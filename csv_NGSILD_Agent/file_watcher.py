"""Background file watcher for the CSV/XLSX NGSI-LD Agent.

Monitors a local folder every N seconds for .csv / .xlsx files.
When a file is found it:
  1. Loads the data and converts each row to an NGSI-LD entity.
  2. Posts the entities to Orion-LD.
  3. Deletes the source file.
  4. Writes a Markdown report (.md) with the JSON-LD payload and result info.
"""

import glob
import logging
import os
import threading
import time
from datetime import datetime, timezone

import csv_ngsild_agent_utils as utils

logger = logging.getLogger("file_watcher")

# ---------------------------------------------------------------------------
# Configuration
# ---------------------------------------------------------------------------

WATCH_FOLDER = os.getenv("WATCH_FOLDER", "watch_folder")
WATCH_INTERVAL = int(os.getenv("WATCH_INTERVAL", "10"))  # seconds
REPORT_FOLDER = os.getenv("REPORT_FOLDER", os.path.join(WATCH_FOLDER, "reports"))
SUPPORTED_EXTENSIONS = ("*.csv", "*.xlsx")


# ---------------------------------------------------------------------------
# Core processing
# ---------------------------------------------------------------------------

def _find_files(folder):
    """Return a list of .csv and .xlsx file paths in *folder*."""
    files = []
    for pattern in SUPPORTED_EXTENSIONS:
        files.extend(glob.glob(os.path.join(folder, pattern)))
    return sorted(files)


def process_file(filepath, log=None):
    """Process a single CSV/XLSX file end-to-end.

    Returns a dict with keys: ``source``, ``entities_json``, ``responses``,
    ``report_path``, ``timestamp``.

    Raises on any error (caller decides how to handle).
    """
    log = log or logger
    config = utils.get_config()
    context = config["CONTEXT_JSON"]
    filename = os.path.basename(filepath)
    ts = datetime.now(timezone.utc)

    log.info(f"[watcher] Processing file: {filepath}")

    # 1. Load & convert -------------------------------------------------
    data = utils.load_file_to_dict(filepath, log)

    entity_list = []
    json_fragments = []
    for row in data:
        entity = utils.generate_ngsild_entity(row, context)
        json_fragments.append(entity.to_json(indent=4))
        entity_list.append(entity)

    entities_json_str = ",\n".join(json_fragments)

    # 2. Post to Orion-LD -----------------------------------------------
    responses = utils.post_ngsi_to_cb_with_token(entity_list, log)
    log.info(f"[watcher] Posted {len(entity_list)} entities from {filename}")

    # 3. Delete source file ---------------------------------------------
    os.remove(filepath)
    log.info(f"[watcher] Deleted source file: {filepath}")

    # 4. Write Markdown report ------------------------------------------
    report_path = _write_report(
        filename=filename,
        entities_json_str=entities_json_str,
        responses=responses,
        tenant=config["ORION_LD_TENANT"],
        ts=ts,
        log=log,
    )

    return {
        "source": filepath,
        "entities_json": entities_json_str,
        "responses": responses,
        "report_path": report_path,
        "timestamp": ts,
    }


def _write_report(filename, entities_json_str, responses, tenant, ts, log=None):
    """Create an .md report and return its path."""
    log = log or logger
    os.makedirs(REPORT_FOLDER, exist_ok=True)

    ts_str = ts.strftime("%Y%m%dT%H%M%SZ")
    base = os.path.splitext(filename)[0]
    report_name = f"{base}_{ts_str}.md"
    report_path = os.path.join(REPORT_FOLDER, report_name)

    lines = [
        f"# NGSI-LD Import Report",
        f"",
        f"- **Source file:** `{filename}`",
        f"- **Processed at:** {ts.isoformat()}",
        f"- **Tenant:** `{tenant}`",
        f"- **Entities posted:** {len(responses)}",
        f"",
        f"## Orion-LD Responses",
        f"",
    ]
    for r in responses:
        lines.append(f"- {r}")
    lines += [
        f"",
        f"## JSON-LD Payload",
        f"",
        f"```json",
        f"[",
        entities_json_str,
        f"]",
        f"```",
        f"",
    ]

    with open(report_path, "w", encoding="utf-8") as f:
        f.write("\n".join(lines))

    log.info(f"[watcher] Report written: {report_path}")
    return report_path


# ---------------------------------------------------------------------------
# Background loop
# ---------------------------------------------------------------------------

def _watch_loop(folder, interval, log):
    """Blocking loop – runs in a daemon thread."""
    log.info(
        f"[watcher] Watching '{folder}' every {interval}s for .csv / .xlsx files"
    )
    while True:
        try:
            files = _find_files(folder)
            for filepath in files:
                try:
                    process_file(filepath, log)
                except Exception as exc:
                    log.error(f"[watcher] Failed to process {filepath}: {exc}")
        except Exception as exc:
            log.error(f"[watcher] Error scanning folder: {exc}")
        time.sleep(interval)


def start_watcher(folder=None, interval=None, log=None):
    """Start the file-watcher daemon thread.

    Parameters are optional and fall back to env-var / module defaults.
    """
    folder = folder or WATCH_FOLDER
    interval = interval if interval is not None else WATCH_INTERVAL
    log = log or logger

    os.makedirs(folder, exist_ok=True)

    t = threading.Thread(
        target=_watch_loop,
        args=(folder, interval, log),
        daemon=True,
        name="file-watcher",
    )
    t.start()
    log.info(f"[watcher] Daemon thread started (folder={folder}, interval={interval}s)")
    return t

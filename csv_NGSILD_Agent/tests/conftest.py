"""Shared fixtures for CSV NGSI-LD Agent tests."""

import os
import sys
import tempfile
import pytest
import openpyxl

# Ensure the parent package is importable
sys.path.insert(0, os.path.join(os.path.dirname(__file__), ".."))


# ---------------------------------------------------------------------------
# Environment helpers
# ---------------------------------------------------------------------------

ENV_DEFAULTS = {
    "NGSI_LD_CONTECT_BROKER_HOSTNAME": "localhost",
    "NGSI_LD_CONTECT_BROKER_PORT": "1026",
    "ORION_LD_TENANT": "test_tenant",
    "CONTEXT_JSON": "http://example.com/context.jsonld",
    "CSV_AGENT_PORT": "5555",
    "PARTNER_USERNAME": "testuser",
    "PARTNER_PASSWORD": "testpass",
    "ORION_PEP_SECRET": "secret123",
}


@pytest.fixture(autouse=True)
def _patch_env(monkeypatch):
    """Set deterministic environment variables for every test."""
    for key, val in ENV_DEFAULTS.items():
        monkeypatch.setenv(key, val)


@pytest.fixture()
def env_no_port(monkeypatch):
    """Remove NGSI_LD_CONTECT_BROKER_PORT so the config defaults to 443."""
    monkeypatch.delenv("NGSI_LD_CONTECT_BROKER_PORT", raising=False)
    monkeypatch.setenv("NGSI_LD_CONTECT_BROKER_PORT", "-1")


# ---------------------------------------------------------------------------
# Temp directory / file helpers
# ---------------------------------------------------------------------------

@pytest.fixture()
def tmp_upload_dir(tmp_path):
    """Return a temporary upload directory path."""
    upload = tmp_path / "uploaded_files"
    upload.mkdir()
    return upload


@pytest.fixture()
def sample_csv(tmp_upload_dir):
    """Write a minimal valid CSV and return its path."""
    csv_path = tmp_upload_dir / "sample.csv"
    csv_path.write_text(
        "id,type,observedAt,color,thickness,thickness_unitCode\n"
        "urn:ngsi-ld:leather:001,leather,2024-06-01T10:00:00Z,black,0.5,MMT\n"
        "urn:ngsi-ld:leather:002,leather,2024-06-01T11:00:00Z,red,0.3,MMT\n",
        encoding="utf-8",
    )
    return str(csv_path)


@pytest.fixture()
def sample_csv_no_observedat(tmp_upload_dir):
    """CSV without an observedAt column."""
    csv_path = tmp_upload_dir / "no_obs.csv"
    csv_path.write_text(
        "id,type,color\n"
        "urn:ngsi-ld:leather:010,leather,green\n",
        encoding="utf-8",
    )
    return str(csv_path)


@pytest.fixture()
def sample_csv_bad_headers(tmp_upload_dir):
    """CSV with wrong first two headers."""
    csv_path = tmp_upload_dir / "bad.csv"
    csv_path.write_text(
        "name,category,value\n"
        "foo,bar,1\n",
        encoding="utf-8",
    )
    return str(csv_path)


@pytest.fixture()
def sample_csv_relationship(tmp_upload_dir):
    """CSV with a _Relationship column."""
    csv_path = tmp_upload_dir / "rel.csv"
    csv_path.write_text(
        "id,type,ownedBy_Relationship\n"
        "urn:ngsi-ld:leather:020,leather,urn:ngsi-ld:Company:001\n",
        encoding="utf-8",
    )
    return str(csv_path)


@pytest.fixture()
def sample_csv_polygon(tmp_upload_dir):
    """CSV with a _Polygon column."""
    csv_path = tmp_upload_dir / "poly.csv"
    csv_path.write_text(
        'id,type,area_Polygon\n'
        'urn:ngsi-ld:leather:030,leather,"[[[0.0,0.0],[1.0,0.0],[1.0,1.0],[0.0,0.0]]]"\n',
        encoding="utf-8",
    )
    return str(csv_path)


# ---------------------------------------------------------------------------
# XLSX file helpers
# ---------------------------------------------------------------------------

def _write_xlsx(path, sheets):
    """Write an xlsx file.  *sheets* is a dict {sheet_name: [row, ...]}.
    Each row is a list/tuple of cell values."""
    wb = openpyxl.Workbook()
    first = True
    for name, rows in sheets.items():
        if first:
            ws = wb.active
            ws.title = name
            first = False
        else:
            ws = wb.create_sheet(name)
        for row in rows:
            ws.append(list(row))
    wb.save(path)


@pytest.fixture()
def sample_xlsx(tmp_upload_dir):
    """Valid single-sheet XLSX with 2 rows."""
    path = tmp_upload_dir / "sample.xlsx"
    _write_xlsx(str(path), {
        "Sheet1": [
            ("id", "type", "observedAt", "color"),
            ("urn:ngsi-ld:leather:001", "leather", "2024-06-01T10:00:00Z", "black"),
            ("urn:ngsi-ld:leather:002", "leather", "2024-06-01T11:00:00Z", "red"),
        ]
    })
    return str(path)


@pytest.fixture()
def sample_xlsx_multi_sheet(tmp_upload_dir):
    """XLSX with 2 sheets – should be rejected."""
    path = tmp_upload_dir / "multi.xlsx"
    _write_xlsx(str(path), {
        "Data": [("id", "type"), ("urn:x:1", "t")],
        "Extra": [("a",), ("b",)],
    })
    return str(path)


@pytest.fixture()
def sample_xlsx_bad_headers(tmp_upload_dir):
    """XLSX whose first two headers are not id/type."""
    path = tmp_upload_dir / "bad.xlsx"
    _write_xlsx(str(path), {
        "Sheet1": [
            ("name", "category", "value"),
            ("foo", "bar", 1),
        ]
    })
    return str(path)


@pytest.fixture()
def sample_xlsx_empty(tmp_upload_dir):
    """XLSX with a single empty sheet."""
    path = tmp_upload_dir / "empty.xlsx"
    _write_xlsx(str(path), {"Sheet1": []})
    return str(path)


# ---------------------------------------------------------------------------
# Flask test client
# ---------------------------------------------------------------------------

@pytest.fixture()
def client():
    """Create a Flask test client with a temporary upload folder."""
    import app as flask_app

    flask_app.UPLOAD_FOLDER = tempfile.mkdtemp()
    flask_app.app.config["TESTING"] = True
    flask_app.entity_ngsild_json_global = None
    with flask_app.app.test_client() as c:
        yield c

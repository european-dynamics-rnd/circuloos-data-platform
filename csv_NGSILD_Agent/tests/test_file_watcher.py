"""Tests for the file_watcher module."""

import logging
import os
import time
from unittest.mock import MagicMock, patch, call

import openpyxl
import pytest

import file_watcher


# ===================================================================
# Helpers
# ===================================================================

def _write_csv(path, content=None):
    """Write a minimal valid CSV file."""
    if content is None:
        content = (
            "id,type,color\n"
            "urn:ngsi-ld:leather:w01,leather,black\n"
        )
    with open(path, "w", encoding="utf-8") as f:
        f.write(content)


def _write_xlsx(path, rows=None):
    """Write a single-sheet XLSX file."""
    if rows is None:
        rows = [
            ("id", "type", "color"),
            ("urn:ngsi-ld:leather:w02", "leather", "red"),
        ]
    wb = openpyxl.Workbook()
    ws = wb.active
    for row in rows:
        ws.append(list(row))
    wb.save(path)


# ===================================================================
# _find_files
# ===================================================================

class TestFindFiles:
    def test_finds_csv_files(self, tmp_path):
        _write_csv(str(tmp_path / "a.csv"))
        _write_csv(str(tmp_path / "b.csv"))
        (tmp_path / "ignore.txt").write_text("nope")
        result = file_watcher._find_files(str(tmp_path))
        assert len(result) == 2
        assert all(f.endswith(".csv") for f in result)

    def test_finds_xlsx_files(self, tmp_path):
        _write_xlsx(str(tmp_path / "data.xlsx"))
        result = file_watcher._find_files(str(tmp_path))
        assert len(result) == 1
        assert result[0].endswith(".xlsx")

    def test_finds_mixed(self, tmp_path):
        _write_csv(str(tmp_path / "a.csv"))
        _write_xlsx(str(tmp_path / "b.xlsx"))
        result = file_watcher._find_files(str(tmp_path))
        assert len(result) == 2

    def test_returns_empty_for_empty_dir(self, tmp_path):
        assert file_watcher._find_files(str(tmp_path)) == []


# ===================================================================
# _write_report
# ===================================================================

class TestWriteReport:
    def test_creates_md_file(self, tmp_path, monkeypatch):
        monkeypatch.setattr(file_watcher, "REPORT_FOLDER", str(tmp_path / "reports"))
        from datetime import datetime, timezone

        ts = datetime(2024, 6, 1, 12, 0, 0, tzinfo=timezone.utc)
        path = file_watcher._write_report(
            filename="test.csv",
            entities_json_str='{"id": "urn:x:1"}',
            responses=["Id: urn:x:1 uploaded OK"],
            tenant="test_tenant",
            ts=ts,
        )
        assert path.endswith(".md")
        assert os.path.isfile(path)

    def test_contains_expected_sections(self, tmp_path, monkeypatch):
        monkeypatch.setattr(file_watcher, "REPORT_FOLDER", str(tmp_path / "reports"))
        from datetime import datetime, timezone

        ts = datetime(2024, 6, 1, 12, 0, 0, tzinfo=timezone.utc)
        path = file_watcher._write_report(
            filename="data.xlsx",
            entities_json_str='{"id": "urn:x:2"}',
            responses=["resp1", "resp2"],
            tenant="my_tenant",
            ts=ts,
        )
        content = open(path, encoding="utf-8").read()
        assert "# NGSI-LD Import Report" in content
        assert "data.xlsx" in content
        assert "my_tenant" in content
        assert "resp1" in content
        assert "resp2" in content
        assert "```json" in content
        assert "urn:x:2" in content

    def test_report_name_includes_timestamp(self, tmp_path, monkeypatch):
        monkeypatch.setattr(file_watcher, "REPORT_FOLDER", str(tmp_path / "reports"))
        from datetime import datetime, timezone

        ts = datetime(2024, 6, 1, 12, 0, 0, tzinfo=timezone.utc)
        path = file_watcher._write_report(
            filename="sample.csv",
            entities_json_str="{}",
            responses=[],
            tenant="test_tenant",
            ts=ts,
        )
        assert "20240601T120000Z" in os.path.basename(path)


# ===================================================================
# process_file
# ===================================================================

class TestProcessFile:
    @patch("file_watcher.utils.post_ngsi_to_cb_with_token")
    def test_csv_end_to_end(self, mock_post, tmp_path, monkeypatch):
        monkeypatch.setattr(file_watcher, "REPORT_FOLDER", str(tmp_path / "reports"))
        mock_post.return_value = ["Id: urn:ngsi-ld:leather:w01 uploaded OK"]

        csv_path = str(tmp_path / "test.csv")
        _write_csv(csv_path)

        logger = logging.getLogger("test")
        result = file_watcher.process_file(csv_path, log=logger)

        # Source file should be deleted
        assert not os.path.exists(csv_path)
        # Report should exist
        assert os.path.isfile(result["report_path"])
        assert result["report_path"].endswith(".md")
        # Entities JSON should contain the entity id
        assert "urn:ngsi-ld:leather:w01" in result["entities_json"]
        # Responses populated
        assert len(result["responses"]) == 1
        # Post was called
        mock_post.assert_called_once()

    @patch("file_watcher.utils.post_ngsi_to_cb_with_token")
    def test_xlsx_end_to_end(self, mock_post, tmp_path, monkeypatch):
        monkeypatch.setattr(file_watcher, "REPORT_FOLDER", str(tmp_path / "reports"))
        mock_post.return_value = ["Id: urn:ngsi-ld:leather:w02 uploaded OK"]

        xlsx_path = str(tmp_path / "test.xlsx")
        _write_xlsx(xlsx_path)

        logger = logging.getLogger("test")
        result = file_watcher.process_file(xlsx_path, log=logger)

        assert not os.path.exists(xlsx_path)
        assert os.path.isfile(result["report_path"])
        assert "urn:ngsi-ld:leather:w02" in result["entities_json"]

    @patch("file_watcher.utils.post_ngsi_to_cb_with_token")
    def test_raises_on_bad_file(self, mock_post, tmp_path, monkeypatch):
        monkeypatch.setattr(file_watcher, "REPORT_FOLDER", str(tmp_path / "reports"))

        bad_csv = str(tmp_path / "bad.csv")
        with open(bad_csv, "w") as f:
            f.write("name,value\nfoo,1\n")

        logger = logging.getLogger("test")
        with pytest.raises(ValueError, match="not 'id' and 'type'"):
            file_watcher.process_file(bad_csv, log=logger)

        # Bad file should NOT be deleted (error before deletion)
        assert os.path.exists(bad_csv)


# ===================================================================
# start_watcher
# ===================================================================

class TestStartWatcher:
    def test_starts_daemon_thread(self, tmp_path):
        logger = logging.getLogger("test")
        t = file_watcher.start_watcher(
            folder=str(tmp_path), interval=9999, log=logger
        )
        assert t.is_alive()
        assert t.daemon is True
        assert t.name == "file-watcher"

    @patch("file_watcher.process_file")
    def test_watcher_processes_new_file(self, mock_process, tmp_path, monkeypatch):
        """Drop a file into the watched folder and verify it gets picked up."""
        logger = logging.getLogger("test")
        monkeypatch.setattr(file_watcher, "REPORT_FOLDER", str(tmp_path / "reports"))

        # Start watcher with a very short interval
        t = file_watcher.start_watcher(
            folder=str(tmp_path), interval=1, log=logger
        )

        # Drop a CSV into the watch folder
        csv_path = str(tmp_path / "auto.csv")
        _write_csv(csv_path)

        # Give the watcher time to detect and process
        time.sleep(3)

        # process_file should have been called with the csv path
        assert mock_process.called
        call_args = mock_process.call_args_list
        processed_paths = [c[0][0] for c in call_args]
        assert any("auto.csv" in p for p in processed_paths)

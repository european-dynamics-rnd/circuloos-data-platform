"""Tests for Flask routes in app.py."""

import io
import json
import os
from unittest.mock import MagicMock, patch

import pytest


# ===================================================================
# GET /  – upload form
# ===================================================================

class TestUploadForm:
    def test_returns_200(self, client):
        resp = client.get("/")
        assert resp.status_code == 200


# ===================================================================
# POST /upload
# ===================================================================

class TestUploadFile:
    def test_no_file_part_returns_400(self, client):
        resp = client.post("/upload", data={})
        assert resp.status_code == 400
        body = resp.get_json()
        assert body["status"] == "error"
        assert "No file part" in body["message"]

    def test_empty_filename_returns_400(self, client):
        data = {"file": (io.BytesIO(b""), "")}
        resp = client.post("/upload", data=data, content_type="multipart/form-data")
        assert resp.status_code == 400
        body = resp.get_json()
        assert "No selected file" in body["message"]

    def test_invalid_extension_returns_400(self, client):
        data = {"file": (io.BytesIO(b"hello"), "test.txt")}
        resp = client.post("/upload", data=data, content_type="multipart/form-data")
        assert resp.status_code == 400
        body = resp.get_json()
        assert "Invalid file type" in body["message"]

    def test_valid_csv_upload_succeeds(self, client):
        csv_content = b"id,type,color\nurn:ngsi-ld:x:1,thing,red\n"
        data = {"file": (io.BytesIO(csv_content), "data.csv")}
        resp = client.post("/upload", data=data, content_type="multipart/form-data")
        assert resp.status_code == 200
        body = resp.get_json()
        assert body["status"] == "success"

    def test_uploaded_file_exists_on_disk(self, client):
        import app as flask_app

        csv_content = b"id,type,color\nurn:ngsi-ld:x:1,thing,red\n"
        data = {"file": (io.BytesIO(csv_content), "check.csv")}
        client.post("/upload", data=data, content_type="multipart/form-data")
        assert os.path.isfile(os.path.join(flask_app.UPLOAD_FOLDER, "check.csv"))


# ===================================================================
# POST /generate-ngsi-ld
# ===================================================================

class TestGenerateNgsiLd:
    def _upload_csv(self, client, content=None):
        """Helper to upload a CSV before generation."""
        if content is None:
            content = (
                b"id,type,observedAt,color\n"
                b"urn:ngsi-ld:leather:001,leather,2024-06-01T10:00:00Z,black\n"
            )
        data = {"file": (io.BytesIO(content), "test.csv")}
        client.post("/upload", data=data, content_type="multipart/form-data")

    def test_success_returns_200(self, client):
        self._upload_csv(client)
        resp = client.post("/generate-ngsi-ld")
        assert resp.status_code == 200
        # The response should contain the entity id in the rendered page
        assert b"urn:ngsi-ld:leather:001" in resp.data

    def test_cleans_csv_after_success(self, client):
        import app as flask_app

        self._upload_csv(client)
        client.post("/generate-ngsi-ld")
        # No CSV files should remain
        import glob

        remaining = glob.glob(os.path.join(flask_app.UPLOAD_FOLDER, "*.csv"))
        assert len(remaining) == 0

    def test_error_when_no_csv_uploaded(self, client):
        resp = client.post("/generate-ngsi-ld")
        assert resp.status_code == 200  # renders the template with error message
        assert b"Please check if you have id and type" in resp.data

    def test_stores_entities_globally(self, client):
        import app as flask_app

        self._upload_csv(client)
        client.post("/generate-ngsi-ld")
        assert flask_app.entity_ngsild_json_global is not None
        assert len(flask_app.entity_ngsild_json_global) == 1


# ===================================================================
# POST /check-connectivity
# ===================================================================

class TestCheckConnectivity:
    @patch("csv_ngsild_agent_utils.requests.get")
    def test_success(self, mock_get, client):
        mock_resp = MagicMock()
        mock_resp.status_code = 200
        mock_resp.json.return_value = {"orionld version": "1.5.1"}
        mock_get.return_value = mock_resp

        resp = client.post("/check-connectivity")
        assert resp.status_code == 200
        body = resp.get_json()
        assert body["error"] == "no errors"
        assert "Successful" in body["responses"]

    @patch("csv_ngsild_agent_utils.requests.get")
    def test_failure_returns_error_message(self, mock_get, client):
        from requests.exceptions import ConnectionError as ReqConnError

        mock_get.side_effect = ReqConnError("Connection refused")

        resp = client.post("/check-connectivity")
        assert resp.status_code == 200
        body = resp.get_json()
        assert "An error occurred" in body["error"]


# ===================================================================
# POST /post-ngsi-ld
# ===================================================================

class TestPostNgsiLd:
    def _prepare_entities(self, client):
        """Upload CSV + generate so entity_ngsild_json_global is set."""
        csv_content = (
            b"id,type,observedAt,color\n"
            b"urn:ngsi-ld:leather:001,leather,2024-06-01T10:00:00Z,black\n"
        )
        data = {"file": (io.BytesIO(csv_content), "test.csv")}
        client.post("/upload", data=data, content_type="multipart/form-data")
        client.post("/generate-ngsi-ld")

    def test_returns_400_when_no_entities(self, client):
        resp = client.post("/post-ngsi-ld")
        assert resp.status_code == 400
        body = resp.get_json()
        assert body["status"] == "error"
        assert "upload your .csv" in body["message"]

    @patch("csv_ngsild_agent_utils.requests.post")
    def test_success(self, mock_post, client):
        mock_resp = MagicMock()
        mock_resp.status_code = 204
        mock_resp.text = ""
        mock_post.return_value = mock_resp

        self._prepare_entities(client)
        resp = client.post("/post-ngsi-ld")
        assert resp.status_code == 200
        body = resp.get_json()
        assert body["status"] == "success"
        assert len(body["responses"]) == 1

    @patch("csv_ngsild_agent_utils.requests.post")
    def test_failure_returns_500(self, mock_post, client):
        from requests.exceptions import HTTPError

        mock_resp = MagicMock()
        mock_resp.raise_for_status.side_effect = HTTPError("500 Server Error")
        mock_post.return_value = mock_resp

        self._prepare_entities(client)
        resp = client.post("/post-ngsi-ld")
        assert resp.status_code == 500
        body = resp.get_json()
        assert body["status"] == "error"
        assert "An error occurred" in body["message"]

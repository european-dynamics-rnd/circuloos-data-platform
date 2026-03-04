"""Tests for csv_ngsild_agent_utils module."""

import logging
import os
from datetime import datetime, timezone
from unittest.mock import MagicMock, patch

import pytest

import csv_ngsild_agent_utils as utils


# ===================================================================
# get_config
# ===================================================================

class TestGetConfig:
    """Tests for get_config()."""

    def test_returns_all_expected_keys(self):
        config = utils.get_config()
        expected_keys = {
            "NGSI_LD_CONTECT_BROKER",
            "ORION_LD_TENANT",
            "CONTEXT_JSON",
            "CSV_AGENT_PORT",
            "PARTNER_USERNAME",
            "PARTNER_PASSWORD",
            "ORION_PEP_SECRET",
        }
        assert expected_keys.issubset(config.keys())

    def test_reads_hostname_from_env(self):
        config = utils.get_config()
        assert config["NGSI_LD_CONTECT_BROKER"]["HOSTNAME"] == "localhost"

    def test_reads_port_from_env(self):
        config = utils.get_config()
        assert config["NGSI_LD_CONTECT_BROKER"]["PORT"] == 1026

    def test_defaults_port_to_443_when_not_set(self, env_no_port):
        config = utils.get_config()
        assert config["NGSI_LD_CONTECT_BROKER"]["PORT"] == 443

    def test_reads_tenant(self):
        config = utils.get_config()
        assert config["ORION_LD_TENANT"] == "test_tenant"

    def test_reads_context_json(self):
        config = utils.get_config()
        assert config["CONTEXT_JSON"] == "http://example.com/context.jsonld"

    def test_reads_csv_agent_port(self):
        config = utils.get_config()
        assert config["CSV_AGENT_PORT"] == "5555"

    def test_reads_credentials(self):
        config = utils.get_config()
        assert config["PARTNER_USERNAME"] == "testuser"
        assert config["PARTNER_PASSWORD"] == "testpass"
        assert config["ORION_PEP_SECRET"] == "secret123"


# ===================================================================
# find_key_observedat
# ===================================================================

class TestFindKeyObservedAt:
    def test_finds_camelCase(self):
        assert utils.find_key_observedat({"observedAt": "v"}) == "observedAt"

    def test_finds_lowercase(self):
        assert utils.find_key_observedat({"observedat": "v"}) == "observedat"

    def test_returns_none_when_missing(self):
        assert utils.find_key_observedat({"foo": "bar"}) is None

    def test_returns_none_for_empty_dict(self):
        assert utils.find_key_observedat({}) is None


# ===================================================================
# return_lastest_csv
# ===================================================================

class TestReturnLastestCsv:
    def test_returns_latest_file(self, tmp_upload_dir):
        logger = logging.getLogger("test")
        # Create two CSVs; touch the second one later
        f1 = tmp_upload_dir / "old.csv"
        f2 = tmp_upload_dir / "new.csv"
        f1.write_text("id,type\n")
        f2.write_text("id,type\n")
        # Force different mtime
        os.utime(str(f1), (1000, 1000))
        os.utime(str(f2), (2000, 2000))

        result = utils.return_lastest_csv(str(tmp_upload_dir), logger)
        assert result == str(f2)

    def test_raises_when_no_csv_files(self, tmp_upload_dir):
        logger = logging.getLogger("test")
        with pytest.raises(ValueError, match="No uploaded csv files found"):
            utils.return_lastest_csv(str(tmp_upload_dir), logger)


# ===================================================================
# load_csv_files_to_dict
# ===================================================================

class TestLoadCsvFilesToDict:
    def test_valid_csv_returns_list_of_dicts(self, sample_csv):
        logger = logging.getLogger("test")
        data = utils.load_csv_files_to_dict(sample_csv, logger)
        assert len(data) == 2
        assert data[0]["id"] == "urn:ngsi-ld:leather:001"
        assert data[0]["type"] == "leather"
        assert data[0]["color"] == "black"

    def test_raises_on_bad_headers(self, sample_csv_bad_headers):
        logger = logging.getLogger("test")
        with pytest.raises(ValueError, match="not 'id' and 'type'"):
            utils.load_csv_files_to_dict(sample_csv_bad_headers, logger)

    def test_handles_utf8_bom(self, tmp_upload_dir):
        """Ensure BOM-encoded files are read correctly."""
        csv_path = tmp_upload_dir / "bom.csv"
        csv_path.write_bytes(
            b"\xef\xbb\xbfid,type,color\nurn:ngsi-ld:x:1,thing,blue\n"
        )
        logger = logging.getLogger("test")
        data = utils.load_csv_files_to_dict(str(csv_path), logger)
        assert data[0]["id"] == "urn:ngsi-ld:x:1"


# ===================================================================
# generate_ngsild_entity
# ===================================================================

class TestGenerateNgsildEntity:
    CONTEXT = "http://example.com/context.jsonld"

    def test_basic_entity(self):
        entity = {
            "id": "urn:ngsi-ld:leather:001",
            "type": "leather",
            "color": "black",
        }
        result = utils.generate_ngsild_entity(entity, self.CONTEXT)
        assert result["id"] == "urn:ngsi-ld:leather:001"
        assert result["type"] == "leather"

    def test_property_with_unitcode(self):
        entity = {
            "id": "urn:ngsi-ld:leather:002",
            "type": "leather",
            "thickness": "0.5",
            "thickness_unitCode": "MMT",
        }
        result = utils.generate_ngsild_entity(entity, self.CONTEXT)
        # The entity should be created without leftover attributes
        assert result["id"] == "urn:ngsi-ld:leather:002"

    def test_observedAt_parsed(self):
        entity = {
            "id": "urn:ngsi-ld:leather:003",
            "type": "leather",
            "observedAt": "2024-06-01T10:00:00Z",
            "color": "red",
        }
        result = utils.generate_ngsild_entity(entity, self.CONTEXT)
        assert result["id"] == "urn:ngsi-ld:leather:003"

    def test_invalid_observedat_falls_back_to_utc_now(self):
        entity = {
            "id": "urn:ngsi-ld:leather:004",
            "type": "leather",
            "observedAt": "not-a-date",
            "color": "blue",
        }
        result = utils.generate_ngsild_entity(entity, self.CONTEXT)
        assert result["id"] == "urn:ngsi-ld:leather:004"

    def test_no_observedat_uses_utc_now(self):
        entity = {
            "id": "urn:ngsi-ld:leather:005",
            "type": "leather",
            "color": "green",
        }
        result = utils.generate_ngsild_entity(entity, self.CONTEXT)
        assert result["id"] == "urn:ngsi-ld:leather:005"

    def test_relationship_attribute(self):
        entity = {
            "id": "urn:ngsi-ld:leather:006",
            "type": "leather",
            "ownedBy_Relationship": "urn:ngsi-ld:Company:001",
        }
        result = utils.generate_ngsild_entity(entity, self.CONTEXT)
        json_str = result.to_json()
        assert "ownedBy" in json_str
        assert "urn:ngsi-ld:Company:001" in json_str

    def test_polygon_attribute(self):
        entity = {
            "id": "urn:ngsi-ld:leather:007",
            "type": "leather",
            "area_Polygon": "[[[0.0,0.0],[1.0,0.0],[1.0,1.0],[0.0,0.0]]]",
        }
        result = utils.generate_ngsild_entity(entity, self.CONTEXT)
        json_str = result.to_json()
        assert "area" in json_str
        assert "Polygon" in json_str

    def test_raises_on_remaining_attributes(self):
        """If entity dict still has keys at the end, it should raise."""
        entity = {
            "id": "urn:ngsi-ld:leather:008",
            "type": "leather",
            "val": "x",
            "val_unitCode": "MMT",
            "leftover_unitCode": "KGM",  # no matching 'leftover' key, will remain
        }
        with pytest.raises(ValueError, match="remaining"):
            utils.generate_ngsild_entity(entity, self.CONTEXT)


# ===================================================================
# get_orion_token
# ===================================================================

class TestGetOrionToken:
    @patch("csv_ngsild_agent_utils.requests.post")
    def test_returns_token(self, mock_post):
        mock_resp = MagicMock()
        mock_resp.status_code = 200
        mock_resp.json.return_value = {"access_token": "abc123"}
        mock_post.return_value = mock_resp

        config = utils.get_config()
        token = utils.get_orion_token(config)
        assert token == "abc123"
        mock_post.assert_called_once()

    @patch("csv_ngsild_agent_utils.requests.post")
    def test_raises_on_http_error(self, mock_post):
        from requests.exceptions import HTTPError

        mock_resp = MagicMock()
        mock_resp.raise_for_status.side_effect = HTTPError("401")
        mock_post.return_value = mock_resp

        config = utils.get_config()
        with pytest.raises(HTTPError):
            utils.get_orion_token(config)


# ===================================================================
# post_ngsi_to_cb_with_token  (local port path, no auth)
# ===================================================================

class TestPostNgsiToCbWithToken:
    @patch("csv_ngsild_agent_utils.requests.post")
    def test_batch_post_success(self, mock_post):
        mock_resp = MagicMock()
        mock_resp.status_code = 204
        mock_resp.text = ""
        mock_post.return_value = mock_resp

        logger = logging.getLogger("test")
        # Build a minimal entity list via the real function
        entity = {
            "id": "urn:ngsi-ld:leather:100",
            "type": "leather",
            "color": "black",
        }
        ctx = "http://example.com/context.jsonld"
        e = utils.generate_ngsild_entity(entity, ctx)

        responses = utils.post_ngsi_to_cb_with_token([e], logger)
        assert len(responses) == 1
        assert "urn:ngsi-ld:leather:100" in responses[0]
        # Verify the batch endpoint was hit (non-443 path)
        call_args = mock_post.call_args
        assert "entityOperations/upsert" in call_args[0][0]

    @patch("csv_ngsild_agent_utils.requests.post")
    def test_raises_on_http_error(self, mock_post):
        from requests.exceptions import HTTPError

        mock_resp = MagicMock()
        mock_resp.raise_for_status.side_effect = HTTPError("500")
        mock_post.return_value = mock_resp

        logger = logging.getLogger("test")
        entity = {
            "id": "urn:ngsi-ld:leather:101",
            "type": "leather",
            "color": "red",
        }
        ctx = "http://example.com/context.jsonld"
        e = utils.generate_ngsild_entity(entity, ctx)

        with pytest.raises(HTTPError):
            utils.post_ngsi_to_cb_with_token([e], logger)

    @patch("csv_ngsild_agent_utils.get_orion_token", return_value="tok123")
    @patch("csv_ngsild_agent_utils.requests.post")
    def test_uses_token_when_port_443(self, mock_post, mock_token, env_no_port):
        mock_resp = MagicMock()
        mock_resp.status_code = 204
        mock_resp.text = ""
        mock_post.return_value = mock_resp

        logger = logging.getLogger("test")
        entity = {
            "id": "urn:ngsi-ld:leather:102",
            "type": "leather",
            "color": "blue",
        }
        ctx = "http://example.com/context.jsonld"
        e = utils.generate_ngsild_entity(entity, ctx)

        responses = utils.post_ngsi_to_cb_with_token([e], logger)
        assert len(responses) == 1
        # Verify token was fetched and Bearer header included
        mock_token.assert_called_once()
        call_kwargs = mock_post.call_args
        headers_sent = call_kwargs[1]["headers"] if "headers" in call_kwargs[1] else call_kwargs[0][1] if len(call_kwargs[0]) > 1 else call_kwargs.kwargs.get("headers", {})
        assert "Bearer" in headers_sent.get("Authorization", "")


# ===================================================================
# get_cb_info_with_token
# ===================================================================

class TestGetCbInfoWithToken:
    @patch("csv_ngsild_agent_utils.requests.get")
    def test_success(self, mock_get):
        mock_resp = MagicMock()
        mock_resp.status_code = 200
        mock_resp.json.return_value = {"orionld version": "1.5.1"}
        mock_get.return_value = mock_resp

        logger = logging.getLogger("test")
        result = utils.get_cb_info_with_token(logger)
        assert "Successful" in result
        assert "localhost" in result

    @patch("csv_ngsild_agent_utils.requests.get")
    def test_raises_on_error(self, mock_get):
        from requests.exceptions import HTTPError

        mock_resp = MagicMock()
        mock_resp.raise_for_status.side_effect = HTTPError("500")
        mock_get.return_value = mock_resp

        logger = logging.getLogger("test")
        with pytest.raises(HTTPError):
            utils.get_cb_info_with_token(logger)

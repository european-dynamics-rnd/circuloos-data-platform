--
-- PostgreSQL database dump
--

-- Dumped from database version 14.1 (Debian 14.1-1.pgdg110+1)
-- Dumped by pg_dump version 14.1 (Debian 14.1-1.pgdg110+1)

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: admin_event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.admin_event_entity (
    id character varying(36) NOT NULL,
    admin_event_time bigint,
    realm_id character varying(255),
    operation_type character varying(255),
    auth_realm_id character varying(255),
    auth_client_id character varying(255),
    auth_user_id character varying(255),
    ip_address character varying(255),
    resource_path character varying(2550),
    representation text,
    error character varying(255),
    resource_type character varying(64)
);


ALTER TABLE public.admin_event_entity OWNER TO keycloak;

--
-- Name: associated_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.associated_policy (
    policy_id character varying(36) NOT NULL,
    associated_policy_id character varying(36) NOT NULL
);


ALTER TABLE public.associated_policy OWNER TO keycloak;

--
-- Name: authentication_execution; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_execution (
    id character varying(36) NOT NULL,
    alias character varying(255),
    authenticator character varying(36),
    realm_id character varying(36),
    flow_id character varying(36),
    requirement integer,
    priority integer,
    authenticator_flow boolean DEFAULT false NOT NULL,
    auth_flow_id character varying(36),
    auth_config character varying(36)
);


ALTER TABLE public.authentication_execution OWNER TO keycloak;

--
-- Name: authentication_flow; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authentication_flow (
    id character varying(36) NOT NULL,
    alias character varying(255),
    description character varying(255),
    realm_id character varying(36),
    provider_id character varying(36) DEFAULT 'basic-flow'::character varying NOT NULL,
    top_level boolean DEFAULT false NOT NULL,
    built_in boolean DEFAULT false NOT NULL
);


ALTER TABLE public.authentication_flow OWNER TO keycloak;

--
-- Name: authenticator_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config (
    id character varying(36) NOT NULL,
    alias character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.authenticator_config OWNER TO keycloak;

--
-- Name: authenticator_config_entry; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.authenticator_config_entry (
    authenticator_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.authenticator_config_entry OWNER TO keycloak;

--
-- Name: broker_link; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.broker_link (
    identity_provider character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL,
    broker_user_id character varying(255),
    broker_username character varying(255),
    token text,
    user_id character varying(255) NOT NULL
);


ALTER TABLE public.broker_link OWNER TO keycloak;

--
-- Name: client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client (
    id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    full_scope_allowed boolean DEFAULT false NOT NULL,
    client_id character varying(255),
    not_before integer,
    public_client boolean DEFAULT false NOT NULL,
    secret character varying(255),
    base_url character varying(255),
    bearer_only boolean DEFAULT false NOT NULL,
    management_url character varying(255),
    surrogate_auth_required boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    protocol character varying(255),
    node_rereg_timeout integer DEFAULT 0,
    frontchannel_logout boolean DEFAULT false NOT NULL,
    consent_required boolean DEFAULT false NOT NULL,
    name character varying(255),
    service_accounts_enabled boolean DEFAULT false NOT NULL,
    client_authenticator_type character varying(255),
    root_url character varying(255),
    description character varying(255),
    registration_token character varying(255),
    standard_flow_enabled boolean DEFAULT true NOT NULL,
    implicit_flow_enabled boolean DEFAULT false NOT NULL,
    direct_access_grants_enabled boolean DEFAULT false NOT NULL,
    always_display_in_console boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client OWNER TO keycloak;

--
-- Name: client_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_attributes (
    client_id character varying(36) NOT NULL,
    value character varying(4000),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_attributes OWNER TO keycloak;

--
-- Name: client_auth_flow_bindings; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_auth_flow_bindings (
    client_id character varying(36) NOT NULL,
    flow_id character varying(36),
    binding_name character varying(255) NOT NULL
);


ALTER TABLE public.client_auth_flow_bindings OWNER TO keycloak;

--
-- Name: client_initial_access; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_initial_access (
    id character varying(36) NOT NULL,
    realm_id character varying(36) NOT NULL,
    "timestamp" integer,
    expiration integer,
    count integer,
    remaining_count integer
);


ALTER TABLE public.client_initial_access OWNER TO keycloak;

--
-- Name: client_node_registrations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_node_registrations (
    client_id character varying(36) NOT NULL,
    value integer,
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_node_registrations OWNER TO keycloak;

--
-- Name: client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope (
    id character varying(36) NOT NULL,
    name character varying(255),
    realm_id character varying(36),
    description character varying(255),
    protocol character varying(255)
);


ALTER TABLE public.client_scope OWNER TO keycloak;

--
-- Name: client_scope_attributes; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_attributes (
    scope_id character varying(36) NOT NULL,
    value character varying(2048),
    name character varying(255) NOT NULL
);


ALTER TABLE public.client_scope_attributes OWNER TO keycloak;

--
-- Name: client_scope_client; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_client (
    client_id character varying(255) NOT NULL,
    scope_id character varying(255) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.client_scope_client OWNER TO keycloak;

--
-- Name: client_scope_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_scope_role_mapping (
    scope_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.client_scope_role_mapping OWNER TO keycloak;

--
-- Name: client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session (
    id character varying(36) NOT NULL,
    client_id character varying(36),
    redirect_uri character varying(255),
    state character varying(255),
    "timestamp" integer,
    session_id character varying(36),
    auth_method character varying(255),
    realm_id character varying(255),
    auth_user_id character varying(36),
    current_action character varying(36)
);


ALTER TABLE public.client_session OWNER TO keycloak;

--
-- Name: client_session_auth_status; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_auth_status (
    authenticator character varying(36) NOT NULL,
    status integer,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_auth_status OWNER TO keycloak;

--
-- Name: client_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_note (
    name character varying(255) NOT NULL,
    value character varying(255),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_note OWNER TO keycloak;

--
-- Name: client_session_prot_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_prot_mapper (
    protocol_mapper_id character varying(36) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_prot_mapper OWNER TO keycloak;

--
-- Name: client_session_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_session_role (
    role_id character varying(255) NOT NULL,
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_session_role OWNER TO keycloak;

--
-- Name: client_user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.client_user_session_note (
    name character varying(255) NOT NULL,
    value character varying(2048),
    client_session character varying(36) NOT NULL
);


ALTER TABLE public.client_user_session_note OWNER TO keycloak;

--
-- Name: component; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_id character varying(36),
    provider_id character varying(36),
    provider_type character varying(255),
    realm_id character varying(36),
    sub_type character varying(255)
);


ALTER TABLE public.component OWNER TO keycloak;

--
-- Name: component_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.component_config (
    id character varying(36) NOT NULL,
    component_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(4000)
);


ALTER TABLE public.component_config OWNER TO keycloak;

--
-- Name: composite_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.composite_role (
    composite character varying(36) NOT NULL,
    child_role character varying(36) NOT NULL
);


ALTER TABLE public.composite_role OWNER TO keycloak;

--
-- Name: credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    user_id character varying(36),
    created_date bigint,
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.credential OWNER TO keycloak;

--
-- Name: databasechangelog; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangelog (
    id character varying(255) NOT NULL,
    author character varying(255) NOT NULL,
    filename character varying(255) NOT NULL,
    dateexecuted timestamp without time zone NOT NULL,
    orderexecuted integer NOT NULL,
    exectype character varying(10) NOT NULL,
    md5sum character varying(35),
    description character varying(255),
    comments character varying(255),
    tag character varying(255),
    liquibase character varying(20),
    contexts character varying(255),
    labels character varying(255),
    deployment_id character varying(10)
);


ALTER TABLE public.databasechangelog OWNER TO keycloak;

--
-- Name: databasechangeloglock; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.databasechangeloglock (
    id integer NOT NULL,
    locked boolean NOT NULL,
    lockgranted timestamp without time zone,
    lockedby character varying(255)
);


ALTER TABLE public.databasechangeloglock OWNER TO keycloak;

--
-- Name: default_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.default_client_scope (
    realm_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL,
    default_scope boolean DEFAULT false NOT NULL
);


ALTER TABLE public.default_client_scope OWNER TO keycloak;

--
-- Name: event_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.event_entity (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    details_json character varying(2550),
    error character varying(255),
    ip_address character varying(255),
    realm_id character varying(255),
    session_id character varying(255),
    event_time bigint,
    type character varying(255),
    user_id character varying(255)
);


ALTER TABLE public.event_entity OWNER TO keycloak;

--
-- Name: fed_user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_attribute (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    value character varying(2024)
);


ALTER TABLE public.fed_user_attribute OWNER TO keycloak;

--
-- Name: fed_user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.fed_user_consent OWNER TO keycloak;

--
-- Name: fed_user_consent_cl_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_consent_cl_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.fed_user_consent_cl_scope OWNER TO keycloak;

--
-- Name: fed_user_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_credential (
    id character varying(36) NOT NULL,
    salt bytea,
    type character varying(255),
    created_date bigint,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36),
    user_label character varying(255),
    secret_data text,
    credential_data text,
    priority integer
);


ALTER TABLE public.fed_user_credential OWNER TO keycloak;

--
-- Name: fed_user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_group_membership OWNER TO keycloak;

--
-- Name: fed_user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_required_action (
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_required_action OWNER TO keycloak;

--
-- Name: fed_user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.fed_user_role_mapping (
    role_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    storage_provider_id character varying(36)
);


ALTER TABLE public.fed_user_role_mapping OWNER TO keycloak;

--
-- Name: federated_identity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_identity (
    identity_provider character varying(255) NOT NULL,
    realm_id character varying(36),
    federated_user_id character varying(255),
    federated_username character varying(255),
    token text,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_identity OWNER TO keycloak;

--
-- Name: federated_user; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.federated_user (
    id character varying(255) NOT NULL,
    storage_provider_id character varying(255),
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.federated_user OWNER TO keycloak;

--
-- Name: group_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_attribute OWNER TO keycloak;

--
-- Name: group_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.group_role_mapping (
    role_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.group_role_mapping OWNER TO keycloak;

--
-- Name: identity_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider (
    internal_id character varying(36) NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    provider_alias character varying(255),
    provider_id character varying(255),
    store_token boolean DEFAULT false NOT NULL,
    authenticate_by_default boolean DEFAULT false NOT NULL,
    realm_id character varying(36),
    add_token_role boolean DEFAULT true NOT NULL,
    trust_email boolean DEFAULT false NOT NULL,
    first_broker_login_flow_id character varying(36),
    post_broker_login_flow_id character varying(36),
    provider_display_name character varying(255),
    link_only boolean DEFAULT false NOT NULL
);


ALTER TABLE public.identity_provider OWNER TO keycloak;

--
-- Name: identity_provider_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_config (
    identity_provider_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.identity_provider_config OWNER TO keycloak;

--
-- Name: identity_provider_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.identity_provider_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    idp_alias character varying(255) NOT NULL,
    idp_mapper_name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.identity_provider_mapper OWNER TO keycloak;

--
-- Name: idp_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.idp_mapper_config (
    idp_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.idp_mapper_config OWNER TO keycloak;

--
-- Name: keycloak_group; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_group (
    id character varying(36) NOT NULL,
    name character varying(255),
    parent_group character varying(36) NOT NULL,
    realm_id character varying(36)
);


ALTER TABLE public.keycloak_group OWNER TO keycloak;

--
-- Name: keycloak_role; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.keycloak_role (
    id character varying(36) NOT NULL,
    client_realm_constraint character varying(255),
    client_role boolean DEFAULT false NOT NULL,
    description character varying(255),
    name character varying(255),
    realm_id character varying(255),
    client character varying(36),
    realm character varying(36)
);


ALTER TABLE public.keycloak_role OWNER TO keycloak;

--
-- Name: migration_model; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.migration_model (
    id character varying(36) NOT NULL,
    version character varying(36),
    update_time bigint DEFAULT 0 NOT NULL
);


ALTER TABLE public.migration_model OWNER TO keycloak;

--
-- Name: offline_client_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_client_session (
    user_session_id character varying(36) NOT NULL,
    client_id character varying(255) NOT NULL,
    offline_flag character varying(4) NOT NULL,
    "timestamp" integer,
    data text,
    client_storage_provider character varying(36) DEFAULT 'local'::character varying NOT NULL,
    external_client_id character varying(255) DEFAULT 'local'::character varying NOT NULL
);


ALTER TABLE public.offline_client_session OWNER TO keycloak;

--
-- Name: offline_user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.offline_user_session (
    user_session_id character varying(36) NOT NULL,
    user_id character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    created_on integer NOT NULL,
    offline_flag character varying(4) NOT NULL,
    data text,
    last_session_refresh integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.offline_user_session OWNER TO keycloak;

--
-- Name: policy_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.policy_config (
    policy_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value text
);


ALTER TABLE public.policy_config OWNER TO keycloak;

--
-- Name: protocol_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    protocol character varying(255) NOT NULL,
    protocol_mapper_name character varying(255) NOT NULL,
    client_id character varying(36),
    client_scope_id character varying(36)
);


ALTER TABLE public.protocol_mapper OWNER TO keycloak;

--
-- Name: protocol_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.protocol_mapper_config (
    protocol_mapper_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.protocol_mapper_config OWNER TO keycloak;

--
-- Name: realm; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm (
    id character varying(36) NOT NULL,
    access_code_lifespan integer,
    user_action_lifespan integer,
    access_token_lifespan integer,
    account_theme character varying(255),
    admin_theme character varying(255),
    email_theme character varying(255),
    enabled boolean DEFAULT false NOT NULL,
    events_enabled boolean DEFAULT false NOT NULL,
    events_expiration bigint,
    login_theme character varying(255),
    name character varying(255),
    not_before integer,
    password_policy character varying(2550),
    registration_allowed boolean DEFAULT false NOT NULL,
    remember_me boolean DEFAULT false NOT NULL,
    reset_password_allowed boolean DEFAULT false NOT NULL,
    social boolean DEFAULT false NOT NULL,
    ssl_required character varying(255),
    sso_idle_timeout integer,
    sso_max_lifespan integer,
    update_profile_on_soc_login boolean DEFAULT false NOT NULL,
    verify_email boolean DEFAULT false NOT NULL,
    master_admin_client character varying(36),
    login_lifespan integer,
    internationalization_enabled boolean DEFAULT false NOT NULL,
    default_locale character varying(255),
    reg_email_as_username boolean DEFAULT false NOT NULL,
    admin_events_enabled boolean DEFAULT false NOT NULL,
    admin_events_details_enabled boolean DEFAULT false NOT NULL,
    edit_username_allowed boolean DEFAULT false NOT NULL,
    otp_policy_counter integer DEFAULT 0,
    otp_policy_window integer DEFAULT 1,
    otp_policy_period integer DEFAULT 30,
    otp_policy_digits integer DEFAULT 6,
    otp_policy_alg character varying(36) DEFAULT 'HmacSHA1'::character varying,
    otp_policy_type character varying(36) DEFAULT 'totp'::character varying,
    browser_flow character varying(36),
    registration_flow character varying(36),
    direct_grant_flow character varying(36),
    reset_credentials_flow character varying(36),
    client_auth_flow character varying(36),
    offline_session_idle_timeout integer DEFAULT 0,
    revoke_refresh_token boolean DEFAULT false NOT NULL,
    access_token_life_implicit integer DEFAULT 0,
    login_with_email_allowed boolean DEFAULT true NOT NULL,
    duplicate_emails_allowed boolean DEFAULT false NOT NULL,
    docker_auth_flow character varying(36),
    refresh_token_max_reuse integer DEFAULT 0,
    allow_user_managed_access boolean DEFAULT false NOT NULL,
    sso_max_lifespan_remember_me integer DEFAULT 0 NOT NULL,
    sso_idle_timeout_remember_me integer DEFAULT 0 NOT NULL,
    default_role character varying(255)
);


ALTER TABLE public.realm OWNER TO keycloak;

--
-- Name: realm_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_attribute (
    name character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL,
    value text
);


ALTER TABLE public.realm_attribute OWNER TO keycloak;

--
-- Name: realm_default_groups; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_default_groups (
    realm_id character varying(36) NOT NULL,
    group_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_default_groups OWNER TO keycloak;

--
-- Name: realm_enabled_event_types; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_enabled_event_types (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_enabled_event_types OWNER TO keycloak;

--
-- Name: realm_events_listeners; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_events_listeners (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_events_listeners OWNER TO keycloak;

--
-- Name: realm_localizations; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_localizations (
    realm_id character varying(255) NOT NULL,
    locale character varying(255) NOT NULL,
    texts text NOT NULL
);


ALTER TABLE public.realm_localizations OWNER TO keycloak;

--
-- Name: realm_required_credential; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_required_credential (
    type character varying(255) NOT NULL,
    form_label character varying(255),
    input boolean DEFAULT false NOT NULL,
    secret boolean DEFAULT false NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.realm_required_credential OWNER TO keycloak;

--
-- Name: realm_smtp_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_smtp_config (
    realm_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.realm_smtp_config OWNER TO keycloak;

--
-- Name: realm_supported_locales; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.realm_supported_locales (
    realm_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.realm_supported_locales OWNER TO keycloak;

--
-- Name: redirect_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.redirect_uris (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.redirect_uris OWNER TO keycloak;

--
-- Name: required_action_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_config (
    required_action_id character varying(36) NOT NULL,
    value text,
    name character varying(255) NOT NULL
);


ALTER TABLE public.required_action_config OWNER TO keycloak;

--
-- Name: required_action_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.required_action_provider (
    id character varying(36) NOT NULL,
    alias character varying(255),
    name character varying(255),
    realm_id character varying(36),
    enabled boolean DEFAULT false NOT NULL,
    default_action boolean DEFAULT false NOT NULL,
    provider_id character varying(255),
    priority integer
);


ALTER TABLE public.required_action_provider OWNER TO keycloak;

--
-- Name: resource_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_attribute (
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255),
    resource_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_attribute OWNER TO keycloak;

--
-- Name: resource_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_policy (
    resource_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_policy OWNER TO keycloak;

--
-- Name: resource_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_scope (
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.resource_scope OWNER TO keycloak;

--
-- Name: resource_server; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server (
    id character varying(36) NOT NULL,
    allow_rs_remote_mgmt boolean DEFAULT false NOT NULL,
    policy_enforce_mode character varying(15) NOT NULL,
    decision_strategy smallint DEFAULT 1 NOT NULL
);


ALTER TABLE public.resource_server OWNER TO keycloak;

--
-- Name: resource_server_perm_ticket; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_perm_ticket (
    id character varying(36) NOT NULL,
    owner character varying(255) NOT NULL,
    requester character varying(255) NOT NULL,
    created_timestamp bigint NOT NULL,
    granted_timestamp bigint,
    resource_id character varying(36) NOT NULL,
    scope_id character varying(36),
    resource_server_id character varying(36) NOT NULL,
    policy_id character varying(36)
);


ALTER TABLE public.resource_server_perm_ticket OWNER TO keycloak;

--
-- Name: resource_server_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_policy (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    description character varying(255),
    type character varying(255) NOT NULL,
    decision_strategy character varying(20),
    logic character varying(20),
    resource_server_id character varying(36) NOT NULL,
    owner character varying(255)
);


ALTER TABLE public.resource_server_policy OWNER TO keycloak;

--
-- Name: resource_server_resource; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_resource (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    type character varying(255),
    icon_uri character varying(255),
    owner character varying(255) NOT NULL,
    resource_server_id character varying(36) NOT NULL,
    owner_managed_access boolean DEFAULT false NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_resource OWNER TO keycloak;

--
-- Name: resource_server_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_server_scope (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    icon_uri character varying(255),
    resource_server_id character varying(36) NOT NULL,
    display_name character varying(255)
);


ALTER TABLE public.resource_server_scope OWNER TO keycloak;

--
-- Name: resource_uris; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.resource_uris (
    resource_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.resource_uris OWNER TO keycloak;

--
-- Name: role_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.role_attribute (
    id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(255)
);


ALTER TABLE public.role_attribute OWNER TO keycloak;

--
-- Name: scope_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_mapping (
    client_id character varying(36) NOT NULL,
    role_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_mapping OWNER TO keycloak;

--
-- Name: scope_policy; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.scope_policy (
    scope_id character varying(36) NOT NULL,
    policy_id character varying(36) NOT NULL
);


ALTER TABLE public.scope_policy OWNER TO keycloak;

--
-- Name: user_attribute; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_attribute (
    name character varying(255) NOT NULL,
    value character varying(255),
    user_id character varying(36) NOT NULL,
    id character varying(36) DEFAULT 'sybase-needs-something-here'::character varying NOT NULL
);


ALTER TABLE public.user_attribute OWNER TO keycloak;

--
-- Name: user_consent; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent (
    id character varying(36) NOT NULL,
    client_id character varying(255),
    user_id character varying(36) NOT NULL,
    created_date bigint,
    last_updated_date bigint,
    client_storage_provider character varying(36),
    external_client_id character varying(255)
);


ALTER TABLE public.user_consent OWNER TO keycloak;

--
-- Name: user_consent_client_scope; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_consent_client_scope (
    user_consent_id character varying(36) NOT NULL,
    scope_id character varying(36) NOT NULL
);


ALTER TABLE public.user_consent_client_scope OWNER TO keycloak;

--
-- Name: user_entity; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_entity (
    id character varying(36) NOT NULL,
    email character varying(255),
    email_constraint character varying(255),
    email_verified boolean DEFAULT false NOT NULL,
    enabled boolean DEFAULT false NOT NULL,
    federation_link character varying(255),
    first_name character varying(255),
    last_name character varying(255),
    realm_id character varying(255),
    username character varying(255),
    created_timestamp bigint,
    service_account_client_link character varying(255),
    not_before integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.user_entity OWNER TO keycloak;

--
-- Name: user_federation_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_config (
    user_federation_provider_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_config OWNER TO keycloak;

--
-- Name: user_federation_mapper; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper (
    id character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    federation_provider_id character varying(36) NOT NULL,
    federation_mapper_type character varying(255) NOT NULL,
    realm_id character varying(36) NOT NULL
);


ALTER TABLE public.user_federation_mapper OWNER TO keycloak;

--
-- Name: user_federation_mapper_config; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_mapper_config (
    user_federation_mapper_id character varying(36) NOT NULL,
    value character varying(255),
    name character varying(255) NOT NULL
);


ALTER TABLE public.user_federation_mapper_config OWNER TO keycloak;

--
-- Name: user_federation_provider; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_federation_provider (
    id character varying(36) NOT NULL,
    changed_sync_period integer,
    display_name character varying(255),
    full_sync_period integer,
    last_sync integer,
    priority integer,
    provider_name character varying(255),
    realm_id character varying(36)
);


ALTER TABLE public.user_federation_provider OWNER TO keycloak;

--
-- Name: user_group_membership; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_group_membership (
    group_id character varying(36) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_group_membership OWNER TO keycloak;

--
-- Name: user_required_action; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_required_action (
    user_id character varying(36) NOT NULL,
    required_action character varying(255) DEFAULT ' '::character varying NOT NULL
);


ALTER TABLE public.user_required_action OWNER TO keycloak;

--
-- Name: user_role_mapping; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_role_mapping (
    role_id character varying(255) NOT NULL,
    user_id character varying(36) NOT NULL
);


ALTER TABLE public.user_role_mapping OWNER TO keycloak;

--
-- Name: user_session; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session (
    id character varying(36) NOT NULL,
    auth_method character varying(255),
    ip_address character varying(255),
    last_session_refresh integer,
    login_username character varying(255),
    realm_id character varying(255),
    remember_me boolean DEFAULT false NOT NULL,
    started integer,
    user_id character varying(255),
    user_session_state integer,
    broker_session_id character varying(255),
    broker_user_id character varying(255)
);


ALTER TABLE public.user_session OWNER TO keycloak;

--
-- Name: user_session_note; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.user_session_note (
    user_session character varying(36) NOT NULL,
    name character varying(255) NOT NULL,
    value character varying(2048)
);


ALTER TABLE public.user_session_note OWNER TO keycloak;

--
-- Name: username_login_failure; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.username_login_failure (
    realm_id character varying(36) NOT NULL,
    username character varying(255) NOT NULL,
    failed_login_not_before integer,
    last_failure bigint,
    last_ip_failure character varying(255),
    num_failures integer
);


ALTER TABLE public.username_login_failure OWNER TO keycloak;

--
-- Name: web_origins; Type: TABLE; Schema: public; Owner: keycloak
--

CREATE TABLE public.web_origins (
    client_id character varying(36) NOT NULL,
    value character varying(255) NOT NULL
);


ALTER TABLE public.web_origins OWNER TO keycloak;

--
-- Data for Name: admin_event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.admin_event_entity (id, admin_event_time, realm_id, operation_type, auth_realm_id, auth_client_id, auth_user_id, ip_address, resource_path, representation, error, resource_type) FROM stdin;
\.


--
-- Data for Name: associated_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.associated_policy (policy_id, associated_policy_id) FROM stdin;
13d580c0-d4d9-4f09-9a39-f28dd749f38e	e9138225-bae6-460a-bcf7-9574919b4759
0a1767dd-be00-4b20-bee5-236ec01322d1	33fce0c5-b2e7-4fa2-979d-450d651b9f9a
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
07cef3b8-b1b2-4026-a434-4891b5dd079c	\N	auth-cookie	master	df76ebe3-8fd5-47f4-b1a8-4ae7bd027f18	2	10	f	\N	\N
214caa2b-db5f-4259-8744-a4ddb8d58cbc	\N	auth-spnego	master	df76ebe3-8fd5-47f4-b1a8-4ae7bd027f18	3	20	f	\N	\N
69420529-f0af-4a9d-a729-4444abeb6f59	\N	identity-provider-redirector	master	df76ebe3-8fd5-47f4-b1a8-4ae7bd027f18	2	25	f	\N	\N
dba09329-71d7-43fb-81ae-3face88b2072	\N	\N	master	df76ebe3-8fd5-47f4-b1a8-4ae7bd027f18	2	30	t	080b2292-b83b-4099-8b15-5408dec704be	\N
5a2cc9ac-41dc-4053-b375-92e73da3ed50	\N	auth-username-password-form	master	080b2292-b83b-4099-8b15-5408dec704be	0	10	f	\N	\N
d94b7ff2-2cfa-4fcd-9ef7-97ef6e24b8c9	\N	\N	master	080b2292-b83b-4099-8b15-5408dec704be	1	20	t	b92b587b-809e-4cd6-92d4-c7a66a8ea6df	\N
8a32212a-ead6-4e9d-b4ad-b760fa88c9be	\N	conditional-user-configured	master	b92b587b-809e-4cd6-92d4-c7a66a8ea6df	0	10	f	\N	\N
c5080dde-54d2-44de-a5ba-64ff2877496f	\N	auth-otp-form	master	b92b587b-809e-4cd6-92d4-c7a66a8ea6df	0	20	f	\N	\N
b91462a4-dd0f-4989-b579-9924792c349e	\N	direct-grant-validate-username	master	9c8af353-4cd5-4ceb-9082-a488fd815699	0	10	f	\N	\N
7c2f04b7-e20c-43c1-af81-5795cc31cf61	\N	direct-grant-validate-password	master	9c8af353-4cd5-4ceb-9082-a488fd815699	0	20	f	\N	\N
4854b879-c467-4380-9a43-cea06ac7c9f4	\N	\N	master	9c8af353-4cd5-4ceb-9082-a488fd815699	1	30	t	8290828c-41aa-4a47-9c7a-0d3843f5b231	\N
b10043fe-ae95-453f-945b-be8e4d089e0a	\N	conditional-user-configured	master	8290828c-41aa-4a47-9c7a-0d3843f5b231	0	10	f	\N	\N
b2cfae76-1242-4371-9ec4-6fe1377face0	\N	direct-grant-validate-otp	master	8290828c-41aa-4a47-9c7a-0d3843f5b231	0	20	f	\N	\N
426aca5d-ea5a-4920-9d2c-2ad8a7c5203d	\N	registration-page-form	master	9335a605-36cd-48db-a374-e8165fa32e47	0	10	t	0c04683b-23b4-457f-9e9d-074526dbc076	\N
c25dfcba-6745-46f6-a322-5ffd2e4b9ace	\N	registration-user-creation	master	0c04683b-23b4-457f-9e9d-074526dbc076	0	20	f	\N	\N
9dd67a06-34a6-4eb3-be1e-65d97c2805ed	\N	registration-profile-action	master	0c04683b-23b4-457f-9e9d-074526dbc076	0	40	f	\N	\N
5aee5c66-4f25-4f36-9b8a-6e1df4c0c1dc	\N	registration-password-action	master	0c04683b-23b4-457f-9e9d-074526dbc076	0	50	f	\N	\N
d82b9fff-b4e9-4462-889b-c45c3dfaba3c	\N	registration-recaptcha-action	master	0c04683b-23b4-457f-9e9d-074526dbc076	3	60	f	\N	\N
53db1ea3-9add-444c-bb14-5bff937ccf80	\N	reset-credentials-choose-user	master	1f110ada-c65d-4c8f-be47-addb33d28965	0	10	f	\N	\N
b024e915-e2df-490c-bc1e-d9e17b8aa792	\N	reset-credential-email	master	1f110ada-c65d-4c8f-be47-addb33d28965	0	20	f	\N	\N
05e793a5-3a75-4bbf-ac64-2a7833b12506	\N	reset-password	master	1f110ada-c65d-4c8f-be47-addb33d28965	0	30	f	\N	\N
2ff2c189-d1ed-4acb-b0a3-e6cf2b986c3d	\N	\N	master	1f110ada-c65d-4c8f-be47-addb33d28965	1	40	t	f87bbb25-d9e2-4e39-8681-83a127c0d545	\N
d29d7dc3-792d-43d7-a412-1d4e3eeab61b	\N	conditional-user-configured	master	f87bbb25-d9e2-4e39-8681-83a127c0d545	0	10	f	\N	\N
6efa7df6-4926-4307-9b0e-a536b632ee75	\N	reset-otp	master	f87bbb25-d9e2-4e39-8681-83a127c0d545	0	20	f	\N	\N
89752d97-d1c2-41fa-a34b-9feca78fcf99	\N	client-secret	master	ae417216-c352-4e77-8cf0-e1eb25027940	2	10	f	\N	\N
2cbd1c6d-0706-49a4-8b7f-abaf341d61aa	\N	client-jwt	master	ae417216-c352-4e77-8cf0-e1eb25027940	2	20	f	\N	\N
4dff68d8-8dd0-4e61-b784-e7752ef2e0ac	\N	client-secret-jwt	master	ae417216-c352-4e77-8cf0-e1eb25027940	2	30	f	\N	\N
0dcbe9a4-3178-426f-baa1-fc37f9ebf4a0	\N	client-x509	master	ae417216-c352-4e77-8cf0-e1eb25027940	2	40	f	\N	\N
329bdb03-9925-4078-851b-495b755f0966	\N	idp-review-profile	master	74c89ad6-6b51-4be8-b4f2-41ef49764ffc	0	10	f	\N	2a81fc41-dee9-479a-ae5a-8dd236a8185e
9f385011-2767-4dd3-a738-70f46a0fc4b0	\N	\N	master	74c89ad6-6b51-4be8-b4f2-41ef49764ffc	0	20	t	4be1e0fe-f8d9-41db-b48f-a56709d16604	\N
d7975812-ec08-49c0-b84b-1370a87bd980	\N	idp-create-user-if-unique	master	4be1e0fe-f8d9-41db-b48f-a56709d16604	2	10	f	\N	a549e2ed-39cf-4dfc-a460-1566a9f65dc8
ec2b62c6-dde4-499b-95b8-f974a585bdbe	\N	\N	master	4be1e0fe-f8d9-41db-b48f-a56709d16604	2	20	t	ee6ff328-e8ec-40a7-84ec-b61135a4fdfa	\N
681a84ef-8b5a-4b6d-8072-571df6f0b469	\N	idp-confirm-link	master	ee6ff328-e8ec-40a7-84ec-b61135a4fdfa	0	10	f	\N	\N
619b147c-4f39-4ab5-8026-4fd9e45c1fe9	\N	\N	master	ee6ff328-e8ec-40a7-84ec-b61135a4fdfa	0	20	t	29b0c7e0-11a1-4a9b-b61d-b6c08980b330	\N
9518af77-92e3-4a2d-8a4c-b70a22e75639	\N	idp-email-verification	master	29b0c7e0-11a1-4a9b-b61d-b6c08980b330	2	10	f	\N	\N
9857b5cf-d76b-48b0-b60c-a182684f83c2	\N	\N	master	29b0c7e0-11a1-4a9b-b61d-b6c08980b330	2	20	t	8cacf927-f9ac-4db4-843d-54c0653fc23c	\N
073e0e2c-cb83-4476-92a1-33c73dfb6679	\N	idp-username-password-form	master	8cacf927-f9ac-4db4-843d-54c0653fc23c	0	10	f	\N	\N
41bc4c8a-e29d-47d7-bd96-3b9b4839830d	\N	\N	master	8cacf927-f9ac-4db4-843d-54c0653fc23c	1	20	t	5bbcebd6-1b40-40d5-b381-a3d656217933	\N
7a68c768-f3d6-42be-8da1-0b9de19dbdcd	\N	conditional-user-configured	master	5bbcebd6-1b40-40d5-b381-a3d656217933	0	10	f	\N	\N
49557b83-4969-4c8f-ab69-1add5e313696	\N	auth-otp-form	master	5bbcebd6-1b40-40d5-b381-a3d656217933	0	20	f	\N	\N
a880a7ef-d420-4498-b492-9ba55ebd289f	\N	http-basic-authenticator	master	c6c09f38-a31e-4ad8-bcba-d631414fe72f	0	10	f	\N	\N
0a306568-a923-4f5b-9a3b-a96a75159a61	\N	docker-http-basic-authenticator	master	6a151a5e-130a-4e22-986d-529a8989d320	0	10	f	\N	\N
5d70cf4d-e161-4202-87e5-8886479852e1	\N	no-cookie-redirect	master	37ffda25-be9c-44de-bf50-5bab83f96b1f	0	10	f	\N	\N
98d23cc8-289b-4e69-98e1-fc3506b27112	\N	\N	master	37ffda25-be9c-44de-bf50-5bab83f96b1f	0	20	t	cba93f85-b9c6-4d44-89c5-5bbb5625f634	\N
7d703cf4-bf36-4701-92cc-be303c080b7b	\N	basic-auth	master	cba93f85-b9c6-4d44-89c5-5bbb5625f634	0	10	f	\N	\N
8e924188-8379-4473-8ceb-7898a7006f6d	\N	basic-auth-otp	master	cba93f85-b9c6-4d44-89c5-5bbb5625f634	3	20	f	\N	\N
1428e0db-da76-4708-9b9e-ad4b16f5dcd2	\N	auth-spnego	master	cba93f85-b9c6-4d44-89c5-5bbb5625f634	3	30	f	\N	\N
f6cff312-58d2-45eb-9d40-8074c7921007	\N	auth-cookie	fiware-server	2be8d746-65bb-4f12-924f-2759810a9d53	2	10	f	\N	\N
d9773ddb-3a3c-4d2b-8702-8093e08a75ca	\N	auth-spnego	fiware-server	2be8d746-65bb-4f12-924f-2759810a9d53	3	20	f	\N	\N
d4194c81-d6bc-4cb2-a149-e0ecaec5efcc	\N	identity-provider-redirector	fiware-server	2be8d746-65bb-4f12-924f-2759810a9d53	2	25	f	\N	\N
496cbf06-146b-4034-adb2-ddf3949bb588	\N	\N	fiware-server	2be8d746-65bb-4f12-924f-2759810a9d53	2	30	t	ec9dd2a7-1a77-4e56-9afe-6072eaa74e2f	\N
b9659f19-da69-48c1-93e0-c0417d81a6d2	\N	auth-username-password-form	fiware-server	ec9dd2a7-1a77-4e56-9afe-6072eaa74e2f	0	10	f	\N	\N
5e9bb406-529e-4d5f-a392-de670c29ced8	\N	\N	fiware-server	ec9dd2a7-1a77-4e56-9afe-6072eaa74e2f	1	20	t	15bcb4c1-6a58-446a-b6d1-8fcb2336a6a8	\N
e48e2ea2-8d21-417f-adf1-fdb36b34917f	\N	conditional-user-configured	fiware-server	15bcb4c1-6a58-446a-b6d1-8fcb2336a6a8	0	10	f	\N	\N
dd2ca95f-7b67-4df2-b934-bc651650a999	\N	auth-otp-form	fiware-server	15bcb4c1-6a58-446a-b6d1-8fcb2336a6a8	0	20	f	\N	\N
ecc02760-e35e-4ee9-9b40-3c107389db71	\N	direct-grant-validate-username	fiware-server	4058b6db-961a-4a54-a855-32456c926ead	0	10	f	\N	\N
096758d1-370f-413f-8f15-dc679ea50b20	\N	direct-grant-validate-password	fiware-server	4058b6db-961a-4a54-a855-32456c926ead	0	20	f	\N	\N
00bf2c66-cfbe-4e63-b7de-13668c53bb64	\N	\N	fiware-server	4058b6db-961a-4a54-a855-32456c926ead	1	30	t	b726847e-a61f-4c9f-ab31-9904accbb777	\N
a69c7a46-181a-4902-87cc-b6d385c25a20	\N	conditional-user-configured	fiware-server	b726847e-a61f-4c9f-ab31-9904accbb777	0	10	f	\N	\N
9148ccb7-ff4d-4385-b690-83ab514f0b78	\N	direct-grant-validate-otp	fiware-server	b726847e-a61f-4c9f-ab31-9904accbb777	0	20	f	\N	\N
c22a84f9-5c68-4c19-8294-1777732557bd	\N	registration-page-form	fiware-server	74c846c3-7027-4926-aa90-9b74b1299579	0	10	t	f5b0ea02-a6b8-412a-9ecc-25ae479095fe	\N
fe6b6b27-13ee-4f11-a8be-3d79f217e80e	\N	registration-user-creation	fiware-server	f5b0ea02-a6b8-412a-9ecc-25ae479095fe	0	20	f	\N	\N
8291c26b-aa46-43df-89b0-413515e44b2a	\N	registration-profile-action	fiware-server	f5b0ea02-a6b8-412a-9ecc-25ae479095fe	0	40	f	\N	\N
f562744e-21b8-4bcb-92ac-c99847b60e3e	\N	registration-password-action	fiware-server	f5b0ea02-a6b8-412a-9ecc-25ae479095fe	0	50	f	\N	\N
dbc43b33-e971-4551-b3bc-e6539e01490e	\N	registration-recaptcha-action	fiware-server	f5b0ea02-a6b8-412a-9ecc-25ae479095fe	3	60	f	\N	\N
ed99358b-e5ba-461d-8f8c-123368ed4218	\N	reset-credentials-choose-user	fiware-server	4edf117c-0396-44d5-af13-d38c5605fe08	0	10	f	\N	\N
289f2812-1d5f-4fb0-b534-da7581c3757f	\N	reset-credential-email	fiware-server	4edf117c-0396-44d5-af13-d38c5605fe08	0	20	f	\N	\N
8d347d5a-7aba-4585-adef-6612b7e375c7	\N	reset-password	fiware-server	4edf117c-0396-44d5-af13-d38c5605fe08	0	30	f	\N	\N
6605cbd5-9030-4d46-91a8-bc508704d011	\N	\N	fiware-server	4edf117c-0396-44d5-af13-d38c5605fe08	1	40	t	3c1f2066-5946-457d-b4f6-1a2d11513b70	\N
1081e0e5-718e-44be-ae09-db0741c9fbd8	\N	conditional-user-configured	fiware-server	3c1f2066-5946-457d-b4f6-1a2d11513b70	0	10	f	\N	\N
2404d140-4b13-4518-b52a-e0b12e8a542d	\N	reset-otp	fiware-server	3c1f2066-5946-457d-b4f6-1a2d11513b70	0	20	f	\N	\N
4b482b0b-88a5-4f41-9450-1004220c4aa4	\N	client-secret	fiware-server	9083924a-fe40-4f8a-97da-f5b23526808e	2	10	f	\N	\N
6b525686-2bfc-414c-b380-6d2b0c5a2f68	\N	client-jwt	fiware-server	9083924a-fe40-4f8a-97da-f5b23526808e	2	20	f	\N	\N
ddd9e892-15fc-4bea-ac48-47dba5632b3f	\N	client-secret-jwt	fiware-server	9083924a-fe40-4f8a-97da-f5b23526808e	2	30	f	\N	\N
dc9c57bb-5f51-4135-be86-5119b2882251	\N	client-x509	fiware-server	9083924a-fe40-4f8a-97da-f5b23526808e	2	40	f	\N	\N
89599298-e50e-40bd-8146-70a0c67c61f7	\N	idp-review-profile	fiware-server	12e4ad57-8777-4c31-a152-a1b24384b652	0	10	f	\N	e6f11dbd-3966-43e4-9e19-e8f06a093529
0441768b-e871-4848-bcef-9b16f03569a4	\N	\N	fiware-server	12e4ad57-8777-4c31-a152-a1b24384b652	0	20	t	5e81672c-b07f-40b5-85df-a7ced43e8fb0	\N
b5a5f81a-aa22-410c-a5e4-6995e604fbcf	\N	idp-create-user-if-unique	fiware-server	5e81672c-b07f-40b5-85df-a7ced43e8fb0	2	10	f	\N	1105a6e8-e26c-4fe9-8b79-b2b8fb1ead04
6353294f-c4d0-4cb3-8f38-22d007212ede	\N	\N	fiware-server	5e81672c-b07f-40b5-85df-a7ced43e8fb0	2	20	t	9bf5029d-eca7-4ece-ae5e-1e1efe5d1134	\N
06839b01-b74f-45d5-af97-2835b83cc7f2	\N	idp-confirm-link	fiware-server	9bf5029d-eca7-4ece-ae5e-1e1efe5d1134	0	10	f	\N	\N
b40ec4bd-2f20-4775-93f9-6f94c0f086cf	\N	\N	fiware-server	9bf5029d-eca7-4ece-ae5e-1e1efe5d1134	0	20	t	a25c6b31-e937-426c-aed2-54119dffd037	\N
92db8517-0acc-412b-b03b-08643e2ccb15	\N	idp-email-verification	fiware-server	a25c6b31-e937-426c-aed2-54119dffd037	2	10	f	\N	\N
2ce63839-ef1f-4ded-8505-3d65c95568ad	\N	\N	fiware-server	a25c6b31-e937-426c-aed2-54119dffd037	2	20	t	957372ed-b0b2-4681-89b7-356e4b1038d7	\N
dbe4e425-9916-4a40-a710-fe1db24c3845	\N	idp-username-password-form	fiware-server	957372ed-b0b2-4681-89b7-356e4b1038d7	0	10	f	\N	\N
8a8ac80b-9bb3-46fc-b43b-3f897f1c3906	\N	\N	fiware-server	957372ed-b0b2-4681-89b7-356e4b1038d7	1	20	t	0bc741a5-7946-4f6e-9abc-45acda49d7f2	\N
ed47e5f8-1fb0-4dc6-9085-b5a4b9e06534	\N	conditional-user-configured	fiware-server	0bc741a5-7946-4f6e-9abc-45acda49d7f2	0	10	f	\N	\N
417b6437-b059-4bda-b967-f4c072ab22cf	\N	auth-otp-form	fiware-server	0bc741a5-7946-4f6e-9abc-45acda49d7f2	0	20	f	\N	\N
5ecafbed-18e1-4c67-9ab4-e29575fbedae	\N	http-basic-authenticator	fiware-server	35a12732-718e-4ed8-9e92-77bd711d0eac	0	10	f	\N	\N
ecb2b954-4812-48bc-bbc7-08c50797a9fb	\N	docker-http-basic-authenticator	fiware-server	af3e5f3e-310c-4411-97b4-51de245cb4c7	0	10	f	\N	\N
1f5428f4-9ea5-43c6-95f2-2d253857612f	\N	no-cookie-redirect	fiware-server	fac42467-fb2c-4b81-9035-f9a9f51da9ce	0	10	f	\N	\N
b3b93656-6515-4f14-85dc-7e50afc343ee	\N	\N	fiware-server	fac42467-fb2c-4b81-9035-f9a9f51da9ce	0	20	t	229de5f2-1bb2-4b8a-8eb6-8fce136ba2dc	\N
49d12aa0-75f1-49c5-9935-7d4f1f0b58ca	\N	basic-auth	fiware-server	229de5f2-1bb2-4b8a-8eb6-8fce136ba2dc	0	10	f	\N	\N
79675a38-f659-49bd-b88b-5bebe473510a	\N	basic-auth-otp	fiware-server	229de5f2-1bb2-4b8a-8eb6-8fce136ba2dc	3	20	f	\N	\N
d1393abf-e8b3-425c-9a0e-49b15d513776	\N	auth-spnego	fiware-server	229de5f2-1bb2-4b8a-8eb6-8fce136ba2dc	3	30	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
df76ebe3-8fd5-47f4-b1a8-4ae7bd027f18	browser	browser based authentication	master	basic-flow	t	t
080b2292-b83b-4099-8b15-5408dec704be	forms	Username, password, otp and other auth forms.	master	basic-flow	f	t
b92b587b-809e-4cd6-92d4-c7a66a8ea6df	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
9c8af353-4cd5-4ceb-9082-a488fd815699	direct grant	OpenID Connect Resource Owner Grant	master	basic-flow	t	t
8290828c-41aa-4a47-9c7a-0d3843f5b231	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
9335a605-36cd-48db-a374-e8165fa32e47	registration	registration flow	master	basic-flow	t	t
0c04683b-23b4-457f-9e9d-074526dbc076	registration form	registration form	master	form-flow	f	t
1f110ada-c65d-4c8f-be47-addb33d28965	reset credentials	Reset credentials for a user if they forgot their password or something	master	basic-flow	t	t
f87bbb25-d9e2-4e39-8681-83a127c0d545	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	master	basic-flow	f	t
ae417216-c352-4e77-8cf0-e1eb25027940	clients	Base authentication for clients	master	client-flow	t	t
74c89ad6-6b51-4be8-b4f2-41ef49764ffc	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	master	basic-flow	t	t
4be1e0fe-f8d9-41db-b48f-a56709d16604	User creation or linking	Flow for the existing/non-existing user alternatives	master	basic-flow	f	t
ee6ff328-e8ec-40a7-84ec-b61135a4fdfa	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	master	basic-flow	f	t
29b0c7e0-11a1-4a9b-b61d-b6c08980b330	Account verification options	Method with which to verity the existing account	master	basic-flow	f	t
8cacf927-f9ac-4db4-843d-54c0653fc23c	Verify Existing Account by Re-authentication	Reauthentication of existing account	master	basic-flow	f	t
5bbcebd6-1b40-40d5-b381-a3d656217933	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	master	basic-flow	f	t
c6c09f38-a31e-4ad8-bcba-d631414fe72f	saml ecp	SAML ECP Profile Authentication Flow	master	basic-flow	t	t
6a151a5e-130a-4e22-986d-529a8989d320	docker auth	Used by Docker clients to authenticate against the IDP	master	basic-flow	t	t
37ffda25-be9c-44de-bf50-5bab83f96b1f	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	master	basic-flow	t	t
cba93f85-b9c6-4d44-89c5-5bbb5625f634	Authentication Options	Authentication options.	master	basic-flow	f	t
2be8d746-65bb-4f12-924f-2759810a9d53	browser	browser based authentication	fiware-server	basic-flow	t	t
ec9dd2a7-1a77-4e56-9afe-6072eaa74e2f	forms	Username, password, otp and other auth forms.	fiware-server	basic-flow	f	t
15bcb4c1-6a58-446a-b6d1-8fcb2336a6a8	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	fiware-server	basic-flow	f	t
4058b6db-961a-4a54-a855-32456c926ead	direct grant	OpenID Connect Resource Owner Grant	fiware-server	basic-flow	t	t
b726847e-a61f-4c9f-ab31-9904accbb777	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	fiware-server	basic-flow	f	t
74c846c3-7027-4926-aa90-9b74b1299579	registration	registration flow	fiware-server	basic-flow	t	t
f5b0ea02-a6b8-412a-9ecc-25ae479095fe	registration form	registration form	fiware-server	form-flow	f	t
4edf117c-0396-44d5-af13-d38c5605fe08	reset credentials	Reset credentials for a user if they forgot their password or something	fiware-server	basic-flow	t	t
3c1f2066-5946-457d-b4f6-1a2d11513b70	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	fiware-server	basic-flow	f	t
9083924a-fe40-4f8a-97da-f5b23526808e	clients	Base authentication for clients	fiware-server	client-flow	t	t
12e4ad57-8777-4c31-a152-a1b24384b652	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	fiware-server	basic-flow	t	t
5e81672c-b07f-40b5-85df-a7ced43e8fb0	User creation or linking	Flow for the existing/non-existing user alternatives	fiware-server	basic-flow	f	t
9bf5029d-eca7-4ece-ae5e-1e1efe5d1134	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	fiware-server	basic-flow	f	t
a25c6b31-e937-426c-aed2-54119dffd037	Account verification options	Method with which to verity the existing account	fiware-server	basic-flow	f	t
957372ed-b0b2-4681-89b7-356e4b1038d7	Verify Existing Account by Re-authentication	Reauthentication of existing account	fiware-server	basic-flow	f	t
0bc741a5-7946-4f6e-9abc-45acda49d7f2	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	fiware-server	basic-flow	f	t
35a12732-718e-4ed8-9e92-77bd711d0eac	saml ecp	SAML ECP Profile Authentication Flow	fiware-server	basic-flow	t	t
af3e5f3e-310c-4411-97b4-51de245cb4c7	docker auth	Used by Docker clients to authenticate against the IDP	fiware-server	basic-flow	t	t
fac42467-fb2c-4b81-9035-f9a9f51da9ce	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	fiware-server	basic-flow	t	t
229de5f2-1bb2-4b8a-8eb6-8fce136ba2dc	Authentication Options	Authentication options.	fiware-server	basic-flow	f	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
2a81fc41-dee9-479a-ae5a-8dd236a8185e	review profile config	master
a549e2ed-39cf-4dfc-a460-1566a9f65dc8	create unique user config	master
e6f11dbd-3966-43e4-9e19-e8f06a093529	review profile config	fiware-server
1105a6e8-e26c-4fe9-8b79-b2b8fb1ead04	create unique user config	fiware-server
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
2a81fc41-dee9-479a-ae5a-8dd236a8185e	missing	update.profile.on.first.login
a549e2ed-39cf-4dfc-a460-1566a9f65dc8	false	require.password.update.after.registration
e6f11dbd-3966-43e4-9e19-e8f06a093529	missing	update.profile.on.first.login
1105a6e8-e26c-4fe9-8b79-b2b8fb1ead04	false	require.password.update.after.registration
\.


--
-- Data for Name: broker_link; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.broker_link (identity_provider, storage_provider_id, realm_id, broker_user_id, broker_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client (id, enabled, full_scope_allowed, client_id, not_before, public_client, secret, base_url, bearer_only, management_url, surrogate_auth_required, realm_id, protocol, node_rereg_timeout, frontchannel_logout, consent_required, name, service_accounts_enabled, client_authenticator_type, root_url, description, registration_token, standard_flow_enabled, implicit_flow_enabled, direct_access_grants_enabled, always_display_in_console) FROM stdin;
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	f	master-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
7accf29a-4352-4ea5-a369-cf6d954350e8	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
68665072-ccfc-4309-b823-0a88de3065c2	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	master	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	t	f	broker	0	f	\N	\N	t	\N	f	master	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
f6abaf9f-3dde-4919-b983-99eb42003057	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	master	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
e33e4d00-628b-4820-bb49-ee3f9061fd8f	t	f	admin-cli	0	t	\N	\N	f	\N	f	master	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	f	fiware-server-realm	0	f	\N	\N	t	\N	f	master	\N	0	f	f	fiware-server Realm	f	client-secret	\N	\N	\N	t	f	f	f
b1528b35-b944-4ba6-8c09-87fa07344b91	t	f	realm-management	0	f	\N	\N	t	\N	f	fiware-server	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
9250b599-4750-4dfb-86b4-5c5444d14c5d	t	f	account	0	t	\N	/realms/fiware-server/account/	f	\N	f	fiware-server	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	t	f	account-console	0	t	\N	/realms/fiware-server/account/	f	\N	f	fiware-server	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	t	f	broker	0	f	\N	\N	t	\N	f	fiware-server	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	t	f	security-admin-console	0	t	\N	/admin/fiware-server/console/	f	\N	f	fiware-server	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
22c1ebec-2690-4d52-814e-aad568216758	t	f	admin-cli	0	t	\N	\N	f	\N	f	fiware-server	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
41d8bab9-aa4f-47dd-bd66-2e88672ea746	t	t	orion-pep	0	f	3qyehZQti4P2xT38RaOguHUaHXWhAUhk	\N	f	\N	f	fiware-server	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
d9289482-a19d-4b09-bc90-57353057cd70	t	t	mintaka-pep	0	f	47qTsRNiiud05sx68hY6lt7IB5TDyXYz	\N	f	\N	f	fiware-server	openid-connect	-1	f	f	\N	t	client-secret	\N	\N	\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, value, name) FROM stdin;
68665072-ccfc-4309-b823-0a88de3065c2	S256	pkce.code.challenge.method
f6abaf9f-3dde-4919-b983-99eb42003057	S256	pkce.code.challenge.method
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	S256	pkce.code.challenge.method
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	S256	pkce.code.challenge.method
41d8bab9-aa4f-47dd-bd66-2e88672ea746	true	backchannel.logout.session.required
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	backchannel.logout.revoke.offline.tokens
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.artifact.binding
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.server.signature
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.server.signature.keyinfo.ext
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.assertion.signature
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.client.signature
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.encrypt
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.authnstatement
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.onetimeuse.condition
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml_force_name_id_format
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.multivalued.roles
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	saml.force.post.binding
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	exclude.session.state.from.auth.response
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	oidc.ciba.grant.enabled
41d8bab9-aa4f-47dd-bd66-2e88672ea746	true	use.refresh.tokens
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	id.token.as.detached.signature
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	tls.client.certificate.bound.access.tokens
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	require.pushed.authorization.requests
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	client_credentials.use_refresh_token
41d8bab9-aa4f-47dd-bd66-2e88672ea746	false	display.on.consent.screen
41d8bab9-aa4f-47dd-bd66-2e88672ea746	true	oauth2.device.authorization.grant.enabled
d9289482-a19d-4b09-bc90-57353057cd70	false	id.token.as.detached.signature
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.assertion.signature
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.force.post.binding
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.multivalued.roles
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.encrypt
d9289482-a19d-4b09-bc90-57353057cd70	true	oauth2.device.authorization.grant.enabled
d9289482-a19d-4b09-bc90-57353057cd70	false	backchannel.logout.revoke.offline.tokens
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.server.signature
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.server.signature.keyinfo.ext
d9289482-a19d-4b09-bc90-57353057cd70	true	use.refresh.tokens
d9289482-a19d-4b09-bc90-57353057cd70	false	exclude.session.state.from.auth.response
d9289482-a19d-4b09-bc90-57353057cd70	false	oidc.ciba.grant.enabled
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.artifact.binding
d9289482-a19d-4b09-bc90-57353057cd70	true	backchannel.logout.session.required
d9289482-a19d-4b09-bc90-57353057cd70	false	client_credentials.use_refresh_token
d9289482-a19d-4b09-bc90-57353057cd70	false	saml_force_name_id_format
d9289482-a19d-4b09-bc90-57353057cd70	false	require.pushed.authorization.requests
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.client.signature
d9289482-a19d-4b09-bc90-57353057cd70	false	tls.client.certificate.bound.access.tokens
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.authnstatement
d9289482-a19d-4b09-bc90-57353057cd70	false	display.on.consent.screen
d9289482-a19d-4b09-bc90-57353057cd70	false	saml.onetimeuse.condition
\.


--
-- Data for Name: client_auth_flow_bindings; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_auth_flow_bindings (client_id, flow_id, binding_name) FROM stdin;
\.


--
-- Data for Name: client_initial_access; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_initial_access (id, realm_id, "timestamp", expiration, count, remaining_count) FROM stdin;
\.


--
-- Data for Name: client_node_registrations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_node_registrations (client_id, value, name) FROM stdin;
\.


--
-- Data for Name: client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope (id, name, realm_id, description, protocol) FROM stdin;
ec01778a-efa1-42df-97f2-476be6cfe1ee	offline_access	master	OpenID Connect built-in scope: offline_access	openid-connect
dee23010-617b-40a0-9743-5fda01dcbadd	role_list	master	SAML role list	saml
318018c7-70c5-4834-b411-9e0559254c2f	profile	master	OpenID Connect built-in scope: profile	openid-connect
37388d3d-ef31-423a-b756-44f44847c887	email	master	OpenID Connect built-in scope: email	openid-connect
19132f67-6d25-40ed-9f7e-34bb7429cc02	address	master	OpenID Connect built-in scope: address	openid-connect
466af8b1-6fc4-41b8-8a39-d3e09a22422d	phone	master	OpenID Connect built-in scope: phone	openid-connect
3f0cbce4-adf7-49c6-9dba-51434b061b37	roles	master	OpenID Connect scope for add user roles to the access token	openid-connect
423ce762-00b9-4cc6-97db-8eaea7df4f31	web-origins	master	OpenID Connect scope for add allowed web origins to the access token	openid-connect
f986ae52-8267-47dc-bce7-822238ae6dcf	microprofile-jwt	master	Microprofile - JWT built-in scope	openid-connect
ae7d096a-993f-4b54-8554-857d9dfa0fce	offline_access	fiware-server	OpenID Connect built-in scope: offline_access	openid-connect
57442969-1294-4c55-a9e8-04ff009d4fcc	role_list	fiware-server	SAML role list	saml
a7b1e404-9ce0-4346-9bf3-15358ddb9043	profile	fiware-server	OpenID Connect built-in scope: profile	openid-connect
6522fd11-9454-4783-99d6-5b73e00d6518	email	fiware-server	OpenID Connect built-in scope: email	openid-connect
250e2dbc-9387-4209-86fe-72f0b7ef3cb2	address	fiware-server	OpenID Connect built-in scope: address	openid-connect
5e57ef27-60af-4619-9acf-9dfadc1066db	phone	fiware-server	OpenID Connect built-in scope: phone	openid-connect
1ff66dcc-a619-4f01-b2f5-1d0a433f2627	roles	fiware-server	OpenID Connect scope for add user roles to the access token	openid-connect
38e6b97e-0029-43fe-aa4c-1c9982cfae0d	web-origins	fiware-server	OpenID Connect scope for add allowed web origins to the access token	openid-connect
2f59b7cc-fb99-4905-90b1-404fc4ad935d	microprofile-jwt	fiware-server	Microprofile - JWT built-in scope	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
ec01778a-efa1-42df-97f2-476be6cfe1ee	true	display.on.consent.screen
ec01778a-efa1-42df-97f2-476be6cfe1ee	${offlineAccessScopeConsentText}	consent.screen.text
dee23010-617b-40a0-9743-5fda01dcbadd	true	display.on.consent.screen
dee23010-617b-40a0-9743-5fda01dcbadd	${samlRoleListScopeConsentText}	consent.screen.text
318018c7-70c5-4834-b411-9e0559254c2f	true	display.on.consent.screen
318018c7-70c5-4834-b411-9e0559254c2f	${profileScopeConsentText}	consent.screen.text
318018c7-70c5-4834-b411-9e0559254c2f	true	include.in.token.scope
37388d3d-ef31-423a-b756-44f44847c887	true	display.on.consent.screen
37388d3d-ef31-423a-b756-44f44847c887	${emailScopeConsentText}	consent.screen.text
37388d3d-ef31-423a-b756-44f44847c887	true	include.in.token.scope
19132f67-6d25-40ed-9f7e-34bb7429cc02	true	display.on.consent.screen
19132f67-6d25-40ed-9f7e-34bb7429cc02	${addressScopeConsentText}	consent.screen.text
19132f67-6d25-40ed-9f7e-34bb7429cc02	true	include.in.token.scope
466af8b1-6fc4-41b8-8a39-d3e09a22422d	true	display.on.consent.screen
466af8b1-6fc4-41b8-8a39-d3e09a22422d	${phoneScopeConsentText}	consent.screen.text
466af8b1-6fc4-41b8-8a39-d3e09a22422d	true	include.in.token.scope
3f0cbce4-adf7-49c6-9dba-51434b061b37	true	display.on.consent.screen
3f0cbce4-adf7-49c6-9dba-51434b061b37	${rolesScopeConsentText}	consent.screen.text
3f0cbce4-adf7-49c6-9dba-51434b061b37	false	include.in.token.scope
423ce762-00b9-4cc6-97db-8eaea7df4f31	false	display.on.consent.screen
423ce762-00b9-4cc6-97db-8eaea7df4f31		consent.screen.text
423ce762-00b9-4cc6-97db-8eaea7df4f31	false	include.in.token.scope
f986ae52-8267-47dc-bce7-822238ae6dcf	false	display.on.consent.screen
f986ae52-8267-47dc-bce7-822238ae6dcf	true	include.in.token.scope
ae7d096a-993f-4b54-8554-857d9dfa0fce	true	display.on.consent.screen
ae7d096a-993f-4b54-8554-857d9dfa0fce	${offlineAccessScopeConsentText}	consent.screen.text
57442969-1294-4c55-a9e8-04ff009d4fcc	true	display.on.consent.screen
57442969-1294-4c55-a9e8-04ff009d4fcc	${samlRoleListScopeConsentText}	consent.screen.text
a7b1e404-9ce0-4346-9bf3-15358ddb9043	true	display.on.consent.screen
a7b1e404-9ce0-4346-9bf3-15358ddb9043	${profileScopeConsentText}	consent.screen.text
a7b1e404-9ce0-4346-9bf3-15358ddb9043	true	include.in.token.scope
6522fd11-9454-4783-99d6-5b73e00d6518	true	display.on.consent.screen
6522fd11-9454-4783-99d6-5b73e00d6518	${emailScopeConsentText}	consent.screen.text
6522fd11-9454-4783-99d6-5b73e00d6518	true	include.in.token.scope
250e2dbc-9387-4209-86fe-72f0b7ef3cb2	true	display.on.consent.screen
250e2dbc-9387-4209-86fe-72f0b7ef3cb2	${addressScopeConsentText}	consent.screen.text
250e2dbc-9387-4209-86fe-72f0b7ef3cb2	true	include.in.token.scope
5e57ef27-60af-4619-9acf-9dfadc1066db	true	display.on.consent.screen
5e57ef27-60af-4619-9acf-9dfadc1066db	${phoneScopeConsentText}	consent.screen.text
5e57ef27-60af-4619-9acf-9dfadc1066db	true	include.in.token.scope
1ff66dcc-a619-4f01-b2f5-1d0a433f2627	true	display.on.consent.screen
1ff66dcc-a619-4f01-b2f5-1d0a433f2627	${rolesScopeConsentText}	consent.screen.text
1ff66dcc-a619-4f01-b2f5-1d0a433f2627	false	include.in.token.scope
38e6b97e-0029-43fe-aa4c-1c9982cfae0d	false	display.on.consent.screen
38e6b97e-0029-43fe-aa4c-1c9982cfae0d		consent.screen.text
38e6b97e-0029-43fe-aa4c-1c9982cfae0d	false	include.in.token.scope
2f59b7cc-fb99-4905-90b1-404fc4ad935d	false	display.on.consent.screen
2f59b7cc-fb99-4905-90b1-404fc4ad935d	true	include.in.token.scope
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
7accf29a-4352-4ea5-a369-cf6d954350e8	318018c7-70c5-4834-b411-9e0559254c2f	t
7accf29a-4352-4ea5-a369-cf6d954350e8	37388d3d-ef31-423a-b756-44f44847c887	t
7accf29a-4352-4ea5-a369-cf6d954350e8	423ce762-00b9-4cc6-97db-8eaea7df4f31	t
7accf29a-4352-4ea5-a369-cf6d954350e8	3f0cbce4-adf7-49c6-9dba-51434b061b37	t
7accf29a-4352-4ea5-a369-cf6d954350e8	19132f67-6d25-40ed-9f7e-34bb7429cc02	f
7accf29a-4352-4ea5-a369-cf6d954350e8	466af8b1-6fc4-41b8-8a39-d3e09a22422d	f
7accf29a-4352-4ea5-a369-cf6d954350e8	ec01778a-efa1-42df-97f2-476be6cfe1ee	f
7accf29a-4352-4ea5-a369-cf6d954350e8	f986ae52-8267-47dc-bce7-822238ae6dcf	f
68665072-ccfc-4309-b823-0a88de3065c2	318018c7-70c5-4834-b411-9e0559254c2f	t
68665072-ccfc-4309-b823-0a88de3065c2	37388d3d-ef31-423a-b756-44f44847c887	t
68665072-ccfc-4309-b823-0a88de3065c2	423ce762-00b9-4cc6-97db-8eaea7df4f31	t
68665072-ccfc-4309-b823-0a88de3065c2	3f0cbce4-adf7-49c6-9dba-51434b061b37	t
68665072-ccfc-4309-b823-0a88de3065c2	19132f67-6d25-40ed-9f7e-34bb7429cc02	f
68665072-ccfc-4309-b823-0a88de3065c2	466af8b1-6fc4-41b8-8a39-d3e09a22422d	f
68665072-ccfc-4309-b823-0a88de3065c2	ec01778a-efa1-42df-97f2-476be6cfe1ee	f
68665072-ccfc-4309-b823-0a88de3065c2	f986ae52-8267-47dc-bce7-822238ae6dcf	f
e33e4d00-628b-4820-bb49-ee3f9061fd8f	318018c7-70c5-4834-b411-9e0559254c2f	t
e33e4d00-628b-4820-bb49-ee3f9061fd8f	37388d3d-ef31-423a-b756-44f44847c887	t
e33e4d00-628b-4820-bb49-ee3f9061fd8f	423ce762-00b9-4cc6-97db-8eaea7df4f31	t
e33e4d00-628b-4820-bb49-ee3f9061fd8f	3f0cbce4-adf7-49c6-9dba-51434b061b37	t
e33e4d00-628b-4820-bb49-ee3f9061fd8f	19132f67-6d25-40ed-9f7e-34bb7429cc02	f
e33e4d00-628b-4820-bb49-ee3f9061fd8f	466af8b1-6fc4-41b8-8a39-d3e09a22422d	f
e33e4d00-628b-4820-bb49-ee3f9061fd8f	ec01778a-efa1-42df-97f2-476be6cfe1ee	f
e33e4d00-628b-4820-bb49-ee3f9061fd8f	f986ae52-8267-47dc-bce7-822238ae6dcf	f
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	318018c7-70c5-4834-b411-9e0559254c2f	t
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	37388d3d-ef31-423a-b756-44f44847c887	t
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	423ce762-00b9-4cc6-97db-8eaea7df4f31	t
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	3f0cbce4-adf7-49c6-9dba-51434b061b37	t
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	19132f67-6d25-40ed-9f7e-34bb7429cc02	f
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	466af8b1-6fc4-41b8-8a39-d3e09a22422d	f
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	ec01778a-efa1-42df-97f2-476be6cfe1ee	f
0a6cdb56-c2ce-47f1-9d02-8af6b881adce	f986ae52-8267-47dc-bce7-822238ae6dcf	f
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	318018c7-70c5-4834-b411-9e0559254c2f	t
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	37388d3d-ef31-423a-b756-44f44847c887	t
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	423ce762-00b9-4cc6-97db-8eaea7df4f31	t
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	3f0cbce4-adf7-49c6-9dba-51434b061b37	t
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	19132f67-6d25-40ed-9f7e-34bb7429cc02	f
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	466af8b1-6fc4-41b8-8a39-d3e09a22422d	f
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	ec01778a-efa1-42df-97f2-476be6cfe1ee	f
0a5ba243-bb6c-4d78-84a1-050e7ddb167d	f986ae52-8267-47dc-bce7-822238ae6dcf	f
f6abaf9f-3dde-4919-b983-99eb42003057	318018c7-70c5-4834-b411-9e0559254c2f	t
f6abaf9f-3dde-4919-b983-99eb42003057	37388d3d-ef31-423a-b756-44f44847c887	t
f6abaf9f-3dde-4919-b983-99eb42003057	423ce762-00b9-4cc6-97db-8eaea7df4f31	t
f6abaf9f-3dde-4919-b983-99eb42003057	3f0cbce4-adf7-49c6-9dba-51434b061b37	t
f6abaf9f-3dde-4919-b983-99eb42003057	19132f67-6d25-40ed-9f7e-34bb7429cc02	f
f6abaf9f-3dde-4919-b983-99eb42003057	466af8b1-6fc4-41b8-8a39-d3e09a22422d	f
f6abaf9f-3dde-4919-b983-99eb42003057	ec01778a-efa1-42df-97f2-476be6cfe1ee	f
f6abaf9f-3dde-4919-b983-99eb42003057	f986ae52-8267-47dc-bce7-822238ae6dcf	f
9250b599-4750-4dfb-86b4-5c5444d14c5d	6522fd11-9454-4783-99d6-5b73e00d6518	t
9250b599-4750-4dfb-86b4-5c5444d14c5d	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
9250b599-4750-4dfb-86b4-5c5444d14c5d	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
9250b599-4750-4dfb-86b4-5c5444d14c5d	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
9250b599-4750-4dfb-86b4-5c5444d14c5d	5e57ef27-60af-4619-9acf-9dfadc1066db	f
9250b599-4750-4dfb-86b4-5c5444d14c5d	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
9250b599-4750-4dfb-86b4-5c5444d14c5d	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
9250b599-4750-4dfb-86b4-5c5444d14c5d	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	6522fd11-9454-4783-99d6-5b73e00d6518	t
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	5e57ef27-60af-4619-9acf-9dfadc1066db	f
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
22c1ebec-2690-4d52-814e-aad568216758	6522fd11-9454-4783-99d6-5b73e00d6518	t
22c1ebec-2690-4d52-814e-aad568216758	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
22c1ebec-2690-4d52-814e-aad568216758	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
22c1ebec-2690-4d52-814e-aad568216758	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
22c1ebec-2690-4d52-814e-aad568216758	5e57ef27-60af-4619-9acf-9dfadc1066db	f
22c1ebec-2690-4d52-814e-aad568216758	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
22c1ebec-2690-4d52-814e-aad568216758	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
22c1ebec-2690-4d52-814e-aad568216758	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	6522fd11-9454-4783-99d6-5b73e00d6518	t
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	5e57ef27-60af-4619-9acf-9dfadc1066db	f
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
b1528b35-b944-4ba6-8c09-87fa07344b91	6522fd11-9454-4783-99d6-5b73e00d6518	t
b1528b35-b944-4ba6-8c09-87fa07344b91	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
b1528b35-b944-4ba6-8c09-87fa07344b91	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
b1528b35-b944-4ba6-8c09-87fa07344b91	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
b1528b35-b944-4ba6-8c09-87fa07344b91	5e57ef27-60af-4619-9acf-9dfadc1066db	f
b1528b35-b944-4ba6-8c09-87fa07344b91	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
b1528b35-b944-4ba6-8c09-87fa07344b91	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
b1528b35-b944-4ba6-8c09-87fa07344b91	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	6522fd11-9454-4783-99d6-5b73e00d6518	t
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	5e57ef27-60af-4619-9acf-9dfadc1066db	f
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
41d8bab9-aa4f-47dd-bd66-2e88672ea746	6522fd11-9454-4783-99d6-5b73e00d6518	t
41d8bab9-aa4f-47dd-bd66-2e88672ea746	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
41d8bab9-aa4f-47dd-bd66-2e88672ea746	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
41d8bab9-aa4f-47dd-bd66-2e88672ea746	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
41d8bab9-aa4f-47dd-bd66-2e88672ea746	5e57ef27-60af-4619-9acf-9dfadc1066db	f
41d8bab9-aa4f-47dd-bd66-2e88672ea746	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
41d8bab9-aa4f-47dd-bd66-2e88672ea746	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
41d8bab9-aa4f-47dd-bd66-2e88672ea746	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
d9289482-a19d-4b09-bc90-57353057cd70	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
d9289482-a19d-4b09-bc90-57353057cd70	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
d9289482-a19d-4b09-bc90-57353057cd70	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
d9289482-a19d-4b09-bc90-57353057cd70	6522fd11-9454-4783-99d6-5b73e00d6518	t
d9289482-a19d-4b09-bc90-57353057cd70	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
d9289482-a19d-4b09-bc90-57353057cd70	5e57ef27-60af-4619-9acf-9dfadc1066db	f
d9289482-a19d-4b09-bc90-57353057cd70	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
d9289482-a19d-4b09-bc90-57353057cd70	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
ec01778a-efa1-42df-97f2-476be6cfe1ee	04a5152d-4371-4552-995f-08944adfdd4b
ae7d096a-993f-4b54-8554-857d9dfa0fce	5e374f11-6256-42a8-ac67-32915eae0160
\.


--
-- Data for Name: client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session (id, client_id, redirect_uri, state, "timestamp", session_id, auth_method, realm_id, auth_user_id, current_action) FROM stdin;
\.


--
-- Data for Name: client_session_auth_status; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_auth_status (authenticator, status, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_prot_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_prot_mapper (protocol_mapper_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_session_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_session_role (role_id, client_session) FROM stdin;
\.


--
-- Data for Name: client_user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_user_session_note (name, value, client_session) FROM stdin;
\.


--
-- Data for Name: component; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component (id, name, parent_id, provider_id, provider_type, realm_id, sub_type) FROM stdin;
d5f4b705-bf1b-45df-9d13-b1f5e66f3fdf	Trusted Hosts	master	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
49768f4c-7b99-4692-97e7-5acc29f66e56	Consent Required	master	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
8bc11ed0-b01a-4448-862f-0823ebd9bba2	Full Scope Disabled	master	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
d1f4e155-3f06-4ca4-a24a-eb43b549dce4	Max Clients Limit	master	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
ba799d64-f257-4bb5-bfe5-da0cc0842a07	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
dc3a42db-a9cc-4527-9f4f-ce9b890a214c	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	anonymous
b28cef1b-68ac-4db2-8af1-73eae4df0001	Allowed Protocol Mapper Types	master	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
8ca43129-7220-41f8-8f8e-287989604681	Allowed Client Scopes	master	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	master	authenticated
ee65bf3c-1a0b-427a-818a-8b72bf42632e	rsa-generated	master	rsa-generated	org.keycloak.keys.KeyProvider	master	\N
ac4f8706-c4de-4bbf-a3e0-ecc9e1811e89	rsa-enc-generated	master	rsa-enc-generated	org.keycloak.keys.KeyProvider	master	\N
e74fe577-c1f4-44b0-ac15-dcaed810f777	hmac-generated	master	hmac-generated	org.keycloak.keys.KeyProvider	master	\N
049cd4d7-5dee-4663-ad47-a29dde0df7bd	aes-generated	master	aes-generated	org.keycloak.keys.KeyProvider	master	\N
7d24e150-a39b-4815-bc42-a7e5838e3e51	rsa-generated	fiware-server	rsa-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
4f303497-631a-4058-92b4-0e4de70e5321	rsa-enc-generated	fiware-server	rsa-enc-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
adf6bd67-6337-406f-b418-2e212220da64	hmac-generated	fiware-server	hmac-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
c99bf748-e1cb-464d-bc71-dc3df64c4470	aes-generated	fiware-server	aes-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
df33adeb-9b74-47d2-b179-fc5a5d276bf8	Trusted Hosts	fiware-server	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
3abd90f0-e36c-47ee-809c-bd932f25af3d	Consent Required	fiware-server	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
ce54fc0b-30b5-4080-97c2-474106485ee5	Full Scope Disabled	fiware-server	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
f1b0c216-53b2-4a08-bdf4-2b2c5944ac76	Max Clients Limit	fiware-server	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	Allowed Protocol Mapper Types	fiware-server	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
c58339d4-5209-4808-bdc8-df3d09f07130	Allowed Client Scopes	fiware-server	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	Allowed Protocol Mapper Types	fiware-server	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	authenticated
d3377b7d-7d0b-4134-9531-4551648b3fa1	Allowed Client Scopes	fiware-server	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	authenticated
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
a22181c9-682d-4c27-bbee-6351103fe4ce	d5f4b705-bf1b-45df-9d13-b1f5e66f3fdf	host-sending-registration-request-must-match	true
4b5f5209-9a22-41e8-8189-21b2e03e8a63	d5f4b705-bf1b-45df-9d13-b1f5e66f3fdf	client-uris-must-match	true
92490bcb-31c5-493f-a1ac-6e12f5970ea4	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	oidc-address-mapper
2a785df4-d1f5-48fd-a090-aaaa655dccc0	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	oidc-full-name-mapper
18d00df9-79bc-40ad-9601-71b856abad5a	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	saml-user-attribute-mapper
ec9c7ddf-879f-46c8-8d34-055c4ecd0035	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
4b4db325-6cab-41df-b0f0-2691fca75b63	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
601b1ffa-f2ab-45de-8ff0-f3cd238da129	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	saml-user-property-mapper
2c094c2d-41bb-43ea-9b37-7c8fb26cc338	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
5ab7d8fb-2a02-4b49-9e61-d85e9552984c	ba799d64-f257-4bb5-bfe5-da0cc0842a07	allowed-protocol-mapper-types	saml-role-list-mapper
e3fdd16d-b9ad-426a-a3a9-7872ba7a9983	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	oidc-full-name-mapper
cefd682d-b405-43c9-958d-059fba92af31	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6595dec5-084d-4447-ab66-612640647854	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	saml-user-attribute-mapper
c269558b-7832-4ea2-9ba0-49e14901d48c	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
2e941d7b-a896-41c0-b4c8-29b69b1835bc	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	oidc-address-mapper
ac9daf49-9fd0-4b27-87ab-a935bce2f571	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	saml-user-property-mapper
08dda6fe-7f03-4240-a08f-bcd87fb91b9a	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	saml-role-list-mapper
ad1c4590-a34d-44ae-810d-20c1fddd9a3d	b28cef1b-68ac-4db2-8af1-73eae4df0001	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
6676bb7f-3b19-497d-b02c-d9d90708ab91	dc3a42db-a9cc-4527-9f4f-ce9b890a214c	allow-default-scopes	true
4a8cfce6-7fbc-463b-b300-8387cbd144db	d1f4e155-3f06-4ca4-a24a-eb43b549dce4	max-clients	200
b02f2f0a-44e2-4fe1-b870-3ac561dd0031	8ca43129-7220-41f8-8f8e-287989604681	allow-default-scopes	true
d628496a-e2e6-4d2d-b48d-719ebd6464d1	ee65bf3c-1a0b-427a-818a-8b72bf42632e	privateKey	MIIEpAIBAAKCAQEApTT3zWixZjxqpER8xiTXmf8tzIugus9mtN9CCQMeN+ZKbxC6BO4tyqmshd9OI2rJJksAc1ODyQxclPQ0ryal7rIb+Y33CbRfx9Eq4QEJ6AcNFJkjGR3OvX60hse+OFDG7//Pe6LdbQ0eF4xdnyLjQJgtu0IlEZVTKXrHjE461dbtzO6wvisb7cX/NExpR/IXiemmUt+ImYdCk9xYy9OCJxw9bZUwrRWhpMqHolxGdhnr0Fbs9b0avOlfSLtKPgYBAYs/Fm4uMBPqL63lDfjkd9APDmhWl2Ors/xQrGfXS8sjKTe/QhmyxWl8I5IUdbt7DUset5DJ5LfehfXqQpxhzwIDAQABAoIBAGbnpWsnSUj7XRnRJz9s93cPAgIk/wsd4UXMwx9F9+6t3bNs4dHsYk2YfsQsoklhXMYjdbZgUPhMYObPbnmjQzx5aP97NGOxHPAkE+dvdDI5IiawdLJSZNKYN+60QIJnnmMkHqNOgUpKH3Jflnlni9JSeDnqK5jWQKTXu7BjkjZb0+cNsWt3PzXOARD9+0risrRkmmLSn2TjK5u9UP4la8qlppQcGgqbsiH1puxEhtlbyUiEvkQt8JGNlMy4ylQUK6rL1aeZczVSccICdOC7k5P39MhWf8S84eIiuALW4JMaWjq9SKo6x6Sk1A7S8gw13YiSK31Xe6o+zliE/82NdvECgYEA9vaeTDrWsOS30x5ZjPctg4ZayjkGTfSjYcoOZJ8A+DPjA1xb5Qs2Mv1HxjneeP8QM/T9R91AesVwdy7GwzOTigOGtjGUKzp8ZMRbTpAk6wJIqIk3wgEKj+NtusBy4fI2jBydD1sY4ldiPoFUTZEaZQqtAgzHi6NtE7VapqIGPhMCgYEAq0CDCQj50jbDpzgoSfEiG71GjHx/5to0KG++zFTq29NVA0WLvBgip3KlgSrP4nlXfRtkCZp/oVyv9wZXd37ZQ0MNrNssspVuvVE1UjqmGv/8XWZ0BPu15HJflsCUhlA+QNoct2fab4gtCeljIoUB85EDAGMtH5dHZvHyq0xR1NUCgYEAh9E1WWL6cyo11ktYoGfHhg+7mn8l8nVZ7Qu8QqYXWGjgrhZ7C0nRMtWMRX3J1e0gMhLHwF/zeBFhOoplETEqMLqjuUsm22c8xgYe2OP5Ca2l29oq6ey8rEk9LXltNMmKKiAKWEmXM9Mu2oUxob7tLyhh4UC59ReZgz83bXCp0jUCgYAk9DDSfEtcX1Ds/qNDAXO4xKk6m4sGB8QFjceAVDqx4PKRWCqFFjg0Jfss2k4tsr18U7LMl7g+279k8MtjD85WQ1vqFwmYJ8LTu3hkHB/H58FPblJO2PoxJ7UU1M24BgzI9cgIk7KBKsN9Rg2MX2NCaeJZ7QzJql1QC5mv+TIXWQKBgQC8Y8FQhOsXSQvMPyJQBPt7AhJZVtw9ga/fc6vygKL7B8waJst6/HFnYrgz5fDn1cjnxFEjjnPfO6Ay3wQwmp9HkKuzSjwyvinw/pzpOLWFF1Jm0090jIZ2ZkHpvVbr2VpoFZXtFOg+DZUkK64J69fw+xOj85TRbnWH/4hSpVQ68Q==
97d863e2-e612-4a20-a361-f9d5badef590	ee65bf3c-1a0b-427a-818a-8b72bf42632e	priority	100
1d8ee4d1-bf0a-40ef-a70c-1154d6d1c127	ee65bf3c-1a0b-427a-818a-8b72bf42632e	keyUse	SIG
7119c928-065b-4685-9aaa-b67b74f1a7d4	ee65bf3c-1a0b-427a-818a-8b72bf42632e	certificate	MIICmzCCAYMCBgGN+nbV6zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMzAxMTQ0MDA4WhcNMzQwMzAxMTQ0MTQ4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQClNPfNaLFmPGqkRHzGJNeZ/y3Mi6C6z2a030IJAx435kpvELoE7i3KqayF304jaskmSwBzU4PJDFyU9DSvJqXushv5jfcJtF/H0SrhAQnoBw0UmSMZHc69frSGx744UMbv/897ot1tDR4XjF2fIuNAmC27QiURlVMpeseMTjrV1u3M7rC+Kxvtxf80TGlH8heJ6aZS34iZh0KT3FjL04InHD1tlTCtFaGkyoeiXEZ2GevQVuz1vRq86V9Iu0o+BgEBiz8Wbi4wE+ovreUN+OR30A8OaFaXY6uz/FCsZ9dLyyMpN79CGbLFaXwjkhR1u3sNSx63kMnkt96F9epCnGHPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAEi6rx2+vTVH4OnbNuh4LukuhoG4bDef9MiPpAvbadxZMclbQUMLty7B8swk1e+OLb+TvdtR8A8UHgQ+0zR7hMOkPoYpGERj6C3vxc6ZkCCteeB8FT8lmGYh6baWzZMl6BGJxXaZv9/plhgdtMueQcaIyWYKhMFTwHws+VXio7tbwvNI6XEYmY7QgD6u76nakHO+s04SYGBxfwKNd9zrxZgItjwBGFLZfSa53fIdClmB179d9tETM+5Qyf2XgYlfbLNr/utwCQeaUjbOtjWGxkslhgx6szVstq7ACYahvBn759p4PVx4VRiJj1DxG7aHV+fHTHOQ73Fxsj0qI2trf/o=
b4e60258-03a5-4c03-849f-dbe26171fd96	e74fe577-c1f4-44b0-ac15-dcaed810f777	secret	G1AA05hel8MFFHIHf3lVEptCi98gvyw8ZYFhXT0LENEM_xNTQa1sdbaj2ygHVS7lkcEVXL45gBoxY-eghx_vZQ
126a13d7-701e-4d5e-8300-51b1c9863a50	e74fe577-c1f4-44b0-ac15-dcaed810f777	kid	dd4bb5a3-874d-4805-91f6-472b8625100d
d773b9e9-6cfa-4b53-9c75-ebea05cce0ff	e74fe577-c1f4-44b0-ac15-dcaed810f777	algorithm	HS256
9301bcee-0e91-46c7-989d-f8782ad8c7e0	e74fe577-c1f4-44b0-ac15-dcaed810f777	priority	100
33ca6e38-0d17-449d-9916-cfa45610b36a	ac4f8706-c4de-4bbf-a3e0-ecc9e1811e89	algorithm	RSA-OAEP
71091a0f-cc45-47a1-ae8c-8ddc5117abca	ac4f8706-c4de-4bbf-a3e0-ecc9e1811e89	priority	100
67c06b19-680c-400d-8429-be445be7c526	ac4f8706-c4de-4bbf-a3e0-ecc9e1811e89	certificate	MIICmzCCAYMCBgGN+nbXEzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjQwMzAxMTQ0MDA4WhcNMzQwMzAxMTQ0MTQ4WjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDe2QqjMX3jLVmYk2UL3CjY/hACdE+uyP0v7atqefsNxE0bznO4cAcRLWI0TvTzdHH+GPhOQOVl+JG6BUM1qEWWIKdKrUc6JrZX0+P6tyZw8MsegL3JOREdNVuV21x5pz4qiA20b5zOuoAkfqAC/2A5VfagYmz0UX0M0gvN/8/fs/28LKMzSIsO0lwp4NZMjUud26I4kIiBCS0HDkKZ5dUP3A3G+/WEp1sSmXyK6IUhcfH49hTgm/ZJgX5jkNK8MyNvssre1fbtxt7OHushBacJFmzvnWL5MWtDg2qipQiYbT5n2bygznb0ChEJXhMIKoAZxfF/OHldzzE46Z/glP0lAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAJoo6Mlycdwsfw5XKKi3T4FIGw60v9eRysMp+WJhj3YaB4MRx2SGqSjun69fj2eF+FcvDHrVPd2Lt+v+GxcVIE0w9mBBUu271N26lCzW5jKYOazeFfrjwfec3/ZPMfPTVpOYrnJUpeHNYUMCManRbY6dsdjkAy3GXd2TJc3d9wma0A4GWzmAnhHJh7nQSSNCSf7bKKMa5dUI+IS5+NxSDVexfld5WPwddfffcCQ2fVEKN/vGgv3uzEFEEFn0jdIjsRb6aCkbma5BgY32Qfm0DKgOO/BKgjvadnK9Dr6JmfsrLP98Zs/bjMaJXNJ0dPfEUnnDkMHFSGVvRZGpLiVEBBo=
080fd31f-367a-4cc0-93c3-4d409bbce48d	ac4f8706-c4de-4bbf-a3e0-ecc9e1811e89	privateKey	MIIEowIBAAKCAQEA3tkKozF94y1ZmJNlC9wo2P4QAnRPrsj9L+2rann7DcRNG85zuHAHES1iNE7083Rx/hj4TkDlZfiRugVDNahFliCnSq1HOia2V9Pj+rcmcPDLHoC9yTkRHTVbldtceac+KogNtG+czrqAJH6gAv9gOVX2oGJs9FF9DNILzf/P37P9vCyjM0iLDtJcKeDWTI1LnduiOJCIgQktBw5CmeXVD9wNxvv1hKdbEpl8iuiFIXHx+PYU4Jv2SYF+Y5DSvDMjb7LK3tX27cbezh7rIQWnCRZs751i+TFrQ4NqoqUImG0+Z9m8oM529AoRCV4TCCqAGcXxfzh5Xc8xOOmf4JT9JQIDAQABAoIBAB2WGUhzYLBRrAyKvSam8zFkAcIhqRaejqbXWiPH0CISxt4DOe/px7ZrHReux+yusBe5PvY8vXgdWVOmMTclgR+edDeA6+z3iMv+UM1PlaX3AjCpjQjzL6d+Fwu9VPi90I4bBB7JlrsHnc26lgnv19mk5RqEFs0VKJIULQcLiJC9eGVYnrawlEGQJO/gfRY+rD7WKUzwKbt63G+G6Zz0TWH4V+djo76FlrZhldfjy3pwo/5lkROivBnjEW+gWPbqR7QBThYAKKOfDQNKpyGxqymub4LiIE7YfjekOIGfj89BuzvlbIE+G31lP7B0e5jYeB8OIBn8fHGO46ZlIRu2Lb0CgYEA9nw8IlTOdBkGnqqj2hKpUDOWSK5jfghFKSw4ilthKoSMdhxXb9uZ/OeukN3D9e3Tzs54VH7CvAQIJ5LEAdVojKI6j1NUKDuQ/UiBUtEXz3f4RRqxtu7gGQ4FlHDSbhKMYF/66AN85Fm+/9CrDXyBgTCvzqBIHlOxq6V30xgzHbcCgYEA53M4rG8MK8li7LfzfYsSmfRsmDSaeH2h29Rhllql5yy6QCTu/CrDe4gWi/PxS6vkFwN9nrAs2jhRQcm3O31G93l/0h4FXQQwY8rEVMdbxDnz11p6L6UzTxYV4n9gdpqp7BNxfKcgpuOXRHuwG3wQiEuc+OHsMcnoLHpiMQchfAMCgYA8HbDM7sIrrq7eo9+yoDqLRQmyUFYTtxCnKhHgLMlWBV38sIziyzyTYi5BRtU0dfziw5i1gvUbxh/3BuSnTdVh928w5bHw3hZOsBBakoSsJSZ4NDqD0170vWa+/YVVM1DpcH9RdwhO6VScL9iIQYWUbLt0OcNdIiyDIKhI4+4ToQKBgQCSYKSvKWwhJTSTUaOE+rfA9nzXpi0rlwkO5rrxRFM4aWlBuBoNEV6geekIijdJDGUsyOBhxDoZqRR67wAbd5eyW/0i/imWMlgIROz2UT8QUzaMNISiLXDNy8H7hWOUnyxoScO0el6ELdw1S6SNPWGXUXrtTLT8qB1WQ/Bl4YSj0QKBgDRT9oVj0efRFRIvo80ILiXlE+eSVSayyqf4giLNHFPhpfqiOy3HmbYIzO6OXxzcFuO3ke3PaE2IhU3NZPmgSti3nuinzcAcJg23RN00JqVVUCEV+/ai8UIO1dWm0TIuBSDzEtL7muV/5R/M4sFrbYq5NXf6sEJq3ZtwLIWgkGH4
cdbea76a-96b7-4311-b41b-cc2fe9fa2b7e	ac4f8706-c4de-4bbf-a3e0-ecc9e1811e89	keyUse	ENC
0cbdccc4-da8f-4cfe-8456-36b9039b92ef	049cd4d7-5dee-4663-ad47-a29dde0df7bd	secret	PPYDMrhzfnEf51M6WCk96g
53432a12-f8ea-4914-ade0-5075b38ef2fb	049cd4d7-5dee-4663-ad47-a29dde0df7bd	priority	100
becc7d56-24c1-4fda-a9be-6e885cc9ecff	049cd4d7-5dee-4663-ad47-a29dde0df7bd	kid	650bcea3-cfe6-4908-bcf5-09d5a4c0ea6d
dce4d7c2-1738-4e96-b1a9-b0631e4f08e0	adf6bd67-6337-406f-b418-2e212220da64	kid	fe4e54f9-ed6d-4e03-97c6-957b4b1c410a
44c36377-1aed-44b8-b3e8-25ea9cfd77eb	adf6bd67-6337-406f-b418-2e212220da64	secret	cSRM_GIAmOSjiufvo2hQc_5OzsQfrld4U_yhpOKYH4t0TKnjX-t-xCJP87hySXcSSfhdOTJOjc3R-2tm6zDdww
d47d90e6-8654-49e6-a0d5-4544b9d776b3	adf6bd67-6337-406f-b418-2e212220da64	priority	100
ff42629c-2bf5-4542-8706-bf99401ce02e	adf6bd67-6337-406f-b418-2e212220da64	algorithm	HS256
e9303738-c99f-4e18-880c-99bf38ca116b	c99bf748-e1cb-464d-bc71-dc3df64c4470	secret	9FiNeFr1iaJQlVa4dphNeA
d606aa02-a7e3-4f63-83f7-17b4769bd431	c99bf748-e1cb-464d-bc71-dc3df64c4470	priority	100
676195a5-209b-42b4-bd46-7a2a30d72c20	c99bf748-e1cb-464d-bc71-dc3df64c4470	kid	d82afc05-405b-4ac0-94f8-344913fc5f6c
0277bde2-fec0-4aa6-81d9-985a7b579e57	7d24e150-a39b-4815-bc42-a7e5838e3e51	keyUse	SIG
f667d633-771b-4daa-8483-43c4c8d704a4	7d24e150-a39b-4815-bc42-a7e5838e3e51	certificate	MIICqTCCAZECBgGN+ngMZTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1maXdhcmUtc2VydmVyMB4XDTI0MDMwMTE0NDEyOFoXDTM0MDMwMTE0NDMwOFowGDEWMBQGA1UEAwwNZml3YXJlLXNlcnZlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIX983SQTluh1H9weV1BbYNh7F7WJy3deXo77nhSxsdvuoCeEZ0yQ+HICKLJY46ydntutQibKzcJnPHUbpfcIZBixL9LRHzP1UiIArVR6bIGNC+O4nriU8qHfcLd7WzMZbROtpMTwD2N0wclXEqXfULYRYNxesYvAFlBTgbeNDLT0WsWd2+Ew/3Bs5Iak9erTEGqy4oFJhA5MKtKjsXFd3OAYHj+nSwX38cezZ43lf/cfFEQToDWsZ2k4nxJAtG6coLlxL72gu9radAcyerpdOUjZgCNb+TJstZM4xCIA6qOd0s3iMx3GgzbeMQW9aHo1kQyaI4RZYRVEPbp8Gn77+kCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEASLa6NBrC+GW5czgD3pUrhaJXwMJiiPUqpKHzs3uRnuBxqj60/lTquLSJDwvoK3VK3SNnRhDghiGvrKtUIeyB8xnxXhdtkad4/joZ9SUzZmjHVMdck6W+bUGx0k6y0DTNHBNXJW6/CT8aJW/BoHmxKfY70Mxwy3v/8U+J7DIhHEsepbo5SzLpzrYFXWVgmaq5QHzC9o0C/TWUJPo7/tBk6ZHi9OlV1M45X0Pdcb6SEjSSAyXPZuVxy6zBt+5egETANdoeNcEbkeVWWaqk/1dUsyelruwi1dIkZUaf0xplnI8G03Sc9A6u8mX2EUjszsx9wWek0qpiTEsJ4rLFSaoG5A==
57927acd-3332-4dda-9eb9-ff9db213edec	7d24e150-a39b-4815-bc42-a7e5838e3e51	priority	100
6f3c352c-dc87-4d67-ad4a-d25bebb0248e	7d24e150-a39b-4815-bc42-a7e5838e3e51	privateKey	MIIEogIBAAKCAQEAhf3zdJBOW6HUf3B5XUFtg2HsXtYnLd15ejvueFLGx2+6gJ4RnTJD4cgIosljjrJ2e261CJsrNwmc8dRul9whkGLEv0tEfM/VSIgCtVHpsgY0L47ieuJTyod9wt3tbMxltE62kxPAPY3TByVcSpd9QthFg3F6xi8AWUFOBt40MtPRaxZ3b4TD/cGzkhqT16tMQarLigUmEDkwq0qOxcV3c4BgeP6dLBffxx7NnjeV/9x8URBOgNaxnaTifEkC0bpyguXEvvaC72tp0BzJ6ul05SNmAI1v5Mmy1kzjEIgDqo53SzeIzHcaDNt4xBb1oejWRDJojhFlhFUQ9unwafvv6QIDAQABAoIBAHepc+KFfXUX8U5ehARkigjrSsznM9YiFHq1SyLpydwSS9zRTam1WiopGo1GjULC3k0dcU9eRBnC3AacUKgOT2tCybKM5X0RnshHryN/I9V49OIEGP7lYS9eEVIWIBMp9yovoZ135hcSsYOQOfvjjlpECtB4Z8zV7NnJGIXJq5Q3i0eXSFIkPgsommJioQqIr7sXd646tsl2ZS2vBqbqEy1Uafa5khYK3ibH1tdbR7NALGn848xSDPiMJVMLmKFzckFFGRp3MEUD8Vq2cuRnzRWWonb6TPMHsGYVwvQZri7MkK7k6uWpm8tD1pPwTmIBarNjvAicCB1UUnndMFeacAECgYEAxKyQasOuCYvoqmeVtB3Xp0aHKh90vT5NU3tC//RjygtP+HkBm/kN2fl5X3j2owaGupH1xjICF9DA3NOOMLA+wx+GV0+8yoD/5wAMzk2Y1vS5YWIKZWEJvxHq4OZLCeaGIhNoFSpAeMUYtfv7T03UdymVS7fcSWPNKc6wU/z45hECgYEArmj+El5hyO8W4IcM6DTQuvB4XljZB83x0Y1wcb+sKm9vJk5+k2WUpE8W9DzUMuAbQIMoMF5FcZValWiw1QNWXh3YzbvbMhRVKIovRqjQwBo/gLXmimLoP23bLjYmblJDHxIQkEfYSSZPa3plZvuw8HBZuJD1WgWIZMkeaaqwtFkCgYAVVwAIhZjxsjuZmcm1lHNc1BtAZ89b5VGwmDRJ33OgbZ/Mvxx8lwZ4u0f/Ivnn8IJX5hR739s4SE9U5qOMBuOYemgyOxWqB1s87lV1YRgPYthmh6PHIkNTdxc8NeC4f0nYkrB9c2sxb3lh7ah0D2bZUyq+34FIeUq+mY2qX02GcQKBgD9IIx/BFRPWBGP1PG6ocy/Q/quk6yJUzC/vdOQg2rQO+LJaery6d8NiWv7Fb20COYEf1Z4vJl0/Br39XWP8sQK3K6oCRlcWX4u1D9BAgnWhUHdACOUfXAtfrc5HoYwX1vjYEiB3oPdxqhFiOJa0LhAfg75fAlbmeQWwn5NRdooJAoGAGlFUjlPA9v30piafu9Rz2KZI23TdehdMifaaiXOOsHAX9LLuXk0zZXrRTDxJqtwqZ8PaPbf53NtuOPtFQgVT12ajqELQd67g9FeD69ym67natTffPSW8vnm1m0GmY/Cik3I1x9kWDnAyHLVHETOyEvNMhzeqvg09LryqI1aKB9Q=
a252a33a-f851-411c-b037-9b0d1bd55cf2	4f303497-631a-4058-92b4-0e4de70e5321	algorithm	RSA-OAEP
6d795bda-b37d-460b-bfef-4d23c1735dde	4f303497-631a-4058-92b4-0e4de70e5321	certificate	MIICqTCCAZECBgGN+ngM2zANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1maXdhcmUtc2VydmVyMB4XDTI0MDMwMTE0NDEyOFoXDTM0MDMwMTE0NDMwOFowGDEWMBQGA1UEAwwNZml3YXJlLXNlcnZlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAIeyYcOXy4Hy+NCm8f/OrKNWKTZfWSXdz9w2pQqqcWWgofv0uPNH43y49k5Dc+MXGGj9+2q3Jw72PdNGmrMcAW4nVFcrN820vD01nF2YT02pCfxHWs1ZqYJA3YK4Ghtul0mnAHiVVxRBTR0MJDJ7xIpSI+XnHFVvhScgaj70Odj+cdhm1OvQpsRd1sTxnGa8HYzn/7SKrYp/Ro0HFuS1GUrdjCo0ml4b/rz57Ms9hNgn0iIFFpLVzoA+WkoJPMCBUJnaejMPEsmuSEKAede30SRTis+pVtcRIiIPYDMOxgKLrenOrCj92RQbHKg+LH2xsNXR1YVEsUi12xkgWxyawGkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAICXfoNvOe40UR4yi8IvFlsYU3iTDL0EomvokTToBcvGiKHiZuuZX7OusyRedh3Y/aEsua8UXHpUpSYryQjTObbTM4dSRoq88yFZeJUi6jGBjSyDoE7RtiVum9rDHRnpBonMQVa9/pxeg568pwWWKf20PcpNWpnwCxbdq5202prSYPrfTp9W+wOs+00j5sCOEmEgG2EGvQtZzg2/TxBeXwYEE5tCrKA8TXfaZd6Cn0fOskEC4ThLjZ+Exb2at6oPAATEc00m79Ozg10kh9s+J91+ulb1tQVQgQikb59qU7IhEcBKOzVfUhii3uTzG60WmPUhko5AeBcOQssrAQf/1rA==
8a78f870-b5a8-4ca3-afa8-b56dbf865b91	4f303497-631a-4058-92b4-0e4de70e5321	priority	100
2cb32662-528d-4176-85a0-23e321b7c0d8	4f303497-631a-4058-92b4-0e4de70e5321	keyUse	ENC
af4c9285-dcac-43e6-bac7-d5bf578d7ea6	4f303497-631a-4058-92b4-0e4de70e5321	privateKey	MIIEowIBAAKCAQEAh7Jhw5fLgfL40Kbx/86so1YpNl9ZJd3P3DalCqpxZaCh+/S480fjfLj2TkNz4xcYaP37arcnDvY900aasxwBbidUVys3zbS8PTWcXZhPTakJ/EdazVmpgkDdgrgaG26XSacAeJVXFEFNHQwkMnvEilIj5eccVW+FJyBqPvQ52P5x2GbU69CmxF3WxPGcZrwdjOf/tIqtin9GjQcW5LUZSt2MKjSaXhv+vPnsyz2E2CfSIgUWktXOgD5aSgk8wIFQmdp6Mw8Sya5IQoB517fRJFOKz6lW1xEiIg9gMw7GAout6c6sKP3ZFBscqD4sfbGw1dHVhUSxSLXbGSBbHJrAaQIDAQABAoIBAF+Or6f0Ujx9pNgSaGKS4SHYwAbpGDdBP2o9FPYw1tARUWDDkibH3hvriI/OkmI91lPBX3Zj6d5wa1NH6hLtStiOW6dS6OY0O0cDZMzIQDhZLI36laf8VxFBqnuuN7xPobwdHYjM6dh6r9ofvbHLVLlvZJY2rM5BTUwjWI5ioAX9BWJAtYNLm/gr/k/taB2GmdVo4jvq18sgoBo2zzBG/hc2SWV03DDHp+yazfIl+8pxpuHmDxKgGuAm0AiQcaAyKfh18RUYszmfaBYxLdx85ZcGr8q1842v/S5WLcwuuBj1bbhmlKYFGVuE1CAdM1p8ZehvWEOD22UF7iYUHg/HrJ0CgYEA4VOWP67MG6wZvY7LOw6flkm5o9qLlgwUbg3pLaE5ExAi8NG3+UU6jtcLlKIm5YFwQpK/3nvRiGLCDXBvfiLpBi5IErqfMYVS7u8nc9uRKG/DHlFyWogVAcAh48vMJZSeumrSX//O1payyk/T5A+1VJgD7TSFFq/F6R8kLbg9HnsCgYEAmitJGTwlbK6HdWt91B+OQyJON50x/Lf0RBkrOjGpMnc2H83ZWXh9XXsMFwWxe/DfGoUvriM2rUE83RNgJLXWI5DD27l11IHR2e39x8QZjnlU58jAWalA/kta2wcccIQgmeP+sYu3b7IqAMQNlZLY1zPwukxX7N2im511oNevGWsCgYEArrzKjLI6WM9a2tSMqEzL15lu3DGUBBV0FnC1PoyDnVPrNMP+HtHf+nur4GTrMxnw+7+gCaINuO2VPSTPYYsjGIb1n4iYAag5y08tUjyY0jnxn2Zb/vb/C297GJOnyhD6EujaIlZXibQuDJRhZsADyAlnKiGLgC9plEJxJP92blcCgYAMsiXZ6ycV1SWYmNqK3nJjuu6AC/Ty399AwGXb6/0IB+MwKU6N3KtOSHTNbI2aLFLjJzau+31kNSwi9JaFT2gsE57deF9ouawja0Lr8Y09O2avk8urVpHgnyoDQYmpBmh849a0nlHj4+MrnvmTaL1ss31OijzvZ60dbZEjRr/HswKBgBCMMOmE0An9nGaS/vkuaHS+w3b+iT3tyMlPDrDHmUWfChl1Mqp1nHq0lW8efgQmhU7JQlCh9nBQkzxJCTmcw8u0y2Jk2b9sJ4/AYyMtq4xgcr/QdAX0pH1mEAZ5Jn0pB6Hif1S6dcpUZmKrkrimlF894KRi+aFVpimYox5H9qnb
80580bd6-a3e2-43fb-9fe2-31706b6ec3bb	df33adeb-9b74-47d2-b179-fc5a5d276bf8	host-sending-registration-request-must-match	true
04b6894c-d819-4a58-8b17-63dade9e298c	df33adeb-9b74-47d2-b179-fc5a5d276bf8	client-uris-must-match	true
94c22de3-2fad-49d6-bb30-ec41234114dd	f1b0c216-53b2-4a08-bdf4-2b2c5944ac76	max-clients	200
aac8af4a-ea59-42b0-8d4c-bb889928cbcb	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	oidc-address-mapper
76e9e6cd-192a-497d-8ffa-8099acc633e3	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	saml-user-property-mapper
0298a346-59f9-4354-9f25-c357eb422167	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	saml-role-list-mapper
f9ba68a3-31fc-410f-9c33-3714db40f2e2	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	oidc-full-name-mapper
66e718aa-655a-41e9-91a8-24f1a4af693f	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
dcd56c5e-62bb-4de9-965e-0d1c323a65b2	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
f27ad87f-5226-41b3-959b-85a3894f7b09	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	saml-user-attribute-mapper
779c5ac5-6a3a-4acf-9d17-07df2513be66	ecd2296b-55c1-439e-a8c7-b2ce0439a8dc	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
224ac104-e3cc-423c-b9bf-39219aa6f716	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	saml-role-list-mapper
e8971bb3-4fda-4875-8e42-01101262f413	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	saml-user-property-mapper
9b6f300c-69e1-41fb-8341-8ff364891ed9	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	saml-user-attribute-mapper
09b05b20-95c6-4466-81b0-28308ace55a3	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
8c849c8c-dcd7-4a25-a054-6060d99922f8	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
6a0a33a2-20e6-45a4-a638-a51bc3aa0b3a	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
99bd4c2d-4aef-4359-813c-198ad59288f4	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	oidc-address-mapper
64d2137f-e739-4f1b-a7f9-1c7cbad13001	8c0fb141-4ce8-4b66-87c8-34fc7bcab3b9	allowed-protocol-mapper-types	oidc-full-name-mapper
8f3d9a5e-9a8a-4f20-b74a-72a2ae798abf	c58339d4-5209-4808-bdc8-df3d09f07130	allow-default-scopes	true
402eb23f-2dc8-45d1-be2f-24cbe866d7e9	d3377b7d-7d0b-4134-9531-4551648b3fa1	allow-default-scopes	true
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
313f957d-ffac-48f8-ba97-ac8de16cb459	b896b09e-ae51-4785-9b42-9969de2b141e
313f957d-ffac-48f8-ba97-ac8de16cb459	2674fe03-5995-4d34-bbf1-012c2893b7eb
313f957d-ffac-48f8-ba97-ac8de16cb459	d693714d-bef1-45f7-9219-96c4dbf4103b
313f957d-ffac-48f8-ba97-ac8de16cb459	918823f3-524e-475e-8f95-81a5386c38a1
313f957d-ffac-48f8-ba97-ac8de16cb459	66669bac-8579-4655-aacc-1893bc201a1b
313f957d-ffac-48f8-ba97-ac8de16cb459	f063487a-bce4-4781-be77-2843637e6d72
313f957d-ffac-48f8-ba97-ac8de16cb459	200d3f73-539f-4625-b4ee-f3703062f4fc
313f957d-ffac-48f8-ba97-ac8de16cb459	617cec3d-053f-4438-a8b6-c7a733f8ec60
313f957d-ffac-48f8-ba97-ac8de16cb459	9a60f451-a17a-4c04-b5db-c2a3682725e7
313f957d-ffac-48f8-ba97-ac8de16cb459	41d7ec21-c3bb-45f8-ade8-8d2a233581f8
313f957d-ffac-48f8-ba97-ac8de16cb459	5f443faa-1337-4a51-aa7e-6db98d350b68
313f957d-ffac-48f8-ba97-ac8de16cb459	8a60b6d8-a231-4fe1-8ce9-2b5eceb8ce24
313f957d-ffac-48f8-ba97-ac8de16cb459	3f99b2a1-1498-4621-8a57-efbcc3777eaf
313f957d-ffac-48f8-ba97-ac8de16cb459	ed6738f0-bffa-4823-9ba0-e9f671026d1c
313f957d-ffac-48f8-ba97-ac8de16cb459	c09d6176-f4ac-4e8d-a3a9-83c6549c4337
313f957d-ffac-48f8-ba97-ac8de16cb459	e7e17f92-7fbc-4319-be25-0b67190a560d
313f957d-ffac-48f8-ba97-ac8de16cb459	4189f2b7-68b0-4fa7-81e5-48535a2bfa86
313f957d-ffac-48f8-ba97-ac8de16cb459	637c4cc2-9e2a-44a9-ac25-53818096b8cd
66669bac-8579-4655-aacc-1893bc201a1b	e7e17f92-7fbc-4319-be25-0b67190a560d
918823f3-524e-475e-8f95-81a5386c38a1	c09d6176-f4ac-4e8d-a3a9-83c6549c4337
918823f3-524e-475e-8f95-81a5386c38a1	637c4cc2-9e2a-44a9-ac25-53818096b8cd
47014777-78ce-4a87-a671-80d33bdcdb55	b0296cc4-c94b-4bfd-a212-4a46e23a71d9
47014777-78ce-4a87-a671-80d33bdcdb55	13660469-ffd3-421e-94bd-095b4918e159
13660469-ffd3-421e-94bd-095b4918e159	c4334b45-6881-48b4-bf2d-7f514ab8fcc3
f60c1bdd-43d1-4cf6-bf08-a77789347479	089a0a23-a2df-4af3-b941-c8b71c112708
313f957d-ffac-48f8-ba97-ac8de16cb459	e95cfbf2-f3d6-4f80-9f56-920232f7b997
47014777-78ce-4a87-a671-80d33bdcdb55	04a5152d-4371-4552-995f-08944adfdd4b
47014777-78ce-4a87-a671-80d33bdcdb55	b81c74f6-c5e7-44f7-b294-9baf1d77d599
313f957d-ffac-48f8-ba97-ac8de16cb459	8d69b447-3cca-4a5b-8e37-195146726fed
313f957d-ffac-48f8-ba97-ac8de16cb459	e0439b99-2983-4ebe-89fb-bfc501764153
313f957d-ffac-48f8-ba97-ac8de16cb459	b827ae20-1ebc-4fdc-9c3c-2f66fafea8fa
313f957d-ffac-48f8-ba97-ac8de16cb459	809f9379-6790-4a3e-91c4-93547549ce67
313f957d-ffac-48f8-ba97-ac8de16cb459	233c1f8b-2e7a-4892-976f-237fa4815b85
313f957d-ffac-48f8-ba97-ac8de16cb459	9f3f59ed-018a-4d31-9c03-d55f11290207
313f957d-ffac-48f8-ba97-ac8de16cb459	0715988c-1926-487d-9cb7-e405f1d38eb6
313f957d-ffac-48f8-ba97-ac8de16cb459	ac213552-7321-4962-8050-24e5b19827bf
313f957d-ffac-48f8-ba97-ac8de16cb459	24da3e46-d54c-4d24-ba40-8fc36e2bf28a
313f957d-ffac-48f8-ba97-ac8de16cb459	05a18bed-4c98-4bca-be9f-58319fba3623
313f957d-ffac-48f8-ba97-ac8de16cb459	6bf767fb-13df-4555-a30b-f84606fefd13
313f957d-ffac-48f8-ba97-ac8de16cb459	64f1a90d-68e3-4ca5-b41d-cbfdfdbed3ba
313f957d-ffac-48f8-ba97-ac8de16cb459	5c3e2f9f-c49e-4a75-88aa-e8c33f2643f4
313f957d-ffac-48f8-ba97-ac8de16cb459	f059b5fb-7ea5-41cd-995c-25abd0328ca6
313f957d-ffac-48f8-ba97-ac8de16cb459	71fdd6db-0393-4ef7-af9c-f5fe6b8b3af8
313f957d-ffac-48f8-ba97-ac8de16cb459	02839e02-4727-46d9-8f2d-ee633c038682
313f957d-ffac-48f8-ba97-ac8de16cb459	a45cce50-5147-43aa-98df-d8682836b332
809f9379-6790-4a3e-91c4-93547549ce67	71fdd6db-0393-4ef7-af9c-f5fe6b8b3af8
b827ae20-1ebc-4fdc-9c3c-2f66fafea8fa	a45cce50-5147-43aa-98df-d8682836b332
b827ae20-1ebc-4fdc-9c3c-2f66fafea8fa	f059b5fb-7ea5-41cd-995c-25abd0328ca6
6045c4d8-4547-4900-aa18-3492e349cd8e	310936b2-ffd5-4371-8575-788c329d85fe
6045c4d8-4547-4900-aa18-3492e349cd8e	282d1363-bfe5-4e61-9afe-9094f81e77cb
6045c4d8-4547-4900-aa18-3492e349cd8e	fdc9a5e6-1a48-4a04-910c-23a36c9f7577
6045c4d8-4547-4900-aa18-3492e349cd8e	46a517f5-0f5e-44c7-a7bd-631444fca1cc
6045c4d8-4547-4900-aa18-3492e349cd8e	af62d230-09dc-49f3-9437-b05381c74943
6045c4d8-4547-4900-aa18-3492e349cd8e	b2025ecd-96f5-4e89-a16e-3e7014fc8af5
6045c4d8-4547-4900-aa18-3492e349cd8e	fd569380-5f62-4aad-b3b0-dcac194724af
6045c4d8-4547-4900-aa18-3492e349cd8e	08c40037-5b75-4706-8075-ee4589026612
6045c4d8-4547-4900-aa18-3492e349cd8e	892ed299-a1c8-454f-8b30-619f77e40d53
6045c4d8-4547-4900-aa18-3492e349cd8e	3607c3c9-3410-4ba7-97af-b564b4aa84a8
6045c4d8-4547-4900-aa18-3492e349cd8e	a37e722a-594a-47b5-8730-82e9180bac1b
6045c4d8-4547-4900-aa18-3492e349cd8e	8fa9dbc4-8029-4769-9a7b-a52d632fc72d
6045c4d8-4547-4900-aa18-3492e349cd8e	443c1e21-1fdf-48f4-a207-358f0f0e127f
6045c4d8-4547-4900-aa18-3492e349cd8e	bef11c06-7013-41db-a865-c1347d5dbedd
6045c4d8-4547-4900-aa18-3492e349cd8e	f04b5a2b-82a7-4fc8-94b5-bef46ad0d404
6045c4d8-4547-4900-aa18-3492e349cd8e	bf77732f-8adc-45ca-b535-aca36239c6fb
6045c4d8-4547-4900-aa18-3492e349cd8e	3048b858-737f-40fd-a6a0-9556120bcc73
46a517f5-0f5e-44c7-a7bd-631444fca1cc	f04b5a2b-82a7-4fc8-94b5-bef46ad0d404
fdc9a5e6-1a48-4a04-910c-23a36c9f7577	bef11c06-7013-41db-a865-c1347d5dbedd
fdc9a5e6-1a48-4a04-910c-23a36c9f7577	3048b858-737f-40fd-a6a0-9556120bcc73
3792b25a-3b02-453a-b945-aae2b442e499	657a5074-1581-4e93-88bc-603e0728acfe
3792b25a-3b02-453a-b945-aae2b442e499	26037ebe-6916-420e-b7df-e6434792c854
26037ebe-6916-420e-b7df-e6434792c854	e855797c-b27c-4a8a-804e-01ed8c096dc4
cbb4ae20-4c00-4063-a6a7-3cf9a115c97f	fc65eb03-6f14-46f1-9b0c-f5c68d9368f7
313f957d-ffac-48f8-ba97-ac8de16cb459	b2a3e561-b2d8-4bd1-ba52-360d9b2cc725
6045c4d8-4547-4900-aa18-3492e349cd8e	19b530f9-103d-4ddf-978f-80ce62cda251
3792b25a-3b02-453a-b945-aae2b442e499	5e374f11-6256-42a8-ac67-32915eae0160
3792b25a-3b02-453a-b945-aae2b442e499	1830f4db-bbc8-43f6-80f7-6b7cf7ff69f0
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
8ef00c5a-81c5-4a88-a967-66e09a017e82	\N	password	7e5599cc-8733-4ba6-97e5-5f4164d55a82	1709304109423	\N	{"value":"wwJtXV+aPB3719636AkosZD3TFJMH69d7duQ/FpctMCBaAbxOPh27UZeN4Hn46/jk9ZOK3efNj0U3YfK1rCU8Q==","salt":"/zu+aUE+QPvFtB+IqlJWvQ==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
3b8e8b06-ccc1-436a-9356-1f6742d5987a	\N	password	05e63846-7ea8-4346-ac00-f6a8aef00fae	1709304578358	\N	{"value":"4910Vq60pKShWBVr1NqKyS9khT+AdnPpjTBrokmQg8GyZvG5mjcSUfkDP0z0ToZ5t3WHF/AyhVevBjJlwso7qQ==","salt":"Y1Kx3am2gN7Xxiuz5IsOCw==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2024-03-01 14:41:39.707641	1	EXECUTED	7:4e70412f24a3f382c82183742ec79317	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	9304099380
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2024-03-01 14:41:39.725628	2	MARK_RAN	7:cb16724583e9675711801c6875114f28	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	3.5.4	\N	\N	9304099380
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2024-03-01 14:41:39.764342	3	EXECUTED	7:0310eb8ba07cec616460794d42ade0fa	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	3.5.4	\N	\N	9304099380
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2024-03-01 14:41:39.768217	4	EXECUTED	7:5d25857e708c3233ef4439df1f93f012	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	9304099380
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2024-03-01 14:41:39.842807	5	EXECUTED	7:c7a54a1041d58eb3817a4a883b4d4e84	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	9304099380
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2024-03-01 14:41:39.847608	6	MARK_RAN	7:2e01012df20974c1c2a605ef8afe25b7	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	3.5.4	\N	\N	9304099380
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2024-03-01 14:41:39.922696	7	EXECUTED	7:0f08df48468428e0f30ee59a8ec01a41	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	9304099380
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2024-03-01 14:41:39.927839	8	MARK_RAN	7:a77ea2ad226b345e7d689d366f185c8c	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	3.5.4	\N	\N	9304099380
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2024-03-01 14:41:39.943456	9	EXECUTED	7:a3377a2059aefbf3b90ebb4c4cc8e2ab	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	3.5.4	\N	\N	9304099380
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2024-03-01 14:41:40.044496	10	EXECUTED	7:04c1dbedc2aa3e9756d1a1668e003451	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	3.5.4	\N	\N	9304099380
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2024-03-01 14:41:40.10575	11	EXECUTED	7:36ef39ed560ad07062d956db861042ba	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	9304099380
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2024-03-01 14:41:40.114931	12	MARK_RAN	7:d909180b2530479a716d3f9c9eaea3d7	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	9304099380
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2024-03-01 14:41:40.136065	13	EXECUTED	7:cf12b04b79bea5152f165eb41f3955f6	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	3.5.4	\N	\N	9304099380
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-01 14:41:40.153312	14	EXECUTED	7:7e32c8f05c755e8675764e7d5f514509	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	3.5.4	\N	\N	9304099380
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-01 14:41:40.155691	15	MARK_RAN	7:980ba23cc0ec39cab731ce903dd01291	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	9304099380
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-01 14:41:40.157767	16	MARK_RAN	7:2fa220758991285312eb84f3b4ff5336	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	3.5.4	\N	\N	9304099380
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2024-03-01 14:41:40.163061	17	EXECUTED	7:d41d8cd98f00b204e9800998ecf8427e	empty		\N	3.5.4	\N	\N	9304099380
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2024-03-01 14:41:40.218875	18	EXECUTED	7:91ace540896df890cc00a0490ee52bbc	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	3.5.4	\N	\N	9304099380
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2024-03-01 14:41:40.270039	19	EXECUTED	7:c31d1646dfa2618a9335c00e07f89f24	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	9304099380
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2024-03-01 14:41:40.275423	20	EXECUTED	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	9304099380
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-01 14:41:41.667294	45	EXECUTED	7:6a48ce645a3525488a90fbf76adf3bb3	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	9304099380
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2024-03-01 14:41:40.277966	21	MARK_RAN	7:f987971fe6b37d963bc95fee2b27f8df	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	3.5.4	\N	\N	9304099380
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2024-03-01 14:41:40.281759	22	MARK_RAN	7:df8bc21027a4f7cbbb01f6344e89ce07	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	3.5.4	\N	\N	9304099380
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2024-03-01 14:41:40.33828	23	EXECUTED	7:ed2dc7f799d19ac452cbcda56c929e47	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	3.5.4	\N	\N	9304099380
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2024-03-01 14:41:40.343295	24	EXECUTED	7:80b5db88a5dda36ece5f235be8757615	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	9304099380
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2024-03-01 14:41:40.345448	25	MARK_RAN	7:1437310ed1305a9b93f8848f301726ce	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	3.5.4	\N	\N	9304099380
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2024-03-01 14:41:40.556763	26	EXECUTED	7:b82ffb34850fa0836be16deefc6a87c4	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	3.5.4	\N	\N	9304099380
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2024-03-01 14:41:40.675683	27	EXECUTED	7:9cc98082921330d8d9266decdd4bd658	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	3.5.4	\N	\N	9304099380
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2024-03-01 14:41:40.679468	28	EXECUTED	7:03d64aeed9cb52b969bd30a7ac0db57e	update tableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	9304099380
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2024-03-01 14:41:40.729753	29	EXECUTED	7:f1f9fd8710399d725b780f463c6b21cd	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	3.5.4	\N	\N	9304099380
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2024-03-01 14:41:40.745427	30	EXECUTED	7:53188c3eb1107546e6f765835705b6c1	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	3.5.4	\N	\N	9304099380
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2024-03-01 14:41:40.759793	31	EXECUTED	7:d6e6f3bc57a0c5586737d1351725d4d4	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	3.5.4	\N	\N	9304099380
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2024-03-01 14:41:40.766191	32	EXECUTED	7:454d604fbd755d9df3fd9c6329043aa5	customChange		\N	3.5.4	\N	\N	9304099380
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-01 14:41:40.771566	33	EXECUTED	7:57e98a3077e29caf562f7dbf80c72600	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	9304099380
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-01 14:41:40.775487	34	MARK_RAN	7:e4c7e8f2256210aee71ddc42f538b57a	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	9304099380
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-01 14:41:40.800033	35	EXECUTED	7:09a43c97e49bc626460480aa1379b522	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	3.5.4	\N	\N	9304099380
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2024-03-01 14:41:40.805149	36	EXECUTED	7:26bfc7c74fefa9126f2ce702fb775553	addColumn tableName=REALM		\N	3.5.4	\N	\N	9304099380
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2024-03-01 14:41:40.810554	37	EXECUTED	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9304099380
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2024-03-01 14:41:40.813804	38	EXECUTED	7:37fc1781855ac5388c494f1442b3f717	addColumn tableName=FED_USER_CONSENT		\N	3.5.4	\N	\N	9304099380
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2024-03-01 14:41:40.81757	39	EXECUTED	7:13a27db0dae6049541136adad7261d27	addColumn tableName=IDENTITY_PROVIDER		\N	3.5.4	\N	\N	9304099380
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-03-01 14:41:40.819572	40	MARK_RAN	7:550300617e3b59e8af3a6294df8248a3	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	9304099380
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-03-01 14:41:40.821436	41	MARK_RAN	7:e3a9482b8931481dc2772a5c07c44f17	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	3.5.4	\N	\N	9304099380
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2024-03-01 14:41:40.827161	42	EXECUTED	7:72b07d85a2677cb257edb02b408f332d	customChange		\N	3.5.4	\N	\N	9304099380
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2024-03-01 14:41:41.658785	43	EXECUTED	7:a72a7858967bd414835d19e04d880312	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	3.5.4	\N	\N	9304099380
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2024-03-01 14:41:41.663593	44	EXECUTED	7:94edff7cf9ce179e7e85f0cd78a3cf2c	addColumn tableName=USER_ENTITY		\N	3.5.4	\N	\N	9304099380
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-01 14:41:41.671645	46	EXECUTED	7:e64b5dcea7db06077c6e57d3b9e5ca14	customChange		\N	3.5.4	\N	\N	9304099380
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-01 14:41:41.67351	47	MARK_RAN	7:fd8cf02498f8b1e72496a20afc75178c	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	3.5.4	\N	\N	9304099380
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-01 14:41:41.742674	48	EXECUTED	7:542794f25aa2b1fbabb7e577d6646319	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	3.5.4	\N	\N	9304099380
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2024-03-01 14:41:41.746668	49	EXECUTED	7:edad604c882df12f74941dac3cc6d650	addColumn tableName=REALM		\N	3.5.4	\N	\N	9304099380
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2024-03-01 14:41:41.780246	50	EXECUTED	7:0f88b78b7b46480eb92690cbf5e44900	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	3.5.4	\N	\N	9304099380
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2024-03-01 14:41:41.941681	51	EXECUTED	7:d560e43982611d936457c327f872dd59	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	3.5.4	\N	\N	9304099380
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2024-03-01 14:41:41.945114	52	EXECUTED	7:c155566c42b4d14ef07059ec3b3bbd8e	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	9304099380
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2024-03-01 14:41:41.947971	53	EXECUTED	7:b40376581f12d70f3c89ba8ddf5b7dea	update tableName=REALM		\N	3.5.4	\N	\N	9304099380
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2024-03-01 14:41:41.950489	54	EXECUTED	7:a1132cc395f7b95b3646146c2e38f168	update tableName=CLIENT		\N	3.5.4	\N	\N	9304099380
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-01 14:41:41.955629	55	EXECUTED	7:d8dc5d89c789105cfa7ca0e82cba60af	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	3.5.4	\N	\N	9304099380
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-01 14:41:41.959918	56	EXECUTED	7:7822e0165097182e8f653c35517656a3	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	3.5.4	\N	\N	9304099380
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-01 14:41:41.988333	57	EXECUTED	7:c6538c29b9c9a08f9e9ea2de5c2b6375	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	3.5.4	\N	\N	9304099380
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2024-03-01 14:41:42.190261	58	EXECUTED	7:6d4893e36de22369cf73bcb051ded875	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	3.5.4	\N	\N	9304099380
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2024-03-01 14:41:42.21685	59	EXECUTED	7:57960fc0b0f0dd0563ea6f8b2e4a1707	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	3.5.4	\N	\N	9304099380
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2024-03-01 14:41:42.223001	60	EXECUTED	7:2b4b8bff39944c7097977cc18dbceb3b	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	3.5.4	\N	\N	9304099380
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-03-01 14:41:42.231083	61	EXECUTED	7:2aa42a964c59cd5b8ca9822340ba33a8	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	3.5.4	\N	\N	9304099380
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2024-03-01 14:41:42.235518	62	EXECUTED	7:9ac9e58545479929ba23f4a3087a0346	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	3.5.4	\N	\N	9304099380
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2024-03-01 14:41:42.238218	63	EXECUTED	7:14d407c35bc4fe1976867756bcea0c36	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	9304099380
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2024-03-01 14:41:42.240382	64	EXECUTED	7:241a8030c748c8548e346adee548fa93	update tableName=REQUIRED_ACTION_PROVIDER		\N	3.5.4	\N	\N	9304099380
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2024-03-01 14:41:42.24262	65	EXECUTED	7:7d3182f65a34fcc61e8d23def037dc3f	update tableName=RESOURCE_SERVER_RESOURCE		\N	3.5.4	\N	\N	9304099380
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2024-03-01 14:41:42.265774	66	EXECUTED	7:b30039e00a0b9715d430d1b0636728fa	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	3.5.4	\N	\N	9304099380
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2024-03-01 14:41:42.282061	67	EXECUTED	7:3797315ca61d531780f8e6f82f258159	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	3.5.4	\N	\N	9304099380
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2024-03-01 14:41:42.285774	68	EXECUTED	7:c7aa4c8d9573500c2d347c1941ff0301	addColumn tableName=REALM		\N	3.5.4	\N	\N	9304099380
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2024-03-01 14:41:42.30529	69	EXECUTED	7:b207faee394fc074a442ecd42185a5dd	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	3.5.4	\N	\N	9304099380
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2024-03-01 14:41:42.310603	70	EXECUTED	7:ab9a9762faaba4ddfa35514b212c4922	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	3.5.4	\N	\N	9304099380
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2024-03-01 14:41:42.314345	71	EXECUTED	7:b9710f74515a6ccb51b72dc0d19df8c4	addColumn tableName=RESOURCE_SERVER		\N	3.5.4	\N	\N	9304099380
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-01 14:41:42.319741	72	EXECUTED	7:ec9707ae4d4f0b7452fee20128083879	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	9304099380
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-01 14:41:42.325652	73	EXECUTED	7:3979a0ae07ac465e920ca696532fc736	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	9304099380
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-01 14:41:42.32747	74	MARK_RAN	7:5abfde4c259119d143bd2fbf49ac2bca	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	3.5.4	\N	\N	9304099380
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-01 14:41:42.339627	75	EXECUTED	7:b48da8c11a3d83ddd6b7d0c8c2219345	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	3.5.4	\N	\N	9304099380
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2024-03-01 14:41:42.361478	76	EXECUTED	7:a73379915c23bfad3e8f5c6d5c0aa4bd	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	3.5.4	\N	\N	9304099380
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-01 14:41:42.364958	77	EXECUTED	7:39e0073779aba192646291aa2332493d	addColumn tableName=CLIENT		\N	3.5.4	\N	\N	9304099380
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-01 14:41:42.366814	78	MARK_RAN	7:81f87368f00450799b4bf42ea0b3ec34	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	3.5.4	\N	\N	9304099380
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-01 14:41:42.382478	79	EXECUTED	7:20b37422abb9fb6571c618148f013a15	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	3.5.4	\N	\N	9304099380
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2024-03-01 14:41:42.384743	80	MARK_RAN	7:1970bb6cfb5ee800736b95ad3fb3c78a	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	3.5.4	\N	\N	9304099380
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-01 14:41:42.401993	81	EXECUTED	7:45d9b25fc3b455d522d8dcc10a0f4c80	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	3.5.4	\N	\N	9304099380
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-01 14:41:42.404526	82	MARK_RAN	7:890ae73712bc187a66c2813a724d037f	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9304099380
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-01 14:41:42.407936	83	EXECUTED	7:0a211980d27fafe3ff50d19a3a29b538	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9304099380
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-01 14:41:42.409779	84	MARK_RAN	7:a161e2ae671a9020fff61e996a207377	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	3.5.4	\N	\N	9304099380
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2024-03-01 14:41:42.425728	85	EXECUTED	7:01c49302201bdf815b0a18d1f98a55dc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	3.5.4	\N	\N	9304099380
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2024-03-01 14:41:42.430316	86	EXECUTED	7:3dace6b144c11f53f1ad2c0361279b86	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	3.5.4	\N	\N	9304099380
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-03-01 14:41:42.436099	87	EXECUTED	7:578d0b92077eaf2ab95ad0ec087aa903	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	3.5.4	\N	\N	9304099380
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2024-03-01 14:41:42.443866	88	EXECUTED	7:c95abe90d962c57a09ecaee57972835d	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	3.5.4	\N	\N	9304099380
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.455232	89	EXECUTED	7:f1313bcc2994a5c4dc1062ed6d8282d3	addColumn tableName=REALM; customChange		\N	3.5.4	\N	\N	9304099380
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.463186	90	EXECUTED	7:90d763b52eaffebefbcbde55f269508b	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	3.5.4	\N	\N	9304099380
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.480288	91	EXECUTED	7:d554f0cb92b764470dccfa5e0014a7dd	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	9304099380
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.487004	92	EXECUTED	7:73193e3ab3c35cf0f37ccea3bf783764	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	3.5.4	\N	\N	9304099380
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.489038	93	MARK_RAN	7:90a1e74f92e9cbaa0c5eab80b8a037f3	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	9304099380
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.50204	94	EXECUTED	7:5b9248f29cd047c200083cc6d8388b16	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	3.5.4	\N	\N	9304099380
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.504067	95	MARK_RAN	7:64db59e44c374f13955489e8990d17a1	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	3.5.4	\N	\N	9304099380
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2024-03-01 14:41:42.507754	96	EXECUTED	7:329a578cdb43262fff975f0a7f6cda60	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	3.5.4	\N	\N	9304099380
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-01 14:41:42.553156	97	EXECUTED	7:fae0de241ac0fd0bbc2b380b85e4f567	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	3.5.4	\N	\N	9304099380
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-01 14:41:42.555194	98	MARK_RAN	7:075d54e9180f49bb0c64ca4218936e81	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	9304099380
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-01 14:41:42.570511	99	MARK_RAN	7:06499836520f4f6b3d05e35a59324910	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	9304099380
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-01 14:41:42.588315	100	EXECUTED	7:fad08e83c77d0171ec166bc9bc5d390a	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	9304099380
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-01 14:41:42.59065	101	MARK_RAN	7:3d2b23076e59c6f70bae703aa01be35b	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	3.5.4	\N	\N	9304099380
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-01 14:41:42.608021	102	EXECUTED	7:1a7f28ff8d9e53aeb879d76ea3d9341a	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	3.5.4	\N	\N	9304099380
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2024-03-01 14:41:42.613013	103	EXECUTED	7:2fd554456fed4a82c698c555c5b751b6	customChange		\N	3.5.4	\N	\N	9304099380
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2024-03-01 14:41:42.617319	104	EXECUTED	7:b06356d66c2790ecc2ae54ba0458397a	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	3.5.4	\N	\N	9304099380
\.


--
-- Data for Name: databasechangeloglock; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangeloglock (id, locked, lockgranted, lockedby) FROM stdin;
1	f	\N	\N
1000	f	\N	\N
1001	f	\N	\N
\.


--
-- Data for Name: default_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.default_client_scope (realm_id, scope_id, default_scope) FROM stdin;
master	ec01778a-efa1-42df-97f2-476be6cfe1ee	f
master	dee23010-617b-40a0-9743-5fda01dcbadd	t
master	318018c7-70c5-4834-b411-9e0559254c2f	t
master	37388d3d-ef31-423a-b756-44f44847c887	t
master	19132f67-6d25-40ed-9f7e-34bb7429cc02	f
master	466af8b1-6fc4-41b8-8a39-d3e09a22422d	f
master	3f0cbce4-adf7-49c6-9dba-51434b061b37	t
master	423ce762-00b9-4cc6-97db-8eaea7df4f31	t
master	f986ae52-8267-47dc-bce7-822238ae6dcf	f
fiware-server	ae7d096a-993f-4b54-8554-857d9dfa0fce	f
fiware-server	57442969-1294-4c55-a9e8-04ff009d4fcc	t
fiware-server	a7b1e404-9ce0-4346-9bf3-15358ddb9043	t
fiware-server	6522fd11-9454-4783-99d6-5b73e00d6518	t
fiware-server	250e2dbc-9387-4209-86fe-72f0b7ef3cb2	f
fiware-server	5e57ef27-60af-4619-9acf-9dfadc1066db	f
fiware-server	1ff66dcc-a619-4f01-b2f5-1d0a433f2627	t
fiware-server	38e6b97e-0029-43fe-aa4c-1c9982cfae0d	t
fiware-server	2f59b7cc-fb99-4905-90b1-404fc4ad935d	f
\.


--
-- Data for Name: event_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.event_entity (id, client_id, details_json, error, ip_address, realm_id, session_id, event_time, type, user_id) FROM stdin;
\.


--
-- Data for Name: fed_user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_attribute (id, name, user_id, realm_id, storage_provider_id, value) FROM stdin;
\.


--
-- Data for Name: fed_user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent (id, client_id, user_id, realm_id, storage_provider_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: fed_user_consent_cl_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_consent_cl_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: fed_user_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_credential (id, salt, type, created_date, user_id, realm_id, storage_provider_id, user_label, secret_data, credential_data, priority) FROM stdin;
\.


--
-- Data for Name: fed_user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_group_membership (group_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_required_action (required_action, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: fed_user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.fed_user_role_mapping (role_id, user_id, realm_id, storage_provider_id) FROM stdin;
\.


--
-- Data for Name: federated_identity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_identity (identity_provider, realm_id, federated_user_id, federated_username, token, user_id) FROM stdin;
\.


--
-- Data for Name: federated_user; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.federated_user (id, storage_provider_id, realm_id) FROM stdin;
\.


--
-- Data for Name: group_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_attribute (id, name, value, group_id) FROM stdin;
\.


--
-- Data for Name: group_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.group_role_mapping (role_id, group_id) FROM stdin;
\.


--
-- Data for Name: identity_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider (internal_id, enabled, provider_alias, provider_id, store_token, authenticate_by_default, realm_id, add_token_role, trust_email, first_broker_login_flow_id, post_broker_login_flow_id, provider_display_name, link_only) FROM stdin;
\.


--
-- Data for Name: identity_provider_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_config (identity_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: identity_provider_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.identity_provider_mapper (id, name, idp_alias, idp_mapper_name, realm_id) FROM stdin;
\.


--
-- Data for Name: idp_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.idp_mapper_config (idp_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: keycloak_group; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_group (id, name, parent_group, realm_id) FROM stdin;
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
47014777-78ce-4a87-a671-80d33bdcdb55	master	f	${role_default-roles}	default-roles-master	master	\N	\N
313f957d-ffac-48f8-ba97-ac8de16cb459	master	f	${role_admin}	admin	master	\N	\N
b896b09e-ae51-4785-9b42-9969de2b141e	master	f	${role_create-realm}	create-realm	master	\N	\N
2674fe03-5995-4d34-bbf1-012c2893b7eb	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_create-client}	create-client	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
d693714d-bef1-45f7-9219-96c4dbf4103b	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_view-realm}	view-realm	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
918823f3-524e-475e-8f95-81a5386c38a1	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_view-users}	view-users	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
66669bac-8579-4655-aacc-1893bc201a1b	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_view-clients}	view-clients	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
f063487a-bce4-4781-be77-2843637e6d72	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_view-events}	view-events	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
200d3f73-539f-4625-b4ee-f3703062f4fc	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_view-identity-providers}	view-identity-providers	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
617cec3d-053f-4438-a8b6-c7a733f8ec60	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_view-authorization}	view-authorization	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
9a60f451-a17a-4c04-b5db-c2a3682725e7	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_manage-realm}	manage-realm	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
41d7ec21-c3bb-45f8-ade8-8d2a233581f8	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_manage-users}	manage-users	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
5f443faa-1337-4a51-aa7e-6db98d350b68	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_manage-clients}	manage-clients	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
8a60b6d8-a231-4fe1-8ce9-2b5eceb8ce24	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_manage-events}	manage-events	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
3f99b2a1-1498-4621-8a57-efbcc3777eaf	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_manage-identity-providers}	manage-identity-providers	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
ed6738f0-bffa-4823-9ba0-e9f671026d1c	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_manage-authorization}	manage-authorization	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
c09d6176-f4ac-4e8d-a3a9-83c6549c4337	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_query-users}	query-users	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
e7e17f92-7fbc-4319-be25-0b67190a560d	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_query-clients}	query-clients	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
4189f2b7-68b0-4fa7-81e5-48535a2bfa86	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_query-realms}	query-realms	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
637c4cc2-9e2a-44a9-ac25-53818096b8cd	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_query-groups}	query-groups	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
b0296cc4-c94b-4bfd-a212-4a46e23a71d9	7accf29a-4352-4ea5-a369-cf6d954350e8	t	${role_view-profile}	view-profile	master	7accf29a-4352-4ea5-a369-cf6d954350e8	\N
13660469-ffd3-421e-94bd-095b4918e159	7accf29a-4352-4ea5-a369-cf6d954350e8	t	${role_manage-account}	manage-account	master	7accf29a-4352-4ea5-a369-cf6d954350e8	\N
c4334b45-6881-48b4-bf2d-7f514ab8fcc3	7accf29a-4352-4ea5-a369-cf6d954350e8	t	${role_manage-account-links}	manage-account-links	master	7accf29a-4352-4ea5-a369-cf6d954350e8	\N
c9ad13e1-f14a-4881-a638-422efe7b5cb8	7accf29a-4352-4ea5-a369-cf6d954350e8	t	${role_view-applications}	view-applications	master	7accf29a-4352-4ea5-a369-cf6d954350e8	\N
089a0a23-a2df-4af3-b941-c8b71c112708	7accf29a-4352-4ea5-a369-cf6d954350e8	t	${role_view-consent}	view-consent	master	7accf29a-4352-4ea5-a369-cf6d954350e8	\N
f60c1bdd-43d1-4cf6-bf08-a77789347479	7accf29a-4352-4ea5-a369-cf6d954350e8	t	${role_manage-consent}	manage-consent	master	7accf29a-4352-4ea5-a369-cf6d954350e8	\N
cab5fc08-7a81-47fc-be3c-648b867703d1	7accf29a-4352-4ea5-a369-cf6d954350e8	t	${role_delete-account}	delete-account	master	7accf29a-4352-4ea5-a369-cf6d954350e8	\N
2d4cedd5-32d8-49bc-bf11-b8433235521c	0a6cdb56-c2ce-47f1-9d02-8af6b881adce	t	${role_read-token}	read-token	master	0a6cdb56-c2ce-47f1-9d02-8af6b881adce	\N
e95cfbf2-f3d6-4f80-9f56-920232f7b997	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	t	${role_impersonation}	impersonation	master	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	\N
04a5152d-4371-4552-995f-08944adfdd4b	master	f	${role_offline-access}	offline_access	master	\N	\N
b81c74f6-c5e7-44f7-b294-9baf1d77d599	master	f	${role_uma_authorization}	uma_authorization	master	\N	\N
3792b25a-3b02-453a-b945-aae2b442e499	fiware-server	f	${role_default-roles}	default-roles-fiware-server	fiware-server	\N	\N
8d69b447-3cca-4a5b-8e37-195146726fed	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_create-client}	create-client	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
e0439b99-2983-4ebe-89fb-bfc501764153	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_view-realm}	view-realm	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
b827ae20-1ebc-4fdc-9c3c-2f66fafea8fa	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_view-users}	view-users	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
809f9379-6790-4a3e-91c4-93547549ce67	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_view-clients}	view-clients	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
233c1f8b-2e7a-4892-976f-237fa4815b85	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_view-events}	view-events	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
9f3f59ed-018a-4d31-9c03-d55f11290207	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_view-identity-providers}	view-identity-providers	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
0715988c-1926-487d-9cb7-e405f1d38eb6	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_view-authorization}	view-authorization	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
ac213552-7321-4962-8050-24e5b19827bf	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_manage-realm}	manage-realm	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
24da3e46-d54c-4d24-ba40-8fc36e2bf28a	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_manage-users}	manage-users	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
05a18bed-4c98-4bca-be9f-58319fba3623	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_manage-clients}	manage-clients	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
6bf767fb-13df-4555-a30b-f84606fefd13	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_manage-events}	manage-events	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
64f1a90d-68e3-4ca5-b41d-cbfdfdbed3ba	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_manage-identity-providers}	manage-identity-providers	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
5c3e2f9f-c49e-4a75-88aa-e8c33f2643f4	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_manage-authorization}	manage-authorization	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
f059b5fb-7ea5-41cd-995c-25abd0328ca6	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_query-users}	query-users	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
71fdd6db-0393-4ef7-af9c-f5fe6b8b3af8	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_query-clients}	query-clients	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
02839e02-4727-46d9-8f2d-ee633c038682	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_query-realms}	query-realms	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
a45cce50-5147-43aa-98df-d8682836b332	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_query-groups}	query-groups	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
6045c4d8-4547-4900-aa18-3492e349cd8e	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_realm-admin}	realm-admin	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
310936b2-ffd5-4371-8575-788c329d85fe	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_create-client}	create-client	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
282d1363-bfe5-4e61-9afe-9094f81e77cb	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_view-realm}	view-realm	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
fdc9a5e6-1a48-4a04-910c-23a36c9f7577	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_view-users}	view-users	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
46a517f5-0f5e-44c7-a7bd-631444fca1cc	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_view-clients}	view-clients	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
af62d230-09dc-49f3-9437-b05381c74943	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_view-events}	view-events	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
b2025ecd-96f5-4e89-a16e-3e7014fc8af5	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_view-identity-providers}	view-identity-providers	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
fd569380-5f62-4aad-b3b0-dcac194724af	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_view-authorization}	view-authorization	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
08c40037-5b75-4706-8075-ee4589026612	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_manage-realm}	manage-realm	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
892ed299-a1c8-454f-8b30-619f77e40d53	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_manage-users}	manage-users	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
3607c3c9-3410-4ba7-97af-b564b4aa84a8	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_manage-clients}	manage-clients	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
a37e722a-594a-47b5-8730-82e9180bac1b	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_manage-events}	manage-events	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
8fa9dbc4-8029-4769-9a7b-a52d632fc72d	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_manage-identity-providers}	manage-identity-providers	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
443c1e21-1fdf-48f4-a207-358f0f0e127f	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_manage-authorization}	manage-authorization	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
bef11c06-7013-41db-a865-c1347d5dbedd	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_query-users}	query-users	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
f04b5a2b-82a7-4fc8-94b5-bef46ad0d404	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_query-clients}	query-clients	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
bf77732f-8adc-45ca-b535-aca36239c6fb	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_query-realms}	query-realms	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
3048b858-737f-40fd-a6a0-9556120bcc73	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_query-groups}	query-groups	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
657a5074-1581-4e93-88bc-603e0728acfe	9250b599-4750-4dfb-86b4-5c5444d14c5d	t	${role_view-profile}	view-profile	fiware-server	9250b599-4750-4dfb-86b4-5c5444d14c5d	\N
26037ebe-6916-420e-b7df-e6434792c854	9250b599-4750-4dfb-86b4-5c5444d14c5d	t	${role_manage-account}	manage-account	fiware-server	9250b599-4750-4dfb-86b4-5c5444d14c5d	\N
e855797c-b27c-4a8a-804e-01ed8c096dc4	9250b599-4750-4dfb-86b4-5c5444d14c5d	t	${role_manage-account-links}	manage-account-links	fiware-server	9250b599-4750-4dfb-86b4-5c5444d14c5d	\N
cf084d2e-d957-430c-a24d-3e6431b59d0e	9250b599-4750-4dfb-86b4-5c5444d14c5d	t	${role_view-applications}	view-applications	fiware-server	9250b599-4750-4dfb-86b4-5c5444d14c5d	\N
fc65eb03-6f14-46f1-9b0c-f5c68d9368f7	9250b599-4750-4dfb-86b4-5c5444d14c5d	t	${role_view-consent}	view-consent	fiware-server	9250b599-4750-4dfb-86b4-5c5444d14c5d	\N
cbb4ae20-4c00-4063-a6a7-3cf9a115c97f	9250b599-4750-4dfb-86b4-5c5444d14c5d	t	${role_manage-consent}	manage-consent	fiware-server	9250b599-4750-4dfb-86b4-5c5444d14c5d	\N
68f83b27-f9ac-4935-b04e-1be5861e0a92	9250b599-4750-4dfb-86b4-5c5444d14c5d	t	${role_delete-account}	delete-account	fiware-server	9250b599-4750-4dfb-86b4-5c5444d14c5d	\N
b2a3e561-b2d8-4bd1-ba52-360d9b2cc725	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	t	${role_impersonation}	impersonation	master	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	\N
19b530f9-103d-4ddf-978f-80ce62cda251	b1528b35-b944-4ba6-8c09-87fa07344b91	t	${role_impersonation}	impersonation	fiware-server	b1528b35-b944-4ba6-8c09-87fa07344b91	\N
49f7e07b-7012-410d-bcde-ce5d180b59e2	f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	t	${role_read-token}	read-token	fiware-server	f9b16bf5-43b2-47b0-903d-aba01dcc0d6d	\N
5e374f11-6256-42a8-ac67-32915eae0160	fiware-server	f	${role_offline-access}	offline_access	fiware-server	\N	\N
1830f4db-bbc8-43f6-80f7-6b7cf7ff69f0	fiware-server	f	${role_uma_authorization}	uma_authorization	fiware-server	\N	\N
14d30ac8-58ce-4cf0-b4e8-b10b6b9c122b	41d8bab9-aa4f-47dd-bd66-2e88672ea746	t	\N	uma_protection	fiware-server	41d8bab9-aa4f-47dd-bd66-2e88672ea746	\N
0ad6e7fd-0eb2-4ce8-9c78-f09a224a30f4	d9289482-a19d-4b09-bc90-57353057cd70	t	\N	uma_protection	fiware-server	d9289482-a19d-4b09-bc90-57353057cd70	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
ue6ye	16.1.1	1709304106
\.


--
-- Data for Name: offline_client_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_client_session (user_session_id, client_id, offline_flag, "timestamp", data, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: offline_user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.offline_user_session (user_session_id, user_id, realm_id, created_on, offline_flag, data, last_session_refresh) FROM stdin;
\.


--
-- Data for Name: policy_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.policy_config (policy_id, name, value) FROM stdin;
e9138225-bae6-460a-bcf7-9574919b4759	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
13d580c0-d4d9-4f09-9a39-f28dd749f38e	defaultResourceType	urn:orion-pep:resources:default
33fce0c5-b2e7-4fa2-979d-450d651b9f9a	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
0a1767dd-be00-4b20-bee5-236ec01322d1	defaultResourceType	urn:mintaka-pep:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
c2782f58-d76c-4074-a388-a2b8e4badc85	audience resolve	openid-connect	oidc-audience-resolve-mapper	68665072-ccfc-4309-b823-0a88de3065c2	\N
682fb193-34a1-4cd9-bd09-15d7968e513a	locale	openid-connect	oidc-usermodel-attribute-mapper	f6abaf9f-3dde-4919-b983-99eb42003057	\N
cf83bf3f-9208-403b-824e-d51253e9cd52	role list	saml	saml-role-list-mapper	\N	dee23010-617b-40a0-9743-5fda01dcbadd
4484a0a9-cc1b-475a-8c3c-ea9e9847c8da	full name	openid-connect	oidc-full-name-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
87095a7b-5139-4392-b3bd-71be9f7f41f8	family name	openid-connect	oidc-usermodel-property-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
900b6fff-9612-44f2-aeaa-ef855b0668dc	given name	openid-connect	oidc-usermodel-property-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
e5d5f915-553a-49ed-a15a-2ef49e769713	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
f47ee5cc-76e7-4ebd-ae44-0f971a0b6235	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
a2da3835-3d16-4cb8-a496-5e05bee8dd8a	username	openid-connect	oidc-usermodel-property-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
464e623b-1643-4bc7-9e2f-7569434305ea	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
841f8f4e-7974-4c05-95da-b9c8c39bce16	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
c11998b5-d2f4-4ae7-9438-2990301221d5	website	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
8ecb18e8-bd64-40c0-bcd9-b1247ce9f01e	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
3d48ddb0-c756-421a-81cf-eb191a5176d6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
d3150060-b38d-4f35-8354-76dae8d3f267	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
c503a55b-5d0b-487e-a6de-b85e06e93cc7	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
458322ec-b9a0-4cec-b0fd-bdce417d572b	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	318018c7-70c5-4834-b411-9e0559254c2f
0c699e1f-320d-45d2-9e61-33a6c8cd30b0	email	openid-connect	oidc-usermodel-property-mapper	\N	37388d3d-ef31-423a-b756-44f44847c887
5b1c740f-64ae-48f1-8244-348604d8d755	email verified	openid-connect	oidc-usermodel-property-mapper	\N	37388d3d-ef31-423a-b756-44f44847c887
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	address	openid-connect	oidc-address-mapper	\N	19132f67-6d25-40ed-9f7e-34bb7429cc02
09218c05-fcee-4b2b-80b9-256e60e9be68	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	466af8b1-6fc4-41b8-8a39-d3e09a22422d
0d8efec7-53e2-4f69-ab24-ade4a0d2e953	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	466af8b1-6fc4-41b8-8a39-d3e09a22422d
9b0f119e-999f-425e-bbc4-14c44d82ea44	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	3f0cbce4-adf7-49c6-9dba-51434b061b37
5b2a9613-952b-4d79-98d7-a3fa9ebeb874	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	3f0cbce4-adf7-49c6-9dba-51434b061b37
b2ed5258-3eaa-4536-96d7-e3cfe2dc4515	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	3f0cbce4-adf7-49c6-9dba-51434b061b37
a9b3bc2c-c8be-4a65-9ef2-0a6921dea8a5	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	423ce762-00b9-4cc6-97db-8eaea7df4f31
46264737-0d04-4079-87cd-c136b2d1537e	upn	openid-connect	oidc-usermodel-property-mapper	\N	f986ae52-8267-47dc-bce7-822238ae6dcf
6c3fa90b-7f60-431e-af8e-9a769b5aa507	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	f986ae52-8267-47dc-bce7-822238ae6dcf
00e41400-3430-4fde-81f7-d7a1bc7ec5d9	audience resolve	openid-connect	oidc-audience-resolve-mapper	56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	\N
1f547dd9-6870-4aea-90db-b621ad14e837	role list	saml	saml-role-list-mapper	\N	57442969-1294-4c55-a9e8-04ff009d4fcc
6c3e8458-966c-4d30-b80c-b5d23d40f648	full name	openid-connect	oidc-full-name-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
71a2378b-3a19-4d6b-8f60-512cae5747d2	family name	openid-connect	oidc-usermodel-property-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
454109be-9206-4c32-ae00-e053a4d7cdbe	given name	openid-connect	oidc-usermodel-property-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
a3e50cc5-45f7-478c-a13c-bed3e29d268b	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
3a323ebd-61c3-4461-9601-89ecbdac62a6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
d7f412f9-ab8c-446d-ad78-7c9388cfe062	username	openid-connect	oidc-usermodel-property-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
ce5a9026-46aa-4ac8-86c8-07a7fefe60da	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
9c0432a4-e3ff-427b-81ba-447ab17c45c7	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
03ff11da-89eb-47a0-ac73-508acd6e1a54	website	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
aebe9e0d-0827-4fb0-93f7-6f4286e7835c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
da30c276-e023-4b48-854e-edeb41e9c7d6	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
9ebcdfae-9fe4-45b1-be05-78e5480f2bd1	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
b33b862e-8aa3-49c7-b22f-c4b4c5112106	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
2710f622-2829-4f63-948b-c0b3c8dffccf	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	a7b1e404-9ce0-4346-9bf3-15358ddb9043
de7d8657-6bc4-45ed-a2cd-bd30f7ae3ef5	email	openid-connect	oidc-usermodel-property-mapper	\N	6522fd11-9454-4783-99d6-5b73e00d6518
10a1aa44-483d-4d16-a1ba-c1a0e2b94e47	email verified	openid-connect	oidc-usermodel-property-mapper	\N	6522fd11-9454-4783-99d6-5b73e00d6518
82872248-f82c-4c7a-851d-21b580a9d467	address	openid-connect	oidc-address-mapper	\N	250e2dbc-9387-4209-86fe-72f0b7ef3cb2
ee4ac124-4c87-4f8a-9703-d553ea692bb0	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	5e57ef27-60af-4619-9acf-9dfadc1066db
9d7ec912-28e0-4c1c-9eb4-531e7b84456f	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	5e57ef27-60af-4619-9acf-9dfadc1066db
e9d09ae0-6aa0-42ba-97fa-ae6da6efd358	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	1ff66dcc-a619-4f01-b2f5-1d0a433f2627
b8cf0d21-f045-44c3-a40b-3ff57b879106	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	1ff66dcc-a619-4f01-b2f5-1d0a433f2627
eddad196-afed-47bb-9f21-ed42165e4dcf	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	1ff66dcc-a619-4f01-b2f5-1d0a433f2627
7ff7bd62-fa06-4c84-b804-08b93b6b603a	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	38e6b97e-0029-43fe-aa4c-1c9982cfae0d
cb22a8ee-a8b7-4a22-bf61-9e132ca0a062	upn	openid-connect	oidc-usermodel-property-mapper	\N	2f59b7cc-fb99-4905-90b1-404fc4ad935d
12904024-e37f-4d3d-bf62-59d9e370e6be	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	2f59b7cc-fb99-4905-90b1-404fc4ad935d
a3d34e0d-0746-4fc0-af4f-d40920f3d70c	locale	openid-connect	oidc-usermodel-attribute-mapper	6d1d6ce9-0565-4974-a42c-5dbd00cc159e	\N
357f72a9-f0a1-4cc8-b985-a17eaad03b45	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	41d8bab9-aa4f-47dd-bd66-2e88672ea746	\N
3d97bad8-d867-4a44-86cd-76bfd0b60ae6	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	41d8bab9-aa4f-47dd-bd66-2e88672ea746	\N
0b2a0180-0c13-4559-ba48-57a8145e76b0	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	41d8bab9-aa4f-47dd-bd66-2e88672ea746	\N
f516735f-9f4d-4702-a5d6-4576293a3772	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	d9289482-a19d-4b09-bc90-57353057cd70	\N
7bfd05aa-272b-4477-9253-ad6f831d3834	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	d9289482-a19d-4b09-bc90-57353057cd70	\N
317be56a-40d2-4c0f-a5c3-d0c00568c1a2	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	d9289482-a19d-4b09-bc90-57353057cd70	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
682fb193-34a1-4cd9-bd09-15d7968e513a	true	userinfo.token.claim
682fb193-34a1-4cd9-bd09-15d7968e513a	locale	user.attribute
682fb193-34a1-4cd9-bd09-15d7968e513a	true	id.token.claim
682fb193-34a1-4cd9-bd09-15d7968e513a	true	access.token.claim
682fb193-34a1-4cd9-bd09-15d7968e513a	locale	claim.name
682fb193-34a1-4cd9-bd09-15d7968e513a	String	jsonType.label
cf83bf3f-9208-403b-824e-d51253e9cd52	false	single
cf83bf3f-9208-403b-824e-d51253e9cd52	Basic	attribute.nameformat
cf83bf3f-9208-403b-824e-d51253e9cd52	Role	attribute.name
4484a0a9-cc1b-475a-8c3c-ea9e9847c8da	true	userinfo.token.claim
4484a0a9-cc1b-475a-8c3c-ea9e9847c8da	true	id.token.claim
4484a0a9-cc1b-475a-8c3c-ea9e9847c8da	true	access.token.claim
87095a7b-5139-4392-b3bd-71be9f7f41f8	true	userinfo.token.claim
87095a7b-5139-4392-b3bd-71be9f7f41f8	lastName	user.attribute
87095a7b-5139-4392-b3bd-71be9f7f41f8	true	id.token.claim
87095a7b-5139-4392-b3bd-71be9f7f41f8	true	access.token.claim
87095a7b-5139-4392-b3bd-71be9f7f41f8	family_name	claim.name
87095a7b-5139-4392-b3bd-71be9f7f41f8	String	jsonType.label
900b6fff-9612-44f2-aeaa-ef855b0668dc	true	userinfo.token.claim
900b6fff-9612-44f2-aeaa-ef855b0668dc	firstName	user.attribute
900b6fff-9612-44f2-aeaa-ef855b0668dc	true	id.token.claim
900b6fff-9612-44f2-aeaa-ef855b0668dc	true	access.token.claim
900b6fff-9612-44f2-aeaa-ef855b0668dc	given_name	claim.name
900b6fff-9612-44f2-aeaa-ef855b0668dc	String	jsonType.label
e5d5f915-553a-49ed-a15a-2ef49e769713	true	userinfo.token.claim
e5d5f915-553a-49ed-a15a-2ef49e769713	middleName	user.attribute
e5d5f915-553a-49ed-a15a-2ef49e769713	true	id.token.claim
e5d5f915-553a-49ed-a15a-2ef49e769713	true	access.token.claim
e5d5f915-553a-49ed-a15a-2ef49e769713	middle_name	claim.name
e5d5f915-553a-49ed-a15a-2ef49e769713	String	jsonType.label
f47ee5cc-76e7-4ebd-ae44-0f971a0b6235	true	userinfo.token.claim
f47ee5cc-76e7-4ebd-ae44-0f971a0b6235	nickname	user.attribute
f47ee5cc-76e7-4ebd-ae44-0f971a0b6235	true	id.token.claim
f47ee5cc-76e7-4ebd-ae44-0f971a0b6235	true	access.token.claim
f47ee5cc-76e7-4ebd-ae44-0f971a0b6235	nickname	claim.name
f47ee5cc-76e7-4ebd-ae44-0f971a0b6235	String	jsonType.label
a2da3835-3d16-4cb8-a496-5e05bee8dd8a	true	userinfo.token.claim
a2da3835-3d16-4cb8-a496-5e05bee8dd8a	username	user.attribute
a2da3835-3d16-4cb8-a496-5e05bee8dd8a	true	id.token.claim
a2da3835-3d16-4cb8-a496-5e05bee8dd8a	true	access.token.claim
a2da3835-3d16-4cb8-a496-5e05bee8dd8a	preferred_username	claim.name
a2da3835-3d16-4cb8-a496-5e05bee8dd8a	String	jsonType.label
464e623b-1643-4bc7-9e2f-7569434305ea	true	userinfo.token.claim
464e623b-1643-4bc7-9e2f-7569434305ea	profile	user.attribute
464e623b-1643-4bc7-9e2f-7569434305ea	true	id.token.claim
464e623b-1643-4bc7-9e2f-7569434305ea	true	access.token.claim
464e623b-1643-4bc7-9e2f-7569434305ea	profile	claim.name
464e623b-1643-4bc7-9e2f-7569434305ea	String	jsonType.label
841f8f4e-7974-4c05-95da-b9c8c39bce16	true	userinfo.token.claim
841f8f4e-7974-4c05-95da-b9c8c39bce16	picture	user.attribute
841f8f4e-7974-4c05-95da-b9c8c39bce16	true	id.token.claim
841f8f4e-7974-4c05-95da-b9c8c39bce16	true	access.token.claim
841f8f4e-7974-4c05-95da-b9c8c39bce16	picture	claim.name
841f8f4e-7974-4c05-95da-b9c8c39bce16	String	jsonType.label
c11998b5-d2f4-4ae7-9438-2990301221d5	true	userinfo.token.claim
c11998b5-d2f4-4ae7-9438-2990301221d5	website	user.attribute
c11998b5-d2f4-4ae7-9438-2990301221d5	true	id.token.claim
c11998b5-d2f4-4ae7-9438-2990301221d5	true	access.token.claim
c11998b5-d2f4-4ae7-9438-2990301221d5	website	claim.name
c11998b5-d2f4-4ae7-9438-2990301221d5	String	jsonType.label
8ecb18e8-bd64-40c0-bcd9-b1247ce9f01e	true	userinfo.token.claim
8ecb18e8-bd64-40c0-bcd9-b1247ce9f01e	gender	user.attribute
8ecb18e8-bd64-40c0-bcd9-b1247ce9f01e	true	id.token.claim
8ecb18e8-bd64-40c0-bcd9-b1247ce9f01e	true	access.token.claim
8ecb18e8-bd64-40c0-bcd9-b1247ce9f01e	gender	claim.name
8ecb18e8-bd64-40c0-bcd9-b1247ce9f01e	String	jsonType.label
3d48ddb0-c756-421a-81cf-eb191a5176d6	true	userinfo.token.claim
3d48ddb0-c756-421a-81cf-eb191a5176d6	birthdate	user.attribute
3d48ddb0-c756-421a-81cf-eb191a5176d6	true	id.token.claim
3d48ddb0-c756-421a-81cf-eb191a5176d6	true	access.token.claim
3d48ddb0-c756-421a-81cf-eb191a5176d6	birthdate	claim.name
3d48ddb0-c756-421a-81cf-eb191a5176d6	String	jsonType.label
d3150060-b38d-4f35-8354-76dae8d3f267	true	userinfo.token.claim
d3150060-b38d-4f35-8354-76dae8d3f267	zoneinfo	user.attribute
d3150060-b38d-4f35-8354-76dae8d3f267	true	id.token.claim
d3150060-b38d-4f35-8354-76dae8d3f267	true	access.token.claim
d3150060-b38d-4f35-8354-76dae8d3f267	zoneinfo	claim.name
d3150060-b38d-4f35-8354-76dae8d3f267	String	jsonType.label
c503a55b-5d0b-487e-a6de-b85e06e93cc7	true	userinfo.token.claim
c503a55b-5d0b-487e-a6de-b85e06e93cc7	locale	user.attribute
c503a55b-5d0b-487e-a6de-b85e06e93cc7	true	id.token.claim
c503a55b-5d0b-487e-a6de-b85e06e93cc7	true	access.token.claim
c503a55b-5d0b-487e-a6de-b85e06e93cc7	locale	claim.name
c503a55b-5d0b-487e-a6de-b85e06e93cc7	String	jsonType.label
458322ec-b9a0-4cec-b0fd-bdce417d572b	true	userinfo.token.claim
458322ec-b9a0-4cec-b0fd-bdce417d572b	updatedAt	user.attribute
458322ec-b9a0-4cec-b0fd-bdce417d572b	true	id.token.claim
458322ec-b9a0-4cec-b0fd-bdce417d572b	true	access.token.claim
458322ec-b9a0-4cec-b0fd-bdce417d572b	updated_at	claim.name
458322ec-b9a0-4cec-b0fd-bdce417d572b	String	jsonType.label
0c699e1f-320d-45d2-9e61-33a6c8cd30b0	true	userinfo.token.claim
0c699e1f-320d-45d2-9e61-33a6c8cd30b0	email	user.attribute
0c699e1f-320d-45d2-9e61-33a6c8cd30b0	true	id.token.claim
0c699e1f-320d-45d2-9e61-33a6c8cd30b0	true	access.token.claim
0c699e1f-320d-45d2-9e61-33a6c8cd30b0	email	claim.name
0c699e1f-320d-45d2-9e61-33a6c8cd30b0	String	jsonType.label
5b1c740f-64ae-48f1-8244-348604d8d755	true	userinfo.token.claim
5b1c740f-64ae-48f1-8244-348604d8d755	emailVerified	user.attribute
5b1c740f-64ae-48f1-8244-348604d8d755	true	id.token.claim
5b1c740f-64ae-48f1-8244-348604d8d755	true	access.token.claim
5b1c740f-64ae-48f1-8244-348604d8d755	email_verified	claim.name
5b1c740f-64ae-48f1-8244-348604d8d755	boolean	jsonType.label
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	formatted	user.attribute.formatted
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	country	user.attribute.country
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	postal_code	user.attribute.postal_code
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	true	userinfo.token.claim
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	street	user.attribute.street
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	true	id.token.claim
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	region	user.attribute.region
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	true	access.token.claim
f33b4fd5-0d59-49bc-9156-e7a35e596cf0	locality	user.attribute.locality
09218c05-fcee-4b2b-80b9-256e60e9be68	true	userinfo.token.claim
09218c05-fcee-4b2b-80b9-256e60e9be68	phoneNumber	user.attribute
09218c05-fcee-4b2b-80b9-256e60e9be68	true	id.token.claim
09218c05-fcee-4b2b-80b9-256e60e9be68	true	access.token.claim
09218c05-fcee-4b2b-80b9-256e60e9be68	phone_number	claim.name
09218c05-fcee-4b2b-80b9-256e60e9be68	String	jsonType.label
0d8efec7-53e2-4f69-ab24-ade4a0d2e953	true	userinfo.token.claim
0d8efec7-53e2-4f69-ab24-ade4a0d2e953	phoneNumberVerified	user.attribute
0d8efec7-53e2-4f69-ab24-ade4a0d2e953	true	id.token.claim
0d8efec7-53e2-4f69-ab24-ade4a0d2e953	true	access.token.claim
0d8efec7-53e2-4f69-ab24-ade4a0d2e953	phone_number_verified	claim.name
0d8efec7-53e2-4f69-ab24-ade4a0d2e953	boolean	jsonType.label
9b0f119e-999f-425e-bbc4-14c44d82ea44	true	multivalued
9b0f119e-999f-425e-bbc4-14c44d82ea44	foo	user.attribute
9b0f119e-999f-425e-bbc4-14c44d82ea44	true	access.token.claim
9b0f119e-999f-425e-bbc4-14c44d82ea44	realm_access.roles	claim.name
9b0f119e-999f-425e-bbc4-14c44d82ea44	String	jsonType.label
5b2a9613-952b-4d79-98d7-a3fa9ebeb874	true	multivalued
5b2a9613-952b-4d79-98d7-a3fa9ebeb874	foo	user.attribute
5b2a9613-952b-4d79-98d7-a3fa9ebeb874	true	access.token.claim
5b2a9613-952b-4d79-98d7-a3fa9ebeb874	resource_access.${client_id}.roles	claim.name
5b2a9613-952b-4d79-98d7-a3fa9ebeb874	String	jsonType.label
46264737-0d04-4079-87cd-c136b2d1537e	true	userinfo.token.claim
46264737-0d04-4079-87cd-c136b2d1537e	username	user.attribute
46264737-0d04-4079-87cd-c136b2d1537e	true	id.token.claim
46264737-0d04-4079-87cd-c136b2d1537e	true	access.token.claim
46264737-0d04-4079-87cd-c136b2d1537e	upn	claim.name
46264737-0d04-4079-87cd-c136b2d1537e	String	jsonType.label
6c3fa90b-7f60-431e-af8e-9a769b5aa507	true	multivalued
6c3fa90b-7f60-431e-af8e-9a769b5aa507	foo	user.attribute
6c3fa90b-7f60-431e-af8e-9a769b5aa507	true	id.token.claim
6c3fa90b-7f60-431e-af8e-9a769b5aa507	true	access.token.claim
6c3fa90b-7f60-431e-af8e-9a769b5aa507	groups	claim.name
6c3fa90b-7f60-431e-af8e-9a769b5aa507	String	jsonType.label
1f547dd9-6870-4aea-90db-b621ad14e837	false	single
1f547dd9-6870-4aea-90db-b621ad14e837	Basic	attribute.nameformat
1f547dd9-6870-4aea-90db-b621ad14e837	Role	attribute.name
6c3e8458-966c-4d30-b80c-b5d23d40f648	true	userinfo.token.claim
6c3e8458-966c-4d30-b80c-b5d23d40f648	true	id.token.claim
6c3e8458-966c-4d30-b80c-b5d23d40f648	true	access.token.claim
71a2378b-3a19-4d6b-8f60-512cae5747d2	true	userinfo.token.claim
71a2378b-3a19-4d6b-8f60-512cae5747d2	lastName	user.attribute
71a2378b-3a19-4d6b-8f60-512cae5747d2	true	id.token.claim
71a2378b-3a19-4d6b-8f60-512cae5747d2	true	access.token.claim
71a2378b-3a19-4d6b-8f60-512cae5747d2	family_name	claim.name
71a2378b-3a19-4d6b-8f60-512cae5747d2	String	jsonType.label
454109be-9206-4c32-ae00-e053a4d7cdbe	true	userinfo.token.claim
454109be-9206-4c32-ae00-e053a4d7cdbe	firstName	user.attribute
454109be-9206-4c32-ae00-e053a4d7cdbe	true	id.token.claim
454109be-9206-4c32-ae00-e053a4d7cdbe	true	access.token.claim
454109be-9206-4c32-ae00-e053a4d7cdbe	given_name	claim.name
454109be-9206-4c32-ae00-e053a4d7cdbe	String	jsonType.label
a3e50cc5-45f7-478c-a13c-bed3e29d268b	true	userinfo.token.claim
a3e50cc5-45f7-478c-a13c-bed3e29d268b	middleName	user.attribute
a3e50cc5-45f7-478c-a13c-bed3e29d268b	true	id.token.claim
a3e50cc5-45f7-478c-a13c-bed3e29d268b	true	access.token.claim
a3e50cc5-45f7-478c-a13c-bed3e29d268b	middle_name	claim.name
a3e50cc5-45f7-478c-a13c-bed3e29d268b	String	jsonType.label
3a323ebd-61c3-4461-9601-89ecbdac62a6	true	userinfo.token.claim
3a323ebd-61c3-4461-9601-89ecbdac62a6	nickname	user.attribute
3a323ebd-61c3-4461-9601-89ecbdac62a6	true	id.token.claim
3a323ebd-61c3-4461-9601-89ecbdac62a6	true	access.token.claim
3a323ebd-61c3-4461-9601-89ecbdac62a6	nickname	claim.name
3a323ebd-61c3-4461-9601-89ecbdac62a6	String	jsonType.label
d7f412f9-ab8c-446d-ad78-7c9388cfe062	true	userinfo.token.claim
d7f412f9-ab8c-446d-ad78-7c9388cfe062	username	user.attribute
d7f412f9-ab8c-446d-ad78-7c9388cfe062	true	id.token.claim
d7f412f9-ab8c-446d-ad78-7c9388cfe062	true	access.token.claim
d7f412f9-ab8c-446d-ad78-7c9388cfe062	preferred_username	claim.name
d7f412f9-ab8c-446d-ad78-7c9388cfe062	String	jsonType.label
ce5a9026-46aa-4ac8-86c8-07a7fefe60da	true	userinfo.token.claim
ce5a9026-46aa-4ac8-86c8-07a7fefe60da	profile	user.attribute
ce5a9026-46aa-4ac8-86c8-07a7fefe60da	true	id.token.claim
ce5a9026-46aa-4ac8-86c8-07a7fefe60da	true	access.token.claim
ce5a9026-46aa-4ac8-86c8-07a7fefe60da	profile	claim.name
ce5a9026-46aa-4ac8-86c8-07a7fefe60da	String	jsonType.label
9c0432a4-e3ff-427b-81ba-447ab17c45c7	true	userinfo.token.claim
9c0432a4-e3ff-427b-81ba-447ab17c45c7	picture	user.attribute
9c0432a4-e3ff-427b-81ba-447ab17c45c7	true	id.token.claim
9c0432a4-e3ff-427b-81ba-447ab17c45c7	true	access.token.claim
9c0432a4-e3ff-427b-81ba-447ab17c45c7	picture	claim.name
9c0432a4-e3ff-427b-81ba-447ab17c45c7	String	jsonType.label
03ff11da-89eb-47a0-ac73-508acd6e1a54	true	userinfo.token.claim
03ff11da-89eb-47a0-ac73-508acd6e1a54	website	user.attribute
03ff11da-89eb-47a0-ac73-508acd6e1a54	true	id.token.claim
03ff11da-89eb-47a0-ac73-508acd6e1a54	true	access.token.claim
03ff11da-89eb-47a0-ac73-508acd6e1a54	website	claim.name
03ff11da-89eb-47a0-ac73-508acd6e1a54	String	jsonType.label
aebe9e0d-0827-4fb0-93f7-6f4286e7835c	true	userinfo.token.claim
aebe9e0d-0827-4fb0-93f7-6f4286e7835c	gender	user.attribute
aebe9e0d-0827-4fb0-93f7-6f4286e7835c	true	id.token.claim
aebe9e0d-0827-4fb0-93f7-6f4286e7835c	true	access.token.claim
aebe9e0d-0827-4fb0-93f7-6f4286e7835c	gender	claim.name
aebe9e0d-0827-4fb0-93f7-6f4286e7835c	String	jsonType.label
da30c276-e023-4b48-854e-edeb41e9c7d6	true	userinfo.token.claim
da30c276-e023-4b48-854e-edeb41e9c7d6	birthdate	user.attribute
da30c276-e023-4b48-854e-edeb41e9c7d6	true	id.token.claim
da30c276-e023-4b48-854e-edeb41e9c7d6	true	access.token.claim
da30c276-e023-4b48-854e-edeb41e9c7d6	birthdate	claim.name
da30c276-e023-4b48-854e-edeb41e9c7d6	String	jsonType.label
9ebcdfae-9fe4-45b1-be05-78e5480f2bd1	true	userinfo.token.claim
9ebcdfae-9fe4-45b1-be05-78e5480f2bd1	zoneinfo	user.attribute
9ebcdfae-9fe4-45b1-be05-78e5480f2bd1	true	id.token.claim
9ebcdfae-9fe4-45b1-be05-78e5480f2bd1	true	access.token.claim
9ebcdfae-9fe4-45b1-be05-78e5480f2bd1	zoneinfo	claim.name
9ebcdfae-9fe4-45b1-be05-78e5480f2bd1	String	jsonType.label
b33b862e-8aa3-49c7-b22f-c4b4c5112106	true	userinfo.token.claim
b33b862e-8aa3-49c7-b22f-c4b4c5112106	locale	user.attribute
b33b862e-8aa3-49c7-b22f-c4b4c5112106	true	id.token.claim
b33b862e-8aa3-49c7-b22f-c4b4c5112106	true	access.token.claim
b33b862e-8aa3-49c7-b22f-c4b4c5112106	locale	claim.name
b33b862e-8aa3-49c7-b22f-c4b4c5112106	String	jsonType.label
2710f622-2829-4f63-948b-c0b3c8dffccf	true	userinfo.token.claim
2710f622-2829-4f63-948b-c0b3c8dffccf	updatedAt	user.attribute
2710f622-2829-4f63-948b-c0b3c8dffccf	true	id.token.claim
2710f622-2829-4f63-948b-c0b3c8dffccf	true	access.token.claim
2710f622-2829-4f63-948b-c0b3c8dffccf	updated_at	claim.name
2710f622-2829-4f63-948b-c0b3c8dffccf	String	jsonType.label
de7d8657-6bc4-45ed-a2cd-bd30f7ae3ef5	true	userinfo.token.claim
de7d8657-6bc4-45ed-a2cd-bd30f7ae3ef5	email	user.attribute
de7d8657-6bc4-45ed-a2cd-bd30f7ae3ef5	true	id.token.claim
de7d8657-6bc4-45ed-a2cd-bd30f7ae3ef5	true	access.token.claim
de7d8657-6bc4-45ed-a2cd-bd30f7ae3ef5	email	claim.name
de7d8657-6bc4-45ed-a2cd-bd30f7ae3ef5	String	jsonType.label
10a1aa44-483d-4d16-a1ba-c1a0e2b94e47	true	userinfo.token.claim
10a1aa44-483d-4d16-a1ba-c1a0e2b94e47	emailVerified	user.attribute
10a1aa44-483d-4d16-a1ba-c1a0e2b94e47	true	id.token.claim
10a1aa44-483d-4d16-a1ba-c1a0e2b94e47	true	access.token.claim
10a1aa44-483d-4d16-a1ba-c1a0e2b94e47	email_verified	claim.name
10a1aa44-483d-4d16-a1ba-c1a0e2b94e47	boolean	jsonType.label
82872248-f82c-4c7a-851d-21b580a9d467	formatted	user.attribute.formatted
82872248-f82c-4c7a-851d-21b580a9d467	country	user.attribute.country
82872248-f82c-4c7a-851d-21b580a9d467	postal_code	user.attribute.postal_code
82872248-f82c-4c7a-851d-21b580a9d467	true	userinfo.token.claim
82872248-f82c-4c7a-851d-21b580a9d467	street	user.attribute.street
82872248-f82c-4c7a-851d-21b580a9d467	true	id.token.claim
82872248-f82c-4c7a-851d-21b580a9d467	region	user.attribute.region
82872248-f82c-4c7a-851d-21b580a9d467	true	access.token.claim
82872248-f82c-4c7a-851d-21b580a9d467	locality	user.attribute.locality
ee4ac124-4c87-4f8a-9703-d553ea692bb0	true	userinfo.token.claim
ee4ac124-4c87-4f8a-9703-d553ea692bb0	phoneNumber	user.attribute
ee4ac124-4c87-4f8a-9703-d553ea692bb0	true	id.token.claim
ee4ac124-4c87-4f8a-9703-d553ea692bb0	true	access.token.claim
ee4ac124-4c87-4f8a-9703-d553ea692bb0	phone_number	claim.name
ee4ac124-4c87-4f8a-9703-d553ea692bb0	String	jsonType.label
9d7ec912-28e0-4c1c-9eb4-531e7b84456f	true	userinfo.token.claim
9d7ec912-28e0-4c1c-9eb4-531e7b84456f	phoneNumberVerified	user.attribute
9d7ec912-28e0-4c1c-9eb4-531e7b84456f	true	id.token.claim
9d7ec912-28e0-4c1c-9eb4-531e7b84456f	true	access.token.claim
9d7ec912-28e0-4c1c-9eb4-531e7b84456f	phone_number_verified	claim.name
9d7ec912-28e0-4c1c-9eb4-531e7b84456f	boolean	jsonType.label
e9d09ae0-6aa0-42ba-97fa-ae6da6efd358	true	multivalued
e9d09ae0-6aa0-42ba-97fa-ae6da6efd358	foo	user.attribute
e9d09ae0-6aa0-42ba-97fa-ae6da6efd358	true	access.token.claim
e9d09ae0-6aa0-42ba-97fa-ae6da6efd358	realm_access.roles	claim.name
e9d09ae0-6aa0-42ba-97fa-ae6da6efd358	String	jsonType.label
b8cf0d21-f045-44c3-a40b-3ff57b879106	true	multivalued
b8cf0d21-f045-44c3-a40b-3ff57b879106	foo	user.attribute
b8cf0d21-f045-44c3-a40b-3ff57b879106	true	access.token.claim
b8cf0d21-f045-44c3-a40b-3ff57b879106	resource_access.${client_id}.roles	claim.name
b8cf0d21-f045-44c3-a40b-3ff57b879106	String	jsonType.label
cb22a8ee-a8b7-4a22-bf61-9e132ca0a062	true	userinfo.token.claim
cb22a8ee-a8b7-4a22-bf61-9e132ca0a062	username	user.attribute
cb22a8ee-a8b7-4a22-bf61-9e132ca0a062	true	id.token.claim
cb22a8ee-a8b7-4a22-bf61-9e132ca0a062	true	access.token.claim
cb22a8ee-a8b7-4a22-bf61-9e132ca0a062	upn	claim.name
cb22a8ee-a8b7-4a22-bf61-9e132ca0a062	String	jsonType.label
12904024-e37f-4d3d-bf62-59d9e370e6be	true	multivalued
12904024-e37f-4d3d-bf62-59d9e370e6be	foo	user.attribute
12904024-e37f-4d3d-bf62-59d9e370e6be	true	id.token.claim
12904024-e37f-4d3d-bf62-59d9e370e6be	true	access.token.claim
12904024-e37f-4d3d-bf62-59d9e370e6be	groups	claim.name
12904024-e37f-4d3d-bf62-59d9e370e6be	String	jsonType.label
a3d34e0d-0746-4fc0-af4f-d40920f3d70c	true	userinfo.token.claim
a3d34e0d-0746-4fc0-af4f-d40920f3d70c	locale	user.attribute
a3d34e0d-0746-4fc0-af4f-d40920f3d70c	true	id.token.claim
a3d34e0d-0746-4fc0-af4f-d40920f3d70c	true	access.token.claim
a3d34e0d-0746-4fc0-af4f-d40920f3d70c	locale	claim.name
a3d34e0d-0746-4fc0-af4f-d40920f3d70c	String	jsonType.label
357f72a9-f0a1-4cc8-b985-a17eaad03b45	clientId	user.session.note
357f72a9-f0a1-4cc8-b985-a17eaad03b45	true	id.token.claim
357f72a9-f0a1-4cc8-b985-a17eaad03b45	true	access.token.claim
357f72a9-f0a1-4cc8-b985-a17eaad03b45	clientId	claim.name
357f72a9-f0a1-4cc8-b985-a17eaad03b45	String	jsonType.label
3d97bad8-d867-4a44-86cd-76bfd0b60ae6	clientHost	user.session.note
3d97bad8-d867-4a44-86cd-76bfd0b60ae6	true	id.token.claim
3d97bad8-d867-4a44-86cd-76bfd0b60ae6	true	access.token.claim
3d97bad8-d867-4a44-86cd-76bfd0b60ae6	clientHost	claim.name
3d97bad8-d867-4a44-86cd-76bfd0b60ae6	String	jsonType.label
0b2a0180-0c13-4559-ba48-57a8145e76b0	clientAddress	user.session.note
0b2a0180-0c13-4559-ba48-57a8145e76b0	true	id.token.claim
0b2a0180-0c13-4559-ba48-57a8145e76b0	true	access.token.claim
0b2a0180-0c13-4559-ba48-57a8145e76b0	clientAddress	claim.name
0b2a0180-0c13-4559-ba48-57a8145e76b0	String	jsonType.label
f516735f-9f4d-4702-a5d6-4576293a3772	clientHost	user.session.note
f516735f-9f4d-4702-a5d6-4576293a3772	true	id.token.claim
f516735f-9f4d-4702-a5d6-4576293a3772	true	access.token.claim
f516735f-9f4d-4702-a5d6-4576293a3772	clientHost	claim.name
f516735f-9f4d-4702-a5d6-4576293a3772	String	jsonType.label
f516735f-9f4d-4702-a5d6-4576293a3772	true	userinfo.token.claim
7bfd05aa-272b-4477-9253-ad6f831d3834	clientAddress	user.session.note
7bfd05aa-272b-4477-9253-ad6f831d3834	true	id.token.claim
7bfd05aa-272b-4477-9253-ad6f831d3834	true	access.token.claim
7bfd05aa-272b-4477-9253-ad6f831d3834	clientAddress	claim.name
7bfd05aa-272b-4477-9253-ad6f831d3834	String	jsonType.label
317be56a-40d2-4c0f-a5c3-d0c00568c1a2	clientId	user.session.note
317be56a-40d2-4c0f-a5c3-d0c00568c1a2	true	id.token.claim
317be56a-40d2-4c0f-a5c3-d0c00568c1a2	true	access.token.claim
317be56a-40d2-4c0f-a5c3-d0c00568c1a2	clientId	claim.name
317be56a-40d2-4c0f-a5c3-d0c00568c1a2	String	jsonType.label
7bfd05aa-272b-4477-9253-ad6f831d3834	true	userinfo.token.claim
317be56a-40d2-4c0f-a5c3-d0c00568c1a2	true	userinfo.token.claim
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
master	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	0a5ba243-bb6c-4d78-84a1-050e7ddb167d	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	df76ebe3-8fd5-47f4-b1a8-4ae7bd027f18	9335a605-36cd-48db-a374-e8165fa32e47	9c8af353-4cd5-4ceb-9082-a488fd815699	1f110ada-c65d-4c8f-be47-addb33d28965	ae417216-c352-4e77-8cf0-e1eb25027940	2592000	f	900	t	f	6a151a5e-130a-4e22-986d-529a8989d320	0	f	0	0	47014777-78ce-4a87-a671-80d33bdcdb55
fiware-server	60	300	300	\N	\N	\N	t	f	0	\N	fiware-server	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	d0d5e62d-cc3f-4fa8-89ac-0392fb561f72	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	2be8d746-65bb-4f12-924f-2759810a9d53	74c846c3-7027-4926-aa90-9b74b1299579	4058b6db-961a-4a54-a855-32456c926ead	4edf117c-0396-44d5-af13-d38c5605fe08	9083924a-fe40-4f8a-97da-f5b23526808e	2592000	f	900	t	f	af3e5f3e-310c-4411-97b4-51de245cb4c7	0	f	0	0	3792b25a-3b02-453a-b945-aae2b442e499
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	master	
_browser_header.xContentTypeOptions	master	nosniff
_browser_header.xRobotsTag	master	none
_browser_header.xFrameOptions	master	SAMEORIGIN
_browser_header.contentSecurityPolicy	master	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	master	1; mode=block
_browser_header.strictTransportSecurity	master	max-age=31536000; includeSubDomains
bruteForceProtected	master	false
permanentLockout	master	false
maxFailureWaitSeconds	master	900
minimumQuickLoginWaitSeconds	master	60
waitIncrementSeconds	master	60
quickLoginCheckMilliSeconds	master	1000
maxDeltaTimeSeconds	master	43200
failureFactor	master	30
displayName	master	Keycloak
displayNameHtml	master	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	master	RS256
offlineSessionMaxLifespanEnabled	master	false
offlineSessionMaxLifespan	master	5184000
_browser_header.contentSecurityPolicyReportOnly	fiware-server	
_browser_header.xContentTypeOptions	fiware-server	nosniff
_browser_header.xRobotsTag	fiware-server	none
_browser_header.xFrameOptions	fiware-server	SAMEORIGIN
_browser_header.contentSecurityPolicy	fiware-server	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	fiware-server	1; mode=block
_browser_header.strictTransportSecurity	fiware-server	max-age=31536000; includeSubDomains
bruteForceProtected	fiware-server	false
permanentLockout	fiware-server	false
maxFailureWaitSeconds	fiware-server	900
minimumQuickLoginWaitSeconds	fiware-server	60
waitIncrementSeconds	fiware-server	60
quickLoginCheckMilliSeconds	fiware-server	1000
maxDeltaTimeSeconds	fiware-server	43200
failureFactor	fiware-server	30
defaultSignatureAlgorithm	fiware-server	RS256
offlineSessionMaxLifespanEnabled	fiware-server	false
offlineSessionMaxLifespan	fiware-server	5184000
actionTokenGeneratedByAdminLifespan	fiware-server	43200
actionTokenGeneratedByUserLifespan	fiware-server	300
oauth2DeviceCodeLifespan	fiware-server	600
oauth2DevicePollingInterval	fiware-server	5
webAuthnPolicyRpEntityName	fiware-server	keycloak
webAuthnPolicySignatureAlgorithms	fiware-server	ES256
webAuthnPolicyRpId	fiware-server	
webAuthnPolicyAttestationConveyancePreference	fiware-server	not specified
webAuthnPolicyAuthenticatorAttachment	fiware-server	not specified
webAuthnPolicyRequireResidentKey	fiware-server	not specified
webAuthnPolicyUserVerificationRequirement	fiware-server	not specified
webAuthnPolicyCreateTimeout	fiware-server	0
webAuthnPolicyAvoidSameAuthenticatorRegister	fiware-server	false
webAuthnPolicyRpEntityNamePasswordless	fiware-server	keycloak
webAuthnPolicySignatureAlgorithmsPasswordless	fiware-server	ES256
webAuthnPolicyRpIdPasswordless	fiware-server	
webAuthnPolicyAttestationConveyancePreferencePasswordless	fiware-server	not specified
webAuthnPolicyAuthenticatorAttachmentPasswordless	fiware-server	not specified
webAuthnPolicyRequireResidentKeyPasswordless	fiware-server	not specified
webAuthnPolicyUserVerificationRequirementPasswordless	fiware-server	not specified
webAuthnPolicyCreateTimeoutPasswordless	fiware-server	0
webAuthnPolicyAvoidSameAuthenticatorRegisterPasswordless	fiware-server	false
cibaBackchannelTokenDeliveryMode	fiware-server	poll
cibaExpiresIn	fiware-server	120
cibaInterval	fiware-server	5
cibaAuthRequestedUserHint	fiware-server	login_hint
parRequestUriLifespan	fiware-server	60
\.


--
-- Data for Name: realm_default_groups; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_default_groups (realm_id, group_id) FROM stdin;
\.


--
-- Data for Name: realm_enabled_event_types; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_enabled_event_types (realm_id, value) FROM stdin;
\.


--
-- Data for Name: realm_events_listeners; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_events_listeners (realm_id, value) FROM stdin;
master	jboss-logging
fiware-server	jboss-logging
\.


--
-- Data for Name: realm_localizations; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_localizations (realm_id, locale, texts) FROM stdin;
\.


--
-- Data for Name: realm_required_credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_required_credential (type, form_label, input, secret, realm_id) FROM stdin;
password	password	t	t	master
password	password	t	t	fiware-server
\.


--
-- Data for Name: realm_smtp_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_smtp_config (realm_id, value, name) FROM stdin;
\.


--
-- Data for Name: realm_supported_locales; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_supported_locales (realm_id, value) FROM stdin;
\.


--
-- Data for Name: redirect_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.redirect_uris (client_id, value) FROM stdin;
7accf29a-4352-4ea5-a369-cf6d954350e8	/realms/master/account/*
68665072-ccfc-4309-b823-0a88de3065c2	/realms/master/account/*
f6abaf9f-3dde-4919-b983-99eb42003057	/admin/master/console/*
9250b599-4750-4dfb-86b4-5c5444d14c5d	/realms/fiware-server/account/*
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	/realms/fiware-server/account/*
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	/admin/fiware-server/console/*
41d8bab9-aa4f-47dd-bd66-2e88672ea746	*
d9289482-a19d-4b09-bc90-57353057cd70	*
\.


--
-- Data for Name: required_action_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_config (required_action_id, value, name) FROM stdin;
\.


--
-- Data for Name: required_action_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.required_action_provider (id, alias, name, realm_id, enabled, default_action, provider_id, priority) FROM stdin;
bf1826ae-cd2e-4c10-b9d1-f7f78d1b987a	VERIFY_EMAIL	Verify Email	master	t	f	VERIFY_EMAIL	50
a2c64d27-ce3d-46e9-981b-a02fb628a848	UPDATE_PROFILE	Update Profile	master	t	f	UPDATE_PROFILE	40
954caef2-f81d-406d-841b-ef271801736b	CONFIGURE_TOTP	Configure OTP	master	t	f	CONFIGURE_TOTP	10
79393d78-9acd-430e-85c4-ce1a9dfb57f9	UPDATE_PASSWORD	Update Password	master	t	f	UPDATE_PASSWORD	30
7abc019c-9bc7-46ae-bbb1-ca2a60f979cd	terms_and_conditions	Terms and Conditions	master	f	f	terms_and_conditions	20
701fa5b1-fd57-481a-bbab-c653a5fb0ce7	update_user_locale	Update User Locale	master	t	f	update_user_locale	1000
ac2d37cf-e08e-419f-bcf0-de4edfc3f6a8	delete_account	Delete Account	master	f	f	delete_account	60
38ea3054-d63a-4343-b6a2-bfc50a782fdc	VERIFY_EMAIL	Verify Email	fiware-server	t	f	VERIFY_EMAIL	50
bcee5785-00f0-4e5f-890c-8f21e596941d	UPDATE_PROFILE	Update Profile	fiware-server	t	f	UPDATE_PROFILE	40
efd2331f-1de9-44f7-b72d-4dc850f21982	CONFIGURE_TOTP	Configure OTP	fiware-server	t	f	CONFIGURE_TOTP	10
fa7565c7-4e4f-4a52-a2b9-599015172b78	UPDATE_PASSWORD	Update Password	fiware-server	t	f	UPDATE_PASSWORD	30
0035087b-5d53-481a-b2c7-73d8fb9a082e	terms_and_conditions	Terms and Conditions	fiware-server	f	f	terms_and_conditions	20
95aec330-3d32-4341-bd78-44b2d87922ce	update_user_locale	Update User Locale	fiware-server	t	f	update_user_locale	1000
d09ae8d1-6a02-4d99-9d24-5db4cd70e0d1	delete_account	Delete Account	fiware-server	f	f	delete_account	60
\.


--
-- Data for Name: resource_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_attribute (id, name, value, resource_id) FROM stdin;
\.


--
-- Data for Name: resource_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_policy (resource_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_scope (resource_id, scope_id) FROM stdin;
\.


--
-- Data for Name: resource_server; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server (id, allow_rs_remote_mgmt, policy_enforce_mode, decision_strategy) FROM stdin;
41d8bab9-aa4f-47dd-bd66-2e88672ea746	t	0	1
d9289482-a19d-4b09-bc90-57353057cd70	t	0	1
\.


--
-- Data for Name: resource_server_perm_ticket; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_perm_ticket (id, owner, requester, created_timestamp, granted_timestamp, resource_id, scope_id, resource_server_id, policy_id) FROM stdin;
\.


--
-- Data for Name: resource_server_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_policy (id, name, description, type, decision_strategy, logic, resource_server_id, owner) FROM stdin;
e9138225-bae6-460a-bcf7-9574919b4759	Default Policy	A policy that grants access only for users within this realm	js	0	0	41d8bab9-aa4f-47dd-bd66-2e88672ea746	\N
13d580c0-d4d9-4f09-9a39-f28dd749f38e	Default Permission	A permission that applies to the default resource type	resource	1	0	41d8bab9-aa4f-47dd-bd66-2e88672ea746	\N
33fce0c5-b2e7-4fa2-979d-450d651b9f9a	Default Policy	A policy that grants access only for users within this realm	js	0	0	d9289482-a19d-4b09-bc90-57353057cd70	\N
0a1767dd-be00-4b20-bee5-236ec01322d1	Default Permission	A permission that applies to the default resource type	resource	1	0	d9289482-a19d-4b09-bc90-57353057cd70	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
28ad496c-9fc8-4729-bf37-4bb4eb961bb7	Default Resource	urn:orion-pep:resources:default	\N	41d8bab9-aa4f-47dd-bd66-2e88672ea746	41d8bab9-aa4f-47dd-bd66-2e88672ea746	f	\N
d2f72e85-e27b-415f-bb7d-fdaab723c21b	Default Resource	urn:mintaka-pep:resources:default	\N	d9289482-a19d-4b09-bc90-57353057cd70	d9289482-a19d-4b09-bc90-57353057cd70	f	\N
\.


--
-- Data for Name: resource_server_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_scope (id, name, icon_uri, resource_server_id, display_name) FROM stdin;
\.


--
-- Data for Name: resource_uris; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_uris (resource_id, value) FROM stdin;
28ad496c-9fc8-4729-bf37-4bb4eb961bb7	/*
d2f72e85-e27b-415f-bb7d-fdaab723c21b	/*
\.


--
-- Data for Name: role_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.role_attribute (id, role_id, name, value) FROM stdin;
\.


--
-- Data for Name: scope_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_mapping (client_id, role_id) FROM stdin;
68665072-ccfc-4309-b823-0a88de3065c2	13660469-ffd3-421e-94bd-095b4918e159
56bc37fb-f41d-4f1c-81bd-f78fc5732a7f	26037ebe-6916-420e-b7df-e6434792c854
\.


--
-- Data for Name: scope_policy; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.scope_policy (scope_id, policy_id) FROM stdin;
\.


--
-- Data for Name: user_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_attribute (name, value, user_id, id) FROM stdin;
\.


--
-- Data for Name: user_consent; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent (id, client_id, user_id, created_date, last_updated_date, client_storage_provider, external_client_id) FROM stdin;
\.


--
-- Data for Name: user_consent_client_scope; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_consent_client_scope (user_consent_id, scope_id) FROM stdin;
\.


--
-- Data for Name: user_entity; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_entity (id, email, email_constraint, email_verified, enabled, federation_link, first_name, last_name, realm_id, username, created_timestamp, service_account_client_link, not_before) FROM stdin;
7e5599cc-8733-4ba6-97e5-5f4164d55a82	\N	837eb43e-e2e4-4d1c-9345-344dcd8b0ac0	f	t	\N	\N	\N	master	keycloak	1709304109376	\N	0
05e63846-7ea8-4346-ac00-f6a8aef00fae	\N	670cc6e9-2c50-49c5-bb7e-70463efd3f65	f	t	\N	\N	\N	fiware-server	admin-user	1709304570801	\N	0
b132828c-a359-4f52-9a36-854b101c9c54	\N	140eb023-91be-4d17-ad1b-16397950c70e	f	t	\N	\N	\N	fiware-server	service-account-orion-pep	1709538624246	41d8bab9-aa4f-47dd-bd66-2e88672ea746	0
c8d85a33-5d93-4061-8f82-ec9fa9534350	\N	01025542-2c26-4ca8-b8c3-6924b36e610f	f	t	\N	\N	\N	fiware-server	service-account-mintaka-pep	1709547656038	d9289482-a19d-4b09-bc90-57353057cd70	0
\.


--
-- Data for Name: user_federation_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_config (user_federation_provider_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper (id, name, federation_provider_id, federation_mapper_type, realm_id) FROM stdin;
\.


--
-- Data for Name: user_federation_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_mapper_config (user_federation_mapper_id, value, name) FROM stdin;
\.


--
-- Data for Name: user_federation_provider; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_federation_provider (id, changed_sync_period, display_name, full_sync_period, last_sync, priority, provider_name, realm_id) FROM stdin;
\.


--
-- Data for Name: user_group_membership; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_group_membership (group_id, user_id) FROM stdin;
\.


--
-- Data for Name: user_required_action; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_required_action (user_id, required_action) FROM stdin;
\.


--
-- Data for Name: user_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_role_mapping (role_id, user_id) FROM stdin;
47014777-78ce-4a87-a671-80d33bdcdb55	7e5599cc-8733-4ba6-97e5-5f4164d55a82
313f957d-ffac-48f8-ba97-ac8de16cb459	7e5599cc-8733-4ba6-97e5-5f4164d55a82
8d69b447-3cca-4a5b-8e37-195146726fed	7e5599cc-8733-4ba6-97e5-5f4164d55a82
e0439b99-2983-4ebe-89fb-bfc501764153	7e5599cc-8733-4ba6-97e5-5f4164d55a82
b827ae20-1ebc-4fdc-9c3c-2f66fafea8fa	7e5599cc-8733-4ba6-97e5-5f4164d55a82
809f9379-6790-4a3e-91c4-93547549ce67	7e5599cc-8733-4ba6-97e5-5f4164d55a82
233c1f8b-2e7a-4892-976f-237fa4815b85	7e5599cc-8733-4ba6-97e5-5f4164d55a82
9f3f59ed-018a-4d31-9c03-d55f11290207	7e5599cc-8733-4ba6-97e5-5f4164d55a82
0715988c-1926-487d-9cb7-e405f1d38eb6	7e5599cc-8733-4ba6-97e5-5f4164d55a82
ac213552-7321-4962-8050-24e5b19827bf	7e5599cc-8733-4ba6-97e5-5f4164d55a82
24da3e46-d54c-4d24-ba40-8fc36e2bf28a	7e5599cc-8733-4ba6-97e5-5f4164d55a82
05a18bed-4c98-4bca-be9f-58319fba3623	7e5599cc-8733-4ba6-97e5-5f4164d55a82
6bf767fb-13df-4555-a30b-f84606fefd13	7e5599cc-8733-4ba6-97e5-5f4164d55a82
64f1a90d-68e3-4ca5-b41d-cbfdfdbed3ba	7e5599cc-8733-4ba6-97e5-5f4164d55a82
5c3e2f9f-c49e-4a75-88aa-e8c33f2643f4	7e5599cc-8733-4ba6-97e5-5f4164d55a82
f059b5fb-7ea5-41cd-995c-25abd0328ca6	7e5599cc-8733-4ba6-97e5-5f4164d55a82
71fdd6db-0393-4ef7-af9c-f5fe6b8b3af8	7e5599cc-8733-4ba6-97e5-5f4164d55a82
02839e02-4727-46d9-8f2d-ee633c038682	7e5599cc-8733-4ba6-97e5-5f4164d55a82
a45cce50-5147-43aa-98df-d8682836b332	7e5599cc-8733-4ba6-97e5-5f4164d55a82
3792b25a-3b02-453a-b945-aae2b442e499	05e63846-7ea8-4346-ac00-f6a8aef00fae
3792b25a-3b02-453a-b945-aae2b442e499	b132828c-a359-4f52-9a36-854b101c9c54
14d30ac8-58ce-4cf0-b4e8-b10b6b9c122b	b132828c-a359-4f52-9a36-854b101c9c54
3792b25a-3b02-453a-b945-aae2b442e499	c8d85a33-5d93-4061-8f82-ec9fa9534350
0ad6e7fd-0eb2-4ce8-9c78-f09a224a30f4	c8d85a33-5d93-4061-8f82-ec9fa9534350
\.


--
-- Data for Name: user_session; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session (id, auth_method, ip_address, last_session_refresh, login_username, realm_id, remember_me, started, user_id, user_session_state, broker_session_id, broker_user_id) FROM stdin;
\.


--
-- Data for Name: user_session_note; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.user_session_note (user_session, name, value) FROM stdin;
\.


--
-- Data for Name: username_login_failure; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.username_login_failure (realm_id, username, failed_login_not_before, last_failure, last_ip_failure, num_failures) FROM stdin;
\.


--
-- Data for Name: web_origins; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.web_origins (client_id, value) FROM stdin;
f6abaf9f-3dde-4919-b983-99eb42003057	+
6d1d6ce9-0565-4974-a42c-5dbd00cc159e	+
\.


--
-- Name: username_login_failure CONSTRAINT_17-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.username_login_failure
    ADD CONSTRAINT "CONSTRAINT_17-2" PRIMARY KEY (realm_id, username);


--
-- Name: keycloak_role UK_J3RWUVD56ONTGSUHOGM184WW2-2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT "UK_J3RWUVD56ONTGSUHOGM184WW2-2" UNIQUE (name, client_realm_constraint);


--
-- Name: client_auth_flow_bindings c_cli_flow_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_auth_flow_bindings
    ADD CONSTRAINT c_cli_flow_bind PRIMARY KEY (client_id, binding_name);


--
-- Name: client_scope_client c_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_client
    ADD CONSTRAINT c_cli_scope_bind PRIMARY KEY (client_id, scope_id);


--
-- Name: client_initial_access cnstr_client_init_acc_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT cnstr_client_init_acc_pk PRIMARY KEY (id);


--
-- Name: realm_default_groups con_group_id_def_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT con_group_id_def_groups UNIQUE (group_id);


--
-- Name: broker_link constr_broker_link_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.broker_link
    ADD CONSTRAINT constr_broker_link_pk PRIMARY KEY (identity_provider, user_id);


--
-- Name: client_user_session_note constr_cl_usr_ses_note; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT constr_cl_usr_ses_note PRIMARY KEY (client_session, name);


--
-- Name: component_config constr_component_config_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT constr_component_config_pk PRIMARY KEY (id);


--
-- Name: component constr_component_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT constr_component_pk PRIMARY KEY (id);


--
-- Name: fed_user_required_action constr_fed_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_required_action
    ADD CONSTRAINT constr_fed_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: fed_user_attribute constr_fed_user_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_attribute
    ADD CONSTRAINT constr_fed_user_attr_pk PRIMARY KEY (id);


--
-- Name: fed_user_consent constr_fed_user_consent_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent
    ADD CONSTRAINT constr_fed_user_consent_pk PRIMARY KEY (id);


--
-- Name: fed_user_credential constr_fed_user_cred_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_credential
    ADD CONSTRAINT constr_fed_user_cred_pk PRIMARY KEY (id);


--
-- Name: fed_user_group_membership constr_fed_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_group_membership
    ADD CONSTRAINT constr_fed_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: fed_user_role_mapping constr_fed_user_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_role_mapping
    ADD CONSTRAINT constr_fed_user_role PRIMARY KEY (role_id, user_id);


--
-- Name: federated_user constr_federated_user; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_user
    ADD CONSTRAINT constr_federated_user PRIMARY KEY (id);


--
-- Name: realm_default_groups constr_realm_default_groups; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT constr_realm_default_groups PRIMARY KEY (realm_id, group_id);


--
-- Name: realm_enabled_event_types constr_realm_enabl_event_types; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT constr_realm_enabl_event_types PRIMARY KEY (realm_id, value);


--
-- Name: realm_events_listeners constr_realm_events_listeners; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT constr_realm_events_listeners PRIMARY KEY (realm_id, value);


--
-- Name: realm_supported_locales constr_realm_supported_locales; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT constr_realm_supported_locales PRIMARY KEY (realm_id, value);


--
-- Name: identity_provider constraint_2b; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT constraint_2b PRIMARY KEY (internal_id);


--
-- Name: client_attributes constraint_3c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT constraint_3c PRIMARY KEY (client_id, name);


--
-- Name: event_entity constraint_4; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.event_entity
    ADD CONSTRAINT constraint_4 PRIMARY KEY (id);


--
-- Name: federated_identity constraint_40; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT constraint_40 PRIMARY KEY (identity_provider, user_id);


--
-- Name: realm constraint_4a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT constraint_4a PRIMARY KEY (id);


--
-- Name: client_session_role constraint_5; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT constraint_5 PRIMARY KEY (client_session, role_id);


--
-- Name: user_session constraint_57; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session
    ADD CONSTRAINT constraint_57 PRIMARY KEY (id);


--
-- Name: user_federation_provider constraint_5c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT constraint_5c PRIMARY KEY (id);


--
-- Name: client_session_note constraint_5e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT constraint_5e PRIMARY KEY (client_session, name);


--
-- Name: client constraint_7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT constraint_7 PRIMARY KEY (id);


--
-- Name: client_session constraint_8; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT constraint_8 PRIMARY KEY (id);


--
-- Name: scope_mapping constraint_81; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT constraint_81 PRIMARY KEY (client_id, role_id);


--
-- Name: client_node_registrations constraint_84; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT constraint_84 PRIMARY KEY (client_id, name);


--
-- Name: realm_attribute constraint_9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT constraint_9 PRIMARY KEY (name, realm_id);


--
-- Name: realm_required_credential constraint_92; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT constraint_92 PRIMARY KEY (realm_id, type);


--
-- Name: keycloak_role constraint_a; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT constraint_a PRIMARY KEY (id);


--
-- Name: admin_event_entity constraint_admin_event_entity; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.admin_event_entity
    ADD CONSTRAINT constraint_admin_event_entity PRIMARY KEY (id);


--
-- Name: authenticator_config_entry constraint_auth_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config_entry
    ADD CONSTRAINT constraint_auth_cfg_pk PRIMARY KEY (authenticator_id, name);


--
-- Name: authentication_execution constraint_auth_exec_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT constraint_auth_exec_pk PRIMARY KEY (id);


--
-- Name: authentication_flow constraint_auth_flow_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT constraint_auth_flow_pk PRIMARY KEY (id);


--
-- Name: authenticator_config constraint_auth_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT constraint_auth_pk PRIMARY KEY (id);


--
-- Name: client_session_auth_status constraint_auth_status_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT constraint_auth_status_pk PRIMARY KEY (client_session, authenticator);


--
-- Name: user_role_mapping constraint_c; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT constraint_c PRIMARY KEY (role_id, user_id);


--
-- Name: composite_role constraint_composite_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT constraint_composite_role PRIMARY KEY (composite, child_role);


--
-- Name: client_session_prot_mapper constraint_cs_pmp_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT constraint_cs_pmp_pk PRIMARY KEY (client_session, protocol_mapper_id);


--
-- Name: identity_provider_config constraint_d; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT constraint_d PRIMARY KEY (identity_provider_id, name);


--
-- Name: policy_config constraint_dpc; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT constraint_dpc PRIMARY KEY (policy_id, name);


--
-- Name: realm_smtp_config constraint_e; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT constraint_e PRIMARY KEY (realm_id, name);


--
-- Name: credential constraint_f; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT constraint_f PRIMARY KEY (id);


--
-- Name: user_federation_config constraint_f9; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT constraint_f9 PRIMARY KEY (user_federation_provider_id, name);


--
-- Name: resource_server_perm_ticket constraint_fapmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT constraint_fapmt PRIMARY KEY (id);


--
-- Name: resource_server_resource constraint_farsr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT constraint_farsr PRIMARY KEY (id);


--
-- Name: resource_server_policy constraint_farsrp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT constraint_farsrp PRIMARY KEY (id);


--
-- Name: associated_policy constraint_farsrpap; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT constraint_farsrpap PRIMARY KEY (policy_id, associated_policy_id);


--
-- Name: resource_policy constraint_farsrpp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT constraint_farsrpp PRIMARY KEY (resource_id, policy_id);


--
-- Name: resource_server_scope constraint_farsrs; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT constraint_farsrs PRIMARY KEY (id);


--
-- Name: resource_scope constraint_farsrsp; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT constraint_farsrsp PRIMARY KEY (resource_id, scope_id);


--
-- Name: scope_policy constraint_farsrsps; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT constraint_farsrsps PRIMARY KEY (scope_id, policy_id);


--
-- Name: user_entity constraint_fb; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT constraint_fb PRIMARY KEY (id);


--
-- Name: user_federation_mapper_config constraint_fedmapper_cfg_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT constraint_fedmapper_cfg_pm PRIMARY KEY (user_federation_mapper_id, name);


--
-- Name: user_federation_mapper constraint_fedmapperpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT constraint_fedmapperpm PRIMARY KEY (id);


--
-- Name: fed_user_consent_cl_scope constraint_fgrntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.fed_user_consent_cl_scope
    ADD CONSTRAINT constraint_fgrntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent_client_scope constraint_grntcsnt_clsc_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT constraint_grntcsnt_clsc_pm PRIMARY KEY (user_consent_id, scope_id);


--
-- Name: user_consent constraint_grntcsnt_pm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT constraint_grntcsnt_pm PRIMARY KEY (id);


--
-- Name: keycloak_group constraint_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT constraint_group PRIMARY KEY (id);


--
-- Name: group_attribute constraint_group_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT constraint_group_attribute_pk PRIMARY KEY (id);


--
-- Name: group_role_mapping constraint_group_role; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT constraint_group_role PRIMARY KEY (role_id, group_id);


--
-- Name: identity_provider_mapper constraint_idpm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT constraint_idpm PRIMARY KEY (id);


--
-- Name: idp_mapper_config constraint_idpmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT constraint_idpmconfig PRIMARY KEY (idp_mapper_id, name);


--
-- Name: migration_model constraint_migmod; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.migration_model
    ADD CONSTRAINT constraint_migmod PRIMARY KEY (id);


--
-- Name: offline_client_session constraint_offl_cl_ses_pk3; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_client_session
    ADD CONSTRAINT constraint_offl_cl_ses_pk3 PRIMARY KEY (user_session_id, client_id, client_storage_provider, external_client_id, offline_flag);


--
-- Name: offline_user_session constraint_offl_us_ses_pk2; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.offline_user_session
    ADD CONSTRAINT constraint_offl_us_ses_pk2 PRIMARY KEY (user_session_id, offline_flag);


--
-- Name: protocol_mapper constraint_pcm; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT constraint_pcm PRIMARY KEY (id);


--
-- Name: protocol_mapper_config constraint_pmconfig; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT constraint_pmconfig PRIMARY KEY (protocol_mapper_id, name);


--
-- Name: redirect_uris constraint_redirect_uris; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT constraint_redirect_uris PRIMARY KEY (client_id, value);


--
-- Name: required_action_config constraint_req_act_cfg_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_config
    ADD CONSTRAINT constraint_req_act_cfg_pk PRIMARY KEY (required_action_id, name);


--
-- Name: required_action_provider constraint_req_act_prv_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT constraint_req_act_prv_pk PRIMARY KEY (id);


--
-- Name: user_required_action constraint_required_action; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT constraint_required_action PRIMARY KEY (required_action, user_id);


--
-- Name: resource_uris constraint_resour_uris_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT constraint_resour_uris_pk PRIMARY KEY (resource_id, value);


--
-- Name: role_attribute constraint_role_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT constraint_role_attribute_pk PRIMARY KEY (id);


--
-- Name: user_attribute constraint_user_attribute_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT constraint_user_attribute_pk PRIMARY KEY (id);


--
-- Name: user_group_membership constraint_user_group; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT constraint_user_group PRIMARY KEY (group_id, user_id);


--
-- Name: user_session_note constraint_usn_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT constraint_usn_pk PRIMARY KEY (user_session, name);


--
-- Name: web_origins constraint_web_origins; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT constraint_web_origins PRIMARY KEY (client_id, value);


--
-- Name: client_scope_attributes pk_cl_tmpl_attr; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT pk_cl_tmpl_attr PRIMARY KEY (scope_id, name);


--
-- Name: client_scope pk_cli_template; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT pk_cli_template PRIMARY KEY (id);


--
-- Name: databasechangeloglock pk_databasechangeloglock; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT pk_databasechangeloglock PRIMARY KEY (id);


--
-- Name: resource_server pk_resource_server; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server
    ADD CONSTRAINT pk_resource_server PRIMARY KEY (id);


--
-- Name: client_scope_role_mapping pk_template_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT pk_template_scope PRIMARY KEY (scope_id, role_id);


--
-- Name: default_client_scope r_def_cli_scope_bind; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT r_def_cli_scope_bind PRIMARY KEY (realm_id, scope_id);


--
-- Name: realm_localizations realm_localizations_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_localizations
    ADD CONSTRAINT realm_localizations_pkey PRIMARY KEY (realm_id, locale);


--
-- Name: resource_attribute res_attr_pk; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT res_attr_pk PRIMARY KEY (id);


--
-- Name: keycloak_group sibling_names; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_group
    ADD CONSTRAINT sibling_names UNIQUE (realm_id, parent_group, name);


--
-- Name: identity_provider uk_2daelwnibji49avxsrtuf6xj33; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT uk_2daelwnibji49avxsrtuf6xj33 UNIQUE (provider_alias, realm_id);


--
-- Name: client uk_b71cjlbenv945rb6gcon438at; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client
    ADD CONSTRAINT uk_b71cjlbenv945rb6gcon438at UNIQUE (realm_id, client_id);


--
-- Name: client_scope uk_cli_scope; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope
    ADD CONSTRAINT uk_cli_scope UNIQUE (realm_id, name);


--
-- Name: user_entity uk_dykn684sl8up1crfei6eckhd7; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_dykn684sl8up1crfei6eckhd7 UNIQUE (realm_id, email_constraint);


--
-- Name: resource_server_resource uk_frsr6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5ha6 UNIQUE (name, owner, resource_server_id);


--
-- Name: resource_server_perm_ticket uk_frsr6t700s9v50bu18ws5pmt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT uk_frsr6t700s9v50bu18ws5pmt UNIQUE (owner, requester, resource_server_id, resource_id, scope_id);


--
-- Name: resource_server_policy uk_frsrpt700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT uk_frsrpt700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: resource_server_scope uk_frsrst700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT uk_frsrst700s9v50bu18ws5ha6 UNIQUE (name, resource_server_id);


--
-- Name: user_consent uk_jkuwuvd56ontgsuhogm8uewrt; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT uk_jkuwuvd56ontgsuhogm8uewrt UNIQUE (client_id, client_storage_provider, external_client_id, user_id);


--
-- Name: realm uk_orvsdmla56612eaefiq6wl5oi; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm
    ADD CONSTRAINT uk_orvsdmla56612eaefiq6wl5oi UNIQUE (name);


--
-- Name: user_entity uk_ru8tt6t700s9v50bu18ws5ha6; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_entity
    ADD CONSTRAINT uk_ru8tt6t700s9v50bu18ws5ha6 UNIQUE (realm_id, username);


--
-- Name: idx_assoc_pol_assoc_pol_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_assoc_pol_assoc_pol_id ON public.associated_policy USING btree (associated_policy_id);


--
-- Name: idx_auth_config_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_config_realm ON public.authenticator_config USING btree (realm_id);


--
-- Name: idx_auth_exec_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_flow ON public.authentication_execution USING btree (flow_id);


--
-- Name: idx_auth_exec_realm_flow; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_exec_realm_flow ON public.authentication_execution USING btree (realm_id, flow_id);


--
-- Name: idx_auth_flow_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_auth_flow_realm ON public.authentication_flow USING btree (realm_id);


--
-- Name: idx_cl_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_cl_clscope ON public.client_scope_client USING btree (scope_id);


--
-- Name: idx_client_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_att_by_name_value ON public.client_attributes USING btree (name, ((value)::character varying(250)));


--
-- Name: idx_client_id; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_id ON public.client USING btree (client_id);


--
-- Name: idx_client_init_acc_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_init_acc_realm ON public.client_initial_access USING btree (realm_id);


--
-- Name: idx_client_session_session; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_client_session_session ON public.client_session USING btree (session_id);


--
-- Name: idx_clscope_attrs; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_attrs ON public.client_scope_attributes USING btree (scope_id);


--
-- Name: idx_clscope_cl; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_cl ON public.client_scope_client USING btree (client_id);


--
-- Name: idx_clscope_protmap; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_protmap ON public.protocol_mapper USING btree (client_scope_id);


--
-- Name: idx_clscope_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_clscope_role ON public.client_scope_role_mapping USING btree (scope_id);


--
-- Name: idx_compo_config_compo; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_compo_config_compo ON public.component_config USING btree (component_id);


--
-- Name: idx_component_provider_type; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_provider_type ON public.component USING btree (provider_type);


--
-- Name: idx_component_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_component_realm ON public.component USING btree (realm_id);


--
-- Name: idx_composite; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite ON public.composite_role USING btree (composite);


--
-- Name: idx_composite_child; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_composite_child ON public.composite_role USING btree (child_role);


--
-- Name: idx_defcls_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_realm ON public.default_client_scope USING btree (realm_id);


--
-- Name: idx_defcls_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_defcls_scope ON public.default_client_scope USING btree (scope_id);


--
-- Name: idx_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_event_time ON public.event_entity USING btree (realm_id, event_time);


--
-- Name: idx_fedidentity_feduser; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_feduser ON public.federated_identity USING btree (federated_user_id);


--
-- Name: idx_fedidentity_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fedidentity_user ON public.federated_identity USING btree (user_id);


--
-- Name: idx_fu_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_attribute ON public.fed_user_attribute USING btree (user_id, realm_id, name);


--
-- Name: idx_fu_cnsnt_ext; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_cnsnt_ext ON public.fed_user_consent USING btree (user_id, client_storage_provider, external_client_id);


--
-- Name: idx_fu_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent ON public.fed_user_consent USING btree (user_id, client_id);


--
-- Name: idx_fu_consent_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_consent_ru ON public.fed_user_consent USING btree (realm_id, user_id);


--
-- Name: idx_fu_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential ON public.fed_user_credential USING btree (user_id, type);


--
-- Name: idx_fu_credential_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_credential_ru ON public.fed_user_credential USING btree (realm_id, user_id);


--
-- Name: idx_fu_group_membership; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership ON public.fed_user_group_membership USING btree (user_id, group_id);


--
-- Name: idx_fu_group_membership_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_group_membership_ru ON public.fed_user_group_membership USING btree (realm_id, user_id);


--
-- Name: idx_fu_required_action; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action ON public.fed_user_required_action USING btree (user_id, required_action);


--
-- Name: idx_fu_required_action_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_required_action_ru ON public.fed_user_required_action USING btree (realm_id, user_id);


--
-- Name: idx_fu_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping ON public.fed_user_role_mapping USING btree (user_id, role_id);


--
-- Name: idx_fu_role_mapping_ru; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_fu_role_mapping_ru ON public.fed_user_role_mapping USING btree (realm_id, user_id);


--
-- Name: idx_group_attr_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_attr_group ON public.group_attribute USING btree (group_id);


--
-- Name: idx_group_role_mapp_group; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_role_mapp_group ON public.group_role_mapping USING btree (group_id);


--
-- Name: idx_id_prov_mapp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_id_prov_mapp_realm ON public.identity_provider_mapper USING btree (realm_id);


--
-- Name: idx_ident_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_ident_prov_realm ON public.identity_provider USING btree (realm_id);


--
-- Name: idx_keycloak_role_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_client ON public.keycloak_role USING btree (client);


--
-- Name: idx_keycloak_role_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_keycloak_role_realm ON public.keycloak_role USING btree (realm);


--
-- Name: idx_offline_css_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_css_preload ON public.offline_client_session USING btree (client_id, offline_flag);


--
-- Name: idx_offline_uss_by_user; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_user ON public.offline_user_session USING btree (user_id, realm_id, offline_flag);


--
-- Name: idx_offline_uss_by_usersess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_by_usersess ON public.offline_user_session USING btree (realm_id, offline_flag, user_session_id);


--
-- Name: idx_offline_uss_createdon; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_createdon ON public.offline_user_session USING btree (created_on);


--
-- Name: idx_offline_uss_preload; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_offline_uss_preload ON public.offline_user_session USING btree (offline_flag, created_on, user_session_id);


--
-- Name: idx_protocol_mapper_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_protocol_mapper_client ON public.protocol_mapper USING btree (client_id);


--
-- Name: idx_realm_attr_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_attr_realm ON public.realm_attribute USING btree (realm_id);


--
-- Name: idx_realm_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_clscope ON public.client_scope USING btree (realm_id);


--
-- Name: idx_realm_def_grp_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_def_grp_realm ON public.realm_default_groups USING btree (realm_id);


--
-- Name: idx_realm_evt_list_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_list_realm ON public.realm_events_listeners USING btree (realm_id);


--
-- Name: idx_realm_evt_types_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_evt_types_realm ON public.realm_enabled_event_types USING btree (realm_id);


--
-- Name: idx_realm_master_adm_cli; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_master_adm_cli ON public.realm USING btree (master_admin_client);


--
-- Name: idx_realm_supp_local_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_realm_supp_local_realm ON public.realm_supported_locales USING btree (realm_id);


--
-- Name: idx_redir_uri_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_redir_uri_client ON public.redirect_uris USING btree (client_id);


--
-- Name: idx_req_act_prov_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_req_act_prov_realm ON public.required_action_provider USING btree (realm_id);


--
-- Name: idx_res_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_policy_policy ON public.resource_policy USING btree (policy_id);


--
-- Name: idx_res_scope_scope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_scope_scope ON public.resource_scope USING btree (scope_id);


--
-- Name: idx_res_serv_pol_res_serv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_serv_pol_res_serv ON public.resource_server_policy USING btree (resource_server_id);


--
-- Name: idx_res_srv_res_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_res_res_srv ON public.resource_server_resource USING btree (resource_server_id);


--
-- Name: idx_res_srv_scope_res_srv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_res_srv_scope_res_srv ON public.resource_server_scope USING btree (resource_server_id);


--
-- Name: idx_role_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_attribute ON public.role_attribute USING btree (role_id);


--
-- Name: idx_role_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_role_clscope ON public.client_scope_role_mapping USING btree (role_id);


--
-- Name: idx_scope_mapping_role; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_mapping_role ON public.scope_mapping USING btree (role_id);


--
-- Name: idx_scope_policy_policy; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_scope_policy_policy ON public.scope_policy USING btree (policy_id);


--
-- Name: idx_update_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_update_time ON public.migration_model USING btree (update_time);


--
-- Name: idx_us_sess_id_on_cl_sess; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_us_sess_id_on_cl_sess ON public.offline_client_session USING btree (user_session_id);


--
-- Name: idx_usconsent_clscope; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usconsent_clscope ON public.user_consent_client_scope USING btree (user_consent_id);


--
-- Name: idx_user_attribute; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute ON public.user_attribute USING btree (user_id);


--
-- Name: idx_user_attribute_name; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_attribute_name ON public.user_attribute USING btree (name, value);


--
-- Name: idx_user_consent; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_consent ON public.user_consent USING btree (user_id);


--
-- Name: idx_user_credential; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_credential ON public.credential USING btree (user_id);


--
-- Name: idx_user_email; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_email ON public.user_entity USING btree (email);


--
-- Name: idx_user_group_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_group_mapping ON public.user_group_membership USING btree (user_id);


--
-- Name: idx_user_reqactions; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_reqactions ON public.user_required_action USING btree (user_id);


--
-- Name: idx_user_role_mapping; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_role_mapping ON public.user_role_mapping USING btree (user_id);


--
-- Name: idx_usr_fed_map_fed_prv; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_fed_prv ON public.user_federation_mapper USING btree (federation_provider_id);


--
-- Name: idx_usr_fed_map_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_map_realm ON public.user_federation_mapper USING btree (realm_id);


--
-- Name: idx_usr_fed_prv_realm; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_usr_fed_prv_realm ON public.user_federation_provider USING btree (realm_id);


--
-- Name: idx_web_orig_client; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_web_orig_client ON public.web_origins USING btree (client_id);


--
-- Name: client_session_auth_status auth_status_constraint; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_auth_status
    ADD CONSTRAINT auth_status_constraint FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: identity_provider fk2b4ebc52ae5c3b34; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider
    ADD CONSTRAINT fk2b4ebc52ae5c3b34 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_attributes fk3c47c64beacca966; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_attributes
    ADD CONSTRAINT fk3c47c64beacca966 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: federated_identity fk404288b92ef007a6; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.federated_identity
    ADD CONSTRAINT fk404288b92ef007a6 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_node_registrations fk4129723ba992f594; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_node_registrations
    ADD CONSTRAINT fk4129723ba992f594 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: client_session_note fk5edfb00ff51c2736; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_note
    ADD CONSTRAINT fk5edfb00ff51c2736 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: user_session_note fk5edfb00ff51d3472; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_session_note
    ADD CONSTRAINT fk5edfb00ff51d3472 FOREIGN KEY (user_session) REFERENCES public.user_session(id);


--
-- Name: client_session_role fk_11b7sgqw18i532811v7o2dv76; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_role
    ADD CONSTRAINT fk_11b7sgqw18i532811v7o2dv76 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: redirect_uris fk_1burs8pb4ouj97h5wuppahv9f; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.redirect_uris
    ADD CONSTRAINT fk_1burs8pb4ouj97h5wuppahv9f FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: user_federation_provider fk_1fj32f6ptolw2qy60cd8n01e8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_provider
    ADD CONSTRAINT fk_1fj32f6ptolw2qy60cd8n01e8 FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session_prot_mapper fk_33a8sgqw18i532811v7o2dk89; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session_prot_mapper
    ADD CONSTRAINT fk_33a8sgqw18i532811v7o2dk89 FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: realm_required_credential fk_5hg65lybevavkqfki3kponh9v; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_required_credential
    ADD CONSTRAINT fk_5hg65lybevavkqfki3kponh9v FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_attribute fk_5hrm2vlf9ql5fu022kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu022kqepovbr FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: user_attribute fk_5hrm2vlf9ql5fu043kqepovbr; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_attribute
    ADD CONSTRAINT fk_5hrm2vlf9ql5fu043kqepovbr FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: user_required_action fk_6qj3w1jw9cvafhe19bwsiuvmd; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_required_action
    ADD CONSTRAINT fk_6qj3w1jw9cvafhe19bwsiuvmd FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: keycloak_role fk_6vyqfe4cn4wlq8r6kt5vdsj5c; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.keycloak_role
    ADD CONSTRAINT fk_6vyqfe4cn4wlq8r6kt5vdsj5c FOREIGN KEY (realm) REFERENCES public.realm(id);


--
-- Name: realm_smtp_config fk_70ej8xdxgxd0b9hh6180irr0o; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_smtp_config
    ADD CONSTRAINT fk_70ej8xdxgxd0b9hh6180irr0o FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_attribute fk_8shxd6l3e9atqukacxgpffptw; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_attribute
    ADD CONSTRAINT fk_8shxd6l3e9atqukacxgpffptw FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: composite_role fk_a63wvekftu8jo1pnj81e7mce2; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_a63wvekftu8jo1pnj81e7mce2 FOREIGN KEY (composite) REFERENCES public.keycloak_role(id);


--
-- Name: authentication_execution fk_auth_exec_flow; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_flow FOREIGN KEY (flow_id) REFERENCES public.authentication_flow(id);


--
-- Name: authentication_execution fk_auth_exec_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_execution
    ADD CONSTRAINT fk_auth_exec_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authentication_flow fk_auth_flow_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authentication_flow
    ADD CONSTRAINT fk_auth_flow_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: authenticator_config fk_auth_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.authenticator_config
    ADD CONSTRAINT fk_auth_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: client_session fk_b4ao2vcvat6ukau74wbwtfqo1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_session
    ADD CONSTRAINT fk_b4ao2vcvat6ukau74wbwtfqo1 FOREIGN KEY (session_id) REFERENCES public.user_session(id);


--
-- Name: user_role_mapping fk_c4fqv34p1mbylloxang7b1q3l; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_role_mapping
    ADD CONSTRAINT fk_c4fqv34p1mbylloxang7b1q3l FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: client_scope_attributes fk_cl_scope_attr_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_attributes
    ADD CONSTRAINT fk_cl_scope_attr_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_scope_role_mapping fk_cl_scope_rm_scope; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_scope_role_mapping
    ADD CONSTRAINT fk_cl_scope_rm_scope FOREIGN KEY (scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_user_session_note fk_cl_usr_ses_note; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_user_session_note
    ADD CONSTRAINT fk_cl_usr_ses_note FOREIGN KEY (client_session) REFERENCES public.client_session(id);


--
-- Name: protocol_mapper fk_cli_scope_mapper; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_cli_scope_mapper FOREIGN KEY (client_scope_id) REFERENCES public.client_scope(id);


--
-- Name: client_initial_access fk_client_init_acc_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.client_initial_access
    ADD CONSTRAINT fk_client_init_acc_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: component_config fk_component_config; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component_config
    ADD CONSTRAINT fk_component_config FOREIGN KEY (component_id) REFERENCES public.component(id);


--
-- Name: component fk_component_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.component
    ADD CONSTRAINT fk_component_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_default_groups fk_def_groups_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_default_groups
    ADD CONSTRAINT fk_def_groups_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_mapper_config fk_fedmapper_cfg; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper_config
    ADD CONSTRAINT fk_fedmapper_cfg FOREIGN KEY (user_federation_mapper_id) REFERENCES public.user_federation_mapper(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_fedprv; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_fedprv FOREIGN KEY (federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_federation_mapper fk_fedmapperpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_mapper
    ADD CONSTRAINT fk_fedmapperpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: associated_policy fk_frsr5s213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsr5s213xcx4wnkog82ssrfy FOREIGN KEY (associated_policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrasp13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrasp13xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog82sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82sspmt FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_resource fk_frsrho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_resource
    ADD CONSTRAINT fk_frsrho213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog83sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog83sspmt FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_server_perm_ticket fk_frsrho213xcx4wnkog84sspmt; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrho213xcx4wnkog84sspmt FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: associated_policy fk_frsrpas14xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.associated_policy
    ADD CONSTRAINT fk_frsrpas14xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: scope_policy fk_frsrpass3xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_policy
    ADD CONSTRAINT fk_frsrpass3xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_perm_ticket fk_frsrpo2128cx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_perm_ticket
    ADD CONSTRAINT fk_frsrpo2128cx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_server_policy fk_frsrpo213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_policy
    ADD CONSTRAINT fk_frsrpo213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: resource_scope fk_frsrpos13xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrpos13xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpos53xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpos53xcx4wnkog82ssrfy FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: resource_policy fk_frsrpp213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_policy
    ADD CONSTRAINT fk_frsrpp213xcx4wnkog82ssrfy FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: resource_scope fk_frsrps213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_scope
    ADD CONSTRAINT fk_frsrps213xcx4wnkog82ssrfy FOREIGN KEY (scope_id) REFERENCES public.resource_server_scope(id);


--
-- Name: resource_server_scope fk_frsrso213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_server_scope
    ADD CONSTRAINT fk_frsrso213xcx4wnkog82ssrfy FOREIGN KEY (resource_server_id) REFERENCES public.resource_server(id);


--
-- Name: composite_role fk_gr7thllb9lu8q4vqa4524jjy8; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.composite_role
    ADD CONSTRAINT fk_gr7thllb9lu8q4vqa4524jjy8 FOREIGN KEY (child_role) REFERENCES public.keycloak_role(id);


--
-- Name: user_consent_client_scope fk_grntcsnt_clsc_usc; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent_client_scope
    ADD CONSTRAINT fk_grntcsnt_clsc_usc FOREIGN KEY (user_consent_id) REFERENCES public.user_consent(id);


--
-- Name: user_consent fk_grntcsnt_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_consent
    ADD CONSTRAINT fk_grntcsnt_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: group_attribute fk_group_attribute_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_attribute
    ADD CONSTRAINT fk_group_attribute_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: group_role_mapping fk_group_role_group; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.group_role_mapping
    ADD CONSTRAINT fk_group_role_group FOREIGN KEY (group_id) REFERENCES public.keycloak_group(id);


--
-- Name: realm_enabled_event_types fk_h846o4h0w8epx5nwedrf5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_enabled_event_types
    ADD CONSTRAINT fk_h846o4h0w8epx5nwedrf5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: realm_events_listeners fk_h846o4h0w8epx5nxev9f5y69j; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_events_listeners
    ADD CONSTRAINT fk_h846o4h0w8epx5nxev9f5y69j FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: identity_provider_mapper fk_idpm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_mapper
    ADD CONSTRAINT fk_idpm_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: idp_mapper_config fk_idpmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.idp_mapper_config
    ADD CONSTRAINT fk_idpmconfig FOREIGN KEY (idp_mapper_id) REFERENCES public.identity_provider_mapper(id);


--
-- Name: web_origins fk_lojpho213xcx4wnkog82ssrfy; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.web_origins
    ADD CONSTRAINT fk_lojpho213xcx4wnkog82ssrfy FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: scope_mapping fk_ouse064plmlr732lxjcn1q5f1; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.scope_mapping
    ADD CONSTRAINT fk_ouse064plmlr732lxjcn1q5f1 FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: protocol_mapper fk_pcm_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper
    ADD CONSTRAINT fk_pcm_realm FOREIGN KEY (client_id) REFERENCES public.client(id);


--
-- Name: credential fk_pfyr0glasqyl0dei3kl69r6v0; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.credential
    ADD CONSTRAINT fk_pfyr0glasqyl0dei3kl69r6v0 FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: protocol_mapper_config fk_pmconfig; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.protocol_mapper_config
    ADD CONSTRAINT fk_pmconfig FOREIGN KEY (protocol_mapper_id) REFERENCES public.protocol_mapper(id);


--
-- Name: default_client_scope fk_r_def_cli_scope_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.default_client_scope
    ADD CONSTRAINT fk_r_def_cli_scope_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: required_action_provider fk_req_act_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.required_action_provider
    ADD CONSTRAINT fk_req_act_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: resource_uris fk_resource_server_uris; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.resource_uris
    ADD CONSTRAINT fk_resource_server_uris FOREIGN KEY (resource_id) REFERENCES public.resource_server_resource(id);


--
-- Name: role_attribute fk_role_attribute_id; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.role_attribute
    ADD CONSTRAINT fk_role_attribute_id FOREIGN KEY (role_id) REFERENCES public.keycloak_role(id);


--
-- Name: realm_supported_locales fk_supported_locales_realm; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.realm_supported_locales
    ADD CONSTRAINT fk_supported_locales_realm FOREIGN KEY (realm_id) REFERENCES public.realm(id);


--
-- Name: user_federation_config fk_t13hpu1j94r2ebpekr39x5eu5; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_federation_config
    ADD CONSTRAINT fk_t13hpu1j94r2ebpekr39x5eu5 FOREIGN KEY (user_federation_provider_id) REFERENCES public.user_federation_provider(id);


--
-- Name: user_group_membership fk_user_group_user; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.user_group_membership
    ADD CONSTRAINT fk_user_group_user FOREIGN KEY (user_id) REFERENCES public.user_entity(id);


--
-- Name: policy_config fkdc34197cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.policy_config
    ADD CONSTRAINT fkdc34197cf864c4e43 FOREIGN KEY (policy_id) REFERENCES public.resource_server_policy(id);


--
-- Name: identity_provider_config fkdc4897cf864c4e43; Type: FK CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.identity_provider_config
    ADD CONSTRAINT fkdc4897cf864c4e43 FOREIGN KEY (identity_provider_id) REFERENCES public.identity_provider(internal_id);


--
-- PostgreSQL database dump complete
--


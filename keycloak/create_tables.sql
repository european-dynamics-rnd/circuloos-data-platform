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
    name character varying(255) NOT NULL,
    value text
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
551809e1-118a-4d73-978c-7e927accea71	0dd01c06-ebe9-4bfc-9131-88960519ff0e
3cb79aaf-05cc-4017-a922-070725cc7262	ed205063-226f-4005-8ef9-5ba387cbd3e4
7055553f-c493-46f0-bb01-901f21cc78ed	541e3170-854b-4e16-9155-e484c3c119ff
\.


--
-- Data for Name: authentication_execution; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_execution (id, alias, authenticator, realm_id, flow_id, requirement, priority, authenticator_flow, auth_flow_id, auth_config) FROM stdin;
22bd1ff9-dffc-4c52-b8b0-a90bd4d50af4	\N	auth-cookie	793c40ee-e7c8-4e66-9f1c-f16bc168faba	3cb76c7f-0d5b-4268-a3b6-38fb2ce45824	2	10	f	\N	\N
7fe64dbe-79a5-4792-85fb-ef3a2c5656c5	\N	auth-spnego	793c40ee-e7c8-4e66-9f1c-f16bc168faba	3cb76c7f-0d5b-4268-a3b6-38fb2ce45824	3	20	f	\N	\N
8e20b53b-74bb-4cd3-ad04-254bf148bbaf	\N	identity-provider-redirector	793c40ee-e7c8-4e66-9f1c-f16bc168faba	3cb76c7f-0d5b-4268-a3b6-38fb2ce45824	2	25	f	\N	\N
ea3bdf48-293e-4ad8-8397-1289cf9fece8	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	3cb76c7f-0d5b-4268-a3b6-38fb2ce45824	2	30	t	99b81a8a-b8a8-4313-9c4f-76727ae52ed6	\N
253a233e-7fd9-437f-afb0-1fb543ba71d0	\N	auth-username-password-form	793c40ee-e7c8-4e66-9f1c-f16bc168faba	99b81a8a-b8a8-4313-9c4f-76727ae52ed6	0	10	f	\N	\N
417e5b0e-04fc-40f1-b912-2bfdf564b818	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	99b81a8a-b8a8-4313-9c4f-76727ae52ed6	1	20	t	3fe7056d-bc56-41de-800c-d2690d24f695	\N
0ead0630-dac9-41db-b3e5-c1d0fedd8b32	\N	conditional-user-configured	793c40ee-e7c8-4e66-9f1c-f16bc168faba	3fe7056d-bc56-41de-800c-d2690d24f695	0	10	f	\N	\N
b235540b-6745-4b8c-a1d8-927e54f26760	\N	auth-otp-form	793c40ee-e7c8-4e66-9f1c-f16bc168faba	3fe7056d-bc56-41de-800c-d2690d24f695	0	20	f	\N	\N
401786d5-5542-4230-999d-ec091218a1e3	\N	direct-grant-validate-username	793c40ee-e7c8-4e66-9f1c-f16bc168faba	772c785c-abcc-4dfb-bfc6-cb65b1f084d8	0	10	f	\N	\N
e9ed8b61-df96-4937-80e1-44edd35accb2	\N	direct-grant-validate-password	793c40ee-e7c8-4e66-9f1c-f16bc168faba	772c785c-abcc-4dfb-bfc6-cb65b1f084d8	0	20	f	\N	\N
515b8e19-ce5a-4d06-ac63-5a19a5f6aacc	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	772c785c-abcc-4dfb-bfc6-cb65b1f084d8	1	30	t	0f393ea5-28f5-45a6-80a2-44b741cc0f8c	\N
b4f13906-1bb1-45f5-9ed1-1cfa48042631	\N	conditional-user-configured	793c40ee-e7c8-4e66-9f1c-f16bc168faba	0f393ea5-28f5-45a6-80a2-44b741cc0f8c	0	10	f	\N	\N
47feaa8c-2bac-4259-8c58-ac158cb854fa	\N	direct-grant-validate-otp	793c40ee-e7c8-4e66-9f1c-f16bc168faba	0f393ea5-28f5-45a6-80a2-44b741cc0f8c	0	20	f	\N	\N
9697a42b-383d-4cb2-8de8-32a241362aa2	\N	registration-page-form	793c40ee-e7c8-4e66-9f1c-f16bc168faba	507aab55-bc22-4902-8f4b-5424967daf86	0	10	t	594e5f2d-8774-4f26-91ba-674e636dd260	\N
4aa67fd8-5d24-43c8-953e-07a36cee6cf7	\N	registration-user-creation	793c40ee-e7c8-4e66-9f1c-f16bc168faba	594e5f2d-8774-4f26-91ba-674e636dd260	0	20	f	\N	\N
1cbcb1f3-db01-441a-aa6b-0b39cb357f45	\N	registration-profile-action	793c40ee-e7c8-4e66-9f1c-f16bc168faba	594e5f2d-8774-4f26-91ba-674e636dd260	0	40	f	\N	\N
9d827868-6956-4d4b-96ff-6eb502390b81	\N	registration-password-action	793c40ee-e7c8-4e66-9f1c-f16bc168faba	594e5f2d-8774-4f26-91ba-674e636dd260	0	50	f	\N	\N
c01cbc72-e627-4aef-baa0-7fd48e250ffc	\N	registration-recaptcha-action	793c40ee-e7c8-4e66-9f1c-f16bc168faba	594e5f2d-8774-4f26-91ba-674e636dd260	3	60	f	\N	\N
f8a600f6-e600-49f9-a64e-269463b7c17d	\N	reset-credentials-choose-user	793c40ee-e7c8-4e66-9f1c-f16bc168faba	2ed611a9-ff56-48ac-9464-d11ff6978f78	0	10	f	\N	\N
cbb07a66-96de-4675-99ae-78bf04f19d2e	\N	reset-credential-email	793c40ee-e7c8-4e66-9f1c-f16bc168faba	2ed611a9-ff56-48ac-9464-d11ff6978f78	0	20	f	\N	\N
23ba86ca-faa0-4c46-9b21-07aa55cfa6d8	\N	reset-password	793c40ee-e7c8-4e66-9f1c-f16bc168faba	2ed611a9-ff56-48ac-9464-d11ff6978f78	0	30	f	\N	\N
1e23888a-9836-4eeb-9a5e-fc840314ab05	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	2ed611a9-ff56-48ac-9464-d11ff6978f78	1	40	t	252ca67e-c13f-450e-b8a8-ef110fae01ce	\N
3fe59ab8-84fc-4194-9142-599332497bf0	\N	conditional-user-configured	793c40ee-e7c8-4e66-9f1c-f16bc168faba	252ca67e-c13f-450e-b8a8-ef110fae01ce	0	10	f	\N	\N
9269d64a-ce68-4382-8e67-8ebbaf0ab1bd	\N	reset-otp	793c40ee-e7c8-4e66-9f1c-f16bc168faba	252ca67e-c13f-450e-b8a8-ef110fae01ce	0	20	f	\N	\N
ba029f26-f3ec-4e6f-84d7-971ff9155361	\N	client-secret	793c40ee-e7c8-4e66-9f1c-f16bc168faba	82fd0085-5b4f-45e4-b56e-3051eec4fce7	2	10	f	\N	\N
ba311e69-bda6-451b-a000-84c977feec6a	\N	client-jwt	793c40ee-e7c8-4e66-9f1c-f16bc168faba	82fd0085-5b4f-45e4-b56e-3051eec4fce7	2	20	f	\N	\N
5590eae0-731e-45d9-b62b-75799f6a3ed3	\N	client-secret-jwt	793c40ee-e7c8-4e66-9f1c-f16bc168faba	82fd0085-5b4f-45e4-b56e-3051eec4fce7	2	30	f	\N	\N
b52c058d-0860-44ad-8c92-a8085caea667	\N	client-x509	793c40ee-e7c8-4e66-9f1c-f16bc168faba	82fd0085-5b4f-45e4-b56e-3051eec4fce7	2	40	f	\N	\N
917a293a-6241-425f-8fbf-60dcb1caec75	\N	idp-review-profile	793c40ee-e7c8-4e66-9f1c-f16bc168faba	d39ed994-1dcf-4a81-93ed-93008f6471c7	0	10	f	\N	f603511d-43ef-4355-b123-8e85416d7249
4ca73ceb-3f7a-47bf-8e69-f50a4035217c	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	d39ed994-1dcf-4a81-93ed-93008f6471c7	0	20	t	91220ea4-7923-47e2-ab1c-f290f7527a9c	\N
fd667ab3-c744-44bd-8fa7-c538a3a087f4	\N	idp-create-user-if-unique	793c40ee-e7c8-4e66-9f1c-f16bc168faba	91220ea4-7923-47e2-ab1c-f290f7527a9c	2	10	f	\N	1d7d6e6f-a604-4425-ac9a-c52817903838
7b7fc043-e545-45ac-911b-c9db5bb3a647	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	91220ea4-7923-47e2-ab1c-f290f7527a9c	2	20	t	a54d01dd-a6e9-4c45-a456-86c68d507e2a	\N
aee26cde-a960-44da-8b83-a4deb6207646	\N	idp-confirm-link	793c40ee-e7c8-4e66-9f1c-f16bc168faba	a54d01dd-a6e9-4c45-a456-86c68d507e2a	0	10	f	\N	\N
41ff99a9-43af-4345-9d3f-e4c6474c301e	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	a54d01dd-a6e9-4c45-a456-86c68d507e2a	0	20	t	7cb20ffa-2e02-4558-9776-0220d5d252e3	\N
10b9263a-28a7-44b4-b756-13dd58202522	\N	idp-email-verification	793c40ee-e7c8-4e66-9f1c-f16bc168faba	7cb20ffa-2e02-4558-9776-0220d5d252e3	2	10	f	\N	\N
f6b6e779-a1a4-45d3-9fd8-dcca8fbeca5d	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	7cb20ffa-2e02-4558-9776-0220d5d252e3	2	20	t	a9664b59-a5db-4dbb-bf53-e3dec896378e	\N
3ff94f55-cdf4-42ea-a915-b9fea871eafa	\N	idp-username-password-form	793c40ee-e7c8-4e66-9f1c-f16bc168faba	a9664b59-a5db-4dbb-bf53-e3dec896378e	0	10	f	\N	\N
75b9edb8-6afe-4d67-8e1e-cf57ce6d8961	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	a9664b59-a5db-4dbb-bf53-e3dec896378e	1	20	t	46d228dc-f86f-4f0b-b22c-5b0b67e23cd0	\N
26788c7d-fa8d-4e1f-b1e9-4db912417059	\N	conditional-user-configured	793c40ee-e7c8-4e66-9f1c-f16bc168faba	46d228dc-f86f-4f0b-b22c-5b0b67e23cd0	0	10	f	\N	\N
f748e2ee-97af-447c-a2a8-5e02803fa211	\N	auth-otp-form	793c40ee-e7c8-4e66-9f1c-f16bc168faba	46d228dc-f86f-4f0b-b22c-5b0b67e23cd0	0	20	f	\N	\N
89232ec6-e023-4009-af17-8a6f34c6d6a3	\N	http-basic-authenticator	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b4632ed0-477d-43ea-a727-80527f9bdb02	0	10	f	\N	\N
fa34f8a5-cc03-44dd-b7e1-0e49ac7a8634	\N	docker-http-basic-authenticator	793c40ee-e7c8-4e66-9f1c-f16bc168faba	49ce0bad-2a9d-4094-bd74-bfc6147c2d3e	0	10	f	\N	\N
488db8a8-3865-40b7-8874-e0df36065c2b	\N	no-cookie-redirect	793c40ee-e7c8-4e66-9f1c-f16bc168faba	18eeb356-b5ad-4e7e-b2d3-d249566520a0	0	10	f	\N	\N
ae0f927f-60f3-4e41-b3b3-3dc592db9336	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	18eeb356-b5ad-4e7e-b2d3-d249566520a0	0	20	t	20b20c6b-5050-4d02-9fd1-dc5c6ac8aa22	\N
eb338130-d228-4bb1-8ab9-85df1cfd2792	\N	basic-auth	793c40ee-e7c8-4e66-9f1c-f16bc168faba	20b20c6b-5050-4d02-9fd1-dc5c6ac8aa22	0	10	f	\N	\N
3764532e-9393-421c-ae99-7ef82f848fb1	\N	basic-auth-otp	793c40ee-e7c8-4e66-9f1c-f16bc168faba	20b20c6b-5050-4d02-9fd1-dc5c6ac8aa22	3	20	f	\N	\N
4179a730-b6e6-4828-b239-97eced306e32	\N	auth-spnego	793c40ee-e7c8-4e66-9f1c-f16bc168faba	20b20c6b-5050-4d02-9fd1-dc5c6ac8aa22	3	30	f	\N	\N
b1730654-baae-4e26-bf53-51b8368d957f	\N	idp-email-verification	fiware-server	203b80cd-5050-40f3-a210-756d555e97d9	2	10	f	\N	\N
203abe2b-329c-489f-9877-c26a1c80d887	\N	\N	fiware-server	203b80cd-5050-40f3-a210-756d555e97d9	2	20	t	c12bcb31-7a21-4540-b6ae-ac006d218b92	\N
b8b4bfba-3ddc-48b6-a36c-f79c2e66b32e	\N	basic-auth	fiware-server	60ebe11e-5cd4-45b1-933b-3ebd807305fa	0	10	f	\N	\N
dc65a6bf-583f-456d-8e1e-cb7f8a82946d	\N	basic-auth-otp	fiware-server	60ebe11e-5cd4-45b1-933b-3ebd807305fa	3	20	f	\N	\N
77b6f7a2-9ef9-4753-838d-bf9f5830c5cd	\N	auth-spnego	fiware-server	60ebe11e-5cd4-45b1-933b-3ebd807305fa	3	30	f	\N	\N
a9ad6000-2d42-4b57-9cd8-19b691162e34	\N	conditional-user-configured	fiware-server	31266c9a-08e3-45a8-8efc-7dcee3393336	0	10	f	\N	\N
d37729c1-3a61-4089-9744-0cb9f309d084	\N	auth-otp-form	fiware-server	31266c9a-08e3-45a8-8efc-7dcee3393336	0	20	f	\N	\N
913e4e13-4ef0-4a77-8674-b3ab4dcb9dcc	\N	conditional-user-configured	fiware-server	47ae6827-d68b-4090-b408-1390cc2974b0	0	10	f	\N	\N
13143ba8-d807-4244-aafc-e769a3930182	\N	direct-grant-validate-otp	fiware-server	47ae6827-d68b-4090-b408-1390cc2974b0	0	20	f	\N	\N
52eeb52e-3783-438b-a79d-d1f239fdef51	\N	conditional-user-configured	fiware-server	25c4384a-d1f4-44cb-9900-21fda4916543	0	10	f	\N	\N
a43cd87c-c733-4ce6-beef-735b45ad3396	\N	auth-otp-form	fiware-server	25c4384a-d1f4-44cb-9900-21fda4916543	0	20	f	\N	\N
5d33aae8-8312-494e-806a-39bf467f4991	\N	idp-confirm-link	fiware-server	021bb47b-afe6-49ae-97e0-753e18776ce2	0	10	f	\N	\N
5971fa4c-1813-4c0d-8a98-60fda48e22a8	\N	\N	fiware-server	021bb47b-afe6-49ae-97e0-753e18776ce2	0	20	t	203b80cd-5050-40f3-a210-756d555e97d9	\N
9c893c0e-f977-42ef-801a-3badc0565465	\N	conditional-user-configured	fiware-server	67cbb524-e82a-4e4b-b845-714e73552311	0	10	f	\N	\N
773bc873-640e-4cf3-b54d-5e8e161ed8b7	\N	reset-otp	fiware-server	67cbb524-e82a-4e4b-b845-714e73552311	0	20	f	\N	\N
a3962f67-9755-409d-a0c0-9f266b637d07	\N	idp-create-user-if-unique	fiware-server	e9fd3d4a-d32b-4e52-9d9e-88eec250e0b5	2	10	f	\N	4e9eda84-35d9-47d1-8d0f-5202e8700404
0114ba73-764f-42b3-9d0e-10195263f2af	\N	\N	fiware-server	e9fd3d4a-d32b-4e52-9d9e-88eec250e0b5	2	20	t	021bb47b-afe6-49ae-97e0-753e18776ce2	\N
3ed8c013-a76b-443c-be53-8145ee7bf667	\N	idp-username-password-form	fiware-server	c12bcb31-7a21-4540-b6ae-ac006d218b92	0	10	f	\N	\N
65f61f64-a3b8-4e2e-bf89-3dba7d76300b	\N	\N	fiware-server	c12bcb31-7a21-4540-b6ae-ac006d218b92	1	20	t	25c4384a-d1f4-44cb-9900-21fda4916543	\N
d294e221-53d3-4e69-a233-eb2401ea04ec	\N	auth-cookie	fiware-server	a5ad4c62-21f1-443c-98fb-61d3001e0bfa	2	10	f	\N	\N
3672f8cf-7f87-4d75-a856-ec02bca0a7c6	\N	auth-spnego	fiware-server	a5ad4c62-21f1-443c-98fb-61d3001e0bfa	3	20	f	\N	\N
b6faa6dd-764e-4c4c-b5d2-a984201617a0	\N	identity-provider-redirector	fiware-server	a5ad4c62-21f1-443c-98fb-61d3001e0bfa	2	25	f	\N	\N
06eef40b-0920-4df1-9409-f635e352ab6f	\N	\N	fiware-server	a5ad4c62-21f1-443c-98fb-61d3001e0bfa	2	30	t	5f46ac0e-2b5c-49b4-9a26-b7670a7bd698	\N
269c5119-d899-4114-b336-21d7e455d6ef	\N	client-secret	fiware-server	03c27c88-c45f-41ab-bb52-82e610e92af3	2	10	f	\N	\N
2bca9d14-6eab-496b-80ce-b27ab2087fe4	\N	client-jwt	fiware-server	03c27c88-c45f-41ab-bb52-82e610e92af3	2	20	f	\N	\N
fd361c73-bbc9-46f0-83f9-585d58300d1c	\N	client-secret-jwt	fiware-server	03c27c88-c45f-41ab-bb52-82e610e92af3	2	30	f	\N	\N
b0b43b25-ea62-429c-b761-a76e76118029	\N	client-x509	fiware-server	03c27c88-c45f-41ab-bb52-82e610e92af3	2	40	f	\N	\N
2a8a9cc5-f7c0-41b7-9a23-9091d3f1c524	\N	direct-grant-validate-username	fiware-server	9fb405b1-de0d-4019-9fd1-74b94ebf14a4	0	10	f	\N	\N
0a69c851-4ed3-4cb5-9d59-77d73687c752	\N	direct-grant-validate-password	fiware-server	9fb405b1-de0d-4019-9fd1-74b94ebf14a4	0	20	f	\N	\N
51abdf5a-0b29-4421-9ec8-24586a60a837	\N	\N	fiware-server	9fb405b1-de0d-4019-9fd1-74b94ebf14a4	1	30	t	47ae6827-d68b-4090-b408-1390cc2974b0	\N
a2ab8169-4a6e-4e7c-a339-cad1307164ff	\N	docker-http-basic-authenticator	fiware-server	2f32c98b-38a7-476b-a097-78137415636d	0	10	f	\N	\N
8544e4ea-f9da-4d2f-aab0-801f8295303f	\N	idp-review-profile	fiware-server	5f3ce07f-1f9d-410a-b287-17a8afba977b	0	10	f	\N	dab7ee72-cf24-49df-bb02-317a24860b45
0d192be0-20ed-4354-8076-22272778def8	\N	\N	fiware-server	5f3ce07f-1f9d-410a-b287-17a8afba977b	0	20	t	e9fd3d4a-d32b-4e52-9d9e-88eec250e0b5	\N
5fd2c9b0-06f1-4753-b79a-5bf039319194	\N	auth-username-password-form	fiware-server	5f46ac0e-2b5c-49b4-9a26-b7670a7bd698	0	10	f	\N	\N
2e282505-acf8-47de-baaa-4ff2a91bea9e	\N	\N	fiware-server	5f46ac0e-2b5c-49b4-9a26-b7670a7bd698	1	20	t	31266c9a-08e3-45a8-8efc-7dcee3393336	\N
6df781d5-9d9e-4e83-bd32-bff5a8aea344	\N	no-cookie-redirect	fiware-server	2af51c7a-f2b4-4015-8951-44fdd4a662f4	0	10	f	\N	\N
d59b81de-a796-412b-8829-0f36fd923a43	\N	\N	fiware-server	2af51c7a-f2b4-4015-8951-44fdd4a662f4	0	20	t	60ebe11e-5cd4-45b1-933b-3ebd807305fa	\N
c098ac73-fd1a-4d01-bcc7-c3b1d5542933	\N	registration-page-form	fiware-server	414f6e7e-b9d5-4692-8447-124e416b3b95	0	10	t	aec849e2-c28e-492d-9d75-62d0a76efe86	\N
c9f1b313-60f3-4c52-80a2-b2f9e71f3051	\N	registration-user-creation	fiware-server	aec849e2-c28e-492d-9d75-62d0a76efe86	0	20	f	\N	\N
7f0c4ca9-4829-45a2-ae02-c5c4d68cee5f	\N	registration-profile-action	fiware-server	aec849e2-c28e-492d-9d75-62d0a76efe86	0	40	f	\N	\N
271a5b8e-b5d7-424c-a78c-7f8c7404cc4c	\N	registration-password-action	fiware-server	aec849e2-c28e-492d-9d75-62d0a76efe86	0	50	f	\N	\N
fcd77b77-ecad-46c5-9755-5b88f5b7cd1d	\N	registration-recaptcha-action	fiware-server	aec849e2-c28e-492d-9d75-62d0a76efe86	3	60	f	\N	\N
70fc6686-dc68-438d-bf65-69f0ce145c93	\N	reset-credentials-choose-user	fiware-server	23904f41-741a-477c-8646-3f16441ef855	0	10	f	\N	\N
2b222227-a2e4-45b4-8582-280eee34dace	\N	reset-credential-email	fiware-server	23904f41-741a-477c-8646-3f16441ef855	0	20	f	\N	\N
19196c35-71c0-4ca3-95a1-6458979b2a9d	\N	reset-password	fiware-server	23904f41-741a-477c-8646-3f16441ef855	0	30	f	\N	\N
01ea4c70-d521-44a6-9e32-eb72d51ecb91	\N	\N	fiware-server	23904f41-741a-477c-8646-3f16441ef855	1	40	t	67cbb524-e82a-4e4b-b845-714e73552311	\N
69618983-8bc9-4cbd-a40c-c88bae4618ce	\N	http-basic-authenticator	fiware-server	75036bac-49f2-4d60-908d-59fa19554585	0	10	f	\N	\N
\.


--
-- Data for Name: authentication_flow; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authentication_flow (id, alias, description, realm_id, provider_id, top_level, built_in) FROM stdin;
3cb76c7f-0d5b-4268-a3b6-38fb2ce45824	browser	browser based authentication	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
99b81a8a-b8a8-4313-9c4f-76727ae52ed6	forms	Username, password, otp and other auth forms.	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
3fe7056d-bc56-41de-800c-d2690d24f695	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
772c785c-abcc-4dfb-bfc6-cb65b1f084d8	direct grant	OpenID Connect Resource Owner Grant	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
0f393ea5-28f5-45a6-80a2-44b741cc0f8c	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
507aab55-bc22-4902-8f4b-5424967daf86	registration	registration flow	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
594e5f2d-8774-4f26-91ba-674e636dd260	registration form	registration form	793c40ee-e7c8-4e66-9f1c-f16bc168faba	form-flow	f	t
2ed611a9-ff56-48ac-9464-d11ff6978f78	reset credentials	Reset credentials for a user if they forgot their password or something	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
252ca67e-c13f-450e-b8a8-ef110fae01ce	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
82fd0085-5b4f-45e4-b56e-3051eec4fce7	clients	Base authentication for clients	793c40ee-e7c8-4e66-9f1c-f16bc168faba	client-flow	t	t
d39ed994-1dcf-4a81-93ed-93008f6471c7	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
91220ea4-7923-47e2-ab1c-f290f7527a9c	User creation or linking	Flow for the existing/non-existing user alternatives	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
a54d01dd-a6e9-4c45-a456-86c68d507e2a	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
7cb20ffa-2e02-4558-9776-0220d5d252e3	Account verification options	Method with which to verity the existing account	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
a9664b59-a5db-4dbb-bf53-e3dec896378e	Verify Existing Account by Re-authentication	Reauthentication of existing account	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
46d228dc-f86f-4f0b-b22c-5b0b67e23cd0	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
b4632ed0-477d-43ea-a727-80527f9bdb02	saml ecp	SAML ECP Profile Authentication Flow	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
49ce0bad-2a9d-4094-bd74-bfc6147c2d3e	docker auth	Used by Docker clients to authenticate against the IDP	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
18eeb356-b5ad-4e7e-b2d3-d249566520a0	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	t	t
20b20c6b-5050-4d02-9fd1-dc5c6ac8aa22	Authentication Options	Authentication options.	793c40ee-e7c8-4e66-9f1c-f16bc168faba	basic-flow	f	t
203b80cd-5050-40f3-a210-756d555e97d9	Account verification options	Method with which to verity the existing account	fiware-server	basic-flow	f	t
60ebe11e-5cd4-45b1-933b-3ebd807305fa	Authentication Options	Authentication options.	fiware-server	basic-flow	f	t
31266c9a-08e3-45a8-8efc-7dcee3393336	Browser - Conditional OTP	Flow to determine if the OTP is required for the authentication	fiware-server	basic-flow	f	t
47ae6827-d68b-4090-b408-1390cc2974b0	Direct Grant - Conditional OTP	Flow to determine if the OTP is required for the authentication	fiware-server	basic-flow	f	t
25c4384a-d1f4-44cb-9900-21fda4916543	First broker login - Conditional OTP	Flow to determine if the OTP is required for the authentication	fiware-server	basic-flow	f	t
021bb47b-afe6-49ae-97e0-753e18776ce2	Handle Existing Account	Handle what to do if there is existing account with same email/username like authenticated identity provider	fiware-server	basic-flow	f	t
67cbb524-e82a-4e4b-b845-714e73552311	Reset - Conditional OTP	Flow to determine if the OTP should be reset or not. Set to REQUIRED to force.	fiware-server	basic-flow	f	t
e9fd3d4a-d32b-4e52-9d9e-88eec250e0b5	User creation or linking	Flow for the existing/non-existing user alternatives	fiware-server	basic-flow	f	t
c12bcb31-7a21-4540-b6ae-ac006d218b92	Verify Existing Account by Re-authentication	Reauthentication of existing account	fiware-server	basic-flow	f	t
a5ad4c62-21f1-443c-98fb-61d3001e0bfa	browser	browser based authentication	fiware-server	basic-flow	t	t
03c27c88-c45f-41ab-bb52-82e610e92af3	clients	Base authentication for clients	fiware-server	client-flow	t	t
9fb405b1-de0d-4019-9fd1-74b94ebf14a4	direct grant	OpenID Connect Resource Owner Grant	fiware-server	basic-flow	t	t
2f32c98b-38a7-476b-a097-78137415636d	docker auth	Used by Docker clients to authenticate against the IDP	fiware-server	basic-flow	t	t
5f3ce07f-1f9d-410a-b287-17a8afba977b	first broker login	Actions taken after first broker login with identity provider account, which is not yet linked to any Keycloak account	fiware-server	basic-flow	t	t
5f46ac0e-2b5c-49b4-9a26-b7670a7bd698	forms	Username, password, otp and other auth forms.	fiware-server	basic-flow	f	t
2af51c7a-f2b4-4015-8951-44fdd4a662f4	http challenge	An authentication flow based on challenge-response HTTP Authentication Schemes	fiware-server	basic-flow	t	t
414f6e7e-b9d5-4692-8447-124e416b3b95	registration	registration flow	fiware-server	basic-flow	t	t
aec849e2-c28e-492d-9d75-62d0a76efe86	registration form	registration form	fiware-server	form-flow	f	t
23904f41-741a-477c-8646-3f16441ef855	reset credentials	Reset credentials for a user if they forgot their password or something	fiware-server	basic-flow	t	t
75036bac-49f2-4d60-908d-59fa19554585	saml ecp	SAML ECP Profile Authentication Flow	fiware-server	basic-flow	t	t
\.


--
-- Data for Name: authenticator_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config (id, alias, realm_id) FROM stdin;
f603511d-43ef-4355-b123-8e85416d7249	review profile config	793c40ee-e7c8-4e66-9f1c-f16bc168faba
1d7d6e6f-a604-4425-ac9a-c52817903838	create unique user config	793c40ee-e7c8-4e66-9f1c-f16bc168faba
4e9eda84-35d9-47d1-8d0f-5202e8700404	create unique user config	fiware-server
dab7ee72-cf24-49df-bb02-317a24860b45	review profile config	fiware-server
\.


--
-- Data for Name: authenticator_config_entry; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.authenticator_config_entry (authenticator_id, value, name) FROM stdin;
1d7d6e6f-a604-4425-ac9a-c52817903838	false	require.password.update.after.registration
f603511d-43ef-4355-b123-8e85416d7249	missing	update.profile.on.first.login
4e9eda84-35d9-47d1-8d0f-5202e8700404	false	require.password.update.after.registration
dab7ee72-cf24-49df-bb02-317a24860b45	missing	update.profile.on.first.login
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
c3978641-c47f-4196-97fa-a9616c3ff17f	t	f	master-realm	0	f	\N	\N	t	\N	f	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N	0	f	f	master Realm	f	client-secret	\N	\N	\N	t	f	f	f
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	f	account	0	t	\N	/realms/master/account/	f	\N	f	793c40ee-e7c8-4e66-9f1c-f16bc168faba	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
691d5659-72c2-4f78-b5de-4832d3d8caf6	t	f	account-console	0	t	\N	/realms/master/account/	f	\N	f	793c40ee-e7c8-4e66-9f1c-f16bc168faba	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
162efb0f-aaec-4907-a1ce-ce9d23547587	t	f	broker	0	f	\N	\N	t	\N	f	793c40ee-e7c8-4e66-9f1c-f16bc168faba	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	t	f	security-admin-console	0	t	\N	/admin/master/console/	f	\N	f	793c40ee-e7c8-4e66-9f1c-f16bc168faba	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
66cf91a1-edbd-4f59-8afd-ddeef47af828	t	f	admin-cli	0	t	\N	\N	f	\N	f	793c40ee-e7c8-4e66-9f1c-f16bc168faba	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
b1c34505-93d7-4e13-8128-e0c4280aa73f	t	f	fiware-server-realm	0	f	\N	\N	t	\N	f	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N	0	f	f	fiware-server Realm	f	client-secret	\N	\N	\N	t	f	f	f
631eb608-f712-491c-bce5-b9873d7d72a5	t	f	account	0	t	\N	/realms/fiware-server/account/	f	\N	f	fiware-server	openid-connect	0	f	f	${client_account}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
24225287-61ca-4a67-bb1f-1dfc9482d265	t	f	account-console	0	t	\N	/realms/fiware-server/account/	f	\N	f	fiware-server	openid-connect	0	f	f	${client_account-console}	f	client-secret	${authBaseUrl}	\N	\N	t	f	f	f
7c468e16-23ac-4998-97cc-84950d801ad0	t	t	mintaka-pep	0	f	zQXGjcxPWuF7YBpAiFtaIOEIOrCiWqeH	http://circuloos-mintaka	f	http://circuloos-mintaka	f	fiware-server	openid-connect	-1	f	f		t	client-secret			\N	t	f	t	f
1d7678b6-8c20-4ff6-b065-f38662242012	t	f	admin-cli	0	t	\N	\N	f	\N	f	fiware-server	openid-connect	0	f	f	${client_admin-cli}	f	client-secret	\N	\N	\N	f	f	t	f
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	t	f	broker	0	f	\N	\N	t	\N	f	fiware-server	openid-connect	0	f	f	${client_broker}	f	client-secret	\N	\N	\N	t	f	f	f
936c2448-f2d8-41f0-8f92-f95a81341302	t	f	realm-management	0	f	\N	\N	t	\N	f	fiware-server	openid-connect	0	f	f	${client_realm-management}	f	client-secret	\N	\N	\N	t	f	f	f
c85b4883-afd1-459d-9d8f-88e735e3f184	t	f	security-admin-console	0	t	\N	/admin/fiware-server/console/	f	\N	f	fiware-server	openid-connect	0	f	f	${client_security-admin-console}	f	client-secret	${authAdminUrl}	\N	\N	t	f	f	f
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	t	t	orion-pep	0	f	yWv2aRCm3KKMGrj9lMXQcEXY4v80tcFk	http://circuloos-orion	f	http://circuloos-orion	f	fiware-server	openid-connect	-1	f	f		t	client-secret			\N	t	f	t	f
\.


--
-- Data for Name: client_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_attributes (client_id, name, value) FROM stdin;
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	post.logout.redirect.uris	+
691d5659-72c2-4f78-b5de-4832d3d8caf6	post.logout.redirect.uris	+
691d5659-72c2-4f78-b5de-4832d3d8caf6	pkce.code.challenge.method	S256
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	post.logout.redirect.uris	+
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	pkce.code.challenge.method	S256
631eb608-f712-491c-bce5-b9873d7d72a5	post.logout.redirect.uris	+
24225287-61ca-4a67-bb1f-1dfc9482d265	post.logout.redirect.uris	+
24225287-61ca-4a67-bb1f-1dfc9482d265	pkce.code.challenge.method	S256
1d7678b6-8c20-4ff6-b065-f38662242012	post.logout.redirect.uris	+
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	post.logout.redirect.uris	+
936c2448-f2d8-41f0-8f92-f95a81341302	post.logout.redirect.uris	+
c85b4883-afd1-459d-9d8f-88e735e3f184	post.logout.redirect.uris	+
c85b4883-afd1-459d-9d8f-88e735e3f184	pkce.code.challenge.method	S256
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	oauth2.device.authorization.grant.enabled	false
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	oidc.ciba.grant.enabled	false
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	display.on.consent.screen	false
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	backchannel.logout.revoke.offline.tokens	false
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	backchannel.logout.session.required	true
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	client.secret.creation.time	1696404919
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	post.logout.redirect.uris	+
7c468e16-23ac-4998-97cc-84950d801ad0	backchannel.logout.revoke.offline.tokens	false
7c468e16-23ac-4998-97cc-84950d801ad0	backchannel.logout.session.required	true
7c468e16-23ac-4998-97cc-84950d801ad0	client.secret.creation.time	1696418688
7c468e16-23ac-4998-97cc-84950d801ad0	display.on.consent.screen	false
7c468e16-23ac-4998-97cc-84950d801ad0	oauth2.device.authorization.grant.enabled	false
7c468e16-23ac-4998-97cc-84950d801ad0	oidc.ciba.grant.enabled	false
7c468e16-23ac-4998-97cc-84950d801ad0	post.logout.redirect.uris	+
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
4a4d3081-78d4-4246-9f5d-fbfea5b16f39	offline_access	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect built-in scope: offline_access	openid-connect
994a47b2-aac3-45dd-b548-51783d733859	role_list	793c40ee-e7c8-4e66-9f1c-f16bc168faba	SAML role list	saml
e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	profile	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect built-in scope: profile	openid-connect
f0182005-5e27-48cc-b5fe-add7123e9ccb	email	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect built-in scope: email	openid-connect
71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	address	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect built-in scope: address	openid-connect
4767f6ce-ba60-4040-bad0-9112fcac3d96	phone	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect built-in scope: phone	openid-connect
00588fda-f105-4024-8ac3-3449cba23aae	roles	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect scope for add user roles to the access token	openid-connect
2d7e87ee-3a83-44a1-ac5b-cf7312611427	web-origins	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect scope for add allowed web origins to the access token	openid-connect
74194b40-0439-449b-87c0-4c6f55919642	microprofile-jwt	793c40ee-e7c8-4e66-9f1c-f16bc168faba	Microprofile - JWT built-in scope	openid-connect
673f0ad8-8195-4ca4-9366-06eb6107edf5	acr	793c40ee-e7c8-4e66-9f1c-f16bc168faba	OpenID Connect scope for add acr (authentication context class reference) to the token	openid-connect
f1164b55-b30c-4baa-a08f-093bd09ddd62	phone	fiware-server	OpenID Connect built-in scope: phone	openid-connect
3077f964-343d-4ab4-ad61-98ed2088b520	web-origins	fiware-server	OpenID Connect scope for add allowed web origins to the access token	openid-connect
e629ea16-e59c-4ae7-8130-0a05a16a4d51	fiware-scope	fiware-server	\N	openid-connect
c43a27a3-54c7-4f47-a963-a5428676d666	offline_access	fiware-server	OpenID Connect built-in scope: offline_access	openid-connect
96b86330-6560-448e-b80f-f6a9c34a8349	role_list	fiware-server	SAML role list	saml
8d32b4b2-f351-4182-98fa-d25b657a981f	microprofile-jwt	fiware-server	Microprofile - JWT built-in scope	openid-connect
ffcdff24-fb2c-4744-b9e2-f249166d2a58	profile	fiware-server	OpenID Connect built-in scope: profile	openid-connect
2370700b-64c3-4047-9ce8-6fbfde4fd04d	address	fiware-server	OpenID Connect built-in scope: address	openid-connect
68255313-fc10-4e6c-a316-cd6f1cbd608e	email	fiware-server	OpenID Connect built-in scope: email	openid-connect
7fd06f00-0061-4d12-86fa-41b9a2f5122c	roles	fiware-server	OpenID Connect scope for add user roles to the access token	openid-connect
\.


--
-- Data for Name: client_scope_attributes; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_attributes (scope_id, value, name) FROM stdin;
4a4d3081-78d4-4246-9f5d-fbfea5b16f39	true	display.on.consent.screen
4a4d3081-78d4-4246-9f5d-fbfea5b16f39	${offlineAccessScopeConsentText}	consent.screen.text
994a47b2-aac3-45dd-b548-51783d733859	true	display.on.consent.screen
994a47b2-aac3-45dd-b548-51783d733859	${samlRoleListScopeConsentText}	consent.screen.text
e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	true	display.on.consent.screen
e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	${profileScopeConsentText}	consent.screen.text
e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	true	include.in.token.scope
f0182005-5e27-48cc-b5fe-add7123e9ccb	true	display.on.consent.screen
f0182005-5e27-48cc-b5fe-add7123e9ccb	${emailScopeConsentText}	consent.screen.text
f0182005-5e27-48cc-b5fe-add7123e9ccb	true	include.in.token.scope
71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	true	display.on.consent.screen
71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	${addressScopeConsentText}	consent.screen.text
71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	true	include.in.token.scope
4767f6ce-ba60-4040-bad0-9112fcac3d96	true	display.on.consent.screen
4767f6ce-ba60-4040-bad0-9112fcac3d96	${phoneScopeConsentText}	consent.screen.text
4767f6ce-ba60-4040-bad0-9112fcac3d96	true	include.in.token.scope
00588fda-f105-4024-8ac3-3449cba23aae	true	display.on.consent.screen
00588fda-f105-4024-8ac3-3449cba23aae	${rolesScopeConsentText}	consent.screen.text
00588fda-f105-4024-8ac3-3449cba23aae	false	include.in.token.scope
2d7e87ee-3a83-44a1-ac5b-cf7312611427	false	display.on.consent.screen
2d7e87ee-3a83-44a1-ac5b-cf7312611427		consent.screen.text
2d7e87ee-3a83-44a1-ac5b-cf7312611427	false	include.in.token.scope
74194b40-0439-449b-87c0-4c6f55919642	false	display.on.consent.screen
74194b40-0439-449b-87c0-4c6f55919642	true	include.in.token.scope
673f0ad8-8195-4ca4-9366-06eb6107edf5	false	display.on.consent.screen
673f0ad8-8195-4ca4-9366-06eb6107edf5	false	include.in.token.scope
f1164b55-b30c-4baa-a08f-093bd09ddd62	true	include.in.token.scope
f1164b55-b30c-4baa-a08f-093bd09ddd62	true	display.on.consent.screen
f1164b55-b30c-4baa-a08f-093bd09ddd62	${phoneScopeConsentText}	consent.screen.text
3077f964-343d-4ab4-ad61-98ed2088b520	false	include.in.token.scope
3077f964-343d-4ab4-ad61-98ed2088b520	false	display.on.consent.screen
3077f964-343d-4ab4-ad61-98ed2088b520		consent.screen.text
e629ea16-e59c-4ae7-8130-0a05a16a4d51	true	include.in.token.scope
e629ea16-e59c-4ae7-8130-0a05a16a4d51	false	display.on.consent.screen
c43a27a3-54c7-4f47-a963-a5428676d666	${offlineAccessScopeConsentText}	consent.screen.text
c43a27a3-54c7-4f47-a963-a5428676d666	true	display.on.consent.screen
96b86330-6560-448e-b80f-f6a9c34a8349	${samlRoleListScopeConsentText}	consent.screen.text
96b86330-6560-448e-b80f-f6a9c34a8349	true	display.on.consent.screen
8d32b4b2-f351-4182-98fa-d25b657a981f	true	include.in.token.scope
8d32b4b2-f351-4182-98fa-d25b657a981f	false	display.on.consent.screen
ffcdff24-fb2c-4744-b9e2-f249166d2a58	true	include.in.token.scope
ffcdff24-fb2c-4744-b9e2-f249166d2a58	true	display.on.consent.screen
ffcdff24-fb2c-4744-b9e2-f249166d2a58	${profileScopeConsentText}	consent.screen.text
2370700b-64c3-4047-9ce8-6fbfde4fd04d	true	include.in.token.scope
2370700b-64c3-4047-9ce8-6fbfde4fd04d	true	display.on.consent.screen
2370700b-64c3-4047-9ce8-6fbfde4fd04d	${addressScopeConsentText}	consent.screen.text
68255313-fc10-4e6c-a316-cd6f1cbd608e	true	include.in.token.scope
68255313-fc10-4e6c-a316-cd6f1cbd608e	true	display.on.consent.screen
68255313-fc10-4e6c-a316-cd6f1cbd608e	${emailScopeConsentText}	consent.screen.text
7fd06f00-0061-4d12-86fa-41b9a2f5122c	false	include.in.token.scope
7fd06f00-0061-4d12-86fa-41b9a2f5122c	true	display.on.consent.screen
7fd06f00-0061-4d12-86fa-41b9a2f5122c	${rolesScopeConsentText}	consent.screen.text
\.


--
-- Data for Name: client_scope_client; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_client (client_id, scope_id, default_scope) FROM stdin;
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	f0182005-5e27-48cc-b5fe-add7123e9ccb	t
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	2d7e87ee-3a83-44a1-ac5b-cf7312611427	t
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	00588fda-f105-4024-8ac3-3449cba23aae	t
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	t
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	673f0ad8-8195-4ca4-9366-06eb6107edf5	t
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	f
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	4767f6ce-ba60-4040-bad0-9112fcac3d96	f
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	74194b40-0439-449b-87c0-4c6f55919642	f
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	4a4d3081-78d4-4246-9f5d-fbfea5b16f39	f
691d5659-72c2-4f78-b5de-4832d3d8caf6	f0182005-5e27-48cc-b5fe-add7123e9ccb	t
691d5659-72c2-4f78-b5de-4832d3d8caf6	2d7e87ee-3a83-44a1-ac5b-cf7312611427	t
691d5659-72c2-4f78-b5de-4832d3d8caf6	00588fda-f105-4024-8ac3-3449cba23aae	t
691d5659-72c2-4f78-b5de-4832d3d8caf6	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	t
691d5659-72c2-4f78-b5de-4832d3d8caf6	673f0ad8-8195-4ca4-9366-06eb6107edf5	t
691d5659-72c2-4f78-b5de-4832d3d8caf6	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	f
691d5659-72c2-4f78-b5de-4832d3d8caf6	4767f6ce-ba60-4040-bad0-9112fcac3d96	f
691d5659-72c2-4f78-b5de-4832d3d8caf6	74194b40-0439-449b-87c0-4c6f55919642	f
691d5659-72c2-4f78-b5de-4832d3d8caf6	4a4d3081-78d4-4246-9f5d-fbfea5b16f39	f
66cf91a1-edbd-4f59-8afd-ddeef47af828	f0182005-5e27-48cc-b5fe-add7123e9ccb	t
66cf91a1-edbd-4f59-8afd-ddeef47af828	2d7e87ee-3a83-44a1-ac5b-cf7312611427	t
66cf91a1-edbd-4f59-8afd-ddeef47af828	00588fda-f105-4024-8ac3-3449cba23aae	t
66cf91a1-edbd-4f59-8afd-ddeef47af828	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	t
66cf91a1-edbd-4f59-8afd-ddeef47af828	673f0ad8-8195-4ca4-9366-06eb6107edf5	t
66cf91a1-edbd-4f59-8afd-ddeef47af828	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	f
66cf91a1-edbd-4f59-8afd-ddeef47af828	4767f6ce-ba60-4040-bad0-9112fcac3d96	f
66cf91a1-edbd-4f59-8afd-ddeef47af828	74194b40-0439-449b-87c0-4c6f55919642	f
66cf91a1-edbd-4f59-8afd-ddeef47af828	4a4d3081-78d4-4246-9f5d-fbfea5b16f39	f
162efb0f-aaec-4907-a1ce-ce9d23547587	f0182005-5e27-48cc-b5fe-add7123e9ccb	t
162efb0f-aaec-4907-a1ce-ce9d23547587	2d7e87ee-3a83-44a1-ac5b-cf7312611427	t
162efb0f-aaec-4907-a1ce-ce9d23547587	00588fda-f105-4024-8ac3-3449cba23aae	t
162efb0f-aaec-4907-a1ce-ce9d23547587	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	t
162efb0f-aaec-4907-a1ce-ce9d23547587	673f0ad8-8195-4ca4-9366-06eb6107edf5	t
162efb0f-aaec-4907-a1ce-ce9d23547587	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	f
162efb0f-aaec-4907-a1ce-ce9d23547587	4767f6ce-ba60-4040-bad0-9112fcac3d96	f
162efb0f-aaec-4907-a1ce-ce9d23547587	74194b40-0439-449b-87c0-4c6f55919642	f
162efb0f-aaec-4907-a1ce-ce9d23547587	4a4d3081-78d4-4246-9f5d-fbfea5b16f39	f
c3978641-c47f-4196-97fa-a9616c3ff17f	f0182005-5e27-48cc-b5fe-add7123e9ccb	t
c3978641-c47f-4196-97fa-a9616c3ff17f	2d7e87ee-3a83-44a1-ac5b-cf7312611427	t
c3978641-c47f-4196-97fa-a9616c3ff17f	00588fda-f105-4024-8ac3-3449cba23aae	t
c3978641-c47f-4196-97fa-a9616c3ff17f	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	t
c3978641-c47f-4196-97fa-a9616c3ff17f	673f0ad8-8195-4ca4-9366-06eb6107edf5	t
c3978641-c47f-4196-97fa-a9616c3ff17f	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	f
c3978641-c47f-4196-97fa-a9616c3ff17f	4767f6ce-ba60-4040-bad0-9112fcac3d96	f
c3978641-c47f-4196-97fa-a9616c3ff17f	74194b40-0439-449b-87c0-4c6f55919642	f
c3978641-c47f-4196-97fa-a9616c3ff17f	4a4d3081-78d4-4246-9f5d-fbfea5b16f39	f
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	f0182005-5e27-48cc-b5fe-add7123e9ccb	t
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	2d7e87ee-3a83-44a1-ac5b-cf7312611427	t
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	00588fda-f105-4024-8ac3-3449cba23aae	t
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	t
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	673f0ad8-8195-4ca4-9366-06eb6107edf5	t
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	f
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	4767f6ce-ba60-4040-bad0-9112fcac3d96	f
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	74194b40-0439-449b-87c0-4c6f55919642	f
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	4a4d3081-78d4-4246-9f5d-fbfea5b16f39	f
631eb608-f712-491c-bce5-b9873d7d72a5	3077f964-343d-4ab4-ad61-98ed2088b520	t
631eb608-f712-491c-bce5-b9873d7d72a5	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
631eb608-f712-491c-bce5-b9873d7d72a5	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
631eb608-f712-491c-bce5-b9873d7d72a5	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
631eb608-f712-491c-bce5-b9873d7d72a5	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
631eb608-f712-491c-bce5-b9873d7d72a5	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
631eb608-f712-491c-bce5-b9873d7d72a5	c43a27a3-54c7-4f47-a963-a5428676d666	f
631eb608-f712-491c-bce5-b9873d7d72a5	8d32b4b2-f351-4182-98fa-d25b657a981f	f
24225287-61ca-4a67-bb1f-1dfc9482d265	3077f964-343d-4ab4-ad61-98ed2088b520	t
24225287-61ca-4a67-bb1f-1dfc9482d265	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
24225287-61ca-4a67-bb1f-1dfc9482d265	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
24225287-61ca-4a67-bb1f-1dfc9482d265	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
24225287-61ca-4a67-bb1f-1dfc9482d265	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
24225287-61ca-4a67-bb1f-1dfc9482d265	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
24225287-61ca-4a67-bb1f-1dfc9482d265	c43a27a3-54c7-4f47-a963-a5428676d666	f
24225287-61ca-4a67-bb1f-1dfc9482d265	8d32b4b2-f351-4182-98fa-d25b657a981f	f
1d7678b6-8c20-4ff6-b065-f38662242012	3077f964-343d-4ab4-ad61-98ed2088b520	t
1d7678b6-8c20-4ff6-b065-f38662242012	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
1d7678b6-8c20-4ff6-b065-f38662242012	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
1d7678b6-8c20-4ff6-b065-f38662242012	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
1d7678b6-8c20-4ff6-b065-f38662242012	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
1d7678b6-8c20-4ff6-b065-f38662242012	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
1d7678b6-8c20-4ff6-b065-f38662242012	c43a27a3-54c7-4f47-a963-a5428676d666	f
1d7678b6-8c20-4ff6-b065-f38662242012	8d32b4b2-f351-4182-98fa-d25b657a981f	f
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	3077f964-343d-4ab4-ad61-98ed2088b520	t
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	c43a27a3-54c7-4f47-a963-a5428676d666	f
26c5c4cd-41f8-404a-8389-1c1c98c13b4b	8d32b4b2-f351-4182-98fa-d25b657a981f	f
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	3077f964-343d-4ab4-ad61-98ed2088b520	t
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	e629ea16-e59c-4ae7-8130-0a05a16a4d51	t
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	c43a27a3-54c7-4f47-a963-a5428676d666	f
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	8d32b4b2-f351-4182-98fa-d25b657a981f	f
936c2448-f2d8-41f0-8f92-f95a81341302	3077f964-343d-4ab4-ad61-98ed2088b520	t
936c2448-f2d8-41f0-8f92-f95a81341302	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
936c2448-f2d8-41f0-8f92-f95a81341302	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
936c2448-f2d8-41f0-8f92-f95a81341302	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
936c2448-f2d8-41f0-8f92-f95a81341302	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
936c2448-f2d8-41f0-8f92-f95a81341302	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
936c2448-f2d8-41f0-8f92-f95a81341302	c43a27a3-54c7-4f47-a963-a5428676d666	f
936c2448-f2d8-41f0-8f92-f95a81341302	8d32b4b2-f351-4182-98fa-d25b657a981f	f
c85b4883-afd1-459d-9d8f-88e735e3f184	3077f964-343d-4ab4-ad61-98ed2088b520	t
c85b4883-afd1-459d-9d8f-88e735e3f184	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
c85b4883-afd1-459d-9d8f-88e735e3f184	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
c85b4883-afd1-459d-9d8f-88e735e3f184	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
c85b4883-afd1-459d-9d8f-88e735e3f184	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
c85b4883-afd1-459d-9d8f-88e735e3f184	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
c85b4883-afd1-459d-9d8f-88e735e3f184	c43a27a3-54c7-4f47-a963-a5428676d666	f
c85b4883-afd1-459d-9d8f-88e735e3f184	8d32b4b2-f351-4182-98fa-d25b657a981f	f
7c468e16-23ac-4998-97cc-84950d801ad0	3077f964-343d-4ab4-ad61-98ed2088b520	t
7c468e16-23ac-4998-97cc-84950d801ad0	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
7c468e16-23ac-4998-97cc-84950d801ad0	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
7c468e16-23ac-4998-97cc-84950d801ad0	e629ea16-e59c-4ae7-8130-0a05a16a4d51	t
7c468e16-23ac-4998-97cc-84950d801ad0	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
7c468e16-23ac-4998-97cc-84950d801ad0	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
7c468e16-23ac-4998-97cc-84950d801ad0	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
7c468e16-23ac-4998-97cc-84950d801ad0	c43a27a3-54c7-4f47-a963-a5428676d666	f
7c468e16-23ac-4998-97cc-84950d801ad0	8d32b4b2-f351-4182-98fa-d25b657a981f	f
\.


--
-- Data for Name: client_scope_role_mapping; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.client_scope_role_mapping (scope_id, role_id) FROM stdin;
4a4d3081-78d4-4246-9f5d-fbfea5b16f39	ea7aaccc-4b43-41f6-b5a2-26a8dac82569
c43a27a3-54c7-4f47-a963-a5428676d666	88e8d0e1-fc32-47df-be80-7b6496d01b76
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
1cd7391e-0873-4d01-a4e3-e55559b47538	Trusted Hosts	793c40ee-e7c8-4e66-9f1c-f16bc168faba	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	anonymous
751bbcee-ad12-4c73-a94b-b1945488e720	Consent Required	793c40ee-e7c8-4e66-9f1c-f16bc168faba	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	anonymous
0d933128-7e57-4bc5-b6a6-6a73a6e6f187	Full Scope Disabled	793c40ee-e7c8-4e66-9f1c-f16bc168faba	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	anonymous
8123afc0-ef84-4008-93a7-9a26cecfedfa	Max Clients Limit	793c40ee-e7c8-4e66-9f1c-f16bc168faba	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	anonymous
bfa070da-31a6-4693-8ffd-7b95d25b2061	Allowed Protocol Mapper Types	793c40ee-e7c8-4e66-9f1c-f16bc168faba	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	anonymous
dfd0b369-8b27-4293-910b-db848161aedd	Allowed Client Scopes	793c40ee-e7c8-4e66-9f1c-f16bc168faba	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	anonymous
90520eee-0ed5-46b2-90ca-dca508ebdcf7	Allowed Protocol Mapper Types	793c40ee-e7c8-4e66-9f1c-f16bc168faba	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	authenticated
8d50dd73-80d9-48a0-b124-83a241dd4bb6	Allowed Client Scopes	793c40ee-e7c8-4e66-9f1c-f16bc168faba	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	authenticated
60f2ff74-8ee7-4191-abd7-3aed9d429b6b	rsa-generated	793c40ee-e7c8-4e66-9f1c-f16bc168faba	rsa-generated	org.keycloak.keys.KeyProvider	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N
c99b3459-10e2-4bad-888a-7ffef6ba7182	rsa-enc-generated	793c40ee-e7c8-4e66-9f1c-f16bc168faba	rsa-enc-generated	org.keycloak.keys.KeyProvider	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N
9f6a1b18-0a58-4f4b-b995-79bc67ec6e0d	hmac-generated	793c40ee-e7c8-4e66-9f1c-f16bc168faba	hmac-generated	org.keycloak.keys.KeyProvider	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N
b77e41ef-0593-49ec-a0ab-cd258d9b5039	aes-generated	793c40ee-e7c8-4e66-9f1c-f16bc168faba	aes-generated	org.keycloak.keys.KeyProvider	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N
3614e55b-a4ff-41e2-95e3-205839eae945	Allowed Client Scopes	fiware-server	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
e58e3802-e94c-4a18-92d2-ac9cd5b450ca	Allowed Protocol Mapper Types	fiware-server	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	authenticated
505854f4-15ea-4b7d-933f-626f2c5e4848	Full Scope Disabled	fiware-server	scope	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
c88160bf-e1b1-4421-a002-0dd0cfcfb3f4	Trusted Hosts	fiware-server	trusted-hosts	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
5f646e62-5508-4186-9db0-65a1738fc07f	Consent Required	fiware-server	consent-required	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
656259b4-2824-434b-ac9d-1e76695bbd81	Max Clients Limit	fiware-server	max-clients	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	Allowed Protocol Mapper Types	fiware-server	allowed-protocol-mappers	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	anonymous
85961b8b-2194-4f35-8848-47cbaaa86d36	Allowed Client Scopes	fiware-server	allowed-client-templates	org.keycloak.services.clientregistration.policy.ClientRegistrationPolicy	fiware-server	authenticated
388e0d45-420f-43ca-b7c3-e9117cc1ec71	rsa-generated	fiware-server	rsa-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
ac96a6a7-2480-4f80-b322-dbb61f620941	hmac-generated	fiware-server	hmac-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
874975d4-63ae-4c5b-a44a-3a2ab9e3ee7f	rsa-enc-generated	fiware-server	rsa-enc-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
f53a6738-bb3f-4df4-8cc9-29adda713b54	aes-generated	fiware-server	aes-generated	org.keycloak.keys.KeyProvider	fiware-server	\N
\.


--
-- Data for Name: component_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.component_config (id, component_id, name, value) FROM stdin;
e91e7de7-345d-4457-9f67-6e3da8a81dd6	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	oidc-address-mapper
82ce9528-ad5a-4728-93ee-28a6dc3a4bef	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	saml-user-property-mapper
0af266ec-3418-4e02-be9b-669a2029d880	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	oidc-full-name-mapper
27abf0d2-b3e1-4f2e-9dab-ba409d0fb3cf	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
5e661867-6269-43ec-9ee5-de1fe6b52eb8	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
560fff84-f844-4ad0-86d2-f7db6a3c7160	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	saml-role-list-mapper
b1b20dd5-2425-4efe-8ac4-297363821ce8	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	saml-user-attribute-mapper
b0bc8bf8-7826-4bed-8105-7c5e7936afb8	bfa070da-31a6-4693-8ffd-7b95d25b2061	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
ef95bffd-a017-4e5b-ae0d-ee754a0b594c	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	oidc-address-mapper
bb22b229-d00e-474d-8e13-3f575da9437f	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	saml-role-list-mapper
4236bd3f-d590-453d-931a-0bd024c35fcb	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
acf829ed-2937-4cf4-b9e2-1933c59ba3b3	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	oidc-full-name-mapper
c4ee02f4-3770-4a6e-8bb7-6aea06e1077c	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	saml-user-property-mapper
bd868edf-8ead-4556-ac01-e05d8d3f9f7a	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
28b95f3b-1baa-4b5a-bf96-da013791d6df	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
da190c4b-74f7-4ac1-96ec-31990a7bd362	90520eee-0ed5-46b2-90ca-dca508ebdcf7	allowed-protocol-mapper-types	saml-user-attribute-mapper
f80f9716-440a-4cc4-993a-3c6aa0ad7fd0	1cd7391e-0873-4d01-a4e3-e55559b47538	client-uris-must-match	true
c58620c1-db09-4c77-9440-5c20b1486974	1cd7391e-0873-4d01-a4e3-e55559b47538	host-sending-registration-request-must-match	true
77818916-b5a4-4bf5-94f0-839dc03c40d2	8123afc0-ef84-4008-93a7-9a26cecfedfa	max-clients	200
72ff3da3-edba-4415-b0a2-8bb4315c4500	8d50dd73-80d9-48a0-b124-83a241dd4bb6	allow-default-scopes	true
9da475f7-13e8-40c5-ad70-f023903cd26d	dfd0b369-8b27-4293-910b-db848161aedd	allow-default-scopes	true
894f7be1-e6f7-419b-aff6-df668c07390d	60f2ff74-8ee7-4191-abd7-3aed9d429b6b	keyUse	SIG
299878ed-e533-40ce-a292-e4e95c370452	60f2ff74-8ee7-4191-abd7-3aed9d429b6b	certificate	MIICmzCCAYMCBgGK+XfIHzANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMxMDA0MDY1MzExWhcNMzMxMDA0MDY1NDUxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC1P2iN5eE0QhT9bDXM06INRhMgq7PpH5r87WR2yfLEgk8WjXprwfkQlT4w1rg5UyIRt+Sqni3WhhORx37l0e+R6AO7gQ325244x7f2/wbkS8gFLq1LVwAYrhdNMAeaPvK8zFcx17nRUsjyxDaztRbdllqLcH5LQs0RfIlfJ+hpKaLQrZaFlvzYRKYo/cyEZVOStIFIgollg1wYI9cFOVFwlQ8olwayFQaQpHKGsLapA28jAXm+ZiQd0VPp0Vp8EoQ1aeJ0ohk8LS9Hd8tDWhvq1AMyQCSpOm0i7xSRq0V9gJVKfYkp2/9tRWlQsIaupTjWd8WxuBP5I3gseGfPIsnPAgMBAAEwDQYJKoZIhvcNAQELBQADggEBABA+svQ158XHPZhtfQdAWoWJiKHTVlp/kVtadeC23bIKU6DUEcHslEA4PzIpH8AJ8hek98oXdH8ThpM/IiTSZmz71Tx2BYBmQa8ewquxOxB7CjxSHRNsxIC+X2Pox8xH126bDAwAlTBG9DNX+HW/iUFE8HMO0SBuk/cJud44cZPx4jWIY4EC5ETqeXrYg29tpCpBSYW1Nd2tmcDAnju6CUyNAzJGdwntC6RNVWnbPBpVl7MU32RLNsGrMHh3umgWUT2jZ6tM/T6jZrgdro7KqXt9F9v2czUAe7gk1ZninRk3/iv8p6ewDfaOW5k8K/fs/6m+fy55VIzVrqMfq7HK6c4=
0012a360-70e5-4f94-bc08-6c1a55445137	60f2ff74-8ee7-4191-abd7-3aed9d429b6b	priority	100
8dfa5a0a-5f15-487d-9ee5-d4d2093cec08	60f2ff74-8ee7-4191-abd7-3aed9d429b6b	privateKey	MIIEowIBAAKCAQEAtT9ojeXhNEIU/Ww1zNOiDUYTIKuz6R+a/O1kdsnyxIJPFo16a8H5EJU+MNa4OVMiEbfkqp4t1oYTkcd+5dHvkegDu4EN9uduOMe39v8G5EvIBS6tS1cAGK4XTTAHmj7yvMxXMde50VLI8sQ2s7UW3ZZai3B+S0LNEXyJXyfoaSmi0K2WhZb82ESmKP3MhGVTkrSBSIKJZYNcGCPXBTlRcJUPKJcGshUGkKRyhrC2qQNvIwF5vmYkHdFT6dFafBKENWnidKIZPC0vR3fLQ1ob6tQDMkAkqTptIu8UkatFfYCVSn2JKdv/bUVpULCGrqU41nfFsbgT+SN4LHhnzyLJzwIDAQABAoIBABszD9Kzm89G13WMhqpdXCVXzckKW25xssWgLoJxHgCFea7tvmBrdKAbdYDIyE65/hPgn+1G3aQi7M7kvFNq5OPliKHb5SeXZYAZ4K6taPBbuwGkFpeGz9nkTlTkD1ADgFP66l7te9JA9S0RaxAe7faE+MOSNzG+LZ4hLVBdYdBeEOA3Nfws6IhvqxZMMoH5byZUX8lk8AQ2w/q3z5pEg1oviRgqBQGFoy3YP0d0dmyXej1KZrYq6VGPlRyjtiAXAq0QR5KVWzXVLft87BDDHnLo40if8tCXvQHQsKpiQdLJEL5EyqDcCWeZE1hatdGfAUOEBRdrphfWE8x3+HIA8pkCgYEA+N7knxonGYZo+xPBvPFJu8tDQo62lJLqJBw3YmAkKeSlvu52lnnABIZFJdUUbqIKO2qJFFfYaWfdPHzxeQO6autB5HyqCNtUKj3RcFaXeGyyzoIq1AXRYQ4rf6Xx4NNELZ1WyjrnBxRctEUXjAxnb49dh6Qb2+jp6XHxMV25DyUCgYEAunCZMnh0X2SyvH9gHeLqa4JSCFsvy3U12+5kzsHDnS6Elc/LFU+cmMpuyK4TwoVFZQ1wnPwaU/XHxZUy5Rfmvxh3ktxhLSl5DcQnUR60wmo8Atqiq3DsvaPNzH3oZacq2OwGUNZ4zXXQtaH+l/kvNnU4KRaE4hn0lsHtMsywLOMCgYBa9Jt5yoUfvw//M2lLNKRODiu215HDGy6Xo/hZ6+lLplUtQtn0hOq4vJnpCcc959r1fCo9VR2y6FLjGIboQ4SOLw0WBLngIsjP52f0NrGFQbTX5Jrign3Tiuo67NtJ3+y6/xYJMx3caIS5HcdNV/s1up/kQwYriSR0PUB5WleYQQKBgQCS63p+QFgMeHE1g/b9dj0fPZJhjWJLpfEsgF+mYyFAs1C+MgKqp5MTAKtur2dY6eb2rDGrNCuXMF8eP+XcjQpEWwaXj91wVndTttj43wa5Ejh6U0rPaWzWQMhDtpC10pc8XDrZ5zlJR+eRyrezkSV4d8Uq89kByExrpSTD3HOU2wKBgH20QmxTp6/T8keSUmyadrkW7JkRR9l9HTbHvcPEVGe+xfVEjreC3zqf0u7FJ/84QTBtWEkExPhr4D0ndRkFHZK+MoEJ2ud6K4TxSX8KfNDFQhHUwHhU0EAD8WNcCyB+BAvAGlOSrWN9B+M+es6jjOyBHM8EZ+W5pC84RCdhTZSi
5441dd10-1d37-45a0-8852-f3de9b41d1b7	c99b3459-10e2-4bad-888a-7ffef6ba7182	privateKey	MIIEpAIBAAKCAQEAmTA1Qn6SPa5MWVIU9p+AiBzZEvGSWKGnJIbsSOS1qDy4C0dZGSHYuhF88edPXsD4Z1nkzh0tJEa1cDC6K2k/oJ29MdojEVtJC/IUkIaCPplB/MQI+AmqCqrz2i6ChWXXUa4nsgbBsB5dMOHNROX7VfvUMBwcYBvnaRFXGBY9M6lbph7wZJy1WgckC4FcMUV2CTxjbaJB0lBNw6swkMQpxlezHtkLghIEsdd/PgLPfwwnnPnlmmcA2PWs9KxNNEwbRU3Xe8aaPZ0oMHY9m/XNQooyRuYkzxK3u0QUFQUTc8+U7Di0Fc6yEwMyCbIRf2oo6EZwfA6ibySDp21TuGqbJQIDAQABAoIBADoirPu8vDQzWx9EwtbrpmRBinIhgpgnVR7MI4zwWy5rSK9jFuGuUikfLOtDDQCZPExAtdAxC2oqeX4HyAdkjHSgmGX8cnWKTrj9WKeWnIQ0NnI+VWcIh+M/iIbDQt5sTWBetwrdfJEhnN1JvFSK8SzrAtZ1PKGOxW4+2e42tmhNpaV+uFTxiyV4zn4PRQP0nXQl83GOVd2+CAJbSDraKiBamnKC+9068yiBlWSkVEhKMCAPGMtWcY9pLpwQKU4o+UGU5c9NIuxLRPKsGy0RMHmvd7OLEeEjfjQkeYJHIhwbYZFf4it47yKA/n2nplKCK5h/D4KblIIG7EXOqpzX0GsCgYEAzVnddxztxLj5AmoViGIUG4Qjm9XOE3vAdGDJ+YEZcCc0H6CXy34ND56qw5y+xU6bU1Vt7ALnN9HX1YtDdaSVP1JPiaUkiO5t5iOLo2caGxd6o5uVTQLlFNySgQQw3G667u4au1anHF5xmjN4NdL6meB+nIY+crsiDca6JNDrZKMCgYEAvvi4S/1S0+wLbgqTcvtOjOQDiL6Zbg45c/yh1eunMeDseFBG9XD/Vqrjwdwng4fziimx78x8Dh2C7YipQaMCuAAqrYowL0Hacna3dV8cqMGysiTCTW2KnRgcXJ+79Ki1ApRwuJULl5Wd228W8y+jt4lSAUiFXGIxKAJw0g6ZtZcCgYBNwE7YQL3OFHND9MK+ZtRSLtAEuwlR2zNdXSBcNgNZsZ5Ms1OGGu37Egp6EikxL7gj7161U8wUGIHuOtKKAoz38sRmy35v0kcOMjs23VzHETbAJ7J5/DScl39pFhsh+1MQEFtSv1Z6qU++IOrNBlsYVCXcQf/3FN+p86qbMfdOnQKBgQCBsDKoGD6ZgGE6t5/uo89ySp5DzPwxCyPlKplUxxXh/5dXFV067SPZ3W+ShUmoPzkaiLo32SweAdiaKwaWdncwMZzKAWA7l4Mb3Jc19ANobzJFXEU/g7ZwfKE2HZvsyG00dU4fa8hVhtuO22BAggeyamTwTimS1XQAcbfgTt3/vQKBgQCgRg5Oa09USvZKpI0Ai/ZQkzJtIK+pyZ46Oe4gSXnzuQv3+dv6cnQQ/LtX80Pym3+CStS0g6zOAZxZbX2jlz/lnT1DsXlVg7rKZ5cPRdyDYg11Cc2jEFlYvph3sN66GPH4ElJNXBtjZU+Jiq/qDwoeliIJ+PRyDk8hi587l72Dkg==
cd08850c-e931-4a6a-aefa-e5722aaaa2b1	c99b3459-10e2-4bad-888a-7ffef6ba7182	priority	100
5984264d-0929-4ba0-8e26-6d194d137854	c99b3459-10e2-4bad-888a-7ffef6ba7182	certificate	MIICmzCCAYMCBgGK+XfI4zANBgkqhkiG9w0BAQsFADARMQ8wDQYDVQQDDAZtYXN0ZXIwHhcNMjMxMDA0MDY1MzExWhcNMzMxMDA0MDY1NDUxWjARMQ8wDQYDVQQDDAZtYXN0ZXIwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQCZMDVCfpI9rkxZUhT2n4CIHNkS8ZJYoackhuxI5LWoPLgLR1kZIdi6EXzx509ewPhnWeTOHS0kRrVwMLoraT+gnb0x2iMRW0kL8hSQhoI+mUH8xAj4CaoKqvPaLoKFZddRrieyBsGwHl0w4c1E5ftV+9QwHBxgG+dpEVcYFj0zqVumHvBknLVaByQLgVwxRXYJPGNtokHSUE3DqzCQxCnGV7Me2QuCEgSx138+As9/DCec+eWaZwDY9az0rE00TBtFTdd7xpo9nSgwdj2b9c1CijJG5iTPEre7RBQVBRNzz5TsOLQVzrITAzIJshF/aijoRnB8DqJvJIOnbVO4apslAgMBAAEwDQYJKoZIhvcNAQELBQADggEBAADBXi7uWkW7IAKhxiqfklPTawVy9o7nEkkRe8l0Yfz6TKAK4K3HGZXCGdKW0NOHs0ydXUnuIRn3RO0gt2Pmq23wiGZGYw30mfKL0YyVCZ3x04dQYTtRW1cGiPy8O3fx3C7U+wMn58xRfYnKdogOODynrEdGDWFVKrkvxqXJcDBAvXvS1Mf/BsT9stnNaMda5sTGmPyhRJ+NfmjXMh8AxbY0xeSJYrWg5GD7wpL1gZ3AUvkEyjqE+vKDm9e+55hAjf4JgPRs0lzJeTJxUjPYN8BzMZcYQQNt+0Y9rm4R3r87XoVRPbmv9DvJBR+TKdXHfjlpp8ULxyMC59RbG5l/pDo=
6f0e8601-edee-4018-a5ba-9b8771ac647b	c99b3459-10e2-4bad-888a-7ffef6ba7182	algorithm	RSA-OAEP
60c7ae82-62ca-4828-ae86-867b74a5dc0a	c99b3459-10e2-4bad-888a-7ffef6ba7182	keyUse	ENC
1bb5f009-27e8-4983-8c10-393eb2def0eb	9f6a1b18-0a58-4f4b-b995-79bc67ec6e0d	kid	d939c256-51ca-4c2b-8d86-061ddabc535a
474ab052-0943-4bce-97cc-6926fc3a3bc9	9f6a1b18-0a58-4f4b-b995-79bc67ec6e0d	secret	CrvHY8qZNDK2QBWl3qq9bkfE685tll5mh6vitWi4xRrxeUsA5RO3dziLFQIg5qZ1zoE0euWQuzraynVUf9ay3Q
13813b16-e3d9-4b6b-a7a4-78a39c876bde	9f6a1b18-0a58-4f4b-b995-79bc67ec6e0d	priority	100
53fe7548-185f-4a13-86e7-76d7118b4db4	9f6a1b18-0a58-4f4b-b995-79bc67ec6e0d	algorithm	HS256
e46787d2-08b0-4fed-a4ea-ae62a98bd808	b77e41ef-0593-49ec-a0ab-cd258d9b5039	kid	4225aa9b-5620-4e8f-b6a9-f92ee8d1ecfb
5fb5bc9b-658d-4f54-a178-7568b6a83d11	b77e41ef-0593-49ec-a0ab-cd258d9b5039	secret	cZ4mcEqNAe7--syL7PGHJg
a33feebc-8517-4527-acf0-bc16e66e8d5e	b77e41ef-0593-49ec-a0ab-cd258d9b5039	priority	100
f5c6d11f-c193-43df-b8ef-59a293b8c058	3614e55b-a4ff-41e2-95e3-205839eae945	allow-default-scopes	true
6bdebd98-dd77-4270-9aa0-ff7dae56a715	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	oidc-full-name-mapper
a3547079-a979-4c9b-9bc9-80adb8760062	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	saml-user-property-mapper
c5c28a59-59be-48e5-99df-7a9546f1017d	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	saml-user-attribute-mapper
13995d0e-be6c-47bd-a970-cca428bed42a	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
15f9142a-396b-4c7e-a2b3-f84181329607	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	saml-role-list-mapper
dadb9299-365f-4fec-b203-8c7c285e624c	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
e72eaf28-8e2a-4158-8ce5-29f77cfcd35d	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
294ad341-0017-4505-bd06-9032181d0e7a	e58e3802-e94c-4a18-92d2-ac9cd5b450ca	allowed-protocol-mapper-types	oidc-address-mapper
7b40100b-3bd4-41bb-bcdd-8ec78911f4ec	c88160bf-e1b1-4421-a002-0dd0cfcfb3f4	client-uris-must-match	true
5aafd57b-f02b-49f7-b6bf-e4b0e87b8a09	c88160bf-e1b1-4421-a002-0dd0cfcfb3f4	host-sending-registration-request-must-match	true
8e945112-bfe0-42f7-9bc4-636c1d46f97a	388e0d45-420f-43ca-b7c3-e9117cc1ec71	priority	100
16c14038-72ce-437f-95f6-afdf445622d5	388e0d45-420f-43ca-b7c3-e9117cc1ec71	privateKey	MIIEogIBAAKCAQEAu8kFDiVUefbL3qF8kE9omSX6cKK4XqjmPTygkPoR3PxI3z9+41cOKEfDAJPL8u0STljcpHnsP21GUTRf8XgfRl9KGlyIgnyICiQFpFs+nnRZ2ptUw07HNWig3S73fwbFg2BwZFGWiixOwq3d3BHrX+Vl62A9PEvbPGUE8GXNLNbrkuaAS0upmjCKi4lZpoIX96BeyeRRUI3OHOy6L3ydxC0juAfZmyqJDIgM03MSV9i+6oUaDQFcQhZmP9hm999bSxglADoFVRdLgc62udbaX0iNJzrK2LJI9wubAjmZ7ZkZyDyFU6TGD3Kb1eXTjBoBPJQfOGLUfJVHAwBjGdHFSwIDAQABAoIBAAnGAzmfFlGkuvMS4j2GjIO6s3XF2k+wtp03aqLbs70V1szi3i+CyFvLViMKY4kxmaiWWYUL9lei+rptWlviQVisdb24uKLNE62D4aouf4/IBQj42Tck18Yw5ifJVn+/DqTxNUoUPwALr09GfBoS1VoFM4lGAISRJevlYzJA+UKdCV2E43oj6nFxEAAzmt0CadfgJVTIgWk001ou8n5pHbrh4dv2xEXi64nixtZuKlhezi81i5z2fHWj417idY46cQx+SFBGCRnVG2PUbxa9IkEvPFY0W4GV6+SnllnQ/jBp3z0yN+8zsvlVbtPs9jxJhp28nA5kUE6v5FV3cpUzzYECgYEA88+LUmCLOtTuA8jCecrfRFc8LPeQvDrEFSs1iPnqyuXUqa0E3BRigXfyjDN+kIoY6MtOzxjlNZk2uFfVu3VgqhpI22s2/rH/PR3VlnsSI8lOApcl200RWYExXEfqQU0w5sgfWrcKrzeEU2BZLa6fZg/uUV5lCX917GtyKF4+UMsCgYEAxSxsVEMzZxnSosCWlfXM3fyyzyMTDUL8NjKmrPtGVdf5cj6zbv2BD4EyX+hAVdUvV/uISds4/D/qdxj0CgluY53C2O2eVN9g/7j1VWT5atJK3eE5WGxP6eJTY0K0YhcZFzrlUDtFBUqONTXiFDYRMZwophHE82Ek6h6nbkyaTYECgYBjpE6sPAiq4prjsQjJ/b+BjqVpO0RLqTi57g7TDFCI26UuMyfpSet4Pi1CX0k6iTXk7jInMWV7okJa1IrlMfNvkY51Hjw7m0NVFvxTo7imJ39aT6uJFNYiXkpuDHYQehuiNeeai3QyZ94MtTO9F8DNVXVwi8N/PjhThxYAqYOOQQKBgDXm2wZ+CINa79ZGR+Re+c6F0mwF7qNleIVoe2A2oRe+nxa4RV1GOA4BB8BoQY41ZWfr/2oRYBa1cmd0juJfian56tZavzn8hwvhiE/79qNZMdZOR9sAYShTEvDDv4RBRD6xfxbb3RaBNzccr91OmoyxX/tmSC0wlWLbVnI0xsoBAoGABxgDuesEjvEkle6uaau8BTvuP5eva/+3N/d4W3OmW5NuoG1bJzscWk/3aHGKwpbI1BBtggEm0VLaW/x2RvsxL3OTYG0hp0CdgvJu8IRFAcKj5M2QbYAv2zhkFmIAgRiR6CWAaemOG4aQbHBx/oX90qMMDGW23JwoLTQhsdk3fno=
bb1385cf-7e9d-4461-afda-47d54d0024fd	388e0d45-420f-43ca-b7c3-e9117cc1ec71	certificate	MIICqTCCAZECBgGK+ZvECTANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1maXdhcmUtc2VydmVyMB4XDTIzMTAwNDA3MzIyOVoXDTMzMTAwNDA3MzQwOVowGDEWMBQGA1UEAwwNZml3YXJlLXNlcnZlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBALvJBQ4lVHn2y96hfJBPaJkl+nCiuF6o5j08oJD6Edz8SN8/fuNXDihHwwCTy/LtEk5Y3KR57D9tRlE0X/F4H0ZfShpciIJ8iAokBaRbPp50WdqbVMNOxzVooN0u938GxYNgcGRRloosTsKt3dwR61/lZetgPTxL2zxlBPBlzSzW65LmgEtLqZowiouJWaaCF/egXsnkUVCNzhzsui98ncQtI7gH2ZsqiQyIDNNzElfYvuqFGg0BXEIWZj/YZvffW0sYJQA6BVUXS4HOtrnW2l9IjSc6ytiySPcLmwI5me2ZGcg8hVOkxg9ym9Xl04waATyUHzhi1HyVRwMAYxnRxUsCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAMZpSLr0fGU5dGNv2HaBKEshkqoYMeCyLK/kIdmDVw7tzn1HUuoyKHbbDMXhfZSbUH3hxpvhZpZ3lTbzxPqpbSv+SFdVk6X9z3/jD+ChZGv5vWIqOwk2VK812AZtNyOLQS3yPTmuCDZZTamh4HzHyuhorxTq8xvHccG3bzZz5jpiK+Mlwi6SaDCA4We2saQ+7XGOBBzy9WLwJNBa/U/YJ5irNh5RZ4QqoJdajZM6C5wqDNNF203FdepuqqWnXQHDUVE/qIyi4Ho5gxwqV81MDbDEJtn28dZVxph914HrKIM2QCLLNFwKjkQiOCYOFXtryuKk4E5Qg9p1mjRKOQk7HWw==
f80ee865-b6df-4cbb-b209-20a2d59c436d	ac96a6a7-2480-4f80-b322-dbb61f620941	priority	100
76d669c9-ac91-4573-a004-4bcd8bc0eb97	ac96a6a7-2480-4f80-b322-dbb61f620941	algorithm	HS256
eb12675a-5689-4a9c-9975-c952e36679dd	ac96a6a7-2480-4f80-b322-dbb61f620941	kid	1fdd5f64-2cfe-480a-9630-67545052fbeb
91788a75-1eca-4f96-8bd0-be6693a72a17	ac96a6a7-2480-4f80-b322-dbb61f620941	secret	PqASwUJIES0b36VoIKQRxmQGV82I3a3L-w-k8-mAr0NMX96H9jOswQZlNrp-GGynLO7TK76Bi81f0uMdOtaFZA
c9286b32-1b16-4461-b5f8-b304ab8ebf0c	874975d4-63ae-4c5b-a44a-3a2ab9e3ee7f	algorithm	RSA-OAEP
65ec595b-fb44-42d0-bbe5-35b95ee45ab7	874975d4-63ae-4c5b-a44a-3a2ab9e3ee7f	certificate	MIICqTCCAZECBgGK+ZvEpjANBgkqhkiG9w0BAQsFADAYMRYwFAYDVQQDDA1maXdhcmUtc2VydmVyMB4XDTIzMTAwNDA3MzIyOVoXDTMzMTAwNDA3MzQwOVowGDEWMBQGA1UEAwwNZml3YXJlLXNlcnZlcjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK8fPAjQrMgSvzkk3/NWhsenQAhtj6bHYSz/Iij3MVeX+n0/Bogq/fA9oKZ+tgqs5nvH5TzJxtJ6EYqarpp5t8mNbojud+srrhjZSI/WlaKW+63+T9cjmjqzpM+/t0+BCSUltqv+Ykdb3GwPs+sH6CuWLrdiPA4gF5OMvc/4ogrx0Q0niRYBScY5m06FkrmEg2xOQQpcLA/u79ngmZuNKfHk1oxH3tqt1OK7WQPDCd86Q3CGDsww9Sh53HDMoKP8Kw4sm9kEE7TdPxqlR63qQJgpF2igCG38/nwplHc+3vIPEUKxQZSZ3ETU44Txq3EJe26x7e60c1Z+0p4CR+VNZxkCAwEAATANBgkqhkiG9w0BAQsFAAOCAQEAJxLxhtUc4dHO0LajIknPCXvyaYByc0l2KVbSlieU8MwC7pjTu446MielchZyT78WDXq7AH3F5DL0JmX89zNKUBzoixcLVtvr7oYrbXWL2l2sOEotXKycnyXuT7z0R/bsJz/jrqqQNJwRWfODnVSa9BHq95h1Vjh4jMsWkvBkcrKjD3duSg4NntJavwSSeY4kocA9u3DNdtIQyXFzVW3ZeifOL3TwEL+geAwPIlMQ6E1zrYOti+Xo1fuFKGybYz3VgcOE4CDx0rTq0Ktp31u4zd9kp+D7wOB35kTwwKJkof3Mj04JxkV4KQangZzw89sCt+iOdHcyV/P6RK5vp5mGWA==
0c1a1136-47f3-4c65-826f-215fdb0bb6af	874975d4-63ae-4c5b-a44a-3a2ab9e3ee7f	priority	100
8a562b16-486f-4ff6-b459-e152967fb088	874975d4-63ae-4c5b-a44a-3a2ab9e3ee7f	privateKey	MIIEogIBAAKCAQEArx88CNCsyBK/OSTf81aGx6dACG2PpsdhLP8iKPcxV5f6fT8GiCr98D2gpn62Cqzme8flPMnG0noRipqumnm3yY1uiO536yuuGNlIj9aVopb7rf5P1yOaOrOkz7+3T4EJJSW2q/5iR1vcbA+z6wfoK5Yut2I8DiAXk4y9z/iiCvHRDSeJFgFJxjmbToWSuYSDbE5BClwsD+7v2eCZm40p8eTWjEfe2q3U4rtZA8MJ3zpDcIYOzDD1KHnccMygo/wrDiyb2QQTtN0/GqVHrepAmCkXaKAIbfz+fCmUdz7e8g8RQrFBlJncRNTjhPGrcQl7brHt7rRzVn7SngJH5U1nGQIDAQABAoIBABfMPNJN2U0PDyFq22wsFADJv6/lg6H8cj41JaU/glsO8iFXEUIr5XpiRZSan45v1Jp5nbNXEEfGAuA9CQFBDTK8n4rILU+uDeiejnfNh2Qi9Gy+pIbt9aWIiBsbSIPrWxzLNTnGRgDAgQHGWILV/jz+GbceCF87CTkp5RmABjVKUaGdF3P7z4jd0urSPauxKKt4A0SATX3NcQ+mlWLUylR5JeojZXgNjsye5+J5eFDtBY64Qy7DgvysMpRMO7HBW0vIXAvAJyEyLGle4mGuD14C2TLF5FlBV3yBByML1Yp/WqzNKxw5IMMDQ1IE6aI6yeqNgdERMcLD/X0/ybYhMAkCgYEA4OB50IXQlQHJA+CBPnQ44k1RYmd8x39m/xuNLBaTuMJkMV/BhheXhCvMdh6JMbI/JU5UYTPtMgD+J/RugOPwDaaaSgwc8evTgNa+esCtYpsTJmUaxt+ZgHSZKZhM/YTl55zLep8ueUX6rB1aTzvAWDrQHtOQ3cVwT/yu993E8W8CgYEAx1vp/yEVpHp4L7NQ1VYO971LNNr+nBijkWUOH5Sp9V/sbTMn5y3QuowcsNcLbYWIlca70+kh2cy7IyN3P0EyFciCK4JkFqat8ax+scaI5TrwIt4tuZ5SdELDa7sol/IM5tdJEFUh4xPkjg/MYBWnh+KqjRd89NPdzzpTSPXqW/cCgYA9VLukZXqXyR7b0dUuBWCmR9QUdIkRl+utVARSq+2qDEprNOSA/9oxEAj5hiaAyU5zjENzJ0hfxOmMWBvzRzdnYbLe0yLp0BmlH+xfakFfjU/Rvu1oo/8ni6ViNMl6s05Itvi//r4cETvmyTKiPXeeGJw+bBEsivawuge2TmOyPQKBgCGSHMlVrOtRpEOEEqyaHVMikTOJXS60B3dIaSRwSF6FlK6e2q1XTbrcNUiiLc53mhR+rsp0i7q9exXjtwTz2ZdJeIITJv+ZedkkjwEoyYywbBezCkgjnQbu5zGRBrjvjbShtDAH5fjzNJ2nk2bqvpdnWAkCV4xy0PtAex3iK2DpAoGAATtIEdnPWJVZ0RTLKSNtqnE3Px+/IJgftF99nQe6w62PqfxNdGZsX+JsDiubJLDZ1QuufTz5Q1cbn0QVT7NDHjOFq/CwtFWxeWD4/IyhuL0L8I7BW0prrrVjz5bfEyt4H6C6B9ECFWQpkTeEsWJdWjUgM71OYoWAsM6LXsnOQ0o=
0b2b87f7-4755-4ff5-8bad-1ce5f662e04c	656259b4-2824-434b-ac9d-1e76695bbd81	max-clients	200
6037b018-6e88-44cc-87c7-737b0fcfc3d8	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	oidc-usermodel-property-mapper
9e047fa5-2c0a-43bb-a3c1-9a7c6a10c0b7	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	oidc-address-mapper
30fca59d-f713-4ef6-84ec-776f5e925676	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	oidc-full-name-mapper
54264a86-c439-4f6c-aad9-ca1e860e855c	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	saml-role-list-mapper
bedd8be5-393d-45bf-85fb-f495c0c3f48c	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	oidc-usermodel-attribute-mapper
ca76b74d-9eec-44e5-b3c7-68f92e122b9d	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	oidc-sha256-pairwise-sub-mapper
b7d169d3-eaac-4fd9-b73c-5fdafa311bb5	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	saml-user-attribute-mapper
57d2fe6c-5f66-40de-9e4d-9f030562818b	fd8ac4be-a925-4c43-b3b4-8bd0272d5ada	allowed-protocol-mapper-types	saml-user-property-mapper
69bd1e37-ffa6-465b-b0c8-510495727137	85961b8b-2194-4f35-8848-47cbaaa86d36	allow-default-scopes	true
7c58791f-d7e7-4b99-b73d-6f185085b145	f53a6738-bb3f-4df4-8cc9-29adda713b54	kid	16ebb16a-af6a-4fef-8e39-2cb0765a5a17
a35f470e-4b19-4997-b969-9ba7adf141ac	f53a6738-bb3f-4df4-8cc9-29adda713b54	secret	hOPO6_m3OPlNARZEx0_QFQ
09a6dc02-c0f8-4b6a-8259-603fb3079454	f53a6738-bb3f-4df4-8cc9-29adda713b54	priority	100
\.


--
-- Data for Name: composite_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.composite_role (composite, child_role) FROM stdin;
3f92ce8b-266c-447c-820d-7c4531b8765b	4666ddf9-c608-492e-bf54-52a026e93a50
3f92ce8b-266c-447c-820d-7c4531b8765b	cf5f6b45-df29-401a-a4d3-4088673e79a5
3f92ce8b-266c-447c-820d-7c4531b8765b	b04e482c-1275-4bcb-8624-68c69f87020f
3f92ce8b-266c-447c-820d-7c4531b8765b	5376d61b-9013-4774-9408-4d93230898f7
3f92ce8b-266c-447c-820d-7c4531b8765b	ed4ed974-1c2d-40e7-bc88-076dc30a4cfb
3f92ce8b-266c-447c-820d-7c4531b8765b	c85b9111-b93c-46ef-808a-306726f16b43
3f92ce8b-266c-447c-820d-7c4531b8765b	43789923-db11-4839-b300-3e3643c1fa97
3f92ce8b-266c-447c-820d-7c4531b8765b	3f8e8579-af84-4fd9-8f15-0a000b76cccf
3f92ce8b-266c-447c-820d-7c4531b8765b	e0452cd0-2f05-4dde-9ee8-a53309449295
3f92ce8b-266c-447c-820d-7c4531b8765b	febee4b1-c9f1-4069-b791-267555c3329c
3f92ce8b-266c-447c-820d-7c4531b8765b	71edf28f-2a68-4319-af39-acadce114b73
3f92ce8b-266c-447c-820d-7c4531b8765b	40a4becd-a819-478d-9d99-f8bfcbd0ec7d
3f92ce8b-266c-447c-820d-7c4531b8765b	471fbc86-edb1-4af5-8157-439c572941f2
3f92ce8b-266c-447c-820d-7c4531b8765b	5f13ed39-4643-411f-92b3-ff812df7e65c
3f92ce8b-266c-447c-820d-7c4531b8765b	855f328d-7008-4aba-8fd6-ae7e07eacb95
3f92ce8b-266c-447c-820d-7c4531b8765b	cf867a58-707e-4734-93aa-179f6be06786
3f92ce8b-266c-447c-820d-7c4531b8765b	4b9f3e04-f803-4625-8fde-592c84009d01
3f92ce8b-266c-447c-820d-7c4531b8765b	d9567aab-3647-40b7-935f-88a439d687f5
1d012033-0bac-42b2-880f-16e38cd3bf9d	319fca69-e4a4-479a-9c63-f71867ef0292
5376d61b-9013-4774-9408-4d93230898f7	855f328d-7008-4aba-8fd6-ae7e07eacb95
5376d61b-9013-4774-9408-4d93230898f7	d9567aab-3647-40b7-935f-88a439d687f5
ed4ed974-1c2d-40e7-bc88-076dc30a4cfb	cf867a58-707e-4734-93aa-179f6be06786
1d012033-0bac-42b2-880f-16e38cd3bf9d	d32ad624-e595-4cbd-8c14-bc3d7334edf0
d32ad624-e595-4cbd-8c14-bc3d7334edf0	8f8622ff-342a-4073-97ac-cb265c57e56e
05b00561-0905-4d03-9208-eb3467c2ab1b	faa24ea2-0012-4e7d-8c08-ece0dad949ab
3f92ce8b-266c-447c-820d-7c4531b8765b	c539f24b-94b5-4213-b909-b9c23e18475e
1d012033-0bac-42b2-880f-16e38cd3bf9d	ea7aaccc-4b43-41f6-b5a2-26a8dac82569
1d012033-0bac-42b2-880f-16e38cd3bf9d	c1b0e9e7-f8f1-426f-86d5-4c0401f3135d
3f92ce8b-266c-447c-820d-7c4531b8765b	cc1be155-5151-4c89-b010-14152a8e5a38
3f92ce8b-266c-447c-820d-7c4531b8765b	9065647d-ee18-43b1-a39b-c7d09de8b935
3f92ce8b-266c-447c-820d-7c4531b8765b	0c4f6146-d816-4739-b62e-4fd75ddff9b3
3f92ce8b-266c-447c-820d-7c4531b8765b	deaf6b58-86f9-47f3-93c7-f5858a7e21f5
3f92ce8b-266c-447c-820d-7c4531b8765b	b82ea2c8-3710-4042-824f-d59aa0420472
3f92ce8b-266c-447c-820d-7c4531b8765b	4f133514-2fa4-4f7d-bb5d-dfc72fd82070
3f92ce8b-266c-447c-820d-7c4531b8765b	b7d00df1-5d9a-42e6-aa75-d4382deeb3d0
3f92ce8b-266c-447c-820d-7c4531b8765b	7b87237f-6c26-4bc1-8167-da50409dffb7
3f92ce8b-266c-447c-820d-7c4531b8765b	a4681698-82b7-4679-98d7-b58f87681c44
3f92ce8b-266c-447c-820d-7c4531b8765b	f787f9a9-8451-47b6-9306-9ab7d0c9750d
3f92ce8b-266c-447c-820d-7c4531b8765b	b8821c73-f61e-4042-b222-83e59db77c10
3f92ce8b-266c-447c-820d-7c4531b8765b	0dac1e0b-51b2-435e-a9ce-98e7b473780c
3f92ce8b-266c-447c-820d-7c4531b8765b	4d30fa9b-8ecb-4f88-82a5-decb932c65e7
3f92ce8b-266c-447c-820d-7c4531b8765b	dcd3e975-6c6b-4461-8ef2-c5b8cdd05f6a
3f92ce8b-266c-447c-820d-7c4531b8765b	b2b26750-c206-42c9-9a3e-5afcfc1d347a
3f92ce8b-266c-447c-820d-7c4531b8765b	5ea5e470-aecb-4a44-a155-b2c9ea9cc3bd
3f92ce8b-266c-447c-820d-7c4531b8765b	eb5ce614-d3c0-4e93-bf92-3d406114d0be
0c4f6146-d816-4739-b62e-4fd75ddff9b3	eb5ce614-d3c0-4e93-bf92-3d406114d0be
0c4f6146-d816-4739-b62e-4fd75ddff9b3	dcd3e975-6c6b-4461-8ef2-c5b8cdd05f6a
deaf6b58-86f9-47f3-93c7-f5858a7e21f5	b2b26750-c206-42c9-9a3e-5afcfc1d347a
7987d9b1-a6fb-42ee-87fb-f894d537a8df	2ffc73af-031f-42c8-af19-d536e467353f
7987d9b1-a6fb-42ee-87fb-f894d537a8df	29ebf4db-27c5-467d-b1fe-557a273e77c3
a63452df-a422-42be-bacd-26318bbd7b85	88e8d0e1-fc32-47df-be80-7b6496d01b76
a63452df-a422-42be-bacd-26318bbd7b85	f78834a4-4c84-4c93-8d9b-7762c9e9364b
a63452df-a422-42be-bacd-26318bbd7b85	b359ee9a-dc5d-4192-b525-97b3cae86e6a
a63452df-a422-42be-bacd-26318bbd7b85	63f34d2f-0d41-4dfd-9af3-83902621b4ec
d4fee5d8-639b-4998-853a-db420a6fdf21	4e5134b7-b6e9-420a-8fdd-b22fbd760a56
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	4e5134b7-b6e9-420a-8fdd-b22fbd760a56
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	27c452f2-562b-4af7-a3b5-eb033fbfbaac
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	c961b24b-5c6a-4b03-af63-04521be8a2b0
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	2ffc73af-031f-42c8-af19-d536e467353f
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	a61321c5-0743-43d1-802a-cb527ca644b7
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	d86762fc-bfcd-4321-a5ff-92b988b72b13
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	85eb5262-cafb-4b94-8883-9e7fbf148cd5
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	7987d9b1-a6fb-42ee-87fb-f894d537a8df
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	4c28d43c-4507-4ab3-9d55-6bdafca61ddf
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	d4fee5d8-639b-4998-853a-db420a6fdf21
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	75b71950-82bc-49df-a37d-22331813e50a
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	29ebf4db-27c5-467d-b1fe-557a273e77c3
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	5a2ef4df-8ae6-46fd-94fb-7fae3369c9ed
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	2704797b-f87f-4574-9fec-3a52ec7e7e6c
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	5ebb1557-2a46-47e2-9c8c-d86466a1b86f
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	66e21d0e-caf3-4ddd-b3a4-427cacb2c274
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	826110e5-9de5-4e8b-a4ff-f07a85a660f9
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	673f052c-b5b1-4754-abfb-96dd28fc1e6a
f78834a4-4c84-4c93-8d9b-7762c9e9364b	57399039-53a6-4070-a4d5-dd04560c67bc
fd4cb91f-7d85-4a80-b708-2249c0630e6a	b9eca7a6-abda-4d7b-97db-043e9d5852c6
3f92ce8b-266c-447c-820d-7c4531b8765b	cc076330-490b-4eeb-8ae9-cd3517a5a024
\.


--
-- Data for Name: credential; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.credential (id, salt, type, user_id, created_date, user_label, secret_data, credential_data, priority) FROM stdin;
ac1986e4-8fc5-4a7a-9c21-0cba5b18113d	\N	password	89ff425e-7daf-4d02-bd10-ece87ed8c06e	1696404798602	\N	{"value":"g7ntHbZp5x44JtsFmgKaM8KvjHY2ByjOUuALZJL0Q4ugaq02b6ZkT6l6Wl8OQLgyt+cKKT5MqupM8Y837YRGJA==","salt":"FaEC75E+HdJSSqLwO8xY/Q==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
54929b6a-cace-4589-98ca-53383adb2b47	\N	password	7a45ce29-fd6d-4b3d-8860-0dc999e58b3a	1696404896388	My password	{"value":"URBECkWbh5PgIY30kHI9qr9pGei6rcMW0Gm8AQWyruBStJH5RP8KLA2pWSR9cKulKa6C3Dv+cnyYnGVd6uW8Nw==","salt":"yY+DkEUZ6dO4r42S4EdD/Q==","additionalParameters":{}}	{"hashIterations":27500,"algorithm":"pbkdf2-sha256","additionalParameters":{}}	10
\.


--
-- Data for Name: databasechangelog; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.databasechangelog (id, author, filename, dateexecuted, orderexecuted, exectype, md5sum, description, comments, tag, liquibase, contexts, labels, deployment_id) FROM stdin;
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/jpa-changelog-1.0.0.Final.xml	2023-10-04 06:54:48.008035	1	EXECUTED	8:bda77d94bf90182a1e30c24f1c155ec7	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	6402487444
1.0.0.Final-KEYCLOAK-5461	sthorger@redhat.com	META-INF/db2-jpa-changelog-1.0.0.Final.xml	2023-10-04 06:54:48.015749	2	MARK_RAN	8:1ecb330f30986693d1cba9ab579fa219	createTable tableName=APPLICATION_DEFAULT_ROLES; createTable tableName=CLIENT; createTable tableName=CLIENT_SESSION; createTable tableName=CLIENT_SESSION_ROLE; createTable tableName=COMPOSITE_ROLE; createTable tableName=CREDENTIAL; createTable tab...		\N	4.8.0	\N	\N	6402487444
1.1.0.Beta1	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Beta1.xml	2023-10-04 06:54:48.069934	3	EXECUTED	8:cb7ace19bc6d959f305605d255d4c843	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=CLIENT_ATTRIBUTES; createTable tableName=CLIENT_SESSION_NOTE; createTable tableName=APP_NODE_REGISTRATIONS; addColumn table...		\N	4.8.0	\N	\N	6402487444
1.1.0.Final	sthorger@redhat.com	META-INF/jpa-changelog-1.1.0.Final.xml	2023-10-04 06:54:48.074882	4	EXECUTED	8:80230013e961310e6872e871be424a63	renameColumn newColumnName=EVENT_TIME, oldColumnName=TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	6402487444
1.2.0.Beta1	psilva@redhat.com	META-INF/jpa-changelog-1.2.0.Beta1.xml	2023-10-04 06:54:48.183039	5	EXECUTED	8:67f4c20929126adc0c8e9bf48279d244	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	6402487444
1.2.0.Beta1	psilva@redhat.com	META-INF/db2-jpa-changelog-1.2.0.Beta1.xml	2023-10-04 06:54:48.186483	6	MARK_RAN	8:7311018b0b8179ce14628ab412bb6783	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION; createTable tableName=PROTOCOL_MAPPER; createTable tableName=PROTOCOL_MAPPER_CONFIG; createTable tableName=...		\N	4.8.0	\N	\N	6402487444
1.2.0.RC1	bburke@redhat.com	META-INF/jpa-changelog-1.2.0.CR1.xml	2023-10-04 06:54:48.347479	7	EXECUTED	8:037ba1216c3640f8785ee6b8e7c8e3c1	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	6402487444
1.2.0.RC1	bburke@redhat.com	META-INF/db2-jpa-changelog-1.2.0.CR1.xml	2023-10-04 06:54:48.351226	8	MARK_RAN	8:7fe6ffe4af4df289b3157de32c624263	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=MIGRATION_MODEL; createTable tableName=IDENTITY_P...		\N	4.8.0	\N	\N	6402487444
1.2.0.Final	keycloak	META-INF/jpa-changelog-1.2.0.Final.xml	2023-10-04 06:54:48.3579	9	EXECUTED	8:9c136bc3187083a98745c7d03bc8a303	update tableName=CLIENT; update tableName=CLIENT; update tableName=CLIENT		\N	4.8.0	\N	\N	6402487444
1.3.0	bburke@redhat.com	META-INF/jpa-changelog-1.3.0.xml	2023-10-04 06:54:48.533064	10	EXECUTED	8:b5f09474dca81fb56a97cf5b6553d331	delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete tableName=USER_SESSION; createTable tableName=ADMI...		\N	4.8.0	\N	\N	6402487444
1.4.0	bburke@redhat.com	META-INF/jpa-changelog-1.4.0.xml	2023-10-04 06:54:48.606757	11	EXECUTED	8:ca924f31bd2a3b219fdcfe78c82dacf4	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	6402487444
1.4.0	bburke@redhat.com	META-INF/db2-jpa-changelog-1.4.0.xml	2023-10-04 06:54:48.614233	12	MARK_RAN	8:8acad7483e106416bcfa6f3b824a16cd	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	6402487444
1.5.0	bburke@redhat.com	META-INF/jpa-changelog-1.5.0.xml	2023-10-04 06:54:48.638288	13	EXECUTED	8:9b1266d17f4f87c78226f5055408fd5e	delete tableName=CLIENT_SESSION_AUTH_STATUS; delete tableName=CLIENT_SESSION_ROLE; delete tableName=CLIENT_SESSION_PROT_MAPPER; delete tableName=CLIENT_SESSION_NOTE; delete tableName=CLIENT_SESSION; delete tableName=USER_SESSION_NOTE; delete table...		\N	4.8.0	\N	\N	6402487444
1.6.1_from15	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-10-04 06:54:48.667933	14	EXECUTED	8:d80ec4ab6dbfe573550ff72396c7e910	addColumn tableName=REALM; addColumn tableName=KEYCLOAK_ROLE; addColumn tableName=CLIENT; createTable tableName=OFFLINE_USER_SESSION; createTable tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_US_SES_PK2, tableName=...		\N	4.8.0	\N	\N	6402487444
1.6.1_from16-pre	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-10-04 06:54:48.671223	15	MARK_RAN	8:d86eb172171e7c20b9c849b584d147b2	delete tableName=OFFLINE_CLIENT_SESSION; delete tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	6402487444
1.6.1_from16	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-10-04 06:54:48.67463	16	MARK_RAN	8:5735f46f0fa60689deb0ecdc2a0dea22	dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_US_SES_PK, tableName=OFFLINE_USER_SESSION; dropPrimaryKey constraintName=CONSTRAINT_OFFLINE_CL_SES_PK, tableName=OFFLINE_CLIENT_SESSION; addColumn tableName=OFFLINE_USER_SESSION; update tableName=OF...		\N	4.8.0	\N	\N	6402487444
1.6.1	mposolda@redhat.com	META-INF/jpa-changelog-1.6.1.xml	2023-10-04 06:54:48.677949	17	EXECUTED	8:d41d8cd98f00b204e9800998ecf8427e	empty		\N	4.8.0	\N	\N	6402487444
1.7.0	bburke@redhat.com	META-INF/jpa-changelog-1.7.0.xml	2023-10-04 06:54:48.741106	18	EXECUTED	8:5c1a8fd2014ac7fc43b90a700f117b23	createTable tableName=KEYCLOAK_GROUP; createTable tableName=GROUP_ROLE_MAPPING; createTable tableName=GROUP_ATTRIBUTE; createTable tableName=USER_GROUP_MEMBERSHIP; createTable tableName=REALM_DEFAULT_GROUPS; addColumn tableName=IDENTITY_PROVIDER; ...		\N	4.8.0	\N	\N	6402487444
1.8.0	mposolda@redhat.com	META-INF/jpa-changelog-1.8.0.xml	2023-10-04 06:54:48.805259	19	EXECUTED	8:1f6c2c2dfc362aff4ed75b3f0ef6b331	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	6402487444
1.8.0-2	keycloak	META-INF/jpa-changelog-1.8.0.xml	2023-10-04 06:54:48.812344	20	EXECUTED	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	6402487444
authz-3.4.0.CR1-resource-server-pk-change-part1	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-10-04 06:54:49.516399	45	EXECUTED	8:a164ae073c56ffdbc98a615493609a52	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_RESOURCE; addColumn tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	6402487444
1.8.0	mposolda@redhat.com	META-INF/db2-jpa-changelog-1.8.0.xml	2023-10-04 06:54:48.815806	21	MARK_RAN	8:9eb2ee1fa8ad1c5e426421a6f8fdfa6a	addColumn tableName=IDENTITY_PROVIDER; createTable tableName=CLIENT_TEMPLATE; createTable tableName=CLIENT_TEMPLATE_ATTRIBUTES; createTable tableName=TEMPLATE_SCOPE_MAPPING; dropNotNullConstraint columnName=CLIENT_ID, tableName=PROTOCOL_MAPPER; ad...		\N	4.8.0	\N	\N	6402487444
1.8.0-2	keycloak	META-INF/db2-jpa-changelog-1.8.0.xml	2023-10-04 06:54:48.81984	22	MARK_RAN	8:dee9246280915712591f83a127665107	dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; update tableName=CREDENTIAL		\N	4.8.0	\N	\N	6402487444
1.9.0	mposolda@redhat.com	META-INF/jpa-changelog-1.9.0.xml	2023-10-04 06:54:48.848424	23	EXECUTED	8:d9fa18ffa355320395b86270680dd4fe	update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=REALM; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=REALM; update tableName=REALM; customChange; dr...		\N	4.8.0	\N	\N	6402487444
1.9.1	keycloak	META-INF/jpa-changelog-1.9.1.xml	2023-10-04 06:54:48.85675	24	EXECUTED	8:90cff506fedb06141ffc1c71c4a1214c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=PUBLIC_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	6402487444
1.9.1	keycloak	META-INF/db2-jpa-changelog-1.9.1.xml	2023-10-04 06:54:48.860043	25	MARK_RAN	8:11a788aed4961d6d29c427c063af828c	modifyDataType columnName=PRIVATE_KEY, tableName=REALM; modifyDataType columnName=CERTIFICATE, tableName=REALM		\N	4.8.0	\N	\N	6402487444
1.9.2	keycloak	META-INF/jpa-changelog-1.9.2.xml	2023-10-04 06:54:48.920795	26	EXECUTED	8:a4218e51e1faf380518cce2af5d39b43	createIndex indexName=IDX_USER_EMAIL, tableName=USER_ENTITY; createIndex indexName=IDX_USER_ROLE_MAPPING, tableName=USER_ROLE_MAPPING; createIndex indexName=IDX_USER_GROUP_MAPPING, tableName=USER_GROUP_MEMBERSHIP; createIndex indexName=IDX_USER_CO...		\N	4.8.0	\N	\N	6402487444
authz-2.0.0	psilva@redhat.com	META-INF/jpa-changelog-authz-2.0.0.xml	2023-10-04 06:54:49.040585	27	EXECUTED	8:d9e9a1bfaa644da9952456050f07bbdc	createTable tableName=RESOURCE_SERVER; addPrimaryKey constraintName=CONSTRAINT_FARS, tableName=RESOURCE_SERVER; addUniqueConstraint constraintName=UK_AU8TT6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER; createTable tableName=RESOURCE_SERVER_RESOU...		\N	4.8.0	\N	\N	6402487444
authz-2.5.1	psilva@redhat.com	META-INF/jpa-changelog-authz-2.5.1.xml	2023-10-04 06:54:49.045082	28	EXECUTED	8:d1bf991a6163c0acbfe664b615314505	update tableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	6402487444
2.1.0-KEYCLOAK-5461	bburke@redhat.com	META-INF/jpa-changelog-2.1.0.xml	2023-10-04 06:54:49.14349	29	EXECUTED	8:88a743a1e87ec5e30bf603da68058a8c	createTable tableName=BROKER_LINK; createTable tableName=FED_USER_ATTRIBUTE; createTable tableName=FED_USER_CONSENT; createTable tableName=FED_USER_CONSENT_ROLE; createTable tableName=FED_USER_CONSENT_PROT_MAPPER; createTable tableName=FED_USER_CR...		\N	4.8.0	\N	\N	6402487444
2.2.0	bburke@redhat.com	META-INF/jpa-changelog-2.2.0.xml	2023-10-04 06:54:49.167118	30	EXECUTED	8:c5517863c875d325dea463d00ec26d7a	addColumn tableName=ADMIN_EVENT_ENTITY; createTable tableName=CREDENTIAL_ATTRIBUTE; createTable tableName=FED_CREDENTIAL_ATTRIBUTE; modifyDataType columnName=VALUE, tableName=CREDENTIAL; addForeignKeyConstraint baseTableName=FED_CREDENTIAL_ATTRIBU...		\N	4.8.0	\N	\N	6402487444
2.3.0	bburke@redhat.com	META-INF/jpa-changelog-2.3.0.xml	2023-10-04 06:54:49.194314	31	EXECUTED	8:ada8b4833b74a498f376d7136bc7d327	createTable tableName=FEDERATED_USER; addPrimaryKey constraintName=CONSTR_FEDERATED_USER, tableName=FEDERATED_USER; dropDefaultValue columnName=TOTP, tableName=USER_ENTITY; dropColumn columnName=TOTP, tableName=USER_ENTITY; addColumn tableName=IDE...		\N	4.8.0	\N	\N	6402487444
2.4.0	bburke@redhat.com	META-INF/jpa-changelog-2.4.0.xml	2023-10-04 06:54:49.200155	32	EXECUTED	8:b9b73c8ea7299457f99fcbb825c263ba	customChange		\N	4.8.0	\N	\N	6402487444
2.5.0	bburke@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-10-04 06:54:49.207911	33	EXECUTED	8:07724333e625ccfcfc5adc63d57314f3	customChange; modifyDataType columnName=USER_ID, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	6402487444
2.5.0-unicode-oracle	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-10-04 06:54:49.211093	34	MARK_RAN	8:8b6fd445958882efe55deb26fc541a7b	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	6402487444
2.5.0-unicode-other-dbs	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-10-04 06:54:49.246891	35	EXECUTED	8:29b29cfebfd12600897680147277a9d7	modifyDataType columnName=DESCRIPTION, tableName=AUTHENTICATION_FLOW; modifyDataType columnName=DESCRIPTION, tableName=CLIENT_TEMPLATE; modifyDataType columnName=DESCRIPTION, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=DESCRIPTION,...		\N	4.8.0	\N	\N	6402487444
2.5.0-duplicate-email-support	slawomir@dabek.name	META-INF/jpa-changelog-2.5.0.xml	2023-10-04 06:54:49.253334	36	EXECUTED	8:73ad77ca8fd0410c7f9f15a471fa52bc	addColumn tableName=REALM		\N	4.8.0	\N	\N	6402487444
2.5.0-unique-group-names	hmlnarik@redhat.com	META-INF/jpa-changelog-2.5.0.xml	2023-10-04 06:54:49.263146	37	EXECUTED	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	6402487444
2.5.1	bburke@redhat.com	META-INF/jpa-changelog-2.5.1.xml	2023-10-04 06:54:49.267907	38	EXECUTED	8:27180251182e6c31846c2ddab4bc5781	addColumn tableName=FED_USER_CONSENT		\N	4.8.0	\N	\N	6402487444
3.0.0	bburke@redhat.com	META-INF/jpa-changelog-3.0.0.xml	2023-10-04 06:54:49.273724	39	EXECUTED	8:d56f201bfcfa7a1413eb3e9bc02978f9	addColumn tableName=IDENTITY_PROVIDER		\N	4.8.0	\N	\N	6402487444
3.2.0-fix	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-10-04 06:54:49.277158	40	MARK_RAN	8:91f5522bf6afdc2077dfab57fbd3455c	addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	6402487444
3.2.0-fix-with-keycloak-5416	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-10-04 06:54:49.280624	41	MARK_RAN	8:0f01b554f256c22caeb7d8aee3a1cdc8	dropIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS; addNotNullConstraint columnName=REALM_ID, tableName=CLIENT_INITIAL_ACCESS; createIndex indexName=IDX_CLIENT_INIT_ACC_REALM, tableName=CLIENT_INITIAL_ACCESS		\N	4.8.0	\N	\N	6402487444
3.2.0-fix-offline-sessions	hmlnarik	META-INF/jpa-changelog-3.2.0.xml	2023-10-04 06:54:49.286767	42	EXECUTED	8:ab91cf9cee415867ade0e2df9651a947	customChange		\N	4.8.0	\N	\N	6402487444
3.2.0-fixed	keycloak	META-INF/jpa-changelog-3.2.0.xml	2023-10-04 06:54:49.505011	43	EXECUTED	8:ceac9b1889e97d602caf373eadb0d4b7	addColumn tableName=REALM; dropPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_PK2, tableName=OFFLINE_CLIENT_SESSION; dropColumn columnName=CLIENT_SESSION_ID, tableName=OFFLINE_CLIENT_SESSION; addPrimaryKey constraintName=CONSTRAINT_OFFL_CL_SES_P...		\N	4.8.0	\N	\N	6402487444
3.3.0	keycloak	META-INF/jpa-changelog-3.3.0.xml	2023-10-04 06:54:49.511033	44	EXECUTED	8:84b986e628fe8f7fd8fd3c275c5259f2	addColumn tableName=USER_ENTITY		\N	4.8.0	\N	\N	6402487444
authz-3.4.0.CR1-resource-server-pk-change-part2-KEYCLOAK-6095	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-10-04 06:54:49.520185	46	EXECUTED	8:70a2b4f1f4bd4dbf487114bdb1810e64	customChange		\N	4.8.0	\N	\N	6402487444
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-10-04 06:54:49.522456	47	MARK_RAN	8:7be68b71d2f5b94b8df2e824f2860fa2	dropIndex indexName=IDX_RES_SERV_POL_RES_SERV, tableName=RESOURCE_SERVER_POLICY; dropIndex indexName=IDX_RES_SRV_RES_RES_SRV, tableName=RESOURCE_SERVER_RESOURCE; dropIndex indexName=IDX_RES_SRV_SCOPE_RES_SRV, tableName=RESOURCE_SERVER_SCOPE		\N	4.8.0	\N	\N	6402487444
authz-3.4.0.CR1-resource-server-pk-change-part3-fixed-nodropindex	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-10-04 06:54:49.560508	48	EXECUTED	8:bab7c631093c3861d6cf6144cd944982	addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_POLICY; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, tableName=RESOURCE_SERVER_RESOURCE; addNotNullConstraint columnName=RESOURCE_SERVER_CLIENT_ID, ...		\N	4.8.0	\N	\N	6402487444
authn-3.4.0.CR1-refresh-token-max-reuse	glavoie@gmail.com	META-INF/jpa-changelog-authz-3.4.0.CR1.xml	2023-10-04 06:54:49.565036	49	EXECUTED	8:fa809ac11877d74d76fe40869916daad	addColumn tableName=REALM		\N	4.8.0	\N	\N	6402487444
3.4.0	keycloak	META-INF/jpa-changelog-3.4.0.xml	2023-10-04 06:54:49.626899	50	EXECUTED	8:fac23540a40208f5f5e326f6ceb4d291	addPrimaryKey constraintName=CONSTRAINT_REALM_DEFAULT_ROLES, tableName=REALM_DEFAULT_ROLES; addPrimaryKey constraintName=CONSTRAINT_COMPOSITE_ROLE, tableName=COMPOSITE_ROLE; addPrimaryKey constraintName=CONSTR_REALM_DEFAULT_GROUPS, tableName=REALM...		\N	4.8.0	\N	\N	6402487444
3.4.0-KEYCLOAK-5230	hmlnarik@redhat.com	META-INF/jpa-changelog-3.4.0.xml	2023-10-04 06:54:49.670106	51	EXECUTED	8:2612d1b8a97e2b5588c346e817307593	createIndex indexName=IDX_FU_ATTRIBUTE, tableName=FED_USER_ATTRIBUTE; createIndex indexName=IDX_FU_CONSENT, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CONSENT_RU, tableName=FED_USER_CONSENT; createIndex indexName=IDX_FU_CREDENTIAL, t...		\N	4.8.0	\N	\N	6402487444
3.4.1	psilva@redhat.com	META-INF/jpa-changelog-3.4.1.xml	2023-10-04 06:54:49.674332	52	EXECUTED	8:9842f155c5db2206c88bcb5d1046e941	modifyDataType columnName=VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	6402487444
3.4.2	keycloak	META-INF/jpa-changelog-3.4.2.xml	2023-10-04 06:54:49.677124	53	EXECUTED	8:2e12e06e45498406db72d5b3da5bbc76	update tableName=REALM		\N	4.8.0	\N	\N	6402487444
3.4.2-KEYCLOAK-5172	mkanis@redhat.com	META-INF/jpa-changelog-3.4.2.xml	2023-10-04 06:54:49.681006	54	EXECUTED	8:33560e7c7989250c40da3abdabdc75a4	update tableName=CLIENT		\N	4.8.0	\N	\N	6402487444
4.0.0-KEYCLOAK-6335	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-10-04 06:54:49.690547	55	EXECUTED	8:87a8d8542046817a9107c7eb9cbad1cd	createTable tableName=CLIENT_AUTH_FLOW_BINDINGS; addPrimaryKey constraintName=C_CLI_FLOW_BIND, tableName=CLIENT_AUTH_FLOW_BINDINGS		\N	4.8.0	\N	\N	6402487444
4.0.0-CLEANUP-UNUSED-TABLE	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-10-04 06:54:49.696001	56	EXECUTED	8:3ea08490a70215ed0088c273d776311e	dropTable tableName=CLIENT_IDENTITY_PROV_MAPPING		\N	4.8.0	\N	\N	6402487444
4.0.0-KEYCLOAK-6228	bburke@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-10-04 06:54:49.719872	57	EXECUTED	8:2d56697c8723d4592ab608ce14b6ed68	dropUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHOGM8UEWRT, tableName=USER_CONSENT; dropNotNullConstraint columnName=CLIENT_ID, tableName=USER_CONSENT; addColumn tableName=USER_CONSENT; addUniqueConstraint constraintName=UK_JKUWUVD56ONTGSUHO...		\N	4.8.0	\N	\N	6402487444
4.0.0-KEYCLOAK-5579-fixed	mposolda@redhat.com	META-INF/jpa-changelog-4.0.0.xml	2023-10-04 06:54:49.820691	58	EXECUTED	8:3e423e249f6068ea2bbe48bf907f9d86	dropForeignKeyConstraint baseTableName=CLIENT_TEMPLATE_ATTRIBUTES, constraintName=FK_CL_TEMPL_ATTR_TEMPL; renameTable newTableName=CLIENT_SCOPE_ATTRIBUTES, oldTableName=CLIENT_TEMPLATE_ATTRIBUTES; renameColumn newColumnName=SCOPE_ID, oldColumnName...		\N	4.8.0	\N	\N	6402487444
authz-4.0.0.CR1	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.CR1.xml	2023-10-04 06:54:49.85242	59	EXECUTED	8:15cabee5e5df0ff099510a0fc03e4103	createTable tableName=RESOURCE_SERVER_PERM_TICKET; addPrimaryKey constraintName=CONSTRAINT_FAPMT, tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRHO213XCX4WNKOG82SSPMT...		\N	4.8.0	\N	\N	6402487444
authz-4.0.0.Beta3	psilva@redhat.com	META-INF/jpa-changelog-authz-4.0.0.Beta3.xml	2023-10-04 06:54:49.858811	60	EXECUTED	8:4b80200af916ac54d2ffbfc47918ab0e	addColumn tableName=RESOURCE_SERVER_POLICY; addColumn tableName=RESOURCE_SERVER_PERM_TICKET; addForeignKeyConstraint baseTableName=RESOURCE_SERVER_PERM_TICKET, constraintName=FK_FRSRPO2128CX4WNKOG82SSRFY, referencedTableName=RESOURCE_SERVER_POLICY		\N	4.8.0	\N	\N	6402487444
authz-4.2.0.Final	mhajas@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-10-04 06:54:49.865865	61	EXECUTED	8:66564cd5e168045d52252c5027485bbb	createTable tableName=RESOURCE_URIS; addForeignKeyConstraint baseTableName=RESOURCE_URIS, constraintName=FK_RESOURCE_SERVER_URIS, referencedTableName=RESOURCE_SERVER_RESOURCE; customChange; dropColumn columnName=URI, tableName=RESOURCE_SERVER_RESO...		\N	4.8.0	\N	\N	6402487444
authz-4.2.0.Final-KEYCLOAK-9944	hmlnarik@redhat.com	META-INF/jpa-changelog-authz-4.2.0.Final.xml	2023-10-04 06:54:49.873313	62	EXECUTED	8:1c7064fafb030222be2bd16ccf690f6f	addPrimaryKey constraintName=CONSTRAINT_RESOUR_URIS_PK, tableName=RESOURCE_URIS		\N	4.8.0	\N	\N	6402487444
4.2.0-KEYCLOAK-6313	wadahiro@gmail.com	META-INF/jpa-changelog-4.2.0.xml	2023-10-04 06:54:49.8765	63	EXECUTED	8:2de18a0dce10cdda5c7e65c9b719b6e5	addColumn tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	6402487444
4.3.0-KEYCLOAK-7984	wadahiro@gmail.com	META-INF/jpa-changelog-4.3.0.xml	2023-10-04 06:54:49.878389	64	EXECUTED	8:03e413dd182dcbd5c57e41c34d0ef682	update tableName=REQUIRED_ACTION_PROVIDER		\N	4.8.0	\N	\N	6402487444
4.6.0-KEYCLOAK-7950	psilva@redhat.com	META-INF/jpa-changelog-4.6.0.xml	2023-10-04 06:54:49.881375	65	EXECUTED	8:d27b42bb2571c18fbe3fe4e4fb7582a7	update tableName=RESOURCE_SERVER_RESOURCE		\N	4.8.0	\N	\N	6402487444
4.6.0-KEYCLOAK-8377	keycloak	META-INF/jpa-changelog-4.6.0.xml	2023-10-04 06:54:49.896435	66	EXECUTED	8:698baf84d9fd0027e9192717c2154fb8	createTable tableName=ROLE_ATTRIBUTE; addPrimaryKey constraintName=CONSTRAINT_ROLE_ATTRIBUTE_PK, tableName=ROLE_ATTRIBUTE; addForeignKeyConstraint baseTableName=ROLE_ATTRIBUTE, constraintName=FK_ROLE_ATTRIBUTE_ID, referencedTableName=KEYCLOAK_ROLE...		\N	4.8.0	\N	\N	6402487444
4.6.0-KEYCLOAK-8555	gideonray@gmail.com	META-INF/jpa-changelog-4.6.0.xml	2023-10-04 06:54:49.904417	67	EXECUTED	8:ced8822edf0f75ef26eb51582f9a821a	createIndex indexName=IDX_COMPONENT_PROVIDER_TYPE, tableName=COMPONENT		\N	4.8.0	\N	\N	6402487444
4.7.0-KEYCLOAK-1267	sguilhen@redhat.com	META-INF/jpa-changelog-4.7.0.xml	2023-10-04 06:54:49.909396	68	EXECUTED	8:f0abba004cf429e8afc43056df06487d	addColumn tableName=REALM		\N	4.8.0	\N	\N	6402487444
4.7.0-KEYCLOAK-7275	keycloak	META-INF/jpa-changelog-4.7.0.xml	2023-10-04 06:54:49.920628	69	EXECUTED	8:6662f8b0b611caa359fcf13bf63b4e24	renameColumn newColumnName=CREATED_ON, oldColumnName=LAST_SESSION_REFRESH, tableName=OFFLINE_USER_SESSION; addNotNullConstraint columnName=CREATED_ON, tableName=OFFLINE_USER_SESSION; addColumn tableName=OFFLINE_USER_SESSION; customChange; createIn...		\N	4.8.0	\N	\N	6402487444
4.8.0-KEYCLOAK-8835	sguilhen@redhat.com	META-INF/jpa-changelog-4.8.0.xml	2023-10-04 06:54:49.925988	70	EXECUTED	8:9e6b8009560f684250bdbdf97670d39e	addNotNullConstraint columnName=SSO_MAX_LIFESPAN_REMEMBER_ME, tableName=REALM; addNotNullConstraint columnName=SSO_IDLE_TIMEOUT_REMEMBER_ME, tableName=REALM		\N	4.8.0	\N	\N	6402487444
authz-7.0.0-KEYCLOAK-10443	psilva@redhat.com	META-INF/jpa-changelog-authz-7.0.0.xml	2023-10-04 06:54:49.930088	71	EXECUTED	8:4223f561f3b8dc655846562b57bb502e	addColumn tableName=RESOURCE_SERVER		\N	4.8.0	\N	\N	6402487444
8.0.0-adding-credential-columns	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-10-04 06:54:49.934621	72	EXECUTED	8:215a31c398b363ce383a2b301202f29e	addColumn tableName=CREDENTIAL; addColumn tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	6402487444
8.0.0-updating-credential-data-not-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-10-04 06:54:49.938721	73	EXECUTED	8:83f7a671792ca98b3cbd3a1a34862d3d	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	6402487444
8.0.0-updating-credential-data-oracle-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-10-04 06:54:49.940915	74	MARK_RAN	8:f58ad148698cf30707a6efbdf8061aa7	update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL; update tableName=FED_USER_CREDENTIAL		\N	4.8.0	\N	\N	6402487444
8.0.0-credential-cleanup-fixed	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-10-04 06:54:49.950477	75	EXECUTED	8:79e4fd6c6442980e58d52ffc3ee7b19c	dropDefaultValue columnName=COUNTER, tableName=CREDENTIAL; dropDefaultValue columnName=DIGITS, tableName=CREDENTIAL; dropDefaultValue columnName=PERIOD, tableName=CREDENTIAL; dropDefaultValue columnName=ALGORITHM, tableName=CREDENTIAL; dropColumn ...		\N	4.8.0	\N	\N	6402487444
8.0.0-resource-tag-support	keycloak	META-INF/jpa-changelog-8.0.0.xml	2023-10-04 06:54:49.957605	76	EXECUTED	8:87af6a1e6d241ca4b15801d1f86a297d	addColumn tableName=MIGRATION_MODEL; createIndex indexName=IDX_UPDATE_TIME, tableName=MIGRATION_MODEL		\N	4.8.0	\N	\N	6402487444
9.0.0-always-display-client	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-10-04 06:54:49.961705	77	EXECUTED	8:b44f8d9b7b6ea455305a6d72a200ed15	addColumn tableName=CLIENT		\N	4.8.0	\N	\N	6402487444
9.0.0-drop-constraints-for-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-10-04 06:54:49.963676	78	MARK_RAN	8:2d8ed5aaaeffd0cb004c046b4a903ac5	dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5PMT, tableName=RESOURCE_SERVER_PERM_TICKET; dropUniqueConstraint constraintName=UK_FRSR6T700S9V50BU18WS5HA6, tableName=RESOURCE_SERVER_RESOURCE; dropPrimaryKey constraintName=CONSTRAINT_O...		\N	4.8.0	\N	\N	6402487444
9.0.0-increase-column-size-federated-fk	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-10-04 06:54:49.976673	79	EXECUTED	8:e290c01fcbc275326c511633f6e2acde	modifyDataType columnName=CLIENT_ID, tableName=FED_USER_CONSENT; modifyDataType columnName=CLIENT_REALM_CONSTRAINT, tableName=KEYCLOAK_ROLE; modifyDataType columnName=OWNER, tableName=RESOURCE_SERVER_POLICY; modifyDataType columnName=CLIENT_ID, ta...		\N	4.8.0	\N	\N	6402487444
9.0.0-recreate-constraints-after-column-increase	keycloak	META-INF/jpa-changelog-9.0.0.xml	2023-10-04 06:54:49.978415	80	MARK_RAN	8:c9db8784c33cea210872ac2d805439f8	addNotNullConstraint columnName=CLIENT_ID, tableName=OFFLINE_CLIENT_SESSION; addNotNullConstraint columnName=OWNER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNullConstraint columnName=REQUESTER, tableName=RESOURCE_SERVER_PERM_TICKET; addNotNull...		\N	4.8.0	\N	\N	6402487444
9.0.1-add-index-to-client.client_id	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-10-04 06:54:49.984989	81	EXECUTED	8:95b676ce8fc546a1fcfb4c92fae4add5	createIndex indexName=IDX_CLIENT_ID, tableName=CLIENT		\N	4.8.0	\N	\N	6402487444
9.0.1-KEYCLOAK-12579-drop-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-10-04 06:54:49.987308	82	MARK_RAN	8:38a6b2a41f5651018b1aca93a41401e5	dropUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	6402487444
9.0.1-KEYCLOAK-12579-add-not-null-constraint	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-10-04 06:54:49.992131	83	EXECUTED	8:3fb99bcad86a0229783123ac52f7609c	addNotNullConstraint columnName=PARENT_GROUP, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	6402487444
9.0.1-KEYCLOAK-12579-recreate-constraints	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-10-04 06:54:49.994393	84	MARK_RAN	8:64f27a6fdcad57f6f9153210f2ec1bdb	addUniqueConstraint constraintName=SIBLING_NAMES, tableName=KEYCLOAK_GROUP		\N	4.8.0	\N	\N	6402487444
9.0.1-add-index-to-events	keycloak	META-INF/jpa-changelog-9.0.1.xml	2023-10-04 06:54:50.002883	85	EXECUTED	8:ab4f863f39adafd4c862f7ec01890abc	createIndex indexName=IDX_EVENT_TIME, tableName=EVENT_ENTITY		\N	4.8.0	\N	\N	6402487444
map-remove-ri	keycloak	META-INF/jpa-changelog-11.0.0.xml	2023-10-04 06:54:50.008939	86	EXECUTED	8:13c419a0eb336e91ee3a3bf8fda6e2a7	dropForeignKeyConstraint baseTableName=REALM, constraintName=FK_TRAF444KK6QRKMS7N56AIWQ5Y; dropForeignKeyConstraint baseTableName=KEYCLOAK_ROLE, constraintName=FK_KJHO5LE2C0RAL09FL8CM9WFW9		\N	4.8.0	\N	\N	6402487444
map-remove-ri	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-10-04 06:54:50.016479	87	EXECUTED	8:e3fb1e698e0471487f51af1ed80fe3ac	dropForeignKeyConstraint baseTableName=REALM_DEFAULT_GROUPS, constraintName=FK_DEF_GROUPS_GROUP; dropForeignKeyConstraint baseTableName=REALM_DEFAULT_ROLES, constraintName=FK_H4WPD7W4HSOOLNI3H0SW7BTJE; dropForeignKeyConstraint baseTableName=CLIENT...		\N	4.8.0	\N	\N	6402487444
12.1.0-add-realm-localization-table	keycloak	META-INF/jpa-changelog-12.0.0.xml	2023-10-04 06:54:50.030652	88	EXECUTED	8:babadb686aab7b56562817e60bf0abd0	createTable tableName=REALM_LOCALIZATIONS; addPrimaryKey tableName=REALM_LOCALIZATIONS		\N	4.8.0	\N	\N	6402487444
default-roles	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.038166	89	EXECUTED	8:72d03345fda8e2f17093d08801947773	addColumn tableName=REALM; customChange		\N	4.8.0	\N	\N	6402487444
default-roles-cleanup	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.044573	90	EXECUTED	8:61c9233951bd96ffecd9ba75f7d978a4	dropTable tableName=REALM_DEFAULT_ROLES; dropTable tableName=CLIENT_DEFAULT_ROLES		\N	4.8.0	\N	\N	6402487444
13.0.0-KEYCLOAK-16844	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.052905	91	EXECUTED	8:ea82e6ad945cec250af6372767b25525	createIndex indexName=IDX_OFFLINE_USS_PRELOAD, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	6402487444
map-remove-ri-13.0.0	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.059551	92	EXECUTED	8:d3f4a33f41d960ddacd7e2ef30d126b3	dropForeignKeyConstraint baseTableName=DEFAULT_CLIENT_SCOPE, constraintName=FK_R_DEF_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SCOPE_CLIENT, constraintName=FK_C_CLI_SCOPE_SCOPE; dropForeignKeyConstraint baseTableName=CLIENT_SC...		\N	4.8.0	\N	\N	6402487444
13.0.0-KEYCLOAK-17992-drop-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.061714	93	MARK_RAN	8:1284a27fbd049d65831cb6fc07c8a783	dropPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CLSCOPE_CL, tableName=CLIENT_SCOPE_CLIENT; dropIndex indexName=IDX_CL_CLSCOPE, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	6402487444
13.0.0-increase-column-size-federated	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.070905	94	EXECUTED	8:9d11b619db2ae27c25853b8a37cd0dea	modifyDataType columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; modifyDataType columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT		\N	4.8.0	\N	\N	6402487444
13.0.0-KEYCLOAK-17992-recreate-constraints	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.073465	95	MARK_RAN	8:3002bb3997451bb9e8bac5c5cd8d6327	addNotNullConstraint columnName=CLIENT_ID, tableName=CLIENT_SCOPE_CLIENT; addNotNullConstraint columnName=SCOPE_ID, tableName=CLIENT_SCOPE_CLIENT; addPrimaryKey constraintName=C_CLI_SCOPE_BIND, tableName=CLIENT_SCOPE_CLIENT; createIndex indexName=...		\N	4.8.0	\N	\N	6402487444
json-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-13.0.0.xml	2023-10-04 06:54:50.078095	96	EXECUTED	8:dfbee0d6237a23ef4ccbb7a4e063c163	addColumn tableName=REALM_ATTRIBUTE; update tableName=REALM_ATTRIBUTE; dropColumn columnName=VALUE, tableName=REALM_ATTRIBUTE; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=REALM_ATTRIBUTE		\N	4.8.0	\N	\N	6402487444
14.0.0-KEYCLOAK-11019	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-10-04 06:54:50.092213	97	EXECUTED	8:75f3e372df18d38c62734eebb986b960	createIndex indexName=IDX_OFFLINE_CSS_PRELOAD, tableName=OFFLINE_CLIENT_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USER, tableName=OFFLINE_USER_SESSION; createIndex indexName=IDX_OFFLINE_USS_BY_USERSESS, tableName=OFFLINE_USER_SESSION		\N	4.8.0	\N	\N	6402487444
14.0.0-KEYCLOAK-18286	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-10-04 06:54:50.094261	98	MARK_RAN	8:7fee73eddf84a6035691512c85637eef	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	6402487444
14.0.0-KEYCLOAK-18286-revert	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-10-04 06:54:50.103453	99	MARK_RAN	8:7a11134ab12820f999fbf3bb13c3adc8	dropIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	6402487444
14.0.0-KEYCLOAK-18286-supported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-10-04 06:54:50.110451	100	EXECUTED	8:c0f6eaac1f3be773ffe54cb5b8482b70	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	6402487444
14.0.0-KEYCLOAK-18286-unsupported-dbs	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-10-04 06:54:50.113158	101	MARK_RAN	8:18186f0008b86e0f0f49b0c4d0e842ac	createIndex indexName=IDX_CLIENT_ATT_BY_NAME_VALUE, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	6402487444
KEYCLOAK-17267-add-index-to-user-attributes	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-10-04 06:54:50.122063	102	EXECUTED	8:09c2780bcb23b310a7019d217dc7b433	createIndex indexName=IDX_USER_ATTRIBUTE_NAME, tableName=USER_ATTRIBUTE		\N	4.8.0	\N	\N	6402487444
KEYCLOAK-18146-add-saml-art-binding-identifier	keycloak	META-INF/jpa-changelog-14.0.0.xml	2023-10-04 06:54:50.127296	103	EXECUTED	8:276a44955eab693c970a42880197fff2	customChange		\N	4.8.0	\N	\N	6402487444
15.0.0-KEYCLOAK-18467	keycloak	META-INF/jpa-changelog-15.0.0.xml	2023-10-04 06:54:50.134553	104	EXECUTED	8:ba8ee3b694d043f2bfc1a1079d0760d7	addColumn tableName=REALM_LOCALIZATIONS; update tableName=REALM_LOCALIZATIONS; dropColumn columnName=TEXTS, tableName=REALM_LOCALIZATIONS; renameColumn newColumnName=TEXTS, oldColumnName=TEXTS_NEW, tableName=REALM_LOCALIZATIONS; addNotNullConstrai...		\N	4.8.0	\N	\N	6402487444
17.0.0-9562	keycloak	META-INF/jpa-changelog-17.0.0.xml	2023-10-04 06:54:50.143025	105	EXECUTED	8:5e06b1d75f5d17685485e610c2851b17	createIndex indexName=IDX_USER_SERVICE_ACCOUNT, tableName=USER_ENTITY		\N	4.8.0	\N	\N	6402487444
18.0.0-10625-IDX_ADMIN_EVENT_TIME	keycloak	META-INF/jpa-changelog-18.0.0.xml	2023-10-04 06:54:50.149941	106	EXECUTED	8:4b80546c1dc550ac552ee7b24a4ab7c0	createIndex indexName=IDX_ADMIN_EVENT_TIME, tableName=ADMIN_EVENT_ENTITY		\N	4.8.0	\N	\N	6402487444
19.0.0-10135	keycloak	META-INF/jpa-changelog-19.0.0.xml	2023-10-04 06:54:50.153673	107	EXECUTED	8:af510cd1bb2ab6339c45372f3e491696	customChange		\N	4.8.0	\N	\N	6402487444
20.0.0-12964-supported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-10-04 06:54:50.16123	108	EXECUTED	8:05c99fc610845ef66ee812b7921af0ef	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	6402487444
20.0.0-12964-unsupported-dbs	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-10-04 06:54:50.163282	109	MARK_RAN	8:314e803baf2f1ec315b3464e398b8247	createIndex indexName=IDX_GROUP_ATT_BY_NAME_VALUE, tableName=GROUP_ATTRIBUTE		\N	4.8.0	\N	\N	6402487444
client-attributes-string-accomodation-fixed	keycloak	META-INF/jpa-changelog-20.0.0.xml	2023-10-04 06:54:50.168701	110	EXECUTED	8:56e4677e7e12556f70b604c573840100	addColumn tableName=CLIENT_ATTRIBUTES; update tableName=CLIENT_ATTRIBUTES; dropColumn columnName=VALUE, tableName=CLIENT_ATTRIBUTES; renameColumn newColumnName=VALUE, oldColumnName=VALUE_NEW, tableName=CLIENT_ATTRIBUTES		\N	4.8.0	\N	\N	6402487444
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
793c40ee-e7c8-4e66-9f1c-f16bc168faba	4a4d3081-78d4-4246-9f5d-fbfea5b16f39	f
793c40ee-e7c8-4e66-9f1c-f16bc168faba	994a47b2-aac3-45dd-b548-51783d733859	t
793c40ee-e7c8-4e66-9f1c-f16bc168faba	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680	t
793c40ee-e7c8-4e66-9f1c-f16bc168faba	f0182005-5e27-48cc-b5fe-add7123e9ccb	t
793c40ee-e7c8-4e66-9f1c-f16bc168faba	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b	f
793c40ee-e7c8-4e66-9f1c-f16bc168faba	4767f6ce-ba60-4040-bad0-9112fcac3d96	f
793c40ee-e7c8-4e66-9f1c-f16bc168faba	00588fda-f105-4024-8ac3-3449cba23aae	t
793c40ee-e7c8-4e66-9f1c-f16bc168faba	2d7e87ee-3a83-44a1-ac5b-cf7312611427	t
793c40ee-e7c8-4e66-9f1c-f16bc168faba	74194b40-0439-449b-87c0-4c6f55919642	f
793c40ee-e7c8-4e66-9f1c-f16bc168faba	673f0ad8-8195-4ca4-9366-06eb6107edf5	t
fiware-server	96b86330-6560-448e-b80f-f6a9c34a8349	t
fiware-server	ffcdff24-fb2c-4744-b9e2-f249166d2a58	t
fiware-server	68255313-fc10-4e6c-a316-cd6f1cbd608e	t
fiware-server	7fd06f00-0061-4d12-86fa-41b9a2f5122c	t
fiware-server	3077f964-343d-4ab4-ad61-98ed2088b520	t
fiware-server	c43a27a3-54c7-4f47-a963-a5428676d666	f
fiware-server	2370700b-64c3-4047-9ce8-6fbfde4fd04d	f
fiware-server	f1164b55-b30c-4baa-a08f-093bd09ddd62	f
fiware-server	8d32b4b2-f351-4182-98fa-d25b657a981f	f
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
00ee5552-fe41-4428-b673-cfe9be5958cf	a757ca8d-3fed-4542-8e93-f86f5b2494bf
a74afe7c-6abb-447f-903b-8708e2f4948a	a757ca8d-3fed-4542-8e93-f86f5b2494bf
00ee5552-fe41-4428-b673-cfe9be5958cf	232d063e-a260-410b-ba99-c90381800b37
e7bbe704-0189-4107-b5d6-54c1b355acca	232d063e-a260-410b-ba99-c90381800b37
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
a757ca8d-3fed-4542-8e93-f86f5b2494bf	admin	 	fiware-server
232d063e-a260-410b-ba99-c90381800b37	consumer	 	fiware-server
\.


--
-- Data for Name: keycloak_role; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.keycloak_role (id, client_realm_constraint, client_role, description, name, realm_id, client, realm) FROM stdin;
1d012033-0bac-42b2-880f-16e38cd3bf9d	793c40ee-e7c8-4e66-9f1c-f16bc168faba	f	${role_default-roles}	default-roles-master	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N	\N
4666ddf9-c608-492e-bf54-52a026e93a50	793c40ee-e7c8-4e66-9f1c-f16bc168faba	f	${role_create-realm}	create-realm	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N	\N
cf5f6b45-df29-401a-a4d3-4088673e79a5	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_create-client}	create-client	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
b04e482c-1275-4bcb-8624-68c69f87020f	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_view-realm}	view-realm	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
5376d61b-9013-4774-9408-4d93230898f7	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_view-users}	view-users	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
ed4ed974-1c2d-40e7-bc88-076dc30a4cfb	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_view-clients}	view-clients	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
c85b9111-b93c-46ef-808a-306726f16b43	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_view-events}	view-events	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
43789923-db11-4839-b300-3e3643c1fa97	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_view-identity-providers}	view-identity-providers	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
3f8e8579-af84-4fd9-8f15-0a000b76cccf	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_view-authorization}	view-authorization	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
e0452cd0-2f05-4dde-9ee8-a53309449295	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_manage-realm}	manage-realm	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
febee4b1-c9f1-4069-b791-267555c3329c	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_manage-users}	manage-users	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
71edf28f-2a68-4319-af39-acadce114b73	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_manage-clients}	manage-clients	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
40a4becd-a819-478d-9d99-f8bfcbd0ec7d	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_manage-events}	manage-events	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
471fbc86-edb1-4af5-8157-439c572941f2	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_manage-identity-providers}	manage-identity-providers	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
5f13ed39-4643-411f-92b3-ff812df7e65c	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_manage-authorization}	manage-authorization	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
855f328d-7008-4aba-8fd6-ae7e07eacb95	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_query-users}	query-users	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
cf867a58-707e-4734-93aa-179f6be06786	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_query-clients}	query-clients	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
4b9f3e04-f803-4625-8fde-592c84009d01	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_query-realms}	query-realms	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
3f92ce8b-266c-447c-820d-7c4531b8765b	793c40ee-e7c8-4e66-9f1c-f16bc168faba	f	${role_admin}	admin	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N	\N
d9567aab-3647-40b7-935f-88a439d687f5	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_query-groups}	query-groups	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
319fca69-e4a4-479a-9c63-f71867ef0292	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_view-profile}	view-profile	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
d32ad624-e595-4cbd-8c14-bc3d7334edf0	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_manage-account}	manage-account	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
8f8622ff-342a-4073-97ac-cb265c57e56e	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_manage-account-links}	manage-account-links	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
a78fc74b-d606-4420-9201-437f5f942656	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_view-applications}	view-applications	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
faa24ea2-0012-4e7d-8c08-ece0dad949ab	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_view-consent}	view-consent	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
05b00561-0905-4d03-9208-eb3467c2ab1b	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_manage-consent}	manage-consent	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
b6e51f65-125a-4f3d-b28e-99824bae06f3	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_view-groups}	view-groups	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
17dc8607-96ba-4738-bef1-a90e064af143	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	t	${role_delete-account}	delete-account	793c40ee-e7c8-4e66-9f1c-f16bc168faba	8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	\N
0a530a8e-c247-4773-aaa2-97ec8db8466a	162efb0f-aaec-4907-a1ce-ce9d23547587	t	${role_read-token}	read-token	793c40ee-e7c8-4e66-9f1c-f16bc168faba	162efb0f-aaec-4907-a1ce-ce9d23547587	\N
c539f24b-94b5-4213-b909-b9c23e18475e	c3978641-c47f-4196-97fa-a9616c3ff17f	t	${role_impersonation}	impersonation	793c40ee-e7c8-4e66-9f1c-f16bc168faba	c3978641-c47f-4196-97fa-a9616c3ff17f	\N
ea7aaccc-4b43-41f6-b5a2-26a8dac82569	793c40ee-e7c8-4e66-9f1c-f16bc168faba	f	${role_offline-access}	offline_access	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N	\N
c1b0e9e7-f8f1-426f-86d5-4c0401f3135d	793c40ee-e7c8-4e66-9f1c-f16bc168faba	f	${role_uma_authorization}	uma_authorization	793c40ee-e7c8-4e66-9f1c-f16bc168faba	\N	\N
a63452df-a422-42be-bacd-26318bbd7b85	fiware-server	f	${role_default-roles}	default-roles-fiware-server	fiware-server	\N	\N
cc1be155-5151-4c89-b010-14152a8e5a38	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_create-client}	create-client	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
9065647d-ee18-43b1-a39b-c7d09de8b935	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_view-realm}	view-realm	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
0c4f6146-d816-4739-b62e-4fd75ddff9b3	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_view-users}	view-users	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
deaf6b58-86f9-47f3-93c7-f5858a7e21f5	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_view-clients}	view-clients	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
b82ea2c8-3710-4042-824f-d59aa0420472	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_view-events}	view-events	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
4f133514-2fa4-4f7d-bb5d-dfc72fd82070	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_view-identity-providers}	view-identity-providers	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
b7d00df1-5d9a-42e6-aa75-d4382deeb3d0	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_view-authorization}	view-authorization	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
7b87237f-6c26-4bc1-8167-da50409dffb7	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_manage-realm}	manage-realm	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
a4681698-82b7-4679-98d7-b58f87681c44	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_manage-users}	manage-users	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
f787f9a9-8451-47b6-9306-9ab7d0c9750d	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_manage-clients}	manage-clients	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
b8821c73-f61e-4042-b222-83e59db77c10	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_manage-events}	manage-events	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
0dac1e0b-51b2-435e-a9ce-98e7b473780c	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_manage-identity-providers}	manage-identity-providers	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
4d30fa9b-8ecb-4f88-82a5-decb932c65e7	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_manage-authorization}	manage-authorization	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
dcd3e975-6c6b-4461-8ef2-c5b8cdd05f6a	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_query-users}	query-users	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
b2b26750-c206-42c9-9a3e-5afcfc1d347a	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_query-clients}	query-clients	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
5ea5e470-aecb-4a44-a155-b2c9ea9cc3bd	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_query-realms}	query-realms	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
eb5ce614-d3c0-4e93-bf92-3d406114d0be	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_query-groups}	query-groups	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
88e8d0e1-fc32-47df-be80-7b6496d01b76	fiware-server	f	${role_offline-access}	offline_access	fiware-server	\N	\N
00ee5552-fe41-4428-b673-cfe9be5958cf	fiware-server	f	User privileges	user	fiware-server	\N	\N
b359ee9a-dc5d-4192-b525-97b3cae86e6a	fiware-server	f	${role_uma_authorization}	uma_authorization	fiware-server	\N	\N
4e5134b7-b6e9-420a-8fdd-b22fbd760a56	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_query-clients}	query-clients	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
27c452f2-562b-4af7-a3b5-eb033fbfbaac	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_manage-realm}	manage-realm	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
c961b24b-5c6a-4b03-af63-04521be8a2b0	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_view-authorization}	view-authorization	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
2ffc73af-031f-42c8-af19-d536e467353f	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_query-groups}	query-groups	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
a61321c5-0743-43d1-802a-cb527ca644b7	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_view-events}	view-events	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
d86762fc-bfcd-4321-a5ff-92b988b72b13	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_manage-users}	manage-users	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
85eb5262-cafb-4b94-8883-9e7fbf148cd5	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_manage-identity-providers}	manage-identity-providers	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
7987d9b1-a6fb-42ee-87fb-f894d537a8df	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_view-users}	view-users	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
4c28d43c-4507-4ab3-9d55-6bdafca61ddf	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_create-client}	create-client	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
75b71950-82bc-49df-a37d-22331813e50a	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_manage-authorization}	manage-authorization	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
29ebf4db-27c5-467d-b1fe-557a273e77c3	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_query-users}	query-users	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
d4fee5d8-639b-4998-853a-db420a6fdf21	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_view-clients}	view-clients	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
5a2ef4df-8ae6-46fd-94fb-7fae3369c9ed	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_impersonation}	impersonation	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
2704797b-f87f-4574-9fec-3a52ec7e7e6c	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_view-realm}	view-realm	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
f34f8c0c-a8ff-45c5-b6b4-b25a8f61f721	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_realm-admin}	realm-admin	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
5ebb1557-2a46-47e2-9c8c-d86466a1b86f	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_query-realms}	query-realms	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
66e21d0e-caf3-4ddd-b3a4-427cacb2c274	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_manage-clients}	manage-clients	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
826110e5-9de5-4e8b-a4ff-f07a85a660f9	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_manage-events}	manage-events	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
673f052c-b5b1-4754-abfb-96dd28fc1e6a	936c2448-f2d8-41f0-8f92-f95a81341302	t	${role_view-identity-providers}	view-identity-providers	fiware-server	936c2448-f2d8-41f0-8f92-f95a81341302	\N
44c0652d-5323-4863-9d32-1764674cba6a	26c5c4cd-41f8-404a-8389-1c1c98c13b4b	t	${role_read-token}	read-token	fiware-server	26c5c4cd-41f8-404a-8389-1c1c98c13b4b	\N
e7bbe704-0189-4107-b5d6-54c1b355acca	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	t	\N	consumer	fiware-server	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
9c7727c7-6dc0-4cb5-b377-e8d1f8760f6a	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	t	\N	uma_protection	fiware-server	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
a74afe7c-6abb-447f-903b-8708e2f4948a	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	t	A	admin	fiware-server	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
b9eca7a6-abda-4d7b-97db-043e9d5852c6	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_view-consent}	view-consent	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
adc9002b-76c9-413c-9da5-1032d8603c49	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_view-applications}	view-applications	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
57399039-53a6-4070-a4d5-dd04560c67bc	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_manage-account-links}	manage-account-links	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
fd4cb91f-7d85-4a80-b708-2249c0630e6a	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_manage-consent}	manage-consent	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
0cdcba3d-6c1d-43a0-b529-1ac3a358cb44	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_view-groups}	view-groups	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
f78834a4-4c84-4c93-8d9b-7762c9e9364b	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_manage-account}	manage-account	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
2b659c75-09f1-4cb2-885e-e2d2c38adb5c	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_delete-account}	delete-account	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
63f34d2f-0d41-4dfd-9af3-83902621b4ec	631eb608-f712-491c-bce5-b9873d7d72a5	t	${role_view-profile}	view-profile	fiware-server	631eb608-f712-491c-bce5-b9873d7d72a5	\N
cc076330-490b-4eeb-8ae9-cd3517a5a024	b1c34505-93d7-4e13-8128-e0c4280aa73f	t	${role_impersonation}	impersonation	793c40ee-e7c8-4e66-9f1c-f16bc168faba	b1c34505-93d7-4e13-8128-e0c4280aa73f	\N
69cf1a08-41c3-4d41-832b-fc66880f1c50	7c468e16-23ac-4998-97cc-84950d801ad0	t	\N	uma_protection	fiware-server	7c468e16-23ac-4998-97cc-84950d801ad0	\N
9f4981a4-f87b-4f0a-b309-83cdf54b2e18	7c468e16-23ac-4998-97cc-84950d801ad0	t	\N	admin	fiware-server	7c468e16-23ac-4998-97cc-84950d801ad0	\N
faab9b86-379e-48bb-ab52-d4e08c7287d7	7c468e16-23ac-4998-97cc-84950d801ad0	t	\N	consumer	fiware-server	7c468e16-23ac-4998-97cc-84950d801ad0	\N
\.


--
-- Data for Name: migration_model; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.migration_model (id, version, update_time) FROM stdin;
56h0y	20.0.3	1696402490
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
ed205063-226f-4005-8ef9-5ba387cbd3e4	roles	[{"id":"e7bbe704-0189-4107-b5d6-54c1b355acca","required":true}]
0dd01c06-ebe9-4bfc-9131-88960519ff0e	roles	[{"id":"a74afe7c-6abb-447f-903b-8708e2f4948a","required":true}]
541e3170-854b-4e16-9155-e484c3c119ff	code	// by default, grants any permission associated with this policy\n$evaluation.grant();\n
7055553f-c493-46f0-bb01-901f21cc78ed	defaultResourceType	urn:mintaka-pep:resources:default
\.


--
-- Data for Name: protocol_mapper; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper (id, name, protocol, protocol_mapper_name, client_id, client_scope_id) FROM stdin;
2b76be29-4fb6-4626-ba5b-97d6eec8742f	audience resolve	openid-connect	oidc-audience-resolve-mapper	691d5659-72c2-4f78-b5de-4832d3d8caf6	\N
d0d46ee5-d32f-4561-af6d-8aac71887418	locale	openid-connect	oidc-usermodel-attribute-mapper	d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	\N
86bfc748-b04c-4ddc-b9b8-a5c54c9c4f13	role list	saml	saml-role-list-mapper	\N	994a47b2-aac3-45dd-b548-51783d733859
362012d8-c6a6-411b-ae33-6eae28f603a6	full name	openid-connect	oidc-full-name-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
f40e91d8-4d0f-406b-98dc-f4a60004ebcd	family name	openid-connect	oidc-usermodel-property-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
7833042d-57cd-41d5-b87a-dfe954e23208	given name	openid-connect	oidc-usermodel-property-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
aa6f2a1e-4c55-4de9-8ef7-ff626023b300	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
9ef9f963-7a43-4c06-b8da-a1920b4150e6	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
3d1b6e03-75db-4478-a7b8-72b573875f7a	username	openid-connect	oidc-usermodel-property-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
afc0e4cf-d2b5-4ef1-9013-e510c693cf61	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
90737628-1ad8-410b-b43c-203cf1701d1b	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
26203353-e6cb-44f8-aac4-1998a241dfde	website	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
6c31fcf3-ade2-411e-ab9b-e6fdd2790bb9	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
d8b5bc16-e2b0-4a19-9b89-d2bfa0016870	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
93b988ec-c1bc-4f52-a7c6-1e3d950d9372	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
8a78e949-ee49-49c8-bbab-7facf8d22926	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
23ab9a0e-5c9f-4781-8122-147e062a8b0f	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	e2fd5216-6409-4e1f-9dbf-0bbdd7e62680
df019141-32de-4fd3-831a-e26dbd3be24b	email	openid-connect	oidc-usermodel-property-mapper	\N	f0182005-5e27-48cc-b5fe-add7123e9ccb
a4ca9f80-1bb2-4ecc-bd95-4b3a55395602	email verified	openid-connect	oidc-usermodel-property-mapper	\N	f0182005-5e27-48cc-b5fe-add7123e9ccb
27279f06-14df-44a2-88ef-c5cf7c33a820	address	openid-connect	oidc-address-mapper	\N	71aa89b3-bbe0-44f0-bfd3-a0aaf3571c7b
d9124922-bca6-4b93-b3ad-75b0000617e2	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	4767f6ce-ba60-4040-bad0-9112fcac3d96
546884f3-5968-468c-9fe5-7527e6568f1b	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	4767f6ce-ba60-4040-bad0-9112fcac3d96
545f9d80-a106-411a-b5d0-a2de57156eef	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	00588fda-f105-4024-8ac3-3449cba23aae
a4a428c0-df12-4273-97b4-71338d08dfd1	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	00588fda-f105-4024-8ac3-3449cba23aae
e8d0510d-393a-4c19-9e96-69c5e74e324f	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	00588fda-f105-4024-8ac3-3449cba23aae
bdf2baa1-52e7-4712-8892-394a74c114a1	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	2d7e87ee-3a83-44a1-ac5b-cf7312611427
a808bcbd-0058-4e7a-aeaf-b08f9e1eee94	upn	openid-connect	oidc-usermodel-property-mapper	\N	74194b40-0439-449b-87c0-4c6f55919642
7bb491e4-d27d-4642-85cb-5fdea3d602c2	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	74194b40-0439-449b-87c0-4c6f55919642
eaa816e2-cdb8-48ce-85c2-c876ee72dbec	acr loa level	openid-connect	oidc-acr-mapper	\N	673f0ad8-8195-4ca4-9366-06eb6107edf5
5d989821-9d7a-4371-90b1-dbba055bf894	phone number	openid-connect	oidc-usermodel-attribute-mapper	\N	f1164b55-b30c-4baa-a08f-093bd09ddd62
ca7f9be1-32c5-4cd4-b97d-910efce55342	phone number verified	openid-connect	oidc-usermodel-attribute-mapper	\N	f1164b55-b30c-4baa-a08f-093bd09ddd62
9b2c0644-318b-4762-9b6b-7c4c385c3dd2	allowed web origins	openid-connect	oidc-allowed-origins-mapper	\N	3077f964-343d-4ab4-ad61-98ed2088b520
c2dddfe1-553b-453d-9074-cd14eb082aea	fiware-scope-object	openid-connect	oidc-script-based-protocol-mapper	\N	e629ea16-e59c-4ae7-8130-0a05a16a4d51
5e0897df-50aa-430d-8a4c-d66d3dd020b5	role list	saml	saml-role-list-mapper	\N	96b86330-6560-448e-b80f-f6a9c34a8349
5c07b360-9f65-4bba-a2d6-53d964aa9237	upn	openid-connect	oidc-usermodel-property-mapper	\N	8d32b4b2-f351-4182-98fa-d25b657a981f
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	groups	openid-connect	oidc-usermodel-realm-role-mapper	\N	8d32b4b2-f351-4182-98fa-d25b657a981f
b14da3b4-545d-46b5-9354-2fea567a4ff5	profile	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
4d9f597c-e035-43ed-8e50-b6bcc18c4611	locale	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
fb047df9-b656-4f88-9dc2-b7933c362382	username	openid-connect	oidc-usermodel-property-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
83239617-dfc1-43c1-876a-3a1e9a1b1997	family name	openid-connect	oidc-usermodel-property-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
765b0c31-74f2-468c-846e-6b48f7dc57d2	given name	openid-connect	oidc-usermodel-property-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
cede6042-6129-4a19-94a4-8b7361fa736c	gender	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
8998aeb1-687e-4520-b54e-32d2320ae93e	zoneinfo	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
83704427-38ae-47a1-9ded-0f924a566ebe	nickname	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
7c8177f8-9c35-4b02-acf7-b7e5f55f2df4	birthdate	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
4a975c24-2428-4fa6-b023-f3fd11473ac2	middle name	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
aeab9b12-1404-4d11-a83b-5806799b3e5d	full name	openid-connect	oidc-full-name-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
09febc89-ad61-4ff4-bab8-ea20fc3eeb7c	updated at	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
dd96fe0f-a430-48f8-9b07-ec3891986d1f	picture	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
7310f6b0-0852-4eb4-91c4-38693881f77b	website	openid-connect	oidc-usermodel-attribute-mapper	\N	ffcdff24-fb2c-4744-b9e2-f249166d2a58
d65b07eb-aec6-4ffe-93bc-8d42e693a729	address	openid-connect	oidc-address-mapper	\N	2370700b-64c3-4047-9ce8-6fbfde4fd04d
3d072ce1-22b5-4580-947c-96f48d6c98e3	email verified	openid-connect	oidc-usermodel-property-mapper	\N	68255313-fc10-4e6c-a316-cd6f1cbd608e
1992972d-976b-4227-8c0e-35723cd6d2ae	email	openid-connect	oidc-usermodel-property-mapper	\N	68255313-fc10-4e6c-a316-cd6f1cbd608e
5e8d7c94-586c-4fb2-b54a-be3c9ab4d286	realm roles	openid-connect	oidc-usermodel-realm-role-mapper	\N	7fd06f00-0061-4d12-86fa-41b9a2f5122c
ce29d976-51e2-4e46-a04a-5ccc08fa9504	audience resolve	openid-connect	oidc-audience-resolve-mapper	\N	7fd06f00-0061-4d12-86fa-41b9a2f5122c
0dc2c306-49d4-4faa-8896-8bec617f87a7	client roles	openid-connect	oidc-usermodel-client-role-mapper	\N	7fd06f00-0061-4d12-86fa-41b9a2f5122c
d997b187-a813-49a7-ab5e-bad6a664164c	audience resolve	openid-connect	oidc-audience-resolve-mapper	24225287-61ca-4a67-bb1f-1dfc9482d265	\N
eedd63e7-6a85-468f-a772-dd7e9896203f	locale	openid-connect	oidc-usermodel-attribute-mapper	c85b4883-afd1-459d-9d8f-88e735e3f184	\N
6550d165-27b5-4a56-b353-d59b56792095	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
d5a5437f-aea1-4894-8bf0-fadd9e27db20	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
34ebfa86-f66a-4aac-8578-a4ca1c751029	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
869d4cf9-23a9-4f03-b5f4-046fa595ef4d	Client Host	openid-connect	oidc-usersessionmodel-note-mapper	7c468e16-23ac-4998-97cc-84950d801ad0	\N
a44672dd-bc3a-44eb-a578-98cbe497344a	Client ID	openid-connect	oidc-usersessionmodel-note-mapper	7c468e16-23ac-4998-97cc-84950d801ad0	\N
137ed2e8-8d45-40a0-bec8-802385664567	Client IP Address	openid-connect	oidc-usersessionmodel-note-mapper	7c468e16-23ac-4998-97cc-84950d801ad0	\N
\.


--
-- Data for Name: protocol_mapper_config; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.protocol_mapper_config (protocol_mapper_id, value, name) FROM stdin;
d0d46ee5-d32f-4561-af6d-8aac71887418	true	userinfo.token.claim
d0d46ee5-d32f-4561-af6d-8aac71887418	locale	user.attribute
d0d46ee5-d32f-4561-af6d-8aac71887418	true	id.token.claim
d0d46ee5-d32f-4561-af6d-8aac71887418	true	access.token.claim
d0d46ee5-d32f-4561-af6d-8aac71887418	locale	claim.name
d0d46ee5-d32f-4561-af6d-8aac71887418	String	jsonType.label
86bfc748-b04c-4ddc-b9b8-a5c54c9c4f13	false	single
86bfc748-b04c-4ddc-b9b8-a5c54c9c4f13	Basic	attribute.nameformat
86bfc748-b04c-4ddc-b9b8-a5c54c9c4f13	Role	attribute.name
23ab9a0e-5c9f-4781-8122-147e062a8b0f	true	userinfo.token.claim
23ab9a0e-5c9f-4781-8122-147e062a8b0f	updatedAt	user.attribute
23ab9a0e-5c9f-4781-8122-147e062a8b0f	true	id.token.claim
23ab9a0e-5c9f-4781-8122-147e062a8b0f	true	access.token.claim
23ab9a0e-5c9f-4781-8122-147e062a8b0f	updated_at	claim.name
23ab9a0e-5c9f-4781-8122-147e062a8b0f	long	jsonType.label
26203353-e6cb-44f8-aac4-1998a241dfde	true	userinfo.token.claim
26203353-e6cb-44f8-aac4-1998a241dfde	website	user.attribute
26203353-e6cb-44f8-aac4-1998a241dfde	true	id.token.claim
26203353-e6cb-44f8-aac4-1998a241dfde	true	access.token.claim
26203353-e6cb-44f8-aac4-1998a241dfde	website	claim.name
26203353-e6cb-44f8-aac4-1998a241dfde	String	jsonType.label
362012d8-c6a6-411b-ae33-6eae28f603a6	true	userinfo.token.claim
362012d8-c6a6-411b-ae33-6eae28f603a6	true	id.token.claim
362012d8-c6a6-411b-ae33-6eae28f603a6	true	access.token.claim
3d1b6e03-75db-4478-a7b8-72b573875f7a	true	userinfo.token.claim
3d1b6e03-75db-4478-a7b8-72b573875f7a	username	user.attribute
3d1b6e03-75db-4478-a7b8-72b573875f7a	true	id.token.claim
3d1b6e03-75db-4478-a7b8-72b573875f7a	true	access.token.claim
3d1b6e03-75db-4478-a7b8-72b573875f7a	preferred_username	claim.name
3d1b6e03-75db-4478-a7b8-72b573875f7a	String	jsonType.label
6c31fcf3-ade2-411e-ab9b-e6fdd2790bb9	true	userinfo.token.claim
6c31fcf3-ade2-411e-ab9b-e6fdd2790bb9	gender	user.attribute
6c31fcf3-ade2-411e-ab9b-e6fdd2790bb9	true	id.token.claim
6c31fcf3-ade2-411e-ab9b-e6fdd2790bb9	true	access.token.claim
6c31fcf3-ade2-411e-ab9b-e6fdd2790bb9	gender	claim.name
6c31fcf3-ade2-411e-ab9b-e6fdd2790bb9	String	jsonType.label
7833042d-57cd-41d5-b87a-dfe954e23208	true	userinfo.token.claim
7833042d-57cd-41d5-b87a-dfe954e23208	firstName	user.attribute
7833042d-57cd-41d5-b87a-dfe954e23208	true	id.token.claim
7833042d-57cd-41d5-b87a-dfe954e23208	true	access.token.claim
7833042d-57cd-41d5-b87a-dfe954e23208	given_name	claim.name
7833042d-57cd-41d5-b87a-dfe954e23208	String	jsonType.label
8a78e949-ee49-49c8-bbab-7facf8d22926	true	userinfo.token.claim
8a78e949-ee49-49c8-bbab-7facf8d22926	locale	user.attribute
8a78e949-ee49-49c8-bbab-7facf8d22926	true	id.token.claim
8a78e949-ee49-49c8-bbab-7facf8d22926	true	access.token.claim
8a78e949-ee49-49c8-bbab-7facf8d22926	locale	claim.name
8a78e949-ee49-49c8-bbab-7facf8d22926	String	jsonType.label
90737628-1ad8-410b-b43c-203cf1701d1b	true	userinfo.token.claim
90737628-1ad8-410b-b43c-203cf1701d1b	picture	user.attribute
90737628-1ad8-410b-b43c-203cf1701d1b	true	id.token.claim
90737628-1ad8-410b-b43c-203cf1701d1b	true	access.token.claim
90737628-1ad8-410b-b43c-203cf1701d1b	picture	claim.name
90737628-1ad8-410b-b43c-203cf1701d1b	String	jsonType.label
93b988ec-c1bc-4f52-a7c6-1e3d950d9372	true	userinfo.token.claim
93b988ec-c1bc-4f52-a7c6-1e3d950d9372	zoneinfo	user.attribute
93b988ec-c1bc-4f52-a7c6-1e3d950d9372	true	id.token.claim
93b988ec-c1bc-4f52-a7c6-1e3d950d9372	true	access.token.claim
93b988ec-c1bc-4f52-a7c6-1e3d950d9372	zoneinfo	claim.name
93b988ec-c1bc-4f52-a7c6-1e3d950d9372	String	jsonType.label
9ef9f963-7a43-4c06-b8da-a1920b4150e6	true	userinfo.token.claim
9ef9f963-7a43-4c06-b8da-a1920b4150e6	nickname	user.attribute
9ef9f963-7a43-4c06-b8da-a1920b4150e6	true	id.token.claim
9ef9f963-7a43-4c06-b8da-a1920b4150e6	true	access.token.claim
9ef9f963-7a43-4c06-b8da-a1920b4150e6	nickname	claim.name
9ef9f963-7a43-4c06-b8da-a1920b4150e6	String	jsonType.label
aa6f2a1e-4c55-4de9-8ef7-ff626023b300	true	userinfo.token.claim
aa6f2a1e-4c55-4de9-8ef7-ff626023b300	middleName	user.attribute
aa6f2a1e-4c55-4de9-8ef7-ff626023b300	true	id.token.claim
aa6f2a1e-4c55-4de9-8ef7-ff626023b300	true	access.token.claim
aa6f2a1e-4c55-4de9-8ef7-ff626023b300	middle_name	claim.name
aa6f2a1e-4c55-4de9-8ef7-ff626023b300	String	jsonType.label
afc0e4cf-d2b5-4ef1-9013-e510c693cf61	true	userinfo.token.claim
afc0e4cf-d2b5-4ef1-9013-e510c693cf61	profile	user.attribute
afc0e4cf-d2b5-4ef1-9013-e510c693cf61	true	id.token.claim
afc0e4cf-d2b5-4ef1-9013-e510c693cf61	true	access.token.claim
afc0e4cf-d2b5-4ef1-9013-e510c693cf61	profile	claim.name
afc0e4cf-d2b5-4ef1-9013-e510c693cf61	String	jsonType.label
d8b5bc16-e2b0-4a19-9b89-d2bfa0016870	true	userinfo.token.claim
d8b5bc16-e2b0-4a19-9b89-d2bfa0016870	birthdate	user.attribute
d8b5bc16-e2b0-4a19-9b89-d2bfa0016870	true	id.token.claim
d8b5bc16-e2b0-4a19-9b89-d2bfa0016870	true	access.token.claim
d8b5bc16-e2b0-4a19-9b89-d2bfa0016870	birthdate	claim.name
d8b5bc16-e2b0-4a19-9b89-d2bfa0016870	String	jsonType.label
f40e91d8-4d0f-406b-98dc-f4a60004ebcd	true	userinfo.token.claim
f40e91d8-4d0f-406b-98dc-f4a60004ebcd	lastName	user.attribute
f40e91d8-4d0f-406b-98dc-f4a60004ebcd	true	id.token.claim
f40e91d8-4d0f-406b-98dc-f4a60004ebcd	true	access.token.claim
f40e91d8-4d0f-406b-98dc-f4a60004ebcd	family_name	claim.name
f40e91d8-4d0f-406b-98dc-f4a60004ebcd	String	jsonType.label
a4ca9f80-1bb2-4ecc-bd95-4b3a55395602	true	userinfo.token.claim
a4ca9f80-1bb2-4ecc-bd95-4b3a55395602	emailVerified	user.attribute
a4ca9f80-1bb2-4ecc-bd95-4b3a55395602	true	id.token.claim
a4ca9f80-1bb2-4ecc-bd95-4b3a55395602	true	access.token.claim
a4ca9f80-1bb2-4ecc-bd95-4b3a55395602	email_verified	claim.name
a4ca9f80-1bb2-4ecc-bd95-4b3a55395602	boolean	jsonType.label
df019141-32de-4fd3-831a-e26dbd3be24b	true	userinfo.token.claim
df019141-32de-4fd3-831a-e26dbd3be24b	email	user.attribute
df019141-32de-4fd3-831a-e26dbd3be24b	true	id.token.claim
df019141-32de-4fd3-831a-e26dbd3be24b	true	access.token.claim
df019141-32de-4fd3-831a-e26dbd3be24b	email	claim.name
df019141-32de-4fd3-831a-e26dbd3be24b	String	jsonType.label
27279f06-14df-44a2-88ef-c5cf7c33a820	formatted	user.attribute.formatted
27279f06-14df-44a2-88ef-c5cf7c33a820	country	user.attribute.country
27279f06-14df-44a2-88ef-c5cf7c33a820	postal_code	user.attribute.postal_code
27279f06-14df-44a2-88ef-c5cf7c33a820	true	userinfo.token.claim
27279f06-14df-44a2-88ef-c5cf7c33a820	street	user.attribute.street
27279f06-14df-44a2-88ef-c5cf7c33a820	true	id.token.claim
27279f06-14df-44a2-88ef-c5cf7c33a820	region	user.attribute.region
27279f06-14df-44a2-88ef-c5cf7c33a820	true	access.token.claim
27279f06-14df-44a2-88ef-c5cf7c33a820	locality	user.attribute.locality
546884f3-5968-468c-9fe5-7527e6568f1b	true	userinfo.token.claim
546884f3-5968-468c-9fe5-7527e6568f1b	phoneNumberVerified	user.attribute
546884f3-5968-468c-9fe5-7527e6568f1b	true	id.token.claim
546884f3-5968-468c-9fe5-7527e6568f1b	true	access.token.claim
546884f3-5968-468c-9fe5-7527e6568f1b	phone_number_verified	claim.name
546884f3-5968-468c-9fe5-7527e6568f1b	boolean	jsonType.label
d9124922-bca6-4b93-b3ad-75b0000617e2	true	userinfo.token.claim
d9124922-bca6-4b93-b3ad-75b0000617e2	phoneNumber	user.attribute
d9124922-bca6-4b93-b3ad-75b0000617e2	true	id.token.claim
d9124922-bca6-4b93-b3ad-75b0000617e2	true	access.token.claim
d9124922-bca6-4b93-b3ad-75b0000617e2	phone_number	claim.name
d9124922-bca6-4b93-b3ad-75b0000617e2	String	jsonType.label
545f9d80-a106-411a-b5d0-a2de57156eef	true	multivalued
545f9d80-a106-411a-b5d0-a2de57156eef	foo	user.attribute
545f9d80-a106-411a-b5d0-a2de57156eef	true	access.token.claim
545f9d80-a106-411a-b5d0-a2de57156eef	realm_access.roles	claim.name
545f9d80-a106-411a-b5d0-a2de57156eef	String	jsonType.label
a4a428c0-df12-4273-97b4-71338d08dfd1	true	multivalued
a4a428c0-df12-4273-97b4-71338d08dfd1	foo	user.attribute
a4a428c0-df12-4273-97b4-71338d08dfd1	true	access.token.claim
a4a428c0-df12-4273-97b4-71338d08dfd1	resource_access.${client_id}.roles	claim.name
a4a428c0-df12-4273-97b4-71338d08dfd1	String	jsonType.label
7bb491e4-d27d-4642-85cb-5fdea3d602c2	true	multivalued
7bb491e4-d27d-4642-85cb-5fdea3d602c2	foo	user.attribute
7bb491e4-d27d-4642-85cb-5fdea3d602c2	true	id.token.claim
7bb491e4-d27d-4642-85cb-5fdea3d602c2	true	access.token.claim
7bb491e4-d27d-4642-85cb-5fdea3d602c2	groups	claim.name
7bb491e4-d27d-4642-85cb-5fdea3d602c2	String	jsonType.label
a808bcbd-0058-4e7a-aeaf-b08f9e1eee94	true	userinfo.token.claim
a808bcbd-0058-4e7a-aeaf-b08f9e1eee94	username	user.attribute
a808bcbd-0058-4e7a-aeaf-b08f9e1eee94	true	id.token.claim
a808bcbd-0058-4e7a-aeaf-b08f9e1eee94	true	access.token.claim
a808bcbd-0058-4e7a-aeaf-b08f9e1eee94	upn	claim.name
a808bcbd-0058-4e7a-aeaf-b08f9e1eee94	String	jsonType.label
eaa816e2-cdb8-48ce-85c2-c876ee72dbec	true	id.token.claim
eaa816e2-cdb8-48ce-85c2-c876ee72dbec	true	access.token.claim
5d989821-9d7a-4371-90b1-dbba055bf894	true	userinfo.token.claim
5d989821-9d7a-4371-90b1-dbba055bf894	phoneNumber	user.attribute
5d989821-9d7a-4371-90b1-dbba055bf894	true	id.token.claim
5d989821-9d7a-4371-90b1-dbba055bf894	true	access.token.claim
5d989821-9d7a-4371-90b1-dbba055bf894	phone_number	claim.name
5d989821-9d7a-4371-90b1-dbba055bf894	String	jsonType.label
ca7f9be1-32c5-4cd4-b97d-910efce55342	true	userinfo.token.claim
ca7f9be1-32c5-4cd4-b97d-910efce55342	phoneNumberVerified	user.attribute
ca7f9be1-32c5-4cd4-b97d-910efce55342	true	id.token.claim
ca7f9be1-32c5-4cd4-b97d-910efce55342	true	access.token.claim
ca7f9be1-32c5-4cd4-b97d-910efce55342	phone_number_verified	claim.name
ca7f9be1-32c5-4cd4-b97d-910efce55342	boolean	jsonType.label
c2dddfe1-553b-453d-9074-cd14eb082aea	true	multivalued
c2dddfe1-553b-453d-9074-cd14eb082aea	true	userinfo.token.claim
c2dddfe1-553b-453d-9074-cd14eb082aea	true	id.token.claim
c2dddfe1-553b-453d-9074-cd14eb082aea	true	access.token.claim
c2dddfe1-553b-453d-9074-cd14eb082aea	fiware-scope-object	claim.name
c2dddfe1-553b-453d-9074-cd14eb082aea	/**\n * Available variables: \n * user - the current user\n * realm - the current realm\n * token - the current token\n * userSession - the current userSession\n * keycloakSession - the current userSession\n */\n\nvar ArrayList = Java.type("java.util.ArrayList");\nvar fiware_scope = new ArrayList();\n\nvar forEach = Array.prototype.forEach;\n\nvar fiware_service;\nvar fiware_servicepath;\nvar fiware_entry;\nvar roles = '';\n\nvar orion_client = realm.getClientByClientId('orion-pep');\n\nfiware_service = user.getFirstAttribute('fiware-service');\nfiware_servicepath = user.getFirstAttribute('fiware-servicepath');\nif (fiware_service !== null && fiware_servicepath !== null) {\n\n    fiware_entry = {\n        "fiware-service": fiware_service,\n        "fiware-servicepath": fiware_servicepath\n    };\n\n    var roleModels = user.getClientRoleMappings(orion_client);\n    if (roleModels.size() > 0) {\n        forEach.call(\n            user.getClientRoleMappings(orion_client).toArray(),\n            function (role) {\n                roles = roles + role.getName() + ",";\n            }\n        );\n        roles = roles.substring(0, roles.length - 1);\n        fiware_entry["orion-roles"] = roles;\n        roles = '';\n    }\n\n    fiware_scope.add(JSON.stringify(fiware_entry));\n    fiware_entry = {};\n}\n\nforEach.call(\n    user.getGroups().toArray(),\n    function (group) {\n\n        fiware_service = group.getFirstAttribute('fiware-service');\n        fiware_servicepath = group.getFirstAttribute('fiware-servicepath');\n        if (fiware_service !== null && fiware_servicepath !== null) {\n            fiware_entry = {\n                "fiware-service": fiware_service,\n                "fiware-servicepath": fiware_servicepath\n            };\n\n            var roleModels = group.getClientRoleMappings(orion_client);\n            if (roleModels.size() > 0) {\n                forEach.call(\n                    group.getClientRoleMappings(orion_client).toArray(),\n                    function (role) {\n                        roles = roles + role.getName() + ",";\n                    }\n                );\n                roles = roles.substring(0, roles.length - 1);\n                fiware_entry["orion-roles"] = roles;\n                roles = '';\n            }\n\n            fiware_scope.add(JSON.stringify(fiware_entry));\n            fiware_entry = {};\n        } else if (group.getParentId() !== null) {\n            fiware_service = group.getParent().getFirstAttribute('fiware-service');\n            fiware_servicepath = group.getParent().getFirstAttribute('fiware-servicepath');\n\n            if (fiware_service !== null && fiware_servicepath !== null) {\n                fiware_entry = {\n                    "fiware-service": fiware_service,\n                    "fiware-servicepath": fiware_servicepath\n                };\n                var subroleModels = group.getClientRoleMappings(orion_client);\n                if (subroleModels.size() > 0) {\n                    forEach.call(\n                        group.getClientRoleMappings(orion_client).toArray(),\n                        function (role) {\n                            roles = roles + role.getName() + ",";\n                        }\n                    );\n                    roles = roles.substring(0, roles.length - 1);\n                    fiware_entry["orion-roles"] = roles;\n                    roles = '';\n                }\n\n                fiware_scope.add(JSON.stringify(fiware_entry));\n                fiware_entry = '';\n            }\n        }\n    }\n);\n\nexports = fiware_scope;	script
5e0897df-50aa-430d-8a4c-d66d3dd020b5	false	single
5e0897df-50aa-430d-8a4c-d66d3dd020b5	Basic	attribute.nameformat
5e0897df-50aa-430d-8a4c-d66d3dd020b5	Role	attribute.name
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	true	multivalued
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	true	userinfo.token.claim
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	foo	user.attribute
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	true	id.token.claim
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	true	access.token.claim
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	groups	claim.name
3c8eb313-81eb-46d8-93c4-75574fa4a4c4	String	jsonType.label
5c07b360-9f65-4bba-a2d6-53d964aa9237	true	userinfo.token.claim
5c07b360-9f65-4bba-a2d6-53d964aa9237	username	user.attribute
5c07b360-9f65-4bba-a2d6-53d964aa9237	true	id.token.claim
5c07b360-9f65-4bba-a2d6-53d964aa9237	true	access.token.claim
5c07b360-9f65-4bba-a2d6-53d964aa9237	upn	claim.name
5c07b360-9f65-4bba-a2d6-53d964aa9237	String	jsonType.label
09febc89-ad61-4ff4-bab8-ea20fc3eeb7c	true	userinfo.token.claim
09febc89-ad61-4ff4-bab8-ea20fc3eeb7c	updatedAt	user.attribute
09febc89-ad61-4ff4-bab8-ea20fc3eeb7c	true	id.token.claim
09febc89-ad61-4ff4-bab8-ea20fc3eeb7c	true	access.token.claim
09febc89-ad61-4ff4-bab8-ea20fc3eeb7c	updated_at	claim.name
09febc89-ad61-4ff4-bab8-ea20fc3eeb7c	String	jsonType.label
4a975c24-2428-4fa6-b023-f3fd11473ac2	true	userinfo.token.claim
4a975c24-2428-4fa6-b023-f3fd11473ac2	middleName	user.attribute
4a975c24-2428-4fa6-b023-f3fd11473ac2	true	id.token.claim
4a975c24-2428-4fa6-b023-f3fd11473ac2	true	access.token.claim
4a975c24-2428-4fa6-b023-f3fd11473ac2	middle_name	claim.name
4a975c24-2428-4fa6-b023-f3fd11473ac2	String	jsonType.label
4d9f597c-e035-43ed-8e50-b6bcc18c4611	true	userinfo.token.claim
4d9f597c-e035-43ed-8e50-b6bcc18c4611	locale	user.attribute
4d9f597c-e035-43ed-8e50-b6bcc18c4611	true	id.token.claim
4d9f597c-e035-43ed-8e50-b6bcc18c4611	true	access.token.claim
4d9f597c-e035-43ed-8e50-b6bcc18c4611	locale	claim.name
4d9f597c-e035-43ed-8e50-b6bcc18c4611	String	jsonType.label
7310f6b0-0852-4eb4-91c4-38693881f77b	true	userinfo.token.claim
7310f6b0-0852-4eb4-91c4-38693881f77b	website	user.attribute
7310f6b0-0852-4eb4-91c4-38693881f77b	true	id.token.claim
7310f6b0-0852-4eb4-91c4-38693881f77b	true	access.token.claim
7310f6b0-0852-4eb4-91c4-38693881f77b	website	claim.name
7310f6b0-0852-4eb4-91c4-38693881f77b	String	jsonType.label
765b0c31-74f2-468c-846e-6b48f7dc57d2	true	userinfo.token.claim
765b0c31-74f2-468c-846e-6b48f7dc57d2	firstName	user.attribute
765b0c31-74f2-468c-846e-6b48f7dc57d2	true	id.token.claim
765b0c31-74f2-468c-846e-6b48f7dc57d2	true	access.token.claim
765b0c31-74f2-468c-846e-6b48f7dc57d2	given_name	claim.name
765b0c31-74f2-468c-846e-6b48f7dc57d2	String	jsonType.label
7c8177f8-9c35-4b02-acf7-b7e5f55f2df4	true	userinfo.token.claim
7c8177f8-9c35-4b02-acf7-b7e5f55f2df4	birthdate	user.attribute
7c8177f8-9c35-4b02-acf7-b7e5f55f2df4	true	id.token.claim
7c8177f8-9c35-4b02-acf7-b7e5f55f2df4	true	access.token.claim
7c8177f8-9c35-4b02-acf7-b7e5f55f2df4	birthdate	claim.name
7c8177f8-9c35-4b02-acf7-b7e5f55f2df4	String	jsonType.label
83239617-dfc1-43c1-876a-3a1e9a1b1997	true	userinfo.token.claim
83239617-dfc1-43c1-876a-3a1e9a1b1997	lastName	user.attribute
83239617-dfc1-43c1-876a-3a1e9a1b1997	true	id.token.claim
83239617-dfc1-43c1-876a-3a1e9a1b1997	true	access.token.claim
83239617-dfc1-43c1-876a-3a1e9a1b1997	family_name	claim.name
83239617-dfc1-43c1-876a-3a1e9a1b1997	String	jsonType.label
83704427-38ae-47a1-9ded-0f924a566ebe	true	userinfo.token.claim
83704427-38ae-47a1-9ded-0f924a566ebe	nickname	user.attribute
83704427-38ae-47a1-9ded-0f924a566ebe	true	id.token.claim
83704427-38ae-47a1-9ded-0f924a566ebe	true	access.token.claim
83704427-38ae-47a1-9ded-0f924a566ebe	nickname	claim.name
83704427-38ae-47a1-9ded-0f924a566ebe	String	jsonType.label
8998aeb1-687e-4520-b54e-32d2320ae93e	true	userinfo.token.claim
8998aeb1-687e-4520-b54e-32d2320ae93e	zoneinfo	user.attribute
8998aeb1-687e-4520-b54e-32d2320ae93e	true	id.token.claim
8998aeb1-687e-4520-b54e-32d2320ae93e	true	access.token.claim
8998aeb1-687e-4520-b54e-32d2320ae93e	zoneinfo	claim.name
8998aeb1-687e-4520-b54e-32d2320ae93e	String	jsonType.label
aeab9b12-1404-4d11-a83b-5806799b3e5d	true	id.token.claim
aeab9b12-1404-4d11-a83b-5806799b3e5d	true	access.token.claim
aeab9b12-1404-4d11-a83b-5806799b3e5d	true	userinfo.token.claim
b14da3b4-545d-46b5-9354-2fea567a4ff5	true	userinfo.token.claim
b14da3b4-545d-46b5-9354-2fea567a4ff5	profile	user.attribute
b14da3b4-545d-46b5-9354-2fea567a4ff5	true	id.token.claim
b14da3b4-545d-46b5-9354-2fea567a4ff5	true	access.token.claim
b14da3b4-545d-46b5-9354-2fea567a4ff5	profile	claim.name
b14da3b4-545d-46b5-9354-2fea567a4ff5	String	jsonType.label
cede6042-6129-4a19-94a4-8b7361fa736c	true	userinfo.token.claim
cede6042-6129-4a19-94a4-8b7361fa736c	gender	user.attribute
cede6042-6129-4a19-94a4-8b7361fa736c	true	id.token.claim
cede6042-6129-4a19-94a4-8b7361fa736c	true	access.token.claim
cede6042-6129-4a19-94a4-8b7361fa736c	gender	claim.name
cede6042-6129-4a19-94a4-8b7361fa736c	String	jsonType.label
dd96fe0f-a430-48f8-9b07-ec3891986d1f	true	userinfo.token.claim
dd96fe0f-a430-48f8-9b07-ec3891986d1f	picture	user.attribute
dd96fe0f-a430-48f8-9b07-ec3891986d1f	true	id.token.claim
dd96fe0f-a430-48f8-9b07-ec3891986d1f	true	access.token.claim
dd96fe0f-a430-48f8-9b07-ec3891986d1f	picture	claim.name
dd96fe0f-a430-48f8-9b07-ec3891986d1f	String	jsonType.label
fb047df9-b656-4f88-9dc2-b7933c362382	true	userinfo.token.claim
fb047df9-b656-4f88-9dc2-b7933c362382	username	user.attribute
fb047df9-b656-4f88-9dc2-b7933c362382	true	id.token.claim
fb047df9-b656-4f88-9dc2-b7933c362382	true	access.token.claim
fb047df9-b656-4f88-9dc2-b7933c362382	preferred_username	claim.name
fb047df9-b656-4f88-9dc2-b7933c362382	String	jsonType.label
d65b07eb-aec6-4ffe-93bc-8d42e693a729	formatted	user.attribute.formatted
d65b07eb-aec6-4ffe-93bc-8d42e693a729	country	user.attribute.country
d65b07eb-aec6-4ffe-93bc-8d42e693a729	postal_code	user.attribute.postal_code
d65b07eb-aec6-4ffe-93bc-8d42e693a729	true	userinfo.token.claim
d65b07eb-aec6-4ffe-93bc-8d42e693a729	street	user.attribute.street
d65b07eb-aec6-4ffe-93bc-8d42e693a729	true	id.token.claim
d65b07eb-aec6-4ffe-93bc-8d42e693a729	region	user.attribute.region
d65b07eb-aec6-4ffe-93bc-8d42e693a729	true	access.token.claim
d65b07eb-aec6-4ffe-93bc-8d42e693a729	locality	user.attribute.locality
1992972d-976b-4227-8c0e-35723cd6d2ae	true	userinfo.token.claim
1992972d-976b-4227-8c0e-35723cd6d2ae	email	user.attribute
1992972d-976b-4227-8c0e-35723cd6d2ae	true	id.token.claim
1992972d-976b-4227-8c0e-35723cd6d2ae	true	access.token.claim
1992972d-976b-4227-8c0e-35723cd6d2ae	email	claim.name
1992972d-976b-4227-8c0e-35723cd6d2ae	String	jsonType.label
3d072ce1-22b5-4580-947c-96f48d6c98e3	true	userinfo.token.claim
3d072ce1-22b5-4580-947c-96f48d6c98e3	emailVerified	user.attribute
3d072ce1-22b5-4580-947c-96f48d6c98e3	true	id.token.claim
3d072ce1-22b5-4580-947c-96f48d6c98e3	true	access.token.claim
3d072ce1-22b5-4580-947c-96f48d6c98e3	email_verified	claim.name
3d072ce1-22b5-4580-947c-96f48d6c98e3	boolean	jsonType.label
0dc2c306-49d4-4faa-8896-8bec617f87a7	foo	user.attribute
0dc2c306-49d4-4faa-8896-8bec617f87a7	true	access.token.claim
0dc2c306-49d4-4faa-8896-8bec617f87a7	resource_access.${client_id}.roles	claim.name
0dc2c306-49d4-4faa-8896-8bec617f87a7	String	jsonType.label
0dc2c306-49d4-4faa-8896-8bec617f87a7	true	multivalued
5e8d7c94-586c-4fb2-b54a-be3c9ab4d286	foo	user.attribute
5e8d7c94-586c-4fb2-b54a-be3c9ab4d286	true	access.token.claim
5e8d7c94-586c-4fb2-b54a-be3c9ab4d286	realm_access.roles	claim.name
5e8d7c94-586c-4fb2-b54a-be3c9ab4d286	String	jsonType.label
5e8d7c94-586c-4fb2-b54a-be3c9ab4d286	true	multivalued
34ebfa86-f66a-4aac-8578-a4ca1c751029	clientHost	user.session.note
34ebfa86-f66a-4aac-8578-a4ca1c751029	true	id.token.claim
34ebfa86-f66a-4aac-8578-a4ca1c751029	true	access.token.claim
34ebfa86-f66a-4aac-8578-a4ca1c751029	clientHost	claim.name
34ebfa86-f66a-4aac-8578-a4ca1c751029	String	jsonType.label
6550d165-27b5-4a56-b353-d59b56792095	clientId	user.session.note
6550d165-27b5-4a56-b353-d59b56792095	true	id.token.claim
6550d165-27b5-4a56-b353-d59b56792095	true	access.token.claim
6550d165-27b5-4a56-b353-d59b56792095	clientId	claim.name
6550d165-27b5-4a56-b353-d59b56792095	String	jsonType.label
6550d165-27b5-4a56-b353-d59b56792095	true	userinfo.token.claim
d5a5437f-aea1-4894-8bf0-fadd9e27db20	clientAddress	user.session.note
d5a5437f-aea1-4894-8bf0-fadd9e27db20	true	id.token.claim
d5a5437f-aea1-4894-8bf0-fadd9e27db20	true	access.token.claim
d5a5437f-aea1-4894-8bf0-fadd9e27db20	clientAddress	claim.name
d5a5437f-aea1-4894-8bf0-fadd9e27db20	String	jsonType.label
d5a5437f-aea1-4894-8bf0-fadd9e27db20	true	userinfo.token.claim
34ebfa86-f66a-4aac-8578-a4ca1c751029	true	userinfo.token.claim
eedd63e7-6a85-468f-a772-dd7e9896203f	true	userinfo.token.claim
eedd63e7-6a85-468f-a772-dd7e9896203f	locale	user.attribute
eedd63e7-6a85-468f-a772-dd7e9896203f	true	id.token.claim
eedd63e7-6a85-468f-a772-dd7e9896203f	true	access.token.claim
eedd63e7-6a85-468f-a772-dd7e9896203f	locale	claim.name
eedd63e7-6a85-468f-a772-dd7e9896203f	String	jsonType.label
137ed2e8-8d45-40a0-bec8-802385664567	clientAddress	user.session.note
137ed2e8-8d45-40a0-bec8-802385664567	true	userinfo.token.claim
137ed2e8-8d45-40a0-bec8-802385664567	true	id.token.claim
137ed2e8-8d45-40a0-bec8-802385664567	true	access.token.claim
137ed2e8-8d45-40a0-bec8-802385664567	clientAddress	claim.name
137ed2e8-8d45-40a0-bec8-802385664567	String	jsonType.label
869d4cf9-23a9-4f03-b5f4-046fa595ef4d	clientHost	user.session.note
869d4cf9-23a9-4f03-b5f4-046fa595ef4d	true	userinfo.token.claim
869d4cf9-23a9-4f03-b5f4-046fa595ef4d	true	id.token.claim
869d4cf9-23a9-4f03-b5f4-046fa595ef4d	true	access.token.claim
869d4cf9-23a9-4f03-b5f4-046fa595ef4d	clientHost	claim.name
869d4cf9-23a9-4f03-b5f4-046fa595ef4d	String	jsonType.label
a44672dd-bc3a-44eb-a578-98cbe497344a	clientId	user.session.note
a44672dd-bc3a-44eb-a578-98cbe497344a	true	userinfo.token.claim
a44672dd-bc3a-44eb-a578-98cbe497344a	true	id.token.claim
a44672dd-bc3a-44eb-a578-98cbe497344a	true	access.token.claim
a44672dd-bc3a-44eb-a578-98cbe497344a	clientId	claim.name
a44672dd-bc3a-44eb-a578-98cbe497344a	String	jsonType.label
\.


--
-- Data for Name: realm; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm (id, access_code_lifespan, user_action_lifespan, access_token_lifespan, account_theme, admin_theme, email_theme, enabled, events_enabled, events_expiration, login_theme, name, not_before, password_policy, registration_allowed, remember_me, reset_password_allowed, social, ssl_required, sso_idle_timeout, sso_max_lifespan, update_profile_on_soc_login, verify_email, master_admin_client, login_lifespan, internationalization_enabled, default_locale, reg_email_as_username, admin_events_enabled, admin_events_details_enabled, edit_username_allowed, otp_policy_counter, otp_policy_window, otp_policy_period, otp_policy_digits, otp_policy_alg, otp_policy_type, browser_flow, registration_flow, direct_grant_flow, reset_credentials_flow, client_auth_flow, offline_session_idle_timeout, revoke_refresh_token, access_token_life_implicit, login_with_email_allowed, duplicate_emails_allowed, docker_auth_flow, refresh_token_max_reuse, allow_user_managed_access, sso_max_lifespan_remember_me, sso_idle_timeout_remember_me, default_role) FROM stdin;
793c40ee-e7c8-4e66-9f1c-f16bc168faba	60	300	60	\N	\N	\N	t	f	0	\N	master	0	\N	f	f	f	f	EXTERNAL	1800	36000	f	f	c3978641-c47f-4196-97fa-a9616c3ff17f	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	3cb76c7f-0d5b-4268-a3b6-38fb2ce45824	507aab55-bc22-4902-8f4b-5424967daf86	772c785c-abcc-4dfb-bfc6-cb65b1f084d8	2ed611a9-ff56-48ac-9464-d11ff6978f78	82fd0085-5b4f-45e4-b56e-3051eec4fce7	2592000	f	900	t	f	49ce0bad-2a9d-4094-bd74-bfc6147c2d3e	0	f	0	0	1d012033-0bac-42b2-880f-16e38cd3bf9d
fiware-server	60	300	300	\N	\N	\N	t	f	0	\N	fiware-server	0	\N	f	f	f	f	NONE	1800	36000	f	f	b1c34505-93d7-4e13-8128-e0c4280aa73f	1800	f	\N	f	f	f	f	0	1	30	6	HmacSHA1	totp	a5ad4c62-21f1-443c-98fb-61d3001e0bfa	414f6e7e-b9d5-4692-8447-124e416b3b95	9fb405b1-de0d-4019-9fd1-74b94ebf14a4	23904f41-741a-477c-8646-3f16441ef855	03c27c88-c45f-41ab-bb52-82e610e92af3	2592000	f	900	t	f	2f32c98b-38a7-476b-a097-78137415636d	0	f	0	0	a63452df-a422-42be-bacd-26318bbd7b85
\.


--
-- Data for Name: realm_attribute; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.realm_attribute (name, realm_id, value) FROM stdin;
_browser_header.contentSecurityPolicyReportOnly	793c40ee-e7c8-4e66-9f1c-f16bc168faba	
_browser_header.xContentTypeOptions	793c40ee-e7c8-4e66-9f1c-f16bc168faba	nosniff
_browser_header.xRobotsTag	793c40ee-e7c8-4e66-9f1c-f16bc168faba	none
_browser_header.xFrameOptions	793c40ee-e7c8-4e66-9f1c-f16bc168faba	SAMEORIGIN
_browser_header.contentSecurityPolicy	793c40ee-e7c8-4e66-9f1c-f16bc168faba	frame-src 'self'; frame-ancestors 'self'; object-src 'none';
_browser_header.xXSSProtection	793c40ee-e7c8-4e66-9f1c-f16bc168faba	1; mode=block
_browser_header.strictTransportSecurity	793c40ee-e7c8-4e66-9f1c-f16bc168faba	max-age=31536000; includeSubDomains
bruteForceProtected	793c40ee-e7c8-4e66-9f1c-f16bc168faba	false
permanentLockout	793c40ee-e7c8-4e66-9f1c-f16bc168faba	false
maxFailureWaitSeconds	793c40ee-e7c8-4e66-9f1c-f16bc168faba	900
minimumQuickLoginWaitSeconds	793c40ee-e7c8-4e66-9f1c-f16bc168faba	60
waitIncrementSeconds	793c40ee-e7c8-4e66-9f1c-f16bc168faba	60
quickLoginCheckMilliSeconds	793c40ee-e7c8-4e66-9f1c-f16bc168faba	1000
maxDeltaTimeSeconds	793c40ee-e7c8-4e66-9f1c-f16bc168faba	43200
failureFactor	793c40ee-e7c8-4e66-9f1c-f16bc168faba	30
realmReusableOtpCode	793c40ee-e7c8-4e66-9f1c-f16bc168faba	false
displayName	793c40ee-e7c8-4e66-9f1c-f16bc168faba	Keycloak
displayNameHtml	793c40ee-e7c8-4e66-9f1c-f16bc168faba	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	793c40ee-e7c8-4e66-9f1c-f16bc168faba	RS256
offlineSessionMaxLifespanEnabled	793c40ee-e7c8-4e66-9f1c-f16bc168faba	false
offlineSessionMaxLifespan	793c40ee-e7c8-4e66-9f1c-f16bc168faba	5184000
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
realmReusableOtpCode	fiware-server	false
displayName	fiware-server	Keycloak
displayNameHtml	fiware-server	<div class="kc-logo-text"><span>Keycloak</span></div>
defaultSignatureAlgorithm	fiware-server	RS256
offlineSessionMaxLifespanEnabled	fiware-server	false
offlineSessionMaxLifespan	fiware-server	5184000
clientSessionIdleTimeout	fiware-server	0
clientSessionMaxLifespan	fiware-server	0
clientOfflineSessionIdleTimeout	fiware-server	0
clientOfflineSessionMaxLifespan	fiware-server	0
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
de.adorsys.keycloak.config.import-checksum-default	fiware-server	d7a16203c5c7f6e894396034d95b5ae6d4fb45e064716e8ae910612502e2b726
de.adorsys.keycloak.config.state-default-roles-realm-0	fiware-server	["user"]
de.adorsys.keycloak.config.state-default-resources-client-orion-pep-0	fiware-server	["ngsi-ld","root"]
de.adorsys.keycloak.config.state-default-roles-client-orion-pep-0	fiware-server	["admin","consumer"]
frontendUrl	fiware-server	https://keycloak.fiware.dev
de.adorsys.keycloak.config.state-default-roles-client-fiware-login-0	fiware-server	[]
de.adorsys.keycloak.config.state-default-clients-0	fiware-server	["orion-pep"]
client-policies.profiles	fiware-server	{"profiles":[]}
client-policies.policies	fiware-server	{"policies":[]}
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
793c40ee-e7c8-4e66-9f1c-f16bc168faba	jboss-logging
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
password	password	t	t	793c40ee-e7c8-4e66-9f1c-f16bc168faba
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
8521d5ca-7bbe-4cdc-8c39-35e31a4e9977	/realms/master/account/*
691d5659-72c2-4f78-b5de-4832d3d8caf6	/realms/master/account/*
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	/admin/master/console/*
631eb608-f712-491c-bce5-b9873d7d72a5	/realms/fiware-server/account/*
24225287-61ca-4a67-bb1f-1dfc9482d265	/realms/fiware-server/account/*
c85b4883-afd1-459d-9d8f-88e735e3f184	/admin/fiware-server/console/*
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	http://circuloos-orion
7c468e16-23ac-4998-97cc-84950d801ad0	http://circuloos-mintaka
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
51252257-a424-43bc-b233-16b48bffd00e	VERIFY_EMAIL	Verify Email	793c40ee-e7c8-4e66-9f1c-f16bc168faba	t	f	VERIFY_EMAIL	50
dcaa8f37-eebc-4944-b5bb-a6ace917f9bf	UPDATE_PROFILE	Update Profile	793c40ee-e7c8-4e66-9f1c-f16bc168faba	t	f	UPDATE_PROFILE	40
c06efa5a-48a2-4135-867a-ea4297aca184	CONFIGURE_TOTP	Configure OTP	793c40ee-e7c8-4e66-9f1c-f16bc168faba	t	f	CONFIGURE_TOTP	10
c8fbd190-ee4f-4f9a-82eb-1a37082aa149	UPDATE_PASSWORD	Update Password	793c40ee-e7c8-4e66-9f1c-f16bc168faba	t	f	UPDATE_PASSWORD	30
18fbfa79-0150-495c-8c96-e555499a7cae	terms_and_conditions	Terms and Conditions	793c40ee-e7c8-4e66-9f1c-f16bc168faba	f	f	terms_and_conditions	20
6a2ab0e0-9d8b-432d-89ec-f36cf653cf9d	delete_account	Delete Account	793c40ee-e7c8-4e66-9f1c-f16bc168faba	f	f	delete_account	60
e2a2186f-57c9-4935-9f7c-e006773fc88b	update_user_locale	Update User Locale	793c40ee-e7c8-4e66-9f1c-f16bc168faba	t	f	update_user_locale	1000
e94e95d6-33ff-42c0-89ef-ef03c01d9ed6	webauthn-register	Webauthn Register	793c40ee-e7c8-4e66-9f1c-f16bc168faba	t	f	webauthn-register	70
5d20bf0b-681e-4b41-9082-559da2b1959d	webauthn-register-passwordless	Webauthn Register Passwordless	793c40ee-e7c8-4e66-9f1c-f16bc168faba	t	f	webauthn-register-passwordless	80
452a0add-fdc2-4db4-ba21-9a94e90602a2	CONFIGURE_TOTP	Configure OTP	fiware-server	t	f	CONFIGURE_TOTP	10
87dafc61-7a44-4ceb-a08b-7d3906653fb5	terms_and_conditions	Terms and Conditions	fiware-server	f	f	terms_and_conditions	20
f4ed02a3-8955-4c52-bf21-6c1cac0c9894	UPDATE_PASSWORD	Update Password	fiware-server	t	f	UPDATE_PASSWORD	30
4622df11-94fd-466b-bc9a-55fa3d563018	UPDATE_PROFILE	Update Profile	fiware-server	t	f	UPDATE_PROFILE	40
7e7101b4-6821-412d-b0a7-67048c663c61	VERIFY_EMAIL	Verify Email	fiware-server	t	f	VERIFY_EMAIL	50
6d2cf980-ac4b-4557-8a39-726bde25496c	delete_account	Delete Account	fiware-server	f	f	delete_account	60
a3ad817d-d445-434f-bf0b-8eded780f14f	webauthn-register	Webauthn Register	fiware-server	t	f	webauthn-register	70
7bce1960-0f90-4f24-9c47-310113ebed96	webauthn-register-passwordless	Webauthn Register Passwordless	fiware-server	t	f	webauthn-register-passwordless	80
da44af4f-c5b8-4045-b042-f3c3ff7b2052	update_user_locale	Update User Locale	fiware-server	t	f	update_user_locale	1000
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
49185cee-1bf7-4156-bdb5-0fe56009ac5f	551809e1-118a-4d73-978c-7e927accea71
ef5f84b7-81a1-48bc-9ac5-02df6e32f563	3cb79aaf-05cc-4017-a922-070725cc7262
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
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	t	0	1
7c468e16-23ac-4998-97cc-84950d801ad0	t	0	1
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
ed205063-226f-4005-8ef9-5ba387cbd3e4	consumer-policy		role	1	0	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
551809e1-118a-4d73-978c-7e927accea71	admin-permission	\N	resource	1	0	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
0dd01c06-ebe9-4bfc-9131-88960519ff0e	admin-policy		role	1	0	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
3cb79aaf-05cc-4017-a922-070725cc7262	consumer-permission	\N	resource	1	0	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	\N
541e3170-854b-4e16-9155-e484c3c119ff	Default Policy	A policy that grants access only for users within this realm	js	0	0	7c468e16-23ac-4998-97cc-84950d801ad0	\N
7055553f-c493-46f0-bb01-901f21cc78ed	Default Permission	A permission that applies to the default resource type	resource	1	0	7c468e16-23ac-4998-97cc-84950d801ad0	\N
\.


--
-- Data for Name: resource_server_resource; Type: TABLE DATA; Schema: public; Owner: keycloak
--

COPY public.resource_server_resource (id, name, type, icon_uri, owner, resource_server_id, owner_managed_access, display_name) FROM stdin;
ef5f84b7-81a1-48bc-9ac5-02df6e32f563	ngsi-ld	orion:context-management	\N	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	f	Context management v1 API
49185cee-1bf7-4156-bdb5-0fe56009ac5f	root	orion:context-management	\N	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	f	Context management v1 API
aae500f4-075f-4354-9905-96a2395a3e7c	Default Resource	urn:mintaka-pep:resources:default	\N	7c468e16-23ac-4998-97cc-84950d801ad0	7c468e16-23ac-4998-97cc-84950d801ad0	f	\N
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
49185cee-1bf7-4156-bdb5-0fe56009ac5f	/keycloak/*
ef5f84b7-81a1-48bc-9ac5-02df6e32f563	/keycloak/ngsi-ld/v1/*
aae500f4-075f-4354-9905-96a2395a3e7c	/*
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
691d5659-72c2-4f78-b5de-4832d3d8caf6	b6e51f65-125a-4f3d-b28e-99824bae06f3
691d5659-72c2-4f78-b5de-4832d3d8caf6	d32ad624-e595-4cbd-8c14-bc3d7334edf0
24225287-61ca-4a67-bb1f-1dfc9482d265	0cdcba3d-6c1d-43a0-b529-1ac3a358cb44
24225287-61ca-4a67-bb1f-1dfc9482d265	f78834a4-4c84-4c93-8d9b-7762c9e9364b
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
89ff425e-7daf-4d02-bd10-ece87ed8c06e	\N	81949fae-444e-42f8-b9a4-15596d205f36	f	t	\N	\N	\N	793c40ee-e7c8-4e66-9f1c-f16bc168faba	admin	1696404798412	\N	0
1e9880b1-936e-491e-87f4-ba3520fd9e3f	\N	cceb75a1-3d6d-47df-a979-3fa61e9df156	f	t	\N	\N	\N	fiware-server	service-account-orion-pep	1696336951311	d2a02ef8-49fc-4901-98c1-8a17ec0fc192	0
7a45ce29-fd6d-4b3d-8860-0dc999e58b3a	\N	e8d875f7-66ef-4b2d-8ceb-e53c0df7c2c5	f	t	\N			fiware-server	admin-user	1696404887742	\N	0
b76c8d55-c46c-4e5c-bc12-b20cf6151f3a	\N	898d2360-6ed9-4397-9c07-f15f666a90b6	f	t	\N	\N	\N	fiware-server	service-account-mintaka-pep	1696418677565	7c468e16-23ac-4998-97cc-84950d801ad0	0
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
a757ca8d-3fed-4542-8e93-f86f5b2494bf	7a45ce29-fd6d-4b3d-8860-0dc999e58b3a
232d063e-a260-410b-ba99-c90381800b37	7a45ce29-fd6d-4b3d-8860-0dc999e58b3a
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
1d012033-0bac-42b2-880f-16e38cd3bf9d	89ff425e-7daf-4d02-bd10-ece87ed8c06e
3f92ce8b-266c-447c-820d-7c4531b8765b	89ff425e-7daf-4d02-bd10-ece87ed8c06e
a63452df-a422-42be-bacd-26318bbd7b85	1e9880b1-936e-491e-87f4-ba3520fd9e3f
9c7727c7-6dc0-4cb5-b377-e8d1f8760f6a	1e9880b1-936e-491e-87f4-ba3520fd9e3f
cc1be155-5151-4c89-b010-14152a8e5a38	89ff425e-7daf-4d02-bd10-ece87ed8c06e
9065647d-ee18-43b1-a39b-c7d09de8b935	89ff425e-7daf-4d02-bd10-ece87ed8c06e
0c4f6146-d816-4739-b62e-4fd75ddff9b3	89ff425e-7daf-4d02-bd10-ece87ed8c06e
deaf6b58-86f9-47f3-93c7-f5858a7e21f5	89ff425e-7daf-4d02-bd10-ece87ed8c06e
b82ea2c8-3710-4042-824f-d59aa0420472	89ff425e-7daf-4d02-bd10-ece87ed8c06e
4f133514-2fa4-4f7d-bb5d-dfc72fd82070	89ff425e-7daf-4d02-bd10-ece87ed8c06e
b7d00df1-5d9a-42e6-aa75-d4382deeb3d0	89ff425e-7daf-4d02-bd10-ece87ed8c06e
7b87237f-6c26-4bc1-8167-da50409dffb7	89ff425e-7daf-4d02-bd10-ece87ed8c06e
a4681698-82b7-4679-98d7-b58f87681c44	89ff425e-7daf-4d02-bd10-ece87ed8c06e
f787f9a9-8451-47b6-9306-9ab7d0c9750d	89ff425e-7daf-4d02-bd10-ece87ed8c06e
b8821c73-f61e-4042-b222-83e59db77c10	89ff425e-7daf-4d02-bd10-ece87ed8c06e
0dac1e0b-51b2-435e-a9ce-98e7b473780c	89ff425e-7daf-4d02-bd10-ece87ed8c06e
4d30fa9b-8ecb-4f88-82a5-decb932c65e7	89ff425e-7daf-4d02-bd10-ece87ed8c06e
dcd3e975-6c6b-4461-8ef2-c5b8cdd05f6a	89ff425e-7daf-4d02-bd10-ece87ed8c06e
b2b26750-c206-42c9-9a3e-5afcfc1d347a	89ff425e-7daf-4d02-bd10-ece87ed8c06e
5ea5e470-aecb-4a44-a155-b2c9ea9cc3bd	89ff425e-7daf-4d02-bd10-ece87ed8c06e
eb5ce614-d3c0-4e93-bf92-3d406114d0be	89ff425e-7daf-4d02-bd10-ece87ed8c06e
a63452df-a422-42be-bacd-26318bbd7b85	7a45ce29-fd6d-4b3d-8860-0dc999e58b3a
a63452df-a422-42be-bacd-26318bbd7b85	b76c8d55-c46c-4e5c-bc12-b20cf6151f3a
69cf1a08-41c3-4d41-832b-fc66880f1c50	b76c8d55-c46c-4e5c-bc12-b20cf6151f3a
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
d6f1e24d-5a73-4f6f-a4ac-a0d411d908a7	+
c85b4883-afd1-459d-9d8f-88e735e3f184	+
d2a02ef8-49fc-4901-98c1-8a17ec0fc192	http://circuloos-orion
7c468e16-23ac-4998-97cc-84950d801ad0	http://circuloos-mintaka
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
-- Name: databasechangeloglock databasechangeloglock_pkey; Type: CONSTRAINT; Schema: public; Owner: keycloak
--

ALTER TABLE ONLY public.databasechangeloglock
    ADD CONSTRAINT databasechangeloglock_pkey PRIMARY KEY (id);


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
-- Name: idx_admin_event_time; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_admin_event_time ON public.admin_event_entity USING btree (realm_id, admin_event_time);


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
-- Name: idx_group_att_by_name_value; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_group_att_by_name_value ON public.group_attribute USING btree (name, ((value)::character varying(250)));


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
-- Name: idx_user_service_account; Type: INDEX; Schema: public; Owner: keycloak
--

CREATE INDEX idx_user_service_account ON public.user_entity USING btree (realm_id, service_account_client_link);


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


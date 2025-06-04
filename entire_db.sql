--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.3

-- Started on 2025-06-04 16:02:22 UTC

-- SET statement_timeout = 0;
-- SET lock_timeout = 0;
-- SET idle_in_transaction_session_timeout = 0;
-- SET client_encoding = 'SQL_ASCII';
-- SET standard_conforming_strings = on;
-- SELECT pg_catalog.set_config('search_path', '', false);
-- SET check_function_bodies = false;
-- SET xmloption = content;
-- SET client_min_messages = warning;
-- SET row_security = off;

--
-- TOC entry 34 (class 2615 OID 16481)
-- Name: auth; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA auth;


ALTER SCHEMA auth OWNER TO postgres;

--
-- TOC entry 23 (class 2615 OID 16388)
-- Name: extensions; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA extensions;


ALTER SCHEMA extensions OWNER TO postgres;

--
-- TOC entry 32 (class 2615 OID 16611)
-- Name: graphql; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA graphql;


ALTER SCHEMA graphql OWNER TO postgres;

--
-- TOC entry 31 (class 2615 OID 16600)
-- Name: graphql_public; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA graphql_public;


ALTER SCHEMA graphql_public OWNER TO postgres;

--
-- TOC entry 12 (class 2615 OID 16386)
-- Name: pgbouncer; Type: SCHEMA; Schema: -; Owner: pgbouncer
--

CREATE SCHEMA pgbouncer;


ALTER SCHEMA pgbouncer OWNER TO pgbouncer;

--
-- TOC entry 59 (class 2615 OID 29441)
-- Name: public; Type: SCHEMA; Schema: -; Owner: postgres
--

-- *not* creating schema, since initdb creates it


ALTER SCHEMA public OWNER TO postgres;

--
-- TOC entry 4387 (class 0 OID 0)
-- Dependencies: 59
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: postgres
--

COMMENT ON SCHEMA public IS '';


--
-- TOC entry 38 (class 2615 OID 16592)
-- Name: realtime; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA realtime;


ALTER SCHEMA realtime OWNER TO postgres;

--
-- TOC entry 33 (class 2615 OID 16529)
-- Name: storage; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA storage;


ALTER SCHEMA storage OWNER TO postgres;

--
-- TOC entry 29 (class 2615 OID 16638)
-- Name: vault; Type: SCHEMA; Schema: -; Owner: postgres
--

CREATE SCHEMA vault;


ALTER SCHEMA vault OWNER TO postgres;

--
-- TOC entry 6 (class 3079 OID 16666)
-- Name: pg_graphql; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_graphql WITH SCHEMA graphql;


--
-- TOC entry 4392 (class 0 OID 0)
-- Dependencies: 6
-- Name: EXTENSION pg_graphql; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_graphql IS 'pg_graphql: GraphQL support';


--
-- TOC entry 4 (class 3079 OID 16389)
-- Name: pg_stat_statements; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pg_stat_statements WITH SCHEMA extensions;


--
-- TOC entry 4393 (class 0 OID 0)
-- Dependencies: 4
-- Name: EXTENSION pg_stat_statements; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pg_stat_statements IS 'track planning and execution statistics of all SQL statements executed';


--
-- TOC entry 2 (class 3079 OID 16434)
-- Name: pgcrypto; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS pgcrypto WITH SCHEMA extensions;


--
-- TOC entry 4394 (class 0 OID 0)
-- Dependencies: 2
-- Name: EXTENSION pgcrypto; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION pgcrypto IS 'cryptographic functions';


--
-- TOC entry 5 (class 3079 OID 16639)
-- Name: supabase_vault; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS supabase_vault WITH SCHEMA vault;


--
-- TOC entry 4395 (class 0 OID 0)
-- Dependencies: 5
-- Name: EXTENSION supabase_vault; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION supabase_vault IS 'Supabase Vault Extension';


--
-- TOC entry 3 (class 3079 OID 16423)
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA extensions;


--
-- TOC entry 4396 (class 0 OID 0)
-- Dependencies: 3
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


--
-- TOC entry 1126 (class 1247 OID 16756)
-- Name: aal_level; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.aal_level AS ENUM (
    'aal1',
    'aal2',
    'aal3'
);


ALTER TYPE auth.aal_level OWNER TO supabase_auth_admin;

--
-- TOC entry 1150 (class 1247 OID 16897)
-- Name: code_challenge_method; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.code_challenge_method AS ENUM (
    's256',
    'plain'
);


ALTER TYPE auth.code_challenge_method OWNER TO supabase_auth_admin;

--
-- TOC entry 1123 (class 1247 OID 16750)
-- Name: factor_status; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_status AS ENUM (
    'unverified',
    'verified'
);


ALTER TYPE auth.factor_status OWNER TO supabase_auth_admin;

--
-- TOC entry 1120 (class 1247 OID 16744)
-- Name: factor_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.factor_type AS ENUM (
    'totp',
    'webauthn',
    'phone'
);


ALTER TYPE auth.factor_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1156 (class 1247 OID 16939)
-- Name: one_time_token_type; Type: TYPE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TYPE auth.one_time_token_type AS ENUM (
    'confirmation_token',
    'reauthentication_token',
    'recovery_token',
    'email_change_token_new',
    'email_change_token_current',
    'phone_change_token'
);


ALTER TYPE auth.one_time_token_type OWNER TO supabase_auth_admin;

--
-- TOC entry 1195 (class 1247 OID 29443)
-- Name: GameCategory; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."GameCategory" AS ENUM (
    'FISH',
    'POKER',
    'SLOTS',
    'TABLE_GAMES',
    'LIVE_CASINO',
    'SPORTSBOOK',
    'VIRTUAL_SPORTS',
    'LOTTERY',
    'CRASH',
    'OTHER'
);


ALTER TYPE public."GameCategory" OWNER TO postgres;

--
-- TOC entry 1198 (class 1247 OID 29464)
-- Name: GameProviderName; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."GameProviderName" AS ENUM (
    'PRAGMATICPLAY',
    'EVOPLAY',
    'NETENT',
    'PLAYNGO',
    'RELAXGAMING',
    'HACKSAW',
    'BGAMING',
    'SPRIBE',
    'INTERNAL',
    'REDTIGER',
    'NETGAME',
    'BIGFISHGAMES',
    'CQNINE',
    'NOLIMIT',
    'KICKASS'
);


ALTER TYPE public."GameProviderName" OWNER TO postgres;

--
-- TOC entry 1216 (class 1247 OID 29558)
-- Name: InvitationStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."InvitationStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'DECLINED',
    'INACTIVE'
);


ALTER TYPE public."InvitationStatus" OWNER TO postgres;

--
-- TOC entry 1204 (class 1247 OID 29508)
-- Name: JackpotType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."JackpotType" AS ENUM (
    'MINOR',
    'MAJOR',
    'GRAND'
);


ALTER TYPE public."JackpotType" OWNER TO postgres;

--
-- TOC entry 1213 (class 1247 OID 29544)
-- Name: KeyMode; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."KeyMode" AS ENUM (
    'read',
    'write',
    'upload',
    'manage_users',
    'manage_settings',
    'launch_game'
);


ALTER TYPE public."KeyMode" OWNER TO postgres;

--
-- TOC entry 1207 (class 1247 OID 29516)
-- Name: PaymentMethod; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."PaymentMethod" AS ENUM (
    'INSTORE_CASH',
    'INSTORE_CARD',
    'CASH_APP'
);


ALTER TYPE public."PaymentMethod" OWNER TO postgres;

--
-- TOC entry 1201 (class 1247 OID 29496)
-- Name: ProviderAuthType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."ProviderAuthType" AS ENUM (
    'API_KEY',
    'OAUTH2',
    'JWT_SIGN',
    'CUSTOM',
    'NONE'
);


ALTER TYPE public."ProviderAuthType" OWNER TO postgres;

--
-- TOC entry 1228 (class 1247 OID 29660)
-- Name: RewardStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."RewardStatus" AS ENUM (
    'AVAILABLE',
    'CLAIMED',
    'EXPIRED',
    'PENDING',
    'VOIDED'
);


ALTER TYPE public."RewardStatus" OWNER TO postgres;

--
-- TOC entry 1210 (class 1247 OID 29524)
-- Name: Role; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."Role" AS ENUM (
    'USER',
    'ADMIN',
    'VIP',
    'MODERATOR',
    'SYSTEM',
    'OWNER',
    'MEMBER',
    'OPERATOR',
    'SUPPORT_AGENT'
);


ALTER TYPE public."Role" OWNER TO postgres;

--
-- TOC entry 1219 (class 1247 OID 29568)
-- Name: TournamentStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TournamentStatus" AS ENUM (
    'PENDING',
    'ACTIVE',
    'COMPLETED',
    'CANCELLED'
);


ALTER TYPE public."TournamentStatus" OWNER TO postgres;

--
-- TOC entry 1225 (class 1247 OID 29638)
-- Name: TransactionStatus; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TransactionStatus" AS ENUM (
    'PENDING',
    'PROCESSING',
    'COMPLETED',
    'FAILED',
    'CANCELLED',
    'REFUNDED',
    'EXPIRED',
    'REJECTED',
    'REQUIRES_ACTION',
    'ON_HOLD'
);


ALTER TYPE public."TransactionStatus" OWNER TO postgres;

--
-- TOC entry 1222 (class 1247 OID 29578)
-- Name: TransactionType; Type: TYPE; Schema: public; Owner: postgres
--

CREATE TYPE public."TransactionType" AS ENUM (
    'DEPOSIT',
    'WITHDRAWAL',
    'BET',
    'WIN',
    'TRANSFER_SENT',
    'TRANSFER_RECEIVED',
    'SYSTEM_ADJUSTMENT_CREDIT',
    'SYSTEM_ADJUSTMENT_DEBIT',
    'TOURNAMENT_BUYIN',
    'TOURNAMENT_PRIZE',
    'AFFILIATE_COMMISSION',
    'REFUND',
    'FEE',
    'BONUS_AWARD',
    'BET_PLACE',
    'BET_WIN',
    'BET_LOSE',
    'BET_REFUND',
    'BONUS_WAGER',
    'BONUS_CONVERT',
    'BONUS_EXPIRED',
    'XP_AWARD',
    'ADJUSTMENT_ADD',
    'ADJUSTMENT_SUB',
    'INTERNAL_TRANSFER',
    'PRODUCT_PURCHASE',
    'REBATE_PAYOUT',
    'JACKPOT_WIN',
    'JACKPOT_CONTRIBUTION'
);


ALTER TYPE public."TransactionType" OWNER TO postgres;

--
-- TOC entry 1180 (class 1247 OID 17107)
-- Name: action; Type: TYPE; Schema: realtime; Owner: postgres
--

CREATE TYPE realtime.action AS ENUM (
    'INSERT',
    'UPDATE',
    'DELETE',
    'TRUNCATE',
    'ERROR'
);


ALTER TYPE realtime.action OWNER TO postgres;

--
-- TOC entry 1171 (class 1247 OID 17066)
-- Name: equality_op; Type: TYPE; Schema: realtime; Owner: postgres
--

CREATE TYPE realtime.equality_op AS ENUM (
    'eq',
    'neq',
    'lt',
    'lte',
    'gt',
    'gte',
    'in'
);


ALTER TYPE realtime.equality_op OWNER TO postgres;

--
-- TOC entry 1174 (class 1247 OID 17081)
-- Name: user_defined_filter; Type: TYPE; Schema: realtime; Owner: postgres
--

CREATE TYPE realtime.user_defined_filter AS (
	column_name text,
	op realtime.equality_op,
	value text
);


ALTER TYPE realtime.user_defined_filter OWNER TO postgres;

--
-- TOC entry 1186 (class 1247 OID 17148)
-- Name: wal_column; Type: TYPE; Schema: realtime; Owner: postgres
--

CREATE TYPE realtime.wal_column AS (
	name text,
	type_name text,
	type_oid oid,
	value jsonb,
	is_pkey boolean,
	is_selectable boolean
);


ALTER TYPE realtime.wal_column OWNER TO postgres;

--
-- TOC entry 1183 (class 1247 OID 17119)
-- Name: wal_rls; Type: TYPE; Schema: realtime; Owner: postgres
--

CREATE TYPE realtime.wal_rls AS (
	wal jsonb,
	is_rls_enabled boolean,
	subscription_ids uuid[],
	errors text[]
);


ALTER TYPE realtime.wal_rls OWNER TO postgres;

--
-- TOC entry 380 (class 1255 OID 16527)
-- Name: email(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.email() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.email', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'email')
  )::text
$$;


ALTER FUNCTION auth.email() OWNER TO supabase_auth_admin;

--
-- TOC entry 4397 (class 0 OID 0)
-- Dependencies: 380
-- Name: FUNCTION email(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.email() IS 'Deprecated. Use auth.jwt() -> ''email'' instead.';


--
-- TOC entry 441 (class 1255 OID 16726)
-- Name: jwt(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.jwt() RETURNS jsonb
    LANGUAGE sql STABLE
    AS $$
  select 
    coalesce(
        nullif(current_setting('request.jwt.claim', true), ''),
        nullif(current_setting('request.jwt.claims', true), '')
    )::jsonb
$$;


ALTER FUNCTION auth.jwt() OWNER TO supabase_auth_admin;

--
-- TOC entry 379 (class 1255 OID 16526)
-- Name: role(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.role() RETURNS text
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.role', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'role')
  )::text
$$;


ALTER FUNCTION auth.role() OWNER TO supabase_auth_admin;

--
-- TOC entry 4400 (class 0 OID 0)
-- Dependencies: 379
-- Name: FUNCTION role(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.role() IS 'Deprecated. Use auth.jwt() -> ''role'' instead.';


--
-- TOC entry 378 (class 1255 OID 16525)
-- Name: uid(); Type: FUNCTION; Schema: auth; Owner: supabase_auth_admin
--

CREATE FUNCTION auth.uid() RETURNS uuid
    LANGUAGE sql STABLE
    AS $$
  select 
  coalesce(
    nullif(current_setting('request.jwt.claim.sub', true), ''),
    (nullif(current_setting('request.jwt.claims', true), '')::jsonb ->> 'sub')
  )::uuid
$$;


ALTER FUNCTION auth.uid() OWNER TO supabase_auth_admin;

--
-- TOC entry 4402 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION uid(); Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON FUNCTION auth.uid() IS 'Deprecated. Use auth.jwt() -> ''sub'' instead.';


--
-- TOC entry 440 (class 1255 OID 16584)
-- Name: grant_pg_cron_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_cron_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_cron'
  )
  THEN
    grant usage on schema cron to postgres with grant option;

    alter default privileges in schema cron grant all on tables to postgres with grant option;
    alter default privileges in schema cron grant all on functions to postgres with grant option;
    alter default privileges in schema cron grant all on sequences to postgres with grant option;

    alter default privileges for user postgres in schema cron grant all
        on sequences to postgres with grant option;
    alter default privileges for user postgres in schema cron grant all
        on tables to postgres with grant option;
    alter default privileges for user postgres in schema cron grant all
        on functions to postgres with grant option;

    grant all privileges on all tables in schema cron to postgres with grant option;
    revoke all on table cron.job from postgres;
    grant select on table cron.job to postgres with grant option;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_cron_access() OWNER TO postgres;

--
-- TOC entry 4418 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION grant_pg_cron_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_cron_access() IS 'Grants access to pg_cron';


--
-- TOC entry 410 (class 1255 OID 16605)
-- Name: grant_pg_graphql_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_graphql_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
DECLARE
    func_is_graphql_resolve bool;
BEGIN
    func_is_graphql_resolve = (
        SELECT n.proname = 'resolve'
        FROM pg_event_trigger_ddl_commands() AS ev
        LEFT JOIN pg_catalog.pg_proc AS n
        ON ev.objid = n.oid
    );

    IF func_is_graphql_resolve
    THEN
        -- Update public wrapper to pass all arguments through to the pg_graphql resolve func
        DROP FUNCTION IF EXISTS graphql_public.graphql;
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language sql
        as $$
            select graphql.resolve(
                query := query,
                variables := coalesce(variables, '{}'),
                "operationName" := "operationName",
                extensions := extensions
            );
        $$;

        -- This hook executes when `graphql.resolve` is created. That is not necessarily the last
        -- function in the extension so we need to grant permissions on existing entities AND
        -- update default permissions to any others that are created after `graphql.resolve`
        grant usage on schema graphql to postgres, anon, authenticated, service_role;
        grant select on all tables in schema graphql to postgres, anon, authenticated, service_role;
        grant execute on all functions in schema graphql to postgres, anon, authenticated, service_role;
        grant all on all sequences in schema graphql to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on tables to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on functions to postgres, anon, authenticated, service_role;
        alter default privileges in schema graphql grant all on sequences to postgres, anon, authenticated, service_role;

        -- Allow postgres role to allow granting usage on graphql and graphql_public schemas to custom roles
        grant usage on schema graphql_public to postgres with grant option;
        grant usage on schema graphql to postgres with grant option;
    END IF;

END;
$_$;


ALTER FUNCTION extensions.grant_pg_graphql_access() OWNER TO postgres;

--
-- TOC entry 4420 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION grant_pg_graphql_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_graphql_access() IS 'Grants access to pg_graphql';


--
-- TOC entry 408 (class 1255 OID 16586)
-- Name: grant_pg_net_access(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.grant_pg_net_access() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
  IF EXISTS (
    SELECT 1
    FROM pg_event_trigger_ddl_commands() AS ev
    JOIN pg_extension AS ext
    ON ev.objid = ext.oid
    WHERE ext.extname = 'pg_net'
  )
  THEN
    IF NOT EXISTS (
      SELECT 1
      FROM pg_roles
      WHERE rolname = 'supabase_functions_admin'
    )
    THEN
      CREATE USER supabase_functions_admin NOINHERIT CREATEROLE LOGIN NOREPLICATION;
    END IF;

    GRANT USAGE ON SCHEMA net TO supabase_functions_admin, postgres, anon, authenticated, service_role;

    IF EXISTS (
      SELECT FROM pg_extension
      WHERE extname = 'pg_net'
      -- all versions in use on existing projects as of 2025-02-20
      -- version 0.12.0 onwards don't need these applied
      AND extversion IN ('0.2', '0.6', '0.7', '0.7.1', '0.8', '0.10.0', '0.11.0')
    ) THEN
      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SECURITY DEFINER;

      ALTER function net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;
      ALTER function net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) SET search_path = net;

      REVOKE ALL ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;
      REVOKE ALL ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) FROM PUBLIC;

      GRANT EXECUTE ON FUNCTION net.http_get(url text, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
      GRANT EXECUTE ON FUNCTION net.http_post(url text, body jsonb, params jsonb, headers jsonb, timeout_milliseconds integer) TO supabase_functions_admin, postgres, anon, authenticated, service_role;
    END IF;
  END IF;
END;
$$;


ALTER FUNCTION extensions.grant_pg_net_access() OWNER TO postgres;

--
-- TOC entry 4422 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION grant_pg_net_access(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.grant_pg_net_access() IS 'Grants access to pg_net';


--
-- TOC entry 409 (class 1255 OID 16596)
-- Name: pgrst_ddl_watch(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.pgrst_ddl_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  cmd record;
BEGIN
  FOR cmd IN SELECT * FROM pg_event_trigger_ddl_commands()
  LOOP
    IF cmd.command_tag IN (
      'CREATE SCHEMA', 'ALTER SCHEMA'
    , 'CREATE TABLE', 'CREATE TABLE AS', 'SELECT INTO', 'ALTER TABLE'
    , 'CREATE FOREIGN TABLE', 'ALTER FOREIGN TABLE'
    , 'CREATE VIEW', 'ALTER VIEW'
    , 'CREATE MATERIALIZED VIEW', 'ALTER MATERIALIZED VIEW'
    , 'CREATE FUNCTION', 'ALTER FUNCTION'
    , 'CREATE TRIGGER'
    , 'CREATE TYPE', 'ALTER TYPE'
    , 'CREATE RULE'
    , 'COMMENT'
    )
    -- don't notify in case of CREATE TEMP table or other objects created on pg_temp
    AND cmd.schema_name is distinct from 'pg_temp'
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_ddl_watch() OWNER TO postgres;

--
-- TOC entry 405 (class 1255 OID 16597)
-- Name: pgrst_drop_watch(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.pgrst_drop_watch() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $$
DECLARE
  obj record;
BEGIN
  FOR obj IN SELECT * FROM pg_event_trigger_dropped_objects()
  LOOP
    IF obj.object_type IN (
      'schema'
    , 'table'
    , 'foreign table'
    , 'view'
    , 'materialized view'
    , 'function'
    , 'trigger'
    , 'type'
    , 'rule'
    )
    AND obj.is_temporary IS false -- no pg_temp objects
    THEN
      NOTIFY pgrst, 'reload schema';
    END IF;
  END LOOP;
END; $$;


ALTER FUNCTION extensions.pgrst_drop_watch() OWNER TO postgres;

--
-- TOC entry 439 (class 1255 OID 16607)
-- Name: set_graphql_placeholder(); Type: FUNCTION; Schema: extensions; Owner: postgres
--

CREATE FUNCTION extensions.set_graphql_placeholder() RETURNS event_trigger
    LANGUAGE plpgsql
    AS $_$
    DECLARE
    graphql_is_dropped bool;
    BEGIN
    graphql_is_dropped = (
        SELECT ev.schema_name = 'graphql_public'
        FROM pg_event_trigger_dropped_objects() AS ev
        WHERE ev.schema_name = 'graphql_public'
    );

    IF graphql_is_dropped
    THEN
        create or replace function graphql_public.graphql(
            "operationName" text default null,
            query text default null,
            variables jsonb default null,
            extensions jsonb default null
        )
            returns jsonb
            language plpgsql
        as $$
            DECLARE
                server_version float;
            BEGIN
                server_version = (SELECT (SPLIT_PART((select version()), ' ', 2))::float);

                IF server_version >= 14 THEN
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql extension is not enabled.'
                            )
                        )
                    );
                ELSE
                    RETURN jsonb_build_object(
                        'errors', jsonb_build_array(
                            jsonb_build_object(
                                'message', 'pg_graphql is only available on projects running Postgres 14 onwards.'
                            )
                        )
                    );
                END IF;
            END;
        $$;
    END IF;

    END;
$_$;


ALTER FUNCTION extensions.set_graphql_placeholder() OWNER TO postgres;

--
-- TOC entry 4451 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION set_graphql_placeholder(); Type: COMMENT; Schema: extensions; Owner: postgres
--

COMMENT ON FUNCTION extensions.set_graphql_placeholder() IS 'Reintroduces placeholder function for graphql_public.graphql';


--
-- TOC entry 355 (class 1255 OID 16387)
-- Name: get_auth(text); Type: FUNCTION; Schema: pgbouncer; Owner: postgres
--

CREATE FUNCTION pgbouncer.get_auth(p_usename text) RETURNS TABLE(username text, password text)
    LANGUAGE plpgsql SECURITY DEFINER
    AS $_$
begin
    raise debug 'PgBouncer auth request: %', p_usename;

    return query
    select 
        rolname::text, 
        case when rolvaliduntil < now() 
            then null 
            else rolpassword::text 
        end 
    from pg_authid 
    where rolname=$1 and rolcanlogin;
end;
$_$;


ALTER FUNCTION pgbouncer.get_auth(p_usename text) OWNER TO postgres;

--
-- TOC entry 403 (class 1255 OID 30546)
-- Name: create_user_wallet_function(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.create_user_wallet_function() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    -- Check if the operation is an INSERT
    IF TG_OP = 'INSERT' THEN
        -- Insert a new wallet record
        INSERT INTO public.wallets (
              id,
            "userId",
            "operatorId",
            "paymentMethod",
            "updatedAt"      
        )
        VALUES (
            public.generate_cuid(),    -- Generate a new CUID-like string for the wallet id
            NEW.id,                    -- The id of the newly created user_profile
            NEW.operator_id,           -- The operator_id from the new user_profile
            'CASH_APP'::public."PaymentMethod", -- Default payment method. Ensure 'CASH_APP' is a valid enum value.
            CURRENT_TIMESTAMP
        );
    END IF;

    -- Return the NEW row to allow the original INSERT operation on user_profiles to complete
    RETURN NEW;
END;
$$;


ALTER FUNCTION public.create_user_wallet_function() OWNER TO postgres;

--
-- TOC entry 4465 (class 0 OID 0)
-- Dependencies: 403
-- Name: FUNCTION create_user_wallet_function(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.create_user_wallet_function() IS 'Creates a new wallet in the public.wallets table using a CUID-like ID when a new user_profile is inserted.';


--
-- TOC entry 402 (class 1255 OID 30545)
-- Name: generate_cuid(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.generate_cuid() RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
    l_timestamp_ms BIGINT;
    l_random_block1 TEXT;
    l_random_block2 TEXT;
    l_chars TEXT := '0123456789abcdefghijklmnopqrstuvwxyz';
    i INT;
BEGIN
    -- Get timestamp in milliseconds since epoch
    l_timestamp_ms := floor(extract(epoch from clock_timestamp()) * 1000);

    -- Generate two random blocks (4 chars each for simplicity)
    l_random_block1 := '';
    FOR i IN 1..4 LOOP
        l_random_block1 := l_random_block1 || substr(l_chars, floor(random() * 36)::INT + 1, 1);
    END LOOP;

    l_random_block2 := '';
    FOR i IN 1..4 LOOP
        l_random_block2 := l_random_block2 || substr(l_chars, floor(random() * 36)::INT + 1, 1);
    END LOOP;

    RETURN 'c' || public.to_base36(l_timestamp_ms) || l_random_block1 || l_random_block2;
END;
$$;


ALTER FUNCTION public.generate_cuid() OWNER TO postgres;

--
-- TOC entry 4466 (class 0 OID 0)
-- Dependencies: 402
-- Name: FUNCTION generate_cuid(); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.generate_cuid() IS 'Generates a CUID-like unique text identifier (prefix ''c'' + base36(timestamp_ms) + random_blocks).';


--
-- TOC entry 368 (class 1255 OID 30194)
-- Name: notify_spec_data_change(); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.notify_spec_data_change() RETURNS trigger
    LANGUAGE plpgsql
    AS $$DECLARE
  changed_fields text[];
  old_json jsonb;
  new_json jsonb;
  primary_key_data jsonb;
  payload jsonb;
BEGIN
  IF TG_OP = 'UPDATE' THEN
    old_json := to_jsonb(OLD);
    new_json := to_jsonb(NEW);
    -- Get changed column names
    SELECT array_agg(key) INTO changed_fields
    FROM jsonb_object_keys(new_json) AS key
    WHERE (old_json->key) IS DISTINCT FROM (new_json->key);
    primary_key_data := jsonb_build_object('_id', NEW.id); -- Ensure '_id' is your actual PK column name
  ELSIF TG_OP = 'DELETE' THEN
    old_json := to_jsonb(OLD);
    new_json := NULL;
    primary_key_data := jsonb_build_object('_id', OLD.id); -- Ensure '_id' is your actual PK column name
  ELSE -- INSERT
    old_json := NULL;
    new_json := to_jsonb(NEW);
    primary_key_data := jsonb_build_object('_id', NEW.id); -- Ensure '_id' is your actual PK column name
  END IF;

  payload := jsonb_build_object(
    'timestamp', now()::text,
    'operation', TG_OP,
    'schema', TG_TABLE_SCHEMA,
    'table', TG_TABLE_NAME,
    'data', CASE WHEN TG_OP = 'DELETE' THEN old_json ELSE new_json END,
    'primaryKeyData', primary_key_data,
    'columnNamesChanged', CASE WHEN TG_OP = 'UPDATE' THEN changed_fields ELSE NULL END
  );

  PERFORM pg_notify('spec_data_change', payload::text);

  RETURN CASE WHEN TG_OP = 'DELETE' THEN OLD ELSE NEW END;
END;$$;


ALTER FUNCTION public.notify_spec_data_change() OWNER TO postgres;

--
-- TOC entry 401 (class 1255 OID 30544)
-- Name: to_base36(bigint); Type: FUNCTION; Schema: public; Owner: postgres
--

CREATE FUNCTION public.to_base36(p_value bigint) RETURNS text
    LANGUAGE plpgsql IMMUTABLE
    AS $$
DECLARE
    l_chars TEXT := '0123456789abcdefghijklmnopqrstuvwxyz';
    l_result TEXT := '';
    l_remainder INT;
    l_current_value BIGINT := p_value;
BEGIN
    IF l_current_value IS NULL THEN
        RETURN NULL; -- Handle as an error or default if needed
    END IF;
    IF l_current_value = 0 THEN
        RETURN '0';
    END IF;
    WHILE l_current_value > 0 LOOP
        l_remainder := l_current_value % 36;
        l_result := substr(l_chars, l_remainder + 1, 1) || l_result;
        l_current_value := floor(l_current_value / 36);
    END LOOP;
    RETURN l_result;
END;
$$;


ALTER FUNCTION public.to_base36(p_value bigint) OWNER TO postgres;

--
-- TOC entry 4467 (class 0 OID 0)
-- Dependencies: 401
-- Name: FUNCTION to_base36(p_value bigint); Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON FUNCTION public.to_base36(p_value bigint) IS 'Converts a BIGINT to its base36 string representation.';


--
-- TOC entry 457 (class 1255 OID 17141)
-- Name: apply_rls(jsonb, integer); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer DEFAULT (1024 * 1024)) RETURNS SETOF realtime.wal_rls
    LANGUAGE plpgsql
    AS $$
declare
-- Regclass of the table e.g. public.notes
entity_ regclass = (quote_ident(wal ->> 'schema') || '.' || quote_ident(wal ->> 'table'))::regclass;

-- I, U, D, T: insert, update ...
action realtime.action = (
    case wal ->> 'action'
        when 'I' then 'INSERT'
        when 'U' then 'UPDATE'
        when 'D' then 'DELETE'
        else 'ERROR'
    end
);

-- Is row level security enabled for the table
is_rls_enabled bool = relrowsecurity from pg_class where oid = entity_;

subscriptions realtime.subscription[] = array_agg(subs)
    from
        realtime.subscription subs
    where
        subs.entity = entity_;

-- Subscription vars
roles regrole[] = array_agg(distinct us.claims_role::text)
    from
        unnest(subscriptions) us;

working_role regrole;
claimed_role regrole;
claims jsonb;

subscription_id uuid;
subscription_has_access bool;
visible_to_subscription_ids uuid[] = '{}';

-- structured info for wal's columns
columns realtime.wal_column[];
-- previous identity values for update/delete
old_columns realtime.wal_column[];

error_record_exceeds_max_size boolean = octet_length(wal::text) > max_record_bytes;

-- Primary jsonb output for record
output jsonb;

begin
perform set_config('role', null, true);

columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'columns') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

old_columns =
    array_agg(
        (
            x->>'name',
            x->>'type',
            x->>'typeoid',
            realtime.cast(
                (x->'value') #>> '{}',
                coalesce(
                    (x->>'typeoid')::regtype, -- null when wal2json version <= 2.4
                    (x->>'type')::regtype
                )
            ),
            (pks ->> 'name') is not null,
            true
        )::realtime.wal_column
    )
    from
        jsonb_array_elements(wal -> 'identity') x
        left join jsonb_array_elements(wal -> 'pk') pks
            on (x ->> 'name') = (pks ->> 'name');

for working_role in select * from unnest(roles) loop

    -- Update `is_selectable` for columns and old_columns
    columns =
        array_agg(
            (
                c.name,
                c.type_name,
                c.type_oid,
                c.value,
                c.is_pkey,
                pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
            )::realtime.wal_column
        )
        from
            unnest(columns) c;

    old_columns =
            array_agg(
                (
                    c.name,
                    c.type_name,
                    c.type_oid,
                    c.value,
                    c.is_pkey,
                    pg_catalog.has_column_privilege(working_role, entity_, c.name, 'SELECT')
                )::realtime.wal_column
            )
            from
                unnest(old_columns) c;

    if action <> 'DELETE' and count(1) = 0 from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            -- subscriptions is already filtered by entity
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 400: Bad Request, no primary key']
        )::realtime.wal_rls;

    -- The claims role does not have SELECT permission to the primary key of entity
    elsif action <> 'DELETE' and sum(c.is_selectable::int) <> count(1) from unnest(columns) c where c.is_pkey then
        return next (
            jsonb_build_object(
                'schema', wal ->> 'schema',
                'table', wal ->> 'table',
                'type', action
            ),
            is_rls_enabled,
            (select array_agg(s.subscription_id) from unnest(subscriptions) as s where claims_role = working_role),
            array['Error 401: Unauthorized']
        )::realtime.wal_rls;

    else
        output = jsonb_build_object(
            'schema', wal ->> 'schema',
            'table', wal ->> 'table',
            'type', action,
            'commit_timestamp', to_char(
                ((wal ->> 'timestamp')::timestamptz at time zone 'utc'),
                'YYYY-MM-DD"T"HH24:MI:SS.MS"Z"'
            ),
            'columns', (
                select
                    jsonb_agg(
                        jsonb_build_object(
                            'name', pa.attname,
                            'type', pt.typname
                        )
                        order by pa.attnum asc
                    )
                from
                    pg_attribute pa
                    join pg_type pt
                        on pa.atttypid = pt.oid
                where
                    attrelid = entity_
                    and attnum > 0
                    and pg_catalog.has_column_privilege(working_role, entity_, pa.attname, 'SELECT')
            )
        )
        -- Add "record" key for insert and update
        || case
            when action in ('INSERT', 'UPDATE') then
                jsonb_build_object(
                    'record',
                    (
                        select
                            jsonb_object_agg(
                                -- if unchanged toast, get column name and value from old record
                                coalesce((c).name, (oc).name),
                                case
                                    when (c).name is null then (oc).value
                                    else (c).value
                                end
                            )
                        from
                            unnest(columns) c
                            full outer join unnest(old_columns) oc
                                on (c).name = (oc).name
                        where
                            coalesce((c).is_selectable, (oc).is_selectable)
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                    )
                )
            else '{}'::jsonb
        end
        -- Add "old_record" key for update and delete
        || case
            when action = 'UPDATE' then
                jsonb_build_object(
                        'old_record',
                        (
                            select jsonb_object_agg((c).name, (c).value)
                            from unnest(old_columns) c
                            where
                                (c).is_selectable
                                and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                        )
                    )
            when action = 'DELETE' then
                jsonb_build_object(
                    'old_record',
                    (
                        select jsonb_object_agg((c).name, (c).value)
                        from unnest(old_columns) c
                        where
                            (c).is_selectable
                            and ( not error_record_exceeds_max_size or (octet_length((c).value::text) <= 64))
                            and ( not is_rls_enabled or (c).is_pkey ) -- if RLS enabled, we can't secure deletes so filter to pkey
                    )
                )
            else '{}'::jsonb
        end;

        -- Create the prepared statement
        if is_rls_enabled and action <> 'DELETE' then
            if (select 1 from pg_prepared_statements where name = 'walrus_rls_stmt' limit 1) > 0 then
                deallocate walrus_rls_stmt;
            end if;
            execute realtime.build_prepared_statement_sql('walrus_rls_stmt', entity_, columns);
        end if;

        visible_to_subscription_ids = '{}';

        for subscription_id, claims in (
                select
                    subs.subscription_id,
                    subs.claims
                from
                    unnest(subscriptions) subs
                where
                    subs.entity = entity_
                    and subs.claims_role = working_role
                    and (
                        realtime.is_visible_through_filters(columns, subs.filters)
                        or (
                          action = 'DELETE'
                          and realtime.is_visible_through_filters(old_columns, subs.filters)
                        )
                    )
        ) loop

            if not is_rls_enabled or action = 'DELETE' then
                visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
            else
                -- Check if RLS allows the role to see the record
                perform
                    -- Trim leading and trailing quotes from working_role because set_config
                    -- doesn't recognize the role as valid if they are included
                    set_config('role', trim(both '"' from working_role::text), true),
                    set_config('request.jwt.claims', claims::text, true);

                execute 'execute walrus_rls_stmt' into subscription_has_access;

                if subscription_has_access then
                    visible_to_subscription_ids = visible_to_subscription_ids || subscription_id;
                end if;
            end if;
        end loop;

        perform set_config('role', null, true);

        return next (
            output,
            is_rls_enabled,
            visible_to_subscription_ids,
            case
                when error_record_exceeds_max_size then array['Error 413: Payload Too Large']
                else '{}'
            end
        )::realtime.wal_rls;

    end if;
end loop;

perform set_config('role', null, true);
end;
$$;


ALTER FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) OWNER TO postgres;

--
-- TOC entry 463 (class 1255 OID 17223)
-- Name: broadcast_changes(text, text, text, text, text, record, record, text); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text DEFAULT 'ROW'::text) RETURNS void
    LANGUAGE plpgsql
    AS $$
DECLARE
    -- Declare a variable to hold the JSONB representation of the row
    row_data jsonb := '{}'::jsonb;
BEGIN
    IF level = 'STATEMENT' THEN
        RAISE EXCEPTION 'function can only be triggered for each row, not for each statement';
    END IF;
    -- Check the operation type and handle accordingly
    IF operation = 'INSERT' OR operation = 'UPDATE' OR operation = 'DELETE' THEN
        row_data := jsonb_build_object('old_record', OLD, 'record', NEW, 'operation', operation, 'table', table_name, 'schema', table_schema);
        PERFORM realtime.send (row_data, event_name, topic_name);
    ELSE
        RAISE EXCEPTION 'Unexpected operation type: %', operation;
    END IF;
EXCEPTION
    WHEN OTHERS THEN
        RAISE EXCEPTION 'Failed to process the row: %', SQLERRM;
END;

$$;


ALTER FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) OWNER TO postgres;

--
-- TOC entry 456 (class 1255 OID 17157)
-- Name: build_prepared_statement_sql(text, regclass, realtime.wal_column[]); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) RETURNS text
    LANGUAGE sql
    AS $$
      /*
      Builds a sql string that, if executed, creates a prepared statement to
      tests retrive a row from *entity* by its primary key columns.
      Example
          select realtime.build_prepared_statement_sql('public.notes', '{"id"}'::text[], '{"bigint"}'::text[])
      */
          select
      'prepare ' || prepared_statement_name || ' as
          select
              exists(
                  select
                      1
                  from
                      ' || entity || '
                  where
                      ' || string_agg(quote_ident(pkc.name) || '=' || quote_nullable(pkc.value #>> '{}') , ' and ') || '
              )'
          from
              unnest(columns) pkc
          where
              pkc.is_pkey
          group by
              entity
      $$;


ALTER FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) OWNER TO postgres;

--
-- TOC entry 453 (class 1255 OID 17103)
-- Name: cast(text, regtype); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime."cast"(val text, type_ regtype) RETURNS jsonb
    LANGUAGE plpgsql IMMUTABLE
    AS $$
    declare
      res jsonb;
    begin
      execute format('select to_jsonb(%L::'|| type_::text || ')', val)  into res;
      return res;
    end
    $$;


ALTER FUNCTION realtime."cast"(val text, type_ regtype) OWNER TO postgres;

--
-- TOC entry 454 (class 1255 OID 17098)
-- Name: check_equality_op(realtime.equality_op, regtype, text, text); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) RETURNS boolean
    LANGUAGE plpgsql IMMUTABLE
    AS $$
      /*
      Casts *val_1* and *val_2* as type *type_* and check the *op* condition for truthiness
      */
      declare
          op_symbol text = (
              case
                  when op = 'eq' then '='
                  when op = 'neq' then '!='
                  when op = 'lt' then '<'
                  when op = 'lte' then '<='
                  when op = 'gt' then '>'
                  when op = 'gte' then '>='
                  when op = 'in' then '= any'
                  else 'UNKNOWN OP'
              end
          );
          res boolean;
      begin
          execute format(
              'select %L::'|| type_::text || ' ' || op_symbol
              || ' ( %L::'
              || (
                  case
                      when op = 'in' then type_::text || '[]'
                      else type_::text end
              )
              || ')', val_1, val_2) into res;
          return res;
      end;
      $$;


ALTER FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) OWNER TO postgres;

--
-- TOC entry 459 (class 1255 OID 17149)
-- Name: is_visible_through_filters(realtime.wal_column[], realtime.user_defined_filter[]); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) RETURNS boolean
    LANGUAGE sql IMMUTABLE
    AS $_$
    /*
    Should the record be visible (true) or filtered out (false) after *filters* are applied
    */
        select
            -- Default to allowed when no filters present
            $2 is null -- no filters. this should not happen because subscriptions has a default
            or array_length($2, 1) is null -- array length of an empty array is null
            or bool_and(
                coalesce(
                    realtime.check_equality_op(
                        op:=f.op,
                        type_:=coalesce(
                            col.type_oid::regtype, -- null when wal2json version <= 2.4
                            col.type_name::regtype
                        ),
                        -- cast jsonb to text
                        val_1:=col.value #>> '{}',
                        val_2:=f.value
                    ),
                    false -- if null, filter does not match
                )
            )
        from
            unnest(filters) f
            join unnest(columns) col
                on f.column_name = col.name;
    $_$;


ALTER FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) OWNER TO postgres;

--
-- TOC entry 460 (class 1255 OID 17164)
-- Name: list_changes(name, name, integer, integer); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) RETURNS SETOF realtime.wal_rls
    LANGUAGE sql
    SET log_min_messages TO 'fatal'
    AS $$
      with pub as (
        select
          concat_ws(
            ',',
            case when bool_or(pubinsert) then 'insert' else null end,
            case when bool_or(pubupdate) then 'update' else null end,
            case when bool_or(pubdelete) then 'delete' else null end
          ) as w2j_actions,
          coalesce(
            string_agg(
              realtime.quote_wal2json(format('%I.%I', schemaname, tablename)::regclass),
              ','
            ) filter (where ppt.tablename is not null and ppt.tablename not like '% %'),
            ''
          ) w2j_add_tables
        from
          pg_publication pp
          left join pg_publication_tables ppt
            on pp.pubname = ppt.pubname
        where
          pp.pubname = publication
        group by
          pp.pubname
        limit 1
      ),
      w2j as (
        select
          x.*, pub.w2j_add_tables
        from
          pub,
          pg_logical_slot_get_changes(
            slot_name, null, max_changes,
            'include-pk', 'true',
            'include-transaction', 'false',
            'include-timestamp', 'true',
            'include-type-oids', 'true',
            'format-version', '2',
            'actions', pub.w2j_actions,
            'add-tables', pub.w2j_add_tables
          ) x
      )
      select
        xyz.wal,
        xyz.is_rls_enabled,
        xyz.subscription_ids,
        xyz.errors
      from
        w2j,
        realtime.apply_rls(
          wal := w2j.data::jsonb,
          max_record_bytes := max_record_bytes
        ) xyz(wal, is_rls_enabled, subscription_ids, errors)
      where
        w2j.w2j_add_tables <> ''
        and xyz.subscription_ids[1] is not null
    $$;


ALTER FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) OWNER TO postgres;

--
-- TOC entry 452 (class 1255 OID 17097)
-- Name: quote_wal2json(regclass); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.quote_wal2json(entity regclass) RETURNS text
    LANGUAGE sql IMMUTABLE STRICT
    AS $$
      select
        (
          select string_agg('' || ch,'')
          from unnest(string_to_array(nsp.nspname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
        )
        || '.'
        || (
          select string_agg('' || ch,'')
          from unnest(string_to_array(pc.relname::text, null)) with ordinality x(ch, idx)
          where
            not (x.idx = 1 and x.ch = '"')
            and not (
              x.idx = array_length(string_to_array(nsp.nspname::text, null), 1)
              and x.ch = '"'
            )
          )
      from
        pg_class pc
        join pg_namespace nsp
          on pc.relnamespace = nsp.oid
      where
        pc.oid = entity
    $$;


ALTER FUNCTION realtime.quote_wal2json(entity regclass) OWNER TO postgres;

--
-- TOC entry 462 (class 1255 OID 17222)
-- Name: send(jsonb, text, text, boolean); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean DEFAULT true) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  BEGIN
    -- Set the topic configuration
    EXECUTE format('SET LOCAL realtime.topic TO %L', topic);

    -- Attempt to insert the message
    INSERT INTO realtime.messages (payload, event, topic, private, extension)
    VALUES (payload, event, topic, private, 'broadcast');
  EXCEPTION
    WHEN OTHERS THEN
      -- Capture and notify the error
      PERFORM pg_notify(
          'realtime:system',
          jsonb_build_object(
              'error', SQLERRM,
              'function', 'realtime.send',
              'event', event,
              'topic', topic,
              'private', private
          )::text
      );
  END;
END;
$$;


ALTER FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) OWNER TO postgres;

--
-- TOC entry 458 (class 1255 OID 17095)
-- Name: subscription_check_filters(); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.subscription_check_filters() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
    /*
    Validates that the user defined filters for a subscription:
    - refer to valid columns that the claimed role may access
    - values are coercable to the correct column type
    */
    declare
        col_names text[] = coalesce(
                array_agg(c.column_name order by c.ordinal_position),
                '{}'::text[]
            )
            from
                information_schema.columns c
            where
                format('%I.%I', c.table_schema, c.table_name)::regclass = new.entity
                and pg_catalog.has_column_privilege(
                    (new.claims ->> 'role'),
                    format('%I.%I', c.table_schema, c.table_name)::regclass,
                    c.column_name,
                    'SELECT'
                );
        filter realtime.user_defined_filter;
        col_type regtype;

        in_val jsonb;
    begin
        for filter in select * from unnest(new.filters) loop
            -- Filtered column is valid
            if not filter.column_name = any(col_names) then
                raise exception 'invalid column for filter %', filter.column_name;
            end if;

            -- Type is sanitized and safe for string interpolation
            col_type = (
                select atttypid::regtype
                from pg_catalog.pg_attribute
                where attrelid = new.entity
                      and attname = filter.column_name
            );
            if col_type is null then
                raise exception 'failed to lookup type for column %', filter.column_name;
            end if;

            -- Set maximum number of entries for in filter
            if filter.op = 'in'::realtime.equality_op then
                in_val = realtime.cast(filter.value, (col_type::text || '[]')::regtype);
                if coalesce(jsonb_array_length(in_val), 0) > 100 then
                    raise exception 'too many values for `in` filter. Maximum 100';
                end if;
            else
                -- raises an exception if value is not coercable to type
                perform realtime.cast(filter.value, col_type);
            end if;

        end loop;

        -- Apply consistent order to filters so the unique constraint on
        -- (subscription_id, entity, filters) can't be tricked by a different filter order
        new.filters = coalesce(
            array_agg(f order by f.column_name, f.op, f.value),
            '{}'
        ) from unnest(new.filters) f;

        return new;
    end;
    $$;


ALTER FUNCTION realtime.subscription_check_filters() OWNER TO postgres;

--
-- TOC entry 455 (class 1255 OID 17130)
-- Name: to_regrole(text); Type: FUNCTION; Schema: realtime; Owner: postgres
--

CREATE FUNCTION realtime.to_regrole(role_name text) RETURNS regrole
    LANGUAGE sql IMMUTABLE
    AS $$ select role_name::regrole $$;


ALTER FUNCTION realtime.to_regrole(role_name text) OWNER TO postgres;

--
-- TOC entry 461 (class 1255 OID 17216)
-- Name: topic(); Type: FUNCTION; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE FUNCTION realtime.topic() RETURNS text
    LANGUAGE sql STABLE
    AS $$
select nullif(current_setting('realtime.topic', true), '')::text;
$$;


ALTER FUNCTION realtime.topic() OWNER TO supabase_realtime_admin;

--
-- TOC entry 448 (class 1255 OID 17004)
-- Name: can_insert_object(text, text, uuid, jsonb); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) RETURNS void
    LANGUAGE plpgsql
    AS $$
BEGIN
  INSERT INTO "storage"."objects" ("bucket_id", "name", "owner", "metadata") VALUES (bucketid, name, owner, metadata);
  -- hack to rollback the successful insert
  RAISE sqlstate 'PT200' using
  message = 'ROLLBACK',
  detail = 'rollback successful insert';
END
$$;


ALTER FUNCTION storage.can_insert_object(bucketid text, name text, owner uuid, metadata jsonb) OWNER TO supabase_storage_admin;

--
-- TOC entry 444 (class 1255 OID 16978)
-- Name: extension(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.extension(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
_filename text;
BEGIN
	select string_to_array(name, '/') into _parts;
	select _parts[array_length(_parts,1)] into _filename;
	-- @todo return the last part instead of 2
	return reverse(split_part(reverse(_filename), '.', 1));
END
$$;


ALTER FUNCTION storage.extension(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 443 (class 1255 OID 16977)
-- Name: filename(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.filename(name text) RETURNS text
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[array_length(_parts,1)];
END
$$;


ALTER FUNCTION storage.filename(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 442 (class 1255 OID 16976)
-- Name: foldername(text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.foldername(name text) RETURNS text[]
    LANGUAGE plpgsql
    AS $$
DECLARE
_parts text[];
BEGIN
	select string_to_array(name, '/') into _parts;
	return _parts[1:array_length(_parts,1)-1];
END
$$;


ALTER FUNCTION storage.foldername(name text) OWNER TO supabase_storage_admin;

--
-- TOC entry 446 (class 1255 OID 16990)
-- Name: get_size_by_bucket(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.get_size_by_bucket() RETURNS TABLE(size bigint, bucket_id text)
    LANGUAGE plpgsql
    AS $$
BEGIN
    return query
        select sum((metadata->>'size')::int) as size, obj.bucket_id
        from "storage".objects as obj
        group by obj.bucket_id;
END
$$;


ALTER FUNCTION storage.get_size_by_bucket() OWNER TO supabase_storage_admin;

--
-- TOC entry 449 (class 1255 OID 17043)
-- Name: list_multipart_uploads_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, next_key_token text DEFAULT ''::text, next_upload_token text DEFAULT ''::text) RETURNS TABLE(key text, id text, created_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(key COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                        substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1)))
                    ELSE
                        key
                END AS key, id, created_at
            FROM
                storage.s3_multipart_uploads
            WHERE
                bucket_id = $5 AND
                key ILIKE $1 || ''%'' AND
                CASE
                    WHEN $4 != '''' AND $6 = '''' THEN
                        CASE
                            WHEN position($2 IN substring(key from length($1) + 1)) > 0 THEN
                                substring(key from 1 for length($1) + position($2 IN substring(key from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                key COLLATE "C" > $4
                            END
                    ELSE
                        true
                END AND
                CASE
                    WHEN $6 != '''' THEN
                        id COLLATE "C" > $6
                    ELSE
                        true
                    END
            ORDER BY
                key COLLATE "C" ASC, created_at ASC) as e order by key COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_key_token, bucket_id, next_upload_token;
END;
$_$;


ALTER FUNCTION storage.list_multipart_uploads_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, next_key_token text, next_upload_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 445 (class 1255 OID 17006)
-- Name: list_objects_with_delimiter(text, text, text, integer, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer DEFAULT 100, start_after text DEFAULT ''::text, next_token text DEFAULT ''::text) RETURNS TABLE(name text, id uuid, metadata jsonb, updated_at timestamp with time zone)
    LANGUAGE plpgsql
    AS $_$
BEGIN
    RETURN QUERY EXECUTE
        'SELECT DISTINCT ON(name COLLATE "C") * from (
            SELECT
                CASE
                    WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                        substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1)))
                    ELSE
                        name
                END AS name, id, metadata, updated_at
            FROM
                storage.objects
            WHERE
                bucket_id = $5 AND
                name ILIKE $1 || ''%'' AND
                CASE
                    WHEN $6 != '''' THEN
                    name COLLATE "C" > $6
                ELSE true END
                AND CASE
                    WHEN $4 != '''' THEN
                        CASE
                            WHEN position($2 IN substring(name from length($1) + 1)) > 0 THEN
                                substring(name from 1 for length($1) + position($2 IN substring(name from length($1) + 1))) COLLATE "C" > $4
                            ELSE
                                name COLLATE "C" > $4
                            END
                    ELSE
                        true
                END
            ORDER BY
                name COLLATE "C" ASC) as e order by name COLLATE "C" LIMIT $3'
        USING prefix_param, delimiter_param, max_keys, next_token, bucket_id, start_after;
END;
$_$;


ALTER FUNCTION storage.list_objects_with_delimiter(bucket_id text, prefix_param text, delimiter_param text, max_keys integer, start_after text, next_token text) OWNER TO supabase_storage_admin;

--
-- TOC entry 451 (class 1255 OID 17059)
-- Name: operation(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.operation() RETURNS text
    LANGUAGE plpgsql STABLE
    AS $$
BEGIN
    RETURN current_setting('storage.operation', true);
END;
$$;


ALTER FUNCTION storage.operation() OWNER TO supabase_storage_admin;

--
-- TOC entry 450 (class 1255 OID 16993)
-- Name: search(text, text, integer, integer, integer, text, text, text); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.search(prefix text, bucketname text, limits integer DEFAULT 100, levels integer DEFAULT 1, offsets integer DEFAULT 0, search text DEFAULT ''::text, sortcolumn text DEFAULT 'name'::text, sortorder text DEFAULT 'asc'::text) RETURNS TABLE(name text, id uuid, updated_at timestamp with time zone, created_at timestamp with time zone, last_accessed_at timestamp with time zone, metadata jsonb)
    LANGUAGE plpgsql STABLE
    AS $_$
declare
  v_order_by text;
  v_sort_order text;
begin
  case
    when sortcolumn = 'name' then
      v_order_by = 'name';
    when sortcolumn = 'updated_at' then
      v_order_by = 'updated_at';
    when sortcolumn = 'created_at' then
      v_order_by = 'created_at';
    when sortcolumn = 'last_accessed_at' then
      v_order_by = 'last_accessed_at';
    else
      v_order_by = 'name';
  end case;

  case
    when sortorder = 'asc' then
      v_sort_order = 'asc';
    when sortorder = 'desc' then
      v_sort_order = 'desc';
    else
      v_sort_order = 'asc';
  end case;

  v_order_by = v_order_by || ' ' || v_sort_order;

  return query execute
    'with folders as (
       select path_tokens[$1] as folder
       from storage.objects
         where objects.name ilike $2 || $3 || ''%''
           and bucket_id = $4
           and array_length(objects.path_tokens, 1) <> $1
       group by folder
       order by folder ' || v_sort_order || '
     )
     (select folder as "name",
            null as id,
            null as updated_at,
            null as created_at,
            null as last_accessed_at,
            null as metadata from folders)
     union all
     (select path_tokens[$1] as "name",
            id,
            updated_at,
            created_at,
            last_accessed_at,
            metadata
     from storage.objects
     where objects.name ilike $2 || $3 || ''%''
       and bucket_id = $4
       and array_length(objects.path_tokens, 1) = $1
     order by ' || v_order_by || ')
     limit $5
     offset $6' using levels, prefix, search, bucketname, limits, offsets;
end;
$_$;


ALTER FUNCTION storage.search(prefix text, bucketname text, limits integer, levels integer, offsets integer, search text, sortcolumn text, sortorder text) OWNER TO supabase_storage_admin;

--
-- TOC entry 447 (class 1255 OID 16994)
-- Name: update_updated_at_column(); Type: FUNCTION; Schema: storage; Owner: supabase_storage_admin
--

CREATE FUNCTION storage.update_updated_at_column() RETURNS trigger
    LANGUAGE plpgsql
    AS $$
BEGIN
    NEW.updated_at = now();
    RETURN NEW; 
END;
$$;


ALTER FUNCTION storage.update_updated_at_column() OWNER TO supabase_storage_admin;

SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 293 (class 1259 OID 16512)
-- Name: audit_log_entries; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.audit_log_entries (
    instance_id uuid,
    id uuid NOT NULL,
    payload json,
    created_at timestamp with time zone,
    ip_address character varying(64) DEFAULT ''::character varying NOT NULL
);


ALTER TABLE auth.audit_log_entries OWNER TO supabase_auth_admin;

--
-- TOC entry 4483 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE audit_log_entries; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.audit_log_entries IS 'Auth: Audit trail for user actions.';


--
-- TOC entry 310 (class 1259 OID 16901)
-- Name: flow_state; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.flow_state (
    id uuid NOT NULL,
    user_id uuid,
    auth_code text NOT NULL,
    code_challenge_method auth.code_challenge_method NOT NULL,
    code_challenge text NOT NULL,
    provider_type text NOT NULL,
    provider_access_token text,
    provider_refresh_token text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    authentication_method text NOT NULL,
    auth_code_issued_at timestamp with time zone
);


ALTER TABLE auth.flow_state OWNER TO supabase_auth_admin;

--
-- TOC entry 4485 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE flow_state; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.flow_state IS 'stores metadata for pkce logins';


--
-- TOC entry 301 (class 1259 OID 16698)
-- Name: identities; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.identities (
    provider_id text NOT NULL,
    user_id uuid NOT NULL,
    identity_data jsonb NOT NULL,
    provider text NOT NULL,
    last_sign_in_at timestamp with time zone,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    email text GENERATED ALWAYS AS (lower((identity_data ->> 'email'::text))) STORED,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE auth.identities OWNER TO supabase_auth_admin;

--
-- TOC entry 4487 (class 0 OID 0)
-- Dependencies: 301
-- Name: TABLE identities; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.identities IS 'Auth: Stores identities associated to a user.';


--
-- TOC entry 4488 (class 0 OID 0)
-- Dependencies: 301
-- Name: COLUMN identities.email; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.identities.email IS 'Auth: Email is a generated column that references the optional email property in the identity_data';


--
-- TOC entry 292 (class 1259 OID 16505)
-- Name: instances; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.instances (
    id uuid NOT NULL,
    uuid uuid,
    raw_base_config text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone
);


ALTER TABLE auth.instances OWNER TO supabase_auth_admin;

--
-- TOC entry 4490 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE instances; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.instances IS 'Auth: Manages users across multiple sites.';


--
-- TOC entry 305 (class 1259 OID 16788)
-- Name: mfa_amr_claims; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_amr_claims (
    session_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    authentication_method text NOT NULL,
    id uuid NOT NULL
);


ALTER TABLE auth.mfa_amr_claims OWNER TO supabase_auth_admin;

--
-- TOC entry 4492 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE mfa_amr_claims; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_amr_claims IS 'auth: stores authenticator method reference claims for multi factor authentication';


--
-- TOC entry 304 (class 1259 OID 16776)
-- Name: mfa_challenges; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_challenges (
    id uuid NOT NULL,
    factor_id uuid NOT NULL,
    created_at timestamp with time zone NOT NULL,
    verified_at timestamp with time zone,
    ip_address inet NOT NULL,
    otp_code text,
    web_authn_session_data jsonb
);


ALTER TABLE auth.mfa_challenges OWNER TO supabase_auth_admin;

--
-- TOC entry 4494 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE mfa_challenges; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_challenges IS 'auth: stores metadata about challenge requests made';


--
-- TOC entry 303 (class 1259 OID 16763)
-- Name: mfa_factors; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.mfa_factors (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    friendly_name text,
    factor_type auth.factor_type NOT NULL,
    status auth.factor_status NOT NULL,
    created_at timestamp with time zone NOT NULL,
    updated_at timestamp with time zone NOT NULL,
    secret text,
    phone text,
    last_challenged_at timestamp with time zone,
    web_authn_credential jsonb,
    web_authn_aaguid uuid
);


ALTER TABLE auth.mfa_factors OWNER TO supabase_auth_admin;

--
-- TOC entry 4496 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE mfa_factors; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.mfa_factors IS 'auth: stores metadata about factors';


--
-- TOC entry 311 (class 1259 OID 16951)
-- Name: one_time_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.one_time_tokens (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    token_type auth.one_time_token_type NOT NULL,
    token_hash text NOT NULL,
    relates_to text NOT NULL,
    created_at timestamp without time zone DEFAULT now() NOT NULL,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    CONSTRAINT one_time_tokens_token_hash_check CHECK ((char_length(token_hash) > 0))
);


ALTER TABLE auth.one_time_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 291 (class 1259 OID 16494)
-- Name: refresh_tokens; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.refresh_tokens (
    instance_id uuid,
    id bigint NOT NULL,
    token character varying(255),
    user_id character varying(255),
    revoked boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    parent character varying(255),
    session_id uuid
);


ALTER TABLE auth.refresh_tokens OWNER TO supabase_auth_admin;

--
-- TOC entry 4499 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE refresh_tokens; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.refresh_tokens IS 'Auth: Store of tokens used to refresh JWT tokens once they expire.';


--
-- TOC entry 290 (class 1259 OID 16493)
-- Name: refresh_tokens_id_seq; Type: SEQUENCE; Schema: auth; Owner: supabase_auth_admin
--

CREATE SEQUENCE auth.refresh_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE auth.refresh_tokens_id_seq OWNER TO supabase_auth_admin;

--
-- TOC entry 4501 (class 0 OID 0)
-- Dependencies: 290
-- Name: refresh_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: auth; Owner: supabase_auth_admin
--

ALTER SEQUENCE auth.refresh_tokens_id_seq OWNED BY auth.refresh_tokens.id;


--
-- TOC entry 308 (class 1259 OID 16830)
-- Name: saml_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_providers (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    entity_id text NOT NULL,
    metadata_xml text NOT NULL,
    metadata_url text,
    attribute_mapping jsonb,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    name_id_format text,
    CONSTRAINT "entity_id not empty" CHECK ((char_length(entity_id) > 0)),
    CONSTRAINT "metadata_url not empty" CHECK (((metadata_url = NULL::text) OR (char_length(metadata_url) > 0))),
    CONSTRAINT "metadata_xml not empty" CHECK ((char_length(metadata_xml) > 0))
);


ALTER TABLE auth.saml_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4503 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE saml_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_providers IS 'Auth: Manages SAML Identity Provider connections.';


--
-- TOC entry 309 (class 1259 OID 16848)
-- Name: saml_relay_states; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.saml_relay_states (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    request_id text NOT NULL,
    for_email text,
    redirect_to text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    flow_state_id uuid,
    CONSTRAINT "request_id not empty" CHECK ((char_length(request_id) > 0))
);


ALTER TABLE auth.saml_relay_states OWNER TO supabase_auth_admin;

--
-- TOC entry 4505 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE saml_relay_states; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.saml_relay_states IS 'Auth: Contains SAML Relay State information for each Service Provider initiated login.';


--
-- TOC entry 294 (class 1259 OID 16520)
-- Name: schema_migrations; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.schema_migrations (
    version character varying(255) NOT NULL
);


ALTER TABLE auth.schema_migrations OWNER TO supabase_auth_admin;

--
-- TOC entry 4507 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE schema_migrations; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.schema_migrations IS 'Auth: Manages updates to the auth system.';


--
-- TOC entry 302 (class 1259 OID 16728)
-- Name: sessions; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sessions (
    id uuid NOT NULL,
    user_id uuid NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    factor_id uuid,
    aal auth.aal_level,
    not_after timestamp with time zone,
    refreshed_at timestamp without time zone,
    user_agent text,
    ip inet,
    tag text
);


ALTER TABLE auth.sessions OWNER TO supabase_auth_admin;

--
-- TOC entry 4509 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE sessions; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sessions IS 'Auth: Stores session data associated to a user.';


--
-- TOC entry 4510 (class 0 OID 0)
-- Dependencies: 302
-- Name: COLUMN sessions.not_after; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sessions.not_after IS 'Auth: Not after is a nullable column that contains a timestamp after which the session should be regarded as expired.';


--
-- TOC entry 307 (class 1259 OID 16815)
-- Name: sso_domains; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_domains (
    id uuid NOT NULL,
    sso_provider_id uuid NOT NULL,
    domain text NOT NULL,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "domain not empty" CHECK ((char_length(domain) > 0))
);


ALTER TABLE auth.sso_domains OWNER TO supabase_auth_admin;

--
-- TOC entry 4512 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE sso_domains; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_domains IS 'Auth: Manages SSO email address domain mapping to an SSO Identity Provider.';


--
-- TOC entry 306 (class 1259 OID 16806)
-- Name: sso_providers; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.sso_providers (
    id uuid NOT NULL,
    resource_id text,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    CONSTRAINT "resource_id not empty" CHECK (((resource_id = NULL::text) OR (char_length(resource_id) > 0)))
);


ALTER TABLE auth.sso_providers OWNER TO supabase_auth_admin;

--
-- TOC entry 4514 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE sso_providers; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.sso_providers IS 'Auth: Manages SSO identity provider information; see saml_providers for SAML.';


--
-- TOC entry 4515 (class 0 OID 0)
-- Dependencies: 306
-- Name: COLUMN sso_providers.resource_id; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.sso_providers.resource_id IS 'Auth: Uniquely identifies a SSO provider according to a user-chosen resource ID (case insensitive), useful in infrastructure as code.';


--
-- TOC entry 289 (class 1259 OID 16482)
-- Name: users; Type: TABLE; Schema: auth; Owner: supabase_auth_admin
--

CREATE TABLE auth.users (
    instance_id uuid,
    id uuid NOT NULL,
    aud character varying(255),
    role character varying(255),
    email character varying(255),
    encrypted_password character varying(255),
    email_confirmed_at timestamp with time zone,
    invited_at timestamp with time zone,
    confirmation_token character varying(255),
    confirmation_sent_at timestamp with time zone,
    recovery_token character varying(255),
    recovery_sent_at timestamp with time zone,
    email_change_token_new character varying(255),
    email_change character varying(255),
    email_change_sent_at timestamp with time zone,
    last_sign_in_at timestamp with time zone,
    raw_app_meta_data jsonb,
    raw_user_meta_data jsonb,
    is_super_admin boolean,
    created_at timestamp with time zone,
    updated_at timestamp with time zone,
    phone text DEFAULT NULL::character varying,
    phone_confirmed_at timestamp with time zone,
    phone_change text DEFAULT ''::character varying,
    phone_change_token character varying(255) DEFAULT ''::character varying,
    phone_change_sent_at timestamp with time zone,
    confirmed_at timestamp with time zone GENERATED ALWAYS AS (LEAST(email_confirmed_at, phone_confirmed_at)) STORED,
    email_change_token_current character varying(255) DEFAULT ''::character varying,
    email_change_confirm_status smallint DEFAULT 0,
    banned_until timestamp with time zone,
    reauthentication_token character varying(255) DEFAULT ''::character varying,
    reauthentication_sent_at timestamp with time zone,
    is_sso_user boolean DEFAULT false NOT NULL,
    deleted_at timestamp with time zone,
    is_anonymous boolean DEFAULT false NOT NULL,
    CONSTRAINT users_email_change_confirm_status_check CHECK (((email_change_confirm_status >= 0) AND (email_change_confirm_status <= 2)))
);


ALTER TABLE auth.users OWNER TO supabase_auth_admin;

--
-- TOC entry 4517 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE users; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON TABLE auth.users IS 'Auth: Stores user login data within a secure schema.';


--
-- TOC entry 4518 (class 0 OID 0)
-- Dependencies: 289
-- Name: COLUMN users.is_sso_user; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON COLUMN auth.users.is_sso_user IS 'Auth: Set this column to true when the account comes from SSO. These accounts can have duplicate emails.';


--
-- TOC entry 335 (class 1259 OID 29737)
-- Name: GameProvider; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."GameProvider" (
    id text NOT NULL,
    name text NOT NULL,
    "displayName" text,
    "rgsBaseUrl" text NOT NULL,
    "settingsPath" text,
    "spinPath" text,
    "resolveBetPath" text,
    "providerRoundId" text,
    "authType" public."ProviderAuthType" DEFAULT 'API_KEY'::public."ProviderAuthType" NOT NULL,
    "apiKey" text,
    "apiSecret" text,
    "publicKey" text,
    "privateKeyRef" text,
    "configJson" jsonb DEFAULT '{}'::jsonb,
    "isActive" boolean DEFAULT true NOT NULL,
    notes text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."GameProvider" OWNER TO postgres;

--
-- TOC entry 346 (class 1259 OID 29845)
-- Name: Tournament; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."Tournament" (
    id text NOT NULL,
    name text NOT NULL,
    description text,
    "startTime" timestamp(3) without time zone NOT NULL,
    "endTime" timestamp(3) without time zone,
    "targetScore" integer,
    status public."TournamentStatus" DEFAULT 'PENDING'::public."TournamentStatus" NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "createdByid" text,
    "userId" text
);


ALTER TABLE public."Tournament" OWNER TO postgres;

--
-- TOC entry 348 (class 1259 OID 29863)
-- Name: TournamentGamePlay; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TournamentGamePlay" (
    id text NOT NULL,
    "tournamentParticipantId" text NOT NULL,
    "gameId" text NOT NULL,
    "pointsEarned" integer NOT NULL,
    "playedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "gameSessionId" text
);


ALTER TABLE public."TournamentGamePlay" OWNER TO postgres;

--
-- TOC entry 347 (class 1259 OID 29854)
-- Name: TournamentParticipant; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TournamentParticipant" (
    id text NOT NULL,
    "tournamentId" text NOT NULL,
    "userId" text NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    rank integer,
    "joinedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public."TournamentParticipant" OWNER TO postgres;

--
-- TOC entry 349 (class 1259 OID 29871)
-- Name: TournamentReward; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."TournamentReward" (
    id text NOT NULL,
    "tournamentId" text NOT NULL,
    rank integer NOT NULL,
    description text NOT NULL,
    "isClaimed" boolean DEFAULT false NOT NULL,
    "winnerId" text
);


ALTER TABLE public."TournamentReward" OWNER TO postgres;

--
-- TOC entry 337 (class 1259 OID 29758)
-- Name: _TournamentGames; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."_TournamentGames" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


ALTER TABLE public."_TournamentGames" OWNER TO postgres;

--
-- TOC entry 330 (class 1259 OID 29685)
-- Name: account; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.account (
    _id text NOT NULL,
    account_id text NOT NULL,
    provider_id text NOT NULL,
    user_id text NOT NULL,
    access_token text,
    refresh_token text,
    id_token text,
    access_token_expires_at timestamp(3) without time zone,
    refresh_token_expires_at timestamp(3) without time zone,
    scope text,
    password text,
    created_at timestamp(3) without time zone NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.account OWNER TO postgres;

--
-- TOC entry 336 (class 1259 OID 29748)
-- Name: game_launch_links; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_launch_links (
    id text NOT NULL,
    token_internal text NOT NULL,
    currency text NOT NULL,
    player_operator_id text,
    mode text NOT NULL,
    meta jsonb,
    request_ip text,
    user_agent text,
    session_url text,
    state text DEFAULT 'SESSION_INIT'::text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    expires_at timestamp(3) without time zone,
    extra_meta jsonb,
    token_original text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL,
    "gameId" text NOT NULL,
    "operatorId" text NOT NULL,
    "userProfileId" text
);


ALTER TABLE public.game_launch_links OWNER TO postgres;

--
-- TOC entry 333 (class 1259 OID 29712)
-- Name: game_sessions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_sessions (
    id text NOT NULL,
    "isActive" boolean DEFAULT false NOT NULL,
    "sessionData" jsonb,
    "authSessionId" text,
    "currencyId" text,
    "startedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "endTime" timestamp(3) without time zone,
    "startTime" timestamp(3) without time zone,
    "ipAddress" text,
    "startingBalance" integer DEFAULT 0,
    "startingTotalXp" integer DEFAULT 0,
    "userAgent" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "totalWagered" integer DEFAULT 0 NOT NULL,
    "totalWon" integer DEFAULT 0 NOT NULL,
    "userId" text NOT NULL,
    "gameId" text NOT NULL,
    "rtgToken" text,
    "rtgFingerPrint" text,
    "profileId" text
);


ALTER TABLE public.game_sessions OWNER TO postgres;

--
-- TOC entry 334 (class 1259 OID 29726)
-- Name: game_spins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.game_spins (
    id text NOT NULL,
    "spinData" jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "grossWinAmount" integer DEFAULT 0 NOT NULL,
    "currencyId" text,
    "spinNumber" integer DEFAULT 0 NOT NULL,
    "gameSessionId" text NOT NULL,
    "wagerAmount" integer DEFAULT 0 NOT NULL,
    "sessionId" text NOT NULL,
    "timeStamp" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.game_spins OWNER TO postgres;

--
-- TOC entry 332 (class 1259 OID 29699)
-- Name: games; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.games (
    id text NOT NULL,
    name text NOT NULL,
    title text NOT NULL,
    "goldsvetData" jsonb,
    description text,
    "supportedProviders" public."GameProviderName"[],
    category public."GameCategory" NOT NULL,
    tags text[],
    "isActive" boolean DEFAULT true NOT NULL,
    "thumbnailUrl" text,
    "bannerUrl" text,
    meta jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    featured boolean DEFAULT false NOT NULL,
    "providerName" text,
    "totalWagered" integer DEFAULT 0 NOT NULL,
    "gameProviderId" text,
    "operatorId" text,
    "tournamentDirectives" jsonb,
    status boolean DEFAULT true NOT NULL,
    checked boolean DEFAULT false NOT NULL
);


ALTER TABLE public.games OWNER TO postgres;

--
-- TOC entry 339 (class 1259 OID 29780)
-- Name: jackpot_contributions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jackpot_contributions (
    id text NOT NULL,
    "jackpotId" text NOT NULL,
    "gameSpinId" text NOT NULL,
    "contributionAmountCoins" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.jackpot_contributions OWNER TO postgres;

--
-- TOC entry 340 (class 1259 OID 29788)
-- Name: jackpot_wins; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jackpot_wins (
    id text NOT NULL,
    "jackpotId" text NOT NULL,
    "winnerId" text NOT NULL,
    "winAmountCoins" integer NOT NULL,
    "gameSpinId" text NOT NULL,
    "transactionId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


ALTER TABLE public.jackpot_wins OWNER TO postgres;

--
-- TOC entry 338 (class 1259 OID 29765)
-- Name: jackpots; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.jackpots (
    id text NOT NULL,
    type public."JackpotType" NOT NULL,
    "currentAmountCoins" integer DEFAULT 0 NOT NULL,
    "seedAmountCoins" integer DEFAULT 0 NOT NULL,
    "minimumBetCoins" integer DEFAULT 1 NOT NULL,
    "contributionRateBasisPoints" integer DEFAULT 0 NOT NULL,
    "probabilityPerMillion" integer DEFAULT 0 NOT NULL,
    "minimumTimeBetweenWinsMinutes" integer DEFAULT 0 NOT NULL,
    "lastWonAt" timestamp(3) without time zone,
    "lastWonBy" text,
    "isActive" boolean DEFAULT true NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.jackpots OWNER TO postgres;

--
-- TOC entry 341 (class 1259 OID 29796)
-- Name: operator_access_keys; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operator_access_keys (
    id text NOT NULL,
    name text NOT NULL,
    operator_secret text NOT NULL,
    operator_access text NOT NULL,
    callback_url text NOT NULL,
    active boolean DEFAULT true NOT NULL,
    permissions public."KeyMode"[],
    ips text[],
    description text,
    last_used_at timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "ownerId" text,
    "acceptedPayments" public."PaymentMethod"[]
);


ALTER TABLE public.operator_access_keys OWNER TO postgres;

--
-- TOC entry 342 (class 1259 OID 29805)
-- Name: operator_invitations; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.operator_invitations (
    id text NOT NULL,
    "operatorId" text NOT NULL,
    username text NOT NULL,
    role public."Role" DEFAULT 'USER'::public."Role" NOT NULL,
    token text NOT NULL,
    "expiresAt" timestamp(3) without time zone NOT NULL,
    "acceptedAt" timestamp(3) without time zone,
    "invitedById" text NOT NULL,
    "userProfileId" text
);


ALTER TABLE public.operator_invitations OWNER TO postgres;

--
-- TOC entry 343 (class 1259 OID 29813)
-- Name: products; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.products (
    id text NOT NULL,
    title text DEFAULT 'default'::text NOT NULL,
    description text DEFAULT 'default'::text NOT NULL,
    url text DEFAULT 'default'::text NOT NULL,
    "iconUrl" text DEFAULT 'default'::text,
    "productType" text DEFAULT 'bundle'::text NOT NULL,
    "bonusCode" text DEFAULT ''::text,
    "bonusTotalInCredits" integer DEFAULT 0 NOT NULL,
    "isActive" boolean,
    "priceInCents" integer DEFAULT 0 NOT NULL,
    "amountToReceiveInCredits" integer DEFAULT 0 NOT NULL,
    "bestValue" integer DEFAULT 0 NOT NULL,
    "discountInCents" integer DEFAULT 0 NOT NULL,
    "bonusSpins" integer DEFAULT 0 NOT NULL,
    "isPromo" boolean DEFAULT false,
    "totalDiscountInCents" integer DEFAULT 0 NOT NULL,
    "shopId" text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone,
    "transactionId" text
);


ALTER TABLE public.products OWNER TO postgres;

--
-- TOC entry 351 (class 1259 OID 29888)
-- Name: rebate_transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.rebate_transactions (
    id text NOT NULL,
    "userId" text NOT NULL,
    "transactionId" text NOT NULL,
    "rebateAmount" double precision NOT NULL,
    "currencyId" text NOT NULL,
    "vipLevel" integer NOT NULL,
    "rebatePercentage" double precision NOT NULL,
    status public."RewardStatus" DEFAULT 'PENDING'::public."RewardStatus" NOT NULL,
    "paidOutAt" timestamp(3) without time zone,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL
);


ALTER TABLE public.rebate_transactions OWNER TO postgres;

--
-- TOC entry 329 (class 1259 OID 29678)
-- Name: session; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.session (
    _id text NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    token text NOT NULL,
    created_at timestamp(3) without time zone NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    ip_address text,
    user_agent text,
    user_id text NOT NULL
);


ALTER TABLE public.session OWNER TO postgres;

--
-- TOC entry 345 (class 1259 OID 29836)
-- Name: todo; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.todo (
    id integer NOT NULL,
    text text NOT NULL,
    completed boolean DEFAULT false NOT NULL
);


ALTER TABLE public.todo OWNER TO postgres;

--
-- TOC entry 344 (class 1259 OID 29835)
-- Name: todo_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.todo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.todo_id_seq OWNER TO postgres;

--
-- TOC entry 4522 (class 0 OID 0)
-- Dependencies: 344
-- Name: todo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.todo_id_seq OWNED BY public.todo.id;


--
-- TOC entry 350 (class 1259 OID 29879)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id text NOT NULL,
    "processedAt" timestamp(3) without time zone,
    "walletId" text,
    type public."TransactionType" NOT NULL,
    status public."TransactionStatus" DEFAULT 'PENDING'::public."TransactionStatus" NOT NULL,
    amount integer NOT NULL,
    "netAmount" integer,
    "feeAmount" integer,
    "productId" text,
    "paymentMethod" public."PaymentMethod",
    "balanceBefore" integer,
    "balanceAfter" integer,
    "bonusBalanceBefore" integer,
    "bonusBalanceAfter" integer,
    "bonusAmount" integer,
    "wageringRequirement" integer,
    "wageringProgress" integer,
    description text,
    provider text,
    "providerTxId" text,
    "relatedGameId" text,
    "relatedRoundId" text,
    metadata jsonb,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userProfileId" text,
    "operatorId" text
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 328 (class 1259 OID 29671)
-- Name: user; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public."user" (
    _id text NOT NULL,
    name text NOT NULL,
    username text NOT NULL,
    display_username text NOT NULL,
    email text NOT NULL,
    email_verified boolean NOT NULL,
    image text,
    created_at timestamp(3) without time zone NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL
);


ALTER TABLE public."user" OWNER TO postgres;

--
-- TOC entry 353 (class 1259 OID 29909)
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.user_profiles (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    username text NOT NULL,
    avatar text DEFAULT 'avatar-10.webp'::text,
    cashtag text,
    balance integer DEFAULT 0 NOT NULL,
    total_xp_from_operator integer DEFAULT 0 NOT NULL,
    active_currency_type text DEFAULT 'USD'::text NOT NULL,
    last_daily_spin timestamp(3) without time zone DEFAULT '1970-01-01 00:00:00'::timestamp without time zone NOT NULL,
    user_id text NOT NULL,
    is_active boolean DEFAULT false NOT NULL,
    other_userid text,
    role public."Role" DEFAULT 'USER'::public."Role",
    operator_id text,
    current_game_sessionid text,
    vip_info_id text NOT NULL
);


ALTER TABLE public.user_profiles OWNER TO postgres;

--
-- TOC entry 331 (class 1259 OID 29692)
-- Name: verification; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.verification (
    _id text NOT NULL,
    identifier text NOT NULL,
    value text NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    created_at timestamp(3) without time zone,
    updated_at timestamp(3) without time zone
);


ALTER TABLE public.verification OWNER TO postgres;

--
-- TOC entry 354 (class 1259 OID 29924)
-- Name: vip_infos; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.vip_infos (
    id text NOT NULL,
    created_at timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    updated_at timestamp(3) without time zone NOT NULL,
    username text NOT NULL,
    avatar text DEFAULT 'avatar-10.webp'::text,
    user_id text NOT NULL,
    level integer DEFAULT 0 NOT NULL,
    current_level_xp integer DEFAULT 0 NOT NULL,
    total_xp integer DEFAULT 0 NOT NULL,
    daily_bonus_claimed_at timestamp(3) without time zone,
    weekly_bonus_claimed_at timestamp(3) without time zone,
    monthly_bonus_claimed_at timestamp(3) without time zone,
    cashback_percentage integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.vip_infos OWNER TO postgres;

--
-- TOC entry 352 (class 1259 OID 29897)
-- Name: wallets; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.wallets (
    id text NOT NULL,
    balance double precision DEFAULT 0.0 NOT NULL,
    "isActive" boolean DEFAULT true NOT NULL,
    address text,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "updatedAt" timestamp(3) without time zone NOT NULL,
    "userId" text NOT NULL,
    "operatorId" text NOT NULL,
    "paymentMethod" public."PaymentMethod" NOT NULL,
    "bonusBalance" integer DEFAULT 0 NOT NULL,
    "lockedBalance" integer DEFAULT 0 NOT NULL
);


ALTER TABLE public.wallets OWNER TO postgres;

--
-- TOC entry 320 (class 1259 OID 17226)
-- Name: messages; Type: TABLE; Schema: realtime; Owner: supabase_realtime_admin
--

CREATE TABLE realtime.messages (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
)
PARTITION BY RANGE (inserted_at);


ALTER TABLE realtime.messages OWNER TO supabase_realtime_admin;

--
-- TOC entry 321 (class 1259 OID 26616)
-- Name: messages_2025_06_01; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.messages_2025_06_01 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_06_01 OWNER TO postgres;

--
-- TOC entry 322 (class 1259 OID 26627)
-- Name: messages_2025_06_02; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.messages_2025_06_02 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_06_02 OWNER TO postgres;

--
-- TOC entry 323 (class 1259 OID 26638)
-- Name: messages_2025_06_03; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.messages_2025_06_03 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_06_03 OWNER TO postgres;

--
-- TOC entry 324 (class 1259 OID 26649)
-- Name: messages_2025_06_04; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.messages_2025_06_04 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_06_04 OWNER TO postgres;

--
-- TOC entry 325 (class 1259 OID 26660)
-- Name: messages_2025_06_05; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.messages_2025_06_05 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_06_05 OWNER TO postgres;

--
-- TOC entry 326 (class 1259 OID 28313)
-- Name: messages_2025_06_06; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.messages_2025_06_06 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_06_06 OWNER TO postgres;

--
-- TOC entry 327 (class 1259 OID 28324)
-- Name: messages_2025_06_07; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.messages_2025_06_07 (
    topic text NOT NULL,
    extension text NOT NULL,
    payload jsonb,
    event text,
    private boolean DEFAULT false,
    updated_at timestamp without time zone DEFAULT now() NOT NULL,
    inserted_at timestamp without time zone DEFAULT now() NOT NULL,
    id uuid DEFAULT gen_random_uuid() NOT NULL
);


ALTER TABLE realtime.messages_2025_06_07 OWNER TO postgres;

--
-- TOC entry 314 (class 1259 OID 17060)
-- Name: schema_migrations; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.schema_migrations (
    version bigint NOT NULL,
    inserted_at timestamp(0) without time zone
);


ALTER TABLE realtime.schema_migrations OWNER TO postgres;

--
-- TOC entry 317 (class 1259 OID 17083)
-- Name: subscription; Type: TABLE; Schema: realtime; Owner: postgres
--

CREATE TABLE realtime.subscription (
    id bigint NOT NULL,
    subscription_id uuid NOT NULL,
    entity regclass NOT NULL,
    filters realtime.user_defined_filter[] DEFAULT '{}'::realtime.user_defined_filter[] NOT NULL,
    claims jsonb NOT NULL,
    claims_role regrole GENERATED ALWAYS AS (realtime.to_regrole((claims ->> 'role'::text))) STORED NOT NULL,
    created_at timestamp without time zone DEFAULT timezone('utc'::text, now()) NOT NULL
);


ALTER TABLE realtime.subscription OWNER TO postgres;

--
-- TOC entry 316 (class 1259 OID 17082)
-- Name: subscription_id_seq; Type: SEQUENCE; Schema: realtime; Owner: postgres
--

ALTER TABLE realtime.subscription ALTER COLUMN id ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME realtime.subscription_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);


--
-- TOC entry 295 (class 1259 OID 16533)
-- Name: buckets; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.buckets (
    id text NOT NULL,
    name text NOT NULL,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    public boolean DEFAULT false,
    avif_autodetection boolean DEFAULT false,
    file_size_limit bigint,
    allowed_mime_types text[],
    owner_id text
);


ALTER TABLE storage.buckets OWNER TO supabase_storage_admin;

--
-- TOC entry 4534 (class 0 OID 0)
-- Dependencies: 295
-- Name: COLUMN buckets.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.buckets.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 297 (class 1259 OID 16575)
-- Name: migrations; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.migrations (
    id integer NOT NULL,
    name character varying(100) NOT NULL,
    hash character varying(40) NOT NULL,
    executed_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


ALTER TABLE storage.migrations OWNER TO supabase_storage_admin;

--
-- TOC entry 296 (class 1259 OID 16548)
-- Name: objects; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.objects (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    bucket_id text,
    name text,
    owner uuid,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now(),
    last_accessed_at timestamp with time zone DEFAULT now(),
    metadata jsonb,
    path_tokens text[] GENERATED ALWAYS AS (string_to_array(name, '/'::text)) STORED,
    version text,
    owner_id text,
    user_metadata jsonb
);


ALTER TABLE storage.objects OWNER TO supabase_storage_admin;

--
-- TOC entry 4536 (class 0 OID 0)
-- Dependencies: 296
-- Name: COLUMN objects.owner; Type: COMMENT; Schema: storage; Owner: supabase_storage_admin
--

COMMENT ON COLUMN storage.objects.owner IS 'Field is deprecated, use owner_id instead';


--
-- TOC entry 312 (class 1259 OID 17008)
-- Name: s3_multipart_uploads; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads (
    id text NOT NULL,
    in_progress_size bigint DEFAULT 0 NOT NULL,
    upload_signature text NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    version text NOT NULL,
    owner_id text,
    created_at timestamp with time zone DEFAULT now() NOT NULL,
    user_metadata jsonb
);


ALTER TABLE storage.s3_multipart_uploads OWNER TO supabase_storage_admin;

--
-- TOC entry 313 (class 1259 OID 17022)
-- Name: s3_multipart_uploads_parts; Type: TABLE; Schema: storage; Owner: supabase_storage_admin
--

CREATE TABLE storage.s3_multipart_uploads_parts (
    id uuid DEFAULT gen_random_uuid() NOT NULL,
    upload_id text NOT NULL,
    size bigint DEFAULT 0 NOT NULL,
    part_number integer NOT NULL,
    bucket_id text NOT NULL,
    key text NOT NULL COLLATE pg_catalog."C",
    etag text NOT NULL,
    owner_id text,
    version text NOT NULL,
    created_at timestamp with time zone DEFAULT now() NOT NULL
);


ALTER TABLE storage.s3_multipart_uploads_parts OWNER TO supabase_storage_admin;

--
-- TOC entry 3708 (class 0 OID 0)
-- Name: messages_2025_06_01; Type: TABLE ATTACH; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_01 FOR VALUES FROM ('2025-06-01 00:00:00') TO ('2025-06-02 00:00:00');


--
-- TOC entry 3709 (class 0 OID 0)
-- Name: messages_2025_06_02; Type: TABLE ATTACH; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_02 FOR VALUES FROM ('2025-06-02 00:00:00') TO ('2025-06-03 00:00:00');


--
-- TOC entry 3710 (class 0 OID 0)
-- Name: messages_2025_06_03; Type: TABLE ATTACH; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_03 FOR VALUES FROM ('2025-06-03 00:00:00') TO ('2025-06-04 00:00:00');


--
-- TOC entry 3711 (class 0 OID 0)
-- Name: messages_2025_06_04; Type: TABLE ATTACH; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_04 FOR VALUES FROM ('2025-06-04 00:00:00') TO ('2025-06-05 00:00:00');


--
-- TOC entry 3712 (class 0 OID 0)
-- Name: messages_2025_06_05; Type: TABLE ATTACH; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_05 FOR VALUES FROM ('2025-06-05 00:00:00') TO ('2025-06-06 00:00:00');


--
-- TOC entry 3713 (class 0 OID 0)
-- Name: messages_2025_06_06; Type: TABLE ATTACH; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_06 FOR VALUES FROM ('2025-06-06 00:00:00') TO ('2025-06-07 00:00:00');


--
-- TOC entry 3714 (class 0 OID 0)
-- Name: messages_2025_06_07; Type: TABLE ATTACH; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages ATTACH PARTITION realtime.messages_2025_06_07 FOR VALUES FROM ('2025-06-07 00:00:00') TO ('2025-06-08 00:00:00');


--
-- TOC entry 3724 (class 2604 OID 16497)
-- Name: refresh_tokens id; Type: DEFAULT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens ALTER COLUMN id SET DEFAULT nextval('auth.refresh_tokens_id_seq'::regclass);


--
-- TOC entry 3837 (class 2604 OID 29839)
-- Name: todo id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.todo ALTER COLUMN id SET DEFAULT nextval('public.todo_id_seq'::regclass);


--
-- TOC entry 4325 (class 0 OID 16512)a
-- Dependencies: 293
-- Data for Name: audit_log_entries; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.audit_log_entries (instance_id, id, payload, created_at, ip_address) FROM stdin;



--
-- TOC entry 4339 (class 0 OID 16901)
-- Dependencies: 310
-- Data for Name: flow_state; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.flow_state (id, user_id, auth_code, code_challenge_method, code_challenge, provider_type, provider_access_token, provider_refresh_token, created_at, updated_at, authentication_method, auth_code_issued_at) FROM stdin;



--
-- TOC entry 4330 (class 0 OID 16698)
-- Dependencies: 301
-- Data for Name: identities; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.identities (provider_id, user_id, identity_data, provider, last_sign_in_at, created_at, updated_at, id) FROM stdin;



--
-- TOC entry 4324 (class 0 OID 16505)
-- Dependencies: 292
-- Data for Name: instances; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.instances (id, uuid, raw_base_config, created_at, updated_at) FROM stdin;



--
-- TOC entry 4334 (class 0 OID 16788)
-- Dependencies: 305
-- Data for Name: mfa_amr_claims; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_amr_claims (session_id, created_at, updated_at, authentication_method, id) FROM stdin;



--
-- TOC entry 4333 (class 0 OID 16776)
-- Dependencies: 304
-- Data for Name: mfa_challenges; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_challenges (id, factor_id, created_at, verified_at, ip_address, otp_code, web_authn_session_data) FROM stdin;



--
-- TOC entry 4332 (class 0 OID 16763)
-- Dependencies: 303
-- Data for Name: mfa_factors; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.mfa_factors (id, user_id, friendly_name, factor_type, status, created_at, updated_at, secret, phone, last_challenged_at, web_authn_credential, web_authn_aaguid) FROM stdin;



--
-- TOC entry 4340 (class 0 OID 16951)
-- Dependencies: 311
-- Data for Name: one_time_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.one_time_tokens (id, user_id, token_type, token_hash, relates_to, created_at, updated_at) FROM stdin;



--
-- TOC entry 4323 (class 0 OID 16494)
-- Dependencies: 291
-- Data for Name: refresh_tokens; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.refresh_tokens (instance_id, id, token, user_id, revoked, created_at, updated_at, parent, session_id) FROM stdin;



--
-- TOC entry 4337 (class 0 OID 16830)
-- Dependencies: 308
-- Data for Name: saml_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_providers (id, sso_provider_id, entity_id, metadata_xml, metadata_url, attribute_mapping, created_at, updated_at, name_id_format) FROM stdin;



--
-- TOC entry 4338 (class 0 OID 16848)
-- Dependencies: 309
-- Data for Name: saml_relay_states; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.saml_relay_states (id, sso_provider_id, request_id, for_email, redirect_to, created_at, updated_at, flow_state_id) FROM stdin;



--
-- TOC entry 4326 (class 0 OID 16520)
-- Dependencies: 294
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--




--
-- TOC entry 4331 (class 0 OID 16728)
-- Dependencies: 302
-- Data for Name: sessions; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sessions (id, user_id, created_at, updated_at, factor_id, aal, not_after, refreshed_at, user_agent, ip, tag) FROM stdin;



--
-- TOC entry 4336 (class 0 OID 16815)
-- Dependencies: 307
-- Data for Name: sso_domains; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_domains (id, sso_provider_id, domain, created_at, updated_at) FROM stdin;



--
-- TOC entry 4335 (class 0 OID 16806)
-- Dependencies: 306
-- Data for Name: sso_providers; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.sso_providers (id, resource_id, created_at, updated_at) FROM stdin;



--
-- TOC entry 4321 (class 0 OID 16482)
-- Dependencies: 289
-- Data for Name: users; Type: TABLE DATA; Schema: auth; Owner: supabase_auth_admin
--

COPY auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at, invited_at, confirmation_token, confirmation_sent_at, recovery_token, recovery_sent_at, email_change_token_new, email_change, email_change_sent_at, last_sign_in_at, raw_app_meta_data, raw_user_meta_data, is_super_admin, created_at, updated_at, phone, phone_confirmed_at, phone_change, phone_change_token, phone_change_sent_at, email_change_token_current, email_change_confirm_status, banned_until, reauthentication_token, reauthentication_sent_at, is_sso_user, deleted_at, is_anonymous) FROM stdin;



--
-- TOC entry 4360 (class 0 OID 29737)
-- Dependencies: 335
-- Data for Name: GameProvider; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."GameProvider" (id, name, "displayName", "rgsBaseUrl", "settingsPath", "spinPath", "resolveBetPath", "providerRoundId", "authType", "apiKey", "apiSecret", "publicKey", "privateKeyRef", "configJson", "isActive", notes, "createdAt", "updatedAt") FROM stdin;
cmbhqvpdx004vmdgpxdarl0gy	PRAGMATICPLAY	Pragmatic Play	https://api.pragmaticplay.com/rgs	\N	\N	\N	\N	API_KEY	pk_BiOMFMN5JdGvdqsqo0RYZAQdIqgAon2L	\N	\N	\N	{"gameLaunchParams": ["token", "lang", "gameSymbol"]}	t	\N	2025-06-04 09:28:10.053	2025-06-04 09:28:10.053
cmbhqvppf004wmdgpirw93dpd	EVOPLAY	EvoPlay	https://api.evoplay.games/api/v2	\N	\N	\N	\N	JWT_SIGN	\N	\N	\N	EVOPLAY_PRIVATE_KEY_VAULT_REF	{"jwtAlgorithm": "RS256"}	t	\N	2025-06-04 09:28:10.468	2025-06-04 09:28:10.468
cmbhqvq16004xmdgpqpazz5nz	NETENT	NetEnt	https://netent-static.casinomodule.com/games	\N	\N	\N	\N	CUSTOM	\N	\N	\N	\N	{"operatorId": "f2155853-eafd-4fb1-95ba-6305d6816c0e"}	t	\N	2025-06-04 09:28:10.89	2025-06-04 09:28:10.89
cmbhqvqci004ymdgpg5lzt4cf	REDTIGER	Red Tiger	https://rgs.redtiger.com/rtg	\N	\N	\N	\N	API_KEY	rtg_pk_Kue5krDRcmN718wAd9kXmjtm	\N	\N	\N	{}	t	\N	2025-06-04 09:28:11.299	2025-06-04 09:28:11.299
cmbhqvqnr004zmdgpu6kglpp2	KICKASS	KickAss Games	https://api.kickassgames.dev/v1	\N	\N	\N	\N	API_KEY	ka_U0q0PFvgvm3iEEiZkFbwAb6e4bXgoV	\N	\N	\N	{}	t	\N	2025-06-04 09:28:11.704	2025-06-04 09:28:11.704
cmbhqvqz80050mdgpm4b6ij9t	NETGAME	NetGame	https://api.netgame.com/prod	\N	\N	\N	\N	API_KEY	ng_qupI7ShgPI78uTc87Tc5kFJfUED2	\N	\N	\N	{}	t	\N	2025-06-04 09:28:12.116	2025-06-04 09:28:12.116
cmbhqvrab0051mdgpze786b66	BIGFISHGAMES	Big Fish Games	https://api.bigfish.com/casino	\N	\N	\N	\N	OAUTH2	\N	\N	\N	\N	{"clientId": "3675924b-ce88-4324-9fef-2d30b8be435b"}	t	\N	2025-06-04 09:28:12.515	2025-06-04 09:28:12.515
cmbhqvrlg0052mdgp824lmait	CQNINE	CQ9 Gaming	https://api.cq9gaming.com/v1	\N	\N	\N	\N	API_KEY	cq9_9BnVHHtmgPkoyUbv11PiQseqC0jbBO	\N	\N	\N	{}	t	\N	2025-06-04 09:28:12.917	2025-06-04 09:28:12.917
cmbhqvrwu0053mdgpdx66fzpk	NOLIMIT	Nolimit City	https://rgs.nolimitcity.com	\N	\N	\N	\N	API_KEY	nlc_qRMmiGV2mS6jdSIWto0WDhyaAdzG10ZB	\N	\N	\N	{}	t	\N	2025-06-04 09:28:13.327	2025-06-04 09:28:13.327
cmbhqvs800054mdgp3oudzr3a	SPRIBE	Spribe	https://api.spribe.io	\N	\N	\N	\N	API_KEY	sp_58SAId3pO41ghRyij8shPm6XL6JIG0	\N	\N	\N	{}	t	\N	2025-06-04 09:28:13.728	2025-06-04 09:28:13.728
cmbhqvsj90055mdgpqwwk3v7c	BGAMING	BGaming	https://api.bgaming.com/rgs	\N	\N	\N	\N	API_KEY	bg_89ByYC7tCEJ3Z0Hj5KyesRazjRrNjZ	\N	\N	\N	{}	t	\N	2025-06-04 09:28:14.133	2025-06-04 09:28:14.133
cmbhqvsum0056mdgp327hu3jm	PLAYNGO	Play'n GO	https://rgs.playngo.com	\N	\N	\N	\N	API_KEY	png_2v1LXWuMhfrrXfvQrocvG9dE3NTEZM	\N	\N	\N	{}	t	\N	2025-06-04 09:28:14.542	2025-06-04 09:28:14.542
cmbhqvt650057mdgptkfeq765	RELAXGAMING	Relax Gaming	https://api.relax-gaming.com	\N	\N	\N	\N	API_KEY	rlx_kpIF5pd2Ew7hXXtfoMFU6peuv8oV2D	\N	\N	\N	{}	t	\N	2025-06-04 09:28:14.957	2025-06-04 09:28:14.957
cmbhqvthp0058mdgp499e884m	HACKSAW	Hacksaw Gaming	https://api.hacksawgaming.com	\N	\N	\N	\N	API_KEY	hksw_vfS4lXlubO5sBtMAkPBRCB1xE1knf3	\N	\N	\N	{}	t	\N	2025-06-04 09:28:15.374	2025-06-04 09:28:15.374
cmbhqvtt50059mdgpy3dpis2a	INTERNAL	Internal Games	https://internal.casino.example/api	\N	\N	\N	\N	NONE	\N	\N	\N	\N	{}	t	\N	2025-06-04 09:28:15.785	2025-06-04 09:28:15.785



--
-- TOC entry 4371 (class 0 OID 29845)
-- Dependencies: 346
-- Data for Name: Tournament; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."Tournament" (id, name, description, "startTime", "endTime", "targetScore", status, "createdAt", "updatedAt", "createdByid", "userId") FROM stdin;
cmbhqxgnn00qhmdgpzbjdv4ci	Past Daily Challenge #1 (concerned)	Daily challenge from 1 day(s) ago, sponsored by Rempel LLC.	2025-06-03 05:00:00	2025-06-04 04:59:59.999	109276	COMPLETED	2025-06-04 09:29:32.051	2025-06-04 09:29:32.051	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqxj1e00rzmdgpezwto4qv	Past Daily Challenge #2 (better)	Daily challenge from 2 day(s) ago, sponsored by Heller, Boyle and Russel.	2025-06-02 05:00:00	2025-06-03 04:59:59.999	124887	COMPLETED	2025-06-04 09:29:35.138	2025-06-04 09:29:35.138	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqxl1500szmdgpfytdfdkp	Past Daily Challenge #3 (juicy)	Daily challenge from 3 day(s) ago, sponsored by Koepp Inc.	2025-06-01 05:00:00	2025-06-02 04:59:59.999	132842	COMPLETED	2025-06-04 09:29:37.721	2025-06-04 09:29:37.721	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqxo7s00utmdgpc45c8gws	Past Daily Challenge #4 (overdue)	Daily challenge from 4 day(s) ago, sponsored by Hermiston, Little and Hirthe.	2025-05-31 05:00:00	2025-06-01 04:59:59.999	93044	COMPLETED	2025-06-04 09:29:41.848	2025-06-04 09:29:41.848	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqxrp000womdgps3kqwur3	Past Daily Challenge #5 (clean)	Daily challenge from 5 day(s) ago, sponsored by Rodriguez, Jacobi and Terry.	2025-05-30 05:00:00	2025-05-31 04:59:59.999	104869	COMPLETED	2025-06-04 09:29:46.357	2025-06-04 09:29:46.357	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqxume00y4mdgpi326w65v	Past Daily Challenge #6 (proper)	Daily challenge from 6 day(s) ago, sponsored by Fadel - Welch.	2025-05-29 05:00:00	2025-05-30 04:59:59.999	141558	COMPLETED	2025-06-04 09:29:50.15	2025-06-04 09:29:50.15	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqxwbp00z4mdgpuij23e9i	Past Daily Challenge #7 (blue)	Daily challenge from 7 day(s) ago, sponsored by Macejkovic and Sons.	2025-05-28 05:00:00	2025-05-29 04:59:59.999	96748	COMPLETED	2025-06-04 09:29:52.357	2025-06-04 09:29:52.357	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqxzin011imdgpa8cfhdfq	Today's Daily Grind	The current daily challenge by Legros - Klocko, live now!	2025-06-04 07:00:00	2025-06-05 07:00:00	87478	ACTIVE	2025-06-04 09:29:56.495	2025-06-04 09:29:56.495	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqy1iv0128mdgptulgabq0	Upcoming Daily Dash	Get ready for tomorrow's daily challenge by Carter, Bruen and Hane!	2025-06-05 05:00:00	2025-06-06 04:59:59.999	140492	PENDING	2025-06-04 09:29:59.095	2025-06-04 09:29:59.095	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqy216012cmdgp9exc9p5i	Last Week's Marathon	Highlights from the previous week's grand tournament by Harber, Lebsack and Baumbach.	2025-05-26 05:00:00	2025-06-02 04:59:59.999	433734	COMPLETED	2025-06-04 09:29:59.754	2025-06-04 09:29:59.754	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqy2uw012kmdgpnahp38gg	This Week's Championship	The main event for this week by Green Group is ongoing!	2025-06-02 05:00:00	2025-06-09 04:59:59.999	827105	ACTIVE	2025-06-04 09:30:00.824	2025-06-04 09:30:00.824	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqy3nz012tmdgpj13ikej0	Next Week's Conquest	Prepare for the upcoming weekly tournament by Beer and Sons.	2025-06-09 05:00:00	2025-06-16 04:59:59.999	588772	PENDING	2025-06-04 09:30:01.871	2025-06-04 09:30:01.871	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqy46e012xmdgpfyckbxcr	Last Weekend's Rumble	Revisiting the excitement of the past weekend tournament by Schroeder, Beahan and Roob.	2025-05-30 22:00:00	2025-06-02 03:59:59.999	172638	COMPLETED	2025-06-04 09:30:02.534	2025-06-04 09:30:02.534	\N	44e19cc5-466c-4551-8719-621ed777c04f
cmbhqy5bo013pmdgpc97o5ajq	Upcoming Weekend Blitz	Get set for the weekend's action-packed tournament by McClure LLC!	2025-06-06 22:00:00	2025-06-09 03:59:59.999	393154	PENDING	2025-06-04 09:30:04.02	2025-06-04 09:30:04.02	\N	44e19cc5-466c-4551-8719-621ed777c04f



--
-- TOC entry 4373 (class 0 OID 29863)
-- Dependencies: 348
-- Data for Name: TournamentGamePlay; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TournamentGamePlay" (id, "tournamentParticipantId", "gameId", "pointsEarned", "playedAt", "gameSessionId") FROM stdin;
cmbhqxh7l00qnmdgpbp8akbrm	cmbhqxh7l00qmmdgp8cs7f0w6	cmbhqvuas006tmdgp84zizuof	6534	2025-06-03 08:09:04.898	\N
cmbhqxh7l00qomdgplrigtwy1	cmbhqxh7l00qmmdgp8cs7f0w6	cmbhqvuau007qmdgpyphe5zj1	4357	2025-06-04 04:41:59.121	\N
cmbhqxh7l00qpmdgpy20lov87	cmbhqxh7l00qmmdgp8cs7f0w6	cmbhqvuau007qmdgpyphe5zj1	8171	2025-06-03 05:41:40.954	\N
cmbhqxhia00qsmdgpkbsyd0ck	cmbhqxhia00qrmdgphneum08g	cmbhqvuau007qmdgpyphe5zj1	5988	2025-06-03 10:37:15.178	\N
cmbhqxhia00qtmdgps29vgie5	cmbhqxhia00qrmdgphneum08g	cmbhqvuau007qmdgpyphe5zj1	2797	2025-06-04 02:03:19.42	\N
cmbhqxhia00qumdgp0s82hr9a	cmbhqxhia00qrmdgphneum08g	cmbhqvuaw008cmdgpf7du7jp8	5885	2025-06-03 07:23:47.057	\N
cmbhqxhia00qvmdgppip113zl	cmbhqxhia00qrmdgphneum08g	cmbhqvuaw008cmdgpf7du7jp8	2998	2025-06-03 05:54:47.805	\N
cmbhqxhia00qwmdgp2f4mngm7	cmbhqxhia00qrmdgphneum08g	cmbhqvuas006tmdgp84zizuof	10478	2025-06-03 09:37:04.238	\N
cmbhqxhia00qxmdgpr9cy5u0k	cmbhqxhia00qrmdgphneum08g	cmbhqvuas006tmdgp84zizuof	5125	2025-06-03 17:06:56.187	\N
cmbhqxhia00qymdgpy7kfv33w	cmbhqxhia00qrmdgphneum08g	cmbhqvuas006tmdgp84zizuof	47	2025-06-04 04:09:47.623	\N
cmbhqxhia00qzmdgp7fbnpmfd	cmbhqxhia00qrmdgphneum08g	cmbhqvuav007umdgp297z1ygv	10191	2025-06-03 20:47:13.736	\N
cmbhqxhia00r0mdgpkcjarr2a	cmbhqxhia00qrmdgphneum08g	cmbhqvuav007umdgp297z1ygv	989	2025-06-03 19:14:32.216	\N
cmbhqxhia00r1mdgpvjh088gg	cmbhqxhia00qrmdgphneum08g	cmbhqvuav007umdgp297z1ygv	4558	2025-06-03 20:18:04.714	\N
cmbhqxhsx00r4mdgpqdlm7yht	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuau007qmdgpyphe5zj1	8634	2025-06-03 05:42:30.791	\N
cmbhqxhsx00r5mdgp7c1oqnt1	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuaw008cmdgpf7du7jp8	2843	2025-06-04 03:18:34.484	\N
cmbhqxhsx00r6mdgpyi8qdhch	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuaw008cmdgpf7du7jp8	9390	2025-06-03 14:59:27.653	\N
cmbhqxhsx00r7mdgpn6z3d37q	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuaw008cmdgpf7du7jp8	3774	2025-06-03 18:44:15.01	\N
cmbhqxhsx00r8mdgpsguzhwim	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuav007umdgp297z1ygv	7958	2025-06-03 19:16:12.87	\N
cmbhqxhsx00r9mdgpuoiyrgqw	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuav007umdgp297z1ygv	8570	2025-06-03 06:35:54.149	\N
cmbhqxhsx00ramdgpmz3z9n6u	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuav007umdgp297z1ygv	4661	2025-06-03 21:35:20.633	\N
cmbhqxhsx00rbmdgpenc7vl94	cmbhqxhsx00r3mdgp4rx23zcc	cmbhqvuas006tmdgp84zizuof	8240	2025-06-03 17:06:01.36	\N
cmbhqxi3t00remdgp3wehugwa	cmbhqxi3t00rdmdgpanuvpr17	cmbhqvuav007umdgp297z1ygv	4510	2025-06-03 22:01:42.435	\N
cmbhqxi3t00rfmdgp0b059nso	cmbhqxi3t00rdmdgpanuvpr17	cmbhqvuav007umdgp297z1ygv	2666	2025-06-03 05:23:51.578	\N
cmbhqxi3t00rgmdgphkt6k3u0	cmbhqxi3t00rdmdgpanuvpr17	cmbhqvuav007umdgp297z1ygv	5089	2025-06-04 02:39:21.04	\N
cmbhqxif900rjmdgp9qy18p84	cmbhqxif900rimdgpdkqk9pjy	cmbhqvuau007qmdgpyphe5zj1	5508	2025-06-04 00:48:37.379	\N
cmbhqxif900rkmdgpymyxnyju	cmbhqxif900rimdgpdkqk9pjy	cmbhqvuau007qmdgpyphe5zj1	1703	2025-06-03 14:56:02.246	\N
cmbhqxif900rlmdgpvfic30me	cmbhqxif900rimdgpdkqk9pjy	cmbhqvuau007qmdgpyphe5zj1	297	2025-06-03 14:37:27.825	\N
cmbhqxiqg00romdgpcmszuwko	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuaw008jmdgpbuzn4kgy	1815	2025-06-03 23:15:04.236	\N
cmbhqxiqg00rpmdgpr5zj3trw	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuaw008jmdgpbuzn4kgy	7693	2025-06-03 12:31:04.91	\N
cmbhqxiqg00rqmdgp03ol54pw	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuav007umdgp297z1ygv	3889	2025-06-03 11:01:46.537	\N
cmbhqxiqg00rrmdgpzk8dwvzm	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuav007umdgp297z1ygv	9113	2025-06-03 13:40:48.776	\N
cmbhqxiqg00rsmdgp187lqqj9	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuas006tmdgp84zizuof	5091	2025-06-03 16:12:13.55	\N
cmbhqxiqg00rtmdgp7xsgtzvy	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuau007qmdgpyphe5zj1	3144	2025-06-03 23:38:56.085	\N
cmbhqxiqg00rumdgp2mipre65	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuau007qmdgpyphe5zj1	4134	2025-06-04 02:30:17.304	\N
cmbhqxiqg00rvmdgp0h74slat	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuau007qmdgpyphe5zj1	7756	2025-06-03 20:51:16.911	\N
cmbhqxiqg00rwmdgp1jw3ztgl	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuaw008cmdgpf7du7jp8	6665	2025-06-04 03:02:54.738	\N
cmbhqxiqg00rxmdgp8fr4fcf6	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuaw008cmdgpf7du7jp8	8178	2025-06-03 21:29:11.981	\N
cmbhqxiqg00rymdgpgdpwdk8d	cmbhqxiqg00rnmdgpqydn88s4	cmbhqvuaw008cmdgpf7du7jp8	4117	2025-06-04 00:50:53.614	\N
cmbhqxjk600s5mdgpdmwx6nj8	cmbhqxjk600s4mdgpir0u4pec	cmbhqvuaq005mmdgpwwo2gj0e	4088	2025-06-03 00:16:47.887	\N
cmbhqxjk600s6mdgpe2462a3i	cmbhqxjk600s4mdgpir0u4pec	cmbhqvuaq005mmdgpwwo2gj0e	3865	2025-06-03 03:25:04.964	\N
cmbhqxjk600s7mdgpgstzn6vq	cmbhqxjk600s4mdgpir0u4pec	cmbhqvuar006fmdgpy2fob1y0	5065	2025-06-02 13:58:10.442	\N
cmbhqxjk600s8mdgpqkodqgxm	cmbhqxjk600s4mdgpir0u4pec	cmbhqvuar006fmdgpy2fob1y0	3120	2025-06-02 10:46:41.988	\N
cmbhqxjk600s9mdgp3qcrgody	cmbhqxjk600s4mdgpir0u4pec	cmbhqvuas006smdgpp1w52gld	7375	2025-06-02 05:59:51.068	\N
cmbhqxjux00scmdgpkgajnb4o	cmbhqxjux00sbmdgpg24igucj	cmbhqvuar006fmdgpy2fob1y0	8616	2025-06-02 11:41:18.715	\N
cmbhqxjux00sdmdgptxffooi0	cmbhqxjux00sbmdgpg24igucj	cmbhqvuar006fmdgpy2fob1y0	4176	2025-06-02 09:17:03.118	\N
cmbhqxk5h00sgmdgpih9of30v	cmbhqxk5h00sfmdgp2uzmnvy2	cmbhqvuaq005mmdgpwwo2gj0e	5167	2025-06-02 05:07:26.197	\N
cmbhqxk5h00shmdgpoctsrkv1	cmbhqxk5h00sfmdgp2uzmnvy2	cmbhqvuaq005mmdgpwwo2gj0e	1266	2025-06-02 13:34:53.458	\N
cmbhqxkfu00skmdgp0jx26bcg	cmbhqxkfu00sjmdgpv3fwao4p	cmbhqvuaq005mmdgpwwo2gj0e	8983	2025-06-02 13:22:45.581	\N
cmbhqxkfu00slmdgptfvug2d2	cmbhqxkfu00sjmdgpv3fwao4p	cmbhqvuaq005mmdgpwwo2gj0e	2734	2025-06-02 17:11:48.178	\N
cmbhqxkfu00smmdgpvywqvvlh	cmbhqxkfu00sjmdgpv3fwao4p	cmbhqvuaq005mmdgpwwo2gj0e	877	2025-06-02 08:09:37.037	\N
cmbhqxkfu00snmdgph3h6qf82	cmbhqxkfu00sjmdgpv3fwao4p	cmbhqvuas006smdgpp1w52gld	12139	2025-06-03 04:16:27.955	\N
cmbhqxkfu00somdgp7e8dv29i	cmbhqxkfu00sjmdgpv3fwao4p	cmbhqvuas006smdgpp1w52gld	4212	2025-06-02 14:12:49.281	\N
cmbhqxkfu00spmdgp88rwql10	cmbhqxkfu00sjmdgpv3fwao4p	cmbhqvuas006smdgpp1w52gld	4866	2025-06-03 03:46:06.464	\N
cmbhqxkqi00ssmdgpm80qel7c	cmbhqxkqi00srmdgp568vqvkz	cmbhqvuau007fmdgpb76g1dli	3824	2025-06-02 13:59:44.748	\N
cmbhqxkqi00stmdgpmp1jhly2	cmbhqxkqi00srmdgp568vqvkz	cmbhqvuau007fmdgpb76g1dli	6954	2025-06-02 18:41:23.659	\N
cmbhqxkqi00sumdgpi0ip6ddj	cmbhqxkqi00srmdgp568vqvkz	cmbhqvuau007fmdgpb76g1dli	4248	2025-06-02 20:36:32.229	\N
cmbhqxkqi00svmdgpkyho8swk	cmbhqxkqi00srmdgp568vqvkz	cmbhqvuaq005mmdgpwwo2gj0e	3981	2025-06-02 19:33:15.102	\N
cmbhqxkqi00swmdgpbf6ziivi	cmbhqxkqi00srmdgp568vqvkz	cmbhqvuas006imdgp4yt775s7	6549	2025-06-02 11:00:59.402	\N
cmbhqxkqi00sxmdgp60hypwtt	cmbhqxkqi00srmdgp568vqvkz	cmbhqvuas006smdgpp1w52gld	5824	2025-06-02 22:51:20.763	\N
cmbhqxkqi00symdgp9eshzs3l	cmbhqxkqi00srmdgp568vqvkz	cmbhqvuar006fmdgpy2fob1y0	11767	2025-06-02 19:48:33.84	\N
cmbhqxlkb00t5mdgp50134uzo	cmbhqxlkb00t4mdgpdeeohzqi	cmbhqvuat006zmdgpripqhodi	6356	2025-06-02 03:07:20.552	\N
cmbhqxlkb00t6mdgpkox5d2z3	cmbhqxlkb00t4mdgpdeeohzqi	cmbhqvuau007kmdgp5xx5do8d	2727	2025-06-01 07:49:20.922	\N
cmbhqxlkb00t7mdgpafsv8bmk	cmbhqxlkb00t4mdgpdeeohzqi	cmbhqvuau007kmdgp5xx5do8d	9934	2025-06-01 11:32:13.084	\N
cmbhqxlkb00t8mdgpnvaswon4	cmbhqxlkb00t4mdgpdeeohzqi	cmbhqvuau007kmdgp5xx5do8d	4455	2025-06-01 11:08:31.962	\N
cmbhqxluw00tbmdgpfynvrdaq	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuav0083mdgphir1eor8	1887	2025-06-01 07:26:48.729	\N
cmbhqxluw00tcmdgpf1mkbdfw	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuav0083mdgphir1eor8	7257	2025-06-02 02:19:04.141	\N
cmbhqxluw00tdmdgp46qs61o7	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuat006zmdgpripqhodi	1637	2025-06-02 02:23:16.525	\N
cmbhqxluw00temdgp6u15p9fg	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuat006zmdgpripqhodi	12053	2025-06-01 22:36:46.717	\N
cmbhqxluw00tfmdgpdc96ozw8	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuau007kmdgp5xx5do8d	8580	2025-06-01 13:54:49.765	\N
cmbhqxluw00tgmdgpaqm4z24g	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuap005fmdgp1yyiy3s4	12629	2025-06-02 03:17:33.352	\N
cmbhqxluw00thmdgpfi4e177m	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuap005fmdgp1yyiy3s4	902	2025-06-01 15:05:44.593	\N
cmbhqxluw00timdgp220rvbrj	cmbhqxluv00tamdgpydqg9mlm	cmbhqvuap005fmdgp1yyiy3s4	4803	2025-06-02 04:16:46.928	\N
cmbhqxm5k00tlmdgpfg1xbowj	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuaq005ymdgpxn0itswl	2825	2025-06-01 12:11:17.42	\N
cmbhqxm5k00tmmdgpv4jad4br	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuaq005ymdgpxn0itswl	12084	2025-06-01 10:51:09.959	\N
cmbhqxm5k00tnmdgp7rzngo6f	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuaq005ymdgpxn0itswl	3995	2025-06-01 18:39:23.37	\N
cmbhqxm5k00tomdgpiqlmayjs	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuav0083mdgphir1eor8	6504	2025-06-01 07:57:41.875	\N
cmbhqxm5k00tpmdgp8iy8amwq	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuav0083mdgphir1eor8	2756	2025-06-01 09:53:59.857	\N
cmbhqxm5k00tqmdgpoqiab0ud	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuav0083mdgphir1eor8	8971	2025-06-02 02:46:49.444	\N
cmbhqxm5k00trmdgp57rxlbs5	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuap005fmdgp1yyiy3s4	4608	2025-06-01 19:54:02.354	\N
cmbhqxm5k00tsmdgp9nm4u5dw	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuap005fmdgp1yyiy3s4	7142	2025-06-01 14:09:26.558	\N
cmbhqxm5k00ttmdgpcvi0rv5p	cmbhqxm5k00tkmdgpzd03w3td	cmbhqvuap005fmdgp1yyiy3s4	2570	2025-06-01 10:46:07.701	\N
cmbhqxmg400twmdgpoe9rc97b	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuav0083mdgphir1eor8	3785	2025-06-01 14:13:15.505	\N
cmbhqxmg400txmdgp8widmcgu	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuat006zmdgpripqhodi	6569	2025-06-02 02:15:12.417	\N
cmbhqxmg400tymdgpi43k67ue	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuat006zmdgpripqhodi	4546	2025-06-02 04:26:59.35	\N
cmbhqxmg400tzmdgp5bz2k0hz	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuat006zmdgpripqhodi	13234	2025-06-02 03:43:46.635	\N
cmbhqxmg400u0mdgp5fp2ubv0	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuap005fmdgp1yyiy3s4	2879	2025-06-01 14:26:18.248	\N
cmbhqxmg400u1mdgp98x0fzxw	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuau007kmdgp5xx5do8d	6773	2025-06-01 09:02:00.389	\N
cmbhqxmg400u2mdgpzsmzzrh0	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuau007kmdgp5xx5do8d	12072	2025-06-02 04:35:15.96	\N
cmbhqxmg400u3mdgp1clnxc1u	cmbhqxmg400tvmdgpjyrd0fxt	cmbhqvuau007kmdgp5xx5do8d	669	2025-06-01 18:20:32.009	\N
cmbhqxmqs00u6mdgpsrb4hk1y	cmbhqxmqr00u5mdgplxki63pe	cmbhqvuau007kmdgp5xx5do8d	2562	2025-06-01 07:39:35.093	\N
cmbhqxmqs00u7mdgphz9suzqb	cmbhqxmqr00u5mdgplxki63pe	cmbhqvuau007kmdgp5xx5do8d	4720	2025-06-01 10:44:31.503	\N
cmbhqxn1k00uamdgpoodrh9xj	cmbhqxn1k00u9mdgp7sped734	cmbhqvuap005fmdgp1yyiy3s4	11576	2025-06-02 03:48:09.227	\N
cmbhqxn1k00ubmdgpfsau06gv	cmbhqxn1k00u9mdgp7sped734	cmbhqvuap005fmdgp1yyiy3s4	101	2025-06-01 23:11:33.986	\N
cmbhqxn1k00ucmdgp70l6posr	cmbhqxn1k00u9mdgp7sped734	cmbhqvuap005fmdgp1yyiy3s4	2787	2025-06-01 12:39:12.515	\N
cmbhqxn1k00udmdgpeeicby9r	cmbhqxn1k00u9mdgp7sped734	cmbhqvuaq005ymdgpxn0itswl	4709	2025-06-01 15:36:39.9	\N
cmbhqxn1k00uemdgp4sa67f8v	cmbhqxn1k00u9mdgp7sped734	cmbhqvuat006zmdgpripqhodi	9924	2025-06-01 07:55:06.546	\N
cmbhqxnc600uhmdgpn4tkvo6m	cmbhqxnc600ugmdgp4s4qm2da	cmbhqvuat006zmdgpripqhodi	7244	2025-06-01 10:48:11.522	\N
cmbhqxnml00ukmdgp9x7otoxz	cmbhqxnml00ujmdgpdv3v5d1u	cmbhqvuaq005ymdgpxn0itswl	1181	2025-06-01 06:57:07.478	\N
cmbhqxnml00ulmdgp0gsak93n	cmbhqxnml00ujmdgpdv3v5d1u	cmbhqvuaq005ymdgpxn0itswl	8104	2025-06-01 16:54:48.177	\N
cmbhqxnml00ummdgpcyedyr56	cmbhqxnml00ujmdgpdv3v5d1u	cmbhqvuaq005ymdgpxn0itswl	4925	2025-06-01 14:24:59.061	\N
cmbhqxnml00unmdgpehwc6j3n	cmbhqxnml00ujmdgpdv3v5d1u	cmbhqvuav0083mdgphir1eor8	3447	2025-06-02 04:02:01.357	\N
cmbhqxnml00uomdgp0a24q72i	cmbhqxnml00ujmdgpdv3v5d1u	cmbhqvuav0083mdgphir1eor8	12170	2025-06-01 16:56:35.74	\N
cmbhqxnml00upmdgpxe3j4q9t	cmbhqxnml00ujmdgpdv3v5d1u	cmbhqvuap005fmdgp1yyiy3s4	12253	2025-06-02 00:46:02.113	\N
cmbhqxnx600usmdgp2mtvea32	cmbhqxnx600urmdgp80qzqe3v	cmbhqvuau007kmdgp5xx5do8d	11737	2025-06-02 00:32:26.733	\N
cmbhqxoqe00uzmdgp9c5df8p8	cmbhqxoqe00uymdgps3wv4htd	cmbhqvuat006wmdgpy8kqdv86	8961	2025-05-31 20:54:14.757	\N
cmbhqxoqe00v0mdgpl19jzmu4	cmbhqxoqe00uymdgps3wv4htd	cmbhqvuat006wmdgpy8kqdv86	1205	2025-05-31 12:20:26.681	\N
cmbhqxoqe00v1mdgpa22d3p0y	cmbhqxoqe00uymdgps3wv4htd	cmbhqvuap005lmdgp8ipvmum8	6699	2025-05-31 20:05:20.934	\N
cmbhqxoqe00v2mdgpsh4a45zf	cmbhqxoqe00uymdgps3wv4htd	cmbhqvuap005lmdgp8ipvmum8	1726	2025-06-01 00:26:50.326	\N
cmbhqxoqe00v3mdgpeh2cvg60	cmbhqxoqe00uymdgps3wv4htd	cmbhqvuap005lmdgp8ipvmum8	49	2025-05-31 15:45:22.35	\N
cmbhqxoqe00v4mdgp15bpn2zx	cmbhqxoqe00uymdgps3wv4htd	cmbhqvuav0087mdgpblfe2ipd	4344	2025-05-31 10:37:10.32	\N
cmbhqxp1300v7mdgp2md25x2i	cmbhqxp1300v6mdgpnaavl200	cmbhqvuap005lmdgp8ipvmum8	8275	2025-06-01 04:46:59.979	\N
cmbhqxp1300v8mdgpimrzn2s6	cmbhqxp1300v6mdgpnaavl200	cmbhqvuap005lmdgp8ipvmum8	1626	2025-05-31 18:58:04.232	\N
cmbhqxp1300v9mdgpfwszo9jq	cmbhqxp1300v6mdgpnaavl200	cmbhqvuav0087mdgpblfe2ipd	4537	2025-06-01 02:40:16.521	\N
cmbhqxp1300vamdgpoyyfr0ds	cmbhqxp1300v6mdgpnaavl200	cmbhqvuav0087mdgpblfe2ipd	8512	2025-05-31 05:24:46.79	\N
cmbhqxp1300vbmdgpalm7pysq	cmbhqxp1300v6mdgpnaavl200	cmbhqvuat006wmdgpy8kqdv86	788	2025-05-31 16:34:17.38	\N
cmbhqxp1300vcmdgpwk72h7pt	cmbhqxp1300v6mdgpnaavl200	cmbhqvuat006wmdgpy8kqdv86	1773	2025-05-31 18:05:26.15	\N
cmbhqxpbq00vfmdgpx0d4xasl	cmbhqxpbq00vemdgpo38czoad	cmbhqvuat006wmdgpy8kqdv86	564	2025-05-31 09:56:57.046	\N
cmbhqxpbq00vgmdgpn95mhn3s	cmbhqxpbq00vemdgpo38czoad	cmbhqvuat006wmdgpy8kqdv86	7366	2025-05-31 16:43:58.182	\N
cmbhqxpbq00vhmdgpncmsel5d	cmbhqxpbq00vemdgpo38czoad	cmbhqvuat006wmdgpy8kqdv86	492	2025-05-31 15:48:38.582	\N
cmbhqxpbq00vimdgp5nxnnrw3	cmbhqxpbq00vemdgpo38czoad	cmbhqvuap005lmdgp8ipvmum8	5609	2025-05-31 18:18:54.171	\N
cmbhqxpbq00vjmdgpvsdqim6a	cmbhqxpbq00vemdgpo38czoad	cmbhqvuav0087mdgpblfe2ipd	2596	2025-05-31 20:14:03.848	\N
cmbhqxpbq00vkmdgpeej2rnpg	cmbhqxpbq00vemdgpo38czoad	cmbhqvuav0087mdgpblfe2ipd	3001	2025-05-31 08:54:00.718	\N
cmbhqxpmd00vnmdgps1kdqmxz	cmbhqxpmd00vmmdgp2itc5srp	cmbhqvuav0087mdgpblfe2ipd	8478	2025-05-31 17:42:25.617	\N
cmbhqxpwz00vqmdgpqmxcba6p	cmbhqxpwz00vpmdgpiairqzz3	cmbhqvuat006wmdgpy8kqdv86	1720	2025-05-31 13:01:01.495	\N
cmbhqxq7r00vtmdgp7j8aqlny	cmbhqxq7r00vsmdgpfechxepl	cmbhqvuav0087mdgpblfe2ipd	6927	2025-05-31 09:06:42.313	\N
cmbhqxq7r00vumdgpk141fu5p	cmbhqxq7r00vsmdgpfechxepl	cmbhqvuav0087mdgpblfe2ipd	6847	2025-05-31 16:58:32.391	\N
cmbhqxq7r00vvmdgpe1jyhv51	cmbhqxq7r00vsmdgpfechxepl	cmbhqvuav0087mdgpblfe2ipd	6089	2025-05-31 19:39:06.874	\N
cmbhqxq7r00vwmdgpm9c1fq0r	cmbhqxq7r00vsmdgpfechxepl	cmbhqvuat006wmdgpy8kqdv86	3253	2025-05-31 23:30:54.645	\N
cmbhqxq7r00vxmdgppv8nosnb	cmbhqxq7r00vsmdgpfechxepl	cmbhqvuat006wmdgpy8kqdv86	2974	2025-05-31 10:27:11.582	\N
cmbhqxq7r00vymdgp4ojt9hwz	cmbhqxq7r00vsmdgpfechxepl	cmbhqvuat006wmdgpy8kqdv86	708	2025-05-31 13:16:48.907	\N
cmbhqxq7r00vzmdgps62068yj	cmbhqxq7r00vsmdgpfechxepl	cmbhqvuap005lmdgp8ipvmum8	6929	2025-05-31 12:38:01.703	\N
cmbhqxqif00w2mdgp7bj6ji0o	cmbhqxqif00w1mdgpcqq4acww	cmbhqvuat006wmdgpy8kqdv86	2091	2025-05-31 09:35:56.689	\N
cmbhqxqif00w3mdgprs1gskbh	cmbhqxqif00w1mdgpcqq4acww	cmbhqvuat006wmdgpy8kqdv86	5916	2025-05-31 08:10:40.665	\N
cmbhqxqif00w4mdgpoegs4scz	cmbhqxqif00w1mdgpcqq4acww	cmbhqvuat006wmdgpy8kqdv86	3868	2025-05-31 18:32:59.024	\N
cmbhqxqif00w5mdgp1a7flptp	cmbhqxqif00w1mdgpcqq4acww	cmbhqvuav0087mdgpblfe2ipd	2523	2025-06-01 00:38:56.889	\N
cmbhqxqif00w6mdgpjahfydjn	cmbhqxqif00w1mdgpcqq4acww	cmbhqvuap005lmdgp8ipvmum8	8834	2025-05-31 17:36:58.606	\N
cmbhqxqsz00w9mdgp3yhvl24s	cmbhqxqsy00w8mdgpn0ruxzl1	cmbhqvuat006wmdgpy8kqdv86	1250	2025-06-01 02:19:33.281	\N
cmbhqxqsz00wamdgp8ehehjqj	cmbhqxqsy00w8mdgpn0ruxzl1	cmbhqvuav0087mdgpblfe2ipd	1255	2025-05-31 12:41:11.487	\N
cmbhqxqsz00wbmdgp7an2vuwz	cmbhqxqsy00w8mdgpn0ruxzl1	cmbhqvuap005lmdgp8ipvmum8	1190	2025-05-31 06:52:17.783	\N
cmbhqxqsz00wcmdgpigghwd36	cmbhqxqsy00w8mdgpn0ruxzl1	cmbhqvuap005lmdgp8ipvmum8	7380	2025-05-31 23:13:48.496	\N
cmbhqxr3o00wfmdgp29ktag9p	cmbhqxr3n00wemdgpgmzyyefa	cmbhqvuat006wmdgpy8kqdv86	6507	2025-05-31 10:09:20.469	\N
cmbhqxr3o00wgmdgprmiw5mty	cmbhqxr3n00wemdgpgmzyyefa	cmbhqvuav0087mdgpblfe2ipd	4306	2025-06-01 03:53:13.538	\N
cmbhqxr3o00whmdgp64f9znic	cmbhqxr3n00wemdgpgmzyyefa	cmbhqvuav0087mdgpblfe2ipd	1047	2025-05-31 13:16:11.536	\N
cmbhqxr3o00wimdgpakm31gng	cmbhqxr3n00wemdgpgmzyyefa	cmbhqvuav0087mdgpblfe2ipd	1439	2025-05-31 05:57:57.974	\N
cmbhqxred00wlmdgp47i71p3q	cmbhqxred00wkmdgpp0tsd4a2	cmbhqvuav0087mdgpblfe2ipd	8080	2025-05-31 12:23:40.268	\N
cmbhqxred00wmmdgpdbz3yo1o	cmbhqxred00wkmdgpp0tsd4a2	cmbhqvuav0087mdgpblfe2ipd	5837	2025-05-31 23:22:22.388	\N
cmbhqxred00wnmdgpcmeqhfmy	cmbhqxred00wkmdgpp0tsd4a2	cmbhqvuav0087mdgpblfe2ipd	1399	2025-05-31 13:10:51.307	\N
cmbhqxs7h00wumdgp9yacyzcd	cmbhqxs7g00wtmdgpe5udrrge	cmbhqvuav007ymdgp7c2zo1wo	3701	2025-05-30 11:07:01.455	\N
cmbhqxs7h00wvmdgp5hq0p7n1	cmbhqxs7g00wtmdgpe5udrrge	cmbhqvuav007ymdgp7c2zo1wo	6934	2025-05-30 18:08:29.531	\N
cmbhqxs7h00wwmdgpfpe1dyst	cmbhqxs7g00wtmdgpe5udrrge	cmbhqvuav007ymdgp7c2zo1wo	8296	2025-05-30 16:03:46.326	\N
cmbhqxsia00wzmdgp88fzt2m0	cmbhqxsia00wymdgpq9wmeaa3	cmbhqvuaw008hmdgpqez5owny	9878	2025-05-30 08:04:01.727	\N
cmbhqxsia00x0mdgpnyfgx255	cmbhqxsia00wymdgpq9wmeaa3	cmbhqvuaw008hmdgpqez5owny	8710	2025-05-31 03:26:17.833	\N
cmbhqxsia00x1mdgpqu7n74wr	cmbhqxsia00wymdgpq9wmeaa3	cmbhqvuav007ymdgp7c2zo1wo	7587	2025-05-30 17:24:25.155	\N
cmbhqxsud00x4mdgpwk6qjhja	cmbhqxsud00x3mdgp1vv69pmg	cmbhqvuaw008hmdgpqez5owny	1011	2025-05-30 15:08:10.811	\N
cmbhqxsud00x5mdgpt6unliei	cmbhqxsud00x3mdgp1vv69pmg	cmbhqvuaw008hmdgpqez5owny	8553	2025-05-30 13:52:11.385	\N
cmbhqxsud00x6mdgp3hr2pm47	cmbhqxsud00x3mdgp1vv69pmg	cmbhqvuaw008hmdgpqez5owny	2134	2025-05-30 10:20:16.628	\N
cmbhqxsud00x7mdgpqn3iz3sw	cmbhqxsud00x3mdgp1vv69pmg	cmbhqvuav007ymdgp7c2zo1wo	3594	2025-05-31 01:06:44.341	\N
cmbhqxsud00x8mdgpmffk7tb5	cmbhqxsud00x3mdgp1vv69pmg	cmbhqvuav007ymdgp7c2zo1wo	1213	2025-05-30 15:56:41.345	\N
cmbhqxsud00x9mdgpmxtm856t	cmbhqxsud00x3mdgp1vv69pmg	cmbhqvuav007ymdgp7c2zo1wo	8498	2025-05-31 01:46:10.428	\N
cmbhqxt5200xcmdgp7cr4mofj	cmbhqxt5100xbmdgpmdbqccb7	cmbhqvuav007ymdgp7c2zo1wo	9464	2025-05-30 18:17:52.958	\N
cmbhqxtfw00xfmdgpy0lekelg	cmbhqxtfw00xemdgp5wkgghbo	cmbhqvuav007ymdgp7c2zo1wo	142	2025-05-30 09:11:16.179	\N
cmbhqxtfw00xgmdgpf2vwj8d4	cmbhqxtfw00xemdgp5wkgghbo	cmbhqvuav007ymdgp7c2zo1wo	9957	2025-05-30 21:31:48.177	\N
cmbhqxtfw00xhmdgp08dkvekf	cmbhqxtfw00xemdgp5wkgghbo	cmbhqvuav007ymdgp7c2zo1wo	3414	2025-05-30 23:54:17.511	\N
cmbhqxtqc00xkmdgp0awj64m7	cmbhqxtqb00xjmdgpkn70xcdl	cmbhqvuaw008hmdgpqez5owny	6216	2025-05-31 04:18:13.707	\N
cmbhqxtqc00xlmdgpw35v00mh	cmbhqxtqb00xjmdgpkn70xcdl	cmbhqvuav007ymdgp7c2zo1wo	2398	2025-05-30 09:29:47.673	\N
cmbhqxtqc00xmmdgplae6ndf1	cmbhqxtqb00xjmdgpkn70xcdl	cmbhqvuav007ymdgp7c2zo1wo	9045	2025-05-30 21:50:18.999	\N
cmbhqxtqc00xnmdgp695cu321	cmbhqxtqb00xjmdgpkn70xcdl	cmbhqvuav007ymdgp7c2zo1wo	200	2025-05-30 21:13:14.612	\N
cmbhqxu1000xqmdgpqd4gxwt6	cmbhqxu0z00xpmdgp36d3s9dg	cmbhqvuav007ymdgp7c2zo1wo	8597	2025-05-30 06:28:02.306	\N
cmbhqxu1000xrmdgp2afbzb7h	cmbhqxu0z00xpmdgp36d3s9dg	cmbhqvuav007ymdgp7c2zo1wo	8617	2025-05-30 10:41:29.334	\N
cmbhqxu1000xsmdgpf5327f9x	cmbhqxu0z00xpmdgp36d3s9dg	cmbhqvuav007ymdgp7c2zo1wo	7601	2025-05-30 08:20:01.907	\N
cmbhqxu1000xtmdgpw60juh5x	cmbhqxu0z00xpmdgp36d3s9dg	cmbhqvuaw008hmdgpqez5owny	9285	2025-05-30 09:24:26.703	\N
cmbhqxu1000xumdgpikk6lfr9	cmbhqxu0z00xpmdgp36d3s9dg	cmbhqvuaw008hmdgpqez5owny	4658	2025-05-31 01:28:26.253	\N
cmbhqxu1000xvmdgpidladcmu	cmbhqxu0z00xpmdgp36d3s9dg	cmbhqvuaw008hmdgpqez5owny	6941	2025-05-30 10:34:34.166	\N
cmbhqxubw00xymdgp44qkzwt0	cmbhqxubw00xxmdgp5hvcou87	cmbhqvuaw008hmdgpqez5owny	2813	2025-05-31 03:12:50.68	\N
cmbhqxubw00xzmdgpb7e1say7	cmbhqxubw00xxmdgp5hvcou87	cmbhqvuaw008hmdgpqez5owny	10171	2025-05-30 05:41:26.976	\N
cmbhqxubw00y0mdgpn4yiykt8	cmbhqxubw00xxmdgp5hvcou87	cmbhqvuaw008hmdgpqez5owny	3496	2025-05-30 13:42:24.5	\N
cmbhqxubw00y1mdgp6ek88np9	cmbhqxubw00xxmdgp5hvcou87	cmbhqvuav007ymdgp7c2zo1wo	4518	2025-05-30 10:47:34.057	\N
cmbhqxubw00y2mdgp5azwyjyn	cmbhqxubw00xxmdgp5hvcou87	cmbhqvuav007ymdgp7c2zo1wo	10016	2025-05-30 18:50:50.476	\N
cmbhqxubw00y3mdgpu3vevshs	cmbhqxubw00xxmdgp5hvcou87	cmbhqvuav007ymdgp7c2zo1wo	5122	2025-05-30 11:22:42.182	\N
cmbhqxv5400yamdgpgew5qtfi	cmbhqxv5300y9mdgpr2icr2lc	cmbhqvuau007gmdgpgbqt50kr	5182	2025-05-29 19:44:11.643	\N
cmbhqxv5400ybmdgprnum2n59	cmbhqxv5300y9mdgpr2icr2lc	cmbhqvuau007gmdgpgbqt50kr	1315	2025-05-29 21:06:30.177	\N
cmbhqxv5400ycmdgpcorcaq3l	cmbhqxv5300y9mdgpr2icr2lc	cmbhqvuau007gmdgpgbqt50kr	4922	2025-05-29 08:44:02.135	\N
cmbhqxv5400ydmdgpcwouusnp	cmbhqxv5300y9mdgpr2icr2lc	cmbhqvuau007mmdgpzy8flpsf	13288	2025-05-29 20:37:47.416	\N
cmbhqxv5400yemdgp5beizze3	cmbhqxv5300y9mdgpr2icr2lc	cmbhqvuau007mmdgpzy8flpsf	1251	2025-05-30 02:48:59.74	\N
cmbhqxv5400yfmdgp9y059agp	cmbhqxv5300y9mdgpr2icr2lc	cmbhqvuau007mmdgpzy8flpsf	1903	2025-05-29 06:02:50.796	\N
cmbhqxvfs00yimdgpx212bnd7	cmbhqxvfs00yhmdgppl9sdr0c	cmbhqvuav0085mdgpf3tdt73d	7412	2025-05-29 11:02:08.13	\N
cmbhqxvfs00yjmdgpch3on8mv	cmbhqxvfs00yhmdgppl9sdr0c	cmbhqvuav0085mdgpf3tdt73d	3602	2025-05-29 11:26:42.168	\N
cmbhqxvfs00ykmdgpxuswbx40	cmbhqxvfs00yhmdgppl9sdr0c	cmbhqvuau007gmdgpgbqt50kr	4624	2025-05-29 05:20:11.086	\N
cmbhqxvfs00ylmdgpybqgx5rf	cmbhqxvfs00yhmdgppl9sdr0c	cmbhqvuau007mmdgpzy8flpsf	7476	2025-05-29 09:34:04.596	\N
cmbhqxvfs00ymmdgpbp4804n7	cmbhqxvfs00yhmdgppl9sdr0c	cmbhqvuau007mmdgpzy8flpsf	8407	2025-05-29 12:54:56.742	\N
cmbhqxvfs00ynmdgp8cfj4crh	cmbhqxvfs00yhmdgppl9sdr0c	cmbhqvuau007mmdgpzy8flpsf	3224	2025-05-29 12:27:30.195	\N
cmbhqxvqb00yqmdgpjf6ui6d6	cmbhqxvqb00ypmdgp73l74pno	cmbhqvuau007gmdgpgbqt50kr	11375	2025-05-29 09:58:44.462	\N
cmbhqxvqb00yrmdgpe1i6n3el	cmbhqxvqb00ypmdgp73l74pno	cmbhqvuau007gmdgpgbqt50kr	10408	2025-05-29 17:15:28.462	\N
cmbhqxvqb00ysmdgps4ga1wdo	cmbhqxvqb00ypmdgp73l74pno	cmbhqvuau007gmdgpgbqt50kr	5634	2025-05-29 08:17:37.949	\N
cmbhqxvqb00ytmdgpzmx4e6tq	cmbhqxvqb00ypmdgp73l74pno	cmbhqvuav0085mdgpf3tdt73d	12583	2025-05-29 18:10:16.978	\N
cmbhqxw1400ywmdgpcvjw1i1t	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuaq0063mdgp7ueu9zuf	8587	2025-05-29 21:30:59.147	\N
cmbhqxw1400yxmdgpgfc495qs	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuaq0063mdgp7ueu9zuf	7802	2025-05-29 07:55:25.713	\N
cmbhqxw1400yymdgpimni1y1q	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuaq0063mdgp7ueu9zuf	8592	2025-05-29 20:46:59.764	\N
cmbhqxw1400yzmdgpltkq48z6	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuau007gmdgpgbqt50kr	10587	2025-05-30 02:44:57.595	\N
cmbhqxw1400z0mdgpjbdxo30d	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuau007gmdgpgbqt50kr	3385	2025-05-29 19:47:32.065	\N
cmbhqxw1400z1mdgpta239508	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuau007gmdgpgbqt50kr	8198	2025-05-30 03:36:53.782	\N
cmbhqxw1400z2mdgp0d8z8exn	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuau007mmdgpzy8flpsf	497	2025-05-30 04:46:02.911	\N
cmbhqxw1400z3mdgpn4nkdc3b	cmbhqxw1300yvmdgpclwmjmvy	cmbhqvuau007mmdgpzy8flpsf	6119	2025-05-29 11:17:36.039	\N
cmbhqxwue00zamdgputqucnyt	cmbhqxwue00z9mdgp3c6yu9y4	cmbhqvuat006zmdgpripqhodi	1750	2025-05-28 18:59:50.967	\N
cmbhqxwue00zbmdgp0ra7zgei	cmbhqxwue00z9mdgp3c6yu9y4	cmbhqvuaw008dmdgp2c6uayfe	6122	2025-05-28 18:14:07.433	\N
cmbhqxwue00zcmdgpd6fousve	cmbhqxwue00z9mdgp3c6yu9y4	cmbhqvuaw008dmdgp2c6uayfe	9268	2025-05-28 17:19:09.717	\N
cmbhqxwue00zdmdgpwtm6vypn	cmbhqxwue00z9mdgp3c6yu9y4	cmbhqvuas006jmdgp7czbz5u5	342	2025-05-28 23:45:26.476	\N
cmbhqxwue00zemdgphi2cyyng	cmbhqxwue00z9mdgp3c6yu9y4	cmbhqvuaq005qmdgpmna46zzs	1003	2025-05-28 18:01:55.437	\N
cmbhqxwue00zfmdgprrtp2od5	cmbhqxwue00z9mdgp3c6yu9y4	cmbhqvuaq005qmdgpmna46zzs	397	2025-05-28 08:10:00.604	\N
cmbhqxx5500zimdgpcwn0ctog	cmbhqxx5500zhmdgpbike3u33	cmbhqvuaw008dmdgp2c6uayfe	9086	2025-05-28 14:22:23.839	\N
cmbhqxx5500zjmdgpn57w3zf2	cmbhqxx5500zhmdgpbike3u33	cmbhqvuaw008dmdgp2c6uayfe	9589	2025-05-28 07:58:06.735	\N
cmbhqxx5500zkmdgp1oml4mfq	cmbhqxx5500zhmdgpbike3u33	cmbhqvuat006zmdgpripqhodi	8769	2025-05-28 18:14:08.555	\N
cmbhqxx5500zlmdgpmm941tup	cmbhqxx5500zhmdgpbike3u33	cmbhqvuas006jmdgp7czbz5u5	4293	2025-05-28 06:20:50.262	\N
cmbhqxx5500zmmdgpzcb48klz	cmbhqxx5500zhmdgpbike3u33	cmbhqvuas006jmdgp7czbz5u5	3803	2025-05-28 19:10:50.607	\N
cmbhqxx5500znmdgpen6pwlf9	cmbhqxx5500zhmdgpbike3u33	cmbhqvuav0083mdgphir1eor8	465	2025-05-28 11:23:23.921	\N
cmbhqxx5500zomdgpfv2pu1wl	cmbhqxx5500zhmdgpbike3u33	cmbhqvuaq005qmdgpmna46zzs	6491	2025-05-28 17:09:09.223	\N
cmbhqxxfq00zrmdgpshldtgcb	cmbhqxxfq00zqmdgpnt0hltvx	cmbhqvuaq005qmdgpmna46zzs	8446	2025-05-28 19:16:01.41	\N
cmbhqxxfq00zsmdgpet8ma7px	cmbhqxxfq00zqmdgpnt0hltvx	cmbhqvuaq005qmdgpmna46zzs	876	2025-05-28 13:41:11.181	\N
cmbhqxxfq00ztmdgph1bobr17	cmbhqxxfq00zqmdgpnt0hltvx	cmbhqvuaq005qmdgpmna46zzs	1647	2025-05-28 13:22:13.531	\N
cmbhqxxfq00zumdgp8sz40ovm	cmbhqxxfq00zqmdgpnt0hltvx	cmbhqvuav0083mdgphir1eor8	2516	2025-05-29 01:01:35.218	\N
cmbhqxxfq00zvmdgpe5chjzuf	cmbhqxxfq00zqmdgpnt0hltvx	cmbhqvuav0083mdgphir1eor8	4596	2025-05-28 23:59:07.553	\N
cmbhqxxfq00zwmdgp9wfh29gp	cmbhqxxfq00zqmdgpnt0hltvx	cmbhqvuat006zmdgpripqhodi	4576	2025-05-28 11:16:08.297	\N
cmbhqxxq800zzmdgp5exdfdfp	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuas006jmdgp7czbz5u5	306	2025-05-28 11:43:30.633	\N
cmbhqxxq80100mdgp7pk58hc9	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuaw008dmdgp2c6uayfe	6281	2025-05-28 09:17:54.996	\N
cmbhqxxq80101mdgp2nbfqr35	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuav0083mdgphir1eor8	2122	2025-05-28 08:46:03.078	\N
cmbhqxxq80102mdgpnciluwit	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuav0083mdgphir1eor8	9631	2025-05-28 17:23:35.345	\N
cmbhqxxq80103mdgpaiwci37h	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuaq005qmdgpmna46zzs	9406	2025-05-28 10:17:43.824	\N
cmbhqxxq80104mdgp0fbm8qkm	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuaq005qmdgpmna46zzs	6339	2025-05-28 22:34:12.471	\N
cmbhqxxq80105mdgppr8vj5vw	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuat006zmdgpripqhodi	2366	2025-05-28 14:35:51.301	\N
cmbhqxxq80106mdgpt74no5xs	cmbhqxxq800zymdgprm4n9h5f	cmbhqvuat006zmdgpripqhodi	199	2025-05-28 08:31:10.942	\N
cmbhqxy150109mdgpkm8w5anf	cmbhqxy150108mdgpqz4fy2js	cmbhqvuaq005qmdgpmna46zzs	2845	2025-05-28 19:12:35.626	\N
cmbhqxy15010amdgphjps3fpl	cmbhqxy150108mdgpqz4fy2js	cmbhqvuaq005qmdgpmna46zzs	1455	2025-05-28 11:44:55.719	\N
cmbhqxy15010bmdgpgctlnztl	cmbhqxy150108mdgpqz4fy2js	cmbhqvuav0083mdgphir1eor8	1704	2025-05-28 18:02:57.263	\N
cmbhqxy15010cmdgpcuuz5fzg	cmbhqxy150108mdgpqz4fy2js	cmbhqvuav0083mdgphir1eor8	2685	2025-05-28 22:51:38.852	\N
cmbhqxy15010dmdgpc41it9f0	cmbhqxy150108mdgpqz4fy2js	cmbhqvuav0083mdgphir1eor8	7827	2025-05-28 23:37:54.731	\N
cmbhqxy15010emdgpisqx08fh	cmbhqxy150108mdgpqz4fy2js	cmbhqvuaw008dmdgp2c6uayfe	7930	2025-05-28 08:13:18.837	\N
cmbhqxy15010fmdgputmnyy1s	cmbhqxy150108mdgpqz4fy2js	cmbhqvuaw008dmdgp2c6uayfe	7561	2025-05-28 21:37:23.545	\N
cmbhqxy15010gmdgp53qwvl6j	cmbhqxy150108mdgpqz4fy2js	cmbhqvuat006zmdgpripqhodi	704	2025-05-28 12:06:11.174	\N
cmbhqxy15010hmdgpcrtl876f	cmbhqxy150108mdgpqz4fy2js	cmbhqvuat006zmdgpripqhodi	600	2025-05-28 10:46:43.168	\N
cmbhqxy15010imdgp9xoon951	cmbhqxy150108mdgpqz4fy2js	cmbhqvuat006zmdgpripqhodi	9284	2025-05-28 14:27:20.674	\N
cmbhqxybr010lmdgp95h5138d	cmbhqxybr010kmdgp9iwqtvys	cmbhqvuav0083mdgphir1eor8	7203	2025-05-28 11:33:01.908	\N
cmbhqxybr010mmdgpzb33hkis	cmbhqxybr010kmdgp9iwqtvys	cmbhqvuav0083mdgphir1eor8	44	2025-05-29 00:57:42.28	\N
cmbhqxybr010nmdgpd1o28p0c	cmbhqxybr010kmdgp9iwqtvys	cmbhqvuaw008dmdgp2c6uayfe	8242	2025-05-29 01:33:15.761	\N
cmbhqxybr010omdgpdhd6iidj	cmbhqxybr010kmdgp9iwqtvys	cmbhqvuaw008dmdgp2c6uayfe	5192	2025-05-28 19:31:48.409	\N
cmbhqxybr010pmdgpej5qb54w	cmbhqxybr010kmdgp9iwqtvys	cmbhqvuaw008dmdgp2c6uayfe	2492	2025-05-29 00:08:54.884	\N
cmbhqxymi010smdgpx5z5zdkz	cmbhqxymi010rmdgpeukb9qni	cmbhqvuat006zmdgpripqhodi	4939	2025-05-28 15:19:20.178	\N
cmbhqxymi010tmdgptrrrr5xt	cmbhqxymi010rmdgpeukb9qni	cmbhqvuat006zmdgpripqhodi	6448	2025-05-28 13:48:29.286	\N
cmbhqxymi010umdgptulihsjm	cmbhqxymi010rmdgpeukb9qni	cmbhqvuat006zmdgpripqhodi	4367	2025-05-28 14:51:58.162	\N
cmbhqxyx5010xmdgpdxgt0anq	cmbhqxyx4010wmdgprspq4jnn	cmbhqvuaw008dmdgp2c6uayfe	1285	2025-05-28 11:26:42.064	\N
cmbhqxyx5010ymdgpdnxl7006	cmbhqxyx4010wmdgprspq4jnn	cmbhqvuaw008dmdgp2c6uayfe	6624	2025-05-28 09:36:17.529	\N
cmbhqxyx5010zmdgpn3evkspm	cmbhqxyx4010wmdgprspq4jnn	cmbhqvuaw008dmdgp2c6uayfe	8390	2025-05-28 22:03:32.197	\N
cmbhqxyx50110mdgptokie60v	cmbhqxyx4010wmdgprspq4jnn	cmbhqvuav0083mdgphir1eor8	4908	2025-05-28 19:49:50.345	\N
cmbhqxyx50111mdgp3jxvr5il	cmbhqxyx4010wmdgprspq4jnn	cmbhqvuav0083mdgphir1eor8	900	2025-05-28 10:06:31.432	\N
cmbhqxyx50112mdgps5znmipa	cmbhqxyx4010wmdgprspq4jnn	cmbhqvuav0083mdgphir1eor8	2679	2025-05-28 08:38:13.184	\N
cmbhqxz7x0115mdgpx9gwzusk	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuaw008dmdgp2c6uayfe	9428	2025-05-28 13:20:35.312	\N
cmbhqxz7x0116mdgpwinth0ie	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuaw008dmdgp2c6uayfe	2071	2025-05-28 17:18:28.365	\N
cmbhqxz7x0117mdgps7991g5c	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuat006zmdgpripqhodi	4545	2025-05-28 23:54:55.935	\N
cmbhqxz7x0118mdgpve3z2kvk	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuat006zmdgpripqhodi	7088	2025-05-29 04:23:17.519	\N
cmbhqxz7x0119mdgpv262cf8t	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuas006jmdgp7czbz5u5	9613	2025-05-28 23:54:51.219	\N
cmbhqxz7x011amdgp2d5fmbij	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuas006jmdgp7czbz5u5	2154	2025-05-28 20:24:15.09	\N
cmbhqxz7x011bmdgp5k9aohme	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuas006jmdgp7czbz5u5	4633	2025-05-28 05:23:14.222	\N
cmbhqxz7x011cmdgpvtmqpjon	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuav0083mdgphir1eor8	594	2025-05-29 04:12:51.035	\N
cmbhqxz7x011dmdgp8xr9axwe	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuav0083mdgphir1eor8	7011	2025-05-29 03:28:49.232	\N
cmbhqxz7x011emdgpy73r5bsr	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuav0083mdgphir1eor8	8999	2025-05-28 19:26:17.109	\N
cmbhqxz7x011fmdgpibudo981	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuaq005qmdgpmna46zzs	7031	2025-05-29 02:01:07.471	\N
cmbhqxz7x011gmdgpvusncb2q	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuaq005qmdgpmna46zzs	8597	2025-05-28 06:43:57.192	\N
cmbhqxz7x011hmdgp1a459ym4	cmbhqxz7x0114mdgpb2ajj9ft	cmbhqvuaq005qmdgpmna46zzs	8896	2025-05-28 22:17:44.837	\N
cmbhqy01e011omdgp7kd6tkta	cmbhqy01e011nmdgp213jr8gs	cmbhqvuat0075mdgpkkp4yfjq	2743	2025-06-04 08:36:45.896	\N
cmbhqy01e011pmdgp6rn4n08b	cmbhqy01e011nmdgp213jr8gs	cmbhqvuat0075mdgpkkp4yfjq	7335	2025-06-04 08:48:02.136	\N
cmbhqy01e011qmdgpqeihimoh	cmbhqy01e011nmdgp213jr8gs	cmbhqvuat0075mdgpkkp4yfjq	2185	2025-06-04 08:58:59.544	\N
cmbhqy0c0011tmdgpcr31tigm	cmbhqy0c0011smdgpufckyz5t	cmbhqvuat0075mdgpkkp4yfjq	8588	2025-06-04 07:57:13.898	\N
cmbhqy0c0011umdgpvhnokn20	cmbhqy0c0011smdgpufckyz5t	cmbhqvuat0075mdgpkkp4yfjq	5327	2025-06-04 08:40:33.283	\N
cmbhqy0c0011vmdgpss3b2uw4	cmbhqy0c0011smdgpufckyz5t	cmbhqvuat0075mdgpkkp4yfjq	2235	2025-06-04 08:01:39.409	\N
cmbhqy0mz011ymdgp5ibaatup	cmbhqy0mz011xmdgpe0pyh5n4	cmbhqvuat0075mdgpkkp4yfjq	4562	2025-06-04 08:07:48.279	\N
cmbhqy0mz011zmdgp5yonsuah	cmbhqy0mz011xmdgpe0pyh5n4	cmbhqvuat0075mdgpkkp4yfjq	1718	2025-06-04 08:38:58.455	\N
cmbhqy0mz0120mdgp16msmlz0	cmbhqy0mz011xmdgpe0pyh5n4	cmbhqvuat0075mdgpkkp4yfjq	8417	2025-06-04 07:26:39.344	\N
cmbhqy0xn0123mdgp8cmdxs1y	cmbhqy0xn0122mdgpmjfon1rv	cmbhqvuat0075mdgpkkp4yfjq	7583	2025-06-04 09:15:27.562	\N
cmbhqy1870126mdgprvnf12z7	cmbhqy1870125mdgpgncm4i6i	cmbhqvuat0075mdgpkkp4yfjq	4070	2025-06-04 07:50:21.66	\N
cmbhqy1870127mdgp92nh2teh	cmbhqy1870125mdgpgncm4i6i	cmbhqvuat0075mdgpkkp4yfjq	4350	2025-06-04 08:19:26.793	\N
cmbhqy2k1012imdgpfiw1925f	cmbhqy2k1012hmdgp584w89f0	cmbhqvuaw008dmdgp2c6uayfe	33150	2025-05-29 22:24:41.968	\N
cmbhqy2k1012jmdgp07mg3q42	cmbhqy2k1012hmdgp584w89f0	cmbhqvuaw008dmdgp2c6uayfe	39511	2025-05-26 23:52:22.366	\N
cmbhqy3d4012qmdgp50qzck5f	cmbhqy3d4012pmdgpdzjp3jlg	cmbhqvuav0086mdgp3vb68p2b	67662	2025-06-04 07:49:55.409	\N
cmbhqy3d4012rmdgp9pa6q01y	cmbhqy3d4012pmdgpdzjp3jlg	cmbhqvuav0086mdgp3vb68p2b	80049	2025-06-02 14:49:54.813	\N
cmbhqy3d4012smdgpz9sy5eno	cmbhqy3d4012pmdgpdzjp3jlg	cmbhqvuav0086mdgp3vb68p2b	27148	2025-06-04 06:37:28.229	\N
cmbhqy4qc0133mdgp291wc509	cmbhqy4qc0132mdgppvx812w9	cmbhqvuap005jmdgphx4hsyq0	126	2025-06-01 04:10:57.849	\N
cmbhqy4qc0134mdgp1e3p1ppw	cmbhqy4qc0132mdgppvx812w9	cmbhqvuap005jmdgphx4hsyq0	16484	2025-06-01 06:45:20.2	\N
cmbhqy4qc0135mdgposijb4xo	cmbhqy4qc0132mdgppvx812w9	cmbhqvuau007hmdgpllwga1qv	8844	2025-05-31 14:07:32.435	\N
cmbhqy4qc0136mdgph5zzcd7c	cmbhqy4qc0132mdgppvx812w9	cmbhqvuau007hmdgpllwga1qv	3848	2025-05-31 14:51:57.376	\N
cmbhqy4qc0137mdgpigtjfmex	cmbhqy4qc0132mdgppvx812w9	cmbhqvuau007hmdgpllwga1qv	10967	2025-06-01 14:35:37.073	\N
cmbhqy4qc0138mdgpyk7fr16k	cmbhqy4qc0132mdgppvx812w9	cmbhqvuaq005omdgpuostmskk	581	2025-06-01 10:08:27.289	\N
cmbhqy4qc0139mdgplrdyga92	cmbhqy4qc0132mdgppvx812w9	cmbhqvuaq005omdgpuostmskk	3924	2025-05-31 07:27:41.925	\N
cmbhqy4qc013amdgpk4hswqnw	cmbhqy4qc0132mdgppvx812w9	cmbhqvuaq005omdgpuostmskk	3026	2025-05-31 21:18:45.645	\N
cmbhqy4qc013bmdgpjvaypib2	cmbhqy4qc0132mdgppvx812w9	cmbhqvuat006wmdgpy8kqdv86	13608	2025-05-31 07:19:42.705	\N
cmbhqy4qc013cmdgp8wuw7m35	cmbhqy4qc0132mdgppvx812w9	cmbhqvuav007vmdgpfmxu6jy0	11415	2025-05-31 00:32:19.326	\N
cmbhqy50z013fmdgp1kysabjr	cmbhqy50z013emdgp6m0y96kz	cmbhqvuaq005omdgpuostmskk	6648	2025-06-01 07:25:30.713	\N
cmbhqy50z013gmdgp89es5a9h	cmbhqy50z013emdgp6m0y96kz	cmbhqvuaq005omdgpuostmskk	11218	2025-06-02 03:08:45.538	\N
cmbhqy50z013hmdgp6dwyv2z4	cmbhqy50z013emdgp6m0y96kz	cmbhqvuap005jmdgphx4hsyq0	2831	2025-05-31 20:50:05.516	\N
cmbhqy50z013imdgp9b96nh77	cmbhqy50z013emdgp6m0y96kz	cmbhqvuap005jmdgphx4hsyq0	7955	2025-05-31 05:51:53.949	\N
cmbhqy50z013jmdgp8rnuozhi	cmbhqy50z013emdgp6m0y96kz	cmbhqvuat006wmdgpy8kqdv86	15861	2025-05-31 20:27:28.649	\N
cmbhqy50z013kmdgp3xnk7ufe	cmbhqy50z013emdgp6m0y96kz	cmbhqvuat006wmdgpy8kqdv86	7275	2025-05-31 10:52:35.27	\N
cmbhqy50z013lmdgpbtb0texj	cmbhqy50z013emdgp6m0y96kz	cmbhqvuat006wmdgpy8kqdv86	14633	2025-06-01 14:59:17.189	\N
cmbhqy50z013mmdgppfyeezza	cmbhqy50z013emdgp6m0y96kz	cmbhqvuau007hmdgpllwga1qv	8685	2025-05-31 15:59:49.049	\N
cmbhqy50z013nmdgpgcdqe8p7	cmbhqy50z013emdgp6m0y96kz	cmbhqvuav007vmdgpfmxu6jy0	9167	2025-06-01 21:41:53.855	\N
cmbhqy50z013omdgp13xsipz1	cmbhqy50z013emdgp6m0y96kz	cmbhqvuav007vmdgpfmxu6jy0	7561	2025-05-31 17:34:51.794	\N



--
-- TOC entry 4372 (class 0 OID 29854)
-- Dependencies: 347
-- Data for Name: TournamentParticipant; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TournamentParticipant" (id, "tournamentId", "userId", score, rank, "joinedAt") FROM stdin;
cmbhqxh7l00qmmdgp8cs7f0w6	cmbhqxgnn00qhmdgpzbjdv4ci	383d5111-8bfb-4862-a1ff-0e47d251c542	19062	\N	2025-06-03 20:40:41.456
cmbhqxhia00qrmdgphneum08g	cmbhqxgnn00qhmdgpzbjdv4ci	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	49056	\N	2025-06-03 08:59:39.818
cmbhqxhsx00r3mdgp4rx23zcc	cmbhqxgnn00qhmdgpzbjdv4ci	65c3736c-5514-4c4f-9f57-2c11d3863657	54070	\N	2025-06-03 12:51:37.651
cmbhqxi3t00rdmdgpanuvpr17	cmbhqxgnn00qhmdgpzbjdv4ci	78ca58fd-7e97-470d-864d-1b995208b2e6	12265	\N	2025-06-03 15:43:09.742
cmbhqxif900rimdgpdkqk9pjy	cmbhqxgnn00qhmdgpzbjdv4ci	e4489c4c-93ee-4220-873a-0568c7e65322	7508	\N	2025-06-03 05:43:02.335
cmbhqxiqg00rnmdgpqydn88s4	cmbhqxgnn00qhmdgpzbjdv4ci	77a5e0cd-6bd4-4803-8328-a984b687acc4	61595	\N	2025-06-03 09:49:28.334
cmbhqxjk600s4mdgpir0u4pec	cmbhqxj1e00rzmdgpezwto4qv	977422d6-241d-4aa4-8c6d-080a97737d11	23513	\N	2025-06-02 05:00:27.28
cmbhqxjux00sbmdgpg24igucj	cmbhqxj1e00rzmdgpezwto4qv	383d5111-8bfb-4862-a1ff-0e47d251c542	12792	\N	2025-06-03 02:51:31.468
cmbhqxk5h00sfmdgp2uzmnvy2	cmbhqxj1e00rzmdgpezwto4qv	93c893af-8756-474e-934e-b08fad0a78fc	6433	\N	2025-06-02 23:00:10.247
cmbhqxkfu00sjmdgpv3fwao4p	cmbhqxj1e00rzmdgpezwto4qv	7851298a-157c-4e0a-9163-b97f4c8c8535	33811	\N	2025-06-02 18:18:47.499
cmbhqxkqi00srmdgp568vqvkz	cmbhqxj1e00rzmdgpezwto4qv	c933392d-433b-404f-9d7a-9e7ad3dc82a6	43147	\N	2025-06-03 02:02:12.772
cmbhqxlkb00t4mdgpdeeohzqi	cmbhqxl1500szmdgpfytdfdkp	77a5e0cd-6bd4-4803-8328-a984b687acc4	23472	\N	2025-06-01 06:03:33.239
cmbhqxluv00tamdgpydqg9mlm	cmbhqxl1500szmdgpfytdfdkp	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	49748	\N	2025-06-02 03:46:26.577
cmbhqxm5k00tkmdgpzd03w3td	cmbhqxl1500szmdgpfytdfdkp	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	51455	\N	2025-06-02 02:56:54.081
cmbhqxmg400tvmdgpjyrd0fxt	cmbhqxl1500szmdgpfytdfdkp	93c893af-8756-474e-934e-b08fad0a78fc	50527	\N	2025-06-01 10:38:13.873
cmbhqxmqr00u5mdgplxki63pe	cmbhqxl1500szmdgpfytdfdkp	383d5111-8bfb-4862-a1ff-0e47d251c542	7282	\N	2025-06-01 20:24:24.202
cmbhqxn1k00u9mdgp7sped734	cmbhqxl1500szmdgpfytdfdkp	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	29097	\N	2025-06-02 02:08:01.338
cmbhqxnc600ugmdgp4s4qm2da	cmbhqxl1500szmdgpfytdfdkp	247c044f-dfb9-4cae-9b72-3e9f80747f2b	7244	\N	2025-06-01 20:26:17.646
cmbhqxnml00ujmdgpdv3v5d1u	cmbhqxl1500szmdgpfytdfdkp	b0417f70-9963-4850-8872-3263fefdef55	42080	\N	2025-06-01 23:41:13.351
cmbhqxnx600urmdgp80qzqe3v	cmbhqxl1500szmdgpfytdfdkp	e4489c4c-93ee-4220-873a-0568c7e65322	11737	\N	2025-06-02 00:07:43.284
cmbhqxoqe00uymdgps3wv4htd	cmbhqxo7s00utmdgpc45c8gws	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	22984	\N	2025-06-01 01:05:16.199
cmbhqxp1300v6mdgpnaavl200	cmbhqxo7s00utmdgpc45c8gws	b0417f70-9963-4850-8872-3263fefdef55	25511	\N	2025-06-01 03:04:28.416
cmbhqxpbq00vemdgpo38czoad	cmbhqxo7s00utmdgpc45c8gws	78ca58fd-7e97-470d-864d-1b995208b2e6	19628	\N	2025-05-31 05:55:58.231
cmbhqxpmd00vmmdgp2itc5srp	cmbhqxo7s00utmdgpc45c8gws	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	8478	\N	2025-05-31 12:08:18.803
cmbhqxpwz00vpmdgpiairqzz3	cmbhqxo7s00utmdgpc45c8gws	c933392d-433b-404f-9d7a-9e7ad3dc82a6	1720	\N	2025-05-31 23:00:13.896
cmbhqxq7r00vsmdgpfechxepl	cmbhqxo7s00utmdgpc45c8gws	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	33727	\N	2025-05-31 19:33:07.016
cmbhqxqif00w1mdgpcqq4acww	cmbhqxo7s00utmdgpc45c8gws	e4489c4c-93ee-4220-873a-0568c7e65322	23232	\N	2025-05-31 20:41:50.749
cmbhqxqsy00w8mdgpn0ruxzl1	cmbhqxo7s00utmdgpc45c8gws	383d5111-8bfb-4862-a1ff-0e47d251c542	11075	\N	2025-05-31 12:59:40.608
cmbhqxr3n00wemdgpgmzyyefa	cmbhqxo7s00utmdgpc45c8gws	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	13299	\N	2025-05-31 11:48:39.262
cmbhqxred00wkmdgpp0tsd4a2	cmbhqxo7s00utmdgpc45c8gws	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	15316	\N	2025-05-31 12:01:24.671
cmbhqxs7g00wtmdgpe5udrrge	cmbhqxrp000womdgps3kqwur3	78ca58fd-7e97-470d-864d-1b995208b2e6	18931	\N	2025-05-30 17:45:26.34
cmbhqxsia00wymdgpq9wmeaa3	cmbhqxrp000womdgps3kqwur3	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	26175	\N	2025-05-30 06:35:58.098
cmbhqxsud00x3mdgp1vv69pmg	cmbhqxrp000womdgps3kqwur3	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	25003	\N	2025-05-30 18:48:20.638
cmbhqxt5100xbmdgpmdbqccb7	cmbhqxrp000womdgps3kqwur3	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	9464	\N	2025-05-30 20:41:48.687
cmbhqxtfw00xemdgp5wkgghbo	cmbhqxrp000womdgps3kqwur3	383d5111-8bfb-4862-a1ff-0e47d251c542	13513	\N	2025-05-30 16:32:57.27
cmbhqxtqb00xjmdgpkn70xcdl	cmbhqxrp000womdgps3kqwur3	b0417f70-9963-4850-8872-3263fefdef55	17859	\N	2025-05-30 14:32:17.863
cmbhqxu0z00xpmdgp36d3s9dg	cmbhqxrp000womdgps3kqwur3	0510f126-3b7a-4e60-8122-9e53b707b8c3	45699	\N	2025-05-31 04:11:10.971
cmbhqxubw00xxmdgp5hvcou87	cmbhqxrp000womdgps3kqwur3	77a5e0cd-6bd4-4803-8328-a984b687acc4	36136	\N	2025-05-30 08:02:11.331
cmbhqxv5300y9mdgpr2icr2lc	cmbhqxume00y4mdgpi326w65v	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	27861	\N	2025-05-29 20:51:58.802
cmbhqxvfs00yhmdgppl9sdr0c	cmbhqxume00y4mdgpi326w65v	383d5111-8bfb-4862-a1ff-0e47d251c542	34745	\N	2025-05-30 01:46:05.641
cmbhqxvqb00ypmdgp73l74pno	cmbhqxume00y4mdgpi326w65v	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	40000	\N	2025-05-29 15:41:49.077
cmbhqxw1300yvmdgpclwmjmvy	cmbhqxume00y4mdgpi326w65v	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	53767	\N	2025-05-29 20:51:44.884
cmbhqxwue00z9mdgp3c6yu9y4	cmbhqxwbp00z4mdgpuij23e9i	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	18882	\N	2025-05-28 05:09:24.607
cmbhqxx5500zhmdgpbike3u33	cmbhqxwbp00z4mdgpuij23e9i	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	42496	\N	2025-05-28 21:31:56.852
cmbhqxxfq00zqmdgpnt0hltvx	cmbhqxwbp00z4mdgpuij23e9i	78ca58fd-7e97-470d-864d-1b995208b2e6	22657	\N	2025-05-28 18:29:17.43
cmbhqxxq800zymdgprm4n9h5f	cmbhqxwbp00z4mdgpuij23e9i	247c044f-dfb9-4cae-9b72-3e9f80747f2b	36650	\N	2025-05-28 14:08:15.848
cmbhqxy150108mdgpqz4fy2js	cmbhqxwbp00z4mdgpuij23e9i	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	42595	\N	2025-05-28 16:34:48.012
cmbhqxybr010kmdgp9iwqtvys	cmbhqxwbp00z4mdgpuij23e9i	e4489c4c-93ee-4220-873a-0568c7e65322	23173	\N	2025-05-28 22:22:01.782
cmbhqxymi010rmdgpeukb9qni	cmbhqxwbp00z4mdgpuij23e9i	7851298a-157c-4e0a-9163-b97f4c8c8535	15754	\N	2025-05-28 09:35:55.235
cmbhqxyx4010wmdgprspq4jnn	cmbhqxwbp00z4mdgpuij23e9i	77a5e0cd-6bd4-4803-8328-a984b687acc4	24786	\N	2025-05-28 23:55:13.332
cmbhqxz7x0114mdgpb2ajj9ft	cmbhqxwbp00z4mdgpuij23e9i	c933392d-433b-404f-9d7a-9e7ad3dc82a6	80660	\N	2025-05-28 05:32:41.51
cmbhqy01e011nmdgp213jr8gs	cmbhqxzin011imdgpa8cfhdfq	65c3736c-5514-4c4f-9f57-2c11d3863657	12263	\N	2025-06-04 07:25:29.927
cmbhqy0c0011smdgpufckyz5t	cmbhqxzin011imdgpa8cfhdfq	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	16150	\N	2025-06-04 08:45:38.903
cmbhqy0mz011xmdgpe0pyh5n4	cmbhqxzin011imdgpa8cfhdfq	c933392d-433b-404f-9d7a-9e7ad3dc82a6	14697	\N	2025-06-04 08:19:42.567
cmbhqy0xn0122mdgpmjfon1rv	cmbhqxzin011imdgpa8cfhdfq	977422d6-241d-4aa4-8c6d-080a97737d11	7583	\N	2025-06-04 07:38:36.7
cmbhqy1870125mdgpgncm4i6i	cmbhqxzin011imdgpa8cfhdfq	78ca58fd-7e97-470d-864d-1b995208b2e6	8420	\N	2025-06-04 08:07:17.675
cmbhqy2k1012hmdgp584w89f0	cmbhqy216012cmdgp9exc9p5i	78ca58fd-7e97-470d-864d-1b995208b2e6	72661	\N	2025-05-28 10:00:06.576
cmbhqy3d4012pmdgpdzjp3jlg	cmbhqy2uw012kmdgpnahp38gg	247c044f-dfb9-4cae-9b72-3e9f80747f2b	174859	\N	2025-06-03 21:29:21.412
cmbhqy4qc0132mdgppvx812w9	cmbhqy46e012xmdgpfyckbxcr	977422d6-241d-4aa4-8c6d-080a97737d11	72823	\N	2025-05-31 14:48:18.193
cmbhqy50z013emdgp6m0y96kz	cmbhqy46e012xmdgpfyckbxcr	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	91834	\N	2025-06-01 09:03:59.857



--
-- TOC entry 4374 (class 0 OID 29871)
-- Dependencies: 349
-- Data for Name: TournamentReward; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."TournamentReward" (id, "tournamentId", rank, description, "isClaimed", "winnerId") FROM stdin;
cmbhqxgnn00qimdgp9aehy84w	cmbhqxgnn00qhmdgpzbjdv4ci	1	1827 Super Coins + Trophy Icon	f	\N
cmbhqxgnn00qjmdgpdozbl1az	cmbhqxgnn00qhmdgpzbjdv4ci	2	1616 Super Coins	f	\N
cmbhqxgnn00qkmdgpiivgni0n	cmbhqxgnn00qhmdgpzbjdv4ci	3	524 Super Coins	f	\N
cmbhqxj1e00s0mdgpizr5j1km	cmbhqxj1e00rzmdgpezwto4qv	1	1824 Super Coins + Trophy Icon	f	\N
cmbhqxj1e00s1mdgp16yu34f1	cmbhqxj1e00rzmdgpezwto4qv	2	1890 Super Coins	f	\N
cmbhqxj1e00s2mdgpvntpvpcw	cmbhqxj1e00rzmdgpezwto4qv	3	766 Super Coins	f	\N
cmbhqxl1500t0mdgptltfm6sg	cmbhqxl1500szmdgpfytdfdkp	1	3474 Super Coins + Trophy Icon	f	\N
cmbhqxl1500t1mdgpn4o6w692	cmbhqxl1500szmdgpfytdfdkp	2	1335 Super Coins	f	\N
cmbhqxl1500t2mdgpv9kpl94d	cmbhqxl1500szmdgpfytdfdkp	3	339 Super Coins	f	\N
cmbhqxo7s00uumdgppuyqbyee	cmbhqxo7s00utmdgpc45c8gws	1	4314 Super Coins + Trophy Icon	f	\N
cmbhqxo7s00uvmdgp4a8blp4h	cmbhqxo7s00utmdgpc45c8gws	2	1526 Super Coins	f	\N
cmbhqxo7s00uwmdgpd7ivizgz	cmbhqxo7s00utmdgpc45c8gws	3	292 Super Coins	f	\N
cmbhqxrp100wpmdgpva9o06ah	cmbhqxrp000womdgps3kqwur3	1	3195 Super Coins + Trophy Icon	f	\N
cmbhqxrp100wqmdgpoujl5hqr	cmbhqxrp000womdgps3kqwur3	2	1067 Super Coins	f	\N
cmbhqxrp100wrmdgpsr9i7y97	cmbhqxrp000womdgps3kqwur3	3	558 Super Coins	f	\N
cmbhqxume00y5mdgp5i96o2fu	cmbhqxume00y4mdgpi326w65v	1	2795 Super Coins + Trophy Icon	f	\N
cmbhqxume00y6mdgpf52rgmpf	cmbhqxume00y4mdgpi326w65v	2	1176 Super Coins	f	\N
cmbhqxume00y7mdgpj6a0fuvh	cmbhqxume00y4mdgpi326w65v	3	691 Super Coins	f	\N
cmbhqxwbp00z5mdgpvl2rw8il	cmbhqxwbp00z4mdgpuij23e9i	1	2228 Super Coins + Trophy Icon	f	\N
cmbhqxwbp00z6mdgp7232ydid	cmbhqxwbp00z4mdgpuij23e9i	2	1247 Super Coins	f	\N
cmbhqxwbp00z7mdgp2yg9t78y	cmbhqxwbp00z4mdgpuij23e9i	3	839 Super Coins	f	\N
cmbhqxzin011jmdgpz4agv1p5	cmbhqxzin011imdgpa8cfhdfq	1	2890 Super Coins + Trophy Icon	f	\N
cmbhqxzin011kmdgpdhp6aa5z	cmbhqxzin011imdgpa8cfhdfq	2	846 Super Coins	f	\N
cmbhqxzin011lmdgpgn18oler	cmbhqxzin011imdgpa8cfhdfq	3	659 Super Coins	f	\N
cmbhqy1iv0129mdgpi1aqjuic	cmbhqy1iv0128mdgptulgabq0	1	1011 Super Coins + Trophy Icon	f	\N
cmbhqy1iv012amdgpzgfa1q4w	cmbhqy1iv0128mdgptulgabq0	2	699 Super Coins	f	\N
cmbhqy1iv012bmdgp81kbs5xs	cmbhqy1iv0128mdgptulgabq0	3	255 Super Coins	f	\N
cmbhqy216012dmdgpy6t0e4ry	cmbhqy216012cmdgp9exc9p5i	1	1657 Super Coins + Trophy Icon	f	\N
cmbhqy216012emdgpad9f7elk	cmbhqy216012cmdgp9exc9p5i	2	1890 Super Coins	f	\N
cmbhqy216012fmdgpfc72ni3e	cmbhqy216012cmdgp9exc9p5i	3	910 Super Coins	f	\N
cmbhqy2uw012lmdgpch3vklxq	cmbhqy2uw012kmdgpnahp38gg	1	1841 Super Coins + Trophy Icon	f	\N
cmbhqy2uw012mmdgp04wspkmg	cmbhqy2uw012kmdgpnahp38gg	2	1937 Super Coins	f	\N
cmbhqy2uw012nmdgpqzodn31f	cmbhqy2uw012kmdgpnahp38gg	3	496 Super Coins	f	\N
cmbhqy3nz012umdgpjvsa57zi	cmbhqy3nz012tmdgpj13ikej0	1	2669 Super Coins + Trophy Icon	f	\N
cmbhqy3nz012vmdgpzs9oz2x6	cmbhqy3nz012tmdgpj13ikej0	2	702 Super Coins	f	\N
cmbhqy3nz012wmdgprvmuypap	cmbhqy3nz012tmdgpj13ikej0	3	745 Super Coins	f	\N
cmbhqy46e012ymdgpogqlnxuz	cmbhqy46e012xmdgpfyckbxcr	1	4353 Super Coins + Trophy Icon	f	\N
cmbhqy46e012zmdgpdmnklivz	cmbhqy46e012xmdgpfyckbxcr	2	1897 Super Coins	f	\N
cmbhqy46e0130mdgp0bivl6kj	cmbhqy46e012xmdgpfyckbxcr	3	360 Super Coins	f	\N
cmbhqy5bo013qmdgpx46zo2q3	cmbhqy5bo013pmdgpc97o5ajq	1	2417 Super Coins + Trophy Icon	f	\N
cmbhqy5bo013rmdgpuyp83ffe	cmbhqy5bo013pmdgpc97o5ajq	2	1536 Super Coins	f	\N
cmbhqy5bo013smdgp0oitvk5o	cmbhqy5bo013pmdgpc97o5ajq	3	600 Super Coins	f	\N



--
-- TOC entry 4362 (class 0 OID 29758)
-- Dependencies: 337
-- Data for Name: _TournamentGames; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."_TournamentGames" ("A", "B") FROM stdin;
cmbhqvuaw008jmdgpbuzn4kgy	cmbhqxgnn00qhmdgpzbjdv4ci
cmbhqvuau007qmdgpyphe5zj1	cmbhqxgnn00qhmdgpzbjdv4ci
cmbhqvuav007umdgp297z1ygv	cmbhqxgnn00qhmdgpzbjdv4ci
cmbhqvuas006tmdgp84zizuof	cmbhqxgnn00qhmdgpzbjdv4ci
cmbhqvuaw008cmdgpf7du7jp8	cmbhqxgnn00qhmdgpzbjdv4ci
cmbhqvuas006imdgp4yt775s7	cmbhqxj1e00rzmdgpezwto4qv
cmbhqvuau007fmdgpb76g1dli	cmbhqxj1e00rzmdgpezwto4qv
cmbhqvuas006smdgpp1w52gld	cmbhqxj1e00rzmdgpezwto4qv
cmbhqvuar006fmdgpy2fob1y0	cmbhqxj1e00rzmdgpezwto4qv
cmbhqvuaq005mmdgpwwo2gj0e	cmbhqxj1e00rzmdgpezwto4qv
cmbhqvuau007kmdgp5xx5do8d	cmbhqxl1500szmdgpfytdfdkp
cmbhqvuaq005ymdgpxn0itswl	cmbhqxl1500szmdgpfytdfdkp
cmbhqvuap005fmdgp1yyiy3s4	cmbhqxl1500szmdgpfytdfdkp
cmbhqvuav0083mdgphir1eor8	cmbhqxl1500szmdgpfytdfdkp
cmbhqvuat006zmdgpripqhodi	cmbhqxl1500szmdgpfytdfdkp
cmbhqvuap005lmdgp8ipvmum8	cmbhqxo7s00utmdgpc45c8gws
cmbhqvuat006wmdgpy8kqdv86	cmbhqxo7s00utmdgpc45c8gws
cmbhqvuav0087mdgpblfe2ipd	cmbhqxo7s00utmdgpc45c8gws
cmbhqvuav007ymdgp7c2zo1wo	cmbhqxrp000womdgps3kqwur3
cmbhqvuaw008hmdgpqez5owny	cmbhqxrp000womdgps3kqwur3
cmbhqvuau007gmdgpgbqt50kr	cmbhqxume00y4mdgpi326w65v
cmbhqvuav0085mdgpf3tdt73d	cmbhqxume00y4mdgpi326w65v
cmbhqvuau007mmdgpzy8flpsf	cmbhqxume00y4mdgpi326w65v
cmbhqvuaq0063mdgp7ueu9zuf	cmbhqxume00y4mdgpi326w65v
cmbhqvuaq005qmdgpmna46zzs	cmbhqxwbp00z4mdgpuij23e9i
cmbhqvuas006jmdgp7czbz5u5	cmbhqxwbp00z4mdgpuij23e9i
cmbhqvuaw008dmdgp2c6uayfe	cmbhqxwbp00z4mdgpuij23e9i
cmbhqvuat006zmdgpripqhodi	cmbhqxwbp00z4mdgpuij23e9i
cmbhqvuav0083mdgphir1eor8	cmbhqxwbp00z4mdgpuij23e9i
cmbhqvuat0075mdgpkkp4yfjq	cmbhqxzin011imdgpa8cfhdfq
cmbhqvuap005cmdgpzvh5q3vd	cmbhqy1iv0128mdgptulgabq0
cmbhqvuaq005omdgpuostmskk	cmbhqy1iv0128mdgptulgabq0
cmbhqvuar006bmdgpew4n8vrg	cmbhqy1iv0128mdgptulgabq0
cmbhqvuaw0088mdgpaag8t0l4	cmbhqy216012cmdgp9exc9p5i
cmbhqvuaw008dmdgp2c6uayfe	cmbhqy216012cmdgp9exc9p5i
cmbhqvuav0086mdgp3vb68p2b	cmbhqy2uw012kmdgpnahp38gg
cmbhqvuau007imdgp9l2ne1bz	cmbhqy2uw012kmdgpnahp38gg
cmbhqvuap005kmdgpu8v6g3k9	cmbhqy2uw012kmdgpnahp38gg
cmbhqvuaq0062mdgplhwepm3z	cmbhqy3nz012tmdgpj13ikej0
cmbhqvuaq005rmdgpuddirg8n	cmbhqy3nz012tmdgpj13ikej0
cmbhqvuap005imdgp3kchbmx7	cmbhqy3nz012tmdgpj13ikej0
cmbhqvuau007jmdgprblon0zn	cmbhqy3nz012tmdgpj13ikej0
cmbhqvuap005jmdgphx4hsyq0	cmbhqy46e012xmdgpfyckbxcr
cmbhqvuat006wmdgpy8kqdv86	cmbhqy46e012xmdgpfyckbxcr
cmbhqvuav007vmdgpfmxu6jy0	cmbhqy46e012xmdgpfyckbxcr
cmbhqvuaq005omdgpuostmskk	cmbhqy46e012xmdgpfyckbxcr
cmbhqvuau007hmdgpllwga1qv	cmbhqy46e012xmdgpfyckbxcr
cmbhqvuaq005rmdgpuddirg8n	cmbhqy5bo013pmdgpc97o5ajq



--
-- TOC entry 4355 (class 0 OID 29685)
-- Dependencies: 330
-- Data for Name: account; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.account (_id, account_id, provider_id, user_id, access_token, refresh_token, id_token, access_token_expires_at, refresh_token_expires_at, scope, password, created_at, updated_at) FROM stdin;
bf3c6b15-01b9-4d48-93dc-a5ee4fd23660	admin@casino.example.com	credentials	44e19cc5-466c-4551-8719-621ed777c04f	\N	\N	\N	\N	\N	\N	$2b$10$GVETGAGi/PpBVgYGuZNQJuuFK/1wuiAlzKOypqGL/K0doXYc6U3le	2025-06-04 09:27:04.48	2025-06-04 09:27:04.48
f4517e39-63a5-4901-80a7-88ad4b78fdec	bart0.harris59@yahoo.com	credentials	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	\N	\N	\N	\N	\N	\N	$2b$10$i8oA5M5IdirKUQYJts/ay.E233/kfOV0Wcd8P5TVpoTIUrTT1sf5K	2025-06-04 09:27:05.429	2025-06-04 09:27:05.429
6cb16d5e-6956-48d3-b79a-5057ea9c0a10	miracle1.dare68@hotmail.com	credentials	b0417f70-9963-4850-8872-3263fefdef55	\N	\N	\N	\N	\N	\N	$2b$10$OS.i7O8NabIpOimLQ1aL9OuaIEc9TqrBTZi7LApK9zpPQRnmpV4oy	2025-06-04 09:27:06.334	2025-06-04 09:27:06.334
a2142407-1cbe-4d6a-9986-0fb3653c08fa	rosalia2_rice48@gmail.com	credentials	c933392d-433b-404f-9d7a-9e7ad3dc82a6	\N	\N	\N	\N	\N	\N	$2b$10$A06AgOpokndsunaLBTTki.Yo4XNQ9hFcAC2YMda1NefapU6hO2ZGy	2025-06-04 09:27:07.234	2025-06-04 09:27:07.234
01532b27-4882-4fe8-8698-71d38ffea08c	alanis3.kerluke9@gmail.com	credentials	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	\N	\N	\N	\N	\N	\N	$2b$10$TDtgD5rK7aqZFfy.U0sVGeZpD/gnrJX/mXowCVzPRMbuJ08uFT1q2	2025-06-04 09:27:08.152	2025-06-04 09:27:08.152
292e751a-bb9a-4f61-b8bc-20f0b86c01eb	conor4.tromp79@hotmail.com	credentials	383d5111-8bfb-4862-a1ff-0e47d251c542	\N	\N	\N	\N	\N	\N	$2b$10$Kuf6K1/YsEYQ2HzcOzabV.90thVt6wjryP/vpq5sEsWdzPhWU8VKa	2025-06-04 09:27:09.065	2025-06-04 09:27:09.065
97870e7f-9b81-463c-850f-ce9e6c370b6d	berenice5.runolfsson@yahoo.com	credentials	66426961-c20f-4883-900f-c6bc0b13172c	\N	\N	\N	\N	\N	\N	$2b$10$JXSsDyXdbXrsQVm1C9v3aeR33/3zBU5pIldAS834HA7YBH1iE7Blu	2025-06-04 09:27:09.99	2025-06-04 09:27:09.99
d3ebd602-4baf-4e54-bb09-d841257f18ee	gino6.vonrueden70@gmail.com	credentials	78ca58fd-7e97-470d-864d-1b995208b2e6	\N	\N	\N	\N	\N	\N	$2b$10$g41wPFA.H4krPpjs8wp6FOUrY2dp/oDI6d5AiE5GSvqoo6ohkogzK	2025-06-04 09:27:10.948	2025-06-04 09:27:10.948
b6e8605e-644a-47dd-8918-ef2950c49b17	arjun7_schulist18@yahoo.com	credentials	247c044f-dfb9-4cae-9b72-3e9f80747f2b	\N	\N	\N	\N	\N	\N	$2b$10$Z.uUNiZZDrcQhlYZ0ID33OMEh/Tj1uSH8YcFrlVpRVTgCicgiMrCm	2025-06-04 09:27:11.917	2025-06-04 09:27:11.917
68a29bcc-530f-47bf-9ae3-8e91504d63a6	eden8.ebert@hotmail.com	credentials	77a5e0cd-6bd4-4803-8328-a984b687acc4	\N	\N	\N	\N	\N	\N	$2b$10$D94/UX79mGiCvQZJ0SUsMeYiPC0wept1bEheJklKncle9RDlK5e8u	2025-06-04 09:27:12.864	2025-06-04 09:27:12.864
99501f92-8b40-47e1-815d-81bd34ddee13	tyrel9_kozey40@gmail.com	credentials	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	\N	\N	\N	\N	\N	\N	$2b$10$7IRCf7H1qMJpYXysT.abY.nZO26K10dOmgYdeCVkvbrzkQlwxJ2zO	2025-06-04 09:27:13.836	2025-06-04 09:27:13.836
82b5168d-1305-495a-93b7-5b4e4aeb98f1	libby10.padberg@gmail.com	credentials	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	\N	\N	\N	\N	\N	\N	$2b$10$tjwWalWNz6PtKliw4F8wDeBXYVAiSGQbolVHuSsCtd1oUn49sXccS	2025-06-04 09:27:14.796	2025-06-04 09:27:14.796
cd185017-dc04-4ca5-bf93-bda8639909c9	cruz11.stokes@hotmail.com	credentials	7851298a-157c-4e0a-9163-b97f4c8c8535	\N	\N	\N	\N	\N	\N	$2b$10$kmzB3FW16HWtYJDGJmE2g.B0qATR1rFT551YH56ed38xLa9B9LzJW	2025-06-04 09:27:15.738	2025-06-04 09:27:15.738
e6b1a920-6666-4f24-8134-75273878e678	ottis12.lindgren@gmail.com	credentials	0510f126-3b7a-4e60-8122-9e53b707b8c3	\N	\N	\N	\N	\N	\N	$2b$10$XUxopV.gLPJPCa/qrc9hH.F15CeYhVbpzuBBmVkTqd0AlQBOUfpuq	2025-06-04 09:27:16.66	2025-06-04 09:27:16.66
be936933-5c4a-44f0-b779-0ac392043121	rashawn13.hand@yahoo.com	credentials	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	\N	\N	\N	\N	\N	\N	$2b$10$IBpl65uOapSHk8ykB2JDAuAYHFw1ChP7fY3D1hB366ozGONu4yr9G	2025-06-04 09:27:17.598	2025-06-04 09:27:17.598
bb793b41-fad4-4a5b-92b3-eaf783cbac90	patsy14_howell47@yahoo.com	credentials	93c893af-8756-474e-934e-b08fad0a78fc	\N	\N	\N	\N	\N	\N	$2b$10$PGdX3hRXQO.oGltyloTi0OSZdlucyZM8ASWDBAzR2i4QcIASl7VjO	2025-06-04 09:27:18.588	2025-06-04 09:27:18.588
56a3788a-3f02-4f4d-9026-c7af8d6e0c87	marc15.wintheiser@yahoo.com	credentials	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	\N	\N	\N	\N	\N	\N	$2b$10$nZObVR6YhjIB7ckzK/DakuNLfCFN/0uMb6UNGdbjzFi097DFyUthW	2025-06-04 09:27:19.498	2025-06-04 09:27:19.498
67317caa-bfc2-41e4-829e-ea5cf8a24c5f	taurean16_ebert99@gmail.com	credentials	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	\N	\N	\N	\N	\N	\N	$2b$10$eD5O6Ojx1rV8dc16xkxrneQ9UK31Ql1omZIC0LYGQtPskYgdQiqiG	2025-06-04 09:27:20.414	2025-06-04 09:27:20.414
bd1abe35-40b8-4440-a92f-2d7a4f37de7f	amos17.corkery@hotmail.com	credentials	65c3736c-5514-4c4f-9f57-2c11d3863657	\N	\N	\N	\N	\N	\N	$2b$10$idmtnArmSu7K4ySbRWPlWuSIlHSAE03AYpOBNpRZki36CPciR/Qda	2025-06-04 09:27:21.381	2025-06-04 09:27:21.381
9f3fe6dc-38c7-4e99-8687-634c28cfcda4	sandy18_daugherty40@hotmail.com	credentials	e4489c4c-93ee-4220-873a-0568c7e65322	\N	\N	\N	\N	\N	\N	$2b$10$vFXvAsSlOnh4MTdqeBWBq.GtYLRlKsKJeNlnbpOb4X/yUJxlvAGJu	2025-06-04 09:27:22.311	2025-06-04 09:27:22.311
72860ace-bea3-45d6-bdc1-babc75b3dba6	maribel19.mann1@yahoo.com	credentials	977422d6-241d-4aa4-8c6d-080a97737d11	\N	\N	\N	\N	\N	\N	$2b$10$cxDcZZklnSRJF36EUs4qwOB1juW8SVoWHB3b/uYE4CnHA6F.48xR2	2025-06-04 09:27:23.285	2025-06-04 09:27:23.285
QkilxjlACzQ7N9QvtGuxJaDrrORQYGhQ	KDD59juLi7g0nwKhS0fVFjNFrO7GinCO	credential	KDD59juLi7g0nwKhS0fVFjNFrO7GinCO	\N	\N	\N	\N	\N	\N	b6ccd3f575a3d4b6795936149d50bf4a:43e5ace28b2bec7edfd003ff4bb62c8f163ac0a22ba95c3f4eb4f17d2c4d0e32da56967b82828e017333c1d0caed41cbd660cdcfbd4732d34df654545e738207	2025-06-04 10:43:08.06	2025-06-04 10:43:08.06
V9hjEsDJoW2K6ELSr4UH4AMDUNklYX4E	eTGvUvHx26rHPbsqX7DdinXgSjpUGhFC	credential	eTGvUvHx26rHPbsqX7DdinXgSjpUGhFC	\N	\N	\N	\N	\N	\N	f34fb703451ed78cd1137187d6fe0394:4cef9a572fce86c9654c5b46e03c376581cbb9e8f4169dfd8313520057480ed36ac1a577fa95f807618fc23f4c285fc2a5496dbfd1901c2d68e0d6b3b54ad5c9	2025-06-04 10:44:46.308	2025-06-04 10:44:46.308
jluFCyoTMwX7xozOgx3cqOMIjR98I7S1	qfw6qGODKsjisZYWZV5UuqrKtssXvZOW	credential	qfw6qGODKsjisZYWZV5UuqrKtssXvZOW	\N	\N	\N	\N	\N	\N	5173b77c3f466eb49dd5c464f20b0415:4644fc3d82925ca74005e8e8013458d73afa28cebd5e4bf41355b5097b21423ef4fa12ea2d1eee9848241c0c97ec45092b15647a9664b341c88d20fda064daed	2025-06-04 10:45:10.658	2025-06-04 10:45:10.658
uWoVB03LmUyauFLLq8k1CB3c85ntgR0d	n54PJz49x6q6Ah6rGN2Fksi5y1ZpXeB2	credential	n54PJz49x6q6Ah6rGN2Fksi5y1ZpXeB2	\N	\N	\N	\N	\N	\N	5ba276f3bf314394363d921c0db5c539:e64e9bbbb370edd5d0c86ebebcc7aa72155ad69da2f35d2e7a0a83b70600736bcf94b5e2cca37c7122fbeed001d3b25cf41e40f6d32aa421e4a0e36571a5dd10	2025-06-04 10:45:21.248	2025-06-04 10:45:21.248
thY4luvWlfPrDajhJetO120FY9NXhJtR	41q73jCZmxVD27ZBISWqTY4WupCxXpgI	credential	41q73jCZmxVD27ZBISWqTY4WupCxXpgI	\N	\N	\N	\N	\N	\N	b5a5e3824fdfebfeec1bb5e0dabf89eb:973e6174a5317bdacfc9e27afef9fd5fed7fd4fbc96024ec6b79d5e2efea9d2233777a6321a84afa080126280d22aa93815a4431bfefe291fc0caf9384af662b	2025-06-04 10:45:44.983	2025-06-04 10:45:44.983
Gd8qAf09e8pXIiFoSwQ6T0cksRpFUeLw	LfZ8rW9WO8IuC1UqwwU8jZtxCusdKJYI	credential	LfZ8rW9WO8IuC1UqwwU8jZtxCusdKJYI	\N	\N	\N	\N	\N	\N	672a13bbf600fa25d870bdd582dc5e71:532ae2e61be5d75c3c67c2a4b396d68c65c712d517c9762fe7b2ca72b28a707a81a1846a9f4efdc8b8c64d19b34535ed8d77dcbf37ec787df1b0c69674252a2b	2025-06-04 10:46:06.448	2025-06-04 10:46:06.448
eIc8mA5MIfNoNBUP1ltpBmdxFAB3GqpO	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	credential	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	\N	\N	\N	\N	\N	\N	3d178da996b21322121ced16146f900d:0b6ed94d3e5cab1a50b9ae4fef2e783a2441e334cadfe19f0570a7fafce4b798645414c9e0f1067fec064b6f34c874dc4d1e73d4c9b84365d58467f18fce5627	2025-06-04 10:46:54.583	2025-06-04 10:46:54.583



--
-- TOC entry 4361 (class 0 OID 29748)
-- Dependencies: 336
-- Data for Name: game_launch_links; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_launch_links (id, token_internal, currency, player_operator_id, mode, meta, request_ip, user_agent, session_url, state, active, expires_at, extra_meta, token_original, "createdAt", "updatedAt", "userId", "gameId", "operatorId", "userProfileId") FROM stdin;



--
-- TOC entry 4358 (class 0 OID 29712)
-- Dependencies: 333
-- Data for Name: game_sessions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_sessions (id, "isActive", "sessionData", "authSessionId", "currencyId", "startedAt", "endTime", "startTime", "ipAddress", "startingBalance", "startingTotalXp", "userAgent", "createdAt", "updatedAt", "totalWagered", "totalWon", "userId", "gameId", "rtgToken", "rtgFingerPrint", "profileId") FROM stdin;
cmbhqvv62008mmdgp8mvm0nps	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "43623454-0ce6-4515-86ab-0a432f0e756a"}	\N	USD	2025-05-08 20:06:19.701	2025-05-08 20:22:19.701	2025-05-08 20:06:19.701	198.160.185.178	29015	98018	FakerBot/0.13.9	2025-06-04 09:28:17.547	2025-06-04 09:28:19.838	2269	1853	44e19cc5-466c-4551-8719-621ed777c04f	cmbhqvuar0065mdgpcfx4yy2n	WVDemBUt2kIkNXwIDB1CguEglsOJlPA8	b8969bdb-2c93-4000-b761-3fea07b096dc	\N
cmbhqvx3d0098mdgp446zj7lq	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "9c6a55e8-eb5e-445d-9602-731b2dd3c329"}	\N	USD	2025-05-16 09:08:43.011	2025-05-16 10:26:43.011	2025-05-16 09:08:43.011	1da7:fa0e:5c7b:0289:aec1:5cf1:7a30:ec76	29015	98018	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/595.86.59 (KHTML, like Gecko) Version/16.1 Safari/562.38.2	2025-06-04 09:28:20.042	2025-06-04 09:28:21.707	2055	2090	44e19cc5-466c-4551-8719-621ed777c04f	cmbhqvuaq0060mdgphzqs5uve	V0Fs0juOoPDBxUr0Irm37RzSg28cLW8P	3652fdad-c513-4dc7-9846-ec46571054f4	\N
cmbhqvyje009omdgp5ncy5117	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "26488fce-507f-4ce2-92df-72d259893609"}	\N	USD	2025-05-05 17:32:37.175	2025-05-05 18:52:37.175	2025-05-05 17:32:37.175	227.125.172.28	30296	15587	Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/589.82.71 (KHTML, like Gecko) Chrome/120.4.3.3 Safari/576.17.24	2025-06-04 09:28:21.914	2025-06-04 09:28:23.142	1091	49	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	cmbhqvuat0078mdgp9uanzcmz	jDW0qD4OPnRZw6b7d6x90eyr5sYZGv2h	fbe8a33c-e9a2-41d8-a079-c232fa724e58	\N
cmbhqvzn600a0mdgphmhn5asd	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3"}	\N	USD	2025-05-16 14:57:29.785	2025-05-16 15:34:29.785	2025-05-16 14:57:29.785	6d2d:2bec:9bb7:e8f8:fbdc:86a5:fffb:7d15	175746	32816	Mozilla/5.0 (iPhone; CPU iPhone OS 13_1 like Mac OS X) AppleWebKit/559.90.81 (KHTML, like Gecko) Version/16_4 Mobile/15E148 Safari/586.44	2025-06-04 09:28:23.346	2025-06-04 09:28:25.188	2242	861	b0417f70-9963-4850-8872-3263fefdef55	cmbhqvuar0067mdgpi1dg1mkh	p1vHS4x9l7mRtpFr6UbsRG4kt3eYolgC	ce32ad2d-b735-4d4a-8460-e2e53c440e56	\N
cmbhqw18000aimdgpeql7v3r1	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "6ac025c8-e405-4426-a8f8-7f8812217222"}	\N	USD	2025-05-17 05:44:55.332	2025-05-17 06:18:55.332	2025-05-17 05:44:55.332	bcfe:a226:efe3:f9ca:1dcf:e7dc:daeb:6ee5	175746	32816	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:124.0) Gecko/20100101 Firefox/90.0	2025-06-04 09:28:25.393	2025-06-04 09:28:27.244	2003	1885	b0417f70-9963-4850-8872-3263fefdef55	cmbhqvuap005lmdgp8ipvmum8	D29ccYzcpNtYPspPdq8r71NrdK9Pf3h5	355a6c6c-f696-4494-b06b-97f7c4cd561a	\N
cmbhqw2th00b0mdgpe6yn0u9h	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "0939c81d-f330-4ee9-808e-e9923dae940b"}	\N	USD	2025-05-10 13:20:05.758	2025-05-10 14:00:05.758	2025-05-10 13:20:05.758	178.34.111.164	159933	17384	Mozilla/5.0 (Windows NT 5.2; Win64; x64) AppleWebKit/574.32 (KHTML, like Gecko) Chrome/85.0.14.6 Safari/597.73 Edg/111.7.1.3	2025-06-04 09:28:27.461	2025-06-04 09:28:28.695	1267	188	c933392d-433b-404f-9d7a-9e7ad3dc82a6	cmbhqvuat0070mdgpojfud5g1	mZSNWryAHGxrPovxARgdfSqnjbvvCpAt	bfc2e882-bd61-4bd7-9869-176d0658cdf5	\N
cmbhqw3xi00bcmdgpalcp7msl	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "e8038b93-372d-4d59-8ca6-f5f54340d745"}	\N	USD	2025-05-12 18:20:00.783	2025-05-12 19:18:00.783	2025-05-12 18:20:00.783	189.140.147.97	159933	17384	FakerBot/5.15.13	2025-06-04 09:28:28.902	2025-06-04 09:28:30.747	2811	1586	c933392d-433b-404f-9d7a-9e7ad3dc82a6	cmbhqvuav007vmdgpfmxu6jy0	PpTyuu2IyJDSCPnj5w9kKGog5gdBwrHC	6875b1ed-fa96-430a-b175-a8dab327e39e	\N
cmbhqw5ig00bumdgpas4kj9lg	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "6f7383dd-1d4c-4a33-acb0-bca968235996"}	\N	USD	2025-05-17 00:41:25.995	2025-05-17 00:49:25.995	2025-05-17 00:41:25.995	2c83:9bda:a8cb:eb80:bac4:cc81:5032:7cde	159933	17384	Googlebot/2.1 (+http://www.google.com/bot.html)	2025-06-04 09:28:30.953	2025-06-04 09:28:33.063	2807	803	c933392d-433b-404f-9d7a-9e7ad3dc82a6	cmbhqvuau007mmdgpzy8flpsf	XBSAk9NrSW8zlyGo4wrMGBbS4ryoEo0x	35be47b1-a68c-42de-9d50-e4d4b51d0b01	\N
cmbhqw7as00cemdgp1rwfz0bc	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "010c55d5-95f7-44b4-8f39-20408020e7e5"}	\N	USD	2025-05-10 23:47:21.904	2025-05-11 01:12:21.904	2025-05-10 23:47:21.904	ce8e:65ec:d0c1:4f52:1abc:561f:1fbd:ebf9	32132	38167	FakerBot/7.20.18	2025-06-04 09:28:33.268	2025-06-04 09:28:34.717	1334	2067	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	cmbhqvuat0072mdgp2z2reie1	0tFtIuRVE7I6fFEkmeCyfkcWg419yvkb	86ed93f3-d0ce-414e-bc67-503d7c4cf31d	\N
cmbhqw8kt00csmdgp0zm85wsy	t	{"clientType": "HTML5_DESKTOP", "providerSessionId": "f5001bbb-f197-49cc-bea7-0d215e6ca1cf"}	\N	USD	2025-05-15 20:58:20.685	\N	2025-05-15 20:58:20.685	94.193.108.106	32132	38167	Mozilla/5.0 (Linux; Android 10; SM-G998P) AppleWebKit/593.47 (KHTML, like Gecko) Chrome/113.7.19.9 Mobile Safari/559.36	2025-06-04 09:28:34.925	2025-06-04 09:28:37.232	1991	2479	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	cmbhqvuar0069mdgpcq38bg7s	F1s9NYjzK8Im73q3Y3gUPFh8eHIaeQfX	a0ce3638-7663-48b8-b8f1-a81a365cd89c	\N
cmbhqwaio00dcmdgpy3v2qdx5	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "4261c84f-7c25-4b41-b894-3946f0c21c13"}	\N	USD	2025-05-13 21:45:28.423	2025-05-13 22:42:28.423	2025-05-13 21:45:28.423	101.60.83.238	32132	38167	FakerBot/6.10.0	2025-06-04 09:28:37.441	2025-06-04 09:28:39.492	3399	4475	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	cmbhqvuat0072mdgp2z2reie1	7uQ7R4vsM8xq8owUz6SvMgLwjuv5cGce	1284dc70-c5f8-43d5-a1dd-d99074b810aa	\N
cmbhqwc9d00dwmdgp5i0xtxa6	t	{"clientType": "HTML5_DESKTOP", "providerSessionId": "fa03107c-08ef-4726-a88c-869f9f47052b"}	\N	USD	2025-05-15 20:48:25.584	\N	2025-05-15 20:48:25.584	bf00:fd5c:64ee:ee7c:bac7:f1f6:c227:02f7	94389	42983	Mozilla/5.0 (X11; Linux x86_64; rv:106.0) Gecko/20100101 Firefox/126.0	2025-06-04 09:28:39.697	2025-06-04 09:28:41.547	1848	2988	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqvuaq0060mdgphzqs5uve	QsOVRdHEW7eaCDL8Cw4pwnqmL1scWPOJ	522eb275-28d4-4eef-abaa-3e117ffed97e	\N
cmbhqwdul00ecmdgp4g0vqshk	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "373acc13-7876-4b19-bef6-433360ee376d"}	\N	USD	2025-05-25 17:44:59.814	2025-05-25 19:21:59.814	2025-05-25 17:44:59.814	125.12.165.223	94389	42983	Mozilla/5.0 (X11; Linux x86_64; rv:113.0) Gecko/20100101 Firefox/97.0	2025-06-04 09:28:41.757	2025-06-04 09:28:43.411	1377	610	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqvuat0079mdgp8jn41ly4	nNcpmPHUuE732GsB8ivaVY1kNG6iQ2fE	664380ba-7a34-42c4-a523-ba88a63361c7	\N
cmbhqwfac00esmdgpcipgyovl	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "33a7de8d-8d87-49e7-881f-7cfe3b565a94"}	\N	USD	2025-06-01 20:39:35.398	2025-06-01 20:56:35.398	2025-06-01 20:39:35.398	df60:139c:a4b9:30c0:dd2a:bb9a:d4bb:6e0c	172763	77776	Mozilla/5.0 (Windows NT 5.2; Win64; x64) AppleWebKit/552.61 (KHTML, like Gecko) Chrome/108.5.0.18 Safari/541.51 Edg/123.3.1.12	2025-06-04 09:28:43.62	2025-06-04 09:28:45.878	2967	4060	66426961-c20f-4883-900f-c6bc0b13172c	cmbhqvuas006nmdgp2qhvyadk	vj4zB3v7HLxUIjM2qT2bn10LwDNk34Hj	52e2a539-ce43-4f0d-a6c1-0e490232f423	\N
cmbhqwh6w00femdgp0pp8p0mo	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "b87b82f8-3561-4642-b022-0370381c2f23"}	\N	USD	2025-05-18 15:27:12.897	2025-05-18 16:20:12.897	2025-05-18 15:27:12.897	2d2c:5d3a:c639:f620:5d3b:fe7b:af29:adbe	172763	77776	Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 5.1; Trident/6.0)	2025-06-04 09:28:46.088	2025-06-04 09:28:47.31	1590	0	66426961-c20f-4883-900f-c6bc0b13172c	cmbhqvuav0085mdgpf3tdt73d	32Sl2RyOceNcWBJUrTedrxJw56qqZIU9	c1fc76bd-a738-4afc-b47c-251407c05e3f	\N
cmbhqwibt00fqmdgpezlxfpc0	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "24d7daf5-a987-423b-b191-d2f6a69ae980"}	\N	USD	2025-05-21 14:22:06.8	2025-05-21 15:48:06.8	2025-05-21 14:22:06.8	7f8f:ae87:847f:6b4b:3b30:a27d:fb4e:eebc	156695	48280	Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/590.9.78 (KHTML, like Gecko) Version/16.1 Safari/605.15.98	2025-06-04 09:28:47.519	2025-06-04 09:28:49.395	1619	2096	78ca58fd-7e97-470d-864d-1b995208b2e6	cmbhqvuaw008cmdgpf7du7jp8	XWJnrubUn9g0AjlAZ7QfNm7S1zGDTH4I	748ac4e7-5d83-4b4d-9bdd-a0fe86459261	\N
cmbhqwjwj00g8mdgp7b6jjxoi	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "2b534e7a-37e4-49d4-97ed-b2ef30c81ce3"}	\N	USD	2025-05-07 11:17:48.852	2025-05-07 12:27:48.852	2025-05-07 11:17:48.852	123.52.157.45	102490	39218	Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 5.2; Trident/5.0)	2025-06-04 09:28:49.603	2025-06-04 09:28:51.657	2529	1952	247c044f-dfb9-4cae-9b72-3e9f80747f2b	cmbhqvuaq005mmdgpwwo2gj0e	YkxyCFmPDL2f8r9usi1iydHcW3lMeyTT	aa2487a3-a832-4664-a7c4-a03210afe2c6	\N
cmbhqwlnc00gsmdgpd8jriaqj	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "931fdf3c-55cb-46ed-8d25-0276b480834b"}	\N	USD	2025-05-10 03:53:50.707	2025-05-10 05:36:50.707	2025-05-10 03:53:50.707	210.13.124.30	102490	39218	Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 5.1; Trident/7.0)	2025-06-04 09:28:51.864	2025-06-04 09:28:53.105	1447	4113	247c044f-dfb9-4cae-9b72-3e9f80747f2b	cmbhqvuat0070mdgpojfud5g1	V0pqUrUTFstspuA9Pz6tcZUsO737ODoG	7b59b168-44fa-4982-a3d4-435c845ff230	\N
cmbhqwmrn00h4mdgpqzuse9kf	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "371f3008-0f7c-4eb7-9f07-0046f36af3c8"}	\N	USD	2025-05-10 20:52:48.562	2025-05-10 21:54:48.562	2025-05-10 20:52:48.562	bab8:fd88:6eaa:a11d:65fa:ddc2:dfad:5cc9	143435	3137	Mozilla/5.0 (Windows NT 5.2; Win64; x64) AppleWebKit/584.92 (KHTML, like Gecko) Chrome/63.7.2.15 Safari/564.83 Edg/121.9.5.9	2025-06-04 09:28:53.315	2025-06-04 09:28:55.37	2848	2196	77a5e0cd-6bd4-4803-8328-a984b687acc4	cmbhqvuaw0088mdgpaag8t0l4	HY8M4UCKGhUSeemF8W9h50nNC6Q1TKd7	d5abe24f-4020-4f89-9cb6-ce6b8f72ae46	\N
cmbhqwoic00homdgptvk4mb1e	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "1149a799-9652-403a-84bc-b8382406e9e0"}	\N	USD	2025-05-08 11:37:38.685	2025-05-08 13:11:38.685	2025-05-08 11:37:38.685	101.148.254.42	32617	94294	Mozilla/5.0 (X11; Linux x86_64; rv:114.0) Gecko/20100101 Firefox/90.0	2025-06-04 09:28:55.572	2025-06-04 09:28:57.837	2424	2958	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqvuat007bmdgpi2zi2nvz	xXdc9fPwfUqUbYrecvsu58kdTbo8XPex	68d78ffe-9684-4927-9eba-22d60797a336	\N
cmbhqwqf900iamdgpxaqrji3w	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9"}	\N	USD	2025-05-28 19:30:23.91	2025-05-28 19:43:23.91	2025-05-28 19:30:23.91	117.245.243.4	32617	94294	Mozilla/5.0 (Linux; Android 12; SM-G998U) AppleWebKit/582.78 (KHTML, like Gecko) Chrome/84.7.20.11 Mobile Safari/537.32	2025-06-04 09:28:58.053	2025-06-04 09:28:59.698	1546	2861	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqvuar006dmdgp1pqguvgk	N2oTnQRiYYnL2RBEFxuilbo181r4Y2y2	aed17f46-9c3f-40aa-82b0-ab832d51838c	\N
cmbhqwrup00iqmdgp5aq3gzwr	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "0ce73605-f95b-4638-bb24-a9b3d8ef1714"}	\N	USD	2025-05-21 18:32:54.099	2025-05-21 18:58:54.099	2025-05-21 18:32:54.099	114.68.90.180	32617	94294	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:88.0) Gecko/20100101 Firefox/109.0	2025-06-04 09:28:59.905	2025-06-04 09:29:01.537	2257	7239	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqvuap005jmdgphx4hsyq0	VCOBswE32cw4EZTgnSkK1YrDqDOKW74K	c9009f63-7b95-4e8b-ad3d-b7828d9e83b7	\N
cmbhqwt9r00j6mdgpr080jpoz	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "6b428212-7746-491e-af18-581b79b425d3"}	\N	USD	2025-05-21 20:41:00.868	2025-05-21 21:16:00.868	2025-05-21 20:41:00.868	62.23.198.229	10286	70592	FakerBot/7.0.3	2025-06-04 09:29:01.743	2025-06-04 09:29:03.847	1409	1094	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	cmbhqvuas006mmdgpxlsdrlyg	w4gjRpmgYASo3WwSzOtcV3kuIIEXOdoW	fabc0b30-75dc-49c8-9bb0-10675ab7e9f5	\N
cmbhqwv1v00jqmdgpcszh0bu4	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "f651a6ac-1760-416d-9f5a-261bd99bc64d"}	\N	USD	2025-06-03 23:22:35.222	2025-06-04 00:01:35.222	2025-06-03 23:22:35.222	9b5d:fd4f:54fa:40f4:b6ce:c319:4aa7:eca7	130978	3772	Mozilla/5.0 (X11; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/86.0	2025-06-04 09:29:04.051	2025-06-04 09:29:06.317	2670	6551	7851298a-157c-4e0a-9163-b97f4c8c8535	cmbhqvuaq005xmdgpcnebufuq	nDMRXf6NnzTYqUqySWfSGSnDmcaux5ru	32b401ad-126e-439f-9ef6-6dd93be95d25	\N
cmbhqwwz000kcmdgpo8qy2j4f	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "fbe0903d-1115-4de8-bbfc-2de4736f3eda"}	\N	USD	2025-05-19 17:28:48.894	2025-05-19 18:21:48.894	2025-05-19 17:28:48.894	133.24.155.251	183265	7787	Mozilla/5.0 (Linux; Android 10; SM-G998P) AppleWebKit/593.72 (KHTML, like Gecko) Chrome/128.9.0.20 Mobile Safari/562.54	2025-06-04 09:29:06.541	2025-06-04 09:29:08.595	2579	1939	0510f126-3b7a-4e60-8122-9e53b707b8c3	cmbhqvuar006emdgpmbbglhfr	Ew8LVAxSYgmWfvn9WYLyUGXHLe1Zzr7t	001d1224-1800-42f1-bb25-a27bda074cee	\N
cmbhqwypt00kwmdgpprxky151	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "1192ce16-8119-4b60-8de6-6896516cda76"}	\N	USD	2025-05-09 19:16:01.05	2025-05-09 20:50:01.05	2025-05-09 19:16:01.05	30e8:e97e:a6fd:dec7:5e1a:46c8:23a0:245f	14692	69481	Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/575.5.31 (KHTML, like Gecko) Chrome/85.0.5.6 Safari/572.93.8	2025-06-04 09:29:08.801	2025-06-04 09:29:10.64	1659	2975	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	cmbhqvuat007amdgpjvde0xvv	liyaQ9fwlilWS6FeDNZU4xi02wPlDlbO	8d0a70d5-3a34-4096-8860-df9b719f133e	\N
cmbhqx0al00lemdgp871asfgj	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "6d4974f8-4f60-40d6-b648-f991e7cea5ea"}	\N	USD	2025-05-20 14:19:27.549	2025-05-20 15:04:27.549	2025-05-20 14:19:27.549	22.234.142.34	221642	36851	Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/574.82.91 (KHTML, like Gecko) Chrome/102.2.19.14 Safari/572.33.65	2025-06-04 09:29:10.845	2025-06-04 09:29:12.913	2547	1631	93c893af-8756-474e-934e-b08fad0a78fc	cmbhqvuas006umdgpaqil3otb	XT6a781GlSLrChIYPsqhEv9OPjVrQXJL	787ad1eb-79f6-4caa-8497-87735d0fb608	\N
cmbhqx21r00lymdgp1ao0k2td	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "48842f7a-fdbd-4eba-b3ba-5a75be387fd0"}	\N	USD	2025-05-28 04:52:34.669	2025-05-28 06:32:34.669	2025-05-28 04:52:34.669	244.122.229.225	221642	36851	Mozilla/5.0 (iPhone; CPU iPhone OS 12_4 like Mac OS X) AppleWebKit/591.55.64 (KHTML, like Gecko) Version/10_0 Mobile/15E148 Safari/537.73	2025-06-04 09:29:13.119	2025-06-04 09:29:15.399	2794	563	93c893af-8756-474e-934e-b08fad0a78fc	cmbhqvuat0077mdgp5fple5r5	zs5NYiGIPsULS6SBShRZzbeedwmwtEMQ	a0374be3-d713-446f-8829-7e7011f97561	\N
cmbi453h80003md6ilvxhqc5q	f	\N	\N	USD	2025-06-04 15:39:23.228	2025-06-04 15:42:45.938	2025-06-04 15:39:23.227	\N	989600	0	\N	2025-06-04 15:39:23.228	2025-06-04 15:42:45.941	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4eayy0003mdh9s73ffobi	f	\N	\N	USD	2025-06-04 15:46:32.842	2025-06-04 15:46:44.177	2025-06-04 15:46:32.841	\N	989400	0	\N	2025-06-04 15:46:32.842	2025-06-04 15:46:44.179	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi49g0m0005md6ixfuevljb	f	\N	\N	USD	2025-06-04 15:42:46.103	2025-06-04 15:44:05.768	2025-06-04 15:42:46.101	\N	989600	0	\N	2025-06-04 15:42:46.103	2025-06-04 15:44:05.77	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4b5mo0001mdh9pkz57opx	f	\N	\N	USD	2025-06-04 15:44:05.952	2025-06-04 15:46:32.673	2025-06-04 15:44:05.95	\N	989600	0	\N	2025-06-04 15:44:05.952	2025-06-04 15:46:32.674	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4n9zs0001md0milnlabdv	f	\N	\N	USD	2025-06-04 15:53:31.481	2025-06-04 15:53:47.086	2025-06-04 15:53:31.479	\N	988800	0	\N	2025-06-04 15:53:31.481	2025-06-04 15:53:47.087	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4enxz0007mdh9ivgdqfk8	f	\N	\N	USD	2025-06-04 15:46:49.656	2025-06-04 15:53:31.293	2025-06-04 15:46:49.654	\N	989000	0	\N	2025-06-04 15:46:49.656	2025-06-04 15:53:31.295	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4ejue0005mdh9xz32nym3	f	\N	\N	USD	2025-06-04 15:46:44.342	2025-06-04 15:46:49.486	2025-06-04 15:46:44.34	\N	989200	0	\N	2025-06-04 15:46:44.342	2025-06-04 15:46:49.487	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4nm670003md0meizoa0et	f	\N	\N	USD	2025-06-04 15:53:47.263	2025-06-04 15:53:52.736	2025-06-04 15:53:47.262	\N	988600	0	\N	2025-06-04 15:53:47.263	2025-06-04 15:53:52.737	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4nqj40005md0m5wfbl0vh	f	\N	\N	USD	2025-06-04 15:53:52.913	2025-06-04 15:53:57.826	2025-06-04 15:53:52.911	\N	988400	0	\N	2025-06-04 15:53:52.913	2025-06-04 15:53:57.827	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4nugl0007md0m9mzrhjbv	f	\N	\N	USD	2025-06-04 15:53:58.005	2025-06-04 15:59:42.388	2025-06-04 15:53:58.004	\N	988200	0	\N	2025-06-04 15:53:58.005	2025-06-04 15:59:42.39	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4v8bq0001mdu5ilyv1kmc	f	\N	\N	USD	2025-06-04 15:59:42.566	2025-06-04 15:59:50.202	2025-06-04 15:59:42.564	\N	988000	0	\N	2025-06-04 15:59:42.566	2025-06-04 15:59:50.203	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhqx3z200mkmdgpm2qhg4v9	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "30447ee9-a859-4d25-a41b-19f1b0b1384d"}	\N	USD	2025-05-24 15:39:56.998	2025-05-24 16:15:56.998	2025-05-24 15:39:56.998	195.49.143.90	209160	2054	Mozilla/5.0 (Windows NT 6.0; Win64; x64) AppleWebKit/582.86 (KHTML, like Gecko) Chrome/125.6.10.9 Safari/560.2 Edg/129.0.0.8	2025-06-04 09:29:15.614	2025-06-04 09:29:17.273	1315	142	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	cmbhqvuau007jmdgprblon0zn	Ibg50RBRs0Bio2Bp63h2SIRerQjzJSQu	78148148-29e0-41f1-9508-f227c2111148	\N
cmbhqx5et00n0mdgpkcfxoxkk	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "31926c22-01db-4fba-8470-14235f286bc8"}	\N	USD	2025-05-24 17:24:37.654	2025-05-24 17:34:37.654	2025-05-24 17:24:37.654	245.238.104.196	229141	98066	Mozilla/5.0 (X11; Linux x86_64; rv:100.0) Gecko/20100101 Firefox/81.0	2025-06-04 09:29:17.477	2025-06-04 09:29:19.385	2263	791	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	cmbhqvuaw008imdgphl1bwpsi	wrmBwZiPObmuIn5iKk3hdwFKffPGOYd6	92374dde-ca8e-4a43-bb80-c4127ff9ef0f	\N
cmbhqx71g00nimdgpkdxdmihe	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "37503ad4-d7be-4adf-8dd2-d7f04302ce3e"}	\N	USD	2025-05-14 18:37:13.353	2025-05-14 18:57:13.353	2025-05-14 18:37:13.353	b7db:159a:fcff:bb32:905e:9c1d:1617:ce4c	84640	57764	Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/583.14.12 (KHTML, like Gecko) Chrome/83.6.19.13 Safari/557.11.20	2025-06-04 09:29:19.588	2025-06-04 09:29:21.459	1944	4430	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqvuau007mmdgpzy8flpsf	uwVLutJPdbhleToovlFTrB4NBuXA3yor	a8bffa5e-2cb9-44f2-8590-72f27d99611e	\N
cmbhqx8n800o0mdgp96lof5ms	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "a2038e03-dd60-4f2b-aa52-7ffaddbde09a"}	\N	USD	2025-05-17 09:20:30.335	2025-05-17 10:15:30.335	2025-05-17 09:20:30.335	d8a0:ef7a:c1ea:b2af:1a94:c887:9ed1:00ff	84640	57764	FakerBot/8.1.11	2025-06-04 09:29:21.668	2025-06-04 09:29:23.749	3319	2850	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqvuau007emdgp1pr7zgxu	cMNNjSMWUKCKmk4glkrveS6BbqHTFIEb	98ec3a9a-eb58-4c1a-bfb1-f8b162e0d945	\N
cmbhqxaew00okmdgpe3jul65p	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "b317b683-f855-4951-b39e-c3b2bb75b781"}	\N	USD	2025-05-07 23:07:49.338	2025-05-08 00:49:49.338	2025-05-07 23:07:49.338	213.201.210.208	198002	52963	Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/557.97.57 (KHTML, like Gecko) Chrome/98.3.8.19 Safari/594.89.75	2025-06-04 09:29:23.96	2025-06-04 09:29:25.424	1044	117	e4489c4c-93ee-4220-873a-0568c7e65322	cmbhqvuau007kmdgp5xx5do8d	554nfv3Jf1wVxqQk5PRo8U3Q7lmDuOov	554e2b53-5147-46f8-a9a5-822d90d611d4	\N
cmbhqxbpf00oymdgpq3rpo12g	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "722bc36e-463d-4b6a-9b5a-c807e7545a57"}	\N	USD	2025-05-08 00:33:34.362	2025-05-08 01:58:34.362	2025-05-08 00:33:34.362	ef5d:ad02:a0af:c1bb:e6d0:7069:b07e:7aae	198002	52963	Mozilla/5.0 (X11; Linux x86_64; rv:126.0) Gecko/20100101 Firefox/82.0	2025-06-04 09:29:25.635	2025-06-04 09:29:27.906	2582	4341	e4489c4c-93ee-4220-873a-0568c7e65322	cmbhqvuap005emdgp0mzz9sed	Jn3Vlzi35Mc8kJzyXuc6jEeGPMFmFeZN	fe74ae25-095d-468e-887a-5c360c2866bc	\N
cmbhqxdme00pkmdgpgc8bbkjm	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "756b7893-ff0e-4756-ba05-f3f665b7a414"}	\N	USD	2025-05-21 12:23:39.489	2025-05-21 13:23:39.489	2025-05-21 12:23:39.489	f9e9:7540:af7c:6e6e:4e27:d67d:b8a2:57e4	247073	56852	Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 6.3; Trident/4.0)	2025-06-04 09:29:28.118	2025-06-04 09:29:29.559	1512	1683	977422d6-241d-4aa4-8c6d-080a97737d11	cmbhqvuar006cmdgpn8ptnpce	Y1MZoQn5xrkxPBMTIFNPpooXBkXrRJD7	95282d80-5635-47fc-8fc4-74cc4b9f0d71	\N
cmbhqxew400pymdgp6ielmxv9	f	{"clientType": "HTML5_DESKTOP", "providerSessionId": "e5234451-1192-4de2-94da-4189394c7d6c"}	\N	USD	2025-05-11 00:23:49.136	2025-05-11 01:52:49.136	2025-05-11 00:23:49.136	ee0d:bcae:b8b1:3bc5:bb80:13b6:948d:4b6e	247073	56852	Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/546.55.0 (KHTML, like Gecko) Chrome/95.2.18.2 Safari/580.48.96	2025-06-04 09:29:29.765	2025-06-04 09:29:31.823	1693	2040	977422d6-241d-4aa4-8c6d-080a97737d11	cmbhqvuap005amdgpsqdu2o1y	8GBHawV5fZ85zUase0TiZUbK77LWzOZu	3bebbf2c-a9cd-4c1a-baec-7ce01c4b783b	\N
cmbhtqsov000fmd0nkm2frcfr	f	\N	\N	USD	2025-06-04 10:48:19.903	2025-06-04 11:09:48.044	2025-06-04 10:48:19.901	\N	0	0	\N	2025-06-04 10:48:19.903	2025-06-04 11:09:48.056	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhuiero0001mdgfkny26fou	f	\N	\N	USD	2025-06-04 11:09:48.229	2025-06-04 12:05:59.807	2025-06-04 11:09:48.227	\N	0	0	\N	2025-06-04 11:09:48.229	2025-06-04 12:05:59.809	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhwiofv0003mdgf9q2ivltl	f	\N	\N	USD	2025-06-04 12:05:59.995	2025-06-04 12:14:21.374	2025-06-04 12:05:59.994	\N	0	0	\N	2025-06-04 12:05:59.995	2025-06-04 12:14:21.375	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhz1z170005mdc9af425jwu	f	\N	\N	USD	2025-06-04 13:16:59.419	2025-06-04 13:17:16.446	2025-06-04 13:16:59.417	\N	998800	0	\N	2025-06-04 13:16:59.419	2025-06-04 13:17:16.449	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi20iv00001mdsvk63r12bh	f	\N	\N	USD	2025-06-04 14:39:50.65	2025-06-04 14:42:17.909	2025-06-04 14:39:50.648	\N	993200	0	\N	2025-06-04 14:39:50.65	2025-06-04 14:42:17.917	1000	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhzsve90001md9coqjai4lm	f	\N	\N	USD	2025-06-04 13:37:54.417	2025-06-04 13:56:04.245	2025-06-04 13:37:54.416	\N	998200	0	\N	2025-06-04 13:37:54.417	2025-06-04 13:56:04.248	400	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhz2cbd0001mdcrduwzt7f4	f	\N	\N	USD	2025-06-04 13:17:16.633	2025-06-04 13:33:13.538	2025-06-04 13:17:16.631	\N	998800	0	\N	2025-06-04 13:17:16.633	2025-06-04 13:33:13.54	600	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhwtfg70005mdgfkopfh1fz	f	\N	\N	USD	2025-06-04 12:14:21.559	2025-06-04 12:53:18.957	2025-06-04 12:14:21.558	\N	0	0	\N	2025-06-04 12:14:21.559	2025-06-04 12:53:18.971	1000	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhy7j5e0001mdc90hub3nmk	f	\N	\N	USD	2025-06-04 12:53:19.154	2025-06-04 13:04:25.771	2025-06-04 12:53:19.152	\N	999000	0	\N	2025-06-04 12:53:19.154	2025-06-04 13:04:25.774	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhyltnd0003mdc9j1kl81qh	f	\N	\N	USD	2025-06-04 13:04:25.945	2025-06-04 13:16:59.245	2025-06-04 13:04:25.944	\N	999000	0	\N	2025-06-04 13:04:25.945	2025-06-04 13:16:59.247	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhzmut20003mdcrtrubfnbb	f	\N	\N	USD	2025-06-04 13:33:13.718	2025-06-04 13:36:28.946	2025-06-04 13:33:13.716	\N	998200	0	\N	2025-06-04 13:33:13.718	2025-06-04 13:36:28.948	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbhzr1l20001mdqmsfmf1s85	f	\N	\N	USD	2025-06-04 13:36:29.126	2025-06-04 13:37:54.23	2025-06-04 13:36:29.124	\N	998200	0	\N	2025-06-04 13:36:29.126	2025-06-04 13:37:54.233	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi0g8gd0001mdbj5vs7qc1l	f	\N	\N	USD	2025-06-04 13:56:04.429	2025-06-04 14:27:11.027	2025-06-04 13:56:04.427	\N	997800	0	\N	2025-06-04 13:56:04.429	2025-06-04 14:27:11.033	3600	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi3b19p0001mdy9k4hw65gy	f	\N	\N	USD	2025-06-04 15:16:00.685	2025-06-04 15:17:02.24	2025-06-04 15:16:00.683	\N	989600	0	\N	2025-06-04 15:16:00.685	2025-06-04 15:17:02.241	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi1k8vg0001mdeejfatwwlp	f	\N	\N	USD	2025-06-04 14:27:11.212	2025-06-04 14:39:50.44	2025-06-04 14:27:11.21	\N	994200	0	\N	2025-06-04 14:27:11.212	2025-06-04 14:39:50.455	1000	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi3ccwe0003mdy95ssfnzz6	f	\N	\N	USD	2025-06-04 15:17:02.414	2025-06-04 15:17:21.253	2025-06-04 15:17:02.413	\N	989600	0	\N	2025-06-04 15:17:02.414	2025-06-04 15:17:21.255	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi23omj0001mduh6yp3b2cj	f	\N	\N	USD	2025-06-04 14:42:18.091	2025-06-04 15:16:00.502	2025-06-04 14:42:18.09	\N	992200	0	\N	2025-06-04 14:42:18.091	2025-06-04 15:16:00.504	2600	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi3crkw0005mdy9kocnci37	f	\N	\N	USD	2025-06-04 15:17:21.44	2025-06-04 15:30:34.725	2025-06-04 15:17:21.439	\N	989600	0	\N	2025-06-04 15:17:21.44	2025-06-04 15:30:34.727	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi3trta0001mdc8rmhs1odt	f	\N	\N	USD	2025-06-04 15:30:34.894	2025-06-04 15:37:45.518	2025-06-04 15:30:34.893	\N	989600	0	\N	2025-06-04 15:30:34.894	2025-06-04 15:37:45.52	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4307o0003mdc82ryaagkp	f	\N	\N	USD	2025-06-04 15:37:45.684	2025-06-04 15:38:50.225	2025-06-04 15:37:45.682	\N	989600	0	\N	2025-06-04 15:37:45.684	2025-06-04 15:38:50.227	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi44e5g0001md6ikqewut0o	f	\N	\N	USD	2025-06-04 15:38:50.404	2025-06-04 15:39:23.03	2025-06-04 15:38:50.403	\N	989600	0	\N	2025-06-04 15:38:50.404	2025-06-04 15:39:23.031	0	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4vect0003mdu536ajhrs0	f	\N	\N	USD	2025-06-04 15:59:50.381	2025-06-04 15:59:53.293	2025-06-04 15:59:50.38	\N	987800	0	\N	2025-06-04 15:59:50.381	2025-06-04 15:59:53.294	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4vgqm0005mdu550uie9aa	f	\N	\N	USD	2025-06-04 15:59:53.47	2025-06-04 15:59:55.93	2025-06-04 15:59:53.469	\N	987600	0	\N	2025-06-04 15:59:53.47	2025-06-04 15:59:55.931	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4visa0007mdu5z3adyhpr	f	\N	\N	USD	2025-06-04 15:59:56.122	2025-06-04 16:00:01.765	2025-06-04 15:59:56.12	\N	987400	0	\N	2025-06-04 15:59:56.122	2025-06-04 16:00:01.766	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N
cmbi4vna90009mdu5pybgtuge	t	\N	\N	USD	2025-06-04 16:00:01.953	\N	2025-06-04 16:00:01.952	\N	987200	0	\N	2025-06-04 16:00:01.953	2025-06-04 16:00:02.789	200	0	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqvuap005bmdgpz22hm62v	\N	\N	\N



--
-- TOC entry 4359 (class 0 OID 29726)
-- Dependencies: 334
-- Data for Name: game_spins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.game_spins (id, "spinData", "createdAt", "grossWinAmount", "currencyId", "spinNumber", "gameSessionId", "wagerAmount", "sessionId", "timeStamp") FROM stdin;
cmbhqvvbr008omdgpu9q1bdyf	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:17.751	0	USD	1	cmbhqvv62008mmdgp8mvm0nps	129	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:18:08.679
cmbhqvvho008qmdgp84e2oikv	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:17.965	0	USD	2	cmbhqvv62008mmdgp8mvm0nps	160	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:19:08.356
cmbhqvvnd008smdgpai7fxi28	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:28:18.169	0	USD	3	cmbhqvv62008mmdgp8mvm0nps	141	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:18:59.419
cmbhqvvt5008umdgp5uks43ey	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:28:18.377	99	USD	4	cmbhqvv62008mmdgp8mvm0nps	16	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:17:52.083
cmbhqvvz2008wmdgpaieso681	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:28:18.591	0	USD	5	cmbhqvv62008mmdgp8mvm0nps	464	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:19:22.519
cmbhqvw4u008ymdgphxokwsgb	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:18.798	0	USD	6	cmbhqvv62008mmdgp8mvm0nps	328	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:14:14.174
cmbhqvwah0090mdgp4t5exhio	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:19.002	0	USD	7	cmbhqvv62008mmdgp8mvm0nps	346	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:19:19.186
cmbhqvwgd0092mdgp3ri4aj91	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:19.213	0	USD	8	cmbhqvv62008mmdgp8mvm0nps	377	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:08:15.873
cmbhqvwm70094mdgpcwlfkm47	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:28:19.424	229	USD	9	cmbhqvv62008mmdgp8mvm0nps	54	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:08:10.929
cmbhqvwry0096mdgp1ds8c5m6	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:28:19.63	1525	USD	10	cmbhqvv62008mmdgp8mvm0nps	254	43623454-0ce6-4515-86ab-0a432f0e756a	2025-05-08 20:10:46.724
cmbhqvx96009amdgp6ule9awl	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:20.25	0	USD	1	cmbhqvx3d0098mdgp446zj7lq	372	9c6a55e8-eb5e-445d-9602-731b2dd3c329	2025-05-16 09:48:52.472
cmbhqvxex009cmdgp38kbklv9	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:28:20.458	69	USD	2	cmbhqvx3d0098mdgp446zj7lq	34	9c6a55e8-eb5e-445d-9602-731b2dd3c329	2025-05-16 09:45:54.955
cmbhqvxkp009emdgpjn69crfu	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:20.666	0	USD	3	cmbhqvx3d0098mdgp446zj7lq	348	9c6a55e8-eb5e-445d-9602-731b2dd3c329	2025-05-16 10:00:57.66
cmbhqvxqk009gmdgp0yv69wl9	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:28:20.877	1019	USD	4	cmbhqvx3d0098mdgp446zj7lq	421	9c6a55e8-eb5e-445d-9602-731b2dd3c329	2025-05-16 09:23:36.542
cmbhqvxw6009imdgpdr3w1fi1	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:28:21.079	0	USD	5	cmbhqvx3d0098mdgp446zj7lq	306	9c6a55e8-eb5e-445d-9602-731b2dd3c329	2025-05-16 09:41:43.275
cmbhqvy25009kmdgpy8wuv1w1	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:21.294	1002	USD	6	cmbhqvx3d0098mdgp446zj7lq	325	9c6a55e8-eb5e-445d-9602-731b2dd3c329	2025-05-16 10:10:32.802
cmbhqvy7x009mmdgppy1lugk9	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:28:21.501	0	USD	7	cmbhqvx3d0098mdgp446zj7lq	249	9c6a55e8-eb5e-445d-9602-731b2dd3c329	2025-05-16 10:23:16
cmbhqvyp1009qmdgp23ei4jqk	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:28:22.117	24	USD	1	cmbhqvyje009omdgp5ncy5117	194	26488fce-507f-4ce2-92df-72d259893609	2025-05-05 18:45:58.113
cmbhqvyuo009smdgpy4m6evya	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:22.321	0	USD	2	cmbhqvyje009omdgp5ncy5117	482	26488fce-507f-4ce2-92df-72d259893609	2025-05-05 17:53:05.256
cmbhqvz0c009umdgp2elw1wrg	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:28:22.524	25	USD	3	cmbhqvyje009omdgp5ncy5117	13	26488fce-507f-4ce2-92df-72d259893609	2025-05-05 17:44:08.777
cmbhqvz61009wmdgpr21vnrf5	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:28:22.73	0	USD	4	cmbhqvyje009omdgp5ncy5117	140	26488fce-507f-4ce2-92df-72d259893609	2025-05-05 18:41:56.132
cmbhqvzbp009ymdgpzfs41ezs	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:28:22.933	0	USD	5	cmbhqvyje009omdgp5ncy5117	262	26488fce-507f-4ce2-92df-72d259893609	2025-05-05 18:16:45.199
cmbhqvzst00a2mdgpbc15pecu	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:28:23.549	0	USD	1	cmbhqvzn600a0mdgphmhn5asd	289	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:22:40.939
cmbhqvzyh00a4mdgph4xjh410	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:28:23.754	0	USD	2	cmbhqvzn600a0mdgphmhn5asd	288	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:30:16.521
cmbhqw04600a6mdgpv8djmpr1	{"betLines": 20, "coinValue": "0.11"}	2025-06-04 09:28:23.958	0	USD	3	cmbhqvzn600a0mdgphmhn5asd	213	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:24:18.778
cmbhqw09u00a8mdgppf25nhpl	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:24.162	861	USD	4	cmbhqvzn600a0mdgphmhn5asd	483	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:12:41.879
cmbhqw0fk00aamdgpl3j9rymm	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:28:24.368	0	USD	5	cmbhqvzn600a0mdgphmhn5asd	254	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:03:38.426
cmbhqw0la00acmdgp83j16tkv	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:28:24.575	0	USD	6	cmbhqvzn600a0mdgphmhn5asd	303	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:06:26.099
cmbhqw0qy00aemdgp7fuubqob	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:24.778	0	USD	7	cmbhqvzn600a0mdgphmhn5asd	321	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:33:01.344
cmbhqw0wn00agmdgpd04fqttq	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:24.983	0	USD	8	cmbhqvzn600a0mdgphmhn5asd	91	68a5f90f-ac53-4c1a-8fcb-8de0fdbb05a3	2025-05-16 15:16:21.317
cmbhqw1dp00akmdgpddl8gew7	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:25.597	0	USD	1	cmbhqw18000aimdgpeql7v3r1	91	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 06:18:10.605
cmbhqw1jg00ammdgpyr6h8ous	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:28:25.804	0	USD	2	cmbhqw18000aimdgpeql7v3r1	255	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 06:16:21.231
cmbhqw1p900aomdgpc37q2dic	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:28:26.014	885	USD	3	cmbhqw18000aimdgpeql7v3r1	463	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 06:13:39.637
cmbhqw1uu00aqmdgpx1bxxcdo	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:26.214	0	USD	4	cmbhqw18000aimdgpeql7v3r1	313	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 05:48:35.035
cmbhqw20k00asmdgp9sv3wus3	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:28:26.42	0	USD	5	cmbhqw18000aimdgpeql7v3r1	359	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 06:06:02.139
cmbhqw26b00aumdgp6507c7tw	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:28:26.627	0	USD	6	cmbhqw18000aimdgpeql7v3r1	366	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 05:59:46.424
cmbhqw2c100awmdgphkf1xhi8	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:26.834	927	USD	7	cmbhqw18000aimdgpeql7v3r1	100	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 06:13:23.418
cmbhqw2hq00aymdgp3xjinkyb	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:28:27.038	73	USD	8	cmbhqw18000aimdgpeql7v3r1	56	6ac025c8-e405-4426-a8f8-7f8812217222	2025-05-17 05:45:34.314
cmbhqw2z300b2mdgpw02402y0	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:27.663	0	USD	1	cmbhqw2th00b0mdgpe6yn0u9h	438	0939c81d-f330-4ee9-808e-e9923dae940b	2025-05-10 13:45:34.29
cmbhqw34t00b4mdgpzo5ri62a	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:27.869	0	USD	2	cmbhqw2th00b0mdgpe6yn0u9h	102	0939c81d-f330-4ee9-808e-e9923dae940b	2025-05-10 13:23:22.178
cmbhqw3ag00b6mdgpyjdlaj9u	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:28.072	188	USD	3	cmbhqw2th00b0mdgpe6yn0u9h	125	0939c81d-f330-4ee9-808e-e9923dae940b	2025-05-10 13:53:58.454
cmbhqw3gb00b8mdgpf1rci2yi	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:28:28.284	0	USD	4	cmbhqw2th00b0mdgpe6yn0u9h	409	0939c81d-f330-4ee9-808e-e9923dae940b	2025-05-10 13:37:53.222
cmbhqw3m000bamdgpjmylavtw	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:28:28.488	0	USD	5	cmbhqw2th00b0mdgpe6yn0u9h	193	0939c81d-f330-4ee9-808e-e9923dae940b	2025-05-10 13:24:25.801
cmbhqw43700bemdgpf2mj11pr	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:28:29.107	0	USD	1	cmbhqw3xi00bcmdgpalcp7msl	182	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 19:13:31.289
cmbhqw48x00bgmdgprz6qtko8	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:29.313	0	USD	2	cmbhqw3xi00bcmdgpalcp7msl	486	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 18:48:53.763
cmbhqw4em00bimdgp8u9qkkt0	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:29.518	0	USD	3	cmbhqw3xi00bcmdgpalcp7msl	443	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 19:05:43.361
cmbhqw4kg00bkmdgp8jez58i5	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:28:29.728	825	USD	4	cmbhqw3xi00bcmdgpalcp7msl	499	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 18:26:50.624
cmbhqw4q200bmmdgph2mvs27a	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:28:29.93	699	USD	5	cmbhqw3xi00bcmdgpalcp7msl	255	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 18:45:43.232
cmbhqw4vn00bomdgp0kbibbtm	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:28:30.131	62	USD	6	cmbhqw3xi00bcmdgpalcp7msl	25	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 18:42:33.538
cmbhqw51c00bqmdgpec8c2guz	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:28:30.336	0	USD	7	cmbhqw3xi00bcmdgpalcp7msl	428	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 18:20:06.31
cmbhqw56z00bsmdgpkcr6izdp	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:28:30.539	0	USD	8	cmbhqw3xi00bcmdgpalcp7msl	493	e8038b93-372d-4d59-8ca6-f5f54340d745	2025-05-12 19:09:26.144
cmbhqw5o600bwmdgpnf7qbuqx	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:31.159	0	USD	1	cmbhqw5ig00bumdgpas4kj9lg	442	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:47:59.247
cmbhqw5tu00bymdgpra339e82	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:31.363	0	USD	2	cmbhqw5ig00bumdgpas4kj9lg	389	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:49:06.447
cmbhqw5zr00c0mdgpv9yuigev	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:28:31.575	713	USD	3	cmbhqw5ig00bumdgpas4kj9lg	390	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:49:22.461
cmbhqw65i00c2mdgpd00kkb4x	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:28:31.782	0	USD	4	cmbhqw5ig00bumdgpas4kj9lg	203	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:41:32.593
cmbhqw6b600c4mdgpih4r63z4	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:28:31.986	0	USD	5	cmbhqw5ig00bumdgpas4kj9lg	422	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:47:48.712
cmbhqw6gx00c6mdgpdhmw1ehm	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:32.194	0	USD	6	cmbhqw5ig00bumdgpas4kj9lg	331	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:43:04.12
cmbhqw6o500c8mdgpwoxw91mu	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:32.408	0	USD	7	cmbhqw5ig00bumdgpas4kj9lg	167	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:45:49.36
cmbhqw6tp00camdgpt3irpzyd	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:32.653	0	USD	8	cmbhqw5ig00bumdgpas4kj9lg	444	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:45:09.797
cmbhqw6zf00ccmdgpkazmf515	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:28:32.859	90	USD	9	cmbhqw5ig00bumdgpas4kj9lg	19	6f7383dd-1d4c-4a33-acb0-bca968235996	2025-05-17 00:43:46.687
cmbhqw7gg00cgmdgpu5h7t5fe	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:28:33.473	2	USD	1	cmbhqw7as00cemdgp1rwfz0bc	27	010c55d5-95f7-44b4-8f39-20408020e7e5	2025-05-11 00:01:15.679
cmbhqw7m700cimdgpt58v1usk	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:33.679	0	USD	2	cmbhqw7as00cemdgp1rwfz0bc	480	010c55d5-95f7-44b4-8f39-20408020e7e5	2025-05-11 01:09:53.855
cmbhqw7s000ckmdgpsalyqnlf	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:28:33.888	0	USD	3	cmbhqw7as00cemdgp1rwfz0bc	275	010c55d5-95f7-44b4-8f39-20408020e7e5	2025-05-10 23:52:09.411
cmbhqw7xt00cmmdgpy0ca9qtq	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:34.098	26	USD	4	cmbhqw7as00cemdgp1rwfz0bc	99	010c55d5-95f7-44b4-8f39-20408020e7e5	2025-05-11 01:05:26.962
cmbhqw83o00comdgpncz3nkmd	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:28:34.308	2039	USD	5	cmbhqw7as00cemdgp1rwfz0bc	361	010c55d5-95f7-44b4-8f39-20408020e7e5	2025-05-11 00:26:34.507
cmbhqw89700cqmdgp7ban8iw1	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:34.508	0	USD	6	cmbhqw7as00cemdgp1rwfz0bc	92	010c55d5-95f7-44b4-8f39-20408020e7e5	2025-05-11 00:59:21.825
cmbhqw8w800cumdgpk5xj0o1b	{"betLines": 20, "coinValue": "0.11"}	2025-06-04 09:28:35.337	738	USD	1	cmbhqw8kt00csmdgp0zm85wsy	224	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-28 07:03:34.967
cmbhqw91y00cwmdgpv7dq3ly7	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:28:35.542	0	USD	2	cmbhqw8kt00csmdgp0zm85wsy	63	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-27 17:58:54.046
cmbhqw97s00cymdgpkpt17ao0	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:35.752	116	USD	3	cmbhqw8kt00csmdgp0zm85wsy	371	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-23 19:35:52.178
cmbhqw9dr00d0mdgpukerzgve	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:28:35.968	0	USD	4	cmbhqw8kt00csmdgp0zm85wsy	420	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-26 04:00:58.252
cmbhqw9jk00d2mdgpkbl63wgf	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:28:36.176	52	USD	5	cmbhqw8kt00csmdgp0zm85wsy	14	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-19 23:01:00.765
cmbhqw9pa00d4mdgp4x975h5r	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:36.383	111	USD	6	cmbhqw8kt00csmdgp0zm85wsy	347	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-22 21:20:44.879
cmbhqw9uz00d6mdgpm2stpdrm	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:28:36.587	1163	USD	7	cmbhqw8kt00csmdgp0zm85wsy	276	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-27 23:24:08.014
cmbhqwa0x00d8mdgpebehikz4	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:36.801	0	USD	8	cmbhqw8kt00csmdgp0zm85wsy	124	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-21 16:49:49.191
cmbhqwa6t00damdgpxfxtmbst	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:37.014	299	USD	9	cmbhqw8kt00csmdgp0zm85wsy	152	f5001bbb-f197-49cc-bea7-0d215e6ca1cf	2025-05-25 05:56:45.898
cmbhqwaof00demdgp7iv9i6kz	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:28:37.647	1920	USD	1	cmbhqwaio00dcmdgpy3v2qdx5	420	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 22:38:12.54
cmbhqwau900dgmdgpzqfkm37z	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:37.857	924	USD	2	cmbhqwaio00dcmdgpy3v2qdx5	431	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 22:05:03.616
cmbhqwazz00dimdgpty488972	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:38.063	0	USD	3	cmbhqwaio00dcmdgpy3v2qdx5	333	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 21:47:18.557
cmbhqwb5o00dkmdgp8buke04c	{"betLines": 20, "coinValue": "0.11"}	2025-06-04 09:28:38.268	0	USD	4	cmbhqwaio00dcmdgpy3v2qdx5	228	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 21:58:20.282
cmbhqwbbc00dmmdgpn7djcyzc	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:38.473	0	USD	5	cmbhqwaio00dcmdgpy3v2qdx5	431	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 22:09:43.193
cmbhqwbh300domdgpgkg976m8	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:28:38.679	0	USD	6	cmbhqwaio00dcmdgpy3v2qdx5	402	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 22:38:37.246
cmbhqwbmq00dqmdgpd8w6a07y	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:38.882	0	USD	7	cmbhqwaio00dcmdgpy3v2qdx5	333	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 22:03:21.696
cmbhqwbsd00dsmdgp0o1nuk0z	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:39.086	873	USD	8	cmbhqwaio00dcmdgpy3v2qdx5	475	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 22:28:54.165
cmbhqwby100dumdgpcfe8x09e	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:39.289	758	USD	9	cmbhqwaio00dcmdgpy3v2qdx5	346	4261c84f-7c25-4b41-b894-3946f0c21c13	2025-05-13 22:31:47.637
cmbhqwckr00dymdgpkz769gc9	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:28:40.108	0	USD	1	cmbhqwc9d00dwmdgp5i0xtxa6	293	fa03107c-08ef-4726-a88c-869f9f47052b	2025-06-01 20:35:49.684
cmbhqwcqf00e0mdgpvhn8uuvf	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:28:40.311	0	USD	2	cmbhqwc9d00dwmdgp5i0xtxa6	199	fa03107c-08ef-4726-a88c-869f9f47052b	2025-05-29 14:16:10.995
cmbhqwcw500e2mdgp5irau04a	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:28:40.517	1778	USD	3	cmbhqwc9d00dwmdgp5i0xtxa6	310	fa03107c-08ef-4726-a88c-869f9f47052b	2025-05-31 02:49:41.576
cmbhqwd1v00e4mdgpzygyi1yy	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:40.724	195	USD	4	cmbhqwc9d00dwmdgp5i0xtxa6	386	fa03107c-08ef-4726-a88c-869f9f47052b	2025-05-28 10:54:08.597
cmbhqwd7j00e6mdgpbfxa83we	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:28:40.927	157	USD	5	cmbhqwc9d00dwmdgp5i0xtxa6	242	fa03107c-08ef-4726-a88c-869f9f47052b	2025-05-21 05:47:59.231
cmbhqwdd800e8mdgp63ygs1xr	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:28:41.132	858	USD	6	cmbhqwc9d00dwmdgp5i0xtxa6	139	fa03107c-08ef-4726-a88c-869f9f47052b	2025-05-19 20:14:00.608
cmbhqwdiz00eamdgp82foae78	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:28:41.339	0	USD	7	cmbhqwc9d00dwmdgp5i0xtxa6	279	fa03107c-08ef-4726-a88c-869f9f47052b	2025-05-16 07:37:00.304
cmbhqwe0g00eemdgpuduv84w5	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:41.968	0	USD	1	cmbhqwdul00ecmdgp4g0vqshk	123	373acc13-7876-4b19-bef6-433360ee376d	2025-05-25 17:47:25.812
cmbhqwe5y00egmdgpdao1r0et	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:28:42.166	445	USD	2	cmbhqwdul00ecmdgp4g0vqshk	352	373acc13-7876-4b19-bef6-433360ee376d	2025-05-25 18:37:54.473
cmbhqwebq00eimdgpuazqvhm3	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:28:42.374	0	USD	3	cmbhqwdul00ecmdgp4g0vqshk	497	373acc13-7876-4b19-bef6-433360ee376d	2025-05-25 18:07:51.074
cmbhqwehh00ekmdgpziv6slog	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:42.581	0	USD	4	cmbhqwdul00ecmdgp4g0vqshk	161	373acc13-7876-4b19-bef6-433360ee376d	2025-05-25 18:19:23.055
cmbhqwenb00emmdgp96wbwyjq	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:28:42.791	0	USD	5	cmbhqwdul00ecmdgp4g0vqshk	186	373acc13-7876-4b19-bef6-433360ee376d	2025-05-25 18:52:29.537
cmbhqwet300eomdgpfyty4psx	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:28:42.999	165	USD	6	cmbhqwdul00ecmdgp4g0vqshk	35	373acc13-7876-4b19-bef6-433360ee376d	2025-05-25 17:52:13.808
cmbhqweyu00eqmdgpg0xdgyvu	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:28:43.207	0	USD	7	cmbhqwdul00ecmdgp4g0vqshk	23	373acc13-7876-4b19-bef6-433360ee376d	2025-05-25 18:08:46.279
cmbhqwffz00eumdgp3pjm672l	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:43.823	0	USD	1	cmbhqwfac00esmdgpcipgyovl	373	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:48:36.621
cmbhqwfln00ewmdgpds64dk2g	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:28:44.027	0	USD	2	cmbhqwfac00esmdgpcipgyovl	344	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:44:37.682
cmbhqwfrd00eymdgp1qv8mwi5	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:28:44.233	0	USD	3	cmbhqwfac00esmdgpcipgyovl	53	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:50:59.619
cmbhqwfx400f0mdgp990mto78	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:44.44	0	USD	4	cmbhqwfac00esmdgpcipgyovl	108	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:51:30.233
cmbhqwg3400f2mdgp0bswhstx	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:44.656	0	USD	5	cmbhqwfac00esmdgpcipgyovl	159	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:44:14.499
cmbhqwg8p00f4mdgpsmt6jcct	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:44.857	0	USD	6	cmbhqwfac00esmdgpcipgyovl	124	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:54:28.106
cmbhqwgec00f6mdgp0a3gim16	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:28:45.06	0	USD	7	cmbhqwfac00esmdgpcipgyovl	454	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:42:55.489
cmbhqwgjz00f8mdgp6b7mlkte	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:45.263	0	USD	8	cmbhqwfac00esmdgpcipgyovl	440	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:41:02.962
cmbhqwgpp00famdgpkq1cihmk	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:45.469	4060	USD	9	cmbhqwfac00esmdgpcipgyovl	481	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:53:03.982
cmbhqwgve00fcmdgpfaoz6981	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:45.674	0	USD	10	cmbhqwfac00esmdgpcipgyovl	431	33a7de8d-8d87-49e7-881f-7cfe3b565a94	2025-06-01 20:50:37.326
cmbhqwhch00fgmdgpnnvell1j	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:28:46.29	0	USD	1	cmbhqwh6w00femdgp0pp8p0mo	174	b87b82f8-3561-4642-b022-0370381c2f23	2025-05-18 15:50:38.915
cmbhqwhi500fimdgps0bu04p0	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:46.493	0	USD	2	cmbhqwh6w00femdgp0pp8p0mo	316	b87b82f8-3561-4642-b022-0370381c2f23	2025-05-18 15:30:20.984
cmbhqwhnu00fkmdgpsrqw3o1h	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:46.699	0	USD	3	cmbhqwh6w00femdgp0pp8p0mo	155	b87b82f8-3561-4642-b022-0370381c2f23	2025-05-18 16:15:08.948
cmbhqwhti00fmmdgptt9vvctf	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:28:46.902	0	USD	4	cmbhqwh6w00femdgp0pp8p0mo	451	b87b82f8-3561-4642-b022-0370381c2f23	2025-05-18 15:38:03.84
cmbhqwhz800fomdgpqma6g3hy	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:28:47.108	0	USD	5	cmbhqwh6w00femdgp0pp8p0mo	494	b87b82f8-3561-4642-b022-0370381c2f23	2025-05-18 16:08:51.797
cmbhqwihb00fsmdgp34jovazq	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:47.76	0	USD	1	cmbhqwibt00fqmdgpezlxfpc0	486	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 15:09:50.243
cmbhqwin200fumdgp3exrmw30	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:47.966	420	USD	2	cmbhqwibt00fqmdgpezlxfpc0	158	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 15:47:09.882
cmbhqwiss00fwmdgp158jmdrv	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:28:48.172	12	USD	3	cmbhqwibt00fqmdgpezlxfpc0	49	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 15:38:51.501
cmbhqwiyi00fymdgplhlmwus5	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:28:48.378	0	USD	4	cmbhqwibt00fqmdgpezlxfpc0	139	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 14:27:02.667
cmbhqwj4400g0mdgp8teyd2vx	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:28:48.581	0	USD	5	cmbhqwibt00fqmdgpezlxfpc0	188	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 15:02:12.616
cmbhqwj9t00g2mdgpelmea5u7	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:28:48.785	602	USD	6	cmbhqwibt00fqmdgpezlxfpc0	230	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 15:19:14.942
cmbhqwjfk00g4mdgp6m4ewumf	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:28:48.992	0	USD	7	cmbhqwibt00fqmdgpezlxfpc0	135	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 15:35:34.07
cmbhqwjl500g6mdgpt2sidvht	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:28:49.194	1062	USD	8	cmbhqwibt00fqmdgpezlxfpc0	234	24d7daf5-a987-423b-b191-d2f6a69ae980	2025-05-21 15:01:11.962
cmbhqwk2600gamdgpary5eou3	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:49.807	0	USD	1	cmbhqwjwj00g8mdgp7b6jjxoi	120	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:43:24.476
cmbhqwk7r00gcmdgp77ozm22y	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:28:50.008	0	USD	2	cmbhqwjwj00g8mdgp7b6jjxoi	392	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:23:02.522
cmbhqwkdi00gemdgpvep9hv4u	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:28:50.214	0	USD	3	cmbhqwjwj00g8mdgp7b6jjxoi	187	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 12:04:20.581
cmbhqwkja00ggmdgpy0ew5zh2	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:28:50.423	1617	USD	4	cmbhqwjwj00g8mdgp7b6jjxoi	494	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:30:32.877
cmbhqwkp500gimdgp86wunf0c	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:28:50.633	335	USD	5	cmbhqwjwj00g8mdgp7b6jjxoi	423	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:59:01.601
cmbhqwkux00gkmdgp4cy9q2t9	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:50.841	0	USD	6	cmbhqwjwj00g8mdgp7b6jjxoi	165	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:36:11.977
cmbhqwl0k00gmmdgp7zhr5du8	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:51.045	0	USD	7	cmbhqwjwj00g8mdgp7b6jjxoi	320	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:22:11.248
cmbhqwl6700gomdgpojnh39ps	{"betLines": 20, "coinValue": "0.11"}	2025-06-04 09:28:51.248	0	USD	8	cmbhqwjwj00g8mdgp7b6jjxoi	219	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:58:03.728
cmbhqwlc100gqmdgp43w1u1qu	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:28:51.457	0	USD	9	cmbhqwjwj00g8mdgp7b6jjxoi	209	2b534e7a-37e4-49d4-97ed-b2ef30c81ce3	2025-05-07 11:42:49.796
cmbhqwlt200gumdgp47mwvgo4	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:52.07	0	USD	1	cmbhqwlnc00gsmdgpd8jriaqj	113	931fdf3c-55cb-46ed-8d25-0276b480834b	2025-05-10 05:20:01.96
cmbhqwlyq00gwmdgpud1eunu4	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:52.274	0	USD	2	cmbhqwlnc00gsmdgpd8jriaqj	473	931fdf3c-55cb-46ed-8d25-0276b480834b	2025-05-10 04:16:26.307
cmbhqwm4900gymdgpf86vpxo4	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:28:52.473	23	USD	3	cmbhqwlnc00gsmdgpd8jriaqj	81	931fdf3c-55cb-46ed-8d25-0276b480834b	2025-05-10 05:15:58.478
cmbhqwma500h0mdgpvxr9zwhr	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:28:52.685	1846	USD	4	cmbhqwlnc00gsmdgpd8jriaqj	479	931fdf3c-55cb-46ed-8d25-0276b480834b	2025-05-10 04:04:42.477
cmbhqwmft00h2mdgp9olq8oia	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:28:52.889	2244	USD	5	cmbhqwlnc00gsmdgpd8jriaqj	301	931fdf3c-55cb-46ed-8d25-0276b480834b	2025-05-10 05:27:07.224
cmbhqwmxd00h6mdgpa0qy1p65	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:28:53.521	0	USD	1	cmbhqwmrn00h4mdgpqzuse9kf	160	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:49:31.751
cmbhqwn3000h8mdgpbqegaeia	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:53.724	265	USD	2	cmbhqwmrn00h4mdgpqzuse9kf	437	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:06:34.085
cmbhqwn8q00hamdgp4hd2t6nx	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:53.93	0	USD	3	cmbhqwmrn00h4mdgpqzuse9kf	373	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:16:25.634
cmbhqwned00hcmdgp8knq89pf	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:28:54.134	465	USD	4	cmbhqwmrn00h4mdgpqzuse9kf	259	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:46:54.987
cmbhqwnk300hemdgp388p7guk	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:28:54.339	1025	USD	5	cmbhqwmrn00h4mdgpqzuse9kf	437	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:41:41.396
cmbhqwnpt00hgmdgp94ov9dfe	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:28:54.546	0	USD	6	cmbhqwmrn00h4mdgpqzuse9kf	421	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:46:40.703
cmbhqwnvk00himdgp5saf2xyt	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:28:54.753	441	USD	7	cmbhqwmrn00h4mdgpqzuse9kf	385	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 20:56:32.832
cmbhqwo1800hkmdgpkev905eg	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:28:54.957	0	USD	8	cmbhqwmrn00h4mdgpqzuse9kf	50	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:40:31.578
cmbhqwo6y00hmmdgp1q05ue09	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:55.162	0	USD	9	cmbhqwmrn00h4mdgpqzuse9kf	326	371f3008-0f7c-4eb7-9f07-0046f36af3c8	2025-05-10 21:38:20.348
cmbhqwont00hqmdgpb7jt9s0y	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:55.77	0	USD	1	cmbhqwoic00homdgptvk4mb1e	327	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:52:32.833
cmbhqwotr00hsmdgp5fn3qs96	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:28:55.983	13	USD	2	cmbhqwoic00homdgptvk4mb1e	114	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:51:13.305
cmbhqwozf00humdgpqyqewoev	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:28:56.188	493	USD	3	cmbhqwoic00homdgptvk4mb1e	275	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:41:43.887
cmbhqwp5500hwmdgph0njovkr	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:28:56.393	0	USD	4	cmbhqwoic00homdgptvk4mb1e	194	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 13:09:35.354
cmbhqwpau00hymdgp5vxdtqoz	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:28:56.598	0	USD	5	cmbhqwoic00homdgptvk4mb1e	293	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:50:02.733
cmbhqwpgk00i0mdgp0tlach8v	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:28:56.804	0	USD	6	cmbhqwoic00homdgptvk4mb1e	73	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:52:34.466
cmbhqwpmc00i2mdgpirngbzzt	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:28:57.012	0	USD	7	cmbhqwoic00homdgptvk4mb1e	238	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:28:39.782
cmbhqwps000i4mdgpsfqftv2k	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:28:57.217	0	USD	8	cmbhqwoic00homdgptvk4mb1e	262	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:42:26.033
cmbhqwpxv00i6mdgp2aoybmuy	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:28:57.427	165	USD	9	cmbhqwoic00homdgptvk4mb1e	150	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 12:44:37.565
cmbhqwq3k00i8mdgp9q79cb23	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:28:57.632	2287	USD	10	cmbhqwoic00homdgptvk4mb1e	498	1149a799-9652-403a-84bc-b8382406e9e0	2025-05-08 13:00:48.658
cmbhqwql000icmdgpza56g31s	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:28:58.26	65	USD	1	cmbhqwqf900iamdgpxaqrji3w	45	d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9	2025-05-28 19:41:02.005
cmbhqwqqq00iemdgpastkwkwj	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:28:58.467	443	USD	2	cmbhqwqf900iamdgpxaqrji3w	455	d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9	2025-05-28 19:33:57.489
cmbhqwqwg00igmdgpjyv0bvil	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:28:58.672	76	USD	3	cmbhqwqf900iamdgpxaqrji3w	80	d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9	2025-05-28 19:31:21.236
cmbhqwr2800iimdgpo6y5xpak	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:58.88	0	USD	4	cmbhqwqf900iamdgpxaqrji3w	314	d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9	2025-05-28 19:31:04.917
cmbhqwr7x00ikmdgp4x145ex5	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:28:59.085	1152	USD	5	cmbhqwqf900iamdgpxaqrji3w	313	d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9	2025-05-28 19:34:33.318
cmbhqwrdk00immdgpedlb1j37	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:28:59.288	0	USD	6	cmbhqwqf900iamdgpxaqrji3w	106	d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9	2025-05-28 19:42:26.317
cmbhqwrj900iomdgp21skg5rx	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:28:59.493	1125	USD	7	cmbhqwqf900iamdgpxaqrji3w	233	d8c55569-7e0c-4f21-b0bc-ba4fbedcaca9	2025-05-28 19:38:27.987
cmbhqws0c00ismdgp3uhycbbs	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:00.109	1958	USD	1	cmbhqwrup00iqmdgp5aq3gzwr	365	0ce73605-f95b-4638-bb24-a9b3d8ef1714	2025-05-21 18:53:15.845
cmbhqws6100iumdgp8rdeg9d0	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:00.314	0	USD	2	cmbhqwrup00iqmdgp5aq3gzwr	191	0ce73605-f95b-4638-bb24-a9b3d8ef1714	2025-05-21 18:52:55.999
cmbhqwsbv00iwmdgp1v53w1pd	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:00.523	483	USD	3	cmbhqwrup00iqmdgp5aq3gzwr	360	0ce73605-f95b-4638-bb24-a9b3d8ef1714	2025-05-21 18:49:55.3
cmbhqwshg00iymdgp1j0lkuic	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:29:00.725	847	USD	4	cmbhqwrup00iqmdgp5aq3gzwr	325	0ce73605-f95b-4638-bb24-a9b3d8ef1714	2025-05-21 18:44:47.231
cmbhqwsn400j0mdgpdznx4pu4	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:29:00.928	2945	USD	5	cmbhqwrup00iqmdgp5aq3gzwr	455	0ce73605-f95b-4638-bb24-a9b3d8ef1714	2025-05-21 18:46:53.005
cmbhqwsst00j2mdgpivmao89a	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:29:01.133	560	USD	6	cmbhqwrup00iqmdgp5aq3gzwr	126	0ce73605-f95b-4638-bb24-a9b3d8ef1714	2025-05-21 18:47:23.481
cmbhqwsyb00j4mdgpmuyyq43l	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:29:01.331	446	USD	7	cmbhqwrup00iqmdgp5aq3gzwr	435	0ce73605-f95b-4638-bb24-a9b3d8ef1714	2025-05-21 18:46:02.774
cmbhqwtfe00j8mdgpgh7itp06	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:29:01.947	0	USD	1	cmbhqwt9r00j6mdgpr080jpoz	94	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 20:51:49.287
cmbhqwtl300jamdgpax9wtn79	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:02.151	0	USD	2	cmbhqwt9r00j6mdgpr080jpoz	199	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 20:49:52.563
cmbhqwtqv00jcmdgpbrdf1h91	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:29:02.359	0	USD	3	cmbhqwt9r00j6mdgpr080jpoz	114	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 20:57:54.397
cmbhqwtxq00jemdgph40cgplb	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:29:02.563	0	USD	4	cmbhqwt9r00j6mdgpr080jpoz	131	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 21:04:51.024
cmbhqwu3b00jgmdgp2ueiypsi	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:29:02.807	0	USD	5	cmbhqwt9r00j6mdgpr080jpoz	259	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 21:13:03.061
cmbhqwu9500jimdgp0rt7w1y3	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:03.017	746	USD	6	cmbhqwt9r00j6mdgpr080jpoz	207	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 20:46:04.189
cmbhqwuev00jkmdgpmfqqqm0d	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:03.224	141	USD	7	cmbhqwt9r00j6mdgpr080jpoz	21	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 21:05:45.819
cmbhqwuko00jmmdgp37pfz1ys	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:03.433	0	USD	8	cmbhqwt9r00j6mdgpr080jpoz	210	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 21:02:12.724
cmbhqwuqh00jomdgp7wnm2rop	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:29:03.641	207	USD	9	cmbhqwt9r00j6mdgpr080jpoz	174	6b428212-7746-491e-af18-581b79b425d3	2025-05-21 21:07:51.68
cmbhqwv7m00jsmdgpzfgh80z8	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:29:04.258	2987	USD	1	cmbhqwv1v00jqmdgpcszh0bu4	334	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-04 00:00:56.73
cmbhqwvdb00jumdgpxy2yas3y	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:29:04.464	831	USD	2	cmbhqwv1v00jqmdgpcszh0bu4	421	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:23:58.775
cmbhqwvj100jwmdgp7ql7cur8	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:29:04.669	0	USD	3	cmbhqwv1v00jqmdgpcszh0bu4	86	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:37:51.628
cmbhqwvop00jymdgpwqnf6svx	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:29:04.873	0	USD	4	cmbhqwv1v00jqmdgpcszh0bu4	286	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:56:47.39
cmbhqwvue00k0mdgpjq1sg5r0	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:29:05.078	0	USD	5	cmbhqwv1v00jqmdgpcszh0bu4	97	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:49:31.59
cmbhqww0500k2mdgptztg07mf	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:29:05.285	0	USD	6	cmbhqwv1v00jqmdgpcszh0bu4	90	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:27:00.791
cmbhqww5w00k4mdgptdqgl6d7	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:29:05.492	66	USD	7	cmbhqwv1v00jqmdgpcszh0bu4	131	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:24:49.822
cmbhqwwbo00k6mdgpicoyx548	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:29:05.701	0	USD	8	cmbhqwv1v00jqmdgpcszh0bu4	429	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:32:27.093
cmbhqwwhf00k8mdgptsb9npox	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:29:05.907	2667	USD	9	cmbhqwv1v00jqmdgpcszh0bu4	404	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:45:01.925
cmbhqwwn300kamdgpwld1ufzg	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:29:06.111	0	USD	10	cmbhqwv1v00jqmdgpcszh0bu4	392	f651a6ac-1760-416d-9f5a-261bd99bc64d	2025-06-03 23:29:05.377
cmbhqwx4o00kemdgpe1jm6g63	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:29:06.744	0	USD	1	cmbhqwwz000kcmdgpo8qy2j4f	379	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 18:14:01.033
cmbhqwxaa00kgmdgp0ietb4tx	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:29:06.947	1346	USD	2	cmbhqwwz000kcmdgpo8qy2j4f	269	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 18:07:33.481
cmbhqwxg100kimdgpa4p6qhq5	{"betLines": 20, "coinValue": "0.11"}	2025-06-04 09:29:07.154	0	USD	3	cmbhqwwz000kcmdgpo8qy2j4f	217	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 18:03:35.813
cmbhqwxlr00kkmdgp63apczcg	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:07.36	0	USD	4	cmbhqwwz000kcmdgpo8qy2j4f	10	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 17:55:15.713
cmbhqwxre00kmmdgpwgryehb6	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:29:07.562	0	USD	5	cmbhqwwz000kcmdgpo8qy2j4f	45	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 17:35:37.089
cmbhqwxx200komdgpg35gp9pz	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:29:07.766	593	USD	6	cmbhqwwz000kcmdgpo8qy2j4f	343	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 17:51:18.957
cmbhqwy2r00kqmdgpykmsnmii	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:29:07.972	0	USD	7	cmbhqwwz000kcmdgpo8qy2j4f	449	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 18:19:45.869
cmbhqwy8l00ksmdgp8jvgjhos	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:29:08.181	0	USD	8	cmbhqwwz000kcmdgpo8qy2j4f	396	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 17:51:30.639
cmbhqwye900kumdgpfo5xjsy5	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:29:08.386	0	USD	9	cmbhqwwz000kcmdgpo8qy2j4f	471	fbe0903d-1115-4de8-bbfc-2de4736f3eda	2025-05-19 17:32:35.983
cmbhqwyvj00kymdgpc13vihmf	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:09.007	0	USD	1	cmbhqwypt00kwmdgpprxky151	14	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 20:28:19.731
cmbhqwz1700l0mdgpprm5i38z	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:29:09.212	0	USD	2	cmbhqwypt00kwmdgpprxky151	49	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 20:26:00.709
cmbhqwz6x00l2mdgprwbugnlf	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:29:09.417	0	USD	3	cmbhqwypt00kwmdgpprxky151	336	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 20:41:34.344
cmbhqwzcp00l4mdgpioo3i75v	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:09.626	1890	USD	4	cmbhqwypt00kwmdgpprxky151	360	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 19:31:40.171
cmbhqwzi500l6mdgpgqcm15rc	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:29:09.821	885	USD	5	cmbhqwypt00kwmdgpprxky151	293	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 19:22:17.718
cmbhqwznu00l8mdgp4xapcv5x	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:10.026	200	USD	6	cmbhqwypt00kwmdgpprxky151	203	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 20:03:10.732
cmbhqwztk00lamdgpwc6dk6dx	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:29:10.232	0	USD	7	cmbhqwypt00kwmdgpprxky151	166	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 19:44:04.454
cmbhqwzz800lcmdgpnsh6do6k	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:29:10.436	0	USD	8	cmbhqwypt00kwmdgpprxky151	238	1192ce16-8119-4b60-8de6-6896516cda76	2025-05-09 20:38:19.397
cmbhqx0ga00lgmdgp79ux3hxu	{"betLines": 20, "coinValue": "0.05"}	2025-06-04 09:29:11.05	0	USD	1	cmbhqx0al00lemdgp871asfgj	104	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:31:16.193
cmbhqx0lx00limdgpehb4473q	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:29:11.253	644	USD	2	cmbhqx0al00lemdgp871asfgj	435	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 15:01:01.126
cmbhqx0rl00lkmdgpnagnc7tw	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:29:11.457	0	USD	3	cmbhqx0al00lemdgp871asfgj	41	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:38:42.304
cmbhqx0xi00lmmdgp1dj0mnvn	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:29:11.67	313	USD	4	cmbhqx0al00lemdgp871asfgj	385	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:57:32.96
cmbhqx13l00lomdgptkrefufl	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:29:11.889	645	USD	5	cmbhqx0al00lemdgp871asfgj	470	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:56:39.33
cmbhqx19800lqmdgp21r5gk7q	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:29:12.092	29	USD	6	cmbhqx0al00lemdgp871asfgj	56	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:52:56.44
cmbhqx1ey00lsmdgpnhke3elc	{"betLines": 20, "coinValue": "0.16"}	2025-06-04 09:29:12.298	0	USD	7	cmbhqx0al00lemdgp871asfgj	318	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:47:31.725
cmbhqx1kl00lumdgp0aepmx4q	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:29:12.501	0	USD	8	cmbhqx0al00lemdgp871asfgj	377	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:53:04.524
cmbhqx1qa00lwmdgp8obsornt	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:12.706	0	USD	9	cmbhqx0al00lemdgp871asfgj	361	6d4974f8-4f60-40d6-b648-f991e7cea5ea	2025-05-20 14:52:21.999
cmbhqx27e00m0mdgpy8suxtky	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:29:13.323	0	USD	1	cmbhqx21r00lymdgp1ao0k2td	413	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 06:23:36.547
cmbhqx2d600m2mdgp1tipt2ka	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:29:13.531	0	USD	2	cmbhqx21r00lymdgp1ao0k2td	294	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:33:33.226
cmbhqx2ix00m4mdgppasmlao0	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:29:13.737	0	USD	3	cmbhqx21r00lymdgp1ao0k2td	140	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:03:46.556
cmbhqx2op00m6mdgpseefd6jf	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:29:13.945	0	USD	4	cmbhqx21r00lymdgp1ao0k2td	436	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:14:43.731
cmbhqx2uf00m8mdgpedtlxnx7	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:29:14.151	174	USD	5	cmbhqx21r00lymdgp1ao0k2td	52	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:08:05.665
cmbhqx30600mamdgp1cr82i7g	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:14.358	0	USD	6	cmbhqx21r00lymdgp1ao0k2td	203	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:52:33.976
cmbhqx35y00mcmdgp95xjtdbl	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:29:14.566	0	USD	7	cmbhqx21r00lymdgp1ao0k2td	413	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:52:12.527
cmbhqx3bo00memdgputm4kbn1	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:14.772	0	USD	8	cmbhqx21r00lymdgp1ao0k2td	357	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:47:50.073
cmbhqx3hf00mgmdgpdhbalfgd	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:29:14.98	389	USD	9	cmbhqx21r00lymdgp1ao0k2td	471	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 06:29:43.978
cmbhqx3nb00mimdgpjqq5ij8g	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:15.191	0	USD	10	cmbhqx21r00lymdgp1ao0k2td	15	48842f7a-fdbd-4eba-b3ba-5a75be387fd0	2025-05-28 05:44:41.009
cmbhqx44p00mmmdgp7kra61zb	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:29:15.818	117	USD	1	cmbhqx3z200mkmdgpm2qhg4v9	122	30447ee9-a859-4d25-a41b-19f1b0b1384d	2025-05-24 16:12:59.687
cmbhqx4af00momdgpp7afekuo	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:29:16.023	0	USD	2	cmbhqx3z200mkmdgpm2qhg4v9	62	30447ee9-a859-4d25-a41b-19f1b0b1384d	2025-05-24 16:01:48.762
cmbhqx4g800mqmdgp3ywyfvd6	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:16.233	25	USD	3	cmbhqx3z200mkmdgpm2qhg4v9	24	30447ee9-a859-4d25-a41b-19f1b0b1384d	2025-05-24 15:41:26.539
cmbhqx4lw00msmdgp7d6u4ykd	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:29:16.436	0	USD	4	cmbhqx3z200mkmdgpm2qhg4v9	394	30447ee9-a859-4d25-a41b-19f1b0b1384d	2025-05-24 15:54:09.473
cmbhqx4rn00mumdgpryhb2oxc	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:29:16.643	0	USD	5	cmbhqx3z200mkmdgpm2qhg4v9	299	30447ee9-a859-4d25-a41b-19f1b0b1384d	2025-05-24 15:59:39.01
cmbhqx4xf00mwmdgpyji6y7nq	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:16.851	0	USD	6	cmbhqx3z200mkmdgpm2qhg4v9	203	30447ee9-a859-4d25-a41b-19f1b0b1384d	2025-05-24 16:11:22.584
cmbhqx53800mymdgpxm1quv0b	{"betLines": 20, "coinValue": "0.11"}	2025-06-04 09:29:17.06	0	USD	7	cmbhqx3z200mkmdgpm2qhg4v9	211	30447ee9-a859-4d25-a41b-19f1b0b1384d	2025-05-24 16:00:38.809
cmbhqx5lq00n2mdgp2dp88h9l	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:29:17.684	0	USD	1	cmbhqx5et00n0mdgpkcfxoxkk	283	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:32:25.024
cmbhqx5rh00n4mdgpcyfxbk23	{"betLines": 20, "coinValue": "0.19"}	2025-06-04 09:29:17.933	0	USD	2	cmbhqx5et00n0mdgpkcfxoxkk	381	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:27:08.098
cmbhqx5x800n6mdgpkym05h9u	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:18.14	0	USD	3	cmbhqx5et00n0mdgpkcfxoxkk	29	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:26:30.153
cmbhqx62x00n8mdgpdlh8c3zq	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:18.346	0	USD	4	cmbhqx5et00n0mdgpkcfxoxkk	357	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:27:59.527
cmbhqx68o00namdgp32g9foce	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:29:18.552	0	USD	5	cmbhqx5et00n0mdgpkcfxoxkk	332	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:34:07.16
cmbhqx6ec00ncmdgpg5dhbjhm	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:29:18.756	791	USD	6	cmbhqx5et00n0mdgpkcfxoxkk	170	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:31:24.741
cmbhqx6kd00nemdgpr7aor4fp	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:29:18.973	0	USD	7	cmbhqx5et00n0mdgpkcfxoxkk	404	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:25:04.943
cmbhqx6q200ngmdgp632bt3mo	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:29:19.178	0	USD	8	cmbhqx5et00n0mdgpkcfxoxkk	307	31926c22-01db-4fba-8470-14235f286bc8	2025-05-24 17:33:21.389
cmbhqx77600nkmdgp27pmcvhc	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:29:19.795	2417	USD	1	cmbhqx71g00nimdgpkdxdmihe	497	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:54:54.502
cmbhqx7cu00nmmdgpe233pce7	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:29:19.998	72	USD	2	cmbhqx71g00nimdgpkdxdmihe	39	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:47:14.278
cmbhqx7ik00nomdgpr36fuzdv	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:29:20.204	0	USD	3	cmbhqx71g00nimdgpkdxdmihe	450	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:47:53.931
cmbhqx7oa00nqmdgp4n64dkmb	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:20.41	0	USD	4	cmbhqx71g00nimdgpkdxdmihe	191	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:42:54.512
cmbhqx7u100nsmdgpwuh45q7x	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:29:20.617	0	USD	5	cmbhqx71g00nimdgpkdxdmihe	71	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:41:42.724
cmbhqx7zx00numdgpq8pyz76m	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:29:20.829	0	USD	6	cmbhqx71g00nimdgpkdxdmihe	178	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:56:31.598
cmbhqx85s00nwmdgpk4agb0ws	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:29:21.04	1669	USD	7	cmbhqx71g00nimdgpkdxdmihe	267	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:52:31.925
cmbhqx8bq00nymdgpv572baqn	{"betLines": 20, "coinValue": "0.13"}	2025-06-04 09:29:21.254	272	USD	8	cmbhqx71g00nimdgpkdxdmihe	251	37503ad4-d7be-4adf-8dd2-d7f04302ce3e	2025-05-14 18:52:48.514
cmbhqx8sx00o2mdgp9n0qa6gd	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:29:21.873	0	USD	1	cmbhqx8n800o0mdgp96lof5ms	429	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:58:18.188
cmbhqx8ym00o4mdgp1ozy3nnv	{"betLines": 20, "coinValue": "0.25"}	2025-06-04 09:29:22.079	223	USD	2	cmbhqx8n800o0mdgp96lof5ms	493	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:45:35.759
cmbhqx94l00o6mdgpfva4z9lc	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:22.293	661	USD	3	cmbhqx8n800o0mdgp96lof5ms	200	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:53:55.864
cmbhqx9a700o8mdgpbj7ab539	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:29:22.495	945	USD	4	cmbhqx8n800o0mdgp96lof5ms	455	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:37:36.952
cmbhqx9fx00oamdgp7em5c6ti	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:29:22.702	287	USD	5	cmbhqx8n800o0mdgp96lof5ms	473	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:27:38.409
cmbhqx9lo00ocmdgpafr7e301	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:22.909	289	USD	6	cmbhqx8n800o0mdgp96lof5ms	352	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:22:03.449
cmbhqx9re00oemdgpe2cts39p	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:29:23.114	0	USD	7	cmbhqx8n800o0mdgp96lof5ms	412	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:56:23.037
cmbhqx9x400ogmdgpklgu2m54	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:29:23.32	445	USD	8	cmbhqx8n800o0mdgp96lof5ms	162	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 10:12:20.923
cmbhqxa2s00oimdgpkhu1tq5l	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:29:23.524	0	USD	9	cmbhqx8n800o0mdgp96lof5ms	343	a2038e03-dd60-4f2b-aa52-7ffaddbde09a	2025-05-17 09:57:30.089
cmbhqxako00ommdgppnxqvejo	{"betLines": 20, "coinValue": "0.03"}	2025-06-04 09:29:24.168	0	USD	1	cmbhqxaew00okmdgpe3jul65p	63	b317b683-f855-4951-b39e-c3b2bb75b781	2025-05-07 23:08:19.095
cmbhqxaqh00oomdgphg47uisr	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:29:24.378	0	USD	2	cmbhqxaew00okmdgpe3jul65p	75	b317b683-f855-4951-b39e-c3b2bb75b781	2025-05-07 23:54:01.355
cmbhqxaw500oqmdgpsf94xogu	{"betLines": 20, "coinValue": "0.08"}	2025-06-04 09:29:24.581	0	USD	3	cmbhqxaew00okmdgpe3jul65p	157	b317b683-f855-4951-b39e-c3b2bb75b781	2025-05-08 00:14:07.091
cmbhqxb2000osmdgp7j3rbmz0	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:29:24.792	0	USD	4	cmbhqxaew00okmdgpe3jul65p	147	b317b683-f855-4951-b39e-c3b2bb75b781	2025-05-07 23:44:59.227
cmbhqxb7t00oumdgpdptulnbv	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:29:25.002	117	USD	5	cmbhqxaew00okmdgpe3jul65p	473	b317b683-f855-4951-b39e-c3b2bb75b781	2025-05-07 23:47:43.24
cmbhqxbdp00owmdgp1gut788p	{"betLines": 20, "coinValue": "0.06"}	2025-06-04 09:29:25.213	0	USD	6	cmbhqxaew00okmdgpe3jul65p	129	b317b683-f855-4951-b39e-c3b2bb75b781	2025-05-08 00:36:31.418
cmbhqxbv200p0mdgp74wex4g0	{"betLines": 20, "coinValue": "0.12"}	2025-06-04 09:29:25.838	0	USD	1	cmbhqxbpf00oymdgpq3rpo12g	230	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 01:54:44.714
cmbhqxc0q00p2mdgp9ts47y9g	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:29:26.042	199	USD	2	cmbhqxbpf00oymdgpq3rpo12g	145	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 00:51:18.839
cmbhqxc6e00p4mdgph6oytq3x	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:26.247	0	USD	3	cmbhqxbpf00oymdgpq3rpo12g	25	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 01:25:20.73
cmbhqxcc200p6mdgpfzbjypg2	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:29:26.451	3	USD	4	cmbhqxbpf00oymdgpq3rpo12g	184	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 00:47:50.43
cmbhqxchs00p8mdgpfjbuzos9	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:29:26.656	538	USD	5	cmbhqxbpf00oymdgpq3rpo12g	484	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 01:22:26.874
cmbhqxcng00pamdgp7vhm97ac	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:29:26.86	0	USD	6	cmbhqxbpf00oymdgpq3rpo12g	35	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 00:54:55.212
cmbhqxct300pcmdgpwl1tbg18	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:29:27.063	0	USD	7	cmbhqxbpf00oymdgpq3rpo12g	189	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 01:21:51.217
cmbhqxcyu00pemdgp9k6pprwa	{"betLines": 20, "coinValue": "0.22"}	2025-06-04 09:29:27.27	0	USD	8	cmbhqxbpf00oymdgpq3rpo12g	449	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 01:06:28.835
cmbhqxd4k00pgmdgpryymgnsy	{"betLines": 20, "coinValue": "0.24"}	2025-06-04 09:29:27.476	2417	USD	9	cmbhqxbpf00oymdgpq3rpo12g	484	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 01:55:04.048
cmbhqxdaf00pimdgpf84l97mq	{"betLines": 20, "coinValue": "0.18"}	2025-06-04 09:29:27.688	1184	USD	10	cmbhqxbpf00oymdgpq3rpo12g	357	722bc36e-463d-4b6a-9b5a-c807e7545a57	2025-05-08 01:51:38.877
cmbhqxds400pmmdgpica5v1rp	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:28.324	809	USD	1	cmbhqxdme00pkmdgpgc8bbkjm	208	756b7893-ff0e-4756-ba05-f3f665b7a414	2025-05-21 12:33:46.913
cmbhqxdxs00pomdgpxivvtzco	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:29:28.528	0	USD	2	cmbhqxdme00pkmdgpgc8bbkjm	131	756b7893-ff0e-4756-ba05-f3f665b7a414	2025-05-21 13:20:32.958
cmbhqxe3k00pqmdgp2ysdu4ry	{"betLines": 20, "coinValue": "0.07"}	2025-06-04 09:29:28.736	748	USD	3	cmbhqxdme00pkmdgpgc8bbkjm	141	756b7893-ff0e-4756-ba05-f3f665b7a414	2025-05-21 12:43:42.663
cmbhqxe9800psmdgp9i3ix6d6	{"betLines": 20, "coinValue": "0.14"}	2025-06-04 09:29:28.94	126	USD	4	cmbhqxdme00pkmdgpgc8bbkjm	286	756b7893-ff0e-4756-ba05-f3f665b7a414	2025-05-21 12:44:27.033
cmbhqxeex00pumdgp2gur6tpu	{"betLines": 20, "coinValue": "0.17"}	2025-06-04 09:29:29.145	0	USD	5	cmbhqxdme00pkmdgpgc8bbkjm	348	756b7893-ff0e-4756-ba05-f3f665b7a414	2025-05-21 12:46:00.414
cmbhqxeks00pwmdgpi0umwjg6	{"betLines": 20, "coinValue": "0.20"}	2025-06-04 09:29:29.356	0	USD	6	cmbhqxdme00pkmdgpgc8bbkjm	398	756b7893-ff0e-4756-ba05-f3f665b7a414	2025-05-21 13:11:49.633
cmbhqxf1s00q0mdgpn1hs2zz0	{"betLines": 20, "coinValue": "0.09"}	2025-06-04 09:29:29.968	0	USD	1	cmbhqxew400pymdgp6ielmxv9	170	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 01:17:50.705
cmbhqxf7g00q2mdgpw9jsqn4a	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:30.172	9	USD	2	cmbhqxew400pymdgp6ielmxv9	15	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 01:04:46.629
cmbhqxfd900q4mdgp4jiwch13	{"betLines": 20, "coinValue": "0.21"}	2025-06-04 09:29:30.381	1313	USD	3	cmbhqxew400pymdgp6ielmxv9	411	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 01:44:22.834
cmbhqxfiv00q6mdgplik628v0	{"betLines": 20, "coinValue": "0.02"}	2025-06-04 09:29:30.584	0	USD	4	cmbhqxew400pymdgp6ielmxv9	45	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 01:10:16.958
cmbhqxfon00q8mdgpotac69vc	{"betLines": 20, "coinValue": "0.01"}	2025-06-04 09:29:30.791	3	USD	5	cmbhqxew400pymdgp6ielmxv9	11	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 00:48:27.752
cmbhqxfub00qamdgp141pfgij	{"betLines": 20, "coinValue": "0.04"}	2025-06-04 09:29:30.995	401	USD	6	cmbhqxew400pymdgp6ielmxv9	88	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 01:30:11.744
cmbhqxg0100qcmdgpt71itbu9	{"betLines": 20, "coinValue": "0.10"}	2025-06-04 09:29:31.201	0	USD	7	cmbhqxew400pymdgp6ielmxv9	208	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 00:54:45.05
cmbhqxg5u00qemdgpfwv3t1w8	{"betLines": 20, "coinValue": "0.15"}	2025-06-04 09:29:31.41	0	USD	8	cmbhqxew400pymdgp6ielmxv9	294	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 01:15:55.75
cmbhqxgbl00qgmdgp3j8282nf	{"betLines": 20, "coinValue": "0.23"}	2025-06-04 09:29:31.617	314	USD	9	cmbhqxew400pymdgp6ielmxv9	451	e5234451-1192-4de2-94da-4189394c7d6c	2025-05-11 00:43:45.457
cmbhxczrpovukngid	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 12:29:33.959	0	USD	0	cmbhwtfg70005mdgfkopfh1fz	200	0	2025-06-04 12:29:33.959
cmbhxfmm36a0pu18e	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 12:31:36.849	0	USD	0	cmbhwtfg70005mdgfkopfh1fz	200	0	2025-06-04 12:31:36.849
cmbhxfoflheillrx6	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 12:31:39.226	0	USD	0	cmbhwtfg70005mdgfkopfh1fz	200	0	2025-06-04 12:31:39.226
cmbhxfpxli0h7eskh	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 12:31:41.37	0	USD	0	cmbhwtfg70005mdgfkopfh1fz	200	0	2025-06-04 12:31:41.37
cmbhxfrp9efpod2lc	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 12:31:43.645	0	USD	0	cmbhwtfg70005mdgfkopfh1fz	200	0	2025-06-04 12:31:43.645
cmbhz0xyq1axfw1qg	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:16:10.978	0	USD	0	cmbhyltnd0003mdc9j1kl81qh	200	0	2025-06-04 13:16:10.978
cmbhz2f574dj8pkgn	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:17:19.889	0	USD	0	cmbhz2cbd0001mdcrduwzt7f4	200	0	2025-06-04 13:17:19.889
cmbhz2hd3acso48u1	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:17:22.752	0	USD	0	cmbhz2cbd0001mdcrduwzt7f4	200	0	2025-06-04 13:17:22.752
cmbhz9c7ioffv9s8m	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:22:42.684	0	USD	0	cmbhz2cbd0001mdcrduwzt7f4	200	0	2025-06-04 13:22:42.684
cmbhzsxuo0zsgmxw4	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:37:57.185	0	USD	0	cmbhzsve90001md9coqjai4lm	200	0	2025-06-04 13:37:57.185
cmbhzt0yx8czthsvh	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:38:01.229	0	USD	0	cmbhzsve90001md9coqjai4lm	200	0	2025-06-04 13:38:01.229
cmbi0gb3eer4k97j8	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:07.433	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:07.433
cmbi0gexfmyxpbpep	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:12.405	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:12.405
cmbi0ghkasbic5ysp	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:15.822	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:15.822
cmbi0gj43r77474au	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:17.848	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:17.848
cmbi0gkhzkb3lmxlm	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:19.658	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:19.658
cmbi0h12ebfykvxxg	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:41.093	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:41.093
cmbi0h2marnwfngkq	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:43.09	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:43.09
cmbi0h417cn25lhel	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:44.938	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:44.938
cmbi0h59ekn7za3uy	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:46.732	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:46.732
cmbi0h6jno22jyvpx	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 13:56:48.405	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 13:56:48.405
cmbi10uio3x0w3gps	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:05.738	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:05.738
cmbi11i8p8cm08my9	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:36.476	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:36.476
cmbi11jtvy99dibz3	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:38.541	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:38.541
cmbi11lztvdtvypn9	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:41.347	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:41.347
cmbi11nbwdoqgc63n	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:43.083	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:43.083
cmbi11qt45kh47st0	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:47.579	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:47.579
cmbi11sc1d23a5tpx	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:49.568	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:49.568
cmbi11u2uledy2n7c	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:12:51.811	0	USD	0	cmbi0g8gd0001mdbj5vs7qc1l	200	0	2025-06-04 14:12:51.811
cmbi1kavi26utk4c2	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:27:13.391	0	USD	0	cmbi1k8vg0001mdeejfatwwlp	200	0	2025-06-04 14:27:13.391
cmbi1kdak9xjwjj9y	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:27:16.536	0	USD	0	cmbi1k8vg0001mdeejfatwwlp	200	0	2025-06-04 14:27:16.536
cmbi1kew94uns1ioq	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:27:18.593	0	USD	0	cmbi1k8vg0001mdeejfatwwlp	200	0	2025-06-04 14:27:18.593
cmbi1kgf2n4sw5k4d	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:27:20.575	0	USD	0	cmbi1k8vg0001mdeejfatwwlp	200	0	2025-06-04 14:27:20.575
cmbi1khujubxfpckk	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:27:22.437	0	USD	0	cmbi1k8vg0001mdeejfatwwlp	200	0	2025-06-04 14:27:22.437
cmbi20lmcfxsz3t6v	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:39:53.821	0	USD	0	cmbi20iv00001mdsvk63r12bh	200	0	2025-06-04 14:39:53.821
cmbi20ne9i8p3qq61	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:39:56.11	0	USD	0	cmbi20iv00001mdsvk63r12bh	200	0	2025-06-04 14:39:56.11
cmbi20p0kb0wc0zr1	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:39:58.217	0	USD	0	cmbi20iv00001mdsvk63r12bh	200	0	2025-06-04 14:39:58.217
cmbi20qegzueqx1fa	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:39:59.998	0	USD	0	cmbi20iv00001mdsvk63r12bh	200	0	2025-06-04 14:39:59.998
cmbi20ru6gp5j9sdv	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:40:01.861	0	USD	0	cmbi20iv00001mdsvk63r12bh	200	0	2025-06-04 14:40:01.861
cmbi23qkgews58pg8	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:42:20.179	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:42:20.179
cmbi23s9mc7k59jld	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:42:22.383	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:42:22.383
cmbi23twmhivp6b0r	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:42:24.494	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:42:24.494
cmbi23vbsdhb6hyb8	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:42:26.318	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:42:26.318
cmbi23wr57edo8esi	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:42:28.208	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:42:28.208
cmbi23y9vczh9htvg	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:42:30.183	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:42:30.183
cmbi284dqe4pfp6k5	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:45:44.706	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:45:44.706
cmbi285m3x0jqgj4y	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:45:46.522	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:45:46.522
cmbi286s8bn3se6jc	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:45:48.039	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:45:48.039
cmbi287xce5lxwes9	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:45:49.524	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:45:49.524
cmbi288y8sfmed9ka	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:45:50.845	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:45:50.845
cmbi289vgfh7t151o	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:45:52.049	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:45:52.049
cmbi28ayl8jt18q0g	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 14:45:53.448	0	USD	0	cmbi23omj0001mduh6yp3b2cj	200	0	2025-06-04 14:45:53.448
cmbi4b6pwb8qez0up	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:44:06.938	0	USD	0	cmbi4b5mo0001mdh9pkz57opx	200	quick-test-1749051844	2025-06-04 15:44:06.938
cmbi4ebvma005dfuz	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:46:33.593	0	USD	0	cmbi4eayy0003mdh9s73ffobi	200	quick-test-1749051991	2025-06-04 15:46:33.593
cmbi4ekr6zklbiou7	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:46:45.082	0	USD	0	cmbi4ejue0005mdh9xz32nym3	200	quick-test-1749052003	2025-06-04 15:46:45.082
cmbi4eotsfld5d9zr	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:46:50.399	0	USD	0	cmbi4enxz0007mdh9ivgdqfk8	200	quick-test-1749052008	2025-06-04 15:46:50.399
cmbi4nb50uhwz0mre	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:53:32.542	0	USD	0	cmbi4n9zs0001md0milnlabdv	200	quick-test-1749052410	2025-06-04 15:53:32.542
cmbi4nn26b2qkli3e	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:53:48.011	0	USD	0	cmbi4nm670003md0meizoa0et	200	quick-test-1749052426	2025-06-04 15:53:48.011
cmbi4nrff4puh549x	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:53:53.679	0	USD	0	cmbi4nqj40005md0m5wfbl0vh	200	quick-test-1749052431	2025-06-04 15:53:53.679
cmbi4nvdcc2cbisp0	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:53:58.773	0	USD	0	cmbi4nugl0007md0m9mzrhjbv	200	quick-test-1749052436	2025-06-04 15:53:58.773
cmbi4v9gjrbjv16zd	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:59:43.618	0	USD	0	cmbi4v8bq0001mdu5ilyv1kmc	200	quick-test-1749052781	2025-06-04 15:59:43.618
cmbi4vfa8exq3dxjh	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:59:51.173	0	USD	0	cmbi4vect0003mdu536ajhrs0	200	quick-test-1749052789	2025-06-04 15:59:51.173
cmbi4vholi488b3q9	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:59:54.285	0	USD	0	cmbi4vgqm0005mdu550uie9aa	200	quick-test-1749052792	2025-06-04 15:59:54.285
cmbi4vjrg18ay8qy9	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 15:59:56.962	0	USD	0	cmbi4visa0007mdu5z3adyhpr	200	quick-test-1749052794	2025-06-04 15:59:56.962
cmbi4vo993v8h7v6f	"{\\"providerRoundId\\":\\"202900066\\",\\"rgsRawResponse\\":{\\"transactions\\":{\\"roundId\\":202900066},\\"user\\":{\\"balance\\":{\\"cash\\":{\\"atStart\\":\\"114.00\\",\\"afterBet\\":\\"112.00\\",\\"atEnd\\":\\"112.00\\"},\\"freeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"bonus\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionCash\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"},\\"sessionFreeBets\\":{\\"atStart\\":\\"0.00\\",\\"afterBet\\":\\"0.00\\",\\"atEnd\\":\\"0.00\\"}},\\"canGamble\\":false,\\"userId\\":7427503,\\"sessionId\\":\\"0\\",\\"sessionNetPosition\\":\\"12.00\\",\\"token\\":\\"db23b6e00877ad73f7a8214dfc5796f01b7afffbb1747e4931bf44d57532f3f61386735ffafd94652b352aa9d5c4d6cdc9befeae79657a1b10065b48e1b71f1a\\",\\"bonuses\\":[],\\"tournaments\\":[],\\"vouchers\\":[],\\"messages\\":[],\\"limits\\":{\\"betThresholdTime\\":925},\\"serverTime\\":\\"2025-02-20 14:46:16\\"},\\"game\\":{\\"win\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"winsMultipliers\\":{\\"lines\\":\\"0.00\\",\\"total\\":\\"0.00\\"},\\"stake\\":\\"2.00\\",\\"multiplier\\":1,\\"winLines\\":[],\\"spinMode\\":\\"Normal\\",\\"fatTiles\\":[{\\"tileId\\":10,\\"reel\\":3,\\"index\\":2,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":4,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":6,\\"width\\":1,\\"height\\":1,\\"multiplier\\":2,\\"amount\\":\\"4.00\\"},{\\"tileId\\":10,\\"reel\\":4,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"},{\\"tileId\\":10,\\"reel\\":3,\\"index\\":0,\\"width\\":1,\\"height\\":1,\\"multiplier\\":5,\\"amount\\":\\"10.00\\"}],\\"scatters\\":[],\\"reelsBuffer\\":[[[7,7,2],[3,8,4,2],[2,14,2]],[[7,5,5],[1,4,2,4],[4,5,9]],[[3,3,1],[2,9,6,8],[3,8,3]],[[5,7,5],[10,1,10,8],[10,14,10]],[[3,3,6],[10,9,7,3],[2,4,2]]],\\"features\\":[],\\"hasState\\":false},\\"jackpots\\":null,\\"bonusChance\\":null}}"	2025-06-04 16:00:02.789	0	USD	0	cmbi4vna90009mdu5pybgtuge	200	quick-test-1749052800	2025-06-04 16:00:02.789



--
-- TOC entry 4357 (class 0 OID 29699)
-- Dependencies: 332
-- Data for Name: games; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.games (id, name, title, "goldsvetData", description, "supportedProviders", category, tags, "isActive", "thumbnailUrl", "bannerUrl", meta, "createdAt", "updatedAt", featured, "providerName", "totalWagered", "gameProviderId", "operatorId", "tournamentDirectives", status, checked) FROM stdin;
cmbhqvuap005amdgpsqdu2o1y	AncientDiscoRTG	Ancient Disco	{"id": "13505", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005bmdgpz22hm62v	BassBossRTG	Bass Boss	{"id": "13512", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005cmdgpzvh5q3vd	BlazingClustersRTG	Blazing Clusters	{"id": "13514", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005dmdgp9g091962	CashOrNothingRTG	Cash Or Nothing	{"id": "13503", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005emdgp0mzz9sed	BugsysBarRTG	Bugsys Bar	{"id": "13518", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005fmdgp1yyiy3s4	BountyRaid2RTG	Bounty Raid2	{"id": "13517", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005gmdgp5mxpqvke	BloodSuckersMegaWaysRTG	Blood Suckers	{"id": "13516", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005hmdgp9iu6uahy	BlobstersClusterbusterRTG	Blobsters Clusterbuster	{"id": "13515", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005imdgp3kchbmx7	CirqueDeLaFortuneRTG	Cirque De LaFortune	{"id": "13523", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005jmdgphx4hsyq0	ChristmasMultihopsRTG	Christmas Multihops	{"id": "13522", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005kmdgpu8v6g3k9	ChristmasMorningRTG	Christmas Morning	{"id": "13521", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuap005lmdgp8ipvmum8	DiceDiceDiceRTG	Dice Dice Dice	{"id": "13527", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005mmdgpwwo2gj0e	DivineWaysRTG	Divine Ways	{"id": "13528", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005nmdgp585myoxh	DesertLegendsSpinsRTG	Desert Legends Spins	{"id": "13526", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005omdgpuostmskk	CloverCrazeRTG	Clover Craze	{"id": "13525", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "6", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005pmdgpt12w0pqv	DragonsMirrorRTG	Dragons Mirror	{"id": "13531", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005qmdgpmna46zzs	DynamiteRichesRTG	Dynamite Riches	{"id": "13532", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005rmdgpuddirg8n	EasyGoldRTG	Easy Gold	{"id": "13533", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005smdgp3ltenjb5	EmeraldDiamondRTG	Emerald Diamond	{"id": "13534", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005tmdgp422lphgp	GemsInfernoMegaWaysRTG	Gems Inferno	{"id": "13539", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005umdgpiojgsa9i	FaFaBabiesRTG	FaFa Babies	{"id": "13536", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005vmdgppvixjzcm	EuropeanRouletteRTG	European Roulette	{"id": "13535", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005wmdgp1gsfht8n	FlodderRTG	Flodder	{"id": "13537", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005xmdgpcnebufuq	GodOfWealthRTG	God Of Wealth	{"id": "13542", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005ymdgpxn0itswl	GonzitasQuestRTG	Gonzitas Quest	{"id": "13544", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq005zmdgp9twey0w8	GetTheGoldInfinireelsRTG	Get TheGold	{"id": "13540", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq0060mdgphzqs5uve	GodsOfTroyRTG	Gods Of Troy	{"id": "13543", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq0061mdgplhde4zut	LastChanceSaloonRTG	LastChance Saloon	{"id": "13547", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq0062mdgplhwepm3z	HappyApplesRTG	Happy Apples	{"id": "13545", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaq0063mdgp7ueu9zuf	LeprechaunsMagicRTG	Leprechauns Magic	{"id": "13548", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar0064mdgpjtifarpb	JingleBellsRTG	Jingle Bells	{"id": "13546", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar0065mdgpcfx4yy2n	PeggySweetsRTG	Peggy Sweets	{"id": "13554", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar0066mdgp6fwh55o3	LuckyEasterRTG	Lucky Easter	{"id": "13550", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar0067mdgpi1dg1mkh	MagicGateRTG	Magic Gate	{"id": "13551", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar0068mdgpirbbywsw	MonstersUnchainedRTG	Monsters Unchained	{"id": "13552", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar0069mdgpcq38bg7s	ReelKingMegaRTG	Reel King	{"id": "13557", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006amdgp8k1jddcr	PersianFortuneRTG	Persian Fortune	{"id": "13555", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006bmdgpew4n8vrg	RedDiamondRTG	Red Diamond	{"id": "13556", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006cmdgpn8ptnpce	SantaSpinsRTG	SantaSpins	{"id": "13558", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006dmdgp1pqguvgk	SpookyCarnivalRTG	SpookyCarnival	{"id": "13562", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006emdgpmbbglhfr	SirensRichesRTG	SirensRiches	{"id": "13560", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006fmdgpy2fob1y0	SnowWildAndThe7FeaturesRTG	SnowWildAndThe7Features	{"id": "13561", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006gmdgpnoatqbnr	Stage888RTG	Stage888	{"id": "13563", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuar006hmdgpicm1jo8i	SugarliciousEveryWayRTG	SugarliciousEveryWay	{"id": "13567", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006imdgp4yt775s7	SumoSpinsRTG	SumoSpins	{"id": "13568", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006jmdgp7czbz5u5	SteamSquadRTG	SteamSquad	{"id": "13565", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006kmdgp35tub8o8	SugarMonsterRTG	SugarMonster	{"id": "13566", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006lmdgpb7x9honi	YearRoundRichesClusterbusterRTG	YearRoundRichesClusterbuster	{"id": "13574", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006mmdgpxlsdrlyg	WantedWildzExtremeRTG	WantedWildzExtreme	{"id": "13573", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006nmdgp2qhvyadk	VaultCrackerMegaWaysRTG	VaultCrackerMegaWays	{"id": "13571", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006omdgpdulhsu7c	TreasureMineRTG	TreasureMine	{"id": "13570", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006pmdgp4wtt3s6t	SpaceCatKA	Space Cat	{"id": "12147", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "299", "cask": "1", "type": "1", "view": "1", "label": "1", "active": "true", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "1", "stat_in": "59.8000", "advanced": "1", "gamebank": "fish", "stat_out": "47.4000", "developer": "kickass", "scalemode": "1", "vip_level": "5", "created_at": "2021-09-08 03:00:25", "popularity": "9", "updated_at": "2021-09-08 03:00:25", "current_rtp": "", "original_id": "1053", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{KICKASS}	OTHER	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	t	\N	0	cmbhqvqnr004zmdgpu6kglpp2	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006qmdgpfnlow965	GoldenDragonKA	Golden Dragon	{"id": "13238", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "1", "type": "1", "view": "1", "label": "1", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "3", "stat_in": "0.0000", "advanced": "1", "gamebank": "fish", "stat_out": "0.0000", "developer": "kickass", "scalemode": "1", "vip_level": "5", "created_at": "2022-08-29 16:03:55", "popularity": "1", "updated_at": "2022-08-29 16:03:55", "current_rtp": "", "original_id": "1052", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{KICKASS}	OTHER	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqnr004zmdgpu6kglpp2	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006rmdgppmuywrpp	ParadiseCQ9	Paradise	{"id": "13226", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "1", "type": "1", "view": "1", "label": "1", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "3", "stat_in": "0.0000", "advanced": "1", "gamebank": "fish", "stat_out": "0.0000", "developer": "cqnine", "scalemode": "1", "vip_level": "5", "created_at": "2022-08-29 16:03:55", "popularity": "1", "updated_at": "2022-08-29 16:03:55", "current_rtp": "", "original_id": "1040", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{CQNINE}	OTHER	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvrlg0052mdgp824lmait	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006smdgpp1w52gld	FireInTheHole2NLC	Fire In The Hole 2	{"id": "13589", "bet": "1", "bids": "", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "", "jpg_id": "", "rezerv": "", "shop_id": "1", "stat_in": "", "advanced": "1", "gamebank": "slots", "stat_out": "", "developer": "nolimit", "scalemode": "1", "vip_level": "0", "created_at": "2020-01-30 00:00:00", "popularity": "8", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{NOLIMIT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	t	\N	0	cmbhqvrwu0053mdgpdx66fzpk	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006tmdgp84zizuof	TheCryptNLC	The Crypt	{"id": "13591", "bet": "1", "bids": "", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "", "jpg_id": "", "rezerv": "", "shop_id": "1", "stat_in": "", "advanced": "1", "gamebank": "slots", "stat_out": "", "developer": "nolimit", "scalemode": "1", "vip_level": "0", "created_at": "2020-01-30 00:00:00", "popularity": "8", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{NOLIMIT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvrwu0053mdgpdx66fzpk	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006umdgpaqil3otb	LandOfTheFreeNLC	Land of the Free	{"id": "13590", "bet": "1", "bids": "", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "", "jpg_id": "", "rezerv": "", "shop_id": "1", "stat_in": "", "advanced": "1", "gamebank": "slots", "stat_out": "", "developer": "nolimit", "scalemode": "1", "vip_level": "0", "created_at": "2020-01-30 00:00:00", "popularity": "7", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{NOLIMIT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvrwu0053mdgpdx66fzpk	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuas006vmdgpesquypp0	SanQuentinNLC	San Quentin	{"id": "13588", "bet": "1", "bids": "", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "", "jpg_id": "", "rezerv": "", "shop_id": "1", "stat_in": "", "advanced": "1", "gamebank": "slots", "stat_out": "", "developer": "nolimit", "scalemode": "1", "vip_level": "0", "created_at": "2020-01-30 00:00:00", "popularity": "6", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{NOLIMIT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	t	\N	0	cmbhqvrwu0053mdgpdx66fzpk	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat006wmdgpy8kqdv86	StarsLuckRTG	StarsLuck	{"id": "13564", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat006xmdgpupyo4fvy	DoggyRichesMegaWaysRTG	DoggyRichesMegaWays	{"id": "13529", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat006ymdgpxph4h9fr	ViralSpiralRTG	ViralSpiral	{"id": "13572", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat006zmdgpripqhodi	TheWildHatterRTG	TheWildHatter	{"id": "13569", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0070mdgpojfud5g1	DragonsFireMegaWaysRTG	DragonsFireMegaWays	{"id": "13530", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0071mdgpew3o1xmn	SeaBoatAdventureRTG	SeaBoatAdventure	{"id": "13559", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0072mdgp2z2reie1	NightmareFamilyMegaWaysRTG	NightmareFamilyMegaWays	{"id": "13553", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0073mdgp64rez8dt	LondonTubeRTG	LondonTube	{"id": "13549", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0074mdgp26gbhu11	GigaBlastRTG	GigaBlast	{"id": "13541", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0075mdgpkkp4yfjq	AtlantisRTG	Atlantis	{"id": "13511", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0076mdgp4n16i99n	FortuneFestRTG	FortuneFest	{"id": "13538", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0077mdgp5fple5r5	ClashOfTheBeastsRTG	ClashOfTheBeasts	{"id": "13524", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0078mdgp9uanzcmz	CaseClosedRTG	CaseClosed	{"id": "13519", "bet": "1", "bids": "0", "cask": "1", "type": "slots", "view": "", "label": "1", "active": "true", "device": "1", "jpg_id": "0", "rezerv": "", "shop_id": "1", "stat_in": "0.0000", "advanced": "1", "gamebank": "slots", "stat_out": "0.0000", "developer": "redtiger", "scalemode": "1", "vip_level": "5", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2020-01-30 00:00:00", "current_rtp": "", "original_id": "", "rtp_stat_in": "", "denomination": "1.00", "rtp_stat_out": "", "standard_rtp": "1", "category_temp": "1", "slotviewstate": "1", "lines_percent_config_spin": "1", "lines_percent_config_bonus": "1", "lines_percent_config_spin_bonus": "1", "lines_percent_config_bonus_bonus": "1"}	\N	{REDTIGER}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqci004ymdgpg5lzt4cf	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat0079mdgp8jn41ly4	HitInVegasNG	Hit In Vegas	{"id": "1070", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1070", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat007amdgpjvde0xvv	FortuneCashNG	Fortune Cash	{"id": "1071", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1071", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat007bmdgpi2zi2nvz	CleosHeartNG	Cleos Heart	{"id": "1072", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1072", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuat007cmdgp1nlqpwzm	Jungle2NG	Jungle 2	{"id": "1073", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1073", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007dmdgpglvnqn9a	BananasNG	Bananas	{"id": "1074", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1074", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007emdgp1pr7zgxu	BookOfNileNG	Book Of Nile	{"id": "1075", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1075", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007fmdgpb76g1dli	ZenZenCashNG	Zen Zen Cash	{"id": "1076", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1076", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007gmdgpgbqt50kr	WildBuffaloNG	Wild Buffalo	{"id": "1077", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1077", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007hmdgpllwga1qv	CrazyScientistNG	Crazy Scientist	{"id": "1078", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1078", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007imdgp9l2ne1bz	FrostyFruitsNG	Frosty Fruits	{"id": "1079", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007jmdgprblon0zn	CloverStonesNG	Clover Stones	{"id": "1080", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007kmdgp5xx5do8d	MMALegendsNG	MMA Legends	{"id": "1081", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007lmdgp8yl1soe9	JackpotSevensNG	Jackpot Sevens	{"id": "1082", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007mmdgpzy8flpsf	WolfReelsNG	Wolf Reels	{"id": "1083", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007nmdgp4bvjp9b4	MagicTreeNG	Magic Tree	{"id": "1084", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007omdgp4qv9uw7p	SpaceRocksNG	Space Rocks	{"id": "1085", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007pmdgpzct0enwj	Royal40FruitsNG	Royal 40 Fruits	{"id": "1086", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007qmdgpyphe5zj1	DiscoFruitsNG	Disco Fruits	{"id": "1087", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007rmdgph3mlki4i	AfricanKingNG	African King	{"id": "1088", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuau007smdgptqwh5vka	QuickCashFruitsNG	Quick Cash Fruits	{"id": "1089", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav007tmdgp4i86dzji	BookOfNileRevengeNG	Book Of Nile Revenge	{"id": "1090", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav007umdgp297z1ygv	BookOfNileLostChapterNG	Book Of NileLost Chapter	{"id": "1091", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav007vmdgpfmxu6jy0	Royal20FruitsNG	Royal 20 Fruits	{"id": "1092", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav007wmdgpwr7tki9l	RedHotChilli7sNG	Red Hot Chilli 7s	{"id": "1093", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav007xmdgpajnxvztk	GoldenFruitsNG	Golden Fruits	{"id": "1094", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netgame", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1079", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETGAME}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvqz80050mdgpm4b6ij9t	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav007ymdgp7c2zo1wo	SpaceWarsNET	Space Wars	{"id": "647", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "647", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav007zmdgpw40ozj7j	WildWaterNET	Wild Water	{"id": "648", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-26 17:03:47", "current_rtp": "0.0000", "original_id": "648", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0080mdgpnvhmhm7l	StarBurstNET	Star Burst	{"id": "649", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "649", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0081mdgprtwzx5rq	FlowersNET	Flowers	{"id": "650", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "650", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0082mdgpjijuojdi	FlowersChristmasNET	Flowers Christmas	{"id": "651", "bet": "0.01, 0.02, 0.05, 0.10, 0.20, 1.00, 5.00, 10.00, 20.00", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2022-03-03 11:38:47", "current_rtp": "0.0000", "original_id": "651", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "12,35", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0083mdgphir1eor8	DazzleMeNET	Dazzle Me	{"id": "652", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "652", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0084mdgpoghd5hng	FruitShopChristmasNET	Fruit Shop Christmas	{"id": "653", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "653", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0085mdgpf3tdt73d	FruitShopNET	Fruit Shop	{"id": "654", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "654", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0086mdgp3vb68p2b	GoBananasNET	Go Bananas	{"id": "655", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "655", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuav0087mdgpblfe2ipd	LightsNET	Lights	{"id": "656", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "656", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw0088mdgpaag8t0l4	FortuneRangersNET	Fortune Rangers	{"id": "876", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "876", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw0089mdgpchc9h825	CreatureFromTheBlackLagoonNET	Creature From The Black Lagoon	{"id": "877", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "877", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008amdgpmwu8up68	WingsOfRichesNET	Wings Of Riches	{"id": "878", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-26 17:03:47", "current_rtp": "0.0000", "original_id": "878", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008bmdgpdi3osn4e	ReelRush2NET	Reel Rush 2	{"id": "879", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "879", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008cmdgpf7du7jp8	TheWolfsBaneNET	The Wolfs Bane	{"id": "880", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "880", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008dmdgp2c6uayfe	GrandSpinnSuperpotNET	Grand Spinn Superpot	{"id": "881", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "881", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008emdgp1begi570	TurnYourFortuneNET	Turn Your Fortune	{"id": "882", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "882", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008fmdgpfsw8cajb	JumanjiNET	Jumanji	{"id": "883", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "883", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008gmdgpmb26h3ug	NarcosNET	Narcos	{"id": "884", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "884", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008hmdgpqez5owny	VikingsNET	Vikings	{"id": "885", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "885", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008imdgphl1bwpsi	SantaVSRudolphNET	Santa vs Rudolph	{"id": "1006", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1006", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008jmdgpbuzn4kgy	GoldenGrimoireNET	Golden Grimoire	{"id": "1007", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1007", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f
cmbhqvuaw008kmdgp8jzoss2f	HalloweenJackNET	Halloween Jack	{"id": "1008", "bet": "0.01, 0.02, 0.05, 0.10, 0.20", "bids": "0", "cask": "", "type": "", "view": "1", "label": "", "active": "false", "device": "2", "jpg_id": "0", "rezerv": "4", "shop_id": "0", "stat_in": "0.0000", "advanced": "", "gamebank": "slots", "stat_out": "0.0000", "developer": "netent", "scalemode": "", "vip_level": "", "created_at": "2020-01-30 00:00:00", "popularity": "1", "updated_at": "2021-01-18 15:58:10", "current_rtp": "0.0000", "original_id": "1008", "rtp_stat_in": "0.0000", "denomination": "1.00", "rtp_stat_out": "0.0000", "standard_rtp": "", "category_temp": "", "slotviewstate": "", "lines_percent_config_spin": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus": "{\\\\\\"line1\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}", "lines_percent_config_spin_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"15\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"9\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"7\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"12\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"8\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"6\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"10\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"7\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"5\\\\\\"}}", "lines_percent_config_bonus_bonus": "{\\\\\\"line1_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line3_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line5_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"100\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"50\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"40\\\\\\"},\\\\\\"line7_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line9_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"},\\\\\\"line10_bonus\\\\\\":{\\\\\\"74_80\\\\\\":\\\\\\"50\\\\\\",\\\\\\"82_88\\\\\\":\\\\\\"40\\\\\\",\\\\\\"90_96\\\\\\":\\\\\\"30\\\\\\"}}"}	\N	{NETENT}	SLOTS	{}	t	\N	\N	\N	2025-06-04 09:28:16.411	2025-06-04 09:28:16.411	f	\N	0	cmbhqvq16004xmdgpqpazz5nz	cmbhqua2y0000mdgpha4dsggk	\N	t	f



--
-- TOC entry 4364 (class 0 OID 29780)
-- Dependencies: 339
-- Data for Name: jackpot_contributions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jackpot_contributions (id, "jackpotId", "gameSpinId", "contributionAmountCoins", "createdAt") FROM stdin;



--
-- TOC entry 4365 (class 0 OID 29788)
-- Dependencies: 340
-- Data for Name: jackpot_wins; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jackpot_wins (id, "jackpotId", "winnerId", "winAmountCoins", "gameSpinId", "transactionId", "createdAt") FROM stdin;



--
-- TOC entry 4363 (class 0 OID 29765)
-- Dependencies: 338
-- Data for Name: jackpots; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.jackpots (id, type, "currentAmountCoins", "seedAmountCoins", "minimumBetCoins", "contributionRateBasisPoints", "probabilityPerMillion", "minimumTimeBetweenWinsMinutes", "lastWonAt", "lastWonBy", "isActive", "createdAt", "updatedAt") FROM stdin;
cmbhqsna20002mdkw97hc9txr	MINOR	100	100	1	10	1000	5	\N	\N	t	2025-06-04 09:25:47.354	2025-06-04 09:25:47.354
cmbhqsnfq0003mdkw37mvr8qa	MAJOR	1000	1000	100	5	100	30	\N	\N	t	2025-06-04 09:25:47.558	2025-06-04 09:25:47.558
cmbhqsnlc0004mdkw3u2w465h	GRAND	10000	10000	400	2	10	120	\N	\N	t	2025-06-04 09:25:47.76	2025-06-04 09:25:47.76



--
-- TOC entry 4366 (class 0 OID 29796)
-- Dependencies: 341
-- Data for Name: operator_access_keys; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operator_access_keys (id, name, operator_secret, operator_access, callback_url, active, permissions, ips, description, last_used_at, "createdAt", "updatedAt", "ownerId", "acceptedPayments") FROM stdin;
cmbhqua2y0000mdgpha4dsggk	MainCasinoOperator	$2b$10$9haEhXZHFlzw7PmIbdw3ZuVT5FQ0wwgOEMZVNHzCi9g4ug3HvxnZ2	internal_services	https://milky-cook.name	t	{read,write,manage_users,launch_game,manage_settings}	{127.0.0.1,::1,*}	The primary operator for this online casino platform.	\N	2025-06-04 09:27:03.562	2025-06-04 09:27:03.562	\N	{CASH_APP,INSTORE_CARD,INSTORE_CASH}



--
-- TOC entry 4367 (class 0 OID 29805)
-- Dependencies: 342
-- Data for Name: operator_invitations; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.operator_invitations (id, "operatorId", username, role, token, "expiresAt", "acceptedAt", "invitedById", "userProfileId") FROM stdin;



--
-- TOC entry 4368 (class 0 OID 29813)
-- Dependencies: 343
-- Data for Name: products; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.products (id, title, description, url, "iconUrl", "productType", "bonusCode", "bonusTotalInCredits", "isActive", "priceInCents", "amountToReceiveInCredits", "bestValue", "discountInCents", "bonusSpins", "isPromo", "totalDiscountInCents", "shopId", "createdAt", "updatedAt", "transactionId") FROM stdin;
cmbhqy5uk013tmdgpn096416s	Package One	blah blah 	https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png	default	DEPOSIT_PACKAGE		0	t	200	500	0	0	1	f	300	cmbhqua2y0000mdgpha4dsggk	2025-06-04 09:30:04.7	2025-06-04 09:30:04.7	\N
cmbhqy659013umdgp89f52gkt	Package Two	blah blah 	https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png	default	DEPOSIT_PACKAGE		0	t	500	1000	0	0	2	f	500	cmbhqua2y0000mdgpha4dsggk	2025-06-04 09:30:05.085	2025-06-04 09:30:05.085	\N
cmbhqy6g1013vmdgp64t126xd	Package Three	blah blah 	https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png	default	DEPOSIT_PACKAGE		0	t	1000	1500	0	0	3	f	500	cmbhqua2y0000mdgpha4dsggk	2025-06-04 09:30:05.474	2025-06-04 09:30:05.474	\N
cmbhqy6qs013wmdgpc0md82c8	Package Four	blah blah 	https://nnzmufhldbsvvztlrrau.supabase.co/storage/v1/object/public/products/gems1.png	default	DEPOSIT_PACKAGE		0	t	1500	2000	0	0	5	f	500	cmbhqua2y0000mdgpha4dsggk	2025-06-04 09:30:05.86	2025-06-04 09:30:05.86	\N



--
-- TOC entry 4376 (class 0 OID 29888)
-- Dependencies: 351
-- Data for Name: rebate_transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.rebate_transactions (id, "userId", "transactionId", "rebateAmount", "currencyId", "vipLevel", "rebatePercentage", status, "paidOutAt", "createdAt", "updatedAt") FROM stdin;



--
-- TOC entry 4354 (class 0 OID 29678)
-- Dependencies: 329
-- Data for Name: session; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.session (_id, expires_at, token, created_at, updated_at, ip_address, user_agent, user_id) FROM stdin;
JiU0bKWlO3dNOL8rwdgmWHRRq98FhZ2L	2025-06-11 10:43:08.272	8sIC6qjN3BpTSxf7xBaBvetpSFhKCEtx	2025-06-04 10:43:08.272	2025-06-04 10:43:08.272		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	KDD59juLi7g0nwKhS0fVFjNFrO7GinCO
wfgCct0556pPj6UKI5jCxIhlJf8nbiJk	2025-06-11 10:44:46.517	NE7Kp5xLS8wLVUWt97YEEd9MgqAULAS0	2025-06-04 10:44:46.517	2025-06-04 10:44:46.517		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	eTGvUvHx26rHPbsqX7DdinXgSjpUGhFC
qDwJw0w5fwIGxBgpJJxO4CbhsPTlDDMC	2025-06-11 10:45:10.867	hSb6DfyjUFESxDafxVqKFdAavkGlKZpC	2025-06-04 10:45:10.867	2025-06-04 10:45:10.867		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	qfw6qGODKsjisZYWZV5UuqrKtssXvZOW
mr0Q0OOnEV8EdMaUKXywPdhO0gJv4xe5	2025-06-11 10:45:21.455	0f3yTaD6cbjsH2wKCHAWtn18mtfRYDT2	2025-06-04 10:45:21.455	2025-06-04 10:45:21.455		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	n54PJz49x6q6Ah6rGN2Fksi5y1ZpXeB2
mY8YMsMCWNLyXFa2Eu6MiPEklecZE81S	2025-06-11 10:45:45.192	eiRXfHAeLduEigVB7JUB9pDKjQshWywq	2025-06-04 10:45:45.192	2025-06-04 10:45:45.192		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	41q73jCZmxVD27ZBISWqTY4WupCxXpgI
s4SNURSDbYBZ0pX1DXhXKVMdFEwjFTxA	2025-06-11 10:46:06.652	F2xMyP7sz5fkOyQPwjEPkYwa1aJ1gKcE	2025-06-04 10:46:06.652	2025-06-04 10:46:06.652		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	LfZ8rW9WO8IuC1UqwwU8jZtxCusdKJYI
T1IowcxIucVSt9zqoNCTHX9fJegcyBYg	2025-06-11 10:46:54.794	25p4z4NXqhebekVYYQpw6DUPGy2WnjUX	2025-06-04 10:46:54.794	2025-06-04 10:46:54.794		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj
d0uqxLL8jG34t1yKLjLBaVzo1PqZYzFX	2025-06-11 10:47:42.136	PUjzsVWi8IzbmaDqJlAAzdvewAFOMTi5	2025-06-04 10:47:42.136	2025-06-04 10:47:42.136		Mozilla/5.0 (Linux; Android 13; Pixel 7) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/136.0.0.0 Mobile Safari/537.36	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj



--
-- TOC entry 4370 (class 0 OID 29836)
-- Dependencies: 345
-- Data for Name: todo; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.todo (id, text, completed) FROM stdin;



--
-- TOC entry 4375 (class 0 OID 29879)
-- Dependencies: 350
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.transactions (id, "processedAt", "walletId", type, status, amount, "netAmount", "feeAmount", "productId", "paymentMethod", "balanceBefore", "balanceAfter", "bonusBalanceBefore", "bonusBalanceAfter", "bonusAmount", "wageringRequirement", "wageringProgress", description, provider, "providerTxId", "relatedGameId", "relatedRoundId", metadata, "createdAt", "updatedAt", "userProfileId", "operatorId") FROM stdin;
cmbhqv6rq0004mdgpcymf83a5	\N	cmbhqv6lq0002mdgpt9r8b9pl	WITHDRAWAL	PENDING	2792	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 27.92	MockPaymentProvider	pbPa3XkN3lkG7xHn	\N	\N	{"ipAddress": "147.222.213.172", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:115.0) Gecko/20100101 Firefox/124.0"}}	2025-06-04 09:27:45.926	2025-06-04 09:27:45.926	44e19cc5-466c-4551-8719-621ed777c04f	cmbhqua2y0000mdgpha4dsggk
cmbhqv6xo0006mdgpkpr4ubly	2025-06-04 09:27:46.139	cmbhqv6lq0002mdgpt9r8b9pl	BET_PLACE	FAILED	3083	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 30.83	System	YhTAMTxxTwfFJYUz	\N	\N	{"ipAddress": "87.225.75.222", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/556.95.18 (KHTML, like Gecko) Version/16.1 Safari/576.30.13"}}	2025-06-04 09:27:46.14	2025-06-04 09:27:46.14	44e19cc5-466c-4551-8719-621ed777c04f	cmbhqua2y0000mdgpha4dsggk
cmbhqv73i0008mdgp7i9scw1t	2025-06-04 09:27:46.349	cmbhqv6lq0002mdgpt9r8b9pl	DEPOSIT	FAILED	5923	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 59.23	MockPaymentProvider	g6cyhZlt4sOJcH1u	\N	\N	{"ipAddress": "eda8:3d6e:c1ab:ef07:841d:6dd5:dd59:ff89", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 6.1; Trident/7.0)"}}	2025-06-04 09:27:46.351	2025-06-04 09:27:46.351	44e19cc5-466c-4551-8719-621ed777c04f	cmbhqua2y0000mdgpha4dsggk
cmbhqv799000amdgpzoh0cumc	2025-06-04 09:27:46.555	cmbhqv6lq0002mdgpt9r8b9pl	WITHDRAWAL	FAILED	2845	0	131	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 28.45	MockPaymentProvider	rF0x7p83hWr12An3	\N	\N	{"ipAddress": "95bc:0cb4:e66c:182f:a0e4:2b4f:f9af:46da", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 14_2 like Mac OS X) AppleWebKit/584.13.71 (KHTML, like Gecko) Version/14_2 Mobile/15E148 Safari/549.90"}}	2025-06-04 09:27:46.557	2025-06-04 09:27:46.557	44e19cc5-466c-4551-8719-621ed777c04f	cmbhqua2y0000mdgpha4dsggk
cmbhqv7ri000emdgpz64hpew7	2025-06-04 09:27:47.212	cmbhqv7lw000cmdgp37tw1fax	BONUS_AWARD	COMPLETED	2028	0	\N	\N	INSTORE_CASH	\N	\N	536	2564	2028	\N	\N	BONUS_AWARD of 20.28	System	OcvDt8yr1r3PBTYL	\N	\N	{"ipAddress": "a02e:46cc:ad2b:5bcd:753e:f0e0:ebb3:43c9", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 10.0; Trident/4.0)"}}	2025-06-04 09:27:47.214	2025-06-04 09:27:47.214	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	cmbhqua2y0000mdgpha4dsggk
cmbhqv7x8000gmdgpy55qei4b	2025-06-04 09:27:47.418	cmbhqv7lw000cmdgp37tw1fax	BET_PLACE	COMPLETED	2916	-2916	\N	\N	INSTORE_CASH	30296	27380	2564	2564	\N	\N	\N	BET_PLACE of 29.16	System	I96aRyOEtgnuyhsP	\N	\N	{"ipAddress": "209.17.185.194", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/551.11.4 (KHTML, like Gecko) Chrome/123.2.5.15 Safari/578.39.56"}}	2025-06-04 09:27:47.42	2025-06-04 09:27:47.42	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	cmbhqua2y0000mdgpha4dsggk
cmbhqv82w000imdgp4yncx5rh	2025-06-04 09:27:47.623	cmbhqv7lw000cmdgp37tw1fax	WITHDRAWAL	COMPLETED	7728	-7896	168	\N	INSTORE_CASH	27380	19484	2564	2564	\N	\N	\N	WITHDRAWAL of 77.28	MockPaymentProvider	yWqhjfwPpbIRgzF2	\N	\N	{"ipAddress": "51.135.171.134", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 5.1; Trident/4.0)"}}	2025-06-04 09:27:47.624	2025-06-04 09:27:47.624	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	cmbhqua2y0000mdgpha4dsggk
cmbhqv88n000kmdgp8fh0zcbz	2025-06-04 09:27:47.83	cmbhqv7lw000cmdgp37tw1fax	WITHDRAWAL	FAILED	6309	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 63.09	MockPaymentProvider	40eXTOxeTkQxmt0G	\N	\N	{"ipAddress": "b9f8:9def:8660:28b6:00df:a618:c2bf:eae7", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/537.76.45 (KHTML, like Gecko) Version/16.1 Safari/549.62.63"}}	2025-06-04 09:27:47.831	2025-06-04 09:27:47.831	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	cmbhqua2y0000mdgpha4dsggk
cmbhqv8ec000mmdgpwfvopjnl	\N	cmbhqv7lw000cmdgp37tw1fax	BONUS_AWARD	PENDING	3169	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	3169	\N	\N	BONUS_AWARD of 31.69	System	dsASxENHoMHKnH9p	\N	\N	{"ipAddress": "d8fd:b0cb:a82f:da4b:0dff:99d1:f2e4:db2d", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_0 like Mac OS X) AppleWebKit/558.27.81 (KHTML, like Gecko) Version/15_1 Mobile/15E148 Safari/602.36"}}	2025-06-04 09:27:48.036	2025-06-04 09:27:48.036	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	cmbhqua2y0000mdgpha4dsggk
cmbhqv916000qmdgp5lw23cnj	2025-06-04 09:27:48.856	cmbhqv8ve000omdgp4axt24q9	BET_PLACE	COMPLETED	1981	-1981	\N	\N	INSTORE_CARD	175746	173765	3489	3489	\N	\N	\N	BET_PLACE of 19.81	System	elXTt54EkhrxX0hh	\N	\N	{"ipAddress": "33c6:5a0c:1cac:8bbb:f5db:fd41:ecb8:a3f5", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 18_3 like Mac OS X) AppleWebKit/551.12.62 (KHTML, like Gecko) Version/11_1 Mobile/15E148 Safari/584.28"}}	2025-06-04 09:27:48.858	2025-06-04 09:27:48.858	b0417f70-9963-4850-8872-3263fefdef55	cmbhqua2y0000mdgpha4dsggk
cmbhqv973000smdgpbargh4r7	\N	cmbhqv8ve000omdgp4axt24q9	BET_PLACE	PENDING	3347	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 33.47	System	yWjwb4G4gFBiiJHY	\N	\N	{"ipAddress": "b53d:1b04:5afc:e34a:eaa8:f29c:ff45:7d88", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.0; Trident/6.0)"}}	2025-06-04 09:27:49.071	2025-06-04 09:27:49.071	b0417f70-9963-4850-8872-3263fefdef55	cmbhqua2y0000mdgpha4dsggk
cmbhqv9cq000umdgp7cnbb1s3	2025-06-04 09:27:49.273	cmbhqv8ve000omdgp4axt24q9	DEPOSIT	COMPLETED	14765	14765	\N	\N	INSTORE_CARD	173765	188530	3489	3489	\N	\N	\N	DEPOSIT of 147.65	MockPaymentProvider	CGZJyFXxtQv4SM7c	\N	\N	{"ipAddress": "188.230.23.0", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/557.63 (KHTML, like Gecko) Chrome/80.5.20.1 Safari/594.26 Edg/121.5.7.14"}}	2025-06-04 09:27:49.274	2025-06-04 09:27:49.274	b0417f70-9963-4850-8872-3263fefdef55	cmbhqua2y0000mdgpha4dsggk
cmbhqvaay0010mdgpcgv6qpep	2025-06-04 09:27:50.505	cmbhqva54000ymdgpg3a4k9fe	WITHDRAWAL	FAILED	3755	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 37.55	MockPaymentProvider	8YvSSpMBxR7naJcG	\N	\N	{"ipAddress": "138.255.232.142", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:86.0) Gecko/20100101 Firefox/132.0"}}	2025-06-04 09:27:50.506	2025-06-04 09:27:50.506	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	cmbhqua2y0000mdgpha4dsggk
cmbhqvagq0012mdgp9gq3ewzd	\N	cmbhqva54000ymdgpg3a4k9fe	DEPOSIT	PENDING	13069	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 130.69	MockPaymentProvider	lwEFceH2NdS8pSgU	\N	\N	{"ipAddress": "2ff9:4305:bafe:2739:ffad:57cc:efb8:c07b", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/585.26 (KHTML, like Gecko) Chrome/122.6.18.10 Safari/582.67 Edg/123.4.16.15"}}	2025-06-04 09:27:50.714	2025-06-04 09:27:50.714	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	cmbhqua2y0000mdgpha4dsggk
cmbhqvamh0014mdgppbjxcqgw	\N	cmbhqva54000ymdgpg3a4k9fe	BET_PLACE	PENDING	2930	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 29.3	System	pxGSlgqaFLDZ5GFm	\N	\N	{"ipAddress": "f4f4:cbcb:be0d:79aa:fbb5:f5a7:a01e:9f3a", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/572.69.97 (KHTML, like Gecko) Chrome/123.9.4.4 Safari/567.92.68"}}	2025-06-04 09:27:50.921	2025-06-04 09:27:50.921	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	cmbhqua2y0000mdgpha4dsggk
cmbhqvb370018mdgp73t5d58z	\N	cmbhqvaxn0016mdgp22xc6xtz	WITHDRAWAL	PENDING	2994	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 29.94	MockPaymentProvider	7FMkPzfPCGhXyOAm	\N	\N	{"ipAddress": "202.201.248.72", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/559.73.85 (KHTML, like Gecko) Chrome/101.7.9.16 Safari/597.29.8"}}	2025-06-04 09:27:51.523	2025-06-04 09:27:51.523	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqua2y0000mdgpha4dsggk
cmbhqvb8w001amdgphwizvrue	\N	cmbhqvaxn0016mdgp22xc6xtz	WITHDRAWAL	PENDING	1476	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 14.76	MockPaymentProvider	DR4fQzS9hu95HNrP	\N	\N	{"ipAddress": "84.196.140.21", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/551.95 (KHTML, like Gecko) Chrome/68.7.4.6 Safari/567.27 Edg/113.5.15.13"}}	2025-06-04 09:27:51.728	2025-06-04 09:27:51.728	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqua2y0000mdgpha4dsggk
cmbhqvbem001cmdgp53e88u4u	2025-06-04 09:27:51.933	cmbhqvaxn0016mdgp22xc6xtz	BONUS_AWARD	COMPLETED	2550	0	\N	\N	INSTORE_CARD	\N	\N	4518	7068	2550	\N	\N	BONUS_AWARD of 25.5	System	jlpUkbwZHJBLvFB2	\N	\N	{"ipAddress": "30.32.206.241", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 12_3 like Mac OS X) AppleWebKit/583.84.41 (KHTML, like Gecko) Version/15_1 Mobile/15E148 Safari/553.9"}}	2025-06-04 09:27:51.934	2025-06-04 09:27:51.934	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqua2y0000mdgpha4dsggk
cmbhqvbk6001emdgpr8ek0lx3	\N	cmbhqvaxn0016mdgp22xc6xtz	WITHDRAWAL	PENDING	9779	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 97.79	MockPaymentProvider	WhRKgiVZDSp4Dmlf	\N	\N	{"ipAddress": "64.28.212.195", "deviceInfo": {"os": "iOS", "browser": "FakerBot/1.16.3"}}	2025-06-04 09:27:52.134	2025-06-04 09:27:52.134	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqua2y0000mdgpha4dsggk
cmbhqvbpt001gmdgp98pnam3o	2025-06-04 09:27:52.336	cmbhqvaxn0016mdgp22xc6xtz	BET_PLACE	FAILED	589	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 5.89	System	68zacXAGlh9F6X4k	\N	\N	{"ipAddress": "ea41:acbf:1c1c:a236:aeee:77f5:9bcc:ac60", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Windows NT 5.1; Win64; x64) AppleWebKit/591.43 (KHTML, like Gecko) Chrome/60.0.15.18 Safari/538.14 Edg/120.0.18.16"}}	2025-06-04 09:27:52.338	2025-06-04 09:27:52.338	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqua2y0000mdgpha4dsggk
cmbhqvcch001kmdgp4l48d5kz	2025-06-04 09:27:53.152	cmbhqvc6p001imdgpmxo453z2	BET_PLACE	FAILED	4090	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 40.9	System	0qNQXDjRNpTXJKw5	\N	\N	{"ipAddress": "47.98.113.11", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/547.67.77 (KHTML, like Gecko) Version/16.1 Safari/600.33.33"}}	2025-06-04 09:27:53.153	2025-06-04 09:27:53.153	66426961-c20f-4883-900f-c6bc0b13172c	cmbhqua2y0000mdgpha4dsggk
cmbhqvctj001omdgpdp4qpti0	2025-06-04 09:27:53.766	cmbhqvcnr001mmdgpcb95g76e	WITHDRAWAL	FAILED	4979	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 49.79	MockPaymentProvider	ZMF46UJzl0fTvmQy	\N	\N	{"ipAddress": "6daf:256e:353c:63fa:d1cc:e86c:e43d:cde7", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:79.0) Gecko/20100101 Firefox/127.0"}}	2025-06-04 09:27:53.767	2025-06-04 09:27:53.767	78ca58fd-7e97-470d-864d-1b995208b2e6	cmbhqua2y0000mdgpha4dsggk
cmbhqvczd001qmdgpkxny7vv8	\N	cmbhqvcnr001mmdgpcb95g76e	DEPOSIT	PENDING	16345	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 163.45	MockPaymentProvider	IYozAuDnJBHpPrEA	\N	\N	{"ipAddress": "244.231.170.154", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/591.72.39 (KHTML, like Gecko) Chrome/69.8.3.3 Safari/573.14.15"}}	2025-06-04 09:27:53.977	2025-06-04 09:27:53.977	78ca58fd-7e97-470d-864d-1b995208b2e6	cmbhqua2y0000mdgpha4dsggk
cmbhqvd52001smdgp0z2fn4nr	\N	cmbhqvcnr001mmdgpcb95g76e	WITHDRAWAL	PENDING	2446	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 24.46	MockPaymentProvider	F8ISkJcmOcyD8FR2	\N	\N	{"ipAddress": "24.160.199.49", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/585.24.72 (KHTML, like Gecko) Chrome/55.4.14.2 Safari/595.95.39"}}	2025-06-04 09:27:54.182	2025-06-04 09:27:54.182	78ca58fd-7e97-470d-864d-1b995208b2e6	cmbhqua2y0000mdgpha4dsggk
cmbhqvdap001umdgpoqckadxu	\N	cmbhqvcnr001mmdgpcb95g76e	BONUS_AWARD	PENDING	909	0	\N	\N	CASH_APP	\N	\N	\N	\N	909	\N	\N	BONUS_AWARD of 9.09	System	fN3ziIaTTbnRMhuC	\N	\N	{"ipAddress": "02b4:e1de:2ea8:6fe1:9bea:1fcf:d04d:e11a", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 6.3; Trident/7.0)"}}	2025-06-04 09:27:54.385	2025-06-04 09:27:54.385	78ca58fd-7e97-470d-864d-1b995208b2e6	cmbhqua2y0000mdgpha4dsggk
cmbhqvdgb001wmdgp1y0uiwtx	\N	cmbhqvcnr001mmdgpcb95g76e	BET_PLACE	PENDING	607	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 6.07	System	sPzY4Mou5mCwwQBj	\N	\N	{"ipAddress": "52.27.188.28", "deviceInfo": {"os": "Windows", "browser": "FakerBot/7.6.20"}}	2025-06-04 09:27:54.588	2025-06-04 09:27:54.588	78ca58fd-7e97-470d-864d-1b995208b2e6	cmbhqua2y0000mdgpha4dsggk
cmbhqvdxg0020mdgpvc5rt6fv	2025-06-04 09:27:55.202	cmbhqvdro001ymdgp8gpxt3yg	WITHDRAWAL	COMPLETED	1270	-1270	\N	\N	INSTORE_CARD	102490	101220	3014	3014	\N	\N	\N	WITHDRAWAL of 12.7	MockPaymentProvider	rQIBoHPFPmZvlE4P	\N	\N	{"ipAddress": "113.88.124.147", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:75.0) Gecko/20100101 Firefox/96.0"}}	2025-06-04 09:27:55.204	2025-06-04 09:27:55.204	247c044f-dfb9-4cae-9b72-3e9f80747f2b	cmbhqua2y0000mdgpha4dsggk
cmbhqve370022mdgpdnstnn29	2025-06-04 09:27:55.41	cmbhqvdro001ymdgp8gpxt3yg	DEPOSIT	FAILED	10256	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 102.56	MockPaymentProvider	y2DTysRxvzkKyLbh	\N	\N	{"ipAddress": "91.207.42.53", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.0; Trident/6.0)"}}	2025-06-04 09:27:55.411	2025-06-04 09:27:55.411	247c044f-dfb9-4cae-9b72-3e9f80747f2b	cmbhqua2y0000mdgpha4dsggk
cmbhqve8z0024mdgpw3pqrq6g	2025-06-04 09:27:55.618	cmbhqvdro001ymdgp8gpxt3yg	BONUS_AWARD	FAILED	1023	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	1023	\N	\N	BONUS_AWARD of 10.23	System	PQJVJU5wEHzIvlf6	\N	\N	{"ipAddress": "189.217.108.186", "deviceInfo": {"os": "Android", "browser": "FakerBot/0.5.8"}}	2025-06-04 09:27:55.619	2025-06-04 09:27:55.619	247c044f-dfb9-4cae-9b72-3e9f80747f2b	cmbhqua2y0000mdgpha4dsggk
cmbhqvevv0028mdgptp54acza	\N	cmbhqveq50026mdgpwe48nbcq	BET_PLACE	PENDING	4652	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 46.52	System	60k2RbwvEOXTQs3u	\N	\N	{"ipAddress": "105.31.89.75", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/553.66.76 (KHTML, like Gecko) Version/16.1 Safari/565.16.70"}}	2025-06-04 09:27:56.443	2025-06-04 09:27:56.443	77a5e0cd-6bd4-4803-8328-a984b687acc4	cmbhqua2y0000mdgpha4dsggk
cmbhqvf1n002amdgpw8zrlxeg	2025-06-04 09:27:56.65	cmbhqveq50026mdgpwe48nbcq	WITHDRAWAL	FAILED	1258	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 12.58	MockPaymentProvider	MK03pX3IepRg8qan	\N	\N	{"ipAddress": "199.130.95.83", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:129.0) Gecko/20100101 Firefox/113.0"}}	2025-06-04 09:27:56.651	2025-06-04 09:27:56.651	77a5e0cd-6bd4-4803-8328-a984b687acc4	cmbhqua2y0000mdgpha4dsggk
cmbhqvf7g002cmdgpzah8igpc	2025-06-04 09:27:56.859	cmbhqveq50026mdgpwe48nbcq	DEPOSIT	COMPLETED	18483	18483	\N	\N	INSTORE_CARD	143435	161918	420	420	\N	\N	\N	DEPOSIT of 184.83	MockPaymentProvider	3RwVDuHqWKDIgx7e	\N	\N	{"ipAddress": "105.127.100.63", "deviceInfo": {"os": "iOS", "browser": "Googlebot/2.1 (+http://www.google.com/bot.html)"}}	2025-06-04 09:27:56.86	2025-06-04 09:27:56.86	77a5e0cd-6bd4-4803-8328-a984b687acc4	cmbhqua2y0000mdgpha4dsggk
cmbhqvfd6002emdgpo5ph2cfd	2025-06-04 09:27:57.066	cmbhqveq50026mdgpwe48nbcq	BONUS_AWARD	COMPLETED	3128	0	\N	\N	INSTORE_CARD	\N	\N	420	3548	3128	\N	\N	BONUS_AWARD of 31.28	System	bEakin0gqIOFnrPh	\N	\N	{"ipAddress": "118.170.159.90", "deviceInfo": {"os": "iOS", "browser": "FakerBot/1.13.9"}}	2025-06-04 09:27:57.066	2025-06-04 09:27:57.066	77a5e0cd-6bd4-4803-8328-a984b687acc4	cmbhqua2y0000mdgpha4dsggk
cmbhqvfzx002imdgppy50mgqm	2025-06-04 09:27:57.884	cmbhqvfu7002gmdgp8mojnzb3	BET_PLACE	FAILED	2617	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 26.17	System	PUyJCwuRpnLyL9yq	\N	\N	{"ipAddress": "8d0b:b3ce:86a5:723e:866f:d0d1:3bbe:47df", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:114.0) Gecko/20100101 Firefox/90.0"}}	2025-06-04 09:27:57.886	2025-06-04 09:27:57.886	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqua2y0000mdgpha4dsggk
cmbhqvg5o002kmdgpseec87v8	2025-06-04 09:27:58.09	cmbhqvfu7002gmdgp8mojnzb3	WITHDRAWAL	COMPLETED	5938	-5938	\N	\N	INSTORE_CASH	32617	26679	4453	4453	\N	\N	\N	WITHDRAWAL of 59.38	MockPaymentProvider	3GgYAFVywRUe0aA5	\N	\N	{"ipAddress": "139.48.171.187", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/582.42.33 (KHTML, like Gecko) Chrome/114.6.15.5 Safari/597.80.1"}}	2025-06-04 09:27:58.092	2025-06-04 09:27:58.092	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqua2y0000mdgpha4dsggk
cmbhz9c0j1h3qahck	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	998400	998200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:22:42.684	2025-06-04 13:22:42.684	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhqvgbc002mmdgprfptwino	\N	cmbhqvfu7002gmdgp8mojnzb3	DEPOSIT	PENDING	17376	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 173.76	MockPaymentProvider	0Vguk7QTeu9XU1bI	\N	\N	{"ipAddress": "180.157.39.93", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/605.20.56 (KHTML, like Gecko) Version/16.1 Safari/556.96.89"}}	2025-06-04 09:27:58.296	2025-06-04 09:27:58.296	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqua2y0000mdgpha4dsggk
cmbhqvgh2002omdgplng5h3hb	\N	cmbhqvfu7002gmdgp8mojnzb3	BET_PLACE	PENDING	3700	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 37	System	TBo62lNuiJT8Y4OP	\N	\N	{"ipAddress": "18.214.206.5", "deviceInfo": {"os": "Windows", "browser": "Googlebot/2.1 (+http://www.google.com/bot.html)"}}	2025-06-04 09:27:58.502	2025-06-04 09:27:58.502	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqua2y0000mdgpha4dsggk
cmbhqvh3t002smdgp61pf8n9r	2025-06-04 09:27:59.319	cmbhqvgy0002qmdgpo26ayqyo	BONUS_AWARD	COMPLETED	3593	0	\N	\N	INSTORE_CASH	\N	\N	4234	7827	3593	\N	\N	BONUS_AWARD of 35.93	System	twWqjW8wDOFmKNmf	\N	\N	{"ipAddress": "191.84.246.249", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/600.34.84 (KHTML, like Gecko) Chrome/111.0.9.15 Safari/597.89.1"}}	2025-06-04 09:27:59.321	2025-06-04 09:27:59.321	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	cmbhqua2y0000mdgpha4dsggk
cmbhqvh9e002umdgp1beimlxc	\N	cmbhqvgy0002qmdgpo26ayqyo	WITHDRAWAL	PENDING	2218	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 22.18	MockPaymentProvider	HrMuNjq4J6xW9udf	\N	\N	{"ipAddress": "33.59.61.86", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/540.34.49 (KHTML, like Gecko) Version/16.1 Safari/539.40.8"}}	2025-06-04 09:27:59.522	2025-06-04 09:27:59.522	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	cmbhqua2y0000mdgpha4dsggk
cmbhqvhf4002wmdgpgywoon4k	2025-06-04 09:27:59.726	cmbhqvgy0002qmdgpo26ayqyo	WITHDRAWAL	COMPLETED	6135	-6135	\N	\N	INSTORE_CASH	10286	4151	7827	7827	\N	\N	\N	WITHDRAWAL of 61.35	MockPaymentProvider	jbO5hpnKLfT7K70K	\N	\N	{"ipAddress": "8fe4:fdd5:359f:d752:bbac:bece:ad8f:a3da", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:101.0) Gecko/20100101 Firefox/87.0"}}	2025-06-04 09:27:59.728	2025-06-04 09:27:59.728	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	cmbhqua2y0000mdgpha4dsggk
cmbhqvi1s0030mdgp6wifuhsb	2025-06-04 09:28:00.542	cmbhqvhw3002ymdgp3k7r1kx6	BET_PLACE	FAILED	2849	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 28.49	System	XJEo4pUoan7h3CkT	\N	\N	{"ipAddress": "167.102.225.66", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (compatible; MSIE 8.0; Windows NT 5.1; Trident/4.0)"}}	2025-06-04 09:28:00.544	2025-06-04 09:28:00.544	7851298a-157c-4e0a-9163-b97f4c8c8535	cmbhqua2y0000mdgpha4dsggk
cmbhqvi7g0032mdgpnk8irixi	2025-06-04 09:28:00.746	cmbhqvhw3002ymdgp3k7r1kx6	DEPOSIT	FAILED	7845	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 78.45	MockPaymentProvider	6UuWoEUqdsVTfG4e	\N	\N	{"ipAddress": "f9d2:f915:d1ac:beb4:a5da:e6bf:fd32:ef87", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 10.0; Trident/5.0)"}}	2025-06-04 09:28:00.748	2025-06-04 09:28:00.748	7851298a-157c-4e0a-9163-b97f4c8c8535	cmbhqua2y0000mdgpha4dsggk
cmbhqviom0036mdgpkrlvqesy	\N	cmbhqviix0034mdgp2jhdnawn	BONUS_AWARD	PENDING	1467	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	1467	\N	\N	BONUS_AWARD of 14.67	System	IOLC9MOCYR6BdmVp	\N	\N	{"ipAddress": "ab9d:2538:e4ce:9dcd:f2ac:df05:7a5e:8f7a", "deviceInfo": {"os": "iOS", "browser": "Googlebot/2.1 (+http://www.google.com/bot.html)"}}	2025-06-04 09:28:01.366	2025-06-04 09:28:01.366	0510f126-3b7a-4e60-8122-9e53b707b8c3	cmbhqua2y0000mdgpha4dsggk
cmbhqviuj0038mdgphw2a44pr	2025-06-04 09:28:01.577	cmbhqviix0034mdgp2jhdnawn	WITHDRAWAL	FAILED	2313	0	58	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 23.13	MockPaymentProvider	RQZJ7cQj7bToHXcl	\N	\N	{"ipAddress": "51.217.202.254", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 13_4 like Mac OS X) AppleWebKit/580.25.55 (KHTML, like Gecko) Version/12_4 Mobile/15E148 Safari/562.9"}}	2025-06-04 09:28:01.579	2025-06-04 09:28:01.579	0510f126-3b7a-4e60-8122-9e53b707b8c3	cmbhqua2y0000mdgpha4dsggk
cmbhqvj06003amdgp0htq1whd	2025-06-04 09:28:01.781	cmbhqviix0034mdgp2jhdnawn	BET_PLACE	FAILED	2076	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 20.76	System	Ts9WnwzN8iXArdFR	\N	\N	{"ipAddress": "2b2e:a34f:fac6:2cae:a5b1:9a23:4c8f:0be8", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (Linux; Android 9; SM-G998B) AppleWebKit/543.57 (KHTML, like Gecko) Chrome/73.4.0.8 Mobile Safari/576.99"}}	2025-06-04 09:28:01.782	2025-06-04 09:28:01.782	0510f126-3b7a-4e60-8122-9e53b707b8c3	cmbhqua2y0000mdgpha4dsggk
cmbhqvj5w003cmdgpe6e6tqhn	2025-06-04 09:28:01.987	cmbhqviix0034mdgp2jhdnawn	DEPOSIT	FAILED	8905	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 89.05	MockPaymentProvider	L6UQL9FJBcmXo8Gx	\N	\N	{"ipAddress": "214.207.211.28", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (compatible; MSIE 10.0; Windows NT 6.1; Trident/7.0)"}}	2025-06-04 09:28:01.988	2025-06-04 09:28:01.988	0510f126-3b7a-4e60-8122-9e53b707b8c3	cmbhqua2y0000mdgpha4dsggk
cmbhqvjoe003gmdgp51zb6z76	2025-06-04 09:28:02.652	cmbhqvjij003emdgpjq517s0w	WITHDRAWAL	FAILED	5777	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 57.77	MockPaymentProvider	huzRGM7VVjIaHHfk	\N	\N	{"ipAddress": "f4bb:e0c5:080c:801b:1dfe:f55e:fdf9:b15f", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (Windows NT 5.1; Win64; x64) AppleWebKit/555.93 (KHTML, like Gecko) Chrome/82.9.16.20 Safari/561.90 Edg/116.1.0.11"}}	2025-06-04 09:28:02.654	2025-06-04 09:28:02.654	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	cmbhqua2y0000mdgpha4dsggk
cmbhqvjub003imdgpxnyh6psl	\N	cmbhqvjij003emdgpjq517s0w	WITHDRAWAL	PENDING	8739	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 87.39	MockPaymentProvider	2qRFTGLb1t8l7473	\N	\N	{"ipAddress": "ecbc:de39:f201:776c:be09:6add:60cb:2dfb", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Linux; Android 8; SM-G998N) AppleWebKit/539.46 (KHTML, like Gecko) Chrome/82.1.9.16 Mobile Safari/603.36"}}	2025-06-04 09:28:02.867	2025-06-04 09:28:02.867	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	cmbhqua2y0000mdgpha4dsggk
cmbhqvjzy003kmdgp7f2k29p2	\N	cmbhqvjij003emdgpjq517s0w	DEPOSIT	PENDING	7053	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	DEPOSIT of 70.53	MockPaymentProvider	qEEL5PPVPx8RLr70	\N	\N	{"ipAddress": "225.67.125.73", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:93.0) Gecko/20100101 Firefox/133.0"}}	2025-06-04 09:28:03.07	2025-06-04 09:28:03.07	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	cmbhqua2y0000mdgpha4dsggk
cmbhqvk5s003mmdgpz8pgw9h3	\N	cmbhqvjij003emdgpjq517s0w	BET_PLACE	PENDING	71	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 0.71	System	3K3hYHYRgfdniYvy	\N	\N	{"ipAddress": "52.1.108.31", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/563.39.31 (KHTML, like Gecko) Version/16.1 Safari/567.13.85"}}	2025-06-04 09:28:03.28	2025-06-04 09:28:03.28	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	cmbhqua2y0000mdgpha4dsggk
cmbhqvkmy003qmdgpq707b2fl	2025-06-04 09:28:03.897	cmbhqvkh3003omdgp4nind7rl	BET_PLACE	COMPLETED	1481	-1481	\N	\N	CASH_APP	221642	220161	3130	3130	\N	\N	\N	BET_PLACE of 14.81	System	NSCjVX3qfryGtMqF	\N	\N	{"ipAddress": "9dd9:f27c:8ea2:bc95:b7bc:2c6f:4edf:0b73", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10_15_7) AppleWebKit/573.9.79 (KHTML, like Gecko) Chrome/75.2.4.14 Safari/575.41.70"}}	2025-06-04 09:28:03.898	2025-06-04 09:28:03.898	93c893af-8756-474e-934e-b08fad0a78fc	cmbhqua2y0000mdgpha4dsggk
cmbhqvkss003smdgp226qtzye	\N	cmbhqvkh3003omdgp4nind7rl	WITHDRAWAL	PENDING	5910	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 59.1	MockPaymentProvider	T5KMxbaOAeCxqxtA	\N	\N	{"ipAddress": "202.61.187.30", "deviceInfo": {"os": "iOS", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:114.0) Gecko/20100101 Firefox/132.0"}}	2025-06-04 09:28:04.108	2025-06-04 09:28:04.108	93c893af-8756-474e-934e-b08fad0a78fc	cmbhqua2y0000mdgpha4dsggk
cmbhqvlfe003wmdgpkhv431gg	2025-06-04 09:28:04.92	cmbhqvl9o003umdgpkrecjvou	BET_PLACE	FAILED	4275	0	\N	\N	INSTORE_CASH	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 42.75	System	Qojv1fJm2ToZFcWK	\N	\N	{"ipAddress": "cfa4:2791:3d63:8c2c:ea4b:50af:e9eb:49e9", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7) AppleWebKit/588.71.58 (KHTML, like Gecko) Version/16.1 Safari/599.55.89"}}	2025-06-04 09:28:04.922	2025-06-04 09:28:04.922	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	cmbhqua2y0000mdgpha4dsggk
cmbhqvlwb0040mdgphot14irb	\N	cmbhqvlqr003ymdgpruvr2f1s	BONUS_AWARD	PENDING	3933	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	3933	\N	\N	BONUS_AWARD of 39.33	System	J5UMrQxYr82GAzWR	\N	\N	{"ipAddress": "49be:2df9:fb1b:a35e:ecfc:df6b:ae2f:afdc", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Linux; Android 11; SM-G998U) AppleWebKit/559.94 (KHTML, like Gecko) Chrome/130.8.5.6 Mobile Safari/577.68"}}	2025-06-04 09:28:05.531	2025-06-04 09:28:05.531	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	cmbhqua2y0000mdgpha4dsggk
cmbhqvm250042mdgp07n082ib	\N	cmbhqvlqr003ymdgpruvr2f1s	WITHDRAWAL	PENDING	5900	0	179	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 59	MockPaymentProvider	dcerHThfeGVP2TDI	\N	\N	{"ipAddress": "144.249.51.238", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Linux; Android 7; SM-T800) AppleWebKit/583.54 (KHTML, like Gecko) Chrome/75.2.0.17 Mobile Safari/569.83"}}	2025-06-04 09:28:05.741	2025-06-04 09:28:05.741	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	cmbhqua2y0000mdgpha4dsggk
cmbhqvm880044mdgp9yarz1yk	2025-06-04 09:28:05.958	cmbhqvlqr003ymdgpruvr2f1s	BET_PLACE	COMPLETED	730	-730	\N	\N	INSTORE_CARD	229141	228411	168	168	\N	\N	\N	BET_PLACE of 7.3	System	nKytCiWsj1IH62Fr	\N	\N	{"ipAddress": "69.74.56.186", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (Linux; Android 7; SM-G998B) AppleWebKit/567.95 (KHTML, like Gecko) Chrome/80.6.5.17 Mobile Safari/541.75"}}	2025-06-04 09:28:05.96	2025-06-04 09:28:05.96	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	cmbhqua2y0000mdgpha4dsggk
cmbhqvmdv0046mdgpkyf3we60	\N	cmbhqvlqr003ymdgpruvr2f1s	WITHDRAWAL	PENDING	9147	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 91.47	MockPaymentProvider	GKv9PlqLY6zrQWdD	\N	\N	{"ipAddress": "c1da:4a8d:47dc:7d47:c6bb:a87f:6f50:fbc7", "deviceInfo": {"os": "iOS", "browser": "Googlebot/2.1 (+http://www.google.com/bot.html)"}}	2025-06-04 09:28:06.163	2025-06-04 09:28:06.163	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	cmbhqua2y0000mdgpha4dsggk
cmbhqvn0w004amdgpyokwhi7y	2025-06-04 09:28:06.991	cmbhqvmv70048mdgph59qc0w7	BONUS_AWARD	FAILED	4645	0	\N	\N	CASH_APP	\N	\N	\N	\N	4645	\N	\N	BONUS_AWARD of 46.45	System	1Zk8iLOEVgCMn7Dx	\N	\N	{"ipAddress": "180.141.219.22", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (Windows NT 6.1; Win64; x64) AppleWebKit/573.61 (KHTML, like Gecko) Chrome/59.1.10.0 Safari/564.41 Edg/116.1.20.12"}}	2025-06-04 09:28:06.993	2025-06-04 09:28:06.993	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqua2y0000mdgpha4dsggk
cmbhqvn6m004cmdgp31f6wj3w	2025-06-04 09:28:07.196	cmbhqvmv70048mdgph59qc0w7	DEPOSIT	COMPLETED	18438	18438	\N	\N	CASH_APP	84640	103078	3151	3151	\N	\N	\N	DEPOSIT of 184.38	MockPaymentProvider	90yZhAOo9KUuEC2V	\N	\N	{"ipAddress": "ca5d:c5b8:6cfe:3c7e:e3c9:b489:8d82:ae9c", "deviceInfo": {"os": "Android", "browser": "Mozilla/5.0 (iPhone; CPU iPhone OS 10_1 like Mac OS X) AppleWebKit/597.62.54 (KHTML, like Gecko) Version/16_1 Mobile/15E148 Safari/539.48"}}	2025-06-04 09:28:07.198	2025-06-04 09:28:07.198	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqua2y0000mdgpha4dsggk
cmbhqvncc004emdgp59pywetj	\N	cmbhqvmv70048mdgph59qc0w7	WITHDRAWAL	PENDING	2117	0	172	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 21.17	MockPaymentProvider	BoCPBOOVT3kwi79Q	\N	\N	{"ipAddress": "189.185.51.23", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101 Firefox/111.0"}}	2025-06-04 09:28:07.404	2025-06-04 09:28:07.404	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqua2y0000mdgpha4dsggk
cmbhqvni2004gmdgprc51o050	2025-06-04 09:28:07.609	cmbhqvmv70048mdgph59qc0w7	BET_PLACE	FAILED	3967	0	\N	\N	CASH_APP	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 39.67	System	bT3WmFOQMKmWZelx	\N	\N	{"ipAddress": "102.34.209.102", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (compatible; MSIE 9.0; Windows NT 6.0; Trident/4.0)"}}	2025-06-04 09:28:07.61	2025-06-04 09:28:07.61	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqua2y0000mdgpha4dsggk
cmbhqvnnt004imdgp0h1mhjte	2025-06-04 09:28:07.815	cmbhqvmv70048mdgph59qc0w7	WITHDRAWAL	COMPLETED	3797	-3867	70	\N	CASH_APP	103078	99211	3151	3151	\N	\N	\N	WITHDRAWAL of 37.97	MockPaymentProvider	qXYiwklcrWZDGHJj	\N	\N	{"ipAddress": "29.7.180.221", "deviceInfo": {"os": "MacOS", "browser": "Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 5.2; Trident/4.0)"}}	2025-06-04 09:28:07.817	2025-06-04 09:28:07.817	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqua2y0000mdgpha4dsggk
cmbhqvoa4004mmdgpiwxbwe81	2025-06-04 09:28:08.619	cmbhqvo4i004kmdgp4xc5j0si	WITHDRAWAL	FAILED	4178	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 41.78	MockPaymentProvider	gDd1WhxxuqWiDPO2	\N	\N	{"ipAddress": "9296:1e08:fe4a:4cf5:56dd:bce7:d7b9:2dbe", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (compatible; MSIE 7.0; Windows NT 6.0; Trident/7.0)"}}	2025-06-04 09:28:08.62	2025-06-04 09:28:08.62	e4489c4c-93ee-4220-873a-0568c7e65322	cmbhqua2y0000mdgpha4dsggk
cmbhqvofu004omdgp15s7iomm	2025-06-04 09:28:08.825	cmbhqvo4i004kmdgp4xc5j0si	WITHDRAWAL	FAILED	8962	0	113	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 89.62	MockPaymentProvider	nd0Xbap9u2fMKWu7	\N	\N	{"ipAddress": "241.229.184.2", "deviceInfo": {"os": "Windows", "browser": "Mozilla/5.0 (compatible; MSIE 6.0; Windows NT 5.1; Trident/5.0)"}}	2025-06-04 09:28:08.826	2025-06-04 09:28:08.826	e4489c4c-93ee-4220-873a-0568c7e65322	cmbhqua2y0000mdgpha4dsggk
cmbhqvowp004smdgpdulk3pcn	\N	cmbhqvor4004qmdgphgvsnn8v	BET_PLACE	PENDING	349	0	\N	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	BET_PLACE of 3.49	System	sUk2Fe9M15GaPU4P	\N	\N	{"ipAddress": "2bba:4241:b89c:a48e:d1ce:66d2:de6e:3d6f", "deviceInfo": {"os": "Windows", "browser": "FakerBot/2.1.2"}}	2025-06-04 09:28:09.433	2025-06-04 09:28:09.433	977422d6-241d-4aa4-8c6d-080a97737d11	cmbhqua2y0000mdgpha4dsggk
cmbhqvp2e004umdgp9h7z465y	2025-06-04 09:28:09.637	cmbhqvor4004qmdgphgvsnn8v	WITHDRAWAL	FAILED	8911	0	136	\N	INSTORE_CARD	\N	\N	\N	\N	\N	\N	\N	WITHDRAWAL of 89.11	MockPaymentProvider	6HjRodz99d54ZNbI	\N	\N	{"ipAddress": "223.124.208.248", "deviceInfo": {"os": "MacOS", "browser": "Googlebot/2.1 (+http://www.google.com/bot.html)"}}	2025-06-04 09:28:09.638	2025-06-04 09:28:09.638	977422d6-241d-4aa4-8c6d-080a97737d11	cmbhqua2y0000mdgpha4dsggk
cmbhxczl280yjvrxp	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	1000000	999800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 12:29:33.959	2025-06-04 12:29:33.959	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhxfmf25j7i6v0x	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	999800	999600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 12:31:36.849	2025-06-04 12:31:36.849	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhxfo8tjngrelky	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	999600	999400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 12:31:39.226	2025-06-04 12:31:39.226	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhxfpty6emgy2c1	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	999400	999200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 12:31:41.37	2025-06-04 12:31:41.37	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhxfrljtsicsjnx	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	999200	999000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 12:31:43.645	2025-06-04 12:31:43.645	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhz0xs3sgs25pzy	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	999000	998800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:16:10.978	2025-06-04 13:16:10.978	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhz2eyhzng42vep	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	998800	998600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:17:19.889	2025-06-04 13:17:19.889	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhz2h61yh63emoo	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	998600	998400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:17:22.752	2025-06-04 13:17:22.752	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhzsxnt8wwvatg1	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	998200	998000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:37:57.185	2025-06-04 13:37:57.185	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbhzt0rzg3k6dhqj	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	998000	997800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:38:01.229	2025-06-04 13:38:01.229	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0gawl5e7xo0ca	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	997800	997600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:07.433	2025-06-04 13:56:07.433	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0geqez62bqnay	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	997600	997400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:12.405	2025-06-04 13:56:12.405	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0ghdj0ezbzidu	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	997400	997200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:15.822	2025-06-04 13:56:15.822	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0gixn4agd2h3v	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	997200	997000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:17.848	2025-06-04 13:56:17.848	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0gkbnfn1vc62b	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	997000	996800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:19.658	2025-06-04 13:56:19.658	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0h0vh8xmk3nhs	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	996800	996600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:41.093	2025-06-04 13:56:41.093	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0h2f2v355brjv	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	996600	996400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:43.09	2025-06-04 13:56:43.09	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0h3u765s3fouq	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	996400	996200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:44.938	2025-06-04 13:56:44.938	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0h55ru006k26t	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	996200	996000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:46.732	2025-06-04 13:56:46.732	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi0h6gaaasf25bm	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	996000	995800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 13:56:48.405	2025-06-04 13:56:48.405	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi10ubui0l3l4sr	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	995800	995600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:05.738	2025-06-04 14:12:05.738	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi11i1t9ljiq6fh	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	995600	995400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:36.476	2025-06-04 14:12:36.476	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi11jn7eqa4rajr	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	995400	995200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:38.541	2025-06-04 14:12:38.541	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi11lt18zzk56pj	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	995200	995000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:41.347	2025-06-04 14:12:41.347	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi11n55unx3i2d5	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	995000	994800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:43.083	2025-06-04 14:12:43.083	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi11qm8ucbxvzzm	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	994800	994600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:47.579	2025-06-04 14:12:47.579	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi11s5edr4nesl8	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	994600	994400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:49.568	2025-06-04 14:12:49.568	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi11tvy15rct2n6	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	994400	994200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:12:51.811	2025-06-04 14:12:51.811	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi1kaoptbh43dk3	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	994200	994000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:27:13.391	2025-06-04 14:27:13.391	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi1kd3ql4c4mtev	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	994000	993800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:27:16.536	2025-06-04 14:27:16.536	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi1kepcgy98lt1q	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	993800	993600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:27:18.593	2025-06-04 14:27:18.593	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi1kg864r2amb82	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	993600	993400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:27:20.575	2025-06-04 14:27:20.575	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi1khnpbkgqqchn	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	993400	993200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:27:22.437	2025-06-04 14:27:22.437	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi20lfrp16mgp1m	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	993200	993000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:39:53.821	2025-06-04 14:39:53.821	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi20n7868xk8i21	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	993000	992800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:39:56.11	2025-06-04 14:39:56.11	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi20otq3gbuj0fj	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	992800	992600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:39:58.217	2025-06-04 14:39:58.217	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi20q7a9b98lskk	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	992600	992400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:39:59.998	2025-06-04 14:39:59.998	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi20rn5qd2hsfq8	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	992400	992200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:40:01.861	2025-06-04 14:40:01.861	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi23qdaaqq6jir1	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	992200	992000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:42:20.179	2025-06-04 14:42:20.179	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi23s2gj5j0vutb	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	992000	991800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:42:22.383	2025-06-04 14:42:22.383	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi23tpe3wqze2dr	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	991800	991600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:42:24.494	2025-06-04 14:42:24.494	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi23v46xe5cy924	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	991600	991400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:42:26.318	2025-06-04 14:42:26.318	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi23wkbie4xy0t1	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	991400	991200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:42:28.208	2025-06-04 14:42:28.208	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi23y30a1sgcuuq	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	991200	991000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:42:30.183	2025-06-04 14:42:30.183	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi28470epspiced	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	991000	990800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:45:44.706	2025-06-04 14:45:44.706	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi285ilc3oudf55	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	990800	990600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:45:46.522	2025-06-04 14:45:46.522	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi286om5ndkbpdu	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	990600	990400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:45:48.039	2025-06-04 14:45:48.039	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi287tzz18xrzcx	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	990400	990200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:45:49.524	2025-06-04 14:45:49.524	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi288unfueh468n	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	990200	990000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:45:50.845	2025-06-04 14:45:50.845	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi289s00ra45rgh	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	990000	989800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:45:52.049	2025-06-04 14:45:52.049	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi28av3e4dy17we	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	989800	989600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 14:45:53.448	2025-06-04 14:45:53.448	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4b6j8zq2ryc6h	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	989600	989400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:44:06.938	2025-06-04 15:44:06.938	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4ebog0bwwbw0h	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	989400	989200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:46:33.593	2025-06-04 15:46:33.593	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4ekjzab5yr5fs	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	989200	989000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:46:45.082	2025-06-04 15:46:45.082	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4eon3pukb5t0s	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	989000	988800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:46:50.399	2025-06-04 15:46:50.399	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4naxuk8o6wvd0	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	988800	988600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:53:32.542	2025-06-04 15:53:32.542	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4nmvixnufjp70	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	988600	988400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:53:48.011	2025-06-04 15:53:48.011	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4nr8yd819uyku	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	988400	988200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:53:53.679	2025-06-04 15:53:53.679	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4nv6j85lq7vt0	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	988200	988000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:53:58.773	2025-06-04 15:53:58.773	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4v99hbhxr6kxz	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	988000	987800	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:59:43.618	2025-06-04 15:59:43.618	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4vf37l3u0zg3r	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	987800	987600	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:59:51.173	2025-06-04 15:59:51.173	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4vhhrhiglvgzn	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	987600	987400	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:59:54.285	2025-06-04 15:59:54.285	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4vjkam76lbtrr	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	987400	987200	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 15:59:56.962	2025-06-04 15:59:56.962	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk
cmbi4vo2d0qp21yam	\N	cmbhtozepceb96bt1	BET	COMPLETED	-200	\N	\N	\N	\N	987200	987000	\N	\N	\N	\N	\N	Bet on RTG	RTG	bet-202900066	cmbhqvuap005bmdgpz22hm62v	202900066	\N	2025-06-04 16:00:02.789	2025-06-04 16:00:02.789	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk



--
-- TOC entry 4353 (class 0 OID 29671)
-- Dependencies: 328
-- Data for Name: user; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public."user" (_id, name, username, display_username, email, email_verified, image, created_at, updated_at) FROM stdin;
44e19cc5-466c-4551-8719-621ed777c04f	Administrator Prime	admincasino	AdminCasino	admin@casino.example.com	t	https://avatars.githubusercontent.com/u/96196354	2025-06-04 09:27:03.967	2025-06-04 09:27:03.967
07a496cb-79bf-446a-a4c1-e39a63e2c7c2	Bart Harris	bart.harris130	Bart15	bart0.harris59@yahoo.com	t	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/80.jpg	2025-06-04 09:27:04.886	2025-06-04 09:27:04.886
b0417f70-9963-4850-8872-3263fefdef55	Miracle Dare	miracle.dare1	Miracle27	miracle1.dare68@hotmail.com	t	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/42.jpg	2025-06-04 09:27:05.831	2025-06-04 09:27:05.831
c933392d-433b-404f-9d7a-9e7ad3dc82a6	Rosalia Rice	rosalia_rice2	Rosalia21	rosalia2_rice48@gmail.com	f	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/36.jpg	2025-06-04 09:27:06.735	2025-06-04 09:27:06.735
ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	Alanis Kerluke	alanis.kerluke3	Alanis16	alanis3.kerluke9@gmail.com	t	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/67.jpg	2025-06-04 09:27:07.645	2025-06-04 09:27:07.645
383d5111-8bfb-4862-a1ff-0e47d251c542	Conor Tromp	conor_tromp4	Conor26	conor4.tromp79@hotmail.com	f	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/25.jpg	2025-06-04 09:27:08.564	2025-06-04 09:27:08.564
66426961-c20f-4883-900f-c6bc0b13172c	Berenice Runolfsson	berenice.runolfsson585	Berenice27	berenice5.runolfsson@yahoo.com	t	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/0.jpg	2025-06-04 09:27:09.476	2025-06-04 09:27:09.476
78ca58fd-7e97-470d-864d-1b995208b2e6	Gino VonRueden	gino_vonrueden856	Gino70	gino6.vonrueden70@gmail.com	f	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/31.jpg	2025-06-04 09:27:10.387	2025-06-04 09:27:10.387
247c044f-dfb9-4cae-9b72-3e9f80747f2b	Arjun Schulist	arjun_schulist357	Arjun29	arjun7_schulist18@yahoo.com	t	https://avatars.githubusercontent.com/u/45546336	2025-06-04 09:27:11.354	2025-06-04 09:27:11.354
77a5e0cd-6bd4-4803-8328-a984b687acc4	Eden Ebert	eden_ebert8	Eden90	eden8.ebert@hotmail.com	t	https://avatars.githubusercontent.com/u/44398270	2025-06-04 09:27:12.315	2025-06-04 09:27:12.315
a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	Tyrel Kozey	tyrel.kozey9	Tyrel42	tyrel9_kozey40@gmail.com	f	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/74.jpg	2025-06-04 09:27:13.281	2025-06-04 09:27:13.281
bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	Libby Padberg	libby_padberg9710	Libby59	libby10.padberg@gmail.com	f	https://avatars.githubusercontent.com/u/96330966	2025-06-04 09:27:14.242	2025-06-04 09:27:14.242
7851298a-157c-4e0a-9163-b97f4c8c8535	Cruz Stokes	cruz_stokes11	Cruz15	cruz11.stokes@hotmail.com	t	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/29.jpg	2025-06-04 09:27:15.218	2025-06-04 09:27:15.218
0510f126-3b7a-4e60-8122-9e53b707b8c3	Ottis Lindgren	ottis_lindgren12	Ottis64	ottis12.lindgren@gmail.com	t	https://avatars.githubusercontent.com/u/49707023	2025-06-04 09:27:16.137	2025-06-04 09:27:16.137
dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	Rashawn Hand	rashawn.hand13	Rashawn30	rashawn13.hand@yahoo.com	t	https://avatars.githubusercontent.com/u/95934514	2025-06-04 09:27:17.102	2025-06-04 09:27:17.102
93c893af-8756-474e-934e-b08fad0a78fc	Patsy Howell	patsy_howell14	Patsy30	patsy14_howell47@yahoo.com	t	https://avatars.githubusercontent.com/u/18504840	2025-06-04 09:27:18.015	2025-06-04 09:27:18.015
b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	Marc Wintheiser	marc_wintheiser15	Marc68	marc15.wintheiser@yahoo.com	f	https://avatars.githubusercontent.com/u/55168520	2025-06-04 09:27:18.992	2025-06-04 09:27:18.992
6c5ccec3-2978-4054-b1fa-de27b31bc7f1	Taurean Ebert	taurean.ebert16	Taurean39	taurean16_ebert99@gmail.com	t	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/48.jpg	2025-06-04 09:27:19.906	2025-06-04 09:27:19.906
65c3736c-5514-4c4f-9f57-2c11d3863657	Amos Corkery	amos.corkery17	Amos47	amos17.corkery@hotmail.com	t	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/19.jpg	2025-06-04 09:27:20.818	2025-06-04 09:27:20.818
e4489c4c-93ee-4220-873a-0568c7e65322	Sandy Daugherty	sandy.daugherty6418	Sandy69	sandy18_daugherty40@hotmail.com	f	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/25.jpg	2025-06-04 09:27:21.783	2025-06-04 09:27:21.783
977422d6-241d-4aa4-8c6d-080a97737d11	Maribel Mann	maribel_mann19	Maribel47	maribel19.mann1@yahoo.com	f	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/88.jpg	2025-06-04 09:27:22.724	2025-06-04 09:27:22.724
KDD59juLi7g0nwKhS0fVFjNFrO7GinCO	asdf	asdf	asdf	asdf@cashflow.com	f	\N	2025-06-04 10:43:07.853	2025-06-04 10:43:07.853
eTGvUvHx26rHPbsqX7DdinXgSjpUGhFC	asdf2	asdf2	asdf2	asdf2@cashflow.com	f	\N	2025-06-04 10:44:46.106	2025-06-04 10:44:46.106
qfw6qGODKsjisZYWZV5UuqrKtssXvZOW	asdf3	asdf3	asdf3	asdf3@cashflow.com	f	\N	2025-06-04 10:45:10.461	2025-06-04 10:45:10.461
n54PJz49x6q6Ah6rGN2Fksi5y1ZpXeB2	asdf4	asdf4	asdf4	asdf4@cashflow.com	f	\N	2025-06-04 10:45:21.047	2025-06-04 10:45:21.047
41q73jCZmxVD27ZBISWqTY4WupCxXpgI	asdf5	asdf5	asdf5	asdf5@cashflow.com	f	\N	2025-06-04 10:45:44.777	2025-06-04 10:45:44.777
LfZ8rW9WO8IuC1UqwwU8jZtxCusdKJYI	asdf6	asdf6	asdf6	asdf6@cashflow.com	f	\N	2025-06-04 10:46:06.247	2025-06-04 10:46:06.247
lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	asdf7	asdf7	asdf7	asdf7@cashflow.com	f	\N	2025-06-04 10:46:54.386	2025-06-04 10:46:54.386



--
-- TOC entry 4378 (class 0 OID 29909)
-- Dependencies: 353
-- Data for Name: user_profiles; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.user_profiles (id, created_at, updated_at, username, avatar, cashtag, balance, total_xp_from_operator, active_currency_type, last_daily_spin, user_id, is_active, other_userid, role, operator_id, current_game_sessionid, vip_info_id) FROM stdin;
44e19cc5-466c-4551-8719-621ed777c04f	2025-06-04 09:27:23.906	2025-06-04 09:27:23.906	admincasino	https://avatars.githubusercontent.com/u/96196354	$admincasinogzx	29015	98018	USD	2025-01-11 23:52:12.622	44e19cc5-466c-4551-8719-621ed777c04f	t	\N	ADMIN	cmbhqua2y0000mdgpha4dsggk	\N	44e19cc5-466c-4551-8719-621ed777c04f
07a496cb-79bf-446a-a4c1-e39a63e2c7c2	2025-06-04 09:27:24.525	2025-06-04 09:27:24.525	bart.harris130	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/80.jpg	$bartharris1304ml	30296	15587	USD	2024-07-02 04:14:45.76	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	07a496cb-79bf-446a-a4c1-e39a63e2c7c2
b0417f70-9963-4850-8872-3263fefdef55	2025-06-04 09:27:25.156	2025-06-04 09:27:25.156	miracle.dare1	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/42.jpg	$miracledare1jn4	175746	32816	USD	2024-07-08 23:27:26.51	b0417f70-9963-4850-8872-3263fefdef55	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	b0417f70-9963-4850-8872-3263fefdef55
c933392d-433b-404f-9d7a-9e7ad3dc82a6	2025-06-04 09:27:25.778	2025-06-04 09:27:25.778	rosalia_rice2	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/36.jpg	$rosaliarice2z6c	159933	17384	USD	2024-10-18 12:56:51.26	c933392d-433b-404f-9d7a-9e7ad3dc82a6	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	c933392d-433b-404f-9d7a-9e7ad3dc82a6
66426961-c20f-4883-900f-c6bc0b13172c	2025-06-04 09:27:27.626	2025-06-04 09:27:27.626	berenice.runolfsson585	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/0.jpg	$berenicerunolfsson585lqa	172763	77776	USD	2025-03-31 10:51:58.904	66426961-c20f-4883-900f-c6bc0b13172c	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	66426961-c20f-4883-900f-c6bc0b13172c
78ca58fd-7e97-470d-864d-1b995208b2e6	2025-06-04 09:27:28.251	2025-06-04 09:27:28.251	gino_vonrueden856	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/31.jpg	$ginovonrueden856do4	156695	48280	USD	2025-05-18 22:40:17.733	78ca58fd-7e97-470d-864d-1b995208b2e6	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	78ca58fd-7e97-470d-864d-1b995208b2e6
247c044f-dfb9-4cae-9b72-3e9f80747f2b	2025-06-04 09:27:28.883	2025-06-04 09:27:28.883	arjun_schulist357	https://avatars.githubusercontent.com/u/45546336	$arjunschulist357q2g	102490	39218	USD	2024-10-18 15:08:18.714	247c044f-dfb9-4cae-9b72-3e9f80747f2b	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	247c044f-dfb9-4cae-9b72-3e9f80747f2b
77a5e0cd-6bd4-4803-8328-a984b687acc4	2025-06-04 09:27:29.512	2025-06-04 09:27:29.512	eden_ebert8	https://avatars.githubusercontent.com/u/44398270	$edenebert8mc2	143435	3137	USD	2025-03-22 04:19:11.17	77a5e0cd-6bd4-4803-8328-a984b687acc4	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	77a5e0cd-6bd4-4803-8328-a984b687acc4
a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	2025-06-04 09:27:30.135	2025-06-04 09:27:30.135	tyrel.kozey9	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/74.jpg	$tyrelkozey9fga	32617	94294	USD	2024-11-25 08:40:37.48	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7
bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	2025-06-04 09:27:30.788	2025-06-04 09:27:30.788	libby_padberg9710	https://avatars.githubusercontent.com/u/96330966	$libbypadberg9710zaw	10286	70592	USD	2025-02-13 18:21:31.235	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0
7851298a-157c-4e0a-9163-b97f4c8c8535	2025-06-04 09:27:31.426	2025-06-04 09:27:31.426	cruz_stokes11	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/29.jpg	$cruzstokes11o6f	130978	3772	USD	2024-07-04 17:08:29.627	7851298a-157c-4e0a-9163-b97f4c8c8535	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	7851298a-157c-4e0a-9163-b97f4c8c8535
0510f126-3b7a-4e60-8122-9e53b707b8c3	2025-06-04 09:27:32.08	2025-06-04 09:27:32.08	ottis_lindgren12	https://avatars.githubusercontent.com/u/49707023	$ottislindgren12vb9	183265	7787	USD	2025-05-08 01:47:19.752	0510f126-3b7a-4e60-8122-9e53b707b8c3	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	0510f126-3b7a-4e60-8122-9e53b707b8c3
dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	2025-06-04 09:27:32.692	2025-06-04 09:27:32.692	rashawn.hand13	https://avatars.githubusercontent.com/u/95934514	$rashawnhand13eem	14692	69481	USD	2024-11-20 09:05:18.296	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70
93c893af-8756-474e-934e-b08fad0a78fc	2025-06-04 09:27:33.319	2025-06-04 09:27:33.319	patsy_howell14	https://avatars.githubusercontent.com/u/18504840	$patsyhowell14rlq	221642	36851	USD	2024-08-03 11:51:14.838	93c893af-8756-474e-934e-b08fad0a78fc	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	93c893af-8756-474e-934e-b08fad0a78fc
b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	2025-06-04 09:27:33.94	2025-06-04 09:27:33.94	marc_wintheiser15	https://avatars.githubusercontent.com/u/55168520	$marcwintheiser15mk2	209160	2054	USD	2024-08-17 06:16:58.16	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1
6c5ccec3-2978-4054-b1fa-de27b31bc7f1	2025-06-04 09:27:34.571	2025-06-04 09:27:34.571	taurean.ebert16	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/48.jpg	$taureanebert16hwp	229141	98066	USD	2025-02-13 10:49:55.045	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	6c5ccec3-2978-4054-b1fa-de27b31bc7f1
65c3736c-5514-4c4f-9f57-2c11d3863657	2025-06-04 09:27:35.201	2025-06-04 09:27:35.201	amos.corkery17	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/19.jpg	$amoscorkery178sh	84640	57764	USD	2024-06-15 15:21:26.825	65c3736c-5514-4c4f-9f57-2c11d3863657	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	65c3736c-5514-4c4f-9f57-2c11d3863657
e4489c4c-93ee-4220-873a-0568c7e65322	2025-06-04 09:27:35.831	2025-06-04 09:27:35.831	sandy.daugherty6418	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/25.jpg	$sandydaugherty6418ld9	198002	52963	USD	2025-01-26 13:24:55.939	e4489c4c-93ee-4220-873a-0568c7e65322	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	e4489c4c-93ee-4220-873a-0568c7e65322
977422d6-241d-4aa4-8c6d-080a97737d11	2025-06-04 09:27:36.453	2025-06-04 09:27:36.453	maribel_mann19	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/88.jpg	$maribelmann19dqv	247073	56852	USD	2025-03-27 06:07:26.112	977422d6-241d-4aa4-8c6d-080a97737d11	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	977422d6-241d-4aa4-8c6d-080a97737d11
ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	2025-06-04 09:27:26.395	2025-06-04 09:28:35.13	alanis.kerluke3	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/67.jpg	$alaniskerluke3rsr	32132	38167	USD	2024-08-13 14:19:48.813	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	cmbhqw8kt00csmdgp0zm85wsy	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa
383d5111-8bfb-4862-a1ff-0e47d251c542	2025-06-04 09:27:27.006	2025-06-04 09:28:39.901	conor_tromp4	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/25.jpg	$conortromp4kbj	94389	42983	USD	2024-11-02 17:46:04.188	383d5111-8bfb-4862-a1ff-0e47d251c542	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	cmbhqwc9d00dwmdgp5i0xtxa6	383d5111-8bfb-4862-a1ff-0e47d251c542
lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	2025-06-04 10:46:55.064	2025-06-04 10:46:55.064	asdf7	avatar-10.webp	\N	0	0	USD	1970-01-01 00:00:00	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	t	\N	USER	cmbhqua2y0000mdgpha4dsggk	\N	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj



--
-- TOC entry 4356 (class 0 OID 29692)
-- Dependencies: 331
-- Data for Name: verification; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.verification (_id, identifier, value, expires_at, created_at, updated_at) FROM stdin;



--
-- TOC entry 4379 (class 0 OID 29924)
-- Dependencies: 354
-- Data for Name: vip_infos; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.vip_infos (id, created_at, updated_at, username, avatar, user_id, level, current_level_xp, total_xp, daily_bonus_claimed_at, weekly_bonus_claimed_at, monthly_bonus_claimed_at, cashback_percentage) FROM stdin;
44e19cc5-466c-4551-8719-621ed777c04f	2025-06-04 09:27:23.7	2025-06-04 09:27:36.862	admincasino	https://avatars.githubusercontent.com/u/96196354	44e19cc5-466c-4551-8719-621ed777c04f	5	392	98030	\N	\N	\N	0
07a496cb-79bf-446a-a4c1-e39a63e2c7c2	2025-06-04 09:27:24.317	2025-06-04 09:27:37.272	bart.harris130	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/80.jpg	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	10	401	15682	\N	\N	\N	7
b0417f70-9963-4850-8872-3263fefdef55	2025-06-04 09:27:24.946	2025-06-04 09:27:37.684	miracle.dare1	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/42.jpg	b0417f70-9963-4850-8872-3263fefdef55	5	655	34296	2025-06-04 07:31:22.226	\N	2025-05-20 20:02:09.685	3
c933392d-433b-404f-9d7a-9e7ad3dc82a6	2025-06-04 09:27:25.571	2025-06-04 09:27:38.091	rosalia_rice2	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/36.jpg	c933392d-433b-404f-9d7a-9e7ad3dc82a6	4	564	18062	2025-06-03 12:07:32.881	\N	\N	2
ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	2025-06-04 09:27:26.187	2025-06-04 09:27:38.514	alanis.kerluke3	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/67.jpg	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	0	760	39390	\N	\N	2025-05-27 16:25:28.509	0
383d5111-8bfb-4862-a1ff-0e47d251c542	2025-06-04 09:27:26.805	2025-06-04 09:27:38.925	conor_tromp4	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/25.jpg	383d5111-8bfb-4862-a1ff-0e47d251c542	5	1160	43912	\N	\N	2025-06-01 18:45:28.658	2
66426961-c20f-4883-900f-c6bc0b13172c	2025-06-04 09:27:27.416	2025-06-04 09:27:39.333	berenice.runolfsson585	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/0.jpg	66426961-c20f-4883-900f-c6bc0b13172c	1	1070	79684	\N	\N	\N	8
78ca58fd-7e97-470d-864d-1b995208b2e6	2025-06-04 09:27:28.04	2025-06-04 09:27:39.742	gino_vonrueden856	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/31.jpg	78ca58fd-7e97-470d-864d-1b995208b2e6	8	581	49911	2025-06-03 15:07:58.178	\N	\N	13
247c044f-dfb9-4cae-9b72-3e9f80747f2b	2025-06-04 09:27:28.682	2025-06-04 09:27:40.158	arjun_schulist357	https://avatars.githubusercontent.com/u/45546336	247c044f-dfb9-4cae-9b72-3e9f80747f2b	6	474	40364	\N	\N	\N	15
77a5e0cd-6bd4-4803-8328-a984b687acc4	2025-06-04 09:27:29.295	2025-06-04 09:27:40.572	eden_ebert8	https://avatars.githubusercontent.com/u/44398270	77a5e0cd-6bd4-4803-8328-a984b687acc4	2	721	4128	2025-06-03 21:52:31.113	\N	\N	8
a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	2025-06-04 09:27:29.926	2025-06-04 09:27:40.974	tyrel.kozey9	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/74.jpg	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	2	903	94956	\N	2025-06-02 08:26:01.006	\N	8
bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	2025-06-04 09:27:30.582	2025-06-04 09:27:41.393	libby_padberg9710	https://avatars.githubusercontent.com/u/96330966	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	9	764	71665	\N	\N	\N	14
7851298a-157c-4e0a-9163-b97f4c8c8535	2025-06-04 09:27:31.212	2025-06-04 09:27:41.8	cruz_stokes11	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/29.jpg	7851298a-157c-4e0a-9163-b97f4c8c8535	7	113	5602	\N	\N	\N	5
0510f126-3b7a-4e60-8122-9e53b707b8c3	2025-06-04 09:27:31.832	2025-06-04 09:27:42.212	ottis_lindgren12	https://avatars.githubusercontent.com/u/49707023	0510f126-3b7a-4e60-8122-9e53b707b8c3	10	873	7825	2025-06-03 14:45:05.634	\N	\N	3
dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	2025-06-04 09:27:32.481	2025-06-04 09:27:42.628	rashawn.hand13	https://avatars.githubusercontent.com/u/95934514	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	7	936	70581	\N	\N	\N	5
93c893af-8756-474e-934e-b08fad0a78fc	2025-06-04 09:27:33.114	2025-06-04 09:27:43.043	patsy_howell14	https://avatars.githubusercontent.com/u/18504840	93c893af-8756-474e-934e-b08fad0a78fc	10	1067	37325	2025-06-03 15:09:55.236	\N	\N	1
b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	2025-06-04 09:27:33.734	2025-06-04 09:27:43.455	marc_wintheiser15	https://avatars.githubusercontent.com/u/55168520	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	4	1404	3422	2025-06-03 19:07:39.806	\N	\N	6
6c5ccec3-2978-4054-b1fa-de27b31bc7f1	2025-06-04 09:27:34.356	2025-06-04 09:27:43.863	taurean.ebert16	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/female/512/48.jpg	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	7	725	99112	2025-06-04 02:06:21.885	\N	2025-05-20 05:47:20.193	5
65c3736c-5514-4c4f-9f57-2c11d3863657	2025-06-04 09:27:34.993	2025-06-04 09:27:44.271	amos.corkery17	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/19.jpg	65c3736c-5514-4c4f-9f57-2c11d3863657	8	1155	59568	\N	\N	\N	7
e4489c4c-93ee-4220-873a-0568c7e65322	2025-06-04 09:27:35.62	2025-06-04 09:27:44.684	sandy.daugherty6418	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/25.jpg	e4489c4c-93ee-4220-873a-0568c7e65322	7	683	53807	\N	\N	\N	8
977422d6-241d-4aa4-8c6d-080a97737d11	2025-06-04 09:27:36.246	2025-06-04 09:27:45.095	maribel_mann19	https://cdn.jsdelivr.net/gh/faker-js/assets-person-portrait/male/512/88.jpg	977422d6-241d-4aa4-8c6d-080a97737d11	5	885	58297	2025-06-04 02:56:11.261	2025-06-02 00:29:00.416	\N	6
ohUhEWleCDu4Z4SLNR4S22LhlFJw99ZZ	2025-06-04 09:48:35.342	2025-06-04 09:48:35.342	asdf3	avatar-10.webp	ohUhEWleCDu4Z4SLNR4S22LhlFJw99ZZ	0	0	0	\N	\N	\N	0
y3WCJExfsZtJOYCaIITd2739DhEz7LA5	2025-06-04 10:37:12.793	2025-06-04 10:37:12.793	asdf19	avatar-10.webp	y3WCJExfsZtJOYCaIITd2739DhEz7LA5	0	0	0	\N	\N	\N	0
io4QObl0hRPgGmccdysNoN9RekdbdLQN	2025-06-04 10:37:47.648	2025-06-04 10:37:47.648	asdf20	avatar-10.webp	io4QObl0hRPgGmccdysNoN9RekdbdLQN	0	0	0	\N	\N	\N	0
lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	2025-06-04 10:46:55.064	2025-06-04 10:46:55.064	asdf7	avatar-10.webp	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	0	0	0	\N	\N	\N	0



--
-- TOC entry 4377 (class 0 OID 29897)
-- Dependencies: 352
-- Data for Name: wallets; Type: TABLE DATA; Schema: public; Owner: postgres
--

COPY public.wallets (id, balance, "isActive", address, "createdAt", "updatedAt", "userId", "operatorId", "paymentMethod", "bonusBalance", "lockedBalance") FROM stdin;
cmbhqv6lq0002mdgpt9r8b9pl	29015	t	\N	2025-06-04 09:27:45.711	2025-06-04 09:27:45.711	44e19cc5-466c-4551-8719-621ed777c04f	cmbhqua2y0000mdgpha4dsggk	INSTORE_CASH	895	0
cmbhqv7lw000cmdgp37tw1fax	19484	t	\N	2025-06-04 09:27:46.968	2025-06-04 09:27:48.244	07a496cb-79bf-446a-a4c1-e39a63e2c7c2	cmbhqua2y0000mdgpha4dsggk	INSTORE_CASH	2564	0
cmbhqv8ve000omdgp4axt24q9	188530	t	\N	2025-06-04 09:27:48.65	2025-06-04 09:27:49.479	b0417f70-9963-4850-8872-3263fefdef55	cmbhqua2y0000mdgpha4dsggk	INSTORE_CARD	3489	0
cmbhqv9tp000wmdgpwin2y777	159933	t	$rosalia_rice2vlu4	2025-06-04 09:27:49.885	2025-06-04 09:27:49.885	c933392d-433b-404f-9d7a-9e7ad3dc82a6	cmbhqua2y0000mdgpha4dsggk	CASH_APP	3816	0
cmbhqva54000ymdgpg3a4k9fe	32132	t	$alanis.kerluke3WTpb	2025-06-04 09:27:50.297	2025-06-04 09:27:50.297	ac8a5aa4-f8ff-41eb-9ed0-62a8f668f1aa	cmbhqua2y0000mdgpha4dsggk	CASH_APP	3380	0
cmbhqvaxn0016mdgp22xc6xtz	94389	t	\N	2025-06-04 09:27:51.324	2025-06-04 09:27:52.54	383d5111-8bfb-4862-a1ff-0e47d251c542	cmbhqua2y0000mdgpha4dsggk	INSTORE_CARD	7068	0
cmbhqvc6p001imdgpmxo453z2	172763	t	$berenice.runolfsson585ktmX	2025-06-04 09:27:52.945	2025-06-04 09:27:52.945	66426961-c20f-4883-900f-c6bc0b13172c	cmbhqua2y0000mdgpha4dsggk	CASH_APP	3101	0
cmbhqvcnr001mmdgpcb95g76e	156695	t	$gino_vonrueden8563Y5r	2025-06-04 09:27:53.559	2025-06-04 09:27:53.559	78ca58fd-7e97-470d-864d-1b995208b2e6	cmbhqua2y0000mdgpha4dsggk	CASH_APP	2498	0
cmbhqvdro001ymdgp8gpxt3yg	101220	t	\N	2025-06-04 09:27:54.996	2025-06-04 09:27:55.823	247c044f-dfb9-4cae-9b72-3e9f80747f2b	cmbhqua2y0000mdgpha4dsggk	INSTORE_CARD	3014	0
cmbhqveq50026mdgpwe48nbcq	161918	t	\N	2025-06-04 09:27:56.237	2025-06-04 09:27:57.27	77a5e0cd-6bd4-4803-8328-a984b687acc4	cmbhqua2y0000mdgpha4dsggk	INSTORE_CARD	3548	0
cmbhqvfu7002gmdgp8mojnzb3	26679	t	\N	2025-06-04 09:27:57.679	2025-06-04 09:27:58.708	a887aedc-d5ef-4eeb-95cc-10d5bc9b8fd7	cmbhqua2y0000mdgpha4dsggk	INSTORE_CASH	4453	0
cmbhqvgy0002qmdgpo26ayqyo	4151	t	\N	2025-06-04 09:27:59.112	2025-06-04 09:27:59.936	bc6dea7b-2ba1-4472-98ef-f040e8e63ef0	cmbhqua2y0000mdgpha4dsggk	INSTORE_CASH	7827	0
cmbhqvhw3002ymdgp3k7r1kx6	130978	t	\N	2025-06-04 09:28:00.339	2025-06-04 09:28:00.339	7851298a-157c-4e0a-9163-b97f4c8c8535	cmbhqua2y0000mdgpha4dsggk	INSTORE_CASH	3398	0
cmbhqviix0034mdgp2jhdnawn	183265	t	\N	2025-06-04 09:28:01.162	2025-06-04 09:28:01.162	0510f126-3b7a-4e60-8122-9e53b707b8c3	cmbhqua2y0000mdgpha4dsggk	INSTORE_CASH	686	0
cmbhqvjij003emdgpjq517s0w	14692	t	$rashawn.hand13IRP5	2025-06-04 09:28:02.443	2025-06-04 09:28:02.443	dc1cee48-6b77-4cc8-89f5-c3d7d02a9a70	cmbhqua2y0000mdgpha4dsggk	CASH_APP	2795	0
cmbhqvkh3003omdgp4nind7rl	220161	t	$patsy_howell14yWh4	2025-06-04 09:28:03.688	2025-06-04 09:28:04.312	93c893af-8756-474e-934e-b08fad0a78fc	cmbhqua2y0000mdgpha4dsggk	CASH_APP	3130	0
cmbhqvl9o003umdgpkrecjvou	209160	t	\N	2025-06-04 09:28:04.716	2025-06-04 09:28:04.716	b59d15f8-d4e0-4c15-98a1-97a2fcd7eeb1	cmbhqua2y0000mdgpha4dsggk	INSTORE_CASH	2993	0
cmbhqvlqr003ymdgpruvr2f1s	228411	t	\N	2025-06-04 09:28:05.331	2025-06-04 09:28:06.371	6c5ccec3-2978-4054-b1fa-de27b31bc7f1	cmbhqua2y0000mdgpha4dsggk	INSTORE_CARD	168	0
cmbhqvmv70048mdgph59qc0w7	99211	t	$amos.corkery17JWoz	2025-06-04 09:28:06.787	2025-06-04 09:28:08.014	65c3736c-5514-4c4f-9f57-2c11d3863657	cmbhqua2y0000mdgpha4dsggk	CASH_APP	3151	0
cmbhqvo4i004kmdgp4xc5j0si	198002	t	\N	2025-06-04 09:28:08.418	2025-06-04 09:28:08.418	e4489c4c-93ee-4220-873a-0568c7e65322	cmbhqua2y0000mdgpha4dsggk	INSTORE_CARD	1819	0
cmbhqvor4004qmdgphgvsnn8v	247073	t	\N	2025-06-04 09:28:09.232	2025-06-04 09:28:09.232	977422d6-241d-4aa4-8c6d-080a97737d11	cmbhqua2y0000mdgpha4dsggk	INSTORE_CARD	2099	0
cmbhtozepceb96bt1	9870	t	\N	2025-06-04 10:46:55.087	2025-06-04 16:00:02.789	lhL30ZMSSK9r1lzpyjjJ4vyJtqxarBZj	cmbhqua2y0000mdgpha4dsggk	CASH_APP	0	0



--
-- TOC entry 4346 (class 0 OID 26616)
-- Dependencies: 321
-- Data for Name: messages_2025_06_01; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_06_01 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;



--
-- TOC entry 4347 (class 0 OID 26627)
-- Dependencies: 322
-- Data for Name: messages_2025_06_02; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_06_02 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;



--
-- TOC entry 4348 (class 0 OID 26638)
-- Dependencies: 323
-- Data for Name: messages_2025_06_03; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_06_03 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;



--
-- TOC entry 4349 (class 0 OID 26649)
-- Dependencies: 324
-- Data for Name: messages_2025_06_04; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_06_04 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;



--
-- TOC entry 4350 (class 0 OID 26660)
-- Dependencies: 325
-- Data for Name: messages_2025_06_05; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_06_05 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;



--
-- TOC entry 4351 (class 0 OID 28313)
-- Dependencies: 326
-- Data for Name: messages_2025_06_06; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_06_06 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;



--
-- TOC entry 4352 (class 0 OID 28324)
-- Dependencies: 327
-- Data for Name: messages_2025_06_07; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.messages_2025_06_07 (topic, extension, payload, event, private, updated_at, inserted_at, id) FROM stdin;



--
-- TOC entry 4343 (class 0 OID 17060)
-- Dependencies: 314
-- Data for Name: schema_migrations; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.schema_migrations (version, inserted_at) FROM stdin;
20211116024918	2025-05-30 22:02:46
20211116045059	2025-05-30 22:02:49
20211116050929	2025-05-30 22:02:51
20211116051442	2025-05-30 22:02:53
20211116212300	2025-05-30 22:02:55
20211116213355	2025-05-30 22:02:57
20211116213934	2025-05-30 22:02:59
20211116214523	2025-05-30 22:03:02
20211122062447	2025-05-30 22:03:04
20211124070109	2025-05-30 22:03:06
20211202204204	2025-05-30 22:03:08
20211202204605	2025-05-30 22:03:10
20211210212804	2025-05-30 22:03:17
20211228014915	2025-05-30 22:03:19
20220107221237	2025-05-30 22:03:21
20220228202821	2025-05-30 22:03:23
20220312004840	2025-05-30 22:03:25
20220603231003	2025-05-30 22:03:28
20220603232444	2025-05-30 22:03:30
20220615214548	2025-05-30 22:03:32
20220712093339	2025-05-30 22:03:35
20220908172859	2025-05-30 22:03:37
20220916233421	2025-05-30 22:03:39
20230119133233	2025-05-30 22:03:41
20230128025114	2025-05-30 22:03:43
20230128025212	2025-05-30 22:03:45
20230227211149	2025-05-30 22:03:47
20230228184745	2025-05-30 22:03:49
20230308225145	2025-05-30 22:03:51
20230328144023	2025-05-30 22:03:53
20231018144023	2025-05-30 22:03:56
20231204144023	2025-05-30 22:03:59
20231204144024	2025-05-30 22:04:01
20231204144025	2025-05-30 22:04:03
20240108234812	2025-05-30 22:04:05
20240109165339	2025-05-30 22:04:07
20240227174441	2025-05-30 22:04:11
20240311171622	2025-05-30 22:04:14
20240321100241	2025-05-30 22:04:18
20240401105812	2025-05-30 22:04:24
20240418121054	2025-05-30 22:04:27
20240523004032	2025-05-30 22:04:34
20240618124746	2025-05-30 22:04:36
20240801235015	2025-05-30 22:04:38
20240805133720	2025-05-30 22:04:40
20240827160934	2025-05-30 22:04:42
20240919163303	2025-05-30 22:04:45
20240919163305	2025-05-30 22:04:47
20241019105805	2025-05-30 22:04:49
20241030150047	2025-05-30 22:04:57
20241108114728	2025-05-30 22:04:59
20241121104152	2025-05-30 22:05:01
20241130184212	2025-05-30 22:05:04
20241220035512	2025-05-30 22:05:06
20241220123912	2025-05-30 22:05:08
20241224161212	2025-05-30 22:05:10
20250107150512	2025-05-30 22:05:12
20250110162412	2025-05-30 22:05:14
20250123174212	2025-05-30 22:05:16
20250128220012	2025-05-30 22:05:18
20250506224012	2025-05-30 22:05:20
20250523164012	2025-05-30 22:05:22



--
-- TOC entry 4345 (class 0 OID 17083)
-- Dependencies: 317
-- Data for Name: subscription; Type: TABLE DATA; Schema: realtime; Owner: postgres
--

COPY realtime.subscription (id, subscription_id, entity, filters, claims, created_at) FROM stdin;



--
-- TOC entry 4327 (class 0 OID 16533)
-- Dependencies: 295
-- Data for Name: buckets; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.buckets (id, name, owner, created_at, updated_at, public, avif_autodetection, file_size_limit, allowed_mime_types, owner_id) FROM stdin;



--
-- TOC entry 4329 (class 0 OID 16575)
-- Dependencies: 297
-- Data for Name: migrations; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.migrations (id, name, hash, executed_at) FROM stdin;
0	create-migrations-table	e18db593bcde2aca2a408c4d1100f6abba2195df	2025-05-30 22:02:40.877667
1	initialmigration	6ab16121fbaa08bbd11b712d05f358f9b555d777	2025-05-30 22:02:40.88928
2	storage-schema	5c7968fd083fcea04050c1b7f6253c9771b99011	2025-05-30 22:02:40.89457
3	pathtoken-column	2cb1b0004b817b29d5b0a971af16bafeede4b70d	2025-05-30 22:02:40.917746
4	add-migrations-rls	427c5b63fe1c5937495d9c635c263ee7a5905058	2025-05-30 22:02:40.940979
5	add-size-functions	79e081a1455b63666c1294a440f8ad4b1e6a7f84	2025-05-30 22:02:40.947248
6	change-column-name-in-get-size	f93f62afdf6613ee5e7e815b30d02dc990201044	2025-05-30 22:02:40.953358
7	add-rls-to-buckets	e7e7f86adbc51049f341dfe8d30256c1abca17aa	2025-05-30 22:02:40.959273
8	add-public-to-buckets	fd670db39ed65f9d08b01db09d6202503ca2bab3	2025-05-30 22:02:40.964267
9	fix-search-function	3a0af29f42e35a4d101c259ed955b67e1bee6825	2025-05-30 22:02:40.969524
10	search-files-search-function	68dc14822daad0ffac3746a502234f486182ef6e	2025-05-30 22:02:40.975221
11	add-trigger-to-auto-update-updated_at-column	7425bdb14366d1739fa8a18c83100636d74dcaa2	2025-05-30 22:02:40.981515
12	add-automatic-avif-detection-flag	8e92e1266eb29518b6a4c5313ab8f29dd0d08df9	2025-05-30 22:02:40.988042
13	add-bucket-custom-limits	cce962054138135cd9a8c4bcd531598684b25e7d	2025-05-30 22:02:40.993501
14	use-bytes-for-max-size	941c41b346f9802b411f06f30e972ad4744dad27	2025-05-30 22:02:40.999437
15	add-can-insert-object-function	934146bc38ead475f4ef4b555c524ee5d66799e5	2025-05-30 22:02:41.026682
16	add-version	76debf38d3fd07dcfc747ca49096457d95b1221b	2025-05-30 22:02:41.032186
17	drop-owner-foreign-key	f1cbb288f1b7a4c1eb8c38504b80ae2a0153d101	2025-05-30 22:02:41.03747
18	add_owner_id_column_deprecate_owner	e7a511b379110b08e2f214be852c35414749fe66	2025-05-30 22:02:41.042988
19	alter-default-value-objects-id	02e5e22a78626187e00d173dc45f58fa66a4f043	2025-05-30 22:02:41.049977
20	list-objects-with-delimiter	cd694ae708e51ba82bf012bba00caf4f3b6393b7	2025-05-30 22:02:41.056418
21	s3-multipart-uploads	8c804d4a566c40cd1e4cc5b3725a664a9303657f	2025-05-30 22:02:41.067542
22	s3-multipart-uploads-big-ints	9737dc258d2397953c9953d9b86920b8be0cdb73	2025-05-30 22:02:41.101391
23	optimize-search-function	9d7e604cddc4b56a5422dc68c9313f4a1b6f132c	2025-05-30 22:02:41.128597
24	operation-function	8312e37c2bf9e76bbe841aa5fda889206d2bf8aa	2025-05-30 22:02:41.134632
25	custom-metadata	d974c6057c3db1c1f847afa0e291e6165693b990	2025-05-30 22:02:41.139895



--
-- TOC entry 4328 (class 0 OID 16548)
-- Dependencies: 296
-- Data for Name: objects; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.objects (id, bucket_id, name, owner, created_at, updated_at, last_accessed_at, metadata, version, owner_id, user_metadata) FROM stdin;



--
-- TOC entry 4341 (class 0 OID 17008)
-- Dependencies: 312
-- Data for Name: s3_multipart_uploads; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads (id, in_progress_size, upload_signature, bucket_id, key, version, owner_id, created_at, user_metadata) FROM stdin;



--
-- TOC entry 4342 (class 0 OID 17022)
-- Dependencies: 313
-- Data for Name: s3_multipart_uploads_parts; Type: TABLE DATA; Schema: storage; Owner: supabase_storage_admin
--

COPY storage.s3_multipart_uploads_parts (id, upload_id, size, part_number, bucket_id, key, etag, owner_id, version, created_at) FROM stdin;



--
-- TOC entry 3707 (class 0 OID 16643)
-- Dependencies: 298
-- Data for Name: secrets; Type: TABLE DATA; Schema: vault; Owner: postgres
--

COPY vault.secrets (id, name, description, secret, key_id, nonce, created_at, updated_at) FROM stdin;



--
-- TOC entry 4542 (class 0 OID 0)
-- Dependencies: 290
-- Name: refresh_tokens_id_seq; Type: SEQUENCE SET; Schema: auth; Owner: supabase_auth_admin
--

SELECT pg_catalog.setval('auth.refresh_tokens_id_seq', 1, false);


--
-- TOC entry 4543 (class 0 OID 0)
-- Dependencies: 344
-- Name: todo_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.todo_id_seq', 1, false);


--
-- TOC entry 4544 (class 0 OID 0)
-- Dependencies: 316
-- Name: subscription_id_seq; Type: SEQUENCE SET; Schema: realtime; Owner: postgres
--

SELECT pg_catalog.setval('realtime.subscription_id_seq', 230, true);


--
-- TOC entry 3943 (class 2606 OID 16801)
-- Name: mfa_amr_claims amr_id_pk; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT amr_id_pk PRIMARY KEY (id);


--
-- TOC entry 3901 (class 2606 OID 16518)
-- Name: audit_log_entries audit_log_entries_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.audit_log_entries
    ADD CONSTRAINT audit_log_entries_pkey PRIMARY KEY (id);


--
-- TOC entry 3965 (class 2606 OID 16907)
-- Name: flow_state flow_state_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.flow_state
    ADD CONSTRAINT flow_state_pkey PRIMARY KEY (id);


--
-- TOC entry 3922 (class 2606 OID 16925)
-- Name: identities identities_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_pkey PRIMARY KEY (id);


--
-- TOC entry 3924 (class 2606 OID 16935)
-- Name: identities identities_provider_id_provider_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_provider_id_provider_unique UNIQUE (provider_id, provider);


--
-- TOC entry 3899 (class 2606 OID 16511)
-- Name: instances instances_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.instances
    ADD CONSTRAINT instances_pkey PRIMARY KEY (id);


--
-- TOC entry 3945 (class 2606 OID 16794)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_authentication_method_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_authentication_method_pkey UNIQUE (session_id, authentication_method);


--
-- TOC entry 3941 (class 2606 OID 16782)
-- Name: mfa_challenges mfa_challenges_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_pkey PRIMARY KEY (id);


--
-- TOC entry 3933 (class 2606 OID 16975)
-- Name: mfa_factors mfa_factors_last_challenged_at_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_last_challenged_at_key UNIQUE (last_challenged_at);


--
-- TOC entry 3935 (class 2606 OID 16769)
-- Name: mfa_factors mfa_factors_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_pkey PRIMARY KEY (id);


--
-- TOC entry 3969 (class 2606 OID 16960)
-- Name: one_time_tokens one_time_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3893 (class 2606 OID 16501)
-- Name: refresh_tokens refresh_tokens_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3896 (class 2606 OID 16711)
-- Name: refresh_tokens refresh_tokens_token_unique; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3954 (class 2606 OID 16841)
-- Name: saml_providers saml_providers_entity_id_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_entity_id_key UNIQUE (entity_id);


--
-- TOC entry 3956 (class 2606 OID 16839)
-- Name: saml_providers saml_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3961 (class 2606 OID 16855)
-- Name: saml_relay_states saml_relay_states_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_pkey PRIMARY KEY (id);


--
-- TOC entry 3904 (class 2606 OID 16524)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3928 (class 2606 OID 16732)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3951 (class 2606 OID 16822)
-- Name: sso_domains sso_domains_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_pkey PRIMARY KEY (id);


--
-- TOC entry 3947 (class 2606 OID 16813)
-- Name: sso_providers sso_providers_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_providers
    ADD CONSTRAINT sso_providers_pkey PRIMARY KEY (id);


--
-- TOC entry 3886 (class 2606 OID 16895)
-- Name: users users_phone_key; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_phone_key UNIQUE (phone);


--
-- TOC entry 3888 (class 2606 OID 16488)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4020 (class 2606 OID 29747)
-- Name: GameProvider GameProvider_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."GameProvider"
    ADD CONSTRAINT "GameProvider_pkey" PRIMARY KEY (id);


--
-- TOC entry 4058 (class 2606 OID 29870)
-- Name: TournamentGamePlay TournamentGamePlay_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentGamePlay"
    ADD CONSTRAINT "TournamentGamePlay_pkey" PRIMARY KEY (id);


--
-- TOC entry 4053 (class 2606 OID 29862)
-- Name: TournamentParticipant TournamentParticipant_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentParticipant"
    ADD CONSTRAINT "TournamentParticipant_pkey" PRIMARY KEY (id);


--
-- TOC entry 4061 (class 2606 OID 29878)
-- Name: TournamentReward TournamentReward_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentReward"
    ADD CONSTRAINT "TournamentReward_pkey" PRIMARY KEY (id);


--
-- TOC entry 4050 (class 2606 OID 29853)
-- Name: Tournament Tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_pkey" PRIMARY KEY (id);


--
-- TOC entry 4026 (class 2606 OID 29764)
-- Name: _TournamentGames _TournamentGames_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TournamentGames"
    ADD CONSTRAINT "_TournamentGames_AB_pkey" PRIMARY KEY ("A", "B");


--
-- TOC entry 4007 (class 2606 OID 29691)
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (_id);


--
-- TOC entry 4022 (class 2606 OID 29757)
-- Name: game_launch_links game_launch_links_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT game_launch_links_pkey PRIMARY KEY (id);


--
-- TOC entry 4013 (class 2606 OID 29725)
-- Name: game_sessions game_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 4015 (class 2606 OID 29736)
-- Name: game_spins game_spins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_spins
    ADD CONSTRAINT game_spins_pkey PRIMARY KEY (id);


--
-- TOC entry 4011 (class 2606 OID 29711)
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- TOC entry 4032 (class 2606 OID 29787)
-- Name: jackpot_contributions jackpot_contributions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_contributions
    ADD CONSTRAINT jackpot_contributions_pkey PRIMARY KEY (id);


--
-- TOC entry 4035 (class 2606 OID 29795)
-- Name: jackpot_wins jackpot_wins_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT jackpot_wins_pkey PRIMARY KEY (id);


--
-- TOC entry 4029 (class 2606 OID 29779)
-- Name: jackpots jackpots_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpots
    ADD CONSTRAINT jackpots_pkey PRIMARY KEY (id);


--
-- TOC entry 4038 (class 2606 OID 29804)
-- Name: operator_access_keys operator_access_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operator_access_keys
    ADD CONSTRAINT operator_access_keys_pkey PRIMARY KEY (id);


--
-- TOC entry 4041 (class 2606 OID 29812)
-- Name: operator_invitations operator_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operator_invitations
    ADD CONSTRAINT operator_invitations_pkey PRIMARY KEY (id);


--
-- TOC entry 4046 (class 2606 OID 29834)
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- TOC entry 4070 (class 2606 OID 29896)
-- Name: rebate_transactions rebate_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rebate_transactions
    ADD CONSTRAINT rebate_transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4004 (class 2606 OID 29684)
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (_id);


--
-- TOC entry 4048 (class 2606 OID 29844)
-- Name: todo todo_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT todo_pkey PRIMARY KEY (id);


--
-- TOC entry 4066 (class 2606 OID 29887)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4002 (class 2606 OID 29677)
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (_id);


--
-- TOC entry 4078 (class 2606 OID 29923)
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- TOC entry 4009 (class 2606 OID 29698)
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (_id);


--
-- TOC entry 4083 (class 2606 OID 29936)
-- Name: vip_infos vip_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.vip_infos
    ADD CONSTRAINT vip_infos_pkey PRIMARY KEY (id);


--
-- TOC entry 4075 (class 2606 OID 29908)
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- TOC entry 3985 (class 2606 OID 17240)
-- Name: messages messages_pkey; Type: CONSTRAINT; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE ONLY realtime.messages
    ADD CONSTRAINT messages_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3987 (class 2606 OID 26624)
-- Name: messages_2025_06_01 messages_2025_06_01_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages_2025_06_01
    ADD CONSTRAINT messages_2025_06_01_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3989 (class 2606 OID 26635)
-- Name: messages_2025_06_02 messages_2025_06_02_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages_2025_06_02
    ADD CONSTRAINT messages_2025_06_02_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3991 (class 2606 OID 26646)
-- Name: messages_2025_06_03 messages_2025_06_03_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages_2025_06_03
    ADD CONSTRAINT messages_2025_06_03_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3993 (class 2606 OID 26657)
-- Name: messages_2025_06_04 messages_2025_06_04_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages_2025_06_04
    ADD CONSTRAINT messages_2025_06_04_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3995 (class 2606 OID 26668)
-- Name: messages_2025_06_05 messages_2025_06_05_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages_2025_06_05
    ADD CONSTRAINT messages_2025_06_05_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3997 (class 2606 OID 28321)
-- Name: messages_2025_06_06 messages_2025_06_06_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages_2025_06_06
    ADD CONSTRAINT messages_2025_06_06_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3999 (class 2606 OID 28332)
-- Name: messages_2025_06_07 messages_2025_06_07_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.messages_2025_06_07
    ADD CONSTRAINT messages_2025_06_07_pkey PRIMARY KEY (id, inserted_at);


--
-- TOC entry 3982 (class 2606 OID 17091)
-- Name: subscription pk_subscription; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.subscription
    ADD CONSTRAINT pk_subscription PRIMARY KEY (id);


--
-- TOC entry 3979 (class 2606 OID 17064)
-- Name: schema_migrations schema_migrations_pkey; Type: CONSTRAINT; Schema: realtime; Owner: postgres
--

ALTER TABLE ONLY realtime.schema_migrations
    ADD CONSTRAINT schema_migrations_pkey PRIMARY KEY (version);


--
-- TOC entry 3907 (class 2606 OID 16541)
-- Name: buckets buckets_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.buckets
    ADD CONSTRAINT buckets_pkey PRIMARY KEY (id);


--
-- TOC entry 3914 (class 2606 OID 16582)
-- Name: migrations migrations_name_key; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_name_key UNIQUE (name);


--
-- TOC entry 3916 (class 2606 OID 16580)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3912 (class 2606 OID 16558)
-- Name: objects objects_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT objects_pkey PRIMARY KEY (id);


--
-- TOC entry 3977 (class 2606 OID 17031)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_pkey PRIMARY KEY (id);


--
-- TOC entry 3975 (class 2606 OID 17016)
-- Name: s3_multipart_uploads s3_multipart_uploads_pkey; Type: CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_pkey PRIMARY KEY (id);


--
-- TOC entry 3902 (class 1259 OID 16519)
-- Name: audit_logs_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX audit_logs_instance_id_idx ON auth.audit_log_entries USING btree (instance_id);


--
-- TOC entry 3876 (class 1259 OID 16721)
-- Name: confirmation_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX confirmation_token_idx ON auth.users USING btree (confirmation_token) WHERE ((confirmation_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3877 (class 1259 OID 16723)
-- Name: email_change_token_current_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_current_idx ON auth.users USING btree (email_change_token_current) WHERE ((email_change_token_current)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3878 (class 1259 OID 16724)
-- Name: email_change_token_new_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX email_change_token_new_idx ON auth.users USING btree (email_change_token_new) WHERE ((email_change_token_new)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3931 (class 1259 OID 16803)
-- Name: factor_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX factor_id_created_at_idx ON auth.mfa_factors USING btree (user_id, created_at);


--
-- TOC entry 3963 (class 1259 OID 16911)
-- Name: flow_state_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX flow_state_created_at_idx ON auth.flow_state USING btree (created_at DESC);


--
-- TOC entry 3920 (class 1259 OID 16891)
-- Name: identities_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_email_idx ON auth.identities USING btree (email text_pattern_ops);


--
-- TOC entry 4545 (class 0 OID 0)
-- Dependencies: 3920
-- Name: INDEX identities_email_idx; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.identities_email_idx IS 'Auth: Ensures indexed queries on the email column';


--
-- TOC entry 3925 (class 1259 OID 16718)
-- Name: identities_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX identities_user_id_idx ON auth.identities USING btree (user_id);


--
-- TOC entry 3966 (class 1259 OID 16908)
-- Name: idx_auth_code; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_auth_code ON auth.flow_state USING btree (auth_code);


--
-- TOC entry 3967 (class 1259 OID 16909)
-- Name: idx_user_id_auth_method; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX idx_user_id_auth_method ON auth.flow_state USING btree (user_id, authentication_method);


--
-- TOC entry 3939 (class 1259 OID 16914)
-- Name: mfa_challenge_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_challenge_created_at_idx ON auth.mfa_challenges USING btree (created_at DESC);


--
-- TOC entry 3936 (class 1259 OID 16775)
-- Name: mfa_factors_user_friendly_name_unique; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX mfa_factors_user_friendly_name_unique ON auth.mfa_factors USING btree (friendly_name, user_id) WHERE (TRIM(BOTH FROM friendly_name) <> ''::text);


--
-- TOC entry 3937 (class 1259 OID 16920)
-- Name: mfa_factors_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX mfa_factors_user_id_idx ON auth.mfa_factors USING btree (user_id);


--
-- TOC entry 3970 (class 1259 OID 16967)
-- Name: one_time_tokens_relates_to_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_relates_to_hash_idx ON auth.one_time_tokens USING hash (relates_to);


--
-- TOC entry 3971 (class 1259 OID 16966)
-- Name: one_time_tokens_token_hash_hash_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX one_time_tokens_token_hash_hash_idx ON auth.one_time_tokens USING hash (token_hash);


--
-- TOC entry 3972 (class 1259 OID 16968)
-- Name: one_time_tokens_user_id_token_type_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX one_time_tokens_user_id_token_type_key ON auth.one_time_tokens USING btree (user_id, token_type);


--
-- TOC entry 3879 (class 1259 OID 16725)
-- Name: reauthentication_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX reauthentication_token_idx ON auth.users USING btree (reauthentication_token) WHERE ((reauthentication_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3880 (class 1259 OID 16722)
-- Name: recovery_token_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX recovery_token_idx ON auth.users USING btree (recovery_token) WHERE ((recovery_token)::text !~ '^[0-9 ]*$'::text);


--
-- TOC entry 3889 (class 1259 OID 16502)
-- Name: refresh_tokens_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_idx ON auth.refresh_tokens USING btree (instance_id);


--
-- TOC entry 3890 (class 1259 OID 16503)
-- Name: refresh_tokens_instance_id_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_instance_id_user_id_idx ON auth.refresh_tokens USING btree (instance_id, user_id);


--
-- TOC entry 3891 (class 1259 OID 16717)
-- Name: refresh_tokens_parent_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_parent_idx ON auth.refresh_tokens USING btree (parent);


--
-- TOC entry 3894 (class 1259 OID 16805)
-- Name: refresh_tokens_session_id_revoked_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_session_id_revoked_idx ON auth.refresh_tokens USING btree (session_id, revoked);


--
-- TOC entry 3897 (class 1259 OID 16910)
-- Name: refresh_tokens_updated_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX refresh_tokens_updated_at_idx ON auth.refresh_tokens USING btree (updated_at DESC);


--
-- TOC entry 3957 (class 1259 OID 16847)
-- Name: saml_providers_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_providers_sso_provider_id_idx ON auth.saml_providers USING btree (sso_provider_id);


--
-- TOC entry 3958 (class 1259 OID 16912)
-- Name: saml_relay_states_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_created_at_idx ON auth.saml_relay_states USING btree (created_at DESC);


--
-- TOC entry 3959 (class 1259 OID 16862)
-- Name: saml_relay_states_for_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_for_email_idx ON auth.saml_relay_states USING btree (for_email);


--
-- TOC entry 3962 (class 1259 OID 16861)
-- Name: saml_relay_states_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX saml_relay_states_sso_provider_id_idx ON auth.saml_relay_states USING btree (sso_provider_id);


--
-- TOC entry 3926 (class 1259 OID 16913)
-- Name: sessions_not_after_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_not_after_idx ON auth.sessions USING btree (not_after DESC);


--
-- TOC entry 3929 (class 1259 OID 16804)
-- Name: sessions_user_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sessions_user_id_idx ON auth.sessions USING btree (user_id);


--
-- TOC entry 3949 (class 1259 OID 16829)
-- Name: sso_domains_domain_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_domains_domain_idx ON auth.sso_domains USING btree (lower(domain));


--
-- TOC entry 3952 (class 1259 OID 16828)
-- Name: sso_domains_sso_provider_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX sso_domains_sso_provider_id_idx ON auth.sso_domains USING btree (sso_provider_id);


--
-- TOC entry 3948 (class 1259 OID 16814)
-- Name: sso_providers_resource_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX sso_providers_resource_id_idx ON auth.sso_providers USING btree (lower(resource_id));


--
-- TOC entry 3938 (class 1259 OID 16973)
-- Name: unique_phone_factor_per_user; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX unique_phone_factor_per_user ON auth.mfa_factors USING btree (user_id, phone);


--
-- TOC entry 3930 (class 1259 OID 16802)
-- Name: user_id_created_at_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX user_id_created_at_idx ON auth.sessions USING btree (user_id, created_at);


--
-- TOC entry 3881 (class 1259 OID 16882)
-- Name: users_email_partial_key; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE UNIQUE INDEX users_email_partial_key ON auth.users USING btree (email) WHERE (is_sso_user = false);


--
-- TOC entry 4546 (class 0 OID 0)
-- Dependencies: 3881
-- Name: INDEX users_email_partial_key; Type: COMMENT; Schema: auth; Owner: supabase_auth_admin
--

COMMENT ON INDEX auth.users_email_partial_key IS 'Auth: A partial unique index that applies only when is_sso_user is false';


--
-- TOC entry 3882 (class 1259 OID 16719)
-- Name: users_instance_id_email_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_email_idx ON auth.users USING btree (instance_id, lower((email)::text));


--
-- TOC entry 3883 (class 1259 OID 16492)
-- Name: users_instance_id_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_instance_id_idx ON auth.users USING btree (instance_id);


--
-- TOC entry 3884 (class 1259 OID 16937)
-- Name: users_is_anonymous_idx; Type: INDEX; Schema: auth; Owner: supabase_auth_admin
--

CREATE INDEX users_is_anonymous_idx ON auth.users USING btree (is_anonymous);


--
-- TOC entry 4016 (class 1259 OID 29941)
-- Name: GameProvider_isActive_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "GameProvider_isActive_idx" ON public."GameProvider" USING btree ("isActive");


--
-- TOC entry 4017 (class 1259 OID 29940)
-- Name: GameProvider_name_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "GameProvider_name_idx" ON public."GameProvider" USING btree (name);


--
-- TOC entry 4018 (class 1259 OID 29939)
-- Name: GameProvider_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "GameProvider_name_key" ON public."GameProvider" USING btree (name);


--
-- TOC entry 4059 (class 1259 OID 29956)
-- Name: TournamentGamePlay_tournamentParticipantId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "TournamentGamePlay_tournamentParticipantId_idx" ON public."TournamentGamePlay" USING btree ("tournamentParticipantId");


--
-- TOC entry 4054 (class 1259 OID 29954)
-- Name: TournamentParticipant_tournamentId_score_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "TournamentParticipant_tournamentId_score_idx" ON public."TournamentParticipant" USING btree ("tournamentId", score);


--
-- TOC entry 4055 (class 1259 OID 29955)
-- Name: TournamentParticipant_tournamentId_userId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "TournamentParticipant_tournamentId_userId_key" ON public."TournamentParticipant" USING btree ("tournamentId", "userId");


--
-- TOC entry 4056 (class 1259 OID 29953)
-- Name: TournamentParticipant_userId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "TournamentParticipant_userId_idx" ON public."TournamentParticipant" USING btree ("userId");


--
-- TOC entry 4062 (class 1259 OID 29957)
-- Name: TournamentReward_tournamentId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "TournamentReward_tournamentId_idx" ON public."TournamentReward" USING btree ("tournamentId");


--
-- TOC entry 4051 (class 1259 OID 29952)
-- Name: Tournament_status_startTime_endTime_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "Tournament_status_startTime_endTime_idx" ON public."Tournament" USING btree (status, "startTime", "endTime");


--
-- TOC entry 4027 (class 1259 OID 29944)
-- Name: _TournamentGames_B_index; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "_TournamentGames_B_index" ON public."_TournamentGames" USING btree ("B");


--
-- TOC entry 4023 (class 1259 OID 29943)
-- Name: game_launch_links_session_url_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX game_launch_links_session_url_key ON public.game_launch_links USING btree (session_url);


--
-- TOC entry 4024 (class 1259 OID 29942)
-- Name: game_launch_links_token_internal_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX game_launch_links_token_internal_key ON public.game_launch_links USING btree (token_internal);


--
-- TOC entry 4030 (class 1259 OID 29945)
-- Name: jackpot_contributions_jackpotId_gameSpinId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "jackpot_contributions_jackpotId_gameSpinId_key" ON public.jackpot_contributions USING btree ("jackpotId", "gameSpinId");


--
-- TOC entry 4033 (class 1259 OID 29946)
-- Name: jackpot_wins_gameSpinId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "jackpot_wins_gameSpinId_key" ON public.jackpot_wins USING btree ("gameSpinId");


--
-- TOC entry 4036 (class 1259 OID 29947)
-- Name: operator_access_keys_name_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX operator_access_keys_name_key ON public.operator_access_keys USING btree (name);


--
-- TOC entry 4039 (class 1259 OID 29949)
-- Name: operator_invitations_operatorId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "operator_invitations_operatorId_idx" ON public.operator_invitations USING btree ("operatorId");


--
-- TOC entry 4042 (class 1259 OID 29951)
-- Name: operator_invitations_token_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX operator_invitations_token_idx ON public.operator_invitations USING btree (token);


--
-- TOC entry 4043 (class 1259 OID 29948)
-- Name: operator_invitations_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX operator_invitations_token_key ON public.operator_invitations USING btree (token);


--
-- TOC entry 4044 (class 1259 OID 29950)
-- Name: operator_invitations_username_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX operator_invitations_username_idx ON public.operator_invitations USING btree (username);


--
-- TOC entry 4071 (class 1259 OID 29962)
-- Name: rebate_transactions_transactionId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "rebate_transactions_transactionId_key" ON public.rebate_transactions USING btree ("transactionId");


--
-- TOC entry 4072 (class 1259 OID 29963)
-- Name: rebate_transactions_userId_status_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "rebate_transactions_userId_status_idx" ON public.rebate_transactions USING btree ("userId", status);


--
-- TOC entry 4005 (class 1259 OID 29938)
-- Name: session_token_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX session_token_key ON public.session USING btree (token);


--
-- TOC entry 4063 (class 1259 OID 29961)
-- Name: transactions_createdAt_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "transactions_createdAt_idx" ON public.transactions USING btree ("createdAt");


--
-- TOC entry 4064 (class 1259 OID 29960)
-- Name: transactions_paymentMethod_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "transactions_paymentMethod_idx" ON public.transactions USING btree ("paymentMethod");


--
-- TOC entry 4067 (class 1259 OID 29959)
-- Name: transactions_provider_providerTxId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "transactions_provider_providerTxId_idx" ON public.transactions USING btree (provider, "providerTxId");


--
-- TOC entry 4068 (class 1259 OID 29958)
-- Name: transactions_walletId_idx; Type: INDEX; Schema: public; Owner: postgres
--

CREATE INDEX "transactions_walletId_idx" ON public.transactions USING btree ("walletId");


--
-- TOC entry 4000 (class 1259 OID 29937)
-- Name: user_email_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_email_key ON public."user" USING btree (email);


--
-- TOC entry 4079 (class 1259 OID 29967)
-- Name: user_profiles_user_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_profiles_user_id_key ON public.user_profiles USING btree (user_id);


--
-- TOC entry 4080 (class 1259 OID 29966)
-- Name: user_profiles_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_profiles_username_key ON public.user_profiles USING btree (username);


--
-- TOC entry 4081 (class 1259 OID 29968)
-- Name: user_profiles_vip_info_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX user_profiles_vip_info_id_key ON public.user_profiles USING btree (vip_info_id);


--
-- TOC entry 4084 (class 1259 OID 29970)
-- Name: vip_infos_user_id_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX vip_infos_user_id_key ON public.vip_infos USING btree (user_id);


--
-- TOC entry 4085 (class 1259 OID 29969)
-- Name: vip_infos_username_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX vip_infos_username_key ON public.vip_infos USING btree (username);


--
-- TOC entry 4073 (class 1259 OID 29964)
-- Name: wallets_address_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX wallets_address_key ON public.wallets USING btree (address);


--
-- TOC entry 4076 (class 1259 OID 29965)
-- Name: wallets_userId_operatorId_key; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX "wallets_userId_operatorId_key" ON public.wallets USING btree ("userId", "operatorId");


--
-- TOC entry 3980 (class 1259 OID 17241)
-- Name: ix_realtime_subscription_entity; Type: INDEX; Schema: realtime; Owner: postgres
--

CREATE INDEX ix_realtime_subscription_entity ON realtime.subscription USING btree (entity);


--
-- TOC entry 3983 (class 1259 OID 17140)
-- Name: subscription_subscription_id_entity_filters_key; Type: INDEX; Schema: realtime; Owner: postgres
--

CREATE UNIQUE INDEX subscription_subscription_id_entity_filters_key ON realtime.subscription USING btree (subscription_id, entity, filters);


--
-- TOC entry 3905 (class 1259 OID 16547)
-- Name: bname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bname ON storage.buckets USING btree (name);


--
-- TOC entry 3908 (class 1259 OID 16569)
-- Name: bucketid_objname; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE UNIQUE INDEX bucketid_objname ON storage.objects USING btree (bucket_id, name);


--
-- TOC entry 3973 (class 1259 OID 17042)
-- Name: idx_multipart_uploads_list; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_multipart_uploads_list ON storage.s3_multipart_uploads USING btree (bucket_id, key, created_at);


--
-- TOC entry 3909 (class 1259 OID 17007)
-- Name: idx_objects_bucket_id_name; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX idx_objects_bucket_id_name ON storage.objects USING btree (bucket_id, name COLLATE "C");


--
-- TOC entry 3910 (class 1259 OID 16570)
-- Name: name_prefix_search; Type: INDEX; Schema: storage; Owner: supabase_storage_admin
--

CREATE INDEX name_prefix_search ON storage.objects USING btree (name text_pattern_ops);


--
-- TOC entry 4086 (class 0 OID 0)
-- Name: messages_2025_06_01_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_01_pkey;


--
-- TOC entry 4087 (class 0 OID 0)
-- Name: messages_2025_06_02_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_02_pkey;


--
-- TOC entry 4088 (class 0 OID 0)
-- Name: messages_2025_06_03_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_03_pkey;


--
-- TOC entry 4089 (class 0 OID 0)
-- Name: messages_2025_06_04_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_04_pkey;


--
-- TOC entry 4090 (class 0 OID 0)
-- Name: messages_2025_06_05_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_05_pkey;


--
-- TOC entry 4091 (class 0 OID 0)
-- Name: messages_2025_06_06_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_06_pkey;


--
-- TOC entry 4092 (class 0 OID 0)
-- Name: messages_2025_06_07_pkey; Type: INDEX ATTACH; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER INDEX realtime.messages_pkey ATTACH PARTITION realtime.messages_2025_06_07_pkey;


--
-- TOC entry 4149 (class 2620 OID 30547)
-- Name: user_profiles after_user_profile_insert_create_wallet_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER after_user_profile_insert_create_wallet_trigger AFTER INSERT ON public.user_profiles FOR EACH ROW EXECUTE FUNCTION public.create_user_wallet_function();


--
-- TOC entry 4547 (class 0 OID 0)
-- Dependencies: 4149
-- Name: TRIGGER after_user_profile_insert_create_wallet_trigger ON user_profiles; Type: COMMENT; Schema: public; Owner: postgres
--

COMMENT ON TRIGGER after_user_profile_insert_create_wallet_trigger ON public.user_profiles IS 'After a user_profile is inserted, automatically creates a corresponding wallet with a CUID-like ID.';


--
-- TOC entry 4150 (class 2620 OID 30195)
-- Name: user_profiles profile_change_trigger; Type: TRIGGER; Schema: public; Owner: postgres
--

CREATE TRIGGER profile_change_trigger AFTER INSERT OR DELETE OR UPDATE ON public.user_profiles FOR EACH ROW EXECUTE FUNCTION public.notify_spec_data_change();

ALTER TABLE public.user_profiles DISABLE TRIGGER profile_change_trigger;


--
-- TOC entry 4148 (class 2620 OID 17096)
-- Name: subscription tr_check_filters; Type: TRIGGER; Schema: realtime; Owner: postgres
--

CREATE TRIGGER tr_check_filters BEFORE INSERT OR UPDATE ON realtime.subscription FOR EACH ROW EXECUTE FUNCTION realtime.subscription_check_filters();


--
-- TOC entry 4147 (class 2620 OID 16995)
-- Name: objects update_objects_updated_at; Type: TRIGGER; Schema: storage; Owner: supabase_storage_admin
--

CREATE TRIGGER update_objects_updated_at BEFORE UPDATE ON storage.objects FOR EACH ROW EXECUTE FUNCTION storage.update_updated_at_column();


--
-- TOC entry 4095 (class 2606 OID 16705)
-- Name: identities identities_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.identities
    ADD CONSTRAINT identities_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4099 (class 2606 OID 16795)
-- Name: mfa_amr_claims mfa_amr_claims_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_amr_claims
    ADD CONSTRAINT mfa_amr_claims_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4098 (class 2606 OID 16783)
-- Name: mfa_challenges mfa_challenges_auth_factor_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_challenges
    ADD CONSTRAINT mfa_challenges_auth_factor_id_fkey FOREIGN KEY (factor_id) REFERENCES auth.mfa_factors(id) ON DELETE CASCADE;


--
-- TOC entry 4097 (class 2606 OID 16770)
-- Name: mfa_factors mfa_factors_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.mfa_factors
    ADD CONSTRAINT mfa_factors_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4104 (class 2606 OID 16961)
-- Name: one_time_tokens one_time_tokens_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.one_time_tokens
    ADD CONSTRAINT one_time_tokens_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4093 (class 2606 OID 16738)
-- Name: refresh_tokens refresh_tokens_session_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.refresh_tokens
    ADD CONSTRAINT refresh_tokens_session_id_fkey FOREIGN KEY (session_id) REFERENCES auth.sessions(id) ON DELETE CASCADE;


--
-- TOC entry 4101 (class 2606 OID 16842)
-- Name: saml_providers saml_providers_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_providers
    ADD CONSTRAINT saml_providers_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4102 (class 2606 OID 16915)
-- Name: saml_relay_states saml_relay_states_flow_state_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_flow_state_id_fkey FOREIGN KEY (flow_state_id) REFERENCES auth.flow_state(id) ON DELETE CASCADE;


--
-- TOC entry 4103 (class 2606 OID 16856)
-- Name: saml_relay_states saml_relay_states_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.saml_relay_states
    ADD CONSTRAINT saml_relay_states_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4096 (class 2606 OID 16733)
-- Name: sessions sessions_user_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sessions
    ADD CONSTRAINT sessions_user_id_fkey FOREIGN KEY (user_id) REFERENCES auth.users(id) ON DELETE CASCADE;


--
-- TOC entry 4100 (class 2606 OID 16823)
-- Name: sso_domains sso_domains_sso_provider_id_fkey; Type: FK CONSTRAINT; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE ONLY auth.sso_domains
    ADD CONSTRAINT sso_domains_sso_provider_id_fkey FOREIGN KEY (sso_provider_id) REFERENCES auth.sso_providers(id) ON DELETE CASCADE;


--
-- TOC entry 4134 (class 2606 OID 30101)
-- Name: TournamentGamePlay TournamentGamePlay_tournamentParticipantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentGamePlay"
    ADD CONSTRAINT "TournamentGamePlay_tournamentParticipantId_fkey" FOREIGN KEY ("tournamentParticipantId") REFERENCES public."TournamentParticipant"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4132 (class 2606 OID 30091)
-- Name: TournamentParticipant TournamentParticipant_tournamentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentParticipant"
    ADD CONSTRAINT "TournamentParticipant_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES public."Tournament"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4133 (class 2606 OID 30096)
-- Name: TournamentParticipant TournamentParticipant_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentParticipant"
    ADD CONSTRAINT "TournamentParticipant_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4135 (class 2606 OID 30106)
-- Name: TournamentReward TournamentReward_tournamentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentReward"
    ADD CONSTRAINT "TournamentReward_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES public."Tournament"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4136 (class 2606 OID 30111)
-- Name: TournamentReward TournamentReward_winnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."TournamentReward"
    ADD CONSTRAINT "TournamentReward_winnerId_fkey" FOREIGN KEY ("winnerId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4131 (class 2606 OID 30086)
-- Name: Tournament Tournament_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4118 (class 2606 OID 30021)
-- Name: _TournamentGames _TournamentGames_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TournamentGames"
    ADD CONSTRAINT "_TournamentGames_A_fkey" FOREIGN KEY ("A") REFERENCES public.games(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4119 (class 2606 OID 30026)
-- Name: _TournamentGames _TournamentGames_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public."_TournamentGames"
    ADD CONSTRAINT "_TournamentGames_B_fkey" FOREIGN KEY ("B") REFERENCES public."Tournament"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4109 (class 2606 OID 29976)
-- Name: account account_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4115 (class 2606 OID 30006)
-- Name: game_launch_links game_launch_links_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT "game_launch_links_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES public.games(id) ON UPDATE CASCADE;


--
-- TOC entry 4116 (class 2606 OID 30011)
-- Name: game_launch_links game_launch_links_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT "game_launch_links_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE;


--
-- TOC entry 4117 (class 2606 OID 30016)
-- Name: game_launch_links game_launch_links_userProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT "game_launch_links_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4112 (class 2606 OID 29991)
-- Name: game_sessions game_sessions_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT "game_sessions_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES public.games(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4113 (class 2606 OID 29996)
-- Name: game_sessions game_sessions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT "game_sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4114 (class 2606 OID 30001)
-- Name: game_spins game_spins_gameSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.game_spins
    ADD CONSTRAINT "game_spins_gameSessionId_fkey" FOREIGN KEY ("gameSessionId") REFERENCES public.game_sessions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4110 (class 2606 OID 29981)
-- Name: games games_gameProviderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT "games_gameProviderId_fkey" FOREIGN KEY ("gameProviderId") REFERENCES public."GameProvider"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4111 (class 2606 OID 29986)
-- Name: games games_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT "games_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4121 (class 2606 OID 30041)
-- Name: jackpot_contributions jackpot_contributions_gameSpinId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_contributions
    ADD CONSTRAINT "jackpot_contributions_gameSpinId_fkey" FOREIGN KEY ("gameSpinId") REFERENCES public.game_spins(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4122 (class 2606 OID 30036)
-- Name: jackpot_contributions jackpot_contributions_jackpotId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_contributions
    ADD CONSTRAINT "jackpot_contributions_jackpotId_fkey" FOREIGN KEY ("jackpotId") REFERENCES public.jackpots(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4123 (class 2606 OID 30056)
-- Name: jackpot_wins jackpot_wins_gameSpinId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_gameSpinId_fkey" FOREIGN KEY ("gameSpinId") REFERENCES public.game_spins(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4124 (class 2606 OID 30046)
-- Name: jackpot_wins jackpot_wins_jackpotId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_jackpotId_fkey" FOREIGN KEY ("jackpotId") REFERENCES public.jackpots(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4125 (class 2606 OID 30061)
-- Name: jackpot_wins jackpot_wins_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4126 (class 2606 OID 30051)
-- Name: jackpot_wins jackpot_wins_winnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_winnerId_fkey" FOREIGN KEY ("winnerId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4120 (class 2606 OID 30031)
-- Name: jackpots jackpots_lastWonBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.jackpots
    ADD CONSTRAINT "jackpots_lastWonBy_fkey" FOREIGN KEY ("lastWonBy") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4127 (class 2606 OID 30066)
-- Name: operator_invitations operator_invitations_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operator_invitations
    ADD CONSTRAINT "operator_invitations_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4128 (class 2606 OID 30071)
-- Name: operator_invitations operator_invitations_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.operator_invitations
    ADD CONSTRAINT operator_invitations_username_fkey FOREIGN KEY (username) REFERENCES public.user_profiles(username) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4129 (class 2606 OID 30076)
-- Name: products products_shopId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4130 (class 2606 OID 30081)
-- Name: products products_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4141 (class 2606 OID 30136)
-- Name: rebate_transactions rebate_transactions_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rebate_transactions
    ADD CONSTRAINT "rebate_transactions_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4142 (class 2606 OID 30141)
-- Name: rebate_transactions rebate_transactions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.rebate_transactions
    ADD CONSTRAINT "rebate_transactions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4108 (class 2606 OID 29971)
-- Name: session session_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4137 (class 2606 OID 30116)
-- Name: transactions transactions_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4138 (class 2606 OID 30121)
-- Name: transactions transactions_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_productId_fkey" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4139 (class 2606 OID 30126)
-- Name: transactions transactions_userProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4140 (class 2606 OID 30131)
-- Name: transactions transactions_walletId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES public.wallets(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4145 (class 2606 OID 30156)
-- Name: user_profiles user_profiles_current_game_sessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_current_game_sessionid_fkey FOREIGN KEY (current_game_sessionid) REFERENCES public.game_sessions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- TOC entry 4146 (class 2606 OID 30161)
-- Name: user_profiles user_profiles_vip_info_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_vip_info_id_fkey FOREIGN KEY (vip_info_id) REFERENCES public.vip_infos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- TOC entry 4143 (class 2606 OID 30146)
-- Name: wallets wallets_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT "wallets_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4144 (class 2606 OID 30151)
-- Name: wallets wallets_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT "wallets_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- TOC entry 4094 (class 2606 OID 16559)
-- Name: objects objects_bucketId_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.objects
    ADD CONSTRAINT "objects_bucketId_fkey" FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4105 (class 2606 OID 17017)
-- Name: s3_multipart_uploads s3_multipart_uploads_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads
    ADD CONSTRAINT s3_multipart_uploads_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4106 (class 2606 OID 17037)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_bucket_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_bucket_id_fkey FOREIGN KEY (bucket_id) REFERENCES storage.buckets(id);


--
-- TOC entry 4107 (class 2606 OID 17032)
-- Name: s3_multipart_uploads_parts s3_multipart_uploads_parts_upload_id_fkey; Type: FK CONSTRAINT; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE ONLY storage.s3_multipart_uploads_parts
    ADD CONSTRAINT s3_multipart_uploads_parts_upload_id_fkey FOREIGN KEY (upload_id) REFERENCES storage.s3_multipart_uploads(id) ON DELETE CASCADE;


--
-- TOC entry 4299 (class 0 OID 16512)
-- Dependencies: 293
-- Name: audit_log_entries; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.audit_log_entries ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4313 (class 0 OID 16901)
-- Dependencies: 310
-- Name: flow_state; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.flow_state ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4304 (class 0 OID 16698)
-- Dependencies: 301
-- Name: identities; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.identities ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4298 (class 0 OID 16505)
-- Dependencies: 292
-- Name: instances; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.instances ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4308 (class 0 OID 16788)
-- Dependencies: 305
-- Name: mfa_amr_claims; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_amr_claims ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4307 (class 0 OID 16776)
-- Dependencies: 304
-- Name: mfa_challenges; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_challenges ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4306 (class 0 OID 16763)
-- Dependencies: 303
-- Name: mfa_factors; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.mfa_factors ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4314 (class 0 OID 16951)
-- Dependencies: 311
-- Name: one_time_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.one_time_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4297 (class 0 OID 16494)
-- Dependencies: 291
-- Name: refresh_tokens; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.refresh_tokens ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4311 (class 0 OID 16830)
-- Dependencies: 308
-- Name: saml_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4312 (class 0 OID 16848)
-- Dependencies: 309
-- Name: saml_relay_states; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.saml_relay_states ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4300 (class 0 OID 16520)
-- Dependencies: 294
-- Name: schema_migrations; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.schema_migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4305 (class 0 OID 16728)
-- Dependencies: 302
-- Name: sessions; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sessions ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4310 (class 0 OID 16815)
-- Dependencies: 307
-- Name: sso_domains; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_domains ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4309 (class 0 OID 16806)
-- Dependencies: 306
-- Name: sso_providers; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.sso_providers ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4296 (class 0 OID 16482)
-- Dependencies: 289
-- Name: users; Type: ROW SECURITY; Schema: auth; Owner: supabase_auth_admin
--

ALTER TABLE auth.users ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4317 (class 0 OID 17226)
-- Dependencies: 320
-- Name: messages; Type: ROW SECURITY; Schema: realtime; Owner: supabase_realtime_admin
--

ALTER TABLE realtime.messages ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4301 (class 0 OID 16533)
-- Dependencies: 295
-- Name: buckets; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.buckets ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4303 (class 0 OID 16575)
-- Dependencies: 297
-- Name: migrations; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.migrations ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4302 (class 0 OID 16548)
-- Dependencies: 296
-- Name: objects; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.objects ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4315 (class 0 OID 17008)
-- Dependencies: 312
-- Name: s3_multipart_uploads; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4316 (class 0 OID 17022)
-- Dependencies: 313
-- Name: s3_multipart_uploads_parts; Type: ROW SECURITY; Schema: storage; Owner: supabase_storage_admin
--

ALTER TABLE storage.s3_multipart_uploads_parts ENABLE ROW LEVEL SECURITY;

--
-- TOC entry 4318 (class 6104 OID 16420)
-- Name: supabase_realtime; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime OWNER TO postgres;

--
-- TOC entry 4319 (class 6104 OID 26671)
-- Name: supabase_realtime_messages_publication; Type: PUBLICATION; Schema: -; Owner: postgres
--

CREATE PUBLICATION supabase_realtime_messages_publication WITH (publish = 'insert, update, delete, truncate');


ALTER PUBLICATION supabase_realtime_messages_publication OWNER TO postgres;

--
-- TOC entry 4320 (class 6106 OID 26672)
-- Name: supabase_realtime_messages_publication messages; Type: PUBLICATION TABLE; Schema: realtime; Owner: postgres
--

ALTER PUBLICATION supabase_realtime_messages_publication ADD TABLE ONLY realtime.messages;


--
-- TOC entry 4385 (class 0 OID 0)
-- Dependencies: 34
-- Name: SCHEMA auth; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA auth TO anon;
GRANT USAGE ON SCHEMA auth TO authenticated;
GRANT USAGE ON SCHEMA auth TO service_role;
GRANT ALL ON SCHEMA auth TO supabase_auth_admin;
GRANT ALL ON SCHEMA auth TO dashboard_user;
GRANT USAGE ON SCHEMA auth TO postgres;


--
-- TOC entry 4386 (class 0 OID 0)
-- Dependencies: 23
-- Name: SCHEMA extensions; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA extensions TO anon;
GRANT USAGE ON SCHEMA extensions TO authenticated;
GRANT USAGE ON SCHEMA extensions TO service_role;
GRANT ALL ON SCHEMA extensions TO dashboard_user;


--
-- TOC entry 4388 (class 0 OID 0)
-- Dependencies: 59
-- Name: SCHEMA public; Type: ACL; Schema: -; Owner: postgres
--

REVOKE USAGE ON SCHEMA public FROM PUBLIC;


--
-- TOC entry 4389 (class 0 OID 0)
-- Dependencies: 38
-- Name: SCHEMA realtime; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA realtime TO postgres;
GRANT USAGE ON SCHEMA realtime TO anon;
GRANT USAGE ON SCHEMA realtime TO authenticated;
GRANT USAGE ON SCHEMA realtime TO service_role;
GRANT ALL ON SCHEMA realtime TO supabase_realtime_admin;


--
-- TOC entry 4390 (class 0 OID 0)
-- Dependencies: 33
-- Name: SCHEMA storage; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA storage TO postgres;
GRANT USAGE ON SCHEMA storage TO anon;
GRANT USAGE ON SCHEMA storage TO authenticated;
GRANT USAGE ON SCHEMA storage TO service_role;
GRANT ALL ON SCHEMA storage TO supabase_storage_admin;
GRANT ALL ON SCHEMA storage TO dashboard_user;


--
-- TOC entry 4391 (class 0 OID 0)
-- Dependencies: 29
-- Name: SCHEMA vault; Type: ACL; Schema: -; Owner: postgres
--

GRANT USAGE ON SCHEMA vault TO postgres WITH GRANT OPTION;
GRANT USAGE ON SCHEMA vault TO service_role;


--
-- TOC entry 4398 (class 0 OID 0)
-- Dependencies: 380
-- Name: FUNCTION email(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.email() TO dashboard_user;


--
-- TOC entry 4399 (class 0 OID 0)
-- Dependencies: 441
-- Name: FUNCTION jwt(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.jwt() TO postgres;
GRANT ALL ON FUNCTION auth.jwt() TO dashboard_user;


--
-- TOC entry 4401 (class 0 OID 0)
-- Dependencies: 379
-- Name: FUNCTION role(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.role() TO dashboard_user;


--
-- TOC entry 4403 (class 0 OID 0)
-- Dependencies: 378
-- Name: FUNCTION uid(); Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON FUNCTION auth.uid() TO dashboard_user;


--
-- TOC entry 4404 (class 0 OID 0)
-- Dependencies: 432
-- Name: FUNCTION armor(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea) TO dashboard_user;


--
-- TOC entry 4405 (class 0 OID 0)
-- Dependencies: 433
-- Name: FUNCTION armor(bytea, text[], text[]); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.armor(bytea, text[], text[]) FROM postgres;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.armor(bytea, text[], text[]) TO dashboard_user;


--
-- TOC entry 4406 (class 0 OID 0)
-- Dependencies: 395
-- Name: FUNCTION crypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.crypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.crypt(text, text) TO dashboard_user;


--
-- TOC entry 4407 (class 0 OID 0)
-- Dependencies: 434
-- Name: FUNCTION dearmor(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.dearmor(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.dearmor(text) TO dashboard_user;


--
-- TOC entry 4408 (class 0 OID 0)
-- Dependencies: 399
-- Name: FUNCTION decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4409 (class 0 OID 0)
-- Dependencies: 385
-- Name: FUNCTION decrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.decrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4410 (class 0 OID 0)
-- Dependencies: 392
-- Name: FUNCTION digest(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(bytea, text) TO dashboard_user;


--
-- TOC entry 4411 (class 0 OID 0)
-- Dependencies: 391
-- Name: FUNCTION digest(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.digest(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.digest(text, text) TO dashboard_user;


--
-- TOC entry 4412 (class 0 OID 0)
-- Dependencies: 398
-- Name: FUNCTION encrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4413 (class 0 OID 0)
-- Dependencies: 400
-- Name: FUNCTION encrypt_iv(bytea, bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.encrypt_iv(bytea, bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4414 (class 0 OID 0)
-- Dependencies: 372
-- Name: FUNCTION gen_random_bytes(integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_bytes(integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_bytes(integer) TO dashboard_user;


--
-- TOC entry 4415 (class 0 OID 0)
-- Dependencies: 373
-- Name: FUNCTION gen_random_uuid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_random_uuid() FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_random_uuid() TO dashboard_user;


--
-- TOC entry 4416 (class 0 OID 0)
-- Dependencies: 396
-- Name: FUNCTION gen_salt(text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text) TO dashboard_user;


--
-- TOC entry 4417 (class 0 OID 0)
-- Dependencies: 397
-- Name: FUNCTION gen_salt(text, integer); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.gen_salt(text, integer) FROM postgres;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.gen_salt(text, integer) TO dashboard_user;


--
-- TOC entry 4419 (class 0 OID 0)
-- Dependencies: 440
-- Name: FUNCTION grant_pg_cron_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_cron_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_cron_access() TO dashboard_user;


--
-- TOC entry 4421 (class 0 OID 0)
-- Dependencies: 410
-- Name: FUNCTION grant_pg_graphql_access(); Type: ACL; Schema: extensions; Owner: postgres
--

GRANT ALL ON FUNCTION extensions.grant_pg_graphql_access() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4423 (class 0 OID 0)
-- Dependencies: 408
-- Name: FUNCTION grant_pg_net_access(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.grant_pg_net_access() FROM postgres;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.grant_pg_net_access() TO dashboard_user;


--
-- TOC entry 4424 (class 0 OID 0)
-- Dependencies: 394
-- Name: FUNCTION hmac(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4425 (class 0 OID 0)
-- Dependencies: 393
-- Name: FUNCTION hmac(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.hmac(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.hmac(text, text, text) TO dashboard_user;


--
-- TOC entry 4426 (class 0 OID 0)
-- Dependencies: 438
-- Name: FUNCTION pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements(showtext boolean, OUT userid oid, OUT dbid oid, OUT toplevel boolean, OUT queryid bigint, OUT query text, OUT plans bigint, OUT total_plan_time double precision, OUT min_plan_time double precision, OUT max_plan_time double precision, OUT mean_plan_time double precision, OUT stddev_plan_time double precision, OUT calls bigint, OUT total_exec_time double precision, OUT min_exec_time double precision, OUT max_exec_time double precision, OUT mean_exec_time double precision, OUT stddev_exec_time double precision, OUT rows bigint, OUT shared_blks_hit bigint, OUT shared_blks_read bigint, OUT shared_blks_dirtied bigint, OUT shared_blks_written bigint, OUT local_blks_hit bigint, OUT local_blks_read bigint, OUT local_blks_dirtied bigint, OUT local_blks_written bigint, OUT temp_blks_read bigint, OUT temp_blks_written bigint, OUT blk_read_time double precision, OUT blk_write_time double precision, OUT temp_blk_read_time double precision, OUT temp_blk_write_time double precision, OUT wal_records bigint, OUT wal_fpi bigint, OUT wal_bytes numeric, OUT jit_functions bigint, OUT jit_generation_time double precision, OUT jit_inlining_count bigint, OUT jit_inlining_time double precision, OUT jit_optimization_count bigint, OUT jit_optimization_time double precision, OUT jit_emission_count bigint, OUT jit_emission_time double precision) TO dashboard_user;


--
-- TOC entry 4427 (class 0 OID 0)
-- Dependencies: 437
-- Name: FUNCTION pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_info(OUT dealloc bigint, OUT stats_reset timestamp with time zone) TO dashboard_user;


--
-- TOC entry 4428 (class 0 OID 0)
-- Dependencies: 436
-- Name: FUNCTION pg_stat_statements_reset(userid oid, dbid oid, queryid bigint); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) FROM postgres;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pg_stat_statements_reset(userid oid, dbid oid, queryid bigint) TO dashboard_user;


--
-- TOC entry 4429 (class 0 OID 0)
-- Dependencies: 435
-- Name: FUNCTION pgp_armor_headers(text, OUT key text, OUT value text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_armor_headers(text, OUT key text, OUT value text) TO dashboard_user;


--
-- TOC entry 4430 (class 0 OID 0)
-- Dependencies: 431
-- Name: FUNCTION pgp_key_id(bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_key_id(bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_key_id(bytea) TO dashboard_user;


--
-- TOC entry 4431 (class 0 OID 0)
-- Dependencies: 425
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4432 (class 0 OID 0)
-- Dependencies: 427
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4433 (class 0 OID 0)
-- Dependencies: 429
-- Name: FUNCTION pgp_pub_decrypt(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4434 (class 0 OID 0)
-- Dependencies: 426
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4435 (class 0 OID 0)
-- Dependencies: 428
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4436 (class 0 OID 0)
-- Dependencies: 430
-- Name: FUNCTION pgp_pub_decrypt_bytea(bytea, bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_decrypt_bytea(bytea, bytea, text, text) TO dashboard_user;


--
-- TOC entry 4437 (class 0 OID 0)
-- Dependencies: 421
-- Name: FUNCTION pgp_pub_encrypt(text, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea) TO dashboard_user;


--
-- TOC entry 4438 (class 0 OID 0)
-- Dependencies: 423
-- Name: FUNCTION pgp_pub_encrypt(text, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt(text, bytea, text) TO dashboard_user;


--
-- TOC entry 4439 (class 0 OID 0)
-- Dependencies: 422
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea) TO dashboard_user;


--
-- TOC entry 4440 (class 0 OID 0)
-- Dependencies: 424
-- Name: FUNCTION pgp_pub_encrypt_bytea(bytea, bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_pub_encrypt_bytea(bytea, bytea, text) TO dashboard_user;


--
-- TOC entry 4441 (class 0 OID 0)
-- Dependencies: 386
-- Name: FUNCTION pgp_sym_decrypt(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text) TO dashboard_user;


--
-- TOC entry 4442 (class 0 OID 0)
-- Dependencies: 388
-- Name: FUNCTION pgp_sym_decrypt(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4443 (class 0 OID 0)
-- Dependencies: 387
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4444 (class 0 OID 0)
-- Dependencies: 404
-- Name: FUNCTION pgp_sym_decrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_decrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4445 (class 0 OID 0)
-- Dependencies: 374
-- Name: FUNCTION pgp_sym_encrypt(text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text) TO dashboard_user;


--
-- TOC entry 4446 (class 0 OID 0)
-- Dependencies: 370
-- Name: FUNCTION pgp_sym_encrypt(text, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt(text, text, text) TO dashboard_user;


--
-- TOC entry 4447 (class 0 OID 0)
-- Dependencies: 369
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text) TO dashboard_user;


--
-- TOC entry 4448 (class 0 OID 0)
-- Dependencies: 371
-- Name: FUNCTION pgp_sym_encrypt_bytea(bytea, text, text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) FROM postgres;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.pgp_sym_encrypt_bytea(bytea, text, text) TO dashboard_user;


--
-- TOC entry 4449 (class 0 OID 0)
-- Dependencies: 409
-- Name: FUNCTION pgrst_ddl_watch(); Type: ACL; Schema: extensions; Owner: postgres
--

GRANT ALL ON FUNCTION extensions.pgrst_ddl_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4450 (class 0 OID 0)
-- Dependencies: 405
-- Name: FUNCTION pgrst_drop_watch(); Type: ACL; Schema: extensions; Owner: postgres
--

GRANT ALL ON FUNCTION extensions.pgrst_drop_watch() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4452 (class 0 OID 0)
-- Dependencies: 439
-- Name: FUNCTION set_graphql_placeholder(); Type: ACL; Schema: extensions; Owner: postgres
--

GRANT ALL ON FUNCTION extensions.set_graphql_placeholder() TO postgres WITH GRANT OPTION;


--
-- TOC entry 4453 (class 0 OID 0)
-- Dependencies: 384
-- Name: FUNCTION uuid_generate_v1(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1() TO dashboard_user;


--
-- TOC entry 4454 (class 0 OID 0)
-- Dependencies: 375
-- Name: FUNCTION uuid_generate_v1mc(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v1mc() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v1mc() TO dashboard_user;


--
-- TOC entry 4455 (class 0 OID 0)
-- Dependencies: 389
-- Name: FUNCTION uuid_generate_v3(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v3(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4456 (class 0 OID 0)
-- Dependencies: 356
-- Name: FUNCTION uuid_generate_v4(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v4() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v4() TO dashboard_user;


--
-- TOC entry 4457 (class 0 OID 0)
-- Dependencies: 390
-- Name: FUNCTION uuid_generate_v5(namespace uuid, name text); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_generate_v5(namespace uuid, name text) TO dashboard_user;


--
-- TOC entry 4458 (class 0 OID 0)
-- Dependencies: 376
-- Name: FUNCTION uuid_nil(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_nil() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_nil() TO dashboard_user;


--
-- TOC entry 4459 (class 0 OID 0)
-- Dependencies: 377
-- Name: FUNCTION uuid_ns_dns(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_dns() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_dns() TO dashboard_user;


--
-- TOC entry 4460 (class 0 OID 0)
-- Dependencies: 382
-- Name: FUNCTION uuid_ns_oid(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_oid() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_oid() TO dashboard_user;


--
-- TOC entry 4461 (class 0 OID 0)
-- Dependencies: 381
-- Name: FUNCTION uuid_ns_url(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_url() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_url() TO dashboard_user;


--
-- TOC entry 4462 (class 0 OID 0)
-- Dependencies: 383
-- Name: FUNCTION uuid_ns_x500(); Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON FUNCTION extensions.uuid_ns_x500() FROM postgres;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION extensions.uuid_ns_x500() TO dashboard_user;


--
-- TOC entry 4463 (class 0 OID 0)
-- Dependencies: 406
-- Name: FUNCTION graphql("operationName" text, query text, variables jsonb, extensions jsonb); Type: ACL; Schema: graphql_public; Owner: postgres
--

GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO postgres;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO anon;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO authenticated;
GRANT ALL ON FUNCTION graphql_public.graphql("operationName" text, query text, variables jsonb, extensions jsonb) TO service_role;


--
-- TOC entry 4464 (class 0 OID 0)
-- Dependencies: 355
-- Name: FUNCTION get_auth(p_usename text); Type: ACL; Schema: pgbouncer; Owner: postgres
--

REVOKE ALL ON FUNCTION pgbouncer.get_auth(p_usename text) FROM PUBLIC;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO pgbouncer;
GRANT ALL ON FUNCTION pgbouncer.get_auth(p_usename text) TO postgres;


--
-- TOC entry 4468 (class 0 OID 0)
-- Dependencies: 457
-- Name: FUNCTION apply_rls(wal jsonb, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.apply_rls(wal jsonb, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4469 (class 0 OID 0)
-- Dependencies: 463
-- Name: FUNCTION broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO postgres;
GRANT ALL ON FUNCTION realtime.broadcast_changes(topic_name text, event_name text, operation text, table_name text, table_schema text, new record, old record, level text) TO dashboard_user;


--
-- TOC entry 4470 (class 0 OID 0)
-- Dependencies: 456
-- Name: FUNCTION build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO postgres;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO anon;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO service_role;
GRANT ALL ON FUNCTION realtime.build_prepared_statement_sql(prepared_statement_name text, entity regclass, columns realtime.wal_column[]) TO supabase_realtime_admin;


--
-- TOC entry 4471 (class 0 OID 0)
-- Dependencies: 453
-- Name: FUNCTION "cast"(val text, type_ regtype); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO postgres;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO dashboard_user;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO anon;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO authenticated;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO service_role;
GRANT ALL ON FUNCTION realtime."cast"(val text, type_ regtype) TO supabase_realtime_admin;


--
-- TOC entry 4472 (class 0 OID 0)
-- Dependencies: 454
-- Name: FUNCTION check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO postgres;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO anon;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO authenticated;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO service_role;
GRANT ALL ON FUNCTION realtime.check_equality_op(op realtime.equality_op, type_ regtype, val_1 text, val_2 text) TO supabase_realtime_admin;


--
-- TOC entry 4473 (class 0 OID 0)
-- Dependencies: 459
-- Name: FUNCTION is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO postgres;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO anon;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO authenticated;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO service_role;
GRANT ALL ON FUNCTION realtime.is_visible_through_filters(columns realtime.wal_column[], filters realtime.user_defined_filter[]) TO supabase_realtime_admin;


--
-- TOC entry 4474 (class 0 OID 0)
-- Dependencies: 460
-- Name: FUNCTION list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO postgres;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO anon;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO authenticated;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO service_role;
GRANT ALL ON FUNCTION realtime.list_changes(publication name, slot_name name, max_changes integer, max_record_bytes integer) TO supabase_realtime_admin;


--
-- TOC entry 4475 (class 0 OID 0)
-- Dependencies: 452
-- Name: FUNCTION quote_wal2json(entity regclass); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO postgres;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO anon;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO authenticated;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO service_role;
GRANT ALL ON FUNCTION realtime.quote_wal2json(entity regclass) TO supabase_realtime_admin;


--
-- TOC entry 4476 (class 0 OID 0)
-- Dependencies: 462
-- Name: FUNCTION send(payload jsonb, event text, topic text, private boolean); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO postgres;
GRANT ALL ON FUNCTION realtime.send(payload jsonb, event text, topic text, private boolean) TO dashboard_user;


--
-- TOC entry 4477 (class 0 OID 0)
-- Dependencies: 458
-- Name: FUNCTION subscription_check_filters(); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO postgres;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO dashboard_user;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO anon;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO authenticated;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO service_role;
GRANT ALL ON FUNCTION realtime.subscription_check_filters() TO supabase_realtime_admin;


--
-- TOC entry 4478 (class 0 OID 0)
-- Dependencies: 455
-- Name: FUNCTION to_regrole(role_name text); Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO postgres;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO dashboard_user;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO anon;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO authenticated;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO service_role;
GRANT ALL ON FUNCTION realtime.to_regrole(role_name text) TO supabase_realtime_admin;


--
-- TOC entry 4479 (class 0 OID 0)
-- Dependencies: 461
-- Name: FUNCTION topic(); Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON FUNCTION realtime.topic() TO postgres;
GRANT ALL ON FUNCTION realtime.topic() TO dashboard_user;


--
-- TOC entry 4480 (class 0 OID 0)
-- Dependencies: 416
-- Name: FUNCTION _crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea); Type: ACL; Schema: vault; Owner: postgres
--

GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault._crypto_aead_det_decrypt(message bytea, additional bytea, key_id bigint, context bytea, nonce bytea) TO service_role;


--
-- TOC entry 4481 (class 0 OID 0)
-- Dependencies: 419
-- Name: FUNCTION create_secret(new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: postgres
--

GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.create_secret(new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4482 (class 0 OID 0)
-- Dependencies: 420
-- Name: FUNCTION update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid); Type: ACL; Schema: vault; Owner: postgres
--

GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO postgres WITH GRANT OPTION;
GRANT ALL ON FUNCTION vault.update_secret(secret_id uuid, new_secret text, new_name text, new_description text, new_key_id uuid) TO service_role;


--
-- TOC entry 4484 (class 0 OID 0)
-- Dependencies: 293
-- Name: TABLE audit_log_entries; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.audit_log_entries TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.audit_log_entries TO postgres;
GRANT SELECT ON TABLE auth.audit_log_entries TO postgres WITH GRANT OPTION;


--
-- TOC entry 4486 (class 0 OID 0)
-- Dependencies: 310
-- Name: TABLE flow_state; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.flow_state TO postgres;
GRANT SELECT ON TABLE auth.flow_state TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.flow_state TO dashboard_user;


--
-- TOC entry 4489 (class 0 OID 0)
-- Dependencies: 301
-- Name: TABLE identities; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.identities TO postgres;
GRANT SELECT ON TABLE auth.identities TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.identities TO dashboard_user;


--
-- TOC entry 4491 (class 0 OID 0)
-- Dependencies: 292
-- Name: TABLE instances; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.instances TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.instances TO postgres;
GRANT SELECT ON TABLE auth.instances TO postgres WITH GRANT OPTION;


--
-- TOC entry 4493 (class 0 OID 0)
-- Dependencies: 305
-- Name: TABLE mfa_amr_claims; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_amr_claims TO postgres;
GRANT SELECT ON TABLE auth.mfa_amr_claims TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_amr_claims TO dashboard_user;


--
-- TOC entry 4495 (class 0 OID 0)
-- Dependencies: 304
-- Name: TABLE mfa_challenges; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_challenges TO postgres;
GRANT SELECT ON TABLE auth.mfa_challenges TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_challenges TO dashboard_user;


--
-- TOC entry 4497 (class 0 OID 0)
-- Dependencies: 303
-- Name: TABLE mfa_factors; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.mfa_factors TO postgres;
GRANT SELECT ON TABLE auth.mfa_factors TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.mfa_factors TO dashboard_user;


--
-- TOC entry 4498 (class 0 OID 0)
-- Dependencies: 311
-- Name: TABLE one_time_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.one_time_tokens TO postgres;
GRANT SELECT ON TABLE auth.one_time_tokens TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.one_time_tokens TO dashboard_user;


--
-- TOC entry 4500 (class 0 OID 0)
-- Dependencies: 291
-- Name: TABLE refresh_tokens; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.refresh_tokens TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.refresh_tokens TO postgres;
GRANT SELECT ON TABLE auth.refresh_tokens TO postgres WITH GRANT OPTION;


--
-- TOC entry 4502 (class 0 OID 0)
-- Dependencies: 290
-- Name: SEQUENCE refresh_tokens_id_seq; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO dashboard_user;
GRANT ALL ON SEQUENCE auth.refresh_tokens_id_seq TO postgres;


--
-- TOC entry 4504 (class 0 OID 0)
-- Dependencies: 308
-- Name: TABLE saml_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_providers TO postgres;
GRANT SELECT ON TABLE auth.saml_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_providers TO dashboard_user;


--
-- TOC entry 4506 (class 0 OID 0)
-- Dependencies: 309
-- Name: TABLE saml_relay_states; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.saml_relay_states TO postgres;
GRANT SELECT ON TABLE auth.saml_relay_states TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.saml_relay_states TO dashboard_user;


--
-- TOC entry 4508 (class 0 OID 0)
-- Dependencies: 294
-- Name: TABLE schema_migrations; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT SELECT ON TABLE auth.schema_migrations TO postgres WITH GRANT OPTION;


--
-- TOC entry 4511 (class 0 OID 0)
-- Dependencies: 302
-- Name: TABLE sessions; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sessions TO postgres;
GRANT SELECT ON TABLE auth.sessions TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sessions TO dashboard_user;


--
-- TOC entry 4513 (class 0 OID 0)
-- Dependencies: 307
-- Name: TABLE sso_domains; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_domains TO postgres;
GRANT SELECT ON TABLE auth.sso_domains TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_domains TO dashboard_user;


--
-- TOC entry 4516 (class 0 OID 0)
-- Dependencies: 306
-- Name: TABLE sso_providers; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.sso_providers TO postgres;
GRANT SELECT ON TABLE auth.sso_providers TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE auth.sso_providers TO dashboard_user;


--
-- TOC entry 4519 (class 0 OID 0)
-- Dependencies: 289
-- Name: TABLE users; Type: ACL; Schema: auth; Owner: supabase_auth_admin
--

GRANT ALL ON TABLE auth.users TO dashboard_user;
GRANT INSERT,REFERENCES,DELETE,TRIGGER,TRUNCATE,UPDATE ON TABLE auth.users TO postgres;
GRANT SELECT ON TABLE auth.users TO postgres WITH GRANT OPTION;


--
-- TOC entry 4520 (class 0 OID 0)
-- Dependencies: 288
-- Name: TABLE pg_stat_statements; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements TO dashboard_user;


--
-- TOC entry 4521 (class 0 OID 0)
-- Dependencies: 287
-- Name: TABLE pg_stat_statements_info; Type: ACL; Schema: extensions; Owner: postgres
--

REVOKE ALL ON TABLE extensions.pg_stat_statements_info FROM postgres;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO postgres WITH GRANT OPTION;
GRANT ALL ON TABLE extensions.pg_stat_statements_info TO dashboard_user;


--
-- TOC entry 4523 (class 0 OID 0)
-- Dependencies: 320
-- Name: TABLE messages; Type: ACL; Schema: realtime; Owner: supabase_realtime_admin
--

GRANT ALL ON TABLE realtime.messages TO postgres;
GRANT ALL ON TABLE realtime.messages TO dashboard_user;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO anon;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO authenticated;
GRANT SELECT,INSERT,UPDATE ON TABLE realtime.messages TO service_role;


--
-- TOC entry 4524 (class 0 OID 0)
-- Dependencies: 321
-- Name: TABLE messages_2025_06_01; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.messages_2025_06_01 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_01 TO dashboard_user;


--
-- TOC entry 4525 (class 0 OID 0)
-- Dependencies: 322
-- Name: TABLE messages_2025_06_02; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.messages_2025_06_02 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_02 TO dashboard_user;


--
-- TOC entry 4526 (class 0 OID 0)
-- Dependencies: 323
-- Name: TABLE messages_2025_06_03; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.messages_2025_06_03 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_03 TO dashboard_user;


--
-- TOC entry 4527 (class 0 OID 0)
-- Dependencies: 324
-- Name: TABLE messages_2025_06_04; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.messages_2025_06_04 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_04 TO dashboard_user;


--
-- TOC entry 4528 (class 0 OID 0)
-- Dependencies: 325
-- Name: TABLE messages_2025_06_05; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.messages_2025_06_05 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_05 TO dashboard_user;


--
-- TOC entry 4529 (class 0 OID 0)
-- Dependencies: 326
-- Name: TABLE messages_2025_06_06; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.messages_2025_06_06 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_06 TO dashboard_user;


--
-- TOC entry 4530 (class 0 OID 0)
-- Dependencies: 327
-- Name: TABLE messages_2025_06_07; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.messages_2025_06_07 TO postgres;
GRANT ALL ON TABLE realtime.messages_2025_06_07 TO dashboard_user;


--
-- TOC entry 4531 (class 0 OID 0)
-- Dependencies: 314
-- Name: TABLE schema_migrations; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.schema_migrations TO postgres;
GRANT ALL ON TABLE realtime.schema_migrations TO dashboard_user;
GRANT SELECT ON TABLE realtime.schema_migrations TO anon;
GRANT SELECT ON TABLE realtime.schema_migrations TO authenticated;
GRANT SELECT ON TABLE realtime.schema_migrations TO service_role;
GRANT ALL ON TABLE realtime.schema_migrations TO supabase_realtime_admin;


--
-- TOC entry 4532 (class 0 OID 0)
-- Dependencies: 317
-- Name: TABLE subscription; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON TABLE realtime.subscription TO postgres;
GRANT ALL ON TABLE realtime.subscription TO dashboard_user;
GRANT SELECT ON TABLE realtime.subscription TO anon;
GRANT SELECT ON TABLE realtime.subscription TO authenticated;
GRANT SELECT ON TABLE realtime.subscription TO service_role;
GRANT ALL ON TABLE realtime.subscription TO supabase_realtime_admin;


--
-- TOC entry 4533 (class 0 OID 0)
-- Dependencies: 316
-- Name: SEQUENCE subscription_id_seq; Type: ACL; Schema: realtime; Owner: postgres
--

GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO postgres;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO dashboard_user;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO anon;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO authenticated;
GRANT USAGE ON SEQUENCE realtime.subscription_id_seq TO service_role;
GRANT ALL ON SEQUENCE realtime.subscription_id_seq TO supabase_realtime_admin;


--
-- TOC entry 4535 (class 0 OID 0)
-- Dependencies: 295
-- Name: TABLE buckets; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.buckets TO anon;
GRANT ALL ON TABLE storage.buckets TO authenticated;
GRANT ALL ON TABLE storage.buckets TO service_role;
GRANT ALL ON TABLE storage.buckets TO postgres;


--
-- TOC entry 4537 (class 0 OID 0)
-- Dependencies: 296
-- Name: TABLE objects; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.objects TO anon;
GRANT ALL ON TABLE storage.objects TO authenticated;
GRANT ALL ON TABLE storage.objects TO service_role;
GRANT ALL ON TABLE storage.objects TO postgres;


--
-- TOC entry 4538 (class 0 OID 0)
-- Dependencies: 312
-- Name: TABLE s3_multipart_uploads; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads TO anon;


--
-- TOC entry 4539 (class 0 OID 0)
-- Dependencies: 313
-- Name: TABLE s3_multipart_uploads_parts; Type: ACL; Schema: storage; Owner: supabase_storage_admin
--

GRANT ALL ON TABLE storage.s3_multipart_uploads_parts TO service_role;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO authenticated;
GRANT SELECT ON TABLE storage.s3_multipart_uploads_parts TO anon;


--
-- TOC entry 4540 (class 0 OID 0)
-- Dependencies: 298
-- Name: TABLE secrets; Type: ACL; Schema: vault; Owner: postgres
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.secrets TO service_role;


--
-- TOC entry 4541 (class 0 OID 0)
-- Dependencies: 299
-- Name: TABLE decrypted_secrets; Type: ACL; Schema: vault; Owner: postgres
--

GRANT SELECT,REFERENCES,DELETE,TRUNCATE ON TABLE vault.decrypted_secrets TO postgres WITH GRANT OPTION;
GRANT SELECT,DELETE ON TABLE vault.decrypted_secrets TO service_role;


--
-- TOC entry 2522 (class 826 OID 16590)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- TOC entry 2523 (class 826 OID 16591)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- TOC entry 2521 (class 826 OID 16589)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: auth; Owner: supabase_auth_admin
--

ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE supabase_auth_admin IN SCHEMA auth GRANT ALL ON TABLES  TO dashboard_user;


--
-- TOC entry 2532 (class 826 OID 16664)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: extensions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA extensions GRANT ALL ON SEQUENCES  TO postgres WITH GRANT OPTION;


--
-- TOC entry 2531 (class 826 OID 16663)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: extensions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA extensions GRANT ALL ON FUNCTIONS  TO postgres WITH GRANT OPTION;


--
-- TOC entry 2530 (class 826 OID 16662)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: extensions; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA extensions GRANT ALL ON TABLES  TO postgres WITH GRANT OPTION;


--
-- TOC entry 2535 (class 826 OID 16624)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2534 (class 826 OID 16623)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2533 (class 826 OID 16622)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2527 (class 826 OID 16604)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: graphql_public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2529 (class 826 OID 16603)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: graphql_public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2528 (class 826 OID 16602)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: graphql_public; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA graphql_public GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 2525 (class 826 OID 16594)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: realtime; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA realtime GRANT ALL ON SEQUENCES  TO dashboard_user;


--
-- TOC entry 2526 (class 826 OID 16595)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: realtime; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA realtime GRANT ALL ON FUNCTIONS  TO dashboard_user;


--
-- TOC entry 2524 (class 826 OID 16593)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: realtime; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA realtime GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA realtime GRANT ALL ON TABLES  TO dashboard_user;


--
-- TOC entry 2520 (class 826 OID 16532)
-- Name: DEFAULT PRIVILEGES FOR SEQUENCES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON SEQUENCES  TO service_role;


--
-- TOC entry 2519 (class 826 OID 16531)
-- Name: DEFAULT PRIVILEGES FOR FUNCTIONS; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON FUNCTIONS  TO service_role;


--
-- TOC entry 2518 (class 826 OID 16530)
-- Name: DEFAULT PRIVILEGES FOR TABLES; Type: DEFAULT ACL; Schema: storage; Owner: postgres
--

ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO postgres;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO anon;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO authenticated;
ALTER DEFAULT PRIVILEGES FOR ROLE postgres IN SCHEMA storage GRANT ALL ON TABLES  TO service_role;


--
-- TOC entry 3700 (class 3466 OID 16608)
-- Name: issue_graphql_placeholder; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_graphql_placeholder ON sql_drop
         WHEN TAG IN ('DROP EXTENSION')
   EXECUTE FUNCTION extensions.set_graphql_placeholder();


ALTER EVENT TRIGGER issue_graphql_placeholder OWNER TO postgres;

--
-- TOC entry 3705 (class 3466 OID 16677)
-- Name: issue_pg_cron_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_cron_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_cron_access();


ALTER EVENT TRIGGER issue_pg_cron_access OWNER TO postgres;

--
-- TOC entry 3699 (class 3466 OID 16606)
-- Name: issue_pg_graphql_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_graphql_access ON ddl_command_end
         WHEN TAG IN ('CREATE FUNCTION')
   EXECUTE FUNCTION extensions.grant_pg_graphql_access();


ALTER EVENT TRIGGER issue_pg_graphql_access OWNER TO postgres;

--
-- TOC entry 3706 (class 3466 OID 16678)
-- Name: issue_pg_net_access; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER issue_pg_net_access ON ddl_command_end
         WHEN TAG IN ('CREATE EXTENSION')
   EXECUTE FUNCTION extensions.grant_pg_net_access();


ALTER EVENT TRIGGER issue_pg_net_access OWNER TO postgres;

--
-- TOC entry 3701 (class 3466 OID 16609)
-- Name: pgrst_ddl_watch; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER pgrst_ddl_watch ON ddl_command_end
   EXECUTE FUNCTION extensions.pgrst_ddl_watch();


ALTER EVENT TRIGGER pgrst_ddl_watch OWNER TO postgres;

--
-- TOC entry 3702 (class 3466 OID 16610)
-- Name: pgrst_drop_watch; Type: EVENT TRIGGER; Schema: -; Owner: postgres
--

CREATE EVENT TRIGGER pgrst_drop_watch ON sql_drop
   EXECUTE FUNCTION extensions.pgrst_drop_watch();


ALTER EVENT TRIGGER pgrst_drop_watch OWNER TO postgres;

-- Completed on 2025-06-04 16:02:37 UTC

--
-- PostgreSQL database dump complete
--


--
-- PostgreSQL database dump
--

-- Dumped from database version 15.8
-- Dumped by pg_dump version 15.3

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'SQL_ASCII';
SET standard_conforming_strings = on;
SELECT pg_catalog.set_config('search_path', '', false);
SET check_function_bodies = false;
SET xmloption = content;
SET client_min_messages = warning;
SET row_security = off;

--
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- Name: GameCategory; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: GameProviderName; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: InvitationStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."InvitationStatus" AS ENUM (
    'PENDING',
    'ACCEPTED',
    'DECLINED',
    'INACTIVE'
);


--
-- Name: JackpotType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."JackpotType" AS ENUM (
    'MINOR',
    'MAJOR',
    'GRAND'
);


--
-- Name: KeyMode; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."KeyMode" AS ENUM (
    'read',
    'write',
    'upload',
    'manage_users',
    'manage_settings',
    'launch_game'
);


--
-- Name: PaymentMethod; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."PaymentMethod" AS ENUM (
    'INSTORE_CASH',
    'INSTORE_CARD',
    'CASH_APP'
);


--
-- Name: ProviderAuthType; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."ProviderAuthType" AS ENUM (
    'API_KEY',
    'OAUTH2',
    'JWT_SIGN',
    'CUSTOM',
    'NONE'
);


--
-- Name: RewardStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."RewardStatus" AS ENUM (
    'AVAILABLE',
    'CLAIMED',
    'EXPIRED',
    'PENDING',
    'VOIDED'
);


--
-- Name: Role; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: TournamentStatus; Type: TYPE; Schema: public; Owner: -
--

CREATE TYPE public."TournamentStatus" AS ENUM (
    'PENDING',
    'ACTIVE',
    'COMPLETED',
    'CANCELLED'
);


--
-- Name: TransactionStatus; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: TransactionType; Type: TYPE; Schema: public; Owner: -
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


--
-- Name: create_user_wallet_function(); Type: FUNCTION; Schema: public; Owner: -
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


--
-- Name: generate_cuid(); Type: FUNCTION; Schema: public; Owner: -
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


--
-- Name: notify_spec_data_change(); Type: FUNCTION; Schema: public; Owner: -
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


--
-- Name: to_base36(bigint); Type: FUNCTION; Schema: public; Owner: -
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


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: GameProvider; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: Tournament; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: TournamentGamePlay; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TournamentGamePlay" (
    id text NOT NULL,
    "tournamentParticipantId" text NOT NULL,
    "gameId" text NOT NULL,
    "pointsEarned" integer NOT NULL,
    "playedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL,
    "gameSessionId" text
);


--
-- Name: TournamentParticipant; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TournamentParticipant" (
    id text NOT NULL,
    "tournamentId" text NOT NULL,
    "userId" text NOT NULL,
    score integer DEFAULT 0 NOT NULL,
    rank integer,
    "joinedAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: TournamentReward; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."TournamentReward" (
    id text NOT NULL,
    "tournamentId" text NOT NULL,
    rank integer NOT NULL,
    description text NOT NULL,
    "isClaimed" boolean DEFAULT false NOT NULL,
    "winnerId" text
);


--
-- Name: _TournamentGames; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public."_TournamentGames" (
    "A" text NOT NULL,
    "B" text NOT NULL
);


--
-- Name: account; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: game_launch_links; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: game_sessions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: game_spins; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: games; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: jackpot_contributions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jackpot_contributions (
    id text NOT NULL,
    "jackpotId" text NOT NULL,
    "gameSpinId" text NOT NULL,
    "contributionAmountCoins" integer NOT NULL,
    "createdAt" timestamp(3) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: jackpot_wins; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: jackpots; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: operator_access_keys; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: operator_invitations; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: products; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: rebate_transactions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: session; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: todo; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.todo (
    id integer NOT NULL,
    text text NOT NULL,
    completed boolean DEFAULT false NOT NULL
);


--
-- Name: todo_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.todo_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: todo_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.todo_id_seq OWNED BY public.todo.id;


--
-- Name: transactions; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: user_profiles; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: verification; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.verification (
    _id text NOT NULL,
    identifier text NOT NULL,
    value text NOT NULL,
    expires_at timestamp(3) without time zone NOT NULL,
    created_at timestamp(3) without time zone,
    updated_at timestamp(3) without time zone
);


--
-- Name: vip_infos; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: wallets; Type: TABLE; Schema: public; Owner: -
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


--
-- Name: todo id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.todo ALTER COLUMN id SET DEFAULT nextval('public.todo_id_seq'::regclass);


--
-- Name: GameProvider GameProvider_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."GameProvider"
    ADD CONSTRAINT "GameProvider_pkey" PRIMARY KEY (id);


--
-- Name: TournamentGamePlay TournamentGamePlay_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentGamePlay"
    ADD CONSTRAINT "TournamentGamePlay_pkey" PRIMARY KEY (id);


--
-- Name: TournamentParticipant TournamentParticipant_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentParticipant"
    ADD CONSTRAINT "TournamentParticipant_pkey" PRIMARY KEY (id);


--
-- Name: TournamentReward TournamentReward_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentReward"
    ADD CONSTRAINT "TournamentReward_pkey" PRIMARY KEY (id);


--
-- Name: Tournament Tournament_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_pkey" PRIMARY KEY (id);


--
-- Name: _TournamentGames _TournamentGames_AB_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_TournamentGames"
    ADD CONSTRAINT "_TournamentGames_AB_pkey" PRIMARY KEY ("A", "B");


--
-- Name: account account_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_pkey PRIMARY KEY (_id);


--
-- Name: game_launch_links game_launch_links_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT game_launch_links_pkey PRIMARY KEY (id);


--
-- Name: game_sessions game_sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT game_sessions_pkey PRIMARY KEY (id);


--
-- Name: game_spins game_spins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_spins
    ADD CONSTRAINT game_spins_pkey PRIMARY KEY (id);


--
-- Name: games games_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT games_pkey PRIMARY KEY (id);


--
-- Name: jackpot_contributions jackpot_contributions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_contributions
    ADD CONSTRAINT jackpot_contributions_pkey PRIMARY KEY (id);


--
-- Name: jackpot_wins jackpot_wins_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT jackpot_wins_pkey PRIMARY KEY (id);


--
-- Name: jackpots jackpots_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpots
    ADD CONSTRAINT jackpots_pkey PRIMARY KEY (id);


--
-- Name: operator_access_keys operator_access_keys_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operator_access_keys
    ADD CONSTRAINT operator_access_keys_pkey PRIMARY KEY (id);


--
-- Name: operator_invitations operator_invitations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operator_invitations
    ADD CONSTRAINT operator_invitations_pkey PRIMARY KEY (id);


--
-- Name: products products_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT products_pkey PRIMARY KEY (id);


--
-- Name: rebate_transactions rebate_transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rebate_transactions
    ADD CONSTRAINT rebate_transactions_pkey PRIMARY KEY (id);


--
-- Name: session session_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_pkey PRIMARY KEY (_id);


--
-- Name: todo todo_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.todo
    ADD CONSTRAINT todo_pkey PRIMARY KEY (id);


--
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- Name: user user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."user"
    ADD CONSTRAINT user_pkey PRIMARY KEY (_id);


--
-- Name: user_profiles user_profiles_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_pkey PRIMARY KEY (id);


--
-- Name: verification verification_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.verification
    ADD CONSTRAINT verification_pkey PRIMARY KEY (_id);


--
-- Name: vip_infos vip_infos_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.vip_infos
    ADD CONSTRAINT vip_infos_pkey PRIMARY KEY (id);


--
-- Name: wallets wallets_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT wallets_pkey PRIMARY KEY (id);


--
-- Name: GameProvider_isActive_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "GameProvider_isActive_idx" ON public."GameProvider" USING btree ("isActive");


--
-- Name: GameProvider_name_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "GameProvider_name_idx" ON public."GameProvider" USING btree (name);


--
-- Name: GameProvider_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "GameProvider_name_key" ON public."GameProvider" USING btree (name);


--
-- Name: TournamentGamePlay_tournamentParticipantId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TournamentGamePlay_tournamentParticipantId_idx" ON public."TournamentGamePlay" USING btree ("tournamentParticipantId");


--
-- Name: TournamentParticipant_tournamentId_score_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TournamentParticipant_tournamentId_score_idx" ON public."TournamentParticipant" USING btree ("tournamentId", score);


--
-- Name: TournamentParticipant_tournamentId_userId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "TournamentParticipant_tournamentId_userId_key" ON public."TournamentParticipant" USING btree ("tournamentId", "userId");


--
-- Name: TournamentParticipant_userId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TournamentParticipant_userId_idx" ON public."TournamentParticipant" USING btree ("userId");


--
-- Name: TournamentReward_tournamentId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "TournamentReward_tournamentId_idx" ON public."TournamentReward" USING btree ("tournamentId");


--
-- Name: Tournament_status_startTime_endTime_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "Tournament_status_startTime_endTime_idx" ON public."Tournament" USING btree (status, "startTime", "endTime");


--
-- Name: _TournamentGames_B_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "_TournamentGames_B_index" ON public."_TournamentGames" USING btree ("B");


--
-- Name: game_launch_links_session_url_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX game_launch_links_session_url_key ON public.game_launch_links USING btree (session_url);


--
-- Name: game_launch_links_token_internal_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX game_launch_links_token_internal_key ON public.game_launch_links USING btree (token_internal);


--
-- Name: jackpot_contributions_jackpotId_gameSpinId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "jackpot_contributions_jackpotId_gameSpinId_key" ON public.jackpot_contributions USING btree ("jackpotId", "gameSpinId");


--
-- Name: jackpot_wins_gameSpinId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "jackpot_wins_gameSpinId_key" ON public.jackpot_wins USING btree ("gameSpinId");


--
-- Name: operator_access_keys_name_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX operator_access_keys_name_key ON public.operator_access_keys USING btree (name);


--
-- Name: operator_invitations_operatorId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "operator_invitations_operatorId_idx" ON public.operator_invitations USING btree ("operatorId");


--
-- Name: operator_invitations_token_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX operator_invitations_token_idx ON public.operator_invitations USING btree (token);


--
-- Name: operator_invitations_token_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX operator_invitations_token_key ON public.operator_invitations USING btree (token);


--
-- Name: operator_invitations_username_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX operator_invitations_username_idx ON public.operator_invitations USING btree (username);


--
-- Name: rebate_transactions_transactionId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "rebate_transactions_transactionId_key" ON public.rebate_transactions USING btree ("transactionId");


--
-- Name: rebate_transactions_userId_status_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "rebate_transactions_userId_status_idx" ON public.rebate_transactions USING btree ("userId", status);


--
-- Name: session_token_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX session_token_key ON public.session USING btree (token);


--
-- Name: transactions_createdAt_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "transactions_createdAt_idx" ON public.transactions USING btree ("createdAt");


--
-- Name: transactions_paymentMethod_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "transactions_paymentMethod_idx" ON public.transactions USING btree ("paymentMethod");


--
-- Name: transactions_provider_providerTxId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "transactions_provider_providerTxId_idx" ON public.transactions USING btree (provider, "providerTxId");


--
-- Name: transactions_walletId_idx; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX "transactions_walletId_idx" ON public.transactions USING btree ("walletId");


--
-- Name: user_email_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_email_key ON public."user" USING btree (email);


--
-- Name: user_profiles_user_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_profiles_user_id_key ON public.user_profiles USING btree (user_id);


--
-- Name: user_profiles_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_profiles_username_key ON public.user_profiles USING btree (username);


--
-- Name: user_profiles_vip_info_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX user_profiles_vip_info_id_key ON public.user_profiles USING btree (vip_info_id);


--
-- Name: vip_infos_user_id_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vip_infos_user_id_key ON public.vip_infos USING btree (user_id);


--
-- Name: vip_infos_username_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX vip_infos_username_key ON public.vip_infos USING btree (username);


--
-- Name: wallets_address_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX wallets_address_key ON public.wallets USING btree (address);


--
-- Name: wallets_userId_operatorId_key; Type: INDEX; Schema: public; Owner: -
--

CREATE UNIQUE INDEX "wallets_userId_operatorId_key" ON public.wallets USING btree ("userId", "operatorId");


--
-- Name: user_profiles after_user_profile_insert_create_wallet_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER after_user_profile_insert_create_wallet_trigger AFTER INSERT ON public.user_profiles FOR EACH ROW EXECUTE FUNCTION public.create_user_wallet_function();


--
-- Name: user_profiles profile_change_trigger; Type: TRIGGER; Schema: public; Owner: -
--

CREATE TRIGGER profile_change_trigger AFTER INSERT OR DELETE OR UPDATE ON public.user_profiles FOR EACH ROW EXECUTE FUNCTION public.notify_spec_data_change();

ALTER TABLE public.user_profiles DISABLE TRIGGER profile_change_trigger;


--
-- Name: TournamentGamePlay TournamentGamePlay_tournamentParticipantId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentGamePlay"
    ADD CONSTRAINT "TournamentGamePlay_tournamentParticipantId_fkey" FOREIGN KEY ("tournamentParticipantId") REFERENCES public."TournamentParticipant"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TournamentParticipant TournamentParticipant_tournamentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentParticipant"
    ADD CONSTRAINT "TournamentParticipant_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES public."Tournament"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TournamentParticipant TournamentParticipant_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentParticipant"
    ADD CONSTRAINT "TournamentParticipant_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: TournamentReward TournamentReward_tournamentId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentReward"
    ADD CONSTRAINT "TournamentReward_tournamentId_fkey" FOREIGN KEY ("tournamentId") REFERENCES public."Tournament"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: TournamentReward TournamentReward_winnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."TournamentReward"
    ADD CONSTRAINT "TournamentReward_winnerId_fkey" FOREIGN KEY ("winnerId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: Tournament Tournament_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."Tournament"
    ADD CONSTRAINT "Tournament_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: _TournamentGames _TournamentGames_A_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_TournamentGames"
    ADD CONSTRAINT "_TournamentGames_A_fkey" FOREIGN KEY ("A") REFERENCES public.games(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: _TournamentGames _TournamentGames_B_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public."_TournamentGames"
    ADD CONSTRAINT "_TournamentGames_B_fkey" FOREIGN KEY ("B") REFERENCES public."Tournament"(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: account account_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.account
    ADD CONSTRAINT account_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_launch_links game_launch_links_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT "game_launch_links_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES public.games(id) ON UPDATE CASCADE;


--
-- Name: game_launch_links game_launch_links_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT "game_launch_links_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE;


--
-- Name: game_launch_links game_launch_links_userProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_launch_links
    ADD CONSTRAINT "game_launch_links_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: game_sessions game_sessions_gameId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT "game_sessions_gameId_fkey" FOREIGN KEY ("gameId") REFERENCES public.games(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_sessions game_sessions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_sessions
    ADD CONSTRAINT "game_sessions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: game_spins game_spins_gameSessionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.game_spins
    ADD CONSTRAINT "game_spins_gameSessionId_fkey" FOREIGN KEY ("gameSessionId") REFERENCES public.game_sessions(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: games games_gameProviderId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT "games_gameProviderId_fkey" FOREIGN KEY ("gameProviderId") REFERENCES public."GameProvider"(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: games games_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.games
    ADD CONSTRAINT "games_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: jackpot_contributions jackpot_contributions_gameSpinId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_contributions
    ADD CONSTRAINT "jackpot_contributions_gameSpinId_fkey" FOREIGN KEY ("gameSpinId") REFERENCES public.game_spins(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: jackpot_contributions jackpot_contributions_jackpotId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_contributions
    ADD CONSTRAINT "jackpot_contributions_jackpotId_fkey" FOREIGN KEY ("jackpotId") REFERENCES public.jackpots(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: jackpot_wins jackpot_wins_gameSpinId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_gameSpinId_fkey" FOREIGN KEY ("gameSpinId") REFERENCES public.game_spins(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: jackpot_wins jackpot_wins_jackpotId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_jackpotId_fkey" FOREIGN KEY ("jackpotId") REFERENCES public.jackpots(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: jackpot_wins jackpot_wins_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: jackpot_wins jackpot_wins_winnerId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpot_wins
    ADD CONSTRAINT "jackpot_wins_winnerId_fkey" FOREIGN KEY ("winnerId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: jackpots jackpots_lastWonBy_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jackpots
    ADD CONSTRAINT "jackpots_lastWonBy_fkey" FOREIGN KEY ("lastWonBy") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: operator_invitations operator_invitations_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operator_invitations
    ADD CONSTRAINT "operator_invitations_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: operator_invitations operator_invitations_username_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.operator_invitations
    ADD CONSTRAINT operator_invitations_username_fkey FOREIGN KEY (username) REFERENCES public.user_profiles(username) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: products products_shopId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_shopId_fkey" FOREIGN KEY ("shopId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: products products_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.products
    ADD CONSTRAINT "products_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: rebate_transactions rebate_transactions_transactionId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rebate_transactions
    ADD CONSTRAINT "rebate_transactions_transactionId_fkey" FOREIGN KEY ("transactionId") REFERENCES public.transactions(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: rebate_transactions rebate_transactions_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.rebate_transactions
    ADD CONSTRAINT "rebate_transactions_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: session session_user_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.session
    ADD CONSTRAINT session_user_id_fkey FOREIGN KEY (user_id) REFERENCES public."user"(_id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: transactions transactions_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: transactions transactions_productId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_productId_fkey" FOREIGN KEY ("productId") REFERENCES public.products(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: transactions transactions_userProfileId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_userProfileId_fkey" FOREIGN KEY ("userProfileId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: transactions transactions_walletId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT "transactions_walletId_fkey" FOREIGN KEY ("walletId") REFERENCES public.wallets(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user_profiles user_profiles_current_game_sessionid_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_current_game_sessionid_fkey FOREIGN KEY (current_game_sessionid) REFERENCES public.game_sessions(id) ON UPDATE CASCADE ON DELETE SET NULL;


--
-- Name: user_profiles user_profiles_vip_info_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.user_profiles
    ADD CONSTRAINT user_profiles_vip_info_id_fkey FOREIGN KEY (vip_info_id) REFERENCES public.vip_infos(id) ON UPDATE CASCADE ON DELETE RESTRICT;


--
-- Name: wallets wallets_operatorId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT "wallets_operatorId_fkey" FOREIGN KEY ("operatorId") REFERENCES public.operator_access_keys(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- Name: wallets wallets_userId_fkey; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.wallets
    ADD CONSTRAINT "wallets_userId_fkey" FOREIGN KEY ("userId") REFERENCES public.user_profiles(id) ON UPDATE CASCADE ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--


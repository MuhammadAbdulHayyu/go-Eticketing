--
-- PostgreSQL database dump
--

\restrict w03HcXVJRN9MiFBtoHUf2eL5kVoeDHdBxcdAVfQdhEo8T8Tw7mt7VaRITuWQudK

-- Dumped from database version 17.6
-- Dumped by pg_dump version 17.6

-- Started on 2025-08-22 07:54:26

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET transaction_timeout = 0;
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
-- TOC entry 224 (class 1259 OID 16453)
-- Name: cards; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.cards (
    id bigint NOT NULL,
    card_uid character varying(32) NOT NULL,
    last_seen_at timestamp with time zone,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.cards OWNER TO postgres;

--
-- TOC entry 223 (class 1259 OID 16452)
-- Name: cards_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.cards_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.cards_id_seq OWNER TO postgres;

--
-- TOC entry 5007 (class 0 OID 0)
-- Dependencies: 223
-- Name: cards_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.cards_id_seq OWNED BY public.cards.id;


--
-- TOC entry 226 (class 1259 OID 16463)
-- Name: checkpoint; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.checkpoint (
    id bigint NOT NULL,
    card_id bigint NOT NULL,
    checkin_gate_id bigint,
    checkout_gate_id bigint,
    origin_terminal_id bigint,
    dest_terminal_id bigint,
    checkin_time timestamp with time zone,
    checkout_time timestamp with time zone,
    status character varying(20) DEFAULT 'in_progress'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.checkpoint OWNER TO postgres;

--
-- TOC entry 225 (class 1259 OID 16462)
-- Name: checkpoint_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.checkpoint_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.checkpoint_id_seq OWNER TO postgres;

--
-- TOC entry 5008 (class 0 OID 0)
-- Dependencies: 225
-- Name: checkpoint_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.checkpoint_id_seq OWNED BY public.checkpoint.id;


--
-- TOC entry 220 (class 1259 OID 16418)
-- Name: gates; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.gates (
    id bigint NOT NULL,
    terminal_id bigint NOT NULL,
    code character varying(20) NOT NULL,
    nama_gate character varying(64),
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.gates OWNER TO postgres;

--
-- TOC entry 219 (class 1259 OID 16417)
-- Name: gates_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.gates_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.gates_id_seq OWNER TO postgres;

--
-- TOC entry 5009 (class 0 OID 0)
-- Dependencies: 219
-- Name: gates_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.gates_id_seq OWNED BY public.gates.id;


--
-- TOC entry 230 (class 1259 OID 16522)
-- Name: sync_queues; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.sync_queues (
    id bigint NOT NULL,
    gate_id bigint,
    payload jsonb NOT NULL,
    status character varying(20) DEFAULT 'queued'::character varying NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.sync_queues OWNER TO postgres;

--
-- TOC entry 229 (class 1259 OID 16521)
-- Name: sync_queues_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.sync_queues_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.sync_queues_id_seq OWNER TO postgres;

--
-- TOC entry 5010 (class 0 OID 0)
-- Dependencies: 229
-- Name: sync_queues_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.sync_queues_id_seq OWNED BY public.sync_queues.id;


--
-- TOC entry 222 (class 1259 OID 16433)
-- Name: tarif_destinasi; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.tarif_destinasi (
    id bigint NOT NULL,
    origin_terminal_id bigint NOT NULL,
    dest_terminal_id bigint NOT NULL,
    tarif integer NOT NULL,
    created_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.tarif_destinasi OWNER TO postgres;

--
-- TOC entry 221 (class 1259 OID 16432)
-- Name: tarif_destinasi_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.tarif_destinasi_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.tarif_destinasi_id_seq OWNER TO postgres;

--
-- TOC entry 5011 (class 0 OID 0)
-- Dependencies: 221
-- Name: tarif_destinasi_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.tarif_destinasi_id_seq OWNED BY public.tarif_destinasi.id;


--
-- TOC entry 218 (class 1259 OID 16404)
-- Name: terminals; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.terminals (
    id bigint NOT NULL,
    code character varying(20) NOT NULL,
    name character varying(100) NOT NULL,
    location text,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.terminals OWNER TO postgres;

--
-- TOC entry 217 (class 1259 OID 16403)
-- Name: terminals_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.terminals_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.terminals_id_seq OWNER TO postgres;

--
-- TOC entry 5012 (class 0 OID 0)
-- Dependencies: 217
-- Name: terminals_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.terminals_id_seq OWNED BY public.terminals.id;


--
-- TOC entry 228 (class 1259 OID 16497)
-- Name: transactions; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.transactions (
    id bigint NOT NULL,
    checkpoint_id bigint,
    card_id bigint,
    gate_id bigint,
    amount integer NOT NULL,
    ts_gate timestamp with time zone,
    ts_server timestamp with time zone DEFAULT now()
);


ALTER TABLE public.transactions OWNER TO postgres;

--
-- TOC entry 227 (class 1259 OID 16496)
-- Name: transactions_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.transactions_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.transactions_id_seq OWNER TO postgres;

--
-- TOC entry 5013 (class 0 OID 0)
-- Dependencies: 227
-- Name: transactions_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.transactions_id_seq OWNED BY public.transactions.id;


--
-- TOC entry 232 (class 1259 OID 16539)
-- Name: users; Type: TABLE; Schema: public; Owner: postgres
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    username character varying(50) NOT NULL,
    password character varying(100) NOT NULL,
    role character varying(20) DEFAULT 'admin'::character varying NOT NULL,
    is_active boolean DEFAULT true NOT NULL,
    created_at timestamp with time zone DEFAULT now(),
    updated_at timestamp with time zone DEFAULT now()
);


ALTER TABLE public.users OWNER TO postgres;

--
-- TOC entry 231 (class 1259 OID 16538)
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: postgres
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER SEQUENCE public.users_id_seq OWNER TO postgres;

--
-- TOC entry 5014 (class 0 OID 0)
-- Dependencies: 231
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: postgres
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- TOC entry 4786 (class 2604 OID 16456)
-- Name: cards id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards ALTER COLUMN id SET DEFAULT nextval('public.cards_id_seq'::regclass);


--
-- TOC entry 4788 (class 2604 OID 16466)
-- Name: checkpoint id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkpoint ALTER COLUMN id SET DEFAULT nextval('public.checkpoint_id_seq'::regclass);


--
-- TOC entry 4781 (class 2604 OID 16421)
-- Name: gates id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gates ALTER COLUMN id SET DEFAULT nextval('public.gates_id_seq'::regclass);


--
-- TOC entry 4793 (class 2604 OID 16525)
-- Name: sync_queues id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_queues ALTER COLUMN id SET DEFAULT nextval('public.sync_queues_id_seq'::regclass);


--
-- TOC entry 4784 (class 2604 OID 16436)
-- Name: tarif_destinasi id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_destinasi ALTER COLUMN id SET DEFAULT nextval('public.tarif_destinasi_id_seq'::regclass);


--
-- TOC entry 4777 (class 2604 OID 16407)
-- Name: terminals id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terminals ALTER COLUMN id SET DEFAULT nextval('public.terminals_id_seq'::regclass);


--
-- TOC entry 4791 (class 2604 OID 16500)
-- Name: transactions id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions ALTER COLUMN id SET DEFAULT nextval('public.transactions_id_seq'::regclass);


--
-- TOC entry 4797 (class 2604 OID 16542)
-- Name: users id; Type: DEFAULT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- TOC entry 4993 (class 0 OID 16453)
-- Dependencies: 224
-- Data for Name: cards; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4995 (class 0 OID 16463)
-- Dependencies: 226
-- Data for Name: checkpoint; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4989 (class 0 OID 16418)
-- Dependencies: 220
-- Data for Name: gates; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4999 (class 0 OID 16522)
-- Dependencies: 230
-- Data for Name: sync_queues; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4991 (class 0 OID 16433)
-- Dependencies: 222
-- Data for Name: tarif_destinasi; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 4987 (class 0 OID 16404)
-- Dependencies: 218
-- Data for Name: terminals; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.terminals VALUES (1, '12', 'Terminal A', 'Jakarta', true, '2025-08-22 07:01:08.486067+07', '2025-08-22 07:01:08.486067+07');
INSERT INTO public.terminals VALUES (2, 'TSN', 'Terminal Senen', 'Jakarta', true, '2025-08-22 07:05:24.322989+07', '2025-08-22 07:05:24.322989+07');
INSERT INTO public.terminals VALUES (3, 'TSh', 'Terminal Selasa', 'Jakarta', true, '2025-08-22 07:07:47.784857+07', '2025-08-22 07:07:47.784857+07');
INSERT INTO public.terminals VALUES (4, 'TSW', 'Terminal kamis', 'Jakarta', true, '2025-08-22 07:13:37.393492+07', '2025-08-22 07:13:37.393492+07');


--
-- TOC entry 4997 (class 0 OID 16497)
-- Dependencies: 228
-- Data for Name: transactions; Type: TABLE DATA; Schema: public; Owner: postgres
--



--
-- TOC entry 5001 (class 0 OID 16539)
-- Dependencies: 232
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: postgres
--

INSERT INTO public.users VALUES (1, 'Admin', 'admin123', 'admin', true, '2025-08-22 05:48:52.512812+07', '2025-08-22 05:48:52.512812+07');


--
-- TOC entry 5015 (class 0 OID 0)
-- Dependencies: 223
-- Name: cards_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.cards_id_seq', 1, false);


--
-- TOC entry 5016 (class 0 OID 0)
-- Dependencies: 225
-- Name: checkpoint_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.checkpoint_id_seq', 1, false);


--
-- TOC entry 5017 (class 0 OID 0)
-- Dependencies: 219
-- Name: gates_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.gates_id_seq', 1, false);


--
-- TOC entry 5018 (class 0 OID 0)
-- Dependencies: 229
-- Name: sync_queues_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.sync_queues_id_seq', 1, false);


--
-- TOC entry 5019 (class 0 OID 0)
-- Dependencies: 221
-- Name: tarif_destinasi_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.tarif_destinasi_id_seq', 1, false);


--
-- TOC entry 5020 (class 0 OID 0)
-- Dependencies: 217
-- Name: terminals_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.terminals_id_seq', 4, true);


--
-- TOC entry 5021 (class 0 OID 0)
-- Dependencies: 227
-- Name: transactions_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.transactions_id_seq', 1, false);


--
-- TOC entry 5022 (class 0 OID 0)
-- Dependencies: 231
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: postgres
--

SELECT pg_catalog.setval('public.users_id_seq', 1, true);


--
-- TOC entry 4814 (class 2606 OID 16461)
-- Name: cards cards_card_uid_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_card_uid_key UNIQUE (card_uid);


--
-- TOC entry 4816 (class 2606 OID 16459)
-- Name: cards cards_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.cards
    ADD CONSTRAINT cards_pkey PRIMARY KEY (id);


--
-- TOC entry 4818 (class 2606 OID 16470)
-- Name: checkpoint checkpoint_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkpoint
    ADD CONSTRAINT checkpoint_pkey PRIMARY KEY (id);


--
-- TOC entry 4807 (class 2606 OID 16425)
-- Name: gates gates_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gates
    ADD CONSTRAINT gates_pkey PRIMARY KEY (id);


--
-- TOC entry 4824 (class 2606 OID 16532)
-- Name: sync_queues sync_queues_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_queues
    ADD CONSTRAINT sync_queues_pkey PRIMARY KEY (id);


--
-- TOC entry 4810 (class 2606 OID 16441)
-- Name: tarif_destinasi tarif_destinasi_origin_terminal_id_dest_terminal_id_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_destinasi
    ADD CONSTRAINT tarif_destinasi_origin_terminal_id_dest_terminal_id_key UNIQUE (origin_terminal_id, dest_terminal_id);


--
-- TOC entry 4812 (class 2606 OID 16439)
-- Name: tarif_destinasi tarif_destinasi_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_destinasi
    ADD CONSTRAINT tarif_destinasi_pkey PRIMARY KEY (id);


--
-- TOC entry 4803 (class 2606 OID 16416)
-- Name: terminals terminals_code_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terminals
    ADD CONSTRAINT terminals_code_key UNIQUE (code);


--
-- TOC entry 4805 (class 2606 OID 16414)
-- Name: terminals terminals_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.terminals
    ADD CONSTRAINT terminals_pkey PRIMARY KEY (id);


--
-- TOC entry 4820 (class 2606 OID 16505)
-- Name: transactions transactions_card_id_ts_gate_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_card_id_ts_gate_key UNIQUE (card_id, ts_gate);


--
-- TOC entry 4822 (class 2606 OID 16503)
-- Name: transactions transactions_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_pkey PRIMARY KEY (id);


--
-- TOC entry 4826 (class 2606 OID 16548)
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- TOC entry 4828 (class 2606 OID 16550)
-- Name: users users_username_key; Type: CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_username_key UNIQUE (username);


--
-- TOC entry 4808 (class 1259 OID 16431)
-- Name: ux_gates_terminal_code; Type: INDEX; Schema: public; Owner: postgres
--

CREATE UNIQUE INDEX ux_gates_terminal_code ON public.gates USING btree (terminal_id, code);


--
-- TOC entry 4832 (class 2606 OID 16471)
-- Name: checkpoint checkpoint_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkpoint
    ADD CONSTRAINT checkpoint_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- TOC entry 4833 (class 2606 OID 16476)
-- Name: checkpoint checkpoint_checkin_gate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkpoint
    ADD CONSTRAINT checkpoint_checkin_gate_id_fkey FOREIGN KEY (checkin_gate_id) REFERENCES public.gates(id);


--
-- TOC entry 4834 (class 2606 OID 16481)
-- Name: checkpoint checkpoint_checkout_gate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkpoint
    ADD CONSTRAINT checkpoint_checkout_gate_id_fkey FOREIGN KEY (checkout_gate_id) REFERENCES public.gates(id);


--
-- TOC entry 4835 (class 2606 OID 16491)
-- Name: checkpoint checkpoint_dest_terminal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkpoint
    ADD CONSTRAINT checkpoint_dest_terminal_id_fkey FOREIGN KEY (dest_terminal_id) REFERENCES public.terminals(id);


--
-- TOC entry 4836 (class 2606 OID 16486)
-- Name: checkpoint checkpoint_origin_terminal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.checkpoint
    ADD CONSTRAINT checkpoint_origin_terminal_id_fkey FOREIGN KEY (origin_terminal_id) REFERENCES public.terminals(id);


--
-- TOC entry 4829 (class 2606 OID 16426)
-- Name: gates gates_terminal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.gates
    ADD CONSTRAINT gates_terminal_id_fkey FOREIGN KEY (terminal_id) REFERENCES public.terminals(id) ON DELETE CASCADE;


--
-- TOC entry 4840 (class 2606 OID 16533)
-- Name: sync_queues sync_queues_gate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.sync_queues
    ADD CONSTRAINT sync_queues_gate_id_fkey FOREIGN KEY (gate_id) REFERENCES public.gates(id);


--
-- TOC entry 4830 (class 2606 OID 16447)
-- Name: tarif_destinasi tarif_destinasi_dest_terminal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_destinasi
    ADD CONSTRAINT tarif_destinasi_dest_terminal_id_fkey FOREIGN KEY (dest_terminal_id) REFERENCES public.terminals(id);


--
-- TOC entry 4831 (class 2606 OID 16442)
-- Name: tarif_destinasi tarif_destinasi_origin_terminal_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.tarif_destinasi
    ADD CONSTRAINT tarif_destinasi_origin_terminal_id_fkey FOREIGN KEY (origin_terminal_id) REFERENCES public.terminals(id);


--
-- TOC entry 4837 (class 2606 OID 16511)
-- Name: transactions transactions_card_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_card_id_fkey FOREIGN KEY (card_id) REFERENCES public.cards(id);


--
-- TOC entry 4838 (class 2606 OID 16506)
-- Name: transactions transactions_checkpoint_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_checkpoint_id_fkey FOREIGN KEY (checkpoint_id) REFERENCES public.checkpoint(id);


--
-- TOC entry 4839 (class 2606 OID 16516)
-- Name: transactions transactions_gate_id_fkey; Type: FK CONSTRAINT; Schema: public; Owner: postgres
--

ALTER TABLE ONLY public.transactions
    ADD CONSTRAINT transactions_gate_id_fkey FOREIGN KEY (gate_id) REFERENCES public.gates(id);


-- Completed on 2025-08-22 07:54:26

--
-- PostgreSQL database dump complete
--

\unrestrict w03HcXVJRN9MiFBtoHUf2eL5kVoeDHdBxcdAVfQdhEo8T8Tw7mt7VaRITuWQudK


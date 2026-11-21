--
-- PostgreSQL database dump
--

\restrict krTBdrkm3Zvwsi3n7TYchePeT0XmkRYTo5z2y4WDwrXQBOdeDbKkVolgO3haLcH

-- Dumped from database version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)
-- Dumped by pg_dump version 16.15 (Ubuntu 16.15-0ubuntu0.24.04.1)

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
-- Name: attendances; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.attendances (
    id bigint NOT NULL,
    post_id bigint NOT NULL,
    user_id bigint NOT NULL,
    status character varying(255) DEFAULT 'pendiente'::character varying NOT NULL,
    notes character varying(255),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT attendances_status_check CHECK (((status)::text = ANY ((ARRAY['pendiente'::character varying, 'presente'::character varying, 'ausente'::character varying, 'justificada'::character varying])::text[])))
);


--
-- Name: attendances_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.attendances_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: attendances_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.attendances_id_seq OWNED BY public.attendances.id;


--
-- Name: cache; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache (
    key character varying(255) NOT NULL,
    value text NOT NULL,
    expiration integer NOT NULL
);


--
-- Name: cache_locks; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.cache_locks (
    key character varying(255) NOT NULL,
    owner character varying(255) NOT NULL,
    expiration integer NOT NULL
);


--
-- Name: categories; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.categories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    description text,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: categories_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.categories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: categories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.categories_id_seq OWNED BY public.categories.id;


--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.failed_jobs (
    id bigint NOT NULL,
    uuid character varying(255) NOT NULL,
    connection text NOT NULL,
    queue text NOT NULL,
    payload text NOT NULL,
    exception text NOT NULL,
    failed_at timestamp(0) without time zone DEFAULT CURRENT_TIMESTAMP NOT NULL
);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: job_batches; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.job_batches (
    id character varying(255) NOT NULL,
    name character varying(255) NOT NULL,
    total_jobs integer NOT NULL,
    pending_jobs integer NOT NULL,
    failed_jobs integer NOT NULL,
    failed_job_ids text NOT NULL,
    options text,
    cancelled_at integer,
    created_at integer NOT NULL,
    finished_at integer
);


--
-- Name: jobs; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.jobs (
    id bigint NOT NULL,
    queue character varying(255) NOT NULL,
    payload text NOT NULL,
    attempts smallint NOT NULL,
    reserved_at integer,
    available_at integer NOT NULL,
    created_at integer NOT NULL
);


--
-- Name: jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.jobs_id_seq OWNED BY public.jobs.id;


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- Name: post_images; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_images (
    id bigint NOT NULL,
    post_id bigint NOT NULL,
    user_id bigint,
    path character varying(255) NOT NULL,
    caption character varying(255),
    type character varying(255) DEFAULT 'galeria'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: post_images_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.post_images_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: post_images_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.post_images_id_seq OWNED BY public.post_images.id;


--
-- Name: post_user; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.post_user (
    post_id bigint NOT NULL,
    user_id bigint NOT NULL
);


--
-- Name: posts; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.posts (
    id bigint NOT NULL,
    user_id bigint NOT NULL,
    category_id bigint NOT NULL,
    title character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    activity_date date NOT NULL,
    content text NOT NULL,
    reflection text,
    main_image character varying(255),
    status character varying(255) DEFAULT 'borrador'::character varying NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    CONSTRAINT posts_status_check CHECK (((status)::text = ANY ((ARRAY['borrador'::character varying, 'publicado'::character varying])::text[])))
);


--
-- Name: posts_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.posts_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: posts_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.posts_id_seq OWNED BY public.posts.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


--
-- Name: users; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.users (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


--
-- Name: users_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.users_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- Name: users_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.users_id_seq OWNED BY public.users.id;


--
-- Name: attendances id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendances ALTER COLUMN id SET DEFAULT nextval('public.attendances_id_seq'::regclass);


--
-- Name: categories id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories ALTER COLUMN id SET DEFAULT nextval('public.categories_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs ALTER COLUMN id SET DEFAULT nextval('public.jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: post_images id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_images ALTER COLUMN id SET DEFAULT nextval('public.post_images_id_seq'::regclass);


--
-- Name: posts id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts ALTER COLUMN id SET DEFAULT nextval('public.posts_id_seq'::regclass);


--
-- Name: users id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users ALTER COLUMN id SET DEFAULT nextval('public.users_id_seq'::regclass);


--
-- Data for Name: attendances; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.attendances (id, post_id, user_id, status, notes, created_at, updated_at) FROM stdin;
2	1	2	presente	\N	2026-11-16 22:31:26	2026-11-16 22:37:49
1	1	1	presente	\N	2026-11-16 22:31:26	2026-11-16 22:37:49
4	2	2	presente	\N	2026-11-16 22:31:26	2026-11-17 15:37:55
3	2	1	presente	\N	2026-11-16 22:31:26	2026-11-17 15:37:55
5	3	1	presente	\N	2026-11-16 22:31:26	2026-11-17 22:34:20
6	3	2	presente	\N	2026-11-16 22:31:26	2026-11-17 22:34:20
7	4	1	presente	\N	2026-11-16 22:31:26	2026-11-18 14:16:32
8	4	2	presente	\N	2026-11-16 22:31:26	2026-11-18 14:16:32
21	11	1	presente	\N	2026-11-18 18:17:37	2026-11-18 18:17:37
22	11	2	presente	\N	2026-11-18 18:17:37	2026-11-18 18:17:37
9	5	1	presente	\N	2026-11-16 22:31:26	2026-11-19 01:55:31
10	5	2	presente	\N	2026-11-16 22:31:26	2026-11-19 01:55:31
11	6	1	presente	\N	2026-11-16 22:31:26	2026-11-19 02:03:27
12	6	2	presente	\N	2026-11-16 22:31:26	2026-11-19 02:03:27
23	12	1	presente	\N	2026-11-20 23:19:45	2026-11-20 23:19:45
24	12	2	presente	\N	2026-11-20 23:19:45	2026-11-20 23:19:45
13	7	1	presente	\N	2026-11-16 22:31:26	2026-11-20 23:22:16
14	7	2	presente	\N	2026-11-16 22:31:26	2026-11-20 23:22:16
25	13	1	presente	\N	2026-11-20 23:28:22	2026-11-20 23:28:22
26	13	2	presente	\N	2026-11-20 23:28:22	2026-11-20 23:28:22
27	14	1	presente	\N	2026-11-20 23:32:54	2026-11-20 23:32:54
28	14	2	presente	\N	2026-11-20 23:32:54	2026-11-20 23:32:54
31	16	1	presente	\N	2026-11-20 23:39:46	2026-11-20 23:39:46
32	16	2	presente	\N	2026-11-20 23:39:46	2026-11-20 23:39:46
33	17	1	presente	\N	2026-11-20 23:44:52	2026-11-20 23:44:52
34	17	2	presente	\N	2026-11-20 23:44:52	2026-11-20 23:44:52
15	8	1	presente	\N	2026-11-16 22:31:26	2026-11-20 23:48:35
16	8	2	presente	\N	2026-11-16 22:31:26	2026-11-20 23:48:35
17	9	1	presente	\N	2026-11-16 22:31:26	2026-11-20 23:55:14
18	9	2	presente	\N	2026-11-16 22:31:26	2026-11-20 23:55:14
19	10	1	presente	\N	2026-11-16 22:31:26	2026-11-20 23:59:13
20	10	2	presente	\N	2026-11-16 22:31:26	2026-11-20 23:59:13
\.


--
-- Data for Name: cache; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache (key, value, expiration) FROM stdin;
\.


--
-- Data for Name: cache_locks; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.cache_locks (key, owner, expiration) FROM stdin;
\.


--
-- Data for Name: categories; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.categories (id, name, slug, description, created_at, updated_at) FROM stdin;
1	Inauguración	inauguracion	Ceremonia de apertura de la Semana de Sistemas 2026.	2026-11-16 22:31:26	2026-11-16 22:31:26
2	Ponencias	ponencias	Charlas y conferencias de expositores.	2026-11-16 22:31:26	2026-11-16 22:31:26
3	Talleres	talleres	Talleres prácticos de herramientas tecnológicas.	2026-11-16 22:31:26	2026-11-16 22:31:26
4	Bingo	bingo	Dinámica de bingo.	2026-11-16 22:31:26	2026-11-16 22:31:26
5	Feria de proyectos	feria-de-proyectos	Expo Systems: proyectos estudiantiles e innovación.	2026-11-16 22:31:26	2026-11-16 22:31:26
6	Comelona de pizza	comelona-de-pizza	Convivencia con pizza.	2026-11-16 22:31:26	2026-11-16 22:31:26
7	Torneo de fútbol sala	torneo-de-futbol-sala	Torneo deportivo.	2026-11-16 22:31:26	2026-11-16 22:31:26
8	Parrillada	parrillada	Convivencia de cierre.	2026-11-16 22:31:26	2026-11-16 22:31:26
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: job_batches; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.job_batches (id, name, total_jobs, pending_jobs, failed_jobs, failed_job_ids, options, cancelled_at, created_at, finished_at) FROM stdin;
\.


--
-- Data for Name: jobs; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.jobs (id, queue, payload, attempts, reserved_at, available_at, created_at) FROM stdin;
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	0001_01_01_000000_create_users_table	1
2	0001_01_01_000001_create_cache_table	1
3	0001_01_01_000002_create_jobs_table	1
4	2026_11_16_000001_create_categories_table	1
5	2026_11_16_000002_create_posts_table	1
6	2026_11_16_000003_create_attendances_table	1
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: post_images; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.post_images (id, post_id, user_id, path, caption, type, created_at, updated_at) FROM stdin;
1	1	1	posts/galeria/8brcXcdMljilScfjtWjfbfuyyMcNxiXB97nCSZJt.jpg	Evidencia de asistencia en la inauguración	evidencia	2026-11-16 22:37:49	2026-11-16 22:37:49
2	1	1	posts/galeria/ol9RK8ip5cxbIBsTaVyfBGXiIR1kTUmVJ4udGfL7.jpg	Evidencia de asistencia en la inauguración	evidencia	2026-11-16 22:37:49	2026-11-16 22:37:49
3	2	\N	posts/galeria/o9Bll4WPF4J9TJ0HfAFa0XFhWAIpb2VOfsCpAYNp.jpg	\N	galeria	2026-11-17 15:44:37	2026-11-17 15:44:37
4	2	\N	posts/galeria/7BMDUyt6xaO3ccXlrLOvd0CU32e5Rrio823Xdpoy.jpg	\N	galeria	2026-11-17 15:44:37	2026-11-17 15:44:37
5	2	\N	posts/galeria/TGCCVdXxBKvQDWTMuiRKNc3vxW05QNFjpmkHpQZm.jpg	\N	galeria	2026-11-17 15:44:37	2026-11-17 15:44:37
6	2	\N	posts/galeria/ZQjdMvbqY6BE6GdLI4My0DTzYjTXwpqrkqToeueF.jpg	\N	galeria	2026-11-17 15:44:37	2026-11-17 15:44:37
7	2	\N	posts/galeria/vq86bgtl3E3TzoZCOhcOBFR67ic1TMfzZyQZ3ipO.jpg	nuestra asistencia a la ponencia#1  (foto de ambos)	evidencia	2026-11-17 15:47:09	2026-11-17 15:47:09
8	2	1	posts/galeria/9D2MADSj0Tur47PCaTF11gcDd2HFmH2yHMcHAxwo.png	\N	galeria	2026-11-17 22:29:35	2026-11-17 22:29:35
9	2	1	posts/galeria/UvMQi8D3ZP4K1C4EBxTQrfKa6LpmxmMEyr4maH2z.png	\N	galeria	2026-11-17 22:29:35	2026-11-17 22:29:35
10	2	1	posts/galeria/eLxDuYzJk4RPWaPFLSHqnEFd2Yp3mY8EPatACXUT.png	\N	galeria	2026-11-17 22:29:35	2026-11-17 22:29:35
11	3	2	posts/galeria/1ZQiFIddDTsjGmQf1hiCqB2tzTSkf1IN5EecB4wu.png	\N	evidencia	2026-11-17 22:34:20	2026-11-17 22:34:20
12	3	1	posts/galeria/dtFxUiCsYU0yIiKsb0FGZkcWAV9oQQGjLgVNqf3O.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-17 22:37:59	2026-11-17 22:37:59
13	3	1	posts/galeria/S9M4JaSA8F6p29D02HaDjD913ByRhVt75HWPtiWK.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-17 22:37:59	2026-11-17 22:37:59
14	3	1	posts/galeria/NJX2B0zihvZBgdBbQndAbeERajS4ZNunlDNL8wjU.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-17 22:37:59	2026-11-17 22:37:59
15	3	1	posts/galeria/DvJWjni9PGs6dyfdjjtArKBaNKlRjplVjfldr5Sx.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-17 22:37:59	2026-11-17 22:37:59
16	3	1	posts/galeria/XavrKESifwHEbPdtDURdjYwvjebCrr5iT30wcwEH.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-17 22:37:59	2026-11-17 22:37:59
17	1	2	posts/galeria/EEZBJJIuNePWp1970zMBN1LVmwYZdq0yzZm3dQf9.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:08:13	2026-11-18 14:08:13
18	1	2	posts/galeria/967fq7uddEAwiV8io1orqXuMYcIOsNCBwdEM6iLd.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:08:13	2026-11-18 14:08:13
19	1	2	posts/galeria/px4IPKLHqMILJ8nW62VSpGNtu96kMkWQhuuKnFP2.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:08:13	2026-11-18 14:08:13
20	1	2	posts/galeria/xdsCMpQzm1xRXgVchxpeU31budaTMRzpviNSyx8q.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:08:13	2026-11-18 14:08:13
21	1	2	posts/galeria/c26wuBw1nQ7v49t3Zw0Qglwg9EEZzqLwZQchA6Tt.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:08:13	2026-11-18 14:08:13
22	2	2	posts/galeria/Q7MxuvnHTmtbh24dHgnaRtR1wMoSTSFYl6ukmHKT.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:11:36	2026-11-18 14:11:36
23	2	2	posts/galeria/PkxA3QpUbW3beihwmY7susQYxZAiilSvV3eorqSJ.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:11:36	2026-11-18 14:11:36
24	2	2	posts/galeria/ULy708EwqISx96AT4l42z1UXQWHFayvtaaginfcO.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:11:36	2026-11-18 14:11:36
25	2	2	posts/galeria/I8esXypYclQgvA6eWh0PrmGapZau0H15beagifoo.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:11:36	2026-11-18 14:11:36
26	3	2	posts/galeria/82Z8P3DukU1BY4rrAYXTnZYEauHppE7ZQUO9cMnj.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:13:02	2026-11-18 14:13:02
27	3	2	posts/galeria/PpiRcEbnlAjQFfcbtV872hL8L4FzmlBqn2MsbagP.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:13:02	2026-11-18 14:13:02
28	3	2	posts/galeria/lFWmgRwUcRnGSu6iCtZyQ8sOvgS9ZfyKKqkdYD91.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:13:02	2026-11-18 14:13:02
29	3	2	posts/galeria/lQsumJ71JvOCDGqDFtkQDwufSkb98xJ3zMSaX4Ex.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:13:02	2026-11-18 14:13:02
30	4	2	posts/galeria/FiIOh1hYGcyjy5Rpl0YngrIc2Zpl5apiuBrp8bUL.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:16:32	2026-11-18 14:16:32
31	4	2	posts/galeria/8gIa756jQC9LyW8rrP6U6N7uV2WSkxPXPaEufhN3.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:16:32	2026-11-18 14:16:32
32	4	2	posts/galeria/rzQiiyHXu3UT1MhHzEw9Ubbh9pOngRR9SqH5jnUK.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:16:32	2026-11-18 14:16:32
33	4	2	posts/galeria/pdtDT4RKuXmgaqundpUxuA4QYYEMjkiea9dUd1l0.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-18 14:16:32	2026-11-18 14:16:32
34	4	1	posts/galeria/RebGKWjhdAumAXtb4zUcXbVQwlyvQEmi9RbicADt.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-18 14:18:16	2026-11-18 14:18:16
35	4	1	posts/galeria/xIyBe9D8w10lCAtfla5zujvjHdQjpThsM8VJTZ6j.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-18 14:18:16	2026-11-18 14:18:16
36	4	1	posts/galeria/Ob9CKcbvCg7uM7nP3JPVQXZLw3RUf2vzXTpnKp1n.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-18 14:18:16	2026-11-18 14:18:16
37	4	1	posts/galeria/dyMxckZr0YIntDco3zu47imZ7igsE9YcMZJYaqG4.png	Evidencia de Jeferson sobre la ponencia	galeria	2026-11-18 14:18:16	2026-11-18 14:18:16
38	4	1	posts/galeria/UZF5OEmRQR41L06ZCUdp4bNcC5ZRWVmF5XzcaCx5.png	Evidencia de Jeferson sobre la asistencia a las ponencias del dia 2	evidencia	2026-11-18 14:18:52	2026-11-18 14:18:52
39	11	\N	posts/galeria/v7mHuhCSBxsg6rrkjPEEB09to8Lc9iSvD7F4vEzd.png	Evidencia de Víctor y Jeferson sobre la ponencia	galeria	2026-11-18 18:17:37	2026-11-18 18:17:37
40	11	\N	posts/galeria/fyqP2xu9SJiZh4Y5FBpaOZd7JzwZWF3GuCKpS1Q9.png	Evidencia de Víctor y Jeferson sobre la ponencia	galeria	2026-11-18 18:17:37	2026-11-18 18:17:37
41	11	\N	posts/galeria/TGo53XblZhDXYnjjUoPMW0e1rATUvKfgFzwGmxyD.png	Evidencia de Víctor y Jeferson sobre la ponencia	galeria	2026-11-18 18:17:37	2026-11-18 18:17:37
42	11	2	posts/galeria/YGal4lM7h9EM5xSoNoiRrY8fBpNVom5YTtmau78z.png	Evidencia de Jeferson sobre la demo hecha en la ponencia	galeria	2026-11-18 18:18:30	2026-11-18 18:18:30
43	11	2	posts/galeria/LYeIrTNRJOyjOiwwbREXTcowbXM4xGj8eUqB4E2B.png	Evidencia de Víctor sobre demo realizada en la ponencia	galeria	2026-11-18 18:19:38	2026-11-18 18:19:38
44	5	2	posts/galeria/krWpqIBh0SKmausz81p6eOFToBk1eswKc3pMOh7U.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-19 01:55:31	2026-11-19 01:55:31
45	5	2	posts/galeria/FSXsRxBZQIaFKH4VhPjZDiSZAhJSxEgnjH5XJMZS.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-19 01:55:31	2026-11-19 01:55:31
46	5	2	posts/galeria/qBnNJYCeH8V4WjBLj3Ku0bQctboI2UYqYevIdzui.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-19 01:55:31	2026-11-19 01:55:31
47	5	2	posts/galeria/UrnNwPl9N8P4jxwGTF7U5pXshmNjcHx0ik7np5ma.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-19 01:55:31	2026-11-19 01:55:31
48	5	2	posts/galeria/hYjkv6LynID2L21jbGDp9Lihaaf7mcGR0U6wjeWw.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-19 01:55:31	2026-11-19 01:55:31
49	5	2	posts/galeria/GkralkR1rzbOBUpuHvwjhLrNnGpdqV4ZxWGGgHoO.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-19 01:55:31	2026-11-19 01:55:31
50	5	2	posts/galeria/PCzmrONIvchw4v8r8ELpBM9ql2IKHfRMCXFvo2DV.png	Evidencia de Víctor sobre la ponencia	galeria	2026-11-19 01:55:31	2026-11-19 01:55:31
51	5	1	posts/galeria/Yo1KWXGaUD56jvRlhVu4aRTVg5IDfQRbJ5wYiYqS.png	Evidencia de Jeferson sobre la ponencia/taller	galeria	2026-11-19 01:56:30	2026-11-19 01:56:30
52	5	1	posts/galeria/HmxsbF3c3JUBXfAZDogQuovIxbXUgNwMNQad7eaK.png	Evidencia de Jeferson sobre la ponencia/taller	galeria	2026-11-19 01:56:30	2026-11-19 01:56:30
53	5	1	posts/galeria/o8ffM50rtJq2NcqexR0kVqPFXKAB2AjB25KiSt7v.png	Evidencia de Jeferson sobre la ponencia/taller	galeria	2026-11-19 01:56:30	2026-11-19 01:56:30
54	6	1	posts/galeria/dUxGjxTJnKLClTpp2Lsn8cWDRWSDwy2fztKISXJD.png	asistencia al bingo	evidencia	2026-11-19 02:03:27	2026-11-19 02:03:27
58	6	1	posts/galeria/5YlIWnSrHTdaO6QJgqjO9yDORH1bvZraucxO3fsH.png	Evidencia de Jeferson sobre el bingo	galeria	2026-11-19 02:05:20	2026-11-19 02:05:20
59	6	1	posts/galeria/m0UByqFqV6UorOgcjtZvBuz9ieiapUZf0XaoAXUI.png	Evidencia de Jeferson sobre el bingo	galeria	2026-11-19 02:05:20	2026-11-19 02:05:20
60	6	1	posts/galeria/Xzcd91yA72LRoAlJgMM0Kg7JdDONlESAbUZgOzFK.png	Evidencia de Jeferson sobre el bingo	galeria	2026-11-19 02:05:20	2026-11-19 02:05:20
61	6	2	posts/galeria/7IYYKpQ3NHh86OXv2Bnq0swXARIoR1CSIFDmRytW.png	Evidencia de Víctor sobre el bingo y su participacion	galeria	2026-11-19 02:05:41	2026-11-19 02:05:41
62	6	2	posts/galeria/VTv8RqsUJlYf45HpwP3wj3WoSTw4XdGq99YaNqqg.png	Evidencia de Víctor sobre el bingo y su participacion	galeria	2026-11-19 02:05:41	2026-11-19 02:05:41
63	6	2	posts/galeria/vFGFGBCNwGP87lwvtNwbt7yBYBvXLxCNMLawfkk0.png	Evidencia de Víctor sobre el bingo y su participacion	galeria	2026-11-19 02:05:41	2026-11-19 02:05:41
64	6	2	posts/galeria/R9CSeYIXCkf1c0L4LfN0k02gN4hd9YYmtWotpkWL.png	Evidencia de Víctor sobre el bingo y su participacion	galeria	2026-11-19 02:05:41	2026-11-19 02:05:41
65	12	\N	posts/galeria/qSvKsONDVA7yEbh3NjBBLpWRelZazgFAsxI0SigS.png	Evidencia de nuestra colaboración y viaje	galeria	2026-11-20 23:19:45	2026-11-20 23:19:45
66	12	\N	posts/galeria/oPPNePWJYsiQvwL8JvzR8JFT6u4u6rSiu9ZHh7k2.png	Evidencia de nuestra colaboración y viaje	galeria	2026-11-20 23:19:45	2026-11-20 23:19:45
67	12	\N	posts/galeria/qjwxqZ5SvxKSFVj6TiK8VJKuuvSFWKjNHFxxSKnN.png	Evidencia de nuestra colaboración y viaje	galeria	2026-11-20 23:19:45	2026-11-20 23:19:45
68	7	1	posts/galeria/q3AnRSoK7HUgPN938Q7jVOPzKwf4JOyksVj6bMwp.png	Evidencia de asistencia en la inauguración de expo system	galeria	2026-11-20 23:22:16	2026-11-20 23:22:16
69	13	2	posts/galeria/sXNRqgbptf9evT2AVnRrFM1C4FywLvmgpqtpQYWW.png	Evidencia de Victor sobre el proyecto Card collector	galeria	2026-11-20 23:28:22	2026-11-20 23:28:22
70	13	2	posts/galeria/VwoDCgEWypUgoE8Aa0MqO6bqkdmQ0fJeD6NdG11k.png	Evidencia de Victor sobre el proyecto Card collector	galeria	2026-11-20 23:28:22	2026-11-20 23:28:22
71	13	2	posts/galeria/UMdKzMbt4dkyALYLkqQynTxIihylTLGGf0ZYjKv1.png	Evidencia de Victor sobre el proyecto Card collector	galeria	2026-11-20 23:28:22	2026-11-20 23:28:22
72	13	2	posts/galeria/fy30ViWAImrqnad604aep7KpFZoSyFT1IDyrvfml.png	Evidencia de Victor sobre el proyecto Card collector	galeria	2026-11-20 23:28:22	2026-11-20 23:28:22
73	14	2	posts/galeria/GAvqoBCZrclu1Zo6dQxAPekj0Ppd8tPbphQUmzjE.png	Evidencia de Víctor sobre el proyecto BASTA	galeria	2026-11-20 23:32:54	2026-11-20 23:32:54
74	14	2	posts/galeria/1aufx0D23Hqfphl5T0XW28yxXKNxT5M4Xkywe6vK.png	Evidencia de Víctor sobre el proyecto BASTA	galeria	2026-11-20 23:32:54	2026-11-20 23:32:54
75	14	2	posts/galeria/atespJyb6GaxFNBLUHWrhHsCIBrBGw83Y51dCAKg.png	Evidencia de Víctor sobre el proyecto BASTA	galeria	2026-11-20 23:32:54	2026-11-20 23:32:54
80	16	2	posts/galeria/BooeLHHUaHfWcd9QCrXLk7lrFAmrQf2GD7cwU7LP.png	Evidencia de Víctor sobre el proyecto #3	galeria	2026-11-20 23:39:46	2026-11-20 23:39:46
81	16	2	posts/galeria/iy8zhpG4RibOX8zrfTiymzB1IEKxKeO66SjbTLAh.png	Evidencia de Víctor sobre el proyecto #3	galeria	2026-11-20 23:39:46	2026-11-20 23:39:46
82	17	2	posts/galeria/BcZGmZqvQjiKIdZdxSg8VR1Lwv85u0kA2cyzweFL.png	Evidencia de Víctor sobre el proyecto	galeria	2026-11-20 23:44:52	2026-11-20 23:44:52
83	8	\N	posts/galeria/O5qfQK1DPCKnU8YkQgwDsY9xqGWvpFP69YZeCbm7.png	Evidencia de ambos en la comelona de pizza	galeria	2026-11-20 23:48:35	2026-11-20 23:48:35
84	8	\N	posts/galeria/F0LIyaOpYUmXWuIIf6iqaVTDj0ABBFM9ShTsNTX4.png	Evidencia de ambos en la comelona de pizza	galeria	2026-11-20 23:48:35	2026-11-20 23:48:35
85	8	\N	posts/galeria/hsUP9yihaQ9zNTgQWjLsGasM0ZqgJvK9FElsaTQ8.png	Evidencia de ambos en la comelona de pizza	galeria	2026-11-20 23:48:35	2026-11-20 23:48:35
86	8	\N	posts/galeria/QVeqSwfuJ5xUrZFCDvnwDRv6htX3nmo9T31HF6PA.png	Evidencia de ambos en la comelona de pizza	galeria	2026-11-20 23:48:35	2026-11-20 23:48:35
87	9	\N	posts/galeria/MdRUsmiPDzgYdnn9YOB5lukFzKbhjvFt2k0xT8Pd.png	Evidencia del apoyo como espectador de ambos integrantes	galeria	2026-11-20 23:55:14	2026-11-20 23:55:14
88	9	\N	posts/galeria/M3uavLNA5bARhvjuJtcwxB1vgaYnPOl2Xr4HrAKM.png	Evidencia del apoyo como espectador de ambos integrantes	galeria	2026-11-20 23:55:14	2026-11-20 23:55:14
89	9	\N	posts/galeria/5rpOOxAA0eHm6uxC7zqZBVyRDjJJkapwe69AiNIQ.png	Evidencia del apoyo como espectador de ambos integrantes	galeria	2026-11-20 23:55:14	2026-11-20 23:55:14
90	9	\N	posts/galeria/QzNx2aWgnzuiMq9wfjxwcjhfbd575a7Pk55QQshJ.png	Evidencia del apoyo como espectador de ambos integrantes	galeria	2026-11-20 23:55:14	2026-11-20 23:55:14
91	9	\N	posts/galeria/eeDdgUr2HDLFR2Gn8dOR29xsVUHulInApJDiL42E.png	Evidencia del apoyo como espectador de ambos integrantes	galeria	2026-11-20 23:55:14	2026-11-20 23:55:14
92	9	\N	posts/galeria/9gBeVQ98RiiLhDZPSABHZCXNoivTBpXaLOnsgLBy.png	Evidencia del apoyo como espectador de ambos integrantes	galeria	2026-11-20 23:55:14	2026-11-20 23:55:14
93	10	\N	posts/galeria/FA4oXdnmfFGluRqJyrkCsuguW8PbyZtuoneZF8xq.png	Evidencia de Jeferson y Victor sobre la carne asada	galeria	2026-11-20 23:59:13	2026-11-20 23:59:13
94	10	\N	posts/galeria/DxkP49gQTfvQF8sCNCocBiSrzIST4UMTvK2CRcx1.png	Evidencia de Jeferson y Victor sobre la carne asada	galeria	2026-11-20 23:59:13	2026-11-20 23:59:13
95	10	\N	posts/galeria/AejweBHCuMFAtRdpylamt6BBkfh23R2W2GOaw7B2.png	Evidencia de Jeferson y Victor sobre la carne asada	galeria	2026-11-20 23:59:13	2026-11-20 23:59:13
96	10	\N	posts/galeria/nM8gPGDhe71H6QIJQO9d48QGz6D1Q9Qw67gvZojq.png	Evidencia de Jeferson y Victor sobre la carne asada	galeria	2026-11-20 23:59:13	2026-11-20 23:59:13
97	10	\N	posts/galeria/7m9WRQMn66sGgA4oJ7emE1iS1z9HQcvVwFqUM5Ci.png	Evidencia de Jeferson y Victor sobre la carne asada	galeria	2026-11-20 23:59:13	2026-11-20 23:59:13
\.


--
-- Data for Name: post_user; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.post_user (post_id, user_id) FROM stdin;
1	1
1	2
2	1
2	2
3	1
3	2
4	1
4	2
5	1
5	2
6	1
6	2
7	1
7	2
8	1
8	2
9	1
9	2
10	1
10	2
11	1
11	2
12	1
13	1
13	2
14	1
14	2
16	1
16	2
17	1
17	2
\.


--
-- Data for Name: posts; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.posts (id, user_id, category_id, title, slug, activity_date, content, reflection, main_image, status, created_at, updated_at) FROM stdin;
12	1	5	Asistencia y ayuda para traer los canopis que se usaran en la feria de sistemas	asistencia-y-ayuda-para-traer-los-canopis-que-se-usaran-en-la-feria-de-sistemas-cmtqu	2026-11-18	Ambos estudiantes, tanto Jeferson Constanza y Víctor Gonzales, fuimos ayudantes de ir atraer los canopis por 8va calle oriente y cerca de la univo, que fueron usados para él día jueves de la feria de sistemas y proyectos	Como estudiantes tenemos la fuerza de hacer lo que nos propongan si nos unimos y colaboramos juntos.	posts/JR4op1l4XyqhlmUKLGj18EBDlfazL6sPVJtecoWS.png	publicado	2026-11-20 23:19:45	2026-11-20 23:19:45
4	1	2	Ponencia 3: Eficiencia energética, optimización de recursos y sostenibilidad aplicada a soluciones tecnológicas	ponencia-3-eficiencia-energetica-optimizacion-de-recursos-y-sostenibilidad-aplicada-a-soluciones-tecnologicas-vl41o	2026-11-17	Lugar: Auditorio 1, 8:00 a. m - 10: 00 a.m.\r\nTema: Eficiencia energética, optimización de recursos y sostenibilidad aplicada a soluciones tecnológicas (Automatización de aires acondicionados mediante IoT, BACnet e IA).\r\n\r\nExpositor: Lic. Nahum Sánchez.\r\n\r\nIdeas centrales: El alcance real del IoT industrial más allá de las placas básicas, la arquitectura de comunicación mediante protocolos abiertos como BACnet y la evolución desde la simple medición hasta la predicción con Inteligencia Artificial.\r\n\r\nAprendizajes:\r\n\r\nIoT más allá de Arduino: Comprendimos que el Internet de las Cosas abarca equipos industriales reales como aires acondicionados, medidores, bombas y luminarias, operando bajo un ciclo claro de tres pasos: Mide (sensores), Comunica (gateways y protocolos) y Decide y actúa (software y actuadores).\r\n\r\nCómo hablan las máquinas (Modbus vs. BACnet): Aprendimos la diferencia clave entre protocolos industriales; mientras que Modbus entrega datos crudos en registros numéricos que requieren un manual para interpretarse, BACnet ofrece objetos con nombre, tipo y unidades autoexplicativas (como Temp. zona 2 = 24.5 °C), funcionando como un lenguaje intermedio estándar donde el gateway actúa como un intérprete en tiempo real (similar al JIT en .NET).\r\n\r\nDe medir a predecir (La escalera de inteligencia): Analizamos cómo escalar un sistema de control pasando por tres niveles: 1) Estadística simple (promedios y gráficos por zona), 2) Machine Learning (predicción y detección de anomalías) y 3) Modelos de lenguaje para ejecutar órdenes en lenguaje natural.\r\n\r\nControl centralizado y ahorro real: Vimos en práctica cómo una aplicación desarrollada en .NET permite gestionar horarios de encendido, fijar límites de temperatura, monitorear zonas en tiempo real, recibir alertas de fallas y asegurar el apagado en fines de semana, logrando el mismo confort con muchas menos horas de operación	Esta ponencia tiende un puente sumamente práctico entre la teoría de la programación que vemos en clase y la ingeniería aplicada al mundo real. Entender que un gateway funciona bajo la misma lógica de un intérprete en tiempo real o que integrar sistemas mediante estándares abiertos como BACnet evita quedar atado al idioma privado de cada fabricante cambia por completo nuestra perspectiva como desarrolladores. Al final, la verdadera sostenibilidad tecnológica el Green IoT no consiste en sacrificar la comodidad de las personas, sino en usar software inteligente, protocolos adecuados e IA para eliminar el desperdicio invisible de energía.	posts/cRjnsn0UOqsoJMLUa94RPJeNNOa6g5g5kARusEbu.png	publicado	2026-11-16 22:31:26	2026-11-18 18:28:10
3	1	2	Ponencia 2: Energías alternativas y eficiencia energética	ponencia-2-energias-alternativas-y-eficiencia-energetica-1808c	2026-11-16	Lugar: Auditorio 1, 1:00 p. m - 4:00pm. \r\nTema: Energías alternativas y eficiencia energética.\r\nExpositor: Dr. Carlos Osmin Pocasangre Jiménez.\r\nIdeas centrales: La importancia de medir para gestionar el consumo energético, los beneficios de la eco-eficiencia, el contexto de la matriz eléctrica nacional y las nuevas apuestas tecnológicas limpias.\r\nAprendizajes: \r\nMedir para gestionar: Partiendo de la premisa del filósofo William Pepperell Montague ("Lo que no se puede medir, no se puede gestionar"), entendimos que cualquier estrategia de ahorro energético comienza por monitorear y cuantificar el consumo real.\r\n\r\nEl impacto integral de la eficiencia energética: Implementar soluciones eco-energéticas no solo reduce la factura eléctrica, sino que mejora el confort y la calidad de vida, resulta amigable con el medio ambiente, es sostenible en el tiempo y se alinea directamente con los Objetivos de Desarrollo Sostenible (ODS).\r\n\r\nBuenas prácticas vs. improvisación: A través de ejemplos cotidianos (e incluso humorísticos), vimos cómo una mala instalación o soluciones improvisadas en climatización disparan el desperdicio energético, demostrando que la técnica y el diseño correcto son indispensables.\r\n\r\nEl panorama energético de El Salvador: Revisamos datos oficiales de generación eléctrica (SIGET) junto con las tendencias y proyectos emergentes en el país, desde soluciones descentralizadas de aprovechamiento orgánico (como los biodigestores domésticos Homebiogas) hasta estudios de gran escala sobre generación de hidrógeno verde y energía nuclear	Esta segunda ponencia nos recuerda que la sostenibilidad y la transición energética no son conceptos lejanos ni exclusivos de las grandes plantas generadoras; empiezan por la cultura de la medición y el uso inteligente de la energía en nuestros propios espacios. Mientras el país explora horizontes ambiciosos como el hidrógeno verde, el biogás o la energía nuclear, nuestro rol como profesionales y ciudadanos es cerrar la brecha entre el derroche cotidiano y la eficiencia real, entendiendo que cada kilovatio bien gestionado impacta tanto en la economía como en el futuro ambiental.	posts/VeThFdaKrJNfveys6dGWY4W1augBx3MZHXJpevJv.png	publicado	2026-11-16 22:31:26	2026-11-17 22:42:11
5	1	3	Taller: Sostenibilidad digital y análisis energético mediante Electricity Map	taller-sostenibilidad-digital-y-analisis-energetico-mediante-electricity-map-k4xom	2026-11-17	Lugar: Auditorio 1,  1:00 p. m. - 4:00 p. m. \r\n\r\nExpositor: Br. Josué González \r\n\r\nHerramientas: Plataforma web Electricity Maps (visualización global de intensidad de carbono y mezcla eléctrica en tiempo real) y Electricity Lab (entorno web creado por el expositor para consumir la API de Electricity Maps mediante API Keys, con secciones de Playground, tutoriales y casos prácticos).   \r\n\r\nProcedimiento: La sesión se desarrolló con un formato expositivo-demostrativo. Primero, se exploró la interfaz de Electricity Maps para entender cómo se miden y visualizan indicadores clave como la intensidad de carbono ($\\text{gCO}_2\\text{eq/kWh}$), la mezcla eléctrica, el porcentaje de energía renovable y el potencial eólico en distintas regiones del mundo (incluyendo ejemplos aplicados a El Salvador). Posteriormente, se presentó la arquitectura de la plataforma Electricity Lab, explicando cómo realizar peticiones GET a los endpoints de la API (como /v4/carbon-intensity/latest) para obtener respuestas en formato JSON y automatizar cálculos de emisiones.\r\n \r\n Práctica: Se revisó la estructura de la sección Práctica Green IoT dentro de Electricity Lab —diseñada para resolver casos de estimación de emisiones de equipos eléctricos en 35 minutos— y el funcionamiento del Playground API. Aunque la demostración se centró en recorrer la herramienta y explicar cómo consumir los datos de forma teórica-visual sin ejecutar un ejercicio guiado paso a paso en vivo, quedó habilitado el entorno para realizar consultas y pruebas por cuenta propia.   \r\n\r\nResultados: Comprensión del flujo de extracción y análisis de datos energéticos en tiempo real mediante APIs abiertas, identificando cómo consultar la huella de carbono de la red eléctrica de El Salvador y otros países para fundamentar proyectos de Green IoT y sostenibilidad digital.	Este taller me permitió aterrizar el concepto de sostenibilidad digital desde una perspectiva técnica y medible. Muchas veces asumimos que el impacto ambiental de la tecnología es intangible, pero herramientas como Electricity Maps y su API demuestran que cada kilovatio hora consumido por nuestros sistemas tiene una huella de carbono concreta que varía según la hora y la matriz energética del país. Contar con plataformas como Electricity Lab facilita enormemente que como estudiantes de informática podamos integrar conciencia ecológica en nuestros desarrollos —por ejemplo, programando tareas pesadas o procesos IoT en horarios de menor intensidad de carbono—, demostrando que la eficiencia energética también se construye desde el código y el análisis de datos	posts/pZXpcdTt3HiRguWGO2fVqRQg5zmunS5TtZULgTD6.png	publicado	2026-11-16 22:31:26	2026-11-19 01:57:49
1	1	1	Inauguración de la Semana de Sistemas 2026	inauguracion-de-la-semana-de-sistemas-2026-0hv5u	2026-11-16	Lugar: Auditorio 1, 8:00 a. m - 10:00 a. m.\r\nInauguración de la semana de sistemas, presentación de la mesa de honores, sus discurso y actividades de el estudiante Adán Quevedo	\N	posts/7ZqCuN0RNAguWXAkufrN5sj7n7eb6dkt84xyY50G.png	publicado	2026-11-16 22:31:26	2026-11-18 14:09:11
2	1	2	Ponencia 1: Investigación aplicada en IoT para la agricultura en El Salvador	ponencia-1-investigacion-aplicada-en-iot-para-la-agricultura-en-el-salvador-avsmi	2026-11-16	Lugar: Auditorio 1, 10:00 a. m - 12:00 pm.\r\nTema: Del internet de las Cosas a la investigación aplicada.\r\nExpositor: Otoniel Flores-Cortez\r\nIdeas centrales: ¿Qué es realmente el IOT?, ¿Paso para llegar del prototipo a la evidencia?\r\nAprendizajes:\r\nRedefiniendo el IoT: Comprendimos que el Internet de las Cosas no es solo conectar aparatos por moda o ensamblar hardware funcional, sino estructurar una arquitectura de 5 capas (Percepción, Nodo/Edge, Red, Plataforma y Aplicación) pensada para convertir fenómenos físicos en evidencia científica y datos trazables. \r\n\r\nEl problema de la brecha tecnológica agrícola: Analizamos el contexto salvadoreño, donde operar a ciegas o con un monitoreo discontinuo (como visitas semanales) genera datos incompletos y lleva a los productores a tomar decisiones basadas enteramente en la intuición empírica y la alta vulnerabilidad climática.   \r\n\r\nLa ruta crítica de la investigación: Descubrimos que el hardware construido es solo el punto de partida. La verdadera investigación aplicada exige una ruta de 5 pasos: 1) Requisitos, 2) Prototipo (diseño e implementación), 3) Verificación en laboratorio, 4) Validación de aptitud en campo, y 5) Evaluación en contexto.   \r\n\r\nElección de tecnología con criterio: Aprendimos que la selección de conectividad (Wi-Fi, Bluetooth/BLE, LoRa/LPWAN o Celular) no debe dictarse por la popularidad comercial, sino por el análisis comparativo del alcance, tasa de datos, consumo energético y la topografía real del terreno	Esta ponencia nos deja una gran lección: la verdadera contribución universitaria y tecnológica no consiste únicamente en fabricar un prototipo que funcione en un escritorio, sino en producir conocimiento verificable. Investigar para comprender y desarrollar para transformar. El reto real radica en alinear la instrumentación estrictamente a la realidad del fenómeno, asegurando validación metrológica y resiliencia local (como arquitecturas store-and-forward) para pasar de la intuición empírica a la certeza respaldada por evidencia continua.	posts/wFt3oDA0JONQTC6aTf0E2rXTDjMd4PyZR47yl0eI.jpg	publicado	2026-11-16 22:31:26	2026-11-17 22:29:34
11	1	2	Ponencia 4: Cyberseguridad	ponencia-4-cyberseguridad-ejwx0	2026-11-17	Lugar: Auditorio 1. 10:00 a.m. - 12:00 a. m.\r\n\r\nTema: Ciberseguridad, nuevos riesgos de la Inteligencia Artificial y simulación interactiva de un ciberataque (ESET El Salvador).\r\n\r\nExpositor: \r\n\r\nIdeas centrales: La brecha entre la rápida adopción de la IA y su gobernanza, los riesgos emergentes en seguridad informática, buenas prácticas de protección digital y una demostración práctica de cómo ocurre una intrusión en tiempo real.\r\n\r\nAprendizajes:\r\n\r\nLa IA avanza más rápido que la gobernanza: Respaldados con datos del 2025 Data Breach Investigations Report de Verizon Business, vimos cómo el uso de IA personal sin control supera ampliamente a las soluciones integradas y reguladas (70 % frente a 15 % respectivamente), creando puntos ciegos y filtraciones de datos en entornos académicos y empresariales.\r\n\r\nNuevos vectores de riesgo con la IA: La Inteligencia Artificial no solo optimiza procesos, también introduce amenazas inéditas que obligan a replantear la seguridad de la información y la privacidad de los datos que compartimos con estas herramientas.\r\n\r\nDemo en vivo de un ataque cibernético en tiempo real: Participamos en una simulación interactiva liderada por ESET El Salvador donde analizamos el paso a paso de un ataque en curso (escaneo de red, puertos abiertos, búsqueda de credenciales expuestas en repositorios de GitHub y secuestro de sesión), votando desde nuestros dispositivos para identificar correos de phishing frente a alertas legítimas y decidir si el ataque lograba avanzar.\r\n\r\nContraseñas que sí aguantan (Higiene digital): Analizamos por qué las claves tradicionales basadas en datos personales (como el nombre de una mascota más un año, reutilizadas en la universidad, el correo y GitHub, y guardadas sin protección en el navegador) son extremadamente vulnerables, aprendiendo a migrar hacia frases de paso largas y memorables (como pupusas-lunes-volcan-7), gestores de contraseñas y verificación en dos pasos o passkeys	Esta ponencia nos deja una advertencia muy clara, reforzada por la experiencia práctica de la simulación en vivo: el eslabón más crítico de la ciberseguridad sigue siendo el factor humano, especialmente ahora que adoptamos herramientas de Inteligencia Artificial a un ritmo vertiginoso sin detenernos a evaluar los riesgos de privacidad y gobernanza. Ver en tiempo real cómo un descuido cotidiano —como dejar una clave expuesta en un proyecto viejo de GitHub, reutilizar contraseñas débiles o caer en un correo engañoso— le abre la puerta completa a un atacante demuestra que la seguridad no depende solo de sistemas complejos. Desarrollar pensamiento crítico frente a cada enlace o alerta y mantener una higiene digital rigurosa es nuestra mejor línea de defensa	posts/IM510iDdjxP8y45g5zwWF4ZscEqHF1hUxCU8HzYQ.png	publicado	2026-11-18 18:17:37	2026-11-18 18:23:36
6	1	4	Bingo	bingo-0kmbi	2026-11-18	Lugar: Auditorio 1, desde las 8:00 a. m.\r\nDinámica:  4año de la carrera presentaron un juego de bingo web\r\nExperiencia:  Un juego muy divertido donde apostabas por premios\r\nParticipación: \r\nJuegos de bingo y actividades para ganar premios.	La experiencia de un programado como los de 4año puede llenar un auditorio de felicidad y diversiones como lo es algo sencillo como un juego de bingo.	posts/KKm65SuzZbiBs6PSNIklbRJkS1v3TAcWSm7qvbzg.png	publicado	2026-11-16 22:31:26	2026-11-19 02:05:53
7	1	5	Expo Systems: feria de proyectos inaguracion	expo-systems-feria-de-proyectos-jj8zj	2026-11-19	Lugar: Plaza Minerva, 8:00 a. m 12 : 00 p .m.\r\nProyectos visitados: 4 proyectos visados que se publicaran en los siguientes post individualmente	\N	posts/95e1lNxRWLEYbUiDdiJ2IBYNn5D0EcYKTHLVukC3.png	publicado	2026-11-16 22:31:26	2026-11-20 23:22:16
8	1	6	Comelona de pizza	comelona-de-pizza-ysxsv	2026-11-19	Lugar: Plaza Minerva, 12:00 p. m.\r\nDesarrollo: 5 participantes, 1 premio\r\nConvivencia: Toda la carrera se unió para apoyar al Ing. Guandique\r\nExperiencia: Divertido ver como los concursantes daban todo de ellos mismo para igualmente perder contra el Ing. Guandique por segundo año consecutivo, con un récord de caja de pizza en 7 minutos	\N	posts/jY0bAtQIW6rEPsAsfAeDMPAGB2vvPVUed5GO5dui.png	publicado	2026-11-16 22:31:26	2026-11-20 23:48:35
13	1	5	Proyecto #1 : Card Collector	proyecto-1-card-collector-gds1l	2026-11-19	Titulo: Card collector (proyecto del integrante Jeferson Constanza)\r\nTecnologías: HTML, JS, CS Y ASTRO\r\nIdea central del proyecto : Tener una web donde puedas ver resultados en vivo, tablas de clasificaciones de los equipos que sigas, colección de figuritas, ver partidos en vivo y jugar minijuegos de manera local o multijugador p2p.	La creatividad de un futbolero y programador puede hacer muchas cosas para el mejorar el deporte y la diciplina	posts/igAyF8vRwq19odO6pjhPQmhf6oiHhwg5E6PsWHQM.png	publicado	2026-11-20 23:28:22	2026-11-20 23:28:22
14	1	5	Proyecto #2 : BASTA	proyecto-2-basta-lfqc4	2026-11-19	Nombre del proyecto: BASTA\r\nEstudiantes: de 4año de la carrera\r\nTecnología usadas: programación de dispositivos móviles con el lenguaje de programación JAVA\r\nEste proyecto es una aplicación movil inspirada en el tradicional juego Bachillerato Stop.\r\n\r\nConsiste en poner a prueba tu vocabulario, rapides de pensamiento  y la capacidad de recordar palabras \r\n\r\nConsiste en elegir una letra del abecedario y completar una serie de categorias que comienzan con esa letra.\r\n\r\nCasa jugador intenta completar todas las categorias antes que los demas\r\nEl primero en completarlas  presiona BASTA \r\nSe comparan las respuestas \r\nLas respuestas validas y no repetidas reciben mayor puntaje \r\nAl final gana quien acumule mas puntos	Un programador puede hacer aplicaciones para la diversión y entretenimiento de la gente, lo que llena de satisfacción el resultado e ideas realizada	posts/Ei1NzxnvxlT27F58nnfQoHtKFOeTUmym9xOmd7VU.png	publicado	2026-11-20 23:32:54	2026-11-20 23:32:54
16	1	5	Proyecto #3 Sistema de velocímetro inteligente para bicicletas	proyecto-3-sistema-de-velocimetro-inteligente-para-bicicletas-aka94	2026-11-19	Nombre del proyecto: sistema de velocimetro inteligente para bicicleta\r\nEstudiante: Manuel Alejandro Solano Guzman\r\nTecnologías e innovación: Este proyecto, clasificado en la categoría libre, consiste en un prototipo físico instalado directamente sobre una bicicleta. Tecnológicamente, el circuito integra un sensor "Hall magnético KY-003", un sensor "Hall lineal KY-024", un sensor de "Mercurio KY-017" y "2 imanes", los cuales están cableados a una unidad de control montada en el manubrio. Para procesar los datos de estos sensores y darle la lógica al proyecto, se utilizó el entorno de desarrollo Arduino IDE. La innovación principal de este sistema es su capacidad de monitoreo integral, ya que no solo mide velocidad, sino que también registra la cadencia de pedaleo y detecta caídas, aportando una función de seguridad para el usuario.	La inteligencia de un programador no solo es código, también circuitos e ideas que revolucionan nuestro país	posts/YawwabeYqqkjL29aNcfU7UaBv6ekyj2uaSKmK1bv.png	publicado	2026-11-20 23:39:46	2026-11-20 23:42:30
17	1	5	Proyecto #4 Sistema de monitor Solar	proyecto-4-sistema-de-monitor-solar-8wmv0	2026-11-19	Nombre del proyecto: sistema de monitor solar\r\nTecnologías e innovación: Este proyecto está enfocado en el área de "Energía". Tecnológicamente, el sistema utiliza un "Sensor de voltaje", un "Sensor de balancín" y un "Panel solar pequeño", los cuales están integrados a un microcontrolador(programado mediante Arduino IDE para definir la lógica del sistema) y una protoboard mediante cables de conexión. La innovación de este prototipo radica en su propósito funcional, ya que mide voltaje generado según inclinación del panel, lo que permite analizar físicamente cómo la posición angular afecta la eficiencia en la captación de energía.	Como ingenieros, podemos aprovechar la naturaleza y medio ambiente para usarlos en nuestros proyectos y enfocarlos a la tematica IOT	posts/j34P0RfeOs4uRolkkO0LIYq611d7kOzyQkjkglyh.png	publicado	2026-11-20 23:44:52	2026-11-20 23:49:24
9	1	7	Torneo de fútbol sala	torneo-de-futbol-sala-xckul	2026-11-20	Lugar: Cancha de futsal, 8:00 a. m.\r\nDesarrollo: Torneo donde 7 equipos disputaron partidos para ver el campeón\r\nEquipos: Junta directiva, Manchester Rojo, Legion 7, Token FC, Jeffrey y sus amigos, Industriales, Dockercompose.yml\r\nParticipación (jugador o espectador): Espectador\r\nGanador del torneo : Jeffrey y sus amigos	La di versión y convivencia que se vive en el futbol traspasa carreras y nos une a todos como personas y hermanos que somos.	posts/5fNHqnKaVbQMG3wvz5VSspdccRGoqKUJY7gRcjmM.png	publicado	2026-11-16 22:31:26	2026-11-20 23:55:14
10	1	8	Parrillada	parrillada-rnjww	2026-11-20	Lugar: Alrededores de la cancha, 12:00 p. m.\r\nDescripción: Carne asada al aire libre\r\nConvivencia: Reunión y almuerzo con un plato de carne hecho por el Ing. Diego y alumnos de 4año	Para finalizar el evento y la semana de sistemas, la convivencia traspasa las ocupaciones de cada uno como ver al Ing. Diego cocinar y estar todos juntos unidos en el almuerzo	posts/ZldgUa13XpTeQESWcKc8JmEVZPQggj7JBgyaPtyk.png	publicado	2026-11-16 22:31:26	2026-11-20 23:59:13
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
F7KBDzkdJDbBJyCxFjm7yKNbaQlZG8vglJBxYYGh	1	127.0.0.1	Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/158.0.0.0 Safari/537.36	YTo1OntzOjY6Il90b2tlbiI7czo0MDoiODZVeHc4blpLdmxFakVmSkxweDNRRnlQNFd1RUkxdmVzWUhVSHRWViI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9lbnRyYWRhcyI7czo1OiJyb3V0ZSI7czoxMDoiYmxvZy5pbmRleCI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czoxNzoicGFzc3dvcmRfaGFzaF93ZWIiO3M6NjQ6IjgwODYxMjMyZGU2NGQxYTU2OWExMGM1YjYzZjBkNzMxNTI0NzFiMDFjMmNjNTNmMmEwMDk1N2JjZGJkMDY3NGMiO30=	1795219156
345b7eArEwquCygJruU2EbYTkm1pY6KiE9xBFprm	\N	127.0.0.1	Wget/1.21.4	YToyOntzOjY6Il90b2tlbiI7czo0MDoiVk9KQ29ETFFhVkpoNTJwQTc1d2ZTcFFkRlRjVkpsaVg2c29JVFNxdiI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1795219294
Ny7pcYb539REx4j5OIcUc5AwehaOQN5y0LyNiwEx	\N	127.0.0.1	Wget/1.21.4	YToyOntzOjY6Il90b2tlbiI7czo0MDoiWkJtRU1MSGdFVFNyUDdzZHNLYzJUdWNtWXprV01uczVac0NtWldZQSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319fQ==	1795219294
GsmDpyJsJUEKbx8qJFwkqOqyjptzWzDkWX1AmbtA	\N	127.0.0.1	Wget/1.21.4	YTozOntzOjY6Il90b2tlbiI7czo0MDoib2hCWHVIZFhRSGJsQlVQdWZ3a09lbGxZalpZRVNyb1hBM29TTzZZUyI7czo5OiJfcHJldmlvdXMiO2E6Mjp7czozOiJ1cmwiO3M6Mzc6Imh0dHA6Ly8xMjcuMC4wLjE6ODAwMC9lbnRyYWRhcz9wYWdlPTEiO3M6NToicm91dGUiO3M6MTA6ImJsb2cuaW5kZXgiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1795219296
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

COPY public.users (id, name, email, email_verified_at, password, remember_token, created_at, updated_at) FROM stdin;
1	cq22003	cq22003@ues.edu.sv	\N	$2y$12$Sxy7VXq6CnIqFzypk.9r/ecjyJGXB40jfTYR1.8y/eT8520hngHb6	\N	2026-11-16 22:31:26	2026-11-17 22:08:17
2	gb23003	gb23003@ues.edu.sv	\N	$2y$12$/j6GmyMTX53RXaC4XlPQ6uUoFApsmwmotQTijD3gCrfcKXlELEflG	\N	2026-11-16 22:31:26	2026-11-17 22:13:42
\.


--
-- Name: attendances_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.attendances_id_seq', 34, true);


--
-- Name: categories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.categories_id_seq', 8, true);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 6, true);


--
-- Name: post_images_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.post_images_id_seq', 97, true);


--
-- Name: posts_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.posts_id_seq', 17, true);


--
-- Name: users_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.users_id_seq', 2, true);


--
-- Name: attendances attendances_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_pkey PRIMARY KEY (id);


--
-- Name: attendances attendances_post_id_user_id_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_post_id_user_id_unique UNIQUE (post_id, user_id);


--
-- Name: cache_locks cache_locks_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache_locks
    ADD CONSTRAINT cache_locks_pkey PRIMARY KEY (key);


--
-- Name: cache cache_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.cache
    ADD CONSTRAINT cache_pkey PRIMARY KEY (key);


--
-- Name: categories categories_name_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_name_unique UNIQUE (name);


--
-- Name: categories categories_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_pkey PRIMARY KEY (id);


--
-- Name: categories categories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.categories
    ADD CONSTRAINT categories_slug_unique UNIQUE (slug);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: job_batches job_batches_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.job_batches
    ADD CONSTRAINT job_batches_pkey PRIMARY KEY (id);


--
-- Name: jobs jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.jobs
    ADD CONSTRAINT jobs_pkey PRIMARY KEY (id);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: post_images post_images_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_images
    ADD CONSTRAINT post_images_pkey PRIMARY KEY (id);


--
-- Name: post_user post_user_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_user
    ADD CONSTRAINT post_user_pkey PRIMARY KEY (post_id, user_id);


--
-- Name: posts posts_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_pkey PRIMARY KEY (id);


--
-- Name: posts posts_slug_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_slug_unique UNIQUE (slug);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users users_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_pkey PRIMARY KEY (id);


--
-- Name: cache_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_expiration_index ON public.cache USING btree (expiration);


--
-- Name: cache_locks_expiration_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX cache_locks_expiration_index ON public.cache_locks USING btree (expiration);


--
-- Name: jobs_queue_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX jobs_queue_index ON public.jobs USING btree (queue);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: attendances attendances_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: attendances attendances_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.attendances
    ADD CONSTRAINT attendances_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: post_images post_images_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_images
    ADD CONSTRAINT post_images_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: post_images post_images_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_images
    ADD CONSTRAINT post_images_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE SET NULL;


--
-- Name: post_user post_user_post_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_user
    ADD CONSTRAINT post_user_post_id_foreign FOREIGN KEY (post_id) REFERENCES public.posts(id) ON DELETE CASCADE;


--
-- Name: post_user post_user_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.post_user
    ADD CONSTRAINT post_user_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- Name: posts posts_category_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_category_id_foreign FOREIGN KEY (category_id) REFERENCES public.categories(id) ON DELETE RESTRICT;


--
-- Name: posts posts_user_id_foreign; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.posts
    ADD CONSTRAINT posts_user_id_foreign FOREIGN KEY (user_id) REFERENCES public.users(id) ON DELETE CASCADE;


--
-- PostgreSQL database dump complete
--

\unrestrict krTBdrkm3Zvwsi3n7TYchePeT0XmkRYTo5z2y4WDwrXQBOdeDbKkVolgO3haLcH


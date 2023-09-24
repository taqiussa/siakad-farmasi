--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

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

--
-- Name: uuid-ossp; Type: EXTENSION; Schema: -; Owner: -
--

CREATE EXTENSION IF NOT EXISTS "uuid-ossp" WITH SCHEMA public;


--
-- Name: EXTENSION "uuid-ossp"; Type: COMMENT; Schema: -; Owner: 
--

COMMENT ON EXTENSION "uuid-ossp" IS 'generate universally unique identifiers (UUIDs)';


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- Name: bookcategories; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.bookcategories (
    id bigint NOT NULL,
    name character varying(255) NOT NULL,
    slug character varying(255) NOT NULL,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.bookcategories OWNER TO dhananghadiyanto;

--
-- Name: bookcategories_id_seq; Type: SEQUENCE; Schema: public; Owner: dhananghadiyanto
--

CREATE SEQUENCE public.bookcategories_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.bookcategories_id_seq OWNER TO dhananghadiyanto;

--
-- Name: bookcategories_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dhananghadiyanto
--

ALTER SEQUENCE public.bookcategories_id_seq OWNED BY public.bookcategories.id;


--
-- Name: books_sequence; Type: SEQUENCE; Schema: public; Owner: dhananghadiyanto
--

CREATE SEQUENCE public.books_sequence
    START WITH 2
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.books_sequence OWNER TO dhananghadiyanto;

--
-- Name: failed_jobs; Type: TABLE; Schema: public; Owner: dhananghadiyanto
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


ALTER TABLE public.failed_jobs OWNER TO dhananghadiyanto;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: dhananghadiyanto
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.failed_jobs_id_seq OWNER TO dhananghadiyanto;

--
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dhananghadiyanto
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- Name: group_akses; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.group_akses (
    id_group_akses uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_master_group uuid NOT NULL,
    id_master_aplikasi uuid NOT NULL,
    id_master_modul uuid NOT NULL,
    akses boolean DEFAULT true
);


ALTER TABLE public.group_akses OWNER TO dhananghadiyanto;

--
-- Name: master_aplikasi; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.master_aplikasi (
    id_master_aplikasi uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_aplikasi character varying,
    deskripsi character varying,
    versi_aplikasi character varying,
    status_data character varying,
    tgl_version date,
    url character varying,
    image character varying
);


ALTER TABLE public.master_aplikasi OWNER TO dhananghadiyanto;

--
-- Name: master_group; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.master_group (
    id_master_group uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_master_aplikasi uuid NOT NULL,
    nama_group character varying NOT NULL,
    deskripsi character varying
);


ALTER TABLE public.master_group OWNER TO dhananghadiyanto;

--
-- Name: master_menu; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.master_menu (
    id_master_menu uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_menu character varying NOT NULL,
    deskripsi character varying,
    "order" integer,
    id_master_aplikasi uuid NOT NULL,
    icon character varying
);


ALTER TABLE public.master_menu OWNER TO dhananghadiyanto;

--
-- Name: master_modul; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.master_modul (
    id_master_modul uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_master_menu uuid NOT NULL,
    "order" integer,
    nama_modul character varying NOT NULL,
    path character varying NOT NULL,
    deskripsi character varying,
    id_master_aplikasi uuid NOT NULL,
    status_data character varying NOT NULL,
    icon character varying
);


ALTER TABLE public.master_modul OWNER TO dhananghadiyanto;

--
-- Name: COLUMN master_modul.status_data; Type: COMMENT; Schema: public; Owner: dhananghadiyanto
--

COMMENT ON COLUMN public.master_modul.status_data IS 'aktif, tidak aktif';


--
-- Name: migrations; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


ALTER TABLE public.migrations OWNER TO dhananghadiyanto;

--
-- Name: migrations_id_seq; Type: SEQUENCE; Schema: public; Owner: dhananghadiyanto
--

CREATE SEQUENCE public.migrations_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.migrations_id_seq OWNER TO dhananghadiyanto;

--
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dhananghadiyanto
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_reset_tokens OWNER TO dhananghadiyanto;

--
-- Name: password_resets; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


ALTER TABLE public.password_resets OWNER TO dhananghadiyanto;

--
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.personal_access_tokens (
    id bigint NOT NULL,
    tokenable_type character varying(255) NOT NULL,
    tokenable_id bigint NOT NULL,
    name character varying(255) NOT NULL,
    token character varying(64) NOT NULL,
    abilities text,
    last_used_at timestamp(0) without time zone,
    expires_at timestamp(0) without time zone,
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone
);


ALTER TABLE public.personal_access_tokens OWNER TO dhananghadiyanto;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: dhananghadiyanto
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.personal_access_tokens_id_seq OWNER TO dhananghadiyanto;

--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: dhananghadiyanto
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- Name: sessions; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.sessions (
    id character varying(255) NOT NULL,
    user_id bigint,
    ip_address character varying(45),
    user_agent text,
    payload text NOT NULL,
    last_activity integer NOT NULL
);


ALTER TABLE public.sessions OWNER TO dhananghadiyanto;

--
-- Name: trans_user_group; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.trans_user_group (
    id_trans_user_group uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_user uuid NOT NULL,
    id_master_aplikasi uuid NOT NULL,
    id_master_group uuid NOT NULL,
    status_data character varying
);


ALTER TABLE public.trans_user_group OWNER TO dhananghadiyanto;

--
-- Name: users_sequence; Type: SEQUENCE; Schema: public; Owner: dhananghadiyanto
--

CREATE SEQUENCE public.users_sequence
    START WITH 2
    INCREMENT BY 2
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


ALTER TABLE public.users_sequence OWNER TO dhananghadiyanto;

--
-- Name: users; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.users (
    name character varying(255) NOT NULL,
    email character varying(255) NOT NULL,
    email_verified_at timestamp(0) without time zone,
    password character varying(255) NOT NULL,
    remember_token character varying(100),
    created_at timestamp(0) without time zone,
    updated_at timestamp(0) without time zone,
    username character varying,
    id_user uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    person_id uuid,
    id integer DEFAULT nextval('public.users_sequence'::regclass),
    image character varying DEFAULT 'avatar.png'::character varying,
    status_data character varying
);


ALTER TABLE public.users OWNER TO dhananghadiyanto;

--
-- Name: COLUMN users.status_data; Type: COMMENT; Schema: public; Owner: dhananghadiyanto
--

COMMENT ON COLUMN public.users.status_data IS 'aktif dan tidak aktif';


--
-- Name: users_2; Type: TABLE; Schema: public; Owner: dhananghadiyanto
--

CREATE TABLE public.users_2 (
    usersid uuid[] NOT NULL,
    username character varying NOT NULL,
    password character varying NOT NULL,
    email character varying,
    name character varying,
    last_update timestamp without time zone[],
    image character varying,
    status boolean,
    personid uuid[]
);


ALTER TABLE public.users_2 OWNER TO dhananghadiyanto;

--
-- Name: bookcategories id; Type: DEFAULT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.bookcategories ALTER COLUMN id SET DEFAULT nextval('public.bookcategories_id_seq'::regclass);


--
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- Data for Name: bookcategories; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.bookcategories (id, name, slug, created_at, updated_at) FROM stdin;
2	buku	bukud	\N	\N
\.


--
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.failed_jobs (id, uuid, connection, queue, payload, exception, failed_at) FROM stdin;
\.


--
-- Data for Name: group_akses; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.group_akses (id_group_akses, id_master_group, id_master_aplikasi, id_master_modul, akses) FROM stdin;
8359ff03-cb98-4cd5-8cba-6a28bdff1539	49a32cff-34ac-42c9-8432-72b178db99a9	6d920eeb-5be8-4346-a6cd-edcd26c95780	1acdb62c-86bf-429e-aae7-2ae71cc86b91	t
2dde2f98-ff36-44d2-bedd-83050f33bc3d	49a32cff-34ac-42c9-8432-72b178db99a9	6d920eeb-5be8-4346-a6cd-edcd26c95780	ff65a686-0202-4758-b6be-9099277b3f2d	t
b2ee1935-cc9d-4185-a9c8-cf35d7ede516	49a32cff-34ac-42c9-8432-72b178db99a9	6d920eeb-5be8-4346-a6cd-edcd26c95780	5baf6af9-9dee-4b5f-bd11-fb3b0d70ec19	t
5e3cc1f1-f9c3-492f-ba82-8acf34a1c5c3	49a32cff-34ac-42c9-8432-72b178db99a9	6d920eeb-5be8-4346-a6cd-edcd26c95780	6d351744-1992-4ed5-aade-73c794642abb	t
f50ec51b-ccfe-4001-85e8-47ee0432551c	49a32cff-34ac-42c9-8432-72b178db99a9	6d920eeb-5be8-4346-a6cd-edcd26c95780	73ad6297-2a4d-4d92-8452-77ef62135b74	t
15b664d4-d91f-4fd5-ab20-868455d70b37	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	247053bb-3072-4f29-aa45-1772ca7e1a6e	t
403768f1-aaf6-42ab-874d-a69e668256b3	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	f225ac92-37b8-401c-8a6e-e362d2657d1f	t
2765bef0-4828-4268-a1af-2d0f250d05cb	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	0610c1ea-1ce9-49ec-bafa-1a539d10c648	t
a9ca6254-1c47-4468-b3f3-e0c511b97e21	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	1469839b-b537-4f03-94d1-b8ce32be79d3	t
092f3f12-b31c-4956-8ba8-af549a4b48ef	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	18f3e1a0-fe13-48d7-a410-bc908ff38769	t
f3c3cacc-e95d-446c-a965-573231f2b2d9	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	f0ab95f3-c42c-487e-a005-5ac1d32a93de	t
e2f755e2-8e09-4291-84f2-2c1075f591be	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	fc0d6624-b8b1-4150-a7cc-e6b18d4c29f1	t
34ffc16e-a3d8-4c11-8f4f-363479c5b2cf	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	6a734913-01e0-4f6f-9dc0-6a952e77329f	t
a03735a9-5dd1-4d6b-aab2-6289511da7e5	a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	2cdb147a-8d0d-4259-a4e3-843e2dd0184d	t
\.


--
-- Data for Name: master_aplikasi; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.master_aplikasi (id_master_aplikasi, nama_aplikasi, deskripsi, versi_aplikasi, status_data, tgl_version, url, image) FROM stdin;
6d920eeb-5be8-4346-a6cd-edcd26c95780	SSO	Single Sign On	2.0	aktif	2023-03-22	http://127.0.0.1:8000/edit_master_aplikasi/6d920eeb-5be8-4346-a6cd-edcd26c95780	1679529740.png
ed9f0135-6f63-422c-a42a-fbc14e261900	SIA farmasi	SIstem akademik farmasi	2.0	aktif	2023-03-22	http://127.0.0.1:8000/add_master_aplikasi	1679496468.png
\.


--
-- Data for Name: master_group; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.master_group (id_master_group, id_master_aplikasi, nama_group, deskripsi) FROM stdin;
a643ec4b-3937-414b-a0da-9aa558ec00c0	ed9f0135-6f63-422c-a42a-fbc14e261900	Administrator	Pengguna Administrator
49a32cff-34ac-42c9-8432-72b178db99a9	6d920eeb-5be8-4346-a6cd-edcd26c95780	Administrator	Pengguna Administrator
9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47	6d920eeb-5be8-4346-a6cd-edcd26c95780	User	Pengguna User
\.


--
-- Data for Name: master_menu; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.master_menu (id_master_menu, nama_menu, deskripsi, "order", id_master_aplikasi, icon) FROM stdin;
4706192a-bca5-4e15-a22b-043ac3e5f920	tes	asdasd	2	ed9f0135-6f63-422c-a42a-fbc14e261900	fa fa-hourglass-3
0d312507-524d-49fe-9e5a-2f28c8ac3824	Manajemen Pengguna	Master Manajemen Pengguna	2	ed9f0135-6f63-422c-a42a-fbc14e261900	fa fa-users
18476952-90c5-42bd-ad9a-6002ed6d87b7	Manajemen Pengguna	Master Manajemen Pengguna	2	6d920eeb-5be8-4346-a6cd-edcd26c95780	fa fa-street-view
cf56b85c-784e-49c3-ad54-446792bdd831	Master	Master Menu	1	ed9f0135-6f63-422c-a42a-fbc14e261900	fa fa-home
006d6c9e-151d-4c8a-9c35-846017b7271c	Akun	Akun	1	6d920eeb-5be8-4346-a6cd-edcd26c95780	fa fa-users
bf507bfd-f42a-4591-bdba-f2d3b87a755e	Kurikulum	Kurikulum	2	ed9f0135-6f63-422c-a42a-fbc14e261900	fa fa-bank
1d05ee48-d583-4916-b620-1761fce60e27	Pembayaran	Master Pembayaran	3	ed9f0135-6f63-422c-a42a-fbc14e261900	fa fa-dollar
8b5e2031-f5c3-4b7b-9f20-eed88d9c982b	Rencana Studi	Master Rencana Studi	4	ed9f0135-6f63-422c-a42a-fbc14e261900	fa fa-balance-scale
\.


--
-- Data for Name: master_modul; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.master_modul (id_master_modul, id_master_menu, "order", nama_modul, path, deskripsi, id_master_aplikasi, status_data, icon) FROM stdin;
0df007ce-ab39-4485-ac73-061dc239e607	4706192a-bca5-4e15-a22b-043ac3e5f920	2	adsas	asda	adsa	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-hourglass-3
1acdb62c-86bf-429e-aae7-2ae71cc86b91	006d6c9e-151d-4c8a-9c35-846017b7271c	1	Profile	profile	Profile Pengguna	6d920eeb-5be8-4346-a6cd-edcd26c95780	aktif	fa fa-user
ff65a686-0202-4758-b6be-9099277b3f2d	18476952-90c5-42bd-ad9a-6002ed6d87b7	1	Master Aplikasi	master_aplikasi	Manajemen Aplikasi	6d920eeb-5be8-4346-a6cd-edcd26c95780	aktif	fa fa-space-shuttle
5baf6af9-9dee-4b5f-bd11-fb3b0d70ec19	18476952-90c5-42bd-ad9a-6002ed6d87b7	2	Master Menu	master_menu	Master Manajemen Menu	6d920eeb-5be8-4346-a6cd-edcd26c95780	aktif	fa fa-bars
6d351744-1992-4ed5-aade-73c794642abb	18476952-90c5-42bd-ad9a-6002ed6d87b7	3	Master Grup Akses	master_group	Master Manajemen Group Akses Aplikasi	6d920eeb-5be8-4346-a6cd-edcd26c95780	aktif	fa fa-comments
73ad6297-2a4d-4d92-8452-77ef62135b74	18476952-90c5-42bd-ad9a-6002ed6d87b7	4	Master Pengguna	master_pengguna	Master Manajemen Pengguna	6d920eeb-5be8-4346-a6cd-edcd26c95780	aktif	fa fa-user-secret
247053bb-3072-4f29-aa45-1772ca7e1a6e	cf56b85c-784e-49c3-ad54-446792bdd831	1	Master Biodata Mahasiswa	master_biodata_mahasiswa	Master Biodata Mahasiswa	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-mortar-board
f225ac92-37b8-401c-8a6e-e362d2657d1f	cf56b85c-784e-49c3-ad54-446792bdd831	2	Master Pendidikan Mahasiswa	master_mahasiswa	Master Pendidikan Mahasiswa	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-users
0610c1ea-1ce9-49ec-bafa-1a539d10c648	cf56b85c-784e-49c3-ad54-446792bdd831	3	Master Mata Kuliah	master_matakuliah	Master Matakuliah	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-book
18f3e1a0-fe13-48d7-a410-bc908ff38769	bf507bfd-f42a-4591-bdba-f2d3b87a755e	1	Master Kurikulum	master_kurikulum	Master Kurikulum	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-map
f0ab95f3-c42c-487e-a005-5ac1d32a93de	bf507bfd-f42a-4591-bdba-f2d3b87a755e	2	Master Angkatan Mahasiswa	master_angkatan_mahasiswa	Master Group Angkatan Mahasiswa	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-bug
6a734913-01e0-4f6f-9dc0-6a952e77329f	1d05ee48-d583-4916-b620-1761fce60e27	2	Tagihan Mahasiswa	tagihan_mahasiswa	Tagihan Mahasiswa	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-th-list
fc0d6624-b8b1-4150-a7cc-e6b18d4c29f1	1d05ee48-d583-4916-b620-1761fce60e27	1	Master Kode Pembayaran	master_kode_pembayaran	Master Kode Pembayaran	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-bar-chart
2cdb147a-8d0d-4259-a4e3-843e2dd0184d	8b5e2031-f5c3-4b7b-9f20-eed88d9c982b	1	Waktu KRS	waktu_krs	master waktu krs	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-commenting
c3eb1aa6-5cd8-4185-96b9-ddead17ba1f4	bf507bfd-f42a-4591-bdba-f2d3b87a755e	1	tes	tes	contoh	ed9f0135-6f63-422c-a42a-fbc14e261900	aktif	fa fa-commenting
\.


--
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.migrations (id, migration, batch) FROM stdin;
1	2014_10_12_000000_create_users_table	1
2	2014_10_12_100000_create_password_reset_tokens_table	1
3	2014_10_12_100000_create_password_resets_table	1
4	2019_08_19_000000_create_failed_jobs_table	1
5	2019_12_14_000001_create_personal_access_tokens_table	1
6	2023_02_15_053453_create_bookcategories_table	1
7	2023_04_08_082712_create_sessions_table	2
\.


--
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.password_reset_tokens (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.password_resets (email, token, created_at) FROM stdin;
\.


--
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.personal_access_tokens (id, tokenable_type, tokenable_id, name, token, abilities, last_used_at, expires_at, created_at, updated_at) FROM stdin;
\.


--
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.sessions (id, user_id, ip_address, user_agent, payload, last_activity) FROM stdin;
hlmyApKhtTDXF7EHGNT2USbXuIXoPJmYrPS1yY6r	\N	192.168.240.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoidlFBejdFNlF4M1JZemtVTHBZOTJCUklCekl4NEhQUUNwOVpvNEtkYSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2MzoiaHR0cDovL3NpYS5ha2FkZW1pay5sb2NhbC9tYXN0ZXJfbWFoYXNpc3dhL2FkZF9tYXN0ZXJfbWFoYXNpc3dhIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9zaWEuYWthZGVtaWsubG9jYWwvbWFzdGVyX21haGFzaXN3YS9hZGRfbWFzdGVyX21haGFzaXN3YSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1695524627
XAlgwqVDAAcSVTFY3uIcnbBiCzghUyOIiZFT0rXq	\N	192.168.240.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0	YTo0OntzOjY6Il90b2tlbiI7czo0MDoiSkpybkxGTmtocUhTS0lIaGtidEVqM0t5ZEVPV3h2N1RoYjJBdVk3TyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo5MDoiaHR0cDovL3NpYS5ha2FkZW1pay5sb2NhbC93YWt0dV9rcnMvZGV0YWlsX21hdGFrdWxpYWgvMzc5YjIyZTEtZmM1My00YmI0LWFkYjktYjk0OTgxZGE3NTdmIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6OTA6Imh0dHA6Ly9zaWEuYWthZGVtaWsubG9jYWwvd2FrdHVfa3JzL2RldGFpbF9tYXRha3VsaWFoLzM3OWIyMmUxLWZjNTMtNGJiNC1hZGI5LWI5NDk4MWRhNzU3ZiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=	1695517576
XuDyyIrXmsweiXYXhJ1Gd3UXDoyn4EDH2DiPbQDs	\N	192.168.240.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0	YTozOntzOjY6Il90b2tlbiI7czo0MDoiOTk4eUFkYkNSbHQ1aTkzZzh6Yko2MUh5RXRUdjQ3MzVKa2pjZFo2dyI7czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzE6Imh0dHA6Ly9zaWEuYWthZGVtaWsubG9jYWwvbG9naW4iO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19	1695517577
TXsF30e5QJPZxklyjXhXmHeXzfWg7fmkRiouQ9Gm	1	192.168.240.1	Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0	YTo2OntzOjY6Il90b2tlbiI7czo0MDoiNXAzd0Jld3JyWXhiRDYyR1FUZkk5MFlHcU1xRzlTVVJHUTlGcjZWbyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjYzOiJodHRwOi8vc2lhLmFrYWRlbWlrLmxvY2FsL21hc3Rlcl9tYWhhc2lzd2EvYWRkX21hc3Rlcl9tYWhhc2lzd2EiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTY5NTUxNzU1NTt9fQ==	1695524652
\.


--
-- Data for Name: trans_user_group; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.trans_user_group (id_trans_user_group, id_user, id_master_aplikasi, id_master_group, status_data) FROM stdin;
c9d9f7f6-0995-43d4-bf57-ce117d3e659f	953fd07b-11a2-45a1-8ae5-87a408001afd	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Aktif
dc2f70b5-8569-4a03-870e-eedb26e81937	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
51c8380c-a975-4e1b-8eb8-8a1abcd5ba4a	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Aktif
c76e8668-1506-4ddb-812a-927fb6271ec3	113cfdf7-ed7f-425e-8bbc-b093206d9917	ed9f0135-6f63-422c-a42a-fbc14e261900	a643ec4b-3937-414b-a0da-9aa558ec00c0	Aktif
fb11c63b-94f2-4af5-bbce-27b220a893ce	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
c4e2117b-70bd-4c0a-809b-0ea1508f2ab6	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
90cc0382-ca17-4f53-a8e8-489b91acb587	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
d805cc43-889b-4fc9-96fb-8bacf9f1c1d5	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
07fd58ac-1adc-489d-9681-390e520f03ec	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
0892b240-1331-47be-963c-a95eb3efeeff	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
36bc3be5-8718-4c44-8bbc-640a05eb3268	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
27703a93-9ddb-41de-8e64-fc214131dd99	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
a741129a-12ad-472e-a516-18df3bfc80ae	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47	Tidak Aktif
7292f5ff-0dac-437c-80bf-e79aee9e334f	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47	Tidak Aktif
50a85e2c-3b7a-4170-b252-28e498f60e39	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
e3a023be-54a2-4c74-b280-7f19a3e126d3	113cfdf7-ed7f-425e-8bbc-b093206d9917	6d920eeb-5be8-4346-a6cd-edcd26c95780	49a32cff-34ac-42c9-8432-72b178db99a9	Tidak Aktif
\.


--
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.users (name, email, email_verified_at, password, remember_token, created_at, updated_at, username, id_user, person_id, id, image, status_data) FROM stdin;
dhanang	dhanang@gmail.com	\N	$2y$10$CtFtf/x9tGDGxYpjRM5eFOUv4E6xDX1PBxl/qBDMZ/eU/JNhAA0CC	\N	2023-03-18 02:27:53	2023-03-18 02:27:53	dhanang2112	113cfdf7-ed7f-425e-8bbc-b093206d9917	063f25d7-2513-405a-ba2a-50cc60b2714a	1	avatar.png	aktif
\.


--
-- Data for Name: users_2; Type: TABLE DATA; Schema: public; Owner: dhananghadiyanto
--

COPY public.users_2 (usersid, username, password, email, name, last_update, image, status, personid) FROM stdin;
{280e5189-0fca-4a2a-9dcf-d15da4d4c5c0}	dhanang2112	123456	dhanang.hadiyanto@gmail.com	dhanang hadiyanto	\N	\N	t	{280e5189-0fca-4a2a-9dcf-d15da4d4c5c0}
\.


--
-- Name: bookcategories_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dhananghadiyanto
--

SELECT pg_catalog.setval('public.bookcategories_id_seq', 2, true);


--
-- Name: books_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhananghadiyanto
--

SELECT pg_catalog.setval('public.books_sequence', 2, false);


--
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dhananghadiyanto
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dhananghadiyanto
--

SELECT pg_catalog.setval('public.migrations_id_seq', 7, true);


--
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: dhananghadiyanto
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- Name: users_sequence; Type: SEQUENCE SET; Schema: public; Owner: dhananghadiyanto
--

SELECT pg_catalog.setval('public.users_sequence', 61, true);


--
-- Name: bookcategories bookcategories_name_unique; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.bookcategories
    ADD CONSTRAINT bookcategories_name_unique UNIQUE (name);


--
-- Name: bookcategories bookcategories_pkey; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.bookcategories
    ADD CONSTRAINT bookcategories_pkey PRIMARY KEY (id);


--
-- Name: bookcategories bookcategories_slug_unique; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.bookcategories
    ADD CONSTRAINT bookcategories_slug_unique UNIQUE (slug);


--
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- Name: group_akses group_akses_pk; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.group_akses
    ADD CONSTRAINT group_akses_pk PRIMARY KEY (id_group_akses);


--
-- Name: users id_users_pk; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT id_users_pk PRIMARY KEY (id_user);


--
-- Name: master_aplikasi master_aplikasi_pk; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.master_aplikasi
    ADD CONSTRAINT master_aplikasi_pk PRIMARY KEY (id_master_aplikasi);


--
-- Name: master_group master_group_pk; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.master_group
    ADD CONSTRAINT master_group_pk PRIMARY KEY (id_master_group);


--
-- Name: master_menu master_menu_pk; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.master_menu
    ADD CONSTRAINT master_menu_pk PRIMARY KEY (id_master_menu);


--
-- Name: master_modul master_modul_pk; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.master_modul
    ADD CONSTRAINT master_modul_pk PRIMARY KEY (id_master_modul);


--
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- Name: users username; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username UNIQUE (username);


--
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- Name: users_2 users_pk; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.users_2
    ADD CONSTRAINT users_pk PRIMARY KEY (usersid);


--
-- Name: users_2 users_un; Type: CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.users_2
    ADD CONSTRAINT users_un UNIQUE (email);


--
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: dhananghadiyanto
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: dhananghadiyanto
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: dhananghadiyanto
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: dhananghadiyanto
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- Name: group_akses group_akses_fk; Type: FK CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.group_akses
    ADD CONSTRAINT group_akses_fk FOREIGN KEY (id_master_group) REFERENCES public.master_group(id_master_group) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: master_group master_group_fk; Type: FK CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.master_group
    ADD CONSTRAINT master_group_fk FOREIGN KEY (id_master_aplikasi) REFERENCES public.master_aplikasi(id_master_aplikasi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: master_menu master_menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.master_menu
    ADD CONSTRAINT master_menu_fk FOREIGN KEY (id_master_aplikasi) REFERENCES public.master_aplikasi(id_master_aplikasi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- Name: master_modul master_modul_fk; Type: FK CONSTRAINT; Schema: public; Owner: dhananghadiyanto
--

ALTER TABLE ONLY public.master_modul
    ADD CONSTRAINT master_modul_fk FOREIGN KEY (id_master_menu) REFERENCES public.master_menu(id_master_menu) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- PostgreSQL database dump complete
--


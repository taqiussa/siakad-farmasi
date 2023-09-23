--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

-- Started on 2023-09-23 11:19:05 WIB

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

DROP DATABASE sso;
--
-- TOC entry 3718 (class 1262 OID 16387)
-- Name: sso; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE sso WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


\connect sso

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
-- TOC entry 217 (class 1259 OID 16442)
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
-- TOC entry 216 (class 1259 OID 16441)
-- Name: failed_jobs_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.failed_jobs_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3719 (class 0 OID 0)
-- Dependencies: 216
-- Name: failed_jobs_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.failed_jobs_id_seq OWNED BY public.failed_jobs.id;


--
-- TOC entry 226 (class 1259 OID 24632)
-- Name: group_akses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.group_akses (
    id_group_akses uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_master_group uuid NOT NULL,
    id_master_aplikasi uuid NOT NULL,
    id_master_modul uuid NOT NULL,
    akses boolean DEFAULT true
);


--
-- TOC entry 222 (class 1259 OID 16478)
-- Name: master_aplikasi; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 225 (class 1259 OID 24626)
-- Name: master_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_group (
    id_master_group uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_master_aplikasi uuid NOT NULL,
    nama_group character varying NOT NULL,
    deskripsi character varying
);


--
-- TOC entry 223 (class 1259 OID 24600)
-- Name: master_menu; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.master_menu (
    id_master_menu uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_menu character varying NOT NULL,
    deskripsi character varying,
    "order" integer,
    id_master_aplikasi uuid NOT NULL,
    icon character varying
);


--
-- TOC entry 224 (class 1259 OID 24613)
-- Name: master_modul; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 3720 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN master_modul.status_data; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.master_modul.status_data IS 'aktif, tidak aktif';


--
-- TOC entry 212 (class 1259 OID 16409)
-- Name: migrations; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.migrations (
    id integer NOT NULL,
    migration character varying(255) NOT NULL,
    batch integer NOT NULL
);


--
-- TOC entry 211 (class 1259 OID 16408)
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
-- TOC entry 3721 (class 0 OID 0)
-- Dependencies: 211
-- Name: migrations_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.migrations_id_seq OWNED BY public.migrations.id;


--
-- TOC entry 214 (class 1259 OID 16428)
-- Name: password_reset_tokens; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_reset_tokens (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- TOC entry 215 (class 1259 OID 16435)
-- Name: password_resets; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.password_resets (
    email character varying(255) NOT NULL,
    token character varying(255) NOT NULL,
    created_at timestamp(0) without time zone
);


--
-- TOC entry 219 (class 1259 OID 16454)
-- Name: personal_access_tokens; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 218 (class 1259 OID 16453)
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE; Schema: public; Owner: -
--

CREATE SEQUENCE public.personal_access_tokens_id_seq
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;


--
-- TOC entry 3722 (class 0 OID 0)
-- Dependencies: 218
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE OWNED BY; Schema: public; Owner: -
--

ALTER SEQUENCE public.personal_access_tokens_id_seq OWNED BY public.personal_access_tokens.id;


--
-- TOC entry 230 (class 1259 OID 24716)
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
-- TOC entry 227 (class 1259 OID 24704)
-- Name: trans_user_group; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.trans_user_group (
    id_trans_user_group uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_user uuid NOT NULL,
    id_master_aplikasi uuid NOT NULL,
    id_master_group uuid NOT NULL,
    status_data character varying
);


--
-- TOC entry 213 (class 1259 OID 16417)
-- Name: users; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 3723 (class 0 OID 0)
-- Dependencies: 213
-- Name: COLUMN users.status_data; Type: COMMENT; Schema: public; Owner: -
--

COMMENT ON COLUMN public.users.status_data IS 'aktif dan tidak aktif';


--
-- TOC entry 210 (class 1259 OID 16388)
-- Name: users_2; Type: TABLE; Schema: public; Owner: -
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


--
-- TOC entry 3505 (class 2604 OID 16445)
-- Name: failed_jobs id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs ALTER COLUMN id SET DEFAULT nextval('public.failed_jobs_id_seq'::regclass);


--
-- TOC entry 3501 (class 2604 OID 16412)
-- Name: migrations id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations ALTER COLUMN id SET DEFAULT nextval('public.migrations_id_seq'::regclass);


--
-- TOC entry 3507 (class 2604 OID 16457)
-- Name: personal_access_tokens id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens ALTER COLUMN id SET DEFAULT nextval('public.personal_access_tokens_id_seq'::regclass);


--
-- TOC entry 3703 (class 0 OID 16442)
-- Dependencies: 217
-- Data for Name: failed_jobs; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3710 (class 0 OID 24632)
-- Dependencies: 226
-- Data for Name: group_akses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.group_akses VALUES ('8359ff03-cb98-4cd5-8cba-6a28bdff1539', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '1acdb62c-86bf-429e-aae7-2ae71cc86b91', true);
INSERT INTO public.group_akses VALUES ('2dde2f98-ff36-44d2-bedd-83050f33bc3d', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'ff65a686-0202-4758-b6be-9099277b3f2d', true);
INSERT INTO public.group_akses VALUES ('b2ee1935-cc9d-4185-a9c8-cf35d7ede516', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '5baf6af9-9dee-4b5f-bd11-fb3b0d70ec19', true);
INSERT INTO public.group_akses VALUES ('5e3cc1f1-f9c3-492f-ba82-8acf34a1c5c3', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '6d351744-1992-4ed5-aade-73c794642abb', true);
INSERT INTO public.group_akses VALUES ('f50ec51b-ccfe-4001-85e8-47ee0432551c', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '73ad6297-2a4d-4d92-8452-77ef62135b74', true);
INSERT INTO public.group_akses VALUES ('15b664d4-d91f-4fd5-ab20-868455d70b37', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '247053bb-3072-4f29-aa45-1772ca7e1a6e', true);
INSERT INTO public.group_akses VALUES ('403768f1-aaf6-42ab-874d-a69e668256b3', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'f225ac92-37b8-401c-8a6e-e362d2657d1f', true);
INSERT INTO public.group_akses VALUES ('2765bef0-4828-4268-a1af-2d0f250d05cb', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '0610c1ea-1ce9-49ec-bafa-1a539d10c648', true);
INSERT INTO public.group_akses VALUES ('a9ca6254-1c47-4468-b3f3-e0c511b97e21', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '1469839b-b537-4f03-94d1-b8ce32be79d3', true);
INSERT INTO public.group_akses VALUES ('092f3f12-b31c-4956-8ba8-af549a4b48ef', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '18f3e1a0-fe13-48d7-a410-bc908ff38769', true);
INSERT INTO public.group_akses VALUES ('f3c3cacc-e95d-446c-a965-573231f2b2d9', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'f0ab95f3-c42c-487e-a005-5ac1d32a93de', true);
INSERT INTO public.group_akses VALUES ('e2f755e2-8e09-4291-84f2-2c1075f591be', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fc0d6624-b8b1-4150-a7cc-e6b18d4c29f1', true);
INSERT INTO public.group_akses VALUES ('34ffc16e-a3d8-4c11-8f4f-363479c5b2cf', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '6a734913-01e0-4f6f-9dc0-6a952e77329f', true);
INSERT INTO public.group_akses VALUES ('a03735a9-5dd1-4d6b-aab2-6289511da7e5', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '2cdb147a-8d0d-4259-a4e3-843e2dd0184d', true);


--
-- TOC entry 3706 (class 0 OID 16478)
-- Dependencies: 222
-- Data for Name: master_aplikasi; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.master_aplikasi VALUES ('6d920eeb-5be8-4346-a6cd-edcd26c95780', 'SSO', 'Single Sign On', '2.0', 'aktif', '2023-03-22', 'http://127.0.0.1:8000/edit_master_aplikasi/6d920eeb-5be8-4346-a6cd-edcd26c95780', '1679529740.png');
INSERT INTO public.master_aplikasi VALUES ('ed9f0135-6f63-422c-a42a-fbc14e261900', 'SIA farmasi', 'SIstem akademik farmasi', '2.0', 'aktif', '2023-03-22', 'http://127.0.0.1:8000/add_master_aplikasi', '1679496468.png');


--
-- TOC entry 3709 (class 0 OID 24626)
-- Dependencies: 225
-- Data for Name: master_group; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.master_group VALUES ('a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'Administrator', 'Pengguna Administrator');
INSERT INTO public.master_group VALUES ('49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'Administrator', 'Pengguna Administrator');
INSERT INTO public.master_group VALUES ('9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'User', 'Pengguna User');


--
-- TOC entry 3707 (class 0 OID 24600)
-- Dependencies: 223
-- Data for Name: master_menu; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.master_menu VALUES ('4706192a-bca5-4e15-a22b-043ac3e5f920', 'tes', 'asdasd', 2, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-hourglass-3');
INSERT INTO public.master_menu VALUES ('0d312507-524d-49fe-9e5a-2f28c8ac3824', 'Manajemen Pengguna', 'Master Manajemen Pengguna', 2, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-users');
INSERT INTO public.master_menu VALUES ('18476952-90c5-42bd-ad9a-6002ed6d87b7', 'Manajemen Pengguna', 'Master Manajemen Pengguna', 2, '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'fa fa-street-view');
INSERT INTO public.master_menu VALUES ('cf56b85c-784e-49c3-ad54-446792bdd831', 'Master', 'Master Menu', 1, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-home');
INSERT INTO public.master_menu VALUES ('006d6c9e-151d-4c8a-9c35-846017b7271c', 'Akun', 'Akun', 1, '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'fa fa-users');
INSERT INTO public.master_menu VALUES ('bf507bfd-f42a-4591-bdba-f2d3b87a755e', 'Kurikulum', 'Kurikulum', 2, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-bank');
INSERT INTO public.master_menu VALUES ('1d05ee48-d583-4916-b620-1761fce60e27', 'Pembayaran', 'Master Pembayaran', 3, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-dollar');
INSERT INTO public.master_menu VALUES ('8b5e2031-f5c3-4b7b-9f20-eed88d9c982b', 'Rencana Studi', 'Master Rencana Studi', 4, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-balance-scale');


--
-- TOC entry 3708 (class 0 OID 24613)
-- Dependencies: 224
-- Data for Name: master_modul; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.master_modul VALUES ('0df007ce-ab39-4485-ac73-061dc239e607', '4706192a-bca5-4e15-a22b-043ac3e5f920', 2, 'adsas', 'asda', 'adsa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-hourglass-3');
INSERT INTO public.master_modul VALUES ('1acdb62c-86bf-429e-aae7-2ae71cc86b91', '006d6c9e-151d-4c8a-9c35-846017b7271c', 1, 'Profile', 'profile', 'Profile Pengguna', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-user');
INSERT INTO public.master_modul VALUES ('ff65a686-0202-4758-b6be-9099277b3f2d', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 1, 'Master Aplikasi', 'master_aplikasi', 'Manajemen Aplikasi', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-space-shuttle');
INSERT INTO public.master_modul VALUES ('5baf6af9-9dee-4b5f-bd11-fb3b0d70ec19', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 2, 'Master Menu', 'master_menu', 'Master Manajemen Menu', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-bars');
INSERT INTO public.master_modul VALUES ('6d351744-1992-4ed5-aade-73c794642abb', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 3, 'Master Grup Akses', 'master_group', 'Master Manajemen Group Akses Aplikasi', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-comments');
INSERT INTO public.master_modul VALUES ('73ad6297-2a4d-4d92-8452-77ef62135b74', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 4, 'Master Pengguna', 'master_pengguna', 'Master Manajemen Pengguna', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-user-secret');
INSERT INTO public.master_modul VALUES ('247053bb-3072-4f29-aa45-1772ca7e1a6e', 'cf56b85c-784e-49c3-ad54-446792bdd831', 1, 'Master Biodata Mahasiswa', 'master_biodata_mahasiswa', 'Master Biodata Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-mortar-board');
INSERT INTO public.master_modul VALUES ('f225ac92-37b8-401c-8a6e-e362d2657d1f', 'cf56b85c-784e-49c3-ad54-446792bdd831', 2, 'Master Pendidikan Mahasiswa', 'master_mahasiswa', 'Master Pendidikan Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-users');
INSERT INTO public.master_modul VALUES ('0610c1ea-1ce9-49ec-bafa-1a539d10c648', 'cf56b85c-784e-49c3-ad54-446792bdd831', 3, 'Master Mata Kuliah', 'master_matakuliah', 'Master Matakuliah', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-book');
INSERT INTO public.master_modul VALUES ('18f3e1a0-fe13-48d7-a410-bc908ff38769', 'bf507bfd-f42a-4591-bdba-f2d3b87a755e', 1, 'Master Kurikulum', 'master_kurikulum', 'Master Kurikulum', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-map');
INSERT INTO public.master_modul VALUES ('f0ab95f3-c42c-487e-a005-5ac1d32a93de', 'bf507bfd-f42a-4591-bdba-f2d3b87a755e', 2, 'Master Angkatan Mahasiswa', 'master_angkatan_mahasiswa', 'Master Group Angkatan Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-bug');
INSERT INTO public.master_modul VALUES ('6a734913-01e0-4f6f-9dc0-6a952e77329f', '1d05ee48-d583-4916-b620-1761fce60e27', 2, 'Tagihan Mahasiswa', 'tagihan_mahasiswa', 'Tagihan Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-th-list');
INSERT INTO public.master_modul VALUES ('fc0d6624-b8b1-4150-a7cc-e6b18d4c29f1', '1d05ee48-d583-4916-b620-1761fce60e27', 1, 'Master Kode Pembayaran', 'master_kode_pembayaran', 'Master Kode Pembayaran', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-bar-chart');
INSERT INTO public.master_modul VALUES ('2cdb147a-8d0d-4259-a4e3-843e2dd0184d', '8b5e2031-f5c3-4b7b-9f20-eed88d9c982b', 1, 'Waktu KRS', 'waktu_krs', 'master waktu krs', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-commenting');
INSERT INTO public.master_modul VALUES ('c3eb1aa6-5cd8-4185-96b9-ddead17ba1f4', 'bf507bfd-f42a-4591-bdba-f2d3b87a755e', 1, 'tes', 'tes', 'contoh', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-commenting');


--
-- TOC entry 3698 (class 0 OID 16409)
-- Dependencies: 212
-- Data for Name: migrations; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.migrations VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO public.migrations VALUES (2, '2014_10_12_100000_create_password_reset_tokens_table', 1);
INSERT INTO public.migrations VALUES (3, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO public.migrations VALUES (4, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO public.migrations VALUES (5, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO public.migrations VALUES (6, '2023_02_15_053453_create_bookcategories_table', 1);
INSERT INTO public.migrations VALUES (7, '2023_04_08_082712_create_sessions_table', 2);


--
-- TOC entry 3700 (class 0 OID 16428)
-- Dependencies: 214
-- Data for Name: password_reset_tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3701 (class 0 OID 16435)
-- Dependencies: 215
-- Data for Name: password_resets; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3705 (class 0 OID 16454)
-- Dependencies: 219
-- Data for Name: personal_access_tokens; Type: TABLE DATA; Schema: public; Owner: -
--



--
-- TOC entry 3712 (class 0 OID 24716)
-- Dependencies: 230
-- Data for Name: sessions; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.sessions VALUES ('3JRQ9guo7MYV68zYCVFt0XQ4Rckqzzwu8HHGGRZJ', 1, '192.168.240.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0', 'YTo1OntzOjY6Il90b2tlbiI7czo0MDoiMXppb2t4U1ZJSkNsVWE3aWJoMVk3RmtUajd1NUI0ZnIxdUlVNVJEUSI7czo2OiJfZmxhc2giO2E6Mjp7czozOiJvbGQiO2E6MDp7fXM6MzoibmV3IjthOjA6e319czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6MzA6Imh0dHA6Ly9zaWEuYWthZGVtaWsubG9jYWwvaG9tZSI7fXM6NTA6ImxvZ2luX3dlYl81OWJhMzZhZGRjMmIyZjk0MDE1ODBmMDE0YzdmNThlYTRlMzA5ODlkIjtpOjE7czo0OiJhdXRoIjthOjE6e3M6MjE6InBhc3N3b3JkX2NvbmZpcm1lZF9hdCI7aToxNjk1NDM4MjA4O319', 1695438209);


--
-- TOC entry 3711 (class 0 OID 24704)
-- Dependencies: 227
-- Data for Name: trans_user_group; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.trans_user_group VALUES ('c9d9f7f6-0995-43d4-bf57-ce117d3e659f', '953fd07b-11a2-45a1-8ae5-87a408001afd', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Aktif');
INSERT INTO public.trans_user_group VALUES ('dc2f70b5-8569-4a03-870e-eedb26e81937', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('51c8380c-a975-4e1b-8eb8-8a1abcd5ba4a', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Aktif');
INSERT INTO public.trans_user_group VALUES ('c76e8668-1506-4ddb-812a-927fb6271ec3', '113cfdf7-ed7f-425e-8bbc-b093206d9917', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'Aktif');
INSERT INTO public.trans_user_group VALUES ('fb11c63b-94f2-4af5-bbce-27b220a893ce', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('c4e2117b-70bd-4c0a-809b-0ea1508f2ab6', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('90cc0382-ca17-4f53-a8e8-489b91acb587', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('d805cc43-889b-4fc9-96fb-8bacf9f1c1d5', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('07fd58ac-1adc-489d-9681-390e520f03ec', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('0892b240-1331-47be-963c-a95eb3efeeff', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('36bc3be5-8718-4c44-8bbc-640a05eb3268', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('27703a93-9ddb-41de-8e64-fc214131dd99', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('a741129a-12ad-472e-a516-18df3bfc80ae', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('7292f5ff-0dac-437c-80bf-e79aee9e334f', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('50a85e2c-3b7a-4170-b252-28e498f60e39', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO public.trans_user_group VALUES ('e3a023be-54a2-4c74-b280-7f19a3e126d3', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');


--
-- TOC entry 3699 (class 0 OID 16417)
-- Dependencies: 213
-- Data for Name: users; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users VALUES ('dhanang', 'dhanang@gmail.com', NULL, '$2y$10$CtFtf/x9tGDGxYpjRM5eFOUv4E6xDX1PBxl/qBDMZ/eU/JNhAA0CC', NULL, '2023-03-18 02:27:53', '2023-03-18 02:27:53', 'dhanang2112', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '063f25d7-2513-405a-ba2a-50cc60b2714a', 1, 'avatar.png', 'aktif');


--
-- TOC entry 3696 (class 0 OID 16388)
-- Dependencies: 210
-- Data for Name: users_2; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO public.users_2 VALUES ('{280e5189-0fca-4a2a-9dcf-d15da4d4c5c0}', 'dhanang2112', '123456', 'dhanang.hadiyanto@gmail.com', 'dhanang hadiyanto', NULL, NULL, true, '{280e5189-0fca-4a2a-9dcf-d15da4d4c5c0}');


--
-- TOC entry 3724 (class 0 OID 0)
-- Dependencies: 216
-- Name: failed_jobs_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.failed_jobs_id_seq', 1, false);


--
-- TOC entry 3725 (class 0 OID 0)
-- Dependencies: 211
-- Name: migrations_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.migrations_id_seq', 7, true);


--
-- TOC entry 3726 (class 0 OID 0)
-- Dependencies: 218
-- Name: personal_access_tokens_id_seq; Type: SEQUENCE SET; Schema: public; Owner: -
--

SELECT pg_catalog.setval('public.personal_access_tokens_id_seq', 1, false);


--
-- TOC entry 3531 (class 2606 OID 16450)
-- Name: failed_jobs failed_jobs_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_pkey PRIMARY KEY (id);


--
-- TOC entry 3533 (class 2606 OID 16452)
-- Name: failed_jobs failed_jobs_uuid_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.failed_jobs
    ADD CONSTRAINT failed_jobs_uuid_unique UNIQUE (uuid);


--
-- TOC entry 3548 (class 2606 OID 24645)
-- Name: group_akses group_akses_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_akses
    ADD CONSTRAINT group_akses_pk PRIMARY KEY (id_group_akses);


--
-- TOC entry 3522 (class 2606 OID 24660)
-- Name: users id_users_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT id_users_pk PRIMARY KEY (id_user);


--
-- TOC entry 3540 (class 2606 OID 16484)
-- Name: master_aplikasi master_aplikasi_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_aplikasi
    ADD CONSTRAINT master_aplikasi_pk PRIMARY KEY (id_master_aplikasi);


--
-- TOC entry 3546 (class 2606 OID 24638)
-- Name: master_group master_group_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_group
    ADD CONSTRAINT master_group_pk PRIMARY KEY (id_master_group);


--
-- TOC entry 3542 (class 2606 OID 24607)
-- Name: master_menu master_menu_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_menu
    ADD CONSTRAINT master_menu_pk PRIMARY KEY (id_master_menu);


--
-- TOC entry 3544 (class 2606 OID 24620)
-- Name: master_modul master_modul_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_modul
    ADD CONSTRAINT master_modul_pk PRIMARY KEY (id_master_modul);


--
-- TOC entry 3520 (class 2606 OID 16414)
-- Name: migrations migrations_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.migrations
    ADD CONSTRAINT migrations_pkey PRIMARY KEY (id);


--
-- TOC entry 3528 (class 2606 OID 16434)
-- Name: password_reset_tokens password_reset_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.password_reset_tokens
    ADD CONSTRAINT password_reset_tokens_pkey PRIMARY KEY (email);


--
-- TOC entry 3535 (class 2606 OID 16461)
-- Name: personal_access_tokens personal_access_tokens_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_pkey PRIMARY KEY (id);


--
-- TOC entry 3537 (class 2606 OID 16464)
-- Name: personal_access_tokens personal_access_tokens_token_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.personal_access_tokens
    ADD CONSTRAINT personal_access_tokens_token_unique UNIQUE (token);


--
-- TOC entry 3551 (class 2606 OID 24722)
-- Name: sessions sessions_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.sessions
    ADD CONSTRAINT sessions_pkey PRIMARY KEY (id);


--
-- TOC entry 3524 (class 2606 OID 16486)
-- Name: users username; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT username UNIQUE (username);


--
-- TOC entry 3526 (class 2606 OID 16427)
-- Name: users users_email_unique; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users
    ADD CONSTRAINT users_email_unique UNIQUE (email);


--
-- TOC entry 3516 (class 2606 OID 16394)
-- Name: users_2 users_pk; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_2
    ADD CONSTRAINT users_pk PRIMARY KEY (usersid);


--
-- TOC entry 3518 (class 2606 OID 16396)
-- Name: users_2 users_un; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.users_2
    ADD CONSTRAINT users_un UNIQUE (email);


--
-- TOC entry 3529 (class 1259 OID 16440)
-- Name: password_resets_email_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX password_resets_email_index ON public.password_resets USING btree (email);


--
-- TOC entry 3538 (class 1259 OID 16462)
-- Name: personal_access_tokens_tokenable_type_tokenable_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX personal_access_tokens_tokenable_type_tokenable_id_index ON public.personal_access_tokens USING btree (tokenable_type, tokenable_id);


--
-- TOC entry 3549 (class 1259 OID 24724)
-- Name: sessions_last_activity_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_last_activity_index ON public.sessions USING btree (last_activity);


--
-- TOC entry 3552 (class 1259 OID 24723)
-- Name: sessions_user_id_index; Type: INDEX; Schema: public; Owner: -
--

CREATE INDEX sessions_user_id_index ON public.sessions USING btree (user_id);


--
-- TOC entry 3556 (class 2606 OID 24646)
-- Name: group_akses group_akses_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.group_akses
    ADD CONSTRAINT group_akses_fk FOREIGN KEY (id_master_group) REFERENCES public.master_group(id_master_group) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3555 (class 2606 OID 24651)
-- Name: master_group master_group_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_group
    ADD CONSTRAINT master_group_fk FOREIGN KEY (id_master_aplikasi) REFERENCES public.master_aplikasi(id_master_aplikasi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3553 (class 2606 OID 24608)
-- Name: master_menu master_menu_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_menu
    ADD CONSTRAINT master_menu_fk FOREIGN KEY (id_master_aplikasi) REFERENCES public.master_aplikasi(id_master_aplikasi) ON UPDATE RESTRICT ON DELETE RESTRICT;


--
-- TOC entry 3554 (class 2606 OID 24621)
-- Name: master_modul master_modul_fk; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.master_modul
    ADD CONSTRAINT master_modul_fk FOREIGN KEY (id_master_menu) REFERENCES public.master_menu(id_master_menu) ON UPDATE RESTRICT ON DELETE RESTRICT;


-- Completed on 2023-09-23 11:19:05 WIB

--
-- PostgreSQL database dump complete
--


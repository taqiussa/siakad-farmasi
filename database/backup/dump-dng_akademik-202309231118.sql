--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

-- Started on 2023-09-23 11:18:03 WIB

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

DROP DATABASE dng_akademik;
--
-- TOC entry 4061 (class 1262 OID 16386)
-- Name: dng_akademik; Type: DATABASE; Schema: -; Owner: -
--

CREATE DATABASE dng_akademik WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE = 'C';


\connect dng_akademik

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
-- TOC entry 9 (class 2615 OID 24725)
-- Name: perwalian; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA perwalian;


--
-- TOC entry 4 (class 2615 OID 2200)
-- Name: public; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA public;


--
-- TOC entry 4062 (class 0 OID 0)
-- Dependencies: 4
-- Name: SCHEMA public; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA public IS 'standard public schema';


--
-- TOC entry 8 (class 2615 OID 24726)
-- Name: siakad; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA siakad;


--
-- TOC entry 4063 (class 0 OID 0)
-- Dependencies: 8
-- Name: SCHEMA siakad; Type: COMMENT; Schema: -; Owner: -
--

COMMENT ON SCHEMA siakad IS 'standard public schema';


--
-- TOC entry 5 (class 2615 OID 24727)
-- Name: skripsi; Type: SCHEMA; Schema: -; Owner: -
--

CREATE SCHEMA skripsi;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
-- TOC entry 213 (class 1259 OID 24728)
-- Name: master_dosen_wali; Type: TABLE; Schema: perwalian; Owner: -
--

CREATE TABLE perwalian.master_dosen_wali (
    id_master_dosen_wali uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5) NOT NULL,
    id_dosen uuid NOT NULL,
    id_registrasi_mahasiswa uuid NOT NULL,
    nama_mahasiswa character varying(24),
    nim character(24)
);


--
-- TOC entry 214 (class 1259 OID 24733)
-- Name: penguji_mahasiswa; Type: TABLE; Schema: perwalian; Owner: -
--

CREATE TABLE perwalian.penguji_mahasiswa (
    id_penguji_mahasiswa uuid NOT NULL,
    id_mahasiswa_skripsi uuid NOT NULL,
    id_kategori_kegiatan character(6) NOT NULL,
    id_dosen uuid NOT NULL,
    penguji_ke integer NOT NULL
);


--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 214
-- Name: COLUMN penguji_mahasiswa.id_kategori_kegiatan; Type: COMMENT; Schema: perwalian; Owner: -
--

COMMENT ON COLUMN perwalian.penguji_mahasiswa.id_kategori_kegiatan IS 'Web Service: GetKategoriKegiatan';


--
-- TOC entry 215 (class 1259 OID 24736)
-- Name: pesan_perwalian; Type: TABLE; Schema: perwalian; Owner: -
--

CREATE TABLE perwalian.pesan_perwalian (
    id_pesan_perwalian uuid NOT NULL,
    id_tran_perwalian uuid NOT NULL,
    id_dosen uuid,
    id_registrasi_mahasiswa uuid,
    pesan character varying,
    tgl_pesan time without time zone DEFAULT CURRENT_TIME
);


--
-- TOC entry 216 (class 1259 OID 24742)
-- Name: tran_perwalian; Type: TABLE; Schema: perwalian; Owner: -
--

CREATE TABLE perwalian.tran_perwalian (
    id_tran_perwalian uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5) NOT NULL,
    id_waktu_perwalian uuid NOT NULL,
    tgl_bimbingan time without time zone DEFAULT CURRENT_TIME NOT NULL,
    pertemuan integer NOT NULL
);


--
-- TOC entry 217 (class 1259 OID 24748)
-- Name: waktu_perwalian; Type: TABLE; Schema: perwalian; Owner: -
--

CREATE TABLE perwalian.waktu_perwalian (
    id_waktu_perwalian uuid NOT NULL,
    nama_perwalian character varying,
    id_prodi uuid,
    nama_program_studi character varying,
    id_semester character(5),
    tgl_mulai time without time zone,
    tgl_selesai time without time zone,
    pertemuan integer
);


--
-- TOC entry 218 (class 1259 OID 24753)
-- Name: absensi_perkuliahan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.absensi_perkuliahan (
    id_absensi_perkuliahan uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5) NOT NULL,
    id_master_kegiatan_perkuliahan uuid NOT NULL,
    tgl_absensi_mulai time without time zone NOT NULL,
    tgl_absensi_selesai time without time zone NOT NULL,
    nama_absensi character varying
);


--
-- TOC entry 219 (class 1259 OID 24758)
-- Name: aktivitas_perkuliahan_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.aktivitas_perkuliahan_mahasiswa (
    id_aktivitas_perkuliahan_mahasiswa uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5) NOT NULL,
    id_status_mahasiswa character(1) NOT NULL,
    ips double precision,
    ipk double precision
);


--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 219
-- Name: COLUMN aktivitas_perkuliahan_mahasiswa.id_status_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.aktivitas_perkuliahan_mahasiswa.id_status_mahasiswa IS 'ID Status Mahasiswa. Web Service: GetStatusMahasiswa';


--
-- TOC entry 220 (class 1259 OID 24763)
-- Name: biodata_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.biodata_mahasiswa (
    id_mahasiswa uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_mahasiswa character varying,
    jenis_kelamin character(1),
    tempat_lahir character varying(32),
    tanggal_lahir date,
    id_agama smallint,
    nama_agama character varying(50),
    nik character(16) DEFAULT '1234567891234567'::bigint NOT NULL,
    nisn character varying(10),
    npwp character varying(15),
    id_negara character(2),
    kewarganegaraan character varying DEFAULT 'ID'::bpchar NOT NULL,
    jalan character varying(80),
    dusun character varying(80),
    rt numeric(2,0),
    rw numeric(2,0),
    kelurahan character varying(60),
    kode_pos numeric(5,0),
    id_wilayah character(6) DEFAULT 0 NOT NULL,
    nama_jenis_tinggal character varying,
    id_alat_transportasi numeric(2,0),
    nama_alat_transportasi character varying,
    telepon character varying(20),
    handphone character varying(20),
    email character varying(60),
    penerima_kps numeric(1,0) DEFAULT 0,
    nik_ayah character varying(16),
    nama_ayah character varying(100),
    tanggal_lahir_ayah date,
    id_pendidikan_ayah numeric(2,0),
    nama_pendidikan_ayah character varying,
    id_pekerjaan_ayah integer,
    nama_pekerjaan_ayah character varying,
    id_penghasilan_ayah integer,
    nama_penghasilan_ayah character varying,
    nik_ibu character varying(16),
    nama_ibu_kandung character varying(100) NOT NULL,
    tanggal_lahir_ibu date,
    id_pendidikan_ibu numeric(2,0),
    nama_pendidikan_ibu character varying,
    id_pekerjaan_ibu integer,
    nama_pekerjaan_ibu character varying,
    id_penghasilan_ibu integer,
    nama_penghasilan_ibu character varying,
    nama_wali character varying(100),
    tanggal_lahir_wali date,
    id_pekerjaan_wali integer,
    nama_pekerjaan_wali character varying,
    id_penghasilan_wali integer,
    nama_penghasilan_wali character varying,
    id_kebutuhan_khusus_mahasiswa integer DEFAULT 0,
    nama_kebutuhan_khusus_mahasiswa character varying,
    id_kebutuhan_khusus_ayah integer DEFAULT 0,
    nama_kebutuhan_khusus_ayah character varying,
    id_kebutuhan_khusus_ibu integer DEFAULT 0,
    nama_kebutuhan_khusus_ibu character varying,
    id_jenis_tinggal smallint,
    id_pendidikan_wali numeric,
    nama_pendidikan_wali character varying,
    nama_wilayah character varying
);


--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE biodata_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.biodata_mahasiswa IS 'master biodata mahasiswa';


--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_mahasiswa IS 'Primary Key, kosongkan ketika mode Tambah';


--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_mahasiswa IS 'Nama Mahasiswa';


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.jenis_kelamin; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.jenis_kelamin IS 'L: Laki-laki, P: Perempuan, *: Belum ada informasi';


--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.tempat_lahir; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.tempat_lahir IS 'Tempat Lahir';


--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.tanggal_lahir; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.tanggal_lahir IS 'Tanggal Lahir';


--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_agama IS 'Web Service feeder:  GetAgama';


--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_agama IS 'Detail Agama';


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nik; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nik IS 'Nomor Induk Kependudukan, wajib di isi';


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nisn; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nisn IS 'Nomor Induk Siswa Nasional';


--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.npwp; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.npwp IS 'Nomor Pokok Wajib Pajak';


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_negara; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_negara IS 'Web Service feeder: GetNegara';


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.kewarganegaraan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.kewarganegaraan IS 'detail Web Service: GetNegara';


--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.jalan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.jalan IS 'Alamat jalan';


--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.dusun; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.dusun IS 'Dusun Desa';


--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.kelurahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.kelurahan IS 'kelurahan';


--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.kode_pos; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.kode_pos IS 'kode_pos harus 5 digit';


--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_wilayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_wilayah IS 'ID Wilayah. Web Service: GetWilayah';


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_alat_transportasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_alat_transportasi IS 'Web Service: GetAlatTransportasi';


--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_alat_transportasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_alat_transportasi IS 'Detail alat tranportasi';


--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.penerima_kps; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.penerima_kps IS '0: Bukan penerima KPS, 1: Penerima KPS';


--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nik_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nik_ayah IS 'Nomor Induk Kependudukan, wajib di isi';


--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_ayah IS 'character varying(100)';


--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pendidikan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pendidikan_ayah IS 'Web Service: GetJenjangPendidikan';


--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pendidikan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pendidikan_ayah IS 'detail Web Service: GetJenjangPendidikan';


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pekerjaan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pekerjaan_ayah IS 'Web Service: GetPekerjaan';


--
-- TOC entry 4092 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pekerjaan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pekerjaan_ayah IS 'detail Web Service: GetPekerjaan';


--
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_penghasilan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_penghasilan_ayah IS 'Web Service: GetPenghasilan';


--
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_penghasilan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_penghasilan_ayah IS 'detail Web Service: GetPenghasilan';


--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nik_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nik_ibu IS 'Nomor Induk Kependudukan, wajib di isi';


--
-- TOC entry 4096 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_ibu_kandung; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_ibu_kandung IS 'character varying(100)';


--
-- TOC entry 4097 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pendidikan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pendidikan_ibu IS 'Web Service: GetJenjangPendidikan';


--
-- TOC entry 4098 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pendidikan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pendidikan_ibu IS 'detail Web Service: GetJenjangPendidikan';


--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pekerjaan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pekerjaan_ibu IS 'Web Service: GetPekerjaan';


--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pekerjaan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pekerjaan_ibu IS 'detail Web Service: GetPekerjaan';


--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_penghasilan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_penghasilan_ibu IS 'Web Service: GetPenghasilan';


--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_penghasilan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_penghasilan_ibu IS 'detail Web Service: GetPenghasilan';


--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pekerjaan_wali; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pekerjaan_wali IS 'Web Service: GetPekerjaan';


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pekerjaan_wali; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pekerjaan_wali IS 'detail Web Service: GetPekerjaan';


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_penghasilan_wali; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_penghasilan_wali IS 'Web Service: GetPenghasilan';


--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_penghasilan_wali; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_penghasilan_wali IS 'detail Web Service: GetPenghasilan';


--
-- TOC entry 222 (class 1259 OID 24780)
-- Name: kurikulum; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.kurikulum (
    id_kurikulum uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_kurikulum character varying(60),
    id_prodi uuid,
    id_semester character(5),
    jumlah_sks_lulus numeric(3,0),
    jumlah_sks_wajib numeric(3,0),
    jumlah_sks_pilihan numeric(3,0),
    id_tahun_akademik uuid,
    nama_program_studi character varying(100)
);


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.kurikulum IS 'Kurikulum';


--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN kurikulum.nama_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.kurikulum.nama_kurikulum IS 'Nama Kuriukulum';


--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN kurikulum.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.kurikulum.id_prodi IS 'ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN kurikulum.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.kurikulum.id_semester IS 'id Semester berlaku\nID Semester. Web Service: GetSemester';


--
-- TOC entry 223 (class 1259 OID 24783)
-- Name: list_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.list_mahasiswa (
    id_registrasi_mahasiswa uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_mahasiswa uuid NOT NULL,
    nama_mahasiswa character(100),
    jenis_kelamin character(1),
    tanggal_lahir date,
    id_perguruan_tinggi character varying,
    id_agama smallint,
    nama_agama character varying(50),
    id_prodi uuid,
    nama_program_studi character varying,
    id_status_mahasiswa character(1) DEFAULT 'A'::bpchar,
    nama_status_mahasiswa character varying,
    nim character varying(24),
    id_periode_masuk character(5),
    nama_periode_masuk character varying,
    id_jenis_daftar numeric(2,0),
    id_jalur_daftar numeric(4,0),
    id_bidang_minat uuid,
    sks_diakui numeric(3,0),
    id_perguruan_tinggi_asal uuid,
    id_prodi_asal uuid,
    id_pembiayaan smallint,
    biaya_masuk numeric(16,2),
    tgl_keluar date,
    no_ijazah character varying,
    no_sk character varying,
    jenis_keluar character varying,
    periode_keluar character(5),
    tgl_sk date,
    ipk_lulus numeric(8,2),
    id_tahun_akademik uuid,
    tanggal_daftar date,
    kode_pt character(6),
    nama_perguruan_tinggi_asal character varying,
    nama_prodi_asal character varying,
    nama_lembaga_prodi_asal character varying
);


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE list_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.list_mahasiswa IS 'detail mahasiswa program studi';


--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_registrasi_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_registrasi_mahasiswa IS 'primary';


--
-- TOC entry 4113 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_mahasiswa IS 'FK dari Biodata_mahasiswa';


--
-- TOC entry 4114 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_mahasiswa IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)';


--
-- TOC entry 4115 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.jenis_kelamin; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.jenis_kelamin IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)\nL: Laki-laki, P: Perempuan, *: Belum ada informasi';


--
-- TOC entry 4116 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.tanggal_lahir; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.tanggal_lahir IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)';


--
-- TOC entry 4117 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_perguruan_tinggi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_perguruan_tinggi IS 'ID Perguruan Tinggi. Web Service: GetProfilPT';


--
-- TOC entry 4118 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_agama IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)\nWeb Service: GetAgama';


--
-- TOC entry 4119 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_agama IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)';


--
-- TOC entry 4120 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_prodi IS 'ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4121 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_program_studi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_program_studi IS 'detail ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4122 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nim; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nim IS 'Nomor Induk Mahasiswa';


--
-- TOC entry 4123 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_periode_masuk; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_periode_masuk IS 'ID periode Masuk';


--
-- TOC entry 4124 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_periode_masuk; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_periode_masuk IS 'Tahun Akademik';


--
-- TOC entry 4125 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_jenis_daftar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_jenis_daftar IS 'Web Service: GetJenisPendaftaran';


--
-- TOC entry 4126 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_jalur_daftar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_jalur_daftar IS 'Web Service: GetJalurMasuk';


--
-- TOC entry 4127 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_bidang_minat; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_bidang_minat IS 'ID Bidang Minat. Web Service: GetListBidangMinat';


--
-- TOC entry 4128 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.sks_diakui; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.sks_diakui IS 'Jika Pindahan';


--
-- TOC entry 4129 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_perguruan_tinggi_asal; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_perguruan_tinggi_asal IS 'Jika Pindahan \nID Perguruan Tinggi. Web Service: GetAllPT';


--
-- TOC entry 4130 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_prodi_asal; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_prodi_asal IS 'Jika Pindahan\nID Prodi. Web Service: GetAllProdi';


--
-- TOC entry 4131 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_pembiayaan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_pembiayaan IS 'ID Pembiayaan Awal. Web Service: GetPembiayaan';


--
-- TOC entry 4132 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.biaya_masuk; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.biaya_masuk IS 'Biaya DPI';


--
-- TOC entry 4133 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.jenis_keluar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.jenis_keluar IS 'lulus,do,pindah,wafat,mengundurkan diri';


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.periode_keluar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.periode_keluar IS 'id semester';


--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_tahun_akademik; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_tahun_akademik IS 'dari master tahun akademik';


--
-- TOC entry 224 (class 1259 OID 24789)
-- Name: lokasi_perkuliahan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.lokasi_perkuliahan (
    id_lokasi_perkuliahan uuid NOT NULL,
    nama_lokasi_perkuliahan character varying NOT NULL,
    no_telp character varying,
    alamat character varying,
    jenis_lokasi character varying,
    pimpinan character varying,
    id_prodi uuid,
    nama_program_studi character varying,
    status character(1) DEFAULT 1
);


--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 224
-- Name: COLUMN lokasi_perkuliahan.status; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.lokasi_perkuliahan.status IS '0 = tidak aktif\n1 = aktif';


--
-- TOC entry 267 (class 1259 OID 33717)
-- Name: mahasiswa_angkatan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.mahasiswa_angkatan (
    id_mahasiswa_angkatan uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_registrasi_mahasiswa uuid,
    tgl_insert timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    id_angkatan_mahasiswa uuid
);


--
-- TOC entry 225 (class 1259 OID 24795)
-- Name: mahasiswa_krs; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.mahasiswa_krs (
    id_mahasiswa_krs uuid NOT NULL,
    id_registrasi_mahasiswa uuid[] NOT NULL,
    id_mahasiswa uuid,
    id_prodi uuid NOT NULL,
    id_matakuliah_krs_ditawarkan uuid NOT NULL,
    nilai_angka numeric(4,2),
    nilai_indeks numeric(2,2),
    nilai_huruf character varying(2),
    status_krs character(1),
    approval character(1) DEFAULT 0,
    tgl_insert timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validasi character(1) DEFAULT 0
);


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.nilai_angka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.nilai_angka IS 'Niai angka dari olah nilai';


--
-- TOC entry 4138 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.nilai_indeks; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.nilai_indeks IS 'nilai indeks \nA = 4\nAB = 3.5\nB = 3\nBC  2.5\nC = 2\nCD = 1.5\nD = 1\nE = 0';


--
-- TOC entry 4139 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.nilai_huruf; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.nilai_huruf IS 'A \nAB \nB \nBC \nC\nCD \nD';


--
-- TOC entry 4140 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.status_krs; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.status_krs IS '1 : KRS \n2: Batal Tambah';


--
-- TOC entry 4141 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.approval; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.approval IS '0 = tunggu\n1 = disetujui';


--
-- TOC entry 4142 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.validasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.validasi IS '1 = valid\n0 = belum validasi';


--
-- TOC entry 226 (class 1259 OID 24803)
-- Name: mahasiswa_kurikulum; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.mahasiswa_kurikulum (
    id_mahasiswa_kurikulum uuid NOT NULL,
    id_kurikulum uuid,
    nama_kurikulum character varying(60),
    id_mahasiswa uuid,
    nama_mahasiswa character(100),
    nim character varying(24),
    id_semester character(5),
    id_registrasi_mahasiswa uuid[],
    id_prodi uuid
);


--
-- TOC entry 4143 (class 0 OID 0)
-- Dependencies: 226
-- Name: TABLE mahasiswa_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.mahasiswa_kurikulum IS 'Mahasiswa Kurikulum';


--
-- TOC entry 227 (class 1259 OID 24808)
-- Name: mahasiswa_remidi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.mahasiswa_remidi (
    id_mahasiswa_remidi uuid NOT NULL,
    id_registrasi_mahasiswa uuid[] NOT NULL,
    id_mahasiswa uuid,
    id_prodi uuid NOT NULL,
    id_matakuliah_remidi_ditawarkan uuid NOT NULL,
    nilai_angka numeric(4,2),
    approval character(1) DEFAULT 0,
    tgl_insert timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validasi character(1) DEFAULT 0
);


--
-- TOC entry 4144 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN mahasiswa_remidi.nilai_angka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_remidi.nilai_angka IS 'Niai angka dari olah nilai';


--
-- TOC entry 4145 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN mahasiswa_remidi.approval; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_remidi.approval IS '0 = tunggu\n1 = disetujui';


--
-- TOC entry 4146 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN mahasiswa_remidi.validasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_remidi.validasi IS '1 = valid\n0 = belum validasi';


--
-- TOC entry 228 (class 1259 OID 24816)
-- Name: mahasiswa_rencana_remidi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.mahasiswa_rencana_remidi (
    id_mahasiswa_krs uuid NOT NULL,
    id_registrasi_mahasiswa uuid[] NOT NULL,
    id_mahasiswa uuid,
    id_prodi uuid NOT NULL,
    id_matakuliah_rencana_remidi_ditawarkan uuid NOT NULL,
    nilai_angka numeric(4,2),
    nilai_indeks numeric(2,2),
    nilai_huruf character varying(2),
    status_krs character(1),
    approval character(1) DEFAULT 0,
    tgl_insert timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validasi character(1) DEFAULT 0
);


--
-- TOC entry 4147 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.nilai_angka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.nilai_angka IS 'Niai angka dari olah nilai';


--
-- TOC entry 4148 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.nilai_indeks; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.nilai_indeks IS 'nilai indeks \nA = 4\nAB = 3.5\nB = 3\nBC  2.5\nC = 2\nCD = 1.5\nD = 1\nE = 0';


--
-- TOC entry 4149 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.nilai_huruf; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.nilai_huruf IS 'A \nAB \nB \nBC \nC\nCD \nD';


--
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.status_krs; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.status_krs IS '1 : KRS \n2: Batal Tambah';


--
-- TOC entry 4151 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.approval; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.approval IS '0 = tunggu\n1 = disetujui';


--
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.validasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.validasi IS '1 = valid\n0 = belum validasi';


--
-- TOC entry 250 (class 1259 OID 25285)
-- Name: master_agama; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_agama (
    id_agama smallint NOT NULL,
    nama_agama character varying(50) NOT NULL
);


--
-- TOC entry 4153 (class 0 OID 0)
-- Dependencies: 250
-- Name: TABLE master_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_agama IS 'GetAgama\n\n{\n            "id_agama": 2,\n            "nama_agama": "Kristen"\n        },\n        {\n            "id_agama": 5,\n            "nama_agama": "Budha"\n        },\n        {\n            "id_agama": 4,\n            "nama_agama": "Hindu"\n        },\n        {\n            "id_agama": 1,\n            "nama_agama": "Islam"\n        },\n        {\n            "id_agama": 99,\n            "nama_agama": "Lainnya"\n        },\n        {\n            "id_agama": 3,\n            "nama_agama": "Katolik"\n        },\n        {\n            "id_agama": 6,\n            "nama_agama": "Khonghucu"\n        }';


--
-- TOC entry 261 (class 1259 OID 32922)
-- Name: master_alat_transportasi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_alat_transportasi (
    id_alat_transportasi smallint NOT NULL,
    nama_alat_transportasi character varying(100)
);


--
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 261
-- Name: TABLE master_alat_transportasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_alat_transportasi IS 'GetAlatTransportasi\n{\n            "id_alat_transportasi": "11",\n            "nama_alat_transportasi": "Kuda"\n        },\n        {\n            "id_alat_transportasi": "4",\n            "nama_alat_transportasi": "Mobil/bus antar jemput"\n        },\n        {\n            "id_alat_transportasi": "8",\n            "nama_alat_transportasi": "Perahu penyeberangan/rakit/getek"\n        },\n        {\n            "id_alat_transportasi": "13",\n            "nama_alat_transportasi": "Sepeda motor"\n        },\n        {\n            "id_alat_transportasi": "1",\n            "nama_alat_transportasi": "Jalan kaki"\n        },\n        {\n            "id_alat_transportasi": "99",\n            "nama_alat_transportasi": "Lainnya"\n        },\n        {\n            "id_alat_transportasi": "14",\n            "nama_alat_transportasi": "Mobil pribadi"\n        },\n        {\n            "id_alat_transportasi": "6",\n            "nama_alat_transportasi": "Ojek"\n        },\n        {\n            "id_alat_transportasi": "5",\n            "nama_alat_transportasi": "Kereta api"\n        },\n        {\n            "id_alat_transportasi": "12",\n            "nama_alat_transportasi": "Sepeda"\n        },\n        {\n            "id_alat_transportasi": "3",\n            "nama_alat_transportasi": "Angkutan umum/bus/pete-pete"\n        },\n        {\n            "id_alat_transportasi": "7",\n            "nama_alat_transportasi": "Andong/bendi/sado/dokar/delman/becak"\n        }';


--
-- TOC entry 266 (class 1259 OID 33697)
-- Name: master_angkatan_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_angkatan_mahasiswa (
    id_angkatan_mahasiswa uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_angkatan_mahasiswa character varying(100),
    id_kurikulum uuid,
    id_tahun_akademik uuid,
    id_semester character(5),
    id_prodi uuid,
    nama_program_studi character varying(100)
);


--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN master_angkatan_mahasiswa.nama_angkatan_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_angkatan_mahasiswa.nama_angkatan_mahasiswa IS 'Nama ANgkatan Mahasiswa';


--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN master_angkatan_mahasiswa.id_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_angkatan_mahasiswa.id_kurikulum IS 'dari tabel kurikulum';


--
-- TOC entry 251 (class 1259 OID 25290)
-- Name: master_jalur_masuk; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_jalur_masuk (
    id_jalur_masuk smallint NOT NULL,
    nama_jalur_masuk character varying(50) NOT NULL
);


--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 251
-- Name: TABLE master_jalur_masuk; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_jalur_masuk IS 'GetJalurMasuk\n{\n            "id_jalur_masuk": "11",\n            "nama_jalur_masuk": "Program Kerjasama Perusahaan/Institusi/Pemerintah"\n        },\n        {\n            "id_jalur_masuk": "4",\n            "nama_jalur_masuk": "Prestasi"\n        },\n        {\n            "id_jalur_masuk": "3",\n            "nama_jalur_masuk": "Penelusuran Minat dan Kemampuan (PMDK)"\n        },\n        {\n            "id_jalur_masuk": "12",\n            "nama_jalur_masuk": "Seleksi Mandiri"\n        },\n        {\n            "id_jalur_masuk": "13",\n            "nama_jalur_masuk": "Ujian Masuk Bersama Lainnya"\n        },\n        {\n            "id_jalur_masuk": "14",\n            "nama_jalur_masuk": "Seleksi Nasional Berdasarkan Tes (SNBT)"\n        },\n        {\n            "id_jalur_masuk": "15",\n            "nama_jalur_masuk": "Seleksi Nasional Berdasarkan Prestasi (SNBP)"\n        },\n        {\n            "id_jalur_masuk": "9",\n            "nama_jalur_masuk": "Program Internasional"\n        }';


--
-- TOC entry 252 (class 1259 OID 25295)
-- Name: master_jenis_keluar; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_jenis_keluar (
    id_jenis_keluar smallint NOT NULL,
    jenis_keluar character varying(50) NOT NULL
);


--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 252
-- Name: TABLE master_jenis_keluar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_jenis_keluar IS 'GetJenisKeluar\n{\n            "id_jenis_keluar": "5",\n            "jenis_keluar": "Putus Studi",\n            "apa_mahasiswa": "1"\n        },\n        {\n            "id_jenis_keluar": "3",\n            "jenis_keluar": "Dikeluarkan",\n            "apa_mahasiswa": "1"\n        },\n        {\n            "id_jenis_keluar": "9",\n            "jenis_keluar": "Pensiun",\n            "apa_mahasiswa": "0"\n        },\n        {\n            "id_jenis_keluar": "2",\n            "jenis_keluar": "Mutasi",\n            "apa_mahasiswa": "1"\n        },\n        {\n            "id_jenis_keluar": "4",\n            "jenis_keluar": "Mengundurkan diri",\n            "apa_mahasiswa": "1"\n        },\n        {\n            "id_jenis_keluar": "1",\n            "jenis_keluar": "Lulus",\n            "apa_mahasiswa": "1"\n        },\n        {\n            "id_jenis_keluar": "0",\n            "jenis_keluar": "Selesai Pendidikan Non Gelar",\n            "apa_mahasiswa": "1"\n        },\n        {\n            "id_jenis_keluar": "6",\n            "jenis_keluar": "Wafat",\n            "apa_mahasiswa": "1"\n        },\n        {\n            "id_jenis_keluar": "8",\n            "jenis_keluar": "Alih Fungsi",\n            "apa_mahasiswa": "0"\n        }';


--
-- TOC entry 265 (class 1259 OID 33608)
-- Name: master_jenis_matakuliah; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_jenis_matakuliah (
    id_jenis_mata_kuliah character(1) NOT NULL,
    nama_jenis_mata_kuliah character varying(100)
);


--
-- TOC entry 253 (class 1259 OID 25300)
-- Name: master_jenis_perndaftaran; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_jenis_perndaftaran (
    id_jenis_daftar smallint NOT NULL,
    nama_jenis_daftar character varying(50) NOT NULL,
    untuk_daftar_sekolah integer
);


--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 253
-- Name: TABLE master_jenis_perndaftaran; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_jenis_perndaftaran IS '{\n            "id_jenis_daftar": "13",\n            "nama_jenis_daftar": "RPL Perolehan SKS",\n            "untuk_daftar_sekolah": "1"\n        },\n        {\n            "id_jenis_daftar": "14",\n            "nama_jenis_daftar": "Pendidikan Non Gelar (Course)",\n            "untuk_daftar_sekolah": "1"\n        },\n        {\n            "id_jenis_daftar": "15",\n            "nama_jenis_daftar": "Fast Track",\n            "untuk_daftar_sekolah": "1"\n        },\n        {\n            "id_jenis_daftar": "16",\n            "nama_jenis_daftar": "RPL Transfer SKS",\n            "untuk_daftar_sekolah": "1"\n        },\n        {\n            "id_jenis_daftar": "5",\n            "nama_jenis_daftar": "Mengulang",\n            "untuk_daftar_sekolah": "0"\n        },\n        {\n            "id_jenis_daftar": "3",\n            "nama_jenis_daftar": "Naik kelas",\n            "untuk_daftar_sekolah": "0"\n        },\n        {\n            "id_jenis_daftar": "1",\n            "nama_jenis_daftar": "Peserta didik baru",\n            "untuk_daftar_sekolah": "1"\n        },\n        {\n            "id_jenis_daftar": "8",\n            "nama_jenis_daftar": "Pindahan Alih Bentuk",\n            "untuk_daftar_sekolah": "0"\n        },\n        {\n            "id_jenis_daftar": "6",\n            "nama_jenis_daftar": "Lanjutan semester",\n            "untuk_daftar_sekolah": "0"\n        },\n        {\n            "id_jenis_daftar": "2",\n            "nama_jenis_daftar": "Pindahan",\n            "untuk_daftar_sekolah": "1"\n        },\n        {\n            "id_jenis_daftar": "4",\n            "nama_jenis_daftar": "Akselerasi",\n            "untuk_daftar_sekolah": "0"\n        }';


--
-- TOC entry 263 (class 1259 OID 32932)
-- Name: master_jenis_prestasi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_jenis_prestasi (
    id_jenis_prestasi smallint NOT NULL,
    nama_jenis_prestasi character varying(50)
);


--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 263
-- Name: TABLE master_jenis_prestasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_jenis_prestasi IS 'GetJenisPrestasi\n {\n            "id_jenis_prestasi": 3,\n            "nama_jenis_prestasi": "Olahraga"\n        },\n        {\n            "id_jenis_prestasi": 2,\n            "nama_jenis_prestasi": "Seni"\n        },\n        {\n            "id_jenis_prestasi": 1,\n            "nama_jenis_prestasi": "Sains"\n        },\n        {\n            "id_jenis_prestasi": 9,\n            "nama_jenis_prestasi": "Lain-lain"\n        }';


--
-- TOC entry 254 (class 1259 OID 25305)
-- Name: master_jenis_tinggal; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_jenis_tinggal (
    id_jenis_tinggal smallint NOT NULL,
    nama_jenis_tinggal character varying(50) NOT NULL
);


--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 254
-- Name: TABLE master_jenis_tinggal; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_jenis_tinggal IS 'GetJenisTinggal\n{\n            "id_jenis_tinggal": "10",\n            "nama_jenis_tinggal": "Rumah sendiri"\n        },\n        {\n            "id_jenis_tinggal": "4",\n            "nama_jenis_tinggal": "Asrama"\n        },\n        {\n            "id_jenis_tinggal": "5",\n            "nama_jenis_tinggal": "Panti asuhan"\n        },\n        {\n            "id_jenis_tinggal": "1",\n            "nama_jenis_tinggal": "Bersama orang tua"\n        },\n        {\n            "id_jenis_tinggal": "3",\n            "nama_jenis_tinggal": "Kost"\n        },\n        {\n            "id_jenis_tinggal": "2",\n            "nama_jenis_tinggal": "Wali"\n        },\n        {\n            "id_jenis_tinggal": "99",\n            "nama_jenis_tinggal": "Lainnya"\n        }';


--
-- TOC entry 255 (class 1259 OID 25310)
-- Name: master_jenjang_pendidikan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_jenjang_pendidikan (
    id_jenjang_didik smallint NOT NULL,
    nama_jenjang_didik character varying(50) NOT NULL
);


--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 255
-- Name: TABLE master_jenjang_pendidikan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_jenjang_pendidikan IS 'GetJenjangPendidikan\n {\n            "id_jenjang_didik": "8",\n            "nama_jenjang_didik": "Paket B"\n        },\n        {\n            "id_jenjang_didik": "37",\n            "nama_jenjang_didik": "Sp-2"\n        },\n        {\n            "id_jenjang_didik": "9",\n            "nama_jenjang_didik": "Paket C"\n        },\n        {\n            "id_jenjang_didik": "30",\n            "nama_jenjang_didik": "S1"\n        },\n        {\n            "id_jenjang_didik": "0",\n            "nama_jenjang_didik": "Tidak sekolah"\n        },\n        {\n            "id_jenjang_didik": "5",\n            "nama_jenjang_didik": "SMP / sederajat"\n        },\n        {\n            "id_jenjang_didik": "3",\n            "nama_jenjang_didik": "Putus SD"\n        },\n        {\n            "id_jenjang_didik": "35",\n            "nama_jenjang_didik": "S2"\n        },\n        {\n            "id_jenjang_didik": "32",\n            "nama_jenjang_didik": "Sp-1"\n        },\n        {\n            "id_jenjang_didik": "1",\n            "nama_jenjang_didik": "PAUD"\n        },\n        {\n            "id_jenjang_didik": "20",\n            "nama_jenjang_didik": "D1"\n        },\n        {\n            "id_jenjang_didik": "4",\n            "nama_jenjang_didik": "SD / sederajat"\n        },\n        {\n            "id_jenjang_didik": "91",\n            "nama_jenjang_didik": "Informal"\n        },\n        {\n            "id_jenjang_didik": "31",\n            "nama_jenjang_didik": "Profesi"\n        },\n        {\n            "id_jenjang_didik": "36",\n            "nama_jenjang_didik": "S2 Terapan"\n        },\n        {\n            "id_jenjang_didik": "41",\n            "nama_jenjang_didik": "S3 Terapan"\n        },\n        {\n            "id_jenjang_didik": "6",\n            "nama_jenjang_didik": "SMA / sederajat"\n        },\n        {\n            "id_jenjang_didik": "40",\n            "nama_jenjang_didik": "S3"\n        },\n        {\n            "id_jenjang_didik": "2",\n            "nama_jenjang_didik": "TK / sederajat"\n        },\n        {\n            "id_jenjang_didik": "90",\n            "nama_jenjang_didik": "Non formal"\n        },\n        {\n            "id_jenjang_didik": "7",\n            "nama_jenjang_didik": "Paket A"\n        },\n        {\n            "id_jenjang_didik": "23",\n            "nama_jenjang_didik": "D4"\n        },\n        {\n            "id_jenjang_didik": "22",\n            "nama_jenjang_didik": "D3"\n        },\n        {\n            "id_jenjang_didik": "21",\n            "nama_jenjang_didik": "D2"\n        },\n        {\n            "id_jenjang_didik": "99",\n            "nama_jenjang_didik": "Lainnya"\n        }';


--
-- TOC entry 229 (class 1259 OID 24824)
-- Name: master_kegiatan_perkuliahan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_kegiatan_perkuliahan (
    id_master_kegiatan_perkuliahan uuid NOT NULL,
    nama_kegiatan_perkuliahan uuid NOT NULL,
    status_data character(1) DEFAULT 1
);


--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 229
-- Name: COLUMN master_kegiatan_perkuliahan.status_data; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_kegiatan_perkuliahan.status_data IS '0 = tidak aktif\n1 = aktif';


--
-- TOC entry 230 (class 1259 OID 24828)
-- Name: master_kelas_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_kelas_mahasiswa (
    id_master_kelas_mahasiswa uuid NOT NULL,
    nama_kelas character varying(250) NOT NULL,
    id_prodi uuid NOT NULL,
    id_semester character(5) NOT NULL,
    nama_program_studi character varying
);


--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE master_kelas_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_kelas_mahasiswa IS 'master kelompok SGD untuk memasukan kelas yang berbeda kurikulum atau kode matakuliah';


--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 230
-- Name: COLUMN master_kelas_mahasiswa.nama_program_studi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_kelas_mahasiswa.nama_program_studi IS 'nama program studi';


--
-- TOC entry 221 (class 1259 OID 24775)
-- Name: master_kode_pembayaran; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_kode_pembayaran (
    id_kode_pembayaran uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    kode_rekening character varying(6),
    nama_rekening character varying,
    id_prodi uuid,
    status boolean DEFAULT true,
    nama_program_studi character varying(100)
);


--
-- TOC entry 4166 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN master_kode_pembayaran.id_kode_pembayaran; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_kode_pembayaran.id_kode_pembayaran IS 'id kode pembayaran';


--
-- TOC entry 4167 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN master_kode_pembayaran.status; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_kode_pembayaran.status IS '0 tidak aktif\n1 aktif';


--
-- TOC entry 233 (class 1259 OID 24843)
-- Name: master_matakuliah; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_matakuliah (
    id_matkul uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    kode_mata_kuliah character varying(20) NOT NULL,
    nama_mata_kuliah character varying(200) NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_jenis_mata_kuliah character(1),
    id_kelompok_mata_kuliah character(1),
    sks_mata_kuliah numeric(5,0) DEFAULT 0 NOT NULL,
    sks_tatap_muka numeric(5,0) DEFAULT 0 NOT NULL,
    sks_praktek numeric(5,0) DEFAULT 0 NOT NULL,
    sks_praktek_lapangan numeric(5,0) DEFAULT 0 NOT NULL,
    sks_simulasi numeric(5,0) DEFAULT 0 NOT NULL,
    metode_kuliah character(50),
    ada_sap numeric(1,0),
    ada_silabus numeric(1,0),
    ada_bahan_ajar numeric(1,0),
    ada_acara_praktek numeric(1,0),
    ada_diktat numeric(1,0),
    tanggal_mulai_efektif date,
    tanggal_akhir_efektif date
);


--
-- TOC entry 4168 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE master_matakuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_matakuliah IS 'master matakuliah';


--
-- TOC entry 4169 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_matkul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_matkul IS 'Primary Key, kosongkan ketika mode Tambah';


--
-- TOC entry 4170 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.kode_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.kode_mata_kuliah IS 'Kode Matakuliah';


--
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.nama_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.nama_mata_kuliah IS 'Nama Matakuliah';


--
-- TOC entry 4172 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_prodi IS 'ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4173 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.nama_program_studi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.nama_program_studi IS 'detail ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4174 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_jenis_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_jenis_mata_kuliah IS 'A=Wajib, B=Pilihan, C=Wajib Peminatan, D=Pilihan Peminatan, S=Tugas akhir/Skripsi/Tesis/Disertasi';


--
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_kelompok_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_kelompok_mata_kuliah IS 'A=MPK, B=MKK, C=MKB, D=MPB, E=MBB, F=MKU/MKDU, G=MKDK, H=MKK';


--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_mata_kuliah IS 'SKS Total';


--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_tatap_muka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_tatap_muka IS 'SKS teori';


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_praktek; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_praktek IS 'SKS Praktikum';


--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_praktek_lapangan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_praktek_lapangan IS 'SKS Praktek Lapangan';


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_simulasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_simulasi IS 'SKS Simulasi';


--
-- TOC entry 231 (class 1259 OID 24833)
-- Name: master_parameter_penilaian; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_parameter_penilaian (
    id_master_parameter_penilaian uuid NOT NULL,
    id_prodi uuid,
    nama_program_studi character varying,
    id_semester character(5),
    ">=a" numeric(8,2) NOT NULL,
    ">=ab" numeric(8,2) NOT NULL,
    ">=b" numeric(8,2) NOT NULL,
    ">=bc" numeric(8,2) NOT NULL,
    ">=c" numeric(8,2) NOT NULL,
    ">=cd" numeric(8,2) NOT NULL,
    ">=d" numeric(8,2) NOT NULL,
    id_matkul uuid NOT NULL,
    nama_mata_kuliah character varying(200),
    id_matakuliah_krs_ditawarkan uuid NOT NULL
);


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 231
-- Name: TABLE master_parameter_penilaian; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_parameter_penilaian IS 'parameter penilaian';


--
-- TOC entry 259 (class 1259 OID 25330)
-- Name: master_pekerjaan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_pekerjaan (
    id_pekerjaan smallint NOT NULL,
    nama_pekerjaan character varying(100)
);


--
-- TOC entry 4182 (class 0 OID 0)
-- Dependencies: 259
-- Name: TABLE master_pekerjaan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_pekerjaan IS 'GetPekerjaan\n {\n            "id_pekerjaan": 15,\n            "nama_pekerjaan": "Magang"\n        },\n        {\n            "id_pekerjaan": 16,\n            "nama_pekerjaan": "Tenaga Pengajar / Instruktur / Fasiltator"\n        },\n        {\n            "id_pekerjaan": 17,\n            "nama_pekerjaan": "Pimpinan / Manajerial"\n        },\n        {\n            "id_pekerjaan": 8,\n            "nama_pekerjaan": "Pedagang Besar"\n        },\n        {\n            "id_pekerjaan": 6,\n            "nama_pekerjaan": "Karyawan Swasta"\n        },\n        {\n            "id_pekerjaan": 11,\n            "nama_pekerjaan": "Buruh"\n        },\n        {\n            "id_pekerjaan": 10,\n            "nama_pekerjaan": "Wirausaha"\n        },\n        {\n            "id_pekerjaan": 5,\n            "nama_pekerjaan": "PNS/TNI/Polri"\n        },\n        {\n            "id_pekerjaan": 12,\n            "nama_pekerjaan": "Pensiunan"\n        },\n        {\n            "id_pekerjaan": 4,\n            "nama_pekerjaan": "Peternak"\n        },\n        {\n            "id_pekerjaan": 9,\n            "nama_pekerjaan": "Wiraswasta"\n        },\n        {\n            "id_pekerjaan": 99,\n            "nama_pekerjaan": "Lainnya"\n        },\n        {\n            "id_pekerjaan": 3,\n            "nama_pekerjaan": "Petani"\n        },\n        {\n            "id_pekerjaan": 98,\n            "nama_pekerjaan": "Sudah Meninggal"\n        },\n        {\n            "id_pekerjaan": 1,\n            "nama_pekerjaan": "Tidak bekerja"\n        },\n        {\n            "id_pekerjaan": 7,\n            "nama_pekerjaan": "Pedagang Kecil"\n        },\n        {\n            "id_pekerjaan": 2,\n            "nama_pekerjaan": "Nelayan"\n        },\n        {\n            "id_pekerjaan": 13,\n            "nama_pekerjaan": "Peneliti"\n        },\n        {\n            "id_pekerjaan": 14,\n            "nama_pekerjaan": "Tim Ahli / Konsultan"\n        }';


--
-- TOC entry 262 (class 1259 OID 32927)
-- Name: master_pembiayaan_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_pembiayaan_mahasiswa (
    id_pembiayaan smallint NOT NULL,
    nama_pembiayaan character varying(50)
);


--
-- TOC entry 4183 (class 0 OID 0)
-- Dependencies: 262
-- Name: TABLE master_pembiayaan_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_pembiayaan_mahasiswa IS 'GetPembiayaan \n{\n            "id_pembiayaan": "1",\n            "nama_pembiayaan": "Mandiri"\n        },\n        {\n            "id_pembiayaan": "2",\n            "nama_pembiayaan": "Beasiswa Tidak Penuh"\n        },\n        {\n            "id_pembiayaan": "3",\n            "nama_pembiayaan": "Beasiswa Penuh"\n        }';


--
-- TOC entry 258 (class 1259 OID 25325)
-- Name: master_penghasilan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_penghasilan (
    id_penghasilan smallint NOT NULL,
    nama_penghasilan character varying(100) NOT NULL
);


--
-- TOC entry 4184 (class 0 OID 0)
-- Dependencies: 258
-- Name: TABLE master_penghasilan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_penghasilan IS 'GetPenghasilan\n{\n            "id_penghasilan": 15,\n            "nama_penghasilan": "Rp. 5,000,000 - Rp. 20,000,000"\n        },\n        {\n            "id_penghasilan": 16,\n            "nama_penghasilan": "Lebih dari Rp. 20,000,000"\n        },\n        {\n            "id_penghasilan": 11,\n            "nama_penghasilan": "Kurang dari Rp. 500,000"\n        },\n        {\n            "id_penghasilan": 14,\n            "nama_penghasilan": "Rp. 2,000,000 - Rp. 4,999,999"\n        },\n        {\n            "id_penghasilan": 0,\n            "nama_penghasilan": ""\n        },\n        {\n            "id_penghasilan": 13,\n            "nama_penghasilan": "Rp. 1,000,000 - Rp. 1,999,999"\n        },\n        {\n            "id_penghasilan": 12,\n            "nama_penghasilan": "Rp. 500,000 - Rp. 999,999"\n        }';


--
-- TOC entry 260 (class 1259 OID 32917)
-- Name: master_prodi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_prodi (
    id_prodi uuid NOT NULL,
    kode_program_studi character(5) NOT NULL,
    nama_program_studi character varying(100) NOT NULL,
    status character(1) NOT NULL,
    id_jenjang_pendidikan smallint NOT NULL,
    nama_jenjang_pendidikan character varying(30)
);


--
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE master_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_prodi IS 'GetProdi\n{\n            "id_prodi": "b1a89424-45fe-4b10-9ba3-113636e09f5e",\n            "kode_program_studi": "15901",\n            "nama_program_studi": "Pendidikan Profesi Bidan",\n            "status": "A",\n            "id_jenjang_pendidikan": "31",\n            "nama_jenjang_pendidikan": "Profesi"\n        }';


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 260
-- Name: COLUMN master_prodi.status; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_prodi.status IS 'A atau N';


--
-- TOC entry 257 (class 1259 OID 25320)
-- Name: master_status_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_status_mahasiswa (
    id_status_mahasiswa character(1) NOT NULL,
    nama_status_mahasiswa character varying(50)
);


--
-- TOC entry 4187 (class 0 OID 0)
-- Dependencies: 257
-- Name: TABLE master_status_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_status_mahasiswa IS 'GetStatusMahasiswa\n{\n            "id_status_mahasiswa": "N",\n            "nama_status_mahasiswa": "Non-Aktif                           "\n        },\n        {\n            "id_status_mahasiswa": "C",\n            "nama_status_mahasiswa": "Cuti"\n        },\n        {\n            "id_status_mahasiswa": "G",\n            "nama_status_mahasiswa": "Sedang Double Degree"\n        },\n        {\n            "id_status_mahasiswa": "M",\n            "nama_status_mahasiswa": "Kampus Merdeka"\n        },\n        {\n            "id_status_mahasiswa": "A",\n            "nama_status_mahasiswa": "Aktif"\n        }';


--
-- TOC entry 232 (class 1259 OID 24838)
-- Name: master_tagihan_angkatan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_tagihan_angkatan (
    id_tagihan_angkatan uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_angkatan_mahasiswa uuid,
    id_semester character(5),
    id_kode_pembayaran uuid,
    kode_rekening character varying(6),
    nama_rekening character varying,
    biaya character varying,
    id_tahun_akademik uuid,
    id_prodi uuid,
    nama_program_studi character varying
);


--
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 232
-- Name: COLUMN master_tagihan_angkatan.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tagihan_angkatan.id_semester IS 'id semester berlaku';


--
-- TOC entry 248 (class 1259 OID 25218)
-- Name: master_tahun_akademik; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_tahun_akademik (
    id_semester character(5) NOT NULL,
    tahun_mulai numeric(4,0),
    "tahun selesai" numeric(4,0),
    nama_semester character varying(50),
    tgl_create date DEFAULT CURRENT_DATE,
    tgl_update date DEFAULT CURRENT_DATE,
    smt integer,
    status boolean,
    id_tahun_akademik uuid DEFAULT public.uuid_generate_v4() NOT NULL
);


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.id_semester IS 'id semester\n20201';


--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.tahun_mulai; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.tahun_mulai IS 'Tahun Mulai\n2020';


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik."tahun selesai"; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik."tahun selesai" IS 'Tahun selesai\n2021';


--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.nama_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.nama_semester IS 'Nama Semester\n2020/2021 Ganjil';


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.tgl_create; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.tgl_create IS 'Tanggal dibuat';


--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.tgl_update; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.tgl_update IS 'tgl Update';


--
-- TOC entry 4195 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.smt; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.smt IS 'semester \n1 /2';


--
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.status; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.status IS 'true false';


--
-- TOC entry 256 (class 1259 OID 25315)
-- Name: master_wilayah; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.master_wilayah (
    id_wilayah character(6) NOT NULL,
    id_level_wilayah smallint,
    id_negara character varying(3),
    nama_wilayah character varying(100),
    id_induk_wilayah character(6)
);


--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 256
-- Name: TABLE master_wilayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_wilayah IS 'GetWilayah\n {\n            "id_level_wilayah": 3,\n            "id_wilayah": "020804  ",\n            "id_negara": "ID",\n            "nama_wilayah": "Kec. Pangalengan"\n        },';


--
-- TOC entry 234 (class 1259 OID 24853)
-- Name: matakuliah_kelas_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.matakuliah_kelas_mahasiswa (
    id_matakuliah_kelas_mahasiswa uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_matakuliah_krs_ditawarkan uuid NOT NULL,
    id_matkul uuid,
    nama_mata_kuliah character varying(200),
    id_semester character(5),
    id_master_kelas_mahasiswa uuid NOT NULL
);


--
-- TOC entry 4198 (class 0 OID 0)
-- Dependencies: 234
-- Name: TABLE matakuliah_kelas_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_kelas_mahasiswa IS 'detail kelas yang akan masuk dalam generate kelas';


--
-- TOC entry 235 (class 1259 OID 24858)
-- Name: matakuliah_krs_ditawarkan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.matakuliah_krs_ditawarkan (
    id_matakuliah_krs_ditawarkan uuid NOT NULL,
    id_waktu_krs uuid NOT NULL,
    id_semester_angkatan character(5),
    id_semester character(5),
    id_matakuliah_kurikulum uuid,
    id_matkul uuid,
    nama_mata_kuliah character varying(200),
    id_prodi uuid,
    nama_program_studi character varying,
    id_tahun_akademik_angkatan uuid,
    id_tahun_akademik uuid
);


--
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE matakuliah_krs_ditawarkan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_krs_ditawarkan IS 'matakuliah krs ditawarkan';


--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN matakuliah_krs_ditawarkan.id_semester_angkatan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_krs_ditawarkan.id_semester_angkatan IS 'id angkatan mahasiswa berlaku';


--
-- TOC entry 4201 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN matakuliah_krs_ditawarkan.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_krs_ditawarkan.id_semester IS 'id semester krs berlaku';


--
-- TOC entry 238 (class 1259 OID 24873)
-- Name: matakuliah_kurikulum; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.matakuliah_kurikulum (
    id_matakuliah_kurikulum uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    id_kurikulum uuid NOT NULL,
    nama_kurikulum character varying(60),
    id_matkul uuid NOT NULL,
    nama_matkul character varying,
    semester numeric(2,0),
    id_semester character(5),
    semester_mulai_berlaku character varying,
    apakah_wajib numeric(1,0) DEFAULT 1,
    sks_mata_kuliah numeric(5,2) DEFAULT 0,
    sks_tatap_muka numeric(5,2) DEFAULT 0,
    sks_praktek numeric(5,2) DEFAULT 0,
    sks_praktek_lapangan numeric(5,2) DEFAULT 0,
    sks_simulasi numeric(5,2) DEFAULT 0,
    id_prodi uuid,
    id_tahun_akademik uuid,
    nama_program_studi character varying
);


--
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE matakuliah_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_kurikulum IS 'Matakuliah Kurikulum';


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.id_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.id_kurikulum IS 'ID Kurikulum SP. Web Service: GetListKurikulum';


--
-- TOC entry 4204 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.nama_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.nama_kurikulum IS 'Nama Matakuliah Kurikulum';


--
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.id_matkul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.id_matkul IS 'Web Service: GetListMataKuliah';


--
-- TOC entry 4206 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.nama_matkul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.nama_matkul IS 'Nama Matakuliah';


--
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.semester IS 'semester matakuliah (1,2,3...8)';


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.id_semester IS 'id semester angkatan berlaku';


--
-- TOC entry 4209 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.apakah_wajib; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.apakah_wajib IS '1:Wajib, 0:Tidak Wajib';


--
-- TOC entry 236 (class 1259 OID 24863)
-- Name: matakuliah_remidi_ditawarkan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.matakuliah_remidi_ditawarkan (
    id_matakuliah_remidi_ditawarkan uuid NOT NULL,
    id_waktu_remidi uuid NOT NULL,
    id_semester_angkatan character(5),
    id_semester character(5),
    id_matkul_kurikulum uuid,
    id_matkul uuid,
    nama_mata_kuliah character varying(200),
    id_prodi uuid,
    nama_program_studi character varying
);


--
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE matakuliah_remidi_ditawarkan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_remidi_ditawarkan IS 'matakuliah  remidi  ditawarkan';


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN matakuliah_remidi_ditawarkan.id_semester_angkatan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_remidi_ditawarkan.id_semester_angkatan IS 'id angkatan mahasiswa berlaku';


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN matakuliah_remidi_ditawarkan.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_remidi_ditawarkan.id_semester IS 'id semester krs berlaku';


--
-- TOC entry 237 (class 1259 OID 24868)
-- Name: matakuliah_rencana_remidi_ditawarkan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.matakuliah_rencana_remidi_ditawarkan (
    id_matakuliah_rencana_remidi_ditawarkan uuid NOT NULL,
    id_waktu_krs uuid NOT NULL,
    id_semester_angkatan character(5),
    id_semester character(5),
    id_matkul_kurikulum uuid,
    id_matkul uuid,
    nama_mata_kuliah character varying(200),
    id_prodi uuid,
    nama_program_studi character varying
);


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE matakuliah_rencana_remidi_ditawarkan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_rencana_remidi_ditawarkan IS 'matakuliah rencana remidi  ditawarkan';


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN matakuliah_rencana_remidi_ditawarkan.id_semester_angkatan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_rencana_remidi_ditawarkan.id_semester_angkatan IS 'id angkatan mahasiswa berlaku';


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN matakuliah_rencana_remidi_ditawarkan.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_rencana_remidi_ditawarkan.id_semester IS 'id semester krs berlaku';


--
-- TOC entry 264 (class 1259 OID 33010)
-- Name: negara; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.negara (
    id_negara character(2) NOT NULL,
    nama_negara character varying(50) NOT NULL
);


--
-- TOC entry 239 (class 1259 OID 24884)
-- Name: nilai; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.nilai (
    id_nilai uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5) NOT NULL,
    id_master_kegiatan_perkuliahan uuid NOT NULL,
    id_registrasi_mahasiswa uuid[] NOT NULL,
    nim character varying(24),
    nama_mahasiswa character(100),
    id_peserta_kelas_mahasiswa uuid NOT NULL,
    kelas character(5),
    nilai numeric(5,2) NOT NULL,
    tgl_nilai time without time zone NOT NULL,
    id_pegawai uuid NOT NULL,
    stat_nilai character(1) DEFAULT 1 NOT NULL,
    tgl_insert timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    validasi character(1) DEFAULT 0,
    id_dosen uuid
);


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE nilai; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.nilai IS 'nilai mentah';


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN nilai.stat_nilai; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.nilai.stat_nilai IS '1 : reguler\n2 : remidi';


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN nilai.validasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.nilai.validasi IS '0 = belum validasi\n1 = validasi';


--
-- TOC entry 240 (class 1259 OID 24892)
-- Name: parameter_absensi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.parameter_absensi (
    id_parameter_penilaian uuid NOT NULL,
    id_master_parameter_penilaian uuid NOT NULL,
    id_prodi uuid,
    nama_program_studi character varying,
    id_semester character(5),
    id_master_kegiatan_perkuliahan uuid NOT NULL,
    prosentase numeric(8,2) NOT NULL,
    jumlah_kegiatan numeric(2,0) NOT NULL,
    nilai_huruf character(2)
);


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE parameter_absensi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.parameter_absensi IS 'parameter penilaian';


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 240
-- Name: COLUMN parameter_absensi.nilai_huruf; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.parameter_absensi.nilai_huruf IS 'Jika prosentase tidak terpenuhi';


--
-- TOC entry 241 (class 1259 OID 24897)
-- Name: parameter_penilaian; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.parameter_penilaian (
    id_parameter_penilaian uuid NOT NULL,
    id_prodi uuid,
    nama_program_studi character varying,
    id_semester character(5),
    id_master_kegiatan_perkuliahan uuid NOT NULL,
    fungsi character(3) DEFAULT 'avg'::bpchar,
    prosentase numeric(8,2) NOT NULL,
    jumlah_kegiatan numeric(2,0) NOT NULL,
    id_master_parameter_penilaian uuid NOT NULL,
    nbl numeric(8,2),
    nilai_huruf character(2)
);


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE parameter_penilaian; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.parameter_penilaian IS 'parameter penilaian';


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN parameter_penilaian.fungsi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.parameter_penilaian.fungsi IS 'max\nsum\navg';


--
-- TOC entry 4223 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN parameter_penilaian.nilai_huruf; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.parameter_penilaian.nilai_huruf IS 'jika tidak lebih dari nbl maka langsung dapat nilai huruf ini';


--
-- TOC entry 249 (class 1259 OID 25225)
-- Name: periode_perkuliahan; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.periode_perkuliahan (
    id_periode_perkuliahan uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5),
    nama_semester character varying(50),
    jumlah_target_mahasiswa_baru integer,
    tanggal_awal_perkuliahan date,
    tanggal_akhir_perkuliahan date,
    calon_ikut_seleksi integer,
    calon_lulus_seleksi integer,
    daftar_sbg_mhs integer,
    pst_undur_diri integer,
    jml_mgu_kul integer,
    metode_kul character varying,
    metode_kul_eks character varying,
    tgl_create date DEFAULT CURRENT_DATE,
    last_update date DEFAULT CURRENT_DATE,
    status_sync character varying(10)
);


--
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE periode_perkuliahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.periode_perkuliahan IS 'Periode Perkuliahan Program Studi';


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.id_periode_perkuliahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.id_periode_perkuliahan IS 'uuid';


--
-- TOC entry 4226 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.id_prodi IS 'id Program studi';


--
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.nama_program_studi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.nama_program_studi IS 'Nama Program Studi';


--
-- TOC entry 4228 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.jumlah_target_mahasiswa_baru; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.jumlah_target_mahasiswa_baru IS 'Target Mahasiswa Baru';


--
-- TOC entry 4229 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.tanggal_awal_perkuliahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.tanggal_awal_perkuliahan IS 'Tanggal Dimulai Semester';


--
-- TOC entry 4230 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.calon_ikut_seleksi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.calon_ikut_seleksi IS 'calon maba';


--
-- TOC entry 4231 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.calon_lulus_seleksi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.calon_lulus_seleksi IS 'calon lulus seleksi';


--
-- TOC entry 4232 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.daftar_sbg_mhs; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.daftar_sbg_mhs IS 'daftar registrasi';


--
-- TOC entry 4233 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.pst_undur_diri; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.pst_undur_diri IS 'mahasiswa mengundurkan diri';


--
-- TOC entry 4234 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.jml_mgu_kul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.jml_mgu_kul IS 'Jumlah minggu kuliah';


--
-- TOC entry 4235 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.tgl_create; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.tgl_create IS 'Tanggal Insert';


--
-- TOC entry 4236 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.last_update; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.last_update IS 'tgl update';


--
-- TOC entry 4237 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.status_sync; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.status_sync IS 'sudah sync\nbelum sync';


--
-- TOC entry 242 (class 1259 OID 24903)
-- Name: peserta_absensi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.peserta_absensi (
    id_peserta_absensi uuid NOT NULL,
    id_absensi_perkuliahan uuid NOT NULL,
    id_registrasi_mahasiswa uuid[],
    tgl_insert timestamp without time zone,
    tgl_absen time without time zone NOT NULL
);


--
-- TOC entry 243 (class 1259 OID 24908)
-- Name: peserta_kelas_mahasiswa; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.peserta_kelas_mahasiswa (
    id_peserta_kelas_mahasiswa uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5),
    id_registrasi_mahasiswa uuid[],
    id_mahasiswa uuid,
    nama_mahasiswa character(100),
    nim character varying(24),
    id_master_kelas_mahasiswa uuid,
    kelas character(5),
    id_matakuliah_krs_ditawarkan uuid,
    id_lokasi_perkuliahan uuid NOT NULL
);


--
-- TOC entry 244 (class 1259 OID 24913)
-- Name: waktu_krs; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.waktu_krs (
    id_waktu_krs uuid DEFAULT public.uuid_generate_v4() NOT NULL,
    nama_krs character varying,
    id_prodi uuid,
    nama_program_studi character varying,
    id_semester character(5),
    id_tahun_akademik uuid,
    nama_semester character varying(50),
    status_data character varying DEFAULT 'Aktif'::character varying,
    tgl_mulai timestamp without time zone,
    tgl_selesai timestamp without time zone,
    tgl_toleransi_mulai timestamp without time zone,
    tgl_toleransi_selesai timestamp without time zone
);


--
-- TOC entry 245 (class 1259 OID 24918)
-- Name: waktu_remidi; Type: TABLE; Schema: siakad; Owner: -
--

CREATE TABLE siakad.waktu_remidi (
    id_waktu_remidi uuid NOT NULL,
    nama_remidi character varying,
    id_prodi uuid,
    nama_program_studi character varying,
    id_semester character(5),
    tgl_mulai time without time zone,
    tgl_selesai time without time zone,
    tgl_tolerasi_mulai time without time zone,
    tgl_toleransi_selesai time without time zone
);


--
-- TOC entry 246 (class 1259 OID 24923)
-- Name: mahasiswa_skripsi; Type: TABLE; Schema: skripsi; Owner: -
--

CREATE TABLE skripsi.mahasiswa_skripsi (
    id_mahasiswa_skripsi uuid NOT NULL,
    id_prodi uuid NOT NULL,
    nama_program_studi character varying,
    id_semester character(5) NOT NULL,
    id_semester_selesai character(5),
    judul character varying,
    judul_inggris character varying,
    status character(1) DEFAULT 1,
    id_jenis_aktivitas numeric NOT NULL
);


--
-- TOC entry 4238 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN mahasiswa_skripsi.id_semester; Type: COMMENT; Schema: skripsi; Owner: -
--

COMMENT ON COLUMN skripsi.mahasiswa_skripsi.id_semester IS 'id_semester daftar';


--
-- TOC entry 4239 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN mahasiswa_skripsi.status; Type: COMMENT; Schema: skripsi; Owner: -
--

COMMENT ON COLUMN skripsi.mahasiswa_skripsi.status IS '1 = aktif\n0 = tidak aktif';


--
-- TOC entry 4240 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN mahasiswa_skripsi.id_jenis_aktivitas; Type: COMMENT; Schema: skripsi; Owner: -
--

COMMENT ON COLUMN skripsi.mahasiswa_skripsi.id_jenis_aktivitas IS 'ID Jenis Aktivitas. Web Service : GetJenisAktivitasMahasiswa';


--
-- TOC entry 247 (class 1259 OID 24929)
-- Name: pembimbing_mahasiswa; Type: TABLE; Schema: skripsi; Owner: -
--

CREATE TABLE skripsi.pembimbing_mahasiswa (
    id_pembimbing_mahasiswa uuid NOT NULL,
    id_mahasiswa_skripsi uuid NOT NULL,
    id_kategori_kegiatan character(6) NOT NULL,
    id_dosen uuid NOT NULL,
    pemimbing_ke integer NOT NULL
);


--
-- TOC entry 4241 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN pembimbing_mahasiswa.id_kategori_kegiatan; Type: COMMENT; Schema: skripsi; Owner: -
--

COMMENT ON COLUMN skripsi.pembimbing_mahasiswa.id_kategori_kegiatan IS 'Web Service: GetKategoriKegiatan';


--
-- TOC entry 4001 (class 0 OID 24728)
-- Dependencies: 213
-- Data for Name: master_dosen_wali; Type: TABLE DATA; Schema: perwalian; Owner: -
--



--
-- TOC entry 4002 (class 0 OID 24733)
-- Dependencies: 214
-- Data for Name: penguji_mahasiswa; Type: TABLE DATA; Schema: perwalian; Owner: -
--



--
-- TOC entry 4003 (class 0 OID 24736)
-- Dependencies: 215
-- Data for Name: pesan_perwalian; Type: TABLE DATA; Schema: perwalian; Owner: -
--



--
-- TOC entry 4004 (class 0 OID 24742)
-- Dependencies: 216
-- Data for Name: tran_perwalian; Type: TABLE DATA; Schema: perwalian; Owner: -
--



--
-- TOC entry 4005 (class 0 OID 24748)
-- Dependencies: 217
-- Data for Name: waktu_perwalian; Type: TABLE DATA; Schema: perwalian; Owner: -
--



--
-- TOC entry 4006 (class 0 OID 24753)
-- Dependencies: 218
-- Data for Name: absensi_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4007 (class 0 OID 24758)
-- Dependencies: 219
-- Data for Name: aktivitas_perkuliahan_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4008 (class 0 OID 24763)
-- Dependencies: 220
-- Data for Name: biodata_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.biodata_mahasiswa VALUES ('1d77cdf6-db16-48a7-96cb-d43302b9a643', 'Dhanang Hadiyanto2', 'L', 'Kendal', '1990-12-22', 2, 'Islam', '332407211290002 ', '12345678', '12345678', 'ID', 'Indonesia', 'Jl. Raya Tulang Bawang', 'Teseh', 1, 4, 'Meteseh', 51381, '032407', 'Rumah Sendiri', 14, 'Mobil Pribadi', '08985576111', '08985576111', 'dhanang.hadiyanto2@gmail.com', 0, '123456', 'Jumadi', '2023-09-11', 37, 'Sp-2', 15, 'Magang', 15, 'Rp. 5,000,000 - Rp. 20,000,000', '1233456', 'Tukiyem', '2023-09-11', 8, 'Paket B', 15, 'Magang', 16, 'Rp. 5,000,000 - Rp. 20,000,000', NULL, '2023-11-09', 16, 'Tenaga Pengajar / Instruktur / Fasiltator', 15, 'Rp. 5,000,000 - Rp. 20,000,000', 0, NULL, 0, NULL, 0, NULL, 10, 9, 'Paket C', 'Kec. Boja - Kab. Kendal - Prov. Jawa Tengah');
INSERT INTO siakad.biodata_mahasiswa VALUES ('d7df5ffa-fd98-4941-8a68-9d8f18a80496', 'Dhanang Hadiyanto', 'L', 'Kendal', '1990-12-21', 1, 'Islam', '332407211290002 ', '12345678', '12345678', 'ID', 'Indonesia', 'Jl. Raya Tulang Bawang', 'Teseh', 1, 4, 'Meteseh', 51381, '032407', 'Rumah sendiri', 14, 'Mobil pribadi', '08985576111', '08985576111', 'dhanang.hadiyanto@gmail.com', 0, '1234566', 'Jumadi', '2023-09-11', 37, 'Sp-2', 15, 'Magang', 15, 'Rp. 5,000,000 - Rp. 20,000,000', '1233456', 'Tukiyem', '2023-09-11', 8, 'Paket B', 15, 'Magang', 16, 'Rp. 5,000,000 - Rp. 20,000,000', NULL, '2023-11-09', 16, 'Tenaga Pengajar / Instruktur / Fasiltator', 15, 'Rp. 5,000,000 - Rp. 20,000,000', 0, NULL, 0, NULL, 0, NULL, 10, 9, 'Paket C', 'Kec. Boja - Kab. Kendal - Prov. Jawa Tengah');


--
-- TOC entry 4010 (class 0 OID 24780)
-- Dependencies: 222
-- Data for Name: kurikulum; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.kurikulum VALUES ('4ef65db6-ee43-45d3-87e5-893e280179f1', 'Kurikulum farmasi 2021', '7f44428f-8665-4909-bbbe-06ebcc1da17a', '20231', 4, 2, 2, '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', 'Farmasi');


--
-- TOC entry 4011 (class 0 OID 24783)
-- Dependencies: 223
-- Data for Name: list_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.list_mahasiswa VALUES ('d904c732-e350-4d00-aaae-15ba47214e02', 'd7df5ffa-fd98-4941-8a68-9d8f18a80496', 'Dhanang Hadiyanto                                                                                   ', 'L', '1990-12-21', NULL, 1, 'Islam', '7f44428f-8665-4909-bbbe-06ebcc1da17a', 'Farmasi', 'A', 'Aktif', '33102300001', '20231', '2023/2024 Gasal', 1, 4, NULL, NULL, NULL, NULL, 1, 50000.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', '2023-09-11', NULL, NULL, NULL, NULL);
INSERT INTO siakad.list_mahasiswa VALUES ('e7e8fafa-344b-4e35-a12a-92f205d399b8', '1d77cdf6-db16-48a7-96cb-d43302b9a643', 'Dhanang Hadiyanto2                                                                                  ', 'L', '1990-12-22', NULL, 2, 'Islam', '7f44428f-8665-4909-bbbe-06ebcc1da17a', 'Farmasi', 'A', 'Aktif', '1234', '20231', '2023/2024 Gasal', 2, 4, NULL, NULL, '51c0d938-50eb-4cc8-b9eb-253658a56e29', 'eaf78fd6-b3dc-4780-bcf7-481a61ef0cfc', 2, 1234.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', '2023-09-11', '061002', 'UNIVERSITAS ISLAM SULTAN AGUNG', NULL, NULL);
INSERT INTO siakad.list_mahasiswa VALUES ('2bd8028c-21b7-4eda-8e18-f674a6ba57f4', 'd7df5ffa-fd98-4941-8a68-9d8f18a80496', 'Dhanang Hadiyanto                                                                                   ', 'L', '1990-12-21', NULL, 1, 'Islam', '7f44428f-8665-4909-bbbe-06ebcc1da17a', 'Farmasi', 'A', 'Aktif', 'wdad', '20231', '2023/2024 Gasal', 1, 3, NULL, NULL, NULL, NULL, 1, 22.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', '2023-09-11', NULL, NULL, NULL, NULL);
INSERT INTO siakad.list_mahasiswa VALUES ('27477e4d-8df4-449d-beb6-974a43c9cf31', '1d77cdf6-db16-48a7-96cb-d43302b9a643', 'Dhanang Hadiyanto2                                                                                  ', 'L', '1990-12-22', NULL, 2, 'Islam', '7f44428f-8665-4909-bbbe-06ebcc1da17a', 'Farmasi', 'A', 'Aktif', '12131', '20231', '2023/2024 Gasal', 1, 3, NULL, NULL, NULL, NULL, 1, 22.00, NULL, NULL, NULL, NULL, NULL, NULL, NULL, '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', '2023-09-11', NULL, NULL, NULL, NULL);


--
-- TOC entry 4012 (class 0 OID 24789)
-- Dependencies: 224
-- Data for Name: lokasi_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4055 (class 0 OID 33717)
-- Dependencies: 267
-- Data for Name: mahasiswa_angkatan; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.mahasiswa_angkatan VALUES ('bdb5399b-e289-4b83-a178-b1099af6ac0d', 'e7e8fafa-344b-4e35-a12a-92f205d399b8', '2023-09-16 15:06:01.594238', 'd57098b3-d806-4c27-a0f8-4d009080c1cc');
INSERT INTO siakad.mahasiswa_angkatan VALUES ('6eb122e1-f292-4269-b55c-b4e173109139', '27477e4d-8df4-449d-beb6-974a43c9cf31', '2023-09-16 15:06:12.18409', 'd57098b3-d806-4c27-a0f8-4d009080c1cc');
INSERT INTO siakad.mahasiswa_angkatan VALUES ('1ab2286a-ace5-41cd-b1ec-cd2e310187d8', '2bd8028c-21b7-4eda-8e18-f674a6ba57f4', '2023-09-16 15:06:12.18409', 'd57098b3-d806-4c27-a0f8-4d009080c1cc');


--
-- TOC entry 4013 (class 0 OID 24795)
-- Dependencies: 225
-- Data for Name: mahasiswa_krs; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4014 (class 0 OID 24803)
-- Dependencies: 226
-- Data for Name: mahasiswa_kurikulum; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4015 (class 0 OID 24808)
-- Dependencies: 227
-- Data for Name: mahasiswa_remidi; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4016 (class 0 OID 24816)
-- Dependencies: 228
-- Data for Name: mahasiswa_rencana_remidi; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4038 (class 0 OID 25285)
-- Dependencies: 250
-- Data for Name: master_agama; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_agama VALUES (1, 'Islam');
INSERT INTO siakad.master_agama VALUES (2, 'Kristen');
INSERT INTO siakad.master_agama VALUES (3, 'Katolik');
INSERT INTO siakad.master_agama VALUES (4, 'Hindu');
INSERT INTO siakad.master_agama VALUES (5, 'Budha');
INSERT INTO siakad.master_agama VALUES (6, 'Khonghucu');
INSERT INTO siakad.master_agama VALUES (9, 'Lainnya');


--
-- TOC entry 4049 (class 0 OID 32922)
-- Dependencies: 261
-- Data for Name: master_alat_transportasi; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_alat_transportasi VALUES (7, 'Andong/bendi/sado/dokar/delman/becak');
INSERT INTO siakad.master_alat_transportasi VALUES (11, 'Kuda');
INSERT INTO siakad.master_alat_transportasi VALUES (4, 'Mobil/bus antar jemput');
INSERT INTO siakad.master_alat_transportasi VALUES (8, 'Perahu penyeberangan/rakit/getek');
INSERT INTO siakad.master_alat_transportasi VALUES (13, 'Sepeda motor');
INSERT INTO siakad.master_alat_transportasi VALUES (1, 'Jalan kaki');
INSERT INTO siakad.master_alat_transportasi VALUES (99, 'Lainnya');
INSERT INTO siakad.master_alat_transportasi VALUES (14, 'Mobil pribadi');
INSERT INTO siakad.master_alat_transportasi VALUES (6, 'Ojek');
INSERT INTO siakad.master_alat_transportasi VALUES (5, 'Kereta api');
INSERT INTO siakad.master_alat_transportasi VALUES (12, 'Sepeda');
INSERT INTO siakad.master_alat_transportasi VALUES (3, 'Angkutan umum/bus/pete-pete');


--
-- TOC entry 4054 (class 0 OID 33697)
-- Dependencies: 266
-- Data for Name: master_angkatan_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_angkatan_mahasiswa VALUES ('d57098b3-d806-4c27-a0f8-4d009080c1cc', 'Farmasi Angkatan 2022/2023 Gasal Beasiswa', '4ef65db6-ee43-45d3-87e5-893e280179f1', '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', '20231', '7f44428f-8665-4909-bbbe-06ebcc1da17a', 'Farmasi');


--
-- TOC entry 4039 (class 0 OID 25290)
-- Dependencies: 251
-- Data for Name: master_jalur_masuk; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_jalur_masuk VALUES (4, 'Prestasi');
INSERT INTO siakad.master_jalur_masuk VALUES (3, 'Penelusuran Minat dan Kemampuan (PMDK)');
INSERT INTO siakad.master_jalur_masuk VALUES (12, 'Seleksi Mandiri');
INSERT INTO siakad.master_jalur_masuk VALUES (13, 'Ujian Masuk Bersama Lainnya');
INSERT INTO siakad.master_jalur_masuk VALUES (14, 'Seleksi Nasional Berdasarkan Tes (SNBT)');
INSERT INTO siakad.master_jalur_masuk VALUES (15, 'Seleksi Nasional Berdasarkan Prestasi (SNBP)');
INSERT INTO siakad.master_jalur_masuk VALUES (9, 'Program Internasional');
INSERT INTO siakad.master_jalur_masuk VALUES (11, 'Program Kerjasama Perusahaan/Institusi/Pemerintah');


--
-- TOC entry 4040 (class 0 OID 25295)
-- Dependencies: 252
-- Data for Name: master_jenis_keluar; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4053 (class 0 OID 33608)
-- Dependencies: 265
-- Data for Name: master_jenis_matakuliah; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_jenis_matakuliah VALUES ('A', 'Wajib');
INSERT INTO siakad.master_jenis_matakuliah VALUES ('B', 'Pilihan');
INSERT INTO siakad.master_jenis_matakuliah VALUES ('C', 'Wajib Peminatan');
INSERT INTO siakad.master_jenis_matakuliah VALUES ('D', 'Pilihan Peminatan');
INSERT INTO siakad.master_jenis_matakuliah VALUES ('S', 'Tugas akhir/Skripsi/Tesis/Disertasi');


--
-- TOC entry 4041 (class 0 OID 25300)
-- Dependencies: 253
-- Data for Name: master_jenis_perndaftaran; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_jenis_perndaftaran VALUES (1, 'Peserta didik baru', 1);
INSERT INTO siakad.master_jenis_perndaftaran VALUES (2, 'Pindahan', 1);
INSERT INTO siakad.master_jenis_perndaftaran VALUES (13, 'RPL Perolehan SKS', 1);
INSERT INTO siakad.master_jenis_perndaftaran VALUES (14, 'Pendidikan Non Gelar (Course)', 1);
INSERT INTO siakad.master_jenis_perndaftaran VALUES (15, 'Fast Track', 1);
INSERT INTO siakad.master_jenis_perndaftaran VALUES (16, 'RPL Transfer SKS', 1);


--
-- TOC entry 4051 (class 0 OID 32932)
-- Dependencies: 263
-- Data for Name: master_jenis_prestasi; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4042 (class 0 OID 25305)
-- Dependencies: 254
-- Data for Name: master_jenis_tinggal; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_jenis_tinggal VALUES (5, 'Panti asuhan');
INSERT INTO siakad.master_jenis_tinggal VALUES (1, 'Bersama orang tua');
INSERT INTO siakad.master_jenis_tinggal VALUES (3, 'Kost');
INSERT INTO siakad.master_jenis_tinggal VALUES (2, 'Wali');
INSERT INTO siakad.master_jenis_tinggal VALUES (99, 'Lainnya');
INSERT INTO siakad.master_jenis_tinggal VALUES (10, 'Rumah sendiri');
INSERT INTO siakad.master_jenis_tinggal VALUES (4, 'Asrama');


--
-- TOC entry 4043 (class 0 OID 25310)
-- Dependencies: 255
-- Data for Name: master_jenjang_pendidikan; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_jenjang_pendidikan VALUES (8, 'Paket B');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (37, 'Sp-2');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (9, 'Paket C');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (30, 'S1');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (0, 'Tidak sekolah');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (5, 'SMP / sederajat');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (3, 'Putus SD');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (35, 'S2');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (32, 'Sp-1');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (1, 'PAUD');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (20, 'D1');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (4, 'SD / sederajat');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (91, 'Informal');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (31, 'Profesi');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (36, 'S2 Terapan');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (41, 'S3 Terapan');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (6, 'SMA / sederajat');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (40, 'S3');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (2, 'TK / sederajat');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (90, 'Non formal');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (7, 'Paket A');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (23, 'D4');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (22, 'D3');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (21, 'D2');
INSERT INTO siakad.master_jenjang_pendidikan VALUES (99, 'Lainnya');


--
-- TOC entry 4017 (class 0 OID 24824)
-- Dependencies: 229
-- Data for Name: master_kegiatan_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4018 (class 0 OID 24828)
-- Dependencies: 230
-- Data for Name: master_kelas_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4009 (class 0 OID 24775)
-- Dependencies: 221
-- Data for Name: master_kode_pembayaran; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_kode_pembayaran VALUES ('4452f637-5d76-4cc7-818e-1654df64591f', '21212', 'UKT2', '7f44428f-8665-4909-bbbe-06ebcc1da17a', true, 'Farmasi');


--
-- TOC entry 4021 (class 0 OID 24843)
-- Dependencies: 233
-- Data for Name: master_matakuliah; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_matakuliah VALUES ('d1842e2a-cd84-4ef4-8df8-1c897084a016', 'FF3210', 'Berfikir Kritis', '7f44428f-8665-4909-bbbe-06ebcc1da17a', 'Farmasi', 'A', NULL, 6, 2, 1, 2, 1, 'SGD                                               ', NULL, NULL, NULL, NULL, NULL, '2023-09-09', '2023-09-09');


--
-- TOC entry 4019 (class 0 OID 24833)
-- Dependencies: 231
-- Data for Name: master_parameter_penilaian; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4047 (class 0 OID 25330)
-- Dependencies: 259
-- Data for Name: master_pekerjaan; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_pekerjaan VALUES (15, 'Magang');
INSERT INTO siakad.master_pekerjaan VALUES (16, 'Tenaga Pengajar / Instruktur / Fasiltator');
INSERT INTO siakad.master_pekerjaan VALUES (17, 'Pimpinan / Manajerial');
INSERT INTO siakad.master_pekerjaan VALUES (8, 'Pedagang Besar');
INSERT INTO siakad.master_pekerjaan VALUES (6, 'Karyawan Swasta');
INSERT INTO siakad.master_pekerjaan VALUES (11, 'Buruh');
INSERT INTO siakad.master_pekerjaan VALUES (10, 'Wirausaha');
INSERT INTO siakad.master_pekerjaan VALUES (5, 'PNS/TNI/Polri');
INSERT INTO siakad.master_pekerjaan VALUES (12, 'Pensiunan');
INSERT INTO siakad.master_pekerjaan VALUES (4, 'Peternak');
INSERT INTO siakad.master_pekerjaan VALUES (9, 'Wiraswasta');
INSERT INTO siakad.master_pekerjaan VALUES (99, 'Lainnya');
INSERT INTO siakad.master_pekerjaan VALUES (3, 'Petani');
INSERT INTO siakad.master_pekerjaan VALUES (98, 'Sudah Meninggal');
INSERT INTO siakad.master_pekerjaan VALUES (1, 'Tidak bekerja');
INSERT INTO siakad.master_pekerjaan VALUES (7, 'Pedagang Kecil');
INSERT INTO siakad.master_pekerjaan VALUES (2, 'Nelayan');
INSERT INTO siakad.master_pekerjaan VALUES (13, 'Peneliti');
INSERT INTO siakad.master_pekerjaan VALUES (14, 'Tim Ahli / Konsultan');


--
-- TOC entry 4050 (class 0 OID 32927)
-- Dependencies: 262
-- Data for Name: master_pembiayaan_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_pembiayaan_mahasiswa VALUES (1, 'Mandiri');
INSERT INTO siakad.master_pembiayaan_mahasiswa VALUES (2, 'Beasiswa Tidak Penuh');
INSERT INTO siakad.master_pembiayaan_mahasiswa VALUES (3, 'Beasiswa Penuh');


--
-- TOC entry 4046 (class 0 OID 25325)
-- Dependencies: 258
-- Data for Name: master_penghasilan; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_penghasilan VALUES (15, 'Rp. 5,000,000 - Rp. 20,000,000');
INSERT INTO siakad.master_penghasilan VALUES (16, 'Lebih dari Rp. 20,000,000');
INSERT INTO siakad.master_penghasilan VALUES (11, 'Kurang dari Rp. 500,000');
INSERT INTO siakad.master_penghasilan VALUES (14, 'Rp. 2,000,000 - Rp. 4,999,999');
INSERT INTO siakad.master_penghasilan VALUES (13, 'Rp. 1,000,000 - Rp. 1,999,999');
INSERT INTO siakad.master_penghasilan VALUES (12, 'Rp. 500,000 - Rp. 999,999');


--
-- TOC entry 4048 (class 0 OID 32917)
-- Dependencies: 260
-- Data for Name: master_prodi; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_prodi VALUES ('b1a89424-45fe-4b10-9ba3-113636e09f5e', '15901', 'Pendidikan Profesi Bidan', 'A', 31, 'Profesi');
INSERT INTO siakad.master_prodi VALUES ('eaf78fd6-b3dc-4780-bcf7-481a61ef0cfc', '15201', 'Kebidanan', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('91e6c205-c8dd-4555-9071-f2eb9856d4a3', '14901', 'Profesi Ners', 'A', 31, 'Profesi');
INSERT INTO siakad.master_prodi VALUES ('7245d7d3-24e1-47b1-81ed-b00ceee417a3', '61001', 'Ilmu Manajemen', 'A', 40, 'S3');
INSERT INTO siakad.master_prodi VALUES ('b7c8a388-e759-42d1-81be-794771897eb8', '61201', 'Manajemen', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('1e7c42f3-329c-4b2a-897e-237f3b71211a', '62201', 'Akuntansi', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('b56b82e3-a855-4d33-b859-4ac924bb268c', '88203', 'Pendidikan Bahasa Inggris', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('6b4a6373-9b2d-4076-9c4f-ec5523f7c8a7', '79202', 'Sastra Inggris', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('d8944e43-cd59-4d3e-9139-3c4033ff54d2', '56401', 'Teknik Komputer', 'H', 22, 'D3');
INSERT INTO siakad.master_prodi VALUES ('e860285e-8662-461f-8e60-45bf463794ce', '20201', 'Teknik Elektro', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('ac851abd-a0a9-41b7-af8e-32bf8e56670a', '86208', 'Pendidikan Agama Islam', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('04c985d0-b79c-4836-bb2b-6daf49ce1466', '11901', 'Profesi Dokter', 'A', 31, 'Profesi');
INSERT INTO siakad.master_prodi VALUES ('7f44428f-8665-4909-bbbe-06ebcc1da17a', '48201', 'Farmasi', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('2d8307a4-2e34-4786-92d3-e331abe09850', '86206', 'Pendidikan Guru Sekolah Dasar', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('b682f5dc-17ac-4752-9318-35de86c73863', '22201', 'Teknik Sipil', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('b00984eb-cff3-4b18-9a24-4d074e5ec0fc', '22101', 'Teknik Sipil', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('7ac5afc4-b4f6-454f-8bc6-66ec1f7361aa', '61101', 'Manajemen', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('38d74acd-825b-4857-9bb1-2c55426467ea', '12901', 'Dokter Gigi', 'A', 31, 'Profesi');
INSERT INTO siakad.master_prodi VALUES ('01b3a6a6-2233-407a-acaa-6e8ef4ba3eee', '14401', 'Keperawatan', 'A', 22, 'D3');
INSERT INTO siakad.master_prodi VALUES ('268a0275-4da6-461b-ae02-8c11f3b70dc5', '11201', 'Pendidikan Dokter', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('8f1fb33b-de61-4e68-9206-1e5fd0727a86', '22001', 'Teknik Sipil', 'A', 40, 'S3');
INSERT INTO siakad.master_prodi VALUES ('c6b7bda3-f56d-4fb4-ab4f-072363d289d5', '55201', 'Teknik Informatika', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('8cfae3ff-e54c-4c80-a957-bcf43c9d6c5f', '20101', 'Teknik Elektro', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('434c8c0d-9eea-4810-8d0d-16a0add5ba54', '62401', 'Akuntansi', 'A', 22, 'D3');
INSERT INTO siakad.master_prodi VALUES ('7d6debd3-3851-433d-b90b-3c38bacf6cc5', '26201', 'Teknik Industri', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('c82260e9-c2f6-4bbe-97b2-e1b1b122fa77', '14201', 'Ilmu Keperawatan', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('072c1ff7-32d0-421d-a524-7cd57e9b34f8', '61406', 'Manajemen Keuangan', 'H', 22, 'D3');
INSERT INTO siakad.master_prodi VALUES ('46d5326c-9218-47ff-b048-53fc5aa99ea2', '86108', 'Pendidikan Agama Islam', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('e578fe50-98c3-4061-b8bc-b0d31156e6f6', '70201', 'Ilmu Komunikasi', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('6d096671-cf3a-4361-bb60-a4a91f4e07d4', '73201', 'Psikologi', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('56239e7e-d909-4f74-ba71-ae80ebbfd975', '48901', 'Pendidikan Profesi Apoteker', 'A', 31, 'Profesi');
INSERT INTO siakad.master_prodi VALUES ('ef4f4881-696d-4146-95ad-e3abd08bb547', '74001', 'Ilmu Hukum', 'A', 40, 'S3');
INSERT INTO siakad.master_prodi VALUES ('2e3dde09-8156-4341-9fe4-d6cb30b52bce', '12201', 'Pendidikan Dokter Gigi', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('cffa17a7-232d-495e-9daf-a162eaf25283', '25201', 'Teknik Lingkungan', 'H', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('07bdcb4f-717e-4b94-aa32-639ac8d9c941', '88201', 'Pendidikan Bahasa dan Sastra Indonesia', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('159fae3f-a6e0-4124-95a5-7fd79de33962', '74101', 'Ilmu Hukum', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('31df5e30-e5ce-46c3-b951-5be56ce96133', '11106', 'Biomedik', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('b10f6020-0a11-4892-9004-f0e181d95216', '74230', 'Hukum Keluarga (Ahwal Syakhshiyah)', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('65147799-8978-4884-b382-217515ad9c65', '74102', 'Kenotariatan', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('a896b181-7216-4fdf-b812-1e70c96f3e77', '62101', 'Akuntansi', 'A', 35, 'S2');
INSERT INTO siakad.master_prodi VALUES ('12f2b443-19e1-4f4c-a0ea-d9f57829a117', '35201', 'Perencanaan Wilayah Dan Kota', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('b7d62023-6678-4ca3-b2ea-7f9cd04e2251', '84202', 'Pendidikan Matematika', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('9b7c984f-6eb3-485c-92f8-30f2014a5079', '15401', 'Kebidanan', 'H', 22, 'D3');
INSERT INTO siakad.master_prodi VALUES ('ac0a4ef7-3b42-4063-9742-dee709d2f249', '74201', 'Ilmu Hukum', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('f9c4e12c-361b-4909-9329-304c3583328b', '80230', 'Sejarah dan Peradaban Islam', 'A', 30, 'S1');
INSERT INTO siakad.master_prodi VALUES ('1b56b523-40eb-438d-bec2-4a938bf81ca3', '86906', 'Pendidikan Profesi Guru', 'A', 31, 'Profesi');
INSERT INTO siakad.master_prodi VALUES ('2fe3d6e3-0dd8-4cfb-bf5b-835b9f9a7962', '12101', 'Ilmu Kedokteran Gigi', 'A', 35, 'S2');


--
-- TOC entry 4045 (class 0 OID 25320)
-- Dependencies: 257
-- Data for Name: master_status_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4020 (class 0 OID 24838)
-- Dependencies: 232
-- Data for Name: master_tagihan_angkatan; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_tagihan_angkatan VALUES ('b534fda7-b147-4012-9aa2-cb6520774e26', 'd57098b3-d806-4c27-a0f8-4d009080c1cc', '20231', '4452f637-5d76-4cc7-818e-1654df64591f', '21212', 'UKT2', '200', NULL, NULL, 'Farmasi');


--
-- TOC entry 4036 (class 0 OID 25218)
-- Dependencies: 248
-- Data for Name: master_tahun_akademik; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_tahun_akademik VALUES ('20231', 2023, 2024, '2023/2024 Gasal', '2023-09-03', '2023-09-03', 1, true, '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e');


--
-- TOC entry 4044 (class 0 OID 25315)
-- Dependencies: 256
-- Data for Name: master_wilayah; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.master_wilayah VALUES ('010000', 1, 'ID', 'Prov. D.K.I. Jakarta', '000000');
INSERT INTO siakad.master_wilayah VALUES ('010100', 2, 'ID', 'Kab. Kepulauan Seribu', '010000');
INSERT INTO siakad.master_wilayah VALUES ('010101', 3, 'ID', 'Kec. Kepulauan Seribu Selatan', '010100');
INSERT INTO siakad.master_wilayah VALUES ('010102', 3, 'ID', 'Kec. Kepulauan Seribu Utara', '010100');
INSERT INTO siakad.master_wilayah VALUES ('016000', 2, 'ID', 'Kota Jakarta Pusat', '010000');
INSERT INTO siakad.master_wilayah VALUES ('016001', 3, 'ID', 'Kec. Tanah Abang', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016002', 3, 'ID', 'Kec. Menteng', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016003', 3, 'ID', 'Kec. Senen', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016004', 3, 'ID', 'Kec. Johar Baru', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016005', 3, 'ID', 'Kec. Cempaka Putih', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016006', 3, 'ID', 'Kec. Kemayoran', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016007', 3, 'ID', 'Kec. Sawah Besar', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016008', 3, 'ID', 'Kec. Gambir', '016000');
INSERT INTO siakad.master_wilayah VALUES ('016100', 2, 'ID', 'Kota Jakarta Utara', '010000');
INSERT INTO siakad.master_wilayah VALUES ('016101', 3, 'ID', 'Kec. Penjaringan', '016100');
INSERT INTO siakad.master_wilayah VALUES ('016102', 3, 'ID', 'Kec. Pademangan', '016100');
INSERT INTO siakad.master_wilayah VALUES ('016103', 3, 'ID', 'Kec. Tanjung Priok', '016100');
INSERT INTO siakad.master_wilayah VALUES ('016104', 3, 'ID', 'Kec. Koja', '016100');
INSERT INTO siakad.master_wilayah VALUES ('016105', 3, 'ID', 'Kec. Kelapa Gading', '016100');
INSERT INTO siakad.master_wilayah VALUES ('016106', 3, 'ID', 'Kec. Cilincing', '016100');
INSERT INTO siakad.master_wilayah VALUES ('016200', 2, 'ID', 'Kota Jakarta Barat', '010000');
INSERT INTO siakad.master_wilayah VALUES ('016201', 3, 'ID', 'Kec. Kembangan', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016202', 3, 'ID', 'Kec. Kebon Jeruk', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016203', 3, 'ID', 'Kec. Palmerah', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016204', 3, 'ID', 'Kec. Grogol Petamburan', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016205', 3, 'ID', 'Kec. Tambora', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016206', 3, 'ID', 'Kec. Taman Sari', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016207', 3, 'ID', 'Kec. Cengkareng', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016208', 3, 'ID', 'Kec. Kali Deres', '016200');
INSERT INTO siakad.master_wilayah VALUES ('016300', 2, 'ID', 'Kota Jakarta Selatan', '010000');
INSERT INTO siakad.master_wilayah VALUES ('016301', 3, 'ID', 'Kec. Jagakarsa', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016302', 3, 'ID', 'Kec. Pasar Minggu', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016303', 3, 'ID', 'Kec. Cilandak', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016304', 3, 'ID', 'Kec. Pesanggrahan', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016305', 3, 'ID', 'Kec. Kebayoran Lama', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016306', 3, 'ID', 'Kec. Kebayoran Baru', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016307', 3, 'ID', 'Kec. Mampang Prapatan', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016308', 3, 'ID', 'Kec. Pancoran', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016309', 3, 'ID', 'Kec. Tebet', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016310', 3, 'ID', 'Kec. Setia Budi', '016300');
INSERT INTO siakad.master_wilayah VALUES ('016400', 2, 'ID', 'Kota Jakarta Timur', '010000');
INSERT INTO siakad.master_wilayah VALUES ('016401', 3, 'ID', 'Kec. Pasar Rebo', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016402', 3, 'ID', 'Kec. Ciracas', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016403', 3, 'ID', 'Kec. Cipayung', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016404', 3, 'ID', 'Kec. Makasar', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016405', 3, 'ID', 'Kec. Kramat Jati', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016406', 3, 'ID', 'Kec. Jatinegara', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016407', 3, 'ID', 'Kec. Duren Sawit', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016408', 3, 'ID', 'Kec. Cakung', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016409', 3, 'ID', 'Kec. Pulo Gadung', '016400');
INSERT INTO siakad.master_wilayah VALUES ('016410', 3, 'ID', 'Kec. Matraman', '016400');
INSERT INTO siakad.master_wilayah VALUES ('020000', 1, 'ID', 'Prov. Jawa Barat', '000000');
INSERT INTO siakad.master_wilayah VALUES ('020500', 2, 'ID', 'Kab. Bogor', '020000');
INSERT INTO siakad.master_wilayah VALUES ('020501', 3, 'ID', 'Kec. Nanggung', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020502', 3, 'ID', 'Kec. Leuwiliang', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020503', 3, 'ID', 'Kec. Pamijahan', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020504', 3, 'ID', 'Kec. Cibungbulang', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020505', 3, 'ID', 'Kec. Ciampea', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020506', 3, 'ID', 'Kec. Dramaga', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020507', 3, 'ID', 'Kec. Ciomas', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020508', 3, 'ID', 'Kec. Cijeruk', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020509', 3, 'ID', 'Kec. Caringin', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020510', 3, 'ID', 'Kec. Ciawi', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020511', 3, 'ID', 'Kec. Cisarua', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020512', 3, 'ID', 'Kec. Megamendung', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020513', 3, 'ID', 'Kec. Sukaraja', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020514', 3, 'ID', 'Kec. Babakan Madang', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020515', 3, 'ID', 'Kec. Sukamakmur', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020516', 3, 'ID', 'Kec. Cariu', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020517', 3, 'ID', 'Kec. Jonggol', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020518', 3, 'ID', 'Kec. Cileungsi', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020519', 3, 'ID', 'Kec. Gunungputri', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020520', 3, 'ID', 'Kec. Citeureup', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020521', 3, 'ID', 'Kec. Cibinong', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020522', 3, 'ID', 'Kec. Bojong Gede', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020523', 3, 'ID', 'Kec. Kemang', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020524', 3, 'ID', 'Kec. Parung', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020525', 3, 'ID', 'Kec. Gunung Sindur', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020526', 3, 'ID', 'Kec. Rumpin', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020527', 3, 'ID', 'Kec. Cigudeg', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020528', 3, 'ID', 'Kec. Jasinga', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020529', 3, 'ID', 'Kec. Tenjo', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020530', 3, 'ID', 'Kec. Parungpanjang', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020531', 3, 'ID', 'Kec. Tamansari', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020532', 3, 'ID', 'Kec. Ciseeng', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020533', 3, 'ID', 'Kec. Kelapa Nunggal', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020534', 3, 'ID', 'Kec. Sukajaya', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020535', 3, 'ID', 'Kec. Ranca Bungur', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020536', 3, 'ID', 'Kec. Tanjung Sari', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020537', 3, 'ID', 'Kec. Tajurhalang', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020538', 3, 'ID', 'Kec. Cigombong', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020539', 3, 'ID', 'Kec. Leuwisadeng', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020540', 3, 'ID', 'Kec. Tenjolaya', '020500');
INSERT INTO siakad.master_wilayah VALUES ('020600', 2, 'ID', 'Kab. Sukabumi', '020000');
INSERT INTO siakad.master_wilayah VALUES ('020601', 3, 'ID', 'Kec. Ciemas', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020602', 3, 'ID', 'Kec. Ciracap', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020603', 3, 'ID', 'Kec. Surade', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020604', 3, 'ID', 'Kec. Jampang Kulon', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020605', 3, 'ID', 'Kec. Kalibunder', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020606', 3, 'ID', 'Kec. Tegalbuleud', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020607', 3, 'ID', 'Kec. Cidolog', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020608', 3, 'ID', 'Kec. Sagaranten', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020609', 3, 'ID', 'Kec. Pabuaran', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020610', 3, 'ID', 'Kec. Lengkong', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020611', 3, 'ID', 'Kec. Pelabuhan Ratu', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020612', 3, 'ID', 'Kec. Warung Kiara', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020613', 3, 'ID', 'Kec. Jampang Tengah', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020614', 3, 'ID', 'Kec. Cikembar', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020615', 3, 'ID', 'Kec. Nyalindung', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020616', 3, 'ID', 'Kec. Gegerbitung', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020617', 3, 'ID', 'Kec. Sukaraja', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020618', 3, 'ID', 'Kec. Sukabumi', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020619', 3, 'ID', 'Kec. Kadudampit', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020620', 3, 'ID', 'Kec. Cisaat', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020621', 3, 'ID', 'Kec. Cibadak', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020622', 3, 'ID', 'Kec. Nagrak', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020623', 3, 'ID', 'Kec. Cicurug', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020624', 3, 'ID', 'Kec. Cidahu', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020625', 3, 'ID', 'Kec. Parakansalak', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020626', 3, 'ID', 'Kec. Parungkuda', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020627', 3, 'ID', 'Kec. Kalapa Nunggal', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020628', 3, 'ID', 'Kec. Cikidang', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020629', 3, 'ID', 'Kec. Cisolok', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020630', 3, 'ID', 'Kec. Kabandungan', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020631', 3, 'ID', 'Kec. Gunung Guruh', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020632', 3, 'ID', 'Kec. Cikakak', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020633', 3, 'ID', 'Kec. Bantar Gadung', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020634', 3, 'ID', 'Kec. Cicantayan', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020635', 3, 'ID', 'Kec. Simpenan', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020636', 3, 'ID', 'Kec. Kebon Pedes', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020637', 3, 'ID', 'Kec. Cidadap', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020638', 3, 'ID', 'Kec. Cibitung', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020639', 3, 'ID', 'Kec. Curugkembar', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020640', 3, 'ID', 'Kec. Purabaya', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020641', 3, 'ID', 'Kec. Cireunghas', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020642', 3, 'ID', 'Kec. Sukalarang', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020643', 3, 'ID', 'Kec. Caringin', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020644', 3, 'ID', 'Kec. Bojong Genteng', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020645', 3, 'ID', 'Kec. Waluran', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020646', 3, 'ID', 'Kec. Cimanggu', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020647', 3, 'ID', 'Kec. Ciambar', '020600');
INSERT INTO siakad.master_wilayah VALUES ('020700', 2, 'ID', 'Kab. Cianjur', '020000');
INSERT INTO siakad.master_wilayah VALUES ('020701', 3, 'ID', 'Kec. Agrabinta', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020702', 3, 'ID', 'Kec. Sindang Barang', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020703', 3, 'ID', 'Kec. Cidaun', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020704', 3, 'ID', 'Kec. Naringgul', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020705', 3, 'ID', 'Kec. Cibinong', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020706', 3, 'ID', 'Kec. Tanggeung', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020707', 3, 'ID', 'Kec. Kadupandak', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020708', 3, 'ID', 'Kec. Takokak', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020709', 3, 'ID', 'Kec. Sukanagara', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020710', 3, 'ID', 'Kec. Pagelaran', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020711', 3, 'ID', 'Kec. Campaka', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020712', 3, 'ID', 'Kec. Cibeber', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020713', 3, 'ID', 'Kec. Warungkondang', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020714', 3, 'ID', 'Kec. Cilaku', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020715', 3, 'ID', 'Kec. Sukaluyu', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020717', 3, 'ID', 'Kec. Ciranjang', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020718', 3, 'ID', 'Kec. Mande', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020719', 3, 'ID', 'Kec. Karang Tengah', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020720', 3, 'ID', 'Kec. Cianjur', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020721', 3, 'ID', 'Kec. Cugenang', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020722', 3, 'ID', 'Kec. Pacet', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020723', 3, 'ID', 'Kec. Sukaresmi', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020724', 3, 'ID', 'Kec. Cikalong Kulon', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020725', 3, 'ID', 'Kec. Bojong Picung', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020726', 3, 'ID', 'Kec. Campaka Mulya', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020727', 3, 'ID', 'Kec. Cikadu', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020728', 3, 'ID', 'Kec. Leles', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020729', 3, 'ID', 'Kec. Cijati', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020730', 3, 'ID', 'Kec. Gekbrong', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020731', 3, 'ID', 'Kec. Cipanas', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020732', 3, 'ID', 'Kec. Haurwangi', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020733', 3, 'ID', 'Kec. Pasirkuda', '020700');
INSERT INTO siakad.master_wilayah VALUES ('020800', 2, 'ID', 'Kab. Bandung', '020000');
INSERT INTO siakad.master_wilayah VALUES ('020801', 3, 'ID', 'Kec. Ciwidey', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020802', 3, 'ID', 'Kec. Pasirjambu', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020803', 3, 'ID', 'Kec. Cimaung', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020804', 3, 'ID', 'Kec. Pangalengan', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020805', 3, 'ID', 'Kec. Kertasari', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020806', 3, 'ID', 'Kec. Pacet', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020807', 3, 'ID', 'Kec. Ibun', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020808', 3, 'ID', 'Kec. Paseh', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020809', 3, 'ID', 'Kec. Cikancung', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020810', 3, 'ID', 'Kec. Cicalengka', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020811', 3, 'ID', 'Kec. Rancaekek', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020812', 3, 'ID', 'Kec. Majalaya', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020813', 3, 'ID', 'Kec. Ciparay', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020814', 3, 'ID', 'Kec. Bale Endah', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020815', 3, 'ID', 'Kec. Arjasari', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020816', 3, 'ID', 'Kec. Banjaran', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020817', 3, 'ID', 'Kec. Pameungpeuk', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020818', 3, 'ID', 'Kec. Ketapang', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020819', 3, 'ID', 'Kec. Soreang', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020820', 3, 'ID', 'Kec. Marga Asih', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020821', 3, 'ID', 'Kec. Margahayu', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020822', 3, 'ID', 'Kec. Dayeuhkolot', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020823', 3, 'ID', 'Kec. Bojongsoang', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020824', 3, 'ID', 'Kec. Cileunyi', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020825', 3, 'ID', 'Kec. Cilengkrang', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020826', 3, 'ID', 'Kec. Cimenyan', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020829', 3, 'ID', 'Kec. Rancabali', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020830', 3, 'ID', 'Kec. Nagreg', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020831', 3, 'ID', 'Kec. Solokan Jeruk', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020832', 3, 'ID', 'Kec. Cangkuang', '020800');
INSERT INTO siakad.master_wilayah VALUES ('020833', 3, 'ID', 'Kec. Kutawaringin', '020800');
INSERT INTO siakad.master_wilayah VALUES ('021000', 2, 'ID', 'Kab. Sumedang', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021001', 3, 'ID', 'Kec. Jatinangor', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021002', 3, 'ID', 'Kec. Cimanggung', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021003', 3, 'ID', 'Kec. Tanjungsari', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021004', 3, 'ID', 'Kec. Rancakalong', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021005', 3, 'ID', 'Kec. Sumedang Selatan', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021006', 3, 'ID', 'Kec. Sumedang Utara', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021007', 3, 'ID', 'Kec. Situraja', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021008', 3, 'ID', 'Kec. Darmaraja', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021009', 3, 'ID', 'Kec. Cibugel', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021010', 3, 'ID', 'Kec. Wado', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021012', 3, 'ID', 'Kec. Tomo', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021013', 3, 'ID', 'Kec. Ujung Jaya', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021014', 3, 'ID', 'Kec. Conggeang', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021015', 3, 'ID', 'Kec. Paseh', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021016', 3, 'ID', 'Kec. Cimalaka', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021017', 3, 'ID', 'Kec. Tanjungkerta', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021018', 3, 'ID', 'Kec. Buah Dua', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021019', 3, 'ID', 'Kec. Ganeas', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021020', 3, 'ID', 'Kec. Jati Gede', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021023', 3, 'ID', 'Kec. Pamulihan', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021024', 3, 'ID', 'Kec. Cisitu', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021025', 3, 'ID', 'Kec. Jatinunggal', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021026', 3, 'ID', 'Kec. Cisarua', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021027', 3, 'ID', 'Kec. Tanjungmedar', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021028', 3, 'ID', 'Kec. Surian', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021029', 3, 'ID', 'Kec. Sukasari', '021000');
INSERT INTO siakad.master_wilayah VALUES ('021100', 2, 'ID', 'Kab. Garut', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021101', 3, 'ID', 'Kec. Talegong', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021102', 3, 'ID', 'Kec. Cisewu', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021103', 3, 'ID', 'Kec. Bungbulang', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021104', 3, 'ID', 'Kec. Pamulihan', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021105', 3, 'ID', 'Kec. Pakenjeng', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021106', 3, 'ID', 'Kec. Cikelet', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021107', 3, 'ID', 'Kec. Pameungpeuk', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021108', 3, 'ID', 'Kec. Cibalong', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021109', 3, 'ID', 'Kec. Cisompet', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021110', 3, 'ID', 'Kec. Peundeuy', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021111', 3, 'ID', 'Kec. Singajaya', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021112', 3, 'ID', 'Kec. Cikajang', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021113', 3, 'ID', 'Kec. Banjarwangi', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021114', 3, 'ID', 'Kec. Cilawu', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021115', 3, 'ID', 'Kec. Bayongbong', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021116', 3, 'ID', 'Kec. Cisurupan', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021117', 3, 'ID', 'Kec. Samarang', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021119', 3, 'ID', 'Kec. Garut Kota', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021120', 3, 'ID', 'Kec. Karangpawitan', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021121', 3, 'ID', 'Kec. Wanaraja', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021122', 3, 'ID', 'Kec. Sukawening', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021123', 3, 'ID', 'Kec. Banyuresmi', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021124', 3, 'ID', 'Kec. Leles', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021125', 3, 'ID', 'Kec. Leuwigoong', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021126', 3, 'ID', 'Kec. Cibatu', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021127', 3, 'ID', 'Kec. Cibiuk', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021128', 3, 'ID', 'Kec. Kadungora', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021129', 3, 'ID', 'Kec. Blubur Limbangan', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021130', 3, 'ID', 'Kec. Selaawi', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021131', 3, 'ID', 'Kec. Malangbong', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021132', 3, 'ID', 'Kec. Mekarmukti', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021133', 3, 'ID', 'Kec. Caringin', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021134', 3, 'ID', 'Kec. Cihurip', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021135', 3, 'ID', 'Kec. Sukaresmi', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021136', 3, 'ID', 'Kec. Pasirwangi', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021137', 3, 'ID', 'Kec. Karangtengah', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021138', 3, 'ID', 'Kec. Kersamanah', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021139', 3, 'ID', 'Kec. Tarogong Kaler', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021140', 3, 'ID', 'Kec. Tarogong Kidul', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021141', 3, 'ID', 'Kec. Cigedug', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021142', 3, 'ID', 'Kec. Sucinaraja', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021143', 3, 'ID', 'Kec. Pangatikan', '021100');
INSERT INTO siakad.master_wilayah VALUES ('021200', 2, 'ID', 'Kab. Tasikmalaya', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021201', 3, 'ID', 'Kec. Cipatujah', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021202', 3, 'ID', 'Kec. Karangnunggal', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021203', 3, 'ID', 'Kec. Cikalong', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021204', 3, 'ID', 'Kec. Panca Tengah', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021205', 3, 'ID', 'Kec. Cikatomas', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021206', 3, 'ID', 'Kec. Cibalong', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021207', 3, 'ID', 'Kec. Bantarkalong', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021208', 3, 'ID', 'Kec. Bojong Gambir', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021209', 3, 'ID', 'Kec. Sodonghilir', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021210', 3, 'ID', 'Kec. Taraju', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021211', 3, 'ID', 'Kec. Salawu', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021212', 3, 'ID', 'Kec. Tanjungjaya', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021213', 3, 'ID', 'Kec. Sukaraja', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021214', 3, 'ID', 'Kec. Salopa', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021215', 3, 'ID', 'Kec. Cineam', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021216', 3, 'ID', 'Kec. Manonjaya', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021219', 3, 'ID', 'Kec. Singaparna', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021220', 3, 'ID', 'Kec. Cigalontang', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021221', 3, 'ID', 'Kec. Leuwisari', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021223', 3, 'ID', 'Kec. Cisayong', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021224', 3, 'ID', 'Kec. Rajapolah', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021225', 3, 'ID', 'Kec. Jamanis', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021226', 3, 'ID', 'Kec. Ciawi', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021227', 3, 'ID', 'Kec. Pagerageung', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021228', 3, 'ID', 'Kec. Parung Ponteng', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021229', 3, 'ID', 'Kec. Sariwangi', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021230', 3, 'ID', 'Kec. Sukaratu', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021231', 3, 'ID', 'Kec. Sukarame', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021232', 3, 'ID', 'Kec. Bojong Asih', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021233', 3, 'ID', 'Kec. Culamega', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021234', 3, 'ID', 'Kec. Puspahiang', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021235', 3, 'ID', 'Kec. Jatiwaras', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021236', 3, 'ID', 'Kec. Mangunreja', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021237', 3, 'ID', 'Kec. Gunung Tanjung', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021238', 3, 'ID', 'Kec. Karang Jaya', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021239', 3, 'ID', 'Kec. Pada Kembang', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021240', 3, 'ID', 'Kec. Sukahening', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021241', 3, 'ID', 'Kec. Kadipaten', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021242', 3, 'ID', 'Kec. Sukaresik', '021200');
INSERT INTO siakad.master_wilayah VALUES ('021400', 2, 'ID', 'Kab. Ciamis', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021401', 3, 'ID', 'Kec. Cimerak', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021402', 3, 'ID', 'Kec. Cijulang', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021403', 3, 'ID', 'Kec. Cigugur', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021404', 3, 'ID', 'Kec. Langkaplancar', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021405', 3, 'ID', 'Kec. Parigi', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021406', 3, 'ID', 'Kec. Sidamulih', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021407', 3, 'ID', 'Kec. Pangandaran', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021408', 3, 'ID', 'Kec. Kalipucang', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021409', 3, 'ID', 'Kec. Padaherang', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021410', 3, 'ID', 'Kec. Banjarsari', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021411', 3, 'ID', 'Kec. Lakbok', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021412', 3, 'ID', 'Kec. Pamarican', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021413', 3, 'ID', 'Kec. Cidolog', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021414', 3, 'ID', 'Kec. Cimaragas', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021415', 3, 'ID', 'Kec. Cijeungjing', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021416', 3, 'ID', 'Kec. Cisaga', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021417', 3, 'ID', 'Kec. Tambaksari', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021418', 3, 'ID', 'Kec. Rancah', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021419', 3, 'ID', 'Kec. Rajadesa', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021420', 3, 'ID', 'Kec. Sukadana', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021421', 3, 'ID', 'Kec. Ciamis', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021422', 3, 'ID', 'Kec. Cikoneng', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021423', 3, 'ID', 'Kec. Cihaurbeuti', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021424', 3, 'ID', 'Kec. Sadananya', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021425', 3, 'ID', 'Kec. Cipaku', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021426', 3, 'ID', 'Kec. Jatinagara', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021427', 3, 'ID', 'Kec. Panawangan', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021428', 3, 'ID', 'Kec. Kawali', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021429', 3, 'ID', 'Kec. Panjalu', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021430', 3, 'ID', 'Kec. Panumbangan', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021431', 3, 'ID', 'Kec. Panjalu Utara/Sukamantri', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021432', 3, 'ID', 'Kec. Sindangkasih', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021433', 3, 'ID', 'Kec. Purwadadi', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021434', 3, 'ID', 'Kec. Baregbeg', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021435', 3, 'ID', 'Kec. Lumbung', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021436', 3, 'ID', 'Kec. Mangunjaya', '021400');
INSERT INTO siakad.master_wilayah VALUES ('021437', 3, 'ID', 'Sukamantri', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021490', 3, 'ID', 'Padaherang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021491', 3, 'ID', 'Kalipucang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021492', 3, 'ID', 'Pangandaran', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021493', 3, 'ID', 'Sidamulih', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021494', 3, 'ID', 'Parigi', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021495', 3, 'ID', 'Cimerak', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021496', 3, 'ID', 'Cigugur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021497', 3, 'ID', 'Langkaplancar', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021498', 3, 'ID', 'Mangunjaya', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021500', 2, 'ID', 'Kab. Kuningan', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021501', 3, 'ID', 'Kec. Darma', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021502', 3, 'ID', 'Kec. Kadugede', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021503', 3, 'ID', 'Kec. Ciniru', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021504', 3, 'ID', 'Kec. Selajambe', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021505', 3, 'ID', 'Kec. Subang', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021506', 3, 'ID', 'Kec. Ciwaru', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021507', 3, 'ID', 'Kec. Cibingbin', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021508', 3, 'ID', 'Kec. Luragung', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021509', 3, 'ID', 'Kec. Cidahu', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021510', 3, 'ID', 'Kec. Ciawigebang', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021511', 3, 'ID', 'Kec. Lebakwangi', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021512', 3, 'ID', 'Kec. Garawangi', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021513', 3, 'ID', 'Kec. Kuningan', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021514', 3, 'ID', 'Kec. Cigugur', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021515', 3, 'ID', 'Kec. Kramatmulya', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021516', 3, 'ID', 'Kec. Jalaksana', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021517', 3, 'ID', 'Kec. Cilimus', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021518', 3, 'ID', 'Kec. Mandirancan', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021519', 3, 'ID', 'Kec. Pasawahan', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021520', 3, 'ID', 'Kec. Pancalang', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021521', 3, 'ID', 'Kec. Cipicung', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021522', 3, 'ID', 'Kec. Kalimanggis', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021523', 3, 'ID', 'Kec. Japara', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021524', 3, 'ID', 'Kec. Karangkancana', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021525', 3, 'ID', 'Kec. Nusaherang', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021526', 3, 'ID', 'Kec. Cilebak', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021527', 3, 'ID', 'Kec. Hantara', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021528', 3, 'ID', 'Kec. Cimahi', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021529', 3, 'ID', 'Kec. Cibeureum', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021530', 3, 'ID', 'Kec. Sindang Agung', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021531', 3, 'ID', 'Kec. Maleber', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021532', 3, 'ID', 'Kec. Ciganda Mekar', '021500');
INSERT INTO siakad.master_wilayah VALUES ('021600', 2, 'ID', 'Kab. Majalengka', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021601', 3, 'ID', 'Kec. Lemahsugih', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021602', 3, 'ID', 'Kec. Bantarujeg', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021603', 3, 'ID', 'Kec. Cikijing', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021604', 3, 'ID', 'Kec. Talaga', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021605', 3, 'ID', 'Kec. Argapura', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021606', 3, 'ID', 'Kec. Maja', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021607', 3, 'ID', 'Kec. Majalengka', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021608', 3, 'ID', 'Kec. Cigasong', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021609', 3, 'ID', 'Kec. Sukahaji', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021610', 3, 'ID', 'Kec. Rajagaluh', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021611', 3, 'ID', 'Kec. Sindangwangi', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021612', 3, 'ID', 'Kec. Leuwimunding', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021613', 3, 'ID', 'Kec. Palasah', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021614', 3, 'ID', 'Kec. Jatiwangi', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021615', 3, 'ID', 'Kec. Dawuan', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021616', 3, 'ID', 'Kec. Panyingkiran', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021617', 3, 'ID', 'Kec. Kadipaten', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021618', 3, 'ID', 'Kec. Kertajati', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021619', 3, 'ID', 'Kec. Jatitujuh', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021620', 3, 'ID', 'Kec. Ligung', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021621', 3, 'ID', 'Kec. Sumberjaya', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021622', 3, 'ID', 'Kec. Banjaran', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021623', 3, 'ID', 'Kec. Cingambul', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021624', 3, 'ID', 'Kec. Mala usma', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021625', 3, 'ID', 'Kec. Sindang', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021626', 3, 'ID', 'Kec. Kasokandel', '021600');
INSERT INTO siakad.master_wilayah VALUES ('021700', 2, 'ID', 'Kab. Cirebon', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021701', 3, 'ID', 'Kec. Waled', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021702', 3, 'ID', 'Kec. Ciledug', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021703', 3, 'ID', 'Kec. Losari', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021704', 3, 'ID', 'Kec. Babakan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021705', 3, 'ID', 'Kec. Karang Sembung', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021706', 3, 'ID', 'Kec. Lemah Abang', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021707', 3, 'ID', 'Kec. Sedong', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021708', 3, 'ID', 'Kec. Astana Japura', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021709', 3, 'ID', 'Kec. Mundu', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021710', 3, 'ID', 'Kec. Beber', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021712', 3, 'ID', 'Kec. Sumber', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021713', 3, 'ID', 'Kec. Palimanan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021714', 3, 'ID', 'Kec. Plumbon', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021715', 3, 'ID', 'Kec. Weru', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021718', 3, 'ID', 'Kec. Kapetakan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021719', 3, 'ID', 'Kec. Klangenan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021720', 3, 'ID', 'Kec. Arjawinangun', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021721', 3, 'ID', 'Kec. Ciwaringin', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021722', 3, 'ID', 'Kec. Susukan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021723', 3, 'ID', 'Kec. Gegesik', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021724', 3, 'ID', 'Kec. Susukan Lebak', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021725', 3, 'ID', 'Kec. Pabedilan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021726', 3, 'ID', 'Kec. Dukupuntang', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021727', 3, 'ID', 'Kec. Panguragan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021728', 3, 'ID', 'Kec. Kaliwedi', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021729', 3, 'ID', 'Kec. Pangenan', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021730', 3, 'ID', 'Kec. Gebang', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021731', 3, 'ID', 'Kec. Depok', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021732', 3, 'ID', 'Kec. Kedawung', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021733', 3, 'ID', 'Kec. Karang Wereng', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021734', 3, 'ID', 'Kec. Talun', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021735', 3, 'ID', 'Kec. Gunung Jati', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021736', 3, 'ID', 'Kec. Pasaleman', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021737', 3, 'ID', 'Kec. Pabuaran', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021738', 3, 'ID', 'Kec. Tengah Tani', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021739', 3, 'ID', 'Kec. Plered', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021740', 3, 'ID', 'Kec. Gempol', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021741', 3, 'ID', 'Kec. Greged', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021742', 3, 'ID', 'Kec. Suranenggala', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021743', 3, 'ID', 'Kec. Jamblang', '021700');
INSERT INTO siakad.master_wilayah VALUES ('021800', 2, 'ID', 'Kab. Indramayu', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021801', 3, 'ID', 'Kec. Haurgeulis', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021802', 3, 'ID', 'Kec. Kroya', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021803', 3, 'ID', 'Kec. Gabuswetan', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021804', 3, 'ID', 'Kec. Cikedung', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021805', 3, 'ID', 'Kec. Lelea', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021806', 3, 'ID', 'Kec. Bangodua', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021807', 3, 'ID', 'Kec. Widasari', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021808', 3, 'ID', 'Kec. Kertasemaya', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021809', 3, 'ID', 'Kec. Krangkeng', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021810', 3, 'ID', 'Kec. Karangampel', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021811', 3, 'ID', 'Kec. Juntinyuat', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021812', 3, 'ID', 'Kec. Sliyeg', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021813', 3, 'ID', 'Kec. Jatibarang', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021814', 3, 'ID', 'Kec. Balongan', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021815', 3, 'ID', 'Kec. Indramayu', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021816', 3, 'ID', 'Kec. Sindang', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021817', 3, 'ID', 'Kec. Lohbener', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021818', 3, 'ID', 'Kec. Losarang', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021819', 3, 'ID', 'Kec. Kandanghaur', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021820', 3, 'ID', 'Kec. Bongas', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021821', 3, 'ID', 'Kec. Anjatan', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021822', 3, 'ID', 'Kec. Sukra', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021823', 3, 'ID', 'Kec. Arahan', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021824', 3, 'ID', 'Kec. Cantigi', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021825', 3, 'ID', 'Kec. Gantar', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021826', 3, 'ID', 'Kec. Terisi', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021827', 3, 'ID', 'Kec. Sukagumiwang', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021828', 3, 'ID', 'Kec. Kedokan Bunder', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021829', 3, 'ID', 'Kec. Pasekan', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021830', 3, 'ID', 'Kec. Tukdana', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021831', 3, 'ID', 'Kec. Patrol', '021800');
INSERT INTO siakad.master_wilayah VALUES ('021900', 2, 'ID', 'Kab. Subang', '020000');
INSERT INTO siakad.master_wilayah VALUES ('021901', 3, 'ID', 'Kec. Sagalaherang', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021902', 3, 'ID', 'Kec. Jalancagak', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021903', 3, 'ID', 'Kec. Cisalak', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021904', 3, 'ID', 'Kec. Tanjung Siang', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021905', 3, 'ID', 'Kec. Cijambe', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021906', 3, 'ID', 'Kec. Cibogo', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021907', 3, 'ID', 'Kec. Subang', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021908', 3, 'ID', 'Kec. Kalijati', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021909', 3, 'ID', 'Kec. Cipeundeuy', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021910', 3, 'ID', 'Kec. Pabuaran', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021911', 3, 'ID', 'Kec. Patokbeusi', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021912', 3, 'ID', 'Kec. Purwadadi', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021913', 3, 'ID', 'Kec. Cikaum', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021914', 3, 'ID', 'Kec. Pagaden', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021915', 3, 'ID', 'Kec. Cipunagara', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021916', 3, 'ID', 'Kec. Compreng', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021917', 3, 'ID', 'Kec. Binong', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021918', 3, 'ID', 'Kec. Ciasem', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021919', 3, 'ID', 'Kec. Pamanukan', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021920', 3, 'ID', 'Kec. Pusakanagara', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021921', 3, 'ID', 'Kec. Legon Kulon', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021922', 3, 'ID', 'Kec. Blanakan', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021923', 3, 'ID', 'Kec. Dawuan', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021924', 3, 'ID', 'Kec. Serang Panjang', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021925', 3, 'ID', 'Kec. Kasomalang', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021926', 3, 'ID', 'Kec. Tambakdahan', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021927', 3, 'ID', 'Kec. Pagaden Barat', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021928', 3, 'ID', 'Kec. Pusakajaya', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021929', 3, 'ID', 'Kec. Ciater', '021900');
INSERT INTO siakad.master_wilayah VALUES ('021930', 3, 'ID', 'Kec. Sukasari', '021900');
INSERT INTO siakad.master_wilayah VALUES ('022000', 2, 'ID', 'Kab. Purwakarta', '020000');
INSERT INTO siakad.master_wilayah VALUES ('022001', 3, 'ID', 'Kec. Jatiluhur', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022002', 3, 'ID', 'Kec. Maniis', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022003', 3, 'ID', 'Kec. Tegalwaru', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022004', 3, 'ID', 'Kec. Plered', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022005', 3, 'ID', 'Kec. Sukatani', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022006', 3, 'ID', 'Kec. Darangdan', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022007', 3, 'ID', 'Kec. Bojong', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022008', 3, 'ID', 'Kec. Wanayasa', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022009', 3, 'ID', 'Kec. Pasawahan', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022010', 3, 'ID', 'Kec. Purwakarta', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022011', 3, 'ID', 'Kec. Campaka', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022012', 3, 'ID', 'Kec. Sukasari', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022013', 3, 'ID', 'Kec. Kiarapedes', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022014', 3, 'ID', 'Kec. Babakancikao', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022015', 3, 'ID', 'Kec. Cibatu', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022016', 3, 'ID', 'Kec. Bungursari', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022017', 3, 'ID', 'Kec. Pondok Salam', '022000');
INSERT INTO siakad.master_wilayah VALUES ('022100', 2, 'ID', 'Kab. Karawang', '020000');
INSERT INTO siakad.master_wilayah VALUES ('022101', 3, 'ID', 'Kec. Pangkalan', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022102', 3, 'ID', 'Kec. Ciampel', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022104', 3, 'ID', 'Kec. Klari', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022105', 3, 'ID', 'Kec. Cikampek', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022106', 3, 'ID', 'Kec. Tirtamulya', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022107', 3, 'ID', 'Kec. Jatisari', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022109', 3, 'ID', 'Kec. Lemahabang', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022110', 3, 'ID', 'Kec. Telagasari', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022111', 3, 'ID', 'Kec. Karawang', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022112', 3, 'ID', 'Kec. Rawamerta', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022113', 3, 'ID', 'Kec. Tempuran', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022114', 3, 'ID', 'Kec. Kutawaluya', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022115', 3, 'ID', 'Kec. Rengasdengklok', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022116', 3, 'ID', 'Kec. Pedes', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022117', 3, 'ID', 'Kec. Cibuaya', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022118', 3, 'ID', 'Kec. Tirtajaya', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022119', 3, 'ID', 'Kec. Batujaya', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022120', 3, 'ID', 'Kec. Pakisjaya', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022121', 3, 'ID', 'Kec. Majalaya', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022122', 3, 'ID', 'Kec. Jayakerta', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022123', 3, 'ID', 'Kec. Cilamaya Kulon', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022124', 3, 'ID', 'Kec. Banyusari', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022125', 3, 'ID', 'Kec. Kotabaru', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022126', 3, 'ID', 'Kec. Cilamaya Wetan', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022127', 3, 'ID', 'Kec. Purwasari', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022128', 3, 'ID', 'Kec. Teluk Jambe Barat', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022129', 3, 'ID', 'Kec. Teluk Jambe Timur', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022130', 3, 'ID', 'Kec. Karawang Timur', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022131', 3, 'ID', 'Kec. Tegalwaru', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022132', 3, 'ID', 'Kec. Cilebar', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022133', 3, 'ID', 'Kec. Karawang Barat', '022100');
INSERT INTO siakad.master_wilayah VALUES ('022200', 2, 'ID', 'Kab. Bekasi', '020000');
INSERT INTO siakad.master_wilayah VALUES ('022201', 3, 'ID', 'Kec. Setu', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022203', 3, 'ID', 'Kec. Cibarusah', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022205', 3, 'ID', 'Kec. Kedung Waringin', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022207', 3, 'ID', 'Kec. Cibitung', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022209', 3, 'ID', 'Kec. Babelan', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022210', 3, 'ID', 'Kec. Taruma Jaya', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022211', 3, 'ID', 'Kec. Tembelang', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022212', 3, 'ID', 'Kec. Sukatani', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022213', 3, 'ID', 'Kec. Pebayuran', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022214', 3, 'ID', 'Kec. Cabangbungin', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022215', 3, 'ID', 'Kec. Muara Gembong', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022216', 3, 'ID', 'Kec. Tambun Selatan', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022217', 3, 'ID', 'Kec. Tambun Utara', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022218', 3, 'ID', 'Kec. Cikarang Barat', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022219', 3, 'ID', 'Kec. Karang Bahagia', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022220', 3, 'ID', 'Kec. Cikarang Utara', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022221', 3, 'ID', 'Kec. Cikarang Selatan', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022222', 3, 'ID', 'Kec. Cikarang Timur', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022223', 3, 'ID', 'Kec. Bojong Mangu', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022224', 3, 'ID', 'Kec. Cikarang Pusat', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022225', 3, 'ID', 'Kec. Sukakarya', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022226', 3, 'ID', 'Kec. Sukawangi', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022227', 3, 'ID', 'Kec. Serang Baru', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022300', 2, 'ID', 'Kab. Bandung Barat', '020000');
INSERT INTO siakad.master_wilayah VALUES ('022301', 3, 'ID', 'Kec. Rongga', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022302', 3, 'ID', 'Kec. Gununghalu', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022303', 3, 'ID', 'Kec. Sindangkerta', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022304', 3, 'ID', 'Kec. Cililin', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022305', 3, 'ID', 'Kec. Cihampelas', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022306', 3, 'ID', 'Kec. Cipongkor', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022307', 3, 'ID', 'Kec. Batujajar', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022308', 3, 'ID', 'Kec. Cipatat', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022309', 3, 'ID', 'Kec. Padalarang', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022310', 3, 'ID', 'Kec. Ngamprah', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022311', 3, 'ID', 'Kec. Parongpong', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022312', 3, 'ID', 'Kec. Lembang', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022313', 3, 'ID', 'Kec. Cisarua', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022314', 3, 'ID', 'Kec. Cikalong Wetan', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022315', 3, 'ID', 'Kec. Cipeundeuy', '022300');
INSERT INTO siakad.master_wilayah VALUES ('026000', 2, 'ID', 'Kota Bandung', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026001', 3, 'ID', 'Kec. Bandung Kulon', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026002', 3, 'ID', 'Kec. Babakan Ciparay', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026003', 3, 'ID', 'Kec. Bojong Loa Kaler', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026004', 3, 'ID', 'Kec. Bojong Loa Kidul', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026005', 3, 'ID', 'Kec. Astananyar', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026006', 3, 'ID', 'Kec. Regol', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026007', 3, 'ID', 'Kec. Lengkong', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026008', 3, 'ID', 'Kec. Bandung Kidul', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026009', 3, 'ID', 'Kec. Buah Batu', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026010', 3, 'ID', 'Kec. Rancasari', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026011', 3, 'ID', 'Kec. Cibiru', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026012', 3, 'ID', 'Kec. Ujungberung', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026013', 3, 'ID', 'Kec. Arcamanik', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026015', 3, 'ID', 'Kec. Kiaracondong', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026016', 3, 'ID', 'Kec. Batununggal', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026017', 3, 'ID', 'Kec. Sumur Bandung', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026018', 3, 'ID', 'Kec. Andir', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026019', 3, 'ID', 'Kec. Cicendo', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026020', 3, 'ID', 'Kec. Bandung Wetan', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026021', 3, 'ID', 'Kec. Cibeunying Kidul', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026022', 3, 'ID', 'Kec. Cibeunying Kaler', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026023', 3, 'ID', 'Kec. Coblong', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026024', 3, 'ID', 'Kec. Sukajadi', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026025', 3, 'ID', 'Kec. Sukasari', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026026', 3, 'ID', 'Kec. Cidadap', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026027', 3, 'ID', 'Kec. Gedebage', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026028', 3, 'ID', 'Kec. Panyileukan', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026029', 3, 'ID', 'Kec. Cinambo', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026030', 3, 'ID', 'Kec. Mandalajati', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026031', 3, 'ID', 'Kec. Antapani', '026000');
INSERT INTO siakad.master_wilayah VALUES ('026100', 2, 'ID', 'Kota Bogor', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026101', 3, 'ID', 'Kec. Kota Bogor Selatan', '026100');
INSERT INTO siakad.master_wilayah VALUES ('026102', 3, 'ID', 'Kec. Kota Bogor Timur', '026100');
INSERT INTO siakad.master_wilayah VALUES ('026103', 3, 'ID', 'Kec. Kota Bogor Utara', '026100');
INSERT INTO siakad.master_wilayah VALUES ('026104', 3, 'ID', 'Kec. Kota Bogor Tengah', '026100');
INSERT INTO siakad.master_wilayah VALUES ('026105', 3, 'ID', 'Kec. Kota Bogor Barat', '026100');
INSERT INTO siakad.master_wilayah VALUES ('026106', 3, 'ID', 'Kec. Tanah Sereal', '026100');
INSERT INTO siakad.master_wilayah VALUES ('026200', 2, 'ID', 'Kota Sukabumi', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026201', 3, 'ID', 'Kec. Baros', '026200');
INSERT INTO siakad.master_wilayah VALUES ('026202', 3, 'ID', 'Kec. Citamiang', '026200');
INSERT INTO siakad.master_wilayah VALUES ('026203', 3, 'ID', 'Kec. Warudoyong', '026200');
INSERT INTO siakad.master_wilayah VALUES ('026204', 3, 'ID', 'Kec. Gunung Puyuh', '026200');
INSERT INTO siakad.master_wilayah VALUES ('026205', 3, 'ID', 'Kec. Cikole', '026200');
INSERT INTO siakad.master_wilayah VALUES ('026206', 3, 'ID', 'Kec. Lembur Situ', '026200');
INSERT INTO siakad.master_wilayah VALUES ('026207', 3, 'ID', 'Kec. Cibeureum', '026200');
INSERT INTO siakad.master_wilayah VALUES ('026300', 2, 'ID', 'Kota Cirebon', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026301', 3, 'ID', 'Kec. Harjamukti', '026300');
INSERT INTO siakad.master_wilayah VALUES ('026302', 3, 'ID', 'Kec. Lemahwungkuk', '026300');
INSERT INTO siakad.master_wilayah VALUES ('026303', 3, 'ID', 'Kec. Pekalipan', '026300');
INSERT INTO siakad.master_wilayah VALUES ('026304', 3, 'ID', 'Kec. Kesambi', '026300');
INSERT INTO siakad.master_wilayah VALUES ('026305', 3, 'ID', 'Kec. Kejaksan', '026300');
INSERT INTO siakad.master_wilayah VALUES ('026500', 2, 'ID', 'Kota Bekasi', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026501', 3, 'ID', 'Kec. Pondokgede', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026502', 3, 'ID', 'Kec. Jatiasih', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026503', 3, 'ID', 'Kec. Bantargebang', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026504', 3, 'ID', 'Kec. Bekasi Timur', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026505', 3, 'ID', 'Kec. Bekasi Selatan', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026506', 3, 'ID', 'Kec. Bekasi Barat', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026507', 3, 'ID', 'Kec. Bekasi Utara', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026508', 3, 'ID', 'Kec. Jati Sampurna', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026509', 3, 'ID', 'Kec. Medan Satria', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026510', 3, 'ID', 'Kec. Rawalumbu', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026511', 3, 'ID', 'Kec. Mustika Jaya', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026512', 3, 'ID', 'Kec. Pondok Melati', '026500');
INSERT INTO siakad.master_wilayah VALUES ('026600', 2, 'ID', 'Kota Depok', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026601', 3, 'ID', 'Kec. Sawangan', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026602', 3, 'ID', 'Kec. Pancoran Mas', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026603', 3, 'ID', 'Kec. Sukmajaya', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026604', 3, 'ID', 'Kec. Cimanggis', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026605', 3, 'ID', 'Kec. Beji', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026606', 3, 'ID', 'Kec. Limo', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026607', 3, 'ID', 'Kec. Cipayung', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026608', 3, 'ID', 'Kec. Cilodong', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026609', 3, 'ID', 'Kec. Cinere', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026610', 3, 'ID', 'Kec. Tapos', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026611', 3, 'ID', 'Kec. Bojongsari', '026600');
INSERT INTO siakad.master_wilayah VALUES ('026700', 2, 'ID', 'Kota Cimahi', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026701', 3, 'ID', 'Kec. Cimahi Selatan', '026700');
INSERT INTO siakad.master_wilayah VALUES ('026702', 3, 'ID', 'Kec. Cimahi Tengah', '026700');
INSERT INTO siakad.master_wilayah VALUES ('026703', 3, 'ID', 'Kec. Cimahi Utara', '026700');
INSERT INTO siakad.master_wilayah VALUES ('026800', 2, 'ID', 'Kota Tasikmalaya', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026801', 3, 'ID', 'Kec. Cibeureum', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026802', 3, 'ID', 'Kec. Tamansari', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026803', 3, 'ID', 'Kec. Kawalu', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026804', 3, 'ID', 'Kec. Mangkubumi', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026805', 3, 'ID', 'Kec. Indihiang', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026806', 3, 'ID', 'Kec. Cipedes', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026807', 3, 'ID', 'Kec. Cihideung', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026808', 3, 'ID', 'Kec. Tawang', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026809', 3, 'ID', 'Kec. Purbaratu', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026810', 3, 'ID', 'Kec. Bungursari', '026800');
INSERT INTO siakad.master_wilayah VALUES ('026900', 2, 'ID', 'Kota Banjar', '020000');
INSERT INTO siakad.master_wilayah VALUES ('026901', 3, 'ID', 'Kec. Banjar', '026900');
INSERT INTO siakad.master_wilayah VALUES ('026902', 3, 'ID', 'Kec. Purwaharja', '026900');
INSERT INTO siakad.master_wilayah VALUES ('026903', 3, 'ID', 'Kec. Pataruman', '026900');
INSERT INTO siakad.master_wilayah VALUES ('026904', 3, 'ID', 'Kec. Langensari', '026900');
INSERT INTO siakad.master_wilayah VALUES ('030000', 1, 'ID', 'Prov. Jawa Tengah', '000000');
INSERT INTO siakad.master_wilayah VALUES ('030100', 2, 'ID', 'Kab. Cilacap', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030101', 3, 'ID', 'Kec. Dayeuhluhur', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030102', 3, 'ID', 'Kec. Wanareja', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030103', 3, 'ID', 'Kec. Majenang', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030104', 3, 'ID', 'Kec. Cimanggu', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030105', 3, 'ID', 'Kec. Karangpucung', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030106', 3, 'ID', 'Kec. Cipari', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030107', 3, 'ID', 'Kec. Sidareja', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030108', 3, 'ID', 'Kec. Kedungreja', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030109', 3, 'ID', 'Kec. Patimuan', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030110', 3, 'ID', 'Kec. Gandrungmangu', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030111', 3, 'ID', 'Kec. Bantarsari', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030112', 3, 'ID', 'Kec. Kawunganten', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030113', 3, 'ID', 'Kec. Kampung Laut', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030114', 3, 'ID', 'Kec. Jeruklegi', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030115', 3, 'ID', 'Kec. Kesugihan', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030116', 3, 'ID', 'Kec. Adipala', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030117', 3, 'ID', 'Kec. Maos', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030118', 3, 'ID', 'Kec. Sampang', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030119', 3, 'ID', 'Kec. Kroya', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030120', 3, 'ID', 'Kec. Binangun', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030121', 3, 'ID', 'Kec. Nusawungu', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030122', 3, 'ID', 'Kec. Cilacap Selatan', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030123', 3, 'ID', 'Kec. Cilacap Tengah', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030124', 3, 'ID', 'Kec. Cilacap Utara', '030100');
INSERT INTO siakad.master_wilayah VALUES ('030200', 2, 'ID', 'Kab. Banyumas', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030201', 3, 'ID', 'Kec. Lumbir', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030202', 3, 'ID', 'Kec. Wangon', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030203', 3, 'ID', 'Kec. Jatilawang', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030204', 3, 'ID', 'Kec. Rawalo', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030205', 3, 'ID', 'Kec. Kebasen', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030206', 3, 'ID', 'Kec. Kemranjen', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030207', 3, 'ID', 'Kec. Sumpiuh', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030208', 3, 'ID', 'Kec. Tambak', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030209', 3, 'ID', 'Kec. Somagede', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030210', 3, 'ID', 'Kec. Kalibagor', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030211', 3, 'ID', 'Kec. Banyumas', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030212', 3, 'ID', 'Kec. Patikraja', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030213', 3, 'ID', 'Kec. Purwojati', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030214', 3, 'ID', 'Kec. Ajibarang', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030215', 3, 'ID', 'Kec. Gumelar', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030216', 3, 'ID', 'Kec. Pekuncen', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030217', 3, 'ID', 'Kec. Cilongok', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030218', 3, 'ID', 'Kec. Karanglewas', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030219', 3, 'ID', 'Kec. Kedung Banteng', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030220', 3, 'ID', 'Kec. Baturaden', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030221', 3, 'ID', 'Kec. Sumbang', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030222', 3, 'ID', 'Kec. Kembaran', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030223', 3, 'ID', 'Kec. Sokaraja', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030224', 3, 'ID', 'Kec. Purwokerto Selatan', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030225', 3, 'ID', 'Kec. Purwokerto Barat', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030226', 3, 'ID', 'Kec. Purwokerto Timur', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030227', 3, 'ID', 'Kec. Purwokerto Utara', '030200');
INSERT INTO siakad.master_wilayah VALUES ('030300', 2, 'ID', 'Kab. Purbalingga', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030301', 3, 'ID', 'Kec. Kemangkon', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030302', 3, 'ID', 'Kec. Bukateja', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030303', 3, 'ID', 'Kec. Kejobong', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030304', 3, 'ID', 'Kec. Pengadegan', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030305', 3, 'ID', 'Kec. Kaligondang', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030306', 3, 'ID', 'Kec. Purbalingga', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030307', 3, 'ID', 'Kec. Kalimanah', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030308', 3, 'ID', 'Kec. Padamara', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030309', 3, 'ID', 'Kec. Kutasari', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030310', 3, 'ID', 'Kec. Bojongsari', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030311', 3, 'ID', 'Kec. Mrebet', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030312', 3, 'ID', 'Kec. Bobotsari', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030313', 3, 'ID', 'Kec. Karangreja', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030314', 3, 'ID', 'Kec. Karanganyar', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030315', 3, 'ID', 'Kec. Karangmoncol', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030316', 3, 'ID', 'Kec. Rembang', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030317', 3, 'ID', 'Kec. Karangjambu', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030318', 3, 'ID', 'Kec. Kertanegara', '030300');
INSERT INTO siakad.master_wilayah VALUES ('030400', 2, 'ID', 'Kab. Banjarnegara', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030401', 3, 'ID', 'Kec. Susukan', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030402', 3, 'ID', 'Kec. Purworejo/ Klampok', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030403', 3, 'ID', 'Kec. Mandiraja', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030404', 3, 'ID', 'Kec. Purwonegara', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030405', 3, 'ID', 'Kec. Bawang', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030406', 3, 'ID', 'Kec. Banjarnegara', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030407', 3, 'ID', 'Kec. Sigaluh', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030408', 3, 'ID', 'Kec. Madukara', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030409', 3, 'ID', 'Kec. Banjarmangu', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030410', 3, 'ID', 'Kec. Wanadadi', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030411', 3, 'ID', 'Kec. Rakit', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030412', 3, 'ID', 'Kec. Punggelan', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030413', 3, 'ID', 'Kec. Karangkobar', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030414', 3, 'ID', 'Kec. Pagentan', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030415', 3, 'ID', 'Kec. Pejawaran', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030416', 3, 'ID', 'Kec. Batur', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030417', 3, 'ID', 'Kec. Wanayasa', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030418', 3, 'ID', 'Kec. Kalibening', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030419', 3, 'ID', 'Kec. Pandan Arum', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030420', 3, 'ID', 'Kec. Pagedongan', '030400');
INSERT INTO siakad.master_wilayah VALUES ('030500', 2, 'ID', 'Kab. Kebumen', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030501', 3, 'ID', 'Kec. Ayah', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030502', 3, 'ID', 'Kec. Buayan', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030503', 3, 'ID', 'Kec. Puring', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030504', 3, 'ID', 'Kec. Petanahan', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030505', 3, 'ID', 'Kec. Klirong', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030506', 3, 'ID', 'Kec. Bulupesantren', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030507', 3, 'ID', 'Kec. Ambal', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030508', 3, 'ID', 'Kec. Mirit', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030509', 3, 'ID', 'Kec. Prembun', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030510', 3, 'ID', 'Kec. Kutowinangun', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030511', 3, 'ID', 'Kec. Alian', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030512', 3, 'ID', 'Kec. Kebumen', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030513', 3, 'ID', 'Kec. Pejagoan', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030514', 3, 'ID', 'Kec. Sruweng', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030515', 3, 'ID', 'Kec. Adimulyo', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030516', 3, 'ID', 'Kec. Kuwarasan', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030517', 3, 'ID', 'Kec. Rowokele', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030518', 3, 'ID', 'Kec. Sempor', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030519', 3, 'ID', 'Kec. Gombong', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030520', 3, 'ID', 'Kec. Karanganyar', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030521', 3, 'ID', 'Kec. Karangganyam', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030522', 3, 'ID', 'Kec. Sadang', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030523', 3, 'ID', 'Kec. Bonorowo', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030524', 3, 'ID', 'Kec. Padureso', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030525', 3, 'ID', 'Kec. Poncowarno', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030526', 3, 'ID', 'Kec. Karangsambung', '030500');
INSERT INTO siakad.master_wilayah VALUES ('030600', 2, 'ID', 'Kab. Purworejo', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030601', 3, 'ID', 'Kec. Grabag', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030602', 3, 'ID', 'Kec. Ngombol', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030603', 3, 'ID', 'Kec. Purwodadi', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030604', 3, 'ID', 'Kec. Bagelen', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030605', 3, 'ID', 'Kec. Kaligesing', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030606', 3, 'ID', 'Kec. Purworejo', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030607', 3, 'ID', 'Kec. Banyu Urip', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030608', 3, 'ID', 'Kec. Bayan', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030609', 3, 'ID', 'Kec. Kutoarjo', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030610', 3, 'ID', 'Kec. Butuh', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030611', 3, 'ID', 'Kec. Pituruh', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030612', 3, 'ID', 'Kec. Kemiri', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030613', 3, 'ID', 'Kec. Bruno', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030614', 3, 'ID', 'Kec. Gebang', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030615', 3, 'ID', 'Kec. Loano', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030616', 3, 'ID', 'Kec. Bener', '030600');
INSERT INTO siakad.master_wilayah VALUES ('030700', 2, 'ID', 'Kab. Wonosobo', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030701', 3, 'ID', 'Kec. Wadaslintang', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030702', 3, 'ID', 'Kec. Kepil', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030703', 3, 'ID', 'Kec. Sapuran', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030704', 3, 'ID', 'Kec. Kaliwiro', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030705', 3, 'ID', 'Kec. Leksono', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030706', 3, 'ID', 'Kec. Selomerto', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030707', 3, 'ID', 'Kec. Kalikajar', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030708', 3, 'ID', 'Kec. Kertek', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030709', 3, 'ID', 'Kec. Wonosobo', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030710', 3, 'ID', 'Kec. Watumalang', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030711', 3, 'ID', 'Kec. Mojotengah', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030712', 3, 'ID', 'Kec. Garung', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030713', 3, 'ID', 'Kec. Kejajar', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030714', 3, 'ID', 'Kec. Sukoharjo', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030715', 3, 'ID', 'Kec. Kalibawang', '030700');
INSERT INTO siakad.master_wilayah VALUES ('030800', 2, 'ID', 'Kab. Magelang', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030801', 3, 'ID', 'Kec. Salaman', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030802', 3, 'ID', 'Kec. Borobudur', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030803', 3, 'ID', 'Kec. Ngluwar', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030804', 3, 'ID', 'Kec. Salam', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030805', 3, 'ID', 'Kec. Srumbung', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030806', 3, 'ID', 'Kec. Dukun', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030807', 3, 'ID', 'Kec. Muntilan', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030808', 3, 'ID', 'Kec. Mungkid', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030809', 3, 'ID', 'Kec. Sawangan', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030810', 3, 'ID', 'Kec. Candimulyo', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030811', 3, 'ID', 'Kec. Martoyudan', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030812', 3, 'ID', 'Kec. Tempuran', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030813', 3, 'ID', 'Kec. Kajoran', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030814', 3, 'ID', 'Kec. Kaliangkrik', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030815', 3, 'ID', 'Kec. Bandongan', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030816', 3, 'ID', 'Kec. Windusari', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030817', 3, 'ID', 'Kec. Secang', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030818', 3, 'ID', 'Kec. Tegalrejo', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030819', 3, 'ID', 'Kec. Pakis', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030820', 3, 'ID', 'Kec. Grabag', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030821', 3, 'ID', 'Kec. Ngablak', '030800');
INSERT INTO siakad.master_wilayah VALUES ('030900', 2, 'ID', 'Kab. Boyolali', '030000');
INSERT INTO siakad.master_wilayah VALUES ('030901', 3, 'ID', 'Kec. Selo', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030902', 3, 'ID', 'Kec. Ampel', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030903', 3, 'ID', 'Kec. Cepogo', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030904', 3, 'ID', 'Kec. Musuk', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030905', 3, 'ID', 'Kec. Boyolali', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030906', 3, 'ID', 'Kec. Mojosongo', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030907', 3, 'ID', 'Kec. Teras', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030908', 3, 'ID', 'Kec. Sawit', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030909', 3, 'ID', 'Kec. Banyudono', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030910', 3, 'ID', 'Kec. Sambi', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030911', 3, 'ID', 'Kec. Ngemplak', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030912', 3, 'ID', 'Kec. Nogosari', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030913', 3, 'ID', 'Kec. Simo', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030914', 3, 'ID', 'Kec. Karanggede', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030915', 3, 'ID', 'Kec. Klego', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030916', 3, 'ID', 'Kec. Andong', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030917', 3, 'ID', 'Kec. Kemusu', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030918', 3, 'ID', 'Kec. Wonosegoro', '030900');
INSERT INTO siakad.master_wilayah VALUES ('030919', 3, 'ID', 'Kec. Juwangi', '030900');
INSERT INTO siakad.master_wilayah VALUES ('031000', 2, 'ID', 'Kab. Klaten', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031001', 3, 'ID', 'Kec. Prambanan', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031002', 3, 'ID', 'Kec. Gantiwarno', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031003', 3, 'ID', 'Kec. Wedi', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031004', 3, 'ID', 'Kec. Bayat', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031005', 3, 'ID', 'Kec. Cawas', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031006', 3, 'ID', 'Kec. Trucuk', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031007', 3, 'ID', 'Kec. Kalikotes', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031008', 3, 'ID', 'Kec. Kebonarum', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031009', 3, 'ID', 'Kec. Jogonalan', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031010', 3, 'ID', 'Kec. Manisrenggo', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031011', 3, 'ID', 'Kec. Karangnongko', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031012', 3, 'ID', 'Kec. Ngawen', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031013', 3, 'ID', 'Kec. Ceper', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031014', 3, 'ID', 'Kec. Pedan', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031015', 3, 'ID', 'Kec. Karangdowo', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031016', 3, 'ID', 'Kec. Juwiring', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031017', 3, 'ID', 'Kec. Wonosari', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031018', 3, 'ID', 'Kec. Delanggu', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031019', 3, 'ID', 'Kec. Polanharjo', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031020', 3, 'ID', 'Kec. Karanganom', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031021', 3, 'ID', 'Kec. Tulung', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031022', 3, 'ID', 'Kec. Jatinom', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031023', 3, 'ID', 'Kec. Kemalang', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031024', 3, 'ID', 'Kec. Klaten Selatan', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031025', 3, 'ID', 'Kec. Klaten Tengah', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031026', 3, 'ID', 'Kec. Klaten Utara', '031000');
INSERT INTO siakad.master_wilayah VALUES ('031100', 2, 'ID', 'Kab. Sukoharjo', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031101', 3, 'ID', 'Kec. Weru', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031102', 3, 'ID', 'Kec. Bulu', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031103', 3, 'ID', 'Kec. Tawangsari', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031104', 3, 'ID', 'Kec. Sukoharjo', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031105', 3, 'ID', 'Kec. Nguter', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031106', 3, 'ID', 'Kec. Bendosari', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031107', 3, 'ID', 'Kec. Polokarto', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031108', 3, 'ID', 'Kec. Mojolaban', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031109', 3, 'ID', 'Kec. Grogol', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031110', 3, 'ID', 'Kec. Baki', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031111', 3, 'ID', 'Kec. Gatak', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031112', 3, 'ID', 'Kec. Kartasura', '031100');
INSERT INTO siakad.master_wilayah VALUES ('031200', 2, 'ID', 'Kab. Wonogiri', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031201', 3, 'ID', 'Kec. Pracimantoro', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031202', 3, 'ID', 'Kec. Paranggupito', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031203', 3, 'ID', 'Kec. Giritontro', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031204', 3, 'ID', 'Kec. Giriwoyo', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031205', 3, 'ID', 'Kec. Batuwarno', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031206', 3, 'ID', 'Kec. Karangtengah', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031207', 3, 'ID', 'Kec. Tirtomoyo', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031208', 3, 'ID', 'Kec. Nguntoronadi', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031209', 3, 'ID', 'Kec. Baturetno', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031210', 3, 'ID', 'Kec. Eromoko', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031211', 3, 'ID', 'Kec. Wuryantoro', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031212', 3, 'ID', 'Kec. Manyaran', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031213', 3, 'ID', 'Kec. Selogiri', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031214', 3, 'ID', 'Kec. Wonogiri', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031215', 3, 'ID', 'Kec. Ngadirojo', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031216', 3, 'ID', 'Kec. Sidoharjo', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031217', 3, 'ID', 'Kec. Jatiroto', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031218', 3, 'ID', 'Kec. Kismantoro', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031219', 3, 'ID', 'Kec. Purwantoro', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031220', 3, 'ID', 'Kec. Bulukerto', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031221', 3, 'ID', 'Kec. Slogohimo', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031222', 3, 'ID', 'Kec. Jatisrono', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031223', 3, 'ID', 'Kec. Jatipurno', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031224', 3, 'ID', 'Kec. Girimarto', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031225', 3, 'ID', 'Kec. Puhpelem', '031200');
INSERT INTO siakad.master_wilayah VALUES ('031300', 2, 'ID', 'Kab. Karanganyar', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031301', 3, 'ID', 'Kec. Jatipuro', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031302', 3, 'ID', 'Kec. Jatiyoso', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031303', 3, 'ID', 'Kec. Jumapolo', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031304', 3, 'ID', 'Kec. Jumantono', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031305', 3, 'ID', 'Kec. Matesih', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031306', 3, 'ID', 'Kec. Tawangmangu', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031307', 3, 'ID', 'Kec. Ngargoyoso', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031308', 3, 'ID', 'Kec. Karangpandan', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031309', 3, 'ID', 'Kec. Karanganyar', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031310', 3, 'ID', 'Kec. Tasikmadu', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031311', 3, 'ID', 'Kec. Jaten', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031312', 3, 'ID', 'Kec. Colomadu', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031313', 3, 'ID', 'Kec. Gondangrejo', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031314', 3, 'ID', 'Kec. Kebakkramat', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031315', 3, 'ID', 'Kec. Mojogedang', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031316', 3, 'ID', 'Kec. Kerjo', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031317', 3, 'ID', 'Kec. Jenawi', '031300');
INSERT INTO siakad.master_wilayah VALUES ('031400', 2, 'ID', 'Kab. Sragen', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031401', 3, 'ID', 'Kec. Kalijambe', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031402', 3, 'ID', 'Kec. Plupuh', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031403', 3, 'ID', 'Kec. Masaran', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031404', 3, 'ID', 'Kec. Kedawung', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031405', 3, 'ID', 'Kec. Sambirejo', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031406', 3, 'ID', 'Kec. Gondang', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031407', 3, 'ID', 'Kec. Sambung Macan', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031408', 3, 'ID', 'Kec. Ngrampal', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031409', 3, 'ID', 'Kec. Karangmalang', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031410', 3, 'ID', 'Kec. Sragen', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031411', 3, 'ID', 'Kec. Sidoharjo', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031412', 3, 'ID', 'Kec. Tanon', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031413', 3, 'ID', 'Kec. Gemolong', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031414', 3, 'ID', 'Kec. Miri', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031415', 3, 'ID', 'Kec. Sumberlawang', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031416', 3, 'ID', 'Kec. Mondokan', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031417', 3, 'ID', 'Kec. Sukodono', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031418', 3, 'ID', 'Kec. Gesi', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031419', 3, 'ID', 'Kec. Tangen', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031420', 3, 'ID', 'Kec. Jenar', '031400');
INSERT INTO siakad.master_wilayah VALUES ('031500', 2, 'ID', 'Kab. Grobogan', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031501', 3, 'ID', 'Kec. Kedungjati', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031502', 3, 'ID', 'Kec. Karangrayung', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031503', 3, 'ID', 'Kec. Penawangan', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031504', 3, 'ID', 'Kec. Toroh', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031505', 3, 'ID', 'Kec. Geyer', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031506', 3, 'ID', 'Kec. Pulokulon', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031507', 3, 'ID', 'Kec. Kradenan', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031508', 3, 'ID', 'Kec. Gabus', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031509', 3, 'ID', 'Kec. Ngaringan', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031510', 3, 'ID', 'Kec. Wirosari', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031511', 3, 'ID', 'Kec. Tawangharjo', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031512', 3, 'ID', 'Kec. Grobogan', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031513', 3, 'ID', 'Kec. Purwodadi', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031514', 3, 'ID', 'Kec. Brati', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031515', 3, 'ID', 'Kec. Klambu', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031516', 3, 'ID', 'Kec. Godong', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031517', 3, 'ID', 'Kec. Gubug', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031518', 3, 'ID', 'Kec. Tegowanu', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031519', 3, 'ID', 'Kec. Tanggungharjo', '031500');
INSERT INTO siakad.master_wilayah VALUES ('031600', 2, 'ID', 'Kab. Blora', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031601', 3, 'ID', 'Kec. Jati', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031602', 3, 'ID', 'Kec. Randublatung', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031603', 3, 'ID', 'Kec. Kradenan', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031604', 3, 'ID', 'Kec. Kedungtuban', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031605', 3, 'ID', 'Kec. Cepu', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031606', 3, 'ID', 'Kec. Sambong', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031607', 3, 'ID', 'Kec. Jiken', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031608', 3, 'ID', 'Kec. Bogorejo', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031609', 3, 'ID', 'Kec. Jepon', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031610', 3, 'ID', 'Kec. Kota Blora', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031611', 3, 'ID', 'Kec. Banjarejo', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031612', 3, 'ID', 'Kec. Tunjungan', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031613', 3, 'ID', 'Kec. Japah', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031614', 3, 'ID', 'Kec. Ngawen', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031615', 3, 'ID', 'Kec. Kunduran', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031616', 3, 'ID', 'Kec. Todanan', '031600');
INSERT INTO siakad.master_wilayah VALUES ('031700', 2, 'ID', 'Kab. Rembang', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031701', 3, 'ID', 'Kec. Sumber', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031702', 3, 'ID', 'Kec. Bulu', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031703', 3, 'ID', 'Kec. Gunem', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031704', 3, 'ID', 'Kec. Sale', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031705', 3, 'ID', 'Kec. Sarang', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031706', 3, 'ID', 'Kec. Sedan', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031707', 3, 'ID', 'Kec. Pamotan', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031708', 3, 'ID', 'Kec. Sulang', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031709', 3, 'ID', 'Kec. Kaliori', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031710', 3, 'ID', 'Kec. Rembang', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031711', 3, 'ID', 'Kec. Pancur', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031712', 3, 'ID', 'Kec. Kragan', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031713', 3, 'ID', 'Kec. Sluke', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031714', 3, 'ID', 'Kec. Lasem', '031700');
INSERT INTO siakad.master_wilayah VALUES ('031800', 2, 'ID', 'Kab. Pati', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031801', 3, 'ID', 'Kec. Sukolilo', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031802', 3, 'ID', 'Kec. Kayen', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031803', 3, 'ID', 'Kec. Tambakromo', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031804', 3, 'ID', 'Kec. Winong', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031805', 3, 'ID', 'Kec. Pucakwangi', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031806', 3, 'ID', 'Kec. Jaken', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031807', 3, 'ID', 'Kec. Batangan', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031808', 3, 'ID', 'Kec. Juwana', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031809', 3, 'ID', 'Kec. Jakenan', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031810', 3, 'ID', 'Kec. Pati', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031811', 3, 'ID', 'Kec. Gabus', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031812', 3, 'ID', 'Kec. Margorejo', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031813', 3, 'ID', 'Kec. Gembong', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031814', 3, 'ID', 'Kec. Tlogowungu', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031815', 3, 'ID', 'Kec. Wedarijaksa', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031816', 3, 'ID', 'Kec. Trangkil', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031817', 3, 'ID', 'Kec. Margoyoso', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031818', 3, 'ID', 'Kec. Gunung Wungkal', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031819', 3, 'ID', 'Kec. Cluwak', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031820', 3, 'ID', 'Kec. Tayu', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031821', 3, 'ID', 'Kec. Dukuhseti', '031800');
INSERT INTO siakad.master_wilayah VALUES ('031900', 2, 'ID', 'Kab. Kudus', '030000');
INSERT INTO siakad.master_wilayah VALUES ('031901', 3, 'ID', 'Kec. Kaliwungu', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031902', 3, 'ID', 'Kec. Kota Kudus', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031903', 3, 'ID', 'Kec. Jati', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031904', 3, 'ID', 'Kec. Undaan', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031905', 3, 'ID', 'Kec. Mejobo', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031906', 3, 'ID', 'Kec. Jekulo', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031907', 3, 'ID', 'Kec. Bae', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031908', 3, 'ID', 'Kec. Gebog', '031900');
INSERT INTO siakad.master_wilayah VALUES ('031909', 3, 'ID', 'Kec. Dawe', '031900');
INSERT INTO siakad.master_wilayah VALUES ('032000', 2, 'ID', 'Kab. Jepara', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032001', 3, 'ID', 'Kec. Kedung', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032002', 3, 'ID', 'Kec. Pecangaan', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032003', 3, 'ID', 'Kec. Welahan', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032004', 3, 'ID', 'Kec. Mayong', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032005', 3, 'ID', 'Kec. Nalumsari', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032006', 3, 'ID', 'Kec. Batealit', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032007', 3, 'ID', 'Kec. Tahunan', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032008', 3, 'ID', 'Kec. Jepara', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032009', 3, 'ID', 'Kec. Mlonggo', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032010', 3, 'ID', 'Kec. Bangsri', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032011', 3, 'ID', 'Kec. Keling', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032012', 3, 'ID', 'Kec. Karimunjawa', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032013', 3, 'ID', 'Kec. Kalinyamatan', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032014', 3, 'ID', 'Kec. Kembang', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032015', 3, 'ID', 'Kec. Donorojo', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032016', 3, 'ID', 'Kec. Pakis Aji', '032000');
INSERT INTO siakad.master_wilayah VALUES ('032100', 2, 'ID', 'Kab. Demak', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032101', 3, 'ID', 'Kec. Mranggen', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032102', 3, 'ID', 'Kec. Karangawen', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032103', 3, 'ID', 'Kec. Guntur', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032104', 3, 'ID', 'Kec. Sayung', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032105', 3, 'ID', 'Kec. Karang Tengah', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032106', 3, 'ID', 'Kec. Bonang', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032107', 3, 'ID', 'Kec. Demak', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032108', 3, 'ID', 'Kec. Wonosalam', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032109', 3, 'ID', 'Kec. Dempet', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032110', 3, 'ID', 'Kec. Gajah', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032111', 3, 'ID', 'Kec. Karanganyar', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032112', 3, 'ID', 'Kec. Mijen', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032113', 3, 'ID', 'Kec. Wedung', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032114', 3, 'ID', 'Kec. Kebonagung', '032100');
INSERT INTO siakad.master_wilayah VALUES ('032200', 2, 'ID', 'Kab. Semarang', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032201', 3, 'ID', 'Kec. Getasan', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032202', 3, 'ID', 'Kec. Tengaran', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032203', 3, 'ID', 'Kec. Susukan', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032204', 3, 'ID', 'Kec. Suruh', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032205', 3, 'ID', 'Kec. Pabelan', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032206', 3, 'ID', 'Kec. Tuntang', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032207', 3, 'ID', 'Kec. Banyubiru', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032208', 3, 'ID', 'Kec. Jambu', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032209', 3, 'ID', 'Kec. Sumowono', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032210', 3, 'ID', 'Kec. Ambarawa', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032211', 3, 'ID', 'Kec. Bawen', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032212', 3, 'ID', 'Kec. Bringin', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032213', 3, 'ID', 'Kec. Pringapus', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032214', 3, 'ID', 'Kec. Bergas', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032217', 3, 'ID', 'Kec. Kaliwungu', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032218', 3, 'ID', 'Kec. Bancak', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032219', 3, 'ID', 'Kec. Ungaran Barat', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032220', 3, 'ID', 'Kec. Ungaran Timur', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032221', 3, 'ID', 'Kec. Bandungan', '032200');
INSERT INTO siakad.master_wilayah VALUES ('032300', 2, 'ID', 'Kab. Temanggung', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032301', 3, 'ID', 'Kec. Parakan', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032302', 3, 'ID', 'Kec. Bulu', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032303', 3, 'ID', 'Kec. Temanggung', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032304', 3, 'ID', 'Kec. Tembarak', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032305', 3, 'ID', 'Kec. Kranggan', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032306', 3, 'ID', 'Kec. Pringsurat', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032307', 3, 'ID', 'Kec. Kaloran', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032308', 3, 'ID', 'Kec. Kandangan', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032309', 3, 'ID', 'Kec. Kedu', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032310', 3, 'ID', 'Kec. Ngadirejo', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032311', 3, 'ID', 'Kec. Jumo', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032312', 3, 'ID', 'Kec. Candiroto', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032313', 3, 'ID', 'Kec. Tretep', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032314', 3, 'ID', 'Kec. Kledung', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032315', 3, 'ID', 'Kec. Bansari', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032316', 3, 'ID', 'Kec. Tlogomulyo', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032317', 3, 'ID', 'Kec. Selopampang', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032318', 3, 'ID', 'Kec. Gemawang', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032319', 3, 'ID', 'Kec. Bejen', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032320', 3, 'ID', 'Kec. Wonoboyo', '032300');
INSERT INTO siakad.master_wilayah VALUES ('032400', 2, 'ID', 'Kab. Kendal', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032401', 3, 'ID', 'Kec. Plantungan', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032402', 3, 'ID', 'Kec. Sukorejo', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032403', 3, 'ID', 'Kec. Pegeruyung', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032404', 3, 'ID', 'Kec. Patean', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032405', 3, 'ID', 'Kec. Singorojo', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032406', 3, 'ID', 'Kec. Limbangan', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032407', 3, 'ID', 'Kec. Boja', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032408', 3, 'ID', 'Kec. Kaliwungu', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032409', 3, 'ID', 'Kec. Brangsong', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032410', 3, 'ID', 'Kec. Pegandon', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032411', 3, 'ID', 'Kec. Gemuh', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032412', 3, 'ID', 'Kec. Waleri', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032413', 3, 'ID', 'Kec. Rowosari', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032414', 3, 'ID', 'Kec. Kangkung', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032415', 3, 'ID', 'Kec. Cipiring', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032416', 3, 'ID', 'Kec. Patebon', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032417', 3, 'ID', 'Kec. Kota Kendal', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032418', 3, 'ID', 'Kec. Ngampel', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032419', 3, 'ID', 'Kec. Ringinarum', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032420', 3, 'ID', 'Kec. Kaliwungu Selatan', '032400');
INSERT INTO siakad.master_wilayah VALUES ('032500', 2, 'ID', 'Kab. Batang', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032501', 3, 'ID', 'Kec. Wonotunggal', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032502', 3, 'ID', 'Kec. Bandar', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032503', 3, 'ID', 'Kec. Blado', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032504', 3, 'ID', 'Kec. Reban', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032505', 3, 'ID', 'Kec. Bawang', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032506', 3, 'ID', 'Kec. Tersono', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032507', 3, 'ID', 'Kec. Gringsing', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032508', 3, 'ID', 'Kec. Limpung', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032509', 3, 'ID', 'Kec. Subah', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032510', 3, 'ID', 'Kec. Tulis', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032511', 3, 'ID', 'Kec. Batang', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032512', 3, 'ID', 'Kec. Warung Asem', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032513', 3, 'ID', 'Kec. Banyuputih', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032514', 3, 'ID', 'Kec. Pecalungan', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032515', 3, 'ID', 'Kec. Kandeman', '032500');
INSERT INTO siakad.master_wilayah VALUES ('032600', 2, 'ID', 'Kab. Pekalongan', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032601', 3, 'ID', 'Kec. Kandang Serang', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032602', 3, 'ID', 'Kec. Peninggaran', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032603', 3, 'ID', 'Kec. Lebakbarang', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032604', 3, 'ID', 'Kec. Petungkriono', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032605', 3, 'ID', 'Kec. Talun', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032606', 3, 'ID', 'Kec. Doro', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032607', 3, 'ID', 'Kec. Karanganyar', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032608', 3, 'ID', 'Kec. Kajen', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032609', 3, 'ID', 'Kec. Kesesi', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032610', 3, 'ID', 'Kec. Sragi', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032611', 3, 'ID', 'Kec. Bojong', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032612', 3, 'ID', 'Kec. Wonopringgo', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032613', 3, 'ID', 'Kec. Kedungwuni', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032614', 3, 'ID', 'Kec. Buaran', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032615', 3, 'ID', 'Kec. Tirto', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032616', 3, 'ID', 'Kec. Wiradesa', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032617', 3, 'ID', 'Kec. Siwalan', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032618', 3, 'ID', 'Kec. Karangdadap', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032619', 3, 'ID', 'Kec. Wonokerto', '032600');
INSERT INTO siakad.master_wilayah VALUES ('032700', 2, 'ID', 'Kab. Pemalang', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032701', 3, 'ID', 'Kec. Moga', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032702', 3, 'ID', 'Kec. Pulosari', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032703', 3, 'ID', 'Kec. Belik', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032704', 3, 'ID', 'Kec. Watukumpul', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032705', 3, 'ID', 'Kec. Bodeh', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032706', 3, 'ID', 'Kec. Bantarbolang', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032707', 3, 'ID', 'Kec. Randudongkel', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032708', 3, 'ID', 'Kec. Pemalang', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032709', 3, 'ID', 'Kec. Taman', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032710', 3, 'ID', 'Kec. Petarukan', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032711', 3, 'ID', 'Kec. Ampelgading', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032712', 3, 'ID', 'Kec. Comal', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032713', 3, 'ID', 'Kec. Ulujami', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032714', 3, 'ID', 'Kec. Warungpring', '032700');
INSERT INTO siakad.master_wilayah VALUES ('032800', 2, 'ID', 'Kab. Tegal', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032801', 3, 'ID', 'Kec. Margasari', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032802', 3, 'ID', 'Kec. Bumijawa', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032803', 3, 'ID', 'Kec. Bojong', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032804', 3, 'ID', 'Kec. Balapulang', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032805', 3, 'ID', 'Kec. Pagerbarang', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032806', 3, 'ID', 'Kec. Lebaksiu', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032807', 3, 'ID', 'Kec. Jatinegara', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032808', 3, 'ID', 'Kec. Kedung Banteng', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032809', 3, 'ID', 'Kec. Pangkah', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032810', 3, 'ID', 'Kec. Slawi', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032811', 3, 'ID', 'Kec. Dukuhwaru', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032812', 3, 'ID', 'Kec. Adiwerna', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032813', 3, 'ID', 'Kec. Dukuhturi', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032814', 3, 'ID', 'Kec. Talang', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032815', 3, 'ID', 'Kec. Tarub', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032816', 3, 'ID', 'Kec. Kramat', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032817', 3, 'ID', 'Kec. Suradadi', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032818', 3, 'ID', 'Kec. Warureja', '032800');
INSERT INTO siakad.master_wilayah VALUES ('032900', 2, 'ID', 'Kab. Brebes', '030000');
INSERT INTO siakad.master_wilayah VALUES ('032901', 3, 'ID', 'Kec. Salem', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032902', 3, 'ID', 'Kec. Bantarkawung', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032903', 3, 'ID', 'Kec. Bumiayu', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032904', 3, 'ID', 'Kec. Paguyangan', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032905', 3, 'ID', 'Kec. Sirampog', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032906', 3, 'ID', 'Kec. Tonjong', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032907', 3, 'ID', 'Kec. Larangan', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032908', 3, 'ID', 'Kec. Ketanggungan', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032909', 3, 'ID', 'Kec. Banjarharjo', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032910', 3, 'ID', 'Kec. Losari', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032911', 3, 'ID', 'Kec. Tanjung', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032912', 3, 'ID', 'Kec. Kersana', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032913', 3, 'ID', 'Kec. Bulakamba', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032914', 3, 'ID', 'Kec. Wanasari', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032915', 3, 'ID', 'Kec. Songgom', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032916', 3, 'ID', 'Kec. Jatibarang', '032900');
INSERT INTO siakad.master_wilayah VALUES ('032917', 3, 'ID', 'Kec. Brebes', '032900');
INSERT INTO siakad.master_wilayah VALUES ('036000', 2, 'ID', 'Kota Magelang', '030000');
INSERT INTO siakad.master_wilayah VALUES ('036001', 3, 'ID', 'Kec. Magelang Selatan', '036000');
INSERT INTO siakad.master_wilayah VALUES ('036002', 3, 'ID', 'Kec. Magelang Utara', '036000');
INSERT INTO siakad.master_wilayah VALUES ('036003', 3, 'ID', 'Kec. Magelang Tengah', '036000');
INSERT INTO siakad.master_wilayah VALUES ('036100', 2, 'ID', 'Kota Surakarta', '030000');
INSERT INTO siakad.master_wilayah VALUES ('036101', 3, 'ID', 'Kec. Laweyan', '036100');
INSERT INTO siakad.master_wilayah VALUES ('036102', 3, 'ID', 'Kec. Serengan', '036100');
INSERT INTO siakad.master_wilayah VALUES ('036103', 3, 'ID', 'Kec. Pasarkliwon', '036100');
INSERT INTO siakad.master_wilayah VALUES ('036104', 3, 'ID', 'Kec. Jebres', '036100');
INSERT INTO siakad.master_wilayah VALUES ('036105', 3, 'ID', 'Kec. Banjarsari', '036100');
INSERT INTO siakad.master_wilayah VALUES ('036200', 2, 'ID', 'Kota Salatiga', '030000');
INSERT INTO siakad.master_wilayah VALUES ('036201', 3, 'ID', 'Kec. Argomulyo', '036200');
INSERT INTO siakad.master_wilayah VALUES ('036202', 3, 'ID', 'Kec. Tingkir', '036200');
INSERT INTO siakad.master_wilayah VALUES ('036203', 3, 'ID', 'Kec. Sidomukti', '036200');
INSERT INTO siakad.master_wilayah VALUES ('036204', 3, 'ID', 'Kec. Sidorejo', '036200');
INSERT INTO siakad.master_wilayah VALUES ('036300', 2, 'ID', 'Kota Semarang', '030000');
INSERT INTO siakad.master_wilayah VALUES ('036301', 3, 'ID', 'Kec. Mijen', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036302', 3, 'ID', 'Kec. Gunung Pati', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036303', 3, 'ID', 'Kec. Banyumanik', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036304', 3, 'ID', 'Kec. Gajah Mungkur', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036305', 3, 'ID', 'Kec. Semarang Selatan', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036306', 3, 'ID', 'Kec. Candisari', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036307', 3, 'ID', 'Kec. Tembalang', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036308', 3, 'ID', 'Kec. Pedurungan', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036309', 3, 'ID', 'Kec. Genuk', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036310', 3, 'ID', 'Kec. Gayamsari', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036311', 3, 'ID', 'Kec. Semarang Timur', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036312', 3, 'ID', 'Kec. Semarang Tengah', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036313', 3, 'ID', 'Kec. Semarang Utara', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036314', 3, 'ID', 'Kec. Semarang Barat', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036315', 3, 'ID', 'Kec. Tugu', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036316', 3, 'ID', 'Kec. Ngaliyan', '036300');
INSERT INTO siakad.master_wilayah VALUES ('036400', 2, 'ID', 'Kota Pekalongan', '030000');
INSERT INTO siakad.master_wilayah VALUES ('036401', 3, 'ID', 'Kec. Pekalongan Barat', '036400');
INSERT INTO siakad.master_wilayah VALUES ('036402', 3, 'ID', 'Kec. Pekalongan Timur', '036400');
INSERT INTO siakad.master_wilayah VALUES ('036403', 3, 'ID', 'Kec. Pekalongan Selatan', '036400');
INSERT INTO siakad.master_wilayah VALUES ('036404', 3, 'ID', 'Kec. Pekalongan Utara', '036400');
INSERT INTO siakad.master_wilayah VALUES ('036500', 2, 'ID', 'Kota Tegal', '030000');
INSERT INTO siakad.master_wilayah VALUES ('036501', 3, 'ID', 'Kec. Tegal Selatan', '036500');
INSERT INTO siakad.master_wilayah VALUES ('036502', 3, 'ID', 'Kec. Tegal Timur', '036500');
INSERT INTO siakad.master_wilayah VALUES ('036503', 3, 'ID', 'Kec. Tegal Barat', '036500');
INSERT INTO siakad.master_wilayah VALUES ('036504', 3, 'ID', 'Kec. Margadana', '036500');
INSERT INTO siakad.master_wilayah VALUES ('040000', 1, 'ID', 'Prov. D.I. Yogyakarta', '000000');
INSERT INTO siakad.master_wilayah VALUES ('040100', 2, 'ID', 'Kab. Bantul', '040000');
INSERT INTO siakad.master_wilayah VALUES ('040101', 3, 'ID', 'Kec. Srandakan', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040102', 3, 'ID', 'Kec. Sanden', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040103', 3, 'ID', 'Kec. Kretek', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040104', 3, 'ID', 'Kec. Pundong', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040105', 3, 'ID', 'Kec. Bambang Lipuro', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040106', 3, 'ID', 'Kec. Pandak', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040107', 3, 'ID', 'Kec. Bantul', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040108', 3, 'ID', 'Kec. Jetis', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040109', 3, 'ID', 'Kec. Imogiri', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040110', 3, 'ID', 'Kec. Dlingo', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040111', 3, 'ID', 'Kec. Pleret', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040112', 3, 'ID', 'Kec. Piyungan', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040113', 3, 'ID', 'Kec. Banguntapan', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040114', 3, 'ID', 'Kec. Sewon', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040115', 3, 'ID', 'Kec. Kasihan', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040116', 3, 'ID', 'Kec. Pajangan', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040117', 3, 'ID', 'Kec. Sedayu', '040100');
INSERT INTO siakad.master_wilayah VALUES ('040200', 2, 'ID', 'Kab. Sleman', '040000');
INSERT INTO siakad.master_wilayah VALUES ('040201', 3, 'ID', 'Kec. Moyudan', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040202', 3, 'ID', 'Kec. Minggir', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040203', 3, 'ID', 'Kec. Seyegan', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040204', 3, 'ID', 'Kec. Godean', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040205', 3, 'ID', 'Kec. Gamping', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040206', 3, 'ID', 'Kec. Mlati', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040207', 3, 'ID', 'Kec. Depok', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040208', 3, 'ID', 'Kec. Berbah', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040209', 3, 'ID', 'Kec. Prambanan', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040210', 3, 'ID', 'Kec. Kalasan', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040211', 3, 'ID', 'Kec. Ngemplak', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040212', 3, 'ID', 'Kec. Ngaglik', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040213', 3, 'ID', 'Kec. Sleman', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040214', 3, 'ID', 'Kec. Tempel', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040215', 3, 'ID', 'Kec. Turi', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040216', 3, 'ID', 'Kec. Pekem', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040217', 3, 'ID', 'Kec. Cangkringan', '040200');
INSERT INTO siakad.master_wilayah VALUES ('040300', 2, 'ID', 'Kab. Gunung Kidul', '040000');
INSERT INTO siakad.master_wilayah VALUES ('040301', 3, 'ID', 'Kec. Panggang', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040302', 3, 'ID', 'Kec. Paliyan', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040303', 3, 'ID', 'Kec. Sapto Sari', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040304', 3, 'ID', 'Kec. Tepus', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040305', 3, 'ID', 'Kec. Rongkop', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040306', 3, 'ID', 'Kec. Semanu', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040307', 3, 'ID', 'Kec. Ponjong', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040308', 3, 'ID', 'Kec. Karangmojo', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040309', 3, 'ID', 'Kec. Wonosari', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040310', 3, 'ID', 'Kec. Playen', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040311', 3, 'ID', 'Kec. Patuk', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040312', 3, 'ID', 'Kec. Gedang Sari', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040313', 3, 'ID', 'Kec. Nglipar', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040314', 3, 'ID', 'Kec. Ngawen', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040315', 3, 'ID', 'Kec. Semin', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040316', 3, 'ID', 'Kec. Purwosari', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040317', 3, 'ID', 'Kec. Girisubo', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040318', 3, 'ID', 'Kec. Tanjungsari', '040300');
INSERT INTO siakad.master_wilayah VALUES ('040400', 2, 'ID', 'Kab. Kulon Progo', '040000');
INSERT INTO siakad.master_wilayah VALUES ('040401', 3, 'ID', 'Kec. Temon', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040402', 3, 'ID', 'Kec. Wates', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040403', 3, 'ID', 'Kec. Panjatan', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040404', 3, 'ID', 'Kec. Galur', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040405', 3, 'ID', 'Kec. Lendah', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040406', 3, 'ID', 'Kec. Sentolo', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040407', 3, 'ID', 'Kec. Pengasih', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040408', 3, 'ID', 'Kec. Kokap', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040409', 3, 'ID', 'Kec. Girimulyo', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040410', 3, 'ID', 'Kec. Nanggulan', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040411', 3, 'ID', 'Kec. Kalibawang', '040400');
INSERT INTO siakad.master_wilayah VALUES ('040412', 3, 'ID', 'Kec. Samigaluh', '040400');
INSERT INTO siakad.master_wilayah VALUES ('046000', 2, 'ID', 'Kota Yogyakarta', '040000');
INSERT INTO siakad.master_wilayah VALUES ('046001', 3, 'ID', 'Kec. Mantrijeron', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046002', 3, 'ID', 'Kec. Kraton', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046003', 3, 'ID', 'Kec. Mergangsan', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046004', 3, 'ID', 'Kec. Umbulharjo', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046005', 3, 'ID', 'Kec. Kotagede', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046006', 3, 'ID', 'Kec. Gondokusuman', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046007', 3, 'ID', 'Kec. Danurejan', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046008', 3, 'ID', 'Kec. Pakualaman', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046009', 3, 'ID', 'Kec. Gondomanan', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046010', 3, 'ID', 'Kec. Ngampilan', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046011', 3, 'ID', 'Kec. Wirobrajan', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046012', 3, 'ID', 'Kec. Gedongtengen', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046013', 3, 'ID', 'Kec. Jetis', '046000');
INSERT INTO siakad.master_wilayah VALUES ('046014', 3, 'ID', 'Kec. Tegalrejo', '046000');
INSERT INTO siakad.master_wilayah VALUES ('050000', 1, 'ID', 'Prov. Jawa Timur', '000000');
INSERT INTO siakad.master_wilayah VALUES ('050100', 2, 'ID', 'Kab. Gresik', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050101', 3, 'ID', 'Kec. Wringin Anom', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050102', 3, 'ID', 'Kec. Driyorejo', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050103', 3, 'ID', 'Kec. Kedamean', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050104', 3, 'ID', 'Kec. Menganti', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050105', 3, 'ID', 'Kec. Cerme', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050106', 3, 'ID', 'Kec. Benjeng', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050107', 3, 'ID', 'Kec. Balong Panggang', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050108', 3, 'ID', 'Kec. Duduk Sampeyan', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050109', 3, 'ID', 'Kec. Kebomas', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050110', 3, 'ID', 'Kec. Gresik', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050111', 3, 'ID', 'Kec. Manyar', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050112', 3, 'ID', 'Kec. Bungah', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050113', 3, 'ID', 'Kec. Sidayu', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050114', 3, 'ID', 'Kec. Dukun', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050115', 3, 'ID', 'Kec. Panceng', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050116', 3, 'ID', 'Kec. Ujung Pangkah', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050117', 3, 'ID', 'Kec. Sangkapura', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050118', 3, 'ID', 'Kec. Tambak', '050100');
INSERT INTO siakad.master_wilayah VALUES ('050200', 2, 'ID', 'Kab. Sidoarjo', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050201', 3, 'ID', 'Kec. Tarik', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050202', 3, 'ID', 'Kec. Prambon', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050203', 3, 'ID', 'Kec. Krembung', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050204', 3, 'ID', 'Kec. Porong', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050205', 3, 'ID', 'Kec. Jabon', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050206', 3, 'ID', 'Kec. Tanggulangin', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050207', 3, 'ID', 'Kec. Candi', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050208', 3, 'ID', 'Kec. Tulangan', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050209', 3, 'ID', 'Kec. Wonoayu', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050210', 3, 'ID', 'Kec. Sukodono', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050211', 3, 'ID', 'Kec. Sidoarjo', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050212', 3, 'ID', 'Kec. Buduran', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050213', 3, 'ID', 'Kec. Sedati', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050214', 3, 'ID', 'Kec. Waru', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050215', 3, 'ID', 'Kec. Gedangan', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050216', 3, 'ID', 'Kec. Taman', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050217', 3, 'ID', 'Kec. Krian', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050218', 3, 'ID', 'Kec. Balong Bendo', '050200');
INSERT INTO siakad.master_wilayah VALUES ('050300', 2, 'ID', 'Kab. Mojokerto', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050301', 3, 'ID', 'Kec. Jatirejo', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050302', 3, 'ID', 'Kec. Gondang', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050303', 3, 'ID', 'Kec. Pacet', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050304', 3, 'ID', 'Kec. Trawas', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050305', 3, 'ID', 'Kec. Ngoro', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050306', 3, 'ID', 'Kec. Pungging', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050307', 3, 'ID', 'Kec. Kutorejo', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050308', 3, 'ID', 'Kec. Mojosari', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050309', 3, 'ID', 'Kec. Bangsal', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050310', 3, 'ID', 'Kec. Dlanggu', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050311', 3, 'ID', 'Kec. Puri', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050312', 3, 'ID', 'Kec. Trowulan', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050313', 3, 'ID', 'Kec. Sooko', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050314', 3, 'ID', 'Kec. Gedek', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050315', 3, 'ID', 'Kec. Kemlagi', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050316', 3, 'ID', 'Kec. Jetis', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050317', 3, 'ID', 'Kec. Dawar Blandong', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050318', 3, 'ID', 'Kec. Mojoanyar', '050300');
INSERT INTO siakad.master_wilayah VALUES ('050400', 2, 'ID', 'Kab. Jombang', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050401', 3, 'ID', 'Kec. Bandar Kedung Mulyo', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050402', 3, 'ID', 'Kec. Perak', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050403', 3, 'ID', 'Kec. Gudo', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050404', 3, 'ID', 'Kec. Diwek', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050405', 3, 'ID', 'Kec. Ngoro', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050406', 3, 'ID', 'Kec. Mojowarno', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050407', 3, 'ID', 'Kec. Bareng', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050408', 3, 'ID', 'Kec. Wonosalam', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050409', 3, 'ID', 'Kec. Mojoagung', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050410', 3, 'ID', 'Kec. Somobito', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050411', 3, 'ID', 'Kec. Jogo Roto', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050412', 3, 'ID', 'Kec. Peterongan', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050413', 3, 'ID', 'Kec. Jombang', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050414', 3, 'ID', 'Kec. Megaluh', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050415', 3, 'ID', 'Kec. Tembelang', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050416', 3, 'ID', 'Kec. Kesamben', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050417', 3, 'ID', 'Kec. Kudu', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050418', 3, 'ID', 'Kec. Ploso', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050419', 3, 'ID', 'Kec. Kabuh', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050420', 3, 'ID', 'Kec. Plandaan', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050421', 3, 'ID', 'Kec. Ngusikan', '050400');
INSERT INTO siakad.master_wilayah VALUES ('050500', 2, 'ID', 'Kab. Bojonegoro', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050501', 3, 'ID', 'Kec. Margomulyo', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050502', 3, 'ID', 'Kec. Ngraho', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050503', 3, 'ID', 'Kec. Tambakrejo', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050504', 3, 'ID', 'Kec. Ngambon', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050505', 3, 'ID', 'Kec. Bubulan', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050506', 3, 'ID', 'Kec. Temayang', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050507', 3, 'ID', 'Kec. Sugihwaras', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050508', 3, 'ID', 'Kec. Kedungadem', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050509', 3, 'ID', 'Kec. Kepoh Baru', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050510', 3, 'ID', 'Kec. Baureno', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050511', 3, 'ID', 'Kec. Kanor', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050512', 3, 'ID', 'Kec. Sumberrejo', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050513', 3, 'ID', 'Kec. Balen', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050514', 3, 'ID', 'Kec. Sukosewu', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050515', 3, 'ID', 'Kec. Kapas', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050516', 3, 'ID', 'Kec. Bojonegoro', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050517', 3, 'ID', 'Kec. Trucuk', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050518', 3, 'ID', 'Kec. Dander', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050519', 3, 'ID', 'Kec. Ngasem', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050520', 3, 'ID', 'Kec. Kalitidu', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050521', 3, 'ID', 'Kec. Malo', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050522', 3, 'ID', 'Kec. Purwosari', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050523', 3, 'ID', 'Kec. Padangan', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050524', 3, 'ID', 'Kec. Kasiman', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050525', 3, 'ID', 'Kec. Kedewan', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050526', 3, 'ID', 'Kec. Gondang', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050527', 3, 'ID', 'Kec. Sekar', '050500');
INSERT INTO siakad.master_wilayah VALUES ('050600', 2, 'ID', 'Kab. Tuban', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050601', 3, 'ID', 'Kec. Kenduruan', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050602', 3, 'ID', 'Kec. Bangilan', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050603', 3, 'ID', 'Kec. Senori', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050604', 3, 'ID', 'Kec. Singgahan', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050605', 3, 'ID', 'Kec. Montong', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050606', 3, 'ID', 'Kec. Parengan', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050607', 3, 'ID', 'Kec. Soko', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050608', 3, 'ID', 'Kec. Rengel', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050609', 3, 'ID', 'Kec. Plumpang', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050610', 3, 'ID', 'Kec. Widang', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050611', 3, 'ID', 'Kec. Palang', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050612', 3, 'ID', 'Kec. Semanding', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050613', 3, 'ID', 'Kec. Tuban', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050614', 3, 'ID', 'Kec. Jenu', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050615', 3, 'ID', 'Kec. Merakurak', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050616', 3, 'ID', 'Kec. Kerek', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050617', 3, 'ID', 'Kec. Tambakboyo', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050618', 3, 'ID', 'Kec. Jatirogo', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050619', 3, 'ID', 'Kec. Bancar', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050620', 3, 'ID', 'Kec. Grabagan', '050600');
INSERT INTO siakad.master_wilayah VALUES ('050700', 2, 'ID', 'Kab. Lamongan', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050701', 3, 'ID', 'Kec. Sukorame', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050702', 3, 'ID', 'Kec. Bluluk', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050703', 3, 'ID', 'Kec. Ngimbang', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050704', 3, 'ID', 'Kec. Sambeng', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050705', 3, 'ID', 'Kec. Mantup', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050706', 3, 'ID', 'Kec. Kambang Bahu', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050707', 3, 'ID', 'Kec. Sugio', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050708', 3, 'ID', 'Kec. Kedungpring', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050709', 3, 'ID', 'Kec. Modo', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050710', 3, 'ID', 'Kec. Babat', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050711', 3, 'ID', 'Kec. Pucuk', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050712', 3, 'ID', 'Kec. Sukodadi', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050713', 3, 'ID', 'Kec. Lamongan', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050714', 3, 'ID', 'Kec. Tikung', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050715', 3, 'ID', 'Kec. Deket', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050716', 3, 'ID', 'Kec. Glagah', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050717', 3, 'ID', 'Kec. Karangbinangun', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050718', 3, 'ID', 'Kec. Turi', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050719', 3, 'ID', 'Kec. Kalitengah', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050720', 3, 'ID', 'Kec. Karang Geneng', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050721', 3, 'ID', 'Kec. Sekaran', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050722', 3, 'ID', 'Kec. Maduran', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050723', 3, 'ID', 'Kec. Laren', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050724', 3, 'ID', 'Kec. Solokuro', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050725', 3, 'ID', 'Kec. Paciran', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050726', 3, 'ID', 'Kec. Brondong', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050727', 3, 'ID', 'Kec. Sarirejo', '050700');
INSERT INTO siakad.master_wilayah VALUES ('050800', 2, 'ID', 'Kab. Madiun', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050801', 3, 'ID', 'Kec. Kebonsari', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050802', 3, 'ID', 'Kec. Geger', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050803', 3, 'ID', 'Kec. Dolopo', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050804', 3, 'ID', 'Kec. Dagangan', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050805', 3, 'ID', 'Kec. Wungu', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050806', 3, 'ID', 'Kec. Kare', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050807', 3, 'ID', 'Kec. Gemarang', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050808', 3, 'ID', 'Kec. Saradan', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050809', 3, 'ID', 'Kec. Pilangkenceng', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050810', 3, 'ID', 'Kec. Mejayan', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050811', 3, 'ID', 'Kec. Wonoasri', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050812', 3, 'ID', 'Kec. Balerejo', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050813', 3, 'ID', 'Kec. Madiun', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050814', 3, 'ID', 'Kec. Sawahan', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050815', 3, 'ID', 'Kec. Jiwan', '050800');
INSERT INTO siakad.master_wilayah VALUES ('050900', 2, 'ID', 'Kab. Ngawi', '050000');
INSERT INTO siakad.master_wilayah VALUES ('050901', 3, 'ID', 'Kec. Sine', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050902', 3, 'ID', 'Kec. Ngrambe', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050903', 3, 'ID', 'Kec. Jogorogo', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050904', 3, 'ID', 'Kec. Kendal', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050905', 3, 'ID', 'Kec. Geneng', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050906', 3, 'ID', 'Kec. Kwadungan', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050907', 3, 'ID', 'Kec. Pangkur', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050908', 3, 'ID', 'Kec. Karangjati', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050909', 3, 'ID', 'Kec. Bringin', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050910', 3, 'ID', 'Kec. Padas', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050911', 3, 'ID', 'Kec. Ngawi', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050912', 3, 'ID', 'Kec. Paron', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050913', 3, 'ID', 'Kec. Kedunggalar', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050914', 3, 'ID', 'Kec. Pitu', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050915', 3, 'ID', 'Kec. Widodaren', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050916', 3, 'ID', 'Kec. Mantingan', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050917', 3, 'ID', 'Kec. Karanganyar', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050918', 3, 'ID', 'Kec. Gerih', '050900');
INSERT INTO siakad.master_wilayah VALUES ('050919', 3, 'ID', 'Kec. Kasreman', '050900');
INSERT INTO siakad.master_wilayah VALUES ('051000', 2, 'ID', 'Kab. Magetan', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051001', 3, 'ID', 'Kec. Poncol', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051002', 3, 'ID', 'Kec. Parang', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051003', 3, 'ID', 'Kec. Lembeyan', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051004', 3, 'ID', 'Kec. Takeran', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051005', 3, 'ID', 'Kec. Kawedanan', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051006', 3, 'ID', 'Kec. Magetan', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051007', 3, 'ID', 'Kec. Plaosan', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051008', 3, 'ID', 'Kec. Panekan', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051009', 3, 'ID', 'Kec. Sukomoro', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051010', 3, 'ID', 'Kec. Bendo', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051011', 3, 'ID', 'Kec. Maospati', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051012', 3, 'ID', 'Kec. Karangrejo', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051014', 3, 'ID', 'Kec. Barat', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051015', 3, 'ID', 'Kec. Kartoharjo', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051016', 3, 'ID', 'Kec. Karas', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051017', 3, 'ID', 'Kec. Ngariboyo', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051018', 3, 'ID', 'Kec. Nguntoronadi', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051019', 3, 'ID', 'Kec. Sidorejo', '051000');
INSERT INTO siakad.master_wilayah VALUES ('051100', 2, 'ID', 'Kab. Ponorogo', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051101', 3, 'ID', 'Kec. Ngrayun', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051102', 3, 'ID', 'Kec. Slahung', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051103', 3, 'ID', 'Kec. Bungkal', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051104', 3, 'ID', 'Kec. Sambit', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051105', 3, 'ID', 'Kec. Sawoo', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051106', 3, 'ID', 'Kec. Sooko', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051107', 3, 'ID', 'Kec. Pulung', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051108', 3, 'ID', 'Kec. Mlarak', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051109', 3, 'ID', 'Kec. Siman', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051110', 3, 'ID', 'Kec. Jetis', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051111', 3, 'ID', 'Kec. Balong', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051112', 3, 'ID', 'Kec. Kauman', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051113', 3, 'ID', 'Kec. Jambon', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051114', 3, 'ID', 'Kec. Badegan', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051115', 3, 'ID', 'Kec. Sampung', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051116', 3, 'ID', 'Kec. Sukorejo', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051117', 3, 'ID', 'Kec. Ponorogo', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051118', 3, 'ID', 'Kec. Babadan', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051119', 3, 'ID', 'Kec. Jenangan', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051120', 3, 'ID', 'Kec. Ngebel', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051121', 3, 'ID', 'Kec. Pudak', '051100');
INSERT INTO siakad.master_wilayah VALUES ('051200', 2, 'ID', 'Kab. Pacitan', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051201', 3, 'ID', 'Kec. Donorejo', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051202', 3, 'ID', 'Kec. Punung', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051203', 3, 'ID', 'Kec. Pringkuku', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051204', 3, 'ID', 'Kec. Pacitan', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051205', 3, 'ID', 'Kec. Kebon Agung', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051206', 3, 'ID', 'Kec. Arjosari', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051207', 3, 'ID', 'Kec. Nawangan', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051208', 3, 'ID', 'Kec. Bandar', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051209', 3, 'ID', 'Kec. Tegalombo', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051210', 3, 'ID', 'Kec. Tulakan', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051211', 3, 'ID', 'Kec. Ngadirojo', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051212', 3, 'ID', 'Kec. Sudimoro', '051200');
INSERT INTO siakad.master_wilayah VALUES ('051300', 2, 'ID', 'Kab. Kediri', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051301', 3, 'ID', 'Kec. Kras', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051302', 3, 'ID', 'Kec. Ringinrejo', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051303', 3, 'ID', 'Kec. Ngancar', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051304', 3, 'ID', 'Kec. Kepung', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051305', 3, 'ID', 'Kec. Puncu', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051306', 3, 'ID', 'Kec. Ploso Klaten', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051307', 3, 'ID', 'Kec. Wates', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051308', 3, 'ID', 'Kec. Kandat', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051309', 3, 'ID', 'Kec. Ngadiluwih', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051310', 3, 'ID', 'Kec. Mojo', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051311', 3, 'ID', 'Kec. Semen', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051312', 3, 'ID', 'Kec. Banyakan', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051313', 3, 'ID', 'Kec. Tarokan', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051314', 3, 'ID', 'Kec. Grogol', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051315', 3, 'ID', 'Kec. Gampengrejo', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051316', 3, 'ID', 'Kec. Gurah', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051317', 3, 'ID', 'Kec. Pagu', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051318', 3, 'ID', 'Kec. Papar', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051319', 3, 'ID', 'Kec. Plemahan', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051320', 3, 'ID', 'Kec. Purwoasri', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051321', 3, 'ID', 'Kec. Kunjang', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051322', 3, 'ID', 'Kec. Pare', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051323', 3, 'ID', 'Kec. Kandangan', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051324', 3, 'ID', 'Kec. Kayen Kidul', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051325', 3, 'ID', 'Kec. Ngasem', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051326', 3, 'ID', 'Kec. Badas', '051300');
INSERT INTO siakad.master_wilayah VALUES ('051400', 2, 'ID', 'Kab. Nganjuk', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051401', 3, 'ID', 'Kec. Sawahan', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051402', 3, 'ID', 'Kec. Ngetos', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051403', 3, 'ID', 'Kec. Berbek', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051404', 3, 'ID', 'Kec. Loceret', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051405', 3, 'ID', 'Kec. Pace', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051406', 3, 'ID', 'Kec. Tanjunganom', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051407', 3, 'ID', 'Kec. Prambon', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051408', 3, 'ID', 'Kec. Ngronggot', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051409', 3, 'ID', 'Kec. Kertosono', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051410', 3, 'ID', 'Kec. Patianrowo', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051411', 3, 'ID', 'Kec. Baron', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051412', 3, 'ID', 'Kec. Gondang', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051413', 3, 'ID', 'Kec. Sukomoro', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051414', 3, 'ID', 'Kec. Nganjuk', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051415', 3, 'ID', 'Kec. Bagor', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051416', 3, 'ID', 'Kec. Wilangan', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051417', 3, 'ID', 'Kec. Rejoso', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051418', 3, 'ID', 'Kec. Ngluyu', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051419', 3, 'ID', 'Kec. Lengkong', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051420', 3, 'ID', 'Kec. Jatikalen', '051400');
INSERT INTO siakad.master_wilayah VALUES ('051500', 2, 'ID', 'Kab. Blitar', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051501', 3, 'ID', 'Kec. Bakung', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051502', 3, 'ID', 'Kec. Wonotirto', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051503', 3, 'ID', 'Kec. Panggungrejo', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051504', 3, 'ID', 'Kec. Wates', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051505', 3, 'ID', 'Kec. Binangun', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051506', 3, 'ID', 'Kec. Sutojayan', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051507', 3, 'ID', 'Kec. Kademangan', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051508', 3, 'ID', 'Kec. Kanigoro', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051509', 3, 'ID', 'Kec. Talun', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051510', 3, 'ID', 'Kec. Selopuro', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051511', 3, 'ID', 'Kec. Kesamben', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051512', 3, 'ID', 'Kec. Selorejo', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051513', 3, 'ID', 'Kec. Doko', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051514', 3, 'ID', 'Kec. Wlingi', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051515', 3, 'ID', 'Kec. Gandusari', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051516', 3, 'ID', 'Kec. Garum', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051517', 3, 'ID', 'Kec. Nglegok', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051518', 3, 'ID', 'Kec. Sanankulon', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051519', 3, 'ID', 'Kec. Ponggok', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051520', 3, 'ID', 'Kec. Srengat', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051521', 3, 'ID', 'Kec. Wonodadi', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051522', 3, 'ID', 'Kec. Udanawu', '051500');
INSERT INTO siakad.master_wilayah VALUES ('051600', 2, 'ID', 'Kab. Tulungagung', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051601', 3, 'ID', 'Kec. Besuki', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051602', 3, 'ID', 'Kec. Bandung', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051603', 3, 'ID', 'Kec. Pakel', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051604', 3, 'ID', 'Kec. Campur Darat', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051605', 3, 'ID', 'Kec. Tanggung Gunung', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051606', 3, 'ID', 'Kec. Kalidawir', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051607', 3, 'ID', 'Kec. Pucang Laban', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051608', 3, 'ID', 'Kec. Rejotangan', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051609', 3, 'ID', 'Kec. Ngunut', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051610', 3, 'ID', 'Kec. Sumbergempol', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051611', 3, 'ID', 'Kec. Boyolangu', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051612', 3, 'ID', 'Kec. Tulungagung', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051613', 3, 'ID', 'Kec. Kedungwaru', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051614', 3, 'ID', 'Kec. Ngantru', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051615', 3, 'ID', 'Kec. Karangrejo', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051616', 3, 'ID', 'Kec. Kauman', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051617', 3, 'ID', 'Kec. Gondang', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051618', 3, 'ID', 'Kec. Pagerwojo', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051619', 3, 'ID', 'Kec. Sendang', '051600');
INSERT INTO siakad.master_wilayah VALUES ('051700', 2, 'ID', 'Kab. Trenggalek', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051701', 3, 'ID', 'Kec. Panggul', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051702', 3, 'ID', 'Kec. Munjungan', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051703', 3, 'ID', 'Kec. Watulimo', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051704', 3, 'ID', 'Kec. Kampak', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051705', 3, 'ID', 'Kec. Dongko', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051706', 3, 'ID', 'Kec. Pule', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051707', 3, 'ID', 'Kec. Karangan', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051708', 3, 'ID', 'Kec. Gandusari', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051709', 3, 'ID', 'Kec. Durenan', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051710', 3, 'ID', 'Kec. Pogalan', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051711', 3, 'ID', 'Kec. Trenggalek', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051712', 3, 'ID', 'Kec. Tugu', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051713', 3, 'ID', 'Kec. Bendungan', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051714', 3, 'ID', 'Kec. Suruh', '051700');
INSERT INTO siakad.master_wilayah VALUES ('051800', 2, 'ID', 'Kab. Malang', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051801', 3, 'ID', 'Kec. Donomulyo', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051802', 3, 'ID', 'Kec. Kalipare', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051803', 3, 'ID', 'Kec. Pagak', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051804', 3, 'ID', 'Kec. Bantur', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051805', 3, 'ID', 'Kec. Gedangan', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051806', 3, 'ID', 'Kec. Sumber Manjing Wetan', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051807', 3, 'ID', 'Kec. Dampit', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051808', 3, 'ID', 'Kec. Tirto Yudo', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051809', 3, 'ID', 'Kec. Ampelgading', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051810', 3, 'ID', 'Kec. Poncokusumo', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051811', 3, 'ID', 'Kec. Wajak', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051812', 3, 'ID', 'Kec. Turen', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051813', 3, 'ID', 'Kec. Pagelaran', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051814', 3, 'ID', 'Kec. Gondanglegi', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051815', 3, 'ID', 'Kec. Bululawang', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051816', 3, 'ID', 'Kec. Kepanjen', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051817', 3, 'ID', 'Kec. Sumberpucung', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051818', 3, 'ID', 'Kec. Kromengan', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051819', 3, 'ID', 'Kec. Wonosari', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051820', 3, 'ID', 'Kec. Ngajum', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051821', 3, 'ID', 'Kec. Wagir', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051822', 3, 'ID', 'Kec. Pakisaji', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051823', 3, 'ID', 'Kec. Tajinan', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051824', 3, 'ID', 'Kec. Tumpang', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051825', 3, 'ID', 'Kec. Pakis', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051826', 3, 'ID', 'Kec. Jabung', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051827', 3, 'ID', 'Kec. Lawang', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051828', 3, 'ID', 'Kec. Singosari', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051829', 3, 'ID', 'Kec. Karangploso', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051830', 3, 'ID', 'Kec. Dau', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051831', 3, 'ID', 'Kec. Pujon', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051832', 3, 'ID', 'Kec. Ngantang', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051833', 3, 'ID', 'Kec. Kasembon', '051800');
INSERT INTO siakad.master_wilayah VALUES ('051900', 2, 'ID', 'Kab. Pasuruan', '050000');
INSERT INTO siakad.master_wilayah VALUES ('051901', 3, 'ID', 'Kec. Purwodadi', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051902', 3, 'ID', 'Kec. Tutur', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051903', 3, 'ID', 'Kec. Puspo', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051904', 3, 'ID', 'Kec. Tosari', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051905', 3, 'ID', 'Kec. Lumbang', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051906', 3, 'ID', 'Kec. Pasrepan', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051907', 3, 'ID', 'Kec. Kejayan', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051908', 3, 'ID', 'Kec. Wonorejo', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051909', 3, 'ID', 'Kec. Purwosari', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051910', 3, 'ID', 'Kec. Prigen', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051911', 3, 'ID', 'Kec. Sukorejo', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051912', 3, 'ID', 'Kec. Pandaan', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051913', 3, 'ID', 'Kec. Gempol', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051914', 3, 'ID', 'Kec. Beji', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051915', 3, 'ID', 'Kec. Bangil', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051916', 3, 'ID', 'Kec. Rembang', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051917', 3, 'ID', 'Kec. Kraton', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051918', 3, 'ID', 'Kec. Pohjentrek', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051919', 3, 'ID', 'Kec. Gondang Wetan', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051920', 3, 'ID', 'Kec. Rejoso', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051921', 3, 'ID', 'Kec. Winongan', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051922', 3, 'ID', 'Kec. Grati', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051923', 3, 'ID', 'Kec. Lekok', '051900');
INSERT INTO siakad.master_wilayah VALUES ('051924', 3, 'ID', 'Kec. Nguling', '051900');
INSERT INTO siakad.master_wilayah VALUES ('052000', 2, 'ID', 'Kab. Probolinggo', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052001', 3, 'ID', 'Kec. Sukapura', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052002', 3, 'ID', 'Kec. Sumber', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052003', 3, 'ID', 'Kec. Kuripan', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052004', 3, 'ID', 'Kec. Bantaran', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052005', 3, 'ID', 'Kec. Leces', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052006', 3, 'ID', 'Kec. Tegal Siwalan', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052007', 3, 'ID', 'Kec. Banyu Anyar', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052008', 3, 'ID', 'Kec. Tiris', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052009', 3, 'ID', 'Kec. Krucil', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052010', 3, 'ID', 'Kec. Gading', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052011', 3, 'ID', 'Kec. Pakuniran', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052012', 3, 'ID', 'Kec. Kota Anyar', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052013', 3, 'ID', 'Kec. Paiton', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052014', 3, 'ID', 'Kec. Besuk', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052015', 3, 'ID', 'Kec. Kraksaan', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052016', 3, 'ID', 'Kec. Krejengan', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052017', 3, 'ID', 'Kec. Pajarakan', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052018', 3, 'ID', 'Kec. Maron', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052019', 3, 'ID', 'Kec. Gending', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052020', 3, 'ID', 'Kec. Dringu', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052021', 3, 'ID', 'Kec. Wonomerto', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052022', 3, 'ID', 'Kec. Lumbang', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052023', 3, 'ID', 'Kec. Tongas', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052024', 3, 'ID', 'Kec. Sumberasih', '052000');
INSERT INTO siakad.master_wilayah VALUES ('052100', 2, 'ID', 'Kab. Lumajang', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052101', 3, 'ID', 'Kec. Tempursari', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052102', 3, 'ID', 'Kec. Pronojiwo', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052103', 3, 'ID', 'Kec. Candipuro', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052104', 3, 'ID', 'Kec. Pasirian', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052105', 3, 'ID', 'Kec. Tempeh', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052106', 3, 'ID', 'Kec. Kunir', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052107', 3, 'ID', 'Kec. Yosowilangun', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052108', 3, 'ID', 'Kec. Rowokangkung', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052109', 3, 'ID', 'Kec. Tekung', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052110', 3, 'ID', 'Kec. Lumajang', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052111', 3, 'ID', 'Kec. Pasrujambe', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052112', 3, 'ID', 'Kec. Senduro', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052113', 3, 'ID', 'Kec. Padang', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052114', 3, 'ID', 'Kec. Sukodono', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052115', 3, 'ID', 'Kec. Jatiroto', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052116', 3, 'ID', 'Kec. Randuagung', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052117', 3, 'ID', 'Kec. Kedungjajang', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052118', 3, 'ID', 'Kec. Gucialit', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052119', 3, 'ID', 'Kec. Klakah', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052120', 3, 'ID', 'Kec. Ranuyoso', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052121', 3, 'ID', 'Kec. Sumbersuko', '052100');
INSERT INTO siakad.master_wilayah VALUES ('052200', 2, 'ID', 'Kab. Bondowoso', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052201', 3, 'ID', 'Kec. Maesan', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052202', 3, 'ID', 'Kec. Grujugan', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052203', 3, 'ID', 'Kec. Tamanan', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052204', 3, 'ID', 'Kec. Pujer', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052205', 3, 'ID', 'Kec. Tlogosari', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052206', 3, 'ID', 'Kec. Sukosari', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052207', 3, 'ID', 'Kec. Tapen', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052208', 3, 'ID', 'Kec. Wonosari', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052209', 3, 'ID', 'Kec. Tenggarang', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052210', 3, 'ID', 'Kec. Bondowoso', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052211', 3, 'ID', 'Kec. Curahdami', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052212', 3, 'ID', 'Kec. Pakem', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052213', 3, 'ID', 'Kec. Wringin', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052214', 3, 'ID', 'Kec. Tegalampel', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052215', 3, 'ID', 'Kec. Klabang', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052216', 3, 'ID', 'Kec. Prajekan', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052217', 3, 'ID', 'Kec. Cermee', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052218', 3, 'ID', 'Kec. Binakal', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052219', 3, 'ID', 'Kec. Sumber Wringin', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052220', 3, 'ID', 'Kec. Sempol', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052221', 3, 'ID', 'Kec. Jambesari Darus Sholah', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052222', 3, 'ID', 'Kec. Taman Krocok', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052223', 3, 'ID', 'Kec. Botolinggo', '052200');
INSERT INTO siakad.master_wilayah VALUES ('052300', 2, 'ID', 'Kab. Situbondo', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052301', 3, 'ID', 'Kec. Sumber Malang', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052302', 3, 'ID', 'Kec. Jatibanteng', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052303', 3, 'ID', 'Kec. Banyuglugur', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052304', 3, 'ID', 'Kec. Besuki', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052305', 3, 'ID', 'Kec. Suboh', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052306', 3, 'ID', 'Kec. Mlandingan', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052307', 3, 'ID', 'Kec. Bungatan', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052308', 3, 'ID', 'Kec. Kendit', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052309', 3, 'ID', 'Kec. Panarukan', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052310', 3, 'ID', 'Kec. Situbondo', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052311', 3, 'ID', 'Kec. Mangaran', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052312', 3, 'ID', 'Kec. Panji', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052313', 3, 'ID', 'Kec. Kapongan', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052314', 3, 'ID', 'Kec. Arjasa', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052315', 3, 'ID', 'Kec. Jangkar', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052316', 3, 'ID', 'Kec. Asembagus', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052317', 3, 'ID', 'Kec. Banyuputih', '052300');
INSERT INTO siakad.master_wilayah VALUES ('052400', 2, 'ID', 'Kab. Jember', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052401', 3, 'ID', 'Kec. Kencong', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052402', 3, 'ID', 'Kec. Gumuk Mas', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052403', 3, 'ID', 'Kec. Puger', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052404', 3, 'ID', 'Kec. Wuluhan', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052405', 3, 'ID', 'Kec. Ambulu', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052406', 3, 'ID', 'Kec. Tempurejo', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052407', 3, 'ID', 'Kec. Silo', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052408', 3, 'ID', 'Kec. Mayang', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052409', 3, 'ID', 'Kec. Mumbulsari', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052410', 3, 'ID', 'Kec. Jenggawah', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052411', 3, 'ID', 'Kec. Ajung', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052412', 3, 'ID', 'Kec. Rambipuji', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052413', 3, 'ID', 'Kec. Balung', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052414', 3, 'ID', 'Kec. Umbulsari', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052415', 3, 'ID', 'Kec. Semboro', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052416', 3, 'ID', 'Kec. Jombang', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052417', 3, 'ID', 'Kec. Sumberbaru', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052418', 3, 'ID', 'Kec. Tanggul', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052419', 3, 'ID', 'Kec. Bangsalsari', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052420', 3, 'ID', 'Kec. Panti', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052421', 3, 'ID', 'Kec. Sukorambi', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052422', 3, 'ID', 'Kec. Arjasa', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052423', 3, 'ID', 'Kec. Pakusari', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052424', 3, 'ID', 'Kec. Kalisat', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052425', 3, 'ID', 'Kec. Ledok Ombo', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052426', 3, 'ID', 'Kec. Sumberjambe', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052427', 3, 'ID', 'Kec. Sukowono', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052428', 3, 'ID', 'Kec. Jelbuk', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052429', 3, 'ID', 'Kec. Kaliwates', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052430', 3, 'ID', 'Kec. Sumbersari', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052431', 3, 'ID', 'Kec. Patrang', '052400');
INSERT INTO siakad.master_wilayah VALUES ('052500', 2, 'ID', 'Kab. Banyuwangi', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052501', 3, 'ID', 'Kec. Pesanggaran', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052502', 3, 'ID', 'Kec. Bangorejo', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052503', 3, 'ID', 'Kec. Purwoharjo', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052504', 3, 'ID', 'Kec. Tegaldlimo', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052505', 3, 'ID', 'Kec. Muncar', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052506', 3, 'ID', 'Kec. Cluring', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052507', 3, 'ID', 'Kec. Gambiran', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052508', 3, 'ID', 'Kec. Glenmore', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052509', 3, 'ID', 'Kec. Kalibaru', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052510', 3, 'ID', 'Kec. Genteng', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052511', 3, 'ID', 'Kec. Srono', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052512', 3, 'ID', 'Kec. Rogojampi', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052513', 3, 'ID', 'Kec. Kabat', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052514', 3, 'ID', 'Kec. Singojuruh', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052515', 3, 'ID', 'Kec. Sempu', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052516', 3, 'ID', 'Kec. Songgon', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052517', 3, 'ID', 'Kec. Glagah', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052518', 3, 'ID', 'Kec. Banyuwangi', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052519', 3, 'ID', 'Kec. Giri', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052520', 3, 'ID', 'Kec. Kalipuro', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052521', 3, 'ID', 'Kec. Wongsorejo', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052522', 3, 'ID', 'Kec. Licin', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052523', 3, 'ID', 'Kec. Tegalsari', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052524', 3, 'ID', 'Kec. Siliragung', '052500');
INSERT INTO siakad.master_wilayah VALUES ('052600', 2, 'ID', 'Kab. Pamekasan', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052601', 3, 'ID', 'Kec. Tlanakan', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052602', 3, 'ID', 'Kec. Pademawu', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052603', 3, 'ID', 'Kec. Galis', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052604', 3, 'ID', 'Kec. Larangan', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052605', 3, 'ID', 'Kec. Pamekasan', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052606', 3, 'ID', 'Kec. Proppo', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052607', 3, 'ID', 'Kec. Palengaan', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052608', 3, 'ID', 'Kec. Pegantenan', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052609', 3, 'ID', 'Kec. Kadur', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052610', 3, 'ID', 'Kec. Pakong', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052611', 3, 'ID', 'Kec. Waru', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052612', 3, 'ID', 'Kec. Batu Marmer', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052613', 3, 'ID', 'Kec. Pasean', '052600');
INSERT INTO siakad.master_wilayah VALUES ('052700', 2, 'ID', 'Kab. Sampang', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052701', 3, 'ID', 'Kec. Sreseh', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052702', 3, 'ID', 'Kec. Torjun', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052703', 3, 'ID', 'Kec. Sampang', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052704', 3, 'ID', 'Kec. Camplong', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052705', 3, 'ID', 'Kec. Omben', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052706', 3, 'ID', 'Kec. Kedungdung', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052707', 3, 'ID', 'Kec. Jrengik', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052708', 3, 'ID', 'Kec. Tambelangan', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052709', 3, 'ID', 'Kec. Banyuates', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052710', 3, 'ID', 'Kec. Robatal', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052711', 3, 'ID', 'Kec. Ketapang', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052712', 3, 'ID', 'Kec. Sokobanah', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052713', 3, 'ID', 'Kec. Karangpenang', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052714', 3, 'ID', 'Kec. Pangarengan', '052700');
INSERT INTO siakad.master_wilayah VALUES ('052800', 2, 'ID', 'Kab. Sumenep', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052801', 3, 'ID', 'Kec. Pragaan', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052802', 3, 'ID', 'Kec. Bluto', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052803', 3, 'ID', 'Kec. Saronggi', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052804', 3, 'ID', 'Kec. Giligenteng', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052805', 3, 'ID', 'Kec. Talango', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052806', 3, 'ID', 'Kec. Kalianget', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052807', 3, 'ID', 'Kec. Kota Sumenep', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052808', 3, 'ID', 'Kec. Lenteng', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052809', 3, 'ID', 'Kec. Ganding', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052810', 3, 'ID', 'Kec. Guluk Guluk', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052811', 3, 'ID', 'Kec. Pasongsongan', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052812', 3, 'ID', 'Kec. Ambunten', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052813', 3, 'ID', 'Kec. Rubaru', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052814', 3, 'ID', 'Kec. Dasuk', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052815', 3, 'ID', 'Kec. Manding', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052816', 3, 'ID', 'Kec. Batuputih', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052817', 3, 'ID', 'Kec. Gapura', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052818', 3, 'ID', 'Kec. Batang Batang', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052819', 3, 'ID', 'Kec. Dungkek', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052820', 3, 'ID', 'Kec. Nonggunong', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052821', 3, 'ID', 'Kec. Gayam', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052822', 3, 'ID', 'Kec. Ra As', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052823', 3, 'ID', 'Kec. Sapeken', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052824', 3, 'ID', 'Kec. Arjasa', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052825', 3, 'ID', 'Kec. Masalembu', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052827', 3, 'ID', 'Kec. Batuan', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052828', 3, 'ID', 'Kec. Kangayan', '052800');
INSERT INTO siakad.master_wilayah VALUES ('052900', 2, 'ID', 'Kab. Bangkalan', '050000');
INSERT INTO siakad.master_wilayah VALUES ('052901', 3, 'ID', 'Kec. Kamal', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052902', 3, 'ID', 'Kec. Labang', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052903', 3, 'ID', 'Kec. Kwanyar', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052904', 3, 'ID', 'Kec. Modung', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052905', 3, 'ID', 'Kec. Blega', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052906', 3, 'ID', 'Kec. Konang', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052907', 3, 'ID', 'Kec. Galis', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052908', 3, 'ID', 'Kec. Tanah Merah', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052909', 3, 'ID', 'Kec. Tragah', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052910', 3, 'ID', 'Kec. Socah', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052911', 3, 'ID', 'Kec. Bangkalan', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052912', 3, 'ID', 'Kec. Burneh', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052913', 3, 'ID', 'Kec. Arosbaya', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052914', 3, 'ID', 'Kec. Geger', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052915', 3, 'ID', 'Kec. Kokop', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052916', 3, 'ID', 'Kec. Tanjungbumi', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052917', 3, 'ID', 'Kec. Sepulu', '052900');
INSERT INTO siakad.master_wilayah VALUES ('052918', 3, 'ID', 'Kec. Klampis', '052900');
INSERT INTO siakad.master_wilayah VALUES ('056000', 2, 'ID', 'Kota Surabaya', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056001', 3, 'ID', 'Kec. Karang Pilang', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056002', 3, 'ID', 'Kec. Jambangan', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056003', 3, 'ID', 'Kec. Gayungan', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056004', 3, 'ID', 'Kec. Wonocolo', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056005', 3, 'ID', 'Kec. Tenggilis Mejoyo', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056006', 3, 'ID', 'Kec. Gununganyar', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056007', 3, 'ID', 'Kec. Rungkut', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056008', 3, 'ID', 'Kec. Sukolilo', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056009', 3, 'ID', 'Kec. Mulyorejo', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056010', 3, 'ID', 'Kec. Gubeng', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056011', 3, 'ID', 'Kec. Wonokromo', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056012', 3, 'ID', 'Kec. Dukuh Pakis', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056013', 3, 'ID', 'Kec. Wiyung', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056014', 3, 'ID', 'Kec. Lakarsantri', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056015', 3, 'ID', 'Kec. Tandes', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056016', 3, 'ID', 'Kec. Sukomanunggal', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056017', 3, 'ID', 'Kec. Sawahan', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056018', 3, 'ID', 'Kec. Tegal Sari', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056019', 3, 'ID', 'Kec. Genteng', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056020', 3, 'ID', 'Kec. Tambaksari', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056021', 3, 'ID', 'Kec. Kenjeran', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056022', 3, 'ID', 'Kec. Simokerto', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056023', 3, 'ID', 'Kec. Semampir', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056024', 3, 'ID', 'Kec. Pabean Cantian', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056025', 3, 'ID', 'Kec. Bubutan', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056026', 3, 'ID', 'Kec. Krembangan', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056027', 3, 'ID', 'Kec. Asemrowo', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056028', 3, 'ID', 'Kec. Benowo', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056029', 3, 'ID', 'Kec. Bulak', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056030', 3, 'ID', 'Kec. Pakal', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056031', 3, 'ID', 'Kec. Sambi Kerep', '056000');
INSERT INTO siakad.master_wilayah VALUES ('056100', 2, 'ID', 'Kota Malang', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056101', 3, 'ID', 'Kec. Kedungkandang', '056100');
INSERT INTO siakad.master_wilayah VALUES ('056102', 3, 'ID', 'Kec. Sukun', '056100');
INSERT INTO siakad.master_wilayah VALUES ('056103', 3, 'ID', 'Kec. Klojen', '056100');
INSERT INTO siakad.master_wilayah VALUES ('056104', 3, 'ID', 'Kec. Blimbing', '056100');
INSERT INTO siakad.master_wilayah VALUES ('056105', 3, 'ID', 'Kec. Lowokwaru', '056100');
INSERT INTO siakad.master_wilayah VALUES ('056200', 2, 'ID', 'Kota Madiun', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056201', 3, 'ID', 'Kec. Manguharjo', '056200');
INSERT INTO siakad.master_wilayah VALUES ('056202', 3, 'ID', 'Kec. Taman', '056200');
INSERT INTO siakad.master_wilayah VALUES ('056203', 3, 'ID', 'Kec. Kartoharjo', '056200');
INSERT INTO siakad.master_wilayah VALUES ('056300', 2, 'ID', 'Kota Kediri', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056301', 3, 'ID', 'Kec. Mojoroto', '056300');
INSERT INTO siakad.master_wilayah VALUES ('056302', 3, 'ID', 'Kec. Kota Kediri', '056300');
INSERT INTO siakad.master_wilayah VALUES ('056303', 3, 'ID', 'Kec. Pesantren', '056300');
INSERT INTO siakad.master_wilayah VALUES ('056400', 2, 'ID', 'Kota Mojokerto', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056401', 3, 'ID', 'Kec. Prajurit Kulon', '056400');
INSERT INTO siakad.master_wilayah VALUES ('056402', 3, 'ID', 'Kec. Magersari', '056400');
INSERT INTO siakad.master_wilayah VALUES ('056500', 2, 'ID', 'Kota Blitar', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056501', 3, 'ID', 'Kec. Sukorejo', '056500');
INSERT INTO siakad.master_wilayah VALUES ('056502', 3, 'ID', 'Kec. Kepanjen Kidul', '056500');
INSERT INTO siakad.master_wilayah VALUES ('056503', 3, 'ID', 'Kec. Sanan Wetan', '056500');
INSERT INTO siakad.master_wilayah VALUES ('056600', 2, 'ID', 'Kota Pasuruan', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056601', 3, 'ID', 'Kec. Gadingrejo', '056600');
INSERT INTO siakad.master_wilayah VALUES ('056602', 3, 'ID', 'Kec. Purworejo', '056600');
INSERT INTO siakad.master_wilayah VALUES ('056603', 3, 'ID', 'Kec. Bugul Kidul', '056600');
INSERT INTO siakad.master_wilayah VALUES ('056604', 3, 'ID', 'Panggungrejo', '      ');
INSERT INTO siakad.master_wilayah VALUES ('056700', 2, 'ID', 'Kota Probolinggo', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056701', 3, 'ID', 'Kec. Kademangan', '056700');
INSERT INTO siakad.master_wilayah VALUES ('056702', 3, 'ID', 'Kec. Wonoasih', '056700');
INSERT INTO siakad.master_wilayah VALUES ('056703', 3, 'ID', 'Kec. Mayangan', '056700');
INSERT INTO siakad.master_wilayah VALUES ('056704', 3, 'ID', 'Kec. Kedopok', '056700');
INSERT INTO siakad.master_wilayah VALUES ('056705', 3, 'ID', 'Kec. Kanigaran', '056700');
INSERT INTO siakad.master_wilayah VALUES ('056800', 2, 'ID', 'Kota Batu', '050000');
INSERT INTO siakad.master_wilayah VALUES ('056801', 3, 'ID', 'Kec. Batu', '056800');
INSERT INTO siakad.master_wilayah VALUES ('056802', 3, 'ID', 'Kec. Junrejo', '056800');
INSERT INTO siakad.master_wilayah VALUES ('056803', 3, 'ID', 'Kec. Bumiaji', '056800');
INSERT INTO siakad.master_wilayah VALUES ('060000', 1, 'ID', 'Prov. Aceh', '000000');
INSERT INTO siakad.master_wilayah VALUES ('060100', 2, 'ID', 'Kab. Aceh Besar', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060101', 3, 'ID', 'Kec. Lhoong', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060102', 3, 'ID', 'Kec. Lho Nga', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060103', 3, 'ID', 'Kec. Indrapuri', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060104', 3, 'ID', 'Kec. Seulimeum', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060105', 3, 'ID', 'Kec. Mesjid Raya', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060106', 3, 'ID', 'Kec. Darussalam', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060107', 3, 'ID', 'Kec. Kuta Baro', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060108', 3, 'ID', 'Kec. Montasik', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060109', 3, 'ID', 'Kec. Ingin Jaya', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060110', 3, 'ID', 'Kec. Suka Makmur', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060111', 3, 'ID', 'Kec. Darul Imarah', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060112', 3, 'ID', 'Kec. Peukan Bada', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060113', 3, 'ID', 'Kec. Pulo Aceh', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060114', 3, 'ID', 'Kec. Leupung', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060115', 3, 'ID', 'Kec. Kuta Malaka', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060116', 3, 'ID', 'Kec. Leumbah Seulewah', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060117', 3, 'ID', 'Kec. Kota Jantho', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060118', 3, 'ID', 'Kec. Baitussalam', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060119', 3, 'ID', 'Kec. Krung Barona Jaya', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060120', 3, 'ID', 'Kec. Simpang Tiga', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060121', 3, 'ID', 'Kec. Kuta Cot Glie', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060122', 3, 'ID', 'Kec. Darul Kamal', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060123', 3, 'ID', 'Kec. Blang Bintang', '060100');
INSERT INTO siakad.master_wilayah VALUES ('060200', 2, 'ID', 'Kab. Pidie', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060201', 3, 'ID', 'Kec. Geumpang', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060207', 3, 'ID', 'Kec. Glumpang Tiga', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060208', 3, 'ID', 'Kec. Mutiara', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060209', 3, 'ID', 'Kec. Tiro/Truseb', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060210', 3, 'ID', 'Kec. Tangse', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060212', 3, 'ID', 'Kec. Sakti', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060213', 3, 'ID', 'Kec. Mila', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060214', 3, 'ID', 'Kec. Padang Tiji', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060215', 3, 'ID', 'Kec. Delima', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060216', 3, 'ID', 'Kec. Indrajaya', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060217', 3, 'ID', 'Kec. Peukan Baru', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060218', 3, 'ID', 'Kec. Kembang Tanjung', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060219', 3, 'ID', 'Kec. Simpang Tiga', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060220', 3, 'ID', 'Kec. Kota Sigli', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060221', 3, 'ID', 'Kec. Pidie', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060222', 3, 'ID', 'Kec. Batee', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060223', 3, 'ID', 'Kec. Muara Tiga', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060224', 3, 'ID', 'Kec. Mane', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060227', 3, 'ID', 'Kec. Grong-Grong', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060228', 3, 'ID', 'Kec. Mutiara Timur', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060230', 3, 'ID', 'Kec. Glupang Baro', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060231', 3, 'ID', 'Kec. Keumala', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060232', 3, 'ID', 'Kec. Titeuae', '060200');
INSERT INTO siakad.master_wilayah VALUES ('060300', 2, 'ID', 'Kab. Aceh Utara', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060301', 3, 'ID', 'Kec. Sawang', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060302', 3, 'ID', 'Kec. Nisam', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060303', 3, 'ID', 'Kec. Kuta Makmur', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060304', 3, 'ID', 'Kec. Syamtalira Bayu', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060305', 3, 'ID', 'Kec. Meurah Mulia', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060306', 3, 'ID', 'Kec. Matangkuli', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060307', 3, 'ID', 'Kec. Cot Girek', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060308', 3, 'ID', 'Kec. Tanah Jambo Aye', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060309', 3, 'ID', 'Kec. Seunudon', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060310', 3, 'ID', 'Kec. Baktiya', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060312', 3, 'ID', 'Kec. Tanah Luas', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060313', 3, 'ID', 'Kec. Samudera', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060314', 3, 'ID', 'Kec. Syamtalira Aron', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060315', 3, 'ID', 'Kec. Tanah Pasir', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060316', 3, 'ID', 'Kec. Langkahan', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060317', 3, 'ID', 'Kec. Baktiya Barat', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060318', 3, 'ID', 'Kec. Simpang Keramat', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060319', 3, 'ID', 'Kec. Nibong', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060320', 3, 'ID', 'Kec. Paya Bakong', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060321', 3, 'ID', 'Kec. Muara Batu', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060322', 3, 'ID', 'Kec. Dewantara', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060323', 3, 'ID', 'Kec. Lhoksukon', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060326', 3, 'ID', 'Kec. Lapang', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060327', 3, 'ID', 'Kec. Pirak Timu', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060328', 3, 'ID', 'Kec. Geureudong Pase', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060329', 3, 'ID', 'Kec. Banda Baro', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060330', 3, 'ID', 'Kec. Nisam Antara', '060300');
INSERT INTO siakad.master_wilayah VALUES ('060400', 2, 'ID', 'Kab. Aceh Timur', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060408', 3, 'ID', 'Kec. Serba Jadi', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060409', 3, 'ID', 'Kec. Birem Bayeun', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060410', 3, 'ID', 'Kec. Rantau Selamat', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060411', 3, 'ID', 'Kec. Peureulak', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060412', 3, 'ID', 'Kec. Ranto Peureulak', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060413', 3, 'ID', 'Kec. Idi Rayeuk', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060414', 3, 'ID', 'Kec. Darul Aman', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060415', 3, 'ID', 'Kec. Nurussalam', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060416', 3, 'ID', 'Kec. Julok', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060417', 3, 'ID', 'Kec. Pante Beudari', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060418', 3, 'ID', 'Kec. Simpang Ulim', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060419', 3, 'ID', 'Kec. Sungai Raya', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060420', 3, 'ID', 'Kec. Peureulak Timur', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060421', 3, 'ID', 'Kec. Peureulak Barat', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060422', 3, 'ID', 'Kec. Banda Alam', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060423', 3, 'ID', 'Kec. Idi Tunong', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060424', 3, 'ID', 'Kec. Peudawa', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060425', 3, 'ID', 'Kec. Indra Makmur', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060426', 3, 'ID', 'Kec. Madat', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060428', 3, 'ID', 'Kec. Simpang Jernih', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060429', 3, 'ID', 'Kec. Darul Ihsan', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060430', 3, 'ID', 'Kec. Peunaron', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060431', 3, 'ID', 'Kec. Idi Timur', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060432', 3, 'ID', 'Kec. Darul Falah', '060400');
INSERT INTO siakad.master_wilayah VALUES ('060500', 2, 'ID', 'Kab. Aceh Tengah', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060501', 3, 'ID', 'Kec. Lingge', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060502', 3, 'ID', 'Kec. Bintang', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060504', 3, 'ID', 'Kec. Pegasing', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060505', 3, 'ID', 'Kec. Bebesen', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060506', 3, 'ID', 'Kec. Silih Nara', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060512', 3, 'ID', 'Kec. Kuta Panang', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060513', 3, 'ID', 'Kec. Ketol', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060514', 3, 'ID', 'Kec. Celala', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060522', 3, 'ID', 'Kec. Kebayakan', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060524', 3, 'ID', 'Kec. Laut Tawar', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060525', 3, 'ID', 'Kec. Atu Lintang', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060526', 3, 'ID', 'Kec. Jagong Jeget', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060527', 3, 'ID', 'Kec. Bies', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060528', 3, 'ID', 'Kec. Rusip Antara', '060500');
INSERT INTO siakad.master_wilayah VALUES ('060600', 2, 'ID', 'Kab. Aceh Barat', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060605', 3, 'ID', 'Kec. Johan Pahlawan', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060606', 3, 'ID', 'Kec. Samatiga', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060607', 3, 'ID', 'Kec. Woyla', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060608', 3, 'ID', 'Kec. Kaway XVI', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060609', 3, 'ID', 'Kec. Sungai Mas', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060610', 3, 'ID', 'Kec. Bubon', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060611', 3, 'ID', 'Kec. Arongan Lambalek', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060612', 3, 'ID', 'Kec. Meureubo', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060613', 3, 'ID', 'Kec. Pantee Ceureumen', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060614', 3, 'ID', 'Kec. Woyla Barat', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060615', 3, 'ID', 'Kec. Woyla Timur', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060616', 3, 'ID', 'Kec. Panton Reu', '060600');
INSERT INTO siakad.master_wilayah VALUES ('060700', 2, 'ID', 'Kab. Aceh Selatan', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060701', 3, 'ID', 'Kec. Trumon', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060702', 3, 'ID', 'Kec. Bakongan', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060703', 3, 'ID', 'Kec. Kluet Selatan', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060704', 3, 'ID', 'Kec. Kluet Utara', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060705', 3, 'ID', 'Kec. Tapak Tuan', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060706', 3, 'ID', 'Kec. Samadua', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060707', 3, 'ID', 'Kec. Sawang', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060708', 3, 'ID', 'Kec. Meukek', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060709', 3, 'ID', 'Kec. Labuhan Haji', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060710', 3, 'ID', 'Kec. Pasie Raja', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060711', 3, 'ID', 'Kec. Trumon Timur', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060712', 3, 'ID', 'Kec. Kluet Timur', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060713', 3, 'ID', 'Kec. Bakongan Timur', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060714', 3, 'ID', 'Kec. Kluet Tengah', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060715', 3, 'ID', 'Kec. Labuhan Haji Barat', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060716', 3, 'ID', 'Kec. Labuhan Haji Timur', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060717', 3, 'ID', 'Kec. Kota Bahagia', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060718', 3, 'ID', 'Kec. Trumon Tengah', '060700');
INSERT INTO siakad.master_wilayah VALUES ('060800', 2, 'ID', 'Kab. Aceh Tenggara', '060000');
INSERT INTO siakad.master_wilayah VALUES ('060801', 3, 'ID', 'Kec. Lawe Alas', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060802', 3, 'ID', 'Kec. Lawe Sigala-Gala', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060803', 3, 'ID', 'Kec. Bambel', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060804', 3, 'ID', 'Kec. Babussalam', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060805', 3, 'ID', 'Kec. Badar', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060806', 3, 'ID', 'Kec. Darul Hasanah', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060807', 3, 'ID', 'Kec. Babul Makmur', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060808', 3, 'ID', 'Kec. Lawe Bulan', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060809', 3, 'ID', 'Kec. Bukit Tusam', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060810', 3, 'ID', 'Kec. Semadam', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060811', 3, 'ID', 'Kec. Babul Rahmat', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060822', 3, 'ID', 'Kec. Ketambe', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060823', 3, 'ID', 'Kec. Deleng Pokhkisen', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060824', 3, 'ID', 'Kec. Lawe Sumur', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060825', 3, 'ID', 'Kec. Tanoh Alas', '060800');
INSERT INTO siakad.master_wilayah VALUES ('060826', 3, 'ID', 'Kec. Lueser', '060800');
INSERT INTO siakad.master_wilayah VALUES ('061100', 2, 'ID', 'Kab. Simeulue', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061101', 3, 'ID', 'Kec. Teupah Selatan', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061102', 3, 'ID', 'Kec. Simeulue Timur', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061103', 3, 'ID', 'Kec. Simeulue Tengah', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061104', 3, 'ID', 'Kec. Salang', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061105', 3, 'ID', 'Kec. Simeulue Barat', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061106', 3, 'ID', 'Kec. Teupah Barat', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061107', 3, 'ID', 'Kec. Teluk Dalam', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061108', 3, 'ID', 'Kec. Alafan', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061200', 2, 'ID', 'Kab. Bireuen', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061201', 3, 'ID', 'Kec. Samalanga', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061202', 3, 'ID', 'Kec. Pandrah', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061203', 3, 'ID', 'Kec. Jeunib', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061204', 3, 'ID', 'Kec. Peudada', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061205', 3, 'ID', 'Kec. Juli', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061206', 3, 'ID', 'Kec. Jeumpa', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061207', 3, 'ID', 'Kec. Jangka', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061208', 3, 'ID', 'Kec. Peusangan', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061209', 3, 'ID', 'Kec. Makmur', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061210', 3, 'ID', 'Kec. Ganda Pura', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061211', 3, 'ID', 'Kec. Simpang Mamplam', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061212', 3, 'ID', 'Kec. Peulimbang', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061213', 3, 'ID', 'Kec. Kota Juang', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061214', 3, 'ID', 'Kec. Kuala', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061215', 3, 'ID', 'Kec. Peusangan Selatan', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061216', 3, 'ID', 'Kec. Peusangan Siblah Krueng', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061217', 3, 'ID', 'Kec. Kuta Blang', '061200');
INSERT INTO siakad.master_wilayah VALUES ('061300', 2, 'ID', 'Kab. Aceh Singkil', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061301', 3, 'ID', 'Kec. Pulau Banyak', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061302', 3, 'ID', 'Kec. Singkil', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061303', 3, 'ID', 'Kec. Simpang Kanan', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061305', 3, 'ID', 'Kec. Singkil Utara', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061306', 3, 'ID', 'Kec. Gunung Mariah', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061307', 3, 'ID', 'Kec. Danau Paris', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061308', 3, 'ID', 'Kec. Suro Makmur', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061312', 3, 'ID', 'Kec. Kuta Baharu', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061313', 3, 'ID', 'Kec. Singkohor', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061317', 3, 'ID', 'Kec. Kuala Baru', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061318', 3, 'ID', 'Pulau Banyak Barat', '061300');
INSERT INTO siakad.master_wilayah VALUES ('061400', 2, 'ID', 'Kab. Aceh Tamiang', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061401', 3, 'ID', 'Kec. Tamiang Hulu', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061402', 3, 'ID', 'Kec. Kejuruan Muda', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061403', 3, 'ID', 'Kec. Kota Kuala Simpang', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061404', 3, 'ID', 'Kec. Seruway', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061405', 3, 'ID', 'Kec. Bendahara', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061406', 3, 'ID', 'Kec. Karang Baru', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061407', 3, 'ID', 'Kec. Manyak Payed', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061408', 3, 'ID', 'Kec. Rantau', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061412', 3, 'ID', 'Kec. Bandar Mulya', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061413', 3, 'ID', 'Kec. Bandar Pusaka', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061414', 3, 'ID', 'Kec. Tenggulun', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061415', 3, 'ID', 'Kec. Sekerak', '061400');
INSERT INTO siakad.master_wilayah VALUES ('061500', 2, 'ID', 'Kab. Nagan Raya', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061501', 3, 'ID', 'Kec. Darul Makmur', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061502', 3, 'ID', 'Kec. Kuala', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061503', 3, 'ID', 'Kec. Beutong', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061504', 3, 'ID', 'Kec. Seunagan', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061505', 3, 'ID', 'Kec. Seunagan Timur', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061506', 3, 'ID', 'Kec. Kuala Pesisir', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061507', 3, 'ID', 'Kec. Tadu Raya', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061508', 3, 'ID', 'Kec. Suka Makmue', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061509', 3, 'ID', 'Kec. Tripa Makmur', '061500');
INSERT INTO siakad.master_wilayah VALUES ('061600', 2, 'ID', 'Kab. Aceh Jaya', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061601', 3, 'ID', 'Kec. Teunom', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061602', 3, 'ID', 'Kec. Krueng Sabee', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061603', 3, 'ID', 'Kec. Setia Bakti', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061604', 3, 'ID', 'Kec. Sampoiniet', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061605', 3, 'ID', 'Kec. Jaya', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061606', 3, 'ID', 'Kec. Panga', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061607', 3, 'ID', 'Kec. Indra Jaya', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061608', 3, 'ID', 'Kec. Darul Hikmah', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061609', 3, 'ID', 'Kec. Pasie Raya', '061600');
INSERT INTO siakad.master_wilayah VALUES ('061700', 2, 'ID', 'Kab. Aceh Barat Daya', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061701', 3, 'ID', 'Kec. Manggeng', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061702', 3, 'ID', 'Kec. Tangan-Tangan', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061703', 3, 'ID', 'Kec. Blang Pidie', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061704', 3, 'ID', 'Kec. Susoh', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061705', 3, 'ID', 'Kec. Kuala Batee', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061706', 3, 'ID', 'Kec. Babah Rot', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061707', 3, 'ID', 'Kec. Lembah Sabil', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061708', 3, 'ID', 'Kec. Setia Bakti', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061709', 3, 'ID', 'Kec. Jeumpa', '061700');
INSERT INTO siakad.master_wilayah VALUES ('061800', 2, 'ID', 'Kab. Gayo Lues', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061801', 3, 'ID', 'Kec. Blang Kejeran', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061802', 3, 'ID', 'Kec. Kuta Panjang', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061803', 3, 'ID', 'Kec. Rikit Gaib', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061804', 3, 'ID', 'Kec. Terangon', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061805', 3, 'ID', 'Kec. Pinding', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061806', 3, 'ID', 'Kec. Blang Jerango', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061807', 3, 'ID', 'Kec. Puteri Betung', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061808', 3, 'ID', 'Kec. Dabung Gelang', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061809', 3, 'ID', 'Kec. Blang Pegayon', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061810', 3, 'ID', 'Kec. Pantan Cuaca', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061811', 3, 'ID', 'Kec. Tripe Jaya', '061800');
INSERT INTO siakad.master_wilayah VALUES ('061900', 2, 'ID', 'Kab. Bener Meriah', '060000');
INSERT INTO siakad.master_wilayah VALUES ('061901', 3, 'ID', 'Kec. Timang Gajah', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061902', 3, 'ID', 'Kec. Bukit', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061903', 3, 'ID', 'Kec. Bandar', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061904', 3, 'ID', 'Kec. Permata', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061905', 3, 'ID', 'Kec. Pintu Rime Gayo', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061906', 3, 'ID', 'Kec. Wih Pesam', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061907', 3, 'ID', 'Kec. Syiah Utama', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061908', 3, 'ID', 'Bener Kelipah', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061909', 3, 'ID', 'Mesidah', '061900');
INSERT INTO siakad.master_wilayah VALUES ('061910', 3, 'ID', 'Gajah Putih', '061900');
INSERT INTO siakad.master_wilayah VALUES ('062000', 2, 'ID', 'Kab. Pidie Jaya', '060000');
INSERT INTO siakad.master_wilayah VALUES ('062001', 3, 'ID', 'Kec. Meureudu', '062000');
INSERT INTO siakad.master_wilayah VALUES ('062002', 3, 'ID', 'Kec. Ulim', '062000');
INSERT INTO siakad.master_wilayah VALUES ('062003', 3, 'ID', 'Kec. Jangka Buya', '062000');
INSERT INTO siakad.master_wilayah VALUES ('062004', 3, 'ID', 'Kec. Bandar Dua', '062000');
INSERT INTO siakad.master_wilayah VALUES ('062005', 3, 'ID', 'Kec. Meurah Dua', '062000');
INSERT INTO siakad.master_wilayah VALUES ('062006', 3, 'ID', 'Kec. Bandar Baru', '062000');
INSERT INTO siakad.master_wilayah VALUES ('062007', 3, 'ID', 'Kec. Panteraja', '062000');
INSERT INTO siakad.master_wilayah VALUES ('062008', 3, 'ID', 'Kec. Trienggadeng', '062000');
INSERT INTO siakad.master_wilayah VALUES ('066000', 2, 'ID', 'Kota Sabang', '060000');
INSERT INTO siakad.master_wilayah VALUES ('066001', 3, 'ID', 'Kec. Sukajaya', '066000');
INSERT INTO siakad.master_wilayah VALUES ('066002', 3, 'ID', 'Kec. Sukakarya', '066000');
INSERT INTO siakad.master_wilayah VALUES ('066100', 2, 'ID', 'Kota Banda Aceh', '060000');
INSERT INTO siakad.master_wilayah VALUES ('066101', 3, 'ID', 'Kec. Meuraxa', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066102', 3, 'ID', 'Kec. Baiturrahman', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066103', 3, 'ID', 'Kec. Kuta Alam', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066104', 3, 'ID', 'Kec. Syiah Kuala', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066105', 3, 'ID', 'Kec. Kuta Raja', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066106', 3, 'ID', 'Kec. Ulee Kareng', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066107', 3, 'ID', 'Kec. Lueng Bata', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066108', 3, 'ID', 'Kec. Banda Raya', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066109', 3, 'ID', 'Kec. Jaya Baru', '066100');
INSERT INTO siakad.master_wilayah VALUES ('066200', 2, 'ID', 'Kota Lhokseumawe', '060000');
INSERT INTO siakad.master_wilayah VALUES ('066201', 3, 'ID', 'Kec. Blang Mangat', '066200');
INSERT INTO siakad.master_wilayah VALUES ('066202', 3, 'ID', 'Kec. Muara Dua', '066200');
INSERT INTO siakad.master_wilayah VALUES ('066203', 3, 'ID', 'Kec. Banda Sakti', '066200');
INSERT INTO siakad.master_wilayah VALUES ('066204', 3, 'ID', 'Kec. Muara Satu', '066200');
INSERT INTO siakad.master_wilayah VALUES ('066300', 2, 'ID', 'Kota Langsa', '060000');
INSERT INTO siakad.master_wilayah VALUES ('066301', 3, 'ID', 'Kec. Langsa Timur', '066300');
INSERT INTO siakad.master_wilayah VALUES ('066302', 3, 'ID', 'Kec. Langsa Barat', '066300');
INSERT INTO siakad.master_wilayah VALUES ('066303', 3, 'ID', 'Kec. Langsa Kota', '066300');
INSERT INTO siakad.master_wilayah VALUES ('066304', 3, 'ID', 'Kec. Langsa Lama', '066300');
INSERT INTO siakad.master_wilayah VALUES ('066305', 3, 'ID', 'Kec. Langsa Baro', '066300');
INSERT INTO siakad.master_wilayah VALUES ('066400', 2, 'ID', 'Kab. Sabussalam', '060000');
INSERT INTO siakad.master_wilayah VALUES ('066401', 3, 'ID', 'Simpang Kiri', '066400');
INSERT INTO siakad.master_wilayah VALUES ('066402', 3, 'ID', 'Penanggalan', '066400');
INSERT INTO siakad.master_wilayah VALUES ('066403', 3, 'ID', 'Rundeng', '066400');
INSERT INTO siakad.master_wilayah VALUES ('066404', 3, 'ID', 'Sultan Daulat', '066400');
INSERT INTO siakad.master_wilayah VALUES ('066405', 3, 'ID', 'Longkib', '066400');
INSERT INTO siakad.master_wilayah VALUES ('070000', 1, 'ID', 'Prov. Sumatera Utara', '000000');
INSERT INTO siakad.master_wilayah VALUES ('070100', 2, 'ID', 'Kab. Deli Serdang', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070101', 3, 'ID', 'Kec. Gunung Meriah', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070102', 3, 'ID', 'Kec. Sinembah Tanjung Muda Hul', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070103', 3, 'ID', 'Kec. Sibolangit', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070104', 3, 'ID', 'Kec. KutaIimbaru', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070105', 3, 'ID', 'Kec. Pancur Batu', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070106', 3, 'ID', 'Kec. Namo Rambe', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070107', 3, 'ID', 'Kec. Sibiru-biru', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070109', 3, 'ID', 'Kec. Bangun Purba', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070119', 3, 'ID', 'Kec. Galang', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070120', 3, 'ID', 'Kec. Tanjung Morawa', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070121', 3, 'ID', 'Kec. Patumbak', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070122', 3, 'ID', 'Kec. Deli Tua', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070123', 3, 'ID', 'Kec. Sunggal', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070124', 3, 'ID', 'Kec. Hamparan Perak', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070125', 3, 'ID', 'Kec. Labuhan Deli', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070126', 3, 'ID', 'Kec. Percut Sei Tuan', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070127', 3, 'ID', 'Kec. Batang Kuis', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070128', 3, 'ID', 'Kec. Pantai Labu', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070129', 3, 'ID', 'Kec. Beringin', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070130', 3, 'ID', 'Kec. Lubuk Pakam', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070131', 3, 'ID', 'Kec. Pagar Marbau', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070132', 3, 'ID', 'STM Hilir', '070100');
INSERT INTO siakad.master_wilayah VALUES ('070200', 2, 'ID', 'Kab. Langkat', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070201', 3, 'ID', 'Kec. Bohorok', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070202', 3, 'ID', 'Kec. Salapian', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070203', 3, 'ID', 'Kec. Sei Bingai', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070204', 3, 'ID', 'Kec. Kuala', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070205', 3, 'ID', 'Kec. Selesai', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070206', 3, 'ID', 'Kec. Binjai', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070207', 3, 'ID', 'Kec. Stabat', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070208', 3, 'ID', 'Kec. Wampu', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070209', 3, 'ID', 'Kec. Batang Serangan', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070210', 3, 'ID', 'Kec. Sawit Seberang', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070211', 3, 'ID', 'Kec. Padang Tualang', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070212', 3, 'ID', 'Kec. Hinai', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070213', 3, 'ID', 'Kec. Secanggang', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070214', 3, 'ID', 'Kec. Tanjung Pura', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070215', 3, 'ID', 'Kec. Gebang', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070216', 3, 'ID', 'Kec. Sei Lepan', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070217', 3, 'ID', 'Kec. Babalan', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070218', 3, 'ID', 'Kec. Berandan Barat', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070219', 3, 'ID', 'Kec. Besitang', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070220', 3, 'ID', 'Kec. Pangkalan Susu', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070221', 3, 'ID', 'Kec. Serapit', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070222', 3, 'ID', 'Kec. Kutambaru', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070223', 3, 'ID', 'Kec. Pematang Jaya', '070200');
INSERT INTO siakad.master_wilayah VALUES ('070300', 2, 'ID', 'Kab. Karo', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070301', 3, 'ID', 'Kec. Mardinding', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070302', 3, 'ID', 'Kec. Laubaleng', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070303', 3, 'ID', 'Kec. Tiga Binanga', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070304', 3, 'ID', 'Kec. Juhar', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070305', 3, 'ID', 'Kec. Munte', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070306', 3, 'ID', 'Kec. Kuta Buluh', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070307', 3, 'ID', 'Kec. Payung', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070308', 3, 'ID', 'Kec. Simpang Empat', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070309', 3, 'ID', 'Kec. Kabanjahe', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070310', 3, 'ID', 'Kec. Berastagi', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070311', 3, 'ID', 'Kec. Tiga Panah', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070312', 3, 'ID', 'Kec. Merek', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070313', 3, 'ID', 'Kec. Barus Jahe', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070314', 3, 'ID', 'Kec. Tiga Binanga', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070315', 3, 'ID', 'Kec. Naman Teran', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070316', 3, 'ID', 'Kec. Merdeka', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070317', 3, 'ID', 'Kec. Dolat Rayat', '070300');
INSERT INTO siakad.master_wilayah VALUES ('070390', 3, 'ID', 'Tiganderket', '      ');
INSERT INTO siakad.master_wilayah VALUES ('070400', 2, 'ID', 'Kab. Simalungun', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070401', 3, 'ID', 'Kec. Silimakuta', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070402', 3, 'ID', 'Kec. Purba', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070403', 3, 'ID', 'Kec. Dolok Pardamean', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070404', 3, 'ID', 'Kec. Sidamanik', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070405', 3, 'ID', 'Kec. Girsang Simpangan Bolon', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070406', 3, 'ID', 'Kec. Tanah Jawa', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070407', 3, 'ID', 'Kec. Dolok Panribuan', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070408', 3, 'ID', 'Kec. Jorlang Hataran', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070409', 3, 'ID', 'Kec. Pane', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070410', 3, 'ID', 'Kec. Raya', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070411', 3, 'ID', 'Kec. Dolok Silau', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070412', 3, 'ID', 'Kec. Silau Kahean', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070413', 3, 'ID', 'Kec. Raya Kahean', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070414', 3, 'ID', 'Kec. Tapian Dolok', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070415', 3, 'ID', 'Kec. Dolok Batu Nanggar', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070416', 3, 'ID', 'Kec. Siantar', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070417', 3, 'ID', 'Kec. Hutabayu Raja', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070418', 3, 'ID', 'Kec. Pematang Bandar', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070419', 3, 'ID', 'Kec. Bandar', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070420', 3, 'ID', 'Kec. Bosar Maligas', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070421', 3, 'ID', 'Kec. Ujung Padang', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070422', 3, 'ID', 'Kec. Panombeian Pane', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070423', 3, 'ID', 'Kec. Gunung Malela', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070424', 3, 'ID', 'Kec. Gunung Maligas', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070425', 3, 'ID', 'Kec. Bandar Huluan', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070426', 3, 'ID', 'Kec. Bandar Masilam', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070427', 3, 'ID', 'Kec. Hatonduhan', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070428', 3, 'ID', 'Kec. Jawa Maraja Bah Jambi', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070429', 3, 'ID', 'Kec. Haranggaol Horison', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070430', 3, 'ID', 'Kec. Pematang Sidamanik', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070431', 3, 'ID', 'Pamatang Silima Huta', '070400');
INSERT INTO siakad.master_wilayah VALUES ('070500', 2, 'ID', 'Kab. Dairi', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070503', 3, 'ID', 'Kec. Sidikalang', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070504', 3, 'ID', 'Kec. Parbuluan', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070505', 3, 'ID', 'Kec. Sumbul', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070506', 3, 'ID', 'Kec. Pegangan Hilir', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070507', 3, 'ID', 'Kec. Siempat Nempu Hulu', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070508', 3, 'ID', 'Kec. Siempat Nempu', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070509', 3, 'ID', 'Kec. Silima Pungga-Pungga', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070510', 3, 'ID', 'Kec. Siempat Nempu Hilir', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070511', 3, 'ID', 'Kec. Tigalingga', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070512', 3, 'ID', 'Kec. Tanah Pinem', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070513', 3, 'ID', 'Kec. Lae Parira', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070514', 3, 'ID', 'Kec. Gunung Stember', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070515', 3, 'ID', 'Kec. Berampu', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070516', 3, 'ID', 'Kec. Sitinjo', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070517', 3, 'ID', 'Silahi Sabungan', '070500');
INSERT INTO siakad.master_wilayah VALUES ('070590', 3, 'ID', 'Merek', '      ');
INSERT INTO siakad.master_wilayah VALUES ('070600', 2, 'ID', 'Kab. Asahan', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070601', 3, 'ID', 'Kec. Bandar Pasir Mandoge', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070602', 3, 'ID', 'Kec. Bandar Pulau', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070603', 3, 'ID', 'Kec. Pulau Rakyat', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070604', 3, 'ID', 'Kec. Sei Kepayang', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070605', 3, 'ID', 'Kec. Tanjung Balai', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070606', 3, 'ID', 'Kec. Simpang Empat', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070607', 3, 'ID', 'Kec. Air Batu', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070608', 3, 'ID', 'Kec. Buntu Pane', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070609', 3, 'ID', 'Kec. Meranti', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070610', 3, 'ID', 'Kec. Air Joman', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070619', 3, 'ID', 'Kec. Aek Kuasan', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070621', 3, 'ID', 'Kec. Kisaran Barat', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070622', 3, 'ID', 'Kec. Kisaran Timur', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070623', 3, 'ID', 'Kec. Aek Songsongan', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070624', 3, 'ID', 'Kec. Rahuning', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070625', 3, 'ID', 'Kec. Aek Ledong', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070626', 3, 'ID', 'Kec. Sei Kepayang Barat', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070627', 3, 'ID', 'Kec. Sei Kepayang Timur', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070628', 3, 'ID', 'Kec. Teluk Dalam', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070629', 3, 'ID', 'Kec. Sei dadap', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070630', 3, 'ID', 'Kec. Tinggi Raja', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070631', 3, 'ID', 'Kec. Setia Janji', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070632', 3, 'ID', 'Kec. Pulo Bandring', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070633', 3, 'ID', 'Kec. Rawang Panca Arga', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070634', 3, 'ID', 'Kec. Silo Laut', '070600');
INSERT INTO siakad.master_wilayah VALUES ('070700', 2, 'ID', 'Kab. Labuhan Batu', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070705', 3, 'ID', 'Kec. Bilah Hulu', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070707', 3, 'ID', 'Kec. Pangkatan', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070708', 3, 'ID', 'Kec. Bilah Barat', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070713', 3, 'ID', 'Kec. Bilah Hilir', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070714', 3, 'ID', 'Kec. Panai Hulu', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070715', 3, 'ID', 'Kec. Panai Tengah', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070716', 3, 'ID', 'Kec. Panai Hilir', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070721', 3, 'ID', 'Kec. Rantau Selatan', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070722', 3, 'ID', 'Kec. Rantau Utara', '070700');
INSERT INTO siakad.master_wilayah VALUES ('070800', 2, 'ID', 'Kab. Tapanuli Utara', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070803', 3, 'ID', 'Kec. Parmonangan', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070804', 3, 'ID', 'Kec. Adian Koting', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070805', 3, 'ID', 'Kec. Sipoholon', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070806', 3, 'ID', 'Kec. Tarutung', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070807', 3, 'ID', 'Kec. Pahae Jae', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070808', 3, 'ID', 'Kec. Pahae Julu', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070809', 3, 'ID', 'Kec. Pangaribuan', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070810', 3, 'ID', 'Kec. Garoga', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070811', 3, 'ID', 'Kec. Sipahutar', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070812', 3, 'ID', 'Kec. Siborong-Borong', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070813', 3, 'ID', 'Kec. Pagaran', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070818', 3, 'ID', 'Kec. Muara', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070819', 3, 'ID', 'Kec. Purbatua', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070822', 3, 'ID', 'Kec. Simangumban', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070823', 3, 'ID', 'Kec. Siatas Barita', '070800');
INSERT INTO siakad.master_wilayah VALUES ('070900', 2, 'ID', 'Kab. Tapanuli Tengah', '070000');
INSERT INTO siakad.master_wilayah VALUES ('070901', 3, 'ID', 'Kec. Lumut', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070902', 3, 'ID', 'Kec. Sibabangun', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070903', 3, 'ID', 'Kec. Pandan', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070904', 3, 'ID', 'Kec. Tapian Nauli', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070905', 3, 'ID', 'Kec. Kolang', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070906', 3, 'ID', 'Kec. Sorkam', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070907', 3, 'ID', 'Kec. Barus', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070908', 3, 'ID', 'Kec. Manduamas', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070909', 3, 'ID', 'Kec. Sosor Gadong', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070910', 3, 'ID', 'Kec. Sorkam Barat', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070911', 3, 'ID', 'Kec. Andam Dewi', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070912', 3, 'ID', 'Kec. Badiri', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070913', 3, 'ID', 'Kec. Sitahuis', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070914', 3, 'ID', 'Kec. Sirandorung', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070915', 3, 'ID', 'Kec. Tukka', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070916', 3, 'ID', 'Kec. Pinang Sori', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070917', 3, 'ID', 'Kec. Sukabangun', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070918', 3, 'ID', 'Kec. Sarudik', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070919', 3, 'ID', 'Kec. Barus Utara', '070900');
INSERT INTO siakad.master_wilayah VALUES ('070920', 3, 'ID', 'Pasaribu Tobing', '070900');
INSERT INTO siakad.master_wilayah VALUES ('071000', 2, 'ID', 'Kab. Tapanuli Selatan', '070000');
INSERT INTO siakad.master_wilayah VALUES ('071001', 3, 'ID', 'Kec. Batang Angkola', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071010', 3, 'ID', 'Kec. Batang Toru', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071011', 3, 'ID', 'Kec. Sipirok', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071012', 3, 'ID', 'Kec. Arse', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071016', 3, 'ID', 'Kec. Saipar Dolok Hole', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071025', 3, 'ID', 'Kec. Marancar', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071026', 3, 'ID', 'Kec. Sayur Matinggi', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071027', 3, 'ID', 'Kec. Aek Bilah', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071029', 3, 'ID', 'Kec. Muaro Batang Toru', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071030', 3, 'ID', 'Angkola Barat', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071031', 3, 'ID', 'Angkola Sangkunur', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071032', 3, 'ID', 'Angkola Selatan', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071033', 3, 'ID', 'Angkola Timur', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071034', 3, 'ID', 'Tantom Angkola', '071000');
INSERT INTO siakad.master_wilayah VALUES ('071100', 2, 'ID', 'Kab. Nias', '070000');
INSERT INTO siakad.master_wilayah VALUES ('071106', 3, 'ID', 'Kec. Idano Gawo', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071107', 3, 'ID', 'Kec. Gido', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071113', 3, 'ID', 'Kec. Hiliduho', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071119', 3, 'ID', 'Kec. Bawalato', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071123', 3, 'ID', 'Kec. Ulugawo', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071125', 3, 'ID', 'Kec. Ma U', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071126', 3, 'ID', 'Kec. Somolo-Molo', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071132', 3, 'ID', 'Kec. Hili Serangkai', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071133', 3, 'ID', 'Kec. Botomuzoi', '071100');
INSERT INTO siakad.master_wilayah VALUES ('071190', 3, 'ID', 'Sogaeadu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('071500', 2, 'ID', 'Kab. Mandailing Natal', '070000');
INSERT INTO siakad.master_wilayah VALUES ('071501', 3, 'ID', 'Kec. Batahan', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071502', 3, 'ID', 'Kec. Batang Natal', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071503', 3, 'ID', 'Kec. Kotanopan', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071504', 3, 'ID', 'Kec. Muara Sipongi', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071505', 3, 'ID', 'Kec. Panyabungan Kota', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071506', 3, 'ID', 'Kec. Natal', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071507', 3, 'ID', 'Kec. Muara Batang Gadis', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071508', 3, 'ID', 'Kec. Siabu', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071509', 3, 'ID', 'Kec. Panyabungan Utara', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071510', 3, 'ID', 'Kec. Panyabungan Barat', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071511', 3, 'ID', 'Kec. Panyabungan Timur', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071512', 3, 'ID', 'Kec. Panyabungan Selatan', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071513', 3, 'ID', 'Kec. Bukit Malintang', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071514', 3, 'ID', 'Kec. Lembah Sorik Merapi', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071515', 3, 'ID', 'Kec. Ulu Pungut', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071516', 3, 'ID', 'Kec. Tambangan', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071517', 3, 'ID', 'Kec. Langga Bayu', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071600', 2, 'ID', 'Kab. Toba Samosir', '070000');
INSERT INTO siakad.master_wilayah VALUES ('071603', 3, 'ID', 'Kec. Balige', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071604', 3, 'ID', 'Kec. Lagu Boti', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071605', 3, 'ID', 'Kec. Habinsaran', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071606', 3, 'ID', 'Kec. Silaen', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071607', 3, 'ID', 'Kec. Porsea', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071608', 3, 'ID', 'Kec. Lumban Julu', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071616', 3, 'ID', 'Kec. Uluan', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071617', 3, 'ID', 'Kec. Pintu Pohan Meranti', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071618', 3, 'ID', 'Kec. Ajibata', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071619', 3, 'ID', 'Kec. Borbor', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071620', 3, 'ID', 'Kec. Tampahan', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071621', 3, 'ID', 'Kec. Nassau', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071622', 3, 'ID', 'Kec. Sigumpar', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071623', 3, 'ID', 'Kec. Siantar Narumonda', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071624', 3, 'ID', 'Kec. Parmaksian', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071625', 3, 'ID', 'Kec. Bonatua Lunasi', '071600');
INSERT INTO siakad.master_wilayah VALUES ('071700', 2, 'ID', 'Kab. Nias Selatan', '070000');
INSERT INTO siakad.master_wilayah VALUES ('071701', 3, 'ID', 'Kec. Pulau-Pulau Batu', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071702', 3, 'ID', 'Kec. Teluk Dalam', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071703', 3, 'ID', 'Kec. Amandraya', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071704', 3, 'ID', 'Kec. Lahusa', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071705', 3, 'ID', 'Kec. Gomo', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071706', 3, 'ID', 'Kec. Lolomatua', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071707', 3, 'ID', 'Kec. Lolowa`U', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071708', 3, 'ID', 'Kec. Hibala', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071709', 3, 'ID', 'Kec. Susua', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071710', 3, 'ID', 'Kec. Maniamolo', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071711', 3, 'ID', 'Kec. Hilimegai', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071712', 3, 'ID', 'Kec. Toma', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071713', 3, 'ID', 'Kec. Mazino', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071714', 3, 'ID', 'Kec. Umbunasi', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071715', 3, 'ID', 'Kec. Aramo', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071716', 3, 'ID', 'Kec. Pulau-Pulau Batu Timur', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071717', 3, 'ID', 'Kec. Mazo', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071718', 3, 'ID', 'Kec. Fanayama', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071800', 2, 'ID', 'Kab. Pak pak Bharat', '070000');
INSERT INTO siakad.master_wilayah VALUES ('071801', 3, 'ID', 'Kec. Salak', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071802', 3, 'ID', 'Kec. Kerajaan', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071803', 3, 'ID', 'Kec. Sitelutali Urang Jehe', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071804', 3, 'ID', 'Kec. Sitelutali Urang Jehe', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071805', 3, 'ID', 'Kec. Pangindar', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071806', 3, 'ID', 'Kec. Pergetteng-getteng Sengku', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071807', 3, 'ID', 'Kec. Tinada', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071808', 3, 'ID', 'Kec. Siempat Rube', '071800');
INSERT INTO siakad.master_wilayah VALUES ('071899', 3, 'ID', 'Sitelu Tali Urang Julu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('071900', 2, 'ID', 'Kab. Humbang Hasudutan', '070000');
INSERT INTO siakad.master_wilayah VALUES ('071901', 3, 'ID', 'Kec. Pakkat', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071902', 3, 'ID', 'Kec. Onan Ganjang', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071903', 3, 'ID', 'Kec. Lintong Nihuta', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071904', 3, 'ID', 'Kec. Dolok Sanggul', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071905', 3, 'ID', 'Kec. Parlilitan', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071906', 3, 'ID', 'Kec. Pollung', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071907', 3, 'ID', 'Kec. Paranginan', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071908', 3, 'ID', 'Kec. Bakti Raja', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071909', 3, 'ID', 'Kec. Sijamapolang', '071900');
INSERT INTO siakad.master_wilayah VALUES ('071910', 3, 'ID', 'Kec. Tarabintang', '071900');
INSERT INTO siakad.master_wilayah VALUES ('072000', 2, 'ID', 'Kab. Samosir', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072001', 3, 'ID', 'Kec. Harian', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072002', 3, 'ID', 'Kec. Sianjur Mula Mula', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072003', 3, 'ID', 'Kec. Onan Runggu Timur', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072004', 3, 'ID', 'Kec. Palipi', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072005', 3, 'ID', 'Kec. Pangururan', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072006', 3, 'ID', 'Kec. Simanindo', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072007', 3, 'ID', 'Kec. Nainggolan', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072008', 3, 'ID', 'Kec. Ronggur Nihuta', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072009', 3, 'ID', 'Kec. Sitiotio', '072000');
INSERT INTO siakad.master_wilayah VALUES ('072100', 2, 'ID', 'Kab. Serdang Bedagai', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072101', 3, 'ID', 'Kec. Kotarih', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072102', 3, 'ID', 'Kec. Dolok Masihul', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072103', 3, 'ID', 'Kec. Sipispis', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072104', 3, 'ID', 'Kec. Dolok Merawan', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072105', 3, 'ID', 'Kec. Tebing Tinggi', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072106', 3, 'ID', 'Kec. Bandar Khalifah', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072107', 3, 'ID', 'Kec. Tanjung Beringin', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072108', 3, 'ID', 'Kec. Teluk Mengkudu', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072109', 3, 'ID', 'Kec. Sei Rampah', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072110', 3, 'ID', 'Kec. Perbaungan', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072111', 3, 'ID', 'Kec. Pantai Cermin', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072112', 3, 'ID', 'Kec. Silinda', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072113', 3, 'ID', 'Kec. Bintang Bayu', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072114', 3, 'ID', 'Kec. Serbajadi', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072115', 3, 'ID', 'Kec. Tebing Syahbandar', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072116', 3, 'ID', 'Kec. Sei Bamban', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072117', 3, 'ID', 'Kec. Pegajahan', '072100');
INSERT INTO siakad.master_wilayah VALUES ('072200', 2, 'ID', 'Kab. Batubara', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072201', 3, 'ID', 'Kec. Medang Deras', '072200');
INSERT INTO siakad.master_wilayah VALUES ('072202', 3, 'ID', 'Kec. Air Putih', '072200');
INSERT INTO siakad.master_wilayah VALUES ('072203', 3, 'ID', 'Kec. Lima Puluh', '072200');
INSERT INTO siakad.master_wilayah VALUES ('072204', 3, 'ID', 'Kec. Sei Balai', '072200');
INSERT INTO siakad.master_wilayah VALUES ('072205', 3, 'ID', 'Kec. Sei Suka', '072200');
INSERT INTO siakad.master_wilayah VALUES ('072206', 3, 'ID', 'Kec. Talawi', '072200');
INSERT INTO siakad.master_wilayah VALUES ('072207', 3, 'ID', 'Kec. Tanjung Tiram', '072200');
INSERT INTO siakad.master_wilayah VALUES ('072300', 2, 'ID', 'Kab. Padang Lawas utara', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072301', 3, 'ID', 'Kec. Padang Bolak Julu', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072302', 3, 'ID', 'Kec. Padang Bolak', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072303', 3, 'ID', 'Kec. Halongonan', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072304', 3, 'ID', 'Kec. Dolok Sxigompulon', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072305', 3, 'ID', 'Kec. Portibi', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072306', 3, 'ID', 'Kec. Simangambat', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072307', 3, 'ID', 'Kec. Batang Onang', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072308', 3, 'ID', 'Kec. Dolok', '072300');
INSERT INTO siakad.master_wilayah VALUES ('072390', 3, 'ID', 'Hulu Sihapas', '      ');
INSERT INTO siakad.master_wilayah VALUES ('072400', 2, 'ID', 'Kab. Padang Lawas', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072401', 3, 'ID', 'Kec. Barumun', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072402', 3, 'ID', 'Kec. Sosa', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072403', 3, 'ID', 'Kec. Barumun Tengah', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072404', 3, 'ID', 'Kec. Batang Lubu Sutam.', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072405', 3, 'ID', 'Kec. Huta Raja Tinggi', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072406', 3, 'ID', 'Kec. Lubuk Barumun', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072407', 3, 'ID', 'Kec. Huristak', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072408', 3, 'ID', 'Kec. Ulu Barumun', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072409', 3, 'ID', 'Kec. Sosopan', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072410', 3, 'ID', 'Kec. Barumun Selatan', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072411', 3, 'ID', 'Kec. Aek Nabara Barumun', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072500', 2, 'ID', 'Kab. Labuhan Batu Utara', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072501', 3, 'ID', 'Kec. Na IX-X', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072502', 3, 'ID', 'Kec. Aek Natas', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072503', 3, 'ID', 'Kec. Aek Kuo', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072504', 3, 'ID', 'Kec. Kualuh Hilir', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072505', 3, 'ID', 'Kec. Kualuh Selatan', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072506', 3, 'ID', 'Kec. Kualuh Hulu', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072507', 3, 'ID', 'Kec. Kualuh Leidong', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072508', 3, 'ID', 'Kec. Marbau', '072500');
INSERT INTO siakad.master_wilayah VALUES ('072600', 2, 'ID', 'Kab. Labuhan Batu Selatan', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072601', 3, 'ID', 'Kec. Sungai Kanan', '072600');
INSERT INTO siakad.master_wilayah VALUES ('072602', 3, 'ID', 'Kec. Torgamba', '072600');
INSERT INTO siakad.master_wilayah VALUES ('072603', 3, 'ID', 'Kec. Kota Pinang', '072600');
INSERT INTO siakad.master_wilayah VALUES ('072604', 3, 'ID', 'Kec. Silangkitang', '072600');
INSERT INTO siakad.master_wilayah VALUES ('072605', 3, 'ID', 'Kec. Kampung Rakyat', '072600');
INSERT INTO siakad.master_wilayah VALUES ('072700', 2, 'ID', 'Kab. Nias Barat', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072701', 3, 'ID', 'Kec. Lolofitu Moi', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072702', 3, 'ID', 'Kec. Sirombu', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072703', 3, 'ID', 'Kec. Lahomi', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072704', 3, 'ID', 'Kec. Mandrehe', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072705', 3, 'ID', 'Kec. Mandrehe Barat', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072706', 3, 'ID', 'Kec. Moro O', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072707', 3, 'ID', 'Kec. Mandrehe Barat', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072708', 3, 'ID', 'Kec. Ulo Moro O', '072700');
INSERT INTO siakad.master_wilayah VALUES ('072800', 2, 'ID', 'Kab. Nias Utara', '070000');
INSERT INTO siakad.master_wilayah VALUES ('072801', 3, 'ID', 'Kec. Tuhemberua', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072802', 3, 'ID', 'Kec. Lotu', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072803', 3, 'ID', 'Kec. Sitolu Ori', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072804', 3, 'ID', 'Kec. Sawo', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072805', 3, 'ID', 'Kec. Alasa', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072806', 3, 'ID', 'Kec. Namohalu Esiwa', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072807', 3, 'ID', 'Kec. Alasa Talu Muzoi', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072808', 3, 'ID', 'Kec. Tugala Oyo', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072809', 3, 'ID', 'Kec. Lahewa', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072810', 3, 'ID', 'Kec. Afulu', '072800');
INSERT INTO siakad.master_wilayah VALUES ('072811', 3, 'ID', 'Kec. Lahewa Timur', '072800');
INSERT INTO siakad.master_wilayah VALUES ('076000', 2, 'ID', 'Kota Medan', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076001', 3, 'ID', 'Kec. Medan Tuntungan', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076002', 3, 'ID', 'Kec. Medan Johor', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076003', 3, 'ID', 'Kec. Medan Amplas', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076004', 3, 'ID', 'Kec. Medan Denai', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076005', 3, 'ID', 'Kec. Medan Area', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076006', 3, 'ID', 'Kec. Medan Kota', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076007', 3, 'ID', 'Kec. Medan Maimun', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076008', 3, 'ID', 'Kec. Medan Polonia', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076009', 3, 'ID', 'Kec. Medan Baru', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076010', 3, 'ID', 'Kec. Medan Selayang', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076011', 3, 'ID', 'Kec. Medan Sunggal', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076012', 3, 'ID', 'Kec. Medan Helvetia', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076013', 3, 'ID', 'Kec. Medan Petisah', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076014', 3, 'ID', 'Kec. Medan Barat', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076015', 3, 'ID', 'Kec. Medan Timur', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076016', 3, 'ID', 'Kec. Medan Perjuangan', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076017', 3, 'ID', 'Kec. Medan Tembung', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076018', 3, 'ID', 'Kec. Medan Deli', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076019', 3, 'ID', 'Kec. Medan Labuhan', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076020', 3, 'ID', 'Kec. Medan Marelan', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076021', 3, 'ID', 'Kec. Medan Kota Belawan', '076000');
INSERT INTO siakad.master_wilayah VALUES ('076100', 2, 'ID', 'Kota Binjai', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076101', 3, 'ID', 'Kec. Binjai Selatan', '076100');
INSERT INTO siakad.master_wilayah VALUES ('076102', 3, 'ID', 'Kec. Binjai Kota', '076100');
INSERT INTO siakad.master_wilayah VALUES ('076103', 3, 'ID', 'Kec. Binjai Timur', '076100');
INSERT INTO siakad.master_wilayah VALUES ('076104', 3, 'ID', 'Kec. Binjai Utara', '076100');
INSERT INTO siakad.master_wilayah VALUES ('076105', 3, 'ID', 'Kec. Binjai Barat', '076100');
INSERT INTO siakad.master_wilayah VALUES ('076200', 2, 'ID', 'Kota Tebing Tinggi', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076201', 3, 'ID', 'Kec. Padang Hulu', '076200');
INSERT INTO siakad.master_wilayah VALUES ('076202', 3, 'ID', 'Kec. Rambutan', '076200');
INSERT INTO siakad.master_wilayah VALUES ('076203', 3, 'ID', 'Kec. Padang Hilir', '076200');
INSERT INTO siakad.master_wilayah VALUES ('076204', 3, 'ID', 'Kec. Bajenis', '076200');
INSERT INTO siakad.master_wilayah VALUES ('076205', 3, 'ID', 'Kec. Tebing Tinggi Kota', '076200');
INSERT INTO siakad.master_wilayah VALUES ('076300', 2, 'ID', 'Kota Pematang Siantar', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076301', 3, 'ID', 'Kec. Siantar Marihat', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076302', 3, 'ID', 'Kec. Siantar Selatan', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076303', 3, 'ID', 'Kec. Siantar Barat', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076304', 3, 'ID', 'Kec. Siantar Utara', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076305', 3, 'ID', 'Kec. Siantar Timur', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076306', 3, 'ID', 'Kec. Siantar Martoba', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076307', 3, 'ID', 'Kec. Siantar Marimbun', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076308', 3, 'ID', 'Kec. Siantar Sitalasari', '076300');
INSERT INTO siakad.master_wilayah VALUES ('076400', 2, 'ID', 'Kota Tanjung Balai', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076401', 3, 'ID', 'Kec. Datuk Bandar', '076400');
INSERT INTO siakad.master_wilayah VALUES ('076402', 3, 'ID', 'Kec. Tanjung Balai Selatan', '076400');
INSERT INTO siakad.master_wilayah VALUES ('076403', 3, 'ID', 'Kec. Tanjung Balai Utara', '076400');
INSERT INTO siakad.master_wilayah VALUES ('076404', 3, 'ID', 'Kec. S. Tualang Raso', '076400');
INSERT INTO siakad.master_wilayah VALUES ('076405', 3, 'ID', 'Kec. Teluk Nibung', '076400');
INSERT INTO siakad.master_wilayah VALUES ('076406', 3, 'ID', 'Kec. Datuk Bandar Timur', '076400');
INSERT INTO siakad.master_wilayah VALUES ('076500', 2, 'ID', 'Kota Sibolga', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076501', 3, 'ID', 'Kec. Sibolga Utara', '076500');
INSERT INTO siakad.master_wilayah VALUES ('076502', 3, 'ID', 'Kec. Sibolga Kota', '076500');
INSERT INTO siakad.master_wilayah VALUES ('076503', 3, 'ID', 'Kec. Sibolga Selatan', '076500');
INSERT INTO siakad.master_wilayah VALUES ('076504', 3, 'ID', 'Kec. Sibolga Sambas', '076500');
INSERT INTO siakad.master_wilayah VALUES ('076600', 2, 'ID', 'Kota Padang Sidempuan', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076601', 3, 'ID', 'Kec. Padang Sidimpuan Selatan', '076600');
INSERT INTO siakad.master_wilayah VALUES ('076602', 3, 'ID', 'Kec. Padang Sidimpuan Utara', '076600');
INSERT INTO siakad.master_wilayah VALUES ('076603', 3, 'ID', 'Kec. Padang Sidimpuan Batu Nad', '076600');
INSERT INTO siakad.master_wilayah VALUES ('076604', 3, 'ID', 'Kec. Padang Sidimpuan Hutaimba', '076600');
INSERT INTO siakad.master_wilayah VALUES ('076605', 3, 'ID', 'Kec. Padang Sidimpuan Tenggara', '076600');
INSERT INTO siakad.master_wilayah VALUES ('076606', 3, 'ID', 'Kec. Padang Sidimpuan Angkola', '076600');
INSERT INTO siakad.master_wilayah VALUES ('076700', 2, 'ID', 'Kota Gunung Sitoli', '070000');
INSERT INTO siakad.master_wilayah VALUES ('076701', 3, 'ID', 'Kec. Gunung Sitoli Idanoi', '076700');
INSERT INTO siakad.master_wilayah VALUES ('076702', 3, 'ID', 'Kec. Gunung Sitoli   Alo Oa', '076700');
INSERT INTO siakad.master_wilayah VALUES ('076703', 3, 'ID', 'Kec. Gunung Sitoli', '076700');
INSERT INTO siakad.master_wilayah VALUES ('076704', 3, 'ID', 'Kec. Gunung Sitoli Selatan', '076700');
INSERT INTO siakad.master_wilayah VALUES ('076705', 3, 'ID', 'Kec. Gunung Sitoli Barat', '076700');
INSERT INTO siakad.master_wilayah VALUES ('076706', 3, 'ID', 'Kec. Gunung Sitoli Utara', '076700');
INSERT INTO siakad.master_wilayah VALUES ('080000', 1, 'ID', 'Prov. Sumatera Barat', '000000');
INSERT INTO siakad.master_wilayah VALUES ('080100', 2, 'ID', 'Kab. Agam', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080101', 3, 'ID', 'Kec. Tanjung Mutiara', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080102', 3, 'ID', 'Kec. Lubuk Basung', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080103', 3, 'ID', 'Kec. Tanjung Raya', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080104', 3, 'ID', 'Kec. Matur', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080105', 3, 'ID', 'Kec. IV Koto', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080107', 3, 'ID', 'Kec. IV Angkat Candung', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080108', 3, 'ID', 'Kec. Baso', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080109', 3, 'ID', 'Kec. Tilatang Kamang', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080110', 3, 'ID', 'Kec. Palembayan', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080111', 3, 'ID', 'Kec. Palupuh', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080113', 3, 'ID', 'Kec. Sungai Pua', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080114', 3, 'ID', 'Kec. Candung', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080115', 3, 'ID', 'Kec. Kamang Magek', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080116', 3, 'ID', 'Kec. Banuhampu', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080117', 3, 'ID', 'Kec. Ampek Angkek', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080118', 3, 'ID', 'Kec. Malalak', '080100');
INSERT INTO siakad.master_wilayah VALUES ('080119', 3, 'ID', 'Ampek Nagari', '      ');
INSERT INTO siakad.master_wilayah VALUES ('080200', 2, 'ID', 'Kab. Pasaman', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080207', 3, 'ID', 'Kec. Bonjol', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080208', 3, 'ID', 'Kec. Lubuk Sikaping', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080210', 3, 'ID', 'Kec. II Koto', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080211', 3, 'ID', 'Kec. Panti', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080212', 3, 'ID', 'Kec. III Nagari', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080213', 3, 'ID', 'Kec. Rao', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080214', 3, 'ID', 'Kec. Mapat Tunggul', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080215', 3, 'ID', 'Kec. Mapat Tunggul Selatan', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080216', 3, 'ID', 'Kec. Simpang Alahan Mati', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080217', 3, 'ID', 'Kec. Padang Gelugur', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080218', 3, 'ID', 'Kec. Rao Utara', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080219', 3, 'ID', 'Kec. Rao Selatan', '080200');
INSERT INTO siakad.master_wilayah VALUES ('080300', 2, 'ID', 'Kab. Lima Puluh Koto', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080301', 3, 'ID', 'Kec. Payakumbuh', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080302', 3, 'ID', 'Kec. Luak', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080303', 3, 'ID', 'Kec. Harau', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080304', 3, 'ID', 'Kec. Guguak', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080305', 3, 'ID', 'Kec. Suliki', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080306', 3, 'ID', 'Kec. Gunuang Omeh', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080307', 3, 'ID', 'Kec. Kapur IX', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080308', 3, 'ID', 'Kec. Pangkalan Koto Baru', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080309', 3, 'ID', 'Kec. Bukkt Barisan', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080310', 3, 'ID', 'Kec. Mungka', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080311', 3, 'ID', 'Kec. Akabiluru', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080312', 3, 'ID', 'Kec. Situjuah Limo Nagari', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080313', 3, 'ID', 'Kec. Lareh Sago Halaban', '080300');
INSERT INTO siakad.master_wilayah VALUES ('080400', 2, 'ID', 'Kab. Solok', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080404', 3, 'ID', 'Kec. Pantai Cermin', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080405', 3, 'ID', 'Kec. Lembah Gumanti', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080406', 3, 'ID', 'Kec. Payung Sekaki', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080407', 3, 'ID', 'Kec. Lembang Jaya', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080408', 3, 'ID', 'Kec. Gunung Talang', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080409', 3, 'ID', 'Kec. Bukit Sundi', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080410', 3, 'ID', 'Kec. Kubung', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080411', 3, 'ID', 'Kec. IX Koto Sungai Lasi', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080412', 3, 'ID', 'Kec. X Koto Diatas', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080413', 3, 'ID', 'Kec. X Koto Singkarak', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080414', 3, 'ID', 'Kec. Junjung Sirih', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080416', 3, 'ID', 'Kec. Hiliran Gumanti', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080417', 3, 'ID', 'Kec. Tigo Lurah', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080418', 3, 'ID', 'Kec. Danau Kembar', '080400');
INSERT INTO siakad.master_wilayah VALUES ('080500', 2, 'ID', 'Kab. Padang Pariaman', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080501', 3, 'ID', 'Kec. Batang Anai', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080502', 3, 'ID', 'Kec. Lubuk Alung', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080503', 3, 'ID', 'Kec. Ulakan Tapakis', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080504', 3, 'ID', 'Kec. Nan Sabaris', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080505', 3, 'ID', 'Kec. 2 x 11 VI Lingkung', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080506', 3, 'ID', 'Kec. VII Koto Sungai Sarik', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080507', 3, 'ID', 'Kec. V Koto Kampung Dalam', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080508', 3, 'ID', 'Kec. Sungai Limau', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080509', 3, 'ID', 'Kec. Sungai Geringging', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080510', 3, 'ID', 'Kec. IV Koto Aur Malintang', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080513', 3, 'ID', 'Kec. Batang Gasan', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080514', 3, 'ID', 'Kec. V Koto Timur', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080515', 3, 'ID', 'Kec. Patamuan', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080516', 3, 'ID', 'Kec. Padang Sago', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080517', 3, 'ID', 'Kec. 2 x 11 Kayu Tanam', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080518', 3, 'ID', 'Kec. Sintuk Toboh Gadang', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080519', 3, 'ID', 'Kec. VI Lingkung', '080500');
INSERT INTO siakad.master_wilayah VALUES ('080600', 2, 'ID', 'Kab. Pesisir Selatan', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080601', 3, 'ID', 'Kec. Lunang Silaut', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080602', 3, 'ID', 'Kec. Basa IV Balai Tapan', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080603', 3, 'ID', 'Kec. Pancung Soal', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080604', 3, 'ID', 'Kec. Linggo Saribaganti', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080605', 3, 'ID', 'Kec. Ranah Pesisir', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080606', 3, 'ID', 'Kec. Lengayang', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080607', 3, 'ID', 'Kec. Sutera', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080608', 3, 'ID', 'Kec. Batang Kapas', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080609', 3, 'ID', 'Kec. IV Jurai', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080610', 3, 'ID', 'Kec. Bayang', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080611', 3, 'ID', 'Kec. Koto XI Terusan', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080612', 3, 'ID', 'Kec. IV Bayang Utara', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080700', 2, 'ID', 'Kab. Tanah Datar', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080701', 3, 'ID', 'Kec. Sepuluh Koto', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080702', 3, 'ID', 'Kec. Batipuh', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080703', 3, 'ID', 'Kec. Pariangan', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080704', 3, 'ID', 'Kec. Rambatan', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080705', 3, 'ID', 'Kec. Lima Kaum', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080706', 3, 'ID', 'Kec. Tanjung Mas', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080707', 3, 'ID', 'Kec. Padang Ganting', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080708', 3, 'ID', 'Kec. Lintau Buo', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080709', 3, 'ID', 'Kec. Sungayang', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080710', 3, 'ID', 'Kec. Sungai Tarab', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080711', 3, 'ID', 'Kec. Salimpaung', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080712', 3, 'ID', 'Kec. Batipuh Selatan', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080713', 3, 'ID', 'Kec. Lintau Buo Utara', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080714', 3, 'ID', 'Kec. Tanjung Baru', '080700');
INSERT INTO siakad.master_wilayah VALUES ('080800', 2, 'ID', 'Kab. Sawahlunto/ Sijunjung', '080000');
INSERT INTO siakad.master_wilayah VALUES ('080805', 3, 'ID', 'Kec. Kamang Baru', '080800');
INSERT INTO siakad.master_wilayah VALUES ('080806', 3, 'ID', 'Kec. Tanjung Gadang', '080800');
INSERT INTO siakad.master_wilayah VALUES ('080807', 3, 'ID', 'Kec. Sijunjung', '080800');
INSERT INTO siakad.master_wilayah VALUES ('080808', 3, 'ID', 'Kec. IV Nagari', '080800');
INSERT INTO siakad.master_wilayah VALUES ('080809', 3, 'ID', 'Kec. Kupitan', '080800');
INSERT INTO siakad.master_wilayah VALUES ('080810', 3, 'ID', 'Kec. Koto Tujuh', '080800');
INSERT INTO siakad.master_wilayah VALUES ('080811', 3, 'ID', 'Kec. Sumpur Kudus', '080800');
INSERT INTO siakad.master_wilayah VALUES ('080812', 3, 'ID', 'Kec. Lubuk Tarok', '080800');
INSERT INTO siakad.master_wilayah VALUES ('081000', 2, 'ID', 'Kab. Kepulauan Mentawai', '080000');
INSERT INTO siakad.master_wilayah VALUES ('081001', 3, 'ID', 'Kec. Pagai Utara', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081002', 3, 'ID', 'Kec. Sipora Selatan', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081003', 3, 'ID', 'Kec. Siberut Selatan', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081004', 3, 'ID', 'Kec. Siberut Utara', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081005', 3, 'ID', 'Kec. Siberut Barat', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081006', 3, 'ID', 'Kec. Siberut Barat Daya', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081007', 3, 'ID', 'Kec. Siberut Tengah', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081008', 3, 'ID', 'Kec. Sipora Utara', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081009', 3, 'ID', 'Kec. Sikakap', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081010', 3, 'ID', 'Kec. Pagai Selatan', '081000');
INSERT INTO siakad.master_wilayah VALUES ('081011', 3, 'ID', 'Siberut Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('081100', 2, 'ID', 'Kab. Solok Selatan', '080000');
INSERT INTO siakad.master_wilayah VALUES ('081101', 3, 'ID', 'Kec. Sangir', '081100');
INSERT INTO siakad.master_wilayah VALUES ('081102', 3, 'ID', 'Kec. Sungai Pagu', '081100');
INSERT INTO siakad.master_wilayah VALUES ('081103', 3, 'ID', 'Kec. Koto Parik Gadang Diateh', '081100');
INSERT INTO siakad.master_wilayah VALUES ('081104', 3, 'ID', 'Kec. Sangir Jujuhan', '081100');
INSERT INTO siakad.master_wilayah VALUES ('081105', 3, 'ID', 'Kec. Sangir Batanghari', '081100');
INSERT INTO siakad.master_wilayah VALUES ('081106', 3, 'ID', 'Kec. Pauah Duo', '081100');
INSERT INTO siakad.master_wilayah VALUES ('081107', 3, 'ID', 'Kec. Sangir Balai Janggo', '081100');
INSERT INTO siakad.master_wilayah VALUES ('081200', 2, 'ID', 'Kab. Dharmas Raya', '080000');
INSERT INTO siakad.master_wilayah VALUES ('081201', 3, 'ID', 'Kec. Sungai Rumbai', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081202', 3, 'ID', 'Kec. Koto Baru', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081203', 3, 'ID', 'Kec. Sitiung', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081204', 3, 'ID', 'Kec. Pulau Punjung', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081205', 3, 'ID', 'Kec. Sembilan Koto', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081206', 3, 'ID', 'Kec. Timpeh', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081207', 3, 'ID', 'Kec. Koto Salak', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081208', 3, 'ID', 'Kec. Tiumang', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081209', 3, 'ID', 'Kec. Padang Laweh', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081210', 3, 'ID', 'Kec. Asam Jujuhan', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081211', 3, 'ID', 'Kec. Koto Besar', '081200');
INSERT INTO siakad.master_wilayah VALUES ('081300', 2, 'ID', 'Kab. Pasaman Barat', '080000');
INSERT INTO siakad.master_wilayah VALUES ('081301', 3, 'ID', 'Kec. Sungai Beremas', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081302', 3, 'ID', 'Kec. Ranah Batahan', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081303', 3, 'ID', 'Kec. Lembah Melintang', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081304', 3, 'ID', 'Kec. Gunung Tuleh', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081305', 3, 'ID', 'Kec. Pasaman', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081306', 3, 'ID', 'Kec. Kinali', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081307', 3, 'ID', 'Kec. Talamau', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081308', 3, 'ID', 'Kec. Koto Balingka', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081309', 3, 'ID', 'Kec. Luhak Nan Duo', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081310', 3, 'ID', 'Kec. Sasak Ranah Pesisir', '081300');
INSERT INTO siakad.master_wilayah VALUES ('081311', 3, 'ID', 'Kec. Sungai Aur', '081300');
INSERT INTO siakad.master_wilayah VALUES ('086000', 2, 'ID', 'Kota Bukittinggi', '080000');
INSERT INTO siakad.master_wilayah VALUES ('086001', 3, 'ID', 'Kec. Guguk Panjang', '086000');
INSERT INTO siakad.master_wilayah VALUES ('086002', 3, 'ID', 'Kec. Mandiangin Koto Selayan', '086000');
INSERT INTO siakad.master_wilayah VALUES ('086003', 3, 'ID', 'Kec. Aur Birugo Tigo Baleh', '086000');
INSERT INTO siakad.master_wilayah VALUES ('086100', 2, 'ID', 'Kota Padang', '080000');
INSERT INTO siakad.master_wilayah VALUES ('086101', 3, 'ID', 'Kec. Bungus Teluk Kabung', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086102', 3, 'ID', 'Kec. Lubuk Kilangan', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086103', 3, 'ID', 'Kec. Lubuk Begalung', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086104', 3, 'ID', 'Kec. Padang Selatan', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086105', 3, 'ID', 'Kec. Padang Timur', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086106', 3, 'ID', 'Kec. Padang Barat', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086107', 3, 'ID', 'Kec. Padang Utara', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086108', 3, 'ID', 'Kec. Nanggalo', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086109', 3, 'ID', 'Kec. Kuranji', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086110', 3, 'ID', 'Kec. Pauh', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086111', 3, 'ID', 'Kec. Koto Tangah', '086100');
INSERT INTO siakad.master_wilayah VALUES ('086200', 2, 'ID', 'Kota Padang Panjang', '080000');
INSERT INTO siakad.master_wilayah VALUES ('086201', 3, 'ID', 'Kec. Padang Panjang Barat', '086200');
INSERT INTO siakad.master_wilayah VALUES ('086202', 3, 'ID', 'Kec. Padang Panjang Timur', '086200');
INSERT INTO siakad.master_wilayah VALUES ('086300', 2, 'ID', 'Kota Sawah Lunto', '080000');
INSERT INTO siakad.master_wilayah VALUES ('086301', 3, 'ID', 'Kec. Silungkang', '086300');
INSERT INTO siakad.master_wilayah VALUES ('086302', 3, 'ID', 'Kec. Lembah Segar', '086300');
INSERT INTO siakad.master_wilayah VALUES ('086303', 3, 'ID', 'Kec. Barangin', '086300');
INSERT INTO siakad.master_wilayah VALUES ('086304', 3, 'ID', 'Kec. Talawi', '086300');
INSERT INTO siakad.master_wilayah VALUES ('086400', 2, 'ID', 'Kota Solok', '080000');
INSERT INTO siakad.master_wilayah VALUES ('086401', 3, 'ID', 'Kec. Lubuk Sikarah', '086400');
INSERT INTO siakad.master_wilayah VALUES ('086402', 3, 'ID', 'Kec. Tanjung Harapan', '086400');
INSERT INTO siakad.master_wilayah VALUES ('086500', 2, 'ID', 'Kota Payakumbuh', '080000');
INSERT INTO siakad.master_wilayah VALUES ('086501', 3, 'ID', 'Kec. Payakumbuh Barat', '086500');
INSERT INTO siakad.master_wilayah VALUES ('086502', 3, 'ID', 'Kec. Payakumbuh Timur', '086500');
INSERT INTO siakad.master_wilayah VALUES ('086503', 3, 'ID', 'Kec. Payakumbuh Utara', '086500');
INSERT INTO siakad.master_wilayah VALUES ('086504', 3, 'ID', 'Kec. Lamposi Tigo Nagori', '086500');
INSERT INTO siakad.master_wilayah VALUES ('086505', 3, 'ID', 'Kec. Payakumbuh Selatan', '086500');
INSERT INTO siakad.master_wilayah VALUES ('086600', 2, 'ID', 'Kota Pariaman', '080000');
INSERT INTO siakad.master_wilayah VALUES ('086601', 3, 'ID', 'Kec. Pariaman Selatan', '086600');
INSERT INTO siakad.master_wilayah VALUES ('086602', 3, 'ID', 'Kec. Pariaman Tengah', '086600');
INSERT INTO siakad.master_wilayah VALUES ('086603', 3, 'ID', 'Kec. Pariaman Utara', '086600');
INSERT INTO siakad.master_wilayah VALUES ('086604', 3, 'ID', 'Kec. Pariaman Timur', '086600');
INSERT INTO siakad.master_wilayah VALUES ('090000', 1, 'ID', 'Prov. Riau', '000000');
INSERT INTO siakad.master_wilayah VALUES ('090100', 2, 'ID', 'Kab. Kampar', '090000');
INSERT INTO siakad.master_wilayah VALUES ('090101', 3, 'ID', 'Kec. XIII Koto Kampar', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090102', 3, 'ID', 'Kec. Kampar Kiri', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090103', 3, 'ID', 'Kec. Kampar', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090104', 3, 'ID', 'Kec. Tambang', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090105', 3, 'ID', 'Kec. Bangkinang', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090106', 3, 'ID', 'Kec. Bangkinang Barat', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090107', 3, 'ID', 'Kec. Siak Hulu', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090108', 3, 'ID', 'Kec. Tapung', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090109', 3, 'ID', 'Kec. Kampar Kiri Hulu', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090110', 3, 'ID', 'Kec. Kampar Kiri Hilir', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090111', 3, 'ID', 'Kec. Tapung Hulu', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090112', 3, 'ID', 'Kec. Tapung Hilir', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090113', 3, 'ID', 'Kec. Tapung Kiri', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090114', 3, 'ID', 'Kec. Salo', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090115', 3, 'ID', 'Kec. Rumbio Jaya', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090116', 3, 'ID', 'Kec. Bangkinang Seberang', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090117', 3, 'ID', 'Kec. Perhentian Raja', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090118', 3, 'ID', 'Kec. Kampar Timur', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090119', 3, 'ID', 'Kec. Kampar Utara', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090120', 3, 'ID', 'Kec. Kampar Kiri Tengah', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090121', 3, 'ID', 'Kec. Gunung Sahilan', '090100');
INSERT INTO siakad.master_wilayah VALUES ('090190', 3, 'ID', 'Koto Kampar Hulu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('090200', 2, 'ID', 'Kab. Bengkalis', '090000');
INSERT INTO siakad.master_wilayah VALUES ('090201', 3, 'ID', 'Kec. Mandau', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090205', 3, 'ID', 'Kec. Bengkalis', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090206', 3, 'ID', 'Kec. Bantan', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090207', 3, 'ID', 'Kec. Bukit Batu', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090208', 3, 'ID', 'Kec. Rupat', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090209', 3, 'ID', 'Kec. Rupat Utara', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090212', 3, 'ID', 'Kec. Siak Kecil', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090213', 3, 'ID', 'Kec. Pinggir', '090200');
INSERT INTO siakad.master_wilayah VALUES ('090400', 2, 'ID', 'Kab. Indragiri Hulu', '090000');
INSERT INTO siakad.master_wilayah VALUES ('090401', 3, 'ID', 'Kec. Peranap', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090402', 3, 'ID', 'Kec. Pasir Penyu', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090403', 3, 'ID', 'Kec. Kelayang', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090404', 3, 'ID', 'Kec. Seberida', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090405', 3, 'ID', 'Kec. Rengat', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090406', 3, 'ID', 'Kec. Rengat Barat', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090407', 3, 'ID', 'Kec. Lirik', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090408', 3, 'ID', 'Kec. Batang Gansal', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090409', 3, 'ID', 'Kec. Batang Cenaku', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090410', 3, 'ID', 'Kec. Batang Peranap', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090411', 3, 'ID', 'Kec. Lubuk Batu Jaya', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090412', 3, 'ID', 'Kec. Sei Lala', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090413', 3, 'ID', 'Kec. Rakit Kulim', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090414', 3, 'ID', 'Kec. Kuala Cenaku', '090400');
INSERT INTO siakad.master_wilayah VALUES ('090500', 2, 'ID', 'Kab. Indragiri Hilir', '090000');
INSERT INTO siakad.master_wilayah VALUES ('090501', 3, 'ID', 'Kec. Keritang', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090502', 3, 'ID', 'Kec. Reteh', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090503', 3, 'ID', 'Kec. Enok', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090504', 3, 'ID', 'Kec. Tanah Merah', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090505', 3, 'ID', 'Kec. Kuala Indragiri', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090506', 3, 'ID', 'Kec. Tembilahan', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090507', 3, 'ID', 'Kec. Tempuling', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090508', 3, 'ID', 'Kec. Batang Tuaka', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090509', 3, 'ID', 'Kec. Gaung Anak Serka', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090510', 3, 'ID', 'Kec. Gaung', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090511', 3, 'ID', 'Kec. Mandah', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090512', 3, 'ID', 'Kec. Kateman', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090513', 3, 'ID', 'Kec. Kemuning', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090514', 3, 'ID', 'Kec. Pelangiran', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090515', 3, 'ID', 'Kec. Pulau Burung', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090516', 3, 'ID', 'Kec. Teluk Blengkong', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090517', 3, 'ID', 'Kec. Tembilahan Hulu', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090518', 3, 'ID', 'Kec. Concong', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090519', 3, 'ID', 'Kec. Kempas', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090520', 3, 'ID', 'Kec. Sungai Batang', '090500');
INSERT INTO siakad.master_wilayah VALUES ('090800', 2, 'ID', 'Kab. Pelalawan', '090000');
INSERT INTO siakad.master_wilayah VALUES ('090801', 3, 'ID', 'Kec. Langgam', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090802', 3, 'ID', 'Kec. Pangkalan Kuras', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090803', 3, 'ID', 'Kec. Bunut', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090804', 3, 'ID', 'Kec. Kuala Kampar', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090805', 3, 'ID', 'Kec. Pangkalan Kerinci', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090806', 3, 'ID', 'Kec. Ukui', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090807', 3, 'ID', 'Kec. Pangkalan Lesung', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090808', 3, 'ID', 'Kec. Kerumutan', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090809', 3, 'ID', 'Kec. Pelalawan', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090810', 3, 'ID', 'Kec. Teluk Meranti', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090811', 3, 'ID', 'Kec. Bandar Sei Kijang', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090812', 3, 'ID', 'Kec. Bandar Petalangan', '090800');
INSERT INTO siakad.master_wilayah VALUES ('090900', 2, 'ID', 'Kab. Rokan Hilir', '090000');
INSERT INTO siakad.master_wilayah VALUES ('090901', 3, 'ID', 'Kec. Ujung Batu', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090902', 3, 'ID', 'Kec. Rokan IV Koto', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090903', 3, 'ID', 'Kec. Rambah', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090904', 3, 'ID', 'Kec. Tembusai', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090905', 3, 'ID', 'Kec. Kepenuhan', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090906', 3, 'ID', 'Kec. Kunto Darussalam', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090907', 3, 'ID', 'Kec. Rambah Samo', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090908', 3, 'ID', 'Kec. Rambah Hilir', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090909', 3, 'ID', 'Kec. Tembusai Utara', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090910', 3, 'ID', 'Kec. Bangun Purba', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090911', 3, 'ID', 'Kec. Tandun', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090912', 3, 'ID', 'Kec. Kabun', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090913', 3, 'ID', 'Kec. Bonai Darussalam', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090914', 3, 'ID', 'Kec. Pagaran Tapah Darussalam', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090916', 3, 'ID', 'Kec. Pendalian IV Koto', '090900');
INSERT INTO siakad.master_wilayah VALUES ('090917', 3, 'ID', 'Kec. Kepenuhan Hulu', '090900');
INSERT INTO siakad.master_wilayah VALUES ('091000', 2, 'ID', 'Kab. Siak', '090000');
INSERT INTO siakad.master_wilayah VALUES ('091001', 3, 'ID', 'Kec. Kubu', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091002', 3, 'ID', 'Kec. Bangko', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091003', 3, 'ID', 'Kec. Tanah Putih', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091004', 3, 'ID', 'Kec. Rimba Melintang', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091005', 3, 'ID', 'Kec. Bagan Sinembah', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091006', 3, 'ID', 'Kec. Pasir Limau Kapas', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091007', 3, 'ID', 'Kec. Sinaboi', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091008', 3, 'ID', 'Kec. Tanah Putih Tanjung Melawan', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091009', 3, 'ID', 'Kec. Pujud', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091010', 3, 'ID', 'Kec. Bangko Pusako', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091011', 3, 'ID', 'Kec. Simpang Kanan', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091012', 3, 'ID', 'Kec. Batu Hampar', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091013', 3, 'ID', 'Kec. Rantau Kopar', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091100', 2, 'ID', 'Kab. Kuantan Singingi', '090000');
INSERT INTO siakad.master_wilayah VALUES ('091101', 3, 'ID', 'Kec. Minas', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091102', 3, 'ID', 'Kec. Siak', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091103', 3, 'ID', 'Kec. Sungai Apit', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091104', 3, 'ID', 'Kec. Tualang', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091105', 3, 'ID', 'Kec. Kerinci Kanan', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091106', 3, 'ID', 'Kec. Dayun', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091107', 3, 'ID', 'Kec. Bunga Raya', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091108', 3, 'ID', 'Kec. Sungai Mandau', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091109', 3, 'ID', 'Kec. Kandis', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091110', 3, 'ID', 'Kec. Lubuk Dalam', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091111', 3, 'ID', 'Kec. Koto Gasip', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091112', 3, 'ID', 'Kec. Pusako', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091113', 3, 'ID', 'Kec. Sabak Auh', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091114', 3, 'ID', 'Kec. Sungai Mempura', '091100');
INSERT INTO siakad.master_wilayah VALUES ('091115', 3, 'ID', 'Mempura', '      ');
INSERT INTO siakad.master_wilayah VALUES ('091400', 2, 'ID', 'Kab. Rokan Hulu', '090000');
INSERT INTO siakad.master_wilayah VALUES ('091401', 3, 'ID', 'Kec. Kuantan Mudik', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091402', 3, 'ID', 'Kec. Kuantan Tengah', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091403', 3, 'ID', 'Kec. Benai', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091404', 3, 'ID', 'Kec. Singingi', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091405', 3, 'ID', 'Kec. Kuantan Hilir', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091406', 3, 'ID', 'Kec. Cerenti', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091407', 3, 'ID', 'Kec. Pangean', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091408', 3, 'ID', 'Kec. Logas Tanah Darat', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091409', 3, 'ID', 'Kec. Inuman', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091410', 3, 'ID', 'Kec. Singingi Hilir', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091411', 3, 'ID', 'Kec. Hulu Kuantan', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091412', 3, 'ID', 'Kec. Gunung Toar', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091500', 2, 'ID', 'Kab. Kepulauan Meranti', '090000');
INSERT INTO siakad.master_wilayah VALUES ('091501', 3, 'ID', 'Kec. Merbau', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091502', 3, 'ID', 'Kec. Rangsang', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091503', 3, 'ID', 'Kec. Rangsang Barat', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091504', 3, 'ID', 'Kec. Tebing Tinggi', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091505', 3, 'ID', 'Kec. Tebing Tinggi Barat', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091506', 3, 'ID', 'Kec. Tasik Putri Puyu', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091507', 3, 'ID', 'Kec. Pulau Merbau', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091508', 3, 'ID', 'Kec. Tebing Tinggi Timur', '091500');
INSERT INTO siakad.master_wilayah VALUES ('091509', 3, 'ID', 'Kec. Rangsang Pesisir', '091500');
INSERT INTO siakad.master_wilayah VALUES ('096000', 2, 'ID', 'Kota Pekanbaru', '090000');
INSERT INTO siakad.master_wilayah VALUES ('096001', 3, 'ID', 'Kec. Tampan', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096002', 3, 'ID', 'Kec. Bukit Raya', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096003', 3, 'ID', 'Kec. Lima Puluh', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096004', 3, 'ID', 'Kec. Sail', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096005', 3, 'ID', 'Kec. Pekanbaru Kota', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096006', 3, 'ID', 'Kec. Sukajadi', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096007', 3, 'ID', 'Kec. Senapelan', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096008', 3, 'ID', 'Kec. Rumbai', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096009', 3, 'ID', 'Kec. Tenayan Raya', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096010', 3, 'ID', 'Kec. Marpoyan Damai', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096011', 3, 'ID', 'Kec. Rumbai Pesisir', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096012', 3, 'ID', 'Kec. Payung Sekaki', '096000');
INSERT INTO siakad.master_wilayah VALUES ('096200', 2, 'ID', 'Kota Dumai', '090000');
INSERT INTO siakad.master_wilayah VALUES ('096201', 3, 'ID', 'Kec. Bukit Kapur', '096200');
INSERT INTO siakad.master_wilayah VALUES ('096202', 3, 'ID', 'Kec. Dumai Barat', '096200');
INSERT INTO siakad.master_wilayah VALUES ('096203', 3, 'ID', 'Kec. Dumai Timur', '096200');
INSERT INTO siakad.master_wilayah VALUES ('096204', 3, 'ID', 'Kec. Medang Kampai', '096200');
INSERT INTO siakad.master_wilayah VALUES ('096205', 3, 'ID', 'Kec. Sungai Sembilan', '096200');
INSERT INTO siakad.master_wilayah VALUES ('096206', 3, 'ID', 'Kec. Dumai Kota', '096200');
INSERT INTO siakad.master_wilayah VALUES ('096207', 3, 'ID', 'Kec. Dumai Selatan', '096200');
INSERT INTO siakad.master_wilayah VALUES ('100000', 1, 'ID', 'Prov. Jambi', '000000');
INSERT INTO siakad.master_wilayah VALUES ('100100', 2, 'ID', 'Kab. Batang Hari', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100101', 3, 'ID', 'Kec. Mersan', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100102', 3, 'ID', 'Kec. Muara Tembesi', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100103', 3, 'ID', 'Kec. Batin XXIV', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100104', 3, 'ID', 'Kec. Muara Bulian', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100105', 3, 'ID', 'Kec. Pemayung', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100106', 3, 'ID', 'Kec. Maro Sebo Ulu', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100107', 3, 'ID', 'Kec. Bajubang', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100108', 3, 'ID', 'Kec. Maro Sebo Ilir', '100100');
INSERT INTO siakad.master_wilayah VALUES ('100200', 2, 'ID', 'Kab. Bungo', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100201', 3, 'ID', 'Kec. Tanah Tumbuh', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100202', 3, 'ID', 'Kec. Tanah Sepenggal', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100203', 3, 'ID', 'Kec. Jujuhan', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100204', 3, 'ID', 'Kec. Rantau Pandan', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100205', 3, 'ID', 'Kec. Pasar Muara Bungo', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100206', 3, 'ID', 'Kec. Pelepat', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100208', 3, 'ID', 'Kec. Pelepat Ilir', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100209', 3, 'ID', 'Kec. Limbur Lubuk Mengkuang', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100210', 3, 'ID', 'Kec. Bathin II Babeko', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100211', 3, 'ID', 'Kec. Muko Muko Batin VII', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100212', 3, 'ID', 'Kec. Bungo Dani', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100213', 3, 'ID', 'Kec. Bathin III', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100214', 3, 'ID', 'Kec. Bathin III Ulu', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100215', 3, 'ID', 'Kec. Tanah Sepenggal Luas', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100216', 3, 'ID', 'Kec. Bathin II Pelayang', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100217', 3, 'ID', 'Kec. Jujuhan Ilir', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100218', 3, 'ID', 'Kec. Rimbo Tengah', '100200');
INSERT INTO siakad.master_wilayah VALUES ('100299', 3, 'ID', 'Tanah Sepenggal Lintas', '      ');
INSERT INTO siakad.master_wilayah VALUES ('100300', 2, 'ID', 'Kab. Sarolangun', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100301', 3, 'ID', 'Kec. Batang Asai', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100302', 3, 'ID', 'Kec. Limun', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100303', 3, 'ID', 'Kec. Sarolangon', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100304', 3, 'ID', 'Kec. Pelawan', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100305', 3, 'ID', 'Kec. Pauh', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100306', 3, 'ID', 'Kec. Mandiangin', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100307', 3, 'ID', 'Kec. Air Hitam', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100308', 3, 'ID', 'Kec. Bathin VIII', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100309', 3, 'ID', 'Kec. Singkut', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100310', 3, 'ID', 'Kec. Cermin Nan Gadang', '100300');
INSERT INTO siakad.master_wilayah VALUES ('100400', 2, 'ID', 'Kab. Tanjung Jabung Barat', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100401', 3, 'ID', 'Kec. Tungkal Ulu', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100402', 3, 'ID', 'Kec. Pengabuan', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100403', 3, 'ID', 'Kec. Tungkal Ilir', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100404', 3, 'ID', 'Kec. Betara', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100405', 3, 'ID', 'Kec. Merlung', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100406', 3, 'ID', 'Kec. Batang Asam', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100407', 3, 'ID', 'Kec. Tebing Tinggi', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100408', 3, 'ID', 'Kec. Renah Mendalu', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100409', 3, 'ID', 'Kec. Muara Papalik', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100410', 3, 'ID', 'Kec. Senyerang', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100411', 3, 'ID', 'Kec. Bram Itam', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100412', 3, 'ID', 'Kec. Seberang Kota', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100413', 3, 'ID', 'Kec. Kuala Betara', '100400');
INSERT INTO siakad.master_wilayah VALUES ('100500', 2, 'ID', 'Kab. Kerinci', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100501', 3, 'ID', 'Kec. Gunung Raya', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100502', 3, 'ID', 'Kec. Batang Merangin', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100503', 3, 'ID', 'Kec. Keliling Danau', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100504', 3, 'ID', 'Kec. Danau Kerinci', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100505', 3, 'ID', 'Kec. Sitinjau Laut', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100507', 3, 'ID', 'Kec. Air Hangat', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100508', 3, 'ID', 'Kec. Gunung Kerinci', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100509', 3, 'ID', 'Kec. Kayu Aro', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100511', 3, 'ID', 'Kec. Air Hangat Timur', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100515', 3, 'ID', 'Kec. Gunung Tujuh', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100516', 3, 'ID', 'Kec. Siulak', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100517', 3, 'ID', 'Kec. Depati Tujuh', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100600', 2, 'ID', 'Kab. Tebo', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100601', 3, 'ID', 'Kec. Rimbo Bujang', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100602', 3, 'ID', 'Kec. Tebo Ilir', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100603', 3, 'ID', 'Kec. Tebo Tengah', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100604', 3, 'ID', 'Kec. Tebo Ulu', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100605', 3, 'ID', 'Kec. Sumay', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100606', 3, 'ID', 'Kec. VII Koto', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100607', 3, 'ID', 'Kec. Rimbo Ilir', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100608', 3, 'ID', 'Kec. Rimbo Ulu', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100609', 3, 'ID', 'Kec. Tengah Ilir', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100610', 3, 'ID', 'Kec. Serai Serumpun', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100611', 3, 'ID', 'Kec. VII Koto Ilir', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100612', 3, 'ID', 'Kec. Muara Tabir', '100600');
INSERT INTO siakad.master_wilayah VALUES ('100700', 2, 'ID', 'Kab. Muaro Jambi', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100701', 3, 'ID', 'Kec. Jambi Luar Kota', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100702', 3, 'ID', 'Kec. Mestong', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100703', 3, 'ID', 'Kec. Kumpeh Ulu', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100704', 3, 'ID', 'Kec. Sekernan', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100705', 3, 'ID', 'Kec. Maro Sebo', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100706', 3, 'ID', 'Kec. Kumpeh', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100707', 3, 'ID', 'Kec. Sungai Bahar', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100708', 3, 'ID', 'Kec. Sungai Gelam', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100800', 2, 'ID', 'Kab. Tanjung Jabung Timur', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100801', 3, 'ID', 'Kec. Muara Sabak', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100802', 3, 'ID', 'Kec. Mendahara', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100803', 3, 'ID', 'Kec. Dendang', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100804', 3, 'ID', 'Kec. Nipah Panjang', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100805', 3, 'ID', 'Kec. Rantau Rasau', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100806', 3, 'ID', 'Kec. Sadu', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100807', 3, 'ID', 'Kec. Mendahara Ulu', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100808', 3, 'ID', 'Kec. Geragai', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100809', 3, 'ID', 'Kec. Muara Sabak Barat', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100811', 3, 'ID', 'Kec. Kuala Jambi', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100812', 3, 'ID', 'Kec. Berbak', '100800');
INSERT INTO siakad.master_wilayah VALUES ('100890', 3, 'ID', 'Muara Sabak Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('100900', 2, 'ID', 'Kab. Merangin', '100000');
INSERT INTO siakad.master_wilayah VALUES ('100901', 3, 'ID', 'Kec. Jangkat', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100902', 3, 'ID', 'Kec. Bangko', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100903', 3, 'ID', 'Kec. Pamenang', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100904', 3, 'ID', 'Kec. Muara Siau', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100905', 3, 'ID', 'Kec. Sungai Manau', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100906', 3, 'ID', 'Kec. Tabir', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100907', 3, 'ID', 'Kec. Tabir Ulu', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100909', 3, 'ID', 'Kec. Lembah Masuarai', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100910', 3, 'ID', 'Kec. Tabir Selatan', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100911', 3, 'ID', 'Kec. Bangko Barat', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100912', 3, 'ID', 'Kec. Nalo Tantan', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100913', 3, 'ID', 'Kec. Batang Masumai', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100914', 3, 'ID', 'Kec. Pamenang Barat', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100915', 3, 'ID', 'Kec. Tabir Ilir', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100916', 3, 'ID', 'Kec. Tabir Timur', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100917', 3, 'ID', 'Kec. Renah Pemparap', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100918', 3, 'ID', 'Kec. Pangkalan Jambu', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100919', 3, 'ID', 'Kec. Sungai Tenang', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100920', 3, 'ID', 'Kec. Tiang Pumpung', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100921', 3, 'ID', 'Kec. Renah Pamenang', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100922', 3, 'ID', 'Kec. Pamenang Selatan', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100923', 3, 'ID', 'Kec. Tabir Lintas', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100924', 3, 'ID', 'Kec. Margo Tabir', '100900');
INSERT INTO siakad.master_wilayah VALUES ('100925', 3, 'ID', 'Kec. Tabir Barat', '100900');
INSERT INTO siakad.master_wilayah VALUES ('106000', 2, 'ID', 'Kota Jambi', '100000');
INSERT INTO siakad.master_wilayah VALUES ('106001', 3, 'ID', 'Kec. Kota Baru', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106002', 3, 'ID', 'Kec. Jambi Selatan', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106003', 3, 'ID', 'Kec. Jelutung', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106004', 3, 'ID', 'Kec. Pasar Jambi', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106005', 3, 'ID', 'Kec. Telanai Pura', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106006', 3, 'ID', 'Kec. Danau Teluk', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106007', 3, 'ID', 'Kec. Pelayangan', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106008', 3, 'ID', 'Kec. Jambi Timur', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106100', 2, 'ID', 'Kab. Sungai Penuh', '100000');
INSERT INTO siakad.master_wilayah VALUES ('106101', 3, 'ID', 'Kec. Tanah Kampung', '106100');
INSERT INTO siakad.master_wilayah VALUES ('106102', 3, 'ID', 'Kec. Sungai Penuh', '106100');
INSERT INTO siakad.master_wilayah VALUES ('106103', 3, 'ID', 'Kec. Hamparan Rawang', '106100');
INSERT INTO siakad.master_wilayah VALUES ('106104', 3, 'ID', 'Kec. Pesisir Bukit', '106100');
INSERT INTO siakad.master_wilayah VALUES ('106105', 3, 'ID', 'Kec. Kumun Debai', '106100');
INSERT INTO siakad.master_wilayah VALUES ('110000', 1, 'ID', 'Prov. Sumatera Selatan', '000000');
INSERT INTO siakad.master_wilayah VALUES ('110100', 2, 'ID', 'Kab. Musi Banyu Asin', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110101', 3, 'ID', 'Kec. Sanga Desa', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110102', 3, 'ID', 'Kec. Babat Toman', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110103', 3, 'ID', 'Kec. Sungai Keruh', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110104', 3, 'ID', 'Kec. Sekayu', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110109', 3, 'ID', 'Kec. Sungai Lilin', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110110', 3, 'ID', 'Kec. Bayung Lencir', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110111', 3, 'ID', 'Kec. Lais', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110112', 3, 'ID', 'Kec. Batanghari Leko', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110113', 3, 'ID', 'Kec. Keluang', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110116', 3, 'ID', 'Kec. Plakat Tinggi', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110117', 3, 'ID', 'Kec. Lalan', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110118', 3, 'ID', 'Kec. Tungkal Jaya', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110119', 3, 'ID', 'Kec. Lawang Wetan', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110120', 3, 'ID', 'Kec. Babat Supat', '110100');
INSERT INTO siakad.master_wilayah VALUES ('110200', 2, 'ID', 'Kab. Ogan Komering Ilir', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110201', 3, 'ID', 'Kec. Lempuing', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110202', 3, 'ID', 'Kec. Mesuji', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110203', 3, 'ID', 'Kec. Tulung Selapan', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110204', 3, 'ID', 'Kec. Pedamaran', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110205', 3, 'ID', 'Kec. Tanjung Lubuk', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110206', 3, 'ID', 'Kec. Kota Ayu Agung', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110212', 3, 'ID', 'Kec. Sirah Pulau Padang', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110213', 3, 'ID', 'Kec. Pampangan', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110214', 3, 'ID', 'Kec. Air Sugihan', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110216', 3, 'ID', 'Kec. Cengal', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110218', 3, 'ID', 'Kec. Jejawi', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110220', 3, 'ID', 'Kec. Sungai Menang', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110221', 3, 'ID', 'Kec. Lempuing Jaya', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110222', 3, 'ID', 'Kec. Mesuji Makmur', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110223', 3, 'ID', 'Kec. Mesuji Raya', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110224', 3, 'ID', 'Kec. Pedamaran Timur', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110225', 3, 'ID', 'Kec. Teluk Gelam', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110226', 3, 'ID', 'Kec. Pangkalan Lapam', '110200');
INSERT INTO siakad.master_wilayah VALUES ('110300', 2, 'ID', 'Kab. Ogan Komering Ulu', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110307', 3, 'ID', 'Kec. Sosoh Buay Rayap', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110308', 3, 'ID', 'Kec. Pengandonan', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110309', 3, 'ID', 'Kec. Peninjauan', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110317', 3, 'ID', 'Kec. Lubuk Batang', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110320', 3, 'ID', 'Kec. Ulu Ogan', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110321', 3, 'ID', 'Kec. Semidang Aji', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110322', 3, 'ID', 'Kec. Lengkiti', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110371', 3, 'ID', 'Kec. Baturaja Timur', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110372', 3, 'ID', 'Kec. Baturaja Barat', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110373', 3, 'ID', 'Kec. Sinar Peninjauan', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110374', 3, 'ID', 'Kec. Lubuk Raja', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110375', 3, 'ID', 'Kec. Muara Jaya', '110300');
INSERT INTO siakad.master_wilayah VALUES ('110400', 2, 'ID', 'Kab. Muara Enim', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110401', 3, 'ID', 'Kec. Semende Darat Laut', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110402', 3, 'ID', 'Kec. Tanjung Agung', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110403', 3, 'ID', 'Kec. Lawang Kidul', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110404', 3, 'ID', 'Kec. Muara Enim', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110405', 3, 'ID', 'Kec. Gunung Megang', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110406', 3, 'ID', 'Kec. Talang Ubi', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110407', 3, 'ID', 'Kec. Gelumbang', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110409', 3, 'ID', 'Kec. Sungai Rotan', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110410', 3, 'ID', 'Kec. Lembak', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110411', 3, 'ID', 'Kec. Benakat', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110412', 3, 'ID', 'Kec. Ujan Mas', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110413', 3, 'ID', 'Kec. Penukal', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110414', 3, 'ID', 'Kec. Penukal Utara', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110415', 3, 'ID', 'Kec. Tanah Abang', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110416', 3, 'ID', 'Kec. Lubai', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110417', 3, 'ID', 'Kec. Rambang', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110419', 3, 'ID', 'Kec. Semende Darat Ulu', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110420', 3, 'ID', 'Kec. Semende Darat Tengah', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110422', 3, 'ID', 'Kec. Rambang Dangku', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110423', 3, 'ID', 'Kec. Abab', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110424', 3, 'ID', 'Kec. Kelekar', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110425', 3, 'ID', 'Kec. Muara Belida', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110427', 3, 'ID', 'Abab', '      ');
INSERT INTO siakad.master_wilayah VALUES ('110428', 3, 'ID', 'Talang Ubi', '      ');
INSERT INTO siakad.master_wilayah VALUES ('110429', 3, 'ID', 'Penukal Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('110430', 3, 'ID', 'Tanah Abang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('110431', 3, 'ID', 'Penukal', '      ');
INSERT INTO siakad.master_wilayah VALUES ('110500', 2, 'ID', 'Kab. Lahat', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110504', 3, 'ID', 'Kec. Kota Agung', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110505', 3, 'ID', 'Kec. Pulau Pinang', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110506', 3, 'ID', 'Kec. Jarai', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110511', 3, 'ID', 'Kec. Kikim Timur', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110512', 3, 'ID', 'Kec. Lahat', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110514', 3, 'ID', 'Kec. Mulak Ulu', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110515', 3, 'ID', 'Kec. Pajar Bulan', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110519', 3, 'ID', 'Kec. Kikim Selatan', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110520', 3, 'ID', 'Kec. Kikim Barat', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110521', 3, 'ID', 'Kec. Kikim Tengah', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110522', 3, 'ID', 'Kec. Tanjung Sakti Pumi', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110523', 3, 'ID', 'Kec. Tanjung Sakti Pumu', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110524', 3, 'ID', 'Kec. Merapi Barat', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110526', 3, 'ID', 'Kec. Pseksu', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110527', 3, 'ID', 'Kec. Gumay Talang', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110528', 3, 'ID', 'Kec. Pagar Gunung', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110529', 3, 'ID', 'Kec. Merapi Timur', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110530', 3, 'ID', 'Kec. Gumay Ulu', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110531', 3, 'ID', 'Kec. Merapi Selatan', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110532', 3, 'ID', 'kec. Tanjung Tebat', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110533', 3, 'ID', 'Kec. Muara Payang', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110600', 2, 'ID', 'Kab. Musi Rawas', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110601', 3, 'ID', 'Kec. Rawas Ulu', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110602', 3, 'ID', 'Kec. Rupit', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110603', 3, 'ID', 'Kec. STL  Ulu Terawas', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110604', 3, 'ID', 'Kec. Tugu Mulyo', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110605', 3, 'ID', 'Kec. Muara Beliti', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110606', 3, 'ID', 'Kec. Jayaloka', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110607', 3, 'ID', 'Kec. Muara Kelingi', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110608', 3, 'ID', 'Kec. Muara Lakitan', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110609', 3, 'ID', 'Kec. Megang Sakti', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110610', 3, 'ID', 'Kec. Rawas Ilir', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110611', 3, 'ID', 'Kec. Purwodadi', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110612', 3, 'ID', 'Kec. Selangit', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110613', 3, 'ID', 'Kec. Karang Jaya', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110614', 3, 'ID', 'Kec. Karang Dapo', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110615', 3, 'ID', 'Kec. Bulan Tengah Suku Ulu', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110616', 3, 'ID', 'Kec. Ulu Rawas', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110617', 3, 'ID', 'Kec. Nibung', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110619', 3, 'ID', 'Kec. Tiang Pumpung Kepungut', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110620', 3, 'ID', 'Kec. Sumber Harta', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110621', 3, 'ID', 'Kec. Tanah Negeri', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110622', 3, 'ID', 'Kec. Suka Karya', '110600');
INSERT INTO siakad.master_wilayah VALUES ('110700', 2, 'ID', 'Kab. Banyuasin', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110701', 3, 'ID', 'Kec. Rantau Bayur', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110702', 3, 'ID', 'Kec. Talang Kelapa', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110703', 3, 'ID', 'Kec. Banyuasin III', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110704', 3, 'ID', 'Kec. Betung', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110705', 3, 'ID', 'Kec. Makarti Jaya', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110706', 3, 'ID', 'Kec. Banyuasin I', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110707', 3, 'ID', 'Kec. Banyuasin II', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110709', 3, 'ID', 'Kec. Rambutan', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110710', 3, 'ID', 'Kec. Muara Telang', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110711', 3, 'ID', 'Kec. Muara Padang', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110712', 3, 'ID', 'Kec. Tanjung Lago', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110713', 3, 'ID', 'Kec. Muara Sugihan', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110714', 3, 'ID', 'Kec. Air Salek', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110715', 3, 'ID', 'Kec. Tungkal Ilir', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110716', 3, 'ID', 'Kec. Suak Tapeh', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110717', 3, 'ID', 'Kec. Pulau Rimau', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110718', 3, 'ID', 'Kec. Sembawa', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110800', 2, 'ID', 'Kab. Ogan Komering Ulu Timur', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110801', 3, 'ID', 'Kec. Martapura', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110802', 3, 'ID', 'Kec. Buay Madang', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110803', 3, 'ID', 'Kec. Cempaka', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110804', 3, 'ID', 'Kec. Madang Suku I', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110805', 3, 'ID', 'Kec. Madang Suku II', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110806', 3, 'ID', 'Kec. Belitang I', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110807', 3, 'ID', 'Kec. Belitang II', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110808', 3, 'ID', 'Kec. Belitang III', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110809', 3, 'ID', 'Kec. Buay Pemuka Peliung', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110810', 3, 'ID', 'Kec. Semendawai Suku III', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110811', 3, 'ID', 'Kec. Bunga Mayang', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110812', 3, 'ID', 'Kec. Buay Madang Timur', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110813', 3, 'ID', 'Kec. Madang Suku III', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110814', 3, 'ID', 'Kec. Semendawai Barat', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110815', 3, 'ID', 'Kec. Semendawai Timur', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110816', 3, 'ID', 'Kec. Jayapura', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110817', 3, 'ID', 'Kec. Belitang Jaya', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110818', 3, 'ID', 'Kec. Belitang Madang Raya', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110819', 3, 'ID', 'Kec. Belitang Mulia', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110820', 3, 'ID', 'Kec. Buay Pemuka Bangsa Raja', '110800');
INSERT INTO siakad.master_wilayah VALUES ('110890', 3, 'ID', 'Belitang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('110900', 2, 'ID', 'Kab. Ogan Komering Ulu Selatan', '110000');
INSERT INTO siakad.master_wilayah VALUES ('110901', 3, 'ID', 'Kec. Banding Agung', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110902', 3, 'ID', 'Kec. Pulau Beringin', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110903', 3, 'ID', 'Kec. Muaradua Kisam', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110904', 3, 'ID', 'Kec. Muaradua', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110905', 3, 'ID', 'Kec. Simpang', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110906', 3, 'ID', 'Kec. Buay Sandang Aji', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110907', 3, 'ID', 'Kec. Buay Runjung', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110908', 3, 'ID', 'Kec. Buay Pemaca', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110909', 3, 'ID', 'Kec. Mekakau Ilir', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110910', 3, 'ID', 'Kec. Kisam Tinggi', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110911', 3, 'ID', 'Kec. Kisam Ilir', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110912', 3, 'ID', 'Kec. Buay Pematang Ribu Ranau', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110913', 3, 'ID', 'Kec. Warkuk Ranau Selatan', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110914', 3, 'ID', 'Kec. Runjung Agung', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110915', 3, 'ID', 'Kec. Sungai Are', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110916', 3, 'ID', 'Kec. Sidang Danau', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110917', 3, 'ID', 'Kec. Buana Pemaca', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110918', 3, 'ID', 'Kec. Tiga Dihaji', '110900');
INSERT INTO siakad.master_wilayah VALUES ('110919', 3, 'ID', 'Kec. Buay Rawan', '110900');
INSERT INTO siakad.master_wilayah VALUES ('111000', 2, 'ID', 'Kab. Ogan Ilir', '110000');
INSERT INTO siakad.master_wilayah VALUES ('111001', 3, 'ID', 'Kec. Tanjung Raja', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111002', 3, 'ID', 'Kec. Muara Kuang', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111003', 3, 'ID', 'Kec. Tanjung Batu', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111004', 3, 'ID', 'Kec. Indralaya', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111005', 3, 'ID', 'Kec. Pemulutan', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111006', 3, 'ID', 'Kec. Rantau Alai', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111007', 3, 'ID', 'Kec. Rambang Kuang', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111008', 3, 'ID', 'Kec. Lubuk Keliat', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111009', 3, 'ID', 'Kec. Payaraman', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111010', 3, 'ID', 'Kec. Kandis', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111011', 3, 'ID', 'Kec. Pemulutan Selatan', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111012', 3, 'ID', 'Kec. Pemulutan Barat', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111013', 3, 'ID', 'Kec. Indralaya Selatan', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111014', 3, 'ID', 'Kec. Indralaya Utara', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111015', 3, 'ID', 'Kec. Rantau Panjang', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111016', 3, 'ID', 'Kec. Sungai Pinang', '111000');
INSERT INTO siakad.master_wilayah VALUES ('111100', 2, 'ID', 'Kab. Empat Lawang', '110000');
INSERT INTO siakad.master_wilayah VALUES ('111101', 3, 'ID', 'Kec. Lintang Kanan', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111102', 3, 'ID', 'Kec. Muara Pinang', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111103', 3, 'ID', 'Kec. Pendopo', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111104', 3, 'ID', 'Kec. Ulu Musi', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111105', 3, 'ID', 'Kec. Tebing Tinggi', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111106', 3, 'ID', 'Kec. Talang Padang', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111107', 3, 'ID', 'Kec. Pasemah Air Keruh', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111108', 3, 'ID', 'Kec. Sikap Dalam', '111100');
INSERT INTO siakad.master_wilayah VALUES ('116000', 2, 'ID', 'Kota Palembang', '110000');
INSERT INTO siakad.master_wilayah VALUES ('116001', 3, 'ID', 'Kec. Ilir Barat II', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116002', 3, 'ID', 'Kec. Seberang Ulu I', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116003', 3, 'ID', 'Kec. Seberang Ulu II', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116004', 3, 'ID', 'Kec. Ilir Barat I', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116005', 3, 'ID', 'Kec. Ilir Timur I', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116006', 3, 'ID', 'Kec. Ilir Timur II', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116007', 3, 'ID', 'Kec. Sako', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116008', 3, 'ID', 'Kec. Sukarami', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116009', 3, 'ID', 'Kec. Kemuning', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116010', 3, 'ID', 'Kec. Plaju', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116011', 3, 'ID', 'Kec. Kertapati', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116012', 3, 'ID', 'Kec. Gandus', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116013', 3, 'ID', 'Kec. Bukit Kecil', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116014', 3, 'ID', 'Kec. Kalidoni', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116015', 3, 'ID', 'Kec. Alang-Alang Lebar', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116016', 3, 'ID', 'Kec. Sematang Borang', '116000');
INSERT INTO siakad.master_wilayah VALUES ('116100', 2, 'ID', 'Kota Prabumulih', '110000');
INSERT INTO siakad.master_wilayah VALUES ('116103', 3, 'ID', 'Kec. Prabumulih Timur', '116100');
INSERT INTO siakad.master_wilayah VALUES ('116104', 3, 'ID', 'Kec. Prabumulih Barat', '116100');
INSERT INTO siakad.master_wilayah VALUES ('116105', 3, 'ID', 'Kec. Cambai', '116100');
INSERT INTO siakad.master_wilayah VALUES ('116106', 3, 'ID', 'Kec. Rambang Kapak Tengah', '116100');
INSERT INTO siakad.master_wilayah VALUES ('116107', 3, 'ID', 'Kec. Prabumulih Utara', '116100');
INSERT INTO siakad.master_wilayah VALUES ('116108', 3, 'ID', 'Kec. Prabumulih Selatan', '116100');
INSERT INTO siakad.master_wilayah VALUES ('116200', 2, 'ID', 'Kota Lubuk Linggau', '110000');
INSERT INTO siakad.master_wilayah VALUES ('116201', 3, 'ID', 'Kec. Lubuk Linggau Barat I', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116202', 3, 'ID', 'Kec. Lubuk Linggau Timur I', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116203', 3, 'ID', 'Kec. Lubuk Linggau Selatan I', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116204', 3, 'ID', 'Kec. Lubuk Linggau Utara I', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116205', 3, 'ID', 'Kec. Lubuk Linggau Barat II', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116206', 3, 'ID', 'Kec. Lubuk Linggau Timur II', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116207', 3, 'ID', 'Kec. Lubuk Linggau Selatan II', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116208', 3, 'ID', 'Kec. Lubuk Linggau Utara II', '116200');
INSERT INTO siakad.master_wilayah VALUES ('116300', 2, 'ID', 'Kota Pagar Alam', '110000');
INSERT INTO siakad.master_wilayah VALUES ('116301', 3, 'ID', 'Kec. Pagar Alam Utara', '116300');
INSERT INTO siakad.master_wilayah VALUES ('116302', 3, 'ID', 'Kec. Pagar Alam Selatan', '116300');
INSERT INTO siakad.master_wilayah VALUES ('116303', 3, 'ID', 'Kec. Dempo Utara', '116300');
INSERT INTO siakad.master_wilayah VALUES ('116304', 3, 'ID', 'Kec. Dempo Selatan', '116300');
INSERT INTO siakad.master_wilayah VALUES ('116305', 3, 'ID', 'Kec. Dempo Tengah', '116300');
INSERT INTO siakad.master_wilayah VALUES ('120000', 1, 'ID', 'Prov. Lampung', '000000');
INSERT INTO siakad.master_wilayah VALUES ('120100', 2, 'ID', 'Kab. Lampung Selatan', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120106', 3, 'ID', 'Kec. Natar', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120107', 3, 'ID', 'Kec. Jati Agung', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120108', 3, 'ID', 'Kec. Tanjung Bintang', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120109', 3, 'ID', 'Kec. Katibung', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120110', 3, 'ID', 'Kec. Sidomulyo', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120112', 3, 'ID', 'Kec. Palas', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120113', 3, 'ID', 'Kec. Penengahan', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120116', 3, 'ID', 'Kec. Merbau Mataram', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120117', 3, 'ID', 'Kec. Candipuro', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120118', 3, 'ID', 'Kec. Rajabasa', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120119', 3, 'ID', 'Kec. Sragi', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120120', 3, 'ID', 'Kec. Ketapang', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120121', 3, 'ID', 'Kec. Katibung', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120122', 3, 'ID', 'Kec. Bakauheni', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120123', 3, 'ID', 'Kec. Tanjung Sari', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120124', 3, 'ID', 'Kec. Way Sulan', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120125', 3, 'ID', 'Kec. Way Panji', '120100');
INSERT INTO siakad.master_wilayah VALUES ('120126', 3, 'ID', 'Kalianda', '      ');
INSERT INTO siakad.master_wilayah VALUES ('120200', 2, 'ID', 'Kab. Lampung Tengah', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120201', 3, 'ID', 'Kec. Padang Ratu', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120202', 3, 'ID', 'Kec. Kalirejo', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120203', 3, 'ID', 'Kec. Bangunrejo', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120204', 3, 'ID', 'Kec. Gunung Sugih', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120205', 3, 'ID', 'Kec. Trimurjo', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120206', 3, 'ID', 'Kec. Punggur', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120207', 3, 'ID', 'Kec. Seputih Raman', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120208', 3, 'ID', 'Kec. Terbanggi Besar', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120209', 3, 'ID', 'Kec. Terusan Nunyai', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120210', 3, 'ID', 'Kec. Seputih Mataram', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120211', 3, 'ID', 'Kec. Seputih Banyak', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120212', 3, 'ID', 'Kec. Rumbia', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120213', 3, 'ID', 'Kec. Seputih Surabaya', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120214', 3, 'ID', 'Kec. Bumi Ratu Nuban', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120215', 3, 'ID', 'Kec. Way Pengubuan', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120216', 3, 'ID', 'Kec. Seputih Agung', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120217', 3, 'ID', 'Kec. Bandar Mataram', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120218', 3, 'ID', 'Kec. Sendang Agung', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120219', 3, 'ID', 'Kec. Anak Tuha', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120220', 3, 'ID', 'Kec. Pubian', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120221', 3, 'ID', 'Kec. Bandar Surabaya', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120222', 3, 'ID', 'Kec. Bumi Nabung', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120223', 3, 'ID', 'Kec. Way Seputih', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120224', 3, 'ID', 'Kec. Kota Gajah', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120225', 3, 'ID', 'Kec. Selagai Lingga', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120226', 3, 'ID', 'Kec. Bekri', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120227', 3, 'ID', 'Kec. Anak Ratu Aji', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120228', 3, 'ID', 'Kec. Putra Rumbia', '120200');
INSERT INTO siakad.master_wilayah VALUES ('120300', 2, 'ID', 'Kab. Lampung Utara', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120301', 3, 'ID', 'Kec. Bukit Kemuning', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120302', 3, 'ID', 'Kec. Tanjung Raja', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120303', 3, 'ID', 'Kec. Abung Barat', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120304', 3, 'ID', 'Kec. Kotabumi Kota', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120305', 3, 'ID', 'Kec. Abung Selatan', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120306', 3, 'ID', 'Kec. Abung Timur', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120307', 3, 'ID', 'Kec. Sungkai Selatan', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120308', 3, 'ID', 'Kec. Sungkai Utara', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120309', 3, 'ID', 'Kec. Abung Tinggi', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120310', 3, 'ID', 'Kec. Abung Tengah', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120311', 3, 'ID', 'Kec. Kotabumi Utara', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120312', 3, 'ID', 'Kec. Kotabumi Selatan', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120313', 3, 'ID', 'Kec. Abung Semuli', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120314', 3, 'ID', 'Kec. Abung Surakarta', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120315', 3, 'ID', 'Kec. Muara Sungkai', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120316', 3, 'ID', 'Kec. Bunga Mayang', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120317', 3, 'ID', 'Kec. Hulu Sungkai', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120318', 3, 'ID', 'Kec. Sungkai Tengah', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120319', 3, 'ID', 'Kec. Abung Pekurun', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120320', 3, 'ID', 'Kec. Sungkai Jaya', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120321', 3, 'ID', 'Kec. Sungkai Barat', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120322', 3, 'ID', 'Kec. Abung Kunang', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120323', 3, 'ID', 'Kec. Blambangan Pagar', '120300');
INSERT INTO siakad.master_wilayah VALUES ('120400', 2, 'ID', 'Kab. Lampung Barat', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120401', 3, 'ID', 'Kec. Pesisir Selatan', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120402', 3, 'ID', 'Kec. Pesisir Tengah', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120403', 3, 'ID', 'Kec. Pesisir Utara', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120404', 3, 'ID', 'Kec. Balik Bukit', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120405', 3, 'ID', 'Kec. Belalau', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120406', 3, 'ID', 'Kec. Sumber Jaya', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120407', 3, 'ID', 'Kec. Sekincau', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120408', 3, 'ID', 'Kec. Bengkunat', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120409', 3, 'ID', 'Kec. Batu Brak', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120410', 3, 'ID', 'Kec. Karyapenggawa', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120411', 3, 'ID', 'Kec. Lemong', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120412', 3, 'ID', 'Kec. Waytenong', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120413', 3, 'ID', 'Kec. Sukau', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120414', 3, 'ID', 'Kec. Suoh', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120415', 3, 'ID', 'Kec. Gedung Surian', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120416', 3, 'ID', 'Kec. Bengkunat Belimbing', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120417', 3, 'ID', 'Kec. Ngambur', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120490', 3, 'ID', 'Pagar Dewa', '      ');
INSERT INTO siakad.master_wilayah VALUES ('120491', 3, 'ID', 'Lumbok Seminung', '      ');
INSERT INTO siakad.master_wilayah VALUES ('120500', 2, 'ID', 'Kab. Tulang Bawang', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120503', 3, 'ID', 'Kec. Banjar Agung', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120504', 3, 'ID', 'Kec. Gedung Aji', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120505', 3, 'ID', 'Kec. Manggala', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120509', 3, 'ID', 'Kec. Penawartama', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120513', 3, 'ID', 'Kec. Rawajitu Selatan', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120514', 3, 'ID', 'Kec. Gedung Meneng', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120519', 3, 'ID', 'Kec. Banjar Margo', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120520', 3, 'ID', 'Kec. Penawar Aji', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120521', 3, 'ID', 'Kec. Rawa Pitu', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120522', 3, 'ID', 'Kec. Rawajitu Timur', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120525', 3, 'ID', 'Kec. Meraksa Aji', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120526', 3, 'ID', 'Kec. Gedung AJI Baru', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120527', 3, 'ID', 'Kec. Dente Teladas', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120528', 3, 'ID', 'Kec. Banjar Baru', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120529', 3, 'ID', 'Kec. Menggala Timur', '120500');
INSERT INTO siakad.master_wilayah VALUES ('120590', 3, 'ID', 'Menggala', '      ');
INSERT INTO siakad.master_wilayah VALUES ('120600', 2, 'ID', 'Kab. Tenggamus', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120601', 3, 'ID', 'Kec. Wonosobo', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120602', 3, 'ID', 'Kec. Kota Agung', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120603', 3, 'ID', 'Kec. Pulau Panggung', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120604', 3, 'ID', 'Kec. Talang Padang', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120605', 3, 'ID', 'Kec. Pugung', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120611', 3, 'ID', 'Kec. Cukuh Balak', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120612', 3, 'ID', 'Kec. Pematang Sawa', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120613', 3, 'ID', 'Kec. Sumberejo', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120614', 3, 'ID', 'Kec. Semaka', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120615', 3, 'ID', 'Kec. Ulu Belu', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120617', 3, 'ID', 'Kec. Kelumbayan', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120618', 3, 'ID', 'Kota Agung Barat', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120619', 3, 'ID', 'Kota Agung Timur', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120620', 3, 'ID', 'Kec. Gisting', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120621', 3, 'ID', 'Kec. Gunung Alip', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120624', 3, 'ID', 'Kec. Limau', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120625', 3, 'ID', 'Kec. Bandar Negeri Semuong', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120626', 3, 'ID', 'Kec. Air Naningan', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120627', 3, 'ID', 'Kec. Bulok', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120628', 3, 'ID', 'Kec. Kelumbayan Barat', '120600');
INSERT INTO siakad.master_wilayah VALUES ('120700', 2, 'ID', 'Kab. Lampung Timur', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120701', 3, 'ID', 'Kec. Metro Kibang', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120702', 3, 'ID', 'Kec. Batanghari', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120703', 3, 'ID', 'Kec. Sekampung', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120704', 3, 'ID', 'Kec. Margatiga', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120705', 3, 'ID', 'Kec. Sekampung Udik', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120706', 3, 'ID', 'Kec. Jabung', '120700');
INSERT INTO siakad.master_wilayah VALUES ('130300', 2, 'ID', 'Kab. Sanggau', '130000');
INSERT INTO siakad.master_wilayah VALUES ('120707', 3, 'ID', 'Kec. Labuhan Maringgai', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120708', 3, 'ID', 'Kec. Way Jepara', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120709', 3, 'ID', 'Kec. Sukadana', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120710', 3, 'ID', 'Kec. Pekalongan', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120711', 3, 'ID', 'Kec. Raman Utara', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120712', 3, 'ID', 'Kec. Purbolinggo', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120713', 3, 'ID', 'Kec. Bumi Agung', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120716', 3, 'ID', 'Kec. Braja Slebah', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120717', 3, 'ID', 'Kec. Bandar Sribawono', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120718', 3, 'ID', 'Kec. Mataram Baru', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120719', 3, 'ID', 'Kec. Melinting', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120720', 3, 'ID', 'Kec. Gunung Pelindung', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120721', 3, 'ID', 'Kec. Waway Karya', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120722', 3, 'ID', 'Kec. Pasir Sakti', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120723', 3, 'ID', 'Kec. Labuhan Ratu', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120724', 3, 'ID', 'Kec. Batanghari Nuban', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120725', 3, 'ID', 'Kec. Way Bungur', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120726', 3, 'ID', 'Kec. Marga Sekampung', '120700');
INSERT INTO siakad.master_wilayah VALUES ('120800', 2, 'ID', 'Kab. Way Kanan', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120801', 3, 'ID', 'Kec. Banjit', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120802', 3, 'ID', 'Kec. Baradatu', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120803', 3, 'ID', 'Kec. Kasui', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120804', 3, 'ID', 'Kec. Blambangan Umpu', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120805', 3, 'ID', 'Kec. Bahuga', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120806', 3, 'ID', 'Kec. Pakuan Ratu', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120807', 3, 'ID', 'Kec. Gunung Labuhan', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120808', 3, 'ID', 'Kec. Rebang Tangkas', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120809', 3, 'ID', 'Kec. Way Tuba', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120810', 3, 'ID', 'Kec. Negeri Agung', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120811', 3, 'ID', 'Kec. Negara Batin', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120812', 3, 'ID', 'Kec. Negeri Besar', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120813', 3, 'ID', 'Kec. Buay Bahuga', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120814', 3, 'ID', 'Kec. Bumi Agung', '120800');
INSERT INTO siakad.master_wilayah VALUES ('120900', 2, 'ID', 'Kab. Pasawaran', '120000');
INSERT INTO siakad.master_wilayah VALUES ('120901', 3, 'ID', 'Kec. Padang Cermin', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120902', 3, 'ID', 'Kec. Punduh Pedada', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120903', 3, 'ID', 'Kec. Kedondong', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120904', 3, 'ID', 'Kec. Way Lima', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120905', 3, 'ID', 'Kec. Gedung Tataan', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120906', 3, 'ID', 'Kec. Negeri Katon', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120907', 3, 'ID', 'Kec. Tegineneng', '120900');
INSERT INTO siakad.master_wilayah VALUES ('121000', 2, 'ID', 'Kab. Tulang Bawang Barat', '120000');
INSERT INTO siakad.master_wilayah VALUES ('121001', 3, 'ID', 'Kec. Pagelaran', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121002', 3, 'ID', 'Kec. Sukoharjo', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121003', 3, 'ID', 'Kec. Adiluwih', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121004', 3, 'ID', 'Kec. Banyumas', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121005', 3, 'ID', 'Kec. Pringsewu', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121006', 3, 'ID', 'Kec. Ambarawa', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121007', 3, 'ID', 'Kec. Gadingrejo', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121008', 3, 'ID', 'Kec. Pardasuka', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121100', 2, 'ID', 'Kab. Mesuji', '120000');
INSERT INTO siakad.master_wilayah VALUES ('121101', 3, 'ID', 'Kec. Mesuji', '121100');
INSERT INTO siakad.master_wilayah VALUES ('121102', 3, 'ID', 'Kec. Tanjung Raya', '121100');
INSERT INTO siakad.master_wilayah VALUES ('121103', 3, 'ID', 'Kec. Rawajitu Utara', '121100');
INSERT INTO siakad.master_wilayah VALUES ('121104', 3, 'ID', 'Kec. Mesuji Timur', '121100');
INSERT INTO siakad.master_wilayah VALUES ('121105', 3, 'ID', 'Kec. Simpang Pematang', '121100');
INSERT INTO siakad.master_wilayah VALUES ('121106', 3, 'ID', 'Kec. Way Serdang', '121100');
INSERT INTO siakad.master_wilayah VALUES ('121107', 3, 'ID', 'Kec. Panca Jaya', '121100');
INSERT INTO siakad.master_wilayah VALUES ('121200', 2, 'ID', 'Kab. Pringsewu', '120000');
INSERT INTO siakad.master_wilayah VALUES ('121201', 3, 'ID', 'Kec. Tulang Bawang Udik', '121200');
INSERT INTO siakad.master_wilayah VALUES ('121202', 3, 'ID', 'Kec. Tumijajar', '121200');
INSERT INTO siakad.master_wilayah VALUES ('121203', 3, 'ID', 'Kec. Tulang Bawang Tengah', '121200');
INSERT INTO siakad.master_wilayah VALUES ('121204', 3, 'ID', 'Kec. Lambu Kibang', '121200');
INSERT INTO siakad.master_wilayah VALUES ('121205', 3, 'ID', 'Kec. Pagar Dewa', '121200');
INSERT INTO siakad.master_wilayah VALUES ('121206', 3, 'ID', 'Kec. Way Kenanga', '121200');
INSERT INTO siakad.master_wilayah VALUES ('121207', 3, 'ID', 'Kec. Gunung Terang', '121200');
INSERT INTO siakad.master_wilayah VALUES ('121208', 3, 'ID', 'Kec. Gunung Agung', '121200');
INSERT INTO siakad.master_wilayah VALUES ('126000', 2, 'ID', 'Kota Bandar Lampung', '120000');
INSERT INTO siakad.master_wilayah VALUES ('126001', 3, 'ID', 'Kec. Teluk Betung Barat', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126002', 3, 'ID', 'Kec. Teluk Betung Selatan', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126003', 3, 'ID', 'Kec. Panjang', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126004', 3, 'ID', 'Kec. Tanjung Karang Timur', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126005', 3, 'ID', 'Kec. Teluk Betung Utara', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126006', 3, 'ID', 'Kec. Tanjung Karang Pusat', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126007', 3, 'ID', 'Kec. Tanjung Karang Barat', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126008', 3, 'ID', 'Kec. Kedaton', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126009', 3, 'ID', 'Kec. Sukarame', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126010', 3, 'ID', 'Kec. Kemiling', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126011', 3, 'ID', 'Kec. Rajabasa', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126012', 3, 'ID', 'Kec. Tanjung Senang', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126013', 3, 'ID', 'Kec. Sukabumi', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126100', 2, 'ID', 'Kota Metro', '120000');
INSERT INTO siakad.master_wilayah VALUES ('126101', 3, 'ID', 'Kec. Metro Pusat', '126100');
INSERT INTO siakad.master_wilayah VALUES ('126102', 3, 'ID', 'Kec. Metro Utara', '126100');
INSERT INTO siakad.master_wilayah VALUES ('126103', 3, 'ID', 'Kec. Metro Barat', '126100');
INSERT INTO siakad.master_wilayah VALUES ('126104', 3, 'ID', 'Kec. Metro Timur', '126100');
INSERT INTO siakad.master_wilayah VALUES ('126105', 3, 'ID', 'Kec. Metro Selatan', '126100');
INSERT INTO siakad.master_wilayah VALUES ('130000', 1, 'ID', 'Prov. Kalimantan Barat', '000000');
INSERT INTO siakad.master_wilayah VALUES ('130100', 2, 'ID', 'Kab. Sambas', '130000');
INSERT INTO siakad.master_wilayah VALUES ('130101', 3, 'ID', 'Kec. Selakau', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130102', 3, 'ID', 'Kec. Pemangkat', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130103', 3, 'ID', 'Kec. Tebas', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130104', 3, 'ID', 'Kec. Sambas', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130105', 3, 'ID', 'Kec. Jawai', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130106', 3, 'ID', 'Kec. Teluk Keramat', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130107', 3, 'ID', 'Kec. Sejangkung', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130108', 3, 'ID', 'Kec. Sajingan Besar', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130109', 3, 'ID', 'Kec. Paloh', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130110', 3, 'ID', 'Kec. Subah', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130111', 3, 'ID', 'Kec. Galing', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130112', 3, 'ID', 'Kec. Semparuk', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130113', 3, 'ID', 'Kec. Tekarang', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130114', 3, 'ID', 'Kec. Sajad', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130115', 3, 'ID', 'Kec. Sebawi', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130116', 3, 'ID', 'Kec. Jawai Selatan', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130117', 3, 'ID', 'Kec. Tangaran', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130118', 3, 'ID', 'Kec. Selakau Tua', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130119', 3, 'ID', 'Kec. Salatiga', '130100');
INSERT INTO siakad.master_wilayah VALUES ('130190', 3, 'ID', 'Selakau Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('130200', 2, 'ID', 'Kab. Pontianak', '130000');
INSERT INTO siakad.master_wilayah VALUES ('130208', 3, 'ID', 'Kec. Siantan', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130209', 3, 'ID', 'Kec. Sungai Pinyuh', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130210', 3, 'ID', 'Kec. Mempawah Hilir', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130211', 3, 'ID', 'Kec. Sungai Kunyit', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130212', 3, 'ID', 'Kec. Toho', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130216', 3, 'ID', 'Kec. Segedong', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130217', 3, 'ID', 'Kec. Anjongan', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130218', 3, 'ID', 'Kec. Sadaniang', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130219', 3, 'ID', 'Kec. Mempawah Timur', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130220', 3, 'ID', 'Kec. Ambawang', '130200');
INSERT INTO siakad.master_wilayah VALUES ('130301', 3, 'ID', 'Kec. Toba', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130306', 3, 'ID', 'Kec. Sanggau Kapuas', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130307', 3, 'ID', 'Kec. Mokok', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130312', 3, 'ID', 'Kec. Jangkang', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130313', 3, 'ID', 'Kec. Bonti', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130314', 3, 'ID', 'Kec. Parindu', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130315', 3, 'ID', 'Kec. Tayan Hilir', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130316', 3, 'ID', 'Kec. Balai', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130317', 3, 'ID', 'Kec. Tayan Hulu', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130318', 3, 'ID', 'Kec. Kembayan', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130319', 3, 'ID', 'Kec. Beduwai', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130320', 3, 'ID', 'Kec. Noyan', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130321', 3, 'ID', 'Kec. Sekayan', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130322', 3, 'ID', 'Kec. Entikong', '130300');
INSERT INTO siakad.master_wilayah VALUES ('130323', 3, 'ID', 'Meliau', '      ');
INSERT INTO siakad.master_wilayah VALUES ('130324', 3, 'ID', 'Kapuas', '      ');
INSERT INTO siakad.master_wilayah VALUES ('130400', 2, 'ID', 'Kab. Sintang', '130000');
INSERT INTO siakad.master_wilayah VALUES ('130406', 3, 'ID', 'Kec. Nanga Serawai', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130407', 3, 'ID', 'Kec. Ambalau', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130408', 3, 'ID', 'Kec. Kayan Hulu', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130411', 3, 'ID', 'Kec. Sepauk', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130412', 3, 'ID', 'Kec. Tempunak', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130413', 3, 'ID', 'Kec. Sungai Tebelian', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130414', 3, 'ID', 'Kec. Sintang', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130415', 3, 'ID', 'Kec. Dedai', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130416', 3, 'ID', 'Kec. Kayan Hilir', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130417', 3, 'ID', 'Kec. Kelam Permai', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130418', 3, 'ID', 'Kec. Binjai Hulu', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130419', 3, 'ID', 'Kec. Ketungau Hilir', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130420', 3, 'ID', 'Kec. Ketungau Tengah', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130421', 3, 'ID', 'Kec. Ketungau Hulu', '130400');
INSERT INTO siakad.master_wilayah VALUES ('130500', 2, 'ID', 'Kab. Kapuas Hulu', '130000');
INSERT INTO siakad.master_wilayah VALUES ('130501', 3, 'ID', 'Kec. Silat Hilir', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130502', 3, 'ID', 'Kec. Silat Hulu', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130503', 3, 'ID', 'Kec. Hulu Gurung', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130504', 3, 'ID', 'Kec. Bunut Hulu', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130505', 3, 'ID', 'Kec. Mentebah', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130507', 3, 'ID', 'Kec. Kalis', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130509', 3, 'ID', 'Kec. Embaloh Hilir', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130510', 3, 'ID', 'Kec. Bunut Hilir', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130511', 3, 'ID', 'Kec. Boyan Tanjung', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130514', 3, 'ID', 'Kec. Selimbau', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130515', 3, 'ID', 'Kec. Suhaid', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130516', 3, 'ID', 'Kec. Seberuang', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130517', 3, 'ID', 'Kec. Semitau', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130518', 3, 'ID', 'Kec. Empanang', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130519', 3, 'ID', 'Kec. Puring Kencana', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130520', 3, 'ID', 'Kec. Badau', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130521', 3, 'ID', 'Kec. Batang Lupar', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130522', 3, 'ID', 'Kec. Embaloh Hulu', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130524', 3, 'ID', 'Kec. Hulu Kapuas', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130526', 3, 'ID', 'Kec. Putussibau Utara', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130527', 3, 'ID', 'Kec. Bika', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130528', 3, 'ID', 'Kec. Jongkong', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130529', 3, 'ID', 'Kec. Putussibau Selatan', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130530', 3, 'ID', 'Kec. Pengkadan', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130531', 3, 'ID', 'Kec. Danau Setarum', '130500');
INSERT INTO siakad.master_wilayah VALUES ('130600', 2, 'ID', 'Kab. Ketapang', '130000');
INSERT INTO siakad.master_wilayah VALUES ('130601', 3, 'ID', 'Kec. Kendawangan', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130602', 3, 'ID', 'Kec. Manis Mata', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130603', 3, 'ID', 'Kec. Marau', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130604', 3, 'ID', 'Kec. Jelai Hulu', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130605', 3, 'ID', 'Kec. Tumbang Titi', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130606', 3, 'ID', 'Kec. Matan Hilir Selatan', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130607', 3, 'ID', 'Kec. Matan Hilir Utara', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130609', 3, 'ID', 'Kec. Nanga Tayap', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130610', 3, 'ID', 'Kec. Sandai', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130611', 3, 'ID', 'Kec. Sungai Laur', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130612', 3, 'ID', 'Kec. Simpang Hulu', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130618', 3, 'ID', 'Kec. Muara Pawan', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130619', 3, 'ID', 'Kec. Delta Pawan', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130620', 3, 'ID', 'Kec. Simpang Dua', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130621', 3, 'ID', 'Kec. Benua Kayong', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130622', 3, 'ID', 'Kec. Hulu Sungai', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130623', 3, 'ID', 'Kec. Air Upas', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130624', 3, 'ID', 'Kec. Singkup', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130625', 3, 'ID', 'Kec. Pemahan', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130626', 3, 'ID', 'Kec. Sungai Melayu Rayek', '130600');
INSERT INTO siakad.master_wilayah VALUES ('130800', 2, 'ID', 'Kab. Bengkayang', '130000');
INSERT INTO siakad.master_wilayah VALUES ('130801', 3, 'ID', 'Kec. Sungai Raya', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130802', 3, 'ID', 'Kec. Capkala', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130803', 3, 'ID', 'Kec. Samalantan', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130804', 3, 'ID', 'Kec. Bengkayang', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130805', 3, 'ID', 'Kec. Ledo', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130806', 3, 'ID', 'Kec. Sanggau Ledo', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130807', 3, 'ID', 'Kec. Seluas', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130808', 3, 'ID', 'Kec. Jagoi Babang', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130809', 3, 'ID', 'Kec. Teriak', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130810', 3, 'ID', 'Kec. Monterado', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130811', 3, 'ID', 'Kec. Suti Semarang', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130812', 3, 'ID', 'Kec. Siding', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130813', 3, 'ID', 'Kec. Lumar', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130814', 3, 'ID', 'Kec. Sungai Betung', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130815', 3, 'ID', 'Kec. Sungai Raya Kepulauan', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130816', 3, 'ID', 'Kec. Lembah Bawang', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130817', 3, 'ID', 'Kec. Tujuh Belas', '130800');
INSERT INTO siakad.master_wilayah VALUES ('130900', 2, 'ID', 'Kab. Landak', '130000');
INSERT INTO siakad.master_wilayah VALUES ('130902', 3, 'ID', 'Kec. Sebangki', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130903', 3, 'ID', 'Kec. Ngabang', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130904', 3, 'ID', 'Kec. Sengah Temila', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130905', 3, 'ID', 'Kec. Mandor', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130906', 3, 'ID', 'Kec. Menjalin', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130907', 3, 'ID', 'Kec. Mempawah Hulu', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130908', 3, 'ID', 'Kec. Menyuke', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130909', 3, 'ID', 'Kec. Meranti', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130910', 3, 'ID', 'Kec. Kuala Behe', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130911', 3, 'ID', 'Kec. Air Besar', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130912', 3, 'ID', 'Kec. Jelimpo', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130913', 3, 'ID', 'Kec. Sompak', '130900');
INSERT INTO siakad.master_wilayah VALUES ('130914', 3, 'ID', 'Kec. Banyuke Hulu', '130900');
INSERT INTO siakad.master_wilayah VALUES ('131000', 2, 'ID', 'Kab. Sekadau', '130000');
INSERT INTO siakad.master_wilayah VALUES ('131001', 3, 'ID', 'Kec. Nanga Mahap', '131000');
INSERT INTO siakad.master_wilayah VALUES ('131002', 3, 'ID', 'Kec. Nanga Taman', '131000');
INSERT INTO siakad.master_wilayah VALUES ('131003', 3, 'ID', 'Kec. Sekadau Hulu', '131000');
INSERT INTO siakad.master_wilayah VALUES ('131004', 3, 'ID', 'Kec. Sekadau Hilir', '131000');
INSERT INTO siakad.master_wilayah VALUES ('131005', 3, 'ID', 'Kec. Belitang', '131000');
INSERT INTO siakad.master_wilayah VALUES ('131006', 3, 'ID', 'Kec. Belitang Hilir', '131000');
INSERT INTO siakad.master_wilayah VALUES ('131007', 3, 'ID', 'Kec. Belitang Hulu', '131000');
INSERT INTO siakad.master_wilayah VALUES ('131100', 2, 'ID', 'Kab. Melawi', '130000');
INSERT INTO siakad.master_wilayah VALUES ('131101', 3, 'ID', 'Kec. Sokan', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131102', 3, 'ID', 'Kec. Tanah Pinoh', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131103', 3, 'ID', 'Kec. Sayan', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131104', 3, 'ID', 'Kec. Ella Hilir', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131105', 3, 'ID', 'Kec. Menukung', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131108', 3, 'ID', 'Kec. Nanga Pinoh', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131109', 3, 'ID', 'Kec. Belimbing', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131110', 3, 'ID', 'Kec. Tanah Pinoh Barat', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131111', 3, 'ID', 'Kec. Belimbing Hulu', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131112', 3, 'ID', 'Kec. Pinoh Selatan', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131113', 3, 'ID', 'Kec. Pinoh Utara', '131100');
INSERT INTO siakad.master_wilayah VALUES ('131200', 2, 'ID', 'Kab. Kayong Utara', '130000');
INSERT INTO siakad.master_wilayah VALUES ('131201', 3, 'ID', 'Kec. Pulau Maya Karimata', '131200');
INSERT INTO siakad.master_wilayah VALUES ('131202', 3, 'ID', 'Kec. Simpang Hilir', '131200');
INSERT INTO siakad.master_wilayah VALUES ('131203', 3, 'ID', 'Kec. Sukadana', '131200');
INSERT INTO siakad.master_wilayah VALUES ('131204', 3, 'ID', 'Kec. Teluk Batang', '131200');
INSERT INTO siakad.master_wilayah VALUES ('131205', 3, 'ID', 'Kec. Seponti', '131200');
INSERT INTO siakad.master_wilayah VALUES ('131300', 2, 'ID', 'Kab. Kuburaya', '130000');
INSERT INTO siakad.master_wilayah VALUES ('131302', 3, 'ID', 'Kec. Kuala Mandor B', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131304', 3, 'ID', 'Kec. Sungai Ambawang', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131305', 3, 'ID', 'Kec. Sungai Kakap', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131308', 3, 'ID', 'Kec. Telok Pakedai', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131309', 3, 'ID', 'Kec. Terentang', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131310', 3, 'ID', 'Kec. Sungai Raya', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131311', 3, 'ID', 'Kec. Batu Ampar', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131312', 3, 'ID', 'Kec. Kubu', '131300');
INSERT INTO siakad.master_wilayah VALUES ('131313', 3, 'ID', 'Kec. Rasau Jaya', '131300');
INSERT INTO siakad.master_wilayah VALUES ('136000', 2, 'ID', 'Kota Pontianak', '130000');
INSERT INTO siakad.master_wilayah VALUES ('136001', 3, 'ID', 'Kec. Pontianak Selatan', '136000');
INSERT INTO siakad.master_wilayah VALUES ('136002', 3, 'ID', 'Kec. Pontianak Timur', '136000');
INSERT INTO siakad.master_wilayah VALUES ('136003', 3, 'ID', 'Kec. Pontianak Barat', '136000');
INSERT INTO siakad.master_wilayah VALUES ('136004', 3, 'ID', 'Kec. Pontianak Utara', '136000');
INSERT INTO siakad.master_wilayah VALUES ('136005', 3, 'ID', 'Kec. Pontianak Kota', '136000');
INSERT INTO siakad.master_wilayah VALUES ('136006', 3, 'ID', 'Kec. Pontianak Tenggara', '136000');
INSERT INTO siakad.master_wilayah VALUES ('136100', 2, 'ID', 'Kota Singkawang', '130000');
INSERT INTO siakad.master_wilayah VALUES ('136101', 3, 'ID', 'Kec. Singkawang Selatan', '136100');
INSERT INTO siakad.master_wilayah VALUES ('136102', 3, 'ID', 'Kec. Singkawang Timur', '136100');
INSERT INTO siakad.master_wilayah VALUES ('136103', 3, 'ID', 'Kec. Singkawang Utara', '136100');
INSERT INTO siakad.master_wilayah VALUES ('136104', 3, 'ID', 'Kec. Singkawang Barat', '136100');
INSERT INTO siakad.master_wilayah VALUES ('136105', 3, 'ID', 'Kec. Singkawang Tengah', '136100');
INSERT INTO siakad.master_wilayah VALUES ('140000', 1, 'ID', 'Prov. Kalimantan Tengah', '000000');
INSERT INTO siakad.master_wilayah VALUES ('140100', 2, 'ID', 'Kab. Kapuas', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140102', 3, 'ID', 'Kec. Kapuas Kuala', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140103', 3, 'ID', 'Kec. Kapuas Timur', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140104', 3, 'ID', 'Kec. Selat', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140107', 3, 'ID', 'Kec. Basarang', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140108', 3, 'ID', 'Kec. Kapuas Hilir', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140109', 3, 'ID', 'Kec. Pulau Petak', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140110', 3, 'ID', 'Kec. Kapuas Murung', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140111', 3, 'ID', 'Kec. Kapuas Barat', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140115', 3, 'ID', 'Kec. Mantangai', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140116', 3, 'ID', 'Kec. Timpah', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140117', 3, 'ID', 'Kec. Kapuas Tengah', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140118', 3, 'ID', 'Kec. Kapuas Hulu', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140200', 2, 'ID', 'Kab. Barito Selatan', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140201', 3, 'ID', 'Kec. Dusun Hilir', '140200');
INSERT INTO siakad.master_wilayah VALUES ('140202', 3, 'ID', 'Kec. Jenamas', '140200');
INSERT INTO siakad.master_wilayah VALUES ('140209', 3, 'ID', 'Kec. Karau Kuala', '140200');
INSERT INTO siakad.master_wilayah VALUES ('140210', 3, 'ID', 'Kec. Dusun Selatan', '140200');
INSERT INTO siakad.master_wilayah VALUES ('140211', 3, 'ID', 'Kec. Dusun Utara', '140200');
INSERT INTO siakad.master_wilayah VALUES ('140212', 3, 'ID', 'Kec. Gunung Bintang Awai', '140200');
INSERT INTO siakad.master_wilayah VALUES ('140300', 2, 'ID', 'Kab. Barito Utara', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140301', 3, 'ID', 'Kec. Montallat', '140300');
INSERT INTO siakad.master_wilayah VALUES ('140302', 3, 'ID', 'Kec. Gunung Timang', '140300');
INSERT INTO siakad.master_wilayah VALUES ('140303', 3, 'ID', 'Kec. Gunung Purei', '140300');
INSERT INTO siakad.master_wilayah VALUES ('140304', 3, 'ID', 'Kec. Teweh Timur', '140300');
INSERT INTO siakad.master_wilayah VALUES ('140305', 3, 'ID', 'Kec. Teweh Tengah', '140300');
INSERT INTO siakad.master_wilayah VALUES ('140306', 3, 'ID', 'Kec. Lahei', '140300');
INSERT INTO siakad.master_wilayah VALUES ('140307', 3, 'ID', 'Teweh Baru', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140308', 3, 'ID', 'Teweh Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140309', 3, 'ID', 'Lahei Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140400', 2, 'ID', 'Kab. Kotawaringin Timur', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140402', 3, 'ID', 'Kec. Mentaya Hilir Selatan', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140405', 3, 'ID', 'Kec. Pulau Hanaut', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140406', 3, 'ID', 'Kec. Mentawa Baru/Ketapang', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140407', 3, 'ID', 'Kec. Mentaya Hilir Utara', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140411', 3, 'ID', 'Kec. Kota Besi', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140412', 3, 'ID', 'Kec. Baamang', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140419', 3, 'ID', 'Kec. Cempaga', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140420', 3, 'ID', 'Kec. Parenggean', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140421', 3, 'ID', 'Kec. Mentaya Hulu', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140423', 3, 'ID', 'Kec. Antang Kalang', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140425', 3, 'ID', 'Kec. Teluk Sampit', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140426', 3, 'ID', 'Kec. Seranau', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140427', 3, 'ID', 'Kec. Cempaga Hulu', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140428', 3, 'ID', 'Kec. Bukit Santuei', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140429', 3, 'ID', 'Kec. Telawang', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140430', 3, 'ID', 'Kec. Tualan Hulu', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140431', 3, 'ID', 'Kec. Telaga Antang', '140400');
INSERT INTO siakad.master_wilayah VALUES ('140432', 3, 'ID', 'Tualan Hulu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140433', 3, 'ID', 'Telaga Antang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140500', 2, 'ID', 'Kab. Kotawaringin Barat', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140504', 3, 'ID', 'Kec. Kotawaringin Lama', '140500');
INSERT INTO siakad.master_wilayah VALUES ('140505', 3, 'ID', 'Kec. Arut Selatan', '140500');
INSERT INTO siakad.master_wilayah VALUES ('140506', 3, 'ID', 'Kec. Kumai', '140500');
INSERT INTO siakad.master_wilayah VALUES ('140507', 3, 'ID', 'Kec. Arut Utara', '140500');
INSERT INTO siakad.master_wilayah VALUES ('140508', 3, 'ID', 'Kec. Pangkalan Banteng', '140500');
INSERT INTO siakad.master_wilayah VALUES ('140509', 3, 'ID', 'Kec. Pangkalan Lada', '140500');
INSERT INTO siakad.master_wilayah VALUES ('140600', 2, 'ID', 'Kab. Katingan', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140601', 3, 'ID', 'Kec. Katingan Kuala', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140602', 3, 'ID', 'Kec. Mendawai', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140603', 3, 'ID', 'Kec. Kampiang', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140604', 3, 'ID', 'Kec. Tasik Payawan', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140605', 3, 'ID', 'Kec. Katingan Hilir', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140606', 3, 'ID', 'Kec. Tewang Sangalang Garing', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140607', 3, 'ID', 'Kec. Pulau Malan', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140608', 3, 'ID', 'Kec. Katingan Tengah', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140609', 3, 'ID', 'Kec. Katingan Hulu', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140610', 3, 'ID', 'Kec. Marikit', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140611', 3, 'ID', 'Kec. Sanaman Mantikei', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140612', 3, 'ID', 'Kec. Petak Malai', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140613', 3, 'ID', 'Kec. Bukit Raya', '140600');
INSERT INTO siakad.master_wilayah VALUES ('140700', 2, 'ID', 'Kab. Seruyan', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140701', 3, 'ID', 'Kec. Seruyan Hilir', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140702', 3, 'ID', 'Kec. Danau Sembuluh', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140703', 3, 'ID', 'Kec. Hanau', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140704', 3, 'ID', 'Kec. Seruyan Tengah', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140705', 3, 'ID', 'Kec. Seruyan Hulu', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140706', 3, 'ID', 'Kec. Seruyan Hilir Timur', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140707', 3, 'ID', 'Kec. Seruyan Raya', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140708', 3, 'ID', 'Kec. Danau Seluluk', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140709', 3, 'ID', 'Kec. Batu Ampar', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140710', 3, 'ID', 'Kec. Suling Tambun', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140711', 3, 'ID', 'Kec. Sembuluh Raya', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140712', 3, 'ID', 'Kec. Natai Kelampai', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140713', 3, 'ID', 'Kec. Sepan Biha', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140714', 3, 'ID', 'Kec. Seruyan Hulu Utara', '140700');
INSERT INTO siakad.master_wilayah VALUES ('140790', 3, 'ID', 'Natai Kelampai', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140791', 3, 'ID', 'Sepan Biha', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140792', 3, 'ID', 'Seruyan Hulu Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140799', 3, 'ID', 'Sembuluh Raya', '      ');
INSERT INTO siakad.master_wilayah VALUES ('140800', 2, 'ID', 'Kab. Sukamara', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140801', 3, 'ID', 'Kec. Jelai', '140800');
INSERT INTO siakad.master_wilayah VALUES ('140802', 3, 'ID', 'Kec. Sukamara', '140800');
INSERT INTO siakad.master_wilayah VALUES ('140803', 3, 'ID', 'Kec. Balai Riam', '140800');
INSERT INTO siakad.master_wilayah VALUES ('140804', 3, 'ID', 'Kec. Pantai Lunci', '140800');
INSERT INTO siakad.master_wilayah VALUES ('140805', 3, 'ID', 'Kec. Permata Kecubung', '140800');
INSERT INTO siakad.master_wilayah VALUES ('140900', 2, 'ID', 'Kab. Lamandau', '140000');
INSERT INTO siakad.master_wilayah VALUES ('140901', 3, 'ID', 'Kec. Bulik', '140900');
INSERT INTO siakad.master_wilayah VALUES ('140902', 3, 'ID', 'Kec. Lamandau', '140900');
INSERT INTO siakad.master_wilayah VALUES ('140903', 3, 'ID', 'Kec. Delang', '140900');
INSERT INTO siakad.master_wilayah VALUES ('140904', 3, 'ID', 'Kec. Bulik Timur', '140900');
INSERT INTO siakad.master_wilayah VALUES ('140905', 3, 'ID', 'Kec. Mentobi Raya', '140900');
INSERT INTO siakad.master_wilayah VALUES ('140906', 3, 'ID', 'Kec. Sematu Jaya', '140900');
INSERT INTO siakad.master_wilayah VALUES ('140907', 3, 'ID', 'Kec. Belantikan Raya', '140900');
INSERT INTO siakad.master_wilayah VALUES ('140908', 3, 'ID', 'Kec. Batang Kawa', '140900');
INSERT INTO siakad.master_wilayah VALUES ('141000', 2, 'ID', 'Kab. Gunung Mas', '140000');
INSERT INTO siakad.master_wilayah VALUES ('141001', 3, 'ID', 'Kec. Tewah', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141002', 3, 'ID', 'Kec. Kurun', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141003', 3, 'ID', 'Kec. Sepang Simin', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141004', 3, 'ID', 'Kec. Rungan', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141005', 3, 'ID', 'Kec. Manuhing', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141006', 3, 'ID', 'Kec. Kahayan Hulu Utara', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141007', 3, 'ID', 'Kec. Mihing Raya', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141008', 3, 'ID', 'Kec. Damang Batu', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141009', 3, 'ID', 'Kec. Miri Manasa', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141010', 3, 'ID', 'Kec. Rungan Hulu', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141011', 3, 'ID', 'Kec. Manuhing Raya', '141000');
INSERT INTO siakad.master_wilayah VALUES ('141100', 2, 'ID', 'Kab. Pulang Pisau', '140000');
INSERT INTO siakad.master_wilayah VALUES ('141101', 3, 'ID', 'Kec. Kahayan Kuala', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141102', 3, 'ID', 'Kec. Pandih Batu', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141103', 3, 'ID', 'Kec. Maliku', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141104', 3, 'ID', 'Kec. Kahayan Hilir', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141105', 3, 'ID', 'Kec. Kahayan Tengah', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141106', 3, 'ID', 'Kec. Banama Tingan', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141107', 3, 'ID', 'Kec. Sebangau Kuala', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141108', 3, 'ID', 'Kec. Jabiren Raya', '141100');
INSERT INTO siakad.master_wilayah VALUES ('141200', 2, 'ID', 'Kab. Murung Raya', '140000');
INSERT INTO siakad.master_wilayah VALUES ('141201', 3, 'ID', 'Kec. Laung Tuhup', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141202', 3, 'ID', 'Kec. Murung', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141203', 3, 'ID', 'Kec. Permata Intan', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141204', 3, 'ID', 'Kec. Tanah Siang', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141205', 3, 'ID', 'Kec. Sumber Barito', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141206', 3, 'ID', 'Kec. Barito Tuhup Raya', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141207', 3, 'ID', 'Kec. Tanah Siang Selatan', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141208', 3, 'ID', 'Kec. Sungai Babuat', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141209', 3, 'ID', 'Kec. Seribu Riam', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141210', 3, 'ID', 'Kec. Uut Murung', '141200');
INSERT INTO siakad.master_wilayah VALUES ('141300', 2, 'ID', 'Kab. Barito Timur', '140000');
INSERT INTO siakad.master_wilayah VALUES ('141301', 3, 'ID', 'Kec. Dusun Timur', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141302', 3, 'ID', 'Kec. Benua Lima', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141303', 3, 'ID', 'Kec. Patangkep Tutui', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141304', 3, 'ID', 'Kec. Awang', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141305', 3, 'ID', 'Kec. Dusun Tengah', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141306', 3, 'ID', 'Kec. Pematang Karau', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141307', 3, 'ID', 'Kec. Paju Epat', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141308', 3, 'ID', 'Kec. Reren Batuah', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141309', 3, 'ID', 'Kec. Paku', '141300');
INSERT INTO siakad.master_wilayah VALUES ('141310', 3, 'ID', 'Kec. Karusen Janang', '141300');
INSERT INTO siakad.master_wilayah VALUES ('146000', 2, 'ID', 'Kota Palangka Raya', '140000');
INSERT INTO siakad.master_wilayah VALUES ('146001', 3, 'ID', 'Kec. Pahandut', '146000');
INSERT INTO siakad.master_wilayah VALUES ('146002', 3, 'ID', 'Kec. Bukit Batu', '146000');
INSERT INTO siakad.master_wilayah VALUES ('146003', 3, 'ID', 'Kec. Sabangau', '146000');
INSERT INTO siakad.master_wilayah VALUES ('146004', 3, 'ID', 'Kec. Jekan Raya', '146000');
INSERT INTO siakad.master_wilayah VALUES ('146005', 3, 'ID', 'Kec. Rakumpit', '146000');
INSERT INTO siakad.master_wilayah VALUES ('150000', 1, 'ID', 'Prov. Kalimantan Selatan', '000000');
INSERT INTO siakad.master_wilayah VALUES ('150100', 2, 'ID', 'Kab. Banjar', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150101', 3, 'ID', 'Kec. Aluh-Aluh', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150102', 3, 'ID', 'Kec. Gambut', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150103', 3, 'ID', 'Kec. Kertak Hanyar', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150104', 3, 'ID', 'Kec. Sungai Tabuk', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150105', 3, 'ID', 'Kec. Martapura', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150106', 3, 'ID', 'Kec. Astambul', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150107', 3, 'ID', 'Kec. Karang Intan', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150108', 3, 'ID', 'Kec. Aranio', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150109', 3, 'ID', 'Kec. Sungai Pinang', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150110', 3, 'ID', 'Kec. Pengaron', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150111', 3, 'ID', 'Kec. Mataraman', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150112', 3, 'ID', 'Kec. Simpang Empat', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150113', 3, 'ID', 'Kec. Beruntung Baru', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150114', 3, 'ID', 'Kec. Martapura Barat', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150115', 3, 'ID', 'Kec. Martapura Timur', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150116', 3, 'ID', 'Kec. Paramasan', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150117', 3, 'ID', 'Kec. Tatah Makmur', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150118', 3, 'ID', 'Kec. Sambung Makmur', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150119', 3, 'ID', 'Kec. Telaga Bauntung', '150100');
INSERT INTO siakad.master_wilayah VALUES ('150200', 2, 'ID', 'Kab. Tanah Laut', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150201', 3, 'ID', 'Kec. Panyipatan', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150202', 3, 'ID', 'Kec. Takisung', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150203', 3, 'ID', 'Kec. Kurau', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150204', 3, 'ID', 'Kec. Bati-Bati', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150205', 3, 'ID', 'Kec. Tambang Ulang', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150206', 3, 'ID', 'Kec. Pelaihari', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150207', 3, 'ID', 'Kec. Batu Ampar', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150208', 3, 'ID', 'Kec. Jorong', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150209', 3, 'ID', 'Kec. Kintap', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150210', 3, 'ID', 'Kec. Harapan Bumi Makmur', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150211', 3, 'ID', 'Kec. Bajuin', '150200');
INSERT INTO siakad.master_wilayah VALUES ('150300', 2, 'ID', 'Kab. Barito Kuala', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150301', 3, 'ID', 'Kec. Tabunganen', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150302', 3, 'ID', 'Kec. Tamban', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150303', 3, 'ID', 'Kec. Mekarsari', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150304', 3, 'ID', 'Kec. Anjir Pasar', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150305', 3, 'ID', 'Kec. Anjir Muara', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150306', 3, 'ID', 'Kec. Alalak', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150307', 3, 'ID', 'Kec. Mandastana', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150308', 3, 'ID', 'Kec. Belawang', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150309', 3, 'ID', 'Kec. Wanaraya', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150310', 3, 'ID', 'Kec. Barambai', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150311', 3, 'ID', 'Kec. Rantau Badauh', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150312', 3, 'ID', 'Kec. Cerbon', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150313', 3, 'ID', 'Kec. Bakumpai', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150314', 3, 'ID', 'Kec. Marabahan', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150315', 3, 'ID', 'Kec. Tabukan', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150316', 3, 'ID', 'Kec. Kuripan', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150317', 3, 'ID', 'Kec. Jejangkit', '150300');
INSERT INTO siakad.master_wilayah VALUES ('150400', 2, 'ID', 'Kab. Tapin', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150401', 3, 'ID', 'Kec. Binuang', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150402', 3, 'ID', 'Kec. Tapin Selatan', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150403', 3, 'ID', 'Kec. Tapin Tengah', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150404', 3, 'ID', 'Kec. Bungur', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150405', 3, 'ID', 'Kec. Piani', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150406', 3, 'ID', 'Kec. Lokpaikat', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150407', 3, 'ID', 'Kec. Tapin Utara', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150408', 3, 'ID', 'Kec. Bakarangan', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150409', 3, 'ID', 'Kec. Candi Laras Selatan', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150410', 3, 'ID', 'Kec. Candi Laras Utara', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150411', 3, 'ID', 'Kec. Hatungun', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150412', 3, 'ID', 'Kec. Salam Babaris', '150400');
INSERT INTO siakad.master_wilayah VALUES ('150500', 2, 'ID', 'Kab. Hulu Sungai Selatan', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150501', 3, 'ID', 'Kec. Padang Batung', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150502', 3, 'ID', 'Kec. Loksado', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150503', 3, 'ID', 'Kec. Telaga Langsat', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150504', 3, 'ID', 'Kec. Angkinang', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150505', 3, 'ID', 'Kec. Kandangan', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150506', 3, 'ID', 'Kec. Sungai Raya', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150507', 3, 'ID', 'Kec. Simpur', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150508', 3, 'ID', 'Kec. Kalumpang', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150509', 3, 'ID', 'Kec. Daha Selatan', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150510', 3, 'ID', 'Kec. Daha Utara', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150511', 3, 'ID', 'Kec. Daha Barat', '150500');
INSERT INTO siakad.master_wilayah VALUES ('150600', 2, 'ID', 'Kab. Hulu Sungai Tengah', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150601', 3, 'ID', 'Kec. Haruyan', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150602', 3, 'ID', 'Kec. Batu Benawa', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150603', 3, 'ID', 'Kec. Hantakan', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150604', 3, 'ID', 'Kec. Batang Alai Selatan', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150605', 3, 'ID', 'Kec. Barabai', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150606', 3, 'ID', 'Kec. Labuan Amas Selatan', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150607', 3, 'ID', 'Kec. Labuan Amas Utara', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150608', 3, 'ID', 'Kec. Pendawan', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150609', 3, 'ID', 'Kec. Batang Alai Utara', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150610', 3, 'ID', 'Kec. Batang Alai Timur', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150611', 3, 'ID', 'Kec. Limpasu', '150600');
INSERT INTO siakad.master_wilayah VALUES ('150700', 2, 'ID', 'Kab. Hulu Sungai Utara', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150701', 3, 'ID', 'Kec. Danau Panggang', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150702', 3, 'ID', 'Kec. Babirik', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150703', 3, 'ID', 'Kec. Sungai Pandan', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150704', 3, 'ID', 'Kec. Amuntai Selatan', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150705', 3, 'ID', 'Kec. Amuntai Tengah', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150706', 3, 'ID', 'Kec. Banjang', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150707', 3, 'ID', 'Kec. Amuntai Utara', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150708', 3, 'ID', 'Kec. Paminggir', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150709', 3, 'ID', 'Kec. Sungai Tabukan', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150710', 3, 'ID', 'Kec. Haur Gading', '150700');
INSERT INTO siakad.master_wilayah VALUES ('150800', 2, 'ID', 'Kab. Tabalong', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150801', 3, 'ID', 'Kec. Banua Lawas', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150802', 3, 'ID', 'Kec. Pugaan', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150803', 3, 'ID', 'Kec. Kelua', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150804', 3, 'ID', 'Kec. Muara Harus', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150805', 3, 'ID', 'Kec. Tanta', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150806', 3, 'ID', 'Kec. Tanjung', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150807', 3, 'ID', 'Kec. Murung Pudak', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150808', 3, 'ID', 'Kec. Haruai', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150809', 3, 'ID', 'Kec. Upau', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150810', 3, 'ID', 'Kec. Muara Uya', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150811', 3, 'ID', 'Kec. Jaro', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150812', 3, 'ID', 'Kec. Bintang Ara', '150800');
INSERT INTO siakad.master_wilayah VALUES ('150900', 2, 'ID', 'Kab. Kota Baru', '150000');
INSERT INTO siakad.master_wilayah VALUES ('150901', 3, 'ID', 'Kec. Pulau Sembilan', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150902', 3, 'ID', 'Kec. Pulau Laut Barat', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150903', 3, 'ID', 'Kec. Pulau Laut Selatan', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150904', 3, 'ID', 'Kec. Pulau Laut Timur', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150905', 3, 'ID', 'Kec. Pulau Sebuku', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150906', 3, 'ID', 'Kec. Pulau Laut Utara', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150907', 3, 'ID', 'Kec. Pulau Laut Tengah', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150908', 3, 'ID', 'Kec. Kelumpang Hilir', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150909', 3, 'ID', 'Kec. Kelumpang Barat', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150912', 3, 'ID', 'Kec. Kelumpang Selatan', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150913', 3, 'ID', 'Kec. Kelumpang Hulu', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150914', 3, 'ID', 'Kec. Hampang', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150915', 3, 'ID', 'Kec. Sungai Durian', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150916', 3, 'ID', 'Kec. Kelumpang Tengah', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150917', 3, 'ID', 'Kec. Kelumpang Utara', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150918', 3, 'ID', 'Kec. Pamukan Selatan', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150919', 3, 'ID', 'Kec. Sampanahan', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150920', 3, 'ID', 'Kec. Pamukan Utara', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150921', 3, 'ID', 'Kec. Pulau Laut Kepulauan', '150900');
INSERT INTO siakad.master_wilayah VALUES ('150922', 3, 'ID', 'Kec. Pamukan Barat', '150900');
INSERT INTO siakad.master_wilayah VALUES ('151000', 2, 'ID', 'Kab. Balangan', '150000');
INSERT INTO siakad.master_wilayah VALUES ('151001', 3, 'ID', 'Kec. Lampihong', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151002', 3, 'ID', 'Kec. Batu Mandi', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151003', 3, 'ID', 'Kec. Awayan', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151004', 3, 'ID', 'Kec. Paringin', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151005', 3, 'ID', 'Kec. Juai', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151006', 3, 'ID', 'Kec. Halong', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151007', 3, 'ID', 'Kec. Tebing Tinggi', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151008', 3, 'ID', 'Kec. Paringin Selatan', '151000');
INSERT INTO siakad.master_wilayah VALUES ('151100', 2, 'ID', 'Kab. Tanah Bumbu', '150000');
INSERT INTO siakad.master_wilayah VALUES ('151101', 3, 'ID', 'Kec. Kusan Hilir', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151102', 3, 'ID', 'Kec. Sungai Loban', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151103', 3, 'ID', 'Kec. Satui', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151104', 3, 'ID', 'Kec. Kusan Hulu', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151105', 3, 'ID', 'Kec. Batu Licin', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151106', 3, 'ID', 'Kec. Simpang Empat', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151107', 3, 'ID', 'Kec. Karang Bintang', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151108', 3, 'ID', 'Kec. Mantewe', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151109', 3, 'ID', 'Kec. Angsana', '151100');
INSERT INTO siakad.master_wilayah VALUES ('151110', 3, 'ID', 'Kec. Kuranji', '151100');
INSERT INTO siakad.master_wilayah VALUES ('156000', 2, 'ID', 'Kota Banjarmasin', '150000');
INSERT INTO siakad.master_wilayah VALUES ('156001', 3, 'ID', 'Kec. Banjarmasin Selatan', '156000');
INSERT INTO siakad.master_wilayah VALUES ('156002', 3, 'ID', 'Kec. Banjarmasin Timur', '156000');
INSERT INTO siakad.master_wilayah VALUES ('156003', 3, 'ID', 'Kec. Banjarmasin Barat', '156000');
INSERT INTO siakad.master_wilayah VALUES ('156004', 3, 'ID', 'Kec. Banjarmasin Utara', '156000');
INSERT INTO siakad.master_wilayah VALUES ('156005', 3, 'ID', 'Kec. Banjarmasin Tengah', '156000');
INSERT INTO siakad.master_wilayah VALUES ('156100', 2, 'ID', 'Kota Banjarbaru', '150000');
INSERT INTO siakad.master_wilayah VALUES ('156101', 3, 'ID', 'Kec. Landasan Ulin', '156100');
INSERT INTO siakad.master_wilayah VALUES ('156102', 3, 'ID', 'Kec. Cempaka', '156100');
INSERT INTO siakad.master_wilayah VALUES ('156104', 3, 'ID', 'Kec. Banjarbaru Utara', '156100');
INSERT INTO siakad.master_wilayah VALUES ('156105', 3, 'ID', 'Kec. Banjarbaru Selatan', '156100');
INSERT INTO siakad.master_wilayah VALUES ('156106', 3, 'ID', 'Kec. Liang Anggang', '156100');
INSERT INTO siakad.master_wilayah VALUES ('160000', 1, 'ID', 'Prov. Kalimantan Timur', '000000');
INSERT INTO siakad.master_wilayah VALUES ('160100', 2, 'ID', 'Kab. Pasir', '160000');
INSERT INTO siakad.master_wilayah VALUES ('160101', 3, 'ID', 'Kec. Batu Sopang', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160102', 3, 'ID', 'Kec. Tanjung Harapan', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160103', 3, 'ID', 'Kec. Pasir Balengkong', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160104', 3, 'ID', 'Kec. Tanah Grogot', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160105', 3, 'ID', 'Kec. Kuaro', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160106', 3, 'ID', 'Kec. Long Ikis', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160107', 3, 'ID', 'Kec. Muara Komam', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160108', 3, 'ID', 'Kec. Long Kali', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160109', 3, 'ID', 'Kec. Muara Samu', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160110', 3, 'ID', 'Kec. Batu Engau', '160100');
INSERT INTO siakad.master_wilayah VALUES ('160200', 2, 'ID', 'Kab. Kutai Kartanegara', '160000');
INSERT INTO siakad.master_wilayah VALUES ('160201', 3, 'ID', 'Kec. Semboja', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160202', 3, 'ID', 'Kec. Muara Jawa', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160203', 3, 'ID', 'Kec. Sanga-Sanga', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160204', 3, 'ID', 'Kec. Loa Janan', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160205', 3, 'ID', 'Kec. Loa Kulu', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160206', 3, 'ID', 'Kec. Muara Muntai', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160207', 3, 'ID', 'Kec. Muara Wis', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160208', 3, 'ID', 'Kec. Kota Bangun', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160209', 3, 'ID', 'Kec. Tenggarong', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160210', 3, 'ID', 'Kec. Sebulu', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160211', 3, 'ID', 'Kec. Tenggarong Seberang', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160212', 3, 'ID', 'Kec. Anggana', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160213', 3, 'ID', 'Kec. Muara Badak', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160214', 3, 'ID', 'Kec. Marang Kayu', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160215', 3, 'ID', 'Kec. Muara Kaman', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160216', 3, 'ID', 'Kec. Kenohan', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160217', 3, 'ID', 'Kec. Kembang Janggut', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160218', 3, 'ID', 'Kec. Tabang', '160200');
INSERT INTO siakad.master_wilayah VALUES ('160300', 2, 'ID', 'Kab. Berau', '160000');
INSERT INTO siakad.master_wilayah VALUES ('160301', 3, 'ID', 'Kec. Kelay', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160302', 3, 'ID', 'Kec. Talisayan', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160303', 3, 'ID', 'Kec. Biduk Biduk', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160304', 3, 'ID', 'Kec. Pulau Derawan', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160305', 3, 'ID', 'Kec. Sambaliung', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160306', 3, 'ID', 'Kec. Tanjung Redeb', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160307', 3, 'ID', 'Kec. Gunung Tabur', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160308', 3, 'ID', 'Kec. Segah', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160309', 3, 'ID', 'Kec. Teluk Bayur', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160312', 3, 'ID', 'Kec. Tubalar', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160313', 3, 'ID', 'Kec. Pulau Maratua', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160314', 3, 'ID', 'Kec. Batu Putih', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160315', 3, 'ID', 'Kec. Biatan', '160300');
INSERT INTO siakad.master_wilayah VALUES ('160400', 2, 'ID', 'Kab. Bulongan', '160000');
INSERT INTO siakad.master_wilayah VALUES ('160402', 3, 'ID', 'Kec. Tanjung Palas', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160403', 3, 'ID', 'Kec. Sekatak', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160405', 3, 'ID', 'Kec. Pulau Bunyu', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160406', 3, 'ID', 'Kec. Tanjung Palas Barat', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160407', 3, 'ID', 'Kec. Tanjung Palas Utara', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160408', 3, 'ID', 'Kec. Tanjung Palas Timur', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160409', 3, 'ID', 'Kec. Tanjung Selor', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160410', 3, 'ID', 'Kec. Tanjung Palas Tengah', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160411', 3, 'ID', 'Kec. Peso Hilir', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160413', 3, 'ID', 'Kec. Peso', '160400');
INSERT INTO siakad.master_wilayah VALUES ('160700', 2, 'ID', 'Kab. Malinau', '160000');
INSERT INTO siakad.master_wilayah VALUES ('160701', 3, 'ID', 'Kec. Kayan Hulu', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160702', 3, 'ID', 'Kec. Kayan Hilir', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160703', 3, 'ID', 'Kec. Pujungan', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160704', 3, 'ID', 'Kec. Malinau Kota', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160705', 3, 'ID', 'Kec. Mentarang', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160706', 3, 'ID', 'Kec. Sungai Boh', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160707', 3, 'ID', 'Kec. Malinau Selatan', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160708', 3, 'ID', 'Kec. Malinau Barat', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160709', 3, 'ID', 'Kec. Malinau Utara', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160710', 3, 'ID', 'Kec. Kayan Selatan', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160711', 3, 'ID', 'Kec. Bahau Hulu', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160712', 3, 'ID', 'Kec. Mentarang Hulu', '160700');
INSERT INTO siakad.master_wilayah VALUES ('160800', 2, 'ID', 'Kab. Nunukan', '160000');
INSERT INTO siakad.master_wilayah VALUES ('160801', 3, 'ID', 'Kec. Kerayan', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160802', 3, 'ID', 'Kec. Lumbis', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160803', 3, 'ID', 'Kec. Sembakung', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160804', 3, 'ID', 'Kec. Nunukan', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160805', 3, 'ID', 'Kec. Sebatik', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160806', 3, 'ID', 'Kec. Sebuku', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160807', 3, 'ID', 'Kec. Krayan Selatan', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160808', 3, 'ID', 'Kec. Sebatik Barat', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160809', 3, 'ID', 'Kec. Nunukan Selatan', '160800');
INSERT INTO siakad.master_wilayah VALUES ('160814', 3, 'ID', 'Nunukan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160815', 3, 'ID', 'Krayan Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160816', 3, 'ID', 'Krayan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160817', 3, 'ID', 'Nunukan Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160900', 2, 'ID', 'Kab. Kutai Barat', '160000');
INSERT INTO siakad.master_wilayah VALUES ('160901', 3, 'ID', 'Kec. Bongan', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160902', 3, 'ID', 'Kec. Jempang', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160903', 3, 'ID', 'Kec. Penyinggahan', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160904', 3, 'ID', 'Kec. Muara Pahu', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160905', 3, 'ID', 'Kec. Muara Lawa', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160906', 3, 'ID', 'Kec. Damai', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160907', 3, 'ID', 'Kec. Barong Tongkok', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160908', 3, 'ID', 'Kec. Melak', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160909', 3, 'ID', 'Kec. Long Iram', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160910', 3, 'ID', 'Kec. Long Hubung', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160911', 3, 'ID', 'Kec. Long Bagun', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160912', 3, 'ID', 'Kec. Long Pahangai', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160913', 3, 'ID', 'Kec. Long Apari', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160915', 3, 'ID', 'Kec. Bentian Besar', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160916', 3, 'ID', 'Kec. Linggang Bingung', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160917', 3, 'ID', 'Kec. Manor Bulatn', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160918', 3, 'ID', 'Kec. Laham', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160919', 3, 'ID', 'Kec. Nyuatan', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160920', 3, 'ID', 'Kec. Sekolaq Darat', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160921', 3, 'ID', 'Kec. Tering', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160923', 3, 'ID', 'Kec. Siluq Ngurai', '160900');
INSERT INTO siakad.master_wilayah VALUES ('160924', 3, 'ID', 'Long Bagun', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160990', 3, 'ID', 'Long Apari', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160991', 3, 'ID', 'Long Pahangai', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160992', 3, 'ID', 'Long Hubung', '      ');
INSERT INTO siakad.master_wilayah VALUES ('160993', 3, 'ID', 'Laham', '      ');
INSERT INTO siakad.master_wilayah VALUES ('161000', 2, 'ID', 'Kab. Kutai Timur', '160000');
INSERT INTO siakad.master_wilayah VALUES ('161001', 3, 'ID', 'Kec. Muara Ancalong', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161002', 3, 'ID', 'Kec. Muara Wahau', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161003', 3, 'ID', 'Kec. Muara Bengkal', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161004', 3, 'ID', 'Kec. Sengata Utara', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161005', 3, 'ID', 'Kec. Sangkulirang', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161006', 3, 'ID', 'Kec. Kaliorang', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161008', 3, 'ID', 'Kec. Kombeng', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161009', 3, 'ID', 'Kec. Bengalon', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161010', 3, 'ID', 'Kec. Busang', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161011', 3, 'ID', 'Kec. Sandaran', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161012', 3, 'ID', 'Kec. Telen', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161013', 3, 'ID', 'Kec. Sengata Selatan', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161014', 3, 'ID', 'Kec. Teluk Pandan', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161015', 3, 'ID', 'Kec. Rantau Pulung', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161016', 3, 'ID', 'Kec. Kaubun', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161017', 3, 'ID', 'Kec. Karangan', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161018', 3, 'ID', 'Kec. Batu Ampar', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161019', 3, 'ID', 'Kec. Long Mesangat', '161000');
INSERT INTO siakad.master_wilayah VALUES ('161100', 2, 'ID', 'Kab. Penajam Paser Utara', '160000');
INSERT INTO siakad.master_wilayah VALUES ('161101', 3, 'ID', 'Kec. Babulu', '161100');
INSERT INTO siakad.master_wilayah VALUES ('161102', 3, 'ID', 'Kec. Waru', '161100');
INSERT INTO siakad.master_wilayah VALUES ('161103', 3, 'ID', 'Kec. Penajam', '161100');
INSERT INTO siakad.master_wilayah VALUES ('161104', 3, 'ID', 'Kec. Sepaku', '161100');
INSERT INTO siakad.master_wilayah VALUES ('165400', 2, 'ID', 'Kab. Tanah Tidung', '160000');
INSERT INTO siakad.master_wilayah VALUES ('166000', 2, 'ID', 'Kota Samarinda', '160000');
INSERT INTO siakad.master_wilayah VALUES ('166001', 3, 'ID', 'Kec. Palaran', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166002', 3, 'ID', 'Kec. Samarinda Ilir', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166003', 3, 'ID', 'Kec. Samarinda Seberang', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166004', 3, 'ID', 'Kec. Sungai Kunjang', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166005', 3, 'ID', 'Kec. Samarinda Ulu', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166006', 3, 'ID', 'Kec. Samarinda Utara', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166007', 3, 'ID', 'Kec. Sambutan', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166008', 3, 'ID', 'Kec. Sungai Pinang', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166009', 3, 'ID', 'Kec. Samarinda Kota', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166010', 3, 'ID', 'Kec. Loa Janan Ilir', '166000');
INSERT INTO siakad.master_wilayah VALUES ('166100', 2, 'ID', 'Kota Balikpapan', '160000');
INSERT INTO siakad.master_wilayah VALUES ('166101', 3, 'ID', 'Kec. Balikpapan Selatan', '166100');
INSERT INTO siakad.master_wilayah VALUES ('166102', 3, 'ID', 'Kec. Balikpapan Timur', '166100');
INSERT INTO siakad.master_wilayah VALUES ('166103', 3, 'ID', 'Kec. Balikpapan Utara', '166100');
INSERT INTO siakad.master_wilayah VALUES ('166104', 3, 'ID', 'Kec. Balikpapan Tengah', '166100');
INSERT INTO siakad.master_wilayah VALUES ('166105', 3, 'ID', 'Kec. Balikpapan Barat', '166100');
INSERT INTO siakad.master_wilayah VALUES ('166200', 2, 'ID', 'Kota Tarakan', '160000');
INSERT INTO siakad.master_wilayah VALUES ('166201', 3, 'ID', 'Kec. Tarakan Timur', '166200');
INSERT INTO siakad.master_wilayah VALUES ('166202', 3, 'ID', 'Kec. Tarakan Tengah', '166200');
INSERT INTO siakad.master_wilayah VALUES ('166203', 3, 'ID', 'Kec. Tarakan Barat', '166200');
INSERT INTO siakad.master_wilayah VALUES ('166204', 3, 'ID', 'Kec. Tarakan Utara', '166200');
INSERT INTO siakad.master_wilayah VALUES ('166300', 2, 'ID', 'Kota Bontang', '160000');
INSERT INTO siakad.master_wilayah VALUES ('166301', 3, 'ID', 'Kec. Bontang Selatan', '166300');
INSERT INTO siakad.master_wilayah VALUES ('166302', 3, 'ID', 'Kec. Bontang Utara', '166300');
INSERT INTO siakad.master_wilayah VALUES ('166303', 3, 'ID', 'Kec. Bontang Barat', '166300');
INSERT INTO siakad.master_wilayah VALUES ('166404', 3, 'ID', 'Sesayap', '      ');
INSERT INTO siakad.master_wilayah VALUES ('166412', 3, 'ID', 'Sesayap Hilir', '      ');
INSERT INTO siakad.master_wilayah VALUES ('166414', 3, 'ID', 'Tana Lia', '      ');
INSERT INTO siakad.master_wilayah VALUES ('170000', 1, 'ID', 'Prov. Sulawesi Utara', '000000');
INSERT INTO siakad.master_wilayah VALUES ('170100', 2, 'ID', 'Kab. Bolaang Mongondaw', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170106', 3, 'ID', 'Kec. Lolayan', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170109', 3, 'ID', 'Kec. Poigar', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170110', 3, 'ID', 'Kec. Bolaang', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170111', 3, 'ID', 'Kec. Lolak', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170112', 3, 'ID', 'Kec. Sangtombolang', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170117', 3, 'ID', 'Kec. Dumoga Utara', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170119', 3, 'ID', 'Kec. Dumoga Barat', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170120', 3, 'ID', 'Kec. Dumoga Timur', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170128', 3, 'ID', 'Kec. Passi Barat', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170129', 3, 'ID', 'Kec. Passi Timur', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170130', 3, 'ID', 'Kec. Bilalang', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170131', 3, 'ID', 'Kec. Sangtombolang', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170133', 3, 'ID', 'Bolaang Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('170200', 2, 'ID', 'Kab. Minahasa', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170209', 3, 'ID', 'Kec. Langowan Timur', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170211', 3, 'ID', 'Kec. Tompaso', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170212', 3, 'ID', 'Kec. Kawangkoan', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170213', 3, 'ID', 'Kec. Sonder', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170216', 3, 'ID', 'Kec. Tombariri', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170217', 3, 'ID', 'Kec. Pineleng', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170219', 3, 'ID', 'Kec. Tondano Timur', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170220', 3, 'ID', 'Kec. Remboken', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170221', 3, 'ID', 'Kec. Kakas', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170222', 3, 'ID', 'Kec. Lembean Timur', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170223', 3, 'ID', 'Kec. Eris', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170224', 3, 'ID', 'Kec. Kombi', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170233', 3, 'ID', 'Kec. Langowan Barat', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170234', 3, 'ID', 'Kec. Tombulu', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170235', 3, 'ID', 'Kec. Tondano Barat', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170236', 3, 'ID', 'Kec. Tondano Utara', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170237', 3, 'ID', 'Kec. Langowan Selatan', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170238', 3, 'ID', 'Kec. Tondano Selatan', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170239', 3, 'ID', 'Kec. Langowan Utara', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170300', 2, 'ID', 'Kab. Kep. Sangihe', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170304', 3, 'ID', 'Kec. Manganitu Selatan', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170305', 3, 'ID', 'Kec. Tamako', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170306', 3, 'ID', 'Kec. Tabukan Selatan', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170307', 3, 'ID', 'Kec. Tabukan Tengah', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170308', 3, 'ID', 'Kec. Manganitu', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170309', 3, 'ID', 'Kec. Tahuna', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170310', 3, 'ID', 'Kec. Tabukan Utara', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170311', 3, 'ID', 'Kec. Kendahe', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170313', 3, 'ID', 'Kec. Tatoareng', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170317', 3, 'ID', 'Kec. Nusa Tabukan', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170319', 3, 'ID', 'Kec. Tabukan Selatan Tengah', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170320', 3, 'ID', 'Kec. Tabukan Selatan Tenggara', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170323', 3, 'ID', 'Kec. Tahuna Timur', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170324', 3, 'ID', 'Kec. Tahuna Barat', '170300');
INSERT INTO siakad.master_wilayah VALUES ('170390', 3, 'ID', 'Kepulauan Marore', '      ');
INSERT INTO siakad.master_wilayah VALUES ('170400', 2, 'ID', 'Kab. Kepulauan Talaud', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170401', 3, 'ID', 'Kec. Kabaruan', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170402', 3, 'ID', 'Kec. Lirung', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170403', 3, 'ID', 'Kec. Melonguane', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170404', 3, 'ID', 'Kec. Beo', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170405', 3, 'ID', 'Kec. Rainis', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170406', 3, 'ID', 'Kec. Essang', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170407', 3, 'ID', 'Kec. Nanusa', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170408', 3, 'ID', 'Kec. Gemeh', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170409', 3, 'ID', 'Kec. Damau', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170410', 3, 'ID', 'Kec. Tanpa Namma', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170411', 3, 'ID', 'Kec. Lirung Selatan', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170412', 3, 'ID', 'Kec. Kalongan', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170413', 3, 'ID', 'Kec. Moronge', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170414', 3, 'ID', 'Kec. Melonguane Timur', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170415', 3, 'ID', 'Kec. Beo Utara', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170416', 3, 'ID', 'Kec. Beo Selatan', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170417', 3, 'ID', 'Kec. Pulutan', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170418', 3, 'ID', 'Kec. Essang Selatan', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170419', 3, 'ID', 'Kec. Miangas', '170400');
INSERT INTO siakad.master_wilayah VALUES ('170420', 3, 'ID', 'Salibabu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('170500', 2, 'ID', 'Kab. Minahasa Selatan', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170501', 3, 'ID', 'Kec. Modoinding', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170502', 3, 'ID', 'Kec. Tompaso Baru', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170503', 3, 'ID', 'Kec. Ranoyapo', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170504', 3, 'ID', 'Kec. Motoling', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170505', 3, 'ID', 'Kec. Tenga', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170509', 3, 'ID', 'Kec. Amurang', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170510', 3, 'ID', 'Kec. Tareran', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170515', 3, 'ID', 'Kec. Kumelembuai', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170516', 3, 'ID', 'Kec. Maesaan', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170517', 3, 'ID', 'Kec. Amurang Barat', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170518', 3, 'ID', 'Kec. Amurang Timur', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170519', 3, 'ID', 'Kec. Tatapan', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170520', 3, 'ID', 'Kec. Motoling Barat', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170521', 3, 'ID', 'Kec. Motoling Timur', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170522', 3, 'ID', 'Kec. Sulta', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170523', 3, 'ID', 'Kec. Tumpaan', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170524', 3, 'ID', 'Sinonsayang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('170529', 3, 'ID', 'Kec. Ratatotok', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170530', 3, 'ID', 'Kec. Pusomaen', '170500');
INSERT INTO siakad.master_wilayah VALUES ('170600', 2, 'ID', 'Kab. Minahasa Utara', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170601', 3, 'ID', 'Kec. Kauditan', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170602', 3, 'ID', 'Kec. Airmadidi', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170603', 3, 'ID', 'Kec. Dimembe', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170604', 3, 'ID', 'Kec. Wori', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170605', 3, 'ID', 'Kec. Likupang Timur', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170606', 3, 'ID', 'Kec. Kema', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170607', 3, 'ID', 'Kec. Likupang Barat', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170608', 3, 'ID', 'Kec. Kalawat', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170609', 3, 'ID', 'Kec. Talawaan', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170610', 3, 'ID', 'Kec. Likupang Selatan', '170600');
INSERT INTO siakad.master_wilayah VALUES ('170800', 2, 'ID', 'Kab. Bolaang Mongondow Utara', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170801', 3, 'ID', 'Kec. Bintauna', '170800');
INSERT INTO siakad.master_wilayah VALUES ('170802', 3, 'ID', 'Kec. Bolaang Itang Timur', '170800');
INSERT INTO siakad.master_wilayah VALUES ('170803', 3, 'ID', 'Kec. Bolaang Itang Barat', '170800');
INSERT INTO siakad.master_wilayah VALUES ('170804', 3, 'ID', 'Kec. Kaidipang', '170800');
INSERT INTO siakad.master_wilayah VALUES ('170805', 3, 'ID', 'Kec. Pinogaluman', '170800');
INSERT INTO siakad.master_wilayah VALUES ('170806', 3, 'ID', 'Kec. Sangkub', '170800');
INSERT INTO siakad.master_wilayah VALUES ('170900', 2, 'ID', 'Kab. Kepulauan Sitaro', '170000');
INSERT INTO siakad.master_wilayah VALUES ('170901', 3, 'ID', 'Kec. Biaro', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170902', 3, 'ID', 'Kec. Siau Barat', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170903', 3, 'ID', 'Kec. Siau Barat Selatan', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170904', 3, 'ID', 'Kec. Siau Barat Utara', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170905', 3, 'ID', 'Kec. Siau Tengah', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170906', 3, 'ID', 'Kec. Siau Timur', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170907', 3, 'ID', 'Kec. Siau Timur Selatan', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170908', 3, 'ID', 'Kec. Tagulandang', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170909', 3, 'ID', 'Kec. Tagulandang Selatan', '170900');
INSERT INTO siakad.master_wilayah VALUES ('170910', 3, 'ID', 'Kec. Tagulandang Utara', '170900');
INSERT INTO siakad.master_wilayah VALUES ('171000', 2, 'ID', 'Kab. Minahasa Tenggara', '170000');
INSERT INTO siakad.master_wilayah VALUES ('171001', 3, 'ID', 'Kec. Ratatotok', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171002', 3, 'ID', 'Kec. Pusomaen', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171003', 3, 'ID', 'Kec. Belang', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171004', 3, 'ID', 'Kec. Ratahan', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171005', 3, 'ID', 'Kec. Tombatu', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171006', 3, 'ID', 'Kec. Touluaan', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171007', 3, 'ID', 'Kec. Touluaan Selatan', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171008', 3, 'ID', 'Kec. Silian Raya', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171009', 3, 'ID', 'Kec. Tombatu Timur', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171010', 3, 'ID', 'Kec. Tombatu Utara', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171011', 3, 'ID', 'Kec. Pasan', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171012', 3, 'ID', 'Kec. Ratahan Timur', '171000');
INSERT INTO siakad.master_wilayah VALUES ('171100', 2, 'ID', 'Kab. Bolaang Mongondaw Timur', '170000');
INSERT INTO siakad.master_wilayah VALUES ('171101', 3, 'ID', 'Kec. Kotabunan', '171100');
INSERT INTO siakad.master_wilayah VALUES ('171102', 3, 'ID', 'Kec. Nuangan', '171100');
INSERT INTO siakad.master_wilayah VALUES ('171103', 3, 'ID', 'Kec.Tutuyan', '171100');
INSERT INTO siakad.master_wilayah VALUES ('171104', 3, 'ID', 'Kec. Modayag', '171100');
INSERT INTO siakad.master_wilayah VALUES ('171105', 3, 'ID', 'Kec. Modayag Barat', '171100');
INSERT INTO siakad.master_wilayah VALUES ('171200', 2, 'ID', 'Kab. Bolaang Mongondaw Selatan', '170000');
INSERT INTO siakad.master_wilayah VALUES ('171201', 3, 'ID', 'Kec. Bolaang Uki', '171200');
INSERT INTO siakad.master_wilayah VALUES ('171202', 3, 'ID', 'Kec. Posigadan', '171200');
INSERT INTO siakad.master_wilayah VALUES ('171203', 3, 'ID', 'Kec. Pinolosian', '171200');
INSERT INTO siakad.master_wilayah VALUES ('171204', 3, 'ID', 'Kec. Pinolosian Timur', '171200');
INSERT INTO siakad.master_wilayah VALUES ('171205', 3, 'ID', 'Kec. Pinolosian Tengah', '171200');
INSERT INTO siakad.master_wilayah VALUES ('176000', 2, 'ID', 'Kota Manado', '170000');
INSERT INTO siakad.master_wilayah VALUES ('176001', 3, 'ID', 'Kec. Malalayang', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176002', 3, 'ID', 'Kec. Sario', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176003', 3, 'ID', 'Kec. Wenang', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176004', 3, 'ID', 'Kec. Mapanget', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176005', 3, 'ID', 'Kec. Bunaken', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176006', 3, 'ID', 'Kec. Wanea', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176007', 3, 'ID', 'Kec. Tikala', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176008', 3, 'ID', 'Kec. Tuminting', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176009', 3, 'ID', 'Kec. Singkil', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176100', 2, 'ID', 'Kota Bitung', '170000');
INSERT INTO siakad.master_wilayah VALUES ('176101', 3, 'ID', 'Kec. Ranowulu', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176102', 3, 'ID', 'Kec. Matuari', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176103', 3, 'ID', 'Kec. Girian', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176104', 3, 'ID', 'Kec. Madidir', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176105', 3, 'ID', 'Kec. Maesa', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176106', 3, 'ID', 'Kec. Aertembaga', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176107', 3, 'ID', 'Kec. Lembeh Utara', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176108', 3, 'ID', 'Kec. Lembeh Selatan', '176100');
INSERT INTO siakad.master_wilayah VALUES ('176200', 2, 'ID', 'Kota Tomohon', '170000');
INSERT INTO siakad.master_wilayah VALUES ('176201', 3, 'ID', 'Kec. Tomohon Utara', '176200');
INSERT INTO siakad.master_wilayah VALUES ('176202', 3, 'ID', 'Kec. Tomohon Tengah', '176200');
INSERT INTO siakad.master_wilayah VALUES ('176203', 3, 'ID', 'Kec. Tomohon Selatan', '176200');
INSERT INTO siakad.master_wilayah VALUES ('176204', 3, 'ID', 'Kec. Tomohon Timur', '176200');
INSERT INTO siakad.master_wilayah VALUES ('176205', 3, 'ID', 'Kec. Tomohon Barat', '176200');
INSERT INTO siakad.master_wilayah VALUES ('176300', 2, 'ID', 'Kota. Kotamobagu', '170000');
INSERT INTO siakad.master_wilayah VALUES ('176301', 3, 'ID', 'Kec. Kotamobagu Barat', '176300');
INSERT INTO siakad.master_wilayah VALUES ('176302', 3, 'ID', 'Kec. Kotamobagu Timur', '176300');
INSERT INTO siakad.master_wilayah VALUES ('176303', 3, 'ID', 'Kec. Kotamobagu Utara', '176300');
INSERT INTO siakad.master_wilayah VALUES ('176304', 3, 'ID', 'Kec. Kotamobagu Selatan', '176300');
INSERT INTO siakad.master_wilayah VALUES ('180000', 1, 'ID', 'Prov. Sulawesi Tengah', '000000');
INSERT INTO siakad.master_wilayah VALUES ('180100', 2, 'ID', 'Kab. Banggai Kepulauan', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180101', 3, 'ID', 'Kec. Labobo', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180102', 3, 'ID', 'Kec. Banggai', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180103', 3, 'ID', 'Kec. Totikum', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180104', 3, 'ID', 'Kec. Tinangkung', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180105', 3, 'ID', 'Kec. Liang', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180106', 3, 'ID', 'Kec. Bulagi', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180107', 3, 'ID', 'Kec. Buko', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180109', 3, 'ID', 'Kec. Bokan Kepulauan', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180110', 3, 'ID', 'Kec. Bulagi Selatan', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180111', 3, 'ID', 'Kec. Bangkurung', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180112', 3, 'ID', 'Kec. Banggai Utara', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180113', 3, 'ID', 'Kec. Banggai Tengah', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180114', 3, 'ID', 'Kec. Banggai Selatan', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180115', 3, 'ID', 'Kec. Selatan', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180116', 3, 'ID', 'Kec. Tinangkung Selatan', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180117', 3, 'ID', 'Kec. Tinangkung Utara', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180118', 3, 'ID', 'Kec. Peling Tengah', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180119', 3, 'ID', 'Kec. Bulagi Utara', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180120', 3, 'ID', 'Kec. Buko Selatan', '180100');
INSERT INTO siakad.master_wilayah VALUES ('180121', 3, 'ID', 'Banggai Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180122', 3, 'ID', 'Banggai', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180190', 3, 'ID', 'Labobo', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180191', 3, 'ID', 'Bokan Kepulauan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180192', 3, 'ID', 'Bangkurung', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180193', 3, 'ID', 'Banggai Tengah', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180194', 3, 'ID', 'Banggai Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180199', 3, 'ID', 'Totikum Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180200', 2, 'ID', 'Kab. Donggala', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180208', 3, 'ID', 'Kec. Banawa', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180209', 3, 'ID', 'Kec. Labuan', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180210', 3, 'ID', 'Kec. Sindue', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180212', 3, 'ID', 'Kec. Sirenja', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180213', 3, 'ID', 'Kec. Balaesang', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180214', 3, 'ID', 'Kec. Damsol', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180216', 3, 'ID', 'Kec. Sojol', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180220', 3, 'ID', 'Kec. Rio Pakava', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180224', 3, 'ID', 'Kec. Banawa Selatan', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180225', 3, 'ID', 'Kec. Tanantovea', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180227', 3, 'ID', 'Kec. Pinembani', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180233', 3, 'ID', 'Kec. Banawa Tengah', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180234', 3, 'ID', 'Kec. Sindue Tombusabora', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180235', 3, 'ID', 'Kec. Sindue Tobata', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180236', 3, 'ID', 'Kec. Sojol Utara', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180237', 3, 'ID', 'Kec. Balaesang Tanjung', '180200');
INSERT INTO siakad.master_wilayah VALUES ('180290', 3, 'ID', 'Dompelas Sojol', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180300', 2, 'ID', 'Kab. Parigi Mautong', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180301', 3, 'ID', 'Kec. Pamona Selatan', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180302', 3, 'ID', 'Kec. Lore Selatan', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180303', 3, 'ID', 'Kec. Pamona Utara', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180304', 3, 'ID', 'Kec. Lore Utara', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180305', 3, 'ID', 'Kec. Poso Pesisir', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180306', 3, 'ID', 'Kec. Lage', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180307', 3, 'ID', 'Kec. Poso Kota', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180314', 3, 'ID', 'Kec. Pamona Timur', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180315', 3, 'ID', 'Kec. Lore Tengah', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180316', 3, 'ID', 'Kec. Pamona Barat', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180317', 3, 'ID', 'Kec. Poso Pesisir Selatan', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180318', 3, 'ID', 'Kec. Poso Pesisir Utara', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180319', 3, 'ID', 'Kec. Poso Kota Utara', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180320', 3, 'ID', 'Kec. Lore Barat', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180321', 3, 'ID', 'Kec. Poso Kota Selatan', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180322', 3, 'ID', 'Pamona Puselemba', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180323', 3, 'ID', 'Kec. Lore Timur', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180324', 3, 'ID', 'Kec. Lore Peore', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180325', 3, 'ID', 'Pamona Tenggara', '180300');
INSERT INTO siakad.master_wilayah VALUES ('180400', 2, 'ID', 'Kab. Banggai', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180401', 3, 'ID', 'Kec. Toili', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180402', 3, 'ID', 'Kec. Batui', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180403', 3, 'ID', 'Kec. Bunta', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180404', 3, 'ID', 'Kec. Kintom', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180405', 3, 'ID', 'Kec. Luwuk', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180406', 3, 'ID', 'Kec. Pagimana', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180407', 3, 'ID', 'Kec. Lamala', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180408', 3, 'ID', 'Kec. Balantak', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180409', 3, 'ID', 'Kec. Bualemo', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180410', 3, 'ID', 'Kec. Toili Barat', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180411', 3, 'ID', 'Kec. Nuhon', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180412', 3, 'ID', 'Kec. Luwuk Timur', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180413', 3, 'ID', 'Kec. Masama', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180500', 2, 'ID', 'Kab. Buol', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180501', 3, 'ID', 'Kec. Biau', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180502', 3, 'ID', 'Kec. Momunu', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180503', 3, 'ID', 'Kec. Bokat', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180504', 3, 'ID', 'Kec. Bunobogu', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180505', 3, 'ID', 'Kec. Paleleh', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180506', 3, 'ID', 'Kec. Tiloan', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180507', 3, 'ID', 'Kec. Bukal', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180508', 3, 'ID', 'Kec. Gadung', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180509', 3, 'ID', 'Kec. Lipunoto', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180510', 3, 'ID', 'Kec. Karamat', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180511', 3, 'ID', 'Kec. Paleleh Barat', '180500');
INSERT INTO siakad.master_wilayah VALUES ('180512', 3, 'ID', 'Lakea', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180600', 2, 'ID', 'Kab. Toli-Toli', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180601', 3, 'ID', 'Kec. Dampal Selatan', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180602', 3, 'ID', 'Kec. Dampal Utara', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180603', 3, 'ID', 'Kec. Dondo', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180604', 3, 'ID', 'Kec. Baolan', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180605', 3, 'ID', 'Kec. Galang', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180606', 3, 'ID', 'Kec. Utara Toli-Toli', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180607', 3, 'ID', 'Kec. Ogo Deide', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180608', 3, 'ID', 'Kec. Basidondo', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180609', 3, 'ID', 'Kec. Lampasio', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180610', 3, 'ID', 'Kec. Dako Pemean', '180600');
INSERT INTO siakad.master_wilayah VALUES ('180700', 2, 'ID', 'Kab. Marowali', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180701', 3, 'ID', 'Kec. Menui Kepulauan', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180702', 3, 'ID', 'Kec. Bungku Selatan', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180703', 3, 'ID', 'Kec. Bungku Tengah', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180704', 3, 'ID', 'Kec. Bungku Barat', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180705', 3, 'ID', 'Kec. Lembo', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180706', 3, 'ID', 'Kec. Mori Atas', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180707', 3, 'ID', 'Kec. Petasia', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180708', 3, 'ID', 'Kec. Bungku Utara', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180709', 3, 'ID', 'Kec. Bahodopi', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180710', 3, 'ID', 'Kec. Soyo Jaya', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180711', 3, 'ID', 'Kec. Witaponda', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180712', 3, 'ID', 'Kec. Mamosalato', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180713', 3, 'ID', 'Kec. Bumi Raya', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180800', 2, 'ID', 'Kab. Poso', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180801', 3, 'ID', 'Kec. Sausu', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180802', 3, 'ID', 'Kec. Parigi', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180803', 3, 'ID', 'Kec. Ampibabo', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180804', 3, 'ID', 'Kec. Tinombo', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180805', 3, 'ID', 'Kec. Tomini', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180806', 3, 'ID', 'Kec. Moutong', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180807', 3, 'ID', 'Kec. Bolano Lambunu', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180808', 3, 'ID', 'Kec. Kasimbar', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180809', 3, 'ID', 'Kec. Torue', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180810', 3, 'ID', 'Kec. Tinombo Selatan', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180811', 3, 'ID', 'Kec. Parigi Selatan', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180812', 3, 'ID', 'Kec. Mepanga', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180813', 3, 'ID', 'Kec. Malakosa', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180814', 3, 'ID', 'Kec. Parigi Barat', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180815', 3, 'ID', 'Kec. Parigi Utara', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180816', 3, 'ID', 'Kec. Ribulu', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180817', 3, 'ID', 'Kec. Siniu', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180818', 3, 'ID', 'Kec. Palasa', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180819', 3, 'ID', 'Kec. Taopa', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180820', 3, 'ID', 'Kec. Parigi Tengah', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180821', 3, 'ID', 'Balinggi', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180890', 3, 'ID', 'Ongka Malino', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180891', 3, 'ID', 'Bolano', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180892', 3, 'ID', 'Lambunu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('180900', 2, 'ID', 'Kab. Tojo Una-Una', '180000');
INSERT INTO siakad.master_wilayah VALUES ('180901', 3, 'ID', 'Kec. Tojo', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180902', 3, 'ID', 'Kec. Ulubongka', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180903', 3, 'ID', 'Kec. Ampana Tete', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180904', 3, 'ID', 'Kec. Ampana Kota', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180905', 3, 'ID', 'Kec. Una - Una', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180906', 3, 'ID', 'Kec. Walea Kepulauan', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180907', 3, 'ID', 'Kec. Togean', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180908', 3, 'ID', 'Kec. Tojo Barat', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180909', 3, 'ID', 'Kec. Walea Besar', '180900');
INSERT INTO siakad.master_wilayah VALUES ('181000', 2, 'ID', 'Kab. Sigi', '180000');
INSERT INTO siakad.master_wilayah VALUES ('181001', 3, 'ID', 'Kec. Kulawi', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181002', 3, 'ID', 'Kec. Pipikoro', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181003', 3, 'ID', 'Kec. Kulawi Selatan', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181004', 3, 'ID', 'Kec. Lindu', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181005', 3, 'ID', 'Kec. Palolo', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181006', 3, 'ID', 'Kec. Nokilalaki', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181007', 3, 'ID', 'Kec. Dolo', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181008', 3, 'ID', 'Kec. Dolo Selatan', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181009', 3, 'ID', 'Kec. Dolo Barat', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181010', 3, 'ID', 'Kec. Marawola', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181011', 3, 'ID', 'Kec. Kinovaru', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181012', 3, 'ID', 'Kec. Marawola Barat', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181013', 3, 'ID', 'Kec. Sigibiromaru', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181014', 3, 'ID', 'Kec. Gumbasa', '181000');
INSERT INTO siakad.master_wilayah VALUES ('181015', 3, 'ID', 'Kec. Tanambulava', '181000');
INSERT INTO siakad.master_wilayah VALUES ('186000', 2, 'ID', 'Kota Palu', '180000');
INSERT INTO siakad.master_wilayah VALUES ('186001', 3, 'ID', 'Kec. Palu Barat', '186000');
INSERT INTO siakad.master_wilayah VALUES ('186002', 3, 'ID', 'Kec. Palu Selatan', '186000');
INSERT INTO siakad.master_wilayah VALUES ('186003', 3, 'ID', 'Kec. Palu Timur', '186000');
INSERT INTO siakad.master_wilayah VALUES ('186004', 3, 'ID', 'Kec. Palu Utara', '186000');
INSERT INTO siakad.master_wilayah VALUES ('190000', 1, 'ID', 'Prov. Sulawesi Selatan', '000000');
INSERT INTO siakad.master_wilayah VALUES ('190100', 2, 'ID', 'Kab. Maros', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190101', 3, 'ID', 'Kec. Mandai', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190102', 3, 'ID', 'Kec. Maros Baru', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190103', 3, 'ID', 'Kec. Maros Utara', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190104', 3, 'ID', 'Kec. Bantimurung', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190105', 3, 'ID', 'Kec. Tanralili', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190106', 3, 'ID', 'Kec. Camba', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190107', 3, 'ID', 'Kec. Mallawa', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190108', 3, 'ID', 'Kec. Moncongloe', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190109', 3, 'ID', 'Kec. Turikale', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190110', 3, 'ID', 'Kec. Marusu', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190111', 3, 'ID', 'Kec. Lau', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190112', 3, 'ID', 'Kec. Simbang', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190113', 3, 'ID', 'Kec. Tompobulu', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190114', 3, 'ID', 'Kec. Cenrana', '190100');
INSERT INTO siakad.master_wilayah VALUES ('190115', 3, 'ID', 'Bontoa', '      ');
INSERT INTO siakad.master_wilayah VALUES ('190200', 2, 'ID', 'Kab. Pangkajene Kepulauan', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190201', 3, 'ID', 'Kec. Liukang Tangaya', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190202', 3, 'ID', 'Kec. Liukang Kalukuang Masalim', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190203', 3, 'ID', 'Kec. Liukang Tapabiring', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190204', 3, 'ID', 'Kec. Pangkajene', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190205', 3, 'ID', 'Kec. Balocci', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190206', 3, 'ID', 'Kec. Bungoro', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190207', 3, 'ID', 'Kec. Labakkang', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190208', 3, 'ID', 'Kec. Ma`rang', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190209', 3, 'ID', 'Kec. Sigeri', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190210', 3, 'ID', 'Kec. Minasatene', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190211', 3, 'ID', 'Kec. Tondong Tallasa', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190212', 3, 'ID', 'Kec. Mandalle', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190213', 3, 'ID', 'Liukang Tupabbiring Utara', '190200');
INSERT INTO siakad.master_wilayah VALUES ('190300', 2, 'ID', 'Kab. Gowa', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190301', 3, 'ID', 'Kec. Bontonompo', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190302', 3, 'ID', 'Kec. Bajeng', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190303', 3, 'ID', 'Kec. Pallangga', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190304', 3, 'ID', 'Kec. Somba Opu', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190305', 3, 'ID', 'Kec. Bontomarannu', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190306', 3, 'ID', 'Kec. Parang Loe', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190307', 3, 'ID', 'Kec. Tinggi Moncong', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190308', 3, 'ID', 'Kec. Bungaya', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190309', 3, 'ID', 'Kec. Tompobulu', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190310', 3, 'ID', 'Kec. Barombong', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190311', 3, 'ID', 'Kec. Biring Bulu', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190312', 3, 'ID', 'Kec. Tombolo Pao', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190313', 3, 'ID', 'Kec. Manuju', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190314', 3, 'ID', 'Kec. Bontolempangan', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190315', 3, 'ID', 'Kec. Pattallassang', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190316', 3, 'ID', 'Kec. Bontonompo Selatan', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190317', 3, 'ID', 'Kec. Parigi', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190318', 3, 'ID', 'Kec. Bajeng Barat', '190300');
INSERT INTO siakad.master_wilayah VALUES ('190399', 3, 'ID', 'Pattalasang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('190400', 2, 'ID', 'Kab. Takalar', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190401', 3, 'ID', 'Kec. Mangarabombang', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190402', 3, 'ID', 'Kec. Mappakasunggu', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190403', 3, 'ID', 'Kec. Polombangkeng Selatan', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190404', 3, 'ID', 'Kec. Polombangkeng Utara', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190405', 3, 'ID', 'Kec. Galesong Selatan', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190406', 3, 'ID', 'Kec. Galesong Utara', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190408', 3, 'ID', 'Kec. Pattallassang', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190409', 3, 'ID', 'Kec. Sanrobone', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190410', 3, 'ID', 'Kec. Galesong', '190400');
INSERT INTO siakad.master_wilayah VALUES ('190500', 2, 'ID', 'Kab. Jeneponto', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190501', 3, 'ID', 'Kec. Bangkala', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190502', 3, 'ID', 'Kec. Tamalatea', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190503', 3, 'ID', 'Kec. Binamu', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190504', 3, 'ID', 'Kec. Batang', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190505', 3, 'ID', 'Kec. Kelara', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190506', 3, 'ID', 'Kec. Bangkala Barat', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190507', 3, 'ID', 'Kec. Bontoramba', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190508', 3, 'ID', 'Kec. Turatea', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190509', 3, 'ID', 'Kec. Arungkeke', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190510', 3, 'ID', 'Kec. Rumbia', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190511', 3, 'ID', 'Kec. Tarowang', '190500');
INSERT INTO siakad.master_wilayah VALUES ('190600', 2, 'ID', 'Kab. Barru', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190601', 3, 'ID', 'Kec. Tanete Riaja', '190600');
INSERT INTO siakad.master_wilayah VALUES ('190602', 3, 'ID', 'Kec. Tanete Rilau', '190600');
INSERT INTO siakad.master_wilayah VALUES ('190603', 3, 'ID', 'Kec. Barru', '190600');
INSERT INTO siakad.master_wilayah VALUES ('190604', 3, 'ID', 'Kec. Soppeng Riaja', '190600');
INSERT INTO siakad.master_wilayah VALUES ('190605', 3, 'ID', 'Kec. Mallusetasi', '190600');
INSERT INTO siakad.master_wilayah VALUES ('190606', 3, 'ID', 'Kec. Balusu', '190600');
INSERT INTO siakad.master_wilayah VALUES ('190607', 3, 'ID', 'Kec. Pujananting', '190600');
INSERT INTO siakad.master_wilayah VALUES ('190700', 2, 'ID', 'Kab. Bone', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190701', 3, 'ID', 'Kec. Bontocani', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190702', 3, 'ID', 'Kec. Kahu', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190703', 3, 'ID', 'Kec. Kajuara', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190704', 3, 'ID', 'Kec. Selomekko', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190705', 3, 'ID', 'Kec. Tonra', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190706', 3, 'ID', 'Kec. Patimpeng', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190707', 3, 'ID', 'Kec. Libureng', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190708', 3, 'ID', 'Kec. Mare', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190709', 3, 'ID', 'Kec. Sibulue', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190710', 3, 'ID', 'Kec. Cina', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190711', 3, 'ID', 'Kec. Barebbo', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190712', 3, 'ID', 'Kec. Ponre', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190713', 3, 'ID', 'Kec. Lappariaja', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190714', 3, 'ID', 'Kec. Lamuru', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190715', 3, 'ID', 'Kec. Bengo', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190716', 3, 'ID', 'Kec. Ulaweng', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190717', 3, 'ID', 'Kec. Palakka', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190718', 3, 'ID', 'Kec. Awangpone', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190719', 3, 'ID', 'Kec. Tellu Siattinge', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190720', 3, 'ID', 'Kec. Amali', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190721', 3, 'ID', 'Kec. Ajangale', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190722', 3, 'ID', 'Kec. Dua Boccoe', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190723', 3, 'ID', 'Kec. Cenrana', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190724', 3, 'ID', 'Kec. Tanete Riattang Barat', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190725', 3, 'ID', 'Kec. Tanete Riattang', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190726', 3, 'ID', 'Kec. Tanete Riattang Timur', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190727', 3, 'ID', 'Kec. Tellu Limpoe', '190700');
INSERT INTO siakad.master_wilayah VALUES ('190800', 2, 'ID', 'Kab. Wajo', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190801', 3, 'ID', 'Kec. Sabbangparu', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190802', 3, 'ID', 'Kec. Tempe', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190803', 3, 'ID', 'Kec. Pammana', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190804', 3, 'ID', 'Kec. Bola', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190805', 3, 'ID', 'Kec. Takkalala', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190806', 3, 'ID', 'Kec. Sajo Anging', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190807', 3, 'ID', 'Kec. Majauleng', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190808', 3, 'ID', 'Kec. Tanasitolo', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190809', 3, 'ID', 'Kec. Belawa', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190810', 3, 'ID', 'Kec. Maniang Pajo', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190811', 3, 'ID', 'Kec. Keera', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190812', 3, 'ID', 'Kec. Pitumpanua', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190813', 3, 'ID', 'Kec. Gilireng', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190814', 3, 'ID', 'Kec. Penrang', '190800');
INSERT INTO siakad.master_wilayah VALUES ('190900', 2, 'ID', 'Kab. Soppeng', '190000');
INSERT INTO siakad.master_wilayah VALUES ('190901', 3, 'ID', 'Kec. Mariowiwawo', '190900');
INSERT INTO siakad.master_wilayah VALUES ('190902', 3, 'ID', 'Kec. Lalabata', '190900');
INSERT INTO siakad.master_wilayah VALUES ('190903', 3, 'ID', 'Kec. Liliriaja', '190900');
INSERT INTO siakad.master_wilayah VALUES ('190904', 3, 'ID', 'Kec. Lili Rilau', '190900');
INSERT INTO siakad.master_wilayah VALUES ('190905', 3, 'ID', 'Kec. Donri-Donri', '190900');
INSERT INTO siakad.master_wilayah VALUES ('190906', 3, 'ID', 'Kec. Mario Riawa', '190900');
INSERT INTO siakad.master_wilayah VALUES ('190907', 3, 'ID', 'Kec. Ganra', '190900');
INSERT INTO siakad.master_wilayah VALUES ('190908', 3, 'ID', 'Kec. Citta', '190900');
INSERT INTO siakad.master_wilayah VALUES ('191000', 2, 'ID', 'Kab. Bantaeng', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191001', 3, 'ID', 'Kec. Bissappu', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191002', 3, 'ID', 'Kec. Bantaeng', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191003', 3, 'ID', 'Kec. Tompobulu', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191004', 3, 'ID', 'Kec. Ulu Ere', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191005', 3, 'ID', 'Kec. Ere Merasa', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191006', 3, 'ID', 'Kec. Pa`jukukang', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191007', 3, 'ID', 'Kec. Gantarang Keke', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191008', 3, 'ID', 'Kec. Sinoa', '191000');
INSERT INTO siakad.master_wilayah VALUES ('191100', 2, 'ID', 'Kab. Bulukumba', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191101', 3, 'ID', 'Kec. Gantarang', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191102', 3, 'ID', 'Kec. Ujung Bulu', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191103', 3, 'ID', 'Kec. Bontobahari', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191104', 3, 'ID', 'Kec. Bontotiro', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191105', 3, 'ID', 'Kec. Hero Lange-Lange', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191106', 3, 'ID', 'Kec. Kajang', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191107', 3, 'ID', 'Kec. Bulukumba', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191108', 3, 'ID', 'Kec. Rilau Ale', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191109', 3, 'ID', 'Kec. Kindang', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191110', 3, 'ID', 'Kec. Ujung Loe', '191100');
INSERT INTO siakad.master_wilayah VALUES ('191200', 2, 'ID', 'Kab. Sinjai', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191201', 3, 'ID', 'Kec. Sinjai Barat', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191202', 3, 'ID', 'Kec. Sinjai Borong', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191203', 3, 'ID', 'Kec. Sinjai Selatan', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191204', 3, 'ID', 'Kec. Tellu Limpoe', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191205', 3, 'ID', 'Kec. Sinjai Timur', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191206', 3, 'ID', 'Kec. Sinjai Tengah', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191207', 3, 'ID', 'Kec. Sinjai Utara', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191208', 3, 'ID', 'Kec. Bulupoddo', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191209', 3, 'ID', 'Kec. Pulau Sembilan', '191200');
INSERT INTO siakad.master_wilayah VALUES ('191300', 2, 'ID', 'Kab. Selayar', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191301', 3, 'ID', 'Kec. Pasimarannu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191302', 3, 'ID', 'Kec. Pasimassunggu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191303', 3, 'ID', 'Kec. Bontosikuyu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191304', 3, 'ID', 'Kec. Bontoharu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191305', 3, 'ID', 'Kec. Bontomatene', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191306', 3, 'ID', 'Kec. Bontomanai', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191307', 3, 'ID', 'Kec. Benteng', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191308', 3, 'ID', 'Kec. Taka Bonerate', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191309', 3, 'ID', 'Kec. Pasilambena', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191310', 3, 'ID', 'Kec. Pasimasunggu Timur', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191311', 3, 'ID', 'Kec. Buki', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191390', 3, 'ID', 'Pasimasunggu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('191400', 2, 'ID', 'Kab. Pinrang', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191401', 3, 'ID', 'Kec. Suppa', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191402', 3, 'ID', 'Kec. Mattiro Sompe', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191403', 3, 'ID', 'Kec. Mattiro Bulu', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191404', 3, 'ID', 'Kec. Watang Sawitto', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191405', 3, 'ID', 'Kec. Patampanua', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191406', 3, 'ID', 'Kec. Cempa', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191407', 3, 'ID', 'Kec. Duampanua', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191408', 3, 'ID', 'Kec. Lembang', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191409', 3, 'ID', 'Kec. Lanrisang', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191410', 3, 'ID', 'Kec. Tiroang', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191411', 3, 'ID', 'Kec. Paleteang', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191412', 3, 'ID', 'Kec. Batulappa', '191400');
INSERT INTO siakad.master_wilayah VALUES ('191500', 2, 'ID', 'Kab. Sidenreng Rappang', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191501', 3, 'ID', 'Kec. Panca Lautang', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191502', 3, 'ID', 'Kec. Tellulimpoe', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191503', 3, 'ID', 'Kec. Watangpulu', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191504', 3, 'ID', 'Kec. Baranti', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191505', 3, 'ID', 'Kec. Panca Rijang', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191506', 3, 'ID', 'Kec. Maritengae', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191507', 3, 'ID', 'Kec. Pitu Riawa', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191508', 3, 'ID', 'Kec. Duapitue', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191509', 3, 'ID', 'Kec. Kulo', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191510', 3, 'ID', 'Kec. Pitu Riase', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191511', 3, 'ID', 'Kec. Watang Sidenreng', '191500');
INSERT INTO siakad.master_wilayah VALUES ('191600', 2, 'ID', 'Kab. Enrekang', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191601', 3, 'ID', 'Kec. Maiwa', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191602', 3, 'ID', 'Kec. Enrekang', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191603', 3, 'ID', 'Kec. Barakka', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191604', 3, 'ID', 'Kec. Anggeraja', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191605', 3, 'ID', 'Kec. Alla', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191606', 3, 'ID', 'Kec. Bungin', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191607', 3, 'ID', 'Kec. Cendana', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191608', 3, 'ID', 'Kec. Curio', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191609', 3, 'ID', 'Kec. Malua', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191610', 3, 'ID', 'Kec. Buntu Batu', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191611', 3, 'ID', 'Kec. Masale', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191612', 3, 'ID', 'Kec. Baroko', '191600');
INSERT INTO siakad.master_wilayah VALUES ('191700', 2, 'ID', 'Kab. Luwu', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191701', 3, 'ID', 'Kec. Larompong', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191702', 3, 'ID', 'Kec. Suli', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191703', 3, 'ID', 'Kec. Belopa', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191704', 3, 'ID', 'Kec. Bajo', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191705', 3, 'ID', 'Kec. Bassesangtempe', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191706', 3, 'ID', 'Kec. Buaponrang', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191707', 3, 'ID', 'Kec. Bua', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191708', 3, 'ID', 'Kec. Walenrang', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191709', 3, 'ID', 'Kec. Lamasi', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191710', 3, 'ID', 'Kec. Latimojong', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191711', 3, 'ID', 'Kec. Larompong Selatan', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191712', 3, 'ID', 'Kec. Kamanre', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191713', 3, 'ID', 'Kec. Walenrang Barat', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191714', 3, 'ID', 'Kec. Walenrang Utara', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191715', 3, 'ID', 'Kec. Walenrang Timur', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191716', 3, 'ID', 'Kec. Lamasi Timur', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191717', 3, 'ID', 'Kec. Suli Barat', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191718', 3, 'ID', 'Kec. Bajo Barat', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191719', 3, 'ID', 'Kec. Ponrang Selatan', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191720', 3, 'ID', 'Kec. Ponrang', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191721', 3, 'ID', 'Kec. Bolopa Utara', '191700');
INSERT INTO siakad.master_wilayah VALUES ('191800', 2, 'ID', 'Kab. Tana Toraja', '190000');
INSERT INTO siakad.master_wilayah VALUES ('191801', 3, 'ID', 'Kec. Bonggakaradeng', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191802', 3, 'ID', 'Kec. Mengkendek', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191803', 3, 'ID', 'Kec. Sangalla', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191804', 3, 'ID', 'Kec. Makale', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191805', 3, 'ID', 'Kec. Saluputti', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191810', 3, 'ID', 'Kec. Simbuang', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191811', 3, 'ID', 'Kec. Rantetayo', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191812', 3, 'ID', 'Kec. Bittuang', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191813', 3, 'ID', 'Kec. Ranomeeto', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191814', 3, 'ID', 'Kec. Mappak', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191815', 3, 'ID', 'Kec. Gadang Batu Silanan', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191816', 3, 'ID', 'Kec. Sangala Selatan', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191817', 3, 'ID', 'Kec. Sangala Utara', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191818', 3, 'ID', 'Kec. Makale Selatan', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191819', 3, 'ID', 'Kec. Makale Utara', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191820', 3, 'ID', 'Kec. Rembon', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191821', 3, 'ID', 'Kec. Masanda', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191822', 3, 'ID', 'Kec. Malimbong Balepe', '191800');
INSERT INTO siakad.master_wilayah VALUES ('191823', 3, 'ID', 'Kec. Kurra', '191800');
INSERT INTO siakad.master_wilayah VALUES ('192400', 2, 'ID', 'Kab. Luwu Utara', '190000');
INSERT INTO siakad.master_wilayah VALUES ('192401', 3, 'ID', 'Kec. Sabbang', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192402', 3, 'ID', 'Kec. Baebunta', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192403', 3, 'ID', 'Kec. Malangke', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192404', 3, 'ID', 'Kec. Sukamaju', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192405', 3, 'ID', 'Kec. Bone-Bone', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192412', 3, 'ID', 'Kec. Massamba', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192413', 3, 'ID', 'Kec. Limbong', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192415', 3, 'ID', 'Kec. Mappedeceng', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192416', 3, 'ID', 'Kec. Sekko', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192417', 3, 'ID', 'Kec. Rampi', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192418', 3, 'ID', 'Kec. Malangke Barat', '192400');
INSERT INTO siakad.master_wilayah VALUES ('192490', 3, 'ID', 'Tana Lili', '      ');
INSERT INTO siakad.master_wilayah VALUES ('192600', 2, 'ID', 'Kab. Luwu Timur', '190000');
INSERT INTO siakad.master_wilayah VALUES ('192601', 3, 'ID', 'Kec. Burau', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192602', 3, 'ID', 'Kec. Tomoni', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192603', 3, 'ID', 'Kec. Wotu', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192604', 3, 'ID', 'Kec. Malili', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192605', 3, 'ID', 'Kec. Nuha', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192606', 3, 'ID', 'Kec. Mangkutana', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192607', 3, 'ID', 'Kec. Towuti', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192608', 3, 'ID', 'Kec. Angkona', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192609', 3, 'ID', 'Kec. Tomoni Timur', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192610', 3, 'ID', 'Kec. Kalaena', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192611', 3, 'ID', 'Kec. Wasuponda', '192600');
INSERT INTO siakad.master_wilayah VALUES ('192700', 2, 'ID', 'Kab. Toraja Utara', '190000');
INSERT INTO siakad.master_wilayah VALUES ('192701', 3, 'ID', 'Kec. Awan Rante karua', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192702', 3, 'ID', 'Kec. Balusu', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192703', 3, 'ID', 'Kec. Bengkelekila', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192704', 3, 'ID', 'Kec. Baruppu', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192705', 3, 'ID', 'Kec. Buntao', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192706', 3, 'ID', 'Kec. Kapala Pitu', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192707', 3, 'ID', 'Kec. Kesu', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192708', 3, 'ID', 'Kec. Nanggala', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192709', 3, 'ID', 'Kec. Rantebua', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192710', 3, 'ID', 'Kec. Rantepao', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192711', 3, 'ID', 'Kec. Rindingallo', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192712', 3, 'ID', 'Kec. Sa`dan', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192713', 3, 'ID', 'Kec. Sanggalangi', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192714', 3, 'ID', 'Kec. Sesean', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192715', 3, 'ID', 'Kec. Sesean Suloara', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192716', 3, 'ID', 'Kec. Sopai', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192717', 3, 'ID', 'Kec. Tallunglipu', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192718', 3, 'ID', 'Kec. Tikala', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192719', 3, 'ID', 'Kec. Tondon', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192720', 3, 'ID', 'Kec. Dende` Piongan Napo', '192700');
INSERT INTO siakad.master_wilayah VALUES ('192721', 3, 'ID', 'Kec. Buntu Pepasan', '192700');
INSERT INTO siakad.master_wilayah VALUES ('196000', 2, 'ID', 'Kota Makassar', '190000');
INSERT INTO siakad.master_wilayah VALUES ('196001', 3, 'ID', 'Kec. Mariso', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196002', 3, 'ID', 'Kec. Mamajang', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196003', 3, 'ID', 'Kec. Tamalate', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196004', 3, 'ID', 'Kec. Makasar', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196005', 3, 'ID', 'Kec. Ujung Pandang', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196006', 3, 'ID', 'Kec. Wajo', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196007', 3, 'ID', 'Kec. Bontoala', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196008', 3, 'ID', 'Kec. Ujung Tanah', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196009', 3, 'ID', 'Kec. Tallo', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196010', 3, 'ID', 'Kec. Panakukkang', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196011', 3, 'ID', 'Kec. Biringkanaya', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196012', 3, 'ID', 'Kec. Tamalanrea', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196013', 3, 'ID', 'Kec. Rappocini', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196014', 3, 'ID', 'Kec. Manggala', '196000');
INSERT INTO siakad.master_wilayah VALUES ('196100', 2, 'ID', 'Kota Pare-Pare', '190000');
INSERT INTO siakad.master_wilayah VALUES ('196101', 3, 'ID', 'Kec. Bacukiki', '196100');
INSERT INTO siakad.master_wilayah VALUES ('196102', 3, 'ID', 'Kec. Ujung', '196100');
INSERT INTO siakad.master_wilayah VALUES ('196103', 3, 'ID', 'Kec. Soreang', '196100');
INSERT INTO siakad.master_wilayah VALUES ('196104', 3, 'ID', 'Kec. Bacukiki Barat', '196100');
INSERT INTO siakad.master_wilayah VALUES ('196200', 2, 'ID', 'Kota Palopo', '190000');
INSERT INTO siakad.master_wilayah VALUES ('196201', 3, 'ID', 'Kec. Wara', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196202', 3, 'ID', 'Kec. Wara Utara', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196203', 3, 'ID', 'Kec. Wara Selatan', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196204', 3, 'ID', 'Kec. Telluwanua', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196205', 3, 'ID', 'Kec. Wara Timur', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196206', 3, 'ID', 'Kec. Wara Barat', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196207', 3, 'ID', 'Kec. Sendana', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196208', 3, 'ID', 'Kec. Mungkajang', '196200');
INSERT INTO siakad.master_wilayah VALUES ('196209', 3, 'ID', 'Kec. Bara', '196200');
INSERT INTO siakad.master_wilayah VALUES ('200000', 1, 'ID', 'Prov. Sulawesi Tenggara', '000000');
INSERT INTO siakad.master_wilayah VALUES ('200100', 2, 'ID', 'Kab. Konawe', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200108', 3, 'ID', 'Kec. Soropia', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200109', 3, 'ID', 'Kec. Sampara', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200112', 3, 'ID', 'Kec. Lambuya', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200114', 3, 'ID', 'Kec. Pondidaha', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200115', 3, 'ID', 'Kec. Wawotobi', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200116', 3, 'ID', 'Kec. Unaaha', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200118', 3, 'ID', 'Kec. Abuki', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200124', 3, 'ID', 'Kec. BondoAla', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200125', 3, 'ID', 'Kec. Uepai', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200126', 3, 'ID', 'Kec. Wonggeduku', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200128', 3, 'ID', 'Kec. Tongauna', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200130', 3, 'ID', 'Kec. Latoma', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200131', 3, 'ID', 'Kec. Besulutu', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200132', 3, 'ID', 'Kec. Puriala', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200133', 3, 'ID', 'Kec. Meluhu', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200134', 3, 'ID', 'Kec. Amonggedo', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200135', 3, 'ID', 'Kec. Wawonii Barat', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200136', 3, 'ID', 'Kec. Wawonii Timur', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200137', 3, 'ID', 'Kec. Wawonii Selatan', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200138', 3, 'ID', 'Kec. Wawonii Utara', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200139', 3, 'ID', 'Kec. Routa', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200140', 3, 'ID', 'Kec. Anggaberi', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200141', 3, 'ID', 'Kec. Wawoni Tengah', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200142', 3, 'ID', 'Kec. Kapoiala', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200143', 3, 'ID', 'Kec. Konawe', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200144', 3, 'ID', 'Asinua', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200145', 3, 'ID', 'Wawonii Tenggara', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200146', 3, 'ID', 'Wawonii Timur Laut', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200147', 3, 'ID', 'Lalonggasumeeto', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200148', 3, 'ID', 'Onembute', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200200', 2, 'ID', 'Kab. Muna', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200201', 3, 'ID', 'Kec. Tongkuno', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200202', 3, 'ID', 'Kec. Parigi', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200203', 3, 'ID', 'Kec. Kabawo', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200205', 3, 'ID', 'Kec. Lawa', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200206', 3, 'ID', 'Kec. Kusambi', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200207', 3, 'ID', 'Kec. Katobu', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200208', 3, 'ID', 'Kec. Napabalano', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200209', 3, 'ID', 'Kec. Wakorumba Selatan', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200215', 3, 'ID', 'Kec. Lohia', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200216', 3, 'ID', 'Kec. Kontunaga', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200217', 3, 'ID', 'Kec. Sawerigadi', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200218', 3, 'ID', 'Kec. Maginti', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200219', 3, 'ID', 'Kec. Kabangka', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200220', 3, 'ID', 'Kec. Maligano', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200224', 3, 'ID', 'Kec. Tiworo Tengah', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200225', 3, 'ID', 'Kec. Barangka', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200226', 3, 'ID', 'Kec. Watopute', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200227', 3, 'ID', 'Kec. Batalaiworu', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200228', 3, 'ID', 'Kec. Duruka', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200229', 3, 'ID', 'Kec. Lasalepa', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200230', 3, 'ID', 'Kec. Pasir Putih', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200232', 3, 'ID', 'Kec. Tiworo Kepulauan', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200233', 3, 'ID', 'Kec. Bone', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200234', 3, 'ID', 'Kontu Kowuna', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200235', 3, 'ID', 'Marobo', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200236', 3, 'ID', 'Tongkuno Selatan', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200237', 3, 'ID', 'Pasi Kolaga', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200238', 3, 'ID', 'Batukara', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200239', 3, 'ID', 'Wa Daga', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200240', 3, 'ID', 'Napano Kusambi', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200241', 3, 'ID', 'Towea', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200242', 3, 'ID', 'Tiworo Selatan', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200243', 3, 'ID', 'Tiworo Utara', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200300', 2, 'ID', 'Kab. Buton', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200305', 3, 'ID', 'Kec. Lasalimu', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200306', 3, 'ID', 'Kec. Pasar Wajo', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200307', 3, 'ID', 'Kec. Sampolawa', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200308', 3, 'ID', 'Kec. Batauga', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200311', 3, 'ID', 'Kec. Kapontori', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200312', 3, 'ID', 'Kec. Gu', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200313', 3, 'ID', 'Kec. Lakudo', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200314', 3, 'ID', 'Kec. Mawasangka', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200321', 3, 'ID', 'Kec. Lasalimu Selatan', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200322', 3, 'ID', 'Kec. Batu Atas', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200323', 3, 'ID', 'Kec. Siompu', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200324', 3, 'ID', 'Kec. Kadatua', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200325', 3, 'ID', 'Kec. Mawasangka Timur', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200326', 3, 'ID', 'Kec. Talaga Raya', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200328', 3, 'ID', 'Kec. Mawasangka Tengah', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200329', 3, 'ID', 'Kec. Sangia Wambulu', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200330', 3, 'ID', 'Kec. Siontapia', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200331', 3, 'ID', 'Kec. Wolowa', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200332', 3, 'ID', 'Kec. Wabula', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200333', 3, 'ID', 'Kec. Lapandewa', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200334', 3, 'ID', 'Kec. Siompu Barat', '200300');
INSERT INTO siakad.master_wilayah VALUES ('200400', 2, 'ID', 'Kab. Kolaka', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200401', 3, 'ID', 'Kec. Watubangga', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200402', 3, 'ID', 'Kec. Pomalaa', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200403', 3, 'ID', 'Kec. Wundulako', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200404', 3, 'ID', 'Kec. Ladongi', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200405', 3, 'ID', 'Kec. Tirawuta', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200406', 3, 'ID', 'Kec. Kolaka', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200407', 3, 'ID', 'Kec. Wolo', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200408', 3, 'ID', 'Kec. Mowewe', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200412', 3, 'ID', 'Kec. Tanggetada', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200413', 3, 'ID', 'Kec. Baula', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200414', 3, 'ID', 'Kec. Lambandia', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200415', 3, 'ID', 'Kec. Latambaga', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200416', 3, 'ID', 'Kec. Samaturu', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200417', 3, 'ID', 'Kec. Uluiwoi', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200418', 3, 'ID', 'Kec. Tinondo', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200419', 3, 'ID', 'Kec. Poli-Polia', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200420', 3, 'ID', 'Kec. Lalolae', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200421', 3, 'ID', 'Kec. Toari', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200422', 3, 'ID', 'Kec. Polinggona', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200423', 3, 'ID', 'Kec. Loela', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200424', 3, 'ID', 'Tirawuta', '      ');
INSERT INTO siakad.master_wilayah VALUES ('200425', 3, 'ID', 'Ladongi', '      ');
INSERT INTO siakad.master_wilayah VALUES ('200426', 3, 'ID', 'Poli-polia', '      ');
INSERT INTO siakad.master_wilayah VALUES ('200427', 3, 'ID', 'Lambandia', '      ');
INSERT INTO siakad.master_wilayah VALUES ('200428', 3, 'ID', 'Uluiwoi', '      ');
INSERT INTO siakad.master_wilayah VALUES ('200429', 3, 'ID', 'Mowewe', '      ');
INSERT INTO siakad.master_wilayah VALUES ('200500', 2, 'ID', 'Kab. Konawe Selatan', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200501', 3, 'ID', 'Kec. Tinanggea', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200502', 3, 'ID', 'Kec. Palangga', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200503', 3, 'ID', 'Kec. Konda', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200504', 3, 'ID', 'Kec. Lainea', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200505', 3, 'ID', 'Kec. Moramo', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200506', 3, 'ID', 'Kec. Ranomeeto', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200507', 3, 'ID', 'Kec. Landono', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200508', 3, 'ID', 'Kec. Kolono', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200509', 3, 'ID', 'Kec. Andolo', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200510', 3, 'ID', 'Kec. Laonti', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200511', 3, 'ID', 'Kec. Angata', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200512', 3, 'ID', 'Kec. Lalembuu', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200513', 3, 'ID', 'Kec. Buke', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200514', 3, 'ID', 'Kec. Palangga Selatan', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200515', 3, 'ID', 'Kec. Baito', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200516', 3, 'ID', 'Kec. Laeya', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200517', 3, 'ID', 'Kec. Moramo Utara', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200518', 3, 'ID', 'Kec. Wolasi', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200519', 3, 'ID', 'Kec. Ranomeeto Barat', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200520', 3, 'ID', 'Kec. Mowila', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200521', 3, 'ID', 'Kec. Benua', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200522', 3, 'ID', 'Kec. Basala', '200500');
INSERT INTO siakad.master_wilayah VALUES ('200600', 2, 'ID', 'Kab. Wakatobi', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200601', 3, 'ID', 'Kec. Binongko', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200602', 3, 'ID', 'Kec. Tomia', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200603', 3, 'ID', 'Kec. Kaledupa', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200604', 3, 'ID', 'Kec. Wangi-Wangi', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200605', 3, 'ID', 'Kec. Wangi-Wangi Selatan', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200606', 3, 'ID', 'Kec. Kaledupa Selatan', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200607', 3, 'ID', 'Kec. Tomia Timur', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200608', 3, 'ID', 'Kec. Togo Binongko', '200600');
INSERT INTO siakad.master_wilayah VALUES ('200700', 2, 'ID', 'Kab. Bombana', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200701', 3, 'ID', 'Kec. Kabaena', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200702', 3, 'ID', 'Kec. Kabaena Timur', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200703', 3, 'ID', 'Kec. Poleang', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200704', 3, 'ID', 'Kec. Poleang Timur', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200705', 3, 'ID', 'Kec. Rumbia', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200706', 3, 'ID', 'Kec. Rarowatu', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200707', 3, 'ID', 'Kec. Poleang Barat', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200708', 3, 'ID', 'Kec. Mataelo', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200709', 3, 'ID', 'Kec. Rarowatu Utara', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200710', 3, 'ID', 'Kec. Poleang Utara', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200711', 3, 'ID', 'Kec. Poleang Selatan', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200712', 3, 'ID', 'Kec. Poleang Tenggara', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200713', 3, 'ID', 'Kec. Kabaena Selatan', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200714', 3, 'ID', 'Kec. Kabaena Barat', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200715', 3, 'ID', 'Kec. Kabaena Utara', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200716', 3, 'ID', 'Kec. Kabaena Tengah', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200717', 3, 'ID', 'Kec. Kep. Masaloka Raya', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200718', 3, 'ID', 'Kec. Rumbia Tengah', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200719', 3, 'ID', 'Kec. Poleang Tengah', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200720', 3, 'ID', 'Kec. Tatonuwu', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200721', 3, 'ID', 'Kec. Lantari Jaya', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200722', 3, 'ID', 'Kec. Mata Usu', '200700');
INSERT INTO siakad.master_wilayah VALUES ('200800', 2, 'ID', 'Kab. Kolaka Utara', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200801', 3, 'ID', 'Kec. Lasusua', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200802', 3, 'ID', 'Kec. Pakue', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200803', 3, 'ID', 'Kec. Batu Putih', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200804', 3, 'ID', 'Kec. Ranteangin', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200805', 3, 'ID', 'Kec. Kodeoha', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200806', 3, 'ID', 'Kec. Ngapa', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200807', 3, 'ID', 'Kec. Wawo', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200808', 3, 'ID', 'Kec. Lambai', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200809', 3, 'ID', 'Kec. Watunohu', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200810', 3, 'ID', 'Kec. Pakue Tengah', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200811', 3, 'ID', 'Kec. Pakue Utara', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200812', 3, 'ID', 'Kec. Porehu', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200813', 3, 'ID', 'Kec. Katoi', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200814', 3, 'ID', 'Kec. Tiwu', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200815', 3, 'ID', 'Kec. Katoi', '200800');
INSERT INTO siakad.master_wilayah VALUES ('200890', 3, 'ID', 'Tolala', '      ');
INSERT INTO siakad.master_wilayah VALUES ('200900', 2, 'ID', 'Kab. Konawe Utara', '200000');
INSERT INTO siakad.master_wilayah VALUES ('200901', 3, 'ID', 'Kec. Langkima', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200902', 3, 'ID', 'Kec. Molawe', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200903', 3, 'ID', 'Kec. Lembo', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200904', 3, 'ID', 'Kec. Asera', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200905', 3, 'ID', 'Kec. Wiwirano', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200906', 3, 'ID', 'Kec. Lasolo', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200907', 3, 'ID', 'Kec. Sawa', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200908', 3, 'ID', 'Kec. Oheo', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200909', 3, 'ID', 'Kec. Andowia', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200910', 3, 'ID', 'Kec. Motui', '200900');
INSERT INTO siakad.master_wilayah VALUES ('201000', 2, 'ID', 'Kab. Buton Utara', '200000');
INSERT INTO siakad.master_wilayah VALUES ('201001', 3, 'ID', 'Kec. Kulisusu', '201000');
INSERT INTO siakad.master_wilayah VALUES ('201002', 3, 'ID', 'Kec. Kulisusu Barat', '201000');
INSERT INTO siakad.master_wilayah VALUES ('201003', 3, 'ID', 'Kec. Kulisusu Utara', '201000');
INSERT INTO siakad.master_wilayah VALUES ('201004', 3, 'ID', 'Kec. Kambowa', '201000');
INSERT INTO siakad.master_wilayah VALUES ('201005', 3, 'ID', 'Kec. Bonenugu', '201000');
INSERT INTO siakad.master_wilayah VALUES ('201006', 3, 'ID', 'Kec. Wakorumba Utara', '201000');
INSERT INTO siakad.master_wilayah VALUES ('201099', 3, 'ID', 'Wakorumba Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('201111', 3, 'ID', 'Loea', '      ');
INSERT INTO siakad.master_wilayah VALUES ('201115', 3, 'ID', 'Lalolae', '      ');
INSERT INTO siakad.master_wilayah VALUES ('206000', 2, 'ID', 'Kota Kendari', '200000');
INSERT INTO siakad.master_wilayah VALUES ('206001', 3, 'ID', 'Kec. Mandonga', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206002', 3, 'ID', 'Kec. Poasia', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206003', 3, 'ID', 'Kec. Kendari', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206004', 3, 'ID', 'Kec. Baruga', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206005', 3, 'ID', 'Kec. Kendari Barat', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206006', 3, 'ID', 'Kec. Abeli', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206007', 3, 'ID', 'Kec. Puwato', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206008', 3, 'ID', 'Kec. Kadia', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206009', 3, 'ID', 'Kec. Wua-Wua', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206010', 3, 'ID', 'Kec. Kambu', '206000');
INSERT INTO siakad.master_wilayah VALUES ('206100', 2, 'ID', 'Kota Baubau', '200000');
INSERT INTO siakad.master_wilayah VALUES ('206101', 3, 'ID', 'Kec. Betoambari', '206100');
INSERT INTO siakad.master_wilayah VALUES ('206102', 3, 'ID', 'Kec. Wolio', '206100');
INSERT INTO siakad.master_wilayah VALUES ('206103', 3, 'ID', 'Kec. Sorowalio', '206100');
INSERT INTO siakad.master_wilayah VALUES ('206104', 3, 'ID', 'Kec. Bungi', '206100');
INSERT INTO siakad.master_wilayah VALUES ('206105', 3, 'ID', 'Kec. Murhum', '206100');
INSERT INTO siakad.master_wilayah VALUES ('206106', 3, 'ID', 'Kec. Kokalukuna', '206100');
INSERT INTO siakad.master_wilayah VALUES ('206107', 3, 'ID', 'Kec. Lea-Lea', '206100');
INSERT INTO siakad.master_wilayah VALUES ('210000', 1, 'ID', 'Prov. Maluku', '000000');
INSERT INTO siakad.master_wilayah VALUES ('210100', 2, 'ID', 'Kab. Maluku Tengah', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210101', 3, 'ID', 'Kec. Banda', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210104', 3, 'ID', 'Kec. Tehoru', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210105', 3, 'ID', 'Kec. Amahai', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210106', 3, 'ID', 'Kec. Teon Nila Serua', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210108', 3, 'ID', 'Kec. Saparua', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210109', 3, 'ID', 'Kec. Pulau Haruku', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210110', 3, 'ID', 'Kec. Salahutu', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210111', 3, 'ID', 'Kec. Leihitu', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210114', 3, 'ID', 'Kec. Seram Utara', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210116', 3, 'ID', 'Kec. Masohi', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210117', 3, 'ID', 'Kec. Nusa Laut', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210118', 3, 'ID', 'Kec. Teluk Elpaputih', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210119', 3, 'ID', 'Kec. Seram Utara Barat', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210120', 3, 'ID', 'Kec. Leihitu Barat', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210121', 3, 'ID', 'Telutih', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210122', 3, 'ID', 'Seram Utara Timur Seti', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210123', 3, 'ID', 'Seram Utara Timur Kobi', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210200', 2, 'ID', 'Kab. Maluku Tenggara', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210201', 3, 'ID', 'Kec. Kei Kecil', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210202', 3, 'ID', 'Kec. Kei Besar', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210205', 3, 'ID', 'Kec. Kei Besar Selatan', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210206', 3, 'ID', 'Kec. Kei Besar Utara Timur', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210212', 3, 'ID', 'Kec. Kei Kecil Barat', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210213', 3, 'ID', 'Kec. Kei Kecil Timur', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210300', 2, 'ID', 'Kab. Buru', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210304', 3, 'ID', 'Kec. Air Buaya', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210307', 3, 'ID', 'Kec. Waeapo', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210310', 3, 'ID', 'Kec. Namlea', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210316', 3, 'ID', 'Kec. Waplau', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210317', 3, 'ID', 'Kec. Bata Baul', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210400', 2, 'ID', 'Kab. Maluku Tenggara Barat', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210401', 3, 'ID', 'Kec. Pulau-pulau Terselatan', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210403', 3, 'ID', 'Kec. Pulau-Pulau Babar', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210404', 3, 'ID', 'Kec. Tanimbar Selatan', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210405', 3, 'ID', 'Kec. Tanimbar Utara', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210406', 3, 'ID', 'Kec. Damer', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210411', 3, 'ID', 'Kec. Wer Tamrian', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210412', 3, 'ID', 'Kec. Wer Maktian', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210413', 3, 'ID', 'Kec. Selaru', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210414', 3, 'ID', 'Kec. Yaru', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210415', 3, 'ID', 'Kec. Wuar Labobar', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210416', 3, 'ID', 'Kec. Nirun Mas', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210417', 3, 'ID', 'Kec. Kormomolin', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210418', 3, 'ID', 'Kec. Molu Maru', '210400');
INSERT INTO siakad.master_wilayah VALUES ('210500', 2, 'ID', 'Kab. Seram Bagian Barat', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210501', 3, 'ID', 'Kec. Kairatu', '210500');
INSERT INTO siakad.master_wilayah VALUES ('210502', 3, 'ID', 'Kec. Seram Barat', '210500');
INSERT INTO siakad.master_wilayah VALUES ('210503', 3, 'ID', 'Kec. Taniwel', '210500');
INSERT INTO siakad.master_wilayah VALUES ('210504', 3, 'ID', 'Kec. Waisala', '210500');
INSERT INTO siakad.master_wilayah VALUES ('210505', 3, 'ID', 'Huamual', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210590', 3, 'ID', 'Inamosol', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210591', 3, 'ID', 'Elpaputih', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210592', 3, 'ID', 'Taniwel Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210593', 3, 'ID', 'Huamual Belakang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210594', 3, 'ID', 'Kepulauan Manipa', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210599', 3, 'ID', 'Kairatu Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210600', 2, 'ID', 'Kab. Seram Bagian Timur', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210601', 3, 'ID', 'Kec. Seram Timur', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210602', 3, 'ID', 'Kec. Werinama', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210603', 3, 'ID', 'Kec. Bula', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210604', 3, 'ID', 'Kec. Pulau-pulau Gorom', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210605', 3, 'ID', 'Kec. Wakate', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210606', 3, 'ID', 'Kec. Tutuk Tolu', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210700', 2, 'ID', 'Kab. Kepulauan Aru', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210701', 3, 'ID', 'Kec. Pulau-Pulau Aru', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210702', 3, 'ID', 'Kec. Aru Tengah', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210703', 3, 'ID', 'Kec. Aru Selatan', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210704', 3, 'ID', 'Kec. Aru Selatan Timur', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210705', 3, 'ID', 'Kec. Aru Tengah Timur', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210706', 3, 'ID', 'Kec. Aru Tengah Selatan', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210707', 3, 'ID', 'Kec. Aru Utara', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210708', 3, 'ID', 'Kec. Batuley', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210709', 3, 'ID', 'Kec. Sir-Sir', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210710', 3, 'ID', 'Kec. Aru Selatan Utara', '210700');
INSERT INTO siakad.master_wilayah VALUES ('210800', 2, 'ID', 'Kab. Maluku Barat Daya', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210801', 3, 'ID', 'Kec. Babar Timur', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210803', 3, 'ID', 'Kec. Mdona Hiera', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210804', 3, 'ID', 'Kec. Moa Lakor', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210805', 3, 'ID', 'Kec. Pulau Letti', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210808', 3, 'ID', 'Kec. Wetar', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210809', 3, 'ID', 'Damer', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210810', 3, 'ID', 'Pulau-pulau Babar', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210811', 3, 'ID', 'Pulau-pulau Terselatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('210900', 2, 'ID', 'Kab. Buru Selatan', '210000');
INSERT INTO siakad.master_wilayah VALUES ('210901', 3, 'ID', 'Kec. Ambalau', '210900');
INSERT INTO siakad.master_wilayah VALUES ('210902', 3, 'ID', 'Kec. Kepala Madan', '210900');
INSERT INTO siakad.master_wilayah VALUES ('210903', 3, 'ID', 'Kec. Leksula', '210900');
INSERT INTO siakad.master_wilayah VALUES ('210904', 3, 'ID', 'Kec. Namrole', '210900');
INSERT INTO siakad.master_wilayah VALUES ('210905', 3, 'ID', 'Kec. Waesama', '210900');
INSERT INTO siakad.master_wilayah VALUES ('216000', 2, 'ID', 'Kota Ambon', '210000');
INSERT INTO siakad.master_wilayah VALUES ('216001', 3, 'ID', 'Kec. Nusaniwe', '216000');
INSERT INTO siakad.master_wilayah VALUES ('216002', 3, 'ID', 'Kec. Sirimau', '216000');
INSERT INTO siakad.master_wilayah VALUES ('216003', 3, 'ID', 'Kec. Teluk Ambon', '216000');
INSERT INTO siakad.master_wilayah VALUES ('216005', 3, 'ID', 'Kec. Baguala', '216000');
INSERT INTO siakad.master_wilayah VALUES ('216006', 3, 'ID', 'Kec. Lei Timur Selatan', '216000');
INSERT INTO siakad.master_wilayah VALUES ('216100', 2, 'ID', 'Kota. Tual', '210000');
INSERT INTO siakad.master_wilayah VALUES ('216101', 3, 'ID', 'Kec. PP Kur Mangur', '216100');
INSERT INTO siakad.master_wilayah VALUES ('216102', 3, 'ID', 'Kec. Pulau Dullah Selatan', '216100');
INSERT INTO siakad.master_wilayah VALUES ('216103', 3, 'ID', 'Kec. Pulau Dullah Utara', '216100');
INSERT INTO siakad.master_wilayah VALUES ('216104', 3, 'ID', 'Kec. Tayando Tam', '216100');
INSERT INTO siakad.master_wilayah VALUES ('220000', 1, 'ID', 'Prov. Bali', '000000');
INSERT INTO siakad.master_wilayah VALUES ('220100', 2, 'ID', 'Kab. Buleleng', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220101', 3, 'ID', 'Kec. Gerokgak', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220102', 3, 'ID', 'Kec. Seririt', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220103', 3, 'ID', 'Kec. Busungbiu', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220104', 3, 'ID', 'Kec. Banjar', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220105', 3, 'ID', 'Kec. Sukasada', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220106', 3, 'ID', 'Kec. Buleleng', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220107', 3, 'ID', 'Kec. Sawan', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220108', 3, 'ID', 'Kec. Kubutambahan', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220109', 3, 'ID', 'Kec. Tejakula', '220100');
INSERT INTO siakad.master_wilayah VALUES ('220200', 2, 'ID', 'Kab. Jembrana', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220201', 3, 'ID', 'Kec. Melaya', '220200');
INSERT INTO siakad.master_wilayah VALUES ('220202', 3, 'ID', 'Kec. Negara', '220200');
INSERT INTO siakad.master_wilayah VALUES ('220203', 3, 'ID', 'Kec. Mendoyo', '220200');
INSERT INTO siakad.master_wilayah VALUES ('220204', 3, 'ID', 'Kec. Pekutatan', '220200');
INSERT INTO siakad.master_wilayah VALUES ('220205', 3, 'ID', 'Kec. Jembrana', '220200');
INSERT INTO siakad.master_wilayah VALUES ('220300', 2, 'ID', 'Kab. Tabanan', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220301', 3, 'ID', 'Kec. Selemadeg', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220302', 3, 'ID', 'Kec. Kerambitan', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220303', 3, 'ID', 'Kec. Tabanan', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220304', 3, 'ID', 'Kec. Kediri', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220305', 3, 'ID', 'Kec. Marga', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220306', 3, 'ID', 'Kec. Baturiti', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220307', 3, 'ID', 'Kec. Penebel', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220308', 3, 'ID', 'Kec. Pupuan', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220309', 3, 'ID', 'Kec. Selemadeg Barat', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220310', 3, 'ID', 'Kec. Selemadeg Timur', '220300');
INSERT INTO siakad.master_wilayah VALUES ('220400', 2, 'ID', 'Kab. Badung', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220401', 3, 'ID', 'Kec. Kuta Selatan', '220400');
INSERT INTO siakad.master_wilayah VALUES ('220402', 3, 'ID', 'Kec. Kuta', '220400');
INSERT INTO siakad.master_wilayah VALUES ('220403', 3, 'ID', 'Kec. Kuta Utara', '220400');
INSERT INTO siakad.master_wilayah VALUES ('220404', 3, 'ID', 'Kec. Mengwi', '220400');
INSERT INTO siakad.master_wilayah VALUES ('220405', 3, 'ID', 'Kec. Abiansemal', '220400');
INSERT INTO siakad.master_wilayah VALUES ('220406', 3, 'ID', 'Kec. Petang', '220400');
INSERT INTO siakad.master_wilayah VALUES ('220500', 2, 'ID', 'Kab. Gianyar', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220501', 3, 'ID', 'Kec. Sukawati', '220500');
INSERT INTO siakad.master_wilayah VALUES ('220502', 3, 'ID', 'Kec. Blahbatuh', '220500');
INSERT INTO siakad.master_wilayah VALUES ('220503', 3, 'ID', 'Kec. Gianyar', '220500');
INSERT INTO siakad.master_wilayah VALUES ('220504', 3, 'ID', 'Kec. Tampak siring', '220500');
INSERT INTO siakad.master_wilayah VALUES ('220505', 3, 'ID', 'Kec. Ubud', '220500');
INSERT INTO siakad.master_wilayah VALUES ('220506', 3, 'ID', 'Kec. Tegallalang', '220500');
INSERT INTO siakad.master_wilayah VALUES ('220507', 3, 'ID', 'Kec. Payangan', '220500');
INSERT INTO siakad.master_wilayah VALUES ('220600', 2, 'ID', 'Kab. Klungkung', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220601', 3, 'ID', 'Kec. Nusapenida', '220600');
INSERT INTO siakad.master_wilayah VALUES ('220602', 3, 'ID', 'Kec. Banjarangkan', '220600');
INSERT INTO siakad.master_wilayah VALUES ('220603', 3, 'ID', 'Kec. Klungkung', '220600');
INSERT INTO siakad.master_wilayah VALUES ('220604', 3, 'ID', 'Kec. Dawan', '220600');
INSERT INTO siakad.master_wilayah VALUES ('220700', 2, 'ID', 'Kab. Bangli', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220701', 3, 'ID', 'Kec. Susut', '220700');
INSERT INTO siakad.master_wilayah VALUES ('220702', 3, 'ID', 'Kec. Bangli', '220700');
INSERT INTO siakad.master_wilayah VALUES ('220703', 3, 'ID', 'Kec. Tembuku', '220700');
INSERT INTO siakad.master_wilayah VALUES ('220704', 3, 'ID', 'Kec. Kintamani', '220700');
INSERT INTO siakad.master_wilayah VALUES ('220800', 2, 'ID', 'Kab. Karang Asem', '220000');
INSERT INTO siakad.master_wilayah VALUES ('220801', 3, 'ID', 'Kec. Rendang', '220800');
INSERT INTO siakad.master_wilayah VALUES ('220802', 3, 'ID', 'Kec. Sidemen', '220800');
INSERT INTO siakad.master_wilayah VALUES ('220803', 3, 'ID', 'Kec. Manggis', '220800');
INSERT INTO siakad.master_wilayah VALUES ('220804', 3, 'ID', 'Kec. Karang asem', '220800');
INSERT INTO siakad.master_wilayah VALUES ('220805', 3, 'ID', 'Kec. Abang', '220800');
INSERT INTO siakad.master_wilayah VALUES ('220806', 3, 'ID', 'Kec. Bebandem', '220800');
INSERT INTO siakad.master_wilayah VALUES ('220807', 3, 'ID', 'Kec. Selat', '220800');
INSERT INTO siakad.master_wilayah VALUES ('220808', 3, 'ID', 'Kec. Kubu', '220800');
INSERT INTO siakad.master_wilayah VALUES ('226000', 2, 'ID', 'Kota Denpasar', '220000');
INSERT INTO siakad.master_wilayah VALUES ('226001', 3, 'ID', 'Kec. Denpasar Selatan', '226000');
INSERT INTO siakad.master_wilayah VALUES ('226002', 3, 'ID', 'Kec. Denpasar Timur', '226000');
INSERT INTO siakad.master_wilayah VALUES ('226003', 3, 'ID', 'Kec. Denpasar Barat', '226000');
INSERT INTO siakad.master_wilayah VALUES ('226004', 3, 'ID', 'Kec. Denpasar Utara', '226000');
INSERT INTO siakad.master_wilayah VALUES ('230000', 1, 'ID', 'Prov. Nusa Tenggara Barat', '000000');
INSERT INTO siakad.master_wilayah VALUES ('230100', 2, 'ID', 'Kab. Lombok Barat', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230101', 3, 'ID', 'Kec. Sekotong Tengah', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230102', 3, 'ID', 'Kec. Gerung', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230103', 3, 'ID', 'Kec. Labuapi', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230104', 3, 'ID', 'Kec. Kediri', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230105', 3, 'ID', 'Kec. Narmada', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230106', 3, 'ID', 'Kec. Gunung Sari', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230110', 3, 'ID', 'Kec. Kuripan', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230112', 3, 'ID', 'Kec. Lembar', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230114', 3, 'ID', 'Kec. Batu Layar', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230115', 3, 'ID', 'Kec. Lingsar', '230100');
INSERT INTO siakad.master_wilayah VALUES ('230200', 2, 'ID', 'Kab. Lombok Tengah', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230201', 3, 'ID', 'Kec. Praya Barat', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230202', 3, 'ID', 'Kec. Pujut', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230203', 3, 'ID', 'Kec. Praya Timur', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230204', 3, 'ID', 'Kec. Janapria', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230205', 3, 'ID', 'Kec. Kopang', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230206', 3, 'ID', 'Kec. Praya', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230207', 3, 'ID', 'Kec. Jonggat', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230208', 3, 'ID', 'Kec. Pringgarata', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230209', 3, 'ID', 'Kec. Batukliang', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230210', 3, 'ID', 'Kec. Batukliang Utara', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230211', 3, 'ID', 'Kec. Praya Barat Daya', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230212', 3, 'ID', 'Kec. Praya Tengah', '230200');
INSERT INTO siakad.master_wilayah VALUES ('230300', 2, 'ID', 'Kab. Lombok Timur', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230301', 3, 'ID', 'Kec. Keruak', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230302', 3, 'ID', 'Kec. Sakra', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230303', 3, 'ID', 'Kec. Terara', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230304', 3, 'ID', 'Kec. Sikur', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230305', 3, 'ID', 'Kec. Masbagik', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230306', 3, 'ID', 'Kec. Sukamulia', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230307', 3, 'ID', 'Kec. Selong', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230308', 3, 'ID', 'Kec. Pringgabaya', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230309', 3, 'ID', 'Kec. Aikmel', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230310', 3, 'ID', 'Kec. Sambelia', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230311', 3, 'ID', 'Kec. Labuhan Haji', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230312', 3, 'ID', 'Kec. Suralaga', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230313', 3, 'ID', 'Kec. Sakra Timur', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230314', 3, 'ID', 'Kec. Sakra Barat', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230315', 3, 'ID', 'Kec. Jerowaru', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230316', 3, 'ID', 'Kec. Pringgasela', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230317', 3, 'ID', 'Kec. Montong Gading', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230318', 3, 'ID', 'Kec. Wanasaba', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230319', 3, 'ID', 'Kec. Sembalun', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230320', 3, 'ID', 'Kec. Suela', '230300');
INSERT INTO siakad.master_wilayah VALUES ('230400', 2, 'ID', 'Kab. Sumbawa', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230402', 3, 'ID', 'Kec. Lunyuk', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230405', 3, 'ID', 'Kec. Alas', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230407', 3, 'ID', 'Kec. Batu Lanten', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230408', 3, 'ID', 'Kec. Sumbawa', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230409', 3, 'ID', 'Kec. Moyo Hilir', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230410', 3, 'ID', 'Kec. Moyo Hulu', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230411', 3, 'ID', 'Kec. Ropang', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230413', 3, 'ID', 'Kec. Plampang', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230414', 3, 'ID', 'Kec. Empang', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230415', 3, 'ID', 'Kec. Labuhan Badas', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230416', 3, 'ID', 'Kec. Alas Barat', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230419', 3, 'ID', 'Kec. Labangka', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230420', 3, 'ID', 'Kec. Unter Iwes', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230421', 3, 'ID', 'Kec. Rhee', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230422', 3, 'ID', 'Kec. Buer', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230423', 3, 'ID', 'Kec. Moyo Utara', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230424', 3, 'ID', 'Kec. Maronge', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230425', 3, 'ID', 'Kec. Tarano', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230426', 3, 'ID', 'Kec. Lopok', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230427', 3, 'ID', 'Kec. Lenangguar', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230428', 3, 'ID', 'Kec. Orong Telu', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230429', 3, 'ID', 'Kec. Utan', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230430', 3, 'ID', 'Kec. Lape', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230431', 3, 'ID', 'Kec. Lantung', '230400');
INSERT INTO siakad.master_wilayah VALUES ('230500', 2, 'ID', 'Kab. Dompu', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230501', 3, 'ID', 'Kec. Hu`u', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230502', 3, 'ID', 'Kec. Dompu', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230503', 3, 'ID', 'Kec. Woja', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230504', 3, 'ID', 'Kec. Kilo', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230505', 3, 'ID', 'Kec. Kempo', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230506', 3, 'ID', 'Kec. Pekat', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230507', 3, 'ID', 'Kec. Pajo', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230508', 3, 'ID', 'Kec. Manggelewa', '230500');
INSERT INTO siakad.master_wilayah VALUES ('230600', 2, 'ID', 'Kab. Bima', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230601', 3, 'ID', 'Kec. Monta', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230602', 3, 'ID', 'Kec. Bolo', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230603', 3, 'ID', 'Kec. Woha', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230604', 3, 'ID', 'Kec. Belo', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230605', 3, 'ID', 'Kec. Wawo', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230606', 3, 'ID', 'Kec. Sape', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230607', 3, 'ID', 'Kec. Wera', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230608', 3, 'ID', 'Kec. Donggo', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230609', 3, 'ID', 'Kec. Sanggar', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230610', 3, 'ID', 'Kec. Lambu', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230611', 3, 'ID', 'Kec. Tambora', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230612', 3, 'ID', 'Kec. Ambalawi', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230613', 3, 'ID', 'Kec. Mada pangga', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230614', 3, 'ID', 'Kec. Langgudu', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230615', 3, 'ID', 'Kec. Soromandi', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230616', 3, 'ID', 'Kec. Parado', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230617', 3, 'ID', 'Kec. Lambitu', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230618', 3, 'ID', 'Kec. Palibelo', '230600');
INSERT INTO siakad.master_wilayah VALUES ('230700', 2, 'ID', 'Kab. Sumbawa Barat', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230701', 3, 'ID', 'Kec. Jereweh', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230702', 3, 'ID', 'Kec. Taliwang', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230703', 3, 'ID', 'Kec. Seteluk', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230704', 3, 'ID', 'Kec. Brang Rea', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230705', 3, 'ID', 'Kec. Sekongkang', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230706', 3, 'ID', 'Kec. Maluk', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230707', 3, 'ID', 'Kec. Brang Ene', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230708', 3, 'ID', 'Kec. Poto Tano', '230700');
INSERT INTO siakad.master_wilayah VALUES ('230800', 2, 'ID', 'Kab. Lombok Utara', '230000');
INSERT INTO siakad.master_wilayah VALUES ('230801', 3, 'ID', 'Kec. Tanjung', '230800');
INSERT INTO siakad.master_wilayah VALUES ('230802', 3, 'ID', 'Kec. Gangga', '230800');
INSERT INTO siakad.master_wilayah VALUES ('230803', 3, 'ID', 'Kec. Bayan', '230800');
INSERT INTO siakad.master_wilayah VALUES ('230804', 3, 'ID', 'Kec. Pemenang', '230800');
INSERT INTO siakad.master_wilayah VALUES ('230805', 3, 'ID', 'Kec. Kayangan', '230800');
INSERT INTO siakad.master_wilayah VALUES ('236000', 2, 'ID', 'Kota Mataram', '230000');
INSERT INTO siakad.master_wilayah VALUES ('236001', 3, 'ID', 'Kec. Ampenan', '236000');
INSERT INTO siakad.master_wilayah VALUES ('236002', 3, 'ID', 'Kec. Mataram', '236000');
INSERT INTO siakad.master_wilayah VALUES ('236003', 3, 'ID', 'Kec. Cakranegara', '236000');
INSERT INTO siakad.master_wilayah VALUES ('236004', 3, 'ID', 'Kec. Sekarbela', '236000');
INSERT INTO siakad.master_wilayah VALUES ('236005', 3, 'ID', 'Kec. Selaperang', '236000');
INSERT INTO siakad.master_wilayah VALUES ('236006', 3, 'ID', 'Kec. Sandubaya', '236000');
INSERT INTO siakad.master_wilayah VALUES ('236100', 2, 'ID', 'Kota Bima', '230000');
INSERT INTO siakad.master_wilayah VALUES ('236101', 3, 'ID', 'Kec. RasanaE Barat', '236100');
INSERT INTO siakad.master_wilayah VALUES ('236102', 3, 'ID', 'Kec. RasanaE Timur', '236100');
INSERT INTO siakad.master_wilayah VALUES ('236103', 3, 'ID', 'Kec. Asakota', '236100');
INSERT INTO siakad.master_wilayah VALUES ('236104', 3, 'ID', 'Kec. Raba', '236100');
INSERT INTO siakad.master_wilayah VALUES ('236105', 3, 'ID', 'Kec. Mpunda', '236100');
INSERT INTO siakad.master_wilayah VALUES ('240000', 1, 'ID', 'Prov. Nusa Tenggara Timur', '000000');
INSERT INTO siakad.master_wilayah VALUES ('240100', 2, 'ID', 'Kab. Kupang', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240101', 3, 'ID', 'Kec. Raijua', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240102', 3, 'ID', 'Kec. Sabu Barat', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240103', 3, 'ID', 'Kec. Sabu Timur', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240110', 3, 'ID', 'Kec. Semau', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240111', 3, 'ID', 'Kec. Kupang Barat', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240112', 3, 'ID', 'Kec. Kupang Tengah', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240113', 3, 'ID', 'Kec. Amarasi', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240114', 3, 'ID', 'Kec. Kupang Timur', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240115', 3, 'ID', 'Kec. Sulamu', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240116', 3, 'ID', 'Kec. Fatuleu', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240117', 3, 'ID', 'Kec. Takari', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240118', 3, 'ID', 'Kec. Amfoang Selatan', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240119', 3, 'ID', 'Kec. Amfoang Utara', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240120', 3, 'ID', 'Kec. Sabu Tengah', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240121', 3, 'ID', 'Kec. Nekamese', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240122', 3, 'ID', 'Kec. Amabi Oefeto Timur', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240123', 3, 'ID', 'Kec. Amarasi Selatan', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240124', 3, 'ID', 'Kec. Amarasi Timur', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240125', 3, 'ID', 'Kec. Amarasi Barat', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240126', 3, 'ID', 'Kec. Amfoang Barat Daya', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240127', 3, 'ID', 'Kec. Amfoang Barat Laut', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240128', 3, 'ID', 'Kec. Sabu Liae', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240129', 3, 'ID', 'Kec. Hawu Mehara', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240130', 3, 'ID', 'Kec. Semau Selatan', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240131', 3, 'ID', 'Kec. Taebenu', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240132', 3, 'ID', 'Kec. Amabi Oefeto', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240133', 3, 'ID', 'Kec. Fatuleu Tengah', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240134', 3, 'ID', 'Kec. Fatuleu Barat', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240135', 3, 'ID', 'Kec. Amfoang Timur', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240136', 3, 'ID', 'Kec. Amfoang Tengah', '240100');
INSERT INTO siakad.master_wilayah VALUES ('240300', 2, 'ID', 'Kab. Timor Tengah Selatan', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240301', 3, 'ID', 'Kec. Mollo Utara', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240302', 3, 'ID', 'Kec. Mollo Selatan', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240303', 3, 'ID', 'Kec. Kota Soe', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240304', 3, 'ID', 'Kec. Amanuban Barat', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240305', 3, 'ID', 'Kec. Amanuban Selatan', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240306', 3, 'ID', 'Kec. Kuanfatu', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240307', 3, 'ID', 'Kec. Amanuban Tengah', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240308', 3, 'ID', 'Kec. Amanuban Timur', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240309', 3, 'ID', 'Kec. Kie', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240310', 3, 'ID', 'Kec. Amanatun Selatan', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240311', 3, 'ID', 'Kec. Amanatun Utara', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240312', 3, 'ID', 'Kec. Fatumnasi', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240313', 3, 'ID', 'Kec. Polen', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240314', 3, 'ID', 'Kec. BatuPutih', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240315', 3, 'ID', 'Kec. Boking', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240316', 3, 'ID', 'Kec. Noebana', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240317', 3, 'ID', 'Kec. Nunkolo', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240318', 3, 'ID', 'Kec. Kot`Olin', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240319', 3, 'ID', 'Kec. Oenino', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240320', 3, 'ID', 'Kec. Kolbano', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240321', 3, 'ID', 'Kec. Kualin', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240322', 3, 'ID', 'Kec. Toianas', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240323', 3, 'ID', 'Kec. Mollo Barat', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240324', 3, 'ID', 'Kec. Kok Baun', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240325', 3, 'ID', 'Kec. Tobu', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240326', 3, 'ID', 'Kec. Nunbena', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240327', 3, 'ID', 'Kec. Mollo Tengah', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240328', 3, 'ID', 'Kec. Kuatnana', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240329', 3, 'ID', 'Kec. Noebeba', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240330', 3, 'ID', 'Kec. Fautmolo', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240331', 3, 'ID', 'Kec. Fatukopa', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240332', 3, 'ID', 'Kec. Santian', '240300');
INSERT INTO siakad.master_wilayah VALUES ('240400', 2, 'ID', 'Kab. Timor Tengah Utara', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240401', 3, 'ID', 'Kec. Miomafo Barat', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240402', 3, 'ID', 'Kec. Miomafo Timur', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240403', 3, 'ID', 'Kec. Kota Kefamenanu', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240404', 3, 'ID', 'Kec. Insana', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240405', 3, 'ID', 'Kec. Biboki Selatan', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240406', 3, 'ID', 'Kec. Biboki Utara', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240407', 3, 'ID', 'Kec. Noemuti', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240408', 3, 'ID', 'Kec. Insana Utara', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240409', 3, 'ID', 'Kec. Biboki Anleu', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240410', 3, 'ID', 'Kec. Noemuti Timur', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240411', 3, 'ID', 'Kec. Miomafo Tengah', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240412', 3, 'ID', 'Kec. Musi', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240413', 3, 'ID', 'Kec. Mutis', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240414', 3, 'ID', 'Kec. Bikomi Selatan', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240415', 3, 'ID', 'Kec. Bikomi Tengah', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240416', 3, 'ID', 'Kec. Bikomi Nilulat', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240417', 3, 'ID', 'Kec. Bikomi Utara', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240418', 3, 'ID', 'Kec. Naibenu', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240419', 3, 'ID', 'Kec. Insana Fafinesu', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240420', 3, 'ID', 'Kec. Insana Barat', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240421', 3, 'ID', 'Kec. Insana Tengah', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240422', 3, 'ID', 'Kec. Biboki Tanpah', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240423', 3, 'ID', 'Kec. Biboki Moenleu', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240424', 3, 'ID', 'Kec. Biboki Feotleu', '240400');
INSERT INTO siakad.master_wilayah VALUES ('240500', 2, 'ID', 'Kab. Belu', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240501', 3, 'ID', 'Kec. Malaka Barat', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240502', 3, 'ID', 'Kec. Malaka Tengah', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240503', 3, 'ID', 'Kec. Malaka Timur', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240504', 3, 'ID', 'Kec. Kobalima', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240505', 3, 'ID', 'Kec. Tasifeto Barat', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240506', 3, 'ID', 'Kec. Kota Atambua', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240507', 3, 'ID', 'Kec. Tasifeto Timur', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240508', 3, 'ID', 'Kec. Lamakmen', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240509', 3, 'ID', 'Kec. Kakuluk Mesak', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240510', 3, 'ID', 'Kec. Raihat', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240511', 3, 'ID', 'Kec. Rinhat', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240512', 3, 'ID', 'Kec. Sasita Mean', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240513', 3, 'ID', 'Kec. Weliman', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240514', 3, 'ID', 'Kec. Wewiku', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240515', 3, 'ID', 'Kec. Rai Manuk', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240516', 3, 'ID', 'Kec. Laen Manen', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240517', 3, 'ID', 'Kec. Lasiolat', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240518', 3, 'ID', 'Kec. Lamakmen Selatan', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240519', 3, 'ID', 'Kec. Lo Kufeu', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240520', 3, 'ID', 'Kec. Botin Leo Bele', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240521', 3, 'ID', 'Kec. Atambua Barat', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240522', 3, 'ID', 'Kec. Atambua Selatan', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240523', 3, 'ID', 'Kec. Nanaet Duabesi', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240524', 3, 'ID', 'Kec. Kobalima Timur', '240500');
INSERT INTO siakad.master_wilayah VALUES ('240525', 3, 'ID', 'Malaka Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240526', 3, 'ID', 'Malaka Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240527', 3, 'ID', 'Kobalima', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240528', 3, 'ID', 'Sasitamean', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240529', 3, 'ID', 'Laen Manen', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240530', 3, 'ID', 'Io Kufeu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240531', 3, 'ID', 'Botin Leo Bele', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240532', 3, 'ID', 'Kobalima Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240533', 3, 'ID', 'Rinhat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240534', 3, 'ID', 'Wewiku', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240535', 3, 'ID', 'Weliman', '      ');
INSERT INTO siakad.master_wilayah VALUES ('240600', 2, 'ID', 'Kab. Alor', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240602', 3, 'ID', 'Kec. Alor Barat Daya', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240603', 3, 'ID', 'Kec. Alor Selatan', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240604', 3, 'ID', 'Kec. Alor Timur', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240605', 3, 'ID', 'Kec. Teluk Mutiara', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240606', 3, 'ID', 'Kec. Alor Barat Laut', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240607', 3, 'ID', 'Kec. Pantar', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240608', 3, 'ID', 'Kec. Alor Timur Laut', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240609', 3, 'ID', 'Kec. Alor Tengah Utara', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240610', 3, 'ID', 'Kec. Pantar Barat', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240611', 3, 'ID', 'Kec. Pantar Timur', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240612', 3, 'ID', 'Kec. Pantar Barat Laut', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240613', 3, 'ID', 'Kec. Pantar Tengah', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240614', 3, 'ID', 'Kec. Mataru', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240615', 3, 'ID', 'Kec. Pureman', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240616', 3, 'ID', 'Kec. Kabola', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240617', 3, 'ID', 'Kec. Pulau Pura', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240618', 3, 'ID', 'Kec. Lembur', '240600');
INSERT INTO siakad.master_wilayah VALUES ('240700', 2, 'ID', 'Kab. Flores Timur', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240701', 3, 'ID', 'Kec. Wulang Gitang', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240702', 3, 'ID', 'Kec. Tanjung Bunga', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240703', 3, 'ID', 'Kec. Larantuka', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240704', 3, 'ID', 'Kec. Solor Barat', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240705', 3, 'ID', 'Kec. Solor Timur', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240706', 3, 'ID', 'Kec. Adonara Barat', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240707', 3, 'ID', 'Kec. Adonara Timur', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240708', 3, 'ID', 'Kec. Titehena', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240709', 3, 'ID', 'Kec. Ile Boleng', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240710', 3, 'ID', 'Kec. Witihama', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240711', 3, 'ID', 'Kec. Kelubagolit', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240712', 3, 'ID', 'Kec. Wotan Ulumado', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240713', 3, 'ID', 'Kec. Ile Mandiri', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240714', 3, 'ID', 'Kec. Demon Pagong', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240715', 3, 'ID', 'Kec. Lewolema', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240716', 3, 'ID', 'Kec. Ilebura', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240717', 3, 'ID', 'Kec. Adonara', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240718', 3, 'ID', 'Kec. Adonara Tengah', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240719', 3, 'ID', 'Kec. Solor Selatan', '240700');
INSERT INTO siakad.master_wilayah VALUES ('240800', 2, 'ID', 'Kab. Sikka', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240801', 3, 'ID', 'Kec. Paga', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240802', 3, 'ID', 'Kec. Lela', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240803', 3, 'ID', 'Kec. Bola', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240804', 3, 'ID', 'Kec. Talibura', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240805', 3, 'ID', 'Kec. Kewapante', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240806', 3, 'ID', 'Kec. Nelle', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240807', 3, 'ID', 'Kec. Nitta', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240808', 3, 'ID', 'Kec. Alok', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240809', 3, 'ID', 'Kec. Mego', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240810', 3, 'ID', 'Kec. Waigete', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240811', 3, 'ID', 'Kec. Palue', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240812', 3, 'ID', 'Kec. Waiblama', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240813', 3, 'ID', 'Kec. Alok Barat', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240814', 3, 'ID', 'Kec. Alok Timur', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240815', 3, 'ID', 'Kec. Magependa', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240816', 3, 'ID', 'Kec. Koting', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240817', 3, 'ID', 'Kec. Tana Wawo', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240818', 3, 'ID', 'Kec. Hewokloang', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240819', 3, 'ID', 'Kec. Kangae', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240820', 3, 'ID', 'Kec. Doreng', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240821', 3, 'ID', 'Kec. Mapitara', '240800');
INSERT INTO siakad.master_wilayah VALUES ('240900', 2, 'ID', 'Kab. Ende', '240000');
INSERT INTO siakad.master_wilayah VALUES ('240901', 3, 'ID', 'Kec. Nangapanda', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240902', 3, 'ID', 'Kec. Ende', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240903', 3, 'ID', 'Kec. Ende Selatan', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240904', 3, 'ID', 'Kec. Ndona', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240905', 3, 'ID', 'Kec. Wolowaru', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240906', 3, 'ID', 'Kec. Maurole', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240907', 3, 'ID', 'Kec. Detusoko', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240909', 3, 'ID', 'Kec. Maukaro', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240910', 3, 'ID', 'Kec. Wewaria', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240911', 3, 'ID', 'Kec. Wolojita', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240912', 3, 'ID', 'Kec. Pulau Ende', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240913', 3, 'ID', 'Kec. Kota Baru', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240914', 3, 'ID', 'Kec. Ndona Timur', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240915', 3, 'ID', 'Kec. Kelimutu', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240916', 3, 'ID', 'Kec. Lio Timur', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240917', 3, 'ID', 'Kec. Detukeli', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240918', 3, 'ID', 'Kec. Ndori', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240919', 3, 'ID', 'Kec. Ende Utara', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240920', 3, 'ID', 'Kec. Ende Tengah', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240921', 3, 'ID', 'Kec. Ende Timur', '240900');
INSERT INTO siakad.master_wilayah VALUES ('240922', 3, 'ID', 'Kec. Lepembusu Kelisoke', '240900');
INSERT INTO siakad.master_wilayah VALUES ('241000', 2, 'ID', 'Kab. Ngada', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241001', 3, 'ID', 'Kec. Aimere', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241002', 3, 'ID', 'Kec. Bajawa', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241003', 3, 'ID', 'Kec. Golewa', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241007', 3, 'ID', 'Kec. Bajawa Utara', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241008', 3, 'ID', 'Kec. Riung', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241012', 3, 'ID', 'Kec. Riung Barat', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241013', 3, 'ID', 'Kec. Soa', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241015', 3, 'ID', 'Kec. Jerebuu', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241017', 3, 'ID', 'Kec. Riung Selatan', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241100', 2, 'ID', 'Kab. Manggarai', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241104', 3, 'ID', 'Kec. Satarmese', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241111', 3, 'ID', 'Kec. Langke Rembong', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241112', 3, 'ID', 'Kec. Ruteng', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241113', 3, 'ID', 'Kec. Cibal', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241114', 3, 'ID', 'Kec. Reok', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241117', 3, 'ID', 'Kec. Wae Ri`I', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241118', 3, 'ID', 'Kec. Satar Mese Barat', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241119', 3, 'ID', 'Kec. Rahong Utara', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241120', 3, 'ID', 'Kec. Lelak', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241200', 2, 'ID', 'Kab. Sumba Timur', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241201', 3, 'ID', 'Kec. Lewa', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241202', 3, 'ID', 'Kec. Tabundung', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241203', 3, 'ID', 'Kec. Paberiwai', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241204', 3, 'ID', 'Kec. Pahunga Lodu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241205', 3, 'ID', 'Kec. Rindi', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241206', 3, 'ID', 'Kec. Pandawai', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241207', 3, 'ID', 'Kec. Kota Waingapu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241208', 3, 'ID', 'Kec. Haharu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241209', 3, 'ID', 'Kec. Nggaha Ori Angu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241210', 3, 'ID', 'Kec. Karera', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241211', 3, 'ID', 'Kec. Umalulu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241212', 3, 'ID', 'Kec. Kahaungu Eti', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241213', 3, 'ID', 'Kec. Matawai La Pawu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241214', 3, 'ID', 'Kec. Pinu Pahar', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241215', 3, 'ID', 'Kec. Wulla Waijelu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241216', 3, 'ID', 'Kec. Katala Hamu Lingu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241217', 3, 'ID', 'Kec. Mahu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241218', 3, 'ID', 'Kec. Ngadu Ngala', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241219', 3, 'ID', 'Kec. Kambata Mapambuhang', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241220', 3, 'ID', 'Kec. Kambera', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241221', 3, 'ID', 'Kec. Kanatang', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241222', 3, 'ID', 'Kec. Lewa Tidahu', '241200');
INSERT INTO siakad.master_wilayah VALUES ('241300', 2, 'ID', 'Kab. Sumba Barat', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241305', 3, 'ID', 'Kec. Loli', '241300');
INSERT INTO siakad.master_wilayah VALUES ('241306', 3, 'ID', 'Kec. Kota Waikabubak', '241300');
INSERT INTO siakad.master_wilayah VALUES ('241310', 3, 'ID', 'Kec. Wanokaka', '241300');
INSERT INTO siakad.master_wilayah VALUES ('241311', 3, 'ID', 'Kec. Lamboya', '241300');
INSERT INTO siakad.master_wilayah VALUES ('241318', 3, 'ID', 'Kec. Tana Righu', '241300');
INSERT INTO siakad.master_wilayah VALUES ('241319', 3, 'ID', 'Kec. Laboya Barat', '241300');
INSERT INTO siakad.master_wilayah VALUES ('241400', 2, 'ID', 'Kab. Lembata', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241401', 3, 'ID', 'Kec. Naga Wutung', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241402', 3, 'ID', 'Kec. Atadei', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241403', 3, 'ID', 'Kec. Ile Ape', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241404', 3, 'ID', 'Kec. Lebatukan', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241405', 3, 'ID', 'Kec. Nubatukan', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241406', 3, 'ID', 'Kec. Omesuri', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241407', 3, 'ID', 'Kec. Buyasuri', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241408', 3, 'ID', 'Kec. Wulandoni', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241409', 3, 'ID', 'Kec. Ile Ape Timur', '241400');
INSERT INTO siakad.master_wilayah VALUES ('241500', 2, 'ID', 'Kab. Rote-Ndao', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241504', 3, 'ID', 'Kec. Rote Barat Daya', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241505', 3, 'ID', 'Kec. Rote Barat Laut', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241506', 3, 'ID', 'Kec. Lobalain', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241507', 3, 'ID', 'Kec. Rote Tengah', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241508', 3, 'ID', 'Kec. Pantai Baru', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241509', 3, 'ID', 'Kec. Rote Timur', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241510', 3, 'ID', 'Kec. Rote Barat', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241511', 3, 'ID', 'Kec. Rote Selatan', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241600', 2, 'ID', 'Kab. Manggarai Barat', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241601', 3, 'ID', 'Kec. Komodo', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241602', 3, 'ID', 'Kec. Sano Nggoang', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241603', 3, 'ID', 'Kec. Lembor', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241604', 3, 'ID', 'Kec. Kuwus', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241605', 3, 'ID', 'Kec. Macang Pacar', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241606', 3, 'ID', 'Kec. Boleng', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241607', 3, 'ID', 'Kec. Welak', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241608', 3, 'ID', 'Kec. Ndoso', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241609', 3, 'ID', 'Kec. Lembor Selatan', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241610', 3, 'ID', 'Kec. Mbeliling', '241600');
INSERT INTO siakad.master_wilayah VALUES ('241700', 2, 'ID', 'Kab. Nagakeo', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241701', 3, 'ID', 'Kec. Aesesa', '241700');
INSERT INTO siakad.master_wilayah VALUES ('241702', 3, 'ID', 'Kec. Boawae', '241700');
INSERT INTO siakad.master_wilayah VALUES ('241703', 3, 'ID', 'Kec. Keo Tengah', '241700');
INSERT INTO siakad.master_wilayah VALUES ('241704', 3, 'ID', 'Kec. Mauponggo', '241700');
INSERT INTO siakad.master_wilayah VALUES ('241705', 3, 'ID', 'Kec. Nangaroro', '241700');
INSERT INTO siakad.master_wilayah VALUES ('241706', 3, 'ID', 'Kec. Wolowae', '241700');
INSERT INTO siakad.master_wilayah VALUES ('241708', 3, 'ID', 'Kec. Aesesa Selatan', '241700');
INSERT INTO siakad.master_wilayah VALUES ('241800', 2, 'ID', 'Kab. Sumba Tengah', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241801', 3, 'ID', 'Kec. Katiku Tana', '241800');
INSERT INTO siakad.master_wilayah VALUES ('241802', 3, 'ID', 'Kec. Mamboro', '241800');
INSERT INTO siakad.master_wilayah VALUES ('241803', 3, 'ID', 'Kec. Umbu Ratu Nggay', '241800');
INSERT INTO siakad.master_wilayah VALUES ('241804', 3, 'ID', 'Kec. Umbu Ratu Nggay Barat', '241800');
INSERT INTO siakad.master_wilayah VALUES ('241805', 3, 'ID', 'Kec. Katiku Tana Selatan', '241800');
INSERT INTO siakad.master_wilayah VALUES ('241900', 2, 'ID', 'Kab. Sumba Barat Daya', '240000');
INSERT INTO siakad.master_wilayah VALUES ('241901', 3, 'ID', 'Kec. Kodi', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241902', 3, 'ID', 'Kec. Kodi Bangedo', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241903', 3, 'ID', 'Kec. Loura', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241904', 3, 'ID', 'Kec. Wewewa Barat', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241905', 3, 'ID', 'Kec. Wewewa Selatan', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241906', 3, 'ID', 'Kec. Wewewa Timur', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241907', 3, 'ID', 'Kec. Wewewa Utara', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241908', 3, 'ID', 'Kec. Kodi Utara', '241900');
INSERT INTO siakad.master_wilayah VALUES ('242000', 2, 'ID', 'Kab. Manggarai Timur', '240000');
INSERT INTO siakad.master_wilayah VALUES ('242001', 3, 'ID', 'Kec. Elar', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242002', 3, 'ID', 'Kec. Kota Komba', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242003', 3, 'ID', 'Kec. Lamba Leda', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242004', 3, 'ID', 'Kec. Poco Ranaka', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242005', 3, 'ID', 'Kec. Sambi Rampas', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242006', 3, 'ID', 'Kec. Borong', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242100', 2, 'ID', 'Kab. Sabu Raijua', '240000');
INSERT INTO siakad.master_wilayah VALUES ('242111', 3, 'ID', 'Hawu Mehara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('242112', 3, 'ID', 'Sabu Tengah', '      ');
INSERT INTO siakad.master_wilayah VALUES ('242113', 3, 'ID', 'Raijua', '      ');
INSERT INTO siakad.master_wilayah VALUES ('242114', 3, 'ID', 'Sabu Liae', '      ');
INSERT INTO siakad.master_wilayah VALUES ('242115', 3, 'ID', 'Sabu Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('242116', 3, 'ID', 'Sabu Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('246000', 2, 'ID', 'Kota Kupang', '240000');
INSERT INTO siakad.master_wilayah VALUES ('246001', 3, 'ID', 'Kec. Alak', '246000');
INSERT INTO siakad.master_wilayah VALUES ('246002', 3, 'ID', 'Kec. Maulafa', '246000');
INSERT INTO siakad.master_wilayah VALUES ('246003', 3, 'ID', 'Kec. Oebodo', '246000');
INSERT INTO siakad.master_wilayah VALUES ('246004', 3, 'ID', 'Kec. Kelapa Lima', '246000');
INSERT INTO siakad.master_wilayah VALUES ('246005', 3, 'ID', 'Kec. Kota Raja', '246000');
INSERT INTO siakad.master_wilayah VALUES ('246006', 3, 'ID', 'Kec. Kota Lama', '246000');
INSERT INTO siakad.master_wilayah VALUES ('250000', 1, 'ID', 'Prov. Papua', '000000');
INSERT INTO siakad.master_wilayah VALUES ('250100', 2, 'ID', 'Kab. Jayapura', '250000');
INSERT INTO siakad.master_wilayah VALUES ('250108', 3, 'ID', 'Kec. Kaureh', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250114', 3, 'ID', 'Kec. Kemtuk', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250115', 3, 'ID', 'Kec. Kemtuk Gresie', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250116', 3, 'ID', 'Kec. Nimboran', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250117', 3, 'ID', 'Kec. Nimbokrang', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250118', 3, 'ID', 'Kec. Unurum Guay', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250120', 3, 'ID', 'Kec. Demta', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250121', 3, 'ID', 'Kec. Depapre', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250122', 3, 'ID', 'Kec. Sentani Barat', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250123', 3, 'ID', 'Kec. Sentani', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250124', 3, 'ID', 'Kec. Sentani Timur', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250125', 3, 'ID', 'Kec. Airu', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250126', 3, 'ID', 'Kec. Yapsi', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250127', 3, 'ID', 'Kec. Nimboran Timur/Namblong', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250128', 3, 'ID', 'Kec. Waibu', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250129', 3, 'ID', 'Kec. Ebungfau', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250200', 2, 'ID', 'Kab. Biak Numfor', '250000');
INSERT INTO siakad.master_wilayah VALUES ('250201', 3, 'ID', 'Kec. Numfor Barat', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250202', 3, 'ID', 'Kec. Numfor Timur', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250203', 3, 'ID', 'Kec. Padaido', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250204', 3, 'ID', 'Kec. Biak Timur', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250205', 3, 'ID', 'Kec. Biak Kota', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250206', 3, 'ID', 'Kec. Samofa', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250207', 3, 'ID', 'Kec. Yendidori', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250208', 3, 'ID', 'Kec. Biak Utara', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250209', 3, 'ID', 'Kec. Warsa', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250210', 3, 'ID', 'Kec. Biak Barat', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250211', 3, 'ID', 'Kec. Swandiwe', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250212', 3, 'ID', 'Kec. Orkeri', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250213', 3, 'ID', 'Kec. Bruyandori', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250214', 3, 'ID', 'Kec. Poiru', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250215', 3, 'ID', 'Kec. Ainando Padaido', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250216', 3, 'ID', 'Kec. Oridek', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250217', 3, 'ID', 'Kec. Andey', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250218', 3, 'ID', 'Kec. Yawosi', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250219', 3, 'ID', 'Kec. Bondifuar', '250200');
INSERT INTO siakad.master_wilayah VALUES ('250300', 2, 'ID', 'Kab. Yapen Waropen', '250000');
INSERT INTO siakad.master_wilayah VALUES ('250304', 3, 'ID', 'Kec. Yapen Timur', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250305', 3, 'ID', 'Kec. Angkaisera', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250306', 3, 'ID', 'Kec. Yapen Selatan', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250307', 3, 'ID', 'Kec. Yapen Barat', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250308', 3, 'ID', 'Kec. Poom', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250309', 3, 'ID', 'Kec. Kosiwo', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250310', 3, 'ID', 'Kec. Yapen Utara', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250311', 3, 'ID', 'Kec. Raimbawi', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250312', 3, 'ID', 'Kec. Teluk Ampimoi', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250313', 3, 'ID', 'Kec. Kepulauan Ambai', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250314', 3, 'ID', 'Kec. Wonawa', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250315', 3, 'ID', 'Kec. Windesi', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250700', 2, 'ID', 'Kab. Merauke', '250000');
INSERT INTO siakad.master_wilayah VALUES ('250701', 3, 'ID', 'Kec. Kimaam', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250702', 3, 'ID', 'Kec. Okaba', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250703', 3, 'ID', 'Kec. Kurik', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250704', 3, 'ID', 'Kec. Merauke', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250705', 3, 'ID', 'Kec. Muting', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250724', 3, 'ID', 'Kec. Distrik Ulilin', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250725', 3, 'ID', 'Kec. Semangga', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250726', 3, 'ID', 'Kec. Tanah Miring', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250727', 3, 'ID', 'Kec. Jagebob', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250728', 3, 'ID', 'Kec. Sota', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250729', 3, 'ID', 'Kec. Eligobel', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250730', 3, 'ID', 'Kec. Naukenjerai', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250731', 3, 'ID', 'Kec. Animha', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250732', 3, 'ID', 'Kec. Malind', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250733', 3, 'ID', 'Kec. Tubang', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250734', 3, 'ID', 'Kec. Ngunti', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250736', 3, 'ID', 'Kec. Kaptel', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250737', 3, 'ID', 'Kec. Tabonji', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250738', 3, 'ID', 'Kec. Waan', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250739', 3, 'ID', 'Kec. Ilwayab', '250700');
INSERT INTO siakad.master_wilayah VALUES ('250800', 2, 'ID', 'Kab. Jayawijaya', '250000');
INSERT INTO siakad.master_wilayah VALUES ('250818', 3, 'ID', 'Kec. Asologaima', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250819', 3, 'ID', 'Kec. Kurulu', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250821', 3, 'ID', 'Kec. Abenaho', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250839', 3, 'ID', 'Kec. Walelagama', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250841', 3, 'ID', 'Kec. Musatfak', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250843', 3, 'ID', 'Kec. Asolokobal', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250848', 3, 'ID', 'Kec. Pelebaga', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250849', 3, 'ID', 'Kec. Yalengga', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250854', 3, 'ID', 'Kec. Wamena', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250860', 3, 'ID', 'Kec. Hubikosi', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250862', 3, 'ID', 'Kec. Bolakme', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250863', 3, 'ID', 'Kec. Wollo', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250900', 2, 'ID', 'Kab. Nabire', '250000');
INSERT INTO siakad.master_wilayah VALUES ('250905', 3, 'ID', 'Kec. Uwapa', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250906', 3, 'ID', 'Kec. Yaur', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250907', 3, 'ID', 'Kec. Wanggar', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250908', 3, 'ID', 'Kec. Nabire', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250909', 3, 'ID', 'Kec. Napan', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250910', 3, 'ID', 'Kec. Siriwo', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250911', 3, 'ID', 'Kec. Teluk Umar', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250912', 3, 'ID', 'Kec. Makimi', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250916', 3, 'ID', 'Kec. Teluk Kimi', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250917', 3, 'ID', 'Kec. Yarokibisay', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250922', 3, 'ID', 'Kec. Nabire Barat', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250923', 3, 'ID', 'Kec. Wapoga', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250990', 3, 'ID', 'Dipha', '      ');
INSERT INTO siakad.master_wilayah VALUES ('250999', 3, 'ID', 'Yaro', '      ');
INSERT INTO siakad.master_wilayah VALUES ('251000', 2, 'ID', 'Kab. Paniai', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251003', 3, 'ID', 'Kec. Paniai Timur', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251004', 3, 'ID', 'Kec. Bibida', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251008', 3, 'ID', 'Kec. Paniai Barat', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251009', 3, 'ID', 'Kec. Bogoboida', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251014', 3, 'ID', 'Kec. Yatamo', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251015', 3, 'ID', 'Kec. Kebo', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251016', 3, 'ID', 'Kec. Dumadama', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251018', 3, 'ID', 'Kec. Ekadide', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251019', 3, 'ID', 'Kec. Siriwo', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251090', 3, 'ID', 'Aradide', '      ');
INSERT INTO siakad.master_wilayah VALUES ('251100', 2, 'ID', 'Kab. Puncak Jaya', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251104', 3, 'ID', 'Kec. Fawi', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251105', 3, 'ID', 'Kec. Mulia', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251106', 3, 'ID', 'Kec. Ilu', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251110', 3, 'ID', 'Kec. Mewoluk', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251111', 3, 'ID', 'Kec. Yamo', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251113', 3, 'ID', 'Kec. Torere', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251114', 3, 'ID', 'Kec. Jigonikme', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251115', 3, 'ID', 'Kec. Tingginambut', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251200', 2, 'ID', 'Kab. Mimika', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251201', 3, 'ID', 'Kec. Mimika Barat', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251202', 3, 'ID', 'Kec. Mimika Timur', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251203', 3, 'ID', 'Kec. Mimika Baru', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251204', 3, 'ID', 'Kec. Agimuga', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251205', 3, 'ID', 'Kec. Mimika Barat Jauh', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251206', 3, 'ID', 'Kec. Mimika Barat Tengah', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251209', 3, 'ID', 'Kec. Tembagapura', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251210', 3, 'ID', 'Kec. Jila', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251211', 3, 'ID', 'Kec. Jita', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251212', 3, 'ID', 'Kec. Kuala Kencana', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251213', 3, 'ID', 'Kec. Mimika Timur Tengah', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251214', 3, 'ID', 'Kec. Mimika Timur Jauh', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251300', 2, 'ID', 'Kab. Boven Digoel', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251301', 3, 'ID', 'Kec. Jair', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251302', 3, 'ID', 'Kec. Mindiptana', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251303', 3, 'ID', 'Kec. Mandobo', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251304', 3, 'ID', 'Kec. Kouh', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251305', 3, 'ID', 'Kec. Waropko', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251306', 3, 'ID', 'Kec. Distrik Bomakia', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251307', 3, 'ID', 'Kec. Subur', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251308', 3, 'ID', 'Kec. Iniyandit', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251309', 3, 'ID', 'Kec. Fofi', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251310', 3, 'ID', 'Kec. Arimop', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251311', 3, 'ID', 'Kec. Firiwage', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251312', 3, 'ID', 'Kec. Manggelum', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251313', 3, 'ID', 'Kec. Yaniruma', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251314', 3, 'ID', 'Kec. Ambatkwi', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251315', 3, 'ID', 'Kombut', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251400', 2, 'ID', 'Kab. Mappi', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251401', 3, 'ID', 'Kec. Nambioman Bapai', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251402', 3, 'ID', 'Kec. Edera', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251403', 3, 'ID', 'Kec. Obaa', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251404', 3, 'ID', 'Kec. Haju', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251405', 3, 'ID', 'Kec. Assue', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251406', 3, 'ID', 'Kec. Citakmitak', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251407', 3, 'ID', 'Kec. Minyamur', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251408', 3, 'ID', 'Kec. Venaha', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251409', 3, 'ID', 'Kec. Passue', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251410', 3, 'ID', 'Kec. Kaibar', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251500', 2, 'ID', 'Kab. Asmat', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251501', 3, 'ID', 'Kec. Pantai Kasuari', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251502', 3, 'ID', 'Kec. Fayit', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251503', 3, 'ID', 'Kec. Atsy', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251504', 3, 'ID', 'Kec. Suator', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251505', 3, 'ID', 'Kec. Akat', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251506', 3, 'ID', 'Kec. Agats', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251507', 3, 'ID', 'Kec. Sawaerma', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251600', 2, 'ID', 'Kab. Yahukimo', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251601', 3, 'ID', 'Kec. Kurima', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251602', 3, 'ID', 'Kec. Ninia', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251603', 3, 'ID', 'Kec. Anggruk', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251604', 3, 'ID', 'Kec. Dekai', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251605', 3, 'ID', 'Kec. Obio', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251606', 3, 'ID', 'Kec. Suru Suru', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251607', 3, 'ID', 'Kec. Wusuma', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251608', 3, 'ID', 'Kec. Amuma', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251609', 3, 'ID', 'Kec. Wusaik', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251610', 3, 'ID', 'Kec. Pasema', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251611', 3, 'ID', 'Kec. Hogio', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251612', 3, 'ID', 'Kec. Mogi', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251613', 3, 'ID', 'Kec. Soba', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251614', 3, 'ID', 'Kec. Werima', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251615', 3, 'ID', 'Kec. Tangma', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251616', 3, 'ID', 'Kec. Ukha', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251617', 3, 'ID', 'Kec. Panggema', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251618', 3, 'ID', 'Kec. Kosarek', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251619', 3, 'ID', 'Kec. Nipsan', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251620', 3, 'ID', 'Kec. Ubahak', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251621', 3, 'ID', 'Kec. Pronggoli', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251622', 3, 'ID', 'Kec. Walma', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251623', 3, 'ID', 'Kec. Yahuliambut', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251624', 3, 'ID', 'Kec. Puldama', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251625', 3, 'ID', 'Kec. Hereapingi', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251626', 3, 'ID', 'Kec. Ubahili', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251627', 3, 'ID', 'Kec. Talambo', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251628', 3, 'ID', 'Kec. Endomen', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251629', 3, 'ID', 'Kec. Kona', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251630', 3, 'ID', 'Kec. Dirwemna', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251631', 3, 'ID', 'Kec. Holuwon', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251632', 3, 'ID', 'Kec. Lolat', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251633', 3, 'ID', 'Kec. Soloikma', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251634', 3, 'ID', 'Kec. Sela', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251635', 3, 'ID', 'Kec. Korupun', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251636', 3, 'ID', 'Kec. Langda', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251637', 3, 'ID', 'Kec. Bomela', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251638', 3, 'ID', 'Kec. Suntamon', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251639', 3, 'ID', 'Kec. Seredela', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251640', 3, 'ID', 'Kec. Sobaham', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251641', 3, 'ID', 'Kec. Kabianggama', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251642', 3, 'ID', 'Kec. Kwelamdua', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251643', 3, 'ID', 'Kec. Kwikma', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251644', 3, 'ID', 'Kec. Hilipuk', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251645', 3, 'ID', 'Kec. Duram', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251646', 3, 'ID', 'Kec. Yogosem', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251647', 3, 'ID', 'Kec. Kayo', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251648', 3, 'ID', 'Kec. Sumo', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251649', 3, 'ID', 'Kec. Silimo', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251650', 3, 'ID', 'Kec. Samenage', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251651', 3, 'ID', 'Kec. Nalca', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251699', 3, 'ID', 'Seradala', '      ');
INSERT INTO siakad.master_wilayah VALUES ('251700', 2, 'ID', 'Kab. Pegunungan Bintang', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251701', 3, 'ID', 'Kec. Okiwur', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251702', 3, 'ID', 'Kec. Oksibil', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251703', 3, 'ID', 'Kec. Borme', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251704', 3, 'ID', 'Kec. Okbibab', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251705', 3, 'ID', 'Kec. Kiwirok', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251706', 3, 'ID', 'Kec. Batom', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251707', 3, 'ID', 'Kec. Pepera', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251708', 3, 'ID', 'Kec. Bime', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251709', 3, 'ID', 'Kec. Aboy', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251710', 3, 'ID', 'Kec. Kiwirok Timur', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251711', 3, 'ID', 'Kec. Kawor', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251712', 3, 'ID', 'Kec. Tarup', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251713', 3, 'ID', 'Kec. Alemsom', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251714', 3, 'ID', 'Kec. Serambakon', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251715', 3, 'ID', 'Kec. Kalomdom', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251716', 3, 'ID', 'Kec. Oksop', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251717', 3, 'ID', 'Kec. Epumek', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251718', 3, 'ID', 'Kec. Weime', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251719', 3, 'ID', 'Kec. Okbab', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251720', 3, 'ID', 'Kec. Teiraplu', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251721', 3, 'ID', 'Kec. Sopsebang', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251722', 3, 'ID', 'Kec. Hokhika', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251723', 3, 'ID', 'Kec.Oklip', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251724', 3, 'ID', 'Kec. Oksamol', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251725', 3, 'ID', 'Kec. Bemta', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251726', 3, 'ID', 'Okbape', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251727', 3, 'ID', 'Ok Aom', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251728', 3, 'ID', 'Awinbon', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251729', 3, 'ID', 'Batani', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251730', 3, 'ID', 'Murkim', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251731', 3, 'ID', 'Mofinop', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251732', 3, 'ID', 'Jetfa', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251733', 3, 'ID', 'Nongme', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251734', 3, 'ID', 'Pamek', '251700');
INSERT INTO siakad.master_wilayah VALUES ('251737', 3, 'ID', 'Iwur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('251790', 3, 'ID', 'Okbemtau', '      ');
INSERT INTO siakad.master_wilayah VALUES ('251791', 3, 'ID', 'Oksebang', '      ');
INSERT INTO siakad.master_wilayah VALUES ('251800', 2, 'ID', 'Kab. Tolikara', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251801', 3, 'ID', 'Kec. Kanggime', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251802', 3, 'ID', 'Kec. Karubaga', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251803', 3, 'ID', 'Kec. Bokondini', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251804', 3, 'ID', 'Kec. Kembu', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251805', 3, 'ID', 'Kec. Goyage', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251806', 3, 'ID', 'Kec. Kubu', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251807', 3, 'ID', 'Kec. Geya', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251808', 3, 'ID', 'Kec. Numba', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251809', 3, 'ID', 'Kec. Dundu', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251810', 3, 'ID', 'Kec. Gudage', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251811', 3, 'ID', 'Kec. Timori', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251812', 3, 'ID', 'Kec. Konda', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251813', 3, 'ID', 'Kec. Nelawi', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251814', 3, 'ID', 'Kec. Kuari', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251815', 3, 'ID', 'Kec. Bokoneri', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251816', 3, 'ID', 'Kec. Bewani', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251817', 3, 'ID', 'Kec. Komboneri', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251818', 3, 'ID', 'Kec. Nabunage', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251819', 3, 'ID', 'Kec. Wakuo', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251820', 3, 'ID', 'Kec. Nunggawi', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251821', 3, 'ID', 'Kec. Woniki', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251822', 3, 'ID', 'Kec. Wunin', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251823', 3, 'ID', 'Kec. Wina', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251824', 3, 'ID', 'Kec. Panaga', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251825', 3, 'ID', 'Kec. Poganeri', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251826', 3, 'ID', 'Kec. Dow', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251827', 3, 'ID', 'Kec. Wari/Taiyeve', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251830', 3, 'ID', 'Kec. Umagi', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251831', 3, 'ID', 'Kec. Gilungbandu', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251832', 3, 'ID', 'Kec. Yuneri', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251833', 3, 'ID', 'Kec. Taginire', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251834', 3, 'ID', 'Kec. Egiam', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251835', 3, 'ID', 'Kec. Air Garam', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251836', 3, 'ID', 'Gika', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251837', 3, 'ID', 'Telenggeme', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251838', 3, 'ID', 'Anawi', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251839', 3, 'ID', 'Wenam', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251840', 3, 'ID', 'Wugi', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251841', 3, 'ID', 'Danime', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251842', 3, 'ID', 'Tagime', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251843', 3, 'ID', 'tidak ada', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251844', 3, 'ID', 'Aweku', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251845', 3, 'ID', 'Bogonuk', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251846', 3, 'ID', 'Li Anogomma', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251847', 3, 'ID', 'Biuk', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251848', 3, 'ID', 'Yuko', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251890', 3, 'ID', 'Kamboneri', '      ');
INSERT INTO siakad.master_wilayah VALUES ('251900', 2, 'ID', 'Kab. Sarmi', '250000');
INSERT INTO siakad.master_wilayah VALUES ('251902', 3, 'ID', 'Kec. Pantai Timur', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251903', 3, 'ID', 'Kec. Bonggo', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251904', 3, 'ID', 'Kec. Tor Atas', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251905', 3, 'ID', 'Kec. Sarmi', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251906', 3, 'ID', 'Kec. Pantai Barat', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251907', 3, 'ID', 'Kec. Pantai Timur Bagian Barat', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251910', 3, 'ID', 'Kec. Bonggo Timur', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251911', 3, 'ID', 'Kec. Sarmi Timur', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251912', 3, 'ID', 'Kec. Sarmi Barat', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251913', 3, 'ID', 'Kec. Apawert Hulu', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251914', 3, 'ID', 'Sarmi Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('252000', 2, 'ID', 'Kab. Keerom', '250000');
INSERT INTO siakad.master_wilayah VALUES ('252001', 3, 'ID', 'Kec. Web', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252002', 3, 'ID', 'Kec. Senggi', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252003', 3, 'ID', 'Kec. Waris', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252004', 3, 'ID', 'Kec. Arso', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252005', 3, 'ID', 'Kec. Skamto', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252006', 3, 'ID', 'Kec. Towe Hitam', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252007', 3, 'ID', 'Kec. Arso Timur', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252600', 2, 'ID', 'Kab. Waropen', '250000');
INSERT INTO siakad.master_wilayah VALUES ('252601', 3, 'ID', 'Kec. Waropen Bawah', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252602', 3, 'ID', 'Kec. Masirei', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252604', 3, 'ID', 'Kec. Inggerus', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252605', 3, 'ID', 'Kec. Ureifaisei', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252607', 3, 'ID', 'Kec. Risei Sayati', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252609', 3, 'ID', 'Kec. Kirihi', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252610', 3, 'ID', 'Wapoga', '      ');
INSERT INTO siakad.master_wilayah VALUES ('252700', 2, 'ID', 'Kab. Supiori', '250000');
INSERT INTO siakad.master_wilayah VALUES ('252701', 3, 'ID', 'Kec. Supiori Selatan', '252700');
INSERT INTO siakad.master_wilayah VALUES ('252702', 3, 'ID', 'Kec. Yenggarbun', '252700');
INSERT INTO siakad.master_wilayah VALUES ('252703', 3, 'ID', 'Kec. Supiori Timur', '252700');
INSERT INTO siakad.master_wilayah VALUES ('252704', 3, 'ID', 'Kec. Kepulauan Aruri', '252700');
INSERT INTO siakad.master_wilayah VALUES ('252705', 3, 'ID', 'Kec. Supiori Barat', '252700');
INSERT INTO siakad.master_wilayah VALUES ('252790', 3, 'ID', 'Supiori Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('252800', 2, 'ID', 'Kab. Memberamo Raya', '250000');
INSERT INTO siakad.master_wilayah VALUES ('252803', 3, 'ID', 'Kec. Waropen Atas', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252804', 3, 'ID', 'Kec. Mamberamo Ilir', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252805', 3, 'ID', 'Kec. Mamberamo Tengah', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252806', 3, 'ID', 'Kec. Mamberamo Tengah Timur', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252807', 3, 'ID', 'Kec. Rufaer', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252808', 3, 'ID', 'Kec. Mamberamo Ulu', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252809', 3, 'ID', 'Kec. Benuki', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252810', 3, 'ID', 'Kec. Sawai', '252800');
INSERT INTO siakad.master_wilayah VALUES ('252890', 3, 'ID', 'Mamberamo Hulu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('252891', 3, 'ID', 'Mamberamo Hilir', '      ');
INSERT INTO siakad.master_wilayah VALUES ('252900', 2, 'ID', 'Kab. Nduga', '250000');
INSERT INTO siakad.master_wilayah VALUES ('252901', 3, 'ID', 'Kec. Wosak', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252902', 3, 'ID', 'Kec. Kenyam', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252903', 3, 'ID', 'Kec. Geselma', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252904', 3, 'ID', 'Kec. Mapenduma', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252905', 3, 'ID', 'Kec. Mugi', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252906', 3, 'ID', 'Kec. Yigi', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252907', 3, 'ID', 'Kec. Mbuwa', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252908', 3, 'ID', 'Kec. Gearek', '252900');
INSERT INTO siakad.master_wilayah VALUES ('253000', 2, 'ID', 'Kab. Lanny Jaya', '250000');
INSERT INTO siakad.master_wilayah VALUES ('253001', 3, 'ID', 'Kec. Makki', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253002', 3, 'ID', 'Kec. Pirime', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253003', 3, 'ID', 'Kec. Tiom', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253004', 3, 'ID', 'Kec. Balingga', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253005', 3, 'ID', 'Kec. Kuyawage', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253006', 3, 'ID', 'Kec. Malagaineri', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253007', 3, 'ID', 'Kec. Tiomneri', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253008', 3, 'ID', 'Kec. Dimba', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253009', 3, 'ID', 'Kec. Gamelia', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253010', 3, 'ID', 'Kec. Poga', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253100', 2, 'ID', 'Kab. Membramo Tengah', '250000');
INSERT INTO siakad.master_wilayah VALUES ('253101', 3, 'ID', 'Kec. Kobakma', '253100');
INSERT INTO siakad.master_wilayah VALUES ('253102', 3, 'ID', 'Kec. Ilugwa', '253100');
INSERT INTO siakad.master_wilayah VALUES ('253103', 3, 'ID', 'Kec. Kelila', '253100');
INSERT INTO siakad.master_wilayah VALUES ('253104', 3, 'ID', 'Kec. Eragayam', '253100');
INSERT INTO siakad.master_wilayah VALUES ('253105', 3, 'ID', 'Kec. Megambilis', '253100');
INSERT INTO siakad.master_wilayah VALUES ('253200', 2, 'ID', 'Kab. Yalimo', '250000');
INSERT INTO siakad.master_wilayah VALUES ('253201', 3, 'ID', 'Kec. Welarek', '253200');
INSERT INTO siakad.master_wilayah VALUES ('253202', 3, 'ID', 'Kec. Apalapsili', '253200');
INSERT INTO siakad.master_wilayah VALUES ('253203', 3, 'ID', 'Kec. Abenaho', '253200');
INSERT INTO siakad.master_wilayah VALUES ('253204', 3, 'ID', 'Kec. Elelim', '253200');
INSERT INTO siakad.master_wilayah VALUES ('253205', 3, 'ID', 'Kec. Benawa', '253200');
INSERT INTO siakad.master_wilayah VALUES ('253300', 2, 'ID', 'kab. Puncak', '250000');
INSERT INTO siakad.master_wilayah VALUES ('253301', 3, 'ID', 'Kec. Agadugume', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253302', 3, 'ID', 'Kec. Gome', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253303', 3, 'ID', 'Kec. Ilaga', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253304', 3, 'ID', 'Kec. Sinak', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253305', 3, 'ID', 'Kec. Pogoma', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253306', 3, 'ID', 'Kec. Wangbe', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253307', 3, 'ID', 'Kec. Beoga', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253308', 3, 'ID', 'Kec. Doufo', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253400', 2, 'ID', 'Kab. Dogiyai', '250000');
INSERT INTO siakad.master_wilayah VALUES ('253401', 3, 'ID', 'Kec. Piyaiye', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253402', 3, 'ID', 'Kec. Mapia Barat', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253403', 3, 'ID', 'Kec. Mapia', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253404', 3, 'ID', 'Kec. Dogiyai', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253405', 3, 'ID', 'Kec. Kamu Selatan', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253406', 3, 'ID', 'Kec. Kamu', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253407', 3, 'ID', 'Kec. Mapia Tengah', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253408', 3, 'ID', 'Kec. Kamu Tmur', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253409', 3, 'ID', 'Kec. Kamu Utara', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253410', 3, 'ID', 'Kec. Sukikai Selatan', '253400');
INSERT INTO siakad.master_wilayah VALUES ('253500', 2, 'ID', 'Kab. Deiyai', '250000');
INSERT INTO siakad.master_wilayah VALUES ('253501', 3, 'ID', 'Kec. Tigi', '253500');
INSERT INTO siakad.master_wilayah VALUES ('253502', 3, 'ID', 'Kec. Tigi Barat', '253500');
INSERT INTO siakad.master_wilayah VALUES ('253503', 3, 'ID', 'Kec. Tigi Timur', '253500');
INSERT INTO siakad.master_wilayah VALUES ('253504', 3, 'ID', 'Kec. Bowobado', '253500');
INSERT INTO siakad.master_wilayah VALUES ('253505', 3, 'ID', 'Kec. Kapiraya', '253500');
INSERT INTO siakad.master_wilayah VALUES ('253600', 2, 'ID', 'Kab. Intan Jaya', '250000');
INSERT INTO siakad.master_wilayah VALUES ('253601', 3, 'ID', 'Kec. Sugapa', '253600');
INSERT INTO siakad.master_wilayah VALUES ('253602', 3, 'ID', 'Kec. Hitadipa', '253600');
INSERT INTO siakad.master_wilayah VALUES ('253603', 3, 'ID', 'Kec. Homeyo', '253600');
INSERT INTO siakad.master_wilayah VALUES ('253604', 3, 'ID', 'Kec. Biandoga', '253600');
INSERT INTO siakad.master_wilayah VALUES ('253605', 3, 'ID', 'Kec. Wandai', '253600');
INSERT INTO siakad.master_wilayah VALUES ('253606', 3, 'ID', 'Kec. Agisiga', '253600');
INSERT INTO siakad.master_wilayah VALUES ('253691', 3, 'ID', 'Sugapa*', '      ');
INSERT INTO siakad.master_wilayah VALUES ('253692', 3, 'ID', 'Hitadipa*', '      ');
INSERT INTO siakad.master_wilayah VALUES ('253693', 3, 'ID', 'Homeyo*', '      ');
INSERT INTO siakad.master_wilayah VALUES ('253694', 3, 'ID', 'Biandoga*', '      ');
INSERT INTO siakad.master_wilayah VALUES ('253695', 3, 'ID', 'Wandai*', '      ');
INSERT INTO siakad.master_wilayah VALUES ('253696', 3, 'ID', 'Agisiga*', '      ');
INSERT INTO siakad.master_wilayah VALUES ('256000', 2, 'ID', 'Kota Jayapura', '250000');
INSERT INTO siakad.master_wilayah VALUES ('256001', 3, 'ID', 'Kec. Muara Tami', '256000');
INSERT INTO siakad.master_wilayah VALUES ('256002', 3, 'ID', 'Kec. Abepura', '256000');
INSERT INTO siakad.master_wilayah VALUES ('256003', 3, 'ID', 'Kec. Jayapura Selatan', '256000');
INSERT INTO siakad.master_wilayah VALUES ('256004', 3, 'ID', 'Kec. Jayapura Utara', '256000');
INSERT INTO siakad.master_wilayah VALUES ('256005', 3, 'ID', 'Kec. Heram', '256000');
INSERT INTO siakad.master_wilayah VALUES ('256090', 3, 'ID', 'Kotaraja', '      ');
INSERT INTO siakad.master_wilayah VALUES ('260000', 1, 'ID', 'Prov. Bengkulu', '000000');
INSERT INTO siakad.master_wilayah VALUES ('260100', 2, 'ID', 'Kab. Bengkulu Utara', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260101', 3, 'ID', 'Kec. Enggano', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260105', 3, 'ID', 'Kec. Kerkap', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260106', 3, 'ID', 'Kec. Arga Makmur', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260107', 3, 'ID', 'Kec. Lais', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260108', 3, 'ID', 'Kec. Padang Jaya', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260109', 3, 'ID', 'Kec. Ketahun', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260110', 3, 'ID', 'Kec. Putri Hijau', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260117', 3, 'ID', 'Kec. Air Napal', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260118', 3, 'ID', 'Kec. Air Besi', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260119', 3, 'ID', 'Kec. Batik Nau', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260120', 3, 'ID', 'Kec. Giri Mulia', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260121', 3, 'ID', 'Kec. Napal Putih', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260122', 3, 'ID', 'Hulu Palik', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260123', 3, 'ID', 'Air Padang', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260200', 2, 'ID', 'Kab. Rejang Lebong', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260202', 3, 'ID', 'Kec. Kota Padang', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260203', 3, 'ID', 'Kec. Padang Ulang Tanding', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260204', 3, 'ID', 'Kec. Curup', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260210', 3, 'ID', 'Kec. Sindang Kelingi', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260211', 3, 'ID', 'Kec. Bermani Ulu', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260212', 3, 'ID', 'Kec. Selupu Rejang', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260217', 3, 'ID', 'Kec. Sindang Beliti Ilir', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260218', 3, 'ID', 'Kec. Bindu Riang', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260219', 3, 'ID', 'Kec. Sindang Beliti Ulu', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260220', 3, 'ID', 'Kec. Sindang Dataran', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260221', 3, 'ID', 'Kec. Curup Selatan', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260222', 3, 'ID', 'Kec. Curup Tengah', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260223', 3, 'ID', 'Kec. Bermani Ulu Raya', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260224', 3, 'ID', 'Kec. Curup Utara', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260225', 3, 'ID', 'Kec. Curup Timur', '260200');
INSERT INTO siakad.master_wilayah VALUES ('260300', 2, 'ID', 'Kab. Bengkulu Selatan', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260304', 3, 'ID', 'Kec. Manna', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260305', 3, 'ID', 'Kec. Seginim', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260306', 3, 'ID', 'Kec. Pino', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260314', 3, 'ID', 'Kec. Kota Manna', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260315', 3, 'ID', 'Kec. Pinoraya', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260318', 3, 'ID', 'Kec. Kedurang', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260319', 3, 'ID', 'Kec. Bunga Mas', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260320', 3, 'ID', 'Kec. Pasar Manna', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260321', 3, 'ID', 'Kec. Kedurang Ilir', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260322', 3, 'ID', 'Kec. Air Nipis', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260323', 3, 'ID', 'Kec. Ulu Manna', '260300');
INSERT INTO siakad.master_wilayah VALUES ('260400', 2, 'ID', 'Kab. Muko-muko', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260401', 3, 'ID', 'Kec. Muko-Muko Selatan', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260402', 3, 'ID', 'Kec. Teras Terunjam', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260403', 3, 'ID', 'Kec. Muko-Muko Utara', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260404', 3, 'ID', 'Kec. Pondok Suguh', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260405', 3, 'ID', 'Kec. Lubuk Pinang', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260406', 3, 'ID', 'Kec. Air Rami', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260407', 3, 'ID', 'Kec. Malin Deman', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260408', 3, 'ID', 'Kec. Sungai Rumbai', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260409', 3, 'ID', 'Kec. Teramang Jaya', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260410', 3, 'ID', 'Kec. Penarik', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260411', 3, 'ID', 'Kec. Selagan Raya', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260412', 3, 'ID', 'Kec. Air Dikit', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260413', 3, 'ID', 'Kec. XIV Koto', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260414', 3, 'ID', 'Kec. Air Manjunto', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260415', 3, 'ID', 'Kec. V Koto', '260400');
INSERT INTO siakad.master_wilayah VALUES ('260490', 3, 'ID', 'Kota Mukomuko', '      ');
INSERT INTO siakad.master_wilayah VALUES ('260491', 3, 'ID', 'Ipuh', '      ');
INSERT INTO siakad.master_wilayah VALUES ('260500', 2, 'ID', 'Kab. Kepahiang', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260501', 3, 'ID', 'Kec. Kepahiang', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260502', 3, 'ID', 'Kec. Bermani Ilir', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260503', 3, 'ID', 'Kec. Tebat Karai', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260504', 3, 'ID', 'Kec. Ujan Mas', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260505', 3, 'ID', 'Kec. Muara Kemumu', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260506', 3, 'ID', 'Kec. Seberang Musi', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260507', 3, 'ID', 'Kec. Kaba Wetan', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260508', 3, 'ID', 'Kec. Merigi', '260500');
INSERT INTO siakad.master_wilayah VALUES ('260600', 2, 'ID', 'Kab. Lebong', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260601', 3, 'ID', 'Kec. Lebong Selatan', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260602', 3, 'ID', 'Kec. Lebong Utara', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260603', 3, 'ID', 'Kec. Rimbo Pegadang', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260604', 3, 'ID', 'Kec. Lebong Tengah', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260605', 3, 'ID', 'Kec. Lebong Atas', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260607', 3, 'ID', 'Topos', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260608', 3, 'ID', 'Bingin Kuning', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260609', 3, 'ID', 'Lebong Sakti', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260610', 3, 'ID', 'Pelabai', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260611', 3, 'ID', 'Amen', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260612', 3, 'ID', 'Uram Jaya', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260613', 3, 'ID', 'Pinang Belapis', '260600');
INSERT INTO siakad.master_wilayah VALUES ('260700', 2, 'ID', 'Kab. Kaur', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260701', 3, 'ID', 'Kec. Kaur Selatan', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260702', 3, 'ID', 'Kec. Kaur Tengah', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260703', 3, 'ID', 'Kec. Kaur Utara', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260704', 3, 'ID', 'Kec. Maje', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260705', 3, 'ID', 'Kec. Nasal', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260706', 3, 'ID', 'Kec. Kinal', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260707', 3, 'ID', 'Kec. Tanjung Kemuning', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260708', 3, 'ID', 'Kec. Muara Tetap', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260709', 3, 'ID', 'Kec. Luas', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260710', 3, 'ID', 'Kec. Muara Sahung', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260711', 3, 'ID', 'Kec. Semidang Gumai', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260712', 3, 'ID', 'Kec. Kelam Tengah', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260713', 3, 'ID', 'Kec. Padang Guci Hilir', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260714', 3, 'ID', 'Kec. Padang Guci Ulu', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260715', 3, 'ID', 'Kec. Lungkang Kule', '260700');
INSERT INTO siakad.master_wilayah VALUES ('260800', 2, 'ID', 'Kab. Seluma', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260801', 3, 'ID', 'Kec. Talo', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260802', 3, 'ID', 'Kec. Seluma', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260803', 3, 'ID', 'Kec. Sukaraja', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260804', 3, 'ID', 'Kec. Semidang Alas Maras', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260805', 3, 'ID', 'Kec. Semidang Alas', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260806', 3, 'ID', 'Kec. Ilir Talo', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260807', 3, 'ID', 'Kec. Talo Kecil', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260808', 3, 'ID', 'Kec. Ulu Talo', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260809', 3, 'ID', 'Kec. Seluma Selatan', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260810', 3, 'ID', 'Kec. Seluma Barat', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260811', 3, 'ID', 'Kec. Seluma Timur', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260812', 3, 'ID', 'Kec. Seluma Utara', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260813', 3, 'ID', 'Kec. Air Periukan', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260814', 3, 'ID', 'Kec. Lubuk Sandi', '260800');
INSERT INTO siakad.master_wilayah VALUES ('260900', 2, 'ID', 'Kab. Bengkulu Tengah', '260000');
INSERT INTO siakad.master_wilayah VALUES ('260901', 3, 'ID', 'Kec. Talang Empat', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260902', 3, 'ID', 'Kec. Karang Tinggi', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260903', 3, 'ID', 'Kec. Taba Penanjung', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260904', 3, 'ID', 'Kec. Pagar Jati', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260905', 3, 'ID', 'Kec. Pondok Kelapa', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260906', 3, 'ID', 'Kec. Pematang Tiga', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260907', 3, 'ID', 'Kec. Merigi Kelindang', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260908', 3, 'ID', 'Kec. Merigi Sakti', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260909', 3, 'ID', 'Kec. Pondok Kubang', '260900');
INSERT INTO siakad.master_wilayah VALUES ('260910', 3, 'ID', 'Kec. Bang Haji', '260900');
INSERT INTO siakad.master_wilayah VALUES ('266000', 2, 'ID', 'Kota Bengkulu', '260000');
INSERT INTO siakad.master_wilayah VALUES ('266001', 3, 'ID', 'Kec. Selebar', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266002', 3, 'ID', 'Kec. Gading Cempaka', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266003', 3, 'ID', 'Kec. Teluk Segara', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266004', 3, 'ID', 'Kec. Muara Bangkahulu', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266005', 3, 'ID', 'Kec. Kampung Melayu', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266006', 3, 'ID', 'Kec. Ratu Agung', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266007', 3, 'ID', 'Kec. Ratu Samban', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266008', 3, 'ID', 'Kec. Sungai  Serut', '266000');
INSERT INTO siakad.master_wilayah VALUES ('266009', 3, 'ID', 'Kec. Singaran Pati', '266000');
INSERT INTO siakad.master_wilayah VALUES ('270000', 1, 'ID', 'Prov. Maluku Utara', '000000');
INSERT INTO siakad.master_wilayah VALUES ('270200', 2, 'ID', 'Kab. Halmahera Tengah', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270203', 3, 'ID', 'Kec. Weda', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270204', 3, 'ID', 'Kec. Pulau Gebe', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270206', 3, 'ID', 'Kec. Patani', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270207', 3, 'ID', 'Kec. Weda Utara', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270208', 3, 'ID', 'Kec. Weda Selatan', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270209', 3, 'ID', 'Kec. Patani Utara', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270210', 3, 'ID', 'Weda Tengah', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270211', 3, 'ID', 'Patani Barat', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270300', 2, 'ID', 'Kab. Halmahera Barat', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270302', 3, 'ID', 'Kec. Sahu', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270303', 3, 'ID', 'Kec. Ibu', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270304', 3, 'ID', 'Kec. Loloda', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270305', 3, 'ID', 'Kec. Jailolo Selatan', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270306', 3, 'ID', 'Kec. Jailolo', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270307', 3, 'ID', 'Kec. Sahu Timur', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270308', 3, 'ID', 'Kec. Ibu Selatan', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270309', 3, 'ID', 'Kec. Ibu Utara', '270300');
INSERT INTO siakad.master_wilayah VALUES ('270310', 3, 'ID', 'Jailolo Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270400', 2, 'ID', 'Kab. halmahera Utara', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270401', 3, 'ID', 'Kec. Tobelo', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270402', 3, 'ID', 'Kec. Tobelo Selatan', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270403', 3, 'ID', 'Kec. Kao', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270404', 3, 'ID', 'Kec. Galela', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270408', 3, 'ID', 'Kec. Loloda Utara', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270409', 3, 'ID', 'Kec. Malifut', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270410', 3, 'ID', 'Kec. Tobelo Utara', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270411', 3, 'ID', 'Kec. Tobelo Tengah', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270412', 3, 'ID', 'Kec. Tobelo Timur', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270413', 3, 'ID', 'Kec. Tobelo Barat', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270414', 3, 'ID', 'Kec. Galela Barat', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270415', 3, 'ID', 'Kec. Galela Selatan', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270416', 3, 'ID', 'Kec. Galela Utara', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270419', 3, 'ID', 'Kec. Loloda Kepulauan', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270420', 3, 'ID', 'Kec. Kao Utara', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270421', 3, 'ID', 'Kec. Kao Barat', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270422', 3, 'ID', 'Kec. Kao Teluk', '270400');
INSERT INTO siakad.master_wilayah VALUES ('270500', 2, 'ID', 'Kab. Halmahera Selatan', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270502', 3, 'ID', 'Kec. Bacan Timur', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270503', 3, 'ID', 'Kec. Bacan Barat', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270504', 3, 'ID', 'Kec. Bacan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270505', 3, 'ID', 'Kec. Obi', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270506', 3, 'ID', 'Kec. Gane Barat', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270507', 3, 'ID', 'Kec. Gane Timur', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270508', 3, 'ID', 'Kec. Kayoa', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270509', 3, 'ID', 'Kec. Pulau Makian', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270510', 3, 'ID', 'Kec. Obi Selatan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270511', 3, 'ID', 'Kec. Obi Barat', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270512', 3, 'ID', 'Kec. Obi Timur', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270513', 3, 'ID', 'Kec. Obi Utara', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270514', 3, 'ID', 'Kec. Mandioli Selatan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270515', 3, 'ID', 'Kec. Mandioli Utara', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270516', 3, 'ID', 'Kec. Bancan Selatan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270517', 3, 'ID', 'Kec. Batang Lomang', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270518', 3, 'ID', 'Kec. Bacan Timur Selatan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270519', 3, 'ID', 'Kec. Bacan Timur Tengah', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270520', 3, 'ID', 'Kec. Kasiruta Barat', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270521', 3, 'ID', 'Kec. Kasiruta Timur', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270522', 3, 'ID', 'Kec. Bacan Barat Utara', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270523', 3, 'ID', 'Kec. Kayoa Barat', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270524', 3, 'ID', 'Kec. Kayoa Selatan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270525', 3, 'ID', 'Kec. Kayoa Utara', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270526', 3, 'ID', 'Kec. Makian Barat', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270527', 3, 'ID', 'Kec. Gane Selatan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270528', 3, 'ID', 'Kec. Gane Utara', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270529', 3, 'ID', 'Kec. Kepulauan Joronga', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270530', 3, 'ID', 'Kec. Gane Timur Tengah', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270531', 3, 'ID', 'Kec. Gane Timur Selatan', '270500');
INSERT INTO siakad.master_wilayah VALUES ('270590', 3, 'ID', 'Gane Barat Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270591', 3, 'ID', 'Gane Barat Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270600', 2, 'ID', 'Kab. Halmahera Timur', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270601', 3, 'ID', 'Kec. Maba Selatan', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270602', 3, 'ID', 'Kec. Wasile Selatan', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270603', 3, 'ID', 'Kec. Wasile', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270604', 3, 'ID', 'Kec. Maba', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270605', 3, 'ID', 'Kec. Wasile Tengah', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270606', 3, 'ID', 'Kec. Wasile Utara', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270607', 3, 'ID', 'Kec. Wasile Timur', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270608', 3, 'ID', 'Kec. Maba Tengah', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270609', 3, 'ID', 'Kec. Maba Utara', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270610', 3, 'ID', 'Kec. Kota Maba', '270600');
INSERT INTO siakad.master_wilayah VALUES ('270700', 2, 'ID', 'Kab. Kepulauan Sula', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270701', 3, 'ID', 'Kec. Sanana', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270702', 3, 'ID', 'Kec. Sula Besi Barat', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270703', 3, 'ID', 'Kec. Mangoli Timur', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270704', 3, 'ID', 'Kec. Taliabu Barat', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270705', 3, 'ID', 'Kec. Taliabu Timur', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270706', 3, 'ID', 'Kec. Mangoli Barat', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270707', 3, 'ID', 'Kec. Sula Besi Tengah', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270708', 3, 'ID', 'Kec. Sula Besi Timur', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270709', 3, 'ID', 'Kec. Mangoli Tengah', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270710', 3, 'ID', 'Kec. Mangoli Utara Timur', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270711', 3, 'ID', 'Kec. Mangoli Utara', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270712', 3, 'ID', 'Kec. Mangoli Selatan', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270713', 3, 'ID', 'Kec. Taliabu Timur Selatan', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270714', 3, 'ID', 'Kec. Taliabu Utara', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270715', 3, 'ID', 'Kec. Sula Besi Selatan', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270716', 3, 'ID', 'Kec. Sanana Utara', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270717', 3, 'ID', 'Kec. Taliabu Barat Laut', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270718', 3, 'ID', 'Kec. Lede', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270719', 3, 'ID', 'Kec. Taliabu Selatan', '270700');
INSERT INTO siakad.master_wilayah VALUES ('270720', 3, 'ID', 'Mangoli Tengah', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270721', 3, 'ID', 'Taliabu Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270722', 3, 'ID', 'Taliabu Timur Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270723', 3, 'ID', 'Taliabu -Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270724', 3, 'ID', 'Taliabu Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270725', 3, 'ID', 'Taliabu Barat Laut', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270726', 3, 'ID', 'Taliabu Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270727', 3, 'ID', 'Lede', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270790', 3, 'ID', 'Tabona', '      ');
INSERT INTO siakad.master_wilayah VALUES ('270800', 2, 'ID', 'Kab. Kepulauan Morotai', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270801', 3, 'ID', 'Kec. Morotai Selatan Barat', '270800');
INSERT INTO siakad.master_wilayah VALUES ('270802', 3, 'ID', 'Kec. Morotai Selatan', '270800');
INSERT INTO siakad.master_wilayah VALUES ('270803', 3, 'ID', 'Kec. Morotai Utara', '270800');
INSERT INTO siakad.master_wilayah VALUES ('270804', 3, 'ID', 'Kec. Morotai Jaya', '270800');
INSERT INTO siakad.master_wilayah VALUES ('270805', 3, 'ID', 'Kec. Morotai Timur', '270800');
INSERT INTO siakad.master_wilayah VALUES ('276000', 2, 'ID', 'Kota Ternate', '270000');
INSERT INTO siakad.master_wilayah VALUES ('276001', 3, 'ID', 'Kec. Pulau Ternate', '276000');
INSERT INTO siakad.master_wilayah VALUES ('276002', 3, 'ID', 'Kec. Ternate Selatan', '276000');
INSERT INTO siakad.master_wilayah VALUES ('276003', 3, 'ID', 'Kec. Ternate Utara', '276000');
INSERT INTO siakad.master_wilayah VALUES ('276004', 3, 'ID', 'Kec. Moti', '276000');
INSERT INTO siakad.master_wilayah VALUES ('276005', 3, 'ID', 'Kec. Pulau Batang Dua', '276000');
INSERT INTO siakad.master_wilayah VALUES ('276006', 3, 'ID', 'Kec. Ternate Tengah', '276000');
INSERT INTO siakad.master_wilayah VALUES ('276007', 3, 'ID', 'Kec.  Pulau Hiri', '276000');
INSERT INTO siakad.master_wilayah VALUES ('276100', 2, 'ID', 'Kota Tidore Kepulauan', '270000');
INSERT INTO siakad.master_wilayah VALUES ('276102', 3, 'ID', 'Kec. Tidore Selatan', '276100');
INSERT INTO siakad.master_wilayah VALUES ('276103', 3, 'ID', 'Kec. Tidore Utara', '276100');
INSERT INTO siakad.master_wilayah VALUES ('276104', 3, 'ID', 'Kec. Oba', '276100');
INSERT INTO siakad.master_wilayah VALUES ('276105', 3, 'ID', 'Kec. Oba Utara', '276100');
INSERT INTO siakad.master_wilayah VALUES ('276106', 3, 'ID', 'Kec. Oba Tengah', '276100');
INSERT INTO siakad.master_wilayah VALUES ('276107', 3, 'ID', 'Kec. Oba Selatan', '276100');
INSERT INTO siakad.master_wilayah VALUES ('276108', 3, 'ID', 'Kec. Tidore', '276100');
INSERT INTO siakad.master_wilayah VALUES ('276109', 3, 'ID', 'Kec. Tidore Timur', '276100');
INSERT INTO siakad.master_wilayah VALUES ('280000', 1, 'ID', 'Prov. Banten', '000000');
INSERT INTO siakad.master_wilayah VALUES ('280100', 2, 'ID', 'Kab. Pandeglang', '280000');
INSERT INTO siakad.master_wilayah VALUES ('280101', 3, 'ID', 'Kec. Sumur', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280102', 3, 'ID', 'Kec. Cimanggu', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280103', 3, 'ID', 'Kec. Cibaliung', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280104', 3, 'ID', 'Kec. Cikeusik', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280105', 3, 'ID', 'Kec. Cigeulis', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280106', 3, 'ID', 'Kec. Panimbang', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280107', 3, 'ID', 'Kec. Munjul', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280108', 3, 'ID', 'Kec. Picung', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280109', 3, 'ID', 'Kec. Bojong', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280110', 3, 'ID', 'Kec. Saketi', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280111', 3, 'ID', 'Kec. Pagelaran', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280112', 3, 'ID', 'Kec. Labuan', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280113', 3, 'ID', 'Kec. Jiput', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280114', 3, 'ID', 'Kec. Menes', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280115', 3, 'ID', 'Kec. Mandalawangi', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280116', 3, 'ID', 'Kec. Cimanuk', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280117', 3, 'ID', 'Kec. Banjar', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280118', 3, 'ID', 'Kec. Pandeglang', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280119', 3, 'ID', 'Kec. Cadasari', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280120', 3, 'ID', 'Kec. Angsana', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280121', 3, 'ID', 'Kec. Karang Tanjung', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280122', 3, 'ID', 'Kec. Kaduhejo', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280123', 3, 'ID', 'Kec. Cikedal', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280124', 3, 'ID', 'Kec. Cipeucang', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280125', 3, 'ID', 'Kec. Cisata', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280126', 3, 'ID', 'Kec. Patia', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280127', 3, 'ID', 'Kec. Carita', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280132', 3, 'ID', 'Kec. Sukaresmi', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280133', 3, 'ID', 'Kec. Mekarjaya', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280134', 3, 'ID', 'Kec. Sindangresmi', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280135', 3, 'ID', 'Kec. Pulosari', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280136', 3, 'ID', 'Kec. Koroncong', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280138', 3, 'ID', 'Kec. Cibitung', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280139', 3, 'ID', 'Kec. Majasari', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280140', 3, 'ID', 'Kec. Sobang', '280100');
INSERT INTO siakad.master_wilayah VALUES ('280200', 2, 'ID', 'Kab. Lebak', '280000');
INSERT INTO siakad.master_wilayah VALUES ('280201', 3, 'ID', 'Kec. Malingping', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280202', 3, 'ID', 'Kec. Panggarangan', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280203', 3, 'ID', 'Kec. Bayah', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280204', 3, 'ID', 'Kec. Cibeber', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280205', 3, 'ID', 'Kec. Cijaku', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280206', 3, 'ID', 'Kec. Banjarsari', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280207', 3, 'ID', 'Kec. Cileles', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280208', 3, 'ID', 'Kec. Gunung kencana', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280209', 3, 'ID', 'Kec. Bojongmanik', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280210', 3, 'ID', 'Kec. Leuwidamar', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280211', 3, 'ID', 'Kec. Muncang', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280212', 3, 'ID', 'Kec. Cipanas', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280213', 3, 'ID', 'Kec. Sajira', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280214', 3, 'ID', 'Kec. Cimarga', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280215', 3, 'ID', 'Kec. Cikulur', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280216', 3, 'ID', 'Kec. Warung gunung', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280217', 3, 'ID', 'Kec. Cibadak', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280218', 3, 'ID', 'Kec. Rangkasbitung', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280219', 3, 'ID', 'Kec. Maja', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280220', 3, 'ID', 'Kec. Curug bitung', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280221', 3, 'ID', 'Kec. Sobang', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280222', 3, 'ID', 'Kec. Wanasalam', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280223', 3, 'ID', 'Kec. Cilograng', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280224', 3, 'ID', 'Kec. Cihara', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280225', 3, 'ID', 'Kec. Cigemblong', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280226', 3, 'ID', 'Kec. Cirinten', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280227', 3, 'ID', 'Kec. Lebakgedong', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280228', 3, 'ID', 'Kec. Karanganyar', '280200');
INSERT INTO siakad.master_wilayah VALUES ('280300', 2, 'ID', 'Kab. Tangerang', '280000');
INSERT INTO siakad.master_wilayah VALUES ('280301', 3, 'ID', 'Kec. Cisoka', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280302', 3, 'ID', 'Kec. Tiga raksa', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280303', 3, 'ID', 'Kec. Cikupa', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280304', 3, 'ID', 'Kec. Panongan', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280305', 3, 'ID', 'Kec. Curug', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280306', 3, 'ID', 'Kec. Legok', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280307', 3, 'ID', 'Kec. Pagedangan', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280312', 3, 'ID', 'Kec. Pasar Kemis', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280313', 3, 'ID', 'Kec. Balaraja', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280314', 3, 'ID', 'Kec. Kresek', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280315', 3, 'ID', 'Kec. Kronjo', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280316', 3, 'ID', 'Kec. Mauk', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280317', 3, 'ID', 'Kec. Rajeg', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280318', 3, 'ID', 'Kec. Sepatan', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280319', 3, 'ID', 'Kec. Pakuhaji', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280320', 3, 'ID', 'Kec. Teluk naga', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280321', 3, 'ID', 'Kec. Kosambi', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280322', 3, 'ID', 'Kec. Jayanti', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280323', 3, 'ID', 'Kec. Jambe', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280324', 3, 'ID', 'Kec. Cisauk', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280325', 3, 'ID', 'Kec. Kemeri', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280326', 3, 'ID', 'Kec. Sukadiri', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280333', 3, 'ID', 'Kec. Sukamulya', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280334', 3, 'ID', 'Kec. Kelapa Dua', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280335', 3, 'ID', 'Kec. Sindang Jaya', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280336', 3, 'ID', 'Kec. Sepatan Timur', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280337', 3, 'ID', 'Kec. Solear', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280338', 3, 'ID', 'Kec. Gunung Kaler', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280339', 3, 'ID', 'Kec. Mekar Baru', '280300');
INSERT INTO siakad.master_wilayah VALUES ('280400', 2, 'ID', 'Kab. Serang', '280000');
INSERT INTO siakad.master_wilayah VALUES ('280401', 3, 'ID', 'Kec. Cinangka', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280402', 3, 'ID', 'Kec. Padarincang', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280403', 3, 'ID', 'Kec. Ciomas', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280404', 3, 'ID', 'Kec. Pabuaran', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280405', 3, 'ID', 'Kec. Baros', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280406', 3, 'ID', 'Kec. Petir', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280408', 3, 'ID', 'Kec. Cikeusal', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280409', 3, 'ID', 'Kec. Pamarayan', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280410', 3, 'ID', 'Kec. Jawilan', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280411', 3, 'ID', 'Kec. Kopo', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280412', 3, 'ID', 'Kec. Cikande', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280413', 3, 'ID', 'Kec. Kragilan', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280416', 3, 'ID', 'Kec. Serang', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280418', 3, 'ID', 'Kec. Waringinkurung', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280419', 3, 'ID', 'Kec. Mancak', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280420', 3, 'ID', 'Kec. Anyar', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280421', 3, 'ID', 'Kec. Bojonegara', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280422', 3, 'ID', 'Kec. Kramatwatu', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280424', 3, 'ID', 'Kec. Ciruas', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280425', 3, 'ID', 'Kec. Pontang', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280426', 3, 'ID', 'Kec. Carenang', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280427', 3, 'ID', 'Kec. Tirtayasa', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280428', 3, 'ID', 'Kec. Tunjung Teja', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280429', 3, 'ID', 'Kec. Kibin', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280430', 3, 'ID', 'Kec. Pulo Ampel', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280431', 3, 'ID', 'Kec. Binuang', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280432', 3, 'ID', 'Kec. Tanara', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280433', 3, 'ID', 'Kec. Gunung Sari', '280400');
INSERT INTO siakad.master_wilayah VALUES ('280434', 3, 'ID', 'Kec. Bandung', '280400');
INSERT INTO siakad.master_wilayah VALUES ('286000', 2, 'ID', 'Kota Cilegon', '280000');
INSERT INTO siakad.master_wilayah VALUES ('286001', 3, 'ID', 'Kec. Ciwandan', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286002', 3, 'ID', 'Kec. Pulomerak', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286003', 3, 'ID', 'Kec. Cilegon', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286004', 3, 'ID', 'Kec. Cibeber', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286005', 3, 'ID', 'Kec. Gerogol', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286006', 3, 'ID', 'Kec. Purwakarta', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286007', 3, 'ID', 'Kec. Jombang', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286008', 3, 'ID', 'Kec. Citangkil', '286000');
INSERT INTO siakad.master_wilayah VALUES ('286100', 2, 'ID', 'Kota Tangerang', '280000');
INSERT INTO siakad.master_wilayah VALUES ('286101', 3, 'ID', 'Kec. Ciledug', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286102', 3, 'ID', 'Kec. Cipondoh', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286103', 3, 'ID', 'Kec. Tangerang', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286104', 3, 'ID', 'Kec. Jati uwung', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286105', 3, 'ID', 'Kec. Batuceper', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286106', 3, 'ID', 'Kec. Benda', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286107', 3, 'ID', 'Kec. Larangan', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286108', 3, 'ID', 'Kec. Karang Tengah', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286109', 3, 'ID', 'Kec. Pinang', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286110', 3, 'ID', 'Kec. Karawaci', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286111', 3, 'ID', 'Kec. Cibodas', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286112', 3, 'ID', 'Kec. Periuk', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286113', 3, 'ID', 'Kec. Neglasari', '286100');
INSERT INTO siakad.master_wilayah VALUES ('286200', 2, 'ID', 'Kota Serang', '280000');
INSERT INTO siakad.master_wilayah VALUES ('286201', 3, 'ID', 'Kec. Cipocok Jaya', '286200');
INSERT INTO siakad.master_wilayah VALUES ('286202', 3, 'ID', 'Kec. Curug', '286200');
INSERT INTO siakad.master_wilayah VALUES ('286203', 3, 'ID', 'Kec. Kasemen', '286200');
INSERT INTO siakad.master_wilayah VALUES ('286205', 3, 'ID', 'Kec. Taktakan', '286200');
INSERT INTO siakad.master_wilayah VALUES ('286206', 3, 'ID', 'Kec. Walantaka', '286200');
INSERT INTO siakad.master_wilayah VALUES ('286300', 2, 'ID', 'Kota tangerang Selatan', '280000');
INSERT INTO siakad.master_wilayah VALUES ('286301', 3, 'ID', 'Kec. Ciputat', '286300');
INSERT INTO siakad.master_wilayah VALUES ('286302', 3, 'ID', 'Kec. Ciputat Timur', '286300');
INSERT INTO siakad.master_wilayah VALUES ('286303', 3, 'ID', 'Kec. Pamulang', '286300');
INSERT INTO siakad.master_wilayah VALUES ('286304', 3, 'ID', 'Kec. Pondok Aren', '286300');
INSERT INTO siakad.master_wilayah VALUES ('286305', 3, 'ID', 'Kec. Serpong', '286300');
INSERT INTO siakad.master_wilayah VALUES ('286306', 3, 'ID', 'Kec. Serpong Utara', '286300');
INSERT INTO siakad.master_wilayah VALUES ('286307', 3, 'ID', 'Kec. Setu', '286300');
INSERT INTO siakad.master_wilayah VALUES ('290000', 1, 'ID', 'Prov. Bangka Belitung', '000000');
INSERT INTO siakad.master_wilayah VALUES ('290100', 2, 'ID', 'Kab. Bangka', '290000');
INSERT INTO siakad.master_wilayah VALUES ('290107', 3, 'ID', 'Kec. Mendo Barat', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290108', 3, 'ID', 'Kec. Merawang', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290109', 3, 'ID', 'Kec. Sungai Liat', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290113', 3, 'ID', 'Kec. Belinyu', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290114', 3, 'ID', 'Kec. Puding Besar', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290115', 3, 'ID', 'Kec. Bakam', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290116', 3, 'ID', 'Kec. Pemali', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290117', 3, 'ID', 'Kec. Riau Silip', '290100');
INSERT INTO siakad.master_wilayah VALUES ('290200', 2, 'ID', 'Kab. Belitung', '290000');
INSERT INTO siakad.master_wilayah VALUES ('290201', 3, 'ID', 'Kec. Membalong', '290200');
INSERT INTO siakad.master_wilayah VALUES ('290206', 3, 'ID', 'Kec. Tanjung Pandan', '290200');
INSERT INTO siakad.master_wilayah VALUES ('290207', 3, 'ID', 'Kec. Sijuk', '290200');
INSERT INTO siakad.master_wilayah VALUES ('290208', 3, 'ID', 'Kec. Badau', '290200');
INSERT INTO siakad.master_wilayah VALUES ('290209', 3, 'ID', 'Kec. Selat Nasik', '290200');
INSERT INTO siakad.master_wilayah VALUES ('290225', 3, 'ID', 'Kec. Air Gegas', '290200');
INSERT INTO siakad.master_wilayah VALUES ('290300', 2, 'ID', 'Kab. Bangka Tengah', '290000');
INSERT INTO siakad.master_wilayah VALUES ('290301', 3, 'ID', 'Kec. Koba', '290300');
INSERT INTO siakad.master_wilayah VALUES ('290302', 3, 'ID', 'Kec. Pangkalan Baru', '290300');
INSERT INTO siakad.master_wilayah VALUES ('290303', 3, 'ID', 'Kec. Sungai Selan', '290300');
INSERT INTO siakad.master_wilayah VALUES ('290304', 3, 'ID', 'Kec. Simpang Katis', '290300');
INSERT INTO siakad.master_wilayah VALUES ('290305', 3, 'ID', 'Kec. Lubuk Besar', '290300');
INSERT INTO siakad.master_wilayah VALUES ('290306', 3, 'ID', 'Kec. Namang', '290300');
INSERT INTO siakad.master_wilayah VALUES ('290400', 2, 'ID', 'Kab. Bangka Barat', '290000');
INSERT INTO siakad.master_wilayah VALUES ('290401', 3, 'ID', 'Kec. Kelapa', '290400');
INSERT INTO siakad.master_wilayah VALUES ('290402', 3, 'ID', 'Kec. Tempilang', '290400');
INSERT INTO siakad.master_wilayah VALUES ('290403', 3, 'ID', 'Kec. Mentok', '290400');
INSERT INTO siakad.master_wilayah VALUES ('290404', 3, 'ID', 'Kec. Simpang Teritip', '290400');
INSERT INTO siakad.master_wilayah VALUES ('290405', 3, 'ID', 'Kec. Jebus', '290400');
INSERT INTO siakad.master_wilayah VALUES ('290406', 3, 'ID', 'Kec. Parittiga', '290400');
INSERT INTO siakad.master_wilayah VALUES ('290500', 2, 'ID', 'Kab. Bangka Selatan', '290000');
INSERT INTO siakad.master_wilayah VALUES ('290501', 3, 'ID', 'Kec. Payung', '290500');
INSERT INTO siakad.master_wilayah VALUES ('290502', 3, 'ID', 'Kec. Simpang Rimba', '290500');
INSERT INTO siakad.master_wilayah VALUES ('290503', 3, 'ID', 'Kec. Toboali', '290500');
INSERT INTO siakad.master_wilayah VALUES ('290505', 3, 'ID', 'Kec. Lepar Pongok', '290500');
INSERT INTO siakad.master_wilayah VALUES ('290506', 3, 'ID', 'Kec. Pulau Besar', '290500');
INSERT INTO siakad.master_wilayah VALUES ('290507', 3, 'ID', 'Kec. Tukak Sadai', '290500');
INSERT INTO siakad.master_wilayah VALUES ('290508', 3, 'ID', 'Air Gegas', '      ');
INSERT INTO siakad.master_wilayah VALUES ('290600', 2, 'ID', 'Kab. Belitung Timur', '290000');
INSERT INTO siakad.master_wilayah VALUES ('290601', 3, 'ID', 'Kec. Dendang', '290600');
INSERT INTO siakad.master_wilayah VALUES ('290602', 3, 'ID', 'Kec. Gantung', '290600');
INSERT INTO siakad.master_wilayah VALUES ('290603', 3, 'ID', 'Kec. Manggar', '290600');
INSERT INTO siakad.master_wilayah VALUES ('290604', 3, 'ID', 'Kec. Kelapa Kampit', '290600');
INSERT INTO siakad.master_wilayah VALUES ('290605', 3, 'ID', 'Kec. Damar', '290600');
INSERT INTO siakad.master_wilayah VALUES ('290606', 3, 'ID', 'Kec. Simpang Renggiang', '290600');
INSERT INTO siakad.master_wilayah VALUES ('290607', 3, 'ID', 'Kec. Simpang Pesak', '290600');
INSERT INTO siakad.master_wilayah VALUES ('296000', 2, 'ID', 'Kota Pangkalpinang', '290000');
INSERT INTO siakad.master_wilayah VALUES ('296001', 3, 'ID', 'Kec. Rangkui', '296000');
INSERT INTO siakad.master_wilayah VALUES ('296002', 3, 'ID', 'Kec. Bukit Intan', '296000');
INSERT INTO siakad.master_wilayah VALUES ('296003', 3, 'ID', 'Kec. Pangkal Balam', '296000');
INSERT INTO siakad.master_wilayah VALUES ('296004', 3, 'ID', 'Kec. Taman Sari', '296000');
INSERT INTO siakad.master_wilayah VALUES ('296005', 3, 'ID', 'Kec. Gerunggang', '296000');
INSERT INTO siakad.master_wilayah VALUES ('296090', 3, 'ID', 'Girimaya', '      ');
INSERT INTO siakad.master_wilayah VALUES ('300000', 1, 'ID', 'Prov. Gorontalo', '000000');
INSERT INTO siakad.master_wilayah VALUES ('300100', 2, 'ID', 'Kab. Boalemo', '300000');
INSERT INTO siakad.master_wilayah VALUES ('300104', 3, 'ID', 'Kec. Tilamuta', '300100');
INSERT INTO siakad.master_wilayah VALUES ('300106', 3, 'ID', 'Kec. Paguyaman', '300100');
INSERT INTO siakad.master_wilayah VALUES ('300107', 3, 'ID', 'Kec. Mananggu', '300100');
INSERT INTO siakad.master_wilayah VALUES ('300108', 3, 'ID', 'Kec. Dulupi', '300100');
INSERT INTO siakad.master_wilayah VALUES ('300109', 3, 'ID', 'Kec. Wonosari', '300100');
INSERT INTO siakad.master_wilayah VALUES ('300110', 3, 'ID', 'Kec. Botumoita', '300100');
INSERT INTO siakad.master_wilayah VALUES ('300111', 3, 'ID', 'Kec. Paguyaman Pantai', '300100');
INSERT INTO siakad.master_wilayah VALUES ('300200', 2, 'ID', 'Kab. Gorontalo', '300000');
INSERT INTO siakad.master_wilayah VALUES ('300201', 3, 'ID', 'Kec. Batudaa Pantai', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300202', 3, 'ID', 'Kec. Batudaa', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300203', 3, 'ID', 'Kec. Tibawa', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300204', 3, 'ID', 'Kec. Boliyohuto', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300207', 3, 'ID', 'Kec. Limboto', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300208', 3, 'ID', 'Kec. Telaga', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300210', 3, 'ID', 'Kec. Bongomeme', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300211', 3, 'ID', 'Kec. Pulubala', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300215', 3, 'ID', 'Kec. Tolangohula', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300216', 3, 'ID', 'Kec. Mootilango', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300218', 3, 'ID', 'Kec. Telaga Biru', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300219', 3, 'ID', 'Kec. Limboto Barat', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300220', 3, 'ID', 'Kec. Biluhu', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300221', 3, 'ID', 'Kec. Tabongo', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300222', 3, 'ID', 'Kec. Asparaga', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300223', 3, 'ID', 'Kec. Tilango', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300224', 3, 'ID', 'Kec. Telaga Jaya', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300225', 3, 'ID', 'Kec. Bilato', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300226', 3, 'ID', 'Bilato', '      ');
INSERT INTO siakad.master_wilayah VALUES ('300300', 2, 'ID', 'Kab. Pohuwato', '300000');
INSERT INTO siakad.master_wilayah VALUES ('300301', 3, 'ID', 'Kec. Popayato', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300302', 3, 'ID', 'Kec. Marisa', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300303', 3, 'ID', 'Kec. Paguat', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300304', 3, 'ID', 'Kec. Lemito', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300305', 3, 'ID', 'Kec. Randangan', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300306', 3, 'ID', 'Kec. Patilanggio', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300307', 3, 'ID', 'Kec. Taluditi', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300308', 3, 'ID', 'Kec. Popayato Barat', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300309', 3, 'ID', 'Kec. Popayato Timur', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300310', 3, 'ID', 'Kec. Wanggarasi', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300311', 3, 'ID', 'Kec. Buntulia', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300312', 3, 'ID', 'Kec. Duhiadaa', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300313', 3, 'ID', 'Kec. Dengilo', '300300');
INSERT INTO siakad.master_wilayah VALUES ('300400', 2, 'ID', 'Kab. Bone Bolango', '300000');
INSERT INTO siakad.master_wilayah VALUES ('300401', 3, 'ID', 'Kec. Tapa', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300402', 3, 'ID', 'Kec. Kabila', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300403', 3, 'ID', 'Kec. Suwawa', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300404', 3, 'ID', 'Kec. Bonepantai', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300405', 3, 'ID', 'Kec. Bulango Utara', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300406', 3, 'ID', 'Kec. Tilongkabila', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300407', 3, 'ID', 'Kec. Botupingge', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300408', 3, 'ID', 'Kec. Kabila Bone', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300409', 3, 'ID', 'Kec. Bone', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300410', 3, 'ID', 'Kec. Bone Raya', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300411', 3, 'ID', 'Kec. Bulango Selatan', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300412', 3, 'ID', 'Kec. Bulango Timur', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300413', 3, 'ID', 'Kec. Bulango Ulu', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300414', 3, 'ID', 'Kec. Suwawa Selatan', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300415', 3, 'ID', 'Kec. Suwawa Timur', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300416', 3, 'ID', 'Kec. Suwawa Tengah', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300417', 3, 'ID', 'Kec. Bulawa', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300500', 2, 'ID', 'Kab. Gorontalo Utara', '300000');
INSERT INTO siakad.master_wilayah VALUES ('300501', 3, 'ID', 'Kec. Anggrek', '300500');
INSERT INTO siakad.master_wilayah VALUES ('300502', 3, 'ID', 'Kec. Atinggola', '300500');
INSERT INTO siakad.master_wilayah VALUES ('300503', 3, 'ID', 'Kec. Kwandang', '300500');
INSERT INTO siakad.master_wilayah VALUES ('300504', 3, 'ID', 'Kec. Sumalata', '300500');
INSERT INTO siakad.master_wilayah VALUES ('300505', 3, 'ID', 'Kec. Tolinggula', '300500');
INSERT INTO siakad.master_wilayah VALUES ('300506', 3, 'ID', 'Kec. Gentuma Raya', '300500');
INSERT INTO siakad.master_wilayah VALUES ('300507', 3, 'ID', 'Tomilito', '      ');
INSERT INTO siakad.master_wilayah VALUES ('300508', 3, 'ID', 'Ponelo Kepulauan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('300509', 3, 'ID', 'Monano', '      ');
INSERT INTO siakad.master_wilayah VALUES ('300511', 3, 'ID', 'Biau', '      ');
INSERT INTO siakad.master_wilayah VALUES ('306000', 2, 'ID', 'Kota Gorontalo', '300000');
INSERT INTO siakad.master_wilayah VALUES ('306001', 3, 'ID', 'Kec. Kota Barat', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306002', 3, 'ID', 'Kec. Kota Selatan', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306003', 3, 'ID', 'Kec. Kota Utara', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306004', 3, 'ID', 'Kec. Kota Timur', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306005', 3, 'ID', 'Kec. Dungingi', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306006', 3, 'ID', 'Kec. Kota Tengah', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306007', 3, 'ID', 'Kec. Sipatana', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306008', 3, 'ID', 'Kec. Dumbo Raya', '306000');
INSERT INTO siakad.master_wilayah VALUES ('306009', 3, 'ID', 'Kec. Hulonthalangi', '306000');
INSERT INTO siakad.master_wilayah VALUES ('310000', 1, 'ID', 'Prov. Kepulauan Riau', '000000');
INSERT INTO siakad.master_wilayah VALUES ('310100', 2, 'ID', 'Kab. Bintan', '310000');
INSERT INTO siakad.master_wilayah VALUES ('310101', 3, 'ID', 'Kec. Bintan Utara', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310102', 3, 'ID', 'Kec. Gunung Kijang', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310103', 3, 'ID', 'Kec. Tambelan', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310104', 3, 'ID', 'Kec. Teluk Bintan', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310105', 3, 'ID', 'Kec. Teluk Sebong', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310106', 3, 'ID', 'Kec. Toapaya', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310107', 3, 'ID', 'Kec. Mantang', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310108', 3, 'ID', 'Kec. Bintan Pesisir', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310109', 3, 'ID', 'Kec. Seri Kuala Loban', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310110', 3, 'ID', 'Kec. Bintan Timur', '310100');
INSERT INTO siakad.master_wilayah VALUES ('310200', 2, 'ID', 'Kab. Karimun', '310000');
INSERT INTO siakad.master_wilayah VALUES ('310201', 3, 'ID', 'Kec. Moro', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310202', 3, 'ID', 'Kec. Kundur', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310203', 3, 'ID', 'Kec. Karimun', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310204', 3, 'ID', 'Kec. Meral', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310205', 3, 'ID', 'Kec. Tebing', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310206', 3, 'ID', 'Kec. Buru', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310207', 3, 'ID', 'Kec. Kundur Utara', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310208', 3, 'ID', 'Kec. Kundur Barat', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310209', 3, 'ID', 'Kec. Durai', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310300', 2, 'ID', 'Kab. Natuna', '310000');
INSERT INTO siakad.master_wilayah VALUES ('310303', 3, 'ID', 'Kec. Midai', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310304', 3, 'ID', 'Kec. Bunguran Barat', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310305', 3, 'ID', 'Kec. Bunguran Timur', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310306', 3, 'ID', 'Kec. Serasan', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310309', 3, 'ID', 'Kec. Subi', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310311', 3, 'ID', 'Kec. Bunguran Utara', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310312', 3, 'ID', 'Kec. Pulau Laut', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310313', 3, 'ID', 'Kec. Pulau Tiga', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310317', 3, 'ID', 'Kec. Bunguran Timur Laut', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310318', 3, 'ID', 'Kec. Bunguran Tengah', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310320', 3, 'ID', 'Kec. Bunguran Selatan', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310321', 3, 'ID', 'Kec. Serasan Timur', '310300');
INSERT INTO siakad.master_wilayah VALUES ('310400', 2, 'ID', 'Kab. Lingga', '310000');
INSERT INTO siakad.master_wilayah VALUES ('310401', 3, 'ID', 'Kec. Singkep', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310402', 3, 'ID', 'Kec. Lingga', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310403', 3, 'ID', 'Kec. Senayang', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310404', 3, 'ID', 'Kec. Singkep Barat', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310405', 3, 'ID', 'Kec. Lingga Utara', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310500', 2, 'ID', 'Kab. Kepulauan Anambas', '310000');
INSERT INTO siakad.master_wilayah VALUES ('310501', 3, 'ID', 'Kec. Jemaja', '310500');
INSERT INTO siakad.master_wilayah VALUES ('310502', 3, 'ID', 'Kec. Jemaja Timur', '310500');
INSERT INTO siakad.master_wilayah VALUES ('310503', 3, 'ID', 'Kec. Siantan', '310500');
INSERT INTO siakad.master_wilayah VALUES ('310504', 3, 'ID', 'Kec. Palmatak', '310500');
INSERT INTO siakad.master_wilayah VALUES ('310505', 3, 'ID', 'Kec. Siantan Selatan', '310500');
INSERT INTO siakad.master_wilayah VALUES ('310506', 3, 'ID', 'Kec. Siantan Timur', '310500');
INSERT INTO siakad.master_wilayah VALUES ('310507', 3, 'ID', 'Kec. Siantan Tengah', '310500');
INSERT INTO siakad.master_wilayah VALUES ('316000', 2, 'ID', 'Kota Batam', '310000');
INSERT INTO siakad.master_wilayah VALUES ('316001', 3, 'ID', 'Kec. Belakang Padang', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316002', 3, 'ID', 'Kec. Sekupang', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316003', 3, 'ID', 'Kec. Sei Beduk', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316004', 3, 'ID', 'Kec. Bulang', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316005', 3, 'ID', 'Kec. Lubuk Baja', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316006', 3, 'ID', 'Kec. Batu Ampar', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316007', 3, 'ID', 'Kec. Nongsa', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316008', 3, 'ID', 'Kec. Galang', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316011', 3, 'ID', 'Kec. Bengkong', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316012', 3, 'ID', 'Kec. Batam Kota', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316013', 3, 'ID', 'Kec. Sagulung', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316014', 3, 'ID', 'Kec. Batu Aji', '316000');
INSERT INTO siakad.master_wilayah VALUES ('316100', 2, 'ID', 'Kota Tanjungpinang', '310000');
INSERT INTO siakad.master_wilayah VALUES ('316101', 3, 'ID', 'Kec. Tanjung Pinang Barat', '316100');
INSERT INTO siakad.master_wilayah VALUES ('316102', 3, 'ID', 'Kec. Tanjung Pinang Timur', '316100');
INSERT INTO siakad.master_wilayah VALUES ('316103', 3, 'ID', 'Kec. Bukit Bestari', '316100');
INSERT INTO siakad.master_wilayah VALUES ('316104', 3, 'ID', 'Kec. Tanjung Pinang Kota', '316100');
INSERT INTO siakad.master_wilayah VALUES ('320000', 1, 'ID', 'Prov. Papua Barat', '000000');
INSERT INTO siakad.master_wilayah VALUES ('320100', 2, 'ID', 'Kab. Fak-Fak', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320101', 3, 'ID', 'Kec.  Fak-Fak Timur', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320102', 3, 'ID', 'Kec.  Karas', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320103', 3, 'ID', 'Kec.  Fak-Fak', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320104', 3, 'ID', 'Kec.  Fak-Fak Tengah', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320105', 3, 'ID', 'Kec.  Fak-Fak Barat', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320106', 3, 'ID', 'Kec.  Kokas', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320107', 3, 'ID', 'Kec.  Teluk Patipi', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320108', 3, 'ID', 'Kec.  Kramongmongga', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320109', 3, 'ID', 'Kec.  Bomberay', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320200', 2, 'ID', 'Kab. Kaimana', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320201', 3, 'ID', 'Kec.  Buruway', '320200');
INSERT INTO siakad.master_wilayah VALUES ('320202', 3, 'ID', 'Kec.  Teluk Arguni (Atas)', '320200');
INSERT INTO siakad.master_wilayah VALUES ('320203', 3, 'ID', 'Kec.  Teluk Arguni Bawah', '320200');
INSERT INTO siakad.master_wilayah VALUES ('320204', 3, 'ID', 'Kec.  Kaimana', '320200');
INSERT INTO siakad.master_wilayah VALUES ('320205', 3, 'ID', 'Kec.  Kambrau', '320200');
INSERT INTO siakad.master_wilayah VALUES ('320206', 3, 'ID', 'Kec.  Teluk Etna', '320200');
INSERT INTO siakad.master_wilayah VALUES ('320207', 3, 'ID', 'Kec.  Yamor', '320200');
INSERT INTO siakad.master_wilayah VALUES ('320300', 2, 'ID', 'Kab. Teluk Wondama', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320301', 3, 'ID', 'Kec.  Naikere', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320302', 3, 'ID', 'Kec.  Wondiboy', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320303', 3, 'ID', 'Kec.  Rasiei', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320304', 3, 'ID', 'Kec.  Kuri Wamesa', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320305', 3, 'ID', 'Kec.  Wasior', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320306', 3, 'ID', 'Kec.  Teluk Duairi', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320307', 3, 'ID', 'Kec.  Roon', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320308', 3, 'ID', 'Kec.  Windesi', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320309', 3, 'ID', 'Kec.  Wamesa', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320310', 3, 'ID', 'Kec.  Roswar', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320311', 3, 'ID', 'Kec.  Rumberpon', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320312', 3, 'ID', 'Kec.  Soug Jaya', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320313', 3, 'ID', 'Kec.  Nikiwar', '320300');
INSERT INTO siakad.master_wilayah VALUES ('320390', 3, 'ID', 'Sough Wepu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320400', 2, 'ID', 'Kab. Teluk Bintuni', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320401', 3, 'ID', 'Kec. Irorutu/Fafuwar', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320402', 3, 'ID', 'Kec. Babo', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320403', 3, 'ID', 'Kec. Sumuri', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320404', 3, 'ID', 'Kec. Aroba', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320405', 3, 'ID', 'Kec. Kaitaro', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320406', 3, 'ID', 'Kec. Kuri', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320407', 3, 'ID', 'Kec. Idoor', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320408', 3, 'ID', 'Kec. Bintuni', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320409', 3, 'ID', 'Kec. Manimeri', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320410', 3, 'ID', 'Kec. Tuhiba', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320411', 3, 'ID', 'Kec. Dataran Beimes', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320412', 3, 'ID', 'Kec. Tembuni', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320413', 3, 'ID', 'Kec. Aranday', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320414', 3, 'ID', 'Kec. Komundan', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320415', 3, 'ID', 'Kec. Tomu', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320416', 3, 'ID', 'Kec. Weriagar', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320417', 3, 'ID', 'Kec. Moskona Selatan', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320418', 3, 'ID', 'Kec. Meyado', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320419', 3, 'ID', 'Kec. Moskona Barat', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320420', 3, 'ID', 'Kec. Merdey', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320421', 3, 'ID', 'Kec. Biscoop', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320422', 3, 'ID', 'Kec. Masyeta', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320423', 3, 'ID', 'Kec. Moskona Utara', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320424', 3, 'ID', 'Kec. Moskona Timur', '320400');
INSERT INTO siakad.master_wilayah VALUES ('320425', 3, 'ID', 'Wamesa', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320500', 2, 'ID', 'Kab. Manokwari', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320501', 3, 'ID', 'Kec. Ransiki', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320502', 3, 'ID', 'Kec. Momi Waren', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320503', 3, 'ID', 'Kec. Nenei', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320504', 3, 'ID', 'Kec. Sururay', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320505', 3, 'ID', 'Kec. Anggi', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320506', 3, 'ID', 'Kec. Taige', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320507', 3, 'ID', 'Kec. Membey', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320508', 3, 'ID', 'Kec. Oransbari', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320509', 3, 'ID', 'Kec. Warmare', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320510', 3, 'ID', 'Kec. Prafi', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320511', 3, 'ID', 'Kec. Menyambouw', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320512', 3, 'ID', 'Kec. Catubouw', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320513', 3, 'ID', 'Kec. Manokwari Barat', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320514', 3, 'ID', 'Kec. Manokwari Timur', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320515', 3, 'ID', 'Kec. Manokwari Utara', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320516', 3, 'ID', 'Kec. Manokwari Selatan', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320517', 3, 'ID', 'Kec. Testega', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320518', 3, 'ID', 'Kec. Tanah Rubu', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320519', 3, 'ID', 'Kec. Kebar', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320520', 3, 'ID', 'Kec. Senopi', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320521', 3, 'ID', 'Kec. Amberbaken', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320522', 3, 'ID', 'Kec. Murbani/Arfu', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320523', 3, 'ID', 'Kec. Masni', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320524', 3, 'ID', 'Kec. Sidey', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320525', 3, 'ID', 'Kec. Tahosta', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320526', 3, 'ID', 'Kec. Didohu', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320527', 3, 'ID', 'Kec. Dataran Isim', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320528', 3, 'ID', 'Kec. Anggi Gida', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320529', 3, 'ID', 'Kec. Hingk', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320530', 3, 'ID', 'Neney', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320531', 3, 'ID', 'Momi - Waren', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320532', 3, 'ID', 'Tohota', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320533', 3, 'ID', 'Taige', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320534', 3, 'ID', 'Membey', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320535', 3, 'ID', 'Anggi Gida', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320536', 3, 'ID', 'Didohu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320537', 3, 'ID', 'Dataran Isim', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320538', 3, 'ID', 'Catubouw', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320539', 3, 'ID', 'Hink', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320590', 3, 'ID', 'Ransiki', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320600', 2, 'ID', 'Kab. Sorong Selatan', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320601', 3, 'ID', 'Kec.  Inanwatan', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320602', 3, 'ID', 'Kec. Kokoda', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320603', 3, 'ID', 'Kec. Metemeini Kais', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320608', 3, 'ID', 'Kec. Moswaren', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320610', 3, 'ID', 'Kec. Seremuk', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320611', 3, 'ID', 'Kec. Wayer', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320612', 3, 'ID', 'Kec. Sawiat', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320616', 3, 'ID', 'Kec.  Kais', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320617', 3, 'ID', 'Kec.  Konda', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320618', 3, 'ID', 'Kec.  Kokoda Utara', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320619', 3, 'ID', 'Kec.  Saifi', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320620', 3, 'ID', 'Kec.  Fokour', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320621', 3, 'ID', 'Kec.  Teminabuan', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320700', 2, 'ID', 'Kab. Sorong', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320705', 3, 'ID', 'Kec. Moraid', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320706', 3, 'ID', 'Kec. Makbon', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320707', 3, 'ID', 'Kec. Beraur', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320708', 3, 'ID', 'Kec. Klamono', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320709', 3, 'ID', 'Kec. Salawati', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320710', 3, 'ID', 'Kec. Manyamuk', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320711', 3, 'ID', 'Kec. Seget', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320712', 3, 'ID', 'Kec. Segun', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320713', 3, 'ID', 'Kec. Salawati Selatan', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320714', 3, 'ID', 'Kec. Aimas', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320715', 3, 'ID', 'Kec. Sayosa', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320716', 3, 'ID', 'Kec.  Klabot', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320717', 3, 'ID', 'Kec.  Klawak', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320718', 3, 'ID', 'Kec.  Maudus', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320719', 3, 'ID', 'Kec.  Mariat', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320720', 3, 'ID', 'Kec.  Klayili', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320721', 3, 'ID', 'Kec.  Klaso', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320722', 3, 'ID', 'Kec.  Moisegen', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320800', 2, 'ID', 'Kab. Raja Ampat', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320801', 3, 'ID', 'Kec.  Misool Selatan', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320802', 3, 'ID', 'Kec.  Misool (Misool Utara)', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320803', 3, 'ID', 'Kec.  Kofiau', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320804', 3, 'ID', 'Kec.  Misool Timur', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320805', 3, 'ID', 'Kec.  Salawati Utara', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320807', 3, 'ID', 'Kec.  Waigeo Selatan', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320808', 3, 'ID', 'Kec.  Teluk Mayalibit', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320809', 3, 'ID', 'Kec.  Meos Mansar', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320810', 3, 'ID', 'Kec.  Waigeo Barat', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320811', 3, 'ID', 'Kec.  Waigeo Utara', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320812', 3, 'ID', 'Kec.  Kepulauan Ayau', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320813', 3, 'ID', 'Kec.  Waigeo Timur', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320814', 3, 'ID', 'Kec.  Warwarbomi', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320815', 3, 'ID', 'Kec.  Waigeo Barat Kepulauan', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320816', 3, 'ID', 'Kec.  Misool Barat', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320817', 3, 'ID', 'Kec.  Kepulauan Sembilan', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320818', 3, 'ID', 'Kec.  Kota Waisai', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320819', 3, 'ID', 'Kec.  Tiplol Mayalibit', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320820', 3, 'ID', 'Kec.  Batanta Utara', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320821', 3, 'ID', 'Kec.  Salawati Barat', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320822', 3, 'ID', 'Kec.  Salawati Tengah', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320823', 3, 'ID', 'Kec.  Supnin', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320824', 3, 'ID', 'Kec.  Ayau', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320825', 3, 'ID', 'Kec.  Batanta Selatan', '320800');
INSERT INTO siakad.master_wilayah VALUES ('320890', 3, 'ID', 'Selat Sagawin', '      ');
INSERT INTO siakad.master_wilayah VALUES ('320900', 2, 'ID', 'Kab. Tambrauw', '320000');
INSERT INTO siakad.master_wilayah VALUES ('320901', 3, 'ID', 'Kec.  Fef', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320902', 3, 'ID', 'Kec.  Miyah', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320903', 3, 'ID', 'Kec.  Yembun', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320904', 3, 'ID', 'Kec.  Kwoor', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320905', 3, 'ID', 'Kec.  Sausapor', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320906', 3, 'ID', 'Kec.  Abun', '320900');
INSERT INTO siakad.master_wilayah VALUES ('321000', 2, 'ID', 'Kab. Maybrat', '320000');
INSERT INTO siakad.master_wilayah VALUES ('321001', 3, 'ID', 'Kec.  Aifat', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321002', 3, 'ID', 'Kec.  Aifat Utara', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321003', 3, 'ID', 'Kec.  Aifat Timur', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321004', 3, 'ID', 'Kec.  Aifat Selatan', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321005', 3, 'ID', 'Kec.  Aitinyo Barat', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321006', 3, 'ID', 'Kec.  Aitinyo', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321007', 3, 'ID', 'Kec.  Aitinyo Utara', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321008', 3, 'ID', 'Kec.  Ayamaru', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321009', 3, 'ID', 'Kec.  Ayamaru Utara', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321010', 3, 'ID', 'Kec.  Ayamaru Timur', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321011', 3, 'ID', 'Kec.  Mare', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321012', 3, 'ID', 'Aitinyo Tengah', '      ');
INSERT INTO siakad.master_wilayah VALUES ('321013', 3, 'ID', 'Aifat Timur Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('321015', 3, 'ID', 'Aitinyo Raya', '      ');
INSERT INTO siakad.master_wilayah VALUES ('321090', 3, 'ID', 'Ayamaru Timur Selatan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('321091', 3, 'ID', 'Aifat Timur Tengah', '      ');
INSERT INTO siakad.master_wilayah VALUES ('321092', 3, 'ID', 'Aifat Timur Jauh', '      ');
INSERT INTO siakad.master_wilayah VALUES ('321099', 3, 'ID', 'Ayamaru Jaya', '      ');
INSERT INTO siakad.master_wilayah VALUES ('326000', 2, 'ID', 'Kota Sorong', '320000');
INSERT INTO siakad.master_wilayah VALUES ('326002', 3, 'ID', 'Kec.  Sorong Timur', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326003', 3, 'ID', 'Kec.  Sorong', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326006', 3, 'ID', 'Kec.  Klablim', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326007', 3, 'ID', 'Kec.  Klawalu', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326008', 3, 'ID', 'Kec.  Giwu', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326009', 3, 'ID', 'Kec.  Klamana', '326000');
INSERT INTO siakad.master_wilayah VALUES ('330000', 1, 'ID', 'Prov. Sulawesi Barat', '000000');
INSERT INTO siakad.master_wilayah VALUES ('330100', 2, 'ID', 'Kab. Mamuju', '330000');
INSERT INTO siakad.master_wilayah VALUES ('330101', 3, 'ID', 'Kec. Tapalang', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330102', 3, 'ID', 'Kec. Mamuju', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330103', 3, 'ID', 'Kec. Kalukku', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330104', 3, 'ID', 'Kec. Kalumpang', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330105', 3, 'ID', 'Kec. Budong-Budong', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330106', 3, 'ID', 'Kec. Tapalang Barat', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330107', 3, 'ID', 'Kec. Papalang', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330108', 3, 'ID', 'Kec. Sampaga', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330109', 3, 'ID', 'Kec. Pangale', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330110', 3, 'ID', 'Kec. Tommo', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330111', 3, 'ID', 'Kec. Bonehau', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330112', 3, 'ID', 'Kec. Topoyo', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330113', 3, 'ID', 'Kec. Tobadak', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330114', 3, 'ID', 'Kec. Karossa', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330115', 3, 'ID', 'Kec. Simboro Kepulauan', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330116', 3, 'ID', 'Kec. Kep. Bala Balakang', '330100');
INSERT INTO siakad.master_wilayah VALUES ('330117', 3, 'ID', 'Topoyo', '      ');
INSERT INTO siakad.master_wilayah VALUES ('330190', 3, 'ID', 'Budong-budong', '      ');
INSERT INTO siakad.master_wilayah VALUES ('330191', 3, 'ID', 'Pangale', '      ');
INSERT INTO siakad.master_wilayah VALUES ('330200', 2, 'ID', 'Kab. Mamuju Utara', '330000');
INSERT INTO siakad.master_wilayah VALUES ('330201', 3, 'ID', 'Kec. Pasangkayu', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330202', 3, 'ID', 'Kec. Sarudu', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330203', 3, 'ID', 'Kec. Baras', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330204', 3, 'ID', 'Kec. Bambalamutu', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330205', 3, 'ID', 'Kec. Dapurang', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330206', 3, 'ID', 'Kec. Duripoku', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330207', 3, 'ID', 'Kec. Bulu Taba', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330208', 3, 'ID', 'Kec. Lariang', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330209', 3, 'ID', 'Kec. Tikke Raya', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330210', 3, 'ID', 'Kec. Pedongga', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330211', 3, 'ID', 'Kec. Bambaira', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330212', 3, 'ID', 'Kec. Sarjo', '330200');
INSERT INTO siakad.master_wilayah VALUES ('330292', 3, 'ID', 'Karossa', '      ');
INSERT INTO siakad.master_wilayah VALUES ('330293', 3, 'ID', 'Simboro Dan Kepulauan', '      ');
INSERT INTO siakad.master_wilayah VALUES ('330294', 3, 'ID', 'Tobadak', '      ');
INSERT INTO siakad.master_wilayah VALUES ('330300', 2, 'ID', 'Kab. Polewali Mamasa', '330000');
INSERT INTO siakad.master_wilayah VALUES ('330301', 3, 'ID', 'Kec. Tinambung', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330302', 3, 'ID', 'Kec. Tutallu', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330303', 3, 'ID', 'Kec. Campalagian', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330304', 3, 'ID', 'Kec. Wonomulyo', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330305', 3, 'ID', 'Kec. Polewali', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330306', 3, 'ID', 'Kec. Limboro', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330307', 3, 'ID', 'Kec. Balanipa', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330308', 3, 'ID', 'Kec. Luyo', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330309', 3, 'ID', 'Kec. Allu', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330310', 3, 'ID', 'Kec. Mapili', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330311', 3, 'ID', 'Kec. Matakali', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330312', 3, 'ID', 'Kec. Binuang', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330313', 3, 'ID', 'Kec. Anreapi', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330314', 3, 'ID', 'Kec. Tapango', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330315', 3, 'ID', 'Kec. Matangnga', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330316', 3, 'ID', 'Kec. Bulo', '330300');
INSERT INTO siakad.master_wilayah VALUES ('330317', 3, 'ID', 'Tutar', '      ');
INSERT INTO siakad.master_wilayah VALUES ('330400', 2, 'ID', 'Kab. Mamasa', '330000');
INSERT INTO siakad.master_wilayah VALUES ('330401', 3, 'ID', 'Kec. Sumarorong', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330402', 3, 'ID', 'Kec. Pana', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330403', 3, 'ID', 'Kec. Mamasa', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330404', 3, 'ID', 'Kec. Mambi', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330405', 3, 'ID', 'Kec. Tabulahan', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330406', 3, 'ID', 'Kec. Tabang', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330407', 3, 'ID', 'Kec. Messawa', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330408', 3, 'ID', 'Kec. Sesenapadang', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330409', 3, 'ID', 'Kec. Tandukalua', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330410', 3, 'ID', 'Kec. Aralle', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330411', 3, 'ID', 'Kec. Nosu', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330412', 3, 'ID', 'Kec. Bambang', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330413', 3, 'ID', 'Kec. Balla', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330414', 3, 'ID', 'Kec. Tawalian', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330415', 3, 'ID', 'Kec. Rantebulahan Timur', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330416', 3, 'ID', 'Kec. Buntumalangka', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330417', 3, 'ID', 'Kec. Mehalaan', '330400');
INSERT INTO siakad.master_wilayah VALUES ('330500', 2, 'ID', 'Kab. Majene', '330000');
INSERT INTO siakad.master_wilayah VALUES ('330502', 3, 'ID', 'Kec. Pamboang', '330500');
INSERT INTO siakad.master_wilayah VALUES ('330505', 3, 'ID', 'Kec. Ulumunda', '330500');
INSERT INTO siakad.master_wilayah VALUES ('330506', 3, 'ID', 'Kec. Tammerodo Sendana', '330500');
INSERT INTO siakad.master_wilayah VALUES ('330507', 3, 'ID', 'Kec. Tubo Sendana', '330500');
INSERT INTO siakad.master_wilayah VALUES ('330509', 3, 'ID', 'Kec. Banggai', '330500');
INSERT INTO siakad.master_wilayah VALUES ('330510', 3, 'ID', 'Kec. Sendana', '330500');
INSERT INTO siakad.master_wilayah VALUES ('330511', 3, 'ID', 'Kec. Malunda', '330500');
INSERT INTO siakad.master_wilayah VALUES ('330512', 3, 'ID', 'Kec. Banggai Timur', '330500');
INSERT INTO siakad.master_wilayah VALUES ('340000', 1, 'ID', 'Prov. Kalimantan Utara', '000000');
INSERT INTO siakad.master_wilayah VALUES ('340001', 3, 'ID', 'Tanjung Palas Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340002', 3, 'ID', 'Peso Ilir', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340003', 3, 'ID', 'Tanjung Palas', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340004', 3, 'ID', 'Tanjung Palas Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340005', 3, 'ID', 'Tanjung Selor', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340006', 3, 'ID', 'Peso', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340007', 3, 'ID', 'Tanjung Palas Tengah', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340008', 3, 'ID', 'Bunyu', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340009', 3, 'ID', 'Tanjung Palas Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340010', 3, 'ID', 'Sekatak', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340100', 2, 'ID', 'Kab. Malinau', '340000');
INSERT INTO siakad.master_wilayah VALUES ('340101', 3, 'ID', 'Tarakan Utara', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340102', 3, 'ID', 'Tarakan Tengah', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340103', 3, 'ID', 'Tarakan Timur', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340104', 3, 'ID', 'Tarakan Barat', '      ');
INSERT INTO siakad.master_wilayah VALUES ('340200', 2, 'ID', 'Kab. Bulungan', '340000');
INSERT INTO siakad.master_wilayah VALUES ('340300', 2, 'ID', 'Kab. Tana Tidung', '340000');
INSERT INTO siakad.master_wilayah VALUES ('340500', 2, 'ID', 'Kab. Nunukan', '340000');
INSERT INTO siakad.master_wilayah VALUES ('346000', 2, 'ID', 'Kota Tarakan', '340000');
INSERT INTO siakad.master_wilayah VALUES ('999999', 3, 'ID', 'tidak ada', '      ');
INSERT INTO siakad.master_wilayah VALUES ('021438', 3, 'ID', 'Kec. Banjaranyar', '021400');
INSERT INTO siakad.master_wilayah VALUES ('022228', 3, 'ID', 'Kec. Tarumajaya', '022200');
INSERT INTO siakad.master_wilayah VALUES ('022316', 3, 'ID', 'Kec. Saguling', '022300');
INSERT INTO siakad.master_wilayah VALUES ('022500', 2, 'ID', 'Kab. Pangandaran', '020000');
INSERT INTO siakad.master_wilayah VALUES ('022551', 3, 'ID', 'Kec. Cijulang', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022552', 3, 'ID', 'Kec. Cimerak', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022553', 3, 'ID', 'Kec. Cigugur', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022554', 3, 'ID', 'Kec. Langkaplancar', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022555', 3, 'ID', 'Kec. Mangunjaya', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022556', 3, 'ID', 'Kec. Padaherang', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022557', 3, 'ID', 'Kec. Kalipucang', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022558', 3, 'ID', 'Kec. Pangandaran', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022559', 3, 'ID', 'Kec. Sidamulih', '022500');
INSERT INTO siakad.master_wilayah VALUES ('022560', 3, 'ID', 'Kec. Parigi', '022500');
INSERT INTO siakad.master_wilayah VALUES ('040218', 3, 'ID', 'Kec. Gamping', '040200');
INSERT INTO siakad.master_wilayah VALUES ('046015', 3, 'ID', 'Kec. Gamping', '046000');
INSERT INTO siakad.master_wilayah VALUES ('050528', 3, 'ID', 'Kec. Gayam', '050500');
INSERT INTO siakad.master_wilayah VALUES ('052525', 3, 'ID', 'Kec. Blimbingsari', '052500');
INSERT INTO siakad.master_wilayah VALUES ('056403', 3, 'ID', 'Kec. Kranggan', '056400');
INSERT INTO siakad.master_wilayah VALUES ('061109', 3, 'ID', 'Kec. Teupah Tengah', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061110', 3, 'ID', 'Kec. Simeulue Cut', '061100');
INSERT INTO siakad.master_wilayah VALUES ('061510', 3, 'ID', 'Kec. Beutong Ateuh Banggalan', '061500');
INSERT INTO siakad.master_wilayah VALUES ('071518', 3, 'ID', 'Kec. Ranto Baek', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071519', 3, 'ID', 'Kec. Puncak Sorik Merapi', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071520', 3, 'ID', 'Kec. Sinunukan', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071521', 3, 'ID', 'Kec. Huta Bargot', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071522', 3, 'ID', 'Kec. Pakantan', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071523', 3, 'ID', 'Kec. Naga Juang', '071500');
INSERT INTO siakad.master_wilayah VALUES ('071719', 3, 'ID', 'Kec. Ulunoyo', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071720', 3, 'ID', 'Kec. Huruna', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071721', 3, 'ID', 'Kec. Oou', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071722', 3, 'ID', 'Kec. Onohazumba', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071723', 3, 'ID', 'Kec. Hilisalawaahe', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071724', 3, 'ID', 'Kec. Ulususua', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071725', 3, 'ID', 'Kec. Siduaori', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071726', 3, 'ID', 'Kec. Somambawa', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071727', 3, 'ID', 'Kec. Boronadu', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071728', 3, 'ID', 'Kec. Ulu Idanotae', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071729', 3, 'ID', 'Kec. Idanotae', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071730', 3, 'ID', 'Kec. Luahagundre Maniamolo', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071731', 3, 'ID', 'Kec. Onolalu', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071732', 3, 'ID', 'Kec. Pulau-Pulau Batu Utara', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071733', 3, 'ID', 'Kec. Pulau-Pulau Batu Barat', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071734', 3, 'ID', 'Kec. Simuk', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071735', 3, 'ID', 'Kec. Tanah Masa', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071736', 3, 'ID', 'Kec. Onolalu', '071700');
INSERT INTO siakad.master_wilayah VALUES ('071737', 3, 'ID', 'Kec. Luahagundre Maniamolo', '071700');
INSERT INTO siakad.master_wilayah VALUES ('072412', 3, 'ID', 'Kec. Sihapas Barumun', '072400');
INSERT INTO siakad.master_wilayah VALUES ('072709', 3, 'ID', 'Kec. Mandrehe Utara', '072700');
INSERT INTO siakad.master_wilayah VALUES ('076022', 3, 'ID', 'Kec. Medan Utara', '076000');
INSERT INTO siakad.master_wilayah VALUES ('080613', 3, 'ID', 'Kec. Silaut', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080614', 3, 'ID', 'Kec. Ranah Ampek Hulu Tapan', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080615', 3, 'ID', 'Kec. Air Pura', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080616', 3, 'ID', 'Kec. Air Pura', '080600');
INSERT INTO siakad.master_wilayah VALUES ('080617', 3, 'ID', 'Kec. Iv Nagari Bayang Utara', '080600');
INSERT INTO siakad.master_wilayah VALUES ('091014', 3, 'ID', 'Kec. Pekaitan', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091015', 3, 'ID', 'Kec. Kubu Babussalam', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091016', 3, 'ID', 'Kec. Bagan Sinembah Jaya', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091017', 3, 'ID', 'Kec. Balai Jaya', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091018', 3, 'ID', 'Kec. Tanjung Medan', '091000');
INSERT INTO siakad.master_wilayah VALUES ('091413', 3, 'ID', 'Kec. Kuantan Hilir Seberang', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091414', 3, 'ID', 'Kec. Sentajo Raya', '091400');
INSERT INTO siakad.master_wilayah VALUES ('091415', 3, 'ID', 'Kec. Pucuk Rantau', '091400');
INSERT INTO siakad.master_wilayah VALUES ('100518', 3, 'ID', 'Kec. Bukit Kerman', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100519', 3, 'ID', 'Kec. Air Hangat Barat', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100520', 3, 'ID', 'Kec. Siulak Mukai', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100521', 3, 'ID', 'Kec. Kayu Aro Barat', '100500');
INSERT INTO siakad.master_wilayah VALUES ('100709', 3, 'ID', 'Kec. Bahar Utara', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100710', 3, 'ID', 'Kec. Bahar Selatan', '100700');
INSERT INTO siakad.master_wilayah VALUES ('100711', 3, 'ID', 'Kec. Taman Rajo', '100700');
INSERT INTO siakad.master_wilayah VALUES ('106009', 3, 'ID', 'Kec. Alam Barajo', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106010', 3, 'ID', 'Kec. Danau Sipin', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106011', 3, 'ID', 'Kec. Paal Merah', '106000');
INSERT INTO siakad.master_wilayah VALUES ('106106', 3, 'ID', 'Kec. Pondok Tinggi', '106100');
INSERT INTO siakad.master_wilayah VALUES ('106107', 3, 'ID', 'Kec. Koto Baru', '106100');
INSERT INTO siakad.master_wilayah VALUES ('106108', 3, 'ID', 'Kec. Sungai Bungkal', '106100');
INSERT INTO siakad.master_wilayah VALUES ('110432', 3, 'ID', 'Kec. Lubai Ulu', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110433', 3, 'ID', 'Kec. Belimbing', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110434', 3, 'ID', 'Kec. Belimbing', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110435', 3, 'ID', 'Kec. Belida Darat', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110436', 3, 'ID', 'Kec. Belida Barat', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110437', 3, 'ID', 'Kec. Lubai Ulu', '110400');
INSERT INTO siakad.master_wilayah VALUES ('110534', 3, 'ID', 'Kec. Sukamerindu', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110535', 3, 'ID', 'Kec. Sukamerindu', '110500');
INSERT INTO siakad.master_wilayah VALUES ('110719', 3, 'ID', 'Kec. Sumber Marga Telang', '110700');
INSERT INTO siakad.master_wilayah VALUES ('110720', 3, 'ID', 'Kec. Air Kumbang', '110700');
INSERT INTO siakad.master_wilayah VALUES ('111109', 3, 'ID', 'Kec. Saling', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111110', 3, 'ID', 'Kec. Pendopo Barat', '111100');
INSERT INTO siakad.master_wilayah VALUES ('111200', 2, 'ID', 'Kab. Penukal Abab Lematang Ilir', '110000');
INSERT INTO siakad.master_wilayah VALUES ('111221', 3, 'ID', 'Kec. Penukal Utara', '111200');
INSERT INTO siakad.master_wilayah VALUES ('111223', 3, 'ID', 'Kec. Abab', '111200');
INSERT INTO siakad.master_wilayah VALUES ('111224', 3, 'ID', 'Kec. Tanah Abang', '111200');
INSERT INTO siakad.master_wilayah VALUES ('111225', 3, 'ID', 'Kec. Talang Ubi', '111200');
INSERT INTO siakad.master_wilayah VALUES ('111226', 3, 'ID', 'Kec. Penukal', '111200');
INSERT INTO siakad.master_wilayah VALUES ('111300', 2, 'ID', 'Kab. Musi Rawas Utara', '110000');
INSERT INTO siakad.master_wilayah VALUES ('111301', 3, 'ID', 'Kec. Rupit', '111300');
INSERT INTO siakad.master_wilayah VALUES ('111302', 3, 'ID', 'Kec. Rawas Ulu', '111300');
INSERT INTO siakad.master_wilayah VALUES ('111303', 3, 'ID', 'Kec. Nibung', '111300');
INSERT INTO siakad.master_wilayah VALUES ('111304', 3, 'ID', 'Kec. Rawas Iilir', '111300');
INSERT INTO siakad.master_wilayah VALUES ('111305', 3, 'ID', 'Kec. Karang Dapo', '111300');
INSERT INTO siakad.master_wilayah VALUES ('111306', 3, 'ID', 'Kec. Karang Jaya', '111300');
INSERT INTO siakad.master_wilayah VALUES ('111307', 3, 'ID', 'Kec. Ulu Rawas', '111300');
INSERT INTO siakad.master_wilayah VALUES ('120492', 3, 'ID', 'Kec. Kebun Tebu', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120493', 3, 'ID', 'Kec. Air Hitam', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120494', 3, 'ID', 'Kec. Batu Ketulis', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120495', 3, 'ID', 'Kec. Bandar Negeri Suoh', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120496', 3, 'ID', 'Kec. Way Krui', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120497', 3, 'ID', 'Kec. Krui Selatan', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120498', 3, 'ID', 'Kec. Pulau Pisang', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120499', 3, 'ID', 'Kec. Pagar Dewa', '120400');
INSERT INTO siakad.master_wilayah VALUES ('120908', 3, 'ID', 'Kec. Marga Punduh', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120909', 3, 'ID', 'Kec. Way Khilau', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120910', 3, 'ID', 'Kec. Teluk Pandan', '120900');
INSERT INTO siakad.master_wilayah VALUES ('120911', 3, 'ID', 'Kec. Way Ratai', '120900');
INSERT INTO siakad.master_wilayah VALUES ('121009', 3, 'ID', 'Kec. Pagelaran Utara', '121000');
INSERT INTO siakad.master_wilayah VALUES ('121300', 2, 'ID', 'Kab. Pesisir Barat', '120000');
INSERT INTO siakad.master_wilayah VALUES ('121301', 3, 'ID', 'Kec. Bangkunat', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121331', 3, 'ID', 'Kec. Pesisir Selatan', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121332', 3, 'ID', 'Kec. Ngambur', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121333', 3, 'ID', 'Kec. Lemong', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121334', 3, 'ID', 'Kec. Ngaras', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121335', 3, 'ID', 'Kec. Karyapenggawa', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121336', 3, 'ID', 'Kec. Pesisir Tengah', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121337', 3, 'ID', 'Kec. Pesisir Utara', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121338', 3, 'ID', 'Kec. Krui Selatan', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121339', 3, 'ID', 'Kec. Pulau Pisang', '121300');
INSERT INTO siakad.master_wilayah VALUES ('121340', 3, 'ID', 'Kec. Way Krui', '121300');
INSERT INTO siakad.master_wilayah VALUES ('126014', 3, 'ID', 'Kec. Labuhan Ratu', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126015', 3, 'ID', 'Kec. Way Halim', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126016', 3, 'ID', 'Kec. Kedamaian', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126017', 3, 'ID', 'Kec. Enggal', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126018', 3, 'ID', 'Kec. Langkapura', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126019', 3, 'ID', 'Kec. Bumi Waras', '126000');
INSERT INTO siakad.master_wilayah VALUES ('126020', 3, 'ID', 'Kec. Teluk Betung Timur', '126000');
INSERT INTO siakad.master_wilayah VALUES ('131206', 3, 'ID', 'Kec. Kepulauan Karimata', '131200');
INSERT INTO siakad.master_wilayah VALUES ('140119', 3, 'ID', 'Kec. Bataguh', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140120', 3, 'ID', 'Kec. Dadahup', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140121', 3, 'ID', 'Kec. Tamban Catur', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140122', 3, 'ID', 'Kec. Pasak Talawang', '140100');
INSERT INTO siakad.master_wilayah VALUES ('140123', 3, 'ID', 'Kec. Mandau Talawang', '140100');
INSERT INTO siakad.master_wilayah VALUES ('141012', 3, 'ID', 'Kec. Rungan Barat', '141000');
INSERT INTO siakad.master_wilayah VALUES ('150923', 3, 'ID', 'Kec. Pulau Laut Tanjung Selayar', '150900');
INSERT INTO siakad.master_wilayah VALUES ('161200', 2, 'ID', 'Kab. Mahakam Ulu', '160000');
INSERT INTO siakad.master_wilayah VALUES ('161221', 3, 'ID', 'Kec. Long Hubung', '161200');
INSERT INTO siakad.master_wilayah VALUES ('161222', 3, 'ID', 'Kec. Laham', '161200');
INSERT INTO siakad.master_wilayah VALUES ('161223', 3, 'ID', 'Kec. Long Apari', '161200');
INSERT INTO siakad.master_wilayah VALUES ('161224', 3, 'ID', 'Kec. Long Pahangai', '161200');
INSERT INTO siakad.master_wilayah VALUES ('161225', 3, 'ID', 'Kec. Long Bagun', '161200');
INSERT INTO siakad.master_wilayah VALUES ('166106', 3, 'ID', 'Kec. Balikpapan Kota', '166100');
INSERT INTO siakad.master_wilayah VALUES ('170134', 3, 'ID', 'Kec. Dumoga', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170135', 3, 'ID', 'Kec. Dumoga Tenggara', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170136', 3, 'ID', 'Kec. Dumoga Tengah', '170100');
INSERT INTO siakad.master_wilayah VALUES ('170240', 3, 'ID', 'Kec. Kakas Barat', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170241', 3, 'ID', 'Kec. Kawangkoan Utara', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170242', 3, 'ID', 'Kec. Tombariri Timur', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170243', 3, 'ID', 'Kec. Kawangkoan Barat', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170244', 3, 'ID', 'Kec. Mandolang', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170245', 3, 'ID', 'Kec. Tompaso Barat', '170200');
INSERT INTO siakad.master_wilayah VALUES ('170531', 3, 'ID', 'Kec. Suluun Tareran', '170500');
INSERT INTO siakad.master_wilayah VALUES ('171206', 3, 'ID', 'Kec. Helumo', '171200');
INSERT INTO siakad.master_wilayah VALUES ('176010', 3, 'ID', 'Kec. Paal Dua', '176000');
INSERT INTO siakad.master_wilayah VALUES ('176011', 3, 'ID', 'Kec. Bunaken Kepulauan', '176000');
INSERT INTO siakad.master_wilayah VALUES ('180414', 3, 'ID', 'Kec. Moilong', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180415', 3, 'ID', 'Kec. Batui Selatan', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180416', 3, 'ID', 'Kec. Luwuk Utara', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180417', 3, 'ID', 'Kec. Luwuk Selatan', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180418', 3, 'ID', 'Kec. Nambo', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180419', 3, 'ID', 'Kec. Mantoh', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180420', 3, 'ID', 'Kec. Balantak Utara', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180421', 3, 'ID', 'Kec. Balantak Selatan', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180422', 3, 'ID', 'Kec. Lobu', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180423', 3, 'ID', 'Kec. Simpang Raya', '180400');
INSERT INTO siakad.master_wilayah VALUES ('180714', 3, 'ID', 'Kec. Petasia Barat', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180715', 3, 'ID', 'Kec. Bungku Timur', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180716', 3, 'ID', 'Kec. Bungku Pesisir', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180717', 3, 'ID', 'Kec. Lembo Raya', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180718', 3, 'ID', 'Kec. Mori Utara', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180719', 3, 'ID', 'Kec. Petasia Timur', '180700');
INSERT INTO siakad.master_wilayah VALUES ('180893', 3, 'ID', 'Kec. Sidoan', '180800');
INSERT INTO siakad.master_wilayah VALUES ('180910', 3, 'ID', 'Kec. Ratolindo', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180911', 3, 'ID', 'Kec. Batudaka', '180900');
INSERT INTO siakad.master_wilayah VALUES ('180912', 3, 'ID', 'Kec. Talatako', '180900');
INSERT INTO siakad.master_wilayah VALUES ('181100', 2, 'ID', 'Kab. Banggai Laut', '180000');
INSERT INTO siakad.master_wilayah VALUES ('181112', 3, 'ID', 'Kec. Bokan Kepulauan', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181113', 3, 'ID', 'Kec. Bangkurung', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181114', 3, 'ID', 'Kec. Labobo', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181115', 3, 'ID', 'Kec. Banggai Selatan', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181116', 3, 'ID', 'Kec. Banggai Tengah', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181117', 3, 'ID', 'Kec. Banggai', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181118', 3, 'ID', 'Kec. Banggai Utara', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181119', 3, 'ID', 'Kec. Banggai', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181120', 3, 'ID', 'Kec. Banggai Utara', '181100');
INSERT INTO siakad.master_wilayah VALUES ('181200', 2, 'ID', 'Kab. Morowali Utara', '180000');
INSERT INTO siakad.master_wilayah VALUES ('181201', 3, 'ID', 'Kec. Bungku Utara', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181202', 3, 'ID', 'Kec. Lembo', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181203', 3, 'ID', 'Kec. Lembo Raya', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181204', 3, 'ID', 'Kec. Mamosalato', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181205', 3, 'ID', 'Kec. Mori Atas', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181206', 3, 'ID', 'Kec. Mori Utara', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181207', 3, 'ID', 'Kec. Petasia', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181208', 3, 'ID', 'Kec. Petasia Timur', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181209', 3, 'ID', 'Kec. Soyo Jaya', '181200');
INSERT INTO siakad.master_wilayah VALUES ('181210', 3, 'ID', 'Kec. Petasia Barat', '181200');
INSERT INTO siakad.master_wilayah VALUES ('186005', 3, 'ID', 'Kec. Ulujadi', '186000');
INSERT INTO siakad.master_wilayah VALUES ('186006', 3, 'ID', 'Kec. Tatanga', '186000');
INSERT INTO siakad.master_wilayah VALUES ('186007', 3, 'ID', 'Kec. Tawaeli', '186000');
INSERT INTO siakad.master_wilayah VALUES ('186008', 3, 'ID', 'Kec. Mantikulore', '186000');
INSERT INTO siakad.master_wilayah VALUES ('191391', 3, 'ID', 'Kec. Pasimasunggu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191392', 3, 'ID', 'Kec. Pasimasunggu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191393', 3, 'ID', 'Kec. Pasimasunggu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191394', 3, 'ID', 'Kec. Pasimasunggu', '191300');
INSERT INTO siakad.master_wilayah VALUES ('191722', 3, 'ID', 'Kec. Bassesangtempe Utara', '191700');
INSERT INTO siakad.master_wilayah VALUES ('200149', 3, 'ID', 'Kec. Anggalomoare', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200150', 3, 'ID', 'Kec. Morosi', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200151', 3, 'ID', 'Kec. Wonggeduku Barat', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200152', 3, 'ID', 'Kec. Padangguni', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200153', 3, 'ID', 'Kec. Tongauna Utara', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200154', 3, 'ID', 'Kec. Anggotoa', '200100');
INSERT INTO siakad.master_wilayah VALUES ('200244', 3, 'ID', 'Kec. Kusambi', '200200');
INSERT INTO siakad.master_wilayah VALUES ('200430', 3, 'ID', 'Kec. Iwoimendaa', '200400');
INSERT INTO siakad.master_wilayah VALUES ('200911', 3, 'ID', 'Kec. Landawe', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200912', 3, 'ID', 'Kec. Lasolo Kepulauan', '200900');
INSERT INTO siakad.master_wilayah VALUES ('200913', 3, 'ID', 'Kec. Wawolesea', '200900');
INSERT INTO siakad.master_wilayah VALUES ('201100', 2, 'ID', 'Kab. Kolaka Timur', '200000');
INSERT INTO siakad.master_wilayah VALUES ('201112', 3, 'ID', 'Kec. Ladongi', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201113', 3, 'ID', 'Kec. Poli-Polia', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201114', 3, 'ID', 'Kec. Lambandia', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201116', 3, 'ID', 'Kec. Mowewe', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201117', 3, 'ID', 'Kec. Uluiwoi', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201118', 3, 'ID', 'Kec. Tinondo', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201119', 3, 'ID', 'Kec. Tirawuta', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201120', 3, 'ID', 'Kec. Ueesi', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201121', 3, 'ID', 'Kec. Aere', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201122', 3, 'ID', 'Kec. Dangia', '201100');
INSERT INTO siakad.master_wilayah VALUES ('201200', 2, 'ID', 'Kab. Konawe Kepulauan', '200000');
INSERT INTO siakad.master_wilayah VALUES ('201201', 3, 'ID', 'Kec. Wawonii Barat', '201200');
INSERT INTO siakad.master_wilayah VALUES ('201202', 3, 'ID', 'Kec. Wawonii Utara', '201200');
INSERT INTO siakad.master_wilayah VALUES ('201203', 3, 'ID', 'Kec. Wawonii Timur Laut', '201200');
INSERT INTO siakad.master_wilayah VALUES ('201204', 3, 'ID', 'Kec. Wawonii Timur', '201200');
INSERT INTO siakad.master_wilayah VALUES ('201205', 3, 'ID', 'Kec. Wawonii Tenggara', '201200');
INSERT INTO siakad.master_wilayah VALUES ('201206', 3, 'ID', 'Kec. Wawonii Selatan', '201200');
INSERT INTO siakad.master_wilayah VALUES ('201207', 3, 'ID', 'Kec. Wawonii Tengah', '201200');
INSERT INTO siakad.master_wilayah VALUES ('201300', 2, 'ID', 'Kab. Muna Barat', '200000');
INSERT INTO siakad.master_wilayah VALUES ('201301', 3, 'ID', 'Kec. Sawerigadi', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201302', 3, 'ID', 'Kec. Barangka', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201303', 3, 'ID', 'Kec. Lawa', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201304', 3, 'ID', 'Kec. Wadaga', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201305', 3, 'ID', 'Kec. Tiworo Selatan', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201306', 3, 'ID', 'Kec. Maginti', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201307', 3, 'ID', 'Kec. Tiworo Tengah', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201308', 3, 'ID', 'Kec. Tiworo Tengah', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201309', 3, 'ID', 'Kec. Tiworo Utara', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201310', 3, 'ID', 'Kec. Tiworo Kepulauan', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201311', 3, 'ID', 'Kec. Napano Kusambi', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201312', 3, 'ID', 'Kec. Kusambi', '201300');
INSERT INTO siakad.master_wilayah VALUES ('201400', 2, 'ID', 'Kab. Buton Selatan', '200000');
INSERT INTO siakad.master_wilayah VALUES ('201401', 3, 'ID', 'Kec. Batauga', '201400');
INSERT INTO siakad.master_wilayah VALUES ('201402', 3, 'ID', 'Kec. Sampolawa', '201400');
INSERT INTO siakad.master_wilayah VALUES ('201403', 3, 'ID', 'Kec. Lapandewa', '201400');
INSERT INTO siakad.master_wilayah VALUES ('201404', 3, 'ID', 'Kec. Batu Atas', '201400');
INSERT INTO siakad.master_wilayah VALUES ('201405', 3, 'ID', 'Kec. Siompu Barat', '201400');
INSERT INTO siakad.master_wilayah VALUES ('201406', 3, 'ID', 'Kec. Siompu', '201400');
INSERT INTO siakad.master_wilayah VALUES ('201407', 3, 'ID', 'Kec. Kadatua', '201400');
INSERT INTO siakad.master_wilayah VALUES ('201600', 2, 'ID', 'Kab. Buton Tengah', '200000');
INSERT INTO siakad.master_wilayah VALUES ('201601', 3, 'ID', 'Kec. Lakudo', '201600');
INSERT INTO siakad.master_wilayah VALUES ('201602', 3, 'ID', 'Kec. Mawasangka Timur', '201600');
INSERT INTO siakad.master_wilayah VALUES ('201603', 3, 'ID', 'Kec. Mawasangka Tengah', '201600');
INSERT INTO siakad.master_wilayah VALUES ('201604', 3, 'ID', 'Kec. Mawasangka', '201600');
INSERT INTO siakad.master_wilayah VALUES ('201605', 3, 'ID', 'Kec.Talaga Raya', '201600');
INSERT INTO siakad.master_wilayah VALUES ('201606', 3, 'ID', 'Kec. Gu', '201600');
INSERT INTO siakad.master_wilayah VALUES ('201607', 3, 'ID', 'Kec. Sangia Wambulu', '201600');
INSERT INTO siakad.master_wilayah VALUES ('206108', 3, 'ID', 'Kec. Batupoaro', '206100');
INSERT INTO siakad.master_wilayah VALUES ('210124', 3, 'ID', 'Kec. Saparua Timur', '210100');
INSERT INTO siakad.master_wilayah VALUES ('210214', 3, 'ID', 'Kec. Manyeuw', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210215', 3, 'ID', 'Kec. Hoat Sorbay', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210216', 3, 'ID', 'Kec. Kei Besar Utara Barat', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210217', 3, 'ID', 'Kec. Kei Besar Selatan Barat', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210218', 3, 'ID', 'Kec. Kei Kecil Timur Selatan', '210200');
INSERT INTO siakad.master_wilayah VALUES ('210318', 3, 'ID', 'Kec. Lolong Guba', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210319', 3, 'ID', 'Kec. Waelata', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210320', 3, 'ID', 'Kec. Fena Leisela', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210321', 3, 'ID', 'Kec. Teluk Kaiely', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210322', 3, 'ID', 'Kec. Lilialy', '210300');
INSERT INTO siakad.master_wilayah VALUES ('210506', 3, 'ID', 'Kec. Amalatu', '210500');
INSERT INTO siakad.master_wilayah VALUES ('210607', 3, 'ID', 'Kec. Siwalalat', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210608', 3, 'ID', 'Kec. Kilmury', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210609', 3, 'ID', 'Kec. Pulau Panjang', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210610', 3, 'ID', 'Kec. Teor', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210611', 3, 'ID', 'Kec. Gorom Timur', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210612', 3, 'ID', 'Kec. Bula Barat', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210613', 3, 'ID', 'Kec. Kian Darat', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210614', 3, 'ID', 'Kec. Siritaun Wida Timur', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210615', 3, 'ID', 'Kec. Teluk Waru', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210616', 3, 'ID', 'Kec. Lian Vitu', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210617', 3, 'ID', 'Kec. Ukar Sengan', '210600');
INSERT INTO siakad.master_wilayah VALUES ('210812', 3, 'ID', 'Kec. Pulau Masela', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210813', 3, 'ID', 'Kec. Dawelor Dawera', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210814', 3, 'ID', 'Kec. Pulau Wetang', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210815', 3, 'ID', 'Kec. Pulau Lakor', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210816', 3, 'ID', 'Kec. Wetar Utara', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210817', 3, 'ID', 'Kec. Wetar Barat', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210818', 3, 'ID', 'Kec. Wetar Timur', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210819', 3, 'ID', 'Kec. Kepulauan Romang', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210820', 3, 'ID', 'Kec. Kisar Utara', '210800');
INSERT INTO siakad.master_wilayah VALUES ('210906', 3, 'ID', 'Kec. Fena Fafan', '210900');
INSERT INTO siakad.master_wilayah VALUES ('216105', 3, 'ID', 'Kec. Kur Selatan', '216100');
INSERT INTO siakad.master_wilayah VALUES ('241004', 3, 'ID', 'Kec. Golewa Barat', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241018', 3, 'ID', 'Kec. Inerie', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241019', 3, 'ID', 'Kec. Golewa Selatan', '241000');
INSERT INTO siakad.master_wilayah VALUES ('241121', 3, 'ID', 'Kec. Reok Barat', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241122', 3, 'ID', 'Kec. Cibal Barat', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241123', 3, 'ID', 'Kec. Landu Leko', '241100');
INSERT INTO siakad.master_wilayah VALUES ('241512', 3, 'ID', 'Kec. Ndao Nuse', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241513', 3, 'ID', 'Kec. Landu Leko', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241514', 3, 'ID', 'Kec. Ndau Nuse', '241500');
INSERT INTO siakad.master_wilayah VALUES ('241909', 3, 'ID', 'Kec. Kota Tambolaka', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241910', 3, 'ID', 'Kec. Wewewa Tengah', '241900');
INSERT INTO siakad.master_wilayah VALUES ('241911', 3, 'ID', 'Kec. Kodi Balaghar', '241900');
INSERT INTO siakad.master_wilayah VALUES ('242007', 3, 'ID', 'Kec. Rana Mese', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242008', 3, 'ID', 'Kec. Poco Ranaka Timur', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242009', 3, 'ID', 'Kec. Elar Selatan', '242000');
INSERT INTO siakad.master_wilayah VALUES ('242200', 2, 'ID', 'Kab. Malaka', '240000');
INSERT INTO siakad.master_wilayah VALUES ('242221', 3, 'ID', 'Kec. Malaka Barat', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242222', 3, 'ID', 'Kec. Wewiku', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242223', 3, 'ID', 'Kec. Weliman', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242224', 3, 'ID', 'Kec. Rinhat', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242225', 3, 'ID', 'Kec. Io Kufeu', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242226', 3, 'ID', 'Kec. Sasitamean', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242227', 3, 'ID', 'Kec. Laenmanen', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242228', 3, 'ID', 'Kec. Malaka Timur', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242229', 3, 'ID', 'Kec. Kobalima Timur', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242230', 3, 'ID', 'Kec. Kobalima', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242231', 3, 'ID', 'Kec. Botin Leobele', '242200');
INSERT INTO siakad.master_wilayah VALUES ('242232', 3, 'ID', 'Kec. Malaka Tengah', '242200');
INSERT INTO siakad.master_wilayah VALUES ('250130', 3, 'ID', 'Kec. Yokari', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250131', 3, 'ID', 'Kec. Ravenirara', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250132', 3, 'ID', 'Kec. Gresi Selatan', '250100');
INSERT INTO siakad.master_wilayah VALUES ('250316', 3, 'ID', 'Kec. Pulau Kurudu', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250317', 3, 'ID', 'Kec. Pulau Yerui', '250300');
INSERT INTO siakad.master_wilayah VALUES ('250864', 3, 'ID', 'Kec. Wesaput', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250865', 3, 'ID', 'Kec. Trikora', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250866', 3, 'ID', 'Kec. Walaik', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250867', 3, 'ID', 'Kec. Wouma', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250868', 3, 'ID', 'Kec. Ibele', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250869', 3, 'ID', 'Kec. Taelarek', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250870', 3, 'ID', 'Kec. Wame', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250871', 3, 'ID', 'Kec. Napua', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250872', 3, 'ID', 'Kec. Hubikiak', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250873', 3, 'ID', 'Kec. Itlay Hisage', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250874', 3, 'ID', 'Kec. Pisugi', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250875', 3, 'ID', 'Kec. Molagalome', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250876', 3, 'ID', 'Kec. Tagineri', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250877', 3, 'ID', 'Kec. Silo Karno Doga', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250878', 3, 'ID', 'Kec. Siepkosi', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250879', 3, 'ID', 'Kec. Usilimo', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250880', 3, 'ID', 'Kec. Libarek', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250881', 3, 'ID', 'Kec. Wadangku', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250882', 3, 'ID', 'Kec. Koragi', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250883', 3, 'ID', 'Kec. Tagime', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250884', 3, 'ID', 'Kec. Piramid', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250885', 3, 'ID', 'Kec. Muliama', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250886', 3, 'ID', 'Kec. Bugi', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250887', 3, 'ID', 'Kec. Bipiri', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250888', 3, 'ID', 'Kec. Welesi', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250889', 3, 'ID', 'Kec. Asotipo', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250890', 3, 'ID', 'Kec. Maima', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250891', 3, 'ID', 'Kec. Wita Waya', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250892', 3, 'ID', 'Kec. Popugoba', '250800');
INSERT INTO siakad.master_wilayah VALUES ('250918', 3, 'ID', 'Kec. Kepulauan Moora', '250900');
INSERT INTO siakad.master_wilayah VALUES ('250924', 3, 'ID', 'Kec. Menou', '250900');
INSERT INTO siakad.master_wilayah VALUES ('251020', 3, 'ID', 'Kec. Weege Bino', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251091', 3, 'ID', 'Kec. Aweida', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251092', 3, 'ID', 'Kec. Baya Biru', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251093', 3, 'ID', 'Kec. Deiyai Miyo', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251094', 3, 'ID', 'Kec. Dogomo', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251095', 3, 'ID', 'Kec. Muye', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251096', 3, 'ID', 'Kec. Nakama', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251097', 3, 'ID', 'Kec. Pugo Dagi', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251098', 3, 'ID', 'Kec. Teluk Deya', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251099', 3, 'ID', 'Kec. Topiyai', '251000');
INSERT INTO siakad.master_wilayah VALUES ('251116', 3, 'ID', 'Kec. Nume', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251117', 3, 'ID', 'Kec. Pagaleme', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251118', 3, 'ID', 'Kec. Gurage', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251119', 3, 'ID', 'Kec. Irimuli', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251120', 3, 'ID', 'Kec. Muara', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251121', 3, 'ID', 'Kec. Ilamburawi', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251122', 3, 'ID', 'Kec. Yambi', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251123', 3, 'ID', 'Kec. Lumo', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251124', 3, 'ID', 'Kec. Molanikime', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251125', 3, 'ID', 'Kec. Dokome', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251126', 3, 'ID', 'Kec. Kalome', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251127', 3, 'ID', 'Kec. Wanwi', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251128', 3, 'ID', 'Kec. Yamoneri', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251129', 3, 'ID', 'Kec. Waegi', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251130', 3, 'ID', 'Kec. Nioga', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251131', 3, 'ID', 'Kec. Gubume', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251132', 3, 'ID', 'Kec. Taganombak', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251133', 3, 'ID', 'Kec. Dagai', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251134', 3, 'ID', 'Kec. Kiyage', '251100');
INSERT INTO siakad.master_wilayah VALUES ('251215', 3, 'ID', 'Kec. Mimika Tengah', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251216', 3, 'ID', 'Kec. Kwamki Narama', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251217', 3, 'ID', 'Kec. Hoya', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251218', 3, 'ID', 'Kec. Iwaka', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251219', 3, 'ID', 'Kec. Wania', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251220', 3, 'ID', 'Kec. Amar', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251221', 3, 'ID', 'Kec. Alama', '251200');
INSERT INTO siakad.master_wilayah VALUES ('251316', 3, 'ID', 'Kec. Ninati', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251317', 3, 'ID', 'Kec. Sesnuk', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251318', 3, 'ID', 'Kec. Ki', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251319', 3, 'ID', 'Kec. Kombay', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251320', 3, 'ID', 'Kec. Kawagit', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251321', 3, 'ID', 'Kec. Syahcame', '251300');
INSERT INTO siakad.master_wilayah VALUES ('251411', 3, 'ID', 'Kec. Syahcame', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251412', 3, 'ID', 'Kec. Yakomi', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251413', 3, 'ID', 'Kec. Bamgi', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251414', 3, 'ID', 'Kec. Passue Bawah', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251415', 3, 'ID', 'Kec. Ti Zain', '251400');
INSERT INTO siakad.master_wilayah VALUES ('251508', 3, 'ID', 'Kec. Kopay', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251509', 3, 'ID', 'Kec. Safan', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251510', 3, 'ID', 'Kec. Sirets', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251511', 3, 'ID', 'Kec. Joerat', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251512', 3, 'ID', 'Kec. Pulau Tiga', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251513', 3, 'ID', 'Kec. Der Koumur', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251514', 3, 'ID', 'Kec. Ayip', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251515', 3, 'ID', 'Kec. Betcbamu', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251516', 3, 'ID', 'Kec. Suru-Suru', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251517', 3, 'ID', 'Kec. Kolf Braza', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251518', 3, 'ID', 'Kec. Jetsy', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251519', 3, 'ID', 'Kec. Unir Sirau', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251520', 3, 'ID', 'Kec. Sirau', '251500');
INSERT INTO siakad.master_wilayah VALUES ('251652', 3, 'ID', 'Kec. Tolikapura 2', '251600');
INSERT INTO siakad.master_wilayah VALUES ('251891', 3, 'ID', 'Kec. Kai', '251800');
INSERT INTO siakad.master_wilayah VALUES ('251915', 3, 'ID', 'Kec. Ismari', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251916', 3, 'ID', 'Kec. Muara Tor', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251917', 3, 'ID', 'Kec. Sobey', '251900');
INSERT INTO siakad.master_wilayah VALUES ('251918', 3, 'ID', 'Kec. Walani', '251900');
INSERT INTO siakad.master_wilayah VALUES ('252008', 3, 'ID', 'Kec. Arso Barat', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252009', 3, 'ID', 'Kec. Kaisenar', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252010', 3, 'ID', 'Kec. Mannem', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252011', 3, 'ID', 'Kec. Yaffi', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252012', 3, 'ID', 'Kec. Yaffi', '252000');
INSERT INTO siakad.master_wilayah VALUES ('252611', 3, 'ID', 'Kec. Demba', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252612', 3, 'ID', 'Kec. Oudate', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252613', 3, 'ID', 'Kec. Wonti', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252614', 3, 'ID', 'Kec. Soyoi Mambai', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252615', 3, 'ID', 'Kec. Walani', '252600');
INSERT INTO siakad.master_wilayah VALUES ('252909', 3, 'ID', 'Kec. Kegayem', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252910', 3, 'ID', 'Kec. Paro', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252911', 3, 'ID', 'Kec. Mebarok', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252912', 3, 'ID', 'Kec. Kilmid', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252913', 3, 'ID', 'Kec. Koroptak', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252914', 3, 'ID', 'Kec. Yenggelo', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252915', 3, 'ID', 'Kec. Alama', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252916', 3, 'ID', 'Kec. Yal', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252917', 3, 'ID', 'Kec. Mam', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252918', 3, 'ID', 'Kec. Dal', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252919', 3, 'ID', 'Kec. Nirkuri', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252920', 3, 'ID', 'Kec. Iniye', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252921', 3, 'ID', 'Kec. Mbua Tengah', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252922', 3, 'ID', 'Kec. Inikgal', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252923', 3, 'ID', 'Kec. Mbulmu Yalma', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252924', 3, 'ID', 'Kec. Embetpen', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252925', 3, 'ID', 'Kec. Kora', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252926', 3, 'ID', 'Kec. Wusi', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252927', 3, 'ID', 'Kec. Nenggeagin', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252928', 3, 'ID', 'Kec. Pasir Putih', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252929', 3, 'ID', 'Kec. Pija', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252930', 3, 'ID', 'Kec. Moba', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252931', 3, 'ID', 'Kec. Wutpaga', '252900');
INSERT INTO siakad.master_wilayah VALUES ('252932', 3, 'ID', 'Kec. Krepkuri', '252900');
INSERT INTO siakad.master_wilayah VALUES ('253011', 3, 'ID', 'Kec. Awina', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253012', 3, 'ID', 'Kec. Ayumnati', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253013', 3, 'ID', 'Kec. Balingga Barat', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253014', 3, 'ID', 'Kec. Bruwa', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253015', 3, 'ID', 'Kec. Buguk Gona', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253016', 3, 'ID', 'Kec. Gelok Beam', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253017', 3, 'ID', 'Kec. Goa Balim', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253018', 3, 'ID', 'Kec. Gollo', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253019', 3, 'ID', 'Kec. Guna', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253020', 3, 'ID', 'Kec. Gupura', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253021', 3, 'ID', 'Kec. Karu', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253022', 3, 'ID', 'Kec. Kelulome', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253023', 3, 'ID', 'Kec. Kolawa', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253024', 3, 'ID', 'Kec. Kuly Lanny', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253025', 3, 'ID', 'Kec. Lannyna', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253026', 3, 'ID', 'Kec. Melagi', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253027', 3, 'ID', 'Kec. Milimbo', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253028', 3, 'ID', 'Kec. Mokoni', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253029', 3, 'ID', 'Kec. Muara', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253030', 3, 'ID', 'Kec. Nikogwe', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253031', 3, 'ID', 'Kec. Niname', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253032', 3, 'ID', 'Kec. Nogi', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253033', 3, 'ID', 'Kec. Tiom Ollo', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253034', 3, 'ID', 'Kec. Wano Barat', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253035', 3, 'ID', 'Kec. Wereka', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253036', 3, 'ID', 'Kec. Wiringgambut', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253037', 3, 'ID', 'Kec. Yiginua', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253038', 3, 'ID', 'Kec. Yiluk', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253039', 3, 'ID', 'Kec. Yugungwi', '253000');
INSERT INTO siakad.master_wilayah VALUES ('253309', 3, 'ID', 'Kec. Dervos', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253310', 3, 'ID', 'Kec. Beoga Barat', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253311', 3, 'ID', 'Kec. Beoga Timur', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253312', 3, 'ID', 'Kec. Ogamanim', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253313', 3, 'ID', 'Kec. Kembru', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253314', 3, 'ID', 'Kec. Bina', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253315', 3, 'ID', 'Kec. Sinak Barat', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253316', 3, 'ID', 'Kec. Mage`abume', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253317', 3, 'ID', 'Kec. Yugumuak', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253318', 3, 'ID', 'Kec. Ilaga Utara', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253319', 3, 'ID', 'Kec. Mabugi', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253320', 3, 'ID', 'Kec. Omukia', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253321', 3, 'ID', 'Kec. Lambewi', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253322', 3, 'ID', 'Kec. Oneri', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253323', 3, 'ID', 'Kec. Amungkalpia', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253324', 3, 'ID', 'Kec. Gome Utara', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253325', 3, 'ID', 'Kec. Erelmakawia', '253300');
INSERT INTO siakad.master_wilayah VALUES ('253697', 3, 'ID', 'Kec. Ugimba', '253600');
INSERT INTO siakad.master_wilayah VALUES ('253698', 3, 'ID', 'Kec. Tomosiga', '253600');
INSERT INTO siakad.master_wilayah VALUES ('260124', 3, 'ID', 'Kec. Arma Jaya', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260125', 3, 'ID', 'Kec. Tanjungagung Palik', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260126', 3, 'ID', 'Kec. Ulok Kupai', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260127', 3, 'ID', 'Kec. Marga Sakti Sebelat', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260128', 3, 'ID', 'Kec. Pinang Raya', '260100');
INSERT INTO siakad.master_wilayah VALUES ('260614', 3, 'ID', 'Kec. Padang Bano', '260600');
INSERT INTO siakad.master_wilayah VALUES ('270100', 2, 'ID', 'Kab. Pulau Taliabu', '270000');
INSERT INTO siakad.master_wilayah VALUES ('270101', 3, 'ID', 'Kec. Taliabu Barat', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270102', 3, 'ID', 'Kec. Taliabu Barat Laut', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270103', 3, 'ID', 'Kec. Lede', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270104', 3, 'ID', 'Kec. Taliabu Utara', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270105', 3, 'ID', 'Kec. Taliabu Timur', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270106', 3, 'ID', 'Kec. Taliabu Timur Selatan', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270107', 3, 'ID', 'Kec. Taliabu Selatan', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270108', 3, 'ID', 'Kec. Tabona', '270100');
INSERT INTO siakad.master_wilayah VALUES ('270212', 3, 'ID', 'Kec. Weda Timur', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270213', 3, 'ID', 'Kec. Patani Timur', '270200');
INSERT INTO siakad.master_wilayah VALUES ('270311', 3, 'ID', 'Kec. Tabaru', '270300');
INSERT INTO siakad.master_wilayah VALUES ('280435', 3, 'ID', 'Kec. Lebak Wangi', '280400');
INSERT INTO siakad.master_wilayah VALUES ('290509', 3, 'ID', 'Kec. Kep. Pongok', '290500');
INSERT INTO siakad.master_wilayah VALUES ('296091', 3, 'ID', 'Kec. Gabek', '296000');
INSERT INTO siakad.master_wilayah VALUES ('300227', 3, 'ID', 'Kec. Dungaliyo', '300200');
INSERT INTO siakad.master_wilayah VALUES ('300418', 3, 'ID', 'Kec. Pinogu', '300400');
INSERT INTO siakad.master_wilayah VALUES ('300512', 3, 'ID', 'Kec. Sumalata Timur', '300500');
INSERT INTO siakad.master_wilayah VALUES ('300513', 3, 'ID', 'Kec. Sumalata Timur', '300500');
INSERT INTO siakad.master_wilayah VALUES ('310210', 3, 'ID', 'Kec. Meral Barat', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310211', 3, 'ID', 'Kec. Ungar', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310212', 3, 'ID', 'Kec. Belat', '310200');
INSERT INTO siakad.master_wilayah VALUES ('310406', 3, 'ID', 'Kec. Singkep Pesisir', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310407', 3, 'ID', 'Kec. Singkep Selatan', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310408', 3, 'ID', 'Kec. Lingga Timur', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310409', 3, 'ID', 'Kec. Selayar', '310400');
INSERT INTO siakad.master_wilayah VALUES ('310410', 3, 'ID', 'Kec. Kepulauan Posek', '310400');
INSERT INTO siakad.master_wilayah VALUES ('320110', 3, 'ID', 'Kec. Pariwari', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320111', 3, 'ID', 'Kec. Wartutin', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320112', 3, 'ID', 'Kec. Fakfak Timur Tengah', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320113', 3, 'ID', 'Kec. Arguni', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320114', 3, 'ID', 'Kec. Mbahamdandara', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320115', 3, 'ID', 'Kec. Kayauni', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320116', 3, 'ID', 'Kec. Furwagi', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320117', 3, 'ID', 'Kec. Tomage', '320100');
INSERT INTO siakad.master_wilayah VALUES ('320591', 3, 'ID', 'Kec. Anggi', '320500');
INSERT INTO siakad.master_wilayah VALUES ('320622', 3, 'ID', 'Kec. Kais Darat', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320623', 3, 'ID', 'Kec. Salkma', '320600');
INSERT INTO siakad.master_wilayah VALUES ('320723', 3, 'ID', 'Kec. Mega', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320724', 3, 'ID', 'Kec. Moraid/Mega', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320725', 3, 'ID', 'Kec. Salawati Timur', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320726', 3, 'ID', 'Kec. Sorong', '320700');
INSERT INTO siakad.master_wilayah VALUES ('320907', 3, 'ID', 'Kec. Amberbaken', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320908', 3, 'ID', 'Kec. Kebar', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320909', 3, 'ID', 'Kec. Senopi', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320910', 3, 'ID', 'Kec. Mubrani', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320911', 3, 'ID', 'Kec. Syujak', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320912', 3, 'ID', 'Kec. Moraid', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320913', 3, 'ID', 'Kec. Bikar', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320914', 3, 'ID', 'Kec. Bamusbama', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320915', 3, 'ID', 'Kec. Ases', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320916', 3, 'ID', 'Kec. Miyah Selatan', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320917', 3, 'ID', 'Kec. Ireres', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320918', 3, 'ID', 'Kec. Tobouw', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320919', 3, 'ID', 'Kec. Wilhem Roumbouts', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320920', 3, 'ID', 'Kec. Kebar Timur', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320921', 3, 'ID', 'Kec. Tinggouw', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320922', 3, 'ID', 'Kec. Kwesefo', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320923', 3, 'ID', 'Kec. Mawabuan', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320924', 3, 'ID', 'Kec. Kebar Selatan', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320925', 3, 'ID', 'Kec. Manekar', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320926', 3, 'ID', 'Kec. Mpur', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320927', 3, 'ID', 'Kec. Amberbaken Barat', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320928', 3, 'ID', 'Kec. Kasi', '320900');
INSERT INTO siakad.master_wilayah VALUES ('320929', 3, 'ID', 'Kec. Selemkai', '320900');
INSERT INTO siakad.master_wilayah VALUES ('321014', 3, 'ID', 'Kec. Ayamaru Barat', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321016', 3, 'ID', 'Kec. Ayamaru Tengah', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321017', 3, 'ID', 'Kec. Ayamaru Selatan', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321018', 3, 'ID', 'Kec. Ayamaru Utara Timur', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321019', 3, 'ID', 'Kec. Ayamaru Selatan Jaya', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321020', 3, 'ID', 'Kec. Mare Selatan', '321000');
INSERT INTO siakad.master_wilayah VALUES ('321100', 2, 'ID', 'Kab. Pegunungan Arfak', '320000');
INSERT INTO siakad.master_wilayah VALUES ('321111', 3, 'ID', 'Kec. Anggi Gida', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321112', 3, 'ID', 'Kec. Membey', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321113', 3, 'ID', 'Kec. Sururay', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321114', 3, 'ID', 'Kec. Didohu', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321115', 3, 'ID', 'Kec. Taige', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321116', 3, 'ID', 'Kec. Catubouw', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321117', 3, 'ID', 'Kec. Testega', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321118', 3, 'ID', 'Kec. Menyambouw', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321119', 3, 'ID', 'Kec. Hingk', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321120', 3, 'ID', 'Kec. Anggi', '321100');
INSERT INTO siakad.master_wilayah VALUES ('321200', 2, 'ID', 'Kab. Manokwari Selatan', '320000');
INSERT INTO siakad.master_wilayah VALUES ('321206', 3, 'ID', 'Kec. Ransiki', '321200');
INSERT INTO siakad.master_wilayah VALUES ('321221', 3, 'ID', 'Kec. Oransbari', '321200');
INSERT INTO siakad.master_wilayah VALUES ('321222', 3, 'ID', 'Kec. Nenei', '321200');
INSERT INTO siakad.master_wilayah VALUES ('321223', 3, 'ID', 'Kec. Dataran Isim', '321200');
INSERT INTO siakad.master_wilayah VALUES ('321224', 3, 'ID', 'Kec. Momi Waren', '321200');
INSERT INTO siakad.master_wilayah VALUES ('321225', 3, 'ID', 'Kec. Tahota', '321200');
INSERT INTO siakad.master_wilayah VALUES ('326010', 3, 'ID', 'Kec. Klaurung', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326011', 3, 'ID', 'Kec. Malaimsimsa', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326012', 3, 'ID', 'Kec. Maladomes', '326000');
INSERT INTO siakad.master_wilayah VALUES ('326013', 3, 'ID', 'Kec. Sorong', '326000');
INSERT INTO siakad.master_wilayah VALUES ('330600', 2, 'ID', 'Kab. Mamuju Tengah', '330000');
INSERT INTO siakad.master_wilayah VALUES ('330601', 3, 'ID', 'Kec. Budong-Budong', '330600');
INSERT INTO siakad.master_wilayah VALUES ('330602', 3, 'ID', 'Kec. Karossa', '330600');
INSERT INTO siakad.master_wilayah VALUES ('330603', 3, 'ID', 'Kec. Topoyo', '330600');
INSERT INTO siakad.master_wilayah VALUES ('330604', 3, 'ID', 'Kec. Tobadak', '330600');
INSERT INTO siakad.master_wilayah VALUES ('330605', 3, 'ID', 'Kec. Pangale', '330600');
INSERT INTO siakad.master_wilayah VALUES ('340105', 3, 'ID', 'Kec. Mentarang', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340106', 3, 'ID', 'Kec. Sungai Boh', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340107', 3, 'ID', 'Kec. Malinau Selatan', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340108', 3, 'ID', 'Kec. Malinau Barat', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340109', 3, 'ID', 'Kec. Malinau Utara', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340110', 3, 'ID', 'Kec. Kayan Selatan', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340111', 3, 'ID', 'Kec. Bahau Hulu', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340112', 3, 'ID', 'Kec. Mentarang Hulu', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340113', 3, 'ID', 'Kec. Malinau Selatan Hilir', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340114', 3, 'ID', 'Kec. Malinau Selatan Hulu', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340115', 3, 'ID', 'Kec. Sungai Tubu', '340100');
INSERT INTO siakad.master_wilayah VALUES ('340202', 3, 'ID', 'Kec. Tanjung Palas', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340203', 3, 'ID', 'Kec. Sekatak', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340205', 3, 'ID', 'Kec. Pulau Bunyu', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340206', 3, 'ID', 'Kec. Tanjung Palas Barat', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340207', 3, 'ID', 'Kec. Tanjung Palas Utara', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340208', 3, 'ID', 'Kec. Tanjung Palas Timur', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340209', 3, 'ID', 'Kec. Tanjung Selor', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340210', 3, 'ID', 'Kec. Tanjung Palas Tengah', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340211', 3, 'ID', 'Kec. Peso Hilir', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340213', 3, 'ID', 'Kec. Peso', '340200');
INSERT INTO siakad.master_wilayah VALUES ('340301', 3, 'ID', 'Kec. Sesayap', '340300');
INSERT INTO siakad.master_wilayah VALUES ('340302', 3, 'ID', 'Kec. Sesayap Hilir', '340300');
INSERT INTO siakad.master_wilayah VALUES ('340303', 3, 'ID', 'Kec. Tanah Lia', '340300');
INSERT INTO siakad.master_wilayah VALUES ('340304', 3, 'ID', 'Kec. Betayau', '340300');
INSERT INTO siakad.master_wilayah VALUES ('340305', 3, 'ID', 'Kec. Muruk Rian', '340300');
INSERT INTO siakad.master_wilayah VALUES ('340501', 3, 'ID', 'Kec. Krayan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340502', 3, 'ID', 'Kec. Lumbis', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340503', 3, 'ID', 'Kec. Sembakung', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340504', 3, 'ID', 'Kec. Nunukan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340505', 3, 'ID', 'Kec. Sebatik', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340506', 3, 'ID', 'Kec. Sebuku', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340507', 3, 'ID', 'Kec. Krayan Selatan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340508', 3, 'ID', 'Kec. Sebatik Barat', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340509', 3, 'ID', 'Kec. Nunukan Selatan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340514', 3, 'ID', 'Kec. Nunukan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340515', 3, 'ID', 'Kec. Krayan Selatan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340516', 3, 'ID', 'Kec. Krayan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340517', 3, 'ID', 'Kec. Nunukan Selatan', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340518', 3, 'ID', 'Kec. Sebatik Timur', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340519', 3, 'ID', 'Kec. Sebatik Utara', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340520', 3, 'ID', 'Kec. Sebatik Tengah', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340521', 3, 'ID', 'Kec. Sei Menggaris', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340522', 3, 'ID', 'Kec. Tulin Onsoi', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340523', 3, 'ID', 'Kec. Lumbis Ogong', '340500');
INSERT INTO siakad.master_wilayah VALUES ('340524', 3, 'ID', 'Kec. Sembakung Atulai', '340500');
INSERT INTO siakad.master_wilayah VALUES ('346001', 3, 'ID', 'Kec. Tarakan Timur', '346000');
INSERT INTO siakad.master_wilayah VALUES ('346002', 3, 'ID', 'Kec. Tarakan Tengah', '346000');
INSERT INTO siakad.master_wilayah VALUES ('346003', 3, 'ID', 'Kec. Tarakan Barat', '346000');
INSERT INTO siakad.master_wilayah VALUES ('346004', 3, 'ID', 'Kec. Tarakan Utara', '346000');
INSERT INTO siakad.master_wilayah VALUES ('286207', 3, 'ID', 'Serang', '286200');


--
-- TOC entry 4022 (class 0 OID 24853)
-- Dependencies: 234
-- Data for Name: matakuliah_kelas_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4023 (class 0 OID 24858)
-- Dependencies: 235
-- Data for Name: matakuliah_krs_ditawarkan; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4026 (class 0 OID 24873)
-- Dependencies: 238
-- Data for Name: matakuliah_kurikulum; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.matakuliah_kurikulum VALUES ('61bcd0f6-8682-40c7-b996-e24c4f9b8204', '4ef65db6-ee43-45d3-87e5-893e280179f1', '20231', 'd1842e2a-cd84-4ef4-8df8-1c897084a016', 'Berfikir Kritis', 4, '20231', '2023/2024 Gasal', 1, 6.00, 2.00, 1.00, 2.00, 1.00, '7f44428f-8665-4909-bbbe-06ebcc1da17a', '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', 'Farmasi');


--
-- TOC entry 4024 (class 0 OID 24863)
-- Dependencies: 236
-- Data for Name: matakuliah_remidi_ditawarkan; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4025 (class 0 OID 24868)
-- Dependencies: 237
-- Data for Name: matakuliah_rencana_remidi_ditawarkan; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4052 (class 0 OID 33010)
-- Dependencies: 264
-- Data for Name: negara; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.negara VALUES ('GH', 'Ghana');
INSERT INTO siakad.negara VALUES ('NC', 'New Caledonia');
INSERT INTO siakad.negara VALUES ('AO', 'Angola');
INSERT INTO siakad.negara VALUES ('PH', 'Philippines');
INSERT INTO siakad.negara VALUES ('VE', 'Venezuela');
INSERT INTO siakad.negara VALUES ('MC', 'Monaco');
INSERT INTO siakad.negara VALUES ('TJ', 'Tajikistan');
INSERT INTO siakad.negara VALUES ('SO', 'Somalia');
INSERT INTO siakad.negara VALUES ('AX', 'Aland Islands');
INSERT INTO siakad.negara VALUES ('KG', 'Kyrgyzstan');
INSERT INTO siakad.negara VALUES ('KR', 'Korea, Republic Of');
INSERT INTO siakad.negara VALUES ('VA', 'Holy See (Vatican City State)');
INSERT INTO siakad.negara VALUES ('AI', 'Anguilla');
INSERT INTO siakad.negara VALUES ('CU', 'Cuba');
INSERT INTO siakad.negara VALUES ('BF', 'Burkina Faso');
INSERT INTO siakad.negara VALUES ('GT', 'Guatemala');
INSERT INTO siakad.negara VALUES ('KI', 'Kiribati');
INSERT INTO siakad.negara VALUES ('BQ', 'Bonaire, Saint Eustatius and Saba');
INSERT INTO siakad.negara VALUES ('CI', 'Cote D''Ivoire');
INSERT INTO siakad.negara VALUES ('DM', 'Dominica');
INSERT INTO siakad.negara VALUES ('BE', 'Belgium');
INSERT INTO siakad.negara VALUES ('MP', 'Northern Mariana Islands');
INSERT INTO siakad.negara VALUES ('PL', 'Poland');
INSERT INTO siakad.negara VALUES ('CM', 'Cameroon');
INSERT INTO siakad.negara VALUES ('IL', 'Israel');
INSERT INTO siakad.negara VALUES ('PT', 'Portugal');
INSERT INTO siakad.negara VALUES ('CG', 'Congo');
INSERT INTO siakad.negara VALUES ('TD', 'Chad');
INSERT INTO siakad.negara VALUES ('BT', 'Bhutan');
INSERT INTO siakad.negara VALUES ('AR', 'Argentina');
INSERT INTO siakad.negara VALUES ('KN', 'Saint Kitts And Nevis');
INSERT INTO siakad.negara VALUES ('GI', 'Gibraltar');
INSERT INTO siakad.negara VALUES ('GE', 'Georgia');
INSERT INTO siakad.negara VALUES ('SK', 'Slovakia');
INSERT INTO siakad.negara VALUES ('IE', 'Ireland');
INSERT INTO siakad.negara VALUES ('GG', 'Guernsey');
INSERT INTO siakad.negara VALUES ('CY', 'Cyprus');
INSERT INTO siakad.negara VALUES ('TN', 'Tunisia');
INSERT INTO siakad.negara VALUES ('SG', 'Singapore');
INSERT INTO siakad.negara VALUES ('LR', 'Liberia');
INSERT INTO siakad.negara VALUES ('NU', 'Niue');
INSERT INTO siakad.negara VALUES ('IS', 'Iceland');
INSERT INTO siakad.negara VALUES ('UA', 'Ukraine');
INSERT INTO siakad.negara VALUES ('SL', 'Sierra Leone');
INSERT INTO siakad.negara VALUES ('BG', 'Bulgaria');
INSERT INTO siakad.negara VALUES ('BW', 'Botswana');
INSERT INTO siakad.negara VALUES ('TK', 'Tokelau');
INSERT INTO siakad.negara VALUES ('VC', 'Saint Vincent And The Grenadines');
INSERT INTO siakad.negara VALUES ('PK', 'Pakistan');
INSERT INTO siakad.negara VALUES ('EG', 'Egypt');
INSERT INTO siakad.negara VALUES ('BH', 'Bahrain');
INSERT INTO siakad.negara VALUES ('RS', 'Serbia');
INSERT INTO siakad.negara VALUES ('TT', 'Trinidad And Tobago');
INSERT INTO siakad.negara VALUES ('JP', 'Japan');
INSERT INTO siakad.negara VALUES ('LI', 'Liechtenstein');
INSERT INTO siakad.negara VALUES ('AE', 'United Arab Emirates');
INSERT INTO siakad.negara VALUES ('NF', 'Norfolk Island');
INSERT INTO siakad.negara VALUES ('NR', 'Nauru');
INSERT INTO siakad.negara VALUES ('IT', 'Italy');
INSERT INTO siakad.negara VALUES ('PM', 'Saint Pierre And Miquelon');
INSERT INTO siakad.negara VALUES ('MS', 'Montserrat');
INSERT INTO siakad.negara VALUES ('BL', 'Saint Bartelemey');
INSERT INTO siakad.negara VALUES ('MA', 'Morocco');
INSERT INTO siakad.negara VALUES ('YE', 'Yemen');
INSERT INTO siakad.negara VALUES ('SI', 'Slovenia');
INSERT INTO siakad.negara VALUES ('AD', 'Andorra');
INSERT INTO siakad.negara VALUES ('TG', 'Togo');
INSERT INTO siakad.negara VALUES ('CN', 'China');
INSERT INTO siakad.negara VALUES ('KE', 'Kenya');
INSERT INTO siakad.negara VALUES ('DJ', 'Djibouti');
INSERT INTO siakad.negara VALUES ('GP', 'Guadeloupe');
INSERT INTO siakad.negara VALUES ('ER', 'Eritrea');
INSERT INTO siakad.negara VALUES ('ID', 'Indonesia');
INSERT INTO siakad.negara VALUES ('CZ', 'Czech Republic');
INSERT INTO siakad.negara VALUES ('HN', 'Honduras');
INSERT INTO siakad.negara VALUES ('FO', 'Faroe Islands');
INSERT INTO siakad.negara VALUES ('KY', 'Cayman Islands');
INSERT INTO siakad.negara VALUES ('PE', 'Peru');
INSERT INTO siakad.negara VALUES ('NZ', 'New Zealand');
INSERT INTO siakad.negara VALUES ('HU', 'Hungary');
INSERT INTO siakad.negara VALUES ('MQ', 'Martinique');
INSERT INTO siakad.negara VALUES ('SD', 'Sudan');
INSERT INTO siakad.negara VALUES ('CW', 'Curacao');
INSERT INTO siakad.negara VALUES ('SB', 'Solomon Islands');
INSERT INTO siakad.negara VALUES ('VU', 'Vanuatu');
INSERT INTO siakad.negara VALUES ('LV', 'Latvia');
INSERT INTO siakad.negara VALUES ('AZ', 'Azerbaijan');
INSERT INTO siakad.negara VALUES ('BO', 'Bolivia');
INSERT INTO siakad.negara VALUES ('AS', 'American Samoa');
INSERT INTO siakad.negara VALUES ('VN', 'Viet Nam');
INSERT INTO siakad.negara VALUES ('IQ', 'Iraq');
INSERT INTO siakad.negara VALUES ('EE', 'Estonia');
INSERT INTO siakad.negara VALUES ('PF', 'French Polynesia');
INSERT INTO siakad.negara VALUES ('PW', 'Palau');
INSERT INTO siakad.negara VALUES ('BJ', 'Benin');
INSERT INTO siakad.negara VALUES ('QA', 'Qatar');
INSERT INTO siakad.negara VALUES ('AT', 'Austria');
INSERT INTO siakad.negara VALUES ('SY', 'Syrian Arab Republic');
INSERT INTO siakad.negara VALUES ('ME', 'Montenegro');
INSERT INTO siakad.negara VALUES ('ZA', 'South Africa');
INSERT INTO siakad.negara VALUES ('KP', 'Korea, Democratic People''S Republic Of');
INSERT INTO siakad.negara VALUES ('TO', 'Tonga');
INSERT INTO siakad.negara VALUES ('RE', 'Reunion');
INSERT INTO siakad.negara VALUES ('CL', 'Chile');
INSERT INTO siakad.negara VALUES ('BR', 'Brazil');
INSERT INTO siakad.negara VALUES ('SM', 'San Marino');
INSERT INTO siakad.negara VALUES ('DZ', 'Algeria');
INSERT INTO siakad.negara VALUES ('AW', 'Aruba');
INSERT INTO siakad.negara VALUES ('SC', 'Seychelles');
INSERT INTO siakad.negara VALUES ('EH', 'Western Sahara');
INSERT INTO siakad.negara VALUES ('MT', 'Malta');
INSERT INTO siakad.negara VALUES ('JM', 'Jamaica');
INSERT INTO siakad.negara VALUES ('NP', 'Nepal');
INSERT INTO siakad.negara VALUES ('BY', 'Belarus');
INSERT INTO siakad.negara VALUES ('ZM', 'Zambia');
INSERT INTO siakad.negara VALUES ('WF', 'Wallis And Futuna');
INSERT INTO siakad.negara VALUES ('VI', 'Virgin Islands, U.S.');
INSERT INTO siakad.negara VALUES ('ET', 'Ethiopia');
INSERT INTO siakad.negara VALUES ('SS', 'South Sudan');
INSERT INTO siakad.negara VALUES ('GR', 'Greece');
INSERT INTO siakad.negara VALUES ('GY', 'Guyana');
INSERT INTO siakad.negara VALUES ('NI', 'Nicaragua');
INSERT INTO siakad.negara VALUES ('LB', 'Lebanon');
INSERT INTO siakad.negara VALUES ('CH', 'Switzerland');
INSERT INTO siakad.negara VALUES ('SN', 'Senegal');
INSERT INTO siakad.negara VALUES ('BS', 'Bahamas');
INSERT INTO siakad.negara VALUES ('IN', 'India');
INSERT INTO siakad.negara VALUES ('GA', 'Gabon');
INSERT INTO siakad.negara VALUES ('TH', 'Thailand');
INSERT INTO siakad.negara VALUES ('MH', 'Marshall Islands');
INSERT INTO siakad.negara VALUES ('YT', 'Mayotte');
INSERT INTO siakad.negara VALUES ('PN', 'Pitcairn');
INSERT INTO siakad.negara VALUES ('NA', 'Namibia');
INSERT INTO siakad.negara VALUES ('BM', 'Bermuda');
INSERT INTO siakad.negara VALUES ('RU', 'Russian Federation');
INSERT INTO siakad.negara VALUES ('CV', 'Cape Verde');
INSERT INTO siakad.negara VALUES ('AG', 'Antigua And Barbuda');
INSERT INTO siakad.negara VALUES ('IM', 'Isle Of Man');
INSERT INTO siakad.negara VALUES ('GL', 'Greenland');
INSERT INTO siakad.negara VALUES ('AM', 'Armenia');
INSERT INTO siakad.negara VALUES ('BA', 'Bosnia And Herzegovina');
INSERT INTO siakad.negara VALUES ('DO', 'Dominican Republic');
INSERT INTO siakad.negara VALUES ('PG', 'Papua New Guinea');
INSERT INTO siakad.negara VALUES ('PY', 'Paraguay');
INSERT INTO siakad.negara VALUES ('HR', 'Croatia');
INSERT INTO siakad.negara VALUES ('LT', 'Lithuania');
INSERT INTO siakad.negara VALUES ('EC', 'Ecuador');
INSERT INTO siakad.negara VALUES ('AU', 'Australia');
INSERT INTO siakad.negara VALUES ('TC', 'Turks And Caicos Islands');
INSERT INTO siakad.negara VALUES ('KM', 'Comoros');
INSERT INTO siakad.negara VALUES ('VG', 'Virgin Islands, British');
INSERT INTO siakad.negara VALUES ('TW', 'Taiwan, Province Of China');
INSERT INTO siakad.negara VALUES ('UZ', 'Uzbekistan');
INSERT INTO siakad.negara VALUES ('HT', 'Haiti');
INSERT INTO siakad.negara VALUES ('CF', 'Central African Republic');
INSERT INTO siakad.negara VALUES ('UG', 'Uganda');
INSERT INTO siakad.negara VALUES ('MG', 'Madagascar');
INSERT INTO siakad.negara VALUES ('MV', 'Maldives');
INSERT INTO siakad.negara VALUES ('DE', 'Germany');
INSERT INTO siakad.negara VALUES ('SV', 'El Salvador');
INSERT INTO siakad.negara VALUES ('AF', 'Afghanistan');
INSERT INTO siakad.negara VALUES ('UM', 'United States Minor Outlying Islands');
INSERT INTO siakad.negara VALUES ('MU', 'Mauritius');
INSERT INTO siakad.negara VALUES ('LA', 'Lao People''S Democratic Republic');
INSERT INTO siakad.negara VALUES ('PR', 'Puerto Rico');
INSERT INTO siakad.negara VALUES ('FM', 'Micronesia, Federated States Of');
INSERT INTO siakad.negara VALUES ('SE', 'Sweden');
INSERT INTO siakad.negara VALUES ('SR', 'Suriname');
INSERT INTO siakad.negara VALUES ('JE', 'Jersey');
INSERT INTO siakad.negara VALUES ('BZ', 'Belize');
INSERT INTO siakad.negara VALUES ('MF', 'Saint Martin');
INSERT INTO siakad.negara VALUES ('CK', 'Cook Islands');
INSERT INTO siakad.negara VALUES ('GM', 'Gambia');
INSERT INTO siakad.negara VALUES ('JO', 'Jordan');
INSERT INTO siakad.negara VALUES ('PS', 'Palestinian Territory, Occupied');
INSERT INTO siakad.negara VALUES ('MK', 'Macedonia, The Former Yugoslav Republic Of');
INSERT INTO siakad.negara VALUES ('RO', 'Romania');
INSERT INTO siakad.negara VALUES ('GB', 'United Kingdom');
INSERT INTO siakad.negara VALUES ('TL', 'Timor-Leste');
INSERT INTO siakad.negara VALUES ('FJ', 'Fiji');
INSERT INTO siakad.negara VALUES ('AN', 'Netherlands Antilles');
INSERT INTO siakad.negara VALUES ('TZ', 'Tanzania, United Republic Of');
INSERT INTO siakad.negara VALUES ('MR', 'Mauritania');
INSERT INTO siakad.negara VALUES ('LS', 'Lesotho');
INSERT INTO siakad.negara VALUES ('NG', 'Nigeria');
INSERT INTO siakad.negara VALUES ('SJ', 'Svalbard And Jan Mayen');
INSERT INTO siakad.negara VALUES ('MY', 'Malaysia');
INSERT INTO siakad.negara VALUES ('SA', 'Saudi Arabia');
INSERT INTO siakad.negara VALUES ('SZ', 'Swaziland');
INSERT INTO siakad.negara VALUES ('GN', 'Guinea');
INSERT INTO siakad.negara VALUES ('FI', 'Finland');
INSERT INTO siakad.negara VALUES ('OM', 'Oman');
INSERT INTO siakad.negara VALUES ('GU', 'Guam');
INSERT INTO siakad.negara VALUES ('ML', 'Mali');
INSERT INTO siakad.negara VALUES ('SX', 'Sint Maarten');
INSERT INTO siakad.negara VALUES ('GD', 'Grenada');
INSERT INTO siakad.negara VALUES ('KZ', 'Kazakhstan');
INSERT INTO siakad.negara VALUES ('MW', 'Malawi');
INSERT INTO siakad.negara VALUES ('CO', 'Colombia');
INSERT INTO siakad.negara VALUES ('US', 'United States');
INSERT INTO siakad.negara VALUES ('TV', 'Tuvalu');
INSERT INTO siakad.negara VALUES ('CA', 'Canada');
INSERT INTO siakad.negara VALUES ('MZ', 'Mozambique');
INSERT INTO siakad.negara VALUES ('NO', 'Norway');
INSERT INTO siakad.negara VALUES ('MM', 'Myanmar');
INSERT INTO siakad.negara VALUES ('UY', 'Uruguay');
INSERT INTO siakad.negara VALUES ('HK', 'Hong Kong');
INSERT INTO siakad.negara VALUES ('DK', 'Denmark');
INSERT INTO siakad.negara VALUES ('LU', 'Luxembourg');
INSERT INTO siakad.negara VALUES ('GW', 'Guinea-Bissau');
INSERT INTO siakad.negara VALUES ('GQ', 'Equatorial Guinea');
INSERT INTO siakad.negara VALUES ('CD', 'Congo, The Democratic Republic Of The');
INSERT INTO siakad.negara VALUES ('PA', 'Panama');
INSERT INTO siakad.negara VALUES ('LC', 'Saint Lucia');
INSERT INTO siakad.negara VALUES ('RW', 'Rwanda');
INSERT INTO siakad.negara VALUES ('NL', 'Netherlands');
INSERT INTO siakad.negara VALUES ('NE', 'Niger');
INSERT INTO siakad.negara VALUES ('CX', 'Christmas Island');
INSERT INTO siakad.negara VALUES ('IO', 'British Indian Ocean Territory');
INSERT INTO siakad.negara VALUES ('ZW', 'Zimbabwe');
INSERT INTO siakad.negara VALUES ('AQ', 'Antarctica');
INSERT INTO siakad.negara VALUES ('BD', 'Bangladesh');
INSERT INTO siakad.negara VALUES ('CC', 'Cocos (Keeling) Islands');
INSERT INTO siakad.negara VALUES ('BB', 'Barbados');
INSERT INTO siakad.negara VALUES ('ES', 'Spain');
INSERT INTO siakad.negara VALUES ('FR', 'France');
INSERT INTO siakad.negara VALUES ('KW', 'Kuwait');
INSERT INTO siakad.negara VALUES ('MN', 'Mongolia');
INSERT INTO siakad.negara VALUES ('CS', 'Serbia And Montenegro');
INSERT INTO siakad.negara VALUES ('FK', 'Falkland Islands (Malvinas)');
INSERT INTO siakad.negara VALUES ('IR', 'Iran, Islamic Republic Of');
INSERT INTO siakad.negara VALUES ('KH', 'Cambodia');
INSERT INTO siakad.negara VALUES ('GS', 'South Georgia And The South Sandwich Islands');
INSERT INTO siakad.negara VALUES ('BN', 'Brunei Darussalam');
INSERT INTO siakad.negara VALUES ('MD', 'Moldova, Republic Of');
INSERT INTO siakad.negara VALUES ('TF', 'French Southern Territories');
INSERT INTO siakad.negara VALUES ('MX', 'Mexico');
INSERT INTO siakad.negara VALUES ('BI', 'Burundi');
INSERT INTO siakad.negara VALUES ('SH', 'Saint Helena');
INSERT INTO siakad.negara VALUES ('CR', 'Costa Rica');
INSERT INTO siakad.negara VALUES ('HM', 'Heard Island And Mcdonald Islands');
INSERT INTO siakad.negara VALUES ('BV', 'Bouvet Island');
INSERT INTO siakad.negara VALUES ('GF', 'French Guiana');
INSERT INTO siakad.negara VALUES ('TM', 'Turkmenistan');
INSERT INTO siakad.negara VALUES ('AL', 'Albania');
INSERT INTO siakad.negara VALUES ('LY', 'Libyan Arab Jamahiriya');
INSERT INTO siakad.negara VALUES ('MO', 'Macao');
INSERT INTO siakad.negara VALUES ('LK', 'Sri Lanka');
INSERT INTO siakad.negara VALUES ('ST', 'Sao Tome And Principe');
INSERT INTO siakad.negara VALUES ('WS', 'Samoa');
INSERT INTO siakad.negara VALUES ('TR', 'Turkey');


--
-- TOC entry 4027 (class 0 OID 24884)
-- Dependencies: 239
-- Data for Name: nilai; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4028 (class 0 OID 24892)
-- Dependencies: 240
-- Data for Name: parameter_absensi; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4029 (class 0 OID 24897)
-- Dependencies: 241
-- Data for Name: parameter_penilaian; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4037 (class 0 OID 25225)
-- Dependencies: 249
-- Data for Name: periode_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4030 (class 0 OID 24903)
-- Dependencies: 242
-- Data for Name: peserta_absensi; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4031 (class 0 OID 24908)
-- Dependencies: 243
-- Data for Name: peserta_kelas_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4032 (class 0 OID 24913)
-- Dependencies: 244
-- Data for Name: waktu_krs; Type: TABLE DATA; Schema: siakad; Owner: -
--

INSERT INTO siakad.waktu_krs VALUES ('379b22e1-fc53-4bb4-adb9-b94981da757f', 'KRS 2022/2023 Gasal farmasi', '7f44428f-8665-4909-bbbe-06ebcc1da17a', 'Farmasi', '20231', '77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e', '2023/2024 Gasal', 'Aktif', '2023-09-19 07:00:00', '2023-09-20 20:00:00', '2023-09-21 07:00:00', '2023-09-23 16:30:00');


--
-- TOC entry 4033 (class 0 OID 24918)
-- Dependencies: 245
-- Data for Name: waktu_remidi; Type: TABLE DATA; Schema: siakad; Owner: -
--



--
-- TOC entry 4034 (class 0 OID 24923)
-- Dependencies: 246
-- Data for Name: mahasiswa_skripsi; Type: TABLE DATA; Schema: skripsi; Owner: -
--



--
-- TOC entry 4035 (class 0 OID 24929)
-- Dependencies: 247
-- Data for Name: pembimbing_mahasiswa; Type: TABLE DATA; Schema: skripsi; Owner: -
--



--
-- TOC entry 3729 (class 2606 OID 24933)
-- Name: master_dosen_wali pk_master_dosen_wali; Type: CONSTRAINT; Schema: perwalian; Owner: -
--

ALTER TABLE ONLY perwalian.master_dosen_wali
    ADD CONSTRAINT pk_master_dosen_wali PRIMARY KEY (id_master_dosen_wali);


--
-- TOC entry 3731 (class 2606 OID 24935)
-- Name: penguji_mahasiswa pk_pembimbing_mahasiswa; Type: CONSTRAINT; Schema: perwalian; Owner: -
--

ALTER TABLE ONLY perwalian.penguji_mahasiswa
    ADD CONSTRAINT pk_pembimbing_mahasiswa PRIMARY KEY (id_penguji_mahasiswa);


--
-- TOC entry 3733 (class 2606 OID 24937)
-- Name: pesan_perwalian pk_pesan_perwalian; Type: CONSTRAINT; Schema: perwalian; Owner: -
--

ALTER TABLE ONLY perwalian.pesan_perwalian
    ADD CONSTRAINT pk_pesan_perwalian PRIMARY KEY (id_pesan_perwalian);


--
-- TOC entry 3735 (class 2606 OID 24939)
-- Name: tran_perwalian pk_tran_perwalian; Type: CONSTRAINT; Schema: perwalian; Owner: -
--

ALTER TABLE ONLY perwalian.tran_perwalian
    ADD CONSTRAINT pk_tran_perwalian PRIMARY KEY (id_tran_perwalian);


--
-- TOC entry 3737 (class 2606 OID 24941)
-- Name: waktu_perwalian pk_waktu_krs; Type: CONSTRAINT; Schema: perwalian; Owner: -
--

ALTER TABLE ONLY perwalian.waktu_perwalian
    ADD CONSTRAINT pk_waktu_krs PRIMARY KEY (id_waktu_perwalian);


--
-- TOC entry 3775 (class 2606 OID 33666)
-- Name: master_matakuliah master_matakuliah_pk; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_matakuliah
    ADD CONSTRAINT master_matakuliah_pk PRIMARY KEY (kode_mata_kuliah, nama_mata_kuliah, id_prodi, sks_mata_kuliah, sks_tatap_muka, sks_praktek, sks_praktek_lapangan, sks_simulasi);


--
-- TOC entry 3839 (class 2606 OID 33014)
-- Name: negara negara_pkey; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.negara
    ADD CONSTRAINT negara_pkey PRIMARY KEY (id_negara);


--
-- TOC entry 3739 (class 2606 OID 24943)
-- Name: absensi_perkuliahan pk_absensi_perkuliahan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.absensi_perkuliahan
    ADD CONSTRAINT pk_absensi_perkuliahan PRIMARY KEY (id_absensi_perkuliahan);


--
-- TOC entry 3741 (class 2606 OID 24945)
-- Name: aktivitas_perkuliahan_mahasiswa pk_aktivitas_perkuliahan_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.aktivitas_perkuliahan_mahasiswa
    ADD CONSTRAINT pk_aktivitas_perkuliahan_mahasiswa PRIMARY KEY (id_aktivitas_perkuliahan_mahasiswa);


--
-- TOC entry 3743 (class 2606 OID 33063)
-- Name: biodata_mahasiswa pk_biodata_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.biodata_mahasiswa
    ADD CONSTRAINT pk_biodata_mahasiswa PRIMARY KEY (id_mahasiswa);


--
-- TOC entry 3841 (class 2606 OID 33614)
-- Name: master_jenis_matakuliah pk_id_jenis_mata_kuliah; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_jenis_matakuliah
    ADD CONSTRAINT pk_id_jenis_mata_kuliah PRIMARY KEY (id_jenis_mata_kuliah);


--
-- TOC entry 3749 (class 2606 OID 33791)
-- Name: master_kode_pembayaran pk_kode_pembayaran; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_kode_pembayaran
    ADD CONSTRAINT pk_kode_pembayaran PRIMARY KEY (id_kode_pembayaran);


--
-- TOC entry 3753 (class 2606 OID 24951)
-- Name: kurikulum pk_kurikulum; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.kurikulum
    ADD CONSTRAINT pk_kurikulum PRIMARY KEY (id_kurikulum);


--
-- TOC entry 3755 (class 2606 OID 33262)
-- Name: list_mahasiswa pk_list_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.list_mahasiswa
    ADD CONSTRAINT pk_list_mahasiswa PRIMARY KEY (id_registrasi_mahasiswa);


--
-- TOC entry 3757 (class 2606 OID 24955)
-- Name: lokasi_perkuliahan pk_lokasi_perkuliahan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.lokasi_perkuliahan
    ADD CONSTRAINT pk_lokasi_perkuliahan PRIMARY KEY (id_lokasi_perkuliahan);


--
-- TOC entry 3845 (class 2606 OID 33723)
-- Name: mahasiswa_angkatan pk_mahasiswa_angkatan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_angkatan
    ADD CONSTRAINT pk_mahasiswa_angkatan PRIMARY KEY (id_mahasiswa_angkatan);


--
-- TOC entry 3759 (class 2606 OID 24957)
-- Name: mahasiswa_krs pk_mahasiswa_krs; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_krs
    ADD CONSTRAINT pk_mahasiswa_krs PRIMARY KEY (id_mahasiswa_krs);


--
-- TOC entry 3765 (class 2606 OID 24959)
-- Name: mahasiswa_rencana_remidi pk_mahasiswa_krs_0; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_rencana_remidi
    ADD CONSTRAINT pk_mahasiswa_krs_0 PRIMARY KEY (id_mahasiswa_krs);


--
-- TOC entry 3763 (class 2606 OID 24961)
-- Name: mahasiswa_remidi pk_mahasiswa_krs_1; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_remidi
    ADD CONSTRAINT pk_mahasiswa_krs_1 PRIMARY KEY (id_mahasiswa_remidi);


--
-- TOC entry 3761 (class 2606 OID 24963)
-- Name: mahasiswa_kurikulum pk_mahasiswa_kurikulum; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_kurikulum
    ADD CONSTRAINT pk_mahasiswa_kurikulum PRIMARY KEY (id_mahasiswa_kurikulum);


--
-- TOC entry 3811 (class 2606 OID 25289)
-- Name: master_agama pk_master_agama; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_agama
    ADD CONSTRAINT pk_master_agama PRIMARY KEY (id_agama);


--
-- TOC entry 3833 (class 2606 OID 32926)
-- Name: master_alat_transportasi pk_master_alat_transportasi; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_alat_transportasi
    ADD CONSTRAINT pk_master_alat_transportasi PRIMARY KEY (id_alat_transportasi);


--
-- TOC entry 3843 (class 2606 OID 33713)
-- Name: master_angkatan_mahasiswa pk_master_angakatan_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_angkatan_mahasiswa
    ADD CONSTRAINT pk_master_angakatan_mahasiswa PRIMARY KEY (id_angkatan_mahasiswa);


--
-- TOC entry 3813 (class 2606 OID 25294)
-- Name: master_jalur_masuk pk_master_jalur_masuk; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_jalur_masuk
    ADD CONSTRAINT pk_master_jalur_masuk PRIMARY KEY (id_jalur_masuk);


--
-- TOC entry 3815 (class 2606 OID 25299)
-- Name: master_jenis_keluar pk_master_jenis_keluar; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_jenis_keluar
    ADD CONSTRAINT pk_master_jenis_keluar PRIMARY KEY (id_jenis_keluar);


--
-- TOC entry 3817 (class 2606 OID 25304)
-- Name: master_jenis_perndaftaran pk_master_jenis_perndaftaran; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_jenis_perndaftaran
    ADD CONSTRAINT pk_master_jenis_perndaftaran PRIMARY KEY (id_jenis_daftar);


--
-- TOC entry 3837 (class 2606 OID 32936)
-- Name: master_jenis_prestasi pk_master_jenis_prestasi; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_jenis_prestasi
    ADD CONSTRAINT pk_master_jenis_prestasi PRIMARY KEY (id_jenis_prestasi);


--
-- TOC entry 3819 (class 2606 OID 25309)
-- Name: master_jenis_tinggal pk_master_jenis_tinggal; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_jenis_tinggal
    ADD CONSTRAINT pk_master_jenis_tinggal PRIMARY KEY (id_jenis_tinggal);


--
-- TOC entry 3821 (class 2606 OID 25314)
-- Name: master_jenjang_pendidikan pk_master_jenjang_pendidikan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_jenjang_pendidikan
    ADD CONSTRAINT pk_master_jenjang_pendidikan PRIMARY KEY (id_jenjang_didik);


--
-- TOC entry 3767 (class 2606 OID 24965)
-- Name: master_kegiatan_perkuliahan pk_master_kegiatan_perkuliahan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_kegiatan_perkuliahan
    ADD CONSTRAINT pk_master_kegiatan_perkuliahan PRIMARY KEY (id_master_kegiatan_perkuliahan);


--
-- TOC entry 3769 (class 2606 OID 24967)
-- Name: master_kelas_mahasiswa pk_master_kelompok_sgd; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_kelas_mahasiswa
    ADD CONSTRAINT pk_master_kelompok_sgd PRIMARY KEY (id_master_kelas_mahasiswa);


--
-- TOC entry 3829 (class 2606 OID 25334)
-- Name: master_pekerjaan pk_master_pekerjaan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_pekerjaan
    ADD CONSTRAINT pk_master_pekerjaan PRIMARY KEY (id_pekerjaan);


--
-- TOC entry 3835 (class 2606 OID 32931)
-- Name: master_pembiayaan_mahasiswa pk_master_pembiayaan_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_pembiayaan_mahasiswa
    ADD CONSTRAINT pk_master_pembiayaan_mahasiswa PRIMARY KEY (id_pembiayaan);


--
-- TOC entry 3827 (class 2606 OID 25329)
-- Name: master_penghasilan pk_master_penghasilan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_penghasilan
    ADD CONSTRAINT pk_master_penghasilan PRIMARY KEY (id_penghasilan);


--
-- TOC entry 3831 (class 2606 OID 32921)
-- Name: master_prodi pk_master_prodi; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_prodi
    ADD CONSTRAINT pk_master_prodi PRIMARY KEY (id_prodi);


--
-- TOC entry 3825 (class 2606 OID 25324)
-- Name: master_status_mahasiswa pk_master_status_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_status_mahasiswa
    ADD CONSTRAINT pk_master_status_mahasiswa PRIMARY KEY (id_status_mahasiswa);


--
-- TOC entry 3773 (class 2606 OID 33733)
-- Name: master_tagihan_angkatan pk_master_tagihan_angkatan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_tagihan_angkatan
    ADD CONSTRAINT pk_master_tagihan_angkatan PRIMARY KEY (id_tagihan_angkatan);


--
-- TOC entry 3805 (class 2606 OID 33215)
-- Name: master_tahun_akademik pk_master_tahun_akademik; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_tahun_akademik
    ADD CONSTRAINT pk_master_tahun_akademik PRIMARY KEY (id_tahun_akademik);


--
-- TOC entry 3823 (class 2606 OID 33024)
-- Name: master_wilayah pk_master_wilayah; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_wilayah
    ADD CONSTRAINT pk_master_wilayah PRIMARY KEY (id_wilayah);


--
-- TOC entry 3777 (class 2606 OID 24973)
-- Name: matakuliah_kelas_mahasiswa pk_matakuliah_kelas_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_kelas_mahasiswa
    ADD CONSTRAINT pk_matakuliah_kelas_mahasiswa PRIMARY KEY (id_matakuliah_kelas_mahasiswa);


--
-- TOC entry 3779 (class 2606 OID 24975)
-- Name: matakuliah_krs_ditawarkan pk_matakuliah_krs_ditawarkan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_krs_ditawarkan
    ADD CONSTRAINT pk_matakuliah_krs_ditawarkan PRIMARY KEY (id_matakuliah_krs_ditawarkan);


--
-- TOC entry 3783 (class 2606 OID 24977)
-- Name: matakuliah_rencana_remidi_ditawarkan pk_matakuliah_krs_ditawarkan_0; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_rencana_remidi_ditawarkan
    ADD CONSTRAINT pk_matakuliah_krs_ditawarkan_0 PRIMARY KEY (id_matakuliah_rencana_remidi_ditawarkan);


--
-- TOC entry 3781 (class 2606 OID 24979)
-- Name: matakuliah_remidi_ditawarkan pk_matakuliah_krs_ditawarkan_1; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_remidi_ditawarkan
    ADD CONSTRAINT pk_matakuliah_krs_ditawarkan_1 PRIMARY KEY (id_matakuliah_remidi_ditawarkan);


--
-- TOC entry 3785 (class 2606 OID 24981)
-- Name: matakuliah_kurikulum pk_matkul_kurikulum; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_kurikulum
    ADD CONSTRAINT pk_matkul_kurikulum PRIMARY KEY (id_matakuliah_kurikulum);


--
-- TOC entry 3787 (class 2606 OID 24983)
-- Name: nilai pk_nilai; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.nilai
    ADD CONSTRAINT pk_nilai PRIMARY KEY (id_nilai);


--
-- TOC entry 3791 (class 2606 OID 24985)
-- Name: parameter_penilaian pk_parameter_penilaian; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.parameter_penilaian
    ADD CONSTRAINT pk_parameter_penilaian PRIMARY KEY (id_parameter_penilaian);


--
-- TOC entry 3771 (class 2606 OID 24987)
-- Name: master_parameter_penilaian pk_parameter_penilaian_0; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_parameter_penilaian
    ADD CONSTRAINT pk_parameter_penilaian_0 PRIMARY KEY (id_master_parameter_penilaian);


--
-- TOC entry 3789 (class 2606 OID 24989)
-- Name: parameter_absensi pk_parameter_penilaian_1; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.parameter_absensi
    ADD CONSTRAINT pk_parameter_penilaian_1 PRIMARY KEY (id_parameter_penilaian);


--
-- TOC entry 3807 (class 2606 OID 25233)
-- Name: periode_perkuliahan pk_periode_perkuliahan; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.periode_perkuliahan
    ADD CONSTRAINT pk_periode_perkuliahan PRIMARY KEY (id_periode_perkuliahan);


--
-- TOC entry 3793 (class 2606 OID 24991)
-- Name: peserta_absensi pk_peserta_absensi; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.peserta_absensi
    ADD CONSTRAINT pk_peserta_absensi PRIMARY KEY (id_peserta_absensi);


--
-- TOC entry 3795 (class 2606 OID 24993)
-- Name: peserta_kelas_mahasiswa pk_peserta_kelas_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.peserta_kelas_mahasiswa
    ADD CONSTRAINT pk_peserta_kelas_mahasiswa PRIMARY KEY (id_peserta_kelas_mahasiswa);


--
-- TOC entry 3797 (class 2606 OID 24995)
-- Name: waktu_krs pk_waktu_krs; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.waktu_krs
    ADD CONSTRAINT pk_waktu_krs PRIMARY KEY (id_waktu_krs);


--
-- TOC entry 3799 (class 2606 OID 24997)
-- Name: waktu_remidi pk_waktu_krs_0; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.waktu_remidi
    ADD CONSTRAINT pk_waktu_krs_0 PRIMARY KEY (id_waktu_remidi);


--
-- TOC entry 3745 (class 2606 OID 32940)
-- Name: biodata_mahasiswa unq_biodata_mahasiswa_id_agama; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.biodata_mahasiswa
    ADD CONSTRAINT unq_biodata_mahasiswa_id_agama UNIQUE (id_agama);


--
-- TOC entry 3747 (class 2606 OID 32938)
-- Name: biodata_mahasiswa unq_biodata_mahasiswa_nama_mahasiswa; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.biodata_mahasiswa
    ADD CONSTRAINT unq_biodata_mahasiswa_nama_mahasiswa UNIQUE (nama_mahasiswa);


--
-- TOC entry 3751 (class 2606 OID 24999)
-- Name: master_kode_pembayaran unq_kode_pembayaran_kode_rekening; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.master_kode_pembayaran
    ADD CONSTRAINT unq_kode_pembayaran_kode_rekening UNIQUE (kode_rekening);


--
-- TOC entry 3809 (class 2606 OID 25235)
-- Name: periode_perkuliahan unq_periode_perkuliahan_id_semester; Type: CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.periode_perkuliahan
    ADD CONSTRAINT unq_periode_perkuliahan_id_semester UNIQUE (id_semester);


--
-- TOC entry 3801 (class 2606 OID 25001)
-- Name: mahasiswa_skripsi pk_mahasiswa_skripsi; Type: CONSTRAINT; Schema: skripsi; Owner: -
--

ALTER TABLE ONLY skripsi.mahasiswa_skripsi
    ADD CONSTRAINT pk_mahasiswa_skripsi PRIMARY KEY (id_mahasiswa_skripsi);


--
-- TOC entry 3803 (class 2606 OID 25003)
-- Name: pembimbing_mahasiswa pk_pembimbing_mahasiswa; Type: CONSTRAINT; Schema: skripsi; Owner: -
--

ALTER TABLE ONLY skripsi.pembimbing_mahasiswa
    ADD CONSTRAINT pk_pembimbing_mahasiswa PRIMARY KEY (id_pembimbing_mahasiswa);


--
-- TOC entry 3846 (class 2606 OID 25004)
-- Name: pesan_perwalian fk_pesan_perwalian_tran_perwalian; Type: FK CONSTRAINT; Schema: perwalian; Owner: -
--

ALTER TABLE ONLY perwalian.pesan_perwalian
    ADD CONSTRAINT fk_pesan_perwalian_tran_perwalian FOREIGN KEY (id_tran_perwalian) REFERENCES perwalian.tran_perwalian(id_tran_perwalian);


--
-- TOC entry 3847 (class 2606 OID 25009)
-- Name: tran_perwalian fk_tran_perwalian_waktu_perwalian; Type: FK CONSTRAINT; Schema: perwalian; Owner: -
--

ALTER TABLE ONLY perwalian.tran_perwalian
    ADD CONSTRAINT fk_tran_perwalian_waktu_perwalian FOREIGN KEY (id_waktu_perwalian) REFERENCES perwalian.waktu_perwalian(id_waktu_perwalian);


--
-- TOC entry 3848 (class 2606 OID 25019)
-- Name: mahasiswa_krs fk_mahasiswa_krs_matakuliah_krs_ditawarkan; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_krs
    ADD CONSTRAINT fk_mahasiswa_krs_matakuliah_krs_ditawarkan FOREIGN KEY (id_matakuliah_krs_ditawarkan) REFERENCES siakad.matakuliah_krs_ditawarkan(id_matakuliah_krs_ditawarkan);


--
-- TOC entry 3849 (class 2606 OID 25034)
-- Name: mahasiswa_remidi fk_mahasiswa_remidi_matakuliah_remidi_ditawarkan; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_remidi
    ADD CONSTRAINT fk_mahasiswa_remidi_matakuliah_remidi_ditawarkan FOREIGN KEY (id_matakuliah_remidi_ditawarkan) REFERENCES siakad.matakuliah_remidi_ditawarkan(id_matakuliah_remidi_ditawarkan);


--
-- TOC entry 3851 (class 2606 OID 25039)
-- Name: mahasiswa_rencana_remidi fk_mahasiswa_rencana_remidi_matakuliah_rencana_remidi_ditawarka; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_rencana_remidi
    ADD CONSTRAINT fk_mahasiswa_rencana_remidi_matakuliah_rencana_remidi_ditawarka FOREIGN KEY (id_matakuliah_rencana_remidi_ditawarkan) REFERENCES siakad.matakuliah_rencana_remidi_ditawarkan(id_matakuliah_rencana_remidi_ditawarkan);


--
-- TOC entry 3850 (class 2606 OID 25044)
-- Name: mahasiswa_remidi fk_mahasiswa_rencana_remidi_matakuliah_rencana_remidi_ditawarka; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.mahasiswa_remidi
    ADD CONSTRAINT fk_mahasiswa_rencana_remidi_matakuliah_rencana_remidi_ditawarka FOREIGN KEY (id_matakuliah_remidi_ditawarkan) REFERENCES siakad.matakuliah_rencana_remidi_ditawarkan(id_matakuliah_rencana_remidi_ditawarkan);


--
-- TOC entry 3852 (class 2606 OID 25059)
-- Name: matakuliah_kelas_mahasiswa fk_matakuliah_kelas_mahasiswa_master_kelas_mahasiswa; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_kelas_mahasiswa
    ADD CONSTRAINT fk_matakuliah_kelas_mahasiswa_master_kelas_mahasiswa FOREIGN KEY (id_master_kelas_mahasiswa) REFERENCES siakad.master_kelas_mahasiswa(id_master_kelas_mahasiswa);


--
-- TOC entry 3853 (class 2606 OID 25064)
-- Name: matakuliah_krs_ditawarkan fk_matakuliah_krs_ditawarkan_matkul_kurikulum; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_krs_ditawarkan
    ADD CONSTRAINT fk_matakuliah_krs_ditawarkan_matkul_kurikulum FOREIGN KEY (id_matakuliah_kurikulum) REFERENCES siakad.matakuliah_kurikulum(id_matakuliah_kurikulum);


--
-- TOC entry 3856 (class 2606 OID 25069)
-- Name: matakuliah_rencana_remidi_ditawarkan fk_matakuliah_krs_ditawarkan_matkul_kurikulum_0; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_rencana_remidi_ditawarkan
    ADD CONSTRAINT fk_matakuliah_krs_ditawarkan_matkul_kurikulum_0 FOREIGN KEY (id_matkul_kurikulum) REFERENCES siakad.matakuliah_kurikulum(id_matakuliah_kurikulum);


--
-- TOC entry 3854 (class 2606 OID 25074)
-- Name: matakuliah_remidi_ditawarkan fk_matakuliah_krs_ditawarkan_matkul_kurikulum_1; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_remidi_ditawarkan
    ADD CONSTRAINT fk_matakuliah_krs_ditawarkan_matkul_kurikulum_1 FOREIGN KEY (id_matkul_kurikulum) REFERENCES siakad.matakuliah_kurikulum(id_matakuliah_kurikulum);


--
-- TOC entry 3855 (class 2606 OID 25089)
-- Name: matakuliah_remidi_ditawarkan fk_matakuliah_remidi_ditawarkan_waktu_remidi; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.matakuliah_remidi_ditawarkan
    ADD CONSTRAINT fk_matakuliah_remidi_ditawarkan_waktu_remidi FOREIGN KEY (id_waktu_remidi) REFERENCES siakad.waktu_remidi(id_waktu_remidi);


--
-- TOC entry 3857 (class 2606 OID 25104)
-- Name: parameter_absensi fk_parameter_absensi_master_parameter_penilaian; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.parameter_absensi
    ADD CONSTRAINT fk_parameter_absensi_master_parameter_penilaian FOREIGN KEY (id_master_parameter_penilaian) REFERENCES siakad.master_parameter_penilaian(id_master_parameter_penilaian);


--
-- TOC entry 3858 (class 2606 OID 25109)
-- Name: parameter_penilaian fk_parameter_penilaian_master_parameter_penilaian; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.parameter_penilaian
    ADD CONSTRAINT fk_parameter_penilaian_master_parameter_penilaian FOREIGN KEY (id_master_parameter_penilaian) REFERENCES siakad.master_parameter_penilaian(id_master_parameter_penilaian);


--
-- TOC entry 3859 (class 2606 OID 25114)
-- Name: peserta_absensi fk_peserta_absensi_absensi_perkuliahan; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.peserta_absensi
    ADD CONSTRAINT fk_peserta_absensi_absensi_perkuliahan FOREIGN KEY (id_absensi_perkuliahan) REFERENCES siakad.absensi_perkuliahan(id_absensi_perkuliahan);


--
-- TOC entry 3860 (class 2606 OID 25119)
-- Name: peserta_kelas_mahasiswa fk_peserta_kelas_mahasiswa_lokasi_perkuliahan; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.peserta_kelas_mahasiswa
    ADD CONSTRAINT fk_peserta_kelas_mahasiswa_lokasi_perkuliahan FOREIGN KEY (id_lokasi_perkuliahan) REFERENCES siakad.lokasi_perkuliahan(id_lokasi_perkuliahan);


--
-- TOC entry 3861 (class 2606 OID 25124)
-- Name: peserta_kelas_mahasiswa fk_peserta_kelas_mahasiswa_master_kelas_mahasiswa; Type: FK CONSTRAINT; Schema: siakad; Owner: -
--

ALTER TABLE ONLY siakad.peserta_kelas_mahasiswa
    ADD CONSTRAINT fk_peserta_kelas_mahasiswa_master_kelas_mahasiswa FOREIGN KEY (id_master_kelas_mahasiswa) REFERENCES siakad.master_kelas_mahasiswa(id_master_kelas_mahasiswa);


-- Completed on 2023-09-23 11:18:04 WIB

--
-- PostgreSQL database dump complete
--


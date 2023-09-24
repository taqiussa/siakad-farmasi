--
-- PostgreSQL database dump
--

-- Dumped from database version 14.9 (Homebrew)
-- Dumped by pg_dump version 14.9 (Homebrew)

-- Started on 2023-09-24 09:19:33 WIB

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
-- TOC entry 4047 (class 1262 OID 16386)
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
-- TOC entry 4048 (class 0 OID 0)
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
-- TOC entry 4049 (class 0 OID 0)
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
-- TOC entry 4050 (class 0 OID 0)
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
-- TOC entry 4051 (class 0 OID 0)
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
-- TOC entry 4052 (class 0 OID 0)
-- Dependencies: 220
-- Name: TABLE biodata_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.biodata_mahasiswa IS 'master biodata mahasiswa';


--
-- TOC entry 4053 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_mahasiswa IS 'Primary Key, kosongkan ketika mode Tambah';


--
-- TOC entry 4054 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_mahasiswa IS 'Nama Mahasiswa';


--
-- TOC entry 4055 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.jenis_kelamin; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.jenis_kelamin IS 'L: Laki-laki, P: Perempuan, *: Belum ada informasi';


--
-- TOC entry 4056 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.tempat_lahir; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.tempat_lahir IS 'Tempat Lahir';


--
-- TOC entry 4057 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.tanggal_lahir; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.tanggal_lahir IS 'Tanggal Lahir';


--
-- TOC entry 4058 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_agama IS 'Web Service feeder:  GetAgama';


--
-- TOC entry 4059 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_agama IS 'Detail Agama';


--
-- TOC entry 4060 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nik; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nik IS 'Nomor Induk Kependudukan, wajib di isi';


--
-- TOC entry 4061 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nisn; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nisn IS 'Nomor Induk Siswa Nasional';


--
-- TOC entry 4062 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.npwp; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.npwp IS 'Nomor Pokok Wajib Pajak';


--
-- TOC entry 4063 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_negara; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_negara IS 'Web Service feeder: GetNegara';


--
-- TOC entry 4064 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.kewarganegaraan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.kewarganegaraan IS 'detail Web Service: GetNegara';


--
-- TOC entry 4065 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.jalan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.jalan IS 'Alamat jalan';


--
-- TOC entry 4066 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.dusun; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.dusun IS 'Dusun Desa';


--
-- TOC entry 4067 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.kelurahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.kelurahan IS 'kelurahan';


--
-- TOC entry 4068 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.kode_pos; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.kode_pos IS 'kode_pos harus 5 digit';


--
-- TOC entry 4069 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_wilayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_wilayah IS 'ID Wilayah. Web Service: GetWilayah';


--
-- TOC entry 4070 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_alat_transportasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_alat_transportasi IS 'Web Service: GetAlatTransportasi';


--
-- TOC entry 4071 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_alat_transportasi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_alat_transportasi IS 'Detail alat tranportasi';


--
-- TOC entry 4072 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.penerima_kps; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.penerima_kps IS '0: Bukan penerima KPS, 1: Penerima KPS';


--
-- TOC entry 4073 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nik_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nik_ayah IS 'Nomor Induk Kependudukan, wajib di isi';


--
-- TOC entry 4074 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_ayah IS 'character varying(100)';


--
-- TOC entry 4075 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pendidikan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pendidikan_ayah IS 'Web Service: GetJenjangPendidikan';


--
-- TOC entry 4076 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pendidikan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pendidikan_ayah IS 'detail Web Service: GetJenjangPendidikan';


--
-- TOC entry 4077 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pekerjaan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pekerjaan_ayah IS 'Web Service: GetPekerjaan';


--
-- TOC entry 4078 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pekerjaan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pekerjaan_ayah IS 'detail Web Service: GetPekerjaan';


--
-- TOC entry 4079 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_penghasilan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_penghasilan_ayah IS 'Web Service: GetPenghasilan';


--
-- TOC entry 4080 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_penghasilan_ayah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_penghasilan_ayah IS 'detail Web Service: GetPenghasilan';


--
-- TOC entry 4081 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nik_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nik_ibu IS 'Nomor Induk Kependudukan, wajib di isi';


--
-- TOC entry 4082 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_ibu_kandung; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_ibu_kandung IS 'character varying(100)';


--
-- TOC entry 4083 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pendidikan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pendidikan_ibu IS 'Web Service: GetJenjangPendidikan';


--
-- TOC entry 4084 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pendidikan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pendidikan_ibu IS 'detail Web Service: GetJenjangPendidikan';


--
-- TOC entry 4085 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pekerjaan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pekerjaan_ibu IS 'Web Service: GetPekerjaan';


--
-- TOC entry 4086 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pekerjaan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pekerjaan_ibu IS 'detail Web Service: GetPekerjaan';


--
-- TOC entry 4087 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_penghasilan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_penghasilan_ibu IS 'Web Service: GetPenghasilan';


--
-- TOC entry 4088 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_penghasilan_ibu; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_penghasilan_ibu IS 'detail Web Service: GetPenghasilan';


--
-- TOC entry 4089 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_pekerjaan_wali; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_pekerjaan_wali IS 'Web Service: GetPekerjaan';


--
-- TOC entry 4090 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.nama_pekerjaan_wali; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.nama_pekerjaan_wali IS 'detail Web Service: GetPekerjaan';


--
-- TOC entry 4091 (class 0 OID 0)
-- Dependencies: 220
-- Name: COLUMN biodata_mahasiswa.id_penghasilan_wali; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.biodata_mahasiswa.id_penghasilan_wali IS 'Web Service: GetPenghasilan';


--
-- TOC entry 4092 (class 0 OID 0)
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
-- TOC entry 4093 (class 0 OID 0)
-- Dependencies: 222
-- Name: TABLE kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.kurikulum IS 'Kurikulum';


--
-- TOC entry 4094 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN kurikulum.nama_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.kurikulum.nama_kurikulum IS 'Nama Kuriukulum';


--
-- TOC entry 4095 (class 0 OID 0)
-- Dependencies: 222
-- Name: COLUMN kurikulum.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.kurikulum.id_prodi IS 'ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4096 (class 0 OID 0)
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
-- TOC entry 4097 (class 0 OID 0)
-- Dependencies: 223
-- Name: TABLE list_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.list_mahasiswa IS 'detail mahasiswa program studi';


--
-- TOC entry 4098 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_registrasi_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_registrasi_mahasiswa IS 'primary';


--
-- TOC entry 4099 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_mahasiswa IS 'FK dari Biodata_mahasiswa';


--
-- TOC entry 4100 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_mahasiswa IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)';


--
-- TOC entry 4101 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.jenis_kelamin; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.jenis_kelamin IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)\nL: Laki-laki, P: Perempuan, *: Belum ada informasi';


--
-- TOC entry 4102 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.tanggal_lahir; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.tanggal_lahir IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)';


--
-- TOC entry 4103 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_perguruan_tinggi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_perguruan_tinggi IS 'ID Perguruan Tinggi. Web Service: GetProfilPT';


--
-- TOC entry 4104 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_agama IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)\nWeb Service: GetAgama';


--
-- TOC entry 4105 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_agama; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_agama IS 'detail mahasiswa ( jangan query menampilkan nama disini - hanya field bantu)';


--
-- TOC entry 4106 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_prodi IS 'ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4107 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_program_studi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_program_studi IS 'detail ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4108 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nim; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nim IS 'Nomor Induk Mahasiswa';


--
-- TOC entry 4109 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_periode_masuk; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_periode_masuk IS 'ID periode Masuk';


--
-- TOC entry 4110 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.nama_periode_masuk; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.nama_periode_masuk IS 'Tahun Akademik';


--
-- TOC entry 4111 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_jenis_daftar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_jenis_daftar IS 'Web Service: GetJenisPendaftaran';


--
-- TOC entry 4112 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_jalur_daftar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_jalur_daftar IS 'Web Service: GetJalurMasuk';


--
-- TOC entry 4113 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_bidang_minat; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_bidang_minat IS 'ID Bidang Minat. Web Service: GetListBidangMinat';


--
-- TOC entry 4114 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.sks_diakui; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.sks_diakui IS 'Jika Pindahan';


--
-- TOC entry 4115 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_perguruan_tinggi_asal; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_perguruan_tinggi_asal IS 'Jika Pindahan \nID Perguruan Tinggi. Web Service: GetAllPT';


--
-- TOC entry 4116 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_prodi_asal; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_prodi_asal IS 'Jika Pindahan\nID Prodi. Web Service: GetAllProdi';


--
-- TOC entry 4117 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.id_pembiayaan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.id_pembiayaan IS 'ID Pembiayaan Awal. Web Service: GetPembiayaan';


--
-- TOC entry 4118 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.biaya_masuk; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.biaya_masuk IS 'Biaya DPI';


--
-- TOC entry 4119 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.jenis_keluar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.jenis_keluar IS 'lulus,do,pindah,wafat,mengundurkan diri';


--
-- TOC entry 4120 (class 0 OID 0)
-- Dependencies: 223
-- Name: COLUMN list_mahasiswa.periode_keluar; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.list_mahasiswa.periode_keluar IS 'id semester';


--
-- TOC entry 4121 (class 0 OID 0)
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
-- TOC entry 4122 (class 0 OID 0)
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
-- TOC entry 4123 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.nilai_angka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.nilai_angka IS 'Niai angka dari olah nilai';


--
-- TOC entry 4124 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.nilai_indeks; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.nilai_indeks IS 'nilai indeks \nA = 4\nAB = 3.5\nB = 3\nBC  2.5\nC = 2\nCD = 1.5\nD = 1\nE = 0';


--
-- TOC entry 4125 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.nilai_huruf; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.nilai_huruf IS 'A \nAB \nB \nBC \nC\nCD \nD';


--
-- TOC entry 4126 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.status_krs; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.status_krs IS '1 : KRS \n2: Batal Tambah';


--
-- TOC entry 4127 (class 0 OID 0)
-- Dependencies: 225
-- Name: COLUMN mahasiswa_krs.approval; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_krs.approval IS '0 = tunggu\n1 = disetujui';


--
-- TOC entry 4128 (class 0 OID 0)
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
-- TOC entry 4129 (class 0 OID 0)
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
-- TOC entry 4130 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN mahasiswa_remidi.nilai_angka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_remidi.nilai_angka IS 'Niai angka dari olah nilai';


--
-- TOC entry 4131 (class 0 OID 0)
-- Dependencies: 227
-- Name: COLUMN mahasiswa_remidi.approval; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_remidi.approval IS '0 = tunggu\n1 = disetujui';


--
-- TOC entry 4132 (class 0 OID 0)
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
-- TOC entry 4133 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.nilai_angka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.nilai_angka IS 'Niai angka dari olah nilai';


--
-- TOC entry 4134 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.nilai_indeks; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.nilai_indeks IS 'nilai indeks \nA = 4\nAB = 3.5\nB = 3\nBC  2.5\nC = 2\nCD = 1.5\nD = 1\nE = 0';


--
-- TOC entry 4135 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.nilai_huruf; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.nilai_huruf IS 'A \nAB \nB \nBC \nC\nCD \nD';


--
-- TOC entry 4136 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.status_krs; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.status_krs IS '1 : KRS \n2: Batal Tambah';


--
-- TOC entry 4137 (class 0 OID 0)
-- Dependencies: 228
-- Name: COLUMN mahasiswa_rencana_remidi.approval; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.mahasiswa_rencana_remidi.approval IS '0 = tunggu\n1 = disetujui';


--
-- TOC entry 4138 (class 0 OID 0)
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
-- TOC entry 4139 (class 0 OID 0)
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
-- TOC entry 4140 (class 0 OID 0)
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
-- TOC entry 4141 (class 0 OID 0)
-- Dependencies: 266
-- Name: COLUMN master_angkatan_mahasiswa.nama_angkatan_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_angkatan_mahasiswa.nama_angkatan_mahasiswa IS 'Nama ANgkatan Mahasiswa';


--
-- TOC entry 4142 (class 0 OID 0)
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
-- TOC entry 4143 (class 0 OID 0)
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
-- TOC entry 4144 (class 0 OID 0)
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
-- TOC entry 4145 (class 0 OID 0)
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
-- TOC entry 4146 (class 0 OID 0)
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
-- TOC entry 4147 (class 0 OID 0)
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
-- TOC entry 4148 (class 0 OID 0)
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
-- TOC entry 4149 (class 0 OID 0)
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
-- TOC entry 4150 (class 0 OID 0)
-- Dependencies: 230
-- Name: TABLE master_kelas_mahasiswa; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_kelas_mahasiswa IS 'master kelompok SGD untuk memasukan kelas yang berbeda kurikulum atau kode matakuliah';


--
-- TOC entry 4151 (class 0 OID 0)
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
-- TOC entry 4152 (class 0 OID 0)
-- Dependencies: 221
-- Name: COLUMN master_kode_pembayaran.id_kode_pembayaran; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_kode_pembayaran.id_kode_pembayaran IS 'id kode pembayaran';


--
-- TOC entry 4153 (class 0 OID 0)
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
-- TOC entry 4154 (class 0 OID 0)
-- Dependencies: 233
-- Name: TABLE master_matakuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_matakuliah IS 'master matakuliah';


--
-- TOC entry 4155 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_matkul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_matkul IS 'Primary Key, kosongkan ketika mode Tambah';


--
-- TOC entry 4156 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.kode_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.kode_mata_kuliah IS 'Kode Matakuliah';


--
-- TOC entry 4157 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.nama_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.nama_mata_kuliah IS 'Nama Matakuliah';


--
-- TOC entry 4158 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_prodi IS 'ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4159 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.nama_program_studi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.nama_program_studi IS 'detail ID Prodi. Web Service: GetProdi';


--
-- TOC entry 4160 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_jenis_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_jenis_mata_kuliah IS 'A=Wajib, B=Pilihan, C=Wajib Peminatan, D=Pilihan Peminatan, S=Tugas akhir/Skripsi/Tesis/Disertasi';


--
-- TOC entry 4161 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.id_kelompok_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.id_kelompok_mata_kuliah IS 'A=MPK, B=MKK, C=MKB, D=MPB, E=MBB, F=MKU/MKDU, G=MKDK, H=MKK';


--
-- TOC entry 4162 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_mata_kuliah; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_mata_kuliah IS 'SKS Total';


--
-- TOC entry 4163 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_tatap_muka; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_tatap_muka IS 'SKS teori';


--
-- TOC entry 4164 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_praktek; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_praktek IS 'SKS Praktikum';


--
-- TOC entry 4165 (class 0 OID 0)
-- Dependencies: 233
-- Name: COLUMN master_matakuliah.sks_praktek_lapangan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_matakuliah.sks_praktek_lapangan IS 'SKS Praktek Lapangan';


--
-- TOC entry 4166 (class 0 OID 0)
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
-- TOC entry 4167 (class 0 OID 0)
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
-- TOC entry 4168 (class 0 OID 0)
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
-- TOC entry 4169 (class 0 OID 0)
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
-- TOC entry 4170 (class 0 OID 0)
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
-- TOC entry 4171 (class 0 OID 0)
-- Dependencies: 260
-- Name: TABLE master_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.master_prodi IS 'GetProdi\n{\n            "id_prodi": "b1a89424-45fe-4b10-9ba3-113636e09f5e",\n            "kode_program_studi": "15901",\n            "nama_program_studi": "Pendidikan Profesi Bidan",\n            "status": "A",\n            "id_jenjang_pendidikan": "31",\n            "nama_jenjang_pendidikan": "Profesi"\n        }';


--
-- TOC entry 4172 (class 0 OID 0)
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
-- TOC entry 4173 (class 0 OID 0)
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
-- TOC entry 4174 (class 0 OID 0)
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
-- TOC entry 4175 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.id_semester IS 'id semester\n20201';


--
-- TOC entry 4176 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.tahun_mulai; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.tahun_mulai IS 'Tahun Mulai\n2020';


--
-- TOC entry 4177 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik."tahun selesai"; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik."tahun selesai" IS 'Tahun selesai\n2021';


--
-- TOC entry 4178 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.nama_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.nama_semester IS 'Nama Semester\n2020/2021 Ganjil';


--
-- TOC entry 4179 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.tgl_create; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.tgl_create IS 'Tanggal dibuat';


--
-- TOC entry 4180 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.tgl_update; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.tgl_update IS 'tgl Update';


--
-- TOC entry 4181 (class 0 OID 0)
-- Dependencies: 248
-- Name: COLUMN master_tahun_akademik.smt; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.master_tahun_akademik.smt IS 'semester \n1 /2';


--
-- TOC entry 4182 (class 0 OID 0)
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
-- TOC entry 4183 (class 0 OID 0)
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
-- TOC entry 4184 (class 0 OID 0)
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
-- TOC entry 4185 (class 0 OID 0)
-- Dependencies: 235
-- Name: TABLE matakuliah_krs_ditawarkan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_krs_ditawarkan IS 'matakuliah krs ditawarkan';


--
-- TOC entry 4186 (class 0 OID 0)
-- Dependencies: 235
-- Name: COLUMN matakuliah_krs_ditawarkan.id_semester_angkatan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_krs_ditawarkan.id_semester_angkatan IS 'id angkatan mahasiswa berlaku';


--
-- TOC entry 4187 (class 0 OID 0)
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
-- TOC entry 4188 (class 0 OID 0)
-- Dependencies: 238
-- Name: TABLE matakuliah_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_kurikulum IS 'Matakuliah Kurikulum';


--
-- TOC entry 4189 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.id_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.id_kurikulum IS 'ID Kurikulum SP. Web Service: GetListKurikulum';


--
-- TOC entry 4190 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.nama_kurikulum; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.nama_kurikulum IS 'Nama Matakuliah Kurikulum';


--
-- TOC entry 4191 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.id_matkul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.id_matkul IS 'Web Service: GetListMataKuliah';


--
-- TOC entry 4192 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.nama_matkul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.nama_matkul IS 'Nama Matakuliah';


--
-- TOC entry 4193 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.semester IS 'semester matakuliah (1,2,3...8)';


--
-- TOC entry 4194 (class 0 OID 0)
-- Dependencies: 238
-- Name: COLUMN matakuliah_kurikulum.id_semester; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_kurikulum.id_semester IS 'id semester angkatan berlaku';


--
-- TOC entry 4195 (class 0 OID 0)
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
-- TOC entry 4196 (class 0 OID 0)
-- Dependencies: 236
-- Name: TABLE matakuliah_remidi_ditawarkan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_remidi_ditawarkan IS 'matakuliah  remidi  ditawarkan';


--
-- TOC entry 4197 (class 0 OID 0)
-- Dependencies: 236
-- Name: COLUMN matakuliah_remidi_ditawarkan.id_semester_angkatan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_remidi_ditawarkan.id_semester_angkatan IS 'id angkatan mahasiswa berlaku';


--
-- TOC entry 4198 (class 0 OID 0)
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
-- TOC entry 4199 (class 0 OID 0)
-- Dependencies: 237
-- Name: TABLE matakuliah_rencana_remidi_ditawarkan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.matakuliah_rencana_remidi_ditawarkan IS 'matakuliah rencana remidi  ditawarkan';


--
-- TOC entry 4200 (class 0 OID 0)
-- Dependencies: 237
-- Name: COLUMN matakuliah_rencana_remidi_ditawarkan.id_semester_angkatan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.matakuliah_rencana_remidi_ditawarkan.id_semester_angkatan IS 'id angkatan mahasiswa berlaku';


--
-- TOC entry 4201 (class 0 OID 0)
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
-- TOC entry 4202 (class 0 OID 0)
-- Dependencies: 239
-- Name: TABLE nilai; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.nilai IS 'nilai mentah';


--
-- TOC entry 4203 (class 0 OID 0)
-- Dependencies: 239
-- Name: COLUMN nilai.stat_nilai; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.nilai.stat_nilai IS '1 : reguler\n2 : remidi';


--
-- TOC entry 4204 (class 0 OID 0)
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
-- TOC entry 4205 (class 0 OID 0)
-- Dependencies: 240
-- Name: TABLE parameter_absensi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.parameter_absensi IS 'parameter penilaian';


--
-- TOC entry 4206 (class 0 OID 0)
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
-- TOC entry 4207 (class 0 OID 0)
-- Dependencies: 241
-- Name: TABLE parameter_penilaian; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.parameter_penilaian IS 'parameter penilaian';


--
-- TOC entry 4208 (class 0 OID 0)
-- Dependencies: 241
-- Name: COLUMN parameter_penilaian.fungsi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.parameter_penilaian.fungsi IS 'max\nsum\navg';


--
-- TOC entry 4209 (class 0 OID 0)
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
-- TOC entry 4210 (class 0 OID 0)
-- Dependencies: 249
-- Name: TABLE periode_perkuliahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON TABLE siakad.periode_perkuliahan IS 'Periode Perkuliahan Program Studi';


--
-- TOC entry 4211 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.id_periode_perkuliahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.id_periode_perkuliahan IS 'uuid';


--
-- TOC entry 4212 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.id_prodi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.id_prodi IS 'id Program studi';


--
-- TOC entry 4213 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.nama_program_studi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.nama_program_studi IS 'Nama Program Studi';


--
-- TOC entry 4214 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.jumlah_target_mahasiswa_baru; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.jumlah_target_mahasiswa_baru IS 'Target Mahasiswa Baru';


--
-- TOC entry 4215 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.tanggal_awal_perkuliahan; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.tanggal_awal_perkuliahan IS 'Tanggal Dimulai Semester';


--
-- TOC entry 4216 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.calon_ikut_seleksi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.calon_ikut_seleksi IS 'calon maba';


--
-- TOC entry 4217 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.calon_lulus_seleksi; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.calon_lulus_seleksi IS 'calon lulus seleksi';


--
-- TOC entry 4218 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.daftar_sbg_mhs; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.daftar_sbg_mhs IS 'daftar registrasi';


--
-- TOC entry 4219 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.pst_undur_diri; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.pst_undur_diri IS 'mahasiswa mengundurkan diri';


--
-- TOC entry 4220 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.jml_mgu_kul; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.jml_mgu_kul IS 'Jumlah minggu kuliah';


--
-- TOC entry 4221 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.tgl_create; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.tgl_create IS 'Tanggal Insert';


--
-- TOC entry 4222 (class 0 OID 0)
-- Dependencies: 249
-- Name: COLUMN periode_perkuliahan.last_update; Type: COMMENT; Schema: siakad; Owner: -
--

COMMENT ON COLUMN siakad.periode_perkuliahan.last_update IS 'tgl update';


--
-- TOC entry 4223 (class 0 OID 0)
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
-- TOC entry 4224 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN mahasiswa_skripsi.id_semester; Type: COMMENT; Schema: skripsi; Owner: -
--

COMMENT ON COLUMN skripsi.mahasiswa_skripsi.id_semester IS 'id_semester daftar';


--
-- TOC entry 4225 (class 0 OID 0)
-- Dependencies: 246
-- Name: COLUMN mahasiswa_skripsi.status; Type: COMMENT; Schema: skripsi; Owner: -
--

COMMENT ON COLUMN skripsi.mahasiswa_skripsi.status IS '1 = aktif\n0 = tidak aktif';


--
-- TOC entry 4226 (class 0 OID 0)
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
-- TOC entry 4227 (class 0 OID 0)
-- Dependencies: 247
-- Name: COLUMN pembimbing_mahasiswa.id_kategori_kegiatan; Type: COMMENT; Schema: skripsi; Owner: -
--

COMMENT ON COLUMN skripsi.pembimbing_mahasiswa.id_kategori_kegiatan IS 'Web Service: GetKategoriKegiatan';


--
-- TOC entry 3987 (class 0 OID 24728)
-- Dependencies: 213
-- Data for Name: master_dosen_wali; Type: TABLE DATA; Schema: perwalian; Owner: -
--

COPY perwalian.master_dosen_wali (id_master_dosen_wali, id_prodi, nama_program_studi, id_semester, id_dosen, id_registrasi_mahasiswa, nama_mahasiswa, nim) FROM stdin;
\.


--
-- TOC entry 3988 (class 0 OID 24733)
-- Dependencies: 214
-- Data for Name: penguji_mahasiswa; Type: TABLE DATA; Schema: perwalian; Owner: -
--

COPY perwalian.penguji_mahasiswa (id_penguji_mahasiswa, id_mahasiswa_skripsi, id_kategori_kegiatan, id_dosen, penguji_ke) FROM stdin;
\.


--
-- TOC entry 3989 (class 0 OID 24736)
-- Dependencies: 215
-- Data for Name: pesan_perwalian; Type: TABLE DATA; Schema: perwalian; Owner: -
--

COPY perwalian.pesan_perwalian (id_pesan_perwalian, id_tran_perwalian, id_dosen, id_registrasi_mahasiswa, pesan, tgl_pesan) FROM stdin;
\.


--
-- TOC entry 3990 (class 0 OID 24742)
-- Dependencies: 216
-- Data for Name: tran_perwalian; Type: TABLE DATA; Schema: perwalian; Owner: -
--

COPY perwalian.tran_perwalian (id_tran_perwalian, id_prodi, nama_program_studi, id_semester, id_waktu_perwalian, tgl_bimbingan, pertemuan) FROM stdin;
\.


--
-- TOC entry 3991 (class 0 OID 24748)
-- Dependencies: 217
-- Data for Name: waktu_perwalian; Type: TABLE DATA; Schema: perwalian; Owner: -
--

COPY perwalian.waktu_perwalian (id_waktu_perwalian, nama_perwalian, id_prodi, nama_program_studi, id_semester, tgl_mulai, tgl_selesai, pertemuan) FROM stdin;
\.


--
-- TOC entry 3992 (class 0 OID 24753)
-- Dependencies: 218
-- Data for Name: absensi_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.absensi_perkuliahan (id_absensi_perkuliahan, id_prodi, nama_program_studi, id_semester, id_master_kegiatan_perkuliahan, tgl_absensi_mulai, tgl_absensi_selesai, nama_absensi) FROM stdin;
\.


--
-- TOC entry 3993 (class 0 OID 24758)
-- Dependencies: 219
-- Data for Name: aktivitas_perkuliahan_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.aktivitas_perkuliahan_mahasiswa (id_aktivitas_perkuliahan_mahasiswa, id_prodi, nama_program_studi, id_semester, id_status_mahasiswa, ips, ipk) FROM stdin;
\.


--
-- TOC entry 3994 (class 0 OID 24763)
-- Dependencies: 220
-- Data for Name: biodata_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.biodata_mahasiswa (id_mahasiswa, nama_mahasiswa, jenis_kelamin, tempat_lahir, tanggal_lahir, id_agama, nama_agama, nik, nisn, npwp, id_negara, kewarganegaraan, jalan, dusun, rt, rw, kelurahan, kode_pos, id_wilayah, nama_jenis_tinggal, id_alat_transportasi, nama_alat_transportasi, telepon, handphone, email, penerima_kps, nik_ayah, nama_ayah, tanggal_lahir_ayah, id_pendidikan_ayah, nama_pendidikan_ayah, id_pekerjaan_ayah, nama_pekerjaan_ayah, id_penghasilan_ayah, nama_penghasilan_ayah, nik_ibu, nama_ibu_kandung, tanggal_lahir_ibu, id_pendidikan_ibu, nama_pendidikan_ibu, id_pekerjaan_ibu, nama_pekerjaan_ibu, id_penghasilan_ibu, nama_penghasilan_ibu, nama_wali, tanggal_lahir_wali, id_pekerjaan_wali, nama_pekerjaan_wali, id_penghasilan_wali, nama_penghasilan_wali, id_kebutuhan_khusus_mahasiswa, nama_kebutuhan_khusus_mahasiswa, id_kebutuhan_khusus_ayah, nama_kebutuhan_khusus_ayah, id_kebutuhan_khusus_ibu, nama_kebutuhan_khusus_ibu, id_jenis_tinggal, id_pendidikan_wali, nama_pendidikan_wali, nama_wilayah) FROM stdin;
1d77cdf6-db16-48a7-96cb-d43302b9a643	Dhanang Hadiyanto2	L	Kendal	1990-12-22	2	Islam	332407211290002 	12345678	12345678	ID	Indonesia	Jl. Raya Tulang Bawang	Teseh	1	4	Meteseh	51381	032407	Rumah Sendiri	14	Mobil Pribadi	08985576111	08985576111	dhanang.hadiyanto2@gmail.com	0	123456	Jumadi	2023-09-11	37	Sp-2	15	Magang	15	Rp. 5,000,000 - Rp. 20,000,000	1233456	Tukiyem	2023-09-11	8	Paket B	15	Magang	16	Rp. 5,000,000 - Rp. 20,000,000	\N	2023-11-09	16	Tenaga Pengajar / Instruktur / Fasiltator	15	Rp. 5,000,000 - Rp. 20,000,000	0	\N	0	\N	0	\N	10	9	Paket C	Kec. Boja - Kab. Kendal - Prov. Jawa Tengah
d7df5ffa-fd98-4941-8a68-9d8f18a80496	Dhanang Hadiyanto	L	Kendal	1990-12-21	1	Islam	332407211290002 	12345678	12345678	ID	Indonesia	Jl. Raya Tulang Bawang	Teseh	1	4	Meteseh	51381	032407	Rumah sendiri	14	Mobil pribadi	08985576111	08985576111	dhanang.hadiyanto@gmail.com	0	1234566	Jumadi	2023-09-11	37	Sp-2	15	Magang	15	Rp. 5,000,000 - Rp. 20,000,000	1233456	Tukiyem	2023-09-11	8	Paket B	15	Magang	16	Rp. 5,000,000 - Rp. 20,000,000	\N	2023-11-09	16	Tenaga Pengajar / Instruktur / Fasiltator	15	Rp. 5,000,000 - Rp. 20,000,000	0	\N	0	\N	0	\N	10	9	Paket C	Kec. Boja - Kab. Kendal - Prov. Jawa Tengah
\.


--
-- TOC entry 3996 (class 0 OID 24780)
-- Dependencies: 222
-- Data for Name: kurikulum; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.kurikulum (id_kurikulum, nama_kurikulum, id_prodi, id_semester, jumlah_sks_lulus, jumlah_sks_wajib, jumlah_sks_pilihan, id_tahun_akademik, nama_program_studi) FROM stdin;
4ef65db6-ee43-45d3-87e5-893e280179f1	Kurikulum farmasi 2021	7f44428f-8665-4909-bbbe-06ebcc1da17a	20231	4	2	2	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	Farmasi
\.


--
-- TOC entry 3997 (class 0 OID 24783)
-- Dependencies: 223
-- Data for Name: list_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.list_mahasiswa (id_registrasi_mahasiswa, id_mahasiswa, nama_mahasiswa, jenis_kelamin, tanggal_lahir, id_perguruan_tinggi, id_agama, nama_agama, id_prodi, nama_program_studi, id_status_mahasiswa, nama_status_mahasiswa, nim, id_periode_masuk, nama_periode_masuk, id_jenis_daftar, id_jalur_daftar, id_bidang_minat, sks_diakui, id_perguruan_tinggi_asal, id_prodi_asal, id_pembiayaan, biaya_masuk, tgl_keluar, no_ijazah, no_sk, jenis_keluar, periode_keluar, tgl_sk, ipk_lulus, id_tahun_akademik, tanggal_daftar, kode_pt, nama_perguruan_tinggi_asal, nama_prodi_asal, nama_lembaga_prodi_asal) FROM stdin;
d904c732-e350-4d00-aaae-15ba47214e02	d7df5ffa-fd98-4941-8a68-9d8f18a80496	Dhanang Hadiyanto                                                                                   	L	1990-12-21	\N	1	Islam	7f44428f-8665-4909-bbbe-06ebcc1da17a	Farmasi	A	Aktif	33102300001	20231	2023/2024 Gasal	1	4	\N	\N	\N	\N	1	50000.00	\N	\N	\N	\N	\N	\N	\N	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	2023-09-11	\N	\N	\N	\N
e7e8fafa-344b-4e35-a12a-92f205d399b8	1d77cdf6-db16-48a7-96cb-d43302b9a643	Dhanang Hadiyanto2                                                                                  	L	1990-12-22	\N	2	Islam	7f44428f-8665-4909-bbbe-06ebcc1da17a	Farmasi	A	Aktif	1234	20231	2023/2024 Gasal	2	4	\N	\N	51c0d938-50eb-4cc8-b9eb-253658a56e29	eaf78fd6-b3dc-4780-bcf7-481a61ef0cfc	2	1234.00	\N	\N	\N	\N	\N	\N	\N	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	2023-09-11	061002	UNIVERSITAS ISLAM SULTAN AGUNG	\N	\N
2bd8028c-21b7-4eda-8e18-f674a6ba57f4	d7df5ffa-fd98-4941-8a68-9d8f18a80496	Dhanang Hadiyanto                                                                                   	L	1990-12-21	\N	1	Islam	7f44428f-8665-4909-bbbe-06ebcc1da17a	Farmasi	A	Aktif	wdad	20231	2023/2024 Gasal	1	3	\N	\N	\N	\N	1	22.00	\N	\N	\N	\N	\N	\N	\N	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	2023-09-11	\N	\N	\N	\N
27477e4d-8df4-449d-beb6-974a43c9cf31	1d77cdf6-db16-48a7-96cb-d43302b9a643	Dhanang Hadiyanto2                                                                                  	L	1990-12-22	\N	2	Islam	7f44428f-8665-4909-bbbe-06ebcc1da17a	Farmasi	A	Aktif	12131	20231	2023/2024 Gasal	1	3	\N	\N	\N	\N	1	22.00	\N	\N	\N	\N	\N	\N	\N	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	2023-09-11	\N	\N	\N	\N
\.


--
-- TOC entry 3998 (class 0 OID 24789)
-- Dependencies: 224
-- Data for Name: lokasi_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.lokasi_perkuliahan (id_lokasi_perkuliahan, nama_lokasi_perkuliahan, no_telp, alamat, jenis_lokasi, pimpinan, id_prodi, nama_program_studi, status) FROM stdin;
\.


--
-- TOC entry 4041 (class 0 OID 33717)
-- Dependencies: 267
-- Data for Name: mahasiswa_angkatan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.mahasiswa_angkatan (id_mahasiswa_angkatan, id_registrasi_mahasiswa, tgl_insert, id_angkatan_mahasiswa) FROM stdin;
bdb5399b-e289-4b83-a178-b1099af6ac0d	e7e8fafa-344b-4e35-a12a-92f205d399b8	2023-09-16 15:06:01.594238	d57098b3-d806-4c27-a0f8-4d009080c1cc
6eb122e1-f292-4269-b55c-b4e173109139	27477e4d-8df4-449d-beb6-974a43c9cf31	2023-09-16 15:06:12.18409	d57098b3-d806-4c27-a0f8-4d009080c1cc
1ab2286a-ace5-41cd-b1ec-cd2e310187d8	2bd8028c-21b7-4eda-8e18-f674a6ba57f4	2023-09-16 15:06:12.18409	d57098b3-d806-4c27-a0f8-4d009080c1cc
\.


--
-- TOC entry 3999 (class 0 OID 24795)
-- Dependencies: 225
-- Data for Name: mahasiswa_krs; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.mahasiswa_krs (id_mahasiswa_krs, id_registrasi_mahasiswa, id_mahasiswa, id_prodi, id_matakuliah_krs_ditawarkan, nilai_angka, nilai_indeks, nilai_huruf, status_krs, approval, tgl_insert, validasi) FROM stdin;
\.


--
-- TOC entry 4000 (class 0 OID 24803)
-- Dependencies: 226
-- Data for Name: mahasiswa_kurikulum; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.mahasiswa_kurikulum (id_mahasiswa_kurikulum, id_kurikulum, nama_kurikulum, id_mahasiswa, nama_mahasiswa, nim, id_semester, id_registrasi_mahasiswa, id_prodi) FROM stdin;
\.


--
-- TOC entry 4001 (class 0 OID 24808)
-- Dependencies: 227
-- Data for Name: mahasiswa_remidi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.mahasiswa_remidi (id_mahasiswa_remidi, id_registrasi_mahasiswa, id_mahasiswa, id_prodi, id_matakuliah_remidi_ditawarkan, nilai_angka, approval, tgl_insert, validasi) FROM stdin;
\.


--
-- TOC entry 4002 (class 0 OID 24816)
-- Dependencies: 228
-- Data for Name: mahasiswa_rencana_remidi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.mahasiswa_rencana_remidi (id_mahasiswa_krs, id_registrasi_mahasiswa, id_mahasiswa, id_prodi, id_matakuliah_rencana_remidi_ditawarkan, nilai_angka, nilai_indeks, nilai_huruf, status_krs, approval, tgl_insert, validasi) FROM stdin;
\.


--
-- TOC entry 4024 (class 0 OID 25285)
-- Dependencies: 250
-- Data for Name: master_agama; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_agama (id_agama, nama_agama) FROM stdin;
1	Islam
2	Kristen
3	Katolik
4	Hindu
5	Budha
6	Khonghucu
9	Lainnya
\.


--
-- TOC entry 4035 (class 0 OID 32922)
-- Dependencies: 261
-- Data for Name: master_alat_transportasi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_alat_transportasi (id_alat_transportasi, nama_alat_transportasi) FROM stdin;
7	Andong/bendi/sado/dokar/delman/becak
11	Kuda
4	Mobil/bus antar jemput
8	Perahu penyeberangan/rakit/getek
13	Sepeda motor
1	Jalan kaki
99	Lainnya
14	Mobil pribadi
6	Ojek
5	Kereta api
12	Sepeda
3	Angkutan umum/bus/pete-pete
\.


--
-- TOC entry 4040 (class 0 OID 33697)
-- Dependencies: 266
-- Data for Name: master_angkatan_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_angkatan_mahasiswa (id_angkatan_mahasiswa, nama_angkatan_mahasiswa, id_kurikulum, id_tahun_akademik, id_semester, id_prodi, nama_program_studi) FROM stdin;
d57098b3-d806-4c27-a0f8-4d009080c1cc	Farmasi Angkatan 2022/2023 Gasal Beasiswa	4ef65db6-ee43-45d3-87e5-893e280179f1	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	20231	7f44428f-8665-4909-bbbe-06ebcc1da17a	Farmasi
\.


--
-- TOC entry 4025 (class 0 OID 25290)
-- Dependencies: 251
-- Data for Name: master_jalur_masuk; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_jalur_masuk (id_jalur_masuk, nama_jalur_masuk) FROM stdin;
4	Prestasi
3	Penelusuran Minat dan Kemampuan (PMDK)
12	Seleksi Mandiri
13	Ujian Masuk Bersama Lainnya
14	Seleksi Nasional Berdasarkan Tes (SNBT)
15	Seleksi Nasional Berdasarkan Prestasi (SNBP)
9	Program Internasional
11	Program Kerjasama Perusahaan/Institusi/Pemerintah
\.


--
-- TOC entry 4026 (class 0 OID 25295)
-- Dependencies: 252
-- Data for Name: master_jenis_keluar; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_jenis_keluar (id_jenis_keluar, jenis_keluar) FROM stdin;
\.


--
-- TOC entry 4039 (class 0 OID 33608)
-- Dependencies: 265
-- Data for Name: master_jenis_matakuliah; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_jenis_matakuliah (id_jenis_mata_kuliah, nama_jenis_mata_kuliah) FROM stdin;
A	Wajib
B	Pilihan
C	Wajib Peminatan
D	Pilihan Peminatan
S	Tugas akhir/Skripsi/Tesis/Disertasi
\.


--
-- TOC entry 4027 (class 0 OID 25300)
-- Dependencies: 253
-- Data for Name: master_jenis_perndaftaran; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_jenis_perndaftaran (id_jenis_daftar, nama_jenis_daftar, untuk_daftar_sekolah) FROM stdin;
1	Peserta didik baru	1
2	Pindahan	1
13	RPL Perolehan SKS	1
14	Pendidikan Non Gelar (Course)	1
15	Fast Track	1
16	RPL Transfer SKS	1
\.


--
-- TOC entry 4037 (class 0 OID 32932)
-- Dependencies: 263
-- Data for Name: master_jenis_prestasi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_jenis_prestasi (id_jenis_prestasi, nama_jenis_prestasi) FROM stdin;
\.


--
-- TOC entry 4028 (class 0 OID 25305)
-- Dependencies: 254
-- Data for Name: master_jenis_tinggal; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_jenis_tinggal (id_jenis_tinggal, nama_jenis_tinggal) FROM stdin;
5	Panti asuhan
1	Bersama orang tua
3	Kost
2	Wali
99	Lainnya
10	Rumah sendiri
4	Asrama
\.


--
-- TOC entry 4029 (class 0 OID 25310)
-- Dependencies: 255
-- Data for Name: master_jenjang_pendidikan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_jenjang_pendidikan (id_jenjang_didik, nama_jenjang_didik) FROM stdin;
8	Paket B
37	Sp-2
9	Paket C
30	S1
0	Tidak sekolah
5	SMP / sederajat
3	Putus SD
35	S2
32	Sp-1
1	PAUD
20	D1
4	SD / sederajat
91	Informal
31	Profesi
36	S2 Terapan
41	S3 Terapan
6	SMA / sederajat
40	S3
2	TK / sederajat
90	Non formal
7	Paket A
23	D4
22	D3
21	D2
99	Lainnya
\.


--
-- TOC entry 4003 (class 0 OID 24824)
-- Dependencies: 229
-- Data for Name: master_kegiatan_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_kegiatan_perkuliahan (id_master_kegiatan_perkuliahan, nama_kegiatan_perkuliahan, status_data) FROM stdin;
\.


--
-- TOC entry 4004 (class 0 OID 24828)
-- Dependencies: 230
-- Data for Name: master_kelas_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_kelas_mahasiswa (id_master_kelas_mahasiswa, nama_kelas, id_prodi, id_semester, nama_program_studi) FROM stdin;
\.


--
-- TOC entry 3995 (class 0 OID 24775)
-- Dependencies: 221
-- Data for Name: master_kode_pembayaran; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_kode_pembayaran (id_kode_pembayaran, kode_rekening, nama_rekening, id_prodi, status, nama_program_studi) FROM stdin;
4452f637-5d76-4cc7-818e-1654df64591f	21212	UKT2	7f44428f-8665-4909-bbbe-06ebcc1da17a	t	Farmasi
\.


--
-- TOC entry 4007 (class 0 OID 24843)
-- Dependencies: 233
-- Data for Name: master_matakuliah; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_matakuliah (id_matkul, kode_mata_kuliah, nama_mata_kuliah, id_prodi, nama_program_studi, id_jenis_mata_kuliah, id_kelompok_mata_kuliah, sks_mata_kuliah, sks_tatap_muka, sks_praktek, sks_praktek_lapangan, sks_simulasi, metode_kuliah, ada_sap, ada_silabus, ada_bahan_ajar, ada_acara_praktek, ada_diktat, tanggal_mulai_efektif, tanggal_akhir_efektif) FROM stdin;
d1842e2a-cd84-4ef4-8df8-1c897084a016	FF3210	Berfikir Kritis	7f44428f-8665-4909-bbbe-06ebcc1da17a	Farmasi	A	\N	6	2	1	2	1	SGD                                               	\N	\N	\N	\N	\N	2023-09-09	2023-09-09
\.


--
-- TOC entry 4005 (class 0 OID 24833)
-- Dependencies: 231
-- Data for Name: master_parameter_penilaian; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_parameter_penilaian (id_master_parameter_penilaian, id_prodi, nama_program_studi, id_semester, ">=a", ">=ab", ">=b", ">=bc", ">=c", ">=cd", ">=d", id_matkul, nama_mata_kuliah, id_matakuliah_krs_ditawarkan) FROM stdin;
\.


--
-- TOC entry 4033 (class 0 OID 25330)
-- Dependencies: 259
-- Data for Name: master_pekerjaan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_pekerjaan (id_pekerjaan, nama_pekerjaan) FROM stdin;
15	Magang
16	Tenaga Pengajar / Instruktur / Fasiltator
17	Pimpinan / Manajerial
8	Pedagang Besar
6	Karyawan Swasta
11	Buruh
10	Wirausaha
5	PNS/TNI/Polri
12	Pensiunan
4	Peternak
9	Wiraswasta
99	Lainnya
3	Petani
98	Sudah Meninggal
1	Tidak bekerja
7	Pedagang Kecil
2	Nelayan
13	Peneliti
14	Tim Ahli / Konsultan
\.


--
-- TOC entry 4036 (class 0 OID 32927)
-- Dependencies: 262
-- Data for Name: master_pembiayaan_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_pembiayaan_mahasiswa (id_pembiayaan, nama_pembiayaan) FROM stdin;
1	Mandiri
2	Beasiswa Tidak Penuh
3	Beasiswa Penuh
\.


--
-- TOC entry 4032 (class 0 OID 25325)
-- Dependencies: 258
-- Data for Name: master_penghasilan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_penghasilan (id_penghasilan, nama_penghasilan) FROM stdin;
15	Rp. 5,000,000 - Rp. 20,000,000
16	Lebih dari Rp. 20,000,000
11	Kurang dari Rp. 500,000
14	Rp. 2,000,000 - Rp. 4,999,999
13	Rp. 1,000,000 - Rp. 1,999,999
12	Rp. 500,000 - Rp. 999,999
\.


--
-- TOC entry 4034 (class 0 OID 32917)
-- Dependencies: 260
-- Data for Name: master_prodi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_prodi (id_prodi, kode_program_studi, nama_program_studi, status, id_jenjang_pendidikan, nama_jenjang_pendidikan) FROM stdin;
b1a89424-45fe-4b10-9ba3-113636e09f5e	15901	Pendidikan Profesi Bidan	A	31	Profesi
eaf78fd6-b3dc-4780-bcf7-481a61ef0cfc	15201	Kebidanan	A	30	S1
91e6c205-c8dd-4555-9071-f2eb9856d4a3	14901	Profesi Ners	A	31	Profesi
7245d7d3-24e1-47b1-81ed-b00ceee417a3	61001	Ilmu Manajemen	A	40	S3
b7c8a388-e759-42d1-81be-794771897eb8	61201	Manajemen	A	30	S1
1e7c42f3-329c-4b2a-897e-237f3b71211a	62201	Akuntansi	A	30	S1
b56b82e3-a855-4d33-b859-4ac924bb268c	88203	Pendidikan Bahasa Inggris	A	30	S1
6b4a6373-9b2d-4076-9c4f-ec5523f7c8a7	79202	Sastra Inggris	A	30	S1
d8944e43-cd59-4d3e-9139-3c4033ff54d2	56401	Teknik Komputer	H	22	D3
e860285e-8662-461f-8e60-45bf463794ce	20201	Teknik Elektro	A	30	S1
ac851abd-a0a9-41b7-af8e-32bf8e56670a	86208	Pendidikan Agama Islam	A	30	S1
04c985d0-b79c-4836-bb2b-6daf49ce1466	11901	Profesi Dokter	A	31	Profesi
7f44428f-8665-4909-bbbe-06ebcc1da17a	48201	Farmasi	A	30	S1
2d8307a4-2e34-4786-92d3-e331abe09850	86206	Pendidikan Guru Sekolah Dasar	A	30	S1
b682f5dc-17ac-4752-9318-35de86c73863	22201	Teknik Sipil	A	30	S1
b00984eb-cff3-4b18-9a24-4d074e5ec0fc	22101	Teknik Sipil	A	35	S2
7ac5afc4-b4f6-454f-8bc6-66ec1f7361aa	61101	Manajemen	A	35	S2
38d74acd-825b-4857-9bb1-2c55426467ea	12901	Dokter Gigi	A	31	Profesi
01b3a6a6-2233-407a-acaa-6e8ef4ba3eee	14401	Keperawatan	A	22	D3
268a0275-4da6-461b-ae02-8c11f3b70dc5	11201	Pendidikan Dokter	A	30	S1
8f1fb33b-de61-4e68-9206-1e5fd0727a86	22001	Teknik Sipil	A	40	S3
c6b7bda3-f56d-4fb4-ab4f-072363d289d5	55201	Teknik Informatika	A	30	S1
8cfae3ff-e54c-4c80-a957-bcf43c9d6c5f	20101	Teknik Elektro	A	35	S2
434c8c0d-9eea-4810-8d0d-16a0add5ba54	62401	Akuntansi	A	22	D3
7d6debd3-3851-433d-b90b-3c38bacf6cc5	26201	Teknik Industri	A	30	S1
c82260e9-c2f6-4bbe-97b2-e1b1b122fa77	14201	Ilmu Keperawatan	A	30	S1
072c1ff7-32d0-421d-a524-7cd57e9b34f8	61406	Manajemen Keuangan	H	22	D3
46d5326c-9218-47ff-b048-53fc5aa99ea2	86108	Pendidikan Agama Islam	A	35	S2
e578fe50-98c3-4061-b8bc-b0d31156e6f6	70201	Ilmu Komunikasi	A	30	S1
6d096671-cf3a-4361-bb60-a4a91f4e07d4	73201	Psikologi	A	30	S1
56239e7e-d909-4f74-ba71-ae80ebbfd975	48901	Pendidikan Profesi Apoteker	A	31	Profesi
ef4f4881-696d-4146-95ad-e3abd08bb547	74001	Ilmu Hukum	A	40	S3
2e3dde09-8156-4341-9fe4-d6cb30b52bce	12201	Pendidikan Dokter Gigi	A	30	S1
cffa17a7-232d-495e-9daf-a162eaf25283	25201	Teknik Lingkungan	H	30	S1
07bdcb4f-717e-4b94-aa32-639ac8d9c941	88201	Pendidikan Bahasa dan Sastra Indonesia	A	30	S1
159fae3f-a6e0-4124-95a5-7fd79de33962	74101	Ilmu Hukum	A	35	S2
31df5e30-e5ce-46c3-b951-5be56ce96133	11106	Biomedik	A	35	S2
b10f6020-0a11-4892-9004-f0e181d95216	74230	Hukum Keluarga (Ahwal Syakhshiyah)	A	30	S1
65147799-8978-4884-b382-217515ad9c65	74102	Kenotariatan	A	35	S2
a896b181-7216-4fdf-b812-1e70c96f3e77	62101	Akuntansi	A	35	S2
12f2b443-19e1-4f4c-a0ea-d9f57829a117	35201	Perencanaan Wilayah Dan Kota	A	30	S1
b7d62023-6678-4ca3-b2ea-7f9cd04e2251	84202	Pendidikan Matematika	A	30	S1
9b7c984f-6eb3-485c-92f8-30f2014a5079	15401	Kebidanan	H	22	D3
ac0a4ef7-3b42-4063-9742-dee709d2f249	74201	Ilmu Hukum	A	30	S1
f9c4e12c-361b-4909-9329-304c3583328b	80230	Sejarah dan Peradaban Islam	A	30	S1
1b56b523-40eb-438d-bec2-4a938bf81ca3	86906	Pendidikan Profesi Guru	A	31	Profesi
2fe3d6e3-0dd8-4cfb-bf5b-835b9f9a7962	12101	Ilmu Kedokteran Gigi	A	35	S2
\.


--
-- TOC entry 4031 (class 0 OID 25320)
-- Dependencies: 257
-- Data for Name: master_status_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_status_mahasiswa (id_status_mahasiswa, nama_status_mahasiswa) FROM stdin;
\.


--
-- TOC entry 4006 (class 0 OID 24838)
-- Dependencies: 232
-- Data for Name: master_tagihan_angkatan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_tagihan_angkatan (id_tagihan_angkatan, id_angkatan_mahasiswa, id_semester, id_kode_pembayaran, kode_rekening, nama_rekening, biaya, id_tahun_akademik, id_prodi, nama_program_studi) FROM stdin;
b534fda7-b147-4012-9aa2-cb6520774e26	d57098b3-d806-4c27-a0f8-4d009080c1cc	20231	4452f637-5d76-4cc7-818e-1654df64591f	21212	UKT2	200	\N	\N	Farmasi
\.


--
-- TOC entry 4022 (class 0 OID 25218)
-- Dependencies: 248
-- Data for Name: master_tahun_akademik; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_tahun_akademik (id_semester, tahun_mulai, "tahun selesai", nama_semester, tgl_create, tgl_update, smt, status, id_tahun_akademik) FROM stdin;
20231	2023	2024	2023/2024 Gasal	2023-09-03	2023-09-03	1	t	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e
\.


--
-- TOC entry 4030 (class 0 OID 25315)
-- Dependencies: 256
-- Data for Name: master_wilayah; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.master_wilayah (id_wilayah, id_level_wilayah, id_negara, nama_wilayah, id_induk_wilayah) FROM stdin;
010000	1	ID	Prov. D.K.I. Jakarta	000000
010100	2	ID	Kab. Kepulauan Seribu	010000
010101	3	ID	Kec. Kepulauan Seribu Selatan	010100
010102	3	ID	Kec. Kepulauan Seribu Utara	010100
016000	2	ID	Kota Jakarta Pusat	010000
016001	3	ID	Kec. Tanah Abang	016000
016002	3	ID	Kec. Menteng	016000
016003	3	ID	Kec. Senen	016000
016004	3	ID	Kec. Johar Baru	016000
016005	3	ID	Kec. Cempaka Putih	016000
016006	3	ID	Kec. Kemayoran	016000
016007	3	ID	Kec. Sawah Besar	016000
016008	3	ID	Kec. Gambir	016000
016100	2	ID	Kota Jakarta Utara	010000
016101	3	ID	Kec. Penjaringan	016100
016102	3	ID	Kec. Pademangan	016100
016103	3	ID	Kec. Tanjung Priok	016100
016104	3	ID	Kec. Koja	016100
016105	3	ID	Kec. Kelapa Gading	016100
016106	3	ID	Kec. Cilincing	016100
016200	2	ID	Kota Jakarta Barat	010000
016201	3	ID	Kec. Kembangan	016200
016202	3	ID	Kec. Kebon Jeruk	016200
016203	3	ID	Kec. Palmerah	016200
016204	3	ID	Kec. Grogol Petamburan	016200
016205	3	ID	Kec. Tambora	016200
016206	3	ID	Kec. Taman Sari	016200
016207	3	ID	Kec. Cengkareng	016200
016208	3	ID	Kec. Kali Deres	016200
016300	2	ID	Kota Jakarta Selatan	010000
016301	3	ID	Kec. Jagakarsa	016300
016302	3	ID	Kec. Pasar Minggu	016300
016303	3	ID	Kec. Cilandak	016300
016304	3	ID	Kec. Pesanggrahan	016300
016305	3	ID	Kec. Kebayoran Lama	016300
016306	3	ID	Kec. Kebayoran Baru	016300
016307	3	ID	Kec. Mampang Prapatan	016300
016308	3	ID	Kec. Pancoran	016300
016309	3	ID	Kec. Tebet	016300
016310	3	ID	Kec. Setia Budi	016300
016400	2	ID	Kota Jakarta Timur	010000
016401	3	ID	Kec. Pasar Rebo	016400
016402	3	ID	Kec. Ciracas	016400
016403	3	ID	Kec. Cipayung	016400
016404	3	ID	Kec. Makasar	016400
016405	3	ID	Kec. Kramat Jati	016400
016406	3	ID	Kec. Jatinegara	016400
016407	3	ID	Kec. Duren Sawit	016400
016408	3	ID	Kec. Cakung	016400
016409	3	ID	Kec. Pulo Gadung	016400
016410	3	ID	Kec. Matraman	016400
020000	1	ID	Prov. Jawa Barat	000000
020500	2	ID	Kab. Bogor	020000
020501	3	ID	Kec. Nanggung	020500
020502	3	ID	Kec. Leuwiliang	020500
020503	3	ID	Kec. Pamijahan	020500
020504	3	ID	Kec. Cibungbulang	020500
020505	3	ID	Kec. Ciampea	020500
020506	3	ID	Kec. Dramaga	020500
020507	3	ID	Kec. Ciomas	020500
020508	3	ID	Kec. Cijeruk	020500
020509	3	ID	Kec. Caringin	020500
020510	3	ID	Kec. Ciawi	020500
020511	3	ID	Kec. Cisarua	020500
020512	3	ID	Kec. Megamendung	020500
020513	3	ID	Kec. Sukaraja	020500
020514	3	ID	Kec. Babakan Madang	020500
020515	3	ID	Kec. Sukamakmur	020500
020516	3	ID	Kec. Cariu	020500
020517	3	ID	Kec. Jonggol	020500
020518	3	ID	Kec. Cileungsi	020500
020519	3	ID	Kec. Gunungputri	020500
020520	3	ID	Kec. Citeureup	020500
020521	3	ID	Kec. Cibinong	020500
020522	3	ID	Kec. Bojong Gede	020500
020523	3	ID	Kec. Kemang	020500
020524	3	ID	Kec. Parung	020500
020525	3	ID	Kec. Gunung Sindur	020500
020526	3	ID	Kec. Rumpin	020500
020527	3	ID	Kec. Cigudeg	020500
020528	3	ID	Kec. Jasinga	020500
020529	3	ID	Kec. Tenjo	020500
020530	3	ID	Kec. Parungpanjang	020500
020531	3	ID	Kec. Tamansari	020500
020532	3	ID	Kec. Ciseeng	020500
020533	3	ID	Kec. Kelapa Nunggal	020500
020534	3	ID	Kec. Sukajaya	020500
020535	3	ID	Kec. Ranca Bungur	020500
020536	3	ID	Kec. Tanjung Sari	020500
020537	3	ID	Kec. Tajurhalang	020500
020538	3	ID	Kec. Cigombong	020500
020539	3	ID	Kec. Leuwisadeng	020500
020540	3	ID	Kec. Tenjolaya	020500
020600	2	ID	Kab. Sukabumi	020000
020601	3	ID	Kec. Ciemas	020600
020602	3	ID	Kec. Ciracap	020600
020603	3	ID	Kec. Surade	020600
020604	3	ID	Kec. Jampang Kulon	020600
020605	3	ID	Kec. Kalibunder	020600
020606	3	ID	Kec. Tegalbuleud	020600
020607	3	ID	Kec. Cidolog	020600
020608	3	ID	Kec. Sagaranten	020600
020609	3	ID	Kec. Pabuaran	020600
020610	3	ID	Kec. Lengkong	020600
020611	3	ID	Kec. Pelabuhan Ratu	020600
020612	3	ID	Kec. Warung Kiara	020600
020613	3	ID	Kec. Jampang Tengah	020600
020614	3	ID	Kec. Cikembar	020600
020615	3	ID	Kec. Nyalindung	020600
020616	3	ID	Kec. Gegerbitung	020600
020617	3	ID	Kec. Sukaraja	020600
020618	3	ID	Kec. Sukabumi	020600
020619	3	ID	Kec. Kadudampit	020600
020620	3	ID	Kec. Cisaat	020600
020621	3	ID	Kec. Cibadak	020600
020622	3	ID	Kec. Nagrak	020600
020623	3	ID	Kec. Cicurug	020600
020624	3	ID	Kec. Cidahu	020600
020625	3	ID	Kec. Parakansalak	020600
020626	3	ID	Kec. Parungkuda	020600
020627	3	ID	Kec. Kalapa Nunggal	020600
020628	3	ID	Kec. Cikidang	020600
020629	3	ID	Kec. Cisolok	020600
020630	3	ID	Kec. Kabandungan	020600
020631	3	ID	Kec. Gunung Guruh	020600
020632	3	ID	Kec. Cikakak	020600
020633	3	ID	Kec. Bantar Gadung	020600
020634	3	ID	Kec. Cicantayan	020600
020635	3	ID	Kec. Simpenan	020600
020636	3	ID	Kec. Kebon Pedes	020600
020637	3	ID	Kec. Cidadap	020600
020638	3	ID	Kec. Cibitung	020600
020639	3	ID	Kec. Curugkembar	020600
020640	3	ID	Kec. Purabaya	020600
020641	3	ID	Kec. Cireunghas	020600
020642	3	ID	Kec. Sukalarang	020600
020643	3	ID	Kec. Caringin	020600
020644	3	ID	Kec. Bojong Genteng	020600
020645	3	ID	Kec. Waluran	020600
020646	3	ID	Kec. Cimanggu	020600
020647	3	ID	Kec. Ciambar	020600
020700	2	ID	Kab. Cianjur	020000
020701	3	ID	Kec. Agrabinta	020700
020702	3	ID	Kec. Sindang Barang	020700
020703	3	ID	Kec. Cidaun	020700
020704	3	ID	Kec. Naringgul	020700
020705	3	ID	Kec. Cibinong	020700
020706	3	ID	Kec. Tanggeung	020700
020707	3	ID	Kec. Kadupandak	020700
020708	3	ID	Kec. Takokak	020700
020709	3	ID	Kec. Sukanagara	020700
020710	3	ID	Kec. Pagelaran	020700
020711	3	ID	Kec. Campaka	020700
020712	3	ID	Kec. Cibeber	020700
020713	3	ID	Kec. Warungkondang	020700
020714	3	ID	Kec. Cilaku	020700
020715	3	ID	Kec. Sukaluyu	020700
020717	3	ID	Kec. Ciranjang	020700
020718	3	ID	Kec. Mande	020700
020719	3	ID	Kec. Karang Tengah	020700
020720	3	ID	Kec. Cianjur	020700
020721	3	ID	Kec. Cugenang	020700
020722	3	ID	Kec. Pacet	020700
020723	3	ID	Kec. Sukaresmi	020700
020724	3	ID	Kec. Cikalong Kulon	020700
020725	3	ID	Kec. Bojong Picung	020700
020726	3	ID	Kec. Campaka Mulya	020700
020727	3	ID	Kec. Cikadu	020700
020728	3	ID	Kec. Leles	020700
020729	3	ID	Kec. Cijati	020700
020730	3	ID	Kec. Gekbrong	020700
020731	3	ID	Kec. Cipanas	020700
020732	3	ID	Kec. Haurwangi	020700
020733	3	ID	Kec. Pasirkuda	020700
020800	2	ID	Kab. Bandung	020000
020801	3	ID	Kec. Ciwidey	020800
020802	3	ID	Kec. Pasirjambu	020800
020803	3	ID	Kec. Cimaung	020800
020804	3	ID	Kec. Pangalengan	020800
020805	3	ID	Kec. Kertasari	020800
020806	3	ID	Kec. Pacet	020800
020807	3	ID	Kec. Ibun	020800
020808	3	ID	Kec. Paseh	020800
020809	3	ID	Kec. Cikancung	020800
020810	3	ID	Kec. Cicalengka	020800
020811	3	ID	Kec. Rancaekek	020800
020812	3	ID	Kec. Majalaya	020800
020813	3	ID	Kec. Ciparay	020800
020814	3	ID	Kec. Bale Endah	020800
020815	3	ID	Kec. Arjasari	020800
020816	3	ID	Kec. Banjaran	020800
020817	3	ID	Kec. Pameungpeuk	020800
020818	3	ID	Kec. Ketapang	020800
020819	3	ID	Kec. Soreang	020800
020820	3	ID	Kec. Marga Asih	020800
020821	3	ID	Kec. Margahayu	020800
020822	3	ID	Kec. Dayeuhkolot	020800
020823	3	ID	Kec. Bojongsoang	020800
020824	3	ID	Kec. Cileunyi	020800
020825	3	ID	Kec. Cilengkrang	020800
020826	3	ID	Kec. Cimenyan	020800
020829	3	ID	Kec. Rancabali	020800
020830	3	ID	Kec. Nagreg	020800
020831	3	ID	Kec. Solokan Jeruk	020800
020832	3	ID	Kec. Cangkuang	020800
020833	3	ID	Kec. Kutawaringin	020800
021000	2	ID	Kab. Sumedang	020000
021001	3	ID	Kec. Jatinangor	021000
021002	3	ID	Kec. Cimanggung	021000
021003	3	ID	Kec. Tanjungsari	021000
021004	3	ID	Kec. Rancakalong	021000
021005	3	ID	Kec. Sumedang Selatan	021000
021006	3	ID	Kec. Sumedang Utara	021000
021007	3	ID	Kec. Situraja	021000
021008	3	ID	Kec. Darmaraja	021000
021009	3	ID	Kec. Cibugel	021000
021010	3	ID	Kec. Wado	021000
021012	3	ID	Kec. Tomo	021000
021013	3	ID	Kec. Ujung Jaya	021000
021014	3	ID	Kec. Conggeang	021000
021015	3	ID	Kec. Paseh	021000
021016	3	ID	Kec. Cimalaka	021000
021017	3	ID	Kec. Tanjungkerta	021000
021018	3	ID	Kec. Buah Dua	021000
021019	3	ID	Kec. Ganeas	021000
021020	3	ID	Kec. Jati Gede	021000
021023	3	ID	Kec. Pamulihan	021000
021024	3	ID	Kec. Cisitu	021000
021025	3	ID	Kec. Jatinunggal	021000
021026	3	ID	Kec. Cisarua	021000
021027	3	ID	Kec. Tanjungmedar	021000
021028	3	ID	Kec. Surian	021000
021029	3	ID	Kec. Sukasari	021000
021100	2	ID	Kab. Garut	020000
021101	3	ID	Kec. Talegong	021100
021102	3	ID	Kec. Cisewu	021100
021103	3	ID	Kec. Bungbulang	021100
021104	3	ID	Kec. Pamulihan	021100
021105	3	ID	Kec. Pakenjeng	021100
021106	3	ID	Kec. Cikelet	021100
021107	3	ID	Kec. Pameungpeuk	021100
021108	3	ID	Kec. Cibalong	021100
021109	3	ID	Kec. Cisompet	021100
021110	3	ID	Kec. Peundeuy	021100
021111	3	ID	Kec. Singajaya	021100
021112	3	ID	Kec. Cikajang	021100
021113	3	ID	Kec. Banjarwangi	021100
021114	3	ID	Kec. Cilawu	021100
021115	3	ID	Kec. Bayongbong	021100
021116	3	ID	Kec. Cisurupan	021100
021117	3	ID	Kec. Samarang	021100
021119	3	ID	Kec. Garut Kota	021100
021120	3	ID	Kec. Karangpawitan	021100
021121	3	ID	Kec. Wanaraja	021100
021122	3	ID	Kec. Sukawening	021100
021123	3	ID	Kec. Banyuresmi	021100
021124	3	ID	Kec. Leles	021100
021125	3	ID	Kec. Leuwigoong	021100
021126	3	ID	Kec. Cibatu	021100
021127	3	ID	Kec. Cibiuk	021100
021128	3	ID	Kec. Kadungora	021100
021129	3	ID	Kec. Blubur Limbangan	021100
021130	3	ID	Kec. Selaawi	021100
021131	3	ID	Kec. Malangbong	021100
021132	3	ID	Kec. Mekarmukti	021100
021133	3	ID	Kec. Caringin	021100
021134	3	ID	Kec. Cihurip	021100
021135	3	ID	Kec. Sukaresmi	021100
021136	3	ID	Kec. Pasirwangi	021100
021137	3	ID	Kec. Karangtengah	021100
021138	3	ID	Kec. Kersamanah	021100
021139	3	ID	Kec. Tarogong Kaler	021100
021140	3	ID	Kec. Tarogong Kidul	021100
021141	3	ID	Kec. Cigedug	021100
021142	3	ID	Kec. Sucinaraja	021100
021143	3	ID	Kec. Pangatikan	021100
021200	2	ID	Kab. Tasikmalaya	020000
021201	3	ID	Kec. Cipatujah	021200
021202	3	ID	Kec. Karangnunggal	021200
021203	3	ID	Kec. Cikalong	021200
021204	3	ID	Kec. Panca Tengah	021200
021205	3	ID	Kec. Cikatomas	021200
021206	3	ID	Kec. Cibalong	021200
021207	3	ID	Kec. Bantarkalong	021200
021208	3	ID	Kec. Bojong Gambir	021200
021209	3	ID	Kec. Sodonghilir	021200
021210	3	ID	Kec. Taraju	021200
021211	3	ID	Kec. Salawu	021200
021212	3	ID	Kec. Tanjungjaya	021200
021213	3	ID	Kec. Sukaraja	021200
021214	3	ID	Kec. Salopa	021200
021215	3	ID	Kec. Cineam	021200
021216	3	ID	Kec. Manonjaya	021200
021219	3	ID	Kec. Singaparna	021200
021220	3	ID	Kec. Cigalontang	021200
021221	3	ID	Kec. Leuwisari	021200
021223	3	ID	Kec. Cisayong	021200
021224	3	ID	Kec. Rajapolah	021200
021225	3	ID	Kec. Jamanis	021200
021226	3	ID	Kec. Ciawi	021200
021227	3	ID	Kec. Pagerageung	021200
021228	3	ID	Kec. Parung Ponteng	021200
021229	3	ID	Kec. Sariwangi	021200
021230	3	ID	Kec. Sukaratu	021200
021231	3	ID	Kec. Sukarame	021200
021232	3	ID	Kec. Bojong Asih	021200
021233	3	ID	Kec. Culamega	021200
021234	3	ID	Kec. Puspahiang	021200
021235	3	ID	Kec. Jatiwaras	021200
021236	3	ID	Kec. Mangunreja	021200
021237	3	ID	Kec. Gunung Tanjung	021200
021238	3	ID	Kec. Karang Jaya	021200
021239	3	ID	Kec. Pada Kembang	021200
021240	3	ID	Kec. Sukahening	021200
021241	3	ID	Kec. Kadipaten	021200
021242	3	ID	Kec. Sukaresik	021200
021400	2	ID	Kab. Ciamis	020000
021401	3	ID	Kec. Cimerak	021400
021402	3	ID	Kec. Cijulang	021400
021403	3	ID	Kec. Cigugur	021400
021404	3	ID	Kec. Langkaplancar	021400
021405	3	ID	Kec. Parigi	021400
021406	3	ID	Kec. Sidamulih	021400
021407	3	ID	Kec. Pangandaran	021400
021408	3	ID	Kec. Kalipucang	021400
021409	3	ID	Kec. Padaherang	021400
021410	3	ID	Kec. Banjarsari	021400
021411	3	ID	Kec. Lakbok	021400
021412	3	ID	Kec. Pamarican	021400
021413	3	ID	Kec. Cidolog	021400
021414	3	ID	Kec. Cimaragas	021400
021415	3	ID	Kec. Cijeungjing	021400
021416	3	ID	Kec. Cisaga	021400
021417	3	ID	Kec. Tambaksari	021400
021418	3	ID	Kec. Rancah	021400
021419	3	ID	Kec. Rajadesa	021400
021420	3	ID	Kec. Sukadana	021400
021421	3	ID	Kec. Ciamis	021400
021422	3	ID	Kec. Cikoneng	021400
021423	3	ID	Kec. Cihaurbeuti	021400
021424	3	ID	Kec. Sadananya	021400
021425	3	ID	Kec. Cipaku	021400
021426	3	ID	Kec. Jatinagara	021400
021427	3	ID	Kec. Panawangan	021400
021428	3	ID	Kec. Kawali	021400
021429	3	ID	Kec. Panjalu	021400
021430	3	ID	Kec. Panumbangan	021400
021431	3	ID	Kec. Panjalu Utara/Sukamantri	021400
021432	3	ID	Kec. Sindangkasih	021400
021433	3	ID	Kec. Purwadadi	021400
021434	3	ID	Kec. Baregbeg	021400
021435	3	ID	Kec. Lumbung	021400
021436	3	ID	Kec. Mangunjaya	021400
021437	3	ID	Sukamantri	      
021490	3	ID	Padaherang	      
021491	3	ID	Kalipucang	      
021492	3	ID	Pangandaran	      
021493	3	ID	Sidamulih	      
021494	3	ID	Parigi	      
021495	3	ID	Cimerak	      
021496	3	ID	Cigugur	      
021497	3	ID	Langkaplancar	      
021498	3	ID	Mangunjaya	      
021500	2	ID	Kab. Kuningan	020000
021501	3	ID	Kec. Darma	021500
021502	3	ID	Kec. Kadugede	021500
021503	3	ID	Kec. Ciniru	021500
021504	3	ID	Kec. Selajambe	021500
021505	3	ID	Kec. Subang	021500
021506	3	ID	Kec. Ciwaru	021500
021507	3	ID	Kec. Cibingbin	021500
021508	3	ID	Kec. Luragung	021500
021509	3	ID	Kec. Cidahu	021500
021510	3	ID	Kec. Ciawigebang	021500
021511	3	ID	Kec. Lebakwangi	021500
021512	3	ID	Kec. Garawangi	021500
021513	3	ID	Kec. Kuningan	021500
021514	3	ID	Kec. Cigugur	021500
021515	3	ID	Kec. Kramatmulya	021500
021516	3	ID	Kec. Jalaksana	021500
021517	3	ID	Kec. Cilimus	021500
021518	3	ID	Kec. Mandirancan	021500
021519	3	ID	Kec. Pasawahan	021500
021520	3	ID	Kec. Pancalang	021500
021521	3	ID	Kec. Cipicung	021500
021522	3	ID	Kec. Kalimanggis	021500
021523	3	ID	Kec. Japara	021500
021524	3	ID	Kec. Karangkancana	021500
021525	3	ID	Kec. Nusaherang	021500
021526	3	ID	Kec. Cilebak	021500
021527	3	ID	Kec. Hantara	021500
021528	3	ID	Kec. Cimahi	021500
021529	3	ID	Kec. Cibeureum	021500
021530	3	ID	Kec. Sindang Agung	021500
021531	3	ID	Kec. Maleber	021500
021532	3	ID	Kec. Ciganda Mekar	021500
021600	2	ID	Kab. Majalengka	020000
021601	3	ID	Kec. Lemahsugih	021600
021602	3	ID	Kec. Bantarujeg	021600
021603	3	ID	Kec. Cikijing	021600
021604	3	ID	Kec. Talaga	021600
021605	3	ID	Kec. Argapura	021600
021606	3	ID	Kec. Maja	021600
021607	3	ID	Kec. Majalengka	021600
021608	3	ID	Kec. Cigasong	021600
021609	3	ID	Kec. Sukahaji	021600
021610	3	ID	Kec. Rajagaluh	021600
021611	3	ID	Kec. Sindangwangi	021600
021612	3	ID	Kec. Leuwimunding	021600
021613	3	ID	Kec. Palasah	021600
021614	3	ID	Kec. Jatiwangi	021600
021615	3	ID	Kec. Dawuan	021600
021616	3	ID	Kec. Panyingkiran	021600
021617	3	ID	Kec. Kadipaten	021600
021618	3	ID	Kec. Kertajati	021600
021619	3	ID	Kec. Jatitujuh	021600
021620	3	ID	Kec. Ligung	021600
021621	3	ID	Kec. Sumberjaya	021600
021622	3	ID	Kec. Banjaran	021600
021623	3	ID	Kec. Cingambul	021600
021624	3	ID	Kec. Mala usma	021600
021625	3	ID	Kec. Sindang	021600
021626	3	ID	Kec. Kasokandel	021600
021700	2	ID	Kab. Cirebon	020000
021701	3	ID	Kec. Waled	021700
021702	3	ID	Kec. Ciledug	021700
021703	3	ID	Kec. Losari	021700
021704	3	ID	Kec. Babakan	021700
021705	3	ID	Kec. Karang Sembung	021700
021706	3	ID	Kec. Lemah Abang	021700
021707	3	ID	Kec. Sedong	021700
021708	3	ID	Kec. Astana Japura	021700
021709	3	ID	Kec. Mundu	021700
021710	3	ID	Kec. Beber	021700
021712	3	ID	Kec. Sumber	021700
021713	3	ID	Kec. Palimanan	021700
021714	3	ID	Kec. Plumbon	021700
021715	3	ID	Kec. Weru	021700
021718	3	ID	Kec. Kapetakan	021700
021719	3	ID	Kec. Klangenan	021700
021720	3	ID	Kec. Arjawinangun	021700
021721	3	ID	Kec. Ciwaringin	021700
021722	3	ID	Kec. Susukan	021700
021723	3	ID	Kec. Gegesik	021700
021724	3	ID	Kec. Susukan Lebak	021700
021725	3	ID	Kec. Pabedilan	021700
021726	3	ID	Kec. Dukupuntang	021700
021727	3	ID	Kec. Panguragan	021700
021728	3	ID	Kec. Kaliwedi	021700
021729	3	ID	Kec. Pangenan	021700
021730	3	ID	Kec. Gebang	021700
021731	3	ID	Kec. Depok	021700
021732	3	ID	Kec. Kedawung	021700
021733	3	ID	Kec. Karang Wereng	021700
021734	3	ID	Kec. Talun	021700
021735	3	ID	Kec. Gunung Jati	021700
021736	3	ID	Kec. Pasaleman	021700
021737	3	ID	Kec. Pabuaran	021700
021738	3	ID	Kec. Tengah Tani	021700
021739	3	ID	Kec. Plered	021700
021740	3	ID	Kec. Gempol	021700
021741	3	ID	Kec. Greged	021700
021742	3	ID	Kec. Suranenggala	021700
021743	3	ID	Kec. Jamblang	021700
021800	2	ID	Kab. Indramayu	020000
021801	3	ID	Kec. Haurgeulis	021800
021802	3	ID	Kec. Kroya	021800
021803	3	ID	Kec. Gabuswetan	021800
021804	3	ID	Kec. Cikedung	021800
021805	3	ID	Kec. Lelea	021800
021806	3	ID	Kec. Bangodua	021800
021807	3	ID	Kec. Widasari	021800
021808	3	ID	Kec. Kertasemaya	021800
021809	3	ID	Kec. Krangkeng	021800
021810	3	ID	Kec. Karangampel	021800
021811	3	ID	Kec. Juntinyuat	021800
021812	3	ID	Kec. Sliyeg	021800
021813	3	ID	Kec. Jatibarang	021800
021814	3	ID	Kec. Balongan	021800
021815	3	ID	Kec. Indramayu	021800
021816	3	ID	Kec. Sindang	021800
021817	3	ID	Kec. Lohbener	021800
021818	3	ID	Kec. Losarang	021800
021819	3	ID	Kec. Kandanghaur	021800
021820	3	ID	Kec. Bongas	021800
021821	3	ID	Kec. Anjatan	021800
021822	3	ID	Kec. Sukra	021800
021823	3	ID	Kec. Arahan	021800
021824	3	ID	Kec. Cantigi	021800
021825	3	ID	Kec. Gantar	021800
021826	3	ID	Kec. Terisi	021800
021827	3	ID	Kec. Sukagumiwang	021800
021828	3	ID	Kec. Kedokan Bunder	021800
021829	3	ID	Kec. Pasekan	021800
021830	3	ID	Kec. Tukdana	021800
021831	3	ID	Kec. Patrol	021800
021900	2	ID	Kab. Subang	020000
021901	3	ID	Kec. Sagalaherang	021900
021902	3	ID	Kec. Jalancagak	021900
021903	3	ID	Kec. Cisalak	021900
021904	3	ID	Kec. Tanjung Siang	021900
021905	3	ID	Kec. Cijambe	021900
021906	3	ID	Kec. Cibogo	021900
021907	3	ID	Kec. Subang	021900
021908	3	ID	Kec. Kalijati	021900
021909	3	ID	Kec. Cipeundeuy	021900
021910	3	ID	Kec. Pabuaran	021900
021911	3	ID	Kec. Patokbeusi	021900
021912	3	ID	Kec. Purwadadi	021900
021913	3	ID	Kec. Cikaum	021900
021914	3	ID	Kec. Pagaden	021900
021915	3	ID	Kec. Cipunagara	021900
021916	3	ID	Kec. Compreng	021900
021917	3	ID	Kec. Binong	021900
021918	3	ID	Kec. Ciasem	021900
021919	3	ID	Kec. Pamanukan	021900
021920	3	ID	Kec. Pusakanagara	021900
021921	3	ID	Kec. Legon Kulon	021900
021922	3	ID	Kec. Blanakan	021900
021923	3	ID	Kec. Dawuan	021900
021924	3	ID	Kec. Serang Panjang	021900
021925	3	ID	Kec. Kasomalang	021900
021926	3	ID	Kec. Tambakdahan	021900
021927	3	ID	Kec. Pagaden Barat	021900
021928	3	ID	Kec. Pusakajaya	021900
021929	3	ID	Kec. Ciater	021900
021930	3	ID	Kec. Sukasari	021900
022000	2	ID	Kab. Purwakarta	020000
022001	3	ID	Kec. Jatiluhur	022000
022002	3	ID	Kec. Maniis	022000
022003	3	ID	Kec. Tegalwaru	022000
022004	3	ID	Kec. Plered	022000
022005	3	ID	Kec. Sukatani	022000
022006	3	ID	Kec. Darangdan	022000
022007	3	ID	Kec. Bojong	022000
022008	3	ID	Kec. Wanayasa	022000
022009	3	ID	Kec. Pasawahan	022000
022010	3	ID	Kec. Purwakarta	022000
022011	3	ID	Kec. Campaka	022000
022012	3	ID	Kec. Sukasari	022000
022013	3	ID	Kec. Kiarapedes	022000
022014	3	ID	Kec. Babakancikao	022000
022015	3	ID	Kec. Cibatu	022000
022016	3	ID	Kec. Bungursari	022000
022017	3	ID	Kec. Pondok Salam	022000
022100	2	ID	Kab. Karawang	020000
022101	3	ID	Kec. Pangkalan	022100
022102	3	ID	Kec. Ciampel	022100
022104	3	ID	Kec. Klari	022100
022105	3	ID	Kec. Cikampek	022100
022106	3	ID	Kec. Tirtamulya	022100
022107	3	ID	Kec. Jatisari	022100
022109	3	ID	Kec. Lemahabang	022100
022110	3	ID	Kec. Telagasari	022100
022111	3	ID	Kec. Karawang	022100
022112	3	ID	Kec. Rawamerta	022100
022113	3	ID	Kec. Tempuran	022100
022114	3	ID	Kec. Kutawaluya	022100
022115	3	ID	Kec. Rengasdengklok	022100
022116	3	ID	Kec. Pedes	022100
022117	3	ID	Kec. Cibuaya	022100
022118	3	ID	Kec. Tirtajaya	022100
022119	3	ID	Kec. Batujaya	022100
022120	3	ID	Kec. Pakisjaya	022100
022121	3	ID	Kec. Majalaya	022100
022122	3	ID	Kec. Jayakerta	022100
022123	3	ID	Kec. Cilamaya Kulon	022100
022124	3	ID	Kec. Banyusari	022100
022125	3	ID	Kec. Kotabaru	022100
022126	3	ID	Kec. Cilamaya Wetan	022100
022127	3	ID	Kec. Purwasari	022100
022128	3	ID	Kec. Teluk Jambe Barat	022100
022129	3	ID	Kec. Teluk Jambe Timur	022100
022130	3	ID	Kec. Karawang Timur	022100
022131	3	ID	Kec. Tegalwaru	022100
022132	3	ID	Kec. Cilebar	022100
022133	3	ID	Kec. Karawang Barat	022100
022200	2	ID	Kab. Bekasi	020000
022201	3	ID	Kec. Setu	022200
022203	3	ID	Kec. Cibarusah	022200
022205	3	ID	Kec. Kedung Waringin	022200
022207	3	ID	Kec. Cibitung	022200
022209	3	ID	Kec. Babelan	022200
022210	3	ID	Kec. Taruma Jaya	022200
022211	3	ID	Kec. Tembelang	022200
022212	3	ID	Kec. Sukatani	022200
022213	3	ID	Kec. Pebayuran	022200
022214	3	ID	Kec. Cabangbungin	022200
022215	3	ID	Kec. Muara Gembong	022200
022216	3	ID	Kec. Tambun Selatan	022200
022217	3	ID	Kec. Tambun Utara	022200
022218	3	ID	Kec. Cikarang Barat	022200
022219	3	ID	Kec. Karang Bahagia	022200
022220	3	ID	Kec. Cikarang Utara	022200
022221	3	ID	Kec. Cikarang Selatan	022200
022222	3	ID	Kec. Cikarang Timur	022200
022223	3	ID	Kec. Bojong Mangu	022200
022224	3	ID	Kec. Cikarang Pusat	022200
022225	3	ID	Kec. Sukakarya	022200
022226	3	ID	Kec. Sukawangi	022200
022227	3	ID	Kec. Serang Baru	022200
022300	2	ID	Kab. Bandung Barat	020000
022301	3	ID	Kec. Rongga	022300
022302	3	ID	Kec. Gununghalu	022300
022303	3	ID	Kec. Sindangkerta	022300
022304	3	ID	Kec. Cililin	022300
022305	3	ID	Kec. Cihampelas	022300
022306	3	ID	Kec. Cipongkor	022300
022307	3	ID	Kec. Batujajar	022300
022308	3	ID	Kec. Cipatat	022300
022309	3	ID	Kec. Padalarang	022300
022310	3	ID	Kec. Ngamprah	022300
022311	3	ID	Kec. Parongpong	022300
022312	3	ID	Kec. Lembang	022300
022313	3	ID	Kec. Cisarua	022300
022314	3	ID	Kec. Cikalong Wetan	022300
022315	3	ID	Kec. Cipeundeuy	022300
026000	2	ID	Kota Bandung	020000
026001	3	ID	Kec. Bandung Kulon	026000
026002	3	ID	Kec. Babakan Ciparay	026000
026003	3	ID	Kec. Bojong Loa Kaler	026000
026004	3	ID	Kec. Bojong Loa Kidul	026000
026005	3	ID	Kec. Astananyar	026000
026006	3	ID	Kec. Regol	026000
026007	3	ID	Kec. Lengkong	026000
026008	3	ID	Kec. Bandung Kidul	026000
026009	3	ID	Kec. Buah Batu	026000
026010	3	ID	Kec. Rancasari	026000
026011	3	ID	Kec. Cibiru	026000
026012	3	ID	Kec. Ujungberung	026000
026013	3	ID	Kec. Arcamanik	026000
026015	3	ID	Kec. Kiaracondong	026000
026016	3	ID	Kec. Batununggal	026000
026017	3	ID	Kec. Sumur Bandung	026000
026018	3	ID	Kec. Andir	026000
026019	3	ID	Kec. Cicendo	026000
026020	3	ID	Kec. Bandung Wetan	026000
026021	3	ID	Kec. Cibeunying Kidul	026000
026022	3	ID	Kec. Cibeunying Kaler	026000
026023	3	ID	Kec. Coblong	026000
026024	3	ID	Kec. Sukajadi	026000
026025	3	ID	Kec. Sukasari	026000
026026	3	ID	Kec. Cidadap	026000
026027	3	ID	Kec. Gedebage	026000
026028	3	ID	Kec. Panyileukan	026000
026029	3	ID	Kec. Cinambo	026000
026030	3	ID	Kec. Mandalajati	026000
026031	3	ID	Kec. Antapani	026000
026100	2	ID	Kota Bogor	020000
026101	3	ID	Kec. Kota Bogor Selatan	026100
026102	3	ID	Kec. Kota Bogor Timur	026100
026103	3	ID	Kec. Kota Bogor Utara	026100
026104	3	ID	Kec. Kota Bogor Tengah	026100
026105	3	ID	Kec. Kota Bogor Barat	026100
026106	3	ID	Kec. Tanah Sereal	026100
026200	2	ID	Kota Sukabumi	020000
026201	3	ID	Kec. Baros	026200
026202	3	ID	Kec. Citamiang	026200
026203	3	ID	Kec. Warudoyong	026200
026204	3	ID	Kec. Gunung Puyuh	026200
026205	3	ID	Kec. Cikole	026200
026206	3	ID	Kec. Lembur Situ	026200
026207	3	ID	Kec. Cibeureum	026200
026300	2	ID	Kota Cirebon	020000
026301	3	ID	Kec. Harjamukti	026300
026302	3	ID	Kec. Lemahwungkuk	026300
026303	3	ID	Kec. Pekalipan	026300
026304	3	ID	Kec. Kesambi	026300
026305	3	ID	Kec. Kejaksan	026300
026500	2	ID	Kota Bekasi	020000
026501	3	ID	Kec. Pondokgede	026500
026502	3	ID	Kec. Jatiasih	026500
026503	3	ID	Kec. Bantargebang	026500
026504	3	ID	Kec. Bekasi Timur	026500
026505	3	ID	Kec. Bekasi Selatan	026500
026506	3	ID	Kec. Bekasi Barat	026500
026507	3	ID	Kec. Bekasi Utara	026500
026508	3	ID	Kec. Jati Sampurna	026500
026509	3	ID	Kec. Medan Satria	026500
026510	3	ID	Kec. Rawalumbu	026500
026511	3	ID	Kec. Mustika Jaya	026500
026512	3	ID	Kec. Pondok Melati	026500
026600	2	ID	Kota Depok	020000
026601	3	ID	Kec. Sawangan	026600
026602	3	ID	Kec. Pancoran Mas	026600
026603	3	ID	Kec. Sukmajaya	026600
026604	3	ID	Kec. Cimanggis	026600
026605	3	ID	Kec. Beji	026600
026606	3	ID	Kec. Limo	026600
026607	3	ID	Kec. Cipayung	026600
026608	3	ID	Kec. Cilodong	026600
026609	3	ID	Kec. Cinere	026600
026610	3	ID	Kec. Tapos	026600
026611	3	ID	Kec. Bojongsari	026600
026700	2	ID	Kota Cimahi	020000
026701	3	ID	Kec. Cimahi Selatan	026700
026702	3	ID	Kec. Cimahi Tengah	026700
026703	3	ID	Kec. Cimahi Utara	026700
026800	2	ID	Kota Tasikmalaya	020000
026801	3	ID	Kec. Cibeureum	026800
026802	3	ID	Kec. Tamansari	026800
026803	3	ID	Kec. Kawalu	026800
026804	3	ID	Kec. Mangkubumi	026800
026805	3	ID	Kec. Indihiang	026800
026806	3	ID	Kec. Cipedes	026800
026807	3	ID	Kec. Cihideung	026800
026808	3	ID	Kec. Tawang	026800
026809	3	ID	Kec. Purbaratu	026800
026810	3	ID	Kec. Bungursari	026800
026900	2	ID	Kota Banjar	020000
026901	3	ID	Kec. Banjar	026900
026902	3	ID	Kec. Purwaharja	026900
026903	3	ID	Kec. Pataruman	026900
026904	3	ID	Kec. Langensari	026900
030000	1	ID	Prov. Jawa Tengah	000000
030100	2	ID	Kab. Cilacap	030000
030101	3	ID	Kec. Dayeuhluhur	030100
030102	3	ID	Kec. Wanareja	030100
030103	3	ID	Kec. Majenang	030100
030104	3	ID	Kec. Cimanggu	030100
030105	3	ID	Kec. Karangpucung	030100
030106	3	ID	Kec. Cipari	030100
030107	3	ID	Kec. Sidareja	030100
030108	3	ID	Kec. Kedungreja	030100
030109	3	ID	Kec. Patimuan	030100
030110	3	ID	Kec. Gandrungmangu	030100
030111	3	ID	Kec. Bantarsari	030100
030112	3	ID	Kec. Kawunganten	030100
030113	3	ID	Kec. Kampung Laut	030100
030114	3	ID	Kec. Jeruklegi	030100
030115	3	ID	Kec. Kesugihan	030100
030116	3	ID	Kec. Adipala	030100
030117	3	ID	Kec. Maos	030100
030118	3	ID	Kec. Sampang	030100
030119	3	ID	Kec. Kroya	030100
030120	3	ID	Kec. Binangun	030100
030121	3	ID	Kec. Nusawungu	030100
030122	3	ID	Kec. Cilacap Selatan	030100
030123	3	ID	Kec. Cilacap Tengah	030100
030124	3	ID	Kec. Cilacap Utara	030100
030200	2	ID	Kab. Banyumas	030000
030201	3	ID	Kec. Lumbir	030200
030202	3	ID	Kec. Wangon	030200
030203	3	ID	Kec. Jatilawang	030200
030204	3	ID	Kec. Rawalo	030200
030205	3	ID	Kec. Kebasen	030200
030206	3	ID	Kec. Kemranjen	030200
030207	3	ID	Kec. Sumpiuh	030200
030208	3	ID	Kec. Tambak	030200
030209	3	ID	Kec. Somagede	030200
030210	3	ID	Kec. Kalibagor	030200
030211	3	ID	Kec. Banyumas	030200
030212	3	ID	Kec. Patikraja	030200
030213	3	ID	Kec. Purwojati	030200
030214	3	ID	Kec. Ajibarang	030200
030215	3	ID	Kec. Gumelar	030200
030216	3	ID	Kec. Pekuncen	030200
030217	3	ID	Kec. Cilongok	030200
030218	3	ID	Kec. Karanglewas	030200
030219	3	ID	Kec. Kedung Banteng	030200
030220	3	ID	Kec. Baturaden	030200
030221	3	ID	Kec. Sumbang	030200
030222	3	ID	Kec. Kembaran	030200
030223	3	ID	Kec. Sokaraja	030200
030224	3	ID	Kec. Purwokerto Selatan	030200
030225	3	ID	Kec. Purwokerto Barat	030200
030226	3	ID	Kec. Purwokerto Timur	030200
030227	3	ID	Kec. Purwokerto Utara	030200
030300	2	ID	Kab. Purbalingga	030000
030301	3	ID	Kec. Kemangkon	030300
030302	3	ID	Kec. Bukateja	030300
030303	3	ID	Kec. Kejobong	030300
030304	3	ID	Kec. Pengadegan	030300
030305	3	ID	Kec. Kaligondang	030300
030306	3	ID	Kec. Purbalingga	030300
030307	3	ID	Kec. Kalimanah	030300
030308	3	ID	Kec. Padamara	030300
030309	3	ID	Kec. Kutasari	030300
030310	3	ID	Kec. Bojongsari	030300
030311	3	ID	Kec. Mrebet	030300
030312	3	ID	Kec. Bobotsari	030300
030313	3	ID	Kec. Karangreja	030300
030314	3	ID	Kec. Karanganyar	030300
030315	3	ID	Kec. Karangmoncol	030300
030316	3	ID	Kec. Rembang	030300
030317	3	ID	Kec. Karangjambu	030300
030318	3	ID	Kec. Kertanegara	030300
030400	2	ID	Kab. Banjarnegara	030000
030401	3	ID	Kec. Susukan	030400
030402	3	ID	Kec. Purworejo/ Klampok	030400
030403	3	ID	Kec. Mandiraja	030400
030404	3	ID	Kec. Purwonegara	030400
030405	3	ID	Kec. Bawang	030400
030406	3	ID	Kec. Banjarnegara	030400
030407	3	ID	Kec. Sigaluh	030400
030408	3	ID	Kec. Madukara	030400
030409	3	ID	Kec. Banjarmangu	030400
030410	3	ID	Kec. Wanadadi	030400
030411	3	ID	Kec. Rakit	030400
030412	3	ID	Kec. Punggelan	030400
030413	3	ID	Kec. Karangkobar	030400
030414	3	ID	Kec. Pagentan	030400
030415	3	ID	Kec. Pejawaran	030400
030416	3	ID	Kec. Batur	030400
030417	3	ID	Kec. Wanayasa	030400
030418	3	ID	Kec. Kalibening	030400
030419	3	ID	Kec. Pandan Arum	030400
030420	3	ID	Kec. Pagedongan	030400
030500	2	ID	Kab. Kebumen	030000
030501	3	ID	Kec. Ayah	030500
030502	3	ID	Kec. Buayan	030500
030503	3	ID	Kec. Puring	030500
030504	3	ID	Kec. Petanahan	030500
030505	3	ID	Kec. Klirong	030500
030506	3	ID	Kec. Bulupesantren	030500
030507	3	ID	Kec. Ambal	030500
030508	3	ID	Kec. Mirit	030500
030509	3	ID	Kec. Prembun	030500
030510	3	ID	Kec. Kutowinangun	030500
030511	3	ID	Kec. Alian	030500
030512	3	ID	Kec. Kebumen	030500
030513	3	ID	Kec. Pejagoan	030500
030514	3	ID	Kec. Sruweng	030500
030515	3	ID	Kec. Adimulyo	030500
030516	3	ID	Kec. Kuwarasan	030500
030517	3	ID	Kec. Rowokele	030500
030518	3	ID	Kec. Sempor	030500
030519	3	ID	Kec. Gombong	030500
030520	3	ID	Kec. Karanganyar	030500
030521	3	ID	Kec. Karangganyam	030500
030522	3	ID	Kec. Sadang	030500
030523	3	ID	Kec. Bonorowo	030500
030524	3	ID	Kec. Padureso	030500
030525	3	ID	Kec. Poncowarno	030500
030526	3	ID	Kec. Karangsambung	030500
030600	2	ID	Kab. Purworejo	030000
030601	3	ID	Kec. Grabag	030600
030602	3	ID	Kec. Ngombol	030600
030603	3	ID	Kec. Purwodadi	030600
030604	3	ID	Kec. Bagelen	030600
030605	3	ID	Kec. Kaligesing	030600
030606	3	ID	Kec. Purworejo	030600
030607	3	ID	Kec. Banyu Urip	030600
030608	3	ID	Kec. Bayan	030600
030609	3	ID	Kec. Kutoarjo	030600
030610	3	ID	Kec. Butuh	030600
030611	3	ID	Kec. Pituruh	030600
030612	3	ID	Kec. Kemiri	030600
030613	3	ID	Kec. Bruno	030600
030614	3	ID	Kec. Gebang	030600
030615	3	ID	Kec. Loano	030600
030616	3	ID	Kec. Bener	030600
030700	2	ID	Kab. Wonosobo	030000
030701	3	ID	Kec. Wadaslintang	030700
030702	3	ID	Kec. Kepil	030700
030703	3	ID	Kec. Sapuran	030700
030704	3	ID	Kec. Kaliwiro	030700
030705	3	ID	Kec. Leksono	030700
030706	3	ID	Kec. Selomerto	030700
030707	3	ID	Kec. Kalikajar	030700
030708	3	ID	Kec. Kertek	030700
030709	3	ID	Kec. Wonosobo	030700
030710	3	ID	Kec. Watumalang	030700
030711	3	ID	Kec. Mojotengah	030700
030712	3	ID	Kec. Garung	030700
030713	3	ID	Kec. Kejajar	030700
030714	3	ID	Kec. Sukoharjo	030700
030715	3	ID	Kec. Kalibawang	030700
030800	2	ID	Kab. Magelang	030000
030801	3	ID	Kec. Salaman	030800
030802	3	ID	Kec. Borobudur	030800
030803	3	ID	Kec. Ngluwar	030800
030804	3	ID	Kec. Salam	030800
030805	3	ID	Kec. Srumbung	030800
030806	3	ID	Kec. Dukun	030800
030807	3	ID	Kec. Muntilan	030800
030808	3	ID	Kec. Mungkid	030800
030809	3	ID	Kec. Sawangan	030800
030810	3	ID	Kec. Candimulyo	030800
030811	3	ID	Kec. Martoyudan	030800
030812	3	ID	Kec. Tempuran	030800
030813	3	ID	Kec. Kajoran	030800
030814	3	ID	Kec. Kaliangkrik	030800
030815	3	ID	Kec. Bandongan	030800
030816	3	ID	Kec. Windusari	030800
030817	3	ID	Kec. Secang	030800
030818	3	ID	Kec. Tegalrejo	030800
030819	3	ID	Kec. Pakis	030800
030820	3	ID	Kec. Grabag	030800
030821	3	ID	Kec. Ngablak	030800
030900	2	ID	Kab. Boyolali	030000
030901	3	ID	Kec. Selo	030900
030902	3	ID	Kec. Ampel	030900
030903	3	ID	Kec. Cepogo	030900
030904	3	ID	Kec. Musuk	030900
030905	3	ID	Kec. Boyolali	030900
030906	3	ID	Kec. Mojosongo	030900
030907	3	ID	Kec. Teras	030900
030908	3	ID	Kec. Sawit	030900
030909	3	ID	Kec. Banyudono	030900
030910	3	ID	Kec. Sambi	030900
030911	3	ID	Kec. Ngemplak	030900
030912	3	ID	Kec. Nogosari	030900
030913	3	ID	Kec. Simo	030900
030914	3	ID	Kec. Karanggede	030900
030915	3	ID	Kec. Klego	030900
030916	3	ID	Kec. Andong	030900
030917	3	ID	Kec. Kemusu	030900
030918	3	ID	Kec. Wonosegoro	030900
030919	3	ID	Kec. Juwangi	030900
031000	2	ID	Kab. Klaten	030000
031001	3	ID	Kec. Prambanan	031000
031002	3	ID	Kec. Gantiwarno	031000
031003	3	ID	Kec. Wedi	031000
031004	3	ID	Kec. Bayat	031000
031005	3	ID	Kec. Cawas	031000
031006	3	ID	Kec. Trucuk	031000
031007	3	ID	Kec. Kalikotes	031000
031008	3	ID	Kec. Kebonarum	031000
031009	3	ID	Kec. Jogonalan	031000
031010	3	ID	Kec. Manisrenggo	031000
031011	3	ID	Kec. Karangnongko	031000
031012	3	ID	Kec. Ngawen	031000
031013	3	ID	Kec. Ceper	031000
031014	3	ID	Kec. Pedan	031000
031015	3	ID	Kec. Karangdowo	031000
031016	3	ID	Kec. Juwiring	031000
031017	3	ID	Kec. Wonosari	031000
031018	3	ID	Kec. Delanggu	031000
031019	3	ID	Kec. Polanharjo	031000
031020	3	ID	Kec. Karanganom	031000
031021	3	ID	Kec. Tulung	031000
031022	3	ID	Kec. Jatinom	031000
031023	3	ID	Kec. Kemalang	031000
031024	3	ID	Kec. Klaten Selatan	031000
031025	3	ID	Kec. Klaten Tengah	031000
031026	3	ID	Kec. Klaten Utara	031000
031100	2	ID	Kab. Sukoharjo	030000
031101	3	ID	Kec. Weru	031100
031102	3	ID	Kec. Bulu	031100
031103	3	ID	Kec. Tawangsari	031100
031104	3	ID	Kec. Sukoharjo	031100
031105	3	ID	Kec. Nguter	031100
031106	3	ID	Kec. Bendosari	031100
031107	3	ID	Kec. Polokarto	031100
031108	3	ID	Kec. Mojolaban	031100
031109	3	ID	Kec. Grogol	031100
031110	3	ID	Kec. Baki	031100
031111	3	ID	Kec. Gatak	031100
031112	3	ID	Kec. Kartasura	031100
031200	2	ID	Kab. Wonogiri	030000
031201	3	ID	Kec. Pracimantoro	031200
031202	3	ID	Kec. Paranggupito	031200
031203	3	ID	Kec. Giritontro	031200
031204	3	ID	Kec. Giriwoyo	031200
031205	3	ID	Kec. Batuwarno	031200
031206	3	ID	Kec. Karangtengah	031200
031207	3	ID	Kec. Tirtomoyo	031200
031208	3	ID	Kec. Nguntoronadi	031200
031209	3	ID	Kec. Baturetno	031200
031210	3	ID	Kec. Eromoko	031200
031211	3	ID	Kec. Wuryantoro	031200
031212	3	ID	Kec. Manyaran	031200
031213	3	ID	Kec. Selogiri	031200
031214	3	ID	Kec. Wonogiri	031200
031215	3	ID	Kec. Ngadirojo	031200
031216	3	ID	Kec. Sidoharjo	031200
031217	3	ID	Kec. Jatiroto	031200
031218	3	ID	Kec. Kismantoro	031200
031219	3	ID	Kec. Purwantoro	031200
031220	3	ID	Kec. Bulukerto	031200
031221	3	ID	Kec. Slogohimo	031200
031222	3	ID	Kec. Jatisrono	031200
031223	3	ID	Kec. Jatipurno	031200
031224	3	ID	Kec. Girimarto	031200
031225	3	ID	Kec. Puhpelem	031200
031300	2	ID	Kab. Karanganyar	030000
031301	3	ID	Kec. Jatipuro	031300
031302	3	ID	Kec. Jatiyoso	031300
031303	3	ID	Kec. Jumapolo	031300
031304	3	ID	Kec. Jumantono	031300
031305	3	ID	Kec. Matesih	031300
031306	3	ID	Kec. Tawangmangu	031300
031307	3	ID	Kec. Ngargoyoso	031300
031308	3	ID	Kec. Karangpandan	031300
031309	3	ID	Kec. Karanganyar	031300
031310	3	ID	Kec. Tasikmadu	031300
031311	3	ID	Kec. Jaten	031300
031312	3	ID	Kec. Colomadu	031300
031313	3	ID	Kec. Gondangrejo	031300
031314	3	ID	Kec. Kebakkramat	031300
031315	3	ID	Kec. Mojogedang	031300
031316	3	ID	Kec. Kerjo	031300
031317	3	ID	Kec. Jenawi	031300
031400	2	ID	Kab. Sragen	030000
031401	3	ID	Kec. Kalijambe	031400
031402	3	ID	Kec. Plupuh	031400
031403	3	ID	Kec. Masaran	031400
031404	3	ID	Kec. Kedawung	031400
031405	3	ID	Kec. Sambirejo	031400
031406	3	ID	Kec. Gondang	031400
031407	3	ID	Kec. Sambung Macan	031400
031408	3	ID	Kec. Ngrampal	031400
031409	3	ID	Kec. Karangmalang	031400
031410	3	ID	Kec. Sragen	031400
031411	3	ID	Kec. Sidoharjo	031400
031412	3	ID	Kec. Tanon	031400
031413	3	ID	Kec. Gemolong	031400
031414	3	ID	Kec. Miri	031400
031415	3	ID	Kec. Sumberlawang	031400
031416	3	ID	Kec. Mondokan	031400
031417	3	ID	Kec. Sukodono	031400
031418	3	ID	Kec. Gesi	031400
031419	3	ID	Kec. Tangen	031400
031420	3	ID	Kec. Jenar	031400
031500	2	ID	Kab. Grobogan	030000
031501	3	ID	Kec. Kedungjati	031500
031502	3	ID	Kec. Karangrayung	031500
031503	3	ID	Kec. Penawangan	031500
031504	3	ID	Kec. Toroh	031500
031505	3	ID	Kec. Geyer	031500
031506	3	ID	Kec. Pulokulon	031500
031507	3	ID	Kec. Kradenan	031500
031508	3	ID	Kec. Gabus	031500
031509	3	ID	Kec. Ngaringan	031500
031510	3	ID	Kec. Wirosari	031500
031511	3	ID	Kec. Tawangharjo	031500
031512	3	ID	Kec. Grobogan	031500
031513	3	ID	Kec. Purwodadi	031500
031514	3	ID	Kec. Brati	031500
031515	3	ID	Kec. Klambu	031500
031516	3	ID	Kec. Godong	031500
031517	3	ID	Kec. Gubug	031500
031518	3	ID	Kec. Tegowanu	031500
031519	3	ID	Kec. Tanggungharjo	031500
031600	2	ID	Kab. Blora	030000
031601	3	ID	Kec. Jati	031600
031602	3	ID	Kec. Randublatung	031600
031603	3	ID	Kec. Kradenan	031600
031604	3	ID	Kec. Kedungtuban	031600
031605	3	ID	Kec. Cepu	031600
031606	3	ID	Kec. Sambong	031600
031607	3	ID	Kec. Jiken	031600
031608	3	ID	Kec. Bogorejo	031600
031609	3	ID	Kec. Jepon	031600
031610	3	ID	Kec. Kota Blora	031600
031611	3	ID	Kec. Banjarejo	031600
031612	3	ID	Kec. Tunjungan	031600
031613	3	ID	Kec. Japah	031600
031614	3	ID	Kec. Ngawen	031600
031615	3	ID	Kec. Kunduran	031600
031616	3	ID	Kec. Todanan	031600
031700	2	ID	Kab. Rembang	030000
031701	3	ID	Kec. Sumber	031700
031702	3	ID	Kec. Bulu	031700
031703	3	ID	Kec. Gunem	031700
031704	3	ID	Kec. Sale	031700
031705	3	ID	Kec. Sarang	031700
031706	3	ID	Kec. Sedan	031700
031707	3	ID	Kec. Pamotan	031700
031708	3	ID	Kec. Sulang	031700
031709	3	ID	Kec. Kaliori	031700
031710	3	ID	Kec. Rembang	031700
031711	3	ID	Kec. Pancur	031700
031712	3	ID	Kec. Kragan	031700
031713	3	ID	Kec. Sluke	031700
031714	3	ID	Kec. Lasem	031700
031800	2	ID	Kab. Pati	030000
031801	3	ID	Kec. Sukolilo	031800
031802	3	ID	Kec. Kayen	031800
031803	3	ID	Kec. Tambakromo	031800
031804	3	ID	Kec. Winong	031800
031805	3	ID	Kec. Pucakwangi	031800
031806	3	ID	Kec. Jaken	031800
031807	3	ID	Kec. Batangan	031800
031808	3	ID	Kec. Juwana	031800
031809	3	ID	Kec. Jakenan	031800
031810	3	ID	Kec. Pati	031800
031811	3	ID	Kec. Gabus	031800
031812	3	ID	Kec. Margorejo	031800
031813	3	ID	Kec. Gembong	031800
031814	3	ID	Kec. Tlogowungu	031800
031815	3	ID	Kec. Wedarijaksa	031800
031816	3	ID	Kec. Trangkil	031800
031817	3	ID	Kec. Margoyoso	031800
031818	3	ID	Kec. Gunung Wungkal	031800
031819	3	ID	Kec. Cluwak	031800
031820	3	ID	Kec. Tayu	031800
031821	3	ID	Kec. Dukuhseti	031800
031900	2	ID	Kab. Kudus	030000
031901	3	ID	Kec. Kaliwungu	031900
031902	3	ID	Kec. Kota Kudus	031900
031903	3	ID	Kec. Jati	031900
031904	3	ID	Kec. Undaan	031900
031905	3	ID	Kec. Mejobo	031900
031906	3	ID	Kec. Jekulo	031900
031907	3	ID	Kec. Bae	031900
031908	3	ID	Kec. Gebog	031900
031909	3	ID	Kec. Dawe	031900
032000	2	ID	Kab. Jepara	030000
032001	3	ID	Kec. Kedung	032000
032002	3	ID	Kec. Pecangaan	032000
032003	3	ID	Kec. Welahan	032000
032004	3	ID	Kec. Mayong	032000
032005	3	ID	Kec. Nalumsari	032000
032006	3	ID	Kec. Batealit	032000
032007	3	ID	Kec. Tahunan	032000
032008	3	ID	Kec. Jepara	032000
032009	3	ID	Kec. Mlonggo	032000
032010	3	ID	Kec. Bangsri	032000
032011	3	ID	Kec. Keling	032000
032012	3	ID	Kec. Karimunjawa	032000
032013	3	ID	Kec. Kalinyamatan	032000
032014	3	ID	Kec. Kembang	032000
032015	3	ID	Kec. Donorojo	032000
032016	3	ID	Kec. Pakis Aji	032000
032100	2	ID	Kab. Demak	030000
032101	3	ID	Kec. Mranggen	032100
032102	3	ID	Kec. Karangawen	032100
032103	3	ID	Kec. Guntur	032100
032104	3	ID	Kec. Sayung	032100
032105	3	ID	Kec. Karang Tengah	032100
032106	3	ID	Kec. Bonang	032100
032107	3	ID	Kec. Demak	032100
032108	3	ID	Kec. Wonosalam	032100
032109	3	ID	Kec. Dempet	032100
032110	3	ID	Kec. Gajah	032100
032111	3	ID	Kec. Karanganyar	032100
032112	3	ID	Kec. Mijen	032100
032113	3	ID	Kec. Wedung	032100
032114	3	ID	Kec. Kebonagung	032100
032200	2	ID	Kab. Semarang	030000
032201	3	ID	Kec. Getasan	032200
032202	3	ID	Kec. Tengaran	032200
032203	3	ID	Kec. Susukan	032200
032204	3	ID	Kec. Suruh	032200
032205	3	ID	Kec. Pabelan	032200
032206	3	ID	Kec. Tuntang	032200
032207	3	ID	Kec. Banyubiru	032200
032208	3	ID	Kec. Jambu	032200
032209	3	ID	Kec. Sumowono	032200
032210	3	ID	Kec. Ambarawa	032200
032211	3	ID	Kec. Bawen	032200
032212	3	ID	Kec. Bringin	032200
032213	3	ID	Kec. Pringapus	032200
032214	3	ID	Kec. Bergas	032200
032217	3	ID	Kec. Kaliwungu	032200
032218	3	ID	Kec. Bancak	032200
032219	3	ID	Kec. Ungaran Barat	032200
032220	3	ID	Kec. Ungaran Timur	032200
032221	3	ID	Kec. Bandungan	032200
032300	2	ID	Kab. Temanggung	030000
032301	3	ID	Kec. Parakan	032300
032302	3	ID	Kec. Bulu	032300
032303	3	ID	Kec. Temanggung	032300
032304	3	ID	Kec. Tembarak	032300
032305	3	ID	Kec. Kranggan	032300
032306	3	ID	Kec. Pringsurat	032300
032307	3	ID	Kec. Kaloran	032300
032308	3	ID	Kec. Kandangan	032300
032309	3	ID	Kec. Kedu	032300
032310	3	ID	Kec. Ngadirejo	032300
032311	3	ID	Kec. Jumo	032300
032312	3	ID	Kec. Candiroto	032300
032313	3	ID	Kec. Tretep	032300
032314	3	ID	Kec. Kledung	032300
032315	3	ID	Kec. Bansari	032300
032316	3	ID	Kec. Tlogomulyo	032300
032317	3	ID	Kec. Selopampang	032300
032318	3	ID	Kec. Gemawang	032300
032319	3	ID	Kec. Bejen	032300
032320	3	ID	Kec. Wonoboyo	032300
032400	2	ID	Kab. Kendal	030000
032401	3	ID	Kec. Plantungan	032400
032402	3	ID	Kec. Sukorejo	032400
032403	3	ID	Kec. Pegeruyung	032400
032404	3	ID	Kec. Patean	032400
032405	3	ID	Kec. Singorojo	032400
032406	3	ID	Kec. Limbangan	032400
032407	3	ID	Kec. Boja	032400
032408	3	ID	Kec. Kaliwungu	032400
032409	3	ID	Kec. Brangsong	032400
032410	3	ID	Kec. Pegandon	032400
032411	3	ID	Kec. Gemuh	032400
032412	3	ID	Kec. Waleri	032400
032413	3	ID	Kec. Rowosari	032400
032414	3	ID	Kec. Kangkung	032400
032415	3	ID	Kec. Cipiring	032400
032416	3	ID	Kec. Patebon	032400
032417	3	ID	Kec. Kota Kendal	032400
032418	3	ID	Kec. Ngampel	032400
032419	3	ID	Kec. Ringinarum	032400
032420	3	ID	Kec. Kaliwungu Selatan	032400
032500	2	ID	Kab. Batang	030000
032501	3	ID	Kec. Wonotunggal	032500
032502	3	ID	Kec. Bandar	032500
032503	3	ID	Kec. Blado	032500
032504	3	ID	Kec. Reban	032500
032505	3	ID	Kec. Bawang	032500
032506	3	ID	Kec. Tersono	032500
032507	3	ID	Kec. Gringsing	032500
032508	3	ID	Kec. Limpung	032500
032509	3	ID	Kec. Subah	032500
032510	3	ID	Kec. Tulis	032500
032511	3	ID	Kec. Batang	032500
032512	3	ID	Kec. Warung Asem	032500
032513	3	ID	Kec. Banyuputih	032500
032514	3	ID	Kec. Pecalungan	032500
032515	3	ID	Kec. Kandeman	032500
032600	2	ID	Kab. Pekalongan	030000
032601	3	ID	Kec. Kandang Serang	032600
032602	3	ID	Kec. Peninggaran	032600
032603	3	ID	Kec. Lebakbarang	032600
032604	3	ID	Kec. Petungkriono	032600
032605	3	ID	Kec. Talun	032600
032606	3	ID	Kec. Doro	032600
032607	3	ID	Kec. Karanganyar	032600
032608	3	ID	Kec. Kajen	032600
032609	3	ID	Kec. Kesesi	032600
032610	3	ID	Kec. Sragi	032600
032611	3	ID	Kec. Bojong	032600
032612	3	ID	Kec. Wonopringgo	032600
032613	3	ID	Kec. Kedungwuni	032600
032614	3	ID	Kec. Buaran	032600
032615	3	ID	Kec. Tirto	032600
032616	3	ID	Kec. Wiradesa	032600
032617	3	ID	Kec. Siwalan	032600
032618	3	ID	Kec. Karangdadap	032600
032619	3	ID	Kec. Wonokerto	032600
032700	2	ID	Kab. Pemalang	030000
032701	3	ID	Kec. Moga	032700
032702	3	ID	Kec. Pulosari	032700
032703	3	ID	Kec. Belik	032700
032704	3	ID	Kec. Watukumpul	032700
032705	3	ID	Kec. Bodeh	032700
032706	3	ID	Kec. Bantarbolang	032700
032707	3	ID	Kec. Randudongkel	032700
032708	3	ID	Kec. Pemalang	032700
032709	3	ID	Kec. Taman	032700
032710	3	ID	Kec. Petarukan	032700
032711	3	ID	Kec. Ampelgading	032700
032712	3	ID	Kec. Comal	032700
032713	3	ID	Kec. Ulujami	032700
032714	3	ID	Kec. Warungpring	032700
032800	2	ID	Kab. Tegal	030000
032801	3	ID	Kec. Margasari	032800
032802	3	ID	Kec. Bumijawa	032800
032803	3	ID	Kec. Bojong	032800
032804	3	ID	Kec. Balapulang	032800
032805	3	ID	Kec. Pagerbarang	032800
032806	3	ID	Kec. Lebaksiu	032800
032807	3	ID	Kec. Jatinegara	032800
032808	3	ID	Kec. Kedung Banteng	032800
032809	3	ID	Kec. Pangkah	032800
032810	3	ID	Kec. Slawi	032800
032811	3	ID	Kec. Dukuhwaru	032800
032812	3	ID	Kec. Adiwerna	032800
032813	3	ID	Kec. Dukuhturi	032800
032814	3	ID	Kec. Talang	032800
032815	3	ID	Kec. Tarub	032800
032816	3	ID	Kec. Kramat	032800
032817	3	ID	Kec. Suradadi	032800
032818	3	ID	Kec. Warureja	032800
032900	2	ID	Kab. Brebes	030000
032901	3	ID	Kec. Salem	032900
032902	3	ID	Kec. Bantarkawung	032900
032903	3	ID	Kec. Bumiayu	032900
032904	3	ID	Kec. Paguyangan	032900
032905	3	ID	Kec. Sirampog	032900
032906	3	ID	Kec. Tonjong	032900
032907	3	ID	Kec. Larangan	032900
032908	3	ID	Kec. Ketanggungan	032900
032909	3	ID	Kec. Banjarharjo	032900
032910	3	ID	Kec. Losari	032900
032911	3	ID	Kec. Tanjung	032900
032912	3	ID	Kec. Kersana	032900
032913	3	ID	Kec. Bulakamba	032900
032914	3	ID	Kec. Wanasari	032900
032915	3	ID	Kec. Songgom	032900
032916	3	ID	Kec. Jatibarang	032900
032917	3	ID	Kec. Brebes	032900
036000	2	ID	Kota Magelang	030000
036001	3	ID	Kec. Magelang Selatan	036000
036002	3	ID	Kec. Magelang Utara	036000
036003	3	ID	Kec. Magelang Tengah	036000
036100	2	ID	Kota Surakarta	030000
036101	3	ID	Kec. Laweyan	036100
036102	3	ID	Kec. Serengan	036100
036103	3	ID	Kec. Pasarkliwon	036100
036104	3	ID	Kec. Jebres	036100
036105	3	ID	Kec. Banjarsari	036100
036200	2	ID	Kota Salatiga	030000
036201	3	ID	Kec. Argomulyo	036200
036202	3	ID	Kec. Tingkir	036200
036203	3	ID	Kec. Sidomukti	036200
036204	3	ID	Kec. Sidorejo	036200
036300	2	ID	Kota Semarang	030000
036301	3	ID	Kec. Mijen	036300
036302	3	ID	Kec. Gunung Pati	036300
036303	3	ID	Kec. Banyumanik	036300
036304	3	ID	Kec. Gajah Mungkur	036300
036305	3	ID	Kec. Semarang Selatan	036300
036306	3	ID	Kec. Candisari	036300
036307	3	ID	Kec. Tembalang	036300
036308	3	ID	Kec. Pedurungan	036300
036309	3	ID	Kec. Genuk	036300
036310	3	ID	Kec. Gayamsari	036300
036311	3	ID	Kec. Semarang Timur	036300
036312	3	ID	Kec. Semarang Tengah	036300
036313	3	ID	Kec. Semarang Utara	036300
036314	3	ID	Kec. Semarang Barat	036300
036315	3	ID	Kec. Tugu	036300
036316	3	ID	Kec. Ngaliyan	036300
036400	2	ID	Kota Pekalongan	030000
036401	3	ID	Kec. Pekalongan Barat	036400
036402	3	ID	Kec. Pekalongan Timur	036400
036403	3	ID	Kec. Pekalongan Selatan	036400
036404	3	ID	Kec. Pekalongan Utara	036400
036500	2	ID	Kota Tegal	030000
036501	3	ID	Kec. Tegal Selatan	036500
036502	3	ID	Kec. Tegal Timur	036500
036503	3	ID	Kec. Tegal Barat	036500
036504	3	ID	Kec. Margadana	036500
040000	1	ID	Prov. D.I. Yogyakarta	000000
040100	2	ID	Kab. Bantul	040000
040101	3	ID	Kec. Srandakan	040100
040102	3	ID	Kec. Sanden	040100
040103	3	ID	Kec. Kretek	040100
040104	3	ID	Kec. Pundong	040100
040105	3	ID	Kec. Bambang Lipuro	040100
040106	3	ID	Kec. Pandak	040100
040107	3	ID	Kec. Bantul	040100
040108	3	ID	Kec. Jetis	040100
040109	3	ID	Kec. Imogiri	040100
040110	3	ID	Kec. Dlingo	040100
040111	3	ID	Kec. Pleret	040100
040112	3	ID	Kec. Piyungan	040100
040113	3	ID	Kec. Banguntapan	040100
040114	3	ID	Kec. Sewon	040100
040115	3	ID	Kec. Kasihan	040100
040116	3	ID	Kec. Pajangan	040100
040117	3	ID	Kec. Sedayu	040100
040200	2	ID	Kab. Sleman	040000
040201	3	ID	Kec. Moyudan	040200
040202	3	ID	Kec. Minggir	040200
040203	3	ID	Kec. Seyegan	040200
040204	3	ID	Kec. Godean	040200
040205	3	ID	Kec. Gamping	040200
040206	3	ID	Kec. Mlati	040200
040207	3	ID	Kec. Depok	040200
040208	3	ID	Kec. Berbah	040200
040209	3	ID	Kec. Prambanan	040200
040210	3	ID	Kec. Kalasan	040200
040211	3	ID	Kec. Ngemplak	040200
040212	3	ID	Kec. Ngaglik	040200
040213	3	ID	Kec. Sleman	040200
040214	3	ID	Kec. Tempel	040200
040215	3	ID	Kec. Turi	040200
040216	3	ID	Kec. Pekem	040200
040217	3	ID	Kec. Cangkringan	040200
040300	2	ID	Kab. Gunung Kidul	040000
040301	3	ID	Kec. Panggang	040300
040302	3	ID	Kec. Paliyan	040300
040303	3	ID	Kec. Sapto Sari	040300
040304	3	ID	Kec. Tepus	040300
040305	3	ID	Kec. Rongkop	040300
040306	3	ID	Kec. Semanu	040300
040307	3	ID	Kec. Ponjong	040300
040308	3	ID	Kec. Karangmojo	040300
040309	3	ID	Kec. Wonosari	040300
040310	3	ID	Kec. Playen	040300
040311	3	ID	Kec. Patuk	040300
040312	3	ID	Kec. Gedang Sari	040300
040313	3	ID	Kec. Nglipar	040300
040314	3	ID	Kec. Ngawen	040300
040315	3	ID	Kec. Semin	040300
040316	3	ID	Kec. Purwosari	040300
040317	3	ID	Kec. Girisubo	040300
040318	3	ID	Kec. Tanjungsari	040300
040400	2	ID	Kab. Kulon Progo	040000
040401	3	ID	Kec. Temon	040400
040402	3	ID	Kec. Wates	040400
040403	3	ID	Kec. Panjatan	040400
040404	3	ID	Kec. Galur	040400
040405	3	ID	Kec. Lendah	040400
040406	3	ID	Kec. Sentolo	040400
040407	3	ID	Kec. Pengasih	040400
040408	3	ID	Kec. Kokap	040400
040409	3	ID	Kec. Girimulyo	040400
040410	3	ID	Kec. Nanggulan	040400
040411	3	ID	Kec. Kalibawang	040400
040412	3	ID	Kec. Samigaluh	040400
046000	2	ID	Kota Yogyakarta	040000
046001	3	ID	Kec. Mantrijeron	046000
046002	3	ID	Kec. Kraton	046000
046003	3	ID	Kec. Mergangsan	046000
046004	3	ID	Kec. Umbulharjo	046000
046005	3	ID	Kec. Kotagede	046000
046006	3	ID	Kec. Gondokusuman	046000
046007	3	ID	Kec. Danurejan	046000
046008	3	ID	Kec. Pakualaman	046000
046009	3	ID	Kec. Gondomanan	046000
046010	3	ID	Kec. Ngampilan	046000
046011	3	ID	Kec. Wirobrajan	046000
046012	3	ID	Kec. Gedongtengen	046000
046013	3	ID	Kec. Jetis	046000
046014	3	ID	Kec. Tegalrejo	046000
050000	1	ID	Prov. Jawa Timur	000000
050100	2	ID	Kab. Gresik	050000
050101	3	ID	Kec. Wringin Anom	050100
050102	3	ID	Kec. Driyorejo	050100
050103	3	ID	Kec. Kedamean	050100
050104	3	ID	Kec. Menganti	050100
050105	3	ID	Kec. Cerme	050100
050106	3	ID	Kec. Benjeng	050100
050107	3	ID	Kec. Balong Panggang	050100
050108	3	ID	Kec. Duduk Sampeyan	050100
050109	3	ID	Kec. Kebomas	050100
050110	3	ID	Kec. Gresik	050100
050111	3	ID	Kec. Manyar	050100
050112	3	ID	Kec. Bungah	050100
050113	3	ID	Kec. Sidayu	050100
050114	3	ID	Kec. Dukun	050100
050115	3	ID	Kec. Panceng	050100
050116	3	ID	Kec. Ujung Pangkah	050100
050117	3	ID	Kec. Sangkapura	050100
050118	3	ID	Kec. Tambak	050100
050200	2	ID	Kab. Sidoarjo	050000
050201	3	ID	Kec. Tarik	050200
050202	3	ID	Kec. Prambon	050200
050203	3	ID	Kec. Krembung	050200
050204	3	ID	Kec. Porong	050200
050205	3	ID	Kec. Jabon	050200
050206	3	ID	Kec. Tanggulangin	050200
050207	3	ID	Kec. Candi	050200
050208	3	ID	Kec. Tulangan	050200
050209	3	ID	Kec. Wonoayu	050200
050210	3	ID	Kec. Sukodono	050200
050211	3	ID	Kec. Sidoarjo	050200
050212	3	ID	Kec. Buduran	050200
050213	3	ID	Kec. Sedati	050200
050214	3	ID	Kec. Waru	050200
050215	3	ID	Kec. Gedangan	050200
050216	3	ID	Kec. Taman	050200
050217	3	ID	Kec. Krian	050200
050218	3	ID	Kec. Balong Bendo	050200
050300	2	ID	Kab. Mojokerto	050000
050301	3	ID	Kec. Jatirejo	050300
050302	3	ID	Kec. Gondang	050300
050303	3	ID	Kec. Pacet	050300
050304	3	ID	Kec. Trawas	050300
050305	3	ID	Kec. Ngoro	050300
050306	3	ID	Kec. Pungging	050300
050307	3	ID	Kec. Kutorejo	050300
050308	3	ID	Kec. Mojosari	050300
050309	3	ID	Kec. Bangsal	050300
050310	3	ID	Kec. Dlanggu	050300
050311	3	ID	Kec. Puri	050300
050312	3	ID	Kec. Trowulan	050300
050313	3	ID	Kec. Sooko	050300
050314	3	ID	Kec. Gedek	050300
050315	3	ID	Kec. Kemlagi	050300
050316	3	ID	Kec. Jetis	050300
050317	3	ID	Kec. Dawar Blandong	050300
050318	3	ID	Kec. Mojoanyar	050300
050400	2	ID	Kab. Jombang	050000
050401	3	ID	Kec. Bandar Kedung Mulyo	050400
050402	3	ID	Kec. Perak	050400
050403	3	ID	Kec. Gudo	050400
050404	3	ID	Kec. Diwek	050400
050405	3	ID	Kec. Ngoro	050400
050406	3	ID	Kec. Mojowarno	050400
050407	3	ID	Kec. Bareng	050400
050408	3	ID	Kec. Wonosalam	050400
050409	3	ID	Kec. Mojoagung	050400
050410	3	ID	Kec. Somobito	050400
050411	3	ID	Kec. Jogo Roto	050400
050412	3	ID	Kec. Peterongan	050400
050413	3	ID	Kec. Jombang	050400
050414	3	ID	Kec. Megaluh	050400
050415	3	ID	Kec. Tembelang	050400
050416	3	ID	Kec. Kesamben	050400
050417	3	ID	Kec. Kudu	050400
050418	3	ID	Kec. Ploso	050400
050419	3	ID	Kec. Kabuh	050400
050420	3	ID	Kec. Plandaan	050400
050421	3	ID	Kec. Ngusikan	050400
050500	2	ID	Kab. Bojonegoro	050000
050501	3	ID	Kec. Margomulyo	050500
050502	3	ID	Kec. Ngraho	050500
050503	3	ID	Kec. Tambakrejo	050500
050504	3	ID	Kec. Ngambon	050500
050505	3	ID	Kec. Bubulan	050500
050506	3	ID	Kec. Temayang	050500
050507	3	ID	Kec. Sugihwaras	050500
050508	3	ID	Kec. Kedungadem	050500
050509	3	ID	Kec. Kepoh Baru	050500
050510	3	ID	Kec. Baureno	050500
050511	3	ID	Kec. Kanor	050500
050512	3	ID	Kec. Sumberrejo	050500
050513	3	ID	Kec. Balen	050500
050514	3	ID	Kec. Sukosewu	050500
050515	3	ID	Kec. Kapas	050500
050516	3	ID	Kec. Bojonegoro	050500
050517	3	ID	Kec. Trucuk	050500
050518	3	ID	Kec. Dander	050500
050519	3	ID	Kec. Ngasem	050500
050520	3	ID	Kec. Kalitidu	050500
050521	3	ID	Kec. Malo	050500
050522	3	ID	Kec. Purwosari	050500
050523	3	ID	Kec. Padangan	050500
050524	3	ID	Kec. Kasiman	050500
050525	3	ID	Kec. Kedewan	050500
050526	3	ID	Kec. Gondang	050500
050527	3	ID	Kec. Sekar	050500
050600	2	ID	Kab. Tuban	050000
050601	3	ID	Kec. Kenduruan	050600
050602	3	ID	Kec. Bangilan	050600
050603	3	ID	Kec. Senori	050600
050604	3	ID	Kec. Singgahan	050600
050605	3	ID	Kec. Montong	050600
050606	3	ID	Kec. Parengan	050600
050607	3	ID	Kec. Soko	050600
050608	3	ID	Kec. Rengel	050600
050609	3	ID	Kec. Plumpang	050600
050610	3	ID	Kec. Widang	050600
050611	3	ID	Kec. Palang	050600
050612	3	ID	Kec. Semanding	050600
050613	3	ID	Kec. Tuban	050600
050614	3	ID	Kec. Jenu	050600
050615	3	ID	Kec. Merakurak	050600
050616	3	ID	Kec. Kerek	050600
050617	3	ID	Kec. Tambakboyo	050600
050618	3	ID	Kec. Jatirogo	050600
050619	3	ID	Kec. Bancar	050600
050620	3	ID	Kec. Grabagan	050600
050700	2	ID	Kab. Lamongan	050000
050701	3	ID	Kec. Sukorame	050700
050702	3	ID	Kec. Bluluk	050700
050703	3	ID	Kec. Ngimbang	050700
050704	3	ID	Kec. Sambeng	050700
050705	3	ID	Kec. Mantup	050700
050706	3	ID	Kec. Kambang Bahu	050700
050707	3	ID	Kec. Sugio	050700
050708	3	ID	Kec. Kedungpring	050700
050709	3	ID	Kec. Modo	050700
050710	3	ID	Kec. Babat	050700
050711	3	ID	Kec. Pucuk	050700
050712	3	ID	Kec. Sukodadi	050700
050713	3	ID	Kec. Lamongan	050700
050714	3	ID	Kec. Tikung	050700
050715	3	ID	Kec. Deket	050700
050716	3	ID	Kec. Glagah	050700
050717	3	ID	Kec. Karangbinangun	050700
050718	3	ID	Kec. Turi	050700
050719	3	ID	Kec. Kalitengah	050700
050720	3	ID	Kec. Karang Geneng	050700
050721	3	ID	Kec. Sekaran	050700
050722	3	ID	Kec. Maduran	050700
050723	3	ID	Kec. Laren	050700
050724	3	ID	Kec. Solokuro	050700
050725	3	ID	Kec. Paciran	050700
050726	3	ID	Kec. Brondong	050700
050727	3	ID	Kec. Sarirejo	050700
050800	2	ID	Kab. Madiun	050000
050801	3	ID	Kec. Kebonsari	050800
050802	3	ID	Kec. Geger	050800
050803	3	ID	Kec. Dolopo	050800
050804	3	ID	Kec. Dagangan	050800
050805	3	ID	Kec. Wungu	050800
050806	3	ID	Kec. Kare	050800
050807	3	ID	Kec. Gemarang	050800
050808	3	ID	Kec. Saradan	050800
050809	3	ID	Kec. Pilangkenceng	050800
050810	3	ID	Kec. Mejayan	050800
050811	3	ID	Kec. Wonoasri	050800
050812	3	ID	Kec. Balerejo	050800
050813	3	ID	Kec. Madiun	050800
050814	3	ID	Kec. Sawahan	050800
050815	3	ID	Kec. Jiwan	050800
050900	2	ID	Kab. Ngawi	050000
050901	3	ID	Kec. Sine	050900
050902	3	ID	Kec. Ngrambe	050900
050903	3	ID	Kec. Jogorogo	050900
050904	3	ID	Kec. Kendal	050900
050905	3	ID	Kec. Geneng	050900
050906	3	ID	Kec. Kwadungan	050900
050907	3	ID	Kec. Pangkur	050900
050908	3	ID	Kec. Karangjati	050900
050909	3	ID	Kec. Bringin	050900
050910	3	ID	Kec. Padas	050900
050911	3	ID	Kec. Ngawi	050900
050912	3	ID	Kec. Paron	050900
050913	3	ID	Kec. Kedunggalar	050900
050914	3	ID	Kec. Pitu	050900
050915	3	ID	Kec. Widodaren	050900
050916	3	ID	Kec. Mantingan	050900
050917	3	ID	Kec. Karanganyar	050900
050918	3	ID	Kec. Gerih	050900
050919	3	ID	Kec. Kasreman	050900
051000	2	ID	Kab. Magetan	050000
051001	3	ID	Kec. Poncol	051000
051002	3	ID	Kec. Parang	051000
051003	3	ID	Kec. Lembeyan	051000
051004	3	ID	Kec. Takeran	051000
051005	3	ID	Kec. Kawedanan	051000
051006	3	ID	Kec. Magetan	051000
051007	3	ID	Kec. Plaosan	051000
051008	3	ID	Kec. Panekan	051000
051009	3	ID	Kec. Sukomoro	051000
051010	3	ID	Kec. Bendo	051000
051011	3	ID	Kec. Maospati	051000
051012	3	ID	Kec. Karangrejo	051000
051014	3	ID	Kec. Barat	051000
051015	3	ID	Kec. Kartoharjo	051000
051016	3	ID	Kec. Karas	051000
051017	3	ID	Kec. Ngariboyo	051000
051018	3	ID	Kec. Nguntoronadi	051000
051019	3	ID	Kec. Sidorejo	051000
051100	2	ID	Kab. Ponorogo	050000
051101	3	ID	Kec. Ngrayun	051100
051102	3	ID	Kec. Slahung	051100
051103	3	ID	Kec. Bungkal	051100
051104	3	ID	Kec. Sambit	051100
051105	3	ID	Kec. Sawoo	051100
051106	3	ID	Kec. Sooko	051100
051107	3	ID	Kec. Pulung	051100
051108	3	ID	Kec. Mlarak	051100
051109	3	ID	Kec. Siman	051100
051110	3	ID	Kec. Jetis	051100
051111	3	ID	Kec. Balong	051100
051112	3	ID	Kec. Kauman	051100
051113	3	ID	Kec. Jambon	051100
051114	3	ID	Kec. Badegan	051100
051115	3	ID	Kec. Sampung	051100
051116	3	ID	Kec. Sukorejo	051100
051117	3	ID	Kec. Ponorogo	051100
051118	3	ID	Kec. Babadan	051100
051119	3	ID	Kec. Jenangan	051100
051120	3	ID	Kec. Ngebel	051100
051121	3	ID	Kec. Pudak	051100
051200	2	ID	Kab. Pacitan	050000
051201	3	ID	Kec. Donorejo	051200
051202	3	ID	Kec. Punung	051200
051203	3	ID	Kec. Pringkuku	051200
051204	3	ID	Kec. Pacitan	051200
051205	3	ID	Kec. Kebon Agung	051200
051206	3	ID	Kec. Arjosari	051200
051207	3	ID	Kec. Nawangan	051200
051208	3	ID	Kec. Bandar	051200
051209	3	ID	Kec. Tegalombo	051200
051210	3	ID	Kec. Tulakan	051200
051211	3	ID	Kec. Ngadirojo	051200
051212	3	ID	Kec. Sudimoro	051200
051300	2	ID	Kab. Kediri	050000
051301	3	ID	Kec. Kras	051300
051302	3	ID	Kec. Ringinrejo	051300
051303	3	ID	Kec. Ngancar	051300
051304	3	ID	Kec. Kepung	051300
051305	3	ID	Kec. Puncu	051300
051306	3	ID	Kec. Ploso Klaten	051300
051307	3	ID	Kec. Wates	051300
051308	3	ID	Kec. Kandat	051300
051309	3	ID	Kec. Ngadiluwih	051300
051310	3	ID	Kec. Mojo	051300
051311	3	ID	Kec. Semen	051300
051312	3	ID	Kec. Banyakan	051300
051313	3	ID	Kec. Tarokan	051300
051314	3	ID	Kec. Grogol	051300
051315	3	ID	Kec. Gampengrejo	051300
051316	3	ID	Kec. Gurah	051300
051317	3	ID	Kec. Pagu	051300
051318	3	ID	Kec. Papar	051300
051319	3	ID	Kec. Plemahan	051300
051320	3	ID	Kec. Purwoasri	051300
051321	3	ID	Kec. Kunjang	051300
051322	3	ID	Kec. Pare	051300
051323	3	ID	Kec. Kandangan	051300
051324	3	ID	Kec. Kayen Kidul	051300
051325	3	ID	Kec. Ngasem	051300
051326	3	ID	Kec. Badas	051300
051400	2	ID	Kab. Nganjuk	050000
051401	3	ID	Kec. Sawahan	051400
051402	3	ID	Kec. Ngetos	051400
051403	3	ID	Kec. Berbek	051400
051404	3	ID	Kec. Loceret	051400
051405	3	ID	Kec. Pace	051400
051406	3	ID	Kec. Tanjunganom	051400
051407	3	ID	Kec. Prambon	051400
051408	3	ID	Kec. Ngronggot	051400
051409	3	ID	Kec. Kertosono	051400
051410	3	ID	Kec. Patianrowo	051400
051411	3	ID	Kec. Baron	051400
051412	3	ID	Kec. Gondang	051400
051413	3	ID	Kec. Sukomoro	051400
051414	3	ID	Kec. Nganjuk	051400
051415	3	ID	Kec. Bagor	051400
051416	3	ID	Kec. Wilangan	051400
051417	3	ID	Kec. Rejoso	051400
051418	3	ID	Kec. Ngluyu	051400
051419	3	ID	Kec. Lengkong	051400
051420	3	ID	Kec. Jatikalen	051400
051500	2	ID	Kab. Blitar	050000
051501	3	ID	Kec. Bakung	051500
051502	3	ID	Kec. Wonotirto	051500
051503	3	ID	Kec. Panggungrejo	051500
051504	3	ID	Kec. Wates	051500
051505	3	ID	Kec. Binangun	051500
051506	3	ID	Kec. Sutojayan	051500
051507	3	ID	Kec. Kademangan	051500
051508	3	ID	Kec. Kanigoro	051500
051509	3	ID	Kec. Talun	051500
051510	3	ID	Kec. Selopuro	051500
051511	3	ID	Kec. Kesamben	051500
051512	3	ID	Kec. Selorejo	051500
051513	3	ID	Kec. Doko	051500
051514	3	ID	Kec. Wlingi	051500
051515	3	ID	Kec. Gandusari	051500
051516	3	ID	Kec. Garum	051500
051517	3	ID	Kec. Nglegok	051500
051518	3	ID	Kec. Sanankulon	051500
051519	3	ID	Kec. Ponggok	051500
051520	3	ID	Kec. Srengat	051500
051521	3	ID	Kec. Wonodadi	051500
051522	3	ID	Kec. Udanawu	051500
051600	2	ID	Kab. Tulungagung	050000
051601	3	ID	Kec. Besuki	051600
051602	3	ID	Kec. Bandung	051600
051603	3	ID	Kec. Pakel	051600
051604	3	ID	Kec. Campur Darat	051600
051605	3	ID	Kec. Tanggung Gunung	051600
051606	3	ID	Kec. Kalidawir	051600
051607	3	ID	Kec. Pucang Laban	051600
051608	3	ID	Kec. Rejotangan	051600
051609	3	ID	Kec. Ngunut	051600
051610	3	ID	Kec. Sumbergempol	051600
051611	3	ID	Kec. Boyolangu	051600
051612	3	ID	Kec. Tulungagung	051600
051613	3	ID	Kec. Kedungwaru	051600
051614	3	ID	Kec. Ngantru	051600
051615	3	ID	Kec. Karangrejo	051600
051616	3	ID	Kec. Kauman	051600
051617	3	ID	Kec. Gondang	051600
051618	3	ID	Kec. Pagerwojo	051600
051619	3	ID	Kec. Sendang	051600
051700	2	ID	Kab. Trenggalek	050000
051701	3	ID	Kec. Panggul	051700
051702	3	ID	Kec. Munjungan	051700
051703	3	ID	Kec. Watulimo	051700
051704	3	ID	Kec. Kampak	051700
051705	3	ID	Kec. Dongko	051700
051706	3	ID	Kec. Pule	051700
051707	3	ID	Kec. Karangan	051700
051708	3	ID	Kec. Gandusari	051700
051709	3	ID	Kec. Durenan	051700
051710	3	ID	Kec. Pogalan	051700
051711	3	ID	Kec. Trenggalek	051700
051712	3	ID	Kec. Tugu	051700
051713	3	ID	Kec. Bendungan	051700
051714	3	ID	Kec. Suruh	051700
051800	2	ID	Kab. Malang	050000
051801	3	ID	Kec. Donomulyo	051800
051802	3	ID	Kec. Kalipare	051800
051803	3	ID	Kec. Pagak	051800
051804	3	ID	Kec. Bantur	051800
051805	3	ID	Kec. Gedangan	051800
051806	3	ID	Kec. Sumber Manjing Wetan	051800
051807	3	ID	Kec. Dampit	051800
051808	3	ID	Kec. Tirto Yudo	051800
051809	3	ID	Kec. Ampelgading	051800
051810	3	ID	Kec. Poncokusumo	051800
051811	3	ID	Kec. Wajak	051800
051812	3	ID	Kec. Turen	051800
051813	3	ID	Kec. Pagelaran	051800
051814	3	ID	Kec. Gondanglegi	051800
051815	3	ID	Kec. Bululawang	051800
051816	3	ID	Kec. Kepanjen	051800
051817	3	ID	Kec. Sumberpucung	051800
051818	3	ID	Kec. Kromengan	051800
051819	3	ID	Kec. Wonosari	051800
051820	3	ID	Kec. Ngajum	051800
051821	3	ID	Kec. Wagir	051800
051822	3	ID	Kec. Pakisaji	051800
051823	3	ID	Kec. Tajinan	051800
051824	3	ID	Kec. Tumpang	051800
051825	3	ID	Kec. Pakis	051800
051826	3	ID	Kec. Jabung	051800
051827	3	ID	Kec. Lawang	051800
051828	3	ID	Kec. Singosari	051800
051829	3	ID	Kec. Karangploso	051800
051830	3	ID	Kec. Dau	051800
051831	3	ID	Kec. Pujon	051800
051832	3	ID	Kec. Ngantang	051800
051833	3	ID	Kec. Kasembon	051800
051900	2	ID	Kab. Pasuruan	050000
051901	3	ID	Kec. Purwodadi	051900
051902	3	ID	Kec. Tutur	051900
051903	3	ID	Kec. Puspo	051900
051904	3	ID	Kec. Tosari	051900
051905	3	ID	Kec. Lumbang	051900
051906	3	ID	Kec. Pasrepan	051900
051907	3	ID	Kec. Kejayan	051900
051908	3	ID	Kec. Wonorejo	051900
051909	3	ID	Kec. Purwosari	051900
051910	3	ID	Kec. Prigen	051900
051911	3	ID	Kec. Sukorejo	051900
051912	3	ID	Kec. Pandaan	051900
051913	3	ID	Kec. Gempol	051900
051914	3	ID	Kec. Beji	051900
051915	3	ID	Kec. Bangil	051900
051916	3	ID	Kec. Rembang	051900
051917	3	ID	Kec. Kraton	051900
051918	3	ID	Kec. Pohjentrek	051900
051919	3	ID	Kec. Gondang Wetan	051900
051920	3	ID	Kec. Rejoso	051900
051921	3	ID	Kec. Winongan	051900
051922	3	ID	Kec. Grati	051900
051923	3	ID	Kec. Lekok	051900
051924	3	ID	Kec. Nguling	051900
052000	2	ID	Kab. Probolinggo	050000
052001	3	ID	Kec. Sukapura	052000
052002	3	ID	Kec. Sumber	052000
052003	3	ID	Kec. Kuripan	052000
052004	3	ID	Kec. Bantaran	052000
052005	3	ID	Kec. Leces	052000
052006	3	ID	Kec. Tegal Siwalan	052000
052007	3	ID	Kec. Banyu Anyar	052000
052008	3	ID	Kec. Tiris	052000
052009	3	ID	Kec. Krucil	052000
052010	3	ID	Kec. Gading	052000
052011	3	ID	Kec. Pakuniran	052000
052012	3	ID	Kec. Kota Anyar	052000
052013	3	ID	Kec. Paiton	052000
052014	3	ID	Kec. Besuk	052000
052015	3	ID	Kec. Kraksaan	052000
052016	3	ID	Kec. Krejengan	052000
052017	3	ID	Kec. Pajarakan	052000
052018	3	ID	Kec. Maron	052000
052019	3	ID	Kec. Gending	052000
052020	3	ID	Kec. Dringu	052000
052021	3	ID	Kec. Wonomerto	052000
052022	3	ID	Kec. Lumbang	052000
052023	3	ID	Kec. Tongas	052000
052024	3	ID	Kec. Sumberasih	052000
052100	2	ID	Kab. Lumajang	050000
052101	3	ID	Kec. Tempursari	052100
052102	3	ID	Kec. Pronojiwo	052100
052103	3	ID	Kec. Candipuro	052100
052104	3	ID	Kec. Pasirian	052100
052105	3	ID	Kec. Tempeh	052100
052106	3	ID	Kec. Kunir	052100
052107	3	ID	Kec. Yosowilangun	052100
052108	3	ID	Kec. Rowokangkung	052100
052109	3	ID	Kec. Tekung	052100
052110	3	ID	Kec. Lumajang	052100
052111	3	ID	Kec. Pasrujambe	052100
052112	3	ID	Kec. Senduro	052100
052113	3	ID	Kec. Padang	052100
052114	3	ID	Kec. Sukodono	052100
052115	3	ID	Kec. Jatiroto	052100
052116	3	ID	Kec. Randuagung	052100
052117	3	ID	Kec. Kedungjajang	052100
052118	3	ID	Kec. Gucialit	052100
052119	3	ID	Kec. Klakah	052100
052120	3	ID	Kec. Ranuyoso	052100
052121	3	ID	Kec. Sumbersuko	052100
052200	2	ID	Kab. Bondowoso	050000
052201	3	ID	Kec. Maesan	052200
052202	3	ID	Kec. Grujugan	052200
052203	3	ID	Kec. Tamanan	052200
052204	3	ID	Kec. Pujer	052200
052205	3	ID	Kec. Tlogosari	052200
052206	3	ID	Kec. Sukosari	052200
052207	3	ID	Kec. Tapen	052200
052208	3	ID	Kec. Wonosari	052200
052209	3	ID	Kec. Tenggarang	052200
052210	3	ID	Kec. Bondowoso	052200
052211	3	ID	Kec. Curahdami	052200
052212	3	ID	Kec. Pakem	052200
052213	3	ID	Kec. Wringin	052200
052214	3	ID	Kec. Tegalampel	052200
052215	3	ID	Kec. Klabang	052200
052216	3	ID	Kec. Prajekan	052200
052217	3	ID	Kec. Cermee	052200
052218	3	ID	Kec. Binakal	052200
052219	3	ID	Kec. Sumber Wringin	052200
052220	3	ID	Kec. Sempol	052200
052221	3	ID	Kec. Jambesari Darus Sholah	052200
052222	3	ID	Kec. Taman Krocok	052200
052223	3	ID	Kec. Botolinggo	052200
052300	2	ID	Kab. Situbondo	050000
052301	3	ID	Kec. Sumber Malang	052300
052302	3	ID	Kec. Jatibanteng	052300
052303	3	ID	Kec. Banyuglugur	052300
052304	3	ID	Kec. Besuki	052300
052305	3	ID	Kec. Suboh	052300
052306	3	ID	Kec. Mlandingan	052300
052307	3	ID	Kec. Bungatan	052300
052308	3	ID	Kec. Kendit	052300
052309	3	ID	Kec. Panarukan	052300
052310	3	ID	Kec. Situbondo	052300
052311	3	ID	Kec. Mangaran	052300
052312	3	ID	Kec. Panji	052300
052313	3	ID	Kec. Kapongan	052300
052314	3	ID	Kec. Arjasa	052300
052315	3	ID	Kec. Jangkar	052300
052316	3	ID	Kec. Asembagus	052300
052317	3	ID	Kec. Banyuputih	052300
052400	2	ID	Kab. Jember	050000
052401	3	ID	Kec. Kencong	052400
052402	3	ID	Kec. Gumuk Mas	052400
052403	3	ID	Kec. Puger	052400
052404	3	ID	Kec. Wuluhan	052400
052405	3	ID	Kec. Ambulu	052400
052406	3	ID	Kec. Tempurejo	052400
052407	3	ID	Kec. Silo	052400
052408	3	ID	Kec. Mayang	052400
052409	3	ID	Kec. Mumbulsari	052400
052410	3	ID	Kec. Jenggawah	052400
052411	3	ID	Kec. Ajung	052400
052412	3	ID	Kec. Rambipuji	052400
052413	3	ID	Kec. Balung	052400
052414	3	ID	Kec. Umbulsari	052400
052415	3	ID	Kec. Semboro	052400
052416	3	ID	Kec. Jombang	052400
052417	3	ID	Kec. Sumberbaru	052400
052418	3	ID	Kec. Tanggul	052400
052419	3	ID	Kec. Bangsalsari	052400
052420	3	ID	Kec. Panti	052400
052421	3	ID	Kec. Sukorambi	052400
052422	3	ID	Kec. Arjasa	052400
052423	3	ID	Kec. Pakusari	052400
052424	3	ID	Kec. Kalisat	052400
052425	3	ID	Kec. Ledok Ombo	052400
052426	3	ID	Kec. Sumberjambe	052400
052427	3	ID	Kec. Sukowono	052400
052428	3	ID	Kec. Jelbuk	052400
052429	3	ID	Kec. Kaliwates	052400
052430	3	ID	Kec. Sumbersari	052400
052431	3	ID	Kec. Patrang	052400
052500	2	ID	Kab. Banyuwangi	050000
052501	3	ID	Kec. Pesanggaran	052500
052502	3	ID	Kec. Bangorejo	052500
052503	3	ID	Kec. Purwoharjo	052500
052504	3	ID	Kec. Tegaldlimo	052500
052505	3	ID	Kec. Muncar	052500
052506	3	ID	Kec. Cluring	052500
052507	3	ID	Kec. Gambiran	052500
052508	3	ID	Kec. Glenmore	052500
052509	3	ID	Kec. Kalibaru	052500
052510	3	ID	Kec. Genteng	052500
052511	3	ID	Kec. Srono	052500
052512	3	ID	Kec. Rogojampi	052500
052513	3	ID	Kec. Kabat	052500
052514	3	ID	Kec. Singojuruh	052500
052515	3	ID	Kec. Sempu	052500
052516	3	ID	Kec. Songgon	052500
052517	3	ID	Kec. Glagah	052500
052518	3	ID	Kec. Banyuwangi	052500
052519	3	ID	Kec. Giri	052500
052520	3	ID	Kec. Kalipuro	052500
052521	3	ID	Kec. Wongsorejo	052500
052522	3	ID	Kec. Licin	052500
052523	3	ID	Kec. Tegalsari	052500
052524	3	ID	Kec. Siliragung	052500
052600	2	ID	Kab. Pamekasan	050000
052601	3	ID	Kec. Tlanakan	052600
052602	3	ID	Kec. Pademawu	052600
052603	3	ID	Kec. Galis	052600
052604	3	ID	Kec. Larangan	052600
052605	3	ID	Kec. Pamekasan	052600
052606	3	ID	Kec. Proppo	052600
052607	3	ID	Kec. Palengaan	052600
052608	3	ID	Kec. Pegantenan	052600
052609	3	ID	Kec. Kadur	052600
052610	3	ID	Kec. Pakong	052600
052611	3	ID	Kec. Waru	052600
052612	3	ID	Kec. Batu Marmer	052600
052613	3	ID	Kec. Pasean	052600
052700	2	ID	Kab. Sampang	050000
052701	3	ID	Kec. Sreseh	052700
052702	3	ID	Kec. Torjun	052700
052703	3	ID	Kec. Sampang	052700
052704	3	ID	Kec. Camplong	052700
052705	3	ID	Kec. Omben	052700
052706	3	ID	Kec. Kedungdung	052700
052707	3	ID	Kec. Jrengik	052700
052708	3	ID	Kec. Tambelangan	052700
052709	3	ID	Kec. Banyuates	052700
052710	3	ID	Kec. Robatal	052700
052711	3	ID	Kec. Ketapang	052700
052712	3	ID	Kec. Sokobanah	052700
052713	3	ID	Kec. Karangpenang	052700
052714	3	ID	Kec. Pangarengan	052700
052800	2	ID	Kab. Sumenep	050000
052801	3	ID	Kec. Pragaan	052800
052802	3	ID	Kec. Bluto	052800
052803	3	ID	Kec. Saronggi	052800
052804	3	ID	Kec. Giligenteng	052800
052805	3	ID	Kec. Talango	052800
052806	3	ID	Kec. Kalianget	052800
052807	3	ID	Kec. Kota Sumenep	052800
052808	3	ID	Kec. Lenteng	052800
052809	3	ID	Kec. Ganding	052800
052810	3	ID	Kec. Guluk Guluk	052800
052811	3	ID	Kec. Pasongsongan	052800
052812	3	ID	Kec. Ambunten	052800
052813	3	ID	Kec. Rubaru	052800
052814	3	ID	Kec. Dasuk	052800
052815	3	ID	Kec. Manding	052800
052816	3	ID	Kec. Batuputih	052800
052817	3	ID	Kec. Gapura	052800
052818	3	ID	Kec. Batang Batang	052800
052819	3	ID	Kec. Dungkek	052800
052820	3	ID	Kec. Nonggunong	052800
052821	3	ID	Kec. Gayam	052800
052822	3	ID	Kec. Ra As	052800
052823	3	ID	Kec. Sapeken	052800
052824	3	ID	Kec. Arjasa	052800
052825	3	ID	Kec. Masalembu	052800
052827	3	ID	Kec. Batuan	052800
052828	3	ID	Kec. Kangayan	052800
052900	2	ID	Kab. Bangkalan	050000
052901	3	ID	Kec. Kamal	052900
052902	3	ID	Kec. Labang	052900
052903	3	ID	Kec. Kwanyar	052900
052904	3	ID	Kec. Modung	052900
052905	3	ID	Kec. Blega	052900
052906	3	ID	Kec. Konang	052900
052907	3	ID	Kec. Galis	052900
052908	3	ID	Kec. Tanah Merah	052900
052909	3	ID	Kec. Tragah	052900
052910	3	ID	Kec. Socah	052900
052911	3	ID	Kec. Bangkalan	052900
052912	3	ID	Kec. Burneh	052900
052913	3	ID	Kec. Arosbaya	052900
052914	3	ID	Kec. Geger	052900
052915	3	ID	Kec. Kokop	052900
052916	3	ID	Kec. Tanjungbumi	052900
052917	3	ID	Kec. Sepulu	052900
052918	3	ID	Kec. Klampis	052900
056000	2	ID	Kota Surabaya	050000
056001	3	ID	Kec. Karang Pilang	056000
056002	3	ID	Kec. Jambangan	056000
056003	3	ID	Kec. Gayungan	056000
056004	3	ID	Kec. Wonocolo	056000
056005	3	ID	Kec. Tenggilis Mejoyo	056000
056006	3	ID	Kec. Gununganyar	056000
056007	3	ID	Kec. Rungkut	056000
056008	3	ID	Kec. Sukolilo	056000
056009	3	ID	Kec. Mulyorejo	056000
056010	3	ID	Kec. Gubeng	056000
056011	3	ID	Kec. Wonokromo	056000
056012	3	ID	Kec. Dukuh Pakis	056000
056013	3	ID	Kec. Wiyung	056000
056014	3	ID	Kec. Lakarsantri	056000
056015	3	ID	Kec. Tandes	056000
056016	3	ID	Kec. Sukomanunggal	056000
056017	3	ID	Kec. Sawahan	056000
056018	3	ID	Kec. Tegal Sari	056000
056019	3	ID	Kec. Genteng	056000
056020	3	ID	Kec. Tambaksari	056000
056021	3	ID	Kec. Kenjeran	056000
056022	3	ID	Kec. Simokerto	056000
056023	3	ID	Kec. Semampir	056000
056024	3	ID	Kec. Pabean Cantian	056000
056025	3	ID	Kec. Bubutan	056000
056026	3	ID	Kec. Krembangan	056000
056027	3	ID	Kec. Asemrowo	056000
056028	3	ID	Kec. Benowo	056000
056029	3	ID	Kec. Bulak	056000
056030	3	ID	Kec. Pakal	056000
056031	3	ID	Kec. Sambi Kerep	056000
056100	2	ID	Kota Malang	050000
056101	3	ID	Kec. Kedungkandang	056100
056102	3	ID	Kec. Sukun	056100
056103	3	ID	Kec. Klojen	056100
056104	3	ID	Kec. Blimbing	056100
056105	3	ID	Kec. Lowokwaru	056100
056200	2	ID	Kota Madiun	050000
056201	3	ID	Kec. Manguharjo	056200
056202	3	ID	Kec. Taman	056200
056203	3	ID	Kec. Kartoharjo	056200
056300	2	ID	Kota Kediri	050000
056301	3	ID	Kec. Mojoroto	056300
056302	3	ID	Kec. Kota Kediri	056300
056303	3	ID	Kec. Pesantren	056300
056400	2	ID	Kota Mojokerto	050000
056401	3	ID	Kec. Prajurit Kulon	056400
056402	3	ID	Kec. Magersari	056400
056500	2	ID	Kota Blitar	050000
056501	3	ID	Kec. Sukorejo	056500
056502	3	ID	Kec. Kepanjen Kidul	056500
056503	3	ID	Kec. Sanan Wetan	056500
056600	2	ID	Kota Pasuruan	050000
056601	3	ID	Kec. Gadingrejo	056600
056602	3	ID	Kec. Purworejo	056600
056603	3	ID	Kec. Bugul Kidul	056600
056604	3	ID	Panggungrejo	      
056700	2	ID	Kota Probolinggo	050000
056701	3	ID	Kec. Kademangan	056700
056702	3	ID	Kec. Wonoasih	056700
056703	3	ID	Kec. Mayangan	056700
056704	3	ID	Kec. Kedopok	056700
056705	3	ID	Kec. Kanigaran	056700
056800	2	ID	Kota Batu	050000
056801	3	ID	Kec. Batu	056800
056802	3	ID	Kec. Junrejo	056800
056803	3	ID	Kec. Bumiaji	056800
060000	1	ID	Prov. Aceh	000000
060100	2	ID	Kab. Aceh Besar	060000
060101	3	ID	Kec. Lhoong	060100
060102	3	ID	Kec. Lho Nga	060100
060103	3	ID	Kec. Indrapuri	060100
060104	3	ID	Kec. Seulimeum	060100
060105	3	ID	Kec. Mesjid Raya	060100
060106	3	ID	Kec. Darussalam	060100
060107	3	ID	Kec. Kuta Baro	060100
060108	3	ID	Kec. Montasik	060100
060109	3	ID	Kec. Ingin Jaya	060100
060110	3	ID	Kec. Suka Makmur	060100
060111	3	ID	Kec. Darul Imarah	060100
060112	3	ID	Kec. Peukan Bada	060100
060113	3	ID	Kec. Pulo Aceh	060100
060114	3	ID	Kec. Leupung	060100
060115	3	ID	Kec. Kuta Malaka	060100
060116	3	ID	Kec. Leumbah Seulewah	060100
060117	3	ID	Kec. Kota Jantho	060100
060118	3	ID	Kec. Baitussalam	060100
060119	3	ID	Kec. Krung Barona Jaya	060100
060120	3	ID	Kec. Simpang Tiga	060100
060121	3	ID	Kec. Kuta Cot Glie	060100
060122	3	ID	Kec. Darul Kamal	060100
060123	3	ID	Kec. Blang Bintang	060100
060200	2	ID	Kab. Pidie	060000
060201	3	ID	Kec. Geumpang	060200
060207	3	ID	Kec. Glumpang Tiga	060200
060208	3	ID	Kec. Mutiara	060200
060209	3	ID	Kec. Tiro/Truseb	060200
060210	3	ID	Kec. Tangse	060200
060212	3	ID	Kec. Sakti	060200
060213	3	ID	Kec. Mila	060200
060214	3	ID	Kec. Padang Tiji	060200
060215	3	ID	Kec. Delima	060200
060216	3	ID	Kec. Indrajaya	060200
060217	3	ID	Kec. Peukan Baru	060200
060218	3	ID	Kec. Kembang Tanjung	060200
060219	3	ID	Kec. Simpang Tiga	060200
060220	3	ID	Kec. Kota Sigli	060200
060221	3	ID	Kec. Pidie	060200
060222	3	ID	Kec. Batee	060200
060223	3	ID	Kec. Muara Tiga	060200
060224	3	ID	Kec. Mane	060200
060227	3	ID	Kec. Grong-Grong	060200
060228	3	ID	Kec. Mutiara Timur	060200
060230	3	ID	Kec. Glupang Baro	060200
060231	3	ID	Kec. Keumala	060200
060232	3	ID	Kec. Titeuae	060200
060300	2	ID	Kab. Aceh Utara	060000
060301	3	ID	Kec. Sawang	060300
060302	3	ID	Kec. Nisam	060300
060303	3	ID	Kec. Kuta Makmur	060300
060304	3	ID	Kec. Syamtalira Bayu	060300
060305	3	ID	Kec. Meurah Mulia	060300
060306	3	ID	Kec. Matangkuli	060300
060307	3	ID	Kec. Cot Girek	060300
060308	3	ID	Kec. Tanah Jambo Aye	060300
060309	3	ID	Kec. Seunudon	060300
060310	3	ID	Kec. Baktiya	060300
060312	3	ID	Kec. Tanah Luas	060300
060313	3	ID	Kec. Samudera	060300
060314	3	ID	Kec. Syamtalira Aron	060300
060315	3	ID	Kec. Tanah Pasir	060300
060316	3	ID	Kec. Langkahan	060300
060317	3	ID	Kec. Baktiya Barat	060300
060318	3	ID	Kec. Simpang Keramat	060300
060319	3	ID	Kec. Nibong	060300
060320	3	ID	Kec. Paya Bakong	060300
060321	3	ID	Kec. Muara Batu	060300
060322	3	ID	Kec. Dewantara	060300
060323	3	ID	Kec. Lhoksukon	060300
060326	3	ID	Kec. Lapang	060300
060327	3	ID	Kec. Pirak Timu	060300
060328	3	ID	Kec. Geureudong Pase	060300
060329	3	ID	Kec. Banda Baro	060300
060330	3	ID	Kec. Nisam Antara	060300
060400	2	ID	Kab. Aceh Timur	060000
060408	3	ID	Kec. Serba Jadi	060400
060409	3	ID	Kec. Birem Bayeun	060400
060410	3	ID	Kec. Rantau Selamat	060400
060411	3	ID	Kec. Peureulak	060400
060412	3	ID	Kec. Ranto Peureulak	060400
060413	3	ID	Kec. Idi Rayeuk	060400
060414	3	ID	Kec. Darul Aman	060400
060415	3	ID	Kec. Nurussalam	060400
060416	3	ID	Kec. Julok	060400
060417	3	ID	Kec. Pante Beudari	060400
060418	3	ID	Kec. Simpang Ulim	060400
060419	3	ID	Kec. Sungai Raya	060400
060420	3	ID	Kec. Peureulak Timur	060400
060421	3	ID	Kec. Peureulak Barat	060400
060422	3	ID	Kec. Banda Alam	060400
060423	3	ID	Kec. Idi Tunong	060400
060424	3	ID	Kec. Peudawa	060400
060425	3	ID	Kec. Indra Makmur	060400
060426	3	ID	Kec. Madat	060400
060428	3	ID	Kec. Simpang Jernih	060400
060429	3	ID	Kec. Darul Ihsan	060400
060430	3	ID	Kec. Peunaron	060400
060431	3	ID	Kec. Idi Timur	060400
060432	3	ID	Kec. Darul Falah	060400
060500	2	ID	Kab. Aceh Tengah	060000
060501	3	ID	Kec. Lingge	060500
060502	3	ID	Kec. Bintang	060500
060504	3	ID	Kec. Pegasing	060500
060505	3	ID	Kec. Bebesen	060500
060506	3	ID	Kec. Silih Nara	060500
060512	3	ID	Kec. Kuta Panang	060500
060513	3	ID	Kec. Ketol	060500
060514	3	ID	Kec. Celala	060500
060522	3	ID	Kec. Kebayakan	060500
060524	3	ID	Kec. Laut Tawar	060500
060525	3	ID	Kec. Atu Lintang	060500
060526	3	ID	Kec. Jagong Jeget	060500
060527	3	ID	Kec. Bies	060500
060528	3	ID	Kec. Rusip Antara	060500
060600	2	ID	Kab. Aceh Barat	060000
060605	3	ID	Kec. Johan Pahlawan	060600
060606	3	ID	Kec. Samatiga	060600
060607	3	ID	Kec. Woyla	060600
060608	3	ID	Kec. Kaway XVI	060600
060609	3	ID	Kec. Sungai Mas	060600
060610	3	ID	Kec. Bubon	060600
060611	3	ID	Kec. Arongan Lambalek	060600
060612	3	ID	Kec. Meureubo	060600
060613	3	ID	Kec. Pantee Ceureumen	060600
060614	3	ID	Kec. Woyla Barat	060600
060615	3	ID	Kec. Woyla Timur	060600
060616	3	ID	Kec. Panton Reu	060600
060700	2	ID	Kab. Aceh Selatan	060000
060701	3	ID	Kec. Trumon	060700
060702	3	ID	Kec. Bakongan	060700
060703	3	ID	Kec. Kluet Selatan	060700
060704	3	ID	Kec. Kluet Utara	060700
060705	3	ID	Kec. Tapak Tuan	060700
060706	3	ID	Kec. Samadua	060700
060707	3	ID	Kec. Sawang	060700
060708	3	ID	Kec. Meukek	060700
060709	3	ID	Kec. Labuhan Haji	060700
060710	3	ID	Kec. Pasie Raja	060700
060711	3	ID	Kec. Trumon Timur	060700
060712	3	ID	Kec. Kluet Timur	060700
060713	3	ID	Kec. Bakongan Timur	060700
060714	3	ID	Kec. Kluet Tengah	060700
060715	3	ID	Kec. Labuhan Haji Barat	060700
060716	3	ID	Kec. Labuhan Haji Timur	060700
060717	3	ID	Kec. Kota Bahagia	060700
060718	3	ID	Kec. Trumon Tengah	060700
060800	2	ID	Kab. Aceh Tenggara	060000
060801	3	ID	Kec. Lawe Alas	060800
060802	3	ID	Kec. Lawe Sigala-Gala	060800
060803	3	ID	Kec. Bambel	060800
060804	3	ID	Kec. Babussalam	060800
060805	3	ID	Kec. Badar	060800
060806	3	ID	Kec. Darul Hasanah	060800
060807	3	ID	Kec. Babul Makmur	060800
060808	3	ID	Kec. Lawe Bulan	060800
060809	3	ID	Kec. Bukit Tusam	060800
060810	3	ID	Kec. Semadam	060800
060811	3	ID	Kec. Babul Rahmat	060800
060822	3	ID	Kec. Ketambe	060800
060823	3	ID	Kec. Deleng Pokhkisen	060800
060824	3	ID	Kec. Lawe Sumur	060800
060825	3	ID	Kec. Tanoh Alas	060800
060826	3	ID	Kec. Lueser	060800
061100	2	ID	Kab. Simeulue	060000
061101	3	ID	Kec. Teupah Selatan	061100
061102	3	ID	Kec. Simeulue Timur	061100
061103	3	ID	Kec. Simeulue Tengah	061100
061104	3	ID	Kec. Salang	061100
061105	3	ID	Kec. Simeulue Barat	061100
061106	3	ID	Kec. Teupah Barat	061100
061107	3	ID	Kec. Teluk Dalam	061100
061108	3	ID	Kec. Alafan	061100
061200	2	ID	Kab. Bireuen	060000
061201	3	ID	Kec. Samalanga	061200
061202	3	ID	Kec. Pandrah	061200
061203	3	ID	Kec. Jeunib	061200
061204	3	ID	Kec. Peudada	061200
061205	3	ID	Kec. Juli	061200
061206	3	ID	Kec. Jeumpa	061200
061207	3	ID	Kec. Jangka	061200
061208	3	ID	Kec. Peusangan	061200
061209	3	ID	Kec. Makmur	061200
061210	3	ID	Kec. Ganda Pura	061200
061211	3	ID	Kec. Simpang Mamplam	061200
061212	3	ID	Kec. Peulimbang	061200
061213	3	ID	Kec. Kota Juang	061200
061214	3	ID	Kec. Kuala	061200
061215	3	ID	Kec. Peusangan Selatan	061200
061216	3	ID	Kec. Peusangan Siblah Krueng	061200
061217	3	ID	Kec. Kuta Blang	061200
061300	2	ID	Kab. Aceh Singkil	060000
061301	3	ID	Kec. Pulau Banyak	061300
061302	3	ID	Kec. Singkil	061300
061303	3	ID	Kec. Simpang Kanan	061300
061305	3	ID	Kec. Singkil Utara	061300
061306	3	ID	Kec. Gunung Mariah	061300
061307	3	ID	Kec. Danau Paris	061300
061308	3	ID	Kec. Suro Makmur	061300
061312	3	ID	Kec. Kuta Baharu	061300
061313	3	ID	Kec. Singkohor	061300
061317	3	ID	Kec. Kuala Baru	061300
061318	3	ID	Pulau Banyak Barat	061300
061400	2	ID	Kab. Aceh Tamiang	060000
061401	3	ID	Kec. Tamiang Hulu	061400
061402	3	ID	Kec. Kejuruan Muda	061400
061403	3	ID	Kec. Kota Kuala Simpang	061400
061404	3	ID	Kec. Seruway	061400
061405	3	ID	Kec. Bendahara	061400
061406	3	ID	Kec. Karang Baru	061400
061407	3	ID	Kec. Manyak Payed	061400
061408	3	ID	Kec. Rantau	061400
061412	3	ID	Kec. Bandar Mulya	061400
061413	3	ID	Kec. Bandar Pusaka	061400
061414	3	ID	Kec. Tenggulun	061400
061415	3	ID	Kec. Sekerak	061400
061500	2	ID	Kab. Nagan Raya	060000
061501	3	ID	Kec. Darul Makmur	061500
061502	3	ID	Kec. Kuala	061500
061503	3	ID	Kec. Beutong	061500
061504	3	ID	Kec. Seunagan	061500
061505	3	ID	Kec. Seunagan Timur	061500
061506	3	ID	Kec. Kuala Pesisir	061500
061507	3	ID	Kec. Tadu Raya	061500
061508	3	ID	Kec. Suka Makmue	061500
061509	3	ID	Kec. Tripa Makmur	061500
061600	2	ID	Kab. Aceh Jaya	060000
061601	3	ID	Kec. Teunom	061600
061602	3	ID	Kec. Krueng Sabee	061600
061603	3	ID	Kec. Setia Bakti	061600
061604	3	ID	Kec. Sampoiniet	061600
061605	3	ID	Kec. Jaya	061600
061606	3	ID	Kec. Panga	061600
061607	3	ID	Kec. Indra Jaya	061600
061608	3	ID	Kec. Darul Hikmah	061600
061609	3	ID	Kec. Pasie Raya	061600
061700	2	ID	Kab. Aceh Barat Daya	060000
061701	3	ID	Kec. Manggeng	061700
061702	3	ID	Kec. Tangan-Tangan	061700
061703	3	ID	Kec. Blang Pidie	061700
061704	3	ID	Kec. Susoh	061700
061705	3	ID	Kec. Kuala Batee	061700
061706	3	ID	Kec. Babah Rot	061700
061707	3	ID	Kec. Lembah Sabil	061700
061708	3	ID	Kec. Setia Bakti	061700
061709	3	ID	Kec. Jeumpa	061700
061800	2	ID	Kab. Gayo Lues	060000
061801	3	ID	Kec. Blang Kejeran	061800
061802	3	ID	Kec. Kuta Panjang	061800
061803	3	ID	Kec. Rikit Gaib	061800
061804	3	ID	Kec. Terangon	061800
061805	3	ID	Kec. Pinding	061800
061806	3	ID	Kec. Blang Jerango	061800
061807	3	ID	Kec. Puteri Betung	061800
061808	3	ID	Kec. Dabung Gelang	061800
061809	3	ID	Kec. Blang Pegayon	061800
061810	3	ID	Kec. Pantan Cuaca	061800
061811	3	ID	Kec. Tripe Jaya	061800
061900	2	ID	Kab. Bener Meriah	060000
061901	3	ID	Kec. Timang Gajah	061900
061902	3	ID	Kec. Bukit	061900
061903	3	ID	Kec. Bandar	061900
061904	3	ID	Kec. Permata	061900
061905	3	ID	Kec. Pintu Rime Gayo	061900
061906	3	ID	Kec. Wih Pesam	061900
061907	3	ID	Kec. Syiah Utama	061900
061908	3	ID	Bener Kelipah	061900
061909	3	ID	Mesidah	061900
061910	3	ID	Gajah Putih	061900
062000	2	ID	Kab. Pidie Jaya	060000
062001	3	ID	Kec. Meureudu	062000
062002	3	ID	Kec. Ulim	062000
062003	3	ID	Kec. Jangka Buya	062000
062004	3	ID	Kec. Bandar Dua	062000
062005	3	ID	Kec. Meurah Dua	062000
062006	3	ID	Kec. Bandar Baru	062000
062007	3	ID	Kec. Panteraja	062000
062008	3	ID	Kec. Trienggadeng	062000
066000	2	ID	Kota Sabang	060000
066001	3	ID	Kec. Sukajaya	066000
066002	3	ID	Kec. Sukakarya	066000
066100	2	ID	Kota Banda Aceh	060000
066101	3	ID	Kec. Meuraxa	066100
066102	3	ID	Kec. Baiturrahman	066100
066103	3	ID	Kec. Kuta Alam	066100
066104	3	ID	Kec. Syiah Kuala	066100
066105	3	ID	Kec. Kuta Raja	066100
066106	3	ID	Kec. Ulee Kareng	066100
066107	3	ID	Kec. Lueng Bata	066100
066108	3	ID	Kec. Banda Raya	066100
066109	3	ID	Kec. Jaya Baru	066100
066200	2	ID	Kota Lhokseumawe	060000
066201	3	ID	Kec. Blang Mangat	066200
066202	3	ID	Kec. Muara Dua	066200
066203	3	ID	Kec. Banda Sakti	066200
066204	3	ID	Kec. Muara Satu	066200
066300	2	ID	Kota Langsa	060000
066301	3	ID	Kec. Langsa Timur	066300
066302	3	ID	Kec. Langsa Barat	066300
066303	3	ID	Kec. Langsa Kota	066300
066304	3	ID	Kec. Langsa Lama	066300
066305	3	ID	Kec. Langsa Baro	066300
066400	2	ID	Kab. Sabussalam	060000
066401	3	ID	Simpang Kiri	066400
066402	3	ID	Penanggalan	066400
066403	3	ID	Rundeng	066400
066404	3	ID	Sultan Daulat	066400
066405	3	ID	Longkib	066400
070000	1	ID	Prov. Sumatera Utara	000000
070100	2	ID	Kab. Deli Serdang	070000
070101	3	ID	Kec. Gunung Meriah	070100
070102	3	ID	Kec. Sinembah Tanjung Muda Hul	070100
070103	3	ID	Kec. Sibolangit	070100
070104	3	ID	Kec. KutaIimbaru	070100
070105	3	ID	Kec. Pancur Batu	070100
070106	3	ID	Kec. Namo Rambe	070100
070107	3	ID	Kec. Sibiru-biru	070100
070109	3	ID	Kec. Bangun Purba	070100
070119	3	ID	Kec. Galang	070100
070120	3	ID	Kec. Tanjung Morawa	070100
070121	3	ID	Kec. Patumbak	070100
070122	3	ID	Kec. Deli Tua	070100
070123	3	ID	Kec. Sunggal	070100
070124	3	ID	Kec. Hamparan Perak	070100
070125	3	ID	Kec. Labuhan Deli	070100
070126	3	ID	Kec. Percut Sei Tuan	070100
070127	3	ID	Kec. Batang Kuis	070100
070128	3	ID	Kec. Pantai Labu	070100
070129	3	ID	Kec. Beringin	070100
070130	3	ID	Kec. Lubuk Pakam	070100
070131	3	ID	Kec. Pagar Marbau	070100
070132	3	ID	STM Hilir	070100
070200	2	ID	Kab. Langkat	070000
070201	3	ID	Kec. Bohorok	070200
070202	3	ID	Kec. Salapian	070200
070203	3	ID	Kec. Sei Bingai	070200
070204	3	ID	Kec. Kuala	070200
070205	3	ID	Kec. Selesai	070200
070206	3	ID	Kec. Binjai	070200
070207	3	ID	Kec. Stabat	070200
070208	3	ID	Kec. Wampu	070200
070209	3	ID	Kec. Batang Serangan	070200
070210	3	ID	Kec. Sawit Seberang	070200
070211	3	ID	Kec. Padang Tualang	070200
070212	3	ID	Kec. Hinai	070200
070213	3	ID	Kec. Secanggang	070200
070214	3	ID	Kec. Tanjung Pura	070200
070215	3	ID	Kec. Gebang	070200
070216	3	ID	Kec. Sei Lepan	070200
070217	3	ID	Kec. Babalan	070200
070218	3	ID	Kec. Berandan Barat	070200
070219	3	ID	Kec. Besitang	070200
070220	3	ID	Kec. Pangkalan Susu	070200
070221	3	ID	Kec. Serapit	070200
070222	3	ID	Kec. Kutambaru	070200
070223	3	ID	Kec. Pematang Jaya	070200
070300	2	ID	Kab. Karo	070000
070301	3	ID	Kec. Mardinding	070300
070302	3	ID	Kec. Laubaleng	070300
070303	3	ID	Kec. Tiga Binanga	070300
070304	3	ID	Kec. Juhar	070300
070305	3	ID	Kec. Munte	070300
070306	3	ID	Kec. Kuta Buluh	070300
070307	3	ID	Kec. Payung	070300
070308	3	ID	Kec. Simpang Empat	070300
070309	3	ID	Kec. Kabanjahe	070300
070310	3	ID	Kec. Berastagi	070300
070311	3	ID	Kec. Tiga Panah	070300
070312	3	ID	Kec. Merek	070300
070313	3	ID	Kec. Barus Jahe	070300
070314	3	ID	Kec. Tiga Binanga	070300
070315	3	ID	Kec. Naman Teran	070300
070316	3	ID	Kec. Merdeka	070300
070317	3	ID	Kec. Dolat Rayat	070300
070390	3	ID	Tiganderket	      
070400	2	ID	Kab. Simalungun	070000
070401	3	ID	Kec. Silimakuta	070400
070402	3	ID	Kec. Purba	070400
070403	3	ID	Kec. Dolok Pardamean	070400
070404	3	ID	Kec. Sidamanik	070400
070405	3	ID	Kec. Girsang Simpangan Bolon	070400
070406	3	ID	Kec. Tanah Jawa	070400
070407	3	ID	Kec. Dolok Panribuan	070400
070408	3	ID	Kec. Jorlang Hataran	070400
070409	3	ID	Kec. Pane	070400
070410	3	ID	Kec. Raya	070400
070411	3	ID	Kec. Dolok Silau	070400
070412	3	ID	Kec. Silau Kahean	070400
070413	3	ID	Kec. Raya Kahean	070400
070414	3	ID	Kec. Tapian Dolok	070400
070415	3	ID	Kec. Dolok Batu Nanggar	070400
070416	3	ID	Kec. Siantar	070400
070417	3	ID	Kec. Hutabayu Raja	070400
070418	3	ID	Kec. Pematang Bandar	070400
070419	3	ID	Kec. Bandar	070400
070420	3	ID	Kec. Bosar Maligas	070400
070421	3	ID	Kec. Ujung Padang	070400
070422	3	ID	Kec. Panombeian Pane	070400
070423	3	ID	Kec. Gunung Malela	070400
070424	3	ID	Kec. Gunung Maligas	070400
070425	3	ID	Kec. Bandar Huluan	070400
070426	3	ID	Kec. Bandar Masilam	070400
070427	3	ID	Kec. Hatonduhan	070400
070428	3	ID	Kec. Jawa Maraja Bah Jambi	070400
070429	3	ID	Kec. Haranggaol Horison	070400
070430	3	ID	Kec. Pematang Sidamanik	070400
070431	3	ID	Pamatang Silima Huta	070400
070500	2	ID	Kab. Dairi	070000
070503	3	ID	Kec. Sidikalang	070500
070504	3	ID	Kec. Parbuluan	070500
070505	3	ID	Kec. Sumbul	070500
070506	3	ID	Kec. Pegangan Hilir	070500
070507	3	ID	Kec. Siempat Nempu Hulu	070500
070508	3	ID	Kec. Siempat Nempu	070500
070509	3	ID	Kec. Silima Pungga-Pungga	070500
070510	3	ID	Kec. Siempat Nempu Hilir	070500
070511	3	ID	Kec. Tigalingga	070500
070512	3	ID	Kec. Tanah Pinem	070500
070513	3	ID	Kec. Lae Parira	070500
070514	3	ID	Kec. Gunung Stember	070500
070515	3	ID	Kec. Berampu	070500
070516	3	ID	Kec. Sitinjo	070500
070517	3	ID	Silahi Sabungan	070500
070590	3	ID	Merek	      
070600	2	ID	Kab. Asahan	070000
070601	3	ID	Kec. Bandar Pasir Mandoge	070600
070602	3	ID	Kec. Bandar Pulau	070600
070603	3	ID	Kec. Pulau Rakyat	070600
070604	3	ID	Kec. Sei Kepayang	070600
070605	3	ID	Kec. Tanjung Balai	070600
070606	3	ID	Kec. Simpang Empat	070600
070607	3	ID	Kec. Air Batu	070600
070608	3	ID	Kec. Buntu Pane	070600
070609	3	ID	Kec. Meranti	070600
070610	3	ID	Kec. Air Joman	070600
070619	3	ID	Kec. Aek Kuasan	070600
070621	3	ID	Kec. Kisaran Barat	070600
070622	3	ID	Kec. Kisaran Timur	070600
070623	3	ID	Kec. Aek Songsongan	070600
070624	3	ID	Kec. Rahuning	070600
070625	3	ID	Kec. Aek Ledong	070600
070626	3	ID	Kec. Sei Kepayang Barat	070600
070627	3	ID	Kec. Sei Kepayang Timur	070600
070628	3	ID	Kec. Teluk Dalam	070600
070629	3	ID	Kec. Sei dadap	070600
070630	3	ID	Kec. Tinggi Raja	070600
070631	3	ID	Kec. Setia Janji	070600
070632	3	ID	Kec. Pulo Bandring	070600
070633	3	ID	Kec. Rawang Panca Arga	070600
070634	3	ID	Kec. Silo Laut	070600
070700	2	ID	Kab. Labuhan Batu	070000
070705	3	ID	Kec. Bilah Hulu	070700
070707	3	ID	Kec. Pangkatan	070700
070708	3	ID	Kec. Bilah Barat	070700
070713	3	ID	Kec. Bilah Hilir	070700
070714	3	ID	Kec. Panai Hulu	070700
070715	3	ID	Kec. Panai Tengah	070700
070716	3	ID	Kec. Panai Hilir	070700
070721	3	ID	Kec. Rantau Selatan	070700
070722	3	ID	Kec. Rantau Utara	070700
070800	2	ID	Kab. Tapanuli Utara	070000
070803	3	ID	Kec. Parmonangan	070800
070804	3	ID	Kec. Adian Koting	070800
070805	3	ID	Kec. Sipoholon	070800
070806	3	ID	Kec. Tarutung	070800
070807	3	ID	Kec. Pahae Jae	070800
070808	3	ID	Kec. Pahae Julu	070800
070809	3	ID	Kec. Pangaribuan	070800
070810	3	ID	Kec. Garoga	070800
070811	3	ID	Kec. Sipahutar	070800
070812	3	ID	Kec. Siborong-Borong	070800
070813	3	ID	Kec. Pagaran	070800
070818	3	ID	Kec. Muara	070800
070819	3	ID	Kec. Purbatua	070800
070822	3	ID	Kec. Simangumban	070800
070823	3	ID	Kec. Siatas Barita	070800
070900	2	ID	Kab. Tapanuli Tengah	070000
070901	3	ID	Kec. Lumut	070900
070902	3	ID	Kec. Sibabangun	070900
070903	3	ID	Kec. Pandan	070900
070904	3	ID	Kec. Tapian Nauli	070900
070905	3	ID	Kec. Kolang	070900
070906	3	ID	Kec. Sorkam	070900
070907	3	ID	Kec. Barus	070900
070908	3	ID	Kec. Manduamas	070900
070909	3	ID	Kec. Sosor Gadong	070900
070910	3	ID	Kec. Sorkam Barat	070900
070911	3	ID	Kec. Andam Dewi	070900
070912	3	ID	Kec. Badiri	070900
070913	3	ID	Kec. Sitahuis	070900
070914	3	ID	Kec. Sirandorung	070900
070915	3	ID	Kec. Tukka	070900
070916	3	ID	Kec. Pinang Sori	070900
070917	3	ID	Kec. Sukabangun	070900
070918	3	ID	Kec. Sarudik	070900
070919	3	ID	Kec. Barus Utara	070900
070920	3	ID	Pasaribu Tobing	070900
071000	2	ID	Kab. Tapanuli Selatan	070000
071001	3	ID	Kec. Batang Angkola	071000
071010	3	ID	Kec. Batang Toru	071000
071011	3	ID	Kec. Sipirok	071000
071012	3	ID	Kec. Arse	071000
071016	3	ID	Kec. Saipar Dolok Hole	071000
071025	3	ID	Kec. Marancar	071000
071026	3	ID	Kec. Sayur Matinggi	071000
071027	3	ID	Kec. Aek Bilah	071000
071029	3	ID	Kec. Muaro Batang Toru	071000
071030	3	ID	Angkola Barat	071000
071031	3	ID	Angkola Sangkunur	071000
071032	3	ID	Angkola Selatan	071000
071033	3	ID	Angkola Timur	071000
071034	3	ID	Tantom Angkola	071000
071100	2	ID	Kab. Nias	070000
071106	3	ID	Kec. Idano Gawo	071100
071107	3	ID	Kec. Gido	071100
071113	3	ID	Kec. Hiliduho	071100
071119	3	ID	Kec. Bawalato	071100
071123	3	ID	Kec. Ulugawo	071100
071125	3	ID	Kec. Ma U	071100
071126	3	ID	Kec. Somolo-Molo	071100
071132	3	ID	Kec. Hili Serangkai	071100
071133	3	ID	Kec. Botomuzoi	071100
071190	3	ID	Sogaeadu	      
071500	2	ID	Kab. Mandailing Natal	070000
071501	3	ID	Kec. Batahan	071500
071502	3	ID	Kec. Batang Natal	071500
071503	3	ID	Kec. Kotanopan	071500
071504	3	ID	Kec. Muara Sipongi	071500
071505	3	ID	Kec. Panyabungan Kota	071500
071506	3	ID	Kec. Natal	071500
071507	3	ID	Kec. Muara Batang Gadis	071500
071508	3	ID	Kec. Siabu	071500
071509	3	ID	Kec. Panyabungan Utara	071500
071510	3	ID	Kec. Panyabungan Barat	071500
071511	3	ID	Kec. Panyabungan Timur	071500
071512	3	ID	Kec. Panyabungan Selatan	071500
071513	3	ID	Kec. Bukit Malintang	071500
071514	3	ID	Kec. Lembah Sorik Merapi	071500
071515	3	ID	Kec. Ulu Pungut	071500
071516	3	ID	Kec. Tambangan	071500
071517	3	ID	Kec. Langga Bayu	071500
071600	2	ID	Kab. Toba Samosir	070000
071603	3	ID	Kec. Balige	071600
071604	3	ID	Kec. Lagu Boti	071600
071605	3	ID	Kec. Habinsaran	071600
071606	3	ID	Kec. Silaen	071600
071607	3	ID	Kec. Porsea	071600
071608	3	ID	Kec. Lumban Julu	071600
071616	3	ID	Kec. Uluan	071600
071617	3	ID	Kec. Pintu Pohan Meranti	071600
071618	3	ID	Kec. Ajibata	071600
071619	3	ID	Kec. Borbor	071600
071620	3	ID	Kec. Tampahan	071600
071621	3	ID	Kec. Nassau	071600
071622	3	ID	Kec. Sigumpar	071600
071623	3	ID	Kec. Siantar Narumonda	071600
071624	3	ID	Kec. Parmaksian	071600
071625	3	ID	Kec. Bonatua Lunasi	071600
071700	2	ID	Kab. Nias Selatan	070000
071701	3	ID	Kec. Pulau-Pulau Batu	071700
071702	3	ID	Kec. Teluk Dalam	071700
071703	3	ID	Kec. Amandraya	071700
071704	3	ID	Kec. Lahusa	071700
071705	3	ID	Kec. Gomo	071700
071706	3	ID	Kec. Lolomatua	071700
071707	3	ID	Kec. Lolowa`U	071700
071708	3	ID	Kec. Hibala	071700
071709	3	ID	Kec. Susua	071700
071710	3	ID	Kec. Maniamolo	071700
071711	3	ID	Kec. Hilimegai	071700
071712	3	ID	Kec. Toma	071700
071713	3	ID	Kec. Mazino	071700
071714	3	ID	Kec. Umbunasi	071700
071715	3	ID	Kec. Aramo	071700
071716	3	ID	Kec. Pulau-Pulau Batu Timur	071700
071717	3	ID	Kec. Mazo	071700
071718	3	ID	Kec. Fanayama	071700
071800	2	ID	Kab. Pak pak Bharat	070000
071801	3	ID	Kec. Salak	071800
071802	3	ID	Kec. Kerajaan	071800
071803	3	ID	Kec. Sitelutali Urang Jehe	071800
071804	3	ID	Kec. Sitelutali Urang Jehe	071800
071805	3	ID	Kec. Pangindar	071800
071806	3	ID	Kec. Pergetteng-getteng Sengku	071800
071807	3	ID	Kec. Tinada	071800
071808	3	ID	Kec. Siempat Rube	071800
071899	3	ID	Sitelu Tali Urang Julu	      
071900	2	ID	Kab. Humbang Hasudutan	070000
071901	3	ID	Kec. Pakkat	071900
071902	3	ID	Kec. Onan Ganjang	071900
071903	3	ID	Kec. Lintong Nihuta	071900
071904	3	ID	Kec. Dolok Sanggul	071900
071905	3	ID	Kec. Parlilitan	071900
071906	3	ID	Kec. Pollung	071900
071907	3	ID	Kec. Paranginan	071900
071908	3	ID	Kec. Bakti Raja	071900
071909	3	ID	Kec. Sijamapolang	071900
071910	3	ID	Kec. Tarabintang	071900
072000	2	ID	Kab. Samosir	070000
072001	3	ID	Kec. Harian	072000
072002	3	ID	Kec. Sianjur Mula Mula	072000
072003	3	ID	Kec. Onan Runggu Timur	072000
072004	3	ID	Kec. Palipi	072000
072005	3	ID	Kec. Pangururan	072000
072006	3	ID	Kec. Simanindo	072000
072007	3	ID	Kec. Nainggolan	072000
072008	3	ID	Kec. Ronggur Nihuta	072000
072009	3	ID	Kec. Sitiotio	072000
072100	2	ID	Kab. Serdang Bedagai	070000
072101	3	ID	Kec. Kotarih	072100
072102	3	ID	Kec. Dolok Masihul	072100
072103	3	ID	Kec. Sipispis	072100
072104	3	ID	Kec. Dolok Merawan	072100
072105	3	ID	Kec. Tebing Tinggi	072100
072106	3	ID	Kec. Bandar Khalifah	072100
072107	3	ID	Kec. Tanjung Beringin	072100
072108	3	ID	Kec. Teluk Mengkudu	072100
072109	3	ID	Kec. Sei Rampah	072100
072110	3	ID	Kec. Perbaungan	072100
072111	3	ID	Kec. Pantai Cermin	072100
072112	3	ID	Kec. Silinda	072100
072113	3	ID	Kec. Bintang Bayu	072100
072114	3	ID	Kec. Serbajadi	072100
072115	3	ID	Kec. Tebing Syahbandar	072100
072116	3	ID	Kec. Sei Bamban	072100
072117	3	ID	Kec. Pegajahan	072100
072200	2	ID	Kab. Batubara	070000
072201	3	ID	Kec. Medang Deras	072200
072202	3	ID	Kec. Air Putih	072200
072203	3	ID	Kec. Lima Puluh	072200
072204	3	ID	Kec. Sei Balai	072200
072205	3	ID	Kec. Sei Suka	072200
072206	3	ID	Kec. Talawi	072200
072207	3	ID	Kec. Tanjung Tiram	072200
072300	2	ID	Kab. Padang Lawas utara	070000
072301	3	ID	Kec. Padang Bolak Julu	072300
072302	3	ID	Kec. Padang Bolak	072300
072303	3	ID	Kec. Halongonan	072300
072304	3	ID	Kec. Dolok Sxigompulon	072300
072305	3	ID	Kec. Portibi	072300
072306	3	ID	Kec. Simangambat	072300
072307	3	ID	Kec. Batang Onang	072300
072308	3	ID	Kec. Dolok	072300
072390	3	ID	Hulu Sihapas	      
072400	2	ID	Kab. Padang Lawas	070000
072401	3	ID	Kec. Barumun	072400
072402	3	ID	Kec. Sosa	072400
072403	3	ID	Kec. Barumun Tengah	072400
072404	3	ID	Kec. Batang Lubu Sutam.	072400
072405	3	ID	Kec. Huta Raja Tinggi	072400
072406	3	ID	Kec. Lubuk Barumun	072400
072407	3	ID	Kec. Huristak	072400
072408	3	ID	Kec. Ulu Barumun	072400
072409	3	ID	Kec. Sosopan	072400
072410	3	ID	Kec. Barumun Selatan	072400
072411	3	ID	Kec. Aek Nabara Barumun	072400
072500	2	ID	Kab. Labuhan Batu Utara	070000
072501	3	ID	Kec. Na IX-X	072500
072502	3	ID	Kec. Aek Natas	072500
072503	3	ID	Kec. Aek Kuo	072500
072504	3	ID	Kec. Kualuh Hilir	072500
072505	3	ID	Kec. Kualuh Selatan	072500
072506	3	ID	Kec. Kualuh Hulu	072500
072507	3	ID	Kec. Kualuh Leidong	072500
072508	3	ID	Kec. Marbau	072500
072600	2	ID	Kab. Labuhan Batu Selatan	070000
072601	3	ID	Kec. Sungai Kanan	072600
072602	3	ID	Kec. Torgamba	072600
072603	3	ID	Kec. Kota Pinang	072600
072604	3	ID	Kec. Silangkitang	072600
072605	3	ID	Kec. Kampung Rakyat	072600
072700	2	ID	Kab. Nias Barat	070000
072701	3	ID	Kec. Lolofitu Moi	072700
072702	3	ID	Kec. Sirombu	072700
072703	3	ID	Kec. Lahomi	072700
072704	3	ID	Kec. Mandrehe	072700
072705	3	ID	Kec. Mandrehe Barat	072700
072706	3	ID	Kec. Moro O	072700
072707	3	ID	Kec. Mandrehe Barat	072700
072708	3	ID	Kec. Ulo Moro O	072700
072800	2	ID	Kab. Nias Utara	070000
072801	3	ID	Kec. Tuhemberua	072800
072802	3	ID	Kec. Lotu	072800
072803	3	ID	Kec. Sitolu Ori	072800
072804	3	ID	Kec. Sawo	072800
072805	3	ID	Kec. Alasa	072800
072806	3	ID	Kec. Namohalu Esiwa	072800
072807	3	ID	Kec. Alasa Talu Muzoi	072800
072808	3	ID	Kec. Tugala Oyo	072800
072809	3	ID	Kec. Lahewa	072800
072810	3	ID	Kec. Afulu	072800
072811	3	ID	Kec. Lahewa Timur	072800
076000	2	ID	Kota Medan	070000
076001	3	ID	Kec. Medan Tuntungan	076000
076002	3	ID	Kec. Medan Johor	076000
076003	3	ID	Kec. Medan Amplas	076000
076004	3	ID	Kec. Medan Denai	076000
076005	3	ID	Kec. Medan Area	076000
076006	3	ID	Kec. Medan Kota	076000
076007	3	ID	Kec. Medan Maimun	076000
076008	3	ID	Kec. Medan Polonia	076000
076009	3	ID	Kec. Medan Baru	076000
076010	3	ID	Kec. Medan Selayang	076000
076011	3	ID	Kec. Medan Sunggal	076000
076012	3	ID	Kec. Medan Helvetia	076000
076013	3	ID	Kec. Medan Petisah	076000
076014	3	ID	Kec. Medan Barat	076000
076015	3	ID	Kec. Medan Timur	076000
076016	3	ID	Kec. Medan Perjuangan	076000
076017	3	ID	Kec. Medan Tembung	076000
076018	3	ID	Kec. Medan Deli	076000
076019	3	ID	Kec. Medan Labuhan	076000
076020	3	ID	Kec. Medan Marelan	076000
076021	3	ID	Kec. Medan Kota Belawan	076000
076100	2	ID	Kota Binjai	070000
076101	3	ID	Kec. Binjai Selatan	076100
076102	3	ID	Kec. Binjai Kota	076100
076103	3	ID	Kec. Binjai Timur	076100
076104	3	ID	Kec. Binjai Utara	076100
076105	3	ID	Kec. Binjai Barat	076100
076200	2	ID	Kota Tebing Tinggi	070000
076201	3	ID	Kec. Padang Hulu	076200
076202	3	ID	Kec. Rambutan	076200
076203	3	ID	Kec. Padang Hilir	076200
076204	3	ID	Kec. Bajenis	076200
076205	3	ID	Kec. Tebing Tinggi Kota	076200
076300	2	ID	Kota Pematang Siantar	070000
076301	3	ID	Kec. Siantar Marihat	076300
076302	3	ID	Kec. Siantar Selatan	076300
076303	3	ID	Kec. Siantar Barat	076300
076304	3	ID	Kec. Siantar Utara	076300
076305	3	ID	Kec. Siantar Timur	076300
076306	3	ID	Kec. Siantar Martoba	076300
076307	3	ID	Kec. Siantar Marimbun	076300
076308	3	ID	Kec. Siantar Sitalasari	076300
076400	2	ID	Kota Tanjung Balai	070000
076401	3	ID	Kec. Datuk Bandar	076400
076402	3	ID	Kec. Tanjung Balai Selatan	076400
076403	3	ID	Kec. Tanjung Balai Utara	076400
076404	3	ID	Kec. S. Tualang Raso	076400
076405	3	ID	Kec. Teluk Nibung	076400
076406	3	ID	Kec. Datuk Bandar Timur	076400
076500	2	ID	Kota Sibolga	070000
076501	3	ID	Kec. Sibolga Utara	076500
076502	3	ID	Kec. Sibolga Kota	076500
076503	3	ID	Kec. Sibolga Selatan	076500
076504	3	ID	Kec. Sibolga Sambas	076500
076600	2	ID	Kota Padang Sidempuan	070000
076601	3	ID	Kec. Padang Sidimpuan Selatan	076600
076602	3	ID	Kec. Padang Sidimpuan Utara	076600
076603	3	ID	Kec. Padang Sidimpuan Batu Nad	076600
076604	3	ID	Kec. Padang Sidimpuan Hutaimba	076600
076605	3	ID	Kec. Padang Sidimpuan Tenggara	076600
076606	3	ID	Kec. Padang Sidimpuan Angkola	076600
076700	2	ID	Kota Gunung Sitoli	070000
076701	3	ID	Kec. Gunung Sitoli Idanoi	076700
076702	3	ID	Kec. Gunung Sitoli   Alo Oa	076700
076703	3	ID	Kec. Gunung Sitoli	076700
076704	3	ID	Kec. Gunung Sitoli Selatan	076700
076705	3	ID	Kec. Gunung Sitoli Barat	076700
076706	3	ID	Kec. Gunung Sitoli Utara	076700
080000	1	ID	Prov. Sumatera Barat	000000
080100	2	ID	Kab. Agam	080000
080101	3	ID	Kec. Tanjung Mutiara	080100
080102	3	ID	Kec. Lubuk Basung	080100
080103	3	ID	Kec. Tanjung Raya	080100
080104	3	ID	Kec. Matur	080100
080105	3	ID	Kec. IV Koto	080100
080107	3	ID	Kec. IV Angkat Candung	080100
080108	3	ID	Kec. Baso	080100
080109	3	ID	Kec. Tilatang Kamang	080100
080110	3	ID	Kec. Palembayan	080100
080111	3	ID	Kec. Palupuh	080100
080113	3	ID	Kec. Sungai Pua	080100
080114	3	ID	Kec. Candung	080100
080115	3	ID	Kec. Kamang Magek	080100
080116	3	ID	Kec. Banuhampu	080100
080117	3	ID	Kec. Ampek Angkek	080100
080118	3	ID	Kec. Malalak	080100
080119	3	ID	Ampek Nagari	      
080200	2	ID	Kab. Pasaman	080000
080207	3	ID	Kec. Bonjol	080200
080208	3	ID	Kec. Lubuk Sikaping	080200
080210	3	ID	Kec. II Koto	080200
080211	3	ID	Kec. Panti	080200
080212	3	ID	Kec. III Nagari	080200
080213	3	ID	Kec. Rao	080200
080214	3	ID	Kec. Mapat Tunggul	080200
080215	3	ID	Kec. Mapat Tunggul Selatan	080200
080216	3	ID	Kec. Simpang Alahan Mati	080200
080217	3	ID	Kec. Padang Gelugur	080200
080218	3	ID	Kec. Rao Utara	080200
080219	3	ID	Kec. Rao Selatan	080200
080300	2	ID	Kab. Lima Puluh Koto	080000
080301	3	ID	Kec. Payakumbuh	080300
080302	3	ID	Kec. Luak	080300
080303	3	ID	Kec. Harau	080300
080304	3	ID	Kec. Guguak	080300
080305	3	ID	Kec. Suliki	080300
080306	3	ID	Kec. Gunuang Omeh	080300
080307	3	ID	Kec. Kapur IX	080300
080308	3	ID	Kec. Pangkalan Koto Baru	080300
080309	3	ID	Kec. Bukkt Barisan	080300
080310	3	ID	Kec. Mungka	080300
080311	3	ID	Kec. Akabiluru	080300
080312	3	ID	Kec. Situjuah Limo Nagari	080300
080313	3	ID	Kec. Lareh Sago Halaban	080300
080400	2	ID	Kab. Solok	080000
080404	3	ID	Kec. Pantai Cermin	080400
080405	3	ID	Kec. Lembah Gumanti	080400
080406	3	ID	Kec. Payung Sekaki	080400
080407	3	ID	Kec. Lembang Jaya	080400
080408	3	ID	Kec. Gunung Talang	080400
080409	3	ID	Kec. Bukit Sundi	080400
080410	3	ID	Kec. Kubung	080400
080411	3	ID	Kec. IX Koto Sungai Lasi	080400
080412	3	ID	Kec. X Koto Diatas	080400
080413	3	ID	Kec. X Koto Singkarak	080400
080414	3	ID	Kec. Junjung Sirih	080400
080416	3	ID	Kec. Hiliran Gumanti	080400
080417	3	ID	Kec. Tigo Lurah	080400
080418	3	ID	Kec. Danau Kembar	080400
080500	2	ID	Kab. Padang Pariaman	080000
080501	3	ID	Kec. Batang Anai	080500
080502	3	ID	Kec. Lubuk Alung	080500
080503	3	ID	Kec. Ulakan Tapakis	080500
080504	3	ID	Kec. Nan Sabaris	080500
080505	3	ID	Kec. 2 x 11 VI Lingkung	080500
080506	3	ID	Kec. VII Koto Sungai Sarik	080500
080507	3	ID	Kec. V Koto Kampung Dalam	080500
080508	3	ID	Kec. Sungai Limau	080500
080509	3	ID	Kec. Sungai Geringging	080500
080510	3	ID	Kec. IV Koto Aur Malintang	080500
080513	3	ID	Kec. Batang Gasan	080500
080514	3	ID	Kec. V Koto Timur	080500
080515	3	ID	Kec. Patamuan	080500
080516	3	ID	Kec. Padang Sago	080500
080517	3	ID	Kec. 2 x 11 Kayu Tanam	080500
080518	3	ID	Kec. Sintuk Toboh Gadang	080500
080519	3	ID	Kec. VI Lingkung	080500
080600	2	ID	Kab. Pesisir Selatan	080000
080601	3	ID	Kec. Lunang Silaut	080600
080602	3	ID	Kec. Basa IV Balai Tapan	080600
080603	3	ID	Kec. Pancung Soal	080600
080604	3	ID	Kec. Linggo Saribaganti	080600
080605	3	ID	Kec. Ranah Pesisir	080600
080606	3	ID	Kec. Lengayang	080600
080607	3	ID	Kec. Sutera	080600
080608	3	ID	Kec. Batang Kapas	080600
080609	3	ID	Kec. IV Jurai	080600
080610	3	ID	Kec. Bayang	080600
080611	3	ID	Kec. Koto XI Terusan	080600
080612	3	ID	Kec. IV Bayang Utara	080600
080700	2	ID	Kab. Tanah Datar	080000
080701	3	ID	Kec. Sepuluh Koto	080700
080702	3	ID	Kec. Batipuh	080700
080703	3	ID	Kec. Pariangan	080700
080704	3	ID	Kec. Rambatan	080700
080705	3	ID	Kec. Lima Kaum	080700
080706	3	ID	Kec. Tanjung Mas	080700
080707	3	ID	Kec. Padang Ganting	080700
080708	3	ID	Kec. Lintau Buo	080700
080709	3	ID	Kec. Sungayang	080700
080710	3	ID	Kec. Sungai Tarab	080700
080711	3	ID	Kec. Salimpaung	080700
080712	3	ID	Kec. Batipuh Selatan	080700
080713	3	ID	Kec. Lintau Buo Utara	080700
080714	3	ID	Kec. Tanjung Baru	080700
080800	2	ID	Kab. Sawahlunto/ Sijunjung	080000
080805	3	ID	Kec. Kamang Baru	080800
080806	3	ID	Kec. Tanjung Gadang	080800
080807	3	ID	Kec. Sijunjung	080800
080808	3	ID	Kec. IV Nagari	080800
080809	3	ID	Kec. Kupitan	080800
080810	3	ID	Kec. Koto Tujuh	080800
080811	3	ID	Kec. Sumpur Kudus	080800
080812	3	ID	Kec. Lubuk Tarok	080800
081000	2	ID	Kab. Kepulauan Mentawai	080000
081001	3	ID	Kec. Pagai Utara	081000
081002	3	ID	Kec. Sipora Selatan	081000
081003	3	ID	Kec. Siberut Selatan	081000
081004	3	ID	Kec. Siberut Utara	081000
081005	3	ID	Kec. Siberut Barat	081000
081006	3	ID	Kec. Siberut Barat Daya	081000
081007	3	ID	Kec. Siberut Tengah	081000
081008	3	ID	Kec. Sipora Utara	081000
081009	3	ID	Kec. Sikakap	081000
081010	3	ID	Kec. Pagai Selatan	081000
081011	3	ID	Siberut Barat	      
081100	2	ID	Kab. Solok Selatan	080000
081101	3	ID	Kec. Sangir	081100
081102	3	ID	Kec. Sungai Pagu	081100
081103	3	ID	Kec. Koto Parik Gadang Diateh	081100
081104	3	ID	Kec. Sangir Jujuhan	081100
081105	3	ID	Kec. Sangir Batanghari	081100
081106	3	ID	Kec. Pauah Duo	081100
081107	3	ID	Kec. Sangir Balai Janggo	081100
081200	2	ID	Kab. Dharmas Raya	080000
081201	3	ID	Kec. Sungai Rumbai	081200
081202	3	ID	Kec. Koto Baru	081200
081203	3	ID	Kec. Sitiung	081200
081204	3	ID	Kec. Pulau Punjung	081200
081205	3	ID	Kec. Sembilan Koto	081200
081206	3	ID	Kec. Timpeh	081200
081207	3	ID	Kec. Koto Salak	081200
081208	3	ID	Kec. Tiumang	081200
081209	3	ID	Kec. Padang Laweh	081200
081210	3	ID	Kec. Asam Jujuhan	081200
081211	3	ID	Kec. Koto Besar	081200
081300	2	ID	Kab. Pasaman Barat	080000
081301	3	ID	Kec. Sungai Beremas	081300
081302	3	ID	Kec. Ranah Batahan	081300
081303	3	ID	Kec. Lembah Melintang	081300
081304	3	ID	Kec. Gunung Tuleh	081300
081305	3	ID	Kec. Pasaman	081300
081306	3	ID	Kec. Kinali	081300
081307	3	ID	Kec. Talamau	081300
081308	3	ID	Kec. Koto Balingka	081300
081309	3	ID	Kec. Luhak Nan Duo	081300
081310	3	ID	Kec. Sasak Ranah Pesisir	081300
081311	3	ID	Kec. Sungai Aur	081300
086000	2	ID	Kota Bukittinggi	080000
086001	3	ID	Kec. Guguk Panjang	086000
086002	3	ID	Kec. Mandiangin Koto Selayan	086000
086003	3	ID	Kec. Aur Birugo Tigo Baleh	086000
086100	2	ID	Kota Padang	080000
086101	3	ID	Kec. Bungus Teluk Kabung	086100
086102	3	ID	Kec. Lubuk Kilangan	086100
086103	3	ID	Kec. Lubuk Begalung	086100
086104	3	ID	Kec. Padang Selatan	086100
086105	3	ID	Kec. Padang Timur	086100
086106	3	ID	Kec. Padang Barat	086100
086107	3	ID	Kec. Padang Utara	086100
086108	3	ID	Kec. Nanggalo	086100
086109	3	ID	Kec. Kuranji	086100
086110	3	ID	Kec. Pauh	086100
086111	3	ID	Kec. Koto Tangah	086100
086200	2	ID	Kota Padang Panjang	080000
086201	3	ID	Kec. Padang Panjang Barat	086200
086202	3	ID	Kec. Padang Panjang Timur	086200
086300	2	ID	Kota Sawah Lunto	080000
086301	3	ID	Kec. Silungkang	086300
086302	3	ID	Kec. Lembah Segar	086300
086303	3	ID	Kec. Barangin	086300
086304	3	ID	Kec. Talawi	086300
086400	2	ID	Kota Solok	080000
086401	3	ID	Kec. Lubuk Sikarah	086400
086402	3	ID	Kec. Tanjung Harapan	086400
086500	2	ID	Kota Payakumbuh	080000
086501	3	ID	Kec. Payakumbuh Barat	086500
086502	3	ID	Kec. Payakumbuh Timur	086500
086503	3	ID	Kec. Payakumbuh Utara	086500
086504	3	ID	Kec. Lamposi Tigo Nagori	086500
086505	3	ID	Kec. Payakumbuh Selatan	086500
086600	2	ID	Kota Pariaman	080000
086601	3	ID	Kec. Pariaman Selatan	086600
086602	3	ID	Kec. Pariaman Tengah	086600
086603	3	ID	Kec. Pariaman Utara	086600
086604	3	ID	Kec. Pariaman Timur	086600
090000	1	ID	Prov. Riau	000000
090100	2	ID	Kab. Kampar	090000
090101	3	ID	Kec. XIII Koto Kampar	090100
090102	3	ID	Kec. Kampar Kiri	090100
090103	3	ID	Kec. Kampar	090100
090104	3	ID	Kec. Tambang	090100
090105	3	ID	Kec. Bangkinang	090100
090106	3	ID	Kec. Bangkinang Barat	090100
090107	3	ID	Kec. Siak Hulu	090100
090108	3	ID	Kec. Tapung	090100
090109	3	ID	Kec. Kampar Kiri Hulu	090100
090110	3	ID	Kec. Kampar Kiri Hilir	090100
090111	3	ID	Kec. Tapung Hulu	090100
090112	3	ID	Kec. Tapung Hilir	090100
090113	3	ID	Kec. Tapung Kiri	090100
090114	3	ID	Kec. Salo	090100
090115	3	ID	Kec. Rumbio Jaya	090100
090116	3	ID	Kec. Bangkinang Seberang	090100
090117	3	ID	Kec. Perhentian Raja	090100
090118	3	ID	Kec. Kampar Timur	090100
090119	3	ID	Kec. Kampar Utara	090100
090120	3	ID	Kec. Kampar Kiri Tengah	090100
090121	3	ID	Kec. Gunung Sahilan	090100
090190	3	ID	Koto Kampar Hulu	      
090200	2	ID	Kab. Bengkalis	090000
090201	3	ID	Kec. Mandau	090200
090205	3	ID	Kec. Bengkalis	090200
090206	3	ID	Kec. Bantan	090200
090207	3	ID	Kec. Bukit Batu	090200
090208	3	ID	Kec. Rupat	090200
090209	3	ID	Kec. Rupat Utara	090200
090212	3	ID	Kec. Siak Kecil	090200
090213	3	ID	Kec. Pinggir	090200
090400	2	ID	Kab. Indragiri Hulu	090000
090401	3	ID	Kec. Peranap	090400
090402	3	ID	Kec. Pasir Penyu	090400
090403	3	ID	Kec. Kelayang	090400
090404	3	ID	Kec. Seberida	090400
090405	3	ID	Kec. Rengat	090400
090406	3	ID	Kec. Rengat Barat	090400
090407	3	ID	Kec. Lirik	090400
090408	3	ID	Kec. Batang Gansal	090400
090409	3	ID	Kec. Batang Cenaku	090400
090410	3	ID	Kec. Batang Peranap	090400
090411	3	ID	Kec. Lubuk Batu Jaya	090400
090412	3	ID	Kec. Sei Lala	090400
090413	3	ID	Kec. Rakit Kulim	090400
090414	3	ID	Kec. Kuala Cenaku	090400
090500	2	ID	Kab. Indragiri Hilir	090000
090501	3	ID	Kec. Keritang	090500
090502	3	ID	Kec. Reteh	090500
090503	3	ID	Kec. Enok	090500
090504	3	ID	Kec. Tanah Merah	090500
090505	3	ID	Kec. Kuala Indragiri	090500
090506	3	ID	Kec. Tembilahan	090500
090507	3	ID	Kec. Tempuling	090500
090508	3	ID	Kec. Batang Tuaka	090500
090509	3	ID	Kec. Gaung Anak Serka	090500
090510	3	ID	Kec. Gaung	090500
090511	3	ID	Kec. Mandah	090500
090512	3	ID	Kec. Kateman	090500
090513	3	ID	Kec. Kemuning	090500
090514	3	ID	Kec. Pelangiran	090500
090515	3	ID	Kec. Pulau Burung	090500
090516	3	ID	Kec. Teluk Blengkong	090500
090517	3	ID	Kec. Tembilahan Hulu	090500
090518	3	ID	Kec. Concong	090500
090519	3	ID	Kec. Kempas	090500
090520	3	ID	Kec. Sungai Batang	090500
090800	2	ID	Kab. Pelalawan	090000
090801	3	ID	Kec. Langgam	090800
090802	3	ID	Kec. Pangkalan Kuras	090800
090803	3	ID	Kec. Bunut	090800
090804	3	ID	Kec. Kuala Kampar	090800
090805	3	ID	Kec. Pangkalan Kerinci	090800
090806	3	ID	Kec. Ukui	090800
090807	3	ID	Kec. Pangkalan Lesung	090800
090808	3	ID	Kec. Kerumutan	090800
090809	3	ID	Kec. Pelalawan	090800
090810	3	ID	Kec. Teluk Meranti	090800
090811	3	ID	Kec. Bandar Sei Kijang	090800
090812	3	ID	Kec. Bandar Petalangan	090800
090900	2	ID	Kab. Rokan Hilir	090000
090901	3	ID	Kec. Ujung Batu	090900
090902	3	ID	Kec. Rokan IV Koto	090900
090903	3	ID	Kec. Rambah	090900
090904	3	ID	Kec. Tembusai	090900
090905	3	ID	Kec. Kepenuhan	090900
090906	3	ID	Kec. Kunto Darussalam	090900
090907	3	ID	Kec. Rambah Samo	090900
090908	3	ID	Kec. Rambah Hilir	090900
090909	3	ID	Kec. Tembusai Utara	090900
090910	3	ID	Kec. Bangun Purba	090900
090911	3	ID	Kec. Tandun	090900
090912	3	ID	Kec. Kabun	090900
090913	3	ID	Kec. Bonai Darussalam	090900
090914	3	ID	Kec. Pagaran Tapah Darussalam	090900
090916	3	ID	Kec. Pendalian IV Koto	090900
090917	3	ID	Kec. Kepenuhan Hulu	090900
091000	2	ID	Kab. Siak	090000
091001	3	ID	Kec. Kubu	091000
091002	3	ID	Kec. Bangko	091000
091003	3	ID	Kec. Tanah Putih	091000
091004	3	ID	Kec. Rimba Melintang	091000
091005	3	ID	Kec. Bagan Sinembah	091000
091006	3	ID	Kec. Pasir Limau Kapas	091000
091007	3	ID	Kec. Sinaboi	091000
091008	3	ID	Kec. Tanah Putih Tanjung Melawan	091000
091009	3	ID	Kec. Pujud	091000
091010	3	ID	Kec. Bangko Pusako	091000
091011	3	ID	Kec. Simpang Kanan	091000
091012	3	ID	Kec. Batu Hampar	091000
091013	3	ID	Kec. Rantau Kopar	091000
091100	2	ID	Kab. Kuantan Singingi	090000
091101	3	ID	Kec. Minas	091100
091102	3	ID	Kec. Siak	091100
091103	3	ID	Kec. Sungai Apit	091100
091104	3	ID	Kec. Tualang	091100
091105	3	ID	Kec. Kerinci Kanan	091100
091106	3	ID	Kec. Dayun	091100
091107	3	ID	Kec. Bunga Raya	091100
091108	3	ID	Kec. Sungai Mandau	091100
091109	3	ID	Kec. Kandis	091100
091110	3	ID	Kec. Lubuk Dalam	091100
091111	3	ID	Kec. Koto Gasip	091100
091112	3	ID	Kec. Pusako	091100
091113	3	ID	Kec. Sabak Auh	091100
091114	3	ID	Kec. Sungai Mempura	091100
091115	3	ID	Mempura	      
091400	2	ID	Kab. Rokan Hulu	090000
091401	3	ID	Kec. Kuantan Mudik	091400
091402	3	ID	Kec. Kuantan Tengah	091400
091403	3	ID	Kec. Benai	091400
091404	3	ID	Kec. Singingi	091400
091405	3	ID	Kec. Kuantan Hilir	091400
091406	3	ID	Kec. Cerenti	091400
091407	3	ID	Kec. Pangean	091400
091408	3	ID	Kec. Logas Tanah Darat	091400
091409	3	ID	Kec. Inuman	091400
091410	3	ID	Kec. Singingi Hilir	091400
091411	3	ID	Kec. Hulu Kuantan	091400
091412	3	ID	Kec. Gunung Toar	091400
091500	2	ID	Kab. Kepulauan Meranti	090000
091501	3	ID	Kec. Merbau	091500
091502	3	ID	Kec. Rangsang	091500
091503	3	ID	Kec. Rangsang Barat	091500
091504	3	ID	Kec. Tebing Tinggi	091500
091505	3	ID	Kec. Tebing Tinggi Barat	091500
091506	3	ID	Kec. Tasik Putri Puyu	091500
091507	3	ID	Kec. Pulau Merbau	091500
091508	3	ID	Kec. Tebing Tinggi Timur	091500
091509	3	ID	Kec. Rangsang Pesisir	091500
096000	2	ID	Kota Pekanbaru	090000
096001	3	ID	Kec. Tampan	096000
096002	3	ID	Kec. Bukit Raya	096000
096003	3	ID	Kec. Lima Puluh	096000
096004	3	ID	Kec. Sail	096000
096005	3	ID	Kec. Pekanbaru Kota	096000
096006	3	ID	Kec. Sukajadi	096000
096007	3	ID	Kec. Senapelan	096000
096008	3	ID	Kec. Rumbai	096000
096009	3	ID	Kec. Tenayan Raya	096000
096010	3	ID	Kec. Marpoyan Damai	096000
096011	3	ID	Kec. Rumbai Pesisir	096000
096012	3	ID	Kec. Payung Sekaki	096000
096200	2	ID	Kota Dumai	090000
096201	3	ID	Kec. Bukit Kapur	096200
096202	3	ID	Kec. Dumai Barat	096200
096203	3	ID	Kec. Dumai Timur	096200
096204	3	ID	Kec. Medang Kampai	096200
096205	3	ID	Kec. Sungai Sembilan	096200
096206	3	ID	Kec. Dumai Kota	096200
096207	3	ID	Kec. Dumai Selatan	096200
100000	1	ID	Prov. Jambi	000000
100100	2	ID	Kab. Batang Hari	100000
100101	3	ID	Kec. Mersan	100100
100102	3	ID	Kec. Muara Tembesi	100100
100103	3	ID	Kec. Batin XXIV	100100
100104	3	ID	Kec. Muara Bulian	100100
100105	3	ID	Kec. Pemayung	100100
100106	3	ID	Kec. Maro Sebo Ulu	100100
100107	3	ID	Kec. Bajubang	100100
100108	3	ID	Kec. Maro Sebo Ilir	100100
100200	2	ID	Kab. Bungo	100000
100201	3	ID	Kec. Tanah Tumbuh	100200
100202	3	ID	Kec. Tanah Sepenggal	100200
100203	3	ID	Kec. Jujuhan	100200
100204	3	ID	Kec. Rantau Pandan	100200
100205	3	ID	Kec. Pasar Muara Bungo	100200
100206	3	ID	Kec. Pelepat	100200
100208	3	ID	Kec. Pelepat Ilir	100200
100209	3	ID	Kec. Limbur Lubuk Mengkuang	100200
100210	3	ID	Kec. Bathin II Babeko	100200
100211	3	ID	Kec. Muko Muko Batin VII	100200
100212	3	ID	Kec. Bungo Dani	100200
100213	3	ID	Kec. Bathin III	100200
100214	3	ID	Kec. Bathin III Ulu	100200
100215	3	ID	Kec. Tanah Sepenggal Luas	100200
100216	3	ID	Kec. Bathin II Pelayang	100200
100217	3	ID	Kec. Jujuhan Ilir	100200
100218	3	ID	Kec. Rimbo Tengah	100200
100299	3	ID	Tanah Sepenggal Lintas	      
100300	2	ID	Kab. Sarolangun	100000
100301	3	ID	Kec. Batang Asai	100300
100302	3	ID	Kec. Limun	100300
100303	3	ID	Kec. Sarolangon	100300
100304	3	ID	Kec. Pelawan	100300
100305	3	ID	Kec. Pauh	100300
100306	3	ID	Kec. Mandiangin	100300
100307	3	ID	Kec. Air Hitam	100300
100308	3	ID	Kec. Bathin VIII	100300
100309	3	ID	Kec. Singkut	100300
100310	3	ID	Kec. Cermin Nan Gadang	100300
100400	2	ID	Kab. Tanjung Jabung Barat	100000
100401	3	ID	Kec. Tungkal Ulu	100400
100402	3	ID	Kec. Pengabuan	100400
100403	3	ID	Kec. Tungkal Ilir	100400
100404	3	ID	Kec. Betara	100400
100405	3	ID	Kec. Merlung	100400
100406	3	ID	Kec. Batang Asam	100400
100407	3	ID	Kec. Tebing Tinggi	100400
100408	3	ID	Kec. Renah Mendalu	100400
100409	3	ID	Kec. Muara Papalik	100400
100410	3	ID	Kec. Senyerang	100400
100411	3	ID	Kec. Bram Itam	100400
100412	3	ID	Kec. Seberang Kota	100400
100413	3	ID	Kec. Kuala Betara	100400
100500	2	ID	Kab. Kerinci	100000
100501	3	ID	Kec. Gunung Raya	100500
100502	3	ID	Kec. Batang Merangin	100500
100503	3	ID	Kec. Keliling Danau	100500
100504	3	ID	Kec. Danau Kerinci	100500
100505	3	ID	Kec. Sitinjau Laut	100500
100507	3	ID	Kec. Air Hangat	100500
100508	3	ID	Kec. Gunung Kerinci	100500
100509	3	ID	Kec. Kayu Aro	100500
100511	3	ID	Kec. Air Hangat Timur	100500
100515	3	ID	Kec. Gunung Tujuh	100500
100516	3	ID	Kec. Siulak	100500
100517	3	ID	Kec. Depati Tujuh	100500
100600	2	ID	Kab. Tebo	100000
100601	3	ID	Kec. Rimbo Bujang	100600
100602	3	ID	Kec. Tebo Ilir	100600
100603	3	ID	Kec. Tebo Tengah	100600
100604	3	ID	Kec. Tebo Ulu	100600
100605	3	ID	Kec. Sumay	100600
100606	3	ID	Kec. VII Koto	100600
100607	3	ID	Kec. Rimbo Ilir	100600
100608	3	ID	Kec. Rimbo Ulu	100600
100609	3	ID	Kec. Tengah Ilir	100600
100610	3	ID	Kec. Serai Serumpun	100600
100611	3	ID	Kec. VII Koto Ilir	100600
100612	3	ID	Kec. Muara Tabir	100600
100700	2	ID	Kab. Muaro Jambi	100000
100701	3	ID	Kec. Jambi Luar Kota	100700
100702	3	ID	Kec. Mestong	100700
100703	3	ID	Kec. Kumpeh Ulu	100700
100704	3	ID	Kec. Sekernan	100700
100705	3	ID	Kec. Maro Sebo	100700
100706	3	ID	Kec. Kumpeh	100700
100707	3	ID	Kec. Sungai Bahar	100700
100708	3	ID	Kec. Sungai Gelam	100700
100800	2	ID	Kab. Tanjung Jabung Timur	100000
100801	3	ID	Kec. Muara Sabak	100800
100802	3	ID	Kec. Mendahara	100800
100803	3	ID	Kec. Dendang	100800
100804	3	ID	Kec. Nipah Panjang	100800
100805	3	ID	Kec. Rantau Rasau	100800
100806	3	ID	Kec. Sadu	100800
100807	3	ID	Kec. Mendahara Ulu	100800
100808	3	ID	Kec. Geragai	100800
100809	3	ID	Kec. Muara Sabak Barat	100800
100811	3	ID	Kec. Kuala Jambi	100800
100812	3	ID	Kec. Berbak	100800
100890	3	ID	Muara Sabak Timur	      
100900	2	ID	Kab. Merangin	100000
100901	3	ID	Kec. Jangkat	100900
100902	3	ID	Kec. Bangko	100900
100903	3	ID	Kec. Pamenang	100900
100904	3	ID	Kec. Muara Siau	100900
100905	3	ID	Kec. Sungai Manau	100900
100906	3	ID	Kec. Tabir	100900
100907	3	ID	Kec. Tabir Ulu	100900
100909	3	ID	Kec. Lembah Masuarai	100900
100910	3	ID	Kec. Tabir Selatan	100900
100911	3	ID	Kec. Bangko Barat	100900
100912	3	ID	Kec. Nalo Tantan	100900
100913	3	ID	Kec. Batang Masumai	100900
100914	3	ID	Kec. Pamenang Barat	100900
100915	3	ID	Kec. Tabir Ilir	100900
100916	3	ID	Kec. Tabir Timur	100900
100917	3	ID	Kec. Renah Pemparap	100900
100918	3	ID	Kec. Pangkalan Jambu	100900
100919	3	ID	Kec. Sungai Tenang	100900
100920	3	ID	Kec. Tiang Pumpung	100900
100921	3	ID	Kec. Renah Pamenang	100900
100922	3	ID	Kec. Pamenang Selatan	100900
100923	3	ID	Kec. Tabir Lintas	100900
100924	3	ID	Kec. Margo Tabir	100900
100925	3	ID	Kec. Tabir Barat	100900
106000	2	ID	Kota Jambi	100000
106001	3	ID	Kec. Kota Baru	106000
106002	3	ID	Kec. Jambi Selatan	106000
106003	3	ID	Kec. Jelutung	106000
106004	3	ID	Kec. Pasar Jambi	106000
106005	3	ID	Kec. Telanai Pura	106000
106006	3	ID	Kec. Danau Teluk	106000
106007	3	ID	Kec. Pelayangan	106000
106008	3	ID	Kec. Jambi Timur	106000
106100	2	ID	Kab. Sungai Penuh	100000
106101	3	ID	Kec. Tanah Kampung	106100
106102	3	ID	Kec. Sungai Penuh	106100
106103	3	ID	Kec. Hamparan Rawang	106100
106104	3	ID	Kec. Pesisir Bukit	106100
106105	3	ID	Kec. Kumun Debai	106100
110000	1	ID	Prov. Sumatera Selatan	000000
110100	2	ID	Kab. Musi Banyu Asin	110000
110101	3	ID	Kec. Sanga Desa	110100
110102	3	ID	Kec. Babat Toman	110100
110103	3	ID	Kec. Sungai Keruh	110100
110104	3	ID	Kec. Sekayu	110100
110109	3	ID	Kec. Sungai Lilin	110100
110110	3	ID	Kec. Bayung Lencir	110100
110111	3	ID	Kec. Lais	110100
110112	3	ID	Kec. Batanghari Leko	110100
110113	3	ID	Kec. Keluang	110100
110116	3	ID	Kec. Plakat Tinggi	110100
110117	3	ID	Kec. Lalan	110100
110118	3	ID	Kec. Tungkal Jaya	110100
110119	3	ID	Kec. Lawang Wetan	110100
110120	3	ID	Kec. Babat Supat	110100
110200	2	ID	Kab. Ogan Komering Ilir	110000
110201	3	ID	Kec. Lempuing	110200
110202	3	ID	Kec. Mesuji	110200
110203	3	ID	Kec. Tulung Selapan	110200
110204	3	ID	Kec. Pedamaran	110200
110205	3	ID	Kec. Tanjung Lubuk	110200
110206	3	ID	Kec. Kota Ayu Agung	110200
110212	3	ID	Kec. Sirah Pulau Padang	110200
110213	3	ID	Kec. Pampangan	110200
110214	3	ID	Kec. Air Sugihan	110200
110216	3	ID	Kec. Cengal	110200
110218	3	ID	Kec. Jejawi	110200
110220	3	ID	Kec. Sungai Menang	110200
110221	3	ID	Kec. Lempuing Jaya	110200
110222	3	ID	Kec. Mesuji Makmur	110200
110223	3	ID	Kec. Mesuji Raya	110200
110224	3	ID	Kec. Pedamaran Timur	110200
110225	3	ID	Kec. Teluk Gelam	110200
110226	3	ID	Kec. Pangkalan Lapam	110200
110300	2	ID	Kab. Ogan Komering Ulu	110000
110307	3	ID	Kec. Sosoh Buay Rayap	110300
110308	3	ID	Kec. Pengandonan	110300
110309	3	ID	Kec. Peninjauan	110300
110317	3	ID	Kec. Lubuk Batang	110300
110320	3	ID	Kec. Ulu Ogan	110300
110321	3	ID	Kec. Semidang Aji	110300
110322	3	ID	Kec. Lengkiti	110300
110371	3	ID	Kec. Baturaja Timur	110300
110372	3	ID	Kec. Baturaja Barat	110300
110373	3	ID	Kec. Sinar Peninjauan	110300
110374	3	ID	Kec. Lubuk Raja	110300
110375	3	ID	Kec. Muara Jaya	110300
110400	2	ID	Kab. Muara Enim	110000
110401	3	ID	Kec. Semende Darat Laut	110400
110402	3	ID	Kec. Tanjung Agung	110400
110403	3	ID	Kec. Lawang Kidul	110400
110404	3	ID	Kec. Muara Enim	110400
110405	3	ID	Kec. Gunung Megang	110400
110406	3	ID	Kec. Talang Ubi	110400
110407	3	ID	Kec. Gelumbang	110400
110409	3	ID	Kec. Sungai Rotan	110400
110410	3	ID	Kec. Lembak	110400
110411	3	ID	Kec. Benakat	110400
110412	3	ID	Kec. Ujan Mas	110400
110413	3	ID	Kec. Penukal	110400
110414	3	ID	Kec. Penukal Utara	110400
110415	3	ID	Kec. Tanah Abang	110400
110416	3	ID	Kec. Lubai	110400
110417	3	ID	Kec. Rambang	110400
110419	3	ID	Kec. Semende Darat Ulu	110400
110420	3	ID	Kec. Semende Darat Tengah	110400
110422	3	ID	Kec. Rambang Dangku	110400
110423	3	ID	Kec. Abab	110400
110424	3	ID	Kec. Kelekar	110400
110425	3	ID	Kec. Muara Belida	110400
110427	3	ID	Abab	      
110428	3	ID	Talang Ubi	      
110429	3	ID	Penukal Utara	      
110430	3	ID	Tanah Abang	      
110431	3	ID	Penukal	      
110500	2	ID	Kab. Lahat	110000
110504	3	ID	Kec. Kota Agung	110500
110505	3	ID	Kec. Pulau Pinang	110500
110506	3	ID	Kec. Jarai	110500
110511	3	ID	Kec. Kikim Timur	110500
110512	3	ID	Kec. Lahat	110500
110514	3	ID	Kec. Mulak Ulu	110500
110515	3	ID	Kec. Pajar Bulan	110500
110519	3	ID	Kec. Kikim Selatan	110500
110520	3	ID	Kec. Kikim Barat	110500
110521	3	ID	Kec. Kikim Tengah	110500
110522	3	ID	Kec. Tanjung Sakti Pumi	110500
110523	3	ID	Kec. Tanjung Sakti Pumu	110500
110524	3	ID	Kec. Merapi Barat	110500
110526	3	ID	Kec. Pseksu	110500
110527	3	ID	Kec. Gumay Talang	110500
110528	3	ID	Kec. Pagar Gunung	110500
110529	3	ID	Kec. Merapi Timur	110500
110530	3	ID	Kec. Gumay Ulu	110500
110531	3	ID	Kec. Merapi Selatan	110500
110532	3	ID	kec. Tanjung Tebat	110500
110533	3	ID	Kec. Muara Payang	110500
110600	2	ID	Kab. Musi Rawas	110000
110601	3	ID	Kec. Rawas Ulu	110600
110602	3	ID	Kec. Rupit	110600
110603	3	ID	Kec. STL  Ulu Terawas	110600
110604	3	ID	Kec. Tugu Mulyo	110600
110605	3	ID	Kec. Muara Beliti	110600
110606	3	ID	Kec. Jayaloka	110600
110607	3	ID	Kec. Muara Kelingi	110600
110608	3	ID	Kec. Muara Lakitan	110600
110609	3	ID	Kec. Megang Sakti	110600
110610	3	ID	Kec. Rawas Ilir	110600
110611	3	ID	Kec. Purwodadi	110600
110612	3	ID	Kec. Selangit	110600
110613	3	ID	Kec. Karang Jaya	110600
110614	3	ID	Kec. Karang Dapo	110600
110615	3	ID	Kec. Bulan Tengah Suku Ulu	110600
110616	3	ID	Kec. Ulu Rawas	110600
110617	3	ID	Kec. Nibung	110600
110619	3	ID	Kec. Tiang Pumpung Kepungut	110600
110620	3	ID	Kec. Sumber Harta	110600
110621	3	ID	Kec. Tanah Negeri	110600
110622	3	ID	Kec. Suka Karya	110600
110700	2	ID	Kab. Banyuasin	110000
110701	3	ID	Kec. Rantau Bayur	110700
110702	3	ID	Kec. Talang Kelapa	110700
110703	3	ID	Kec. Banyuasin III	110700
110704	3	ID	Kec. Betung	110700
110705	3	ID	Kec. Makarti Jaya	110700
110706	3	ID	Kec. Banyuasin I	110700
110707	3	ID	Kec. Banyuasin II	110700
110709	3	ID	Kec. Rambutan	110700
110710	3	ID	Kec. Muara Telang	110700
110711	3	ID	Kec. Muara Padang	110700
110712	3	ID	Kec. Tanjung Lago	110700
110713	3	ID	Kec. Muara Sugihan	110700
110714	3	ID	Kec. Air Salek	110700
110715	3	ID	Kec. Tungkal Ilir	110700
110716	3	ID	Kec. Suak Tapeh	110700
110717	3	ID	Kec. Pulau Rimau	110700
110718	3	ID	Kec. Sembawa	110700
110800	2	ID	Kab. Ogan Komering Ulu Timur	110000
110801	3	ID	Kec. Martapura	110800
110802	3	ID	Kec. Buay Madang	110800
110803	3	ID	Kec. Cempaka	110800
110804	3	ID	Kec. Madang Suku I	110800
110805	3	ID	Kec. Madang Suku II	110800
110806	3	ID	Kec. Belitang I	110800
110807	3	ID	Kec. Belitang II	110800
110808	3	ID	Kec. Belitang III	110800
110809	3	ID	Kec. Buay Pemuka Peliung	110800
110810	3	ID	Kec. Semendawai Suku III	110800
110811	3	ID	Kec. Bunga Mayang	110800
110812	3	ID	Kec. Buay Madang Timur	110800
110813	3	ID	Kec. Madang Suku III	110800
110814	3	ID	Kec. Semendawai Barat	110800
110815	3	ID	Kec. Semendawai Timur	110800
110816	3	ID	Kec. Jayapura	110800
110817	3	ID	Kec. Belitang Jaya	110800
110818	3	ID	Kec. Belitang Madang Raya	110800
110819	3	ID	Kec. Belitang Mulia	110800
110820	3	ID	Kec. Buay Pemuka Bangsa Raja	110800
110890	3	ID	Belitang	      
110900	2	ID	Kab. Ogan Komering Ulu Selatan	110000
110901	3	ID	Kec. Banding Agung	110900
110902	3	ID	Kec. Pulau Beringin	110900
110903	3	ID	Kec. Muaradua Kisam	110900
110904	3	ID	Kec. Muaradua	110900
110905	3	ID	Kec. Simpang	110900
110906	3	ID	Kec. Buay Sandang Aji	110900
110907	3	ID	Kec. Buay Runjung	110900
110908	3	ID	Kec. Buay Pemaca	110900
110909	3	ID	Kec. Mekakau Ilir	110900
110910	3	ID	Kec. Kisam Tinggi	110900
110911	3	ID	Kec. Kisam Ilir	110900
110912	3	ID	Kec. Buay Pematang Ribu Ranau	110900
110913	3	ID	Kec. Warkuk Ranau Selatan	110900
110914	3	ID	Kec. Runjung Agung	110900
110915	3	ID	Kec. Sungai Are	110900
110916	3	ID	Kec. Sidang Danau	110900
110917	3	ID	Kec. Buana Pemaca	110900
110918	3	ID	Kec. Tiga Dihaji	110900
110919	3	ID	Kec. Buay Rawan	110900
111000	2	ID	Kab. Ogan Ilir	110000
111001	3	ID	Kec. Tanjung Raja	111000
111002	3	ID	Kec. Muara Kuang	111000
111003	3	ID	Kec. Tanjung Batu	111000
111004	3	ID	Kec. Indralaya	111000
111005	3	ID	Kec. Pemulutan	111000
111006	3	ID	Kec. Rantau Alai	111000
111007	3	ID	Kec. Rambang Kuang	111000
111008	3	ID	Kec. Lubuk Keliat	111000
111009	3	ID	Kec. Payaraman	111000
111010	3	ID	Kec. Kandis	111000
111011	3	ID	Kec. Pemulutan Selatan	111000
111012	3	ID	Kec. Pemulutan Barat	111000
111013	3	ID	Kec. Indralaya Selatan	111000
111014	3	ID	Kec. Indralaya Utara	111000
111015	3	ID	Kec. Rantau Panjang	111000
111016	3	ID	Kec. Sungai Pinang	111000
111100	2	ID	Kab. Empat Lawang	110000
111101	3	ID	Kec. Lintang Kanan	111100
111102	3	ID	Kec. Muara Pinang	111100
111103	3	ID	Kec. Pendopo	111100
111104	3	ID	Kec. Ulu Musi	111100
111105	3	ID	Kec. Tebing Tinggi	111100
111106	3	ID	Kec. Talang Padang	111100
111107	3	ID	Kec. Pasemah Air Keruh	111100
111108	3	ID	Kec. Sikap Dalam	111100
116000	2	ID	Kota Palembang	110000
116001	3	ID	Kec. Ilir Barat II	116000
116002	3	ID	Kec. Seberang Ulu I	116000
116003	3	ID	Kec. Seberang Ulu II	116000
116004	3	ID	Kec. Ilir Barat I	116000
116005	3	ID	Kec. Ilir Timur I	116000
116006	3	ID	Kec. Ilir Timur II	116000
116007	3	ID	Kec. Sako	116000
116008	3	ID	Kec. Sukarami	116000
116009	3	ID	Kec. Kemuning	116000
116010	3	ID	Kec. Plaju	116000
116011	3	ID	Kec. Kertapati	116000
116012	3	ID	Kec. Gandus	116000
116013	3	ID	Kec. Bukit Kecil	116000
116014	3	ID	Kec. Kalidoni	116000
116015	3	ID	Kec. Alang-Alang Lebar	116000
116016	3	ID	Kec. Sematang Borang	116000
116100	2	ID	Kota Prabumulih	110000
116103	3	ID	Kec. Prabumulih Timur	116100
116104	3	ID	Kec. Prabumulih Barat	116100
116105	3	ID	Kec. Cambai	116100
116106	3	ID	Kec. Rambang Kapak Tengah	116100
116107	3	ID	Kec. Prabumulih Utara	116100
116108	3	ID	Kec. Prabumulih Selatan	116100
116200	2	ID	Kota Lubuk Linggau	110000
116201	3	ID	Kec. Lubuk Linggau Barat I	116200
116202	3	ID	Kec. Lubuk Linggau Timur I	116200
116203	3	ID	Kec. Lubuk Linggau Selatan I	116200
116204	3	ID	Kec. Lubuk Linggau Utara I	116200
116205	3	ID	Kec. Lubuk Linggau Barat II	116200
116206	3	ID	Kec. Lubuk Linggau Timur II	116200
116207	3	ID	Kec. Lubuk Linggau Selatan II	116200
116208	3	ID	Kec. Lubuk Linggau Utara II	116200
116300	2	ID	Kota Pagar Alam	110000
116301	3	ID	Kec. Pagar Alam Utara	116300
116302	3	ID	Kec. Pagar Alam Selatan	116300
116303	3	ID	Kec. Dempo Utara	116300
116304	3	ID	Kec. Dempo Selatan	116300
116305	3	ID	Kec. Dempo Tengah	116300
120000	1	ID	Prov. Lampung	000000
120100	2	ID	Kab. Lampung Selatan	120000
120106	3	ID	Kec. Natar	120100
120107	3	ID	Kec. Jati Agung	120100
120108	3	ID	Kec. Tanjung Bintang	120100
120109	3	ID	Kec. Katibung	120100
120110	3	ID	Kec. Sidomulyo	120100
120112	3	ID	Kec. Palas	120100
120113	3	ID	Kec. Penengahan	120100
120116	3	ID	Kec. Merbau Mataram	120100
120117	3	ID	Kec. Candipuro	120100
120118	3	ID	Kec. Rajabasa	120100
120119	3	ID	Kec. Sragi	120100
120120	3	ID	Kec. Ketapang	120100
120121	3	ID	Kec. Katibung	120100
120122	3	ID	Kec. Bakauheni	120100
120123	3	ID	Kec. Tanjung Sari	120100
120124	3	ID	Kec. Way Sulan	120100
120125	3	ID	Kec. Way Panji	120100
120126	3	ID	Kalianda	      
120200	2	ID	Kab. Lampung Tengah	120000
120201	3	ID	Kec. Padang Ratu	120200
120202	3	ID	Kec. Kalirejo	120200
120203	3	ID	Kec. Bangunrejo	120200
120204	3	ID	Kec. Gunung Sugih	120200
120205	3	ID	Kec. Trimurjo	120200
120206	3	ID	Kec. Punggur	120200
120207	3	ID	Kec. Seputih Raman	120200
120208	3	ID	Kec. Terbanggi Besar	120200
120209	3	ID	Kec. Terusan Nunyai	120200
120210	3	ID	Kec. Seputih Mataram	120200
120211	3	ID	Kec. Seputih Banyak	120200
120212	3	ID	Kec. Rumbia	120200
120213	3	ID	Kec. Seputih Surabaya	120200
120214	3	ID	Kec. Bumi Ratu Nuban	120200
120215	3	ID	Kec. Way Pengubuan	120200
120216	3	ID	Kec. Seputih Agung	120200
120217	3	ID	Kec. Bandar Mataram	120200
120218	3	ID	Kec. Sendang Agung	120200
120219	3	ID	Kec. Anak Tuha	120200
120220	3	ID	Kec. Pubian	120200
120221	3	ID	Kec. Bandar Surabaya	120200
120222	3	ID	Kec. Bumi Nabung	120200
120223	3	ID	Kec. Way Seputih	120200
120224	3	ID	Kec. Kota Gajah	120200
120225	3	ID	Kec. Selagai Lingga	120200
120226	3	ID	Kec. Bekri	120200
120227	3	ID	Kec. Anak Ratu Aji	120200
120228	3	ID	Kec. Putra Rumbia	120200
120300	2	ID	Kab. Lampung Utara	120000
120301	3	ID	Kec. Bukit Kemuning	120300
120302	3	ID	Kec. Tanjung Raja	120300
120303	3	ID	Kec. Abung Barat	120300
120304	3	ID	Kec. Kotabumi Kota	120300
120305	3	ID	Kec. Abung Selatan	120300
120306	3	ID	Kec. Abung Timur	120300
120307	3	ID	Kec. Sungkai Selatan	120300
120308	3	ID	Kec. Sungkai Utara	120300
120309	3	ID	Kec. Abung Tinggi	120300
120310	3	ID	Kec. Abung Tengah	120300
120311	3	ID	Kec. Kotabumi Utara	120300
120312	3	ID	Kec. Kotabumi Selatan	120300
120313	3	ID	Kec. Abung Semuli	120300
120314	3	ID	Kec. Abung Surakarta	120300
120315	3	ID	Kec. Muara Sungkai	120300
120316	3	ID	Kec. Bunga Mayang	120300
120317	3	ID	Kec. Hulu Sungkai	120300
120318	3	ID	Kec. Sungkai Tengah	120300
120319	3	ID	Kec. Abung Pekurun	120300
120320	3	ID	Kec. Sungkai Jaya	120300
120321	3	ID	Kec. Sungkai Barat	120300
120322	3	ID	Kec. Abung Kunang	120300
120323	3	ID	Kec. Blambangan Pagar	120300
120400	2	ID	Kab. Lampung Barat	120000
120401	3	ID	Kec. Pesisir Selatan	120400
120402	3	ID	Kec. Pesisir Tengah	120400
120403	3	ID	Kec. Pesisir Utara	120400
120404	3	ID	Kec. Balik Bukit	120400
120405	3	ID	Kec. Belalau	120400
120406	3	ID	Kec. Sumber Jaya	120400
120407	3	ID	Kec. Sekincau	120400
120408	3	ID	Kec. Bengkunat	120400
120409	3	ID	Kec. Batu Brak	120400
120410	3	ID	Kec. Karyapenggawa	120400
120411	3	ID	Kec. Lemong	120400
120412	3	ID	Kec. Waytenong	120400
120413	3	ID	Kec. Sukau	120400
120414	3	ID	Kec. Suoh	120400
120415	3	ID	Kec. Gedung Surian	120400
120416	3	ID	Kec. Bengkunat Belimbing	120400
120417	3	ID	Kec. Ngambur	120400
120490	3	ID	Pagar Dewa	      
120491	3	ID	Lumbok Seminung	      
120500	2	ID	Kab. Tulang Bawang	120000
120503	3	ID	Kec. Banjar Agung	120500
120504	3	ID	Kec. Gedung Aji	120500
120505	3	ID	Kec. Manggala	120500
120509	3	ID	Kec. Penawartama	120500
120513	3	ID	Kec. Rawajitu Selatan	120500
120514	3	ID	Kec. Gedung Meneng	120500
120519	3	ID	Kec. Banjar Margo	120500
120520	3	ID	Kec. Penawar Aji	120500
120521	3	ID	Kec. Rawa Pitu	120500
120522	3	ID	Kec. Rawajitu Timur	120500
120525	3	ID	Kec. Meraksa Aji	120500
120526	3	ID	Kec. Gedung AJI Baru	120500
120527	3	ID	Kec. Dente Teladas	120500
120528	3	ID	Kec. Banjar Baru	120500
120529	3	ID	Kec. Menggala Timur	120500
120590	3	ID	Menggala	      
120600	2	ID	Kab. Tenggamus	120000
120601	3	ID	Kec. Wonosobo	120600
120602	3	ID	Kec. Kota Agung	120600
120603	3	ID	Kec. Pulau Panggung	120600
120604	3	ID	Kec. Talang Padang	120600
120605	3	ID	Kec. Pugung	120600
120611	3	ID	Kec. Cukuh Balak	120600
120612	3	ID	Kec. Pematang Sawa	120600
120613	3	ID	Kec. Sumberejo	120600
120614	3	ID	Kec. Semaka	120600
120615	3	ID	Kec. Ulu Belu	120600
120617	3	ID	Kec. Kelumbayan	120600
120618	3	ID	Kota Agung Barat	120600
120619	3	ID	Kota Agung Timur	120600
120620	3	ID	Kec. Gisting	120600
120621	3	ID	Kec. Gunung Alip	120600
120624	3	ID	Kec. Limau	120600
120625	3	ID	Kec. Bandar Negeri Semuong	120600
120626	3	ID	Kec. Air Naningan	120600
120627	3	ID	Kec. Bulok	120600
120628	3	ID	Kec. Kelumbayan Barat	120600
120700	2	ID	Kab. Lampung Timur	120000
120701	3	ID	Kec. Metro Kibang	120700
120702	3	ID	Kec. Batanghari	120700
120703	3	ID	Kec. Sekampung	120700
120704	3	ID	Kec. Margatiga	120700
120705	3	ID	Kec. Sekampung Udik	120700
120706	3	ID	Kec. Jabung	120700
130300	2	ID	Kab. Sanggau	130000
120707	3	ID	Kec. Labuhan Maringgai	120700
120708	3	ID	Kec. Way Jepara	120700
120709	3	ID	Kec. Sukadana	120700
120710	3	ID	Kec. Pekalongan	120700
120711	3	ID	Kec. Raman Utara	120700
120712	3	ID	Kec. Purbolinggo	120700
120713	3	ID	Kec. Bumi Agung	120700
120716	3	ID	Kec. Braja Slebah	120700
120717	3	ID	Kec. Bandar Sribawono	120700
120718	3	ID	Kec. Mataram Baru	120700
120719	3	ID	Kec. Melinting	120700
120720	3	ID	Kec. Gunung Pelindung	120700
120721	3	ID	Kec. Waway Karya	120700
120722	3	ID	Kec. Pasir Sakti	120700
120723	3	ID	Kec. Labuhan Ratu	120700
120724	3	ID	Kec. Batanghari Nuban	120700
120725	3	ID	Kec. Way Bungur	120700
120726	3	ID	Kec. Marga Sekampung	120700
120800	2	ID	Kab. Way Kanan	120000
120801	3	ID	Kec. Banjit	120800
120802	3	ID	Kec. Baradatu	120800
120803	3	ID	Kec. Kasui	120800
120804	3	ID	Kec. Blambangan Umpu	120800
120805	3	ID	Kec. Bahuga	120800
120806	3	ID	Kec. Pakuan Ratu	120800
120807	3	ID	Kec. Gunung Labuhan	120800
120808	3	ID	Kec. Rebang Tangkas	120800
120809	3	ID	Kec. Way Tuba	120800
120810	3	ID	Kec. Negeri Agung	120800
120811	3	ID	Kec. Negara Batin	120800
120812	3	ID	Kec. Negeri Besar	120800
120813	3	ID	Kec. Buay Bahuga	120800
120814	3	ID	Kec. Bumi Agung	120800
120900	2	ID	Kab. Pasawaran	120000
120901	3	ID	Kec. Padang Cermin	120900
120902	3	ID	Kec. Punduh Pedada	120900
120903	3	ID	Kec. Kedondong	120900
120904	3	ID	Kec. Way Lima	120900
120905	3	ID	Kec. Gedung Tataan	120900
120906	3	ID	Kec. Negeri Katon	120900
120907	3	ID	Kec. Tegineneng	120900
121000	2	ID	Kab. Tulang Bawang Barat	120000
121001	3	ID	Kec. Pagelaran	121000
121002	3	ID	Kec. Sukoharjo	121000
121003	3	ID	Kec. Adiluwih	121000
121004	3	ID	Kec. Banyumas	121000
121005	3	ID	Kec. Pringsewu	121000
121006	3	ID	Kec. Ambarawa	121000
121007	3	ID	Kec. Gadingrejo	121000
121008	3	ID	Kec. Pardasuka	121000
121100	2	ID	Kab. Mesuji	120000
121101	3	ID	Kec. Mesuji	121100
121102	3	ID	Kec. Tanjung Raya	121100
121103	3	ID	Kec. Rawajitu Utara	121100
121104	3	ID	Kec. Mesuji Timur	121100
121105	3	ID	Kec. Simpang Pematang	121100
121106	3	ID	Kec. Way Serdang	121100
121107	3	ID	Kec. Panca Jaya	121100
121200	2	ID	Kab. Pringsewu	120000
121201	3	ID	Kec. Tulang Bawang Udik	121200
121202	3	ID	Kec. Tumijajar	121200
121203	3	ID	Kec. Tulang Bawang Tengah	121200
121204	3	ID	Kec. Lambu Kibang	121200
121205	3	ID	Kec. Pagar Dewa	121200
121206	3	ID	Kec. Way Kenanga	121200
121207	3	ID	Kec. Gunung Terang	121200
121208	3	ID	Kec. Gunung Agung	121200
126000	2	ID	Kota Bandar Lampung	120000
126001	3	ID	Kec. Teluk Betung Barat	126000
126002	3	ID	Kec. Teluk Betung Selatan	126000
126003	3	ID	Kec. Panjang	126000
126004	3	ID	Kec. Tanjung Karang Timur	126000
126005	3	ID	Kec. Teluk Betung Utara	126000
126006	3	ID	Kec. Tanjung Karang Pusat	126000
126007	3	ID	Kec. Tanjung Karang Barat	126000
126008	3	ID	Kec. Kedaton	126000
126009	3	ID	Kec. Sukarame	126000
126010	3	ID	Kec. Kemiling	126000
126011	3	ID	Kec. Rajabasa	126000
126012	3	ID	Kec. Tanjung Senang	126000
126013	3	ID	Kec. Sukabumi	126000
126100	2	ID	Kota Metro	120000
126101	3	ID	Kec. Metro Pusat	126100
126102	3	ID	Kec. Metro Utara	126100
126103	3	ID	Kec. Metro Barat	126100
126104	3	ID	Kec. Metro Timur	126100
126105	3	ID	Kec. Metro Selatan	126100
130000	1	ID	Prov. Kalimantan Barat	000000
130100	2	ID	Kab. Sambas	130000
130101	3	ID	Kec. Selakau	130100
130102	3	ID	Kec. Pemangkat	130100
130103	3	ID	Kec. Tebas	130100
130104	3	ID	Kec. Sambas	130100
130105	3	ID	Kec. Jawai	130100
130106	3	ID	Kec. Teluk Keramat	130100
130107	3	ID	Kec. Sejangkung	130100
130108	3	ID	Kec. Sajingan Besar	130100
130109	3	ID	Kec. Paloh	130100
130110	3	ID	Kec. Subah	130100
130111	3	ID	Kec. Galing	130100
130112	3	ID	Kec. Semparuk	130100
130113	3	ID	Kec. Tekarang	130100
130114	3	ID	Kec. Sajad	130100
130115	3	ID	Kec. Sebawi	130100
130116	3	ID	Kec. Jawai Selatan	130100
130117	3	ID	Kec. Tangaran	130100
130118	3	ID	Kec. Selakau Tua	130100
130119	3	ID	Kec. Salatiga	130100
130190	3	ID	Selakau Timur	      
130200	2	ID	Kab. Pontianak	130000
130208	3	ID	Kec. Siantan	130200
130209	3	ID	Kec. Sungai Pinyuh	130200
130210	3	ID	Kec. Mempawah Hilir	130200
130211	3	ID	Kec. Sungai Kunyit	130200
130212	3	ID	Kec. Toho	130200
130216	3	ID	Kec. Segedong	130200
130217	3	ID	Kec. Anjongan	130200
130218	3	ID	Kec. Sadaniang	130200
130219	3	ID	Kec. Mempawah Timur	130200
130220	3	ID	Kec. Ambawang	130200
130301	3	ID	Kec. Toba	130300
130306	3	ID	Kec. Sanggau Kapuas	130300
130307	3	ID	Kec. Mokok	130300
130312	3	ID	Kec. Jangkang	130300
130313	3	ID	Kec. Bonti	130300
130314	3	ID	Kec. Parindu	130300
130315	3	ID	Kec. Tayan Hilir	130300
130316	3	ID	Kec. Balai	130300
130317	3	ID	Kec. Tayan Hulu	130300
130318	3	ID	Kec. Kembayan	130300
130319	3	ID	Kec. Beduwai	130300
130320	3	ID	Kec. Noyan	130300
130321	3	ID	Kec. Sekayan	130300
130322	3	ID	Kec. Entikong	130300
130323	3	ID	Meliau	      
130324	3	ID	Kapuas	      
130400	2	ID	Kab. Sintang	130000
130406	3	ID	Kec. Nanga Serawai	130400
130407	3	ID	Kec. Ambalau	130400
130408	3	ID	Kec. Kayan Hulu	130400
130411	3	ID	Kec. Sepauk	130400
130412	3	ID	Kec. Tempunak	130400
130413	3	ID	Kec. Sungai Tebelian	130400
130414	3	ID	Kec. Sintang	130400
130415	3	ID	Kec. Dedai	130400
130416	3	ID	Kec. Kayan Hilir	130400
130417	3	ID	Kec. Kelam Permai	130400
130418	3	ID	Kec. Binjai Hulu	130400
130419	3	ID	Kec. Ketungau Hilir	130400
130420	3	ID	Kec. Ketungau Tengah	130400
130421	3	ID	Kec. Ketungau Hulu	130400
130500	2	ID	Kab. Kapuas Hulu	130000
130501	3	ID	Kec. Silat Hilir	130500
130502	3	ID	Kec. Silat Hulu	130500
130503	3	ID	Kec. Hulu Gurung	130500
130504	3	ID	Kec. Bunut Hulu	130500
130505	3	ID	Kec. Mentebah	130500
130507	3	ID	Kec. Kalis	130500
130509	3	ID	Kec. Embaloh Hilir	130500
130510	3	ID	Kec. Bunut Hilir	130500
130511	3	ID	Kec. Boyan Tanjung	130500
130514	3	ID	Kec. Selimbau	130500
130515	3	ID	Kec. Suhaid	130500
130516	3	ID	Kec. Seberuang	130500
130517	3	ID	Kec. Semitau	130500
130518	3	ID	Kec. Empanang	130500
130519	3	ID	Kec. Puring Kencana	130500
130520	3	ID	Kec. Badau	130500
130521	3	ID	Kec. Batang Lupar	130500
130522	3	ID	Kec. Embaloh Hulu	130500
130524	3	ID	Kec. Hulu Kapuas	130500
130526	3	ID	Kec. Putussibau Utara	130500
130527	3	ID	Kec. Bika	130500
130528	3	ID	Kec. Jongkong	130500
130529	3	ID	Kec. Putussibau Selatan	130500
130530	3	ID	Kec. Pengkadan	130500
130531	3	ID	Kec. Danau Setarum	130500
130600	2	ID	Kab. Ketapang	130000
130601	3	ID	Kec. Kendawangan	130600
130602	3	ID	Kec. Manis Mata	130600
130603	3	ID	Kec. Marau	130600
130604	3	ID	Kec. Jelai Hulu	130600
130605	3	ID	Kec. Tumbang Titi	130600
130606	3	ID	Kec. Matan Hilir Selatan	130600
130607	3	ID	Kec. Matan Hilir Utara	130600
130609	3	ID	Kec. Nanga Tayap	130600
130610	3	ID	Kec. Sandai	130600
130611	3	ID	Kec. Sungai Laur	130600
130612	3	ID	Kec. Simpang Hulu	130600
130618	3	ID	Kec. Muara Pawan	130600
130619	3	ID	Kec. Delta Pawan	130600
130620	3	ID	Kec. Simpang Dua	130600
130621	3	ID	Kec. Benua Kayong	130600
130622	3	ID	Kec. Hulu Sungai	130600
130623	3	ID	Kec. Air Upas	130600
130624	3	ID	Kec. Singkup	130600
130625	3	ID	Kec. Pemahan	130600
130626	3	ID	Kec. Sungai Melayu Rayek	130600
130800	2	ID	Kab. Bengkayang	130000
130801	3	ID	Kec. Sungai Raya	130800
130802	3	ID	Kec. Capkala	130800
130803	3	ID	Kec. Samalantan	130800
130804	3	ID	Kec. Bengkayang	130800
130805	3	ID	Kec. Ledo	130800
130806	3	ID	Kec. Sanggau Ledo	130800
130807	3	ID	Kec. Seluas	130800
130808	3	ID	Kec. Jagoi Babang	130800
130809	3	ID	Kec. Teriak	130800
130810	3	ID	Kec. Monterado	130800
130811	3	ID	Kec. Suti Semarang	130800
130812	3	ID	Kec. Siding	130800
130813	3	ID	Kec. Lumar	130800
130814	3	ID	Kec. Sungai Betung	130800
130815	3	ID	Kec. Sungai Raya Kepulauan	130800
130816	3	ID	Kec. Lembah Bawang	130800
130817	3	ID	Kec. Tujuh Belas	130800
130900	2	ID	Kab. Landak	130000
130902	3	ID	Kec. Sebangki	130900
130903	3	ID	Kec. Ngabang	130900
130904	3	ID	Kec. Sengah Temila	130900
130905	3	ID	Kec. Mandor	130900
130906	3	ID	Kec. Menjalin	130900
130907	3	ID	Kec. Mempawah Hulu	130900
130908	3	ID	Kec. Menyuke	130900
130909	3	ID	Kec. Meranti	130900
130910	3	ID	Kec. Kuala Behe	130900
130911	3	ID	Kec. Air Besar	130900
130912	3	ID	Kec. Jelimpo	130900
130913	3	ID	Kec. Sompak	130900
130914	3	ID	Kec. Banyuke Hulu	130900
131000	2	ID	Kab. Sekadau	130000
131001	3	ID	Kec. Nanga Mahap	131000
131002	3	ID	Kec. Nanga Taman	131000
131003	3	ID	Kec. Sekadau Hulu	131000
131004	3	ID	Kec. Sekadau Hilir	131000
131005	3	ID	Kec. Belitang	131000
131006	3	ID	Kec. Belitang Hilir	131000
131007	3	ID	Kec. Belitang Hulu	131000
131100	2	ID	Kab. Melawi	130000
131101	3	ID	Kec. Sokan	131100
131102	3	ID	Kec. Tanah Pinoh	131100
131103	3	ID	Kec. Sayan	131100
131104	3	ID	Kec. Ella Hilir	131100
131105	3	ID	Kec. Menukung	131100
131108	3	ID	Kec. Nanga Pinoh	131100
131109	3	ID	Kec. Belimbing	131100
131110	3	ID	Kec. Tanah Pinoh Barat	131100
131111	3	ID	Kec. Belimbing Hulu	131100
131112	3	ID	Kec. Pinoh Selatan	131100
131113	3	ID	Kec. Pinoh Utara	131100
131200	2	ID	Kab. Kayong Utara	130000
131201	3	ID	Kec. Pulau Maya Karimata	131200
131202	3	ID	Kec. Simpang Hilir	131200
131203	3	ID	Kec. Sukadana	131200
131204	3	ID	Kec. Teluk Batang	131200
131205	3	ID	Kec. Seponti	131200
131300	2	ID	Kab. Kuburaya	130000
131302	3	ID	Kec. Kuala Mandor B	131300
131304	3	ID	Kec. Sungai Ambawang	131300
131305	3	ID	Kec. Sungai Kakap	131300
131308	3	ID	Kec. Telok Pakedai	131300
131309	3	ID	Kec. Terentang	131300
131310	3	ID	Kec. Sungai Raya	131300
131311	3	ID	Kec. Batu Ampar	131300
131312	3	ID	Kec. Kubu	131300
131313	3	ID	Kec. Rasau Jaya	131300
136000	2	ID	Kota Pontianak	130000
136001	3	ID	Kec. Pontianak Selatan	136000
136002	3	ID	Kec. Pontianak Timur	136000
136003	3	ID	Kec. Pontianak Barat	136000
136004	3	ID	Kec. Pontianak Utara	136000
136005	3	ID	Kec. Pontianak Kota	136000
136006	3	ID	Kec. Pontianak Tenggara	136000
136100	2	ID	Kota Singkawang	130000
136101	3	ID	Kec. Singkawang Selatan	136100
136102	3	ID	Kec. Singkawang Timur	136100
136103	3	ID	Kec. Singkawang Utara	136100
136104	3	ID	Kec. Singkawang Barat	136100
136105	3	ID	Kec. Singkawang Tengah	136100
140000	1	ID	Prov. Kalimantan Tengah	000000
140100	2	ID	Kab. Kapuas	140000
140102	3	ID	Kec. Kapuas Kuala	140100
140103	3	ID	Kec. Kapuas Timur	140100
140104	3	ID	Kec. Selat	140100
140107	3	ID	Kec. Basarang	140100
140108	3	ID	Kec. Kapuas Hilir	140100
140109	3	ID	Kec. Pulau Petak	140100
140110	3	ID	Kec. Kapuas Murung	140100
140111	3	ID	Kec. Kapuas Barat	140100
140115	3	ID	Kec. Mantangai	140100
140116	3	ID	Kec. Timpah	140100
140117	3	ID	Kec. Kapuas Tengah	140100
140118	3	ID	Kec. Kapuas Hulu	140100
140200	2	ID	Kab. Barito Selatan	140000
140201	3	ID	Kec. Dusun Hilir	140200
140202	3	ID	Kec. Jenamas	140200
140209	3	ID	Kec. Karau Kuala	140200
140210	3	ID	Kec. Dusun Selatan	140200
140211	3	ID	Kec. Dusun Utara	140200
140212	3	ID	Kec. Gunung Bintang Awai	140200
140300	2	ID	Kab. Barito Utara	140000
140301	3	ID	Kec. Montallat	140300
140302	3	ID	Kec. Gunung Timang	140300
140303	3	ID	Kec. Gunung Purei	140300
140304	3	ID	Kec. Teweh Timur	140300
140305	3	ID	Kec. Teweh Tengah	140300
140306	3	ID	Kec. Lahei	140300
140307	3	ID	Teweh Baru	      
140308	3	ID	Teweh Selatan	      
140309	3	ID	Lahei Barat	      
140400	2	ID	Kab. Kotawaringin Timur	140000
140402	3	ID	Kec. Mentaya Hilir Selatan	140400
140405	3	ID	Kec. Pulau Hanaut	140400
140406	3	ID	Kec. Mentawa Baru/Ketapang	140400
140407	3	ID	Kec. Mentaya Hilir Utara	140400
140411	3	ID	Kec. Kota Besi	140400
140412	3	ID	Kec. Baamang	140400
140419	3	ID	Kec. Cempaga	140400
140420	3	ID	Kec. Parenggean	140400
140421	3	ID	Kec. Mentaya Hulu	140400
140423	3	ID	Kec. Antang Kalang	140400
140425	3	ID	Kec. Teluk Sampit	140400
140426	3	ID	Kec. Seranau	140400
140427	3	ID	Kec. Cempaga Hulu	140400
140428	3	ID	Kec. Bukit Santuei	140400
140429	3	ID	Kec. Telawang	140400
140430	3	ID	Kec. Tualan Hulu	140400
140431	3	ID	Kec. Telaga Antang	140400
140432	3	ID	Tualan Hulu	      
140433	3	ID	Telaga Antang	      
140500	2	ID	Kab. Kotawaringin Barat	140000
140504	3	ID	Kec. Kotawaringin Lama	140500
140505	3	ID	Kec. Arut Selatan	140500
140506	3	ID	Kec. Kumai	140500
140507	3	ID	Kec. Arut Utara	140500
140508	3	ID	Kec. Pangkalan Banteng	140500
140509	3	ID	Kec. Pangkalan Lada	140500
140600	2	ID	Kab. Katingan	140000
140601	3	ID	Kec. Katingan Kuala	140600
140602	3	ID	Kec. Mendawai	140600
140603	3	ID	Kec. Kampiang	140600
140604	3	ID	Kec. Tasik Payawan	140600
140605	3	ID	Kec. Katingan Hilir	140600
140606	3	ID	Kec. Tewang Sangalang Garing	140600
140607	3	ID	Kec. Pulau Malan	140600
140608	3	ID	Kec. Katingan Tengah	140600
140609	3	ID	Kec. Katingan Hulu	140600
140610	3	ID	Kec. Marikit	140600
140611	3	ID	Kec. Sanaman Mantikei	140600
140612	3	ID	Kec. Petak Malai	140600
140613	3	ID	Kec. Bukit Raya	140600
140700	2	ID	Kab. Seruyan	140000
140701	3	ID	Kec. Seruyan Hilir	140700
140702	3	ID	Kec. Danau Sembuluh	140700
140703	3	ID	Kec. Hanau	140700
140704	3	ID	Kec. Seruyan Tengah	140700
140705	3	ID	Kec. Seruyan Hulu	140700
140706	3	ID	Kec. Seruyan Hilir Timur	140700
140707	3	ID	Kec. Seruyan Raya	140700
140708	3	ID	Kec. Danau Seluluk	140700
140709	3	ID	Kec. Batu Ampar	140700
140710	3	ID	Kec. Suling Tambun	140700
140711	3	ID	Kec. Sembuluh Raya	140700
140712	3	ID	Kec. Natai Kelampai	140700
140713	3	ID	Kec. Sepan Biha	140700
140714	3	ID	Kec. Seruyan Hulu Utara	140700
140790	3	ID	Natai Kelampai	      
140791	3	ID	Sepan Biha	      
140792	3	ID	Seruyan Hulu Utara	      
140799	3	ID	Sembuluh Raya	      
140800	2	ID	Kab. Sukamara	140000
140801	3	ID	Kec. Jelai	140800
140802	3	ID	Kec. Sukamara	140800
140803	3	ID	Kec. Balai Riam	140800
140804	3	ID	Kec. Pantai Lunci	140800
140805	3	ID	Kec. Permata Kecubung	140800
140900	2	ID	Kab. Lamandau	140000
140901	3	ID	Kec. Bulik	140900
140902	3	ID	Kec. Lamandau	140900
140903	3	ID	Kec. Delang	140900
140904	3	ID	Kec. Bulik Timur	140900
140905	3	ID	Kec. Mentobi Raya	140900
140906	3	ID	Kec. Sematu Jaya	140900
140907	3	ID	Kec. Belantikan Raya	140900
140908	3	ID	Kec. Batang Kawa	140900
141000	2	ID	Kab. Gunung Mas	140000
141001	3	ID	Kec. Tewah	141000
141002	3	ID	Kec. Kurun	141000
141003	3	ID	Kec. Sepang Simin	141000
141004	3	ID	Kec. Rungan	141000
141005	3	ID	Kec. Manuhing	141000
141006	3	ID	Kec. Kahayan Hulu Utara	141000
141007	3	ID	Kec. Mihing Raya	141000
141008	3	ID	Kec. Damang Batu	141000
141009	3	ID	Kec. Miri Manasa	141000
141010	3	ID	Kec. Rungan Hulu	141000
141011	3	ID	Kec. Manuhing Raya	141000
141100	2	ID	Kab. Pulang Pisau	140000
141101	3	ID	Kec. Kahayan Kuala	141100
141102	3	ID	Kec. Pandih Batu	141100
141103	3	ID	Kec. Maliku	141100
141104	3	ID	Kec. Kahayan Hilir	141100
141105	3	ID	Kec. Kahayan Tengah	141100
141106	3	ID	Kec. Banama Tingan	141100
141107	3	ID	Kec. Sebangau Kuala	141100
141108	3	ID	Kec. Jabiren Raya	141100
141200	2	ID	Kab. Murung Raya	140000
141201	3	ID	Kec. Laung Tuhup	141200
141202	3	ID	Kec. Murung	141200
141203	3	ID	Kec. Permata Intan	141200
141204	3	ID	Kec. Tanah Siang	141200
141205	3	ID	Kec. Sumber Barito	141200
141206	3	ID	Kec. Barito Tuhup Raya	141200
141207	3	ID	Kec. Tanah Siang Selatan	141200
141208	3	ID	Kec. Sungai Babuat	141200
141209	3	ID	Kec. Seribu Riam	141200
141210	3	ID	Kec. Uut Murung	141200
141300	2	ID	Kab. Barito Timur	140000
141301	3	ID	Kec. Dusun Timur	141300
141302	3	ID	Kec. Benua Lima	141300
141303	3	ID	Kec. Patangkep Tutui	141300
141304	3	ID	Kec. Awang	141300
141305	3	ID	Kec. Dusun Tengah	141300
141306	3	ID	Kec. Pematang Karau	141300
141307	3	ID	Kec. Paju Epat	141300
141308	3	ID	Kec. Reren Batuah	141300
141309	3	ID	Kec. Paku	141300
141310	3	ID	Kec. Karusen Janang	141300
146000	2	ID	Kota Palangka Raya	140000
146001	3	ID	Kec. Pahandut	146000
146002	3	ID	Kec. Bukit Batu	146000
146003	3	ID	Kec. Sabangau	146000
146004	3	ID	Kec. Jekan Raya	146000
146005	3	ID	Kec. Rakumpit	146000
150000	1	ID	Prov. Kalimantan Selatan	000000
150100	2	ID	Kab. Banjar	150000
150101	3	ID	Kec. Aluh-Aluh	150100
150102	3	ID	Kec. Gambut	150100
150103	3	ID	Kec. Kertak Hanyar	150100
150104	3	ID	Kec. Sungai Tabuk	150100
150105	3	ID	Kec. Martapura	150100
150106	3	ID	Kec. Astambul	150100
150107	3	ID	Kec. Karang Intan	150100
150108	3	ID	Kec. Aranio	150100
150109	3	ID	Kec. Sungai Pinang	150100
150110	3	ID	Kec. Pengaron	150100
150111	3	ID	Kec. Mataraman	150100
150112	3	ID	Kec. Simpang Empat	150100
150113	3	ID	Kec. Beruntung Baru	150100
150114	3	ID	Kec. Martapura Barat	150100
150115	3	ID	Kec. Martapura Timur	150100
150116	3	ID	Kec. Paramasan	150100
150117	3	ID	Kec. Tatah Makmur	150100
150118	3	ID	Kec. Sambung Makmur	150100
150119	3	ID	Kec. Telaga Bauntung	150100
150200	2	ID	Kab. Tanah Laut	150000
150201	3	ID	Kec. Panyipatan	150200
150202	3	ID	Kec. Takisung	150200
150203	3	ID	Kec. Kurau	150200
150204	3	ID	Kec. Bati-Bati	150200
150205	3	ID	Kec. Tambang Ulang	150200
150206	3	ID	Kec. Pelaihari	150200
150207	3	ID	Kec. Batu Ampar	150200
150208	3	ID	Kec. Jorong	150200
150209	3	ID	Kec. Kintap	150200
150210	3	ID	Kec. Harapan Bumi Makmur	150200
150211	3	ID	Kec. Bajuin	150200
150300	2	ID	Kab. Barito Kuala	150000
150301	3	ID	Kec. Tabunganen	150300
150302	3	ID	Kec. Tamban	150300
150303	3	ID	Kec. Mekarsari	150300
150304	3	ID	Kec. Anjir Pasar	150300
150305	3	ID	Kec. Anjir Muara	150300
150306	3	ID	Kec. Alalak	150300
150307	3	ID	Kec. Mandastana	150300
150308	3	ID	Kec. Belawang	150300
150309	3	ID	Kec. Wanaraya	150300
150310	3	ID	Kec. Barambai	150300
150311	3	ID	Kec. Rantau Badauh	150300
150312	3	ID	Kec. Cerbon	150300
150313	3	ID	Kec. Bakumpai	150300
150314	3	ID	Kec. Marabahan	150300
150315	3	ID	Kec. Tabukan	150300
150316	3	ID	Kec. Kuripan	150300
150317	3	ID	Kec. Jejangkit	150300
150400	2	ID	Kab. Tapin	150000
150401	3	ID	Kec. Binuang	150400
150402	3	ID	Kec. Tapin Selatan	150400
150403	3	ID	Kec. Tapin Tengah	150400
150404	3	ID	Kec. Bungur	150400
150405	3	ID	Kec. Piani	150400
150406	3	ID	Kec. Lokpaikat	150400
150407	3	ID	Kec. Tapin Utara	150400
150408	3	ID	Kec. Bakarangan	150400
150409	3	ID	Kec. Candi Laras Selatan	150400
150410	3	ID	Kec. Candi Laras Utara	150400
150411	3	ID	Kec. Hatungun	150400
150412	3	ID	Kec. Salam Babaris	150400
150500	2	ID	Kab. Hulu Sungai Selatan	150000
150501	3	ID	Kec. Padang Batung	150500
150502	3	ID	Kec. Loksado	150500
150503	3	ID	Kec. Telaga Langsat	150500
150504	3	ID	Kec. Angkinang	150500
150505	3	ID	Kec. Kandangan	150500
150506	3	ID	Kec. Sungai Raya	150500
150507	3	ID	Kec. Simpur	150500
150508	3	ID	Kec. Kalumpang	150500
150509	3	ID	Kec. Daha Selatan	150500
150510	3	ID	Kec. Daha Utara	150500
150511	3	ID	Kec. Daha Barat	150500
150600	2	ID	Kab. Hulu Sungai Tengah	150000
150601	3	ID	Kec. Haruyan	150600
150602	3	ID	Kec. Batu Benawa	150600
150603	3	ID	Kec. Hantakan	150600
150604	3	ID	Kec. Batang Alai Selatan	150600
150605	3	ID	Kec. Barabai	150600
150606	3	ID	Kec. Labuan Amas Selatan	150600
150607	3	ID	Kec. Labuan Amas Utara	150600
150608	3	ID	Kec. Pendawan	150600
150609	3	ID	Kec. Batang Alai Utara	150600
150610	3	ID	Kec. Batang Alai Timur	150600
150611	3	ID	Kec. Limpasu	150600
150700	2	ID	Kab. Hulu Sungai Utara	150000
150701	3	ID	Kec. Danau Panggang	150700
150702	3	ID	Kec. Babirik	150700
150703	3	ID	Kec. Sungai Pandan	150700
150704	3	ID	Kec. Amuntai Selatan	150700
150705	3	ID	Kec. Amuntai Tengah	150700
150706	3	ID	Kec. Banjang	150700
150707	3	ID	Kec. Amuntai Utara	150700
150708	3	ID	Kec. Paminggir	150700
150709	3	ID	Kec. Sungai Tabukan	150700
150710	3	ID	Kec. Haur Gading	150700
150800	2	ID	Kab. Tabalong	150000
150801	3	ID	Kec. Banua Lawas	150800
150802	3	ID	Kec. Pugaan	150800
150803	3	ID	Kec. Kelua	150800
150804	3	ID	Kec. Muara Harus	150800
150805	3	ID	Kec. Tanta	150800
150806	3	ID	Kec. Tanjung	150800
150807	3	ID	Kec. Murung Pudak	150800
150808	3	ID	Kec. Haruai	150800
150809	3	ID	Kec. Upau	150800
150810	3	ID	Kec. Muara Uya	150800
150811	3	ID	Kec. Jaro	150800
150812	3	ID	Kec. Bintang Ara	150800
150900	2	ID	Kab. Kota Baru	150000
150901	3	ID	Kec. Pulau Sembilan	150900
150902	3	ID	Kec. Pulau Laut Barat	150900
150903	3	ID	Kec. Pulau Laut Selatan	150900
150904	3	ID	Kec. Pulau Laut Timur	150900
150905	3	ID	Kec. Pulau Sebuku	150900
150906	3	ID	Kec. Pulau Laut Utara	150900
150907	3	ID	Kec. Pulau Laut Tengah	150900
150908	3	ID	Kec. Kelumpang Hilir	150900
150909	3	ID	Kec. Kelumpang Barat	150900
150912	3	ID	Kec. Kelumpang Selatan	150900
150913	3	ID	Kec. Kelumpang Hulu	150900
150914	3	ID	Kec. Hampang	150900
150915	3	ID	Kec. Sungai Durian	150900
150916	3	ID	Kec. Kelumpang Tengah	150900
150917	3	ID	Kec. Kelumpang Utara	150900
150918	3	ID	Kec. Pamukan Selatan	150900
150919	3	ID	Kec. Sampanahan	150900
150920	3	ID	Kec. Pamukan Utara	150900
150921	3	ID	Kec. Pulau Laut Kepulauan	150900
150922	3	ID	Kec. Pamukan Barat	150900
151000	2	ID	Kab. Balangan	150000
151001	3	ID	Kec. Lampihong	151000
151002	3	ID	Kec. Batu Mandi	151000
151003	3	ID	Kec. Awayan	151000
151004	3	ID	Kec. Paringin	151000
151005	3	ID	Kec. Juai	151000
151006	3	ID	Kec. Halong	151000
151007	3	ID	Kec. Tebing Tinggi	151000
151008	3	ID	Kec. Paringin Selatan	151000
151100	2	ID	Kab. Tanah Bumbu	150000
151101	3	ID	Kec. Kusan Hilir	151100
151102	3	ID	Kec. Sungai Loban	151100
151103	3	ID	Kec. Satui	151100
151104	3	ID	Kec. Kusan Hulu	151100
151105	3	ID	Kec. Batu Licin	151100
151106	3	ID	Kec. Simpang Empat	151100
151107	3	ID	Kec. Karang Bintang	151100
151108	3	ID	Kec. Mantewe	151100
151109	3	ID	Kec. Angsana	151100
151110	3	ID	Kec. Kuranji	151100
156000	2	ID	Kota Banjarmasin	150000
156001	3	ID	Kec. Banjarmasin Selatan	156000
156002	3	ID	Kec. Banjarmasin Timur	156000
156003	3	ID	Kec. Banjarmasin Barat	156000
156004	3	ID	Kec. Banjarmasin Utara	156000
156005	3	ID	Kec. Banjarmasin Tengah	156000
156100	2	ID	Kota Banjarbaru	150000
156101	3	ID	Kec. Landasan Ulin	156100
156102	3	ID	Kec. Cempaka	156100
156104	3	ID	Kec. Banjarbaru Utara	156100
156105	3	ID	Kec. Banjarbaru Selatan	156100
156106	3	ID	Kec. Liang Anggang	156100
160000	1	ID	Prov. Kalimantan Timur	000000
160100	2	ID	Kab. Pasir	160000
160101	3	ID	Kec. Batu Sopang	160100
160102	3	ID	Kec. Tanjung Harapan	160100
160103	3	ID	Kec. Pasir Balengkong	160100
160104	3	ID	Kec. Tanah Grogot	160100
160105	3	ID	Kec. Kuaro	160100
160106	3	ID	Kec. Long Ikis	160100
160107	3	ID	Kec. Muara Komam	160100
160108	3	ID	Kec. Long Kali	160100
160109	3	ID	Kec. Muara Samu	160100
160110	3	ID	Kec. Batu Engau	160100
160200	2	ID	Kab. Kutai Kartanegara	160000
160201	3	ID	Kec. Semboja	160200
160202	3	ID	Kec. Muara Jawa	160200
160203	3	ID	Kec. Sanga-Sanga	160200
160204	3	ID	Kec. Loa Janan	160200
160205	3	ID	Kec. Loa Kulu	160200
160206	3	ID	Kec. Muara Muntai	160200
160207	3	ID	Kec. Muara Wis	160200
160208	3	ID	Kec. Kota Bangun	160200
160209	3	ID	Kec. Tenggarong	160200
160210	3	ID	Kec. Sebulu	160200
160211	3	ID	Kec. Tenggarong Seberang	160200
160212	3	ID	Kec. Anggana	160200
160213	3	ID	Kec. Muara Badak	160200
160214	3	ID	Kec. Marang Kayu	160200
160215	3	ID	Kec. Muara Kaman	160200
160216	3	ID	Kec. Kenohan	160200
160217	3	ID	Kec. Kembang Janggut	160200
160218	3	ID	Kec. Tabang	160200
160300	2	ID	Kab. Berau	160000
160301	3	ID	Kec. Kelay	160300
160302	3	ID	Kec. Talisayan	160300
160303	3	ID	Kec. Biduk Biduk	160300
160304	3	ID	Kec. Pulau Derawan	160300
160305	3	ID	Kec. Sambaliung	160300
160306	3	ID	Kec. Tanjung Redeb	160300
160307	3	ID	Kec. Gunung Tabur	160300
160308	3	ID	Kec. Segah	160300
160309	3	ID	Kec. Teluk Bayur	160300
160312	3	ID	Kec. Tubalar	160300
160313	3	ID	Kec. Pulau Maratua	160300
160314	3	ID	Kec. Batu Putih	160300
160315	3	ID	Kec. Biatan	160300
160400	2	ID	Kab. Bulongan	160000
160402	3	ID	Kec. Tanjung Palas	160400
160403	3	ID	Kec. Sekatak	160400
160405	3	ID	Kec. Pulau Bunyu	160400
160406	3	ID	Kec. Tanjung Palas Barat	160400
160407	3	ID	Kec. Tanjung Palas Utara	160400
160408	3	ID	Kec. Tanjung Palas Timur	160400
160409	3	ID	Kec. Tanjung Selor	160400
160410	3	ID	Kec. Tanjung Palas Tengah	160400
160411	3	ID	Kec. Peso Hilir	160400
160413	3	ID	Kec. Peso	160400
160700	2	ID	Kab. Malinau	160000
160701	3	ID	Kec. Kayan Hulu	160700
160702	3	ID	Kec. Kayan Hilir	160700
160703	3	ID	Kec. Pujungan	160700
160704	3	ID	Kec. Malinau Kota	160700
160705	3	ID	Kec. Mentarang	160700
160706	3	ID	Kec. Sungai Boh	160700
160707	3	ID	Kec. Malinau Selatan	160700
160708	3	ID	Kec. Malinau Barat	160700
160709	3	ID	Kec. Malinau Utara	160700
160710	3	ID	Kec. Kayan Selatan	160700
160711	3	ID	Kec. Bahau Hulu	160700
160712	3	ID	Kec. Mentarang Hulu	160700
160800	2	ID	Kab. Nunukan	160000
160801	3	ID	Kec. Kerayan	160800
160802	3	ID	Kec. Lumbis	160800
160803	3	ID	Kec. Sembakung	160800
160804	3	ID	Kec. Nunukan	160800
160805	3	ID	Kec. Sebatik	160800
160806	3	ID	Kec. Sebuku	160800
160807	3	ID	Kec. Krayan Selatan	160800
160808	3	ID	Kec. Sebatik Barat	160800
160809	3	ID	Kec. Nunukan Selatan	160800
160814	3	ID	Nunukan	      
160815	3	ID	Krayan Selatan	      
160816	3	ID	Krayan	      
160817	3	ID	Nunukan Selatan	      
160900	2	ID	Kab. Kutai Barat	160000
160901	3	ID	Kec. Bongan	160900
160902	3	ID	Kec. Jempang	160900
160903	3	ID	Kec. Penyinggahan	160900
160904	3	ID	Kec. Muara Pahu	160900
160905	3	ID	Kec. Muara Lawa	160900
160906	3	ID	Kec. Damai	160900
160907	3	ID	Kec. Barong Tongkok	160900
160908	3	ID	Kec. Melak	160900
160909	3	ID	Kec. Long Iram	160900
160910	3	ID	Kec. Long Hubung	160900
160911	3	ID	Kec. Long Bagun	160900
160912	3	ID	Kec. Long Pahangai	160900
160913	3	ID	Kec. Long Apari	160900
160915	3	ID	Kec. Bentian Besar	160900
160916	3	ID	Kec. Linggang Bingung	160900
160917	3	ID	Kec. Manor Bulatn	160900
160918	3	ID	Kec. Laham	160900
160919	3	ID	Kec. Nyuatan	160900
160920	3	ID	Kec. Sekolaq Darat	160900
160921	3	ID	Kec. Tering	160900
160923	3	ID	Kec. Siluq Ngurai	160900
160924	3	ID	Long Bagun	      
160990	3	ID	Long Apari	      
160991	3	ID	Long Pahangai	      
160992	3	ID	Long Hubung	      
160993	3	ID	Laham	      
161000	2	ID	Kab. Kutai Timur	160000
161001	3	ID	Kec. Muara Ancalong	161000
161002	3	ID	Kec. Muara Wahau	161000
161003	3	ID	Kec. Muara Bengkal	161000
161004	3	ID	Kec. Sengata Utara	161000
161005	3	ID	Kec. Sangkulirang	161000
161006	3	ID	Kec. Kaliorang	161000
161008	3	ID	Kec. Kombeng	161000
161009	3	ID	Kec. Bengalon	161000
161010	3	ID	Kec. Busang	161000
161011	3	ID	Kec. Sandaran	161000
161012	3	ID	Kec. Telen	161000
161013	3	ID	Kec. Sengata Selatan	161000
161014	3	ID	Kec. Teluk Pandan	161000
161015	3	ID	Kec. Rantau Pulung	161000
161016	3	ID	Kec. Kaubun	161000
161017	3	ID	Kec. Karangan	161000
161018	3	ID	Kec. Batu Ampar	161000
161019	3	ID	Kec. Long Mesangat	161000
161100	2	ID	Kab. Penajam Paser Utara	160000
161101	3	ID	Kec. Babulu	161100
161102	3	ID	Kec. Waru	161100
161103	3	ID	Kec. Penajam	161100
161104	3	ID	Kec. Sepaku	161100
165400	2	ID	Kab. Tanah Tidung	160000
166000	2	ID	Kota Samarinda	160000
166001	3	ID	Kec. Palaran	166000
166002	3	ID	Kec. Samarinda Ilir	166000
166003	3	ID	Kec. Samarinda Seberang	166000
166004	3	ID	Kec. Sungai Kunjang	166000
166005	3	ID	Kec. Samarinda Ulu	166000
166006	3	ID	Kec. Samarinda Utara	166000
166007	3	ID	Kec. Sambutan	166000
166008	3	ID	Kec. Sungai Pinang	166000
166009	3	ID	Kec. Samarinda Kota	166000
166010	3	ID	Kec. Loa Janan Ilir	166000
166100	2	ID	Kota Balikpapan	160000
166101	3	ID	Kec. Balikpapan Selatan	166100
166102	3	ID	Kec. Balikpapan Timur	166100
166103	3	ID	Kec. Balikpapan Utara	166100
166104	3	ID	Kec. Balikpapan Tengah	166100
166105	3	ID	Kec. Balikpapan Barat	166100
166200	2	ID	Kota Tarakan	160000
166201	3	ID	Kec. Tarakan Timur	166200
166202	3	ID	Kec. Tarakan Tengah	166200
166203	3	ID	Kec. Tarakan Barat	166200
166204	3	ID	Kec. Tarakan Utara	166200
166300	2	ID	Kota Bontang	160000
166301	3	ID	Kec. Bontang Selatan	166300
166302	3	ID	Kec. Bontang Utara	166300
166303	3	ID	Kec. Bontang Barat	166300
166404	3	ID	Sesayap	      
166412	3	ID	Sesayap Hilir	      
166414	3	ID	Tana Lia	      
170000	1	ID	Prov. Sulawesi Utara	000000
170100	2	ID	Kab. Bolaang Mongondaw	170000
170106	3	ID	Kec. Lolayan	170100
170109	3	ID	Kec. Poigar	170100
170110	3	ID	Kec. Bolaang	170100
170111	3	ID	Kec. Lolak	170100
170112	3	ID	Kec. Sangtombolang	170100
170117	3	ID	Kec. Dumoga Utara	170100
170119	3	ID	Kec. Dumoga Barat	170100
170120	3	ID	Kec. Dumoga Timur	170100
170128	3	ID	Kec. Passi Barat	170100
170129	3	ID	Kec. Passi Timur	170100
170130	3	ID	Kec. Bilalang	170100
170131	3	ID	Kec. Sangtombolang	170100
170133	3	ID	Bolaang Timur	      
170200	2	ID	Kab. Minahasa	170000
170209	3	ID	Kec. Langowan Timur	170200
170211	3	ID	Kec. Tompaso	170200
170212	3	ID	Kec. Kawangkoan	170200
170213	3	ID	Kec. Sonder	170200
170216	3	ID	Kec. Tombariri	170200
170217	3	ID	Kec. Pineleng	170200
170219	3	ID	Kec. Tondano Timur	170200
170220	3	ID	Kec. Remboken	170200
170221	3	ID	Kec. Kakas	170200
170222	3	ID	Kec. Lembean Timur	170200
170223	3	ID	Kec. Eris	170200
170224	3	ID	Kec. Kombi	170200
170233	3	ID	Kec. Langowan Barat	170200
170234	3	ID	Kec. Tombulu	170200
170235	3	ID	Kec. Tondano Barat	170200
170236	3	ID	Kec. Tondano Utara	170200
170237	3	ID	Kec. Langowan Selatan	170200
170238	3	ID	Kec. Tondano Selatan	170200
170239	3	ID	Kec. Langowan Utara	170200
170300	2	ID	Kab. Kep. Sangihe	170000
170304	3	ID	Kec. Manganitu Selatan	170300
170305	3	ID	Kec. Tamako	170300
170306	3	ID	Kec. Tabukan Selatan	170300
170307	3	ID	Kec. Tabukan Tengah	170300
170308	3	ID	Kec. Manganitu	170300
170309	3	ID	Kec. Tahuna	170300
170310	3	ID	Kec. Tabukan Utara	170300
170311	3	ID	Kec. Kendahe	170300
170313	3	ID	Kec. Tatoareng	170300
170317	3	ID	Kec. Nusa Tabukan	170300
170319	3	ID	Kec. Tabukan Selatan Tengah	170300
170320	3	ID	Kec. Tabukan Selatan Tenggara	170300
170323	3	ID	Kec. Tahuna Timur	170300
170324	3	ID	Kec. Tahuna Barat	170300
170390	3	ID	Kepulauan Marore	      
170400	2	ID	Kab. Kepulauan Talaud	170000
170401	3	ID	Kec. Kabaruan	170400
170402	3	ID	Kec. Lirung	170400
170403	3	ID	Kec. Melonguane	170400
170404	3	ID	Kec. Beo	170400
170405	3	ID	Kec. Rainis	170400
170406	3	ID	Kec. Essang	170400
170407	3	ID	Kec. Nanusa	170400
170408	3	ID	Kec. Gemeh	170400
170409	3	ID	Kec. Damau	170400
170410	3	ID	Kec. Tanpa Namma	170400
170411	3	ID	Kec. Lirung Selatan	170400
170412	3	ID	Kec. Kalongan	170400
170413	3	ID	Kec. Moronge	170400
170414	3	ID	Kec. Melonguane Timur	170400
170415	3	ID	Kec. Beo Utara	170400
170416	3	ID	Kec. Beo Selatan	170400
170417	3	ID	Kec. Pulutan	170400
170418	3	ID	Kec. Essang Selatan	170400
170419	3	ID	Kec. Miangas	170400
170420	3	ID	Salibabu	      
170500	2	ID	Kab. Minahasa Selatan	170000
170501	3	ID	Kec. Modoinding	170500
170502	3	ID	Kec. Tompaso Baru	170500
170503	3	ID	Kec. Ranoyapo	170500
170504	3	ID	Kec. Motoling	170500
170505	3	ID	Kec. Tenga	170500
170509	3	ID	Kec. Amurang	170500
170510	3	ID	Kec. Tareran	170500
170515	3	ID	Kec. Kumelembuai	170500
170516	3	ID	Kec. Maesaan	170500
170517	3	ID	Kec. Amurang Barat	170500
170518	3	ID	Kec. Amurang Timur	170500
170519	3	ID	Kec. Tatapan	170500
170520	3	ID	Kec. Motoling Barat	170500
170521	3	ID	Kec. Motoling Timur	170500
170522	3	ID	Kec. Sulta	170500
170523	3	ID	Kec. Tumpaan	170500
170524	3	ID	Sinonsayang	      
170529	3	ID	Kec. Ratatotok	170500
170530	3	ID	Kec. Pusomaen	170500
170600	2	ID	Kab. Minahasa Utara	170000
170601	3	ID	Kec. Kauditan	170600
170602	3	ID	Kec. Airmadidi	170600
170603	3	ID	Kec. Dimembe	170600
170604	3	ID	Kec. Wori	170600
170605	3	ID	Kec. Likupang Timur	170600
170606	3	ID	Kec. Kema	170600
170607	3	ID	Kec. Likupang Barat	170600
170608	3	ID	Kec. Kalawat	170600
170609	3	ID	Kec. Talawaan	170600
170610	3	ID	Kec. Likupang Selatan	170600
170800	2	ID	Kab. Bolaang Mongondow Utara	170000
170801	3	ID	Kec. Bintauna	170800
170802	3	ID	Kec. Bolaang Itang Timur	170800
170803	3	ID	Kec. Bolaang Itang Barat	170800
170804	3	ID	Kec. Kaidipang	170800
170805	3	ID	Kec. Pinogaluman	170800
170806	3	ID	Kec. Sangkub	170800
170900	2	ID	Kab. Kepulauan Sitaro	170000
170901	3	ID	Kec. Biaro	170900
170902	3	ID	Kec. Siau Barat	170900
170903	3	ID	Kec. Siau Barat Selatan	170900
170904	3	ID	Kec. Siau Barat Utara	170900
170905	3	ID	Kec. Siau Tengah	170900
170906	3	ID	Kec. Siau Timur	170900
170907	3	ID	Kec. Siau Timur Selatan	170900
170908	3	ID	Kec. Tagulandang	170900
170909	3	ID	Kec. Tagulandang Selatan	170900
170910	3	ID	Kec. Tagulandang Utara	170900
171000	2	ID	Kab. Minahasa Tenggara	170000
171001	3	ID	Kec. Ratatotok	171000
171002	3	ID	Kec. Pusomaen	171000
171003	3	ID	Kec. Belang	171000
171004	3	ID	Kec. Ratahan	171000
171005	3	ID	Kec. Tombatu	171000
171006	3	ID	Kec. Touluaan	171000
171007	3	ID	Kec. Touluaan Selatan	171000
171008	3	ID	Kec. Silian Raya	171000
171009	3	ID	Kec. Tombatu Timur	171000
171010	3	ID	Kec. Tombatu Utara	171000
171011	3	ID	Kec. Pasan	171000
171012	3	ID	Kec. Ratahan Timur	171000
171100	2	ID	Kab. Bolaang Mongondaw Timur	170000
171101	3	ID	Kec. Kotabunan	171100
171102	3	ID	Kec. Nuangan	171100
171103	3	ID	Kec.Tutuyan	171100
171104	3	ID	Kec. Modayag	171100
171105	3	ID	Kec. Modayag Barat	171100
171200	2	ID	Kab. Bolaang Mongondaw Selatan	170000
171201	3	ID	Kec. Bolaang Uki	171200
171202	3	ID	Kec. Posigadan	171200
171203	3	ID	Kec. Pinolosian	171200
171204	3	ID	Kec. Pinolosian Timur	171200
171205	3	ID	Kec. Pinolosian Tengah	171200
176000	2	ID	Kota Manado	170000
176001	3	ID	Kec. Malalayang	176000
176002	3	ID	Kec. Sario	176000
176003	3	ID	Kec. Wenang	176000
176004	3	ID	Kec. Mapanget	176000
176005	3	ID	Kec. Bunaken	176000
176006	3	ID	Kec. Wanea	176000
176007	3	ID	Kec. Tikala	176000
176008	3	ID	Kec. Tuminting	176000
176009	3	ID	Kec. Singkil	176000
176100	2	ID	Kota Bitung	170000
176101	3	ID	Kec. Ranowulu	176100
176102	3	ID	Kec. Matuari	176100
176103	3	ID	Kec. Girian	176100
176104	3	ID	Kec. Madidir	176100
176105	3	ID	Kec. Maesa	176100
176106	3	ID	Kec. Aertembaga	176100
176107	3	ID	Kec. Lembeh Utara	176100
176108	3	ID	Kec. Lembeh Selatan	176100
176200	2	ID	Kota Tomohon	170000
176201	3	ID	Kec. Tomohon Utara	176200
176202	3	ID	Kec. Tomohon Tengah	176200
176203	3	ID	Kec. Tomohon Selatan	176200
176204	3	ID	Kec. Tomohon Timur	176200
176205	3	ID	Kec. Tomohon Barat	176200
176300	2	ID	Kota. Kotamobagu	170000
176301	3	ID	Kec. Kotamobagu Barat	176300
176302	3	ID	Kec. Kotamobagu Timur	176300
176303	3	ID	Kec. Kotamobagu Utara	176300
176304	3	ID	Kec. Kotamobagu Selatan	176300
180000	1	ID	Prov. Sulawesi Tengah	000000
180100	2	ID	Kab. Banggai Kepulauan	180000
180101	3	ID	Kec. Labobo	180100
180102	3	ID	Kec. Banggai	180100
180103	3	ID	Kec. Totikum	180100
180104	3	ID	Kec. Tinangkung	180100
180105	3	ID	Kec. Liang	180100
180106	3	ID	Kec. Bulagi	180100
180107	3	ID	Kec. Buko	180100
180109	3	ID	Kec. Bokan Kepulauan	180100
180110	3	ID	Kec. Bulagi Selatan	180100
180111	3	ID	Kec. Bangkurung	180100
180112	3	ID	Kec. Banggai Utara	180100
180113	3	ID	Kec. Banggai Tengah	180100
180114	3	ID	Kec. Banggai Selatan	180100
180115	3	ID	Kec. Selatan	180100
180116	3	ID	Kec. Tinangkung Selatan	180100
180117	3	ID	Kec. Tinangkung Utara	180100
180118	3	ID	Kec. Peling Tengah	180100
180119	3	ID	Kec. Bulagi Utara	180100
180120	3	ID	Kec. Buko Selatan	180100
180121	3	ID	Banggai Utara	      
180122	3	ID	Banggai	      
180190	3	ID	Labobo	      
180191	3	ID	Bokan Kepulauan	      
180192	3	ID	Bangkurung	      
180193	3	ID	Banggai Tengah	      
180194	3	ID	Banggai Selatan	      
180199	3	ID	Totikum Selatan	      
180200	2	ID	Kab. Donggala	180000
180208	3	ID	Kec. Banawa	180200
180209	3	ID	Kec. Labuan	180200
180210	3	ID	Kec. Sindue	180200
180212	3	ID	Kec. Sirenja	180200
180213	3	ID	Kec. Balaesang	180200
180214	3	ID	Kec. Damsol	180200
180216	3	ID	Kec. Sojol	180200
180220	3	ID	Kec. Rio Pakava	180200
180224	3	ID	Kec. Banawa Selatan	180200
180225	3	ID	Kec. Tanantovea	180200
180227	3	ID	Kec. Pinembani	180200
180233	3	ID	Kec. Banawa Tengah	180200
180234	3	ID	Kec. Sindue Tombusabora	180200
180235	3	ID	Kec. Sindue Tobata	180200
180236	3	ID	Kec. Sojol Utara	180200
180237	3	ID	Kec. Balaesang Tanjung	180200
180290	3	ID	Dompelas Sojol	      
180300	2	ID	Kab. Parigi Mautong	180000
180301	3	ID	Kec. Pamona Selatan	180300
180302	3	ID	Kec. Lore Selatan	180300
180303	3	ID	Kec. Pamona Utara	180300
180304	3	ID	Kec. Lore Utara	180300
180305	3	ID	Kec. Poso Pesisir	180300
180306	3	ID	Kec. Lage	180300
180307	3	ID	Kec. Poso Kota	180300
180314	3	ID	Kec. Pamona Timur	180300
180315	3	ID	Kec. Lore Tengah	180300
180316	3	ID	Kec. Pamona Barat	180300
180317	3	ID	Kec. Poso Pesisir Selatan	180300
180318	3	ID	Kec. Poso Pesisir Utara	180300
180319	3	ID	Kec. Poso Kota Utara	180300
180320	3	ID	Kec. Lore Barat	180300
180321	3	ID	Kec. Poso Kota Selatan	180300
180322	3	ID	Pamona Puselemba	180300
180323	3	ID	Kec. Lore Timur	180300
180324	3	ID	Kec. Lore Peore	180300
180325	3	ID	Pamona Tenggara	180300
180400	2	ID	Kab. Banggai	180000
180401	3	ID	Kec. Toili	180400
180402	3	ID	Kec. Batui	180400
180403	3	ID	Kec. Bunta	180400
180404	3	ID	Kec. Kintom	180400
180405	3	ID	Kec. Luwuk	180400
180406	3	ID	Kec. Pagimana	180400
180407	3	ID	Kec. Lamala	180400
180408	3	ID	Kec. Balantak	180400
180409	3	ID	Kec. Bualemo	180400
180410	3	ID	Kec. Toili Barat	180400
180411	3	ID	Kec. Nuhon	180400
180412	3	ID	Kec. Luwuk Timur	180400
180413	3	ID	Kec. Masama	180400
180500	2	ID	Kab. Buol	180000
180501	3	ID	Kec. Biau	180500
180502	3	ID	Kec. Momunu	180500
180503	3	ID	Kec. Bokat	180500
180504	3	ID	Kec. Bunobogu	180500
180505	3	ID	Kec. Paleleh	180500
180506	3	ID	Kec. Tiloan	180500
180507	3	ID	Kec. Bukal	180500
180508	3	ID	Kec. Gadung	180500
180509	3	ID	Kec. Lipunoto	180500
180510	3	ID	Kec. Karamat	180500
180511	3	ID	Kec. Paleleh Barat	180500
180512	3	ID	Lakea	      
180600	2	ID	Kab. Toli-Toli	180000
180601	3	ID	Kec. Dampal Selatan	180600
180602	3	ID	Kec. Dampal Utara	180600
180603	3	ID	Kec. Dondo	180600
180604	3	ID	Kec. Baolan	180600
180605	3	ID	Kec. Galang	180600
180606	3	ID	Kec. Utara Toli-Toli	180600
180607	3	ID	Kec. Ogo Deide	180600
180608	3	ID	Kec. Basidondo	180600
180609	3	ID	Kec. Lampasio	180600
180610	3	ID	Kec. Dako Pemean	180600
180700	2	ID	Kab. Marowali	180000
180701	3	ID	Kec. Menui Kepulauan	180700
180702	3	ID	Kec. Bungku Selatan	180700
180703	3	ID	Kec. Bungku Tengah	180700
180704	3	ID	Kec. Bungku Barat	180700
180705	3	ID	Kec. Lembo	180700
180706	3	ID	Kec. Mori Atas	180700
180707	3	ID	Kec. Petasia	180700
180708	3	ID	Kec. Bungku Utara	180700
180709	3	ID	Kec. Bahodopi	180700
180710	3	ID	Kec. Soyo Jaya	180700
180711	3	ID	Kec. Witaponda	180700
180712	3	ID	Kec. Mamosalato	180700
180713	3	ID	Kec. Bumi Raya	180700
180800	2	ID	Kab. Poso	180000
180801	3	ID	Kec. Sausu	180800
180802	3	ID	Kec. Parigi	180800
180803	3	ID	Kec. Ampibabo	180800
180804	3	ID	Kec. Tinombo	180800
180805	3	ID	Kec. Tomini	180800
180806	3	ID	Kec. Moutong	180800
180807	3	ID	Kec. Bolano Lambunu	180800
180808	3	ID	Kec. Kasimbar	180800
180809	3	ID	Kec. Torue	180800
180810	3	ID	Kec. Tinombo Selatan	180800
180811	3	ID	Kec. Parigi Selatan	180800
180812	3	ID	Kec. Mepanga	180800
180813	3	ID	Kec. Malakosa	180800
180814	3	ID	Kec. Parigi Barat	180800
180815	3	ID	Kec. Parigi Utara	180800
180816	3	ID	Kec. Ribulu	180800
180817	3	ID	Kec. Siniu	180800
180818	3	ID	Kec. Palasa	180800
180819	3	ID	Kec. Taopa	180800
180820	3	ID	Kec. Parigi Tengah	180800
180821	3	ID	Balinggi	      
180890	3	ID	Ongka Malino	      
180891	3	ID	Bolano	      
180892	3	ID	Lambunu	      
180900	2	ID	Kab. Tojo Una-Una	180000
180901	3	ID	Kec. Tojo	180900
180902	3	ID	Kec. Ulubongka	180900
180903	3	ID	Kec. Ampana Tete	180900
180904	3	ID	Kec. Ampana Kota	180900
180905	3	ID	Kec. Una - Una	180900
180906	3	ID	Kec. Walea Kepulauan	180900
180907	3	ID	Kec. Togean	180900
180908	3	ID	Kec. Tojo Barat	180900
180909	3	ID	Kec. Walea Besar	180900
181000	2	ID	Kab. Sigi	180000
181001	3	ID	Kec. Kulawi	181000
181002	3	ID	Kec. Pipikoro	181000
181003	3	ID	Kec. Kulawi Selatan	181000
181004	3	ID	Kec. Lindu	181000
181005	3	ID	Kec. Palolo	181000
181006	3	ID	Kec. Nokilalaki	181000
181007	3	ID	Kec. Dolo	181000
181008	3	ID	Kec. Dolo Selatan	181000
181009	3	ID	Kec. Dolo Barat	181000
181010	3	ID	Kec. Marawola	181000
181011	3	ID	Kec. Kinovaru	181000
181012	3	ID	Kec. Marawola Barat	181000
181013	3	ID	Kec. Sigibiromaru	181000
181014	3	ID	Kec. Gumbasa	181000
181015	3	ID	Kec. Tanambulava	181000
186000	2	ID	Kota Palu	180000
186001	3	ID	Kec. Palu Barat	186000
186002	3	ID	Kec. Palu Selatan	186000
186003	3	ID	Kec. Palu Timur	186000
186004	3	ID	Kec. Palu Utara	186000
190000	1	ID	Prov. Sulawesi Selatan	000000
190100	2	ID	Kab. Maros	190000
190101	3	ID	Kec. Mandai	190100
190102	3	ID	Kec. Maros Baru	190100
190103	3	ID	Kec. Maros Utara	190100
190104	3	ID	Kec. Bantimurung	190100
190105	3	ID	Kec. Tanralili	190100
190106	3	ID	Kec. Camba	190100
190107	3	ID	Kec. Mallawa	190100
190108	3	ID	Kec. Moncongloe	190100
190109	3	ID	Kec. Turikale	190100
190110	3	ID	Kec. Marusu	190100
190111	3	ID	Kec. Lau	190100
190112	3	ID	Kec. Simbang	190100
190113	3	ID	Kec. Tompobulu	190100
190114	3	ID	Kec. Cenrana	190100
190115	3	ID	Bontoa	      
190200	2	ID	Kab. Pangkajene Kepulauan	190000
190201	3	ID	Kec. Liukang Tangaya	190200
190202	3	ID	Kec. Liukang Kalukuang Masalim	190200
190203	3	ID	Kec. Liukang Tapabiring	190200
190204	3	ID	Kec. Pangkajene	190200
190205	3	ID	Kec. Balocci	190200
190206	3	ID	Kec. Bungoro	190200
190207	3	ID	Kec. Labakkang	190200
190208	3	ID	Kec. Ma`rang	190200
190209	3	ID	Kec. Sigeri	190200
190210	3	ID	Kec. Minasatene	190200
190211	3	ID	Kec. Tondong Tallasa	190200
190212	3	ID	Kec. Mandalle	190200
190213	3	ID	Liukang Tupabbiring Utara	190200
190300	2	ID	Kab. Gowa	190000
190301	3	ID	Kec. Bontonompo	190300
190302	3	ID	Kec. Bajeng	190300
190303	3	ID	Kec. Pallangga	190300
190304	3	ID	Kec. Somba Opu	190300
190305	3	ID	Kec. Bontomarannu	190300
190306	3	ID	Kec. Parang Loe	190300
190307	3	ID	Kec. Tinggi Moncong	190300
190308	3	ID	Kec. Bungaya	190300
190309	3	ID	Kec. Tompobulu	190300
190310	3	ID	Kec. Barombong	190300
190311	3	ID	Kec. Biring Bulu	190300
190312	3	ID	Kec. Tombolo Pao	190300
190313	3	ID	Kec. Manuju	190300
190314	3	ID	Kec. Bontolempangan	190300
190315	3	ID	Kec. Pattallassang	190300
190316	3	ID	Kec. Bontonompo Selatan	190300
190317	3	ID	Kec. Parigi	190300
190318	3	ID	Kec. Bajeng Barat	190300
190399	3	ID	Pattalasang	      
190400	2	ID	Kab. Takalar	190000
190401	3	ID	Kec. Mangarabombang	190400
190402	3	ID	Kec. Mappakasunggu	190400
190403	3	ID	Kec. Polombangkeng Selatan	190400
190404	3	ID	Kec. Polombangkeng Utara	190400
190405	3	ID	Kec. Galesong Selatan	190400
190406	3	ID	Kec. Galesong Utara	190400
190408	3	ID	Kec. Pattallassang	190400
190409	3	ID	Kec. Sanrobone	190400
190410	3	ID	Kec. Galesong	190400
190500	2	ID	Kab. Jeneponto	190000
190501	3	ID	Kec. Bangkala	190500
190502	3	ID	Kec. Tamalatea	190500
190503	3	ID	Kec. Binamu	190500
190504	3	ID	Kec. Batang	190500
190505	3	ID	Kec. Kelara	190500
190506	3	ID	Kec. Bangkala Barat	190500
190507	3	ID	Kec. Bontoramba	190500
190508	3	ID	Kec. Turatea	190500
190509	3	ID	Kec. Arungkeke	190500
190510	3	ID	Kec. Rumbia	190500
190511	3	ID	Kec. Tarowang	190500
190600	2	ID	Kab. Barru	190000
190601	3	ID	Kec. Tanete Riaja	190600
190602	3	ID	Kec. Tanete Rilau	190600
190603	3	ID	Kec. Barru	190600
190604	3	ID	Kec. Soppeng Riaja	190600
190605	3	ID	Kec. Mallusetasi	190600
190606	3	ID	Kec. Balusu	190600
190607	3	ID	Kec. Pujananting	190600
190700	2	ID	Kab. Bone	190000
190701	3	ID	Kec. Bontocani	190700
190702	3	ID	Kec. Kahu	190700
190703	3	ID	Kec. Kajuara	190700
190704	3	ID	Kec. Selomekko	190700
190705	3	ID	Kec. Tonra	190700
190706	3	ID	Kec. Patimpeng	190700
190707	3	ID	Kec. Libureng	190700
190708	3	ID	Kec. Mare	190700
190709	3	ID	Kec. Sibulue	190700
190710	3	ID	Kec. Cina	190700
190711	3	ID	Kec. Barebbo	190700
190712	3	ID	Kec. Ponre	190700
190713	3	ID	Kec. Lappariaja	190700
190714	3	ID	Kec. Lamuru	190700
190715	3	ID	Kec. Bengo	190700
190716	3	ID	Kec. Ulaweng	190700
190717	3	ID	Kec. Palakka	190700
190718	3	ID	Kec. Awangpone	190700
190719	3	ID	Kec. Tellu Siattinge	190700
190720	3	ID	Kec. Amali	190700
190721	3	ID	Kec. Ajangale	190700
190722	3	ID	Kec. Dua Boccoe	190700
190723	3	ID	Kec. Cenrana	190700
190724	3	ID	Kec. Tanete Riattang Barat	190700
190725	3	ID	Kec. Tanete Riattang	190700
190726	3	ID	Kec. Tanete Riattang Timur	190700
190727	3	ID	Kec. Tellu Limpoe	190700
190800	2	ID	Kab. Wajo	190000
190801	3	ID	Kec. Sabbangparu	190800
190802	3	ID	Kec. Tempe	190800
190803	3	ID	Kec. Pammana	190800
190804	3	ID	Kec. Bola	190800
190805	3	ID	Kec. Takkalala	190800
190806	3	ID	Kec. Sajo Anging	190800
190807	3	ID	Kec. Majauleng	190800
190808	3	ID	Kec. Tanasitolo	190800
190809	3	ID	Kec. Belawa	190800
190810	3	ID	Kec. Maniang Pajo	190800
190811	3	ID	Kec. Keera	190800
190812	3	ID	Kec. Pitumpanua	190800
190813	3	ID	Kec. Gilireng	190800
190814	3	ID	Kec. Penrang	190800
190900	2	ID	Kab. Soppeng	190000
190901	3	ID	Kec. Mariowiwawo	190900
190902	3	ID	Kec. Lalabata	190900
190903	3	ID	Kec. Liliriaja	190900
190904	3	ID	Kec. Lili Rilau	190900
190905	3	ID	Kec. Donri-Donri	190900
190906	3	ID	Kec. Mario Riawa	190900
190907	3	ID	Kec. Ganra	190900
190908	3	ID	Kec. Citta	190900
191000	2	ID	Kab. Bantaeng	190000
191001	3	ID	Kec. Bissappu	191000
191002	3	ID	Kec. Bantaeng	191000
191003	3	ID	Kec. Tompobulu	191000
191004	3	ID	Kec. Ulu Ere	191000
191005	3	ID	Kec. Ere Merasa	191000
191006	3	ID	Kec. Pa`jukukang	191000
191007	3	ID	Kec. Gantarang Keke	191000
191008	3	ID	Kec. Sinoa	191000
191100	2	ID	Kab. Bulukumba	190000
191101	3	ID	Kec. Gantarang	191100
191102	3	ID	Kec. Ujung Bulu	191100
191103	3	ID	Kec. Bontobahari	191100
191104	3	ID	Kec. Bontotiro	191100
191105	3	ID	Kec. Hero Lange-Lange	191100
191106	3	ID	Kec. Kajang	191100
191107	3	ID	Kec. Bulukumba	191100
191108	3	ID	Kec. Rilau Ale	191100
191109	3	ID	Kec. Kindang	191100
191110	3	ID	Kec. Ujung Loe	191100
191200	2	ID	Kab. Sinjai	190000
191201	3	ID	Kec. Sinjai Barat	191200
191202	3	ID	Kec. Sinjai Borong	191200
191203	3	ID	Kec. Sinjai Selatan	191200
191204	3	ID	Kec. Tellu Limpoe	191200
191205	3	ID	Kec. Sinjai Timur	191200
191206	3	ID	Kec. Sinjai Tengah	191200
191207	3	ID	Kec. Sinjai Utara	191200
191208	3	ID	Kec. Bulupoddo	191200
191209	3	ID	Kec. Pulau Sembilan	191200
191300	2	ID	Kab. Selayar	190000
191301	3	ID	Kec. Pasimarannu	191300
191302	3	ID	Kec. Pasimassunggu	191300
191303	3	ID	Kec. Bontosikuyu	191300
191304	3	ID	Kec. Bontoharu	191300
191305	3	ID	Kec. Bontomatene	191300
191306	3	ID	Kec. Bontomanai	191300
191307	3	ID	Kec. Benteng	191300
191308	3	ID	Kec. Taka Bonerate	191300
191309	3	ID	Kec. Pasilambena	191300
191310	3	ID	Kec. Pasimasunggu Timur	191300
191311	3	ID	Kec. Buki	191300
191390	3	ID	Pasimasunggu	      
191400	2	ID	Kab. Pinrang	190000
191401	3	ID	Kec. Suppa	191400
191402	3	ID	Kec. Mattiro Sompe	191400
191403	3	ID	Kec. Mattiro Bulu	191400
191404	3	ID	Kec. Watang Sawitto	191400
191405	3	ID	Kec. Patampanua	191400
191406	3	ID	Kec. Cempa	191400
191407	3	ID	Kec. Duampanua	191400
191408	3	ID	Kec. Lembang	191400
191409	3	ID	Kec. Lanrisang	191400
191410	3	ID	Kec. Tiroang	191400
191411	3	ID	Kec. Paleteang	191400
191412	3	ID	Kec. Batulappa	191400
191500	2	ID	Kab. Sidenreng Rappang	190000
191501	3	ID	Kec. Panca Lautang	191500
191502	3	ID	Kec. Tellulimpoe	191500
191503	3	ID	Kec. Watangpulu	191500
191504	3	ID	Kec. Baranti	191500
191505	3	ID	Kec. Panca Rijang	191500
191506	3	ID	Kec. Maritengae	191500
191507	3	ID	Kec. Pitu Riawa	191500
191508	3	ID	Kec. Duapitue	191500
191509	3	ID	Kec. Kulo	191500
191510	3	ID	Kec. Pitu Riase	191500
191511	3	ID	Kec. Watang Sidenreng	191500
191600	2	ID	Kab. Enrekang	190000
191601	3	ID	Kec. Maiwa	191600
191602	3	ID	Kec. Enrekang	191600
191603	3	ID	Kec. Barakka	191600
191604	3	ID	Kec. Anggeraja	191600
191605	3	ID	Kec. Alla	191600
191606	3	ID	Kec. Bungin	191600
191607	3	ID	Kec. Cendana	191600
191608	3	ID	Kec. Curio	191600
191609	3	ID	Kec. Malua	191600
191610	3	ID	Kec. Buntu Batu	191600
191611	3	ID	Kec. Masale	191600
191612	3	ID	Kec. Baroko	191600
191700	2	ID	Kab. Luwu	190000
191701	3	ID	Kec. Larompong	191700
191702	3	ID	Kec. Suli	191700
191703	3	ID	Kec. Belopa	191700
191704	3	ID	Kec. Bajo	191700
191705	3	ID	Kec. Bassesangtempe	191700
191706	3	ID	Kec. Buaponrang	191700
191707	3	ID	Kec. Bua	191700
191708	3	ID	Kec. Walenrang	191700
191709	3	ID	Kec. Lamasi	191700
191710	3	ID	Kec. Latimojong	191700
191711	3	ID	Kec. Larompong Selatan	191700
191712	3	ID	Kec. Kamanre	191700
191713	3	ID	Kec. Walenrang Barat	191700
191714	3	ID	Kec. Walenrang Utara	191700
191715	3	ID	Kec. Walenrang Timur	191700
191716	3	ID	Kec. Lamasi Timur	191700
191717	3	ID	Kec. Suli Barat	191700
191718	3	ID	Kec. Bajo Barat	191700
191719	3	ID	Kec. Ponrang Selatan	191700
191720	3	ID	Kec. Ponrang	191700
191721	3	ID	Kec. Bolopa Utara	191700
191800	2	ID	Kab. Tana Toraja	190000
191801	3	ID	Kec. Bonggakaradeng	191800
191802	3	ID	Kec. Mengkendek	191800
191803	3	ID	Kec. Sangalla	191800
191804	3	ID	Kec. Makale	191800
191805	3	ID	Kec. Saluputti	191800
191810	3	ID	Kec. Simbuang	191800
191811	3	ID	Kec. Rantetayo	191800
191812	3	ID	Kec. Bittuang	191800
191813	3	ID	Kec. Ranomeeto	191800
191814	3	ID	Kec. Mappak	191800
191815	3	ID	Kec. Gadang Batu Silanan	191800
191816	3	ID	Kec. Sangala Selatan	191800
191817	3	ID	Kec. Sangala Utara	191800
191818	3	ID	Kec. Makale Selatan	191800
191819	3	ID	Kec. Makale Utara	191800
191820	3	ID	Kec. Rembon	191800
191821	3	ID	Kec. Masanda	191800
191822	3	ID	Kec. Malimbong Balepe	191800
191823	3	ID	Kec. Kurra	191800
192400	2	ID	Kab. Luwu Utara	190000
192401	3	ID	Kec. Sabbang	192400
192402	3	ID	Kec. Baebunta	192400
192403	3	ID	Kec. Malangke	192400
192404	3	ID	Kec. Sukamaju	192400
192405	3	ID	Kec. Bone-Bone	192400
192412	3	ID	Kec. Massamba	192400
192413	3	ID	Kec. Limbong	192400
192415	3	ID	Kec. Mappedeceng	192400
192416	3	ID	Kec. Sekko	192400
192417	3	ID	Kec. Rampi	192400
192418	3	ID	Kec. Malangke Barat	192400
192490	3	ID	Tana Lili	      
192600	2	ID	Kab. Luwu Timur	190000
192601	3	ID	Kec. Burau	192600
192602	3	ID	Kec. Tomoni	192600
192603	3	ID	Kec. Wotu	192600
192604	3	ID	Kec. Malili	192600
192605	3	ID	Kec. Nuha	192600
192606	3	ID	Kec. Mangkutana	192600
192607	3	ID	Kec. Towuti	192600
192608	3	ID	Kec. Angkona	192600
192609	3	ID	Kec. Tomoni Timur	192600
192610	3	ID	Kec. Kalaena	192600
192611	3	ID	Kec. Wasuponda	192600
192700	2	ID	Kab. Toraja Utara	190000
192701	3	ID	Kec. Awan Rante karua	192700
192702	3	ID	Kec. Balusu	192700
192703	3	ID	Kec. Bengkelekila	192700
192704	3	ID	Kec. Baruppu	192700
192705	3	ID	Kec. Buntao	192700
192706	3	ID	Kec. Kapala Pitu	192700
192707	3	ID	Kec. Kesu	192700
192708	3	ID	Kec. Nanggala	192700
192709	3	ID	Kec. Rantebua	192700
192710	3	ID	Kec. Rantepao	192700
192711	3	ID	Kec. Rindingallo	192700
192712	3	ID	Kec. Sa`dan	192700
192713	3	ID	Kec. Sanggalangi	192700
192714	3	ID	Kec. Sesean	192700
192715	3	ID	Kec. Sesean Suloara	192700
192716	3	ID	Kec. Sopai	192700
192717	3	ID	Kec. Tallunglipu	192700
192718	3	ID	Kec. Tikala	192700
192719	3	ID	Kec. Tondon	192700
192720	3	ID	Kec. Dende` Piongan Napo	192700
192721	3	ID	Kec. Buntu Pepasan	192700
196000	2	ID	Kota Makassar	190000
196001	3	ID	Kec. Mariso	196000
196002	3	ID	Kec. Mamajang	196000
196003	3	ID	Kec. Tamalate	196000
196004	3	ID	Kec. Makasar	196000
196005	3	ID	Kec. Ujung Pandang	196000
196006	3	ID	Kec. Wajo	196000
196007	3	ID	Kec. Bontoala	196000
196008	3	ID	Kec. Ujung Tanah	196000
196009	3	ID	Kec. Tallo	196000
196010	3	ID	Kec. Panakukkang	196000
196011	3	ID	Kec. Biringkanaya	196000
196012	3	ID	Kec. Tamalanrea	196000
196013	3	ID	Kec. Rappocini	196000
196014	3	ID	Kec. Manggala	196000
196100	2	ID	Kota Pare-Pare	190000
196101	3	ID	Kec. Bacukiki	196100
196102	3	ID	Kec. Ujung	196100
196103	3	ID	Kec. Soreang	196100
196104	3	ID	Kec. Bacukiki Barat	196100
196200	2	ID	Kota Palopo	190000
196201	3	ID	Kec. Wara	196200
196202	3	ID	Kec. Wara Utara	196200
196203	3	ID	Kec. Wara Selatan	196200
196204	3	ID	Kec. Telluwanua	196200
196205	3	ID	Kec. Wara Timur	196200
196206	3	ID	Kec. Wara Barat	196200
196207	3	ID	Kec. Sendana	196200
196208	3	ID	Kec. Mungkajang	196200
196209	3	ID	Kec. Bara	196200
200000	1	ID	Prov. Sulawesi Tenggara	000000
200100	2	ID	Kab. Konawe	200000
200108	3	ID	Kec. Soropia	200100
200109	3	ID	Kec. Sampara	200100
200112	3	ID	Kec. Lambuya	200100
200114	3	ID	Kec. Pondidaha	200100
200115	3	ID	Kec. Wawotobi	200100
200116	3	ID	Kec. Unaaha	200100
200118	3	ID	Kec. Abuki	200100
200124	3	ID	Kec. BondoAla	200100
200125	3	ID	Kec. Uepai	200100
200126	3	ID	Kec. Wonggeduku	200100
200128	3	ID	Kec. Tongauna	200100
200130	3	ID	Kec. Latoma	200100
200131	3	ID	Kec. Besulutu	200100
200132	3	ID	Kec. Puriala	200100
200133	3	ID	Kec. Meluhu	200100
200134	3	ID	Kec. Amonggedo	200100
200135	3	ID	Kec. Wawonii Barat	200100
200136	3	ID	Kec. Wawonii Timur	200100
200137	3	ID	Kec. Wawonii Selatan	200100
200138	3	ID	Kec. Wawonii Utara	200100
200139	3	ID	Kec. Routa	200100
200140	3	ID	Kec. Anggaberi	200100
200141	3	ID	Kec. Wawoni Tengah	200100
200142	3	ID	Kec. Kapoiala	200100
200143	3	ID	Kec. Konawe	200100
200144	3	ID	Asinua	200100
200145	3	ID	Wawonii Tenggara	200100
200146	3	ID	Wawonii Timur Laut	200100
200147	3	ID	Lalonggasumeeto	200100
200148	3	ID	Onembute	200100
200200	2	ID	Kab. Muna	200000
200201	3	ID	Kec. Tongkuno	200200
200202	3	ID	Kec. Parigi	200200
200203	3	ID	Kec. Kabawo	200200
200205	3	ID	Kec. Lawa	200200
200206	3	ID	Kec. Kusambi	200200
200207	3	ID	Kec. Katobu	200200
200208	3	ID	Kec. Napabalano	200200
200209	3	ID	Kec. Wakorumba Selatan	200200
200215	3	ID	Kec. Lohia	200200
200216	3	ID	Kec. Kontunaga	200200
200217	3	ID	Kec. Sawerigadi	200200
200218	3	ID	Kec. Maginti	200200
200219	3	ID	Kec. Kabangka	200200
200220	3	ID	Kec. Maligano	200200
200224	3	ID	Kec. Tiworo Tengah	200200
200225	3	ID	Kec. Barangka	200200
200226	3	ID	Kec. Watopute	200200
200227	3	ID	Kec. Batalaiworu	200200
200228	3	ID	Kec. Duruka	200200
200229	3	ID	Kec. Lasalepa	200200
200230	3	ID	Kec. Pasir Putih	200200
200232	3	ID	Kec. Tiworo Kepulauan	200200
200233	3	ID	Kec. Bone	200200
200234	3	ID	Kontu Kowuna	200200
200235	3	ID	Marobo	200200
200236	3	ID	Tongkuno Selatan	200200
200237	3	ID	Pasi Kolaga	200200
200238	3	ID	Batukara	200200
200239	3	ID	Wa Daga	200200
200240	3	ID	Napano Kusambi	200200
200241	3	ID	Towea	200200
200242	3	ID	Tiworo Selatan	200200
200243	3	ID	Tiworo Utara	200200
200300	2	ID	Kab. Buton	200000
200305	3	ID	Kec. Lasalimu	200300
200306	3	ID	Kec. Pasar Wajo	200300
200307	3	ID	Kec. Sampolawa	200300
200308	3	ID	Kec. Batauga	200300
200311	3	ID	Kec. Kapontori	200300
200312	3	ID	Kec. Gu	200300
200313	3	ID	Kec. Lakudo	200300
200314	3	ID	Kec. Mawasangka	200300
200321	3	ID	Kec. Lasalimu Selatan	200300
200322	3	ID	Kec. Batu Atas	200300
200323	3	ID	Kec. Siompu	200300
200324	3	ID	Kec. Kadatua	200300
200325	3	ID	Kec. Mawasangka Timur	200300
200326	3	ID	Kec. Talaga Raya	200300
200328	3	ID	Kec. Mawasangka Tengah	200300
200329	3	ID	Kec. Sangia Wambulu	200300
200330	3	ID	Kec. Siontapia	200300
200331	3	ID	Kec. Wolowa	200300
200332	3	ID	Kec. Wabula	200300
200333	3	ID	Kec. Lapandewa	200300
200334	3	ID	Kec. Siompu Barat	200300
200400	2	ID	Kab. Kolaka	200000
200401	3	ID	Kec. Watubangga	200400
200402	3	ID	Kec. Pomalaa	200400
200403	3	ID	Kec. Wundulako	200400
200404	3	ID	Kec. Ladongi	200400
200405	3	ID	Kec. Tirawuta	200400
200406	3	ID	Kec. Kolaka	200400
200407	3	ID	Kec. Wolo	200400
200408	3	ID	Kec. Mowewe	200400
200412	3	ID	Kec. Tanggetada	200400
200413	3	ID	Kec. Baula	200400
200414	3	ID	Kec. Lambandia	200400
200415	3	ID	Kec. Latambaga	200400
200416	3	ID	Kec. Samaturu	200400
200417	3	ID	Kec. Uluiwoi	200400
200418	3	ID	Kec. Tinondo	200400
200419	3	ID	Kec. Poli-Polia	200400
200420	3	ID	Kec. Lalolae	200400
200421	3	ID	Kec. Toari	200400
200422	3	ID	Kec. Polinggona	200400
200423	3	ID	Kec. Loela	200400
200424	3	ID	Tirawuta	      
200425	3	ID	Ladongi	      
200426	3	ID	Poli-polia	      
200427	3	ID	Lambandia	      
200428	3	ID	Uluiwoi	      
200429	3	ID	Mowewe	      
200500	2	ID	Kab. Konawe Selatan	200000
200501	3	ID	Kec. Tinanggea	200500
200502	3	ID	Kec. Palangga	200500
200503	3	ID	Kec. Konda	200500
200504	3	ID	Kec. Lainea	200500
200505	3	ID	Kec. Moramo	200500
200506	3	ID	Kec. Ranomeeto	200500
200507	3	ID	Kec. Landono	200500
200508	3	ID	Kec. Kolono	200500
200509	3	ID	Kec. Andolo	200500
200510	3	ID	Kec. Laonti	200500
200511	3	ID	Kec. Angata	200500
200512	3	ID	Kec. Lalembuu	200500
200513	3	ID	Kec. Buke	200500
200514	3	ID	Kec. Palangga Selatan	200500
200515	3	ID	Kec. Baito	200500
200516	3	ID	Kec. Laeya	200500
200517	3	ID	Kec. Moramo Utara	200500
200518	3	ID	Kec. Wolasi	200500
200519	3	ID	Kec. Ranomeeto Barat	200500
200520	3	ID	Kec. Mowila	200500
200521	3	ID	Kec. Benua	200500
200522	3	ID	Kec. Basala	200500
200600	2	ID	Kab. Wakatobi	200000
200601	3	ID	Kec. Binongko	200600
200602	3	ID	Kec. Tomia	200600
200603	3	ID	Kec. Kaledupa	200600
200604	3	ID	Kec. Wangi-Wangi	200600
200605	3	ID	Kec. Wangi-Wangi Selatan	200600
200606	3	ID	Kec. Kaledupa Selatan	200600
200607	3	ID	Kec. Tomia Timur	200600
200608	3	ID	Kec. Togo Binongko	200600
200700	2	ID	Kab. Bombana	200000
200701	3	ID	Kec. Kabaena	200700
200702	3	ID	Kec. Kabaena Timur	200700
200703	3	ID	Kec. Poleang	200700
200704	3	ID	Kec. Poleang Timur	200700
200705	3	ID	Kec. Rumbia	200700
200706	3	ID	Kec. Rarowatu	200700
200707	3	ID	Kec. Poleang Barat	200700
200708	3	ID	Kec. Mataelo	200700
200709	3	ID	Kec. Rarowatu Utara	200700
200710	3	ID	Kec. Poleang Utara	200700
200711	3	ID	Kec. Poleang Selatan	200700
200712	3	ID	Kec. Poleang Tenggara	200700
200713	3	ID	Kec. Kabaena Selatan	200700
200714	3	ID	Kec. Kabaena Barat	200700
200715	3	ID	Kec. Kabaena Utara	200700
200716	3	ID	Kec. Kabaena Tengah	200700
200717	3	ID	Kec. Kep. Masaloka Raya	200700
200718	3	ID	Kec. Rumbia Tengah	200700
200719	3	ID	Kec. Poleang Tengah	200700
200720	3	ID	Kec. Tatonuwu	200700
200721	3	ID	Kec. Lantari Jaya	200700
200722	3	ID	Kec. Mata Usu	200700
200800	2	ID	Kab. Kolaka Utara	200000
200801	3	ID	Kec. Lasusua	200800
200802	3	ID	Kec. Pakue	200800
200803	3	ID	Kec. Batu Putih	200800
200804	3	ID	Kec. Ranteangin	200800
200805	3	ID	Kec. Kodeoha	200800
200806	3	ID	Kec. Ngapa	200800
200807	3	ID	Kec. Wawo	200800
200808	3	ID	Kec. Lambai	200800
200809	3	ID	Kec. Watunohu	200800
200810	3	ID	Kec. Pakue Tengah	200800
200811	3	ID	Kec. Pakue Utara	200800
200812	3	ID	Kec. Porehu	200800
200813	3	ID	Kec. Katoi	200800
200814	3	ID	Kec. Tiwu	200800
200815	3	ID	Kec. Katoi	200800
200890	3	ID	Tolala	      
200900	2	ID	Kab. Konawe Utara	200000
200901	3	ID	Kec. Langkima	200900
200902	3	ID	Kec. Molawe	200900
200903	3	ID	Kec. Lembo	200900
200904	3	ID	Kec. Asera	200900
200905	3	ID	Kec. Wiwirano	200900
200906	3	ID	Kec. Lasolo	200900
200907	3	ID	Kec. Sawa	200900
200908	3	ID	Kec. Oheo	200900
200909	3	ID	Kec. Andowia	200900
200910	3	ID	Kec. Motui	200900
201000	2	ID	Kab. Buton Utara	200000
201001	3	ID	Kec. Kulisusu	201000
201002	3	ID	Kec. Kulisusu Barat	201000
201003	3	ID	Kec. Kulisusu Utara	201000
201004	3	ID	Kec. Kambowa	201000
201005	3	ID	Kec. Bonenugu	201000
201006	3	ID	Kec. Wakorumba Utara	201000
201099	3	ID	Wakorumba Utara	      
201111	3	ID	Loea	      
201115	3	ID	Lalolae	      
206000	2	ID	Kota Kendari	200000
206001	3	ID	Kec. Mandonga	206000
206002	3	ID	Kec. Poasia	206000
206003	3	ID	Kec. Kendari	206000
206004	3	ID	Kec. Baruga	206000
206005	3	ID	Kec. Kendari Barat	206000
206006	3	ID	Kec. Abeli	206000
206007	3	ID	Kec. Puwato	206000
206008	3	ID	Kec. Kadia	206000
206009	3	ID	Kec. Wua-Wua	206000
206010	3	ID	Kec. Kambu	206000
206100	2	ID	Kota Baubau	200000
206101	3	ID	Kec. Betoambari	206100
206102	3	ID	Kec. Wolio	206100
206103	3	ID	Kec. Sorowalio	206100
206104	3	ID	Kec. Bungi	206100
206105	3	ID	Kec. Murhum	206100
206106	3	ID	Kec. Kokalukuna	206100
206107	3	ID	Kec. Lea-Lea	206100
210000	1	ID	Prov. Maluku	000000
210100	2	ID	Kab. Maluku Tengah	210000
210101	3	ID	Kec. Banda	210100
210104	3	ID	Kec. Tehoru	210100
210105	3	ID	Kec. Amahai	210100
210106	3	ID	Kec. Teon Nila Serua	210100
210108	3	ID	Kec. Saparua	210100
210109	3	ID	Kec. Pulau Haruku	210100
210110	3	ID	Kec. Salahutu	210100
210111	3	ID	Kec. Leihitu	210100
210114	3	ID	Kec. Seram Utara	210100
210116	3	ID	Kec. Masohi	210100
210117	3	ID	Kec. Nusa Laut	210100
210118	3	ID	Kec. Teluk Elpaputih	210100
210119	3	ID	Kec. Seram Utara Barat	210100
210120	3	ID	Kec. Leihitu Barat	210100
210121	3	ID	Telutih	      
210122	3	ID	Seram Utara Timur Seti	      
210123	3	ID	Seram Utara Timur Kobi	      
210200	2	ID	Kab. Maluku Tenggara	210000
210201	3	ID	Kec. Kei Kecil	210200
210202	3	ID	Kec. Kei Besar	210200
210205	3	ID	Kec. Kei Besar Selatan	210200
210206	3	ID	Kec. Kei Besar Utara Timur	210200
210212	3	ID	Kec. Kei Kecil Barat	210200
210213	3	ID	Kec. Kei Kecil Timur	210200
210300	2	ID	Kab. Buru	210000
210304	3	ID	Kec. Air Buaya	210300
210307	3	ID	Kec. Waeapo	210300
210310	3	ID	Kec. Namlea	210300
210316	3	ID	Kec. Waplau	210300
210317	3	ID	Kec. Bata Baul	210300
210400	2	ID	Kab. Maluku Tenggara Barat	210000
210401	3	ID	Kec. Pulau-pulau Terselatan	210400
210403	3	ID	Kec. Pulau-Pulau Babar	210400
210404	3	ID	Kec. Tanimbar Selatan	210400
210405	3	ID	Kec. Tanimbar Utara	210400
210406	3	ID	Kec. Damer	210400
210411	3	ID	Kec. Wer Tamrian	210400
210412	3	ID	Kec. Wer Maktian	210400
210413	3	ID	Kec. Selaru	210400
210414	3	ID	Kec. Yaru	210400
210415	3	ID	Kec. Wuar Labobar	210400
210416	3	ID	Kec. Nirun Mas	210400
210417	3	ID	Kec. Kormomolin	210400
210418	3	ID	Kec. Molu Maru	210400
210500	2	ID	Kab. Seram Bagian Barat	210000
210501	3	ID	Kec. Kairatu	210500
210502	3	ID	Kec. Seram Barat	210500
210503	3	ID	Kec. Taniwel	210500
210504	3	ID	Kec. Waisala	210500
210505	3	ID	Huamual	      
210590	3	ID	Inamosol	      
210591	3	ID	Elpaputih	      
210592	3	ID	Taniwel Timur	      
210593	3	ID	Huamual Belakang	      
210594	3	ID	Kepulauan Manipa	      
210599	3	ID	Kairatu Barat	      
210600	2	ID	Kab. Seram Bagian Timur	210000
210601	3	ID	Kec. Seram Timur	210600
210602	3	ID	Kec. Werinama	210600
210603	3	ID	Kec. Bula	210600
210604	3	ID	Kec. Pulau-pulau Gorom	210600
210605	3	ID	Kec. Wakate	210600
210606	3	ID	Kec. Tutuk Tolu	210600
210700	2	ID	Kab. Kepulauan Aru	210000
210701	3	ID	Kec. Pulau-Pulau Aru	210700
210702	3	ID	Kec. Aru Tengah	210700
210703	3	ID	Kec. Aru Selatan	210700
210704	3	ID	Kec. Aru Selatan Timur	210700
210705	3	ID	Kec. Aru Tengah Timur	210700
210706	3	ID	Kec. Aru Tengah Selatan	210700
210707	3	ID	Kec. Aru Utara	210700
210708	3	ID	Kec. Batuley	210700
210709	3	ID	Kec. Sir-Sir	210700
210710	3	ID	Kec. Aru Selatan Utara	210700
210800	2	ID	Kab. Maluku Barat Daya	210000
210801	3	ID	Kec. Babar Timur	210800
210803	3	ID	Kec. Mdona Hiera	210800
210804	3	ID	Kec. Moa Lakor	210800
210805	3	ID	Kec. Pulau Letti	210800
210808	3	ID	Kec. Wetar	210800
210809	3	ID	Damer	      
210810	3	ID	Pulau-pulau Babar	      
210811	3	ID	Pulau-pulau Terselatan	      
210900	2	ID	Kab. Buru Selatan	210000
210901	3	ID	Kec. Ambalau	210900
210902	3	ID	Kec. Kepala Madan	210900
210903	3	ID	Kec. Leksula	210900
210904	3	ID	Kec. Namrole	210900
210905	3	ID	Kec. Waesama	210900
216000	2	ID	Kota Ambon	210000
216001	3	ID	Kec. Nusaniwe	216000
216002	3	ID	Kec. Sirimau	216000
216003	3	ID	Kec. Teluk Ambon	216000
216005	3	ID	Kec. Baguala	216000
216006	3	ID	Kec. Lei Timur Selatan	216000
216100	2	ID	Kota. Tual	210000
216101	3	ID	Kec. PP Kur Mangur	216100
216102	3	ID	Kec. Pulau Dullah Selatan	216100
216103	3	ID	Kec. Pulau Dullah Utara	216100
216104	3	ID	Kec. Tayando Tam	216100
220000	1	ID	Prov. Bali	000000
220100	2	ID	Kab. Buleleng	220000
220101	3	ID	Kec. Gerokgak	220100
220102	3	ID	Kec. Seririt	220100
220103	3	ID	Kec. Busungbiu	220100
220104	3	ID	Kec. Banjar	220100
220105	3	ID	Kec. Sukasada	220100
220106	3	ID	Kec. Buleleng	220100
220107	3	ID	Kec. Sawan	220100
220108	3	ID	Kec. Kubutambahan	220100
220109	3	ID	Kec. Tejakula	220100
220200	2	ID	Kab. Jembrana	220000
220201	3	ID	Kec. Melaya	220200
220202	3	ID	Kec. Negara	220200
220203	3	ID	Kec. Mendoyo	220200
220204	3	ID	Kec. Pekutatan	220200
220205	3	ID	Kec. Jembrana	220200
220300	2	ID	Kab. Tabanan	220000
220301	3	ID	Kec. Selemadeg	220300
220302	3	ID	Kec. Kerambitan	220300
220303	3	ID	Kec. Tabanan	220300
220304	3	ID	Kec. Kediri	220300
220305	3	ID	Kec. Marga	220300
220306	3	ID	Kec. Baturiti	220300
220307	3	ID	Kec. Penebel	220300
220308	3	ID	Kec. Pupuan	220300
220309	3	ID	Kec. Selemadeg Barat	220300
220310	3	ID	Kec. Selemadeg Timur	220300
220400	2	ID	Kab. Badung	220000
220401	3	ID	Kec. Kuta Selatan	220400
220402	3	ID	Kec. Kuta	220400
220403	3	ID	Kec. Kuta Utara	220400
220404	3	ID	Kec. Mengwi	220400
220405	3	ID	Kec. Abiansemal	220400
220406	3	ID	Kec. Petang	220400
220500	2	ID	Kab. Gianyar	220000
220501	3	ID	Kec. Sukawati	220500
220502	3	ID	Kec. Blahbatuh	220500
220503	3	ID	Kec. Gianyar	220500
220504	3	ID	Kec. Tampak siring	220500
220505	3	ID	Kec. Ubud	220500
220506	3	ID	Kec. Tegallalang	220500
220507	3	ID	Kec. Payangan	220500
220600	2	ID	Kab. Klungkung	220000
220601	3	ID	Kec. Nusapenida	220600
220602	3	ID	Kec. Banjarangkan	220600
220603	3	ID	Kec. Klungkung	220600
220604	3	ID	Kec. Dawan	220600
220700	2	ID	Kab. Bangli	220000
220701	3	ID	Kec. Susut	220700
220702	3	ID	Kec. Bangli	220700
220703	3	ID	Kec. Tembuku	220700
220704	3	ID	Kec. Kintamani	220700
220800	2	ID	Kab. Karang Asem	220000
220801	3	ID	Kec. Rendang	220800
220802	3	ID	Kec. Sidemen	220800
220803	3	ID	Kec. Manggis	220800
220804	3	ID	Kec. Karang asem	220800
220805	3	ID	Kec. Abang	220800
220806	3	ID	Kec. Bebandem	220800
220807	3	ID	Kec. Selat	220800
220808	3	ID	Kec. Kubu	220800
226000	2	ID	Kota Denpasar	220000
226001	3	ID	Kec. Denpasar Selatan	226000
226002	3	ID	Kec. Denpasar Timur	226000
226003	3	ID	Kec. Denpasar Barat	226000
226004	3	ID	Kec. Denpasar Utara	226000
230000	1	ID	Prov. Nusa Tenggara Barat	000000
230100	2	ID	Kab. Lombok Barat	230000
230101	3	ID	Kec. Sekotong Tengah	230100
230102	3	ID	Kec. Gerung	230100
230103	3	ID	Kec. Labuapi	230100
230104	3	ID	Kec. Kediri	230100
230105	3	ID	Kec. Narmada	230100
230106	3	ID	Kec. Gunung Sari	230100
230110	3	ID	Kec. Kuripan	230100
230112	3	ID	Kec. Lembar	230100
230114	3	ID	Kec. Batu Layar	230100
230115	3	ID	Kec. Lingsar	230100
230200	2	ID	Kab. Lombok Tengah	230000
230201	3	ID	Kec. Praya Barat	230200
230202	3	ID	Kec. Pujut	230200
230203	3	ID	Kec. Praya Timur	230200
230204	3	ID	Kec. Janapria	230200
230205	3	ID	Kec. Kopang	230200
230206	3	ID	Kec. Praya	230200
230207	3	ID	Kec. Jonggat	230200
230208	3	ID	Kec. Pringgarata	230200
230209	3	ID	Kec. Batukliang	230200
230210	3	ID	Kec. Batukliang Utara	230200
230211	3	ID	Kec. Praya Barat Daya	230200
230212	3	ID	Kec. Praya Tengah	230200
230300	2	ID	Kab. Lombok Timur	230000
230301	3	ID	Kec. Keruak	230300
230302	3	ID	Kec. Sakra	230300
230303	3	ID	Kec. Terara	230300
230304	3	ID	Kec. Sikur	230300
230305	3	ID	Kec. Masbagik	230300
230306	3	ID	Kec. Sukamulia	230300
230307	3	ID	Kec. Selong	230300
230308	3	ID	Kec. Pringgabaya	230300
230309	3	ID	Kec. Aikmel	230300
230310	3	ID	Kec. Sambelia	230300
230311	3	ID	Kec. Labuhan Haji	230300
230312	3	ID	Kec. Suralaga	230300
230313	3	ID	Kec. Sakra Timur	230300
230314	3	ID	Kec. Sakra Barat	230300
230315	3	ID	Kec. Jerowaru	230300
230316	3	ID	Kec. Pringgasela	230300
230317	3	ID	Kec. Montong Gading	230300
230318	3	ID	Kec. Wanasaba	230300
230319	3	ID	Kec. Sembalun	230300
230320	3	ID	Kec. Suela	230300
230400	2	ID	Kab. Sumbawa	230000
230402	3	ID	Kec. Lunyuk	230400
230405	3	ID	Kec. Alas	230400
230407	3	ID	Kec. Batu Lanten	230400
230408	3	ID	Kec. Sumbawa	230400
230409	3	ID	Kec. Moyo Hilir	230400
230410	3	ID	Kec. Moyo Hulu	230400
230411	3	ID	Kec. Ropang	230400
230413	3	ID	Kec. Plampang	230400
230414	3	ID	Kec. Empang	230400
230415	3	ID	Kec. Labuhan Badas	230400
230416	3	ID	Kec. Alas Barat	230400
230419	3	ID	Kec. Labangka	230400
230420	3	ID	Kec. Unter Iwes	230400
230421	3	ID	Kec. Rhee	230400
230422	3	ID	Kec. Buer	230400
230423	3	ID	Kec. Moyo Utara	230400
230424	3	ID	Kec. Maronge	230400
230425	3	ID	Kec. Tarano	230400
230426	3	ID	Kec. Lopok	230400
230427	3	ID	Kec. Lenangguar	230400
230428	3	ID	Kec. Orong Telu	230400
230429	3	ID	Kec. Utan	230400
230430	3	ID	Kec. Lape	230400
230431	3	ID	Kec. Lantung	230400
230500	2	ID	Kab. Dompu	230000
230501	3	ID	Kec. Hu`u	230500
230502	3	ID	Kec. Dompu	230500
230503	3	ID	Kec. Woja	230500
230504	3	ID	Kec. Kilo	230500
230505	3	ID	Kec. Kempo	230500
230506	3	ID	Kec. Pekat	230500
230507	3	ID	Kec. Pajo	230500
230508	3	ID	Kec. Manggelewa	230500
230600	2	ID	Kab. Bima	230000
230601	3	ID	Kec. Monta	230600
230602	3	ID	Kec. Bolo	230600
230603	3	ID	Kec. Woha	230600
230604	3	ID	Kec. Belo	230600
230605	3	ID	Kec. Wawo	230600
230606	3	ID	Kec. Sape	230600
230607	3	ID	Kec. Wera	230600
230608	3	ID	Kec. Donggo	230600
230609	3	ID	Kec. Sanggar	230600
230610	3	ID	Kec. Lambu	230600
230611	3	ID	Kec. Tambora	230600
230612	3	ID	Kec. Ambalawi	230600
230613	3	ID	Kec. Mada pangga	230600
230614	3	ID	Kec. Langgudu	230600
230615	3	ID	Kec. Soromandi	230600
230616	3	ID	Kec. Parado	230600
230617	3	ID	Kec. Lambitu	230600
230618	3	ID	Kec. Palibelo	230600
230700	2	ID	Kab. Sumbawa Barat	230000
230701	3	ID	Kec. Jereweh	230700
230702	3	ID	Kec. Taliwang	230700
230703	3	ID	Kec. Seteluk	230700
230704	3	ID	Kec. Brang Rea	230700
230705	3	ID	Kec. Sekongkang	230700
230706	3	ID	Kec. Maluk	230700
230707	3	ID	Kec. Brang Ene	230700
230708	3	ID	Kec. Poto Tano	230700
230800	2	ID	Kab. Lombok Utara	230000
230801	3	ID	Kec. Tanjung	230800
230802	3	ID	Kec. Gangga	230800
230803	3	ID	Kec. Bayan	230800
230804	3	ID	Kec. Pemenang	230800
230805	3	ID	Kec. Kayangan	230800
236000	2	ID	Kota Mataram	230000
236001	3	ID	Kec. Ampenan	236000
236002	3	ID	Kec. Mataram	236000
236003	3	ID	Kec. Cakranegara	236000
236004	3	ID	Kec. Sekarbela	236000
236005	3	ID	Kec. Selaperang	236000
236006	3	ID	Kec. Sandubaya	236000
236100	2	ID	Kota Bima	230000
236101	3	ID	Kec. RasanaE Barat	236100
236102	3	ID	Kec. RasanaE Timur	236100
236103	3	ID	Kec. Asakota	236100
236104	3	ID	Kec. Raba	236100
236105	3	ID	Kec. Mpunda	236100
240000	1	ID	Prov. Nusa Tenggara Timur	000000
240100	2	ID	Kab. Kupang	240000
240101	3	ID	Kec. Raijua	240100
240102	3	ID	Kec. Sabu Barat	240100
240103	3	ID	Kec. Sabu Timur	240100
240110	3	ID	Kec. Semau	240100
240111	3	ID	Kec. Kupang Barat	240100
240112	3	ID	Kec. Kupang Tengah	240100
240113	3	ID	Kec. Amarasi	240100
240114	3	ID	Kec. Kupang Timur	240100
240115	3	ID	Kec. Sulamu	240100
240116	3	ID	Kec. Fatuleu	240100
240117	3	ID	Kec. Takari	240100
240118	3	ID	Kec. Amfoang Selatan	240100
240119	3	ID	Kec. Amfoang Utara	240100
240120	3	ID	Kec. Sabu Tengah	240100
240121	3	ID	Kec. Nekamese	240100
240122	3	ID	Kec. Amabi Oefeto Timur	240100
240123	3	ID	Kec. Amarasi Selatan	240100
240124	3	ID	Kec. Amarasi Timur	240100
240125	3	ID	Kec. Amarasi Barat	240100
240126	3	ID	Kec. Amfoang Barat Daya	240100
240127	3	ID	Kec. Amfoang Barat Laut	240100
240128	3	ID	Kec. Sabu Liae	240100
240129	3	ID	Kec. Hawu Mehara	240100
240130	3	ID	Kec. Semau Selatan	240100
240131	3	ID	Kec. Taebenu	240100
240132	3	ID	Kec. Amabi Oefeto	240100
240133	3	ID	Kec. Fatuleu Tengah	240100
240134	3	ID	Kec. Fatuleu Barat	240100
240135	3	ID	Kec. Amfoang Timur	240100
240136	3	ID	Kec. Amfoang Tengah	240100
240300	2	ID	Kab. Timor Tengah Selatan	240000
240301	3	ID	Kec. Mollo Utara	240300
240302	3	ID	Kec. Mollo Selatan	240300
240303	3	ID	Kec. Kota Soe	240300
240304	3	ID	Kec. Amanuban Barat	240300
240305	3	ID	Kec. Amanuban Selatan	240300
240306	3	ID	Kec. Kuanfatu	240300
240307	3	ID	Kec. Amanuban Tengah	240300
240308	3	ID	Kec. Amanuban Timur	240300
240309	3	ID	Kec. Kie	240300
240310	3	ID	Kec. Amanatun Selatan	240300
240311	3	ID	Kec. Amanatun Utara	240300
240312	3	ID	Kec. Fatumnasi	240300
240313	3	ID	Kec. Polen	240300
240314	3	ID	Kec. BatuPutih	240300
240315	3	ID	Kec. Boking	240300
240316	3	ID	Kec. Noebana	240300
240317	3	ID	Kec. Nunkolo	240300
240318	3	ID	Kec. Kot`Olin	240300
240319	3	ID	Kec. Oenino	240300
240320	3	ID	Kec. Kolbano	240300
240321	3	ID	Kec. Kualin	240300
240322	3	ID	Kec. Toianas	240300
240323	3	ID	Kec. Mollo Barat	240300
240324	3	ID	Kec. Kok Baun	240300
240325	3	ID	Kec. Tobu	240300
240326	3	ID	Kec. Nunbena	240300
240327	3	ID	Kec. Mollo Tengah	240300
240328	3	ID	Kec. Kuatnana	240300
240329	3	ID	Kec. Noebeba	240300
240330	3	ID	Kec. Fautmolo	240300
240331	3	ID	Kec. Fatukopa	240300
240332	3	ID	Kec. Santian	240300
240400	2	ID	Kab. Timor Tengah Utara	240000
240401	3	ID	Kec. Miomafo Barat	240400
240402	3	ID	Kec. Miomafo Timur	240400
240403	3	ID	Kec. Kota Kefamenanu	240400
240404	3	ID	Kec. Insana	240400
240405	3	ID	Kec. Biboki Selatan	240400
240406	3	ID	Kec. Biboki Utara	240400
240407	3	ID	Kec. Noemuti	240400
240408	3	ID	Kec. Insana Utara	240400
240409	3	ID	Kec. Biboki Anleu	240400
240410	3	ID	Kec. Noemuti Timur	240400
240411	3	ID	Kec. Miomafo Tengah	240400
240412	3	ID	Kec. Musi	240400
240413	3	ID	Kec. Mutis	240400
240414	3	ID	Kec. Bikomi Selatan	240400
240415	3	ID	Kec. Bikomi Tengah	240400
240416	3	ID	Kec. Bikomi Nilulat	240400
240417	3	ID	Kec. Bikomi Utara	240400
240418	3	ID	Kec. Naibenu	240400
240419	3	ID	Kec. Insana Fafinesu	240400
240420	3	ID	Kec. Insana Barat	240400
240421	3	ID	Kec. Insana Tengah	240400
240422	3	ID	Kec. Biboki Tanpah	240400
240423	3	ID	Kec. Biboki Moenleu	240400
240424	3	ID	Kec. Biboki Feotleu	240400
240500	2	ID	Kab. Belu	240000
240501	3	ID	Kec. Malaka Barat	240500
240502	3	ID	Kec. Malaka Tengah	240500
240503	3	ID	Kec. Malaka Timur	240500
240504	3	ID	Kec. Kobalima	240500
240505	3	ID	Kec. Tasifeto Barat	240500
240506	3	ID	Kec. Kota Atambua	240500
240507	3	ID	Kec. Tasifeto Timur	240500
240508	3	ID	Kec. Lamakmen	240500
240509	3	ID	Kec. Kakuluk Mesak	240500
240510	3	ID	Kec. Raihat	240500
240511	3	ID	Kec. Rinhat	240500
240512	3	ID	Kec. Sasita Mean	240500
240513	3	ID	Kec. Weliman	240500
240514	3	ID	Kec. Wewiku	240500
240515	3	ID	Kec. Rai Manuk	240500
240516	3	ID	Kec. Laen Manen	240500
240517	3	ID	Kec. Lasiolat	240500
240518	3	ID	Kec. Lamakmen Selatan	240500
240519	3	ID	Kec. Lo Kufeu	240500
240520	3	ID	Kec. Botin Leo Bele	240500
240521	3	ID	Kec. Atambua Barat	240500
240522	3	ID	Kec. Atambua Selatan	240500
240523	3	ID	Kec. Nanaet Duabesi	240500
240524	3	ID	Kec. Kobalima Timur	240500
240525	3	ID	Malaka Barat	      
240526	3	ID	Malaka Timur	      
240527	3	ID	Kobalima	      
240528	3	ID	Sasitamean	      
240529	3	ID	Laen Manen	      
240530	3	ID	Io Kufeu	      
240531	3	ID	Botin Leo Bele	      
240532	3	ID	Kobalima Timur	      
240533	3	ID	Rinhat	      
240534	3	ID	Wewiku	      
240535	3	ID	Weliman	      
240600	2	ID	Kab. Alor	240000
240602	3	ID	Kec. Alor Barat Daya	240600
240603	3	ID	Kec. Alor Selatan	240600
240604	3	ID	Kec. Alor Timur	240600
240605	3	ID	Kec. Teluk Mutiara	240600
240606	3	ID	Kec. Alor Barat Laut	240600
240607	3	ID	Kec. Pantar	240600
240608	3	ID	Kec. Alor Timur Laut	240600
240609	3	ID	Kec. Alor Tengah Utara	240600
240610	3	ID	Kec. Pantar Barat	240600
240611	3	ID	Kec. Pantar Timur	240600
240612	3	ID	Kec. Pantar Barat Laut	240600
240613	3	ID	Kec. Pantar Tengah	240600
240614	3	ID	Kec. Mataru	240600
240615	3	ID	Kec. Pureman	240600
240616	3	ID	Kec. Kabola	240600
240617	3	ID	Kec. Pulau Pura	240600
240618	3	ID	Kec. Lembur	240600
240700	2	ID	Kab. Flores Timur	240000
240701	3	ID	Kec. Wulang Gitang	240700
240702	3	ID	Kec. Tanjung Bunga	240700
240703	3	ID	Kec. Larantuka	240700
240704	3	ID	Kec. Solor Barat	240700
240705	3	ID	Kec. Solor Timur	240700
240706	3	ID	Kec. Adonara Barat	240700
240707	3	ID	Kec. Adonara Timur	240700
240708	3	ID	Kec. Titehena	240700
240709	3	ID	Kec. Ile Boleng	240700
240710	3	ID	Kec. Witihama	240700
240711	3	ID	Kec. Kelubagolit	240700
240712	3	ID	Kec. Wotan Ulumado	240700
240713	3	ID	Kec. Ile Mandiri	240700
240714	3	ID	Kec. Demon Pagong	240700
240715	3	ID	Kec. Lewolema	240700
240716	3	ID	Kec. Ilebura	240700
240717	3	ID	Kec. Adonara	240700
240718	3	ID	Kec. Adonara Tengah	240700
240719	3	ID	Kec. Solor Selatan	240700
240800	2	ID	Kab. Sikka	240000
240801	3	ID	Kec. Paga	240800
240802	3	ID	Kec. Lela	240800
240803	3	ID	Kec. Bola	240800
240804	3	ID	Kec. Talibura	240800
240805	3	ID	Kec. Kewapante	240800
240806	3	ID	Kec. Nelle	240800
240807	3	ID	Kec. Nitta	240800
240808	3	ID	Kec. Alok	240800
240809	3	ID	Kec. Mego	240800
240810	3	ID	Kec. Waigete	240800
240811	3	ID	Kec. Palue	240800
240812	3	ID	Kec. Waiblama	240800
240813	3	ID	Kec. Alok Barat	240800
240814	3	ID	Kec. Alok Timur	240800
240815	3	ID	Kec. Magependa	240800
240816	3	ID	Kec. Koting	240800
240817	3	ID	Kec. Tana Wawo	240800
240818	3	ID	Kec. Hewokloang	240800
240819	3	ID	Kec. Kangae	240800
240820	3	ID	Kec. Doreng	240800
240821	3	ID	Kec. Mapitara	240800
240900	2	ID	Kab. Ende	240000
240901	3	ID	Kec. Nangapanda	240900
240902	3	ID	Kec. Ende	240900
240903	3	ID	Kec. Ende Selatan	240900
240904	3	ID	Kec. Ndona	240900
240905	3	ID	Kec. Wolowaru	240900
240906	3	ID	Kec. Maurole	240900
240907	3	ID	Kec. Detusoko	240900
240909	3	ID	Kec. Maukaro	240900
240910	3	ID	Kec. Wewaria	240900
240911	3	ID	Kec. Wolojita	240900
240912	3	ID	Kec. Pulau Ende	240900
240913	3	ID	Kec. Kota Baru	240900
240914	3	ID	Kec. Ndona Timur	240900
240915	3	ID	Kec. Kelimutu	240900
240916	3	ID	Kec. Lio Timur	240900
240917	3	ID	Kec. Detukeli	240900
240918	3	ID	Kec. Ndori	240900
240919	3	ID	Kec. Ende Utara	240900
240920	3	ID	Kec. Ende Tengah	240900
240921	3	ID	Kec. Ende Timur	240900
240922	3	ID	Kec. Lepembusu Kelisoke	240900
241000	2	ID	Kab. Ngada	240000
241001	3	ID	Kec. Aimere	241000
241002	3	ID	Kec. Bajawa	241000
241003	3	ID	Kec. Golewa	241000
241007	3	ID	Kec. Bajawa Utara	241000
241008	3	ID	Kec. Riung	241000
241012	3	ID	Kec. Riung Barat	241000
241013	3	ID	Kec. Soa	241000
241015	3	ID	Kec. Jerebuu	241000
241017	3	ID	Kec. Riung Selatan	241000
241100	2	ID	Kab. Manggarai	240000
241104	3	ID	Kec. Satarmese	241100
241111	3	ID	Kec. Langke Rembong	241100
241112	3	ID	Kec. Ruteng	241100
241113	3	ID	Kec. Cibal	241100
241114	3	ID	Kec. Reok	241100
241117	3	ID	Kec. Wae Ri`I	241100
241118	3	ID	Kec. Satar Mese Barat	241100
241119	3	ID	Kec. Rahong Utara	241100
241120	3	ID	Kec. Lelak	241100
241200	2	ID	Kab. Sumba Timur	240000
241201	3	ID	Kec. Lewa	241200
241202	3	ID	Kec. Tabundung	241200
241203	3	ID	Kec. Paberiwai	241200
241204	3	ID	Kec. Pahunga Lodu	241200
241205	3	ID	Kec. Rindi	241200
241206	3	ID	Kec. Pandawai	241200
241207	3	ID	Kec. Kota Waingapu	241200
241208	3	ID	Kec. Haharu	241200
241209	3	ID	Kec. Nggaha Ori Angu	241200
241210	3	ID	Kec. Karera	241200
241211	3	ID	Kec. Umalulu	241200
241212	3	ID	Kec. Kahaungu Eti	241200
241213	3	ID	Kec. Matawai La Pawu	241200
241214	3	ID	Kec. Pinu Pahar	241200
241215	3	ID	Kec. Wulla Waijelu	241200
241216	3	ID	Kec. Katala Hamu Lingu	241200
241217	3	ID	Kec. Mahu	241200
241218	3	ID	Kec. Ngadu Ngala	241200
241219	3	ID	Kec. Kambata Mapambuhang	241200
241220	3	ID	Kec. Kambera	241200
241221	3	ID	Kec. Kanatang	241200
241222	3	ID	Kec. Lewa Tidahu	241200
241300	2	ID	Kab. Sumba Barat	240000
241305	3	ID	Kec. Loli	241300
241306	3	ID	Kec. Kota Waikabubak	241300
241310	3	ID	Kec. Wanokaka	241300
241311	3	ID	Kec. Lamboya	241300
241318	3	ID	Kec. Tana Righu	241300
241319	3	ID	Kec. Laboya Barat	241300
241400	2	ID	Kab. Lembata	240000
241401	3	ID	Kec. Naga Wutung	241400
241402	3	ID	Kec. Atadei	241400
241403	3	ID	Kec. Ile Ape	241400
241404	3	ID	Kec. Lebatukan	241400
241405	3	ID	Kec. Nubatukan	241400
241406	3	ID	Kec. Omesuri	241400
241407	3	ID	Kec. Buyasuri	241400
241408	3	ID	Kec. Wulandoni	241400
241409	3	ID	Kec. Ile Ape Timur	241400
241500	2	ID	Kab. Rote-Ndao	240000
241504	3	ID	Kec. Rote Barat Daya	241500
241505	3	ID	Kec. Rote Barat Laut	241500
241506	3	ID	Kec. Lobalain	241500
241507	3	ID	Kec. Rote Tengah	241500
241508	3	ID	Kec. Pantai Baru	241500
241509	3	ID	Kec. Rote Timur	241500
241510	3	ID	Kec. Rote Barat	241500
241511	3	ID	Kec. Rote Selatan	241500
241600	2	ID	Kab. Manggarai Barat	240000
241601	3	ID	Kec. Komodo	241600
241602	3	ID	Kec. Sano Nggoang	241600
241603	3	ID	Kec. Lembor	241600
241604	3	ID	Kec. Kuwus	241600
241605	3	ID	Kec. Macang Pacar	241600
241606	3	ID	Kec. Boleng	241600
241607	3	ID	Kec. Welak	241600
241608	3	ID	Kec. Ndoso	241600
241609	3	ID	Kec. Lembor Selatan	241600
241610	3	ID	Kec. Mbeliling	241600
241700	2	ID	Kab. Nagakeo	240000
241701	3	ID	Kec. Aesesa	241700
241702	3	ID	Kec. Boawae	241700
241703	3	ID	Kec. Keo Tengah	241700
241704	3	ID	Kec. Mauponggo	241700
241705	3	ID	Kec. Nangaroro	241700
241706	3	ID	Kec. Wolowae	241700
241708	3	ID	Kec. Aesesa Selatan	241700
241800	2	ID	Kab. Sumba Tengah	240000
241801	3	ID	Kec. Katiku Tana	241800
241802	3	ID	Kec. Mamboro	241800
241803	3	ID	Kec. Umbu Ratu Nggay	241800
241804	3	ID	Kec. Umbu Ratu Nggay Barat	241800
241805	3	ID	Kec. Katiku Tana Selatan	241800
241900	2	ID	Kab. Sumba Barat Daya	240000
241901	3	ID	Kec. Kodi	241900
241902	3	ID	Kec. Kodi Bangedo	241900
241903	3	ID	Kec. Loura	241900
241904	3	ID	Kec. Wewewa Barat	241900
241905	3	ID	Kec. Wewewa Selatan	241900
241906	3	ID	Kec. Wewewa Timur	241900
241907	3	ID	Kec. Wewewa Utara	241900
241908	3	ID	Kec. Kodi Utara	241900
242000	2	ID	Kab. Manggarai Timur	240000
242001	3	ID	Kec. Elar	242000
242002	3	ID	Kec. Kota Komba	242000
242003	3	ID	Kec. Lamba Leda	242000
242004	3	ID	Kec. Poco Ranaka	242000
242005	3	ID	Kec. Sambi Rampas	242000
242006	3	ID	Kec. Borong	242000
242100	2	ID	Kab. Sabu Raijua	240000
242111	3	ID	Hawu Mehara	      
242112	3	ID	Sabu Tengah	      
242113	3	ID	Raijua	      
242114	3	ID	Sabu Liae	      
242115	3	ID	Sabu Barat	      
242116	3	ID	Sabu Timur	      
246000	2	ID	Kota Kupang	240000
246001	3	ID	Kec. Alak	246000
246002	3	ID	Kec. Maulafa	246000
246003	3	ID	Kec. Oebodo	246000
246004	3	ID	Kec. Kelapa Lima	246000
246005	3	ID	Kec. Kota Raja	246000
246006	3	ID	Kec. Kota Lama	246000
250000	1	ID	Prov. Papua	000000
250100	2	ID	Kab. Jayapura	250000
250108	3	ID	Kec. Kaureh	250100
250114	3	ID	Kec. Kemtuk	250100
250115	3	ID	Kec. Kemtuk Gresie	250100
250116	3	ID	Kec. Nimboran	250100
250117	3	ID	Kec. Nimbokrang	250100
250118	3	ID	Kec. Unurum Guay	250100
250120	3	ID	Kec. Demta	250100
250121	3	ID	Kec. Depapre	250100
250122	3	ID	Kec. Sentani Barat	250100
250123	3	ID	Kec. Sentani	250100
250124	3	ID	Kec. Sentani Timur	250100
250125	3	ID	Kec. Airu	250100
250126	3	ID	Kec. Yapsi	250100
250127	3	ID	Kec. Nimboran Timur/Namblong	250100
250128	3	ID	Kec. Waibu	250100
250129	3	ID	Kec. Ebungfau	250100
250200	2	ID	Kab. Biak Numfor	250000
250201	3	ID	Kec. Numfor Barat	250200
250202	3	ID	Kec. Numfor Timur	250200
250203	3	ID	Kec. Padaido	250200
250204	3	ID	Kec. Biak Timur	250200
250205	3	ID	Kec. Biak Kota	250200
250206	3	ID	Kec. Samofa	250200
250207	3	ID	Kec. Yendidori	250200
250208	3	ID	Kec. Biak Utara	250200
250209	3	ID	Kec. Warsa	250200
250210	3	ID	Kec. Biak Barat	250200
250211	3	ID	Kec. Swandiwe	250200
250212	3	ID	Kec. Orkeri	250200
250213	3	ID	Kec. Bruyandori	250200
250214	3	ID	Kec. Poiru	250200
250215	3	ID	Kec. Ainando Padaido	250200
250216	3	ID	Kec. Oridek	250200
250217	3	ID	Kec. Andey	250200
250218	3	ID	Kec. Yawosi	250200
250219	3	ID	Kec. Bondifuar	250200
250300	2	ID	Kab. Yapen Waropen	250000
250304	3	ID	Kec. Yapen Timur	250300
250305	3	ID	Kec. Angkaisera	250300
250306	3	ID	Kec. Yapen Selatan	250300
250307	3	ID	Kec. Yapen Barat	250300
250308	3	ID	Kec. Poom	250300
250309	3	ID	Kec. Kosiwo	250300
250310	3	ID	Kec. Yapen Utara	250300
250311	3	ID	Kec. Raimbawi	250300
250312	3	ID	Kec. Teluk Ampimoi	250300
250313	3	ID	Kec. Kepulauan Ambai	250300
250314	3	ID	Kec. Wonawa	250300
250315	3	ID	Kec. Windesi	250300
250700	2	ID	Kab. Merauke	250000
250701	3	ID	Kec. Kimaam	250700
250702	3	ID	Kec. Okaba	250700
250703	3	ID	Kec. Kurik	250700
250704	3	ID	Kec. Merauke	250700
250705	3	ID	Kec. Muting	250700
250724	3	ID	Kec. Distrik Ulilin	250700
250725	3	ID	Kec. Semangga	250700
250726	3	ID	Kec. Tanah Miring	250700
250727	3	ID	Kec. Jagebob	250700
250728	3	ID	Kec. Sota	250700
250729	3	ID	Kec. Eligobel	250700
250730	3	ID	Kec. Naukenjerai	250700
250731	3	ID	Kec. Animha	250700
250732	3	ID	Kec. Malind	250700
250733	3	ID	Kec. Tubang	250700
250734	3	ID	Kec. Ngunti	250700
250736	3	ID	Kec. Kaptel	250700
250737	3	ID	Kec. Tabonji	250700
250738	3	ID	Kec. Waan	250700
250739	3	ID	Kec. Ilwayab	250700
250800	2	ID	Kab. Jayawijaya	250000
250818	3	ID	Kec. Asologaima	250800
250819	3	ID	Kec. Kurulu	250800
250821	3	ID	Kec. Abenaho	250800
250839	3	ID	Kec. Walelagama	250800
250841	3	ID	Kec. Musatfak	250800
250843	3	ID	Kec. Asolokobal	250800
250848	3	ID	Kec. Pelebaga	250800
250849	3	ID	Kec. Yalengga	250800
250854	3	ID	Kec. Wamena	250800
250860	3	ID	Kec. Hubikosi	250800
250862	3	ID	Kec. Bolakme	250800
250863	3	ID	Kec. Wollo	250800
250900	2	ID	Kab. Nabire	250000
250905	3	ID	Kec. Uwapa	250900
250906	3	ID	Kec. Yaur	250900
250907	3	ID	Kec. Wanggar	250900
250908	3	ID	Kec. Nabire	250900
250909	3	ID	Kec. Napan	250900
250910	3	ID	Kec. Siriwo	250900
250911	3	ID	Kec. Teluk Umar	250900
250912	3	ID	Kec. Makimi	250900
250916	3	ID	Kec. Teluk Kimi	250900
250917	3	ID	Kec. Yarokibisay	250900
250922	3	ID	Kec. Nabire Barat	250900
250923	3	ID	Kec. Wapoga	250900
250990	3	ID	Dipha	      
250999	3	ID	Yaro	      
251000	2	ID	Kab. Paniai	250000
251003	3	ID	Kec. Paniai Timur	251000
251004	3	ID	Kec. Bibida	251000
251008	3	ID	Kec. Paniai Barat	251000
251009	3	ID	Kec. Bogoboida	251000
251014	3	ID	Kec. Yatamo	251000
251015	3	ID	Kec. Kebo	251000
251016	3	ID	Kec. Dumadama	251000
251018	3	ID	Kec. Ekadide	251000
251019	3	ID	Kec. Siriwo	251000
251090	3	ID	Aradide	      
251100	2	ID	Kab. Puncak Jaya	250000
251104	3	ID	Kec. Fawi	251100
251105	3	ID	Kec. Mulia	251100
251106	3	ID	Kec. Ilu	251100
251110	3	ID	Kec. Mewoluk	251100
251111	3	ID	Kec. Yamo	251100
251113	3	ID	Kec. Torere	251100
251114	3	ID	Kec. Jigonikme	251100
251115	3	ID	Kec. Tingginambut	251100
251200	2	ID	Kab. Mimika	250000
251201	3	ID	Kec. Mimika Barat	251200
251202	3	ID	Kec. Mimika Timur	251200
251203	3	ID	Kec. Mimika Baru	251200
251204	3	ID	Kec. Agimuga	251200
251205	3	ID	Kec. Mimika Barat Jauh	251200
251206	3	ID	Kec. Mimika Barat Tengah	251200
251209	3	ID	Kec. Tembagapura	251200
251210	3	ID	Kec. Jila	251200
251211	3	ID	Kec. Jita	251200
251212	3	ID	Kec. Kuala Kencana	251200
251213	3	ID	Kec. Mimika Timur Tengah	251200
251214	3	ID	Kec. Mimika Timur Jauh	251200
251300	2	ID	Kab. Boven Digoel	250000
251301	3	ID	Kec. Jair	251300
251302	3	ID	Kec. Mindiptana	251300
251303	3	ID	Kec. Mandobo	251300
251304	3	ID	Kec. Kouh	251300
251305	3	ID	Kec. Waropko	251300
251306	3	ID	Kec. Distrik Bomakia	251300
251307	3	ID	Kec. Subur	251300
251308	3	ID	Kec. Iniyandit	251300
251309	3	ID	Kec. Fofi	251300
251310	3	ID	Kec. Arimop	251300
251311	3	ID	Kec. Firiwage	251300
251312	3	ID	Kec. Manggelum	251300
251313	3	ID	Kec. Yaniruma	251300
251314	3	ID	Kec. Ambatkwi	251300
251315	3	ID	Kombut	251300
251400	2	ID	Kab. Mappi	250000
251401	3	ID	Kec. Nambioman Bapai	251400
251402	3	ID	Kec. Edera	251400
251403	3	ID	Kec. Obaa	251400
251404	3	ID	Kec. Haju	251400
251405	3	ID	Kec. Assue	251400
251406	3	ID	Kec. Citakmitak	251400
251407	3	ID	Kec. Minyamur	251400
251408	3	ID	Kec. Venaha	251400
251409	3	ID	Kec. Passue	251400
251410	3	ID	Kec. Kaibar	251400
251500	2	ID	Kab. Asmat	250000
251501	3	ID	Kec. Pantai Kasuari	251500
251502	3	ID	Kec. Fayit	251500
251503	3	ID	Kec. Atsy	251500
251504	3	ID	Kec. Suator	251500
251505	3	ID	Kec. Akat	251500
251506	3	ID	Kec. Agats	251500
251507	3	ID	Kec. Sawaerma	251500
251600	2	ID	Kab. Yahukimo	250000
251601	3	ID	Kec. Kurima	251600
251602	3	ID	Kec. Ninia	251600
251603	3	ID	Kec. Anggruk	251600
251604	3	ID	Kec. Dekai	251600
251605	3	ID	Kec. Obio	251600
251606	3	ID	Kec. Suru Suru	251600
251607	3	ID	Kec. Wusuma	251600
251608	3	ID	Kec. Amuma	251600
251609	3	ID	Kec. Wusaik	251600
251610	3	ID	Kec. Pasema	251600
251611	3	ID	Kec. Hogio	251600
251612	3	ID	Kec. Mogi	251600
251613	3	ID	Kec. Soba	251600
251614	3	ID	Kec. Werima	251600
251615	3	ID	Kec. Tangma	251600
251616	3	ID	Kec. Ukha	251600
251617	3	ID	Kec. Panggema	251600
251618	3	ID	Kec. Kosarek	251600
251619	3	ID	Kec. Nipsan	251600
251620	3	ID	Kec. Ubahak	251600
251621	3	ID	Kec. Pronggoli	251600
251622	3	ID	Kec. Walma	251600
251623	3	ID	Kec. Yahuliambut	251600
251624	3	ID	Kec. Puldama	251600
251625	3	ID	Kec. Hereapingi	251600
251626	3	ID	Kec. Ubahili	251600
251627	3	ID	Kec. Talambo	251600
251628	3	ID	Kec. Endomen	251600
251629	3	ID	Kec. Kona	251600
251630	3	ID	Kec. Dirwemna	251600
251631	3	ID	Kec. Holuwon	251600
251632	3	ID	Kec. Lolat	251600
251633	3	ID	Kec. Soloikma	251600
251634	3	ID	Kec. Sela	251600
251635	3	ID	Kec. Korupun	251600
251636	3	ID	Kec. Langda	251600
251637	3	ID	Kec. Bomela	251600
251638	3	ID	Kec. Suntamon	251600
251639	3	ID	Kec. Seredela	251600
251640	3	ID	Kec. Sobaham	251600
251641	3	ID	Kec. Kabianggama	251600
251642	3	ID	Kec. Kwelamdua	251600
251643	3	ID	Kec. Kwikma	251600
251644	3	ID	Kec. Hilipuk	251600
251645	3	ID	Kec. Duram	251600
251646	3	ID	Kec. Yogosem	251600
251647	3	ID	Kec. Kayo	251600
251648	3	ID	Kec. Sumo	251600
251649	3	ID	Kec. Silimo	251600
251650	3	ID	Kec. Samenage	251600
251651	3	ID	Kec. Nalca	251600
251699	3	ID	Seradala	      
251700	2	ID	Kab. Pegunungan Bintang	250000
251701	3	ID	Kec. Okiwur	251700
251702	3	ID	Kec. Oksibil	251700
251703	3	ID	Kec. Borme	251700
251704	3	ID	Kec. Okbibab	251700
251705	3	ID	Kec. Kiwirok	251700
251706	3	ID	Kec. Batom	251700
251707	3	ID	Kec. Pepera	251700
251708	3	ID	Kec. Bime	251700
251709	3	ID	Kec. Aboy	251700
251710	3	ID	Kec. Kiwirok Timur	251700
251711	3	ID	Kec. Kawor	251700
251712	3	ID	Kec. Tarup	251700
251713	3	ID	Kec. Alemsom	251700
251714	3	ID	Kec. Serambakon	251700
251715	3	ID	Kec. Kalomdom	251700
251716	3	ID	Kec. Oksop	251700
251717	3	ID	Kec. Epumek	251700
251718	3	ID	Kec. Weime	251700
251719	3	ID	Kec. Okbab	251700
251720	3	ID	Kec. Teiraplu	251700
251721	3	ID	Kec. Sopsebang	251700
251722	3	ID	Kec. Hokhika	251700
251723	3	ID	Kec.Oklip	251700
251724	3	ID	Kec. Oksamol	251700
251725	3	ID	Kec. Bemta	251700
251726	3	ID	Okbape	251700
251727	3	ID	Ok Aom	251700
251728	3	ID	Awinbon	251700
251729	3	ID	Batani	251700
251730	3	ID	Murkim	251700
251731	3	ID	Mofinop	251700
251732	3	ID	Jetfa	251700
251733	3	ID	Nongme	251700
251734	3	ID	Pamek	251700
251737	3	ID	Iwur	      
251790	3	ID	Okbemtau	      
251791	3	ID	Oksebang	      
251800	2	ID	Kab. Tolikara	250000
251801	3	ID	Kec. Kanggime	251800
251802	3	ID	Kec. Karubaga	251800
251803	3	ID	Kec. Bokondini	251800
251804	3	ID	Kec. Kembu	251800
251805	3	ID	Kec. Goyage	251800
251806	3	ID	Kec. Kubu	251800
251807	3	ID	Kec. Geya	251800
251808	3	ID	Kec. Numba	251800
251809	3	ID	Kec. Dundu	251800
251810	3	ID	Kec. Gudage	251800
251811	3	ID	Kec. Timori	251800
251812	3	ID	Kec. Konda	251800
251813	3	ID	Kec. Nelawi	251800
251814	3	ID	Kec. Kuari	251800
251815	3	ID	Kec. Bokoneri	251800
251816	3	ID	Kec. Bewani	251800
251817	3	ID	Kec. Komboneri	251800
251818	3	ID	Kec. Nabunage	251800
251819	3	ID	Kec. Wakuo	251800
251820	3	ID	Kec. Nunggawi	251800
251821	3	ID	Kec. Woniki	251800
251822	3	ID	Kec. Wunin	251800
251823	3	ID	Kec. Wina	251800
251824	3	ID	Kec. Panaga	251800
251825	3	ID	Kec. Poganeri	251800
251826	3	ID	Kec. Dow	251800
251827	3	ID	Kec. Wari/Taiyeve	251800
251830	3	ID	Kec. Umagi	251800
251831	3	ID	Kec. Gilungbandu	251800
251832	3	ID	Kec. Yuneri	251800
251833	3	ID	Kec. Taginire	251800
251834	3	ID	Kec. Egiam	251800
251835	3	ID	Kec. Air Garam	251800
251836	3	ID	Gika	251800
251837	3	ID	Telenggeme	251800
251838	3	ID	Anawi	251800
251839	3	ID	Wenam	251800
251840	3	ID	Wugi	251800
251841	3	ID	Danime	251800
251842	3	ID	Tagime	251800
251843	3	ID	tidak ada	251800
251844	3	ID	Aweku	251800
251845	3	ID	Bogonuk	251800
251846	3	ID	Li Anogomma	251800
251847	3	ID	Biuk	251800
251848	3	ID	Yuko	251800
251890	3	ID	Kamboneri	      
251900	2	ID	Kab. Sarmi	250000
251902	3	ID	Kec. Pantai Timur	251900
251903	3	ID	Kec. Bonggo	251900
251904	3	ID	Kec. Tor Atas	251900
251905	3	ID	Kec. Sarmi	251900
251906	3	ID	Kec. Pantai Barat	251900
251907	3	ID	Kec. Pantai Timur Bagian Barat	251900
251910	3	ID	Kec. Bonggo Timur	251900
251911	3	ID	Kec. Sarmi Timur	251900
251912	3	ID	Kec. Sarmi Barat	251900
251913	3	ID	Kec. Apawert Hulu	251900
251914	3	ID	Sarmi Selatan	      
252000	2	ID	Kab. Keerom	250000
252001	3	ID	Kec. Web	252000
252002	3	ID	Kec. Senggi	252000
252003	3	ID	Kec. Waris	252000
252004	3	ID	Kec. Arso	252000
252005	3	ID	Kec. Skamto	252000
252006	3	ID	Kec. Towe Hitam	252000
252007	3	ID	Kec. Arso Timur	252000
252600	2	ID	Kab. Waropen	250000
252601	3	ID	Kec. Waropen Bawah	252600
252602	3	ID	Kec. Masirei	252600
252604	3	ID	Kec. Inggerus	252600
252605	3	ID	Kec. Ureifaisei	252600
252607	3	ID	Kec. Risei Sayati	252600
252609	3	ID	Kec. Kirihi	252600
252610	3	ID	Wapoga	      
252700	2	ID	Kab. Supiori	250000
252701	3	ID	Kec. Supiori Selatan	252700
252702	3	ID	Kec. Yenggarbun	252700
252703	3	ID	Kec. Supiori Timur	252700
252704	3	ID	Kec. Kepulauan Aruri	252700
252705	3	ID	Kec. Supiori Barat	252700
252790	3	ID	Supiori Utara	      
252800	2	ID	Kab. Memberamo Raya	250000
252803	3	ID	Kec. Waropen Atas	252800
252804	3	ID	Kec. Mamberamo Ilir	252800
252805	3	ID	Kec. Mamberamo Tengah	252800
252806	3	ID	Kec. Mamberamo Tengah Timur	252800
252807	3	ID	Kec. Rufaer	252800
252808	3	ID	Kec. Mamberamo Ulu	252800
252809	3	ID	Kec. Benuki	252800
252810	3	ID	Kec. Sawai	252800
252890	3	ID	Mamberamo Hulu	      
252891	3	ID	Mamberamo Hilir	      
252900	2	ID	Kab. Nduga	250000
252901	3	ID	Kec. Wosak	252900
252902	3	ID	Kec. Kenyam	252900
252903	3	ID	Kec. Geselma	252900
252904	3	ID	Kec. Mapenduma	252900
252905	3	ID	Kec. Mugi	252900
252906	3	ID	Kec. Yigi	252900
252907	3	ID	Kec. Mbuwa	252900
252908	3	ID	Kec. Gearek	252900
253000	2	ID	Kab. Lanny Jaya	250000
253001	3	ID	Kec. Makki	253000
253002	3	ID	Kec. Pirime	253000
253003	3	ID	Kec. Tiom	253000
253004	3	ID	Kec. Balingga	253000
253005	3	ID	Kec. Kuyawage	253000
253006	3	ID	Kec. Malagaineri	253000
253007	3	ID	Kec. Tiomneri	253000
253008	3	ID	Kec. Dimba	253000
253009	3	ID	Kec. Gamelia	253000
253010	3	ID	Kec. Poga	253000
253100	2	ID	Kab. Membramo Tengah	250000
253101	3	ID	Kec. Kobakma	253100
253102	3	ID	Kec. Ilugwa	253100
253103	3	ID	Kec. Kelila	253100
253104	3	ID	Kec. Eragayam	253100
253105	3	ID	Kec. Megambilis	253100
253200	2	ID	Kab. Yalimo	250000
253201	3	ID	Kec. Welarek	253200
253202	3	ID	Kec. Apalapsili	253200
253203	3	ID	Kec. Abenaho	253200
253204	3	ID	Kec. Elelim	253200
253205	3	ID	Kec. Benawa	253200
253300	2	ID	kab. Puncak	250000
253301	3	ID	Kec. Agadugume	253300
253302	3	ID	Kec. Gome	253300
253303	3	ID	Kec. Ilaga	253300
253304	3	ID	Kec. Sinak	253300
253305	3	ID	Kec. Pogoma	253300
253306	3	ID	Kec. Wangbe	253300
253307	3	ID	Kec. Beoga	253300
253308	3	ID	Kec. Doufo	253300
253400	2	ID	Kab. Dogiyai	250000
253401	3	ID	Kec. Piyaiye	253400
253402	3	ID	Kec. Mapia Barat	253400
253403	3	ID	Kec. Mapia	253400
253404	3	ID	Kec. Dogiyai	253400
253405	3	ID	Kec. Kamu Selatan	253400
253406	3	ID	Kec. Kamu	253400
253407	3	ID	Kec. Mapia Tengah	253400
253408	3	ID	Kec. Kamu Tmur	253400
253409	3	ID	Kec. Kamu Utara	253400
253410	3	ID	Kec. Sukikai Selatan	253400
253500	2	ID	Kab. Deiyai	250000
253501	3	ID	Kec. Tigi	253500
253502	3	ID	Kec. Tigi Barat	253500
253503	3	ID	Kec. Tigi Timur	253500
253504	3	ID	Kec. Bowobado	253500
253505	3	ID	Kec. Kapiraya	253500
253600	2	ID	Kab. Intan Jaya	250000
253601	3	ID	Kec. Sugapa	253600
253602	3	ID	Kec. Hitadipa	253600
253603	3	ID	Kec. Homeyo	253600
253604	3	ID	Kec. Biandoga	253600
253605	3	ID	Kec. Wandai	253600
253606	3	ID	Kec. Agisiga	253600
253691	3	ID	Sugapa*	      
253692	3	ID	Hitadipa*	      
253693	3	ID	Homeyo*	      
253694	3	ID	Biandoga*	      
253695	3	ID	Wandai*	      
253696	3	ID	Agisiga*	      
256000	2	ID	Kota Jayapura	250000
256001	3	ID	Kec. Muara Tami	256000
256002	3	ID	Kec. Abepura	256000
256003	3	ID	Kec. Jayapura Selatan	256000
256004	3	ID	Kec. Jayapura Utara	256000
256005	3	ID	Kec. Heram	256000
256090	3	ID	Kotaraja	      
260000	1	ID	Prov. Bengkulu	000000
260100	2	ID	Kab. Bengkulu Utara	260000
260101	3	ID	Kec. Enggano	260100
260105	3	ID	Kec. Kerkap	260100
260106	3	ID	Kec. Arga Makmur	260100
260107	3	ID	Kec. Lais	260100
260108	3	ID	Kec. Padang Jaya	260100
260109	3	ID	Kec. Ketahun	260100
260110	3	ID	Kec. Putri Hijau	260100
260117	3	ID	Kec. Air Napal	260100
260118	3	ID	Kec. Air Besi	260100
260119	3	ID	Kec. Batik Nau	260100
260120	3	ID	Kec. Giri Mulia	260100
260121	3	ID	Kec. Napal Putih	260100
260122	3	ID	Hulu Palik	260100
260123	3	ID	Air Padang	260100
260200	2	ID	Kab. Rejang Lebong	260000
260202	3	ID	Kec. Kota Padang	260200
260203	3	ID	Kec. Padang Ulang Tanding	260200
260204	3	ID	Kec. Curup	260200
260210	3	ID	Kec. Sindang Kelingi	260200
260211	3	ID	Kec. Bermani Ulu	260200
260212	3	ID	Kec. Selupu Rejang	260200
260217	3	ID	Kec. Sindang Beliti Ilir	260200
260218	3	ID	Kec. Bindu Riang	260200
260219	3	ID	Kec. Sindang Beliti Ulu	260200
260220	3	ID	Kec. Sindang Dataran	260200
260221	3	ID	Kec. Curup Selatan	260200
260222	3	ID	Kec. Curup Tengah	260200
260223	3	ID	Kec. Bermani Ulu Raya	260200
260224	3	ID	Kec. Curup Utara	260200
260225	3	ID	Kec. Curup Timur	260200
260300	2	ID	Kab. Bengkulu Selatan	260000
260304	3	ID	Kec. Manna	260300
260305	3	ID	Kec. Seginim	260300
260306	3	ID	Kec. Pino	260300
260314	3	ID	Kec. Kota Manna	260300
260315	3	ID	Kec. Pinoraya	260300
260318	3	ID	Kec. Kedurang	260300
260319	3	ID	Kec. Bunga Mas	260300
260320	3	ID	Kec. Pasar Manna	260300
260321	3	ID	Kec. Kedurang Ilir	260300
260322	3	ID	Kec. Air Nipis	260300
260323	3	ID	Kec. Ulu Manna	260300
260400	2	ID	Kab. Muko-muko	260000
260401	3	ID	Kec. Muko-Muko Selatan	260400
260402	3	ID	Kec. Teras Terunjam	260400
260403	3	ID	Kec. Muko-Muko Utara	260400
260404	3	ID	Kec. Pondok Suguh	260400
260405	3	ID	Kec. Lubuk Pinang	260400
260406	3	ID	Kec. Air Rami	260400
260407	3	ID	Kec. Malin Deman	260400
260408	3	ID	Kec. Sungai Rumbai	260400
260409	3	ID	Kec. Teramang Jaya	260400
260410	3	ID	Kec. Penarik	260400
260411	3	ID	Kec. Selagan Raya	260400
260412	3	ID	Kec. Air Dikit	260400
260413	3	ID	Kec. XIV Koto	260400
260414	3	ID	Kec. Air Manjunto	260400
260415	3	ID	Kec. V Koto	260400
260490	3	ID	Kota Mukomuko	      
260491	3	ID	Ipuh	      
260500	2	ID	Kab. Kepahiang	260000
260501	3	ID	Kec. Kepahiang	260500
260502	3	ID	Kec. Bermani Ilir	260500
260503	3	ID	Kec. Tebat Karai	260500
260504	3	ID	Kec. Ujan Mas	260500
260505	3	ID	Kec. Muara Kemumu	260500
260506	3	ID	Kec. Seberang Musi	260500
260507	3	ID	Kec. Kaba Wetan	260500
260508	3	ID	Kec. Merigi	260500
260600	2	ID	Kab. Lebong	260000
260601	3	ID	Kec. Lebong Selatan	260600
260602	3	ID	Kec. Lebong Utara	260600
260603	3	ID	Kec. Rimbo Pegadang	260600
260604	3	ID	Kec. Lebong Tengah	260600
260605	3	ID	Kec. Lebong Atas	260600
260607	3	ID	Topos	260600
260608	3	ID	Bingin Kuning	260600
260609	3	ID	Lebong Sakti	260600
260610	3	ID	Pelabai	260600
260611	3	ID	Amen	260600
260612	3	ID	Uram Jaya	260600
260613	3	ID	Pinang Belapis	260600
260700	2	ID	Kab. Kaur	260000
260701	3	ID	Kec. Kaur Selatan	260700
260702	3	ID	Kec. Kaur Tengah	260700
260703	3	ID	Kec. Kaur Utara	260700
260704	3	ID	Kec. Maje	260700
260705	3	ID	Kec. Nasal	260700
260706	3	ID	Kec. Kinal	260700
260707	3	ID	Kec. Tanjung Kemuning	260700
260708	3	ID	Kec. Muara Tetap	260700
260709	3	ID	Kec. Luas	260700
260710	3	ID	Kec. Muara Sahung	260700
260711	3	ID	Kec. Semidang Gumai	260700
260712	3	ID	Kec. Kelam Tengah	260700
260713	3	ID	Kec. Padang Guci Hilir	260700
260714	3	ID	Kec. Padang Guci Ulu	260700
260715	3	ID	Kec. Lungkang Kule	260700
260800	2	ID	Kab. Seluma	260000
260801	3	ID	Kec. Talo	260800
260802	3	ID	Kec. Seluma	260800
260803	3	ID	Kec. Sukaraja	260800
260804	3	ID	Kec. Semidang Alas Maras	260800
260805	3	ID	Kec. Semidang Alas	260800
260806	3	ID	Kec. Ilir Talo	260800
260807	3	ID	Kec. Talo Kecil	260800
260808	3	ID	Kec. Ulu Talo	260800
260809	3	ID	Kec. Seluma Selatan	260800
260810	3	ID	Kec. Seluma Barat	260800
260811	3	ID	Kec. Seluma Timur	260800
260812	3	ID	Kec. Seluma Utara	260800
260813	3	ID	Kec. Air Periukan	260800
260814	3	ID	Kec. Lubuk Sandi	260800
260900	2	ID	Kab. Bengkulu Tengah	260000
260901	3	ID	Kec. Talang Empat	260900
260902	3	ID	Kec. Karang Tinggi	260900
260903	3	ID	Kec. Taba Penanjung	260900
260904	3	ID	Kec. Pagar Jati	260900
260905	3	ID	Kec. Pondok Kelapa	260900
260906	3	ID	Kec. Pematang Tiga	260900
260907	3	ID	Kec. Merigi Kelindang	260900
260908	3	ID	Kec. Merigi Sakti	260900
260909	3	ID	Kec. Pondok Kubang	260900
260910	3	ID	Kec. Bang Haji	260900
266000	2	ID	Kota Bengkulu	260000
266001	3	ID	Kec. Selebar	266000
266002	3	ID	Kec. Gading Cempaka	266000
266003	3	ID	Kec. Teluk Segara	266000
266004	3	ID	Kec. Muara Bangkahulu	266000
266005	3	ID	Kec. Kampung Melayu	266000
266006	3	ID	Kec. Ratu Agung	266000
266007	3	ID	Kec. Ratu Samban	266000
266008	3	ID	Kec. Sungai  Serut	266000
266009	3	ID	Kec. Singaran Pati	266000
270000	1	ID	Prov. Maluku Utara	000000
270200	2	ID	Kab. Halmahera Tengah	270000
270203	3	ID	Kec. Weda	270200
270204	3	ID	Kec. Pulau Gebe	270200
270206	3	ID	Kec. Patani	270200
270207	3	ID	Kec. Weda Utara	270200
270208	3	ID	Kec. Weda Selatan	270200
270209	3	ID	Kec. Patani Utara	270200
270210	3	ID	Weda Tengah	270200
270211	3	ID	Patani Barat	270200
270300	2	ID	Kab. Halmahera Barat	270000
270302	3	ID	Kec. Sahu	270300
270303	3	ID	Kec. Ibu	270300
270304	3	ID	Kec. Loloda	270300
270305	3	ID	Kec. Jailolo Selatan	270300
270306	3	ID	Kec. Jailolo	270300
270307	3	ID	Kec. Sahu Timur	270300
270308	3	ID	Kec. Ibu Selatan	270300
270309	3	ID	Kec. Ibu Utara	270300
270310	3	ID	Jailolo Timur	      
270400	2	ID	Kab. halmahera Utara	270000
270401	3	ID	Kec. Tobelo	270400
270402	3	ID	Kec. Tobelo Selatan	270400
270403	3	ID	Kec. Kao	270400
270404	3	ID	Kec. Galela	270400
270408	3	ID	Kec. Loloda Utara	270400
270409	3	ID	Kec. Malifut	270400
270410	3	ID	Kec. Tobelo Utara	270400
270411	3	ID	Kec. Tobelo Tengah	270400
270412	3	ID	Kec. Tobelo Timur	270400
270413	3	ID	Kec. Tobelo Barat	270400
270414	3	ID	Kec. Galela Barat	270400
270415	3	ID	Kec. Galela Selatan	270400
270416	3	ID	Kec. Galela Utara	270400
270419	3	ID	Kec. Loloda Kepulauan	270400
270420	3	ID	Kec. Kao Utara	270400
270421	3	ID	Kec. Kao Barat	270400
270422	3	ID	Kec. Kao Teluk	270400
270500	2	ID	Kab. Halmahera Selatan	270000
270502	3	ID	Kec. Bacan Timur	270500
270503	3	ID	Kec. Bacan Barat	270500
270504	3	ID	Kec. Bacan	270500
270505	3	ID	Kec. Obi	270500
270506	3	ID	Kec. Gane Barat	270500
270507	3	ID	Kec. Gane Timur	270500
270508	3	ID	Kec. Kayoa	270500
270509	3	ID	Kec. Pulau Makian	270500
270510	3	ID	Kec. Obi Selatan	270500
270511	3	ID	Kec. Obi Barat	270500
270512	3	ID	Kec. Obi Timur	270500
270513	3	ID	Kec. Obi Utara	270500
270514	3	ID	Kec. Mandioli Selatan	270500
270515	3	ID	Kec. Mandioli Utara	270500
270516	3	ID	Kec. Bancan Selatan	270500
270517	3	ID	Kec. Batang Lomang	270500
270518	3	ID	Kec. Bacan Timur Selatan	270500
270519	3	ID	Kec. Bacan Timur Tengah	270500
270520	3	ID	Kec. Kasiruta Barat	270500
270521	3	ID	Kec. Kasiruta Timur	270500
270522	3	ID	Kec. Bacan Barat Utara	270500
270523	3	ID	Kec. Kayoa Barat	270500
270524	3	ID	Kec. Kayoa Selatan	270500
270525	3	ID	Kec. Kayoa Utara	270500
270526	3	ID	Kec. Makian Barat	270500
270527	3	ID	Kec. Gane Selatan	270500
270528	3	ID	Kec. Gane Utara	270500
270529	3	ID	Kec. Kepulauan Joronga	270500
270530	3	ID	Kec. Gane Timur Tengah	270500
270531	3	ID	Kec. Gane Timur Selatan	270500
270590	3	ID	Gane Barat Selatan	      
270591	3	ID	Gane Barat Utara	      
270600	2	ID	Kab. Halmahera Timur	270000
270601	3	ID	Kec. Maba Selatan	270600
270602	3	ID	Kec. Wasile Selatan	270600
270603	3	ID	Kec. Wasile	270600
270604	3	ID	Kec. Maba	270600
270605	3	ID	Kec. Wasile Tengah	270600
270606	3	ID	Kec. Wasile Utara	270600
270607	3	ID	Kec. Wasile Timur	270600
270608	3	ID	Kec. Maba Tengah	270600
270609	3	ID	Kec. Maba Utara	270600
270610	3	ID	Kec. Kota Maba	270600
270700	2	ID	Kab. Kepulauan Sula	270000
270701	3	ID	Kec. Sanana	270700
270702	3	ID	Kec. Sula Besi Barat	270700
270703	3	ID	Kec. Mangoli Timur	270700
270704	3	ID	Kec. Taliabu Barat	270700
270705	3	ID	Kec. Taliabu Timur	270700
270706	3	ID	Kec. Mangoli Barat	270700
270707	3	ID	Kec. Sula Besi Tengah	270700
270708	3	ID	Kec. Sula Besi Timur	270700
270709	3	ID	Kec. Mangoli Tengah	270700
270710	3	ID	Kec. Mangoli Utara Timur	270700
270711	3	ID	Kec. Mangoli Utara	270700
270712	3	ID	Kec. Mangoli Selatan	270700
270713	3	ID	Kec. Taliabu Timur Selatan	270700
270714	3	ID	Kec. Taliabu Utara	270700
270715	3	ID	Kec. Sula Besi Selatan	270700
270716	3	ID	Kec. Sanana Utara	270700
270717	3	ID	Kec. Taliabu Barat Laut	270700
270718	3	ID	Kec. Lede	270700
270719	3	ID	Kec. Taliabu Selatan	270700
270720	3	ID	Mangoli Tengah	      
270721	3	ID	Taliabu Utara	      
270722	3	ID	Taliabu Timur Selatan	      
270723	3	ID	Taliabu -Timur	      
270724	3	ID	Taliabu Selatan	      
270725	3	ID	Taliabu Barat Laut	      
270726	3	ID	Taliabu Barat	      
270727	3	ID	Lede	      
270790	3	ID	Tabona	      
270800	2	ID	Kab. Kepulauan Morotai	270000
270801	3	ID	Kec. Morotai Selatan Barat	270800
270802	3	ID	Kec. Morotai Selatan	270800
270803	3	ID	Kec. Morotai Utara	270800
270804	3	ID	Kec. Morotai Jaya	270800
270805	3	ID	Kec. Morotai Timur	270800
276000	2	ID	Kota Ternate	270000
276001	3	ID	Kec. Pulau Ternate	276000
276002	3	ID	Kec. Ternate Selatan	276000
276003	3	ID	Kec. Ternate Utara	276000
276004	3	ID	Kec. Moti	276000
276005	3	ID	Kec. Pulau Batang Dua	276000
276006	3	ID	Kec. Ternate Tengah	276000
276007	3	ID	Kec.  Pulau Hiri	276000
276100	2	ID	Kota Tidore Kepulauan	270000
276102	3	ID	Kec. Tidore Selatan	276100
276103	3	ID	Kec. Tidore Utara	276100
276104	3	ID	Kec. Oba	276100
276105	3	ID	Kec. Oba Utara	276100
276106	3	ID	Kec. Oba Tengah	276100
276107	3	ID	Kec. Oba Selatan	276100
276108	3	ID	Kec. Tidore	276100
276109	3	ID	Kec. Tidore Timur	276100
280000	1	ID	Prov. Banten	000000
280100	2	ID	Kab. Pandeglang	280000
280101	3	ID	Kec. Sumur	280100
280102	3	ID	Kec. Cimanggu	280100
280103	3	ID	Kec. Cibaliung	280100
280104	3	ID	Kec. Cikeusik	280100
280105	3	ID	Kec. Cigeulis	280100
280106	3	ID	Kec. Panimbang	280100
280107	3	ID	Kec. Munjul	280100
280108	3	ID	Kec. Picung	280100
280109	3	ID	Kec. Bojong	280100
280110	3	ID	Kec. Saketi	280100
280111	3	ID	Kec. Pagelaran	280100
280112	3	ID	Kec. Labuan	280100
280113	3	ID	Kec. Jiput	280100
280114	3	ID	Kec. Menes	280100
280115	3	ID	Kec. Mandalawangi	280100
280116	3	ID	Kec. Cimanuk	280100
280117	3	ID	Kec. Banjar	280100
280118	3	ID	Kec. Pandeglang	280100
280119	3	ID	Kec. Cadasari	280100
280120	3	ID	Kec. Angsana	280100
280121	3	ID	Kec. Karang Tanjung	280100
280122	3	ID	Kec. Kaduhejo	280100
280123	3	ID	Kec. Cikedal	280100
280124	3	ID	Kec. Cipeucang	280100
280125	3	ID	Kec. Cisata	280100
280126	3	ID	Kec. Patia	280100
280127	3	ID	Kec. Carita	280100
280132	3	ID	Kec. Sukaresmi	280100
280133	3	ID	Kec. Mekarjaya	280100
280134	3	ID	Kec. Sindangresmi	280100
280135	3	ID	Kec. Pulosari	280100
280136	3	ID	Kec. Koroncong	280100
280138	3	ID	Kec. Cibitung	280100
280139	3	ID	Kec. Majasari	280100
280140	3	ID	Kec. Sobang	280100
280200	2	ID	Kab. Lebak	280000
280201	3	ID	Kec. Malingping	280200
280202	3	ID	Kec. Panggarangan	280200
280203	3	ID	Kec. Bayah	280200
280204	3	ID	Kec. Cibeber	280200
280205	3	ID	Kec. Cijaku	280200
280206	3	ID	Kec. Banjarsari	280200
280207	3	ID	Kec. Cileles	280200
280208	3	ID	Kec. Gunung kencana	280200
280209	3	ID	Kec. Bojongmanik	280200
280210	3	ID	Kec. Leuwidamar	280200
280211	3	ID	Kec. Muncang	280200
280212	3	ID	Kec. Cipanas	280200
280213	3	ID	Kec. Sajira	280200
280214	3	ID	Kec. Cimarga	280200
280215	3	ID	Kec. Cikulur	280200
280216	3	ID	Kec. Warung gunung	280200
280217	3	ID	Kec. Cibadak	280200
280218	3	ID	Kec. Rangkasbitung	280200
280219	3	ID	Kec. Maja	280200
280220	3	ID	Kec. Curug bitung	280200
280221	3	ID	Kec. Sobang	280200
280222	3	ID	Kec. Wanasalam	280200
280223	3	ID	Kec. Cilograng	280200
280224	3	ID	Kec. Cihara	280200
280225	3	ID	Kec. Cigemblong	280200
280226	3	ID	Kec. Cirinten	280200
280227	3	ID	Kec. Lebakgedong	280200
280228	3	ID	Kec. Karanganyar	280200
280300	2	ID	Kab. Tangerang	280000
280301	3	ID	Kec. Cisoka	280300
280302	3	ID	Kec. Tiga raksa	280300
280303	3	ID	Kec. Cikupa	280300
280304	3	ID	Kec. Panongan	280300
280305	3	ID	Kec. Curug	280300
280306	3	ID	Kec. Legok	280300
280307	3	ID	Kec. Pagedangan	280300
280312	3	ID	Kec. Pasar Kemis	280300
280313	3	ID	Kec. Balaraja	280300
280314	3	ID	Kec. Kresek	280300
280315	3	ID	Kec. Kronjo	280300
280316	3	ID	Kec. Mauk	280300
280317	3	ID	Kec. Rajeg	280300
280318	3	ID	Kec. Sepatan	280300
280319	3	ID	Kec. Pakuhaji	280300
280320	3	ID	Kec. Teluk naga	280300
280321	3	ID	Kec. Kosambi	280300
280322	3	ID	Kec. Jayanti	280300
280323	3	ID	Kec. Jambe	280300
280324	3	ID	Kec. Cisauk	280300
280325	3	ID	Kec. Kemeri	280300
280326	3	ID	Kec. Sukadiri	280300
280333	3	ID	Kec. Sukamulya	280300
280334	3	ID	Kec. Kelapa Dua	280300
280335	3	ID	Kec. Sindang Jaya	280300
280336	3	ID	Kec. Sepatan Timur	280300
280337	3	ID	Kec. Solear	280300
280338	3	ID	Kec. Gunung Kaler	280300
280339	3	ID	Kec. Mekar Baru	280300
280400	2	ID	Kab. Serang	280000
280401	3	ID	Kec. Cinangka	280400
280402	3	ID	Kec. Padarincang	280400
280403	3	ID	Kec. Ciomas	280400
280404	3	ID	Kec. Pabuaran	280400
280405	3	ID	Kec. Baros	280400
280406	3	ID	Kec. Petir	280400
280408	3	ID	Kec. Cikeusal	280400
280409	3	ID	Kec. Pamarayan	280400
280410	3	ID	Kec. Jawilan	280400
280411	3	ID	Kec. Kopo	280400
280412	3	ID	Kec. Cikande	280400
280413	3	ID	Kec. Kragilan	280400
280416	3	ID	Kec. Serang	280400
280418	3	ID	Kec. Waringinkurung	280400
280419	3	ID	Kec. Mancak	280400
280420	3	ID	Kec. Anyar	280400
280421	3	ID	Kec. Bojonegara	280400
280422	3	ID	Kec. Kramatwatu	280400
280424	3	ID	Kec. Ciruas	280400
280425	3	ID	Kec. Pontang	280400
280426	3	ID	Kec. Carenang	280400
280427	3	ID	Kec. Tirtayasa	280400
280428	3	ID	Kec. Tunjung Teja	280400
280429	3	ID	Kec. Kibin	280400
280430	3	ID	Kec. Pulo Ampel	280400
280431	3	ID	Kec. Binuang	280400
280432	3	ID	Kec. Tanara	280400
280433	3	ID	Kec. Gunung Sari	280400
280434	3	ID	Kec. Bandung	280400
286000	2	ID	Kota Cilegon	280000
286001	3	ID	Kec. Ciwandan	286000
286002	3	ID	Kec. Pulomerak	286000
286003	3	ID	Kec. Cilegon	286000
286004	3	ID	Kec. Cibeber	286000
286005	3	ID	Kec. Gerogol	286000
286006	3	ID	Kec. Purwakarta	286000
286007	3	ID	Kec. Jombang	286000
286008	3	ID	Kec. Citangkil	286000
286100	2	ID	Kota Tangerang	280000
286101	3	ID	Kec. Ciledug	286100
286102	3	ID	Kec. Cipondoh	286100
286103	3	ID	Kec. Tangerang	286100
286104	3	ID	Kec. Jati uwung	286100
286105	3	ID	Kec. Batuceper	286100
286106	3	ID	Kec. Benda	286100
286107	3	ID	Kec. Larangan	286100
286108	3	ID	Kec. Karang Tengah	286100
286109	3	ID	Kec. Pinang	286100
286110	3	ID	Kec. Karawaci	286100
286111	3	ID	Kec. Cibodas	286100
286112	3	ID	Kec. Periuk	286100
286113	3	ID	Kec. Neglasari	286100
286200	2	ID	Kota Serang	280000
286201	3	ID	Kec. Cipocok Jaya	286200
286202	3	ID	Kec. Curug	286200
286203	3	ID	Kec. Kasemen	286200
286205	3	ID	Kec. Taktakan	286200
286206	3	ID	Kec. Walantaka	286200
286300	2	ID	Kota tangerang Selatan	280000
286301	3	ID	Kec. Ciputat	286300
286302	3	ID	Kec. Ciputat Timur	286300
286303	3	ID	Kec. Pamulang	286300
286304	3	ID	Kec. Pondok Aren	286300
286305	3	ID	Kec. Serpong	286300
286306	3	ID	Kec. Serpong Utara	286300
286307	3	ID	Kec. Setu	286300
290000	1	ID	Prov. Bangka Belitung	000000
290100	2	ID	Kab. Bangka	290000
290107	3	ID	Kec. Mendo Barat	290100
290108	3	ID	Kec. Merawang	290100
290109	3	ID	Kec. Sungai Liat	290100
290113	3	ID	Kec. Belinyu	290100
290114	3	ID	Kec. Puding Besar	290100
290115	3	ID	Kec. Bakam	290100
290116	3	ID	Kec. Pemali	290100
290117	3	ID	Kec. Riau Silip	290100
290200	2	ID	Kab. Belitung	290000
290201	3	ID	Kec. Membalong	290200
290206	3	ID	Kec. Tanjung Pandan	290200
290207	3	ID	Kec. Sijuk	290200
290208	3	ID	Kec. Badau	290200
290209	3	ID	Kec. Selat Nasik	290200
290225	3	ID	Kec. Air Gegas	290200
290300	2	ID	Kab. Bangka Tengah	290000
290301	3	ID	Kec. Koba	290300
290302	3	ID	Kec. Pangkalan Baru	290300
290303	3	ID	Kec. Sungai Selan	290300
290304	3	ID	Kec. Simpang Katis	290300
290305	3	ID	Kec. Lubuk Besar	290300
290306	3	ID	Kec. Namang	290300
290400	2	ID	Kab. Bangka Barat	290000
290401	3	ID	Kec. Kelapa	290400
290402	3	ID	Kec. Tempilang	290400
290403	3	ID	Kec. Mentok	290400
290404	3	ID	Kec. Simpang Teritip	290400
290405	3	ID	Kec. Jebus	290400
290406	3	ID	Kec. Parittiga	290400
290500	2	ID	Kab. Bangka Selatan	290000
290501	3	ID	Kec. Payung	290500
290502	3	ID	Kec. Simpang Rimba	290500
290503	3	ID	Kec. Toboali	290500
290505	3	ID	Kec. Lepar Pongok	290500
290506	3	ID	Kec. Pulau Besar	290500
290507	3	ID	Kec. Tukak Sadai	290500
290508	3	ID	Air Gegas	      
290600	2	ID	Kab. Belitung Timur	290000
290601	3	ID	Kec. Dendang	290600
290602	3	ID	Kec. Gantung	290600
290603	3	ID	Kec. Manggar	290600
290604	3	ID	Kec. Kelapa Kampit	290600
290605	3	ID	Kec. Damar	290600
290606	3	ID	Kec. Simpang Renggiang	290600
290607	3	ID	Kec. Simpang Pesak	290600
296000	2	ID	Kota Pangkalpinang	290000
296001	3	ID	Kec. Rangkui	296000
296002	3	ID	Kec. Bukit Intan	296000
296003	3	ID	Kec. Pangkal Balam	296000
296004	3	ID	Kec. Taman Sari	296000
296005	3	ID	Kec. Gerunggang	296000
296090	3	ID	Girimaya	      
300000	1	ID	Prov. Gorontalo	000000
300100	2	ID	Kab. Boalemo	300000
300104	3	ID	Kec. Tilamuta	300100
300106	3	ID	Kec. Paguyaman	300100
300107	3	ID	Kec. Mananggu	300100
300108	3	ID	Kec. Dulupi	300100
300109	3	ID	Kec. Wonosari	300100
300110	3	ID	Kec. Botumoita	300100
300111	3	ID	Kec. Paguyaman Pantai	300100
300200	2	ID	Kab. Gorontalo	300000
300201	3	ID	Kec. Batudaa Pantai	300200
300202	3	ID	Kec. Batudaa	300200
300203	3	ID	Kec. Tibawa	300200
300204	3	ID	Kec. Boliyohuto	300200
300207	3	ID	Kec. Limboto	300200
300208	3	ID	Kec. Telaga	300200
300210	3	ID	Kec. Bongomeme	300200
300211	3	ID	Kec. Pulubala	300200
300215	3	ID	Kec. Tolangohula	300200
300216	3	ID	Kec. Mootilango	300200
300218	3	ID	Kec. Telaga Biru	300200
300219	3	ID	Kec. Limboto Barat	300200
300220	3	ID	Kec. Biluhu	300200
300221	3	ID	Kec. Tabongo	300200
300222	3	ID	Kec. Asparaga	300200
300223	3	ID	Kec. Tilango	300200
300224	3	ID	Kec. Telaga Jaya	300200
300225	3	ID	Kec. Bilato	300200
300226	3	ID	Bilato	      
300300	2	ID	Kab. Pohuwato	300000
300301	3	ID	Kec. Popayato	300300
300302	3	ID	Kec. Marisa	300300
300303	3	ID	Kec. Paguat	300300
300304	3	ID	Kec. Lemito	300300
300305	3	ID	Kec. Randangan	300300
300306	3	ID	Kec. Patilanggio	300300
300307	3	ID	Kec. Taluditi	300300
300308	3	ID	Kec. Popayato Barat	300300
300309	3	ID	Kec. Popayato Timur	300300
300310	3	ID	Kec. Wanggarasi	300300
300311	3	ID	Kec. Buntulia	300300
300312	3	ID	Kec. Duhiadaa	300300
300313	3	ID	Kec. Dengilo	300300
300400	2	ID	Kab. Bone Bolango	300000
300401	3	ID	Kec. Tapa	300400
300402	3	ID	Kec. Kabila	300400
300403	3	ID	Kec. Suwawa	300400
300404	3	ID	Kec. Bonepantai	300400
300405	3	ID	Kec. Bulango Utara	300400
300406	3	ID	Kec. Tilongkabila	300400
300407	3	ID	Kec. Botupingge	300400
300408	3	ID	Kec. Kabila Bone	300400
300409	3	ID	Kec. Bone	300400
300410	3	ID	Kec. Bone Raya	300400
300411	3	ID	Kec. Bulango Selatan	300400
300412	3	ID	Kec. Bulango Timur	300400
300413	3	ID	Kec. Bulango Ulu	300400
300414	3	ID	Kec. Suwawa Selatan	300400
300415	3	ID	Kec. Suwawa Timur	300400
300416	3	ID	Kec. Suwawa Tengah	300400
300417	3	ID	Kec. Bulawa	300400
300500	2	ID	Kab. Gorontalo Utara	300000
300501	3	ID	Kec. Anggrek	300500
300502	3	ID	Kec. Atinggola	300500
300503	3	ID	Kec. Kwandang	300500
300504	3	ID	Kec. Sumalata	300500
300505	3	ID	Kec. Tolinggula	300500
300506	3	ID	Kec. Gentuma Raya	300500
300507	3	ID	Tomilito	      
300508	3	ID	Ponelo Kepulauan	      
300509	3	ID	Monano	      
300511	3	ID	Biau	      
306000	2	ID	Kota Gorontalo	300000
306001	3	ID	Kec. Kota Barat	306000
306002	3	ID	Kec. Kota Selatan	306000
306003	3	ID	Kec. Kota Utara	306000
306004	3	ID	Kec. Kota Timur	306000
306005	3	ID	Kec. Dungingi	306000
306006	3	ID	Kec. Kota Tengah	306000
306007	3	ID	Kec. Sipatana	306000
306008	3	ID	Kec. Dumbo Raya	306000
306009	3	ID	Kec. Hulonthalangi	306000
310000	1	ID	Prov. Kepulauan Riau	000000
310100	2	ID	Kab. Bintan	310000
310101	3	ID	Kec. Bintan Utara	310100
310102	3	ID	Kec. Gunung Kijang	310100
310103	3	ID	Kec. Tambelan	310100
310104	3	ID	Kec. Teluk Bintan	310100
310105	3	ID	Kec. Teluk Sebong	310100
310106	3	ID	Kec. Toapaya	310100
310107	3	ID	Kec. Mantang	310100
310108	3	ID	Kec. Bintan Pesisir	310100
310109	3	ID	Kec. Seri Kuala Loban	310100
310110	3	ID	Kec. Bintan Timur	310100
310200	2	ID	Kab. Karimun	310000
310201	3	ID	Kec. Moro	310200
310202	3	ID	Kec. Kundur	310200
310203	3	ID	Kec. Karimun	310200
310204	3	ID	Kec. Meral	310200
310205	3	ID	Kec. Tebing	310200
310206	3	ID	Kec. Buru	310200
310207	3	ID	Kec. Kundur Utara	310200
310208	3	ID	Kec. Kundur Barat	310200
310209	3	ID	Kec. Durai	310200
310300	2	ID	Kab. Natuna	310000
310303	3	ID	Kec. Midai	310300
310304	3	ID	Kec. Bunguran Barat	310300
310305	3	ID	Kec. Bunguran Timur	310300
310306	3	ID	Kec. Serasan	310300
310309	3	ID	Kec. Subi	310300
310311	3	ID	Kec. Bunguran Utara	310300
310312	3	ID	Kec. Pulau Laut	310300
310313	3	ID	Kec. Pulau Tiga	310300
310317	3	ID	Kec. Bunguran Timur Laut	310300
310318	3	ID	Kec. Bunguran Tengah	310300
310320	3	ID	Kec. Bunguran Selatan	310300
310321	3	ID	Kec. Serasan Timur	310300
310400	2	ID	Kab. Lingga	310000
310401	3	ID	Kec. Singkep	310400
310402	3	ID	Kec. Lingga	310400
310403	3	ID	Kec. Senayang	310400
310404	3	ID	Kec. Singkep Barat	310400
310405	3	ID	Kec. Lingga Utara	310400
310500	2	ID	Kab. Kepulauan Anambas	310000
310501	3	ID	Kec. Jemaja	310500
310502	3	ID	Kec. Jemaja Timur	310500
310503	3	ID	Kec. Siantan	310500
310504	3	ID	Kec. Palmatak	310500
310505	3	ID	Kec. Siantan Selatan	310500
310506	3	ID	Kec. Siantan Timur	310500
310507	3	ID	Kec. Siantan Tengah	310500
316000	2	ID	Kota Batam	310000
316001	3	ID	Kec. Belakang Padang	316000
316002	3	ID	Kec. Sekupang	316000
316003	3	ID	Kec. Sei Beduk	316000
316004	3	ID	Kec. Bulang	316000
316005	3	ID	Kec. Lubuk Baja	316000
316006	3	ID	Kec. Batu Ampar	316000
316007	3	ID	Kec. Nongsa	316000
316008	3	ID	Kec. Galang	316000
316011	3	ID	Kec. Bengkong	316000
316012	3	ID	Kec. Batam Kota	316000
316013	3	ID	Kec. Sagulung	316000
316014	3	ID	Kec. Batu Aji	316000
316100	2	ID	Kota Tanjungpinang	310000
316101	3	ID	Kec. Tanjung Pinang Barat	316100
316102	3	ID	Kec. Tanjung Pinang Timur	316100
316103	3	ID	Kec. Bukit Bestari	316100
316104	3	ID	Kec. Tanjung Pinang Kota	316100
320000	1	ID	Prov. Papua Barat	000000
320100	2	ID	Kab. Fak-Fak	320000
320101	3	ID	Kec.  Fak-Fak Timur	320100
320102	3	ID	Kec.  Karas	320100
320103	3	ID	Kec.  Fak-Fak	320100
320104	3	ID	Kec.  Fak-Fak Tengah	320100
320105	3	ID	Kec.  Fak-Fak Barat	320100
320106	3	ID	Kec.  Kokas	320100
320107	3	ID	Kec.  Teluk Patipi	320100
320108	3	ID	Kec.  Kramongmongga	320100
320109	3	ID	Kec.  Bomberay	320100
320200	2	ID	Kab. Kaimana	320000
320201	3	ID	Kec.  Buruway	320200
320202	3	ID	Kec.  Teluk Arguni (Atas)	320200
320203	3	ID	Kec.  Teluk Arguni Bawah	320200
320204	3	ID	Kec.  Kaimana	320200
320205	3	ID	Kec.  Kambrau	320200
320206	3	ID	Kec.  Teluk Etna	320200
320207	3	ID	Kec.  Yamor	320200
320300	2	ID	Kab. Teluk Wondama	320000
320301	3	ID	Kec.  Naikere	320300
320302	3	ID	Kec.  Wondiboy	320300
320303	3	ID	Kec.  Rasiei	320300
320304	3	ID	Kec.  Kuri Wamesa	320300
320305	3	ID	Kec.  Wasior	320300
320306	3	ID	Kec.  Teluk Duairi	320300
320307	3	ID	Kec.  Roon	320300
320308	3	ID	Kec.  Windesi	320300
320309	3	ID	Kec.  Wamesa	320300
320310	3	ID	Kec.  Roswar	320300
320311	3	ID	Kec.  Rumberpon	320300
320312	3	ID	Kec.  Soug Jaya	320300
320313	3	ID	Kec.  Nikiwar	320300
320390	3	ID	Sough Wepu	      
320400	2	ID	Kab. Teluk Bintuni	320000
320401	3	ID	Kec. Irorutu/Fafuwar	320400
320402	3	ID	Kec. Babo	320400
320403	3	ID	Kec. Sumuri	320400
320404	3	ID	Kec. Aroba	320400
320405	3	ID	Kec. Kaitaro	320400
320406	3	ID	Kec. Kuri	320400
320407	3	ID	Kec. Idoor	320400
320408	3	ID	Kec. Bintuni	320400
320409	3	ID	Kec. Manimeri	320400
320410	3	ID	Kec. Tuhiba	320400
320411	3	ID	Kec. Dataran Beimes	320400
320412	3	ID	Kec. Tembuni	320400
320413	3	ID	Kec. Aranday	320400
320414	3	ID	Kec. Komundan	320400
320415	3	ID	Kec. Tomu	320400
320416	3	ID	Kec. Weriagar	320400
320417	3	ID	Kec. Moskona Selatan	320400
320418	3	ID	Kec. Meyado	320400
320419	3	ID	Kec. Moskona Barat	320400
320420	3	ID	Kec. Merdey	320400
320421	3	ID	Kec. Biscoop	320400
320422	3	ID	Kec. Masyeta	320400
320423	3	ID	Kec. Moskona Utara	320400
320424	3	ID	Kec. Moskona Timur	320400
320425	3	ID	Wamesa	      
320500	2	ID	Kab. Manokwari	320000
320501	3	ID	Kec. Ransiki	320500
320502	3	ID	Kec. Momi Waren	320500
320503	3	ID	Kec. Nenei	320500
320504	3	ID	Kec. Sururay	320500
320505	3	ID	Kec. Anggi	320500
320506	3	ID	Kec. Taige	320500
320507	3	ID	Kec. Membey	320500
320508	3	ID	Kec. Oransbari	320500
320509	3	ID	Kec. Warmare	320500
320510	3	ID	Kec. Prafi	320500
320511	3	ID	Kec. Menyambouw	320500
320512	3	ID	Kec. Catubouw	320500
320513	3	ID	Kec. Manokwari Barat	320500
320514	3	ID	Kec. Manokwari Timur	320500
320515	3	ID	Kec. Manokwari Utara	320500
320516	3	ID	Kec. Manokwari Selatan	320500
320517	3	ID	Kec. Testega	320500
320518	3	ID	Kec. Tanah Rubu	320500
320519	3	ID	Kec. Kebar	320500
320520	3	ID	Kec. Senopi	320500
320521	3	ID	Kec. Amberbaken	320500
320522	3	ID	Kec. Murbani/Arfu	320500
320523	3	ID	Kec. Masni	320500
320524	3	ID	Kec. Sidey	320500
320525	3	ID	Kec. Tahosta	320500
320526	3	ID	Kec. Didohu	320500
320527	3	ID	Kec. Dataran Isim	320500
320528	3	ID	Kec. Anggi Gida	320500
320529	3	ID	Kec. Hingk	320500
320530	3	ID	Neney	      
320531	3	ID	Momi - Waren	      
320532	3	ID	Tohota	      
320533	3	ID	Taige	      
320534	3	ID	Membey	      
320535	3	ID	Anggi Gida	      
320536	3	ID	Didohu	      
320537	3	ID	Dataran Isim	      
320538	3	ID	Catubouw	      
320539	3	ID	Hink	      
320590	3	ID	Ransiki	      
320600	2	ID	Kab. Sorong Selatan	320000
320601	3	ID	Kec.  Inanwatan	320600
320602	3	ID	Kec. Kokoda	320600
320603	3	ID	Kec. Metemeini Kais	320600
320608	3	ID	Kec. Moswaren	320600
320610	3	ID	Kec. Seremuk	320600
320611	3	ID	Kec. Wayer	320600
320612	3	ID	Kec. Sawiat	320600
320616	3	ID	Kec.  Kais	320600
320617	3	ID	Kec.  Konda	320600
320618	3	ID	Kec.  Kokoda Utara	320600
320619	3	ID	Kec.  Saifi	320600
320620	3	ID	Kec.  Fokour	320600
320621	3	ID	Kec.  Teminabuan	320600
320700	2	ID	Kab. Sorong	320000
320705	3	ID	Kec. Moraid	320700
320706	3	ID	Kec. Makbon	320700
320707	3	ID	Kec. Beraur	320700
320708	3	ID	Kec. Klamono	320700
320709	3	ID	Kec. Salawati	320700
320710	3	ID	Kec. Manyamuk	320700
320711	3	ID	Kec. Seget	320700
320712	3	ID	Kec. Segun	320700
320713	3	ID	Kec. Salawati Selatan	320700
320714	3	ID	Kec. Aimas	320700
320715	3	ID	Kec. Sayosa	320700
320716	3	ID	Kec.  Klabot	320700
320717	3	ID	Kec.  Klawak	320700
320718	3	ID	Kec.  Maudus	320700
320719	3	ID	Kec.  Mariat	320700
320720	3	ID	Kec.  Klayili	320700
320721	3	ID	Kec.  Klaso	320700
320722	3	ID	Kec.  Moisegen	320700
320800	2	ID	Kab. Raja Ampat	320000
320801	3	ID	Kec.  Misool Selatan	320800
320802	3	ID	Kec.  Misool (Misool Utara)	320800
320803	3	ID	Kec.  Kofiau	320800
320804	3	ID	Kec.  Misool Timur	320800
320805	3	ID	Kec.  Salawati Utara	320800
320807	3	ID	Kec.  Waigeo Selatan	320800
320808	3	ID	Kec.  Teluk Mayalibit	320800
320809	3	ID	Kec.  Meos Mansar	320800
320810	3	ID	Kec.  Waigeo Barat	320800
320811	3	ID	Kec.  Waigeo Utara	320800
320812	3	ID	Kec.  Kepulauan Ayau	320800
320813	3	ID	Kec.  Waigeo Timur	320800
320814	3	ID	Kec.  Warwarbomi	320800
320815	3	ID	Kec.  Waigeo Barat Kepulauan	320800
320816	3	ID	Kec.  Misool Barat	320800
320817	3	ID	Kec.  Kepulauan Sembilan	320800
320818	3	ID	Kec.  Kota Waisai	320800
320819	3	ID	Kec.  Tiplol Mayalibit	320800
320820	3	ID	Kec.  Batanta Utara	320800
320821	3	ID	Kec.  Salawati Barat	320800
320822	3	ID	Kec.  Salawati Tengah	320800
320823	3	ID	Kec.  Supnin	320800
320824	3	ID	Kec.  Ayau	320800
320825	3	ID	Kec.  Batanta Selatan	320800
320890	3	ID	Selat Sagawin	      
320900	2	ID	Kab. Tambrauw	320000
320901	3	ID	Kec.  Fef	320900
320902	3	ID	Kec.  Miyah	320900
320903	3	ID	Kec.  Yembun	320900
320904	3	ID	Kec.  Kwoor	320900
320905	3	ID	Kec.  Sausapor	320900
320906	3	ID	Kec.  Abun	320900
321000	2	ID	Kab. Maybrat	320000
321001	3	ID	Kec.  Aifat	321000
321002	3	ID	Kec.  Aifat Utara	321000
321003	3	ID	Kec.  Aifat Timur	321000
321004	3	ID	Kec.  Aifat Selatan	321000
321005	3	ID	Kec.  Aitinyo Barat	321000
321006	3	ID	Kec.  Aitinyo	321000
321007	3	ID	Kec.  Aitinyo Utara	321000
321008	3	ID	Kec.  Ayamaru	321000
321009	3	ID	Kec.  Ayamaru Utara	321000
321010	3	ID	Kec.  Ayamaru Timur	321000
321011	3	ID	Kec.  Mare	321000
321012	3	ID	Aitinyo Tengah	      
321013	3	ID	Aifat Timur Selatan	      
321015	3	ID	Aitinyo Raya	      
321090	3	ID	Ayamaru Timur Selatan	      
321091	3	ID	Aifat Timur Tengah	      
321092	3	ID	Aifat Timur Jauh	      
321099	3	ID	Ayamaru Jaya	      
326000	2	ID	Kota Sorong	320000
326002	3	ID	Kec.  Sorong Timur	326000
326003	3	ID	Kec.  Sorong	326000
326006	3	ID	Kec.  Klablim	326000
326007	3	ID	Kec.  Klawalu	326000
326008	3	ID	Kec.  Giwu	326000
326009	3	ID	Kec.  Klamana	326000
330000	1	ID	Prov. Sulawesi Barat	000000
330100	2	ID	Kab. Mamuju	330000
330101	3	ID	Kec. Tapalang	330100
330102	3	ID	Kec. Mamuju	330100
330103	3	ID	Kec. Kalukku	330100
330104	3	ID	Kec. Kalumpang	330100
330105	3	ID	Kec. Budong-Budong	330100
330106	3	ID	Kec. Tapalang Barat	330100
330107	3	ID	Kec. Papalang	330100
330108	3	ID	Kec. Sampaga	330100
330109	3	ID	Kec. Pangale	330100
330110	3	ID	Kec. Tommo	330100
330111	3	ID	Kec. Bonehau	330100
330112	3	ID	Kec. Topoyo	330100
330113	3	ID	Kec. Tobadak	330100
330114	3	ID	Kec. Karossa	330100
330115	3	ID	Kec. Simboro Kepulauan	330100
330116	3	ID	Kec. Kep. Bala Balakang	330100
330117	3	ID	Topoyo	      
330190	3	ID	Budong-budong	      
330191	3	ID	Pangale	      
330200	2	ID	Kab. Mamuju Utara	330000
330201	3	ID	Kec. Pasangkayu	330200
330202	3	ID	Kec. Sarudu	330200
330203	3	ID	Kec. Baras	330200
330204	3	ID	Kec. Bambalamutu	330200
330205	3	ID	Kec. Dapurang	330200
330206	3	ID	Kec. Duripoku	330200
330207	3	ID	Kec. Bulu Taba	330200
330208	3	ID	Kec. Lariang	330200
330209	3	ID	Kec. Tikke Raya	330200
330210	3	ID	Kec. Pedongga	330200
330211	3	ID	Kec. Bambaira	330200
330212	3	ID	Kec. Sarjo	330200
330292	3	ID	Karossa	      
330293	3	ID	Simboro Dan Kepulauan	      
330294	3	ID	Tobadak	      
330300	2	ID	Kab. Polewali Mamasa	330000
330301	3	ID	Kec. Tinambung	330300
330302	3	ID	Kec. Tutallu	330300
330303	3	ID	Kec. Campalagian	330300
330304	3	ID	Kec. Wonomulyo	330300
330305	3	ID	Kec. Polewali	330300
330306	3	ID	Kec. Limboro	330300
330307	3	ID	Kec. Balanipa	330300
330308	3	ID	Kec. Luyo	330300
330309	3	ID	Kec. Allu	330300
330310	3	ID	Kec. Mapili	330300
330311	3	ID	Kec. Matakali	330300
330312	3	ID	Kec. Binuang	330300
330313	3	ID	Kec. Anreapi	330300
330314	3	ID	Kec. Tapango	330300
330315	3	ID	Kec. Matangnga	330300
330316	3	ID	Kec. Bulo	330300
330317	3	ID	Tutar	      
330400	2	ID	Kab. Mamasa	330000
330401	3	ID	Kec. Sumarorong	330400
330402	3	ID	Kec. Pana	330400
330403	3	ID	Kec. Mamasa	330400
330404	3	ID	Kec. Mambi	330400
330405	3	ID	Kec. Tabulahan	330400
330406	3	ID	Kec. Tabang	330400
330407	3	ID	Kec. Messawa	330400
330408	3	ID	Kec. Sesenapadang	330400
330409	3	ID	Kec. Tandukalua	330400
330410	3	ID	Kec. Aralle	330400
330411	3	ID	Kec. Nosu	330400
330412	3	ID	Kec. Bambang	330400
330413	3	ID	Kec. Balla	330400
330414	3	ID	Kec. Tawalian	330400
330415	3	ID	Kec. Rantebulahan Timur	330400
330416	3	ID	Kec. Buntumalangka	330400
330417	3	ID	Kec. Mehalaan	330400
330500	2	ID	Kab. Majene	330000
330502	3	ID	Kec. Pamboang	330500
330505	3	ID	Kec. Ulumunda	330500
330506	3	ID	Kec. Tammerodo Sendana	330500
330507	3	ID	Kec. Tubo Sendana	330500
330509	3	ID	Kec. Banggai	330500
330510	3	ID	Kec. Sendana	330500
330511	3	ID	Kec. Malunda	330500
330512	3	ID	Kec. Banggai Timur	330500
340000	1	ID	Prov. Kalimantan Utara	000000
340001	3	ID	Tanjung Palas Utara	      
340002	3	ID	Peso Ilir	      
340003	3	ID	Tanjung Palas	      
340004	3	ID	Tanjung Palas Barat	      
340005	3	ID	Tanjung Selor	      
340006	3	ID	Peso	      
340007	3	ID	Tanjung Palas Tengah	      
340008	3	ID	Bunyu	      
340009	3	ID	Tanjung Palas Timur	      
340010	3	ID	Sekatak	      
340100	2	ID	Kab. Malinau	340000
340101	3	ID	Tarakan Utara	      
340102	3	ID	Tarakan Tengah	      
340103	3	ID	Tarakan Timur	      
340104	3	ID	Tarakan Barat	      
340200	2	ID	Kab. Bulungan	340000
340300	2	ID	Kab. Tana Tidung	340000
340500	2	ID	Kab. Nunukan	340000
346000	2	ID	Kota Tarakan	340000
999999	3	ID	tidak ada	      
021438	3	ID	Kec. Banjaranyar	021400
022228	3	ID	Kec. Tarumajaya	022200
022316	3	ID	Kec. Saguling	022300
022500	2	ID	Kab. Pangandaran	020000
022551	3	ID	Kec. Cijulang	022500
022552	3	ID	Kec. Cimerak	022500
022553	3	ID	Kec. Cigugur	022500
022554	3	ID	Kec. Langkaplancar	022500
022555	3	ID	Kec. Mangunjaya	022500
022556	3	ID	Kec. Padaherang	022500
022557	3	ID	Kec. Kalipucang	022500
022558	3	ID	Kec. Pangandaran	022500
022559	3	ID	Kec. Sidamulih	022500
022560	3	ID	Kec. Parigi	022500
040218	3	ID	Kec. Gamping	040200
046015	3	ID	Kec. Gamping	046000
050528	3	ID	Kec. Gayam	050500
052525	3	ID	Kec. Blimbingsari	052500
056403	3	ID	Kec. Kranggan	056400
061109	3	ID	Kec. Teupah Tengah	061100
061110	3	ID	Kec. Simeulue Cut	061100
061510	3	ID	Kec. Beutong Ateuh Banggalan	061500
071518	3	ID	Kec. Ranto Baek	071500
071519	3	ID	Kec. Puncak Sorik Merapi	071500
071520	3	ID	Kec. Sinunukan	071500
071521	3	ID	Kec. Huta Bargot	071500
071522	3	ID	Kec. Pakantan	071500
071523	3	ID	Kec. Naga Juang	071500
071719	3	ID	Kec. Ulunoyo	071700
071720	3	ID	Kec. Huruna	071700
071721	3	ID	Kec. Oou	071700
071722	3	ID	Kec. Onohazumba	071700
071723	3	ID	Kec. Hilisalawaahe	071700
071724	3	ID	Kec. Ulususua	071700
071725	3	ID	Kec. Siduaori	071700
071726	3	ID	Kec. Somambawa	071700
071727	3	ID	Kec. Boronadu	071700
071728	3	ID	Kec. Ulu Idanotae	071700
071729	3	ID	Kec. Idanotae	071700
071730	3	ID	Kec. Luahagundre Maniamolo	071700
071731	3	ID	Kec. Onolalu	071700
071732	3	ID	Kec. Pulau-Pulau Batu Utara	071700
071733	3	ID	Kec. Pulau-Pulau Batu Barat	071700
071734	3	ID	Kec. Simuk	071700
071735	3	ID	Kec. Tanah Masa	071700
071736	3	ID	Kec. Onolalu	071700
071737	3	ID	Kec. Luahagundre Maniamolo	071700
072412	3	ID	Kec. Sihapas Barumun	072400
072709	3	ID	Kec. Mandrehe Utara	072700
076022	3	ID	Kec. Medan Utara	076000
080613	3	ID	Kec. Silaut	080600
080614	3	ID	Kec. Ranah Ampek Hulu Tapan	080600
080615	3	ID	Kec. Air Pura	080600
080616	3	ID	Kec. Air Pura	080600
080617	3	ID	Kec. Iv Nagari Bayang Utara	080600
091014	3	ID	Kec. Pekaitan	091000
091015	3	ID	Kec. Kubu Babussalam	091000
091016	3	ID	Kec. Bagan Sinembah Jaya	091000
091017	3	ID	Kec. Balai Jaya	091000
091018	3	ID	Kec. Tanjung Medan	091000
091413	3	ID	Kec. Kuantan Hilir Seberang	091400
091414	3	ID	Kec. Sentajo Raya	091400
091415	3	ID	Kec. Pucuk Rantau	091400
100518	3	ID	Kec. Bukit Kerman	100500
100519	3	ID	Kec. Air Hangat Barat	100500
100520	3	ID	Kec. Siulak Mukai	100500
100521	3	ID	Kec. Kayu Aro Barat	100500
100709	3	ID	Kec. Bahar Utara	100700
100710	3	ID	Kec. Bahar Selatan	100700
100711	3	ID	Kec. Taman Rajo	100700
106009	3	ID	Kec. Alam Barajo	106000
106010	3	ID	Kec. Danau Sipin	106000
106011	3	ID	Kec. Paal Merah	106000
106106	3	ID	Kec. Pondok Tinggi	106100
106107	3	ID	Kec. Koto Baru	106100
106108	3	ID	Kec. Sungai Bungkal	106100
110432	3	ID	Kec. Lubai Ulu	110400
110433	3	ID	Kec. Belimbing	110400
110434	3	ID	Kec. Belimbing	110400
110435	3	ID	Kec. Belida Darat	110400
110436	3	ID	Kec. Belida Barat	110400
110437	3	ID	Kec. Lubai Ulu	110400
110534	3	ID	Kec. Sukamerindu	110500
110535	3	ID	Kec. Sukamerindu	110500
110719	3	ID	Kec. Sumber Marga Telang	110700
110720	3	ID	Kec. Air Kumbang	110700
111109	3	ID	Kec. Saling	111100
111110	3	ID	Kec. Pendopo Barat	111100
111200	2	ID	Kab. Penukal Abab Lematang Ilir	110000
111221	3	ID	Kec. Penukal Utara	111200
111223	3	ID	Kec. Abab	111200
111224	3	ID	Kec. Tanah Abang	111200
111225	3	ID	Kec. Talang Ubi	111200
111226	3	ID	Kec. Penukal	111200
111300	2	ID	Kab. Musi Rawas Utara	110000
111301	3	ID	Kec. Rupit	111300
111302	3	ID	Kec. Rawas Ulu	111300
111303	3	ID	Kec. Nibung	111300
111304	3	ID	Kec. Rawas Iilir	111300
111305	3	ID	Kec. Karang Dapo	111300
111306	3	ID	Kec. Karang Jaya	111300
111307	3	ID	Kec. Ulu Rawas	111300
120492	3	ID	Kec. Kebun Tebu	120400
120493	3	ID	Kec. Air Hitam	120400
120494	3	ID	Kec. Batu Ketulis	120400
120495	3	ID	Kec. Bandar Negeri Suoh	120400
120496	3	ID	Kec. Way Krui	120400
120497	3	ID	Kec. Krui Selatan	120400
120498	3	ID	Kec. Pulau Pisang	120400
120499	3	ID	Kec. Pagar Dewa	120400
120908	3	ID	Kec. Marga Punduh	120900
120909	3	ID	Kec. Way Khilau	120900
120910	3	ID	Kec. Teluk Pandan	120900
120911	3	ID	Kec. Way Ratai	120900
121009	3	ID	Kec. Pagelaran Utara	121000
121300	2	ID	Kab. Pesisir Barat	120000
121301	3	ID	Kec. Bangkunat	121300
121331	3	ID	Kec. Pesisir Selatan	121300
121332	3	ID	Kec. Ngambur	121300
121333	3	ID	Kec. Lemong	121300
121334	3	ID	Kec. Ngaras	121300
121335	3	ID	Kec. Karyapenggawa	121300
121336	3	ID	Kec. Pesisir Tengah	121300
121337	3	ID	Kec. Pesisir Utara	121300
121338	3	ID	Kec. Krui Selatan	121300
121339	3	ID	Kec. Pulau Pisang	121300
121340	3	ID	Kec. Way Krui	121300
126014	3	ID	Kec. Labuhan Ratu	126000
126015	3	ID	Kec. Way Halim	126000
126016	3	ID	Kec. Kedamaian	126000
126017	3	ID	Kec. Enggal	126000
126018	3	ID	Kec. Langkapura	126000
126019	3	ID	Kec. Bumi Waras	126000
126020	3	ID	Kec. Teluk Betung Timur	126000
131206	3	ID	Kec. Kepulauan Karimata	131200
140119	3	ID	Kec. Bataguh	140100
140120	3	ID	Kec. Dadahup	140100
140121	3	ID	Kec. Tamban Catur	140100
140122	3	ID	Kec. Pasak Talawang	140100
140123	3	ID	Kec. Mandau Talawang	140100
141012	3	ID	Kec. Rungan Barat	141000
150923	3	ID	Kec. Pulau Laut Tanjung Selayar	150900
161200	2	ID	Kab. Mahakam Ulu	160000
161221	3	ID	Kec. Long Hubung	161200
161222	3	ID	Kec. Laham	161200
161223	3	ID	Kec. Long Apari	161200
161224	3	ID	Kec. Long Pahangai	161200
161225	3	ID	Kec. Long Bagun	161200
166106	3	ID	Kec. Balikpapan Kota	166100
170134	3	ID	Kec. Dumoga	170100
170135	3	ID	Kec. Dumoga Tenggara	170100
170136	3	ID	Kec. Dumoga Tengah	170100
170240	3	ID	Kec. Kakas Barat	170200
170241	3	ID	Kec. Kawangkoan Utara	170200
170242	3	ID	Kec. Tombariri Timur	170200
170243	3	ID	Kec. Kawangkoan Barat	170200
170244	3	ID	Kec. Mandolang	170200
170245	3	ID	Kec. Tompaso Barat	170200
170531	3	ID	Kec. Suluun Tareran	170500
171206	3	ID	Kec. Helumo	171200
176010	3	ID	Kec. Paal Dua	176000
176011	3	ID	Kec. Bunaken Kepulauan	176000
180414	3	ID	Kec. Moilong	180400
180415	3	ID	Kec. Batui Selatan	180400
180416	3	ID	Kec. Luwuk Utara	180400
180417	3	ID	Kec. Luwuk Selatan	180400
180418	3	ID	Kec. Nambo	180400
180419	3	ID	Kec. Mantoh	180400
180420	3	ID	Kec. Balantak Utara	180400
180421	3	ID	Kec. Balantak Selatan	180400
180422	3	ID	Kec. Lobu	180400
180423	3	ID	Kec. Simpang Raya	180400
180714	3	ID	Kec. Petasia Barat	180700
180715	3	ID	Kec. Bungku Timur	180700
180716	3	ID	Kec. Bungku Pesisir	180700
180717	3	ID	Kec. Lembo Raya	180700
180718	3	ID	Kec. Mori Utara	180700
180719	3	ID	Kec. Petasia Timur	180700
180893	3	ID	Kec. Sidoan	180800
180910	3	ID	Kec. Ratolindo	180900
180911	3	ID	Kec. Batudaka	180900
180912	3	ID	Kec. Talatako	180900
181100	2	ID	Kab. Banggai Laut	180000
181112	3	ID	Kec. Bokan Kepulauan	181100
181113	3	ID	Kec. Bangkurung	181100
181114	3	ID	Kec. Labobo	181100
181115	3	ID	Kec. Banggai Selatan	181100
181116	3	ID	Kec. Banggai Tengah	181100
181117	3	ID	Kec. Banggai	181100
181118	3	ID	Kec. Banggai Utara	181100
181119	3	ID	Kec. Banggai	181100
181120	3	ID	Kec. Banggai Utara	181100
181200	2	ID	Kab. Morowali Utara	180000
181201	3	ID	Kec. Bungku Utara	181200
181202	3	ID	Kec. Lembo	181200
181203	3	ID	Kec. Lembo Raya	181200
181204	3	ID	Kec. Mamosalato	181200
181205	3	ID	Kec. Mori Atas	181200
181206	3	ID	Kec. Mori Utara	181200
181207	3	ID	Kec. Petasia	181200
181208	3	ID	Kec. Petasia Timur	181200
181209	3	ID	Kec. Soyo Jaya	181200
181210	3	ID	Kec. Petasia Barat	181200
186005	3	ID	Kec. Ulujadi	186000
186006	3	ID	Kec. Tatanga	186000
186007	3	ID	Kec. Tawaeli	186000
186008	3	ID	Kec. Mantikulore	186000
191391	3	ID	Kec. Pasimasunggu	191300
191392	3	ID	Kec. Pasimasunggu	191300
191393	3	ID	Kec. Pasimasunggu	191300
191394	3	ID	Kec. Pasimasunggu	191300
191722	3	ID	Kec. Bassesangtempe Utara	191700
200149	3	ID	Kec. Anggalomoare	200100
200150	3	ID	Kec. Morosi	200100
200151	3	ID	Kec. Wonggeduku Barat	200100
200152	3	ID	Kec. Padangguni	200100
200153	3	ID	Kec. Tongauna Utara	200100
200154	3	ID	Kec. Anggotoa	200100
200244	3	ID	Kec. Kusambi	200200
200430	3	ID	Kec. Iwoimendaa	200400
200911	3	ID	Kec. Landawe	200900
200912	3	ID	Kec. Lasolo Kepulauan	200900
200913	3	ID	Kec. Wawolesea	200900
201100	2	ID	Kab. Kolaka Timur	200000
201112	3	ID	Kec. Ladongi	201100
201113	3	ID	Kec. Poli-Polia	201100
201114	3	ID	Kec. Lambandia	201100
201116	3	ID	Kec. Mowewe	201100
201117	3	ID	Kec. Uluiwoi	201100
201118	3	ID	Kec. Tinondo	201100
201119	3	ID	Kec. Tirawuta	201100
201120	3	ID	Kec. Ueesi	201100
201121	3	ID	Kec. Aere	201100
201122	3	ID	Kec. Dangia	201100
201200	2	ID	Kab. Konawe Kepulauan	200000
201201	3	ID	Kec. Wawonii Barat	201200
201202	3	ID	Kec. Wawonii Utara	201200
201203	3	ID	Kec. Wawonii Timur Laut	201200
201204	3	ID	Kec. Wawonii Timur	201200
201205	3	ID	Kec. Wawonii Tenggara	201200
201206	3	ID	Kec. Wawonii Selatan	201200
201207	3	ID	Kec. Wawonii Tengah	201200
201300	2	ID	Kab. Muna Barat	200000
201301	3	ID	Kec. Sawerigadi	201300
201302	3	ID	Kec. Barangka	201300
201303	3	ID	Kec. Lawa	201300
201304	3	ID	Kec. Wadaga	201300
201305	3	ID	Kec. Tiworo Selatan	201300
201306	3	ID	Kec. Maginti	201300
201307	3	ID	Kec. Tiworo Tengah	201300
201308	3	ID	Kec. Tiworo Tengah	201300
201309	3	ID	Kec. Tiworo Utara	201300
201310	3	ID	Kec. Tiworo Kepulauan	201300
201311	3	ID	Kec. Napano Kusambi	201300
201312	3	ID	Kec. Kusambi	201300
201400	2	ID	Kab. Buton Selatan	200000
201401	3	ID	Kec. Batauga	201400
201402	3	ID	Kec. Sampolawa	201400
201403	3	ID	Kec. Lapandewa	201400
201404	3	ID	Kec. Batu Atas	201400
201405	3	ID	Kec. Siompu Barat	201400
201406	3	ID	Kec. Siompu	201400
201407	3	ID	Kec. Kadatua	201400
201600	2	ID	Kab. Buton Tengah	200000
201601	3	ID	Kec. Lakudo	201600
201602	3	ID	Kec. Mawasangka Timur	201600
201603	3	ID	Kec. Mawasangka Tengah	201600
201604	3	ID	Kec. Mawasangka	201600
201605	3	ID	Kec.Talaga Raya	201600
201606	3	ID	Kec. Gu	201600
201607	3	ID	Kec. Sangia Wambulu	201600
206108	3	ID	Kec. Batupoaro	206100
210124	3	ID	Kec. Saparua Timur	210100
210214	3	ID	Kec. Manyeuw	210200
210215	3	ID	Kec. Hoat Sorbay	210200
210216	3	ID	Kec. Kei Besar Utara Barat	210200
210217	3	ID	Kec. Kei Besar Selatan Barat	210200
210218	3	ID	Kec. Kei Kecil Timur Selatan	210200
210318	3	ID	Kec. Lolong Guba	210300
210319	3	ID	Kec. Waelata	210300
210320	3	ID	Kec. Fena Leisela	210300
210321	3	ID	Kec. Teluk Kaiely	210300
210322	3	ID	Kec. Lilialy	210300
210506	3	ID	Kec. Amalatu	210500
210607	3	ID	Kec. Siwalalat	210600
210608	3	ID	Kec. Kilmury	210600
210609	3	ID	Kec. Pulau Panjang	210600
210610	3	ID	Kec. Teor	210600
210611	3	ID	Kec. Gorom Timur	210600
210612	3	ID	Kec. Bula Barat	210600
210613	3	ID	Kec. Kian Darat	210600
210614	3	ID	Kec. Siritaun Wida Timur	210600
210615	3	ID	Kec. Teluk Waru	210600
210616	3	ID	Kec. Lian Vitu	210600
210617	3	ID	Kec. Ukar Sengan	210600
210812	3	ID	Kec. Pulau Masela	210800
210813	3	ID	Kec. Dawelor Dawera	210800
210814	3	ID	Kec. Pulau Wetang	210800
210815	3	ID	Kec. Pulau Lakor	210800
210816	3	ID	Kec. Wetar Utara	210800
210817	3	ID	Kec. Wetar Barat	210800
210818	3	ID	Kec. Wetar Timur	210800
210819	3	ID	Kec. Kepulauan Romang	210800
210820	3	ID	Kec. Kisar Utara	210800
210906	3	ID	Kec. Fena Fafan	210900
216105	3	ID	Kec. Kur Selatan	216100
241004	3	ID	Kec. Golewa Barat	241000
241018	3	ID	Kec. Inerie	241000
241019	3	ID	Kec. Golewa Selatan	241000
241121	3	ID	Kec. Reok Barat	241100
241122	3	ID	Kec. Cibal Barat	241100
241123	3	ID	Kec. Landu Leko	241100
241512	3	ID	Kec. Ndao Nuse	241500
241513	3	ID	Kec. Landu Leko	241500
241514	3	ID	Kec. Ndau Nuse	241500
241909	3	ID	Kec. Kota Tambolaka	241900
241910	3	ID	Kec. Wewewa Tengah	241900
241911	3	ID	Kec. Kodi Balaghar	241900
242007	3	ID	Kec. Rana Mese	242000
242008	3	ID	Kec. Poco Ranaka Timur	242000
242009	3	ID	Kec. Elar Selatan	242000
242200	2	ID	Kab. Malaka	240000
242221	3	ID	Kec. Malaka Barat	242200
242222	3	ID	Kec. Wewiku	242200
242223	3	ID	Kec. Weliman	242200
242224	3	ID	Kec. Rinhat	242200
242225	3	ID	Kec. Io Kufeu	242200
242226	3	ID	Kec. Sasitamean	242200
242227	3	ID	Kec. Laenmanen	242200
242228	3	ID	Kec. Malaka Timur	242200
242229	3	ID	Kec. Kobalima Timur	242200
242230	3	ID	Kec. Kobalima	242200
242231	3	ID	Kec. Botin Leobele	242200
242232	3	ID	Kec. Malaka Tengah	242200
250130	3	ID	Kec. Yokari	250100
250131	3	ID	Kec. Ravenirara	250100
250132	3	ID	Kec. Gresi Selatan	250100
250316	3	ID	Kec. Pulau Kurudu	250300
250317	3	ID	Kec. Pulau Yerui	250300
250864	3	ID	Kec. Wesaput	250800
250865	3	ID	Kec. Trikora	250800
250866	3	ID	Kec. Walaik	250800
250867	3	ID	Kec. Wouma	250800
250868	3	ID	Kec. Ibele	250800
250869	3	ID	Kec. Taelarek	250800
250870	3	ID	Kec. Wame	250800
250871	3	ID	Kec. Napua	250800
250872	3	ID	Kec. Hubikiak	250800
250873	3	ID	Kec. Itlay Hisage	250800
250874	3	ID	Kec. Pisugi	250800
250875	3	ID	Kec. Molagalome	250800
250876	3	ID	Kec. Tagineri	250800
250877	3	ID	Kec. Silo Karno Doga	250800
250878	3	ID	Kec. Siepkosi	250800
250879	3	ID	Kec. Usilimo	250800
250880	3	ID	Kec. Libarek	250800
250881	3	ID	Kec. Wadangku	250800
250882	3	ID	Kec. Koragi	250800
250883	3	ID	Kec. Tagime	250800
250884	3	ID	Kec. Piramid	250800
250885	3	ID	Kec. Muliama	250800
250886	3	ID	Kec. Bugi	250800
250887	3	ID	Kec. Bipiri	250800
250888	3	ID	Kec. Welesi	250800
250889	3	ID	Kec. Asotipo	250800
250890	3	ID	Kec. Maima	250800
250891	3	ID	Kec. Wita Waya	250800
250892	3	ID	Kec. Popugoba	250800
250918	3	ID	Kec. Kepulauan Moora	250900
250924	3	ID	Kec. Menou	250900
251020	3	ID	Kec. Weege Bino	251000
251091	3	ID	Kec. Aweida	251000
251092	3	ID	Kec. Baya Biru	251000
251093	3	ID	Kec. Deiyai Miyo	251000
251094	3	ID	Kec. Dogomo	251000
251095	3	ID	Kec. Muye	251000
251096	3	ID	Kec. Nakama	251000
251097	3	ID	Kec. Pugo Dagi	251000
251098	3	ID	Kec. Teluk Deya	251000
251099	3	ID	Kec. Topiyai	251000
251116	3	ID	Kec. Nume	251100
251117	3	ID	Kec. Pagaleme	251100
251118	3	ID	Kec. Gurage	251100
251119	3	ID	Kec. Irimuli	251100
251120	3	ID	Kec. Muara	251100
251121	3	ID	Kec. Ilamburawi	251100
251122	3	ID	Kec. Yambi	251100
251123	3	ID	Kec. Lumo	251100
251124	3	ID	Kec. Molanikime	251100
251125	3	ID	Kec. Dokome	251100
251126	3	ID	Kec. Kalome	251100
251127	3	ID	Kec. Wanwi	251100
251128	3	ID	Kec. Yamoneri	251100
251129	3	ID	Kec. Waegi	251100
251130	3	ID	Kec. Nioga	251100
251131	3	ID	Kec. Gubume	251100
251132	3	ID	Kec. Taganombak	251100
251133	3	ID	Kec. Dagai	251100
251134	3	ID	Kec. Kiyage	251100
251215	3	ID	Kec. Mimika Tengah	251200
251216	3	ID	Kec. Kwamki Narama	251200
251217	3	ID	Kec. Hoya	251200
251218	3	ID	Kec. Iwaka	251200
251219	3	ID	Kec. Wania	251200
251220	3	ID	Kec. Amar	251200
251221	3	ID	Kec. Alama	251200
251316	3	ID	Kec. Ninati	251300
251317	3	ID	Kec. Sesnuk	251300
251318	3	ID	Kec. Ki	251300
251319	3	ID	Kec. Kombay	251300
251320	3	ID	Kec. Kawagit	251300
251321	3	ID	Kec. Syahcame	251300
251411	3	ID	Kec. Syahcame	251400
251412	3	ID	Kec. Yakomi	251400
251413	3	ID	Kec. Bamgi	251400
251414	3	ID	Kec. Passue Bawah	251400
251415	3	ID	Kec. Ti Zain	251400
251508	3	ID	Kec. Kopay	251500
251509	3	ID	Kec. Safan	251500
251510	3	ID	Kec. Sirets	251500
251511	3	ID	Kec. Joerat	251500
251512	3	ID	Kec. Pulau Tiga	251500
251513	3	ID	Kec. Der Koumur	251500
251514	3	ID	Kec. Ayip	251500
251515	3	ID	Kec. Betcbamu	251500
251516	3	ID	Kec. Suru-Suru	251500
251517	3	ID	Kec. Kolf Braza	251500
251518	3	ID	Kec. Jetsy	251500
251519	3	ID	Kec. Unir Sirau	251500
251520	3	ID	Kec. Sirau	251500
251652	3	ID	Kec. Tolikapura 2	251600
251891	3	ID	Kec. Kai	251800
251915	3	ID	Kec. Ismari	251900
251916	3	ID	Kec. Muara Tor	251900
251917	3	ID	Kec. Sobey	251900
251918	3	ID	Kec. Walani	251900
252008	3	ID	Kec. Arso Barat	252000
252009	3	ID	Kec. Kaisenar	252000
252010	3	ID	Kec. Mannem	252000
252011	3	ID	Kec. Yaffi	252000
252012	3	ID	Kec. Yaffi	252000
252611	3	ID	Kec. Demba	252600
252612	3	ID	Kec. Oudate	252600
252613	3	ID	Kec. Wonti	252600
252614	3	ID	Kec. Soyoi Mambai	252600
252615	3	ID	Kec. Walani	252600
252909	3	ID	Kec. Kegayem	252900
252910	3	ID	Kec. Paro	252900
252911	3	ID	Kec. Mebarok	252900
252912	3	ID	Kec. Kilmid	252900
252913	3	ID	Kec. Koroptak	252900
252914	3	ID	Kec. Yenggelo	252900
252915	3	ID	Kec. Alama	252900
252916	3	ID	Kec. Yal	252900
252917	3	ID	Kec. Mam	252900
252918	3	ID	Kec. Dal	252900
252919	3	ID	Kec. Nirkuri	252900
252920	3	ID	Kec. Iniye	252900
252921	3	ID	Kec. Mbua Tengah	252900
252922	3	ID	Kec. Inikgal	252900
252923	3	ID	Kec. Mbulmu Yalma	252900
252924	3	ID	Kec. Embetpen	252900
252925	3	ID	Kec. Kora	252900
252926	3	ID	Kec. Wusi	252900
252927	3	ID	Kec. Nenggeagin	252900
252928	3	ID	Kec. Pasir Putih	252900
252929	3	ID	Kec. Pija	252900
252930	3	ID	Kec. Moba	252900
252931	3	ID	Kec. Wutpaga	252900
252932	3	ID	Kec. Krepkuri	252900
253011	3	ID	Kec. Awina	253000
253012	3	ID	Kec. Ayumnati	253000
253013	3	ID	Kec. Balingga Barat	253000
253014	3	ID	Kec. Bruwa	253000
253015	3	ID	Kec. Buguk Gona	253000
253016	3	ID	Kec. Gelok Beam	253000
253017	3	ID	Kec. Goa Balim	253000
253018	3	ID	Kec. Gollo	253000
253019	3	ID	Kec. Guna	253000
253020	3	ID	Kec. Gupura	253000
253021	3	ID	Kec. Karu	253000
253022	3	ID	Kec. Kelulome	253000
253023	3	ID	Kec. Kolawa	253000
253024	3	ID	Kec. Kuly Lanny	253000
253025	3	ID	Kec. Lannyna	253000
253026	3	ID	Kec. Melagi	253000
253027	3	ID	Kec. Milimbo	253000
253028	3	ID	Kec. Mokoni	253000
253029	3	ID	Kec. Muara	253000
253030	3	ID	Kec. Nikogwe	253000
253031	3	ID	Kec. Niname	253000
253032	3	ID	Kec. Nogi	253000
253033	3	ID	Kec. Tiom Ollo	253000
253034	3	ID	Kec. Wano Barat	253000
253035	3	ID	Kec. Wereka	253000
253036	3	ID	Kec. Wiringgambut	253000
253037	3	ID	Kec. Yiginua	253000
253038	3	ID	Kec. Yiluk	253000
253039	3	ID	Kec. Yugungwi	253000
253309	3	ID	Kec. Dervos	253300
253310	3	ID	Kec. Beoga Barat	253300
253311	3	ID	Kec. Beoga Timur	253300
253312	3	ID	Kec. Ogamanim	253300
253313	3	ID	Kec. Kembru	253300
253314	3	ID	Kec. Bina	253300
253315	3	ID	Kec. Sinak Barat	253300
253316	3	ID	Kec. Mage`abume	253300
253317	3	ID	Kec. Yugumuak	253300
253318	3	ID	Kec. Ilaga Utara	253300
253319	3	ID	Kec. Mabugi	253300
253320	3	ID	Kec. Omukia	253300
253321	3	ID	Kec. Lambewi	253300
253322	3	ID	Kec. Oneri	253300
253323	3	ID	Kec. Amungkalpia	253300
253324	3	ID	Kec. Gome Utara	253300
253325	3	ID	Kec. Erelmakawia	253300
253697	3	ID	Kec. Ugimba	253600
253698	3	ID	Kec. Tomosiga	253600
260124	3	ID	Kec. Arma Jaya	260100
260125	3	ID	Kec. Tanjungagung Palik	260100
260126	3	ID	Kec. Ulok Kupai	260100
260127	3	ID	Kec. Marga Sakti Sebelat	260100
260128	3	ID	Kec. Pinang Raya	260100
260614	3	ID	Kec. Padang Bano	260600
270100	2	ID	Kab. Pulau Taliabu	270000
270101	3	ID	Kec. Taliabu Barat	270100
270102	3	ID	Kec. Taliabu Barat Laut	270100
270103	3	ID	Kec. Lede	270100
270104	3	ID	Kec. Taliabu Utara	270100
270105	3	ID	Kec. Taliabu Timur	270100
270106	3	ID	Kec. Taliabu Timur Selatan	270100
270107	3	ID	Kec. Taliabu Selatan	270100
270108	3	ID	Kec. Tabona	270100
270212	3	ID	Kec. Weda Timur	270200
270213	3	ID	Kec. Patani Timur	270200
270311	3	ID	Kec. Tabaru	270300
280435	3	ID	Kec. Lebak Wangi	280400
290509	3	ID	Kec. Kep. Pongok	290500
296091	3	ID	Kec. Gabek	296000
300227	3	ID	Kec. Dungaliyo	300200
300418	3	ID	Kec. Pinogu	300400
300512	3	ID	Kec. Sumalata Timur	300500
300513	3	ID	Kec. Sumalata Timur	300500
310210	3	ID	Kec. Meral Barat	310200
310211	3	ID	Kec. Ungar	310200
310212	3	ID	Kec. Belat	310200
310406	3	ID	Kec. Singkep Pesisir	310400
310407	3	ID	Kec. Singkep Selatan	310400
310408	3	ID	Kec. Lingga Timur	310400
310409	3	ID	Kec. Selayar	310400
310410	3	ID	Kec. Kepulauan Posek	310400
320110	3	ID	Kec. Pariwari	320100
320111	3	ID	Kec. Wartutin	320100
320112	3	ID	Kec. Fakfak Timur Tengah	320100
320113	3	ID	Kec. Arguni	320100
320114	3	ID	Kec. Mbahamdandara	320100
320115	3	ID	Kec. Kayauni	320100
320116	3	ID	Kec. Furwagi	320100
320117	3	ID	Kec. Tomage	320100
320591	3	ID	Kec. Anggi	320500
320622	3	ID	Kec. Kais Darat	320600
320623	3	ID	Kec. Salkma	320600
320723	3	ID	Kec. Mega	320700
320724	3	ID	Kec. Moraid/Mega	320700
320725	3	ID	Kec. Salawati Timur	320700
320726	3	ID	Kec. Sorong	320700
320907	3	ID	Kec. Amberbaken	320900
320908	3	ID	Kec. Kebar	320900
320909	3	ID	Kec. Senopi	320900
320910	3	ID	Kec. Mubrani	320900
320911	3	ID	Kec. Syujak	320900
320912	3	ID	Kec. Moraid	320900
320913	3	ID	Kec. Bikar	320900
320914	3	ID	Kec. Bamusbama	320900
320915	3	ID	Kec. Ases	320900
320916	3	ID	Kec. Miyah Selatan	320900
320917	3	ID	Kec. Ireres	320900
320918	3	ID	Kec. Tobouw	320900
320919	3	ID	Kec. Wilhem Roumbouts	320900
320920	3	ID	Kec. Kebar Timur	320900
320921	3	ID	Kec. Tinggouw	320900
320922	3	ID	Kec. Kwesefo	320900
320923	3	ID	Kec. Mawabuan	320900
320924	3	ID	Kec. Kebar Selatan	320900
320925	3	ID	Kec. Manekar	320900
320926	3	ID	Kec. Mpur	320900
320927	3	ID	Kec. Amberbaken Barat	320900
320928	3	ID	Kec. Kasi	320900
320929	3	ID	Kec. Selemkai	320900
321014	3	ID	Kec. Ayamaru Barat	321000
321016	3	ID	Kec. Ayamaru Tengah	321000
321017	3	ID	Kec. Ayamaru Selatan	321000
321018	3	ID	Kec. Ayamaru Utara Timur	321000
321019	3	ID	Kec. Ayamaru Selatan Jaya	321000
321020	3	ID	Kec. Mare Selatan	321000
321100	2	ID	Kab. Pegunungan Arfak	320000
321111	3	ID	Kec. Anggi Gida	321100
321112	3	ID	Kec. Membey	321100
321113	3	ID	Kec. Sururay	321100
321114	3	ID	Kec. Didohu	321100
321115	3	ID	Kec. Taige	321100
321116	3	ID	Kec. Catubouw	321100
321117	3	ID	Kec. Testega	321100
321118	3	ID	Kec. Menyambouw	321100
321119	3	ID	Kec. Hingk	321100
321120	3	ID	Kec. Anggi	321100
321200	2	ID	Kab. Manokwari Selatan	320000
321206	3	ID	Kec. Ransiki	321200
321221	3	ID	Kec. Oransbari	321200
321222	3	ID	Kec. Nenei	321200
321223	3	ID	Kec. Dataran Isim	321200
321224	3	ID	Kec. Momi Waren	321200
321225	3	ID	Kec. Tahota	321200
326010	3	ID	Kec. Klaurung	326000
326011	3	ID	Kec. Malaimsimsa	326000
326012	3	ID	Kec. Maladomes	326000
326013	3	ID	Kec. Sorong	326000
330600	2	ID	Kab. Mamuju Tengah	330000
330601	3	ID	Kec. Budong-Budong	330600
330602	3	ID	Kec. Karossa	330600
330603	3	ID	Kec. Topoyo	330600
330604	3	ID	Kec. Tobadak	330600
330605	3	ID	Kec. Pangale	330600
340105	3	ID	Kec. Mentarang	340100
340106	3	ID	Kec. Sungai Boh	340100
340107	3	ID	Kec. Malinau Selatan	340100
340108	3	ID	Kec. Malinau Barat	340100
340109	3	ID	Kec. Malinau Utara	340100
340110	3	ID	Kec. Kayan Selatan	340100
340111	3	ID	Kec. Bahau Hulu	340100
340112	3	ID	Kec. Mentarang Hulu	340100
340113	3	ID	Kec. Malinau Selatan Hilir	340100
340114	3	ID	Kec. Malinau Selatan Hulu	340100
340115	3	ID	Kec. Sungai Tubu	340100
340202	3	ID	Kec. Tanjung Palas	340200
340203	3	ID	Kec. Sekatak	340200
340205	3	ID	Kec. Pulau Bunyu	340200
340206	3	ID	Kec. Tanjung Palas Barat	340200
340207	3	ID	Kec. Tanjung Palas Utara	340200
340208	3	ID	Kec. Tanjung Palas Timur	340200
340209	3	ID	Kec. Tanjung Selor	340200
340210	3	ID	Kec. Tanjung Palas Tengah	340200
340211	3	ID	Kec. Peso Hilir	340200
340213	3	ID	Kec. Peso	340200
340301	3	ID	Kec. Sesayap	340300
340302	3	ID	Kec. Sesayap Hilir	340300
340303	3	ID	Kec. Tanah Lia	340300
340304	3	ID	Kec. Betayau	340300
340305	3	ID	Kec. Muruk Rian	340300
340501	3	ID	Kec. Krayan	340500
340502	3	ID	Kec. Lumbis	340500
340503	3	ID	Kec. Sembakung	340500
340504	3	ID	Kec. Nunukan	340500
340505	3	ID	Kec. Sebatik	340500
340506	3	ID	Kec. Sebuku	340500
340507	3	ID	Kec. Krayan Selatan	340500
340508	3	ID	Kec. Sebatik Barat	340500
340509	3	ID	Kec. Nunukan Selatan	340500
340514	3	ID	Kec. Nunukan	340500
340515	3	ID	Kec. Krayan Selatan	340500
340516	3	ID	Kec. Krayan	340500
340517	3	ID	Kec. Nunukan Selatan	340500
340518	3	ID	Kec. Sebatik Timur	340500
340519	3	ID	Kec. Sebatik Utara	340500
340520	3	ID	Kec. Sebatik Tengah	340500
340521	3	ID	Kec. Sei Menggaris	340500
340522	3	ID	Kec. Tulin Onsoi	340500
340523	3	ID	Kec. Lumbis Ogong	340500
340524	3	ID	Kec. Sembakung Atulai	340500
346001	3	ID	Kec. Tarakan Timur	346000
346002	3	ID	Kec. Tarakan Tengah	346000
346003	3	ID	Kec. Tarakan Barat	346000
346004	3	ID	Kec. Tarakan Utara	346000
286207	3	ID	Serang	286200
\.


--
-- TOC entry 4008 (class 0 OID 24853)
-- Dependencies: 234
-- Data for Name: matakuliah_kelas_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.matakuliah_kelas_mahasiswa (id_matakuliah_kelas_mahasiswa, id_prodi, nama_program_studi, id_matakuliah_krs_ditawarkan, id_matkul, nama_mata_kuliah, id_semester, id_master_kelas_mahasiswa) FROM stdin;
\.


--
-- TOC entry 4009 (class 0 OID 24858)
-- Dependencies: 235
-- Data for Name: matakuliah_krs_ditawarkan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.matakuliah_krs_ditawarkan (id_matakuliah_krs_ditawarkan, id_waktu_krs, id_semester_angkatan, id_semester, id_matakuliah_kurikulum, id_matkul, nama_mata_kuliah, id_prodi, nama_program_studi, id_tahun_akademik_angkatan, id_tahun_akademik) FROM stdin;
\.


--
-- TOC entry 4012 (class 0 OID 24873)
-- Dependencies: 238
-- Data for Name: matakuliah_kurikulum; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.matakuliah_kurikulum (id_matakuliah_kurikulum, id_kurikulum, nama_kurikulum, id_matkul, nama_matkul, semester, id_semester, semester_mulai_berlaku, apakah_wajib, sks_mata_kuliah, sks_tatap_muka, sks_praktek, sks_praktek_lapangan, sks_simulasi, id_prodi, id_tahun_akademik, nama_program_studi) FROM stdin;
61bcd0f6-8682-40c7-b996-e24c4f9b8204	4ef65db6-ee43-45d3-87e5-893e280179f1	20231	d1842e2a-cd84-4ef4-8df8-1c897084a016	Berfikir Kritis	4	20231	2023/2024 Gasal	1	6.00	2.00	1.00	2.00	1.00	7f44428f-8665-4909-bbbe-06ebcc1da17a	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	Farmasi
\.


--
-- TOC entry 4010 (class 0 OID 24863)
-- Dependencies: 236
-- Data for Name: matakuliah_remidi_ditawarkan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.matakuliah_remidi_ditawarkan (id_matakuliah_remidi_ditawarkan, id_waktu_remidi, id_semester_angkatan, id_semester, id_matkul_kurikulum, id_matkul, nama_mata_kuliah, id_prodi, nama_program_studi) FROM stdin;
\.


--
-- TOC entry 4011 (class 0 OID 24868)
-- Dependencies: 237
-- Data for Name: matakuliah_rencana_remidi_ditawarkan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.matakuliah_rencana_remidi_ditawarkan (id_matakuliah_rencana_remidi_ditawarkan, id_waktu_krs, id_semester_angkatan, id_semester, id_matkul_kurikulum, id_matkul, nama_mata_kuliah, id_prodi, nama_program_studi) FROM stdin;
\.


--
-- TOC entry 4038 (class 0 OID 33010)
-- Dependencies: 264
-- Data for Name: negara; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.negara (id_negara, nama_negara) FROM stdin;
GH	Ghana
NC	New Caledonia
AO	Angola
PH	Philippines
VE	Venezuela
MC	Monaco
TJ	Tajikistan
SO	Somalia
AX	Aland Islands
KG	Kyrgyzstan
KR	Korea, Republic Of
VA	Holy See (Vatican City State)
AI	Anguilla
CU	Cuba
BF	Burkina Faso
GT	Guatemala
KI	Kiribati
BQ	Bonaire, Saint Eustatius and Saba
CI	Cote D'Ivoire
DM	Dominica
BE	Belgium
MP	Northern Mariana Islands
PL	Poland
CM	Cameroon
IL	Israel
PT	Portugal
CG	Congo
TD	Chad
BT	Bhutan
AR	Argentina
KN	Saint Kitts And Nevis
GI	Gibraltar
GE	Georgia
SK	Slovakia
IE	Ireland
GG	Guernsey
CY	Cyprus
TN	Tunisia
SG	Singapore
LR	Liberia
NU	Niue
IS	Iceland
UA	Ukraine
SL	Sierra Leone
BG	Bulgaria
BW	Botswana
TK	Tokelau
VC	Saint Vincent And The Grenadines
PK	Pakistan
EG	Egypt
BH	Bahrain
RS	Serbia
TT	Trinidad And Tobago
JP	Japan
LI	Liechtenstein
AE	United Arab Emirates
NF	Norfolk Island
NR	Nauru
IT	Italy
PM	Saint Pierre And Miquelon
MS	Montserrat
BL	Saint Bartelemey
MA	Morocco
YE	Yemen
SI	Slovenia
AD	Andorra
TG	Togo
CN	China
KE	Kenya
DJ	Djibouti
GP	Guadeloupe
ER	Eritrea
ID	Indonesia
CZ	Czech Republic
HN	Honduras
FO	Faroe Islands
KY	Cayman Islands
PE	Peru
NZ	New Zealand
HU	Hungary
MQ	Martinique
SD	Sudan
CW	Curacao
SB	Solomon Islands
VU	Vanuatu
LV	Latvia
AZ	Azerbaijan
BO	Bolivia
AS	American Samoa
VN	Viet Nam
IQ	Iraq
EE	Estonia
PF	French Polynesia
PW	Palau
BJ	Benin
QA	Qatar
AT	Austria
SY	Syrian Arab Republic
ME	Montenegro
ZA	South Africa
KP	Korea, Democratic People'S Republic Of
TO	Tonga
RE	Reunion
CL	Chile
BR	Brazil
SM	San Marino
DZ	Algeria
AW	Aruba
SC	Seychelles
EH	Western Sahara
MT	Malta
JM	Jamaica
NP	Nepal
BY	Belarus
ZM	Zambia
WF	Wallis And Futuna
VI	Virgin Islands, U.S.
ET	Ethiopia
SS	South Sudan
GR	Greece
GY	Guyana
NI	Nicaragua
LB	Lebanon
CH	Switzerland
SN	Senegal
BS	Bahamas
IN	India
GA	Gabon
TH	Thailand
MH	Marshall Islands
YT	Mayotte
PN	Pitcairn
NA	Namibia
BM	Bermuda
RU	Russian Federation
CV	Cape Verde
AG	Antigua And Barbuda
IM	Isle Of Man
GL	Greenland
AM	Armenia
BA	Bosnia And Herzegovina
DO	Dominican Republic
PG	Papua New Guinea
PY	Paraguay
HR	Croatia
LT	Lithuania
EC	Ecuador
AU	Australia
TC	Turks And Caicos Islands
KM	Comoros
VG	Virgin Islands, British
TW	Taiwan, Province Of China
UZ	Uzbekistan
HT	Haiti
CF	Central African Republic
UG	Uganda
MG	Madagascar
MV	Maldives
DE	Germany
SV	El Salvador
AF	Afghanistan
UM	United States Minor Outlying Islands
MU	Mauritius
LA	Lao People'S Democratic Republic
PR	Puerto Rico
FM	Micronesia, Federated States Of
SE	Sweden
SR	Suriname
JE	Jersey
BZ	Belize
MF	Saint Martin
CK	Cook Islands
GM	Gambia
JO	Jordan
PS	Palestinian Territory, Occupied
MK	Macedonia, The Former Yugoslav Republic Of
RO	Romania
GB	United Kingdom
TL	Timor-Leste
FJ	Fiji
AN	Netherlands Antilles
TZ	Tanzania, United Republic Of
MR	Mauritania
LS	Lesotho
NG	Nigeria
SJ	Svalbard And Jan Mayen
MY	Malaysia
SA	Saudi Arabia
SZ	Swaziland
GN	Guinea
FI	Finland
OM	Oman
GU	Guam
ML	Mali
SX	Sint Maarten
GD	Grenada
KZ	Kazakhstan
MW	Malawi
CO	Colombia
US	United States
TV	Tuvalu
CA	Canada
MZ	Mozambique
NO	Norway
MM	Myanmar
UY	Uruguay
HK	Hong Kong
DK	Denmark
LU	Luxembourg
GW	Guinea-Bissau
GQ	Equatorial Guinea
CD	Congo, The Democratic Republic Of The
PA	Panama
LC	Saint Lucia
RW	Rwanda
NL	Netherlands
NE	Niger
CX	Christmas Island
IO	British Indian Ocean Territory
ZW	Zimbabwe
AQ	Antarctica
BD	Bangladesh
CC	Cocos (Keeling) Islands
BB	Barbados
ES	Spain
FR	France
KW	Kuwait
MN	Mongolia
CS	Serbia And Montenegro
FK	Falkland Islands (Malvinas)
IR	Iran, Islamic Republic Of
KH	Cambodia
GS	South Georgia And The South Sandwich Islands
BN	Brunei Darussalam
MD	Moldova, Republic Of
TF	French Southern Territories
MX	Mexico
BI	Burundi
SH	Saint Helena
CR	Costa Rica
HM	Heard Island And Mcdonald Islands
BV	Bouvet Island
GF	French Guiana
TM	Turkmenistan
AL	Albania
LY	Libyan Arab Jamahiriya
MO	Macao
LK	Sri Lanka
ST	Sao Tome And Principe
WS	Samoa
TR	Turkey
\.


--
-- TOC entry 4013 (class 0 OID 24884)
-- Dependencies: 239
-- Data for Name: nilai; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.nilai (id_nilai, id_prodi, nama_program_studi, id_semester, id_master_kegiatan_perkuliahan, id_registrasi_mahasiswa, nim, nama_mahasiswa, id_peserta_kelas_mahasiswa, kelas, nilai, tgl_nilai, id_pegawai, stat_nilai, tgl_insert, validasi, id_dosen) FROM stdin;
\.


--
-- TOC entry 4014 (class 0 OID 24892)
-- Dependencies: 240
-- Data for Name: parameter_absensi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.parameter_absensi (id_parameter_penilaian, id_master_parameter_penilaian, id_prodi, nama_program_studi, id_semester, id_master_kegiatan_perkuliahan, prosentase, jumlah_kegiatan, nilai_huruf) FROM stdin;
\.


--
-- TOC entry 4015 (class 0 OID 24897)
-- Dependencies: 241
-- Data for Name: parameter_penilaian; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.parameter_penilaian (id_parameter_penilaian, id_prodi, nama_program_studi, id_semester, id_master_kegiatan_perkuliahan, fungsi, prosentase, jumlah_kegiatan, id_master_parameter_penilaian, nbl, nilai_huruf) FROM stdin;
\.


--
-- TOC entry 4023 (class 0 OID 25225)
-- Dependencies: 249
-- Data for Name: periode_perkuliahan; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.periode_perkuliahan (id_periode_perkuliahan, id_prodi, nama_program_studi, id_semester, nama_semester, jumlah_target_mahasiswa_baru, tanggal_awal_perkuliahan, tanggal_akhir_perkuliahan, calon_ikut_seleksi, calon_lulus_seleksi, daftar_sbg_mhs, pst_undur_diri, jml_mgu_kul, metode_kul, metode_kul_eks, tgl_create, last_update, status_sync) FROM stdin;
\.


--
-- TOC entry 4016 (class 0 OID 24903)
-- Dependencies: 242
-- Data for Name: peserta_absensi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.peserta_absensi (id_peserta_absensi, id_absensi_perkuliahan, id_registrasi_mahasiswa, tgl_insert, tgl_absen) FROM stdin;
\.


--
-- TOC entry 4017 (class 0 OID 24908)
-- Dependencies: 243
-- Data for Name: peserta_kelas_mahasiswa; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.peserta_kelas_mahasiswa (id_peserta_kelas_mahasiswa, id_prodi, nama_program_studi, id_semester, id_registrasi_mahasiswa, id_mahasiswa, nama_mahasiswa, nim, id_master_kelas_mahasiswa, kelas, id_matakuliah_krs_ditawarkan, id_lokasi_perkuliahan) FROM stdin;
\.


--
-- TOC entry 4018 (class 0 OID 24913)
-- Dependencies: 244
-- Data for Name: waktu_krs; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.waktu_krs (id_waktu_krs, nama_krs, id_prodi, nama_program_studi, id_semester, id_tahun_akademik, nama_semester, status_data, tgl_mulai, tgl_selesai, tgl_toleransi_mulai, tgl_toleransi_selesai) FROM stdin;
379b22e1-fc53-4bb4-adb9-b94981da757f	KRS 2022/2023 Gasal farmasi	7f44428f-8665-4909-bbbe-06ebcc1da17a	Farmasi	20231	77fe2b94-1a8f-407a-9f9d-bb4e4f82af6e	2023/2024 Gasal	Aktif	2023-09-19 07:00:00	2023-09-20 20:00:00	2023-09-21 07:00:00	2023-09-23 16:30:00
\.


--
-- TOC entry 4019 (class 0 OID 24918)
-- Dependencies: 245
-- Data for Name: waktu_remidi; Type: TABLE DATA; Schema: siakad; Owner: -
--

COPY siakad.waktu_remidi (id_waktu_remidi, nama_remidi, id_prodi, nama_program_studi, id_semester, tgl_mulai, tgl_selesai, tgl_tolerasi_mulai, tgl_toleransi_selesai) FROM stdin;
\.


--
-- TOC entry 4020 (class 0 OID 24923)
-- Dependencies: 246
-- Data for Name: mahasiswa_skripsi; Type: TABLE DATA; Schema: skripsi; Owner: -
--

COPY skripsi.mahasiswa_skripsi (id_mahasiswa_skripsi, id_prodi, nama_program_studi, id_semester, id_semester_selesai, judul, judul_inggris, status, id_jenis_aktivitas) FROM stdin;
\.


--
-- TOC entry 4021 (class 0 OID 24929)
-- Dependencies: 247
-- Data for Name: pembimbing_mahasiswa; Type: TABLE DATA; Schema: skripsi; Owner: -
--

COPY skripsi.pembimbing_mahasiswa (id_pembimbing_mahasiswa, id_mahasiswa_skripsi, id_kategori_kegiatan, id_dosen, pemimbing_ke) FROM stdin;
\.


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


-- Completed on 2023-09-24 09:19:33 WIB

--
-- PostgreSQL database dump complete
--


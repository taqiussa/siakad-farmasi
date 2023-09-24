/*
 Navicat Premium Data Transfer

 Source Server         : postgres local
 Source Server Type    : PostgreSQL
 Source Server Version : 140009 (140009)
 Source Host           : localhost:5432
 Source Catalog        : sso
 Source Schema         : public

 Target Server Type    : PostgreSQL
 Target Server Version : 140009 (140009)
 File Encoding         : 65001

 Date: 24/09/2023 11:56:38
*/


-- ----------------------------
-- Sequence structure for bookcategories_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "bookcategories_id_seq";
CREATE SEQUENCE "bookcategories_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for books_sequence
-- ----------------------------
DROP SEQUENCE IF EXISTS "books_sequence";
CREATE SEQUENCE "books_sequence" 
INCREMENT 2
MINVALUE  1
MAXVALUE 9223372036854775807
START 2
CACHE 1;

-- ----------------------------
-- Sequence structure for failed_jobs_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "failed_jobs_id_seq";
CREATE SEQUENCE "failed_jobs_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for migrations_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "migrations_id_seq";
CREATE SEQUENCE "migrations_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 2147483647
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for personal_access_tokens_id_seq
-- ----------------------------
DROP SEQUENCE IF EXISTS "personal_access_tokens_id_seq";
CREATE SEQUENCE "personal_access_tokens_id_seq" 
INCREMENT 1
MINVALUE  1
MAXVALUE 9223372036854775807
START 1
CACHE 1;

-- ----------------------------
-- Sequence structure for users_sequence
-- ----------------------------
DROP SEQUENCE IF EXISTS "users_sequence";
CREATE SEQUENCE "users_sequence" 
INCREMENT 2
MINVALUE  1
MAXVALUE 9223372036854775807
START 2
CACHE 1;

-- ----------------------------
-- Table structure for bookcategories
-- ----------------------------
DROP TABLE IF EXISTS "bookcategories";
CREATE TABLE "bookcategories" (
  "id" int8 NOT NULL DEFAULT nextval('bookcategories_id_seq'::regclass),
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "slug" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of bookcategories
-- ----------------------------
BEGIN;
INSERT INTO "bookcategories" ("id", "name", "slug", "created_at", "updated_at") VALUES (2, 'buku', 'bukud', NULL, NULL);
COMMIT;

-- ----------------------------
-- Table structure for failed_jobs
-- ----------------------------
DROP TABLE IF EXISTS "failed_jobs";
CREATE TABLE "failed_jobs" (
  "id" int8 NOT NULL DEFAULT nextval('failed_jobs_id_seq'::regclass),
  "uuid" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "connection" text COLLATE "pg_catalog"."default" NOT NULL,
  "queue" text COLLATE "pg_catalog"."default" NOT NULL,
  "payload" text COLLATE "pg_catalog"."default" NOT NULL,
  "exception" text COLLATE "pg_catalog"."default" NOT NULL,
  "failed_at" timestamp(0) NOT NULL DEFAULT CURRENT_TIMESTAMP
)
;

-- ----------------------------
-- Records of failed_jobs
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for group_akses
-- ----------------------------
DROP TABLE IF EXISTS "group_akses";
CREATE TABLE "group_akses" (
  "id_group_akses" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "id_master_group" uuid NOT NULL,
  "id_master_aplikasi" uuid NOT NULL,
  "id_master_modul" uuid NOT NULL,
  "akses" bool DEFAULT true
)
;

-- ----------------------------
-- Records of group_akses
-- ----------------------------
BEGIN;
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('8359ff03-cb98-4cd5-8cba-6a28bdff1539', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '1acdb62c-86bf-429e-aae7-2ae71cc86b91', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('2dde2f98-ff36-44d2-bedd-83050f33bc3d', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'ff65a686-0202-4758-b6be-9099277b3f2d', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('b2ee1935-cc9d-4185-a9c8-cf35d7ede516', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '5baf6af9-9dee-4b5f-bd11-fb3b0d70ec19', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('5e3cc1f1-f9c3-492f-ba82-8acf34a1c5c3', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '6d351744-1992-4ed5-aade-73c794642abb', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('f50ec51b-ccfe-4001-85e8-47ee0432551c', '49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '73ad6297-2a4d-4d92-8452-77ef62135b74', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('15b664d4-d91f-4fd5-ab20-868455d70b37', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '247053bb-3072-4f29-aa45-1772ca7e1a6e', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('403768f1-aaf6-42ab-874d-a69e668256b3', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'f225ac92-37b8-401c-8a6e-e362d2657d1f', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('2765bef0-4828-4268-a1af-2d0f250d05cb', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '0610c1ea-1ce9-49ec-bafa-1a539d10c648', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('a9ca6254-1c47-4468-b3f3-e0c511b97e21', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '1469839b-b537-4f03-94d1-b8ce32be79d3', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('092f3f12-b31c-4956-8ba8-af549a4b48ef', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '18f3e1a0-fe13-48d7-a410-bc908ff38769', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('f3c3cacc-e95d-446c-a965-573231f2b2d9', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'f0ab95f3-c42c-487e-a005-5ac1d32a93de', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('e2f755e2-8e09-4291-84f2-2c1075f591be', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fc0d6624-b8b1-4150-a7cc-e6b18d4c29f1', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('34ffc16e-a3d8-4c11-8f4f-363479c5b2cf', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '6a734913-01e0-4f6f-9dc0-6a952e77329f', 't');
INSERT INTO "group_akses" ("id_group_akses", "id_master_group", "id_master_aplikasi", "id_master_modul", "akses") VALUES ('a03735a9-5dd1-4d6b-aab2-6289511da7e5', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', '2cdb147a-8d0d-4259-a4e3-843e2dd0184d', 't');
COMMIT;

-- ----------------------------
-- Table structure for master_aplikasi
-- ----------------------------
DROP TABLE IF EXISTS "master_aplikasi";
CREATE TABLE "master_aplikasi" (
  "id_master_aplikasi" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "nama_aplikasi" varchar COLLATE "pg_catalog"."default",
  "deskripsi" varchar COLLATE "pg_catalog"."default",
  "versi_aplikasi" varchar COLLATE "pg_catalog"."default",
  "status_data" varchar COLLATE "pg_catalog"."default",
  "tgl_version" date,
  "url" varchar COLLATE "pg_catalog"."default",
  "image" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of master_aplikasi
-- ----------------------------
BEGIN;
INSERT INTO "master_aplikasi" ("id_master_aplikasi", "nama_aplikasi", "deskripsi", "versi_aplikasi", "status_data", "tgl_version", "url", "image") VALUES ('6d920eeb-5be8-4346-a6cd-edcd26c95780', 'SSO', 'Single Sign On', '2.0', 'aktif', '2023-03-22', 'http://127.0.0.1:8000/edit_master_aplikasi/6d920eeb-5be8-4346-a6cd-edcd26c95780', '1679529740.png');
INSERT INTO "master_aplikasi" ("id_master_aplikasi", "nama_aplikasi", "deskripsi", "versi_aplikasi", "status_data", "tgl_version", "url", "image") VALUES ('ed9f0135-6f63-422c-a42a-fbc14e261900', 'SIA farmasi', 'SIstem akademik farmasi', '2.0', 'aktif', '2023-03-22', 'http://127.0.0.1:8000/add_master_aplikasi', '1679496468.png');
COMMIT;

-- ----------------------------
-- Table structure for master_group
-- ----------------------------
DROP TABLE IF EXISTS "master_group";
CREATE TABLE "master_group" (
  "id_master_group" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "id_master_aplikasi" uuid NOT NULL,
  "nama_group" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "deskripsi" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of master_group
-- ----------------------------
BEGIN;
INSERT INTO "master_group" ("id_master_group", "id_master_aplikasi", "nama_group", "deskripsi") VALUES ('a643ec4b-3937-414b-a0da-9aa558ec00c0', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'Administrator', 'Pengguna Administrator');
INSERT INTO "master_group" ("id_master_group", "id_master_aplikasi", "nama_group", "deskripsi") VALUES ('49a32cff-34ac-42c9-8432-72b178db99a9', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'Administrator', 'Pengguna Administrator');
INSERT INTO "master_group" ("id_master_group", "id_master_aplikasi", "nama_group", "deskripsi") VALUES ('9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'User', 'Pengguna User');
COMMIT;

-- ----------------------------
-- Table structure for master_menu
-- ----------------------------
DROP TABLE IF EXISTS "master_menu";
CREATE TABLE "master_menu" (
  "id_master_menu" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "nama_menu" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "deskripsi" varchar COLLATE "pg_catalog"."default",
  "order" int4,
  "id_master_aplikasi" uuid NOT NULL,
  "icon" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of master_menu
-- ----------------------------
BEGIN;
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('4706192a-bca5-4e15-a22b-043ac3e5f920', 'tes', 'asdasd', 2, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-hourglass-3');
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('0d312507-524d-49fe-9e5a-2f28c8ac3824', 'Manajemen Pengguna', 'Master Manajemen Pengguna', 2, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-users');
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('18476952-90c5-42bd-ad9a-6002ed6d87b7', 'Manajemen Pengguna', 'Master Manajemen Pengguna', 2, '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'fa fa-street-view');
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('cf56b85c-784e-49c3-ad54-446792bdd831', 'Master', 'Master Menu', 1, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-home');
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('006d6c9e-151d-4c8a-9c35-846017b7271c', 'Akun', 'Akun', 1, '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'fa fa-users');
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('bf507bfd-f42a-4591-bdba-f2d3b87a755e', 'Kurikulum', 'Kurikulum', 2, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-bank');
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('1d05ee48-d583-4916-b620-1761fce60e27', 'Pembayaran', 'Master Pembayaran', 3, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-dollar');
INSERT INTO "master_menu" ("id_master_menu", "nama_menu", "deskripsi", "order", "id_master_aplikasi", "icon") VALUES ('8b5e2031-f5c3-4b7b-9f20-eed88d9c982b', 'Rencana Studi', 'Master Rencana Studi', 4, 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'fa fa-balance-scale');
COMMIT;

-- ----------------------------
-- Table structure for master_modul
-- ----------------------------
DROP TABLE IF EXISTS "master_modul";
CREATE TABLE "master_modul" (
  "id_master_modul" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "id_master_menu" uuid NOT NULL,
  "order" int4,
  "nama_modul" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "path" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "deskripsi" varchar COLLATE "pg_catalog"."default",
  "id_master_aplikasi" uuid NOT NULL,
  "status_data" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "icon" varchar COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "master_modul"."status_data" IS 'aktif, tidak aktif';

-- ----------------------------
-- Records of master_modul
-- ----------------------------
BEGIN;
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('0df007ce-ab39-4485-ac73-061dc239e607', '4706192a-bca5-4e15-a22b-043ac3e5f920', 2, 'adsas', 'asda', 'adsa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-hourglass-3');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('1acdb62c-86bf-429e-aae7-2ae71cc86b91', '006d6c9e-151d-4c8a-9c35-846017b7271c', 1, 'Profile', 'profile', 'Profile Pengguna', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-user');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('ff65a686-0202-4758-b6be-9099277b3f2d', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 1, 'Master Aplikasi', 'master_aplikasi', 'Manajemen Aplikasi', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-space-shuttle');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('5baf6af9-9dee-4b5f-bd11-fb3b0d70ec19', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 2, 'Master Menu', 'master_menu', 'Master Manajemen Menu', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-bars');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('6d351744-1992-4ed5-aade-73c794642abb', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 3, 'Master Grup Akses', 'master_group', 'Master Manajemen Group Akses Aplikasi', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-comments');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('73ad6297-2a4d-4d92-8452-77ef62135b74', '18476952-90c5-42bd-ad9a-6002ed6d87b7', 4, 'Master Pengguna', 'master_pengguna', 'Master Manajemen Pengguna', '6d920eeb-5be8-4346-a6cd-edcd26c95780', 'aktif', 'fa fa-user-secret');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('247053bb-3072-4f29-aa45-1772ca7e1a6e', 'cf56b85c-784e-49c3-ad54-446792bdd831', 1, 'Master Biodata Mahasiswa', 'master_biodata_mahasiswa', 'Master Biodata Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-mortar-board');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('f225ac92-37b8-401c-8a6e-e362d2657d1f', 'cf56b85c-784e-49c3-ad54-446792bdd831', 2, 'Master Pendidikan Mahasiswa', 'master_mahasiswa', 'Master Pendidikan Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-users');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('0610c1ea-1ce9-49ec-bafa-1a539d10c648', 'cf56b85c-784e-49c3-ad54-446792bdd831', 3, 'Master Mata Kuliah', 'master_matakuliah', 'Master Matakuliah', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-book');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('18f3e1a0-fe13-48d7-a410-bc908ff38769', 'bf507bfd-f42a-4591-bdba-f2d3b87a755e', 1, 'Master Kurikulum', 'master_kurikulum', 'Master Kurikulum', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-map');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('f0ab95f3-c42c-487e-a005-5ac1d32a93de', 'bf507bfd-f42a-4591-bdba-f2d3b87a755e', 2, 'Master Angkatan Mahasiswa', 'master_angkatan_mahasiswa', 'Master Group Angkatan Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-bug');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('6a734913-01e0-4f6f-9dc0-6a952e77329f', '1d05ee48-d583-4916-b620-1761fce60e27', 2, 'Tagihan Mahasiswa', 'tagihan_mahasiswa', 'Tagihan Mahasiswa', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-th-list');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('fc0d6624-b8b1-4150-a7cc-e6b18d4c29f1', '1d05ee48-d583-4916-b620-1761fce60e27', 1, 'Master Kode Pembayaran', 'master_kode_pembayaran', 'Master Kode Pembayaran', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-bar-chart');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('2cdb147a-8d0d-4259-a4e3-843e2dd0184d', '8b5e2031-f5c3-4b7b-9f20-eed88d9c982b', 1, 'Waktu KRS', 'waktu_krs', 'master waktu krs', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-commenting');
INSERT INTO "master_modul" ("id_master_modul", "id_master_menu", "order", "nama_modul", "path", "deskripsi", "id_master_aplikasi", "status_data", "icon") VALUES ('c3eb1aa6-5cd8-4185-96b9-ddead17ba1f4', 'bf507bfd-f42a-4591-bdba-f2d3b87a755e', 1, 'tes', 'tes', 'contoh', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'aktif', 'fa fa-commenting');
COMMIT;

-- ----------------------------
-- Table structure for migrations
-- ----------------------------
DROP TABLE IF EXISTS "migrations";
CREATE TABLE "migrations" (
  "id" int4 NOT NULL DEFAULT nextval('migrations_id_seq'::regclass),
  "migration" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "batch" int4 NOT NULL
)
;

-- ----------------------------
-- Records of migrations
-- ----------------------------
BEGIN;
INSERT INTO "migrations" ("id", "migration", "batch") VALUES (1, '2014_10_12_000000_create_users_table', 1);
INSERT INTO "migrations" ("id", "migration", "batch") VALUES (2, '2014_10_12_100000_create_password_reset_tokens_table', 1);
INSERT INTO "migrations" ("id", "migration", "batch") VALUES (3, '2014_10_12_100000_create_password_resets_table', 1);
INSERT INTO "migrations" ("id", "migration", "batch") VALUES (4, '2019_08_19_000000_create_failed_jobs_table', 1);
INSERT INTO "migrations" ("id", "migration", "batch") VALUES (5, '2019_12_14_000001_create_personal_access_tokens_table', 1);
INSERT INTO "migrations" ("id", "migration", "batch") VALUES (6, '2023_02_15_053453_create_bookcategories_table', 1);
INSERT INTO "migrations" ("id", "migration", "batch") VALUES (7, '2023_04_08_082712_create_sessions_table', 2);
COMMIT;

-- ----------------------------
-- Table structure for password_reset_tokens
-- ----------------------------
DROP TABLE IF EXISTS "password_reset_tokens";
CREATE TABLE "password_reset_tokens" (
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "token" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0)
)
;

-- ----------------------------
-- Records of password_reset_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for password_resets
-- ----------------------------
DROP TABLE IF EXISTS "password_resets";
CREATE TABLE "password_resets" (
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "token" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "created_at" timestamp(0)
)
;

-- ----------------------------
-- Records of password_resets
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for personal_access_tokens
-- ----------------------------
DROP TABLE IF EXISTS "personal_access_tokens";
CREATE TABLE "personal_access_tokens" (
  "id" int8 NOT NULL DEFAULT nextval('personal_access_tokens_id_seq'::regclass),
  "tokenable_type" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "tokenable_id" int8 NOT NULL,
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "token" varchar(64) COLLATE "pg_catalog"."default" NOT NULL,
  "abilities" text COLLATE "pg_catalog"."default",
  "last_used_at" timestamp(0),
  "expires_at" timestamp(0),
  "created_at" timestamp(0),
  "updated_at" timestamp(0)
)
;

-- ----------------------------
-- Records of personal_access_tokens
-- ----------------------------
BEGIN;
COMMIT;

-- ----------------------------
-- Table structure for sessions
-- ----------------------------
DROP TABLE IF EXISTS "sessions";
CREATE TABLE "sessions" (
  "id" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "user_id" int8,
  "ip_address" varchar(45) COLLATE "pg_catalog"."default",
  "user_agent" text COLLATE "pg_catalog"."default",
  "payload" text COLLATE "pg_catalog"."default" NOT NULL,
  "last_activity" int4 NOT NULL
)
;

-- ----------------------------
-- Records of sessions
-- ----------------------------
BEGIN;
INSERT INTO "sessions" ("id", "user_id", "ip_address", "user_agent", "payload", "last_activity") VALUES ('hlmyApKhtTDXF7EHGNT2USbXuIXoPJmYrPS1yY6r', NULL, '192.168.240.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoidlFBejdFNlF4M1JZemtVTHBZOTJCUklCekl4NEhQUUNwOVpvNEtkYSI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo2MzoiaHR0cDovL3NpYS5ha2FkZW1pay5sb2NhbC9tYXN0ZXJfbWFoYXNpc3dhL2FkZF9tYXN0ZXJfbWFoYXNpc3dhIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NjM6Imh0dHA6Ly9zaWEuYWthZGVtaWsubG9jYWwvbWFzdGVyX21haGFzaXN3YS9hZGRfbWFzdGVyX21haGFzaXN3YSI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1695524627);
INSERT INTO "sessions" ("id", "user_id", "ip_address", "user_agent", "payload", "last_activity") VALUES ('aZbz3NAueXdFAeZdDZcTkNZCaKnbwN35LRucfcb2', NULL, '192.168.240.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiMmw2U0U5VHEwWUYwb3VvcFR3VkxibHE4ZjJOS0gwdkZoYWNQWHd5TyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czo0MjoiaHR0cDovL3NpYS5ha2FkZW1pay5sb2NhbC93YWt0dV9rcnM/cGFnZT0yIjt9czo5OiJfcHJldmlvdXMiO2E6MTp7czozOiJ1cmwiO3M6NDI6Imh0dHA6Ly9zaWEuYWthZGVtaWsubG9jYWwvd2FrdHVfa3JzP3BhZ2U9MiI7fXM6NjoiX2ZsYXNoIjthOjI6e3M6Mzoib2xkIjthOjA6e31zOjM6Im5ldyI7YTowOnt9fX0=', 1695528571);
INSERT INTO "sessions" ("id", "user_id", "ip_address", "user_agent", "payload", "last_activity") VALUES ('TXsF30e5QJPZxklyjXhXmHeXzfWg7fmkRiouQ9Gm', 1, '192.168.240.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0', 'YTo2OntzOjY6Il90b2tlbiI7czo0MDoiNXAzd0Jld3JyWXhiRDYyR1FUZkk5MFlHcU1xRzlTVVJHUTlGcjZWbyI7czozOiJ1cmwiO2E6MDp7fXM6OToiX3ByZXZpb3VzIjthOjE6e3M6MzoidXJsIjtzOjQyOiJodHRwOi8vc2lhLmFrYWRlbWlrLmxvY2FsL3dha3R1X2tycz9wYWdlPTciO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX1zOjUwOiJsb2dpbl93ZWJfNTliYTM2YWRkYzJiMmY5NDAxNTgwZjAxNGM3ZjU4ZWE0ZTMwOTg5ZCI7aToxO3M6NDoiYXV0aCI7YToxOntzOjIxOiJwYXNzd29yZF9jb25maXJtZWRfYXQiO2k6MTY5NTUxNzU1NTt9fQ==', 1695528816);
INSERT INTO "sessions" ("id", "user_id", "ip_address", "user_agent", "payload", "last_activity") VALUES ('IZSKaFDxHGRNDs1L4xejbrIlSBksvoATJuuO6kMe', NULL, '192.168.240.1', 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:109.0) Gecko/20100101 Firefox/117.0', 'YTo0OntzOjY6Il90b2tlbiI7czo0MDoiNFZzZ1JBemFnQmgwVDBWcDFkRUJIUkZVWm9PazYyakdsQ3dLQTZ5YyI7czozOiJ1cmwiO2E6MTp7czo4OiJpbnRlbmRlZCI7czozNToiaHR0cDovL3NpYS5ha2FkZW1pay5sb2NhbC93YWt0dV9rcnMiO31zOjk6Il9wcmV2aW91cyI7YToxOntzOjM6InVybCI7czozNToiaHR0cDovL3NpYS5ha2FkZW1pay5sb2NhbC93YWt0dV9rcnMiO31zOjY6Il9mbGFzaCI7YToyOntzOjM6Im9sZCI7YTowOnt9czozOiJuZXciO2E6MDp7fX19', 1695528140);
COMMIT;

-- ----------------------------
-- Table structure for trans_user_group
-- ----------------------------
DROP TABLE IF EXISTS "trans_user_group";
CREATE TABLE "trans_user_group" (
  "id_trans_user_group" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "id_user" uuid NOT NULL,
  "id_master_aplikasi" uuid NOT NULL,
  "id_master_group" uuid NOT NULL,
  "status_data" varchar COLLATE "pg_catalog"."default"
)
;

-- ----------------------------
-- Records of trans_user_group
-- ----------------------------
BEGIN;
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('c9d9f7f6-0995-43d4-bf57-ce117d3e659f', '953fd07b-11a2-45a1-8ae5-87a408001afd', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('dc2f70b5-8569-4a03-870e-eedb26e81937', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('51c8380c-a975-4e1b-8eb8-8a1abcd5ba4a', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('c76e8668-1506-4ddb-812a-927fb6271ec3', '113cfdf7-ed7f-425e-8bbc-b093206d9917', 'ed9f0135-6f63-422c-a42a-fbc14e261900', 'a643ec4b-3937-414b-a0da-9aa558ec00c0', 'Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('fb11c63b-94f2-4af5-bbce-27b220a893ce', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('c4e2117b-70bd-4c0a-809b-0ea1508f2ab6', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('90cc0382-ca17-4f53-a8e8-489b91acb587', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('d805cc43-889b-4fc9-96fb-8bacf9f1c1d5', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('07fd58ac-1adc-489d-9681-390e520f03ec', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('0892b240-1331-47be-963c-a95eb3efeeff', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('36bc3be5-8718-4c44-8bbc-640a05eb3268', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('27703a93-9ddb-41de-8e64-fc214131dd99', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('a741129a-12ad-472e-a516-18df3bfc80ae', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('7292f5ff-0dac-437c-80bf-e79aee9e334f', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '9c2c00ba-d1a9-4d6e-8f35-41c61bab6b47', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('50a85e2c-3b7a-4170-b252-28e498f60e39', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
INSERT INTO "trans_user_group" ("id_trans_user_group", "id_user", "id_master_aplikasi", "id_master_group", "status_data") VALUES ('e3a023be-54a2-4c74-b280-7f19a3e126d3', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '6d920eeb-5be8-4346-a6cd-edcd26c95780', '49a32cff-34ac-42c9-8432-72b178db99a9', 'Tidak Aktif');
COMMIT;

-- ----------------------------
-- Table structure for users
-- ----------------------------
DROP TABLE IF EXISTS "users";
CREATE TABLE "users" (
  "name" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "email_verified_at" timestamp(0),
  "password" varchar(255) COLLATE "pg_catalog"."default" NOT NULL,
  "remember_token" varchar(100) COLLATE "pg_catalog"."default",
  "created_at" timestamp(0),
  "updated_at" timestamp(0),
  "username" varchar COLLATE "pg_catalog"."default",
  "id_user" uuid NOT NULL DEFAULT uuid_generate_v4(),
  "person_id" uuid,
  "id" int4 DEFAULT nextval('users_sequence'::regclass),
  "image" varchar COLLATE "pg_catalog"."default" DEFAULT 'avatar.png'::character varying,
  "status_data" varchar COLLATE "pg_catalog"."default"
)
;
COMMENT ON COLUMN "users"."status_data" IS 'aktif dan tidak aktif';

-- ----------------------------
-- Records of users
-- ----------------------------
BEGIN;
INSERT INTO "users" ("name", "email", "email_verified_at", "password", "remember_token", "created_at", "updated_at", "username", "id_user", "person_id", "id", "image", "status_data") VALUES ('dhanang', 'dhanang@gmail.com', NULL, '$2y$10$CtFtf/x9tGDGxYpjRM5eFOUv4E6xDX1PBxl/qBDMZ/eU/JNhAA0CC', NULL, '2023-03-18 02:27:53', '2023-03-18 02:27:53', 'dhanang2112', '113cfdf7-ed7f-425e-8bbc-b093206d9917', '063f25d7-2513-405a-ba2a-50cc60b2714a', 1, 'avatar.png', 'aktif');
COMMIT;

-- ----------------------------
-- Table structure for users_2
-- ----------------------------
DROP TABLE IF EXISTS "users_2";
CREATE TABLE "users_2" (
  "usersid" _uuid NOT NULL,
  "username" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "password" varchar COLLATE "pg_catalog"."default" NOT NULL,
  "email" varchar COLLATE "pg_catalog"."default",
  "name" varchar COLLATE "pg_catalog"."default",
  "last_update" _timestamp,
  "image" varchar COLLATE "pg_catalog"."default",
  "status" bool,
  "personid" _uuid
)
;

-- ----------------------------
-- Records of users_2
-- ----------------------------
BEGIN;
INSERT INTO "users_2" ("usersid", "username", "password", "email", "name", "last_update", "image", "status", "personid") VALUES ('{280e5189-0fca-4a2a-9dcf-d15da4d4c5c0}', 'dhanang2112', '123456', 'dhanang.hadiyanto@gmail.com', 'dhanang hadiyanto', NULL, NULL, 't', '{280e5189-0fca-4a2a-9dcf-d15da4d4c5c0}');
COMMIT;

-- ----------------------------
-- Function structure for uuid_generate_v1
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v1"();
CREATE OR REPLACE FUNCTION "uuid_generate_v1"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v1mc
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v1mc"();
CREATE OR REPLACE FUNCTION "uuid_generate_v1mc"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v1mc'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v3
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v3"("namespace" uuid, "name" text);
CREATE OR REPLACE FUNCTION "uuid_generate_v3"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v3'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v4
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v4"();
CREATE OR REPLACE FUNCTION "uuid_generate_v4"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v4'
  LANGUAGE c VOLATILE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_generate_v5
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_generate_v5"("namespace" uuid, "name" text);
CREATE OR REPLACE FUNCTION "uuid_generate_v5"("namespace" uuid, "name" text)
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_generate_v5'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_nil
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_nil"();
CREATE OR REPLACE FUNCTION "uuid_nil"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_nil'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_dns
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_dns"();
CREATE OR REPLACE FUNCTION "uuid_ns_dns"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_dns'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_oid
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_oid"();
CREATE OR REPLACE FUNCTION "uuid_ns_oid"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_oid'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_url
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_url"();
CREATE OR REPLACE FUNCTION "uuid_ns_url"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_url'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Function structure for uuid_ns_x500
-- ----------------------------
DROP FUNCTION IF EXISTS "uuid_ns_x500"();
CREATE OR REPLACE FUNCTION "uuid_ns_x500"()
  RETURNS "pg_catalog"."uuid" AS '$libdir/uuid-ossp', 'uuid_ns_x500'
  LANGUAGE c IMMUTABLE STRICT
  COST 1;

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "bookcategories_id_seq"
OWNED BY "bookcategories"."id";
SELECT setval('"bookcategories_id_seq"', 2, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"books_sequence"', 2, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "failed_jobs_id_seq"
OWNED BY "failed_jobs"."id";
SELECT setval('"failed_jobs_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "migrations_id_seq"
OWNED BY "migrations"."id";
SELECT setval('"migrations_id_seq"', 7, true);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
ALTER SEQUENCE "personal_access_tokens_id_seq"
OWNED BY "personal_access_tokens"."id";
SELECT setval('"personal_access_tokens_id_seq"', 1, false);

-- ----------------------------
-- Alter sequences owned by
-- ----------------------------
SELECT setval('"users_sequence"', 61, true);

-- ----------------------------
-- Uniques structure for table bookcategories
-- ----------------------------
ALTER TABLE "bookcategories" ADD CONSTRAINT "bookcategories_name_unique" UNIQUE ("name");
ALTER TABLE "bookcategories" ADD CONSTRAINT "bookcategories_slug_unique" UNIQUE ("slug");

-- ----------------------------
-- Primary Key structure for table bookcategories
-- ----------------------------
ALTER TABLE "bookcategories" ADD CONSTRAINT "bookcategories_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table failed_jobs
-- ----------------------------
ALTER TABLE "failed_jobs" ADD CONSTRAINT "failed_jobs_uuid_unique" UNIQUE ("uuid");

-- ----------------------------
-- Primary Key structure for table failed_jobs
-- ----------------------------
ALTER TABLE "failed_jobs" ADD CONSTRAINT "failed_jobs_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table group_akses
-- ----------------------------
ALTER TABLE "group_akses" ADD CONSTRAINT "group_akses_pk" PRIMARY KEY ("id_group_akses");

-- ----------------------------
-- Primary Key structure for table master_aplikasi
-- ----------------------------
ALTER TABLE "master_aplikasi" ADD CONSTRAINT "master_aplikasi_pk" PRIMARY KEY ("id_master_aplikasi");

-- ----------------------------
-- Primary Key structure for table master_group
-- ----------------------------
ALTER TABLE "master_group" ADD CONSTRAINT "master_group_pk" PRIMARY KEY ("id_master_group");

-- ----------------------------
-- Primary Key structure for table master_menu
-- ----------------------------
ALTER TABLE "master_menu" ADD CONSTRAINT "master_menu_pk" PRIMARY KEY ("id_master_menu");

-- ----------------------------
-- Primary Key structure for table master_modul
-- ----------------------------
ALTER TABLE "master_modul" ADD CONSTRAINT "master_modul_pk" PRIMARY KEY ("id_master_modul");

-- ----------------------------
-- Primary Key structure for table migrations
-- ----------------------------
ALTER TABLE "migrations" ADD CONSTRAINT "migrations_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Primary Key structure for table password_reset_tokens
-- ----------------------------
ALTER TABLE "password_reset_tokens" ADD CONSTRAINT "password_reset_tokens_pkey" PRIMARY KEY ("email");

-- ----------------------------
-- Indexes structure for table password_resets
-- ----------------------------
CREATE INDEX "password_resets_email_index" ON "password_resets" USING btree (
  "email" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST
);

-- ----------------------------
-- Indexes structure for table personal_access_tokens
-- ----------------------------
CREATE INDEX "personal_access_tokens_tokenable_type_tokenable_id_index" ON "personal_access_tokens" USING btree (
  "tokenable_type" COLLATE "pg_catalog"."default" "pg_catalog"."text_ops" ASC NULLS LAST,
  "tokenable_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Uniques structure for table personal_access_tokens
-- ----------------------------
ALTER TABLE "personal_access_tokens" ADD CONSTRAINT "personal_access_tokens_token_unique" UNIQUE ("token");

-- ----------------------------
-- Primary Key structure for table personal_access_tokens
-- ----------------------------
ALTER TABLE "personal_access_tokens" ADD CONSTRAINT "personal_access_tokens_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Indexes structure for table sessions
-- ----------------------------
CREATE INDEX "sessions_last_activity_index" ON "sessions" USING btree (
  "last_activity" "pg_catalog"."int4_ops" ASC NULLS LAST
);
CREATE INDEX "sessions_user_id_index" ON "sessions" USING btree (
  "user_id" "pg_catalog"."int8_ops" ASC NULLS LAST
);

-- ----------------------------
-- Primary Key structure for table sessions
-- ----------------------------
ALTER TABLE "sessions" ADD CONSTRAINT "sessions_pkey" PRIMARY KEY ("id");

-- ----------------------------
-- Uniques structure for table users
-- ----------------------------
ALTER TABLE "users" ADD CONSTRAINT "users_email_unique" UNIQUE ("email");
ALTER TABLE "users" ADD CONSTRAINT "username" UNIQUE ("username");

-- ----------------------------
-- Primary Key structure for table users
-- ----------------------------
ALTER TABLE "users" ADD CONSTRAINT "id_users_pk" PRIMARY KEY ("id_user");

-- ----------------------------
-- Uniques structure for table users_2
-- ----------------------------
ALTER TABLE "users_2" ADD CONSTRAINT "users_un" UNIQUE ("email");

-- ----------------------------
-- Primary Key structure for table users_2
-- ----------------------------
ALTER TABLE "users_2" ADD CONSTRAINT "users_pk" PRIMARY KEY ("usersid");

-- ----------------------------
-- Foreign Keys structure for table group_akses
-- ----------------------------
ALTER TABLE "group_akses" ADD CONSTRAINT "group_akses_fk" FOREIGN KEY ("id_master_group") REFERENCES "master_group" ("id_master_group") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table master_group
-- ----------------------------
ALTER TABLE "master_group" ADD CONSTRAINT "master_group_fk" FOREIGN KEY ("id_master_aplikasi") REFERENCES "master_aplikasi" ("id_master_aplikasi") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table master_menu
-- ----------------------------
ALTER TABLE "master_menu" ADD CONSTRAINT "master_menu_fk" FOREIGN KEY ("id_master_aplikasi") REFERENCES "master_aplikasi" ("id_master_aplikasi") ON DELETE RESTRICT ON UPDATE RESTRICT;

-- ----------------------------
-- Foreign Keys structure for table master_modul
-- ----------------------------
ALTER TABLE "master_modul" ADD CONSTRAINT "master_modul_fk" FOREIGN KEY ("id_master_menu") REFERENCES "master_menu" ("id_master_menu") ON DELETE RESTRICT ON UPDATE RESTRICT;

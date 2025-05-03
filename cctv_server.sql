-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: May 03, 2025 at 05:42 PM
-- Server version: 11.7.2-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `cctv_server`
--

-- --------------------------------------------------------

--
-- Table structure for table `apd_report_pelanggaran`
--

CREATE TABLE `apd_report_pelanggaran` (
  `id` bigint(20) NOT NULL,
  `waktu` datetime(6) NOT NULL,
  `lokasi` varchar(255) NOT NULL,
  `jenis_pelanggaran` varchar(100) NOT NULL,
  `tindakan` varchar(100) NOT NULL,
  `confidence` double DEFAULT NULL,
  `screenshot_path` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `apd_report_pelanggaran`
--

INSERT INTO `apd_report_pelanggaran` (`id`, `waktu`, `lokasi`, `jenis_pelanggaran`, `tindakan`, `confidence`, `screenshot_path`) VALUES
(6, '2024-05-15 14:36:59.260927', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.6137546300888062, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250422-213514.jpg'),
(7, '2024-05-15 14:36:59.260927', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.5056233406066895, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250422-213617.jpg'),
(8, '2025-04-22 14:36:23.366008', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.73353511095047, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250422-213623.jpg'),
(10, '2025-05-01 12:25:53.429425', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.6137546300888062, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250501-192553.jpg'),
(11, '2025-05-01 12:26:40.258433', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.5056233406066895, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250501-192640.jpg'),
(12, '2025-05-01 12:26:45.295397', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.6217843294143677, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250501-192645.jpg'),
(13, '2025-05-01 12:27:15.962160', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.5721391439437866, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250501-192715.jpg'),
(14, '2025-05-01 12:27:58.586594', 'Lokasi Tidak Diketahui', 'No Helmet', 'Peringatan', 0.5576567649841309, 'C:\\myapps\\webapp\\apd_report\\static\\screenshots\\no_helmet_furthest_20250501-192758.jpg');

-- --------------------------------------------------------

--
-- Table structure for table `auth_group`
--

CREATE TABLE `auth_group` (
  `id` int(11) NOT NULL,
  `name` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_group_permissions`
--

CREATE TABLE `auth_group_permissions` (
  `id` bigint(20) NOT NULL,
  `group_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_permission`
--

CREATE TABLE `auth_permission` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `content_type_id` int(11) NOT NULL,
  `codename` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_permission`
--

INSERT INTO `auth_permission` (`id`, `name`, `content_type_id`, `codename`) VALUES
(1, 'Can add log entry', 1, 'add_logentry'),
(2, 'Can change log entry', 1, 'change_logentry'),
(3, 'Can delete log entry', 1, 'delete_logentry'),
(4, 'Can view log entry', 1, 'view_logentry'),
(5, 'Can add permission', 2, 'add_permission'),
(6, 'Can change permission', 2, 'change_permission'),
(7, 'Can delete permission', 2, 'delete_permission'),
(8, 'Can view permission', 2, 'view_permission'),
(9, 'Can add group', 3, 'add_group'),
(10, 'Can change group', 3, 'change_group'),
(11, 'Can delete group', 3, 'delete_group'),
(12, 'Can view group', 3, 'view_group'),
(13, 'Can add user', 4, 'add_user'),
(14, 'Can change user', 4, 'change_user'),
(15, 'Can delete user', 4, 'delete_user'),
(16, 'Can view user', 4, 'view_user'),
(17, 'Can add content type', 5, 'add_contenttype'),
(18, 'Can change content type', 5, 'change_contenttype'),
(19, 'Can delete content type', 5, 'delete_contenttype'),
(20, 'Can view content type', 5, 'view_contenttype'),
(21, 'Can add session', 6, 'add_session'),
(22, 'Can change session', 6, 'change_session'),
(23, 'Can delete session', 6, 'delete_session'),
(24, 'Can view session', 6, 'view_session'),
(25, 'Can add pelanggaran', 7, 'add_pelanggaran'),
(26, 'Can change pelanggaran', 7, 'change_pelanggaran'),
(27, 'Can delete pelanggaran', 7, 'delete_pelanggaran'),
(28, 'Can view pelanggaran', 7, 'view_pelanggaran');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user`
--

CREATE TABLE `auth_user` (
  `id` int(11) NOT NULL,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `auth_user`
--

INSERT INTO `auth_user` (`id`, `password`, `last_login`, `is_superuser`, `username`, `first_name`, `last_name`, `email`, `is_staff`, `is_active`, `date_joined`) VALUES
(1, 'pbkdf2_sha256$870000$KaaDJ2mnLWzCq2p7tiFd4k$lLuwtEcqhRUF+qihBNKjCdYp8QFVJAeVlOCRznFnJWw=', '2025-05-01 14:11:14.144482', 1, 'admin1', 'Petugas', 'K3', 'admin1@gmail.com', 1, 1, '2025-03-23 00:24:12.000000'),
(2, 'pbkdf2_sha256$870000$YqBLikAvUEI0iaRHGDduoC$LXqRBHA0sQkd+qtrnPtBP4Th9ETeOJYVftFJChR4BsE=', '2025-04-01 18:11:09.000000', 0, 'K3', 'Hari', '', 'Hari@gmail.com', 1, 1, '2025-04-01 17:18:54.000000');

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_groups`
--

CREATE TABLE `auth_user_groups` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `group_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `auth_user_user_permissions`
--

CREATE TABLE `auth_user_user_permissions` (
  `id` bigint(20) NOT NULL,
  `user_id` int(11) NOT NULL,
  `permission_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Table structure for table `django_admin_log`
--

CREATE TABLE `django_admin_log` (
  `id` int(11) NOT NULL,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext DEFAULT NULL,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint(5) UNSIGNED NOT NULL CHECK (`action_flag` >= 0),
  `change_message` longtext NOT NULL,
  `content_type_id` int(11) DEFAULT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_admin_log`
--

INSERT INTO `django_admin_log` (`id`, `action_time`, `object_id`, `object_repr`, `action_flag`, `change_message`, `content_type_id`, `user_id`) VALUES
(1, '2025-04-01 17:18:54.645309', '2', 'K3', 1, '[{\"added\": {}}]', 4, 1),
(2, '2025-04-01 17:19:35.668282', '2', 'K3', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Email address\", \"User permissions\"]}}]', 4, 1),
(3, '2025-04-01 18:09:25.362629', '2', 'K3', 2, '[{\"changed\": {\"fields\": [\"Staff status\"]}}]', 4, 1),
(4, '2025-04-01 18:10:06.290187', '2', 'K3', 2, '[]', 4, 1),
(5, '2025-04-01 18:10:57.798025', '2', 'K3', 2, '[{\"changed\": {\"fields\": [\"User permissions\"]}}]', 4, 1),
(6, '2025-04-21 14:06:09.486052', '2', 'K3', 2, '[{\"changed\": {\"fields\": [\"password\"]}}]', 4, 1),
(7, '2025-04-21 14:06:49.893326', '2', 'K3', 2, '[]', 4, 1),
(8, '2025-05-01 11:20:47.892826', '1', 'admin1', 2, '[{\"changed\": {\"fields\": [\"First name\", \"Last name\"]}}]', 4, 1);

-- --------------------------------------------------------

--
-- Table structure for table `django_content_type`
--

CREATE TABLE `django_content_type` (
  `id` int(11) NOT NULL,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_content_type`
--

INSERT INTO `django_content_type` (`id`, `app_label`, `model`) VALUES
(1, 'admin', 'logentry'),
(7, 'apd_report', 'pelanggaran'),
(3, 'auth', 'group'),
(2, 'auth', 'permission'),
(4, 'auth', 'user'),
(5, 'contenttypes', 'contenttype'),
(6, 'sessions', 'session');

-- --------------------------------------------------------

--
-- Table structure for table `django_migrations`
--

CREATE TABLE `django_migrations` (
  `id` bigint(20) NOT NULL,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_migrations`
--

INSERT INTO `django_migrations` (`id`, `app`, `name`, `applied`) VALUES
(1, 'contenttypes', '0001_initial', '2025-03-23 00:19:44.118034'),
(2, 'auth', '0001_initial', '2025-03-23 00:19:45.111892'),
(3, 'admin', '0001_initial', '2025-03-23 00:19:45.283001'),
(4, 'admin', '0002_logentry_remove_auto_add', '2025-03-23 00:19:45.301969'),
(5, 'admin', '0003_logentry_add_action_flag_choices', '2025-03-23 00:19:45.326089'),
(6, 'contenttypes', '0002_remove_content_type_name', '2025-03-23 00:19:45.492774'),
(7, 'auth', '0002_alter_permission_name_max_length', '2025-03-23 00:19:45.693803'),
(8, 'auth', '0003_alter_user_email_max_length', '2025-03-23 00:19:45.853338'),
(9, 'auth', '0004_alter_user_username_opts', '2025-03-23 00:19:45.878463'),
(10, 'auth', '0005_alter_user_last_login_null', '2025-03-23 00:19:45.949433'),
(11, 'auth', '0006_require_contenttypes_0002', '2025-03-23 00:19:45.952914'),
(12, 'auth', '0007_alter_validators_add_error_messages', '2025-03-23 00:19:45.970520'),
(13, 'auth', '0008_alter_user_username_max_length', '2025-03-23 00:19:46.022803'),
(14, 'auth', '0009_alter_user_last_name_max_length', '2025-03-23 00:19:46.072551'),
(15, 'auth', '0010_alter_group_name_max_length', '2025-03-23 00:19:46.125504'),
(16, 'auth', '0011_update_proxy_permissions', '2025-03-23 00:19:46.140369'),
(17, 'auth', '0012_alter_user_first_name_max_length', '2025-03-23 00:19:46.190924'),
(18, 'sessions', '0001_initial', '2025-03-23 00:19:46.250506'),
(19, 'apd_report', '0001_initial', '2025-04-14 13:41:53.499103'),
(20, 'apd_report', '0002_alter_pelanggaran_jenis_pelanggaran_and_more', '2025-04-17 17:10:28.221617'),
(21, 'apd_report', '0002_pelanggaran_confidence_pelanggaran_screenshot_path_and_more', '2025-04-22 13:27:34.599529');

-- --------------------------------------------------------

--
-- Table structure for table `django_session`
--

CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `django_session`
--

INSERT INTO `django_session` (`session_key`, `session_data`, `expire_date`) VALUES
('c2asglzu4sch22btmm4z6xfmq2pyb3on', '.eJxVjDsOwjAQBe_iGlnyZ_2hpOcM1nq9xgHkSHFSIe4OkVJA-2bmvUTCbW1pG7ykqYizUOL0u2WkB_cdlDv22yxp7usyZbkr8qBDXufCz8vh_h00HO1bR1KWNVmulhGC0x4MUC1QHVfMEJ2GCAVK1cqQjtEEpyzZgIE8Vy_eH-2YN_k:1uAUd8:p8kbeX5di1XpJNCQh015J3Wd-uHrO7LcddgKvQqQcE8', '2025-05-15 14:11:14.153482'),
('dqkg1i2y5mapzeg58ehez2ejkrxbfd7k', '.eJxVjDsOwjAQBe_iGlnyZ_2hpOcM1nq9xgHkSHFSIe4OkVJA-2bmvUTCbW1pG7ykqYizUOL0u2WkB_cdlDv22yxp7usyZbkr8qBDXufCz8vh_h00HO1bR1KWNVmulhGC0x4MUC1QHVfMEJ2GCAVK1cqQjtEEpyzZgIE8Vy_eH-2YN_k:1uATEq:wJg71Z-Z23_-WxHfg0PfwRWeg_ONFCE-fSgMbVruyjE', '2025-05-15 12:42:04.708170'),
('g5bcdy9djsljrgt1mgksuhmvmnmb893n', '.eJxVjDsOwjAQBe_iGlnyZ_2hpOcM1nq9xgHkSHFSIe4OkVJA-2bmvUTCbW1pG7ykqYizUOL0u2WkB_cdlDv22yxp7usyZbkr8qBDXufCz8vh_h00HO1bR1KWNVmulhGC0x4MUC1QHVfMEJ2GCAVK1cqQjtEEpyzZgIE8Vy_eH-2YN_k:1tzg5E:HYzudpMkzuV4CiUC_B0BaRGjMmexvlLnVIIEsLsTpWQ', '2025-04-15 18:11:32.540551'),
('moniyvyc27d4ld543e7qieyt64qw056y', '.eJxVjDsOwjAQBe_iGlnyZ_2hpOcM1nq9xgHkSHFSIe4OkVJA-2bmvUTCbW1pG7ykqYizUOL0u2WkB_cdlDv22yxp7usyZbkr8qBDXufCz8vh_h00HO1bR1KWNVmulhGC0x4MUC1QHVfMEJ2GCAVK1cqQjtEEpyzZgIE8Vy_eH-2YN_k:1u8LcT:cn9siCNRIxDrTHjh5b5BnNsB7fYQpRgYFdFQY0pih6g', '2025-05-09 16:09:41.085695');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apd_report_pelanggaran`
--
ALTER TABLE `apd_report_pelanggaran`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `auth_group`
--
ALTER TABLE `auth_group`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  ADD KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`);

--
-- Indexes for table `auth_user`
--
ALTER TABLE `auth_user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`);

--
-- Indexes for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  ADD KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`);

--
-- Indexes for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  ADD KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`);

--
-- Indexes for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  ADD KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`);

--
-- Indexes for table `django_content_type`
--
ALTER TABLE `django_content_type`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`);

--
-- Indexes for table `django_migrations`
--
ALTER TABLE `django_migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `django_session`
--
ALTER TABLE `django_session`
  ADD PRIMARY KEY (`session_key`),
  ADD KEY `django_session_expire_date_a5c62663` (`expire_date`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apd_report_pelanggaran`
--
ALTER TABLE `apd_report_pelanggaran`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `auth_group`
--
ALTER TABLE `auth_group`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_permission`
--
ALTER TABLE `auth_permission`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=29;

--
-- AUTO_INCREMENT for table `auth_user`
--
ALTER TABLE `auth_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=25;

--
-- AUTO_INCREMENT for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `django_content_type`
--
ALTER TABLE `django_content_type`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `django_migrations`
--
ALTER TABLE `django_migrations`
  MODIFY `id` bigint(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=22;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `auth_group_permissions`
--
ALTER TABLE `auth_group_permissions`
  ADD CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`);

--
-- Constraints for table `auth_permission`
--
ALTER TABLE `auth_permission`
  ADD CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`);

--
-- Constraints for table `auth_user_groups`
--
ALTER TABLE `auth_user_groups`
  ADD CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  ADD CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `auth_user_user_permissions`
--
ALTER TABLE `auth_user_user_permissions`
  ADD CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  ADD CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);

--
-- Constraints for table `django_admin_log`
--
ALTER TABLE `django_admin_log`
  ADD CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  ADD CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

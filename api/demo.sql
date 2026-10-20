-- Class Compass demo database (Kenya: CBC, KES plans, Compass Academy demo school)
-- Database: `class_compass`
SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


DROP TABLE IF EXISTS `about_us`;
CREATE TABLE `about_us` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `description` longtext DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `about_us_institute_id_foreign` (`institute_id`),
  KEY `about_us_branch_id_foreign` (`branch_id`),
  KEY `about_us_created_by_foreign` (`created_by`),
  KEY `about_us_title_index` (`title`),
  CONSTRAINT `about_us_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `about_us_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `about_us_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `about_us` VALUES (1,1,1,'Welcome to Compass Academy','Compass Academy is a CBC day and boarding school in Nairobi for learners from PP1 to Grade 9. We combine strong foundations in literacy and numeracy with practical projects, clubs, sports and values education, so every learner discovers and grows their talent.','about-compass-academy.jpg',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `absent_fines`;
CREATE TABLE `absent_fines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `period_id` bigint(20) unsigned NOT NULL,
  `fee_amount` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `absent_fines_institute_id_foreign` (`institute_id`),
  KEY `absent_fines_branch_id_foreign` (`branch_id`),
  KEY `absent_fines_class_id_index` (`class_id`),
  CONSTRAINT `absent_fines_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `absent_fines_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `academic_images`;
CREATE TABLE `academic_images` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) DEFAULT NULL,
  `heading` text DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `academic_images_institute_id_foreign` (`institute_id`),
  KEY `academic_images_created_by_foreign` (`created_by`),
  CONSTRAINT `academic_images_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `academic_images_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `academic_years`;
CREATE TABLE `academic_years` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `session` varchar(50) NOT NULL,
  `year` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `academic_years` VALUES (1,'2024','2024-2025','2026-03-30 11:21:06','2026-03-30 11:21:06'),(2,'2025','2025-2026','2026-03-30 11:21:06','2026-03-30 11:21:06'),(3,'2026','2026-2027','2026-03-30 11:21:06','2026-03-30 11:21:06'),(4,'2027','2027-2028','2026-03-30 11:21:06','2026-03-30 11:21:06');
DROP TABLE IF EXISTS `account_transaction_details`;
CREATE TABLE `account_transaction_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `account_transactions_id` bigint(20) unsigned NOT NULL,
  `fund_id` bigint(20) unsigned DEFAULT NULL,
  `fund_to_id` bigint(20) unsigned DEFAULT NULL,
  `ledger_id` bigint(20) unsigned DEFAULT NULL,
  `payment_method_id` bigint(20) unsigned DEFAULT NULL,
  `payment_method_to_id` bigint(20) unsigned DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `debit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `credit` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_transaction_details_institute_id_foreign` (`institute_id`),
  KEY `account_transaction_details_branch_id_foreign` (`branch_id`),
  KEY `account_transaction_details_account_transactions_id_index` (`account_transactions_id`),
  CONSTRAINT `account_transaction_details_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `account_transaction_details_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `account_transactions`;
CREATE TABLE `account_transactions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `voucher_id` bigint(20) unsigned DEFAULT NULL,
  `category_id` bigint(20) unsigned DEFAULT NULL,
  `fund_id` bigint(20) unsigned DEFAULT NULL,
  `fund_to_id` bigint(20) unsigned DEFAULT NULL,
  `payment_method_id` bigint(20) unsigned DEFAULT NULL,
  `payment_method_to_id` bigint(20) unsigned DEFAULT NULL,
  `transaction_date` date NOT NULL,
  `type` enum('payment','receipt','contra','fund_transfer','journal') NOT NULL,
  `reference` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `account_transactions_institute_id_foreign` (`institute_id`),
  KEY `account_transactions_branch_id_foreign` (`branch_id`),
  KEY `account_transactions_voucher_id_fund_id_index` (`voucher_id`,`fund_id`),
  CONSTRAINT `account_transactions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `account_transactions_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `accounting_categories`;
CREATE TABLE `accounting_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `nature` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`name`),
  KEY `accounting_categories_branch_id_foreign` (`branch_id`),
  CONSTRAINT `accounting_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `accounting_categories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `accounting_categories` VALUES (1,1,1,'Cash & Cash Equivalence',NULL,'Assets','debit',NULL,NULL),(2,1,1,'Current Liabilities',NULL,'Liabilities','credit',NULL,NULL),(3,1,1,'Non-Current Liabilities',NULL,'Liabilities','credit',NULL,NULL),(4,1,1,'Owner’s Equity',NULL,'Liabilities','credit',NULL,NULL),(5,1,1,'Fees Related Income',NULL,'Income','credit',NULL,NULL),(6,1,1,'Others Income',NULL,'Income','credit',NULL,NULL),(7,1,1,'General Expenses',NULL,'Expense','debit',NULL,NULL);
DROP TABLE IF EXISTS `accounting_funds`;
CREATE TABLE `accounting_funds` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `serial` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `cash_in` decimal(10,2) NOT NULL DEFAULT 0.00,
  `cash_out` decimal(10,2) NOT NULL DEFAULT 0.00,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`name`),
  KEY `accounting_funds_branch_id_foreign` (`branch_id`),
  CONSTRAINT `accounting_funds_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `accounting_funds_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `accounting_funds` VALUES (1,1,1,1,'General Fund',102000.00,0.00,162000.00,'2026-03-30 11:21:12','2026-10-19 16:45:40');
DROP TABLE IF EXISTS `accounting_groups`;
CREATE TABLE `accounting_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `accounting_category_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`accounting_category_id`,`name`),
  KEY `accounting_groups_branch_id_foreign` (`branch_id`),
  CONSTRAINT `accounting_groups_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `accounting_groups_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `accounting_groups` VALUES (1,1,1,1,'Cash',NULL,NULL),(2,1,1,1,'Digital Payment',NULL,NULL),(3,1,1,2,'Accounts Payable',NULL,NULL),(4,1,1,3,'Long Term Loan',NULL,NULL),(5,1,1,4,'Opening Balance Equity',NULL,NULL),(6,1,1,5,'Income From Fees',NULL,NULL),(7,1,1,5,'Income From Fine',NULL,NULL),(8,1,1,6,'Rental Income',NULL,NULL),(9,1,1,6,'Old Things Sells Income',NULL,NULL),(10,1,1,6,'Others Miscellaneous Income',NULL,NULL),(11,1,1,6,'Donation',NULL,NULL),(12,1,1,7,'Advertising / Promotional',NULL,NULL),(13,1,1,7,'Occasional Expenses',NULL,NULL),(14,1,1,7,'Bank Charge',NULL,NULL),(15,1,1,7,'Others Miscellaneous Expenses',NULL,NULL),(16,1,1,7,'Convenience Expenses',NULL,NULL),(17,1,1,7,'Utilities Expenses',NULL,NULL),(18,1,1,7,'Meals &amp; Entertainment',NULL,NULL),(19,1,1,7,'Exam Expenses',NULL,NULL),(20,1,1,7,'Rental Expenses',NULL,NULL),(21,1,1,7,'Software Charge',NULL,NULL),(22,1,1,7,'Stationary Expenses',NULL,NULL),(23,1,1,7,'Repair & Maintenance',NULL,NULL),(24,1,1,7,'Payroll Expenses',NULL,NULL);
DROP TABLE IF EXISTS `accounting_ledgers`;
CREATE TABLE `accounting_ledgers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `ledger_name` varchar(191) NOT NULL,
  `accounting_category_id` bigint(20) unsigned DEFAULT NULL,
  `accounting_group_id` bigint(20) unsigned DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `type` enum('payment','default') NOT NULL DEFAULT 'default',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`ledger_name`),
  KEY `accounting_ledgers_branch_id_foreign` (`branch_id`),
  CONSTRAINT `accounting_ledgers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `accounting_ledgers_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `accounting_ledgers` VALUES (1,1,1,'Cash',1,1,0.00,'default',NULL,NULL),(2,1,1,'Digital Payment',1,2,0.00,'default',NULL,NULL),(3,1,1,'Accounts Payable',2,3,0.00,'default',NULL,NULL),(4,1,1,'Tuition Fee Refund',2,3,0.00,'default',NULL,NULL),(5,1,1,'Director`s Loan ',3,4,0.00,'default',NULL,NULL),(6,1,1,'Opening Balance Equity',4,5,0.00,'default',NULL,NULL),(7,1,1,'Admission Fees Collection',5,6,135000.00,'default',NULL,'2026-10-19 16:45:40'),(8,1,1,'Board Fees Collection',5,6,0.00,'default',NULL,NULL),(9,1,1,'Dairy And Syllabuss Collection',5,6,0.00,'default',NULL,NULL),(10,1,1,'Exam Fees Collection',5,6,0.00,'default',NULL,NULL),(11,1,1,'Fee Collections Collection',5,6,0.00,'default',NULL,NULL),(12,1,1,'Session Charge Collection',5,6,0.00,'default',NULL,NULL),(13,1,1,'Study Materials Fees Collection',5,6,0.00,'default',NULL,NULL),(14,1,1,'TC Fees Collection',5,6,0.00,'default',NULL,NULL),(15,1,1,'Testimonial Fees Collection',5,6,0.00,'default',NULL,NULL),(16,1,1,'Tie And Id Card Collection',5,6,0.00,'default',NULL,NULL),(17,1,1,'Tuition Fees Collection',5,6,27000.00,'default',NULL,NULL),(18,1,1,'Attendance Fine',5,7,0.00,'default',NULL,NULL),(19,1,1,'Quiz Fine',5,7,0.00,'default',NULL,NULL),(20,1,1,'Lab Fine',5,7,0.00,'default',NULL,NULL),(21,1,1,'Tuition Fee Fin',5,7,0.00,'default',NULL,NULL),(22,1,1,'Late Fine',5,7,0.00,'default',NULL,NULL),(23,1,1,'Attendance Make up Fine',5,7,0.00,'default',NULL,NULL),(24,1,1,'Laboratories Class Fine',5,7,0.00,'default',NULL,NULL),(25,1,1,'ID Card Fine',5,7,0.00,'default',NULL,NULL),(26,1,1,'Discipline Fine',5,7,0.00,'default',NULL,NULL),(27,1,1,'Library Fine',5,7,0.00,'default',NULL,NULL),(28,1,1,'Miscellaneous Fine',5,7,0.00,'default',NULL,NULL),(29,1,1,'House Rent(Cr)',6,8,0.00,'default',NULL,NULL),(30,1,1,'Old Paper Sells',6,9,0.00,'default',NULL,NULL),(31,1,1,'Online Apply Fee',6,10,0.00,'default',NULL,NULL),(32,1,1,'Opening Balance',6,11,0.00,'default',NULL,NULL),(33,1,1,'Advertisement',7,12,0.00,'default',NULL,NULL),(34,1,1,'Anual Sports',7,13,0.00,'default',NULL,NULL),(35,1,1,'National Day &amp; Fastival Expanse',7,13,0.00,'default',NULL,NULL),(36,1,1,'Ocation',7,13,0.00,'default',NULL,NULL),(37,1,1,'Study Tour',7,13,0.00,'default',NULL,NULL),(38,1,1,'Bank Charges',7,14,0.00,'default',NULL,NULL),(39,1,1,'Board Fee',7,15,0.00,'default',NULL,NULL),(40,1,1,'Miscellaneous Exp.',7,15,0.00,'default',NULL,NULL),(41,1,1,'Office Expense',7,15,0.00,'default',NULL,NULL),(42,1,1,'Conveyance Expenses',7,16,0.00,'default',NULL,NULL),(43,1,1,'Electricity Bill',7,17,0.00,'default',NULL,NULL),(44,1,1,'Internet Bill',7,17,0.00,'default',NULL,NULL),(45,1,1,'Mobile Recharge Exp.',7,17,0.00,'default',NULL,NULL),(46,1,1,'Entertainment Exp.',7,18,0.00,'default',NULL,NULL),(47,1,1,'Exam Centre Fee',7,19,0.00,'default',NULL,NULL),(48,1,1,'Exam Expenses',7,19,0.00,'default',NULL,NULL),(49,1,1,'House Rent',7,20,0.00,'default',NULL,NULL),(50,1,1,'Netizen Bill Payment',7,21,0.00,'default',NULL,NULL),(51,1,1,'Office Stationary',7,22,0.00,'default',NULL,NULL),(52,1,1,'Printing & Stationary Expense',7,22,0.00,'default',NULL,NULL),(53,1,1,'Repair Expenses',7,23,0.00,'default',NULL,NULL),(54,1,1,'Salary & Honorarium (Bank Payment)',7,24,0.00,'default',NULL,NULL),(55,1,1,'Salary & Honorarium (Cash Payment)',7,24,0.00,'default',NULL,NULL);
DROP TABLE IF EXISTS `assign_shifts`;
CREATE TABLE `assign_shifts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `teacher_id` bigint(20) unsigned NOT NULL,
  `shift_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assign_shifts_institute_id_foreign` (`institute_id`),
  KEY `assign_shifts_branch_id_foreign` (`branch_id`),
  KEY `assign_shifts_teacher_id_shift_id_index` (`teacher_id`,`shift_id`),
  CONSTRAINT `assign_shifts_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assign_shifts_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `assign_subjects`;
CREATE TABLE `assign_subjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `subject_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assign_subjects_institute_id_foreign` (`institute_id`),
  KEY `assign_subjects_branch_id_foreign` (`branch_id`),
  KEY `assign_subjects_subject_id_index` (`subject_id`),
  CONSTRAINT `assign_subjects_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assign_subjects_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `assignment_submits`;
CREATE TABLE `assignment_submits` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `session_id` int(11) NOT NULL,
  `assignment_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `file` varchar(100) NOT NULL,
  `file_2` varchar(100) DEFAULT NULL,
  `file_3` varchar(100) DEFAULT NULL,
  `file_4` varchar(100) DEFAULT NULL,
  `result` double NOT NULL DEFAULT 0,
  `reviewed_by` bigint(20) unsigned DEFAULT NULL,
  `review_description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assignment_submits_institute_id_foreign` (`institute_id`),
  KEY `assignment_submits_branch_id_foreign` (`branch_id`),
  KEY `assignment_submits_reviewed_by_foreign` (`reviewed_by`),
  CONSTRAINT `assignment_submits_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assignment_submits_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assignment_submits_reviewed_by_foreign` FOREIGN KEY (`reviewed_by`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `assignments`;
CREATE TABLE `assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `session_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `deadline` date NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `file` varchar(100) NOT NULL,
  `file_2` varchar(100) DEFAULT NULL,
  `file_3` varchar(100) DEFAULT NULL,
  `file_4` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `assignments_institute_id_foreign` (`institute_id`),
  KEY `assignments_branch_id_foreign` (`branch_id`),
  KEY `assignments_class_id_section_id_index` (`class_id`,`section_id`),
  CONSTRAINT `assignments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assignments_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `attendance_fines`;
CREATE TABLE `attendance_fines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `fine_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `waiver` decimal(8,2) NOT NULL DEFAULT 0.00,
  `type` enum('attendance_absent_fine','attendance_quiz_fine','attendance_lab_fine') NOT NULL DEFAULT 'attendance_absent_fine',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_fines_institute_id_foreign` (`institute_id`),
  KEY `attendance_fines_branch_id_foreign` (`branch_id`),
  KEY `attendance_fines_student_id_index` (`student_id`),
  CONSTRAINT `attendance_fines_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_fines_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `attendance_waivers`;
CREATE TABLE `attendance_waivers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `attendance_fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `quiz_fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `lab_fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_waiver` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `attendance_waivers_institute_id_foreign` (`institute_id`),
  KEY `attendance_waivers_branch_id_foreign` (`branch_id`),
  CONSTRAINT `attendance_waivers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `attendance_waivers_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `banners`;
CREATE TABLE `banners` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `button_name` varchar(100) DEFAULT NULL,
  `button_link` varchar(500) DEFAULT NULL,
  `image` varchar(255) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `banners_institute_id_foreign` (`institute_id`),
  KEY `banners_branch_id_foreign` (`branch_id`),
  KEY `banners_created_by_foreign` (`created_by`),
  CONSTRAINT `banners_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `banners_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `banners_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `banners` VALUES (1,1,1,'Admissions open for the 2027 intake','PP1 to Grade 9 under CBC. Book a school visit or apply online today.','Apply now','#','school-admissions.jpg',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,'Nurturing skills, values and talent','Hands-on CBC learning, STEM clubs, sports and the arts for every learner.','Our programmes','#','school-academics.jpg',1,NULL,'2026-10-19 12:52:09','2026-10-19 12:52:09',NULL),(3,1,1,'Stay connected to your child\'s progress','Live report cards, notices and convenient fee payment by M-Pesa.','Parent portal','#','school-community.jpg',1,NULL,'2026-10-19 12:52:09','2026-10-19 12:52:09',NULL);
DROP TABLE IF EXISTS `behaviors`;
CREATE TABLE `behaviors` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  `date` varchar(191) DEFAULT NULL,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `behaviors_institute_id_foreign` (`institute_id`),
  KEY `behaviors_branch_id_foreign` (`branch_id`),
  CONSTRAINT `behaviors_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `behaviors_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `book_categories`;
CREATE TABLE `book_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `category_name` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `book_categories_institute_id_foreign` (`institute_id`),
  KEY `book_categories_branch_id_foreign` (`branch_id`),
  CONSTRAINT `book_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `book_categories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `book_categories` VALUES (1,1,1,'General','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Fiction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'Science Fiction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'Mystery','2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Non-Fiction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'Fantasy','2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,'Others','2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,2,'General','2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,2,'Fiction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,2,'Science Fiction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(11,1,2,'Mystery','2026-03-30 11:21:12','2026-03-30 11:21:12'),(12,1,2,'Non-Fiction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(13,1,2,'Fantasy','2026-03-30 11:21:12','2026-03-30 11:21:12'),(14,1,2,'Others','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `book_issues`;
CREATE TABLE `book_issues` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `book_id` int(11) NOT NULL,
  `library_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `note` text DEFAULT NULL,
  `issue_date` date NOT NULL,
  `due_date` date NOT NULL,
  `return_date` date DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `teacher_id` bigint(20) unsigned DEFAULT NULL,
  `student_id` bigint(20) unsigned DEFAULT NULL,
  `staff_id` bigint(20) unsigned DEFAULT NULL,
  `type` varchar(20) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `book_issues_institute_id_foreign` (`institute_id`),
  KEY `book_issues_branch_id_foreign` (`branch_id`),
  KEY `book_issues_book_id_library_id_user_id_index` (`book_id`,`library_id`,`user_id`),
  CONSTRAINT `book_issues_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `book_issues_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `books`;
CREATE TABLE `books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `datetime` date DEFAULT NULL,
  `code` varchar(100) DEFAULT NULL,
  `book_group` int(11) DEFAULT NULL,
  `book_name` varchar(255) DEFAULT NULL,
  `book_copy_no` varchar(255) DEFAULT NULL,
  `publisher` varchar(255) DEFAULT NULL,
  `publish_year` varchar(255) DEFAULT NULL,
  `provider` varchar(255) DEFAULT NULL,
  `total_page` varchar(255) DEFAULT NULL,
  `identification_page` varchar(255) DEFAULT NULL,
  `aa` varchar(255) DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `edition` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `category` varchar(255) DEFAULT NULL,
  `quantity` varchar(191) DEFAULT NULL,
  `price` varchar(255) DEFAULT NULL,
  `bookself` varchar(255) DEFAULT NULL,
  `rack` varchar(255) DEFAULT NULL,
  `path` text DEFAULT NULL,
  `status` varchar(100) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `books_institute_id_foreign` (`institute_id`),
  KEY `books_branch_id_foreign` (`branch_id`),
  CONSTRAINT `books_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `books_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `books` VALUES (1,1,1,NULL,'MAT7-438383',NULL,'Spotlight Mathematics Grade 7',NULL,'Spotlight',NULL,NULL,NULL,NULL,NULL,'Spotlight Publishers',NULL,NULL,'Mathematics','5',NULL,NULL,NULL,NULL,NULL,'2026-10-19 16:33:04','2026-10-19 16:33:04'),(2,1,1,NULL,'MAT7-439074',NULL,'Spotlight Mathematics Grade 7',NULL,'Spotlight',NULL,NULL,NULL,NULL,NULL,'Spotlight Publishers',NULL,NULL,'Mathematics','5',NULL,NULL,NULL,NULL,NULL,'2026-10-19 16:44:36','2026-10-19 16:44:36');
DROP TABLE IF EXISTS `branches`;
CREATE TABLE `branches` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `branches_institute_id_foreign` (`institute_id`),
  CONSTRAINT `branches_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `branches` VALUES (1,1,'Main Campus',1,'2026-03-30 11:21:04','2026-03-30 11:21:04'),(2,1,'Westlands Campus',1,'2026-03-30 11:21:04','2026-03-30 11:21:04');
DROP TABLE IF EXISTS `bus_routes`;
CREATE TABLE `bus_routes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `route_name` varchar(100) NOT NULL,
  `start_location` varchar(191) NOT NULL,
  `end_location` varchar(191) NOT NULL,
  `total_distance` decimal(5,2) NOT NULL,
  `estimated_time` time NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bus_routes_institute_id_foreign` (`institute_id`),
  KEY `bus_routes_branch_id_foreign` (`branch_id`),
  CONSTRAINT `bus_routes_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bus_routes_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `bus_stops`;
CREATE TABLE `bus_stops` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `route_id` bigint(20) unsigned NOT NULL,
  `stop_name` varchar(100) NOT NULL,
  `latitude` decimal(10,8) NOT NULL,
  `longitude` decimal(11,8) NOT NULL,
  `stop_order` int(11) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bus_stops_institute_id_foreign` (`institute_id`),
  KEY `bus_stops_branch_id_foreign` (`branch_id`),
  KEY `bus_stops_route_id_foreign` (`route_id`),
  CONSTRAINT `bus_stops_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bus_stops_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `bus_stops_route_id_foreign` FOREIGN KEY (`route_id`) REFERENCES `bus_routes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `buses`;
CREATE TABLE `buses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `bus_number` varchar(50) NOT NULL,
  `model` varchar(100) NOT NULL,
  `capacity` int(11) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `buses_institute_id_foreign` (`institute_id`),
  KEY `buses_branch_id_foreign` (`branch_id`),
  CONSTRAINT `buses_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `buses_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `cache`;
CREATE TABLE `cache` (
  `key` varchar(191) NOT NULL,
  `value` mediumtext NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `cache_locks`;
CREATE TABLE `cache_locks` (
  `key` varchar(191) NOT NULL,
  `owner` varchar(191) NOT NULL,
  `expiration` int(11) NOT NULL,
  PRIMARY KEY (`key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `chapters`;
CREATE TABLE `chapters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `image` varchar(191) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `status` enum('active','inactive','draft') NOT NULL DEFAULT 'inactive' COMMENT 'Chapter status: active, inactive, draft',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `chapters_institute_id_foreign` (`institute_id`),
  KEY `chapters_course_id_foreign` (`course_id`),
  KEY `chapters_created_by_foreign` (`created_by`),
  CONSTRAINT `chapters_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `chapters_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `chapters_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `class_assigns`;
CREATE TABLE `class_assigns` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `teacher_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `class_assigns_institute_id_foreign` (`institute_id`),
  KEY `class_assigns_branch_id_foreign` (`branch_id`),
  KEY `class_assigns_teacher_id_class_id_index` (`teacher_id`,`class_id`),
  CONSTRAINT `class_assigns_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_assigns_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `class_days`;
CREATE TABLE `class_days` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `day` varchar(30) NOT NULL,
  `is_active` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `class_days_institute_id_foreign` (`institute_id`),
  KEY `class_days_branch_id_foreign` (`branch_id`),
  CONSTRAINT `class_days_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_days_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `class_days` VALUES (1,1,1,'SATURDAY',1,NULL,NULL),(2,1,1,'SUNDAY',1,NULL,NULL),(3,1,1,'MONDAY',1,NULL,NULL),(4,1,1,'TUESDAY',1,NULL,NULL),(5,1,1,'WEDNESDAY',1,NULL,NULL),(6,1,1,'THURSDAY',1,NULL,NULL),(7,1,1,'FRIDAY',1,NULL,NULL);
DROP TABLE IF EXISTS `class_exams`;
CREATE TABLE `class_exams` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `exam_id` bigint(20) unsigned NOT NULL,
  `merit_process_type_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `class_exams_institute_id_foreign` (`institute_id`),
  KEY `class_exams_branch_id_foreign` (`branch_id`),
  KEY `class_exams_class_id_foreign` (`class_id`),
  KEY `class_exams_exam_id_foreign` (`exam_id`),
  KEY `class_exams_merit_process_type_id_foreign` (`merit_process_type_id`),
  CONSTRAINT `class_exams_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_exams_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_exams_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_exams_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_exams_merit_process_type_id_foreign` FOREIGN KEY (`merit_process_type_id`) REFERENCES `merit_process_types` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `class_lessons`;
CREATE TABLE `class_lessons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  `date` varchar(255) NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `note` varchar(255) NOT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_2` varchar(255) DEFAULT NULL,
  `file_3` varchar(255) DEFAULT NULL,
  `file_4` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `class_lessons_institute_id_foreign` (`institute_id`),
  KEY `class_lessons_branch_id_foreign` (`branch_id`),
  CONSTRAINT `class_lessons_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_lessons_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `class_routines`;
CREATE TABLE `class_routines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `subject_id` bigint(20) unsigned NOT NULL,
  `day` varchar(20) NOT NULL,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `teacher_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `start_end_teacher_unique` (`day`,`start_time`,`end_time`,`teacher_id`),
  KEY `class_routines_institute_id_foreign` (`institute_id`),
  KEY `class_routines_branch_id_foreign` (`branch_id`),
  KEY `class_routines_class_id_foreign` (`class_id`),
  KEY `class_routines_subject_id_foreign` (`subject_id`),
  KEY `class_routines_section_id_subject_id_teacher_id_index` (`section_id`,`subject_id`,`teacher_id`),
  CONSTRAINT `class_routines_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_routines_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  CONSTRAINT `class_routines_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `class_routines_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`),
  CONSTRAINT `class_routines_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `classes`;
CREATE TABLE `classes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_name` varchar(20) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `classes_institute_id_foreign` (`institute_id`),
  KEY `classes_branch_id_foreign` (`branch_id`),
  CONSTRAINT `classes_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `classes_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `classes` VALUES (1,1,1,'Class 1',1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Class 2',1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'PP1',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(4,1,1,'PP2',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(5,1,1,'Grade 1',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(6,1,1,'Grade 2',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(7,1,1,'Grade 3',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(8,1,1,'Grade 4',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(9,1,1,'Grade 5',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(10,1,1,'Grade 6',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(11,1,1,'Grade 7',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(12,1,1,'Grade 8',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(13,1,1,'Grade 9',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(14,1,1,'Grade 10',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(15,1,1,'Grade 11',1,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(16,1,1,'Grade 12',1,'2026-10-19 09:03:40','2026-10-19 09:03:40');
DROP TABLE IF EXISTS `client_licenses`;
CREATE TABLE `client_licenses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `plan_id` bigint(20) unsigned DEFAULT NULL,
  `license_key` varchar(191) NOT NULL,
  `status` enum('active','expired','suspended','revoked') NOT NULL DEFAULT 'active',
  `issued_at` date DEFAULT NULL,
  `expires_at` date DEFAULT NULL,
  `student_limit` int(11) NOT NULL DEFAULT 0,
  `branch_limit` int(11) NOT NULL DEFAULT 0,
  `notes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_licenses_license_key_unique` (`license_key`),
  KEY `client_licenses_institute_id_foreign` (`institute_id`),
  KEY `client_licenses_plan_id_foreign` (`plan_id`),
  CONSTRAINT `client_licenses_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `client_licenses_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `contacts`;
CREATE TABLE `contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `email` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `message` text NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `isSeen` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `contacts_institute_id_foreign` (`institute_id`),
  KEY `contacts_branch_id_foreign` (`branch_id`),
  KEY `contacts_user_id_isseen_index` (`user_id`,`isSeen`),
  CONSTRAINT `contacts_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contacts_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `content_visibility`;
CREATE TABLE `content_visibility` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `chapter_id` bigint(20) unsigned NOT NULL,
  `content_id` bigint(20) unsigned NOT NULL,
  `is_enabled` tinyint(1) NOT NULL DEFAULT 1,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `content_visibility_institute_id_foreign` (`institute_id`),
  KEY `content_visibility_course_id_foreign` (`course_id`),
  KEY `content_visibility_chapter_id_foreign` (`chapter_id`),
  KEY `content_visibility_created_by_foreign` (`created_by`),
  CONSTRAINT `content_visibility_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_visibility_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_visibility_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `content_visibility_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `contents`;
CREATE TABLE `contents` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `chapter_id` bigint(20) unsigned NOT NULL,
  `type` enum('lesson','quiz','assignment','pdf','offline') NOT NULL,
  `type_id` bigint(20) unsigned NOT NULL,
  `serial` int(10) unsigned NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `contents_chapter_id_type_type_id_unique` (`chapter_id`,`type`,`type_id`),
  KEY `contents_institute_id_foreign` (`institute_id`),
  CONSTRAINT `contents_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `contents_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `course_categories`;
CREATE TABLE `course_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `bg_color` varchar(7) DEFAULT NULL,
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `enable_homepage` tinyint(1) NOT NULL DEFAULT 1,
  `description` longtext DEFAULT NULL,
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_categories_institute_id_foreign` (`institute_id`),
  KEY `course_categories_parent_id_foreign` (`parent_id`),
  KEY `course_categories_created_by_foreign` (`created_by`),
  CONSTRAINT `course_categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `course_categories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_categories_parent_id_foreign` FOREIGN KEY (`parent_id`) REFERENCES `course_categories` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `course_faqs`;
CREATE TABLE `course_faqs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` longtext DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_faqs_institute_id_foreign` (`institute_id`),
  KEY `course_faqs_course_id_foreign` (`course_id`),
  KEY `course_faqs_created_by_foreign` (`created_by`),
  CONSTRAINT `course_faqs_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_faqs_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `course_faqs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `course_features`;
CREATE TABLE `course_features` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `name` varchar(255) NOT NULL,
  `priority` longtext DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `course_features_institute_id_foreign` (`institute_id`),
  KEY `course_features_course_id_foreign` (`course_id`),
  KEY `course_features_created_by_foreign` (`created_by`),
  CONSTRAINT `course_features_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `course_features_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `course_features_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `courses`;
CREATE TABLE `courses` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `course_category_id` bigint(20) unsigned NOT NULL,
  `course_sub_category_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `video_type` varchar(191) DEFAULT NULL,
  `video_url` longtext DEFAULT NULL,
  `embedded_url` longtext DEFAULT NULL,
  `uploaded_video_path` varchar(191) DEFAULT NULL,
  `status` enum('draft','schedule','published','private') NOT NULL DEFAULT 'draft' COMMENT 'Course status: draft, schedule, published, private',
  `publish_date` date DEFAULT NULL,
  `type` enum('single','bundle') NOT NULL DEFAULT 'single' COMMENT 'Course type: single, bundle',
  `payment_type` enum('free','recurring_payment','one_time') NOT NULL DEFAULT 'free',
  `invoice_title` varchar(191) DEFAULT NULL,
  `fake_enrolled_students` int(11) NOT NULL DEFAULT 0,
  `total_classes` int(11) NOT NULL DEFAULT 0,
  `total_notes` int(11) NOT NULL DEFAULT 0,
  `total_exams` int(11) NOT NULL DEFAULT 0,
  `regular_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `offer_price` decimal(10,2) NOT NULL DEFAULT 0.00,
  `repeat_count` int(11) NOT NULL DEFAULT 0,
  `payment_duration` varchar(191) DEFAULT NULL,
  `total_cycles` int(11) DEFAULT NULL,
  `is_infinity` tinyint(1) NOT NULL DEFAULT 0,
  `is_auto_generate_invoice` tinyint(1) NOT NULL DEFAULT 0,
  `class_routine_image` varchar(191) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `meta_description` text DEFAULT NULL,
  `meta_keywords` text DEFAULT NULL,
  `total_view` int(10) unsigned NOT NULL DEFAULT 0,
  `total_enrolled` int(10) unsigned NOT NULL DEFAULT 0,
  `avg_rating` decimal(10,2) NOT NULL DEFAULT 0.00,
  `start_date` date DEFAULT NULL,
  `end_date` date DEFAULT NULL,
  `requirements` text DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `courses_institute_id_foreign` (`institute_id`),
  KEY `courses_branch_id_foreign` (`branch_id`),
  KEY `courses_course_category_id_foreign` (`course_category_id`),
  KEY `courses_course_sub_category_id_foreign` (`course_sub_category_id`),
  KEY `courses_created_by_foreign` (`created_by`),
  CONSTRAINT `courses_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `courses_course_category_id_foreign` FOREIGN KEY (`course_category_id`) REFERENCES `course_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `courses_course_sub_category_id_foreign` FOREIGN KEY (`course_sub_category_id`) REFERENCES `course_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `courses_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `courses_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `custom_field_values`;
CREATE TABLE `custom_field_values` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `custom_field_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  `value` text DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `custom_field_values_model_type_model_id_index` (`model_type`,`model_id`),
  KEY `custom_field_values_institute_id_index` (`institute_id`),
  KEY `custom_field_values_branch_id_index` (`branch_id`),
  KEY `custom_field_values_custom_field_id_index` (`custom_field_id`),
  CONSTRAINT `custom_field_values_custom_field_id_foreign` FOREIGN KEY (`custom_field_id`) REFERENCES `custom_fields` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `custom_fields`;
CREATE TABLE `custom_fields` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `module` varchar(191) NOT NULL DEFAULT 'student' COMMENT 'student, teacher, employee',
  `field_name` varchar(191) NOT NULL COMMENT 'database key e.g blood_group',
  `label` varchar(191) NOT NULL COMMENT 'Display label',
  `field_type` varchar(191) NOT NULL DEFAULT 'text' COMMENT 'text, number, select, date, checkbox',
  `options` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL COMMENT 'For select, checkbox options' CHECK (json_valid(`options`)),
  `is_required` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_form` tinyint(1) NOT NULL DEFAULT 1,
  `show_in_list` tinyint(1) NOT NULL DEFAULT 0,
  `show_in_profile` tinyint(1) NOT NULL DEFAULT 1,
  `serial` int(11) NOT NULL DEFAULT 0,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `custom_fields_institute_id_branch_id_module_index` (`institute_id`,`branch_id`,`module`),
  KEY `custom_fields_institute_id_index` (`institute_id`),
  KEY `custom_fields_branch_id_index` (`branch_id`),
  KEY `custom_fields_field_name_index` (`field_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `departments`;
CREATE TABLE `departments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `department_name` varchar(30) NOT NULL,
  `slug` varchar(40) NOT NULL,
  `priority` int(11) NOT NULL DEFAULT 100,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`department_name`),
  KEY `departments_branch_id_foreign` (`branch_id`),
  CONSTRAINT `departments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `departments_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=45 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `departments` VALUES (1,1,1,'Bangla','bangla',1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'English','english',2,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'ICT','ict',3,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'Math','math',4,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Physics','physics',5,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'Chemistry','chemistry',6,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,'Biology','biology',7,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,1,'Humanities','humanities',8,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,1,'Business Studies','business-studies',9,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,1,'Administration','administration',10,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(11,1,1,'Principal Office','principal-office',11,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(12,1,1,'Academic/Main Office','academic-main-office',12,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(13,1,1,'Exam','exam',13,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(14,1,1,'Account','account',14,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(15,1,1,'Guidance','guidance',15,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(16,1,1,'Information & Technology','information-&-technology',16,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(17,1,1,'Laboratories','laboratories',17,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(18,1,1,'Library','library',18,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(19,1,1,'Store Room','store-room',19,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(20,1,1,'Maintenance','maintenance',20,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(21,1,1,'Bookstore','bookstore',21,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(22,1,1,'Student Work Program','student-work-program',22,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(23,1,2,'Bangla','bangla',1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(24,1,2,'English','english',2,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(25,1,2,'ICT','ict',3,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(26,1,2,'Math','math',4,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(27,1,2,'Physics','physics',5,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(28,1,2,'Chemistry','chemistry',6,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(29,1,2,'Biology','biology',7,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(30,1,2,'Humanities','humanities',8,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(31,1,2,'Business Studies','business-studies',9,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(32,1,2,'Administration','administration',10,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(33,1,2,'Principal Office','principal-office',11,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(34,1,2,'Academic/Main Office','academic-main-office',12,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(35,1,2,'Exam','exam',13,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(36,1,2,'Account','account',14,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(37,1,2,'Guidance','guidance',15,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(38,1,2,'Information & Technology','information-&-technology',16,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(39,1,2,'Laboratories','laboratories',17,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(40,1,2,'Library','library',18,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(41,1,2,'Store Room','store-room',19,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(42,1,2,'Maintenance','maintenance',20,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(43,1,2,'Bookstore','bookstore',21,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(44,1,2,'Student Work Program','student-work-program',22,'2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `device_controls`;
CREATE TABLE `device_controls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `device_access_type` enum('single','multiple','unlimited') NOT NULL DEFAULT 'single',
  `device_limit` int(10) unsigned DEFAULT NULL COMMENT 'Applicable only for multiple',
  `is_active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `device_controls_student_id_foreign` (`student_id`),
  CONSTRAINT `device_controls_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `drivers`;
CREATE TABLE `drivers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `phone_number` varchar(25) NOT NULL,
  `license_number` varchar(50) NOT NULL,
  `assigned_bus_id` bigint(20) unsigned DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `drivers_institute_id_foreign` (`institute_id`),
  KEY `drivers_branch_id_foreign` (`branch_id`),
  KEY `drivers_assigned_bus_id_foreign` (`assigned_bus_id`),
  CONSTRAINT `drivers_assigned_bus_id_foreign` FOREIGN KEY (`assigned_bus_id`) REFERENCES `buses` (`id`) ON DELETE SET NULL,
  CONSTRAINT `drivers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `drivers_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `enrollments`;
CREATE TABLE `enrollments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `enrollment_type` enum('one_time','monthly_subscription') NOT NULL DEFAULT 'one_time',
  `enrollment_date` date NOT NULL,
  `subscription_start` timestamp NULL DEFAULT NULL,
  `subscription_end` timestamp NULL DEFAULT NULL,
  `amount_paid` decimal(8,2) NOT NULL DEFAULT 0.00,
  `status` enum('active','inactive','blocked') NOT NULL DEFAULT 'inactive' COMMENT 'Enrollment status: active, inactive, blocked',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `enrollments_course_id_user_id_unique` (`course_id`,`user_id`),
  KEY `enrollments_institute_id_foreign` (`institute_id`),
  KEY `enrollments_user_id_foreign` (`user_id`),
  CONSTRAINT `enrollments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollments_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `enrollments_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `events`;
CREATE TABLE `events` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `start_date` datetime NOT NULL,
  `end_date` datetime NOT NULL,
  `name` text NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `details` longtext NOT NULL,
  `location` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `events_institute_id_foreign` (`institute_id`),
  KEY `events_branch_id_foreign` (`branch_id`),
  CONSTRAINT `events_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `events_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `exam_attendances`;
CREATE TABLE `exam_attendances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `exam_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `attendance` int(11) NOT NULL DEFAULT 2,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_attendances_institute_id_foreign` (`institute_id`),
  KEY `exam_attendances_branch_id_foreign` (`branch_id`),
  KEY `exam_attendances_class_id_section_id_exam_id_index` (`class_id`,`section_id`,`exam_id`),
  CONSTRAINT `exam_attendances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_attendances_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `exam_codes`;
CREATE TABLE `exam_codes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_model_id` bigint(20) unsigned NOT NULL,
  `short_code_id` bigint(20) unsigned NOT NULL,
  `short_code_title` varchar(191) DEFAULT NULL,
  `short_code_note` varchar(191) DEFAULT NULL,
  `default_id` int(11) DEFAULT NULL,
  `total_mark` decimal(5,2) DEFAULT NULL,
  `accept_percent` decimal(5,2) DEFAULT NULL,
  `pass_mark` decimal(5,2) DEFAULT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_codes_institute_id_foreign` (`institute_id`),
  KEY `exam_codes_branch_id_foreign` (`branch_id`),
  KEY `exam_codes_class_model_id_foreign` (`class_model_id`),
  KEY `exam_codes_short_code_id_foreign` (`short_code_id`),
  CONSTRAINT `exam_codes_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_codes_class_model_id_foreign` FOREIGN KEY (`class_model_id`) REFERENCES `classes` (`id`),
  CONSTRAINT `exam_codes_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_codes_short_code_id_foreign` FOREIGN KEY (`short_code_id`) REFERENCES `short_codes` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `exam_grades`;
CREATE TABLE `exam_grades` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_model_id` bigint(20) unsigned NOT NULL,
  `grade_id` bigint(20) unsigned NOT NULL,
  `grade_name` varchar(191) NOT NULL,
  `grade_number` decimal(5,2) NOT NULL,
  `grade_point` decimal(5,2) NOT NULL,
  `grade_range` varchar(191) NOT NULL,
  `number_high` decimal(5,2) NOT NULL,
  `number_low` decimal(5,2) NOT NULL,
  `point_high` decimal(5,2) NOT NULL,
  `point_low` decimal(5,2) NOT NULL,
  `priority` varchar(191) NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_grades_institute_id_foreign` (`institute_id`),
  KEY `exam_grades_branch_id_foreign` (`branch_id`),
  KEY `exam_grades_class_model_id_foreign` (`class_model_id`),
  KEY `exam_grades_grade_id_foreign` (`grade_id`),
  CONSTRAINT `exam_grades_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_grades_class_model_id_foreign` FOREIGN KEY (`class_model_id`) REFERENCES `classes` (`id`),
  CONSTRAINT `exam_grades_grade_id_foreign` FOREIGN KEY (`grade_id`) REFERENCES `grades` (`id`),
  CONSTRAINT `exam_grades_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1073 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `exam_grades` VALUES (385,1,1,3,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(386,1,1,4,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(387,1,1,5,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(388,1,1,6,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(389,1,1,7,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(390,1,1,8,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(391,1,1,9,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(392,1,1,10,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(393,1,1,11,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(394,1,1,12,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(395,1,1,13,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(396,1,1,14,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(397,1,1,15,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(398,1,1,16,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(399,1,1,1,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(400,1,1,2,32,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(401,1,1,3,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(402,1,1,4,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(403,1,1,5,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(404,1,1,6,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(405,1,1,7,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(406,1,1,8,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(407,1,1,9,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(408,1,1,10,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(409,1,1,11,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(410,1,1,12,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(411,1,1,13,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(412,1,1,14,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(413,1,1,15,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(414,1,1,16,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(415,1,1,1,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(416,1,1,2,33,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(417,1,1,3,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(418,1,1,4,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(419,1,1,5,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(420,1,1,6,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(421,1,1,7,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(422,1,1,8,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(423,1,1,9,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(424,1,1,10,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(425,1,1,11,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(426,1,1,12,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(427,1,1,13,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(428,1,1,14,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(429,1,1,15,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(430,1,1,16,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(431,1,1,1,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(432,1,1,2,34,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(433,1,1,3,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(434,1,1,4,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(435,1,1,5,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(436,1,1,6,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(437,1,1,7,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(438,1,1,8,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(439,1,1,9,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(440,1,1,10,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(441,1,1,11,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(442,1,1,12,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(443,1,1,13,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(444,1,1,14,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(445,1,1,15,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(446,1,1,16,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(447,1,1,1,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(448,1,1,2,35,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(449,1,1,3,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(450,1,1,4,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(451,1,1,5,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(452,1,1,6,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(453,1,1,7,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(454,1,1,8,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(455,1,1,9,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(456,1,1,10,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(457,1,1,11,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(458,1,1,12,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(459,1,1,13,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(460,1,1,14,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(461,1,1,15,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(462,1,1,16,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(463,1,1,1,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(464,1,1,2,36,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(465,1,1,3,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(466,1,1,4,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(467,1,1,5,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(468,1,1,6,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(469,1,1,7,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(470,1,1,8,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(471,1,1,9,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(472,1,1,10,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(473,1,1,11,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(474,1,1,12,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(475,1,1,13,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(476,1,1,14,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(477,1,1,15,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(478,1,1,16,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(479,1,1,1,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(480,1,1,2,37,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(481,1,1,3,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(482,1,1,4,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(483,1,1,5,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(484,1,1,6,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(485,1,1,7,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(486,1,1,8,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(487,1,1,9,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(488,1,1,10,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(489,1,1,11,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(490,1,1,12,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(491,1,1,13,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(492,1,1,14,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(493,1,1,15,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(494,1,1,16,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(495,1,1,1,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(496,1,1,2,38,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(497,1,1,3,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(498,1,1,4,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(499,1,1,5,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(500,1,1,6,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(501,1,1,7,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(502,1,1,8,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(503,1,1,9,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(504,1,1,10,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(505,1,1,11,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(506,1,1,12,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(507,1,1,13,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(508,1,1,14,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(509,1,1,15,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(510,1,1,16,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(511,1,1,1,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(512,1,1,2,39,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',1,'2026-10-19 09:06:04','2026-10-19 09:06:04');
DROP TABLE IF EXISTS `exam_marks`;
CREATE TABLE `exam_marks` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `group_id` bigint(20) unsigned NOT NULL,
  `subject_id` bigint(20) unsigned NOT NULL,
  `exam_id` bigint(20) unsigned NOT NULL,
  `mark1` decimal(5,2) NOT NULL DEFAULT 0.00,
  `mark2` decimal(5,2) NOT NULL DEFAULT 0.00,
  `mark3` decimal(5,2) NOT NULL DEFAULT 0.00,
  `mark4` decimal(5,2) NOT NULL DEFAULT 0.00,
  `mark5` decimal(5,2) NOT NULL DEFAULT 0.00,
  `mark6` decimal(5,2) NOT NULL DEFAULT 0.00,
  `total_marks` decimal(5,2) NOT NULL DEFAULT 0.00,
  `grade_point` decimal(5,2) NOT NULL DEFAULT 0.00,
  `grade` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_marks_institute_id_foreign` (`institute_id`),
  KEY `exam_marks_branch_id_foreign` (`branch_id`),
  KEY `exam_marks_student_id_foreign` (`student_id`),
  KEY `exam_marks_class_id_foreign` (`class_id`),
  KEY `exam_marks_group_id_foreign` (`group_id`),
  KEY `exam_marks_subject_id_foreign` (`subject_id`),
  KEY `exam_marks_exam_id_foreign` (`exam_id`),
  CONSTRAINT `exam_marks_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_marks_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_marks_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_marks_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `student_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_marks_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_marks_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_marks_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `exam_schedules`;
CREATE TABLE `exam_schedules` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `exam_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `date` date NOT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `room` varchar(20) NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `exam_schedules_institute_id_foreign` (`institute_id`),
  KEY `exam_schedules_branch_id_foreign` (`branch_id`),
  KEY `exam_schedules_class_id_subject_id_exam_id_index` (`class_id`,`subject_id`,`exam_id`),
  CONSTRAINT `exam_schedules_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exam_schedules_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `exams`;
CREATE TABLE `exams` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `exam_code` varchar(191) DEFAULT NULL,
  `note` text DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`exam_code`),
  KEY `exams_branch_id_foreign` (`branch_id`),
  CONSTRAINT `exams_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `exams_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `failed_jobs`;
CREATE TABLE `failed_jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `uuid` varchar(191) NOT NULL,
  `connection` text NOT NULL,
  `queue` text NOT NULL,
  `payload` longtext NOT NULL,
  `exception` longtext NOT NULL,
  `failed_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  UNIQUE KEY `failed_jobs_uuid_unique` (`uuid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `faq_questions`;
CREATE TABLE `faq_questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `question` varchar(255) NOT NULL,
  `answer` longtext DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `faq_questions_institute_id_foreign` (`institute_id`),
  KEY `faq_questions_branch_id_foreign` (`branch_id`),
  KEY `faq_questions_created_by_foreign` (`created_by`),
  CONSTRAINT `faq_questions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `faq_questions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `faq_questions_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `faq_questions` VALUES (1,1,1,'What are the school hours?','Lessons run from 7:30 am to 3:30 pm, Monday to Friday. Clubs and games run until 4:30 pm. The school office is open from 8:00 am to 5:00 pm.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,'Do you offer transport and boarding?','Yes. School buses serve routes across Nairobi and boarding is available from Grade 4. Ask the office for current routes, availability and charges.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,1,1,'When is the admission period?','We admit learners for the January intake from August each year, and for other terms when spaces are available. Book a visit early because places are limited.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `fee_date_configs`;
CREATE TABLE `fee_date_configs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `fee_sub_head_id` bigint(20) unsigned NOT NULL,
  `payable_date_start` date NOT NULL,
  `payable_date_end` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fee_date_configs_institute_id_foreign` (`institute_id`),
  KEY `fee_date_configs_branch_id_foreign` (`branch_id`),
  CONSTRAINT `fee_date_configs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fee_date_configs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `fee_heads`;
CREATE TABLE `fee_heads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `serial` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`name`),
  KEY `fee_heads_branch_id_foreign` (`branch_id`),
  CONSTRAINT `fee_heads_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fee_heads_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `fee_heads` VALUES (1,1,1,'Admission Fees',1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Admission Form Fees',2,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'Session Charge',3,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'Online Apply Fees',4,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Tuition Fees',5,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'College Examination Fees',6,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,'Model Test Fees',7,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,1,'Re-Take Exam Fees',8,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,1,'Form Fill Up/Registration',9,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,1,'TC/Admission Cancel',10,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(11,1,1,'Testimonial Fees',11,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(12,1,1,'Study Materials',12,'2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `fee_map_fee_sub_head`;
CREATE TABLE `fee_map_fee_sub_head` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fee_map_id` bigint(20) unsigned DEFAULT NULL,
  `fee_head_id` bigint(20) unsigned DEFAULT NULL,
  `fee_sub_head_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `fee_map_fee_sub_head` VALUES (4,2,5,48,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(5,2,5,49,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(6,2,5,50,'2026-10-19 09:06:04','2026-10-19 09:06:04');
DROP TABLE IF EXISTS `fee_map_fund`;
CREATE TABLE `fee_map_fund` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `fee_map_id` bigint(20) unsigned DEFAULT NULL,
  `fund_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `fee_maps`;
CREATE TABLE `fee_maps` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `fee_head_id` bigint(20) unsigned NOT NULL,
  `ledger_id` bigint(20) unsigned NOT NULL,
  `fund` varchar(191) DEFAULT NULL,
  `type` enum('fee','fee_fine') NOT NULL DEFAULT 'fee',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fee_maps_institute_id_foreign` (`institute_id`),
  KEY `fee_maps_branch_id_foreign` (`branch_id`),
  CONSTRAINT `fee_maps_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fee_maps_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `fee_maps` VALUES (2,1,1,5,7,'1','fee','2026-10-19 09:06:04','2026-10-19 09:06:04');
DROP TABLE IF EXISTS `fee_sub_heads`;
CREATE TABLE `fee_sub_heads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `fee_head_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `serial` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`fee_head_id`,`name`),
  KEY `fee_sub_heads_branch_id_foreign` (`branch_id`),
  CONSTRAINT `fee_sub_heads_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fee_sub_heads_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `fee_sub_heads` VALUES (1,1,1,NULL,'Admission Fee',1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,NULL,'January',2,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,NULL,'February',3,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,NULL,'March',4,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,NULL,'April',5,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,NULL,'May',6,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,NULL,'June',7,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,1,NULL,'July',8,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,1,NULL,'August',9,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,1,NULL,'September',10,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(11,1,1,NULL,'October',11,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(12,1,1,NULL,'November',12,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(13,1,1,NULL,'December',13,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(14,1,1,NULL,'Session Charge',14,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(15,1,1,NULL,'1st Term Exam',15,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(16,1,1,NULL,'2nd Semester Exam',16,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(17,1,1,NULL,'1st Semester Exam',17,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(18,1,1,NULL,'3rd Semester Exam',18,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(19,1,1,NULL,'1st Model test',19,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(20,1,1,NULL,'2nd Model Test',20,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(21,1,1,NULL,'3rd Model Test',21,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(22,1,1,NULL,'Attendance Fine',22,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(23,1,1,NULL,'Quiz Fine',23,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(24,1,1,NULL,'Lab Fine',24,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(25,1,1,NULL,'Library Fine',25,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(26,1,1,NULL,'Late Fine',26,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(27,1,1,NULL,'ID Card Fine',27,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(28,1,1,NULL,'Discipline Fine',28,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(29,1,1,NULL,'Miscellaneous Fine',29,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(30,1,1,NULL,'Laboratories Exam Fine',30,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(31,1,1,NULL,'College Examination Fee',31,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(32,1,1,NULL,'Model Test Fee',32,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(33,1,1,NULL,'Re-Take Exam Fee',33,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(34,1,1,NULL,'Tc/Admission Cancel',34,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(35,1,1,NULL,'Form Fill Up/Registration',35,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(36,1,1,NULL,'Admission Income (Form, SMS & Others)',36,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(37,1,1,NULL,'Different Type of course fees',37,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(38,1,1,NULL,'Stipend',38,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(39,1,1,NULL,'College Report',39,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(40,1,1,NULL,'Miscellaneous Income',40,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(41,1,1,NULL,'Tuition Book/Rosid Book',41,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(42,1,1,NULL,'ID Card New/Fita/Folder',42,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(43,1,1,NULL,'Online Apply Fees',43,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(44,1,1,NULL,'Testimonial Fees',44,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(48,1,1,5,'Term 1',1,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(49,1,1,5,'Term 2',2,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(50,1,1,5,'Term 3',3,'2026-10-19 09:06:04','2026-10-19 09:06:04');
DROP TABLE IF EXISTS `feedback`;
CREATE TABLE `feedback` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `user_id` bigint(20) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `feedback_user_id_foreign` (`user_id`),
  CONSTRAINT `feedback_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `feedback` VALUES (1,1,'I love learning here! The teachers are supportive, and the activities are fun.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,2,'A great place to teach! The school values both students and educators.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,3,'The best decision for my child! Excellent education and communication.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `fees`;
CREATE TABLE `fees` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `student_category_id` bigint(20) unsigned DEFAULT NULL,
  `fee_head_id` bigint(20) unsigned DEFAULT NULL,
  `fee_amount` decimal(8,2) NOT NULL,
  `fine_amount` decimal(8,2) DEFAULT NULL,
  `fund_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fees_institute_id_foreign` (`institute_id`),
  KEY `fees_branch_id_foreign` (`branch_id`),
  CONSTRAINT `fees_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fees_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `fees` VALUES (2,1,1,1,11,11,NULL,1,5,15000.00,0.00,1,'2026-10-19 09:06:04','2026-10-19 09:06:04');
DROP TABLE IF EXISTS `frontend_contacts`;
CREATE TABLE `frontend_contacts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `phone` varchar(191) DEFAULT NULL,
  `email` varchar(191) DEFAULT NULL,
  `subject` varchar(191) DEFAULT NULL,
  `message` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`phone`,`email`),
  KEY `frontend_contacts_branch_id_foreign` (`branch_id`),
  CONSTRAINT `frontend_contacts_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `frontend_contacts_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `gamifications`;
CREATE TABLE `gamifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  `date` varchar(191) DEFAULT NULL,
  `student_id` int(11) NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `gamifications_institute_id_foreign` (`institute_id`),
  KEY `gamifications_branch_id_foreign` (`branch_id`),
  CONSTRAINT `gamifications_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `gamifications_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `grades`;
CREATE TABLE `grades` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `grade_name` varchar(191) NOT NULL,
  `grade_number` decimal(5,2) NOT NULL,
  `grade_point` decimal(5,2) NOT NULL,
  `grade_range` varchar(191) NOT NULL,
  `number_high` decimal(5,2) NOT NULL,
  `number_low` decimal(5,2) NOT NULL,
  `point_high` decimal(5,2) NOT NULL,
  `point_low` decimal(5,2) NOT NULL,
  `priority` varchar(191) NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grades_institute_id_foreign` (`institute_id`),
  KEY `grades_branch_id_foreign` (`branch_id`),
  CONSTRAINT `grades_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grades_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=80 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `grades` VALUES (32,1,1,'EE1',90.00,8.00,'90-100',100.00,90.00,8.00,8.00,'1',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(33,1,1,'EE2',75.00,7.00,'75-89',89.99,75.00,7.00,7.00,'2',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(34,1,1,'ME1',58.00,6.00,'58-74',74.99,58.00,6.00,6.00,'3',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(35,1,1,'ME2',41.00,5.00,'41-57',57.99,41.00,5.00,5.00,'4',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(36,1,1,'AE1',31.00,4.00,'31-40',40.99,31.00,4.00,4.00,'5',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(37,1,1,'AE2',21.00,3.00,'21-30',30.99,21.00,3.00,3.00,'6',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(38,1,1,'BE1',11.00,2.00,'11-20',20.99,11.00,2.00,2.00,'7',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(39,1,1,'BE2',0.00,1.00,'0-10',10.99,0.00,1.00,1.00,'8',NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04');
DROP TABLE IF EXISTS `grand_final_class_exams`;
CREATE TABLE `grand_final_class_exams` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `exam_id` bigint(20) unsigned NOT NULL,
  `percentage` decimal(5,2) NOT NULL,
  `serial_no` int(10) unsigned NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `grand_final_class_exams_institute_id_foreign` (`institute_id`),
  KEY `grand_final_class_exams_branch_id_foreign` (`branch_id`),
  KEY `grand_final_class_exams_class_id_foreign` (`class_id`),
  KEY `grand_final_class_exams_exam_id_foreign` (`exam_id`),
  CONSTRAINT `grand_final_class_exams_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grand_final_class_exams_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grand_final_class_exams_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `grand_final_class_exams_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `hostel_bills`;
CREATE TABLE `hostel_bills` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `hostel_fee` decimal(8,2) NOT NULL,
  `meal_fee` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_amount` decimal(8,2) NOT NULL,
  `status` enum('pending','paid','overdue') NOT NULL DEFAULT 'pending',
  `due_date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hostel_bills_institute_id_foreign` (`institute_id`),
  KEY `hostel_bills_branch_id_foreign` (`branch_id`),
  KEY `hostel_bills_student_id_foreign` (`student_id`),
  CONSTRAINT `hostel_bills_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostel_bills_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostel_bills_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `hostel_categories`;
CREATE TABLE `hostel_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `hostel_id` bigint(20) unsigned NOT NULL,
  `standard` varchar(20) NOT NULL,
  `hostel_fee` decimal(8,2) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hostel_categories_institute_id_foreign` (`institute_id`),
  KEY `hostel_categories_branch_id_foreign` (`branch_id`),
  KEY `hostel_categories_hostel_id_foreign` (`hostel_id`),
  CONSTRAINT `hostel_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostel_categories_hostel_id_foreign` FOREIGN KEY (`hostel_id`) REFERENCES `hostels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostel_categories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `hostel_members`;
CREATE TABLE `hostel_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `hostel_category_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hostel_members_institute_id_foreign` (`institute_id`),
  KEY `hostel_members_branch_id_foreign` (`branch_id`),
  KEY `hostel_members_hostel_category_id_foreign` (`hostel_category_id`),
  KEY `hostel_members_student_id_foreign` (`student_id`),
  CONSTRAINT `hostel_members_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostel_members_hostel_category_id_foreign` FOREIGN KEY (`hostel_category_id`) REFERENCES `hostel_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostel_members_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostel_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `hostels`;
CREATE TABLE `hostels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `hostel_name` varchar(80) NOT NULL,
  `type` varchar(20) NOT NULL,
  `address` longtext NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hostels_institute_id_foreign` (`institute_id`),
  KEY `hostels_branch_id_foreign` (`branch_id`),
  CONSTRAINT `hostels_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hostels_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `institute_image_s_a_a_s_settings`;
CREATE TABLE `institute_image_s_a_a_s_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `header_logo_light_theme` varchar(191) DEFAULT NULL,
  `header_logo_dark_theme` varchar(191) DEFAULT NULL,
  `footer_logo_light_theme` varchar(191) DEFAULT NULL,
  `footer_logo_dark_theme` varchar(191) DEFAULT NULL,
  `banner_image` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 0=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `institute_image_settings`;
CREATE TABLE `institute_image_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `header_logo_light_theme` varchar(191) DEFAULT NULL,
  `header_logo_dark_theme` varchar(191) DEFAULT NULL,
  `footer_logo_light_theme` varchar(191) DEFAULT NULL,
  `footer_logo_dark_theme` varchar(191) DEFAULT NULL,
  `banner_image` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 0=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `institute_image_settings_institute_id_foreign` (`institute_id`),
  CONSTRAINT `institute_image_settings_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `institutes`;
CREATE TABLE `institutes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `owner_id` bigint(20) unsigned DEFAULT NULL,
  `assigned_to` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(100) NOT NULL,
  `email` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `institute_type` varchar(100) DEFAULT NULL,
  `phone` varchar(15) DEFAULT NULL,
  `domain` varchar(100) DEFAULT NULL,
  `logo` varchar(191) DEFAULT NULL,
  `platform` enum('WEB','APP') NOT NULL DEFAULT 'APP',
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `deleted_by` bigint(20) unsigned DEFAULT NULL,
  `theme_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `institutes_email_unique` (`email`),
  KEY `institutes_owner_id_foreign` (`owner_id`),
  KEY `institutes_assigned_to_foreign` (`assigned_to`),
  KEY `institutes_created_by_foreign` (`created_by`),
  KEY `institutes_updated_by_foreign` (`updated_by`),
  KEY `institutes_deleted_by_foreign` (`deleted_by`),
  CONSTRAINT `institutes_assigned_to_foreign` FOREIGN KEY (`assigned_to`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `institutes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `institutes_deleted_by_foreign` FOREIGN KEY (`deleted_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `institutes_owner_id_foreign` FOREIGN KEY (`owner_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `institutes_updated_by_foreign` FOREIGN KEY (`updated_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `institutes` VALUES (1,NULL,NULL,'Compass Academy',NULL,'123 Main Street, City','School','1234567890','institute1.com',NULL,'WEB',1,NULL,NULL,NULL,NULL,'2026-03-30 11:21:04','2026-03-30 11:21:04',NULL);
DROP TABLE IF EXISTS `job_batches`;
CREATE TABLE `job_batches` (
  `id` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `total_jobs` int(11) NOT NULL,
  `pending_jobs` int(11) NOT NULL,
  `failed_jobs` int(11) NOT NULL,
  `failed_job_ids` longtext NOT NULL,
  `options` mediumtext DEFAULT NULL,
  `cancelled_at` int(11) DEFAULT NULL,
  `created_at` int(11) NOT NULL,
  `finished_at` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `jobs`;
CREATE TABLE `jobs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `queue` varchar(191) NOT NULL,
  `payload` longtext NOT NULL,
  `attempts` tinyint(3) unsigned NOT NULL,
  `reserved_at` int(10) unsigned DEFAULT NULL,
  `available_at` int(10) unsigned NOT NULL,
  `created_at` int(10) unsigned NOT NULL,
  PRIMARY KEY (`id`),
  KEY `jobs_queue_index` (`queue`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `languages`;
CREATE TABLE `languages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `file_path` varchar(191) NOT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `status` enum('active','inactive') NOT NULL DEFAULT 'active',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `leave_types`;
CREATE TABLE `leave_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `leave_types_institute_id_foreign` (`institute_id`),
  KEY `leave_types_branch_id_foreign` (`branch_id`),
  CONSTRAINT `leave_types_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `leave_types_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `leave_types` VALUES (1,1,1,'Medical Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Vacation Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'Emergency Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'Maternity/Paternity Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Study Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'Sick Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,'Family Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,1,'Special Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,1,'Educational Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,1,'Bereavement Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(11,1,1,'Religious Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(12,1,1,'Extracurricular Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(13,1,2,'Medical Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(14,1,2,'Vacation Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(15,1,2,'Emergency Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(16,1,2,'Maternity/Paternity Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(17,1,2,'Study Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(18,1,2,'Sick Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(19,1,2,'Family Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(20,1,2,'Special Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(21,1,2,'Educational Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(22,1,2,'Bereavement Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(23,1,2,'Religious Leave','2026-03-30 11:21:12','2026-03-30 11:21:12'),(24,1,2,'Extracurricular Leave','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `lessons`;
CREATE TABLE `lessons` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `chapter_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `description` longtext DEFAULT NULL,
  `thumbnail_image` varchar(191) DEFAULT NULL,
  `video_type` varchar(191) DEFAULT NULL,
  `video_url` longtext DEFAULT NULL,
  `embedded_url` longtext DEFAULT NULL,
  `uploaded_video_path` varchar(191) DEFAULT NULL,
  `document_file` varchar(191) DEFAULT NULL,
  `attachments` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`attachments`)),
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `playback_hours` int(11) NOT NULL DEFAULT 0,
  `playback_minutes` int(11) NOT NULL DEFAULT 0,
  `playback_seconds` int(11) NOT NULL DEFAULT 0,
  `is_scheduled` tinyint(1) NOT NULL DEFAULT 0,
  `scheduled_at` timestamp NULL DEFAULT NULL,
  `visibility` enum('none','password','public') NOT NULL DEFAULT 'none',
  `password` varchar(191) DEFAULT NULL,
  `status` enum('active','inactive','draft') NOT NULL DEFAULT 'active' COMMENT 'Lesson status: active, inactive, draft',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lessons_institute_id_foreign` (`institute_id`),
  KEY `lessons_course_id_foreign` (`course_id`),
  KEY `lessons_chapter_id_foreign` (`chapter_id`),
  KEY `lessons_created_by_foreign` (`created_by`),
  CONSTRAINT `lessons_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lessons_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lessons_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lessons_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `library_fines`;
CREATE TABLE `library_fines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `book_issue_id` int(11) NOT NULL,
  `library_id` bigint(20) unsigned NOT NULL,
  `fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `lost_book` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `library_fines_institute_id_foreign` (`institute_id`),
  KEY `library_fines_branch_id_foreign` (`branch_id`),
  KEY `library_fines_book_issue_id_library_id_index` (`book_issue_id`,`library_id`),
  CONSTRAINT `library_fines_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `library_fines_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `library_members`;
CREATE TABLE `library_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `library_id` bigint(20) unsigned NOT NULL,
  `member_type` varchar(20) NOT NULL,
  `teacher_id` bigint(20) unsigned DEFAULT NULL,
  `student_id` bigint(20) unsigned DEFAULT NULL,
  `staff_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `library_members_institute_id_foreign` (`institute_id`),
  KEY `library_members_branch_id_foreign` (`branch_id`),
  KEY `library_members_teacher_id_foreign` (`teacher_id`),
  KEY `library_members_student_id_foreign` (`student_id`),
  KEY `library_members_staff_id_foreign` (`staff_id`),
  KEY `library_members_user_id_library_id_index` (`user_id`,`library_id`),
  CONSTRAINT `library_members_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `library_members_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `library_members_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `staffs` (`id`),
  CONSTRAINT `library_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`),
  CONSTRAINT `library_members_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`),
  CONSTRAINT `library_members_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `library_members` VALUES (1,1,1,12,9281,'Student',NULL,2,NULL,'2026-10-19 16:31:23','2026-10-19 16:31:23'),(2,1,1,13,9383,'Student',NULL,3,NULL,'2026-10-19 16:33:03','2026-10-19 16:33:03'),(5,1,1,19,9074,'Student',NULL,6,NULL,'2026-10-19 16:44:35','2026-10-19 16:44:35');
DROP TABLE IF EXISTS `lms_assignment_results`;
CREATE TABLE `lms_assignment_results` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `assignment_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `marks` int(11) DEFAULT NULL,
  `feedback` text DEFAULT NULL,
  `submission_file` varchar(191) DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_assignment_results_institute_id_foreign` (`institute_id`),
  KEY `lms_assignment_results_assignment_id_foreign` (`assignment_id`),
  KEY `lms_assignment_results_user_id_foreign` (`user_id`),
  CONSTRAINT `lms_assignment_results_assignment_id_foreign` FOREIGN KEY (`assignment_id`) REFERENCES `assignments` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lms_assignment_results_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lms_assignment_results_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `lms_assignments`;
CREATE TABLE `lms_assignments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `chapter_id` bigint(20) unsigned NOT NULL,
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `title` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `due_date` datetime NOT NULL,
  `file_path` varchar(191) DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_assignments_institute_id_foreign` (`institute_id`),
  KEY `lms_assignments_course_id_foreign` (`course_id`),
  KEY `lms_assignments_chapter_id_foreign` (`chapter_id`),
  KEY `lms_assignments_created_by_foreign` (`created_by`),
  CONSTRAINT `lms_assignments_chapter_id_foreign` FOREIGN KEY (`chapter_id`) REFERENCES `chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lms_assignments_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lms_assignments_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `lms_assignments_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `lms_class_routine_days`;
CREATE TABLE `lms_class_routine_days` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `routine_id` bigint(20) unsigned NOT NULL,
  `day_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_class_routine_days_routine_id_foreign` (`routine_id`),
  KEY `lms_class_routine_days_day_id_foreign` (`day_id`),
  CONSTRAINT `lms_class_routine_days_day_id_foreign` FOREIGN KEY (`day_id`) REFERENCES `lms_days` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lms_class_routine_days_routine_id_foreign` FOREIGN KEY (`routine_id`) REFERENCES `lms_class_routines` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `lms_class_routines`;
CREATE TABLE `lms_class_routines` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `teacher_id` bigint(20) unsigned DEFAULT NULL,
  `room_id` bigint(20) unsigned DEFAULT NULL,
  `start_time` time NOT NULL,
  `end_time` time NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_class_routines_institute_id_foreign` (`institute_id`),
  CONSTRAINT `lms_class_routines_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `lms_days`;
CREATE TABLE `lms_days` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `serial` int(11) NOT NULL DEFAULT 0,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_days_institute_id_foreign` (`institute_id`),
  CONSTRAINT `lms_days_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `lms_rooms`;
CREATE TABLE `lms_rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `serial` int(11) NOT NULL DEFAULT 0,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `lms_rooms_institute_id_foreign` (`institute_id`),
  CONSTRAINT `lms_rooms_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `lms_zoom_meetings`;
CREATE TABLE `lms_zoom_meetings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `meeting_id` varchar(191) NOT NULL,
  `topic` text NOT NULL,
  `agenda` text DEFAULT NULL,
  `start_time` varchar(191) NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `join_url` longtext NOT NULL,
  `start_url` longtext NOT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`meeting_id`),
  KEY `lms_zoom_meetings_course_id_foreign` (`course_id`),
  KEY `lms_zoom_meetings_created_by_foreign` (`created_by`),
  CONSTRAINT `lms_zoom_meetings_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lms_zoom_meetings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `lms_zoom_meetings_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `mark_config_exam_codes`;
CREATE TABLE `mark_config_exam_codes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `subject_id` bigint(20) unsigned DEFAULT NULL,
  `title` varchar(191) NOT NULL,
  `total_marks` decimal(5,2) NOT NULL DEFAULT 100.00,
  `pass_mark` decimal(5,2) NOT NULL DEFAULT 33.00,
  `acceptance` decimal(5,2) NOT NULL DEFAULT 1.00,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `mark_config_exam_codes_title_subject_id_unique` (`title`,`subject_id`),
  KEY `mark_config_exam_codes_institute_id_foreign` (`institute_id`),
  KEY `mark_config_exam_codes_branch_id_foreign` (`branch_id`),
  KEY `mark_config_exam_codes_subject_id_foreign` (`subject_id`),
  CONSTRAINT `mark_config_exam_codes_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_config_exam_codes_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_config_exam_codes_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `mark_configs`;
CREATE TABLE `mark_configs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `group_id` bigint(20) unsigned NOT NULL,
  `subject_id` bigint(20) unsigned NOT NULL,
  `exam_id` bigint(20) unsigned NOT NULL,
  `mark_config_exam_code_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mark_configs_institute_id_foreign` (`institute_id`),
  KEY `mark_configs_branch_id_foreign` (`branch_id`),
  KEY `mark_configs_class_id_foreign` (`class_id`),
  KEY `mark_configs_group_id_foreign` (`group_id`),
  KEY `mark_configs_subject_id_foreign` (`subject_id`),
  KEY `mark_configs_exam_id_foreign` (`exam_id`),
  KEY `mark_configs_mark_config_exam_code_id_foreign` (`mark_config_exam_code_id`),
  CONSTRAINT `mark_configs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_configs_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_configs_exam_id_foreign` FOREIGN KEY (`exam_id`) REFERENCES `exams` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_configs_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `student_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_configs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_configs_mark_config_exam_code_id_foreign` FOREIGN KEY (`mark_config_exam_code_id`) REFERENCES `mark_config_exam_codes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mark_configs_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `meal_entries`;
CREATE TABLE `meal_entries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `meal_id` bigint(20) unsigned NOT NULL,
  `meal_price` decimal(8,2) NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meal_entries_institute_id_foreign` (`institute_id`),
  KEY `meal_entries_branch_id_foreign` (`branch_id`),
  KEY `meal_entries_student_id_foreign` (`student_id`),
  KEY `meal_entries_meal_id_foreign` (`meal_id`),
  CONSTRAINT `meal_entries_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meal_entries_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meal_entries_meal_id_foreign` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meal_entries_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `meal_plans`;
CREATE TABLE `meal_plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `meal_id` bigint(20) unsigned NOT NULL,
  `date` date NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meal_plans_institute_id_foreign` (`institute_id`),
  KEY `meal_plans_branch_id_foreign` (`branch_id`),
  KEY `meal_plans_student_id_foreign` (`student_id`),
  KEY `meal_plans_meal_id_foreign` (`meal_id`),
  CONSTRAINT `meal_plans_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meal_plans_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meal_plans_meal_id_foreign` FOREIGN KEY (`meal_id`) REFERENCES `meals` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meal_plans_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `meals`;
CREATE TABLE `meals` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `meal_name` varchar(191) NOT NULL,
  `meal_type` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `meals_institute_id_foreign` (`institute_id`),
  KEY `meals_branch_id_foreign` (`branch_id`),
  CONSTRAINT `meals_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `meals_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `merit_process_types`;
CREATE TABLE `merit_process_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) NOT NULL,
  `serial` int(11) NOT NULL DEFAULT 1,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `merit_process_types_institute_id_foreign` (`institute_id`),
  KEY `merit_process_types_branch_id_foreign` (`branch_id`),
  CONSTRAINT `merit_process_types_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `merit_process_types_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `merit_process_types` VALUES (1,1,1,'Total Mark(Sequential)',1,NULL,NULL,NULL),(2,1,1,'Grade Point(Sequential)',1,NULL,NULL,NULL);
DROP TABLE IF EXISTS `migrations`;
CREATE TABLE `migrations` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `migration` varchar(191) NOT NULL,
  `batch` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=203 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `migrations` VALUES (1,'0001_01_01_000000_create_users_table',1),(2,'0001_01_01_000001_create_cache_table',1),(3,'0001_01_01_000001_create_institutes_table',1),(4,'0001_01_01_000002_create_branches_table',1),(5,'0001_01_01_000002_create_jobs_table',1),(6,'2014_10_12_100000_create_password_resets_table',1),(7,'2018_07_13_155644_create_payment_methods_table',1),(8,'2023_10_22_082015_create_accounting_categories_table',1),(9,'2023_10_22_082017_create_accounting_groups_table',1),(10,'2023_10_22_082056_create_accounting_ledgers_table',1),(11,'2023_10_22_082111_create_accounting_funds_table',1),(12,'2023_10_23_133635_create_account_transactions_table',1),(13,'2023_10_23_133653_create_account_transaction_details_table',1),(14,'2023_10_26_042847_create_sms_templates_table',1),(15,'2023_10_26_082224_create_phone_book_categories_table',1),(16,'2023_10_26_132603_create_phone_books_table',1),(17,'2023_11_06_041423_create_fee_heads_table',1),(18,'2023_11_06_041430_create_fee_sub_heads_table',1),(19,'2023_11_07_133106_create_fee_maps_table',1),(20,'2023_11_07_133130_create_fee_map_fee_sub_head_table',1),(21,'2023_11_07_133139_create_fee_map_fund_table',1),(22,'2023_11_10_122800_create_fees_table',1),(23,'2023_11_10_133218_create_absent_fines_table',1),(24,'2023_11_12_092104_create_fee_date_configs_table',1),(25,'2023_11_13_050817_create_waivers_table',1),(26,'2023_11_26_040459_create_sms_purchases_table',1),(27,'2023_11_26_051903_create_sms_balances_table',1),(28,'2023_12_09_202508_create_student_collections_table',1),(29,'2023_12_09_203730_create_student_collection_details_table',1),(30,'2023_12_09_204428_create_student_collection_details_sub_heads_table',1),(31,'2023_12_11_075037_create_student_waiver_configs_table',1),(32,'2024_03_27_214530_create_book_categories_table',1),(33,'2024_03_27_214532_create_books_table',1),(34,'2024_03_27_2145340_create_book_issues_table',1),(35,'2024_03_27_2145347_create_library_fines_table',1),(36,'2024_04_27_212419_create_attendance_fines_table',1),(37,'2024_05_06_073101_create_academic_years_table',1),(38,'2024_05_06_073200_create_shifts_table',1),(39,'2024_05_06_073201_create_classes_table',1),(40,'2024_05_06_073202_create_student_groups_table',1),(41,'2024_05_06_073203_create_sections_table',1),(42,'2024_05_06_073205_create_periods_table',1),(43,'2024_05_06_073206_create_subjects_table',1),(44,'2024_05_06_073207_create_subject_configs_table',1),(45,'2024_05_18_195819_create_departments_table',1),(46,'2024_05_26_175254_create_attendance_waivers_table',1),(47,'2024_06_01_080940_create_settings_table',1),(48,'2024_06_01_161632_create_picklists_table',1),(49,'2024_09_04_183648_create_permission_tables',1),(50,'2024_10_25_124652_create_merit_process_types_table',1),(51,'2024_10_25_124653_create_grades_table',1),(52,'2024_10_25_124905_create_short_codes_table',1),(53,'2024_10_26_074535_create_students_table',1),(54,'2024_10_26_074536_create_exams_table',1),(55,'2024_10_26_074538_create_class_exams_table',1),(56,'2024_11_01_174246_create_user_logs_table',1),(57,'2024_11_02_144004_create_exam_codes_table',1),(58,'2024_11_03_005102_create_exam_grades_table',1),(59,'2024_11_03_161726_create_mark_config_exam_codes_table',1),(60,'2024_11_03_161727_create_mark_configs_table',1),(61,'2024_11_04_015021_create_grand_final_class_exams_table',1),(62,'2024_11_05_013537_create_remark_configs_table',1),(63,'2024_11_06_160453_create_exam_marks_table',1),(64,'2024_11_09_162259_create_student_categories_table',1),(65,'2024_11_09_162261_create_signatures_table',1),(66,'2024_11_09_162262_leave_types',1),(67,'2024_11_09_162282_create_staffs_table',1),(68,'2024_11_09_162284_create_teachers_table',1),(69,'2024_11_09_162292_create_student_sessions_table',1),(70,'2024_11_11_015344_create_oauth_auth_codes_table',1),(71,'2024_11_11_015345_create_oauth_access_tokens_table',1),(72,'2024_11_11_015346_create_oauth_refresh_tokens_table',1),(73,'2024_11_11_015347_create_oauth_clients_table',1),(74,'2024_11_11_015348_create_oauth_personal_access_clients_table',1),(75,'2024_11_12_162918_create_student_migrations_table',1),(76,'2024_11_12_162920_create_library_members_table',1),(77,'2024_11_12_162921_create_student_attendances_table',1),(78,'2024_11_12_162922_create_staff_attendances_table',1),(79,'2024_11_12_162924_create_sms_logs_table',1),(80,'2024_11_12_162932_create_exam_schedules_table',1),(81,'2024_11_12_162934_create_exam_attendances_table',1),(82,'2024_11_12_162935_create_class_days_table',1),(83,'2024_11_12_162936_create_class_routines_table',1),(84,'2024_11_12_162941_create_assign_shifts_table',1),(85,'2024_11_12_162942_create_class_assigns_table',1),(86,'2024_11_12_162943_create_assign_subjects_table',1),(87,'2024_11_12_162944_create_syllabus_table',1),(88,'2024_11_12_162946_create_assignments_table',1),(89,'2024_11_12_162953_create_notices_table',1),(90,'2024_11_12_162955_create_user_notices_table',1),(91,'2024_11_12_162960_create_events_table',1),(92,'2024_11_12_172960_create_contacts_table',1),(93,'2024_11_29_014050_create_assignment_submits_table',1),(94,'2024_12_15_160450_create_salary_heads_table',1),(95,'2024_12_15_160452_create_user_payrolls_table',1),(96,'2024_12_15_160454_create_salary_head_user_payrolls_table',1),(97,'2024_12_15_160456_create_payslip_salaries_table',1),(98,'2024_12_15_160458_create_payslip_salary_heads_table',1),(99,'2024_12_15_160460_create_payslip_invoices_table',1),(100,'2024_12_15_160462_create_payroll_accounting_mappings_table',1),(101,'2024_12_15_160466_create_payments_table',1),(102,'2025_01_01_032931_create_class_lessons_table',1),(103,'2025_01_01_033554_create_prayers_table',1),(104,'2025_01_01_063251_create_behaviors_table',1),(105,'2025_01_01_063813_create_gamifications_table',1),(106,'2025_01_01_063919_create_resources_table',1),(107,'2025_01_11_051038_create_faq_questions_table',1),(108,'2025_01_11_051040_create_policies_table',1),(109,'2025_01_12_051009_create_academic_images_table',1),(110,'2025_01_12_093405_create_about_us_table',1),(111,'2025_02_11_041343_create_our_histories_table',1),(112,'2025_02_13_044120_create_banners_table',1),(113,'2025_02_23_101529_create_testimonials_table',1),(114,'2025_02_26_100812_create_course_categories_table',1),(115,'2025_02_26_101353_create_courses_table',1),(116,'2025_02_26_101354_create_course_features_table',1),(117,'2025_02_26_101355_create_course_faqs_table',1),(118,'2025_02_27_082122_create_chapters_table',1),(119,'2025_02_27_082135_create_lessons_table',1),(120,'2025_03_02_062951_create_quizzes_table',1),(121,'2025_03_02_063014_create_quiz_attempts_table',1),(122,'2025_03_02_063022_create_quiz_results_table',1),(123,'2025_03_02_090616_create_contacts_table',1),(124,'2025_03_03_050829_create_pages_table',1),(125,'2025_03_12_034430_create_zoom_meetings_table',1),(126,'2025_03_16_035921_create_onboardings_table',1),(127,'2025_03_17_040437_create_lms_assignments_table',1),(128,'2025_03_17_040458_create_lms_assignment_results_table',1),(129,'2025_03_18_150112_create_otp_verifications_table',1),(130,'2025_03_21_195239_create_why_choose_us_table',1),(131,'2025_03_21_213247_create_ready_to_join_us_table',1),(132,'2025_03_23_034819_create_payment_requests_table',1),(133,'2025_03_25_160046_create_mobile_app_sections_table',1),(134,'2025_03_28_083006_create_hostels_table',1),(135,'2025_03_28_083008_create_hostel_categories_table',1),(136,'2025_03_28_083010_create_hostel_members_table',1),(137,'2025_03_28_083015_create_rooms_table',1),(138,'2025_03_28_083030_create_room_members_table',1),(139,'2025_03_28_083039_create_meals_table',1),(140,'2025_03_28_083044_create_meal_plans_table',1),(141,'2025_03_28_140712_create_hostel_bills_table',1),(142,'2025_03_28_140735_create_meal_entries_table',1),(143,'2025_03_29_133534_create_buses_table',1),(144,'2025_03_29_133605_create_drivers_table',1),(145,'2025_03_29_133739_create_bus_routes_table',1),(146,'2025_03_29_133749_create_bus_stops_table',1),(147,'2025_03_29_134153_create_transport_members_table',1),(148,'2025_03_30_062148_create_parent_models_table',1),(149,'2025_04_05_043108_create_plans_table',1),(150,'2025_04_05_043132_create_subscriptions_table',1),(151,'2025_04_05_043150_create_subscription_items_table',1),(152,'2025_04_06_041546_create_device_controls_table',1),(153,'2025_04_06_043435_create_student_devices_table',1),(154,'2025_04_08_040639_create_payment_histories_table',1),(155,'2025_04_10_010718_create_feedback_table',1),(156,'2025_04_10_010805_create_s_a_a_s_faqs_table',1),(157,'2025_04_10_033705_create_subscription_upgrade_requests_table',1),(158,'2025_04_20_032512_create_question_bank_classes_table',1),(159,'2025_04_20_032529_create_question_bank_groups_table',1),(160,'2025_04_20_032530_create_question_categories_table',1),(161,'2025_04_20_032538_create_question_bank_subjects_table',1),(162,'2025_04_20_032550_create_question_bank_chapters_table',1),(163,'2025_04_20_032623_create_question_bank_topics_table',1),(164,'2025_04_20_032630_create_question_bank_types_table',1),(165,'2025_04_20_032632_create_question_bank_levels_table',1),(166,'2025_04_20_032638_create_question_bank_sources_table',1),(167,'2025_04_20_032643_create_question_bank_sub_sources_table',1),(168,'2025_04_20_032645_create_question_bank_tags_table',1),(169,'2025_04_20_032646_create_question_bank_sessions_table',1),(170,'2025_04_20_032650_create_question_bank_years_table',1),(171,'2025_04_20_040730_create_question_bank_boards_table',1),(172,'2025_04_20_040732_create_question_bank_difficulty_levels_table',1),(173,'2025_04_20_040733_create_question_bank_tests_table',1),(174,'2025_04_20_040734_create_questions_table',1),(175,'2025_04_20_040738_create_question_test_table',1),(176,'2025_04_20_040738_create_question_type_table',1),(177,'2025_04_20_040744_create_question_level_table',1),(178,'2025_04_20_040746_create_question_topic_table',1),(179,'2025_04_20_040754_create_question_source_table',1),(180,'2025_04_20_040756_create_question_sub_source_table',1),(181,'2025_04_20_040758_create_question_tag_table',1),(182,'2025_04_20_040759_create_question_session_table',1),(183,'2025_04_24_061458_create_contents_table',1),(184,'2025_04_29_055845_create_s_a_a_s_settings_table',1),(185,'2025_04_30_040523_create_s_a_a_s_subscriptions_table',1),(186,'2025_05_24_090100_create_lms_zoom_meetings_table',1),(187,'2025_06_25_070227_create_languages_table',1),(188,'2025_09_20_053933_create_quiz_topics_table',1),(189,'2025_10_01_091211_create_themes_table',1),(190,'2025_10_22_054455_create_lms_rooms_table',1),(191,'2025_10_22_055522_create_lms_days_table',1),(192,'2025_10_22_060312_create_lms_class_routines_table',1),(193,'2025_10_22_060314_create_class_routine_days_table',1),(194,'2025_10_22_060316_create_content_visibility_table',1),(195,'2025_10_22_060317_create_enrollments_table',1),(196,'2025_11_26_005955_create_institute_image_settings_table',1),(197,'2025_11_26_005956_create_institute_image_s_a_a_s_settings_table',1),(198,'2026_02_05_152100_create_teacher_signatures_table',1),(199,'2026_02_05_152200_create_result_cards_table',1),(200,'2026_03_14_065756_create_custom_fields_table',1),(201,'2026_03_14_065757_create_custom_field_values_table',1),(202,'2026_10_19_000000_create_client_licenses_table',1);
DROP TABLE IF EXISTS `mobile_app_sections`;
CREATE TABLE `mobile_app_sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) NOT NULL,
  `heading` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `feature_one` varchar(191) DEFAULT NULL,
  `feature_two` varchar(191) DEFAULT NULL,
  `feature_three` varchar(191) DEFAULT NULL,
  `play_store_link` varchar(191) DEFAULT NULL,
  `app_store_link` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mobile_app_sections_institute_id_foreign` (`institute_id`),
  KEY `mobile_app_sections_branch_id_foreign` (`branch_id`),
  CONSTRAINT `mobile_app_sections_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `mobile_app_sections_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `mobile_app_sections` VALUES (1,1,1,'Stay connected anywhere, any time','Parent app','With the Compass Academy parent app you can:','mobile_app.png','See CBC report cards and attendance','Get notices and SMS alerts instantly','Pay school fees with M-Pesa','https://play.google.com/store/apps/details?id=ke.classcompass.app','https://apps.apple.com/us/app/example-app/id123456789','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `model_has_permissions`;
CREATE TABLE `model_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`model_id`,`model_type`),
  KEY `model_has_permissions_model_id_model_type_index` (`model_id`,`model_type`),
  CONSTRAINT `model_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `model_has_roles`;
CREATE TABLE `model_has_roles` (
  `role_id` bigint(20) unsigned NOT NULL,
  `model_type` varchar(191) NOT NULL,
  `model_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`role_id`,`model_id`,`model_type`),
  CONSTRAINT `model_has_roles_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `model_has_roles` VALUES (1,'Modules\\Authentication\\Models\\User',1),(2,'Modules\\Authentication\\Models\\User',2),(3,'Modules\\Authentication\\Models\\User',3),(4,'Modules\\Authentication\\Models\\User',4),(5,'Modules\\Authentication\\Models\\User',5),(7,'Modules\\Authentication\\Models\\User',9),(8,'Modules\\Authentication\\Models\\User',10),(9,'Modules\\Authentication\\Models\\User',6),(10,'Modules\\Authentication\\Models\\User',7);
DROP TABLE IF EXISTS `notices`;
CREATE TABLE `notices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` text DEFAULT NULL,
  `notice` longtext NOT NULL,
  `image` varchar(191) DEFAULT NULL,
  `date` date NOT NULL,
  `created_by` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `notices_institute_id_foreign` (`institute_id`),
  KEY `notices_branch_id_foreign` (`branch_id`),
  CONSTRAINT `notices_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `notices_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `notices` VALUES (1,1,1,'Half-term break','School closes on Friday for half-term.',NULL,'2026-10-19',2,'2026-10-19 16:33:04','2026-10-19 16:33:04'),(2,1,1,'Half-term break','School closes on Friday for half-term.',NULL,'2026-10-19',2,'2026-10-19 16:44:35','2026-10-19 16:44:35');
DROP TABLE IF EXISTS `oauth_access_tokens`;
CREATE TABLE `oauth_access_tokens` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `client_id` char(36) NOT NULL,
  `name` varchar(191) DEFAULT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_access_tokens_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `oauth_auth_codes`;
CREATE TABLE `oauth_auth_codes` (
  `id` varchar(100) NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `client_id` char(36) NOT NULL,
  `scopes` text DEFAULT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_auth_codes_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `oauth_clients`;
CREATE TABLE `oauth_clients` (
  `id` char(36) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `secret` varchar(100) DEFAULT NULL,
  `provider` varchar(191) DEFAULT NULL,
  `redirect` text NOT NULL,
  `personal_access_client` tinyint(1) NOT NULL,
  `password_client` tinyint(1) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_clients_user_id_index` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `oauth_clients` VALUES ('a16ce882-294e-44cc-8b90-380023f17453',NULL,'yes','0890236e4e8d2b649433f694f673cb29ab334777',NULL,'http://localhost',1,0,0,'2026-03-30 11:21:33','2026-03-30 11:21:33');
DROP TABLE IF EXISTS `oauth_personal_access_clients`;
CREATE TABLE `oauth_personal_access_clients` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `client_id` char(36) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `oauth_personal_access_clients` VALUES (1,'a16ce882-294e-44cc-8b90-380023f17453','2026-03-30 11:21:33','2026-03-30 11:21:33');
DROP TABLE IF EXISTS `oauth_refresh_tokens`;
CREATE TABLE `oauth_refresh_tokens` (
  `id` varchar(100) NOT NULL,
  `access_token_id` varchar(100) NOT NULL,
  `revoked` tinyint(1) NOT NULL,
  `expires_at` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `oauth_refresh_tokens_access_token_id_index` (`access_token_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `onboardings`;
CREATE TABLE `onboardings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `collected_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`collected_data`)),
  `institute_logo` varchar(191) DEFAULT NULL,
  `user_avatar` varchar(191) DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `approved_by` bigint(20) unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `onboardings_approved_by_foreign` (`approved_by`),
  CONSTRAINT `onboardings_approved_by_foreign` FOREIGN KEY (`approved_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `otp_verifications`;
CREATE TABLE `otp_verifications` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `phone` varchar(191) NOT NULL,
  `otp` varchar(191) DEFAULT NULL,
  `expires_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `otp_verifications_institute_id_foreign` (`institute_id`),
  CONSTRAINT `otp_verifications_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `our_histories`;
CREATE TABLE `our_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `year` year(4) NOT NULL,
  `title` varchar(255) NOT NULL,
  `descriptions` text DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `our_histories_institute_id_foreign` (`institute_id`),
  KEY `our_histories_branch_id_foreign` (`branch_id`),
  KEY `our_histories_created_by_foreign` (`created_by`),
  CONSTRAINT `our_histories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `our_histories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `our_histories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `our_histories` VALUES (1,1,1,1972,'Mere tranquil existence','Possession of my entire soul, like these sweet mornings of spring which I enjoy with my whole heart am alone',1,NULL,NULL,NULL,NULL);
DROP TABLE IF EXISTS `pages`;
CREATE TABLE `pages` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) NOT NULL,
  `slug` varchar(191) NOT NULL,
  `type` varchar(191) NOT NULL,
  `content` text DEFAULT NULL,
  `meta_data` varchar(191) DEFAULT NULL,
  `seo_meta_keywords` text DEFAULT NULL,
  `seo_meta_description` text DEFAULT NULL,
  `page_status` varchar(191) NOT NULL DEFAULT 'draft',
  `page_template` varchar(191) NOT NULL DEFAULT 'default',
  `author_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`slug`),
  KEY `pages_branch_id_foreign` (`branch_id`),
  KEY `pages_author_id_index` (`author_id`),
  CONSTRAINT `pages_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `pages_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `pages` VALUES (1,1,1,'Home','home','home','<p>Home page content</p>',NULL,'home, welcome','This is the home page','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,'About Us','about-us','about','<p>About us content</p>',NULL,'about, us','Learn more about us','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,1,1,'Mission','mission','mission','<p>Demo College provides quality education to students...</p>',NULL,'mission, education, students','Our mission is to provide quality education.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(4,1,1,'Vision','vision','vision','<p>Demo College inspires students to acquire genuine knowledge...</p>',NULL,'vision, education, knowledge','Our vision is to inspire students with knowledge.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(5,1,1,'Goal','goal','goal','<p>To establish Demo College as a model educational institution...</p>',NULL,'goal, education, institution','Our goal is to be a model educational institution.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(6,1,1,'Motto','motto','motto','<p>Pursue Knowledge through Human Service...</p>',NULL,'motto, knowledge, service','Our motto is to pursue knowledge through service.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(7,1,1,'Admission Information','admission-information','admission-information','<img src=\"https://example.com/public/page_Image/admission_information.png\">',NULL,'admission, info, enrollment','Find out about our admission process.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(8,1,1,'Academic Achievements','academic-achievement','academic-achievement','<img src=\"https://example.com/public/page_Image/admission_information.png\">',NULL,'admission, academic achievements, enrollment','Learn about the academic achievements of our institution and how we support student success.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(9,1,1,'Academic Facilities','academic-facilities','academic-facilities','<img src=\"https://example.com/public/page_Image/admission_information.png\">',NULL,'admission, academic facilities, enrollment','Explore the academic facilities that provide a conducive environment for learning and growth.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(10,1,1,'Debating Club Information','debating-club','debating-club','<img src=\"https://example.com/public/page_Image/admission_information.png\">',NULL,'admission, debating club, extracurricular','Join our debating club to enhance your critical thinking and public speaking skills.','publish','default',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `parent_models`;
CREATE TABLE `parent_models` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned DEFAULT NULL,
  `parent_name` varchar(50) NOT NULL,
  `parent_profession` varchar(100) DEFAULT NULL,
  `parent_phone` varchar(25) DEFAULT NULL,
  `present_address` longtext DEFAULT NULL,
  `permanent_address` longtext DEFAULT NULL,
  `access_key` varchar(25) DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `parent_models_institute_id_foreign` (`institute_id`),
  KEY `parent_models_branch_id_foreign` (`branch_id`),
  KEY `parent_models_student_id_foreign` (`student_id`),
  KEY `parent_models_user_id_parent_phone_index` (`user_id`,`parent_phone`),
  CONSTRAINT `parent_models_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `parent_models_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `parent_models_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `parent_models_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `parent_models` VALUES (1,1,1,10,1,'Peter Kamau',NULL,'254700000102',NULL,NULL,NULL,'0','2026-10-19 09:06:04','2026-10-19 09:06:04',NULL);
DROP TABLE IF EXISTS `password_reset_tokens`;
CREATE TABLE `password_reset_tokens` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `password_resets`;
CREATE TABLE `password_resets` (
  `email` varchar(191) NOT NULL,
  `token` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  KEY `password_resets_email_index` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `payment_histories`;
CREATE TABLE `payment_histories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `course_id` bigint(20) unsigned NOT NULL,
  `payment_method_id` bigint(20) unsigned NOT NULL,
  `invoice_number` varchar(32) NOT NULL,
  `invoice_title` varchar(191) NOT NULL DEFAULT 'Monthly fee',
  `payable` decimal(10,2) NOT NULL DEFAULT 0.00,
  `paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `due` decimal(10,2) NOT NULL DEFAULT 0.00,
  `discount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `status` enum('Paid','Unpaid','Partial') NOT NULL DEFAULT 'Unpaid',
  `date_issued` date DEFAULT NULL,
  `due_date` date DEFAULT NULL,
  `provider_transaction_id` varchar(191) DEFAULT NULL,
  `mobile_payment_provider` varchar(191) DEFAULT NULL,
  `confirmation_status` enum('Pending','Confirmed','Failed') NOT NULL DEFAULT 'Pending',
  `attachments` varchar(191) DEFAULT NULL,
  `internal_notes` longtext DEFAULT NULL,
  `send_sms` tinyint(1) NOT NULL DEFAULT 0,
  `send_email` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `payment_histories_invoice_number_unique` (`invoice_number`),
  UNIQUE KEY `payment_histories_user_id_course_id_date_issued_unique` (`user_id`,`course_id`,`date_issued`),
  KEY `payment_histories_institute_id_foreign` (`institute_id`),
  KEY `payment_histories_course_id_foreign` (`course_id`),
  KEY `payment_histories_payment_method_id_foreign` (`payment_method_id`),
  CONSTRAINT `payment_histories_course_id_foreign` FOREIGN KEY (`course_id`) REFERENCES `courses` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payment_histories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payment_histories_payment_method_id_foreign` FOREIGN KEY (`payment_method_id`) REFERENCES `payment_methods` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payment_histories_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `payment_methods`;
CREATE TABLE `payment_methods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `session_id` int(11) DEFAULT NULL,
  `balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_methods_institute_id_foreign` (`institute_id`),
  KEY `payment_methods_branch_id_foreign` (`branch_id`),
  CONSTRAINT `payment_methods_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payment_methods_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `payment_requests`;
CREATE TABLE `payment_requests` (
  `id` char(36) NOT NULL,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `payer_id` varchar(64) DEFAULT NULL,
  `receiver_id` varchar(64) DEFAULT NULL,
  `payment_amount` decimal(24,2) NOT NULL DEFAULT 0.00,
  `gateway_callback_url` varchar(191) DEFAULT NULL,
  `success_hook` varchar(100) DEFAULT NULL,
  `failure_hook` varchar(100) DEFAULT NULL,
  `transaction_id` varchar(100) DEFAULT NULL,
  `currency_code` varchar(20) NOT NULL DEFAULT 'USD',
  `payment_method` varchar(50) DEFAULT NULL,
  `payment_type` varchar(50) DEFAULT NULL,
  `name` varchar(50) DEFAULT NULL,
  `phone` varchar(25) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `plan_id` bigint(20) unsigned DEFAULT NULL,
  `notes` varchar(50) DEFAULT NULL,
  `additional_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`additional_data`)),
  `is_paid` tinyint(1) NOT NULL DEFAULT 0,
  `payer_information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`payer_information`)),
  `external_redirect_link` varchar(255) DEFAULT NULL,
  `receiver_information` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`receiver_information`)),
  `attribute_id` varchar(64) DEFAULT NULL,
  `attribute` varchar(255) DEFAULT NULL,
  `payment_platform` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payment_requests_institute_id_foreign` (`institute_id`),
  KEY `payment_requests_branch_id_foreign` (`branch_id`),
  CONSTRAINT `payment_requests_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payment_requests_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `payments`;
CREATE TABLE `payments` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `account_id` bigint(20) unsigned DEFAULT NULL,
  `year` varchar(191) NOT NULL,
  `month` varchar(191) NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `type` enum('salary','due','advanced','advanced_return') NOT NULL DEFAULT 'due',
  `payment_method_id` bigint(20) unsigned DEFAULT NULL,
  `paid_by` bigint(20) unsigned DEFAULT NULL,
  `note` longtext DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payments_institute_id_foreign` (`institute_id`),
  KEY `payments_branch_id_foreign` (`branch_id`),
  CONSTRAINT `payments_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payments_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `payroll_accounting_mappings`;
CREATE TABLE `payroll_accounting_mappings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `ledger_id` bigint(20) unsigned NOT NULL,
  `fund_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payroll_accounting_mappings_ledger_id_fund_id_index` (`ledger_id`,`fund_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `payroll_accounting_mappings` VALUES (1,55,1,'2026-03-30 11:21:06',NULL);
DROP TABLE IF EXISTS `payslip_invoices`;
CREATE TABLE `payslip_invoices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `invoice_id` bigint(20) unsigned NOT NULL COMMENT 'custom generate id',
  `payslip_salary_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payslip_invoices_institute_id_foreign` (`institute_id`),
  KEY `payslip_invoices_branch_id_foreign` (`branch_id`),
  CONSTRAINT `payslip_invoices_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payslip_invoices_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `payslip_salaries`;
CREATE TABLE `payslip_salaries` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `year` varchar(191) NOT NULL,
  `month` varchar(191) NOT NULL,
  `paid_amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `is_paid` enum('0','1') NOT NULL DEFAULT '0',
  `payment_date` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payslip_salaries_institute_id_foreign` (`institute_id`),
  KEY `payslip_salaries_branch_id_foreign` (`branch_id`),
  KEY `payslip_salaries_user_id_index` (`user_id`),
  CONSTRAINT `payslip_salaries_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payslip_salaries_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `payslip_salary_heads`;
CREATE TABLE `payslip_salary_heads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_payroll_id` bigint(20) unsigned NOT NULL,
  `salary_head_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `payslip_salary_heads_institute_id_foreign` (`institute_id`),
  KEY `payslip_salary_heads_branch_id_foreign` (`branch_id`),
  CONSTRAINT `payslip_salary_heads_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `payslip_salary_heads_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `periods`;
CREATE TABLE `periods` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `serial_no` int(10) unsigned DEFAULT NULL,
  `period` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`period`),
  KEY `periods_branch_id_foreign` (`branch_id`),
  CONSTRAINT `periods_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `periods_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `periods` VALUES (1,1,1,1,'1st Period','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,2,'2nd Period','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `permissions_name_guard_name_unique` (`name`,`guard_name`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `permissions` VALUES (1,'master_configuration.institutes','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(2,'master_configuration.plans','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(3,'master_configuration.cms_control','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(4,'teacher_panel','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(5,'student_panel','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(6,'parent_panel','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(7,'hostel_panel','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(8,'transport_panel','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(9,'dashboard','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(10,'system-admin','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(11,'student_information.student_index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(12,'student_information.student_create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(13,'student_information.student_edit','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(14,'student_information.student_delete','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(15,'student_information.student_status_change','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(16,'student_information.student_migration','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(17,'student_information.student_pullback','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(18,'student_information.migration_list','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(19,'student_information.all_student_list','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(20,'staff_information.teachers_index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(21,'staff_information.teachers_create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(22,'staff_information.teachers_edit','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(23,'staff_information.teachers_delete','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(24,'staff_information.teachers_status_change','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(25,'staff_information.staffs_index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(26,'staff_information.staffs_create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(27,'staff_information.staffs_edit','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(28,'staff_information.staffs_delete','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(29,'staff_information.staff_attendance_view','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(30,'staff_information.staff_attendance_create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(31,'staff_information.staffs_report','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(32,'student_attendance.student_attendance_index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(33,'student_attendance.student_attendance_create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(34,'student_attendance.exam_attendance_index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(35,'student_attendance.exam_attendance_schedule','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(36,'student_attendance.student_attendance_report','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(37,'student_attendance.student_absent_report','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(38,'academic_configuration.academic_session','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(39,'academic_configuration.shifts','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(40,'academic_configuration.classes','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(41,'academic_configuration.sections','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(42,'academic_configuration.groups','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(43,'academic_configuration.periods','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(44,'academic_configuration.subjects','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(45,'academic_configuration.subject_config','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(46,'academic_configuration.exams','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(47,'academic_configuration.student_categories','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(48,'academic_configuration.departments','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(49,'academic_configuration.picklist','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(50,'academic_configuration.principal_signatures','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(51,'fees_management.startup','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(52,'fees_management.mapping','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(53,'fees_management.amount_config','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(54,'fees_management.date_config','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(55,'fees_management.fine_waiver','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(56,'fees_management.waiver','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(57,'fees_management.waiver_config','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(58,'fees_management.smart_collection','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(59,'fees_management.paid_info','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(60,'fees_management.unpaid_info','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(61,'accounting_management.ledgers','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(62,'accounting_management.funds','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(63,'accounting_management.categories','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(64,'accounting_management.groups','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(65,'accounting_management.payment','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(66,'accounting_management.receipt','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(67,'accounting_management.contra','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(68,'accounting_management.journal','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(69,'accounting_management.fund_transfer','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(70,'accounting_management.chart_of_accounts','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(71,'accounting_report.balance_sheet','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(72,'accounting_report.trial_balance','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(73,'accounting_report.cash_flow_statement','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(74,'accounting_report.cash_flow_details','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(75,'accounting_report.cash_book_account','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(76,'accounting_report.ledger_book_account','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(77,'accounting_report.income_statement','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(78,'accounting_report.cash_summary','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(79,'payroll.payroll_start_up','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(80,'payroll.payroll_mapping','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(81,'payroll.payroll_assign','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(82,'payroll.salary_slip','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(83,'payroll.salary','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(84,'payroll.due','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(85,'payroll.advance','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(86,'payroll.return_advance_payment','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(87,'payroll.salary_statement','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(88,'payroll.payment_info','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(89,'routine_management.syllabuses','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(90,'routine_management.assignments','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(91,'routine_management.class_routine','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(92,'routine_management.exam_routine','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(93,'routine_management.admit_seat_plan','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(94,'library_management.book_category','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(95,'library_management.books','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(96,'library_management.members','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(97,'library_management.book_issue_search','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(98,'library_management.book_issue_report','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(99,'library_management.book_barcode_print','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(100,'exam_module.exam_start_up','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(101,'exam_module.mark_config','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(102,'exam_module.remarks_config','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(103,'exam_module.mark_input','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(104,'exam_module.exam_result','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(105,'layouts_certificates.general','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(106,'layouts_certificates.testimonial','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(107,'layouts_certificates.attendance_certificate','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(108,'layouts_certificates.hsc_recommendation_letter','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(109,'layouts_certificates.transfer','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(110,'layouts_certificates.abroad_letter','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(111,'sms_notifications.templates','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(112,'sms_notifications.phonebook_category','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(113,'sms_notifications.phonebook','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(114,'sms_notifications.sent_sms','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(115,'sms_notifications.purchase_sms','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(116,'sms_notifications.sms_report','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(117,'administrator.assign_shift','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(118,'administrator.assign_subject','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(119,'administrator.assign_class','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(120,'administrator.notice','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(121,'administrator.event','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(122,'administrator.contact_message','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(123,'administrator.user_activities','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(124,'quiz.topics','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(125,'quiz.questions','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(126,'quiz.answers','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(127,'quiz.all_reports','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(128,'master_configuration.system_settings','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(129,'master_configuration.roles','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(130,'master_configuration.users','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(131,'master_configuration.database_backup','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(132,'master_configuration.branches','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(133,'zoom-index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(134,'zoom-create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(135,'zoom-update','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(136,'zoom-delete','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(137,'payment_gateway.index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(138,'payment_gateway.create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(139,'payment_gateway.update','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(140,'payment_gateway.delete','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(141,'role-index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(142,'role-create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(143,'role-update','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(144,'role-delete','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(145,'user-index','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(146,'user-create','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(147,'user-update','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(148,'user-delete','web','2026-03-30 11:21:04','2026-03-30 11:21:04'),(149,'master_configuration.client_licenses','web','2026-03-30 11:21:04','2026-03-30 11:21:04');
DROP TABLE IF EXISTS `phone_book_categories`;
CREATE TABLE `phone_book_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_book_categories_institute_id_foreign` (`institute_id`),
  KEY `phone_book_categories_branch_id_foreign` (`branch_id`),
  CONSTRAINT `phone_book_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phone_book_categories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `phone_book_categories` VALUES (1,1,1,'Student','Student',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(2,1,1,'Teacher','Teacher',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(3,1,1,'Family','Family',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(4,1,1,'VIP','VIP',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(5,1,1,'Director','Director',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(6,1,1,'Shareholder','Shareholder',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(7,1,1,'Other School Teacher','Other School Teacher',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(8,1,1,'Chairman','Chairman',1,'2026-03-30 11:21:14','2026-03-30 11:21:14');
DROP TABLE IF EXISTS `phone_books`;
CREATE TABLE `phone_books` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `phone` varchar(191) NOT NULL,
  `category_id` varchar(191) NOT NULL,
  `note` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `phone_books_institute_id_foreign` (`institute_id`),
  KEY `phone_books_branch_id_foreign` (`branch_id`),
  KEY `phone_books_category_id_index` (`category_id`),
  CONSTRAINT `phone_books_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `phone_books_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `picklists`;
CREATE TABLE `picklists` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `type` varchar(50) NOT NULL,
  `value` text NOT NULL,
  `slug` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `picklists_institute_id_foreign` (`institute_id`),
  KEY `picklists_branch_id_foreign` (`branch_id`),
  KEY `picklists_type_index` (`type`),
  CONSTRAINT `picklists_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `picklists_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `picklists` VALUES (1,1,1,'Religion','Islam','islam','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Religion','Christianity','christianity','2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'Religion','Hinduism','hinduism','2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'Religion','Buddhism','buddhism','2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Religion','Others','others','2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'Designation','Department Head','department-head','2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,'Designation','Lecturer','lecturer','2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,1,'Designation','Associate Professor','associate-professor','2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,1,'Designation','Professor','professor','2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,1,'Designation','Principal','principal','2026-03-30 11:21:12','2026-03-30 11:21:12'),(11,1,1,'Designation','Director of administration and student guidance','director-of-administration-and-student-guidance','2026-03-30 11:21:12','2026-03-30 11:21:12'),(12,1,1,'Staff Designation','Accounts Office','accounts-office','2026-03-30 11:21:12','2026-03-30 11:21:12'),(13,1,1,'Staff Designation','Exam Office','exam-office','2026-03-30 11:21:12','2026-03-30 11:21:12'),(14,1,1,'Staff Designation','IT Office','it-office','2026-03-30 11:21:12','2026-03-30 11:21:12'),(15,1,1,'Staff Designation','Library','library','2026-03-30 11:21:12','2026-03-30 11:21:12'),(16,1,1,'Staff Designation','Storekeeper','storekeeper','2026-03-30 11:21:12','2026-03-30 11:21:12'),(17,1,1,'Staff Designation','Lab Assistant','lab-assistant','2026-03-30 11:21:12','2026-03-30 11:21:12'),(18,1,1,'Staff Designation','Maintenance','maintenance','2026-03-30 11:21:12','2026-03-30 11:21:12'),(19,1,1,'Staff Designation','Holy Cross Fathers Work Program','holy-cross-fathers-work-program','2026-03-30 11:21:12','2026-03-30 11:21:12'),(20,1,1,'Staff Designation','Academic Office','academic-office','2026-03-30 11:21:12','2026-03-30 11:21:12'),(21,1,2,'Religion','Islam','islam','2026-03-30 11:21:12','2026-03-30 11:21:12'),(22,1,2,'Religion','Christianity','christianity','2026-03-30 11:21:12','2026-03-30 11:21:12'),(23,1,2,'Religion','Hinduism','hinduism','2026-03-30 11:21:12','2026-03-30 11:21:12'),(24,1,2,'Religion','Buddhism','buddhism','2026-03-30 11:21:12','2026-03-30 11:21:12'),(25,1,2,'Religion','Others','others','2026-03-30 11:21:12','2026-03-30 11:21:12'),(26,1,2,'Designation','Department Head','department-head','2026-03-30 11:21:12','2026-03-30 11:21:12'),(27,1,2,'Designation','Lecturer','lecturer','2026-03-30 11:21:12','2026-03-30 11:21:12'),(28,1,2,'Designation','Associate Professor','associate-professor','2026-03-30 11:21:12','2026-03-30 11:21:12'),(29,1,2,'Designation','Professor','professor','2026-03-30 11:21:12','2026-03-30 11:21:12'),(30,1,2,'Designation','Principal','principal','2026-03-30 11:21:12','2026-03-30 11:21:12'),(31,1,2,'Designation','Director of administration and student guidance','director-of-administration-and-student-guidance','2026-03-30 11:21:12','2026-03-30 11:21:12'),(32,1,2,'Staff Designation','Accounts Office','accounts-office','2026-03-30 11:21:12','2026-03-30 11:21:12'),(33,1,2,'Staff Designation','Exam Office','exam-office','2026-03-30 11:21:12','2026-03-30 11:21:12'),(34,1,2,'Staff Designation','IT Office','it-office','2026-03-30 11:21:12','2026-03-30 11:21:12'),(35,1,2,'Staff Designation','Library','library','2026-03-30 11:21:12','2026-03-30 11:21:12'),(36,1,2,'Staff Designation','Storekeeper','storekeeper','2026-03-30 11:21:12','2026-03-30 11:21:12'),(37,1,2,'Staff Designation','Lab Assistant','lab-assistant','2026-03-30 11:21:12','2026-03-30 11:21:12'),(38,1,2,'Staff Designation','Maintenance','maintenance','2026-03-30 11:21:12','2026-03-30 11:21:12'),(39,1,2,'Staff Designation','Holy Cross Fathers Work Program','holy-cross-fathers-work-program','2026-03-30 11:21:12','2026-03-30 11:21:12'),(40,1,2,'Staff Designation','Academic Office','academic-office','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `plans`;
CREATE TABLE `plans` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `student_limit` int(11) NOT NULL DEFAULT 0,
  `branch_limit` int(11) NOT NULL DEFAULT 0,
  `price` decimal(8,2) NOT NULL DEFAULT 0.00,
  `duration_days` int(11) DEFAULT NULL,
  `is_custom` tinyint(1) NOT NULL DEFAULT 0,
  `is_free` tinyint(1) NOT NULL DEFAULT 0,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `plans` VALUES (1,'Free Trial','30 days free, all features',200,1,0.00,30,0,1,1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,'Msingi','Up to 200 learners, per term',200,1,2500.00,120,0,0,1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,'Shule','201 to 700 learners, per term',700,1,5000.00,120,0,0,1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(4,'Shule Pro','701 to 1,500 learners, up to 3 campuses, per term',1500,3,9500.00,120,0,0,1,'2026-10-19 12:41:50','2026-10-19 12:41:50',NULL),(5,'Group & College','Custom pricing for school groups and colleges',999999,99,0.00,365,1,0,1,'2026-10-19 12:41:50','2026-10-19 12:41:50',NULL);
DROP TABLE IF EXISTS `policies`;
CREATE TABLE `policies` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `type` tinyint(4) NOT NULL COMMENT '1=privacy, 2=cookie, 3=terms & conditions',
  `description` longtext NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `policies_institute_id_foreign` (`institute_id`),
  KEY `policies_branch_id_foreign` (`branch_id`),
  KEY `policies_created_by_foreign` (`created_by`),
  CONSTRAINT `policies_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `policies_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `policies_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `policies` VALUES (1,1,1,1,'This Privacy Policy explains how we collect, use, and protect your personal data when you use our Learning Management System (LMS). We prioritize your privacy and comply with data protection laws.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,2,'Our Cookie Policy explains how we use cookies to improve your experience on our LMS platform. By using our site, you agree to our use of cookies for analytics, personalization, and security.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,1,1,3,'These Terms & Conditions outline the rules and regulations for using our LMS. By accessing our platform, you agree to abide by our terms, including content usage, user conduct, and dispute resolution.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `prayers`;
CREATE TABLE `prayers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(191) NOT NULL,
  `date` varchar(255) DEFAULT NULL,
  `note` varchar(255) DEFAULT NULL,
  `file` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `prayers_institute_id_foreign` (`institute_id`),
  KEY `prayers_branch_id_foreign` (`branch_id`),
  CONSTRAINT `prayers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `prayers_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_boards`;
CREATE TABLE `question_bank_boards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `board` varchar(191) NOT NULL,
  `short_name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_chapters`;
CREATE TABLE `question_bank_chapters` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subject_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `chapter_no` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_bank_chapters_subject_id_foreign` (`subject_id`),
  CONSTRAINT `question_bank_chapters_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `question_bank_subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_classes`;
CREATE TABLE `question_bank_classes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_difficulty_levels`;
CREATE TABLE `question_bank_difficulty_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `level_name` varchar(191) NOT NULL,
  `level_code` text DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_groups`;
CREATE TABLE `question_bank_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_bank_groups_class_id_foreign` (`class_id`),
  CONSTRAINT `question_bank_groups_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `question_bank_classes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_levels`;
CREATE TABLE `question_bank_levels` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `level_name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_sessions`;
CREATE TABLE `question_bank_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_sources`;
CREATE TABLE `question_bank_sources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_sub_sources`;
CREATE TABLE `question_bank_sub_sources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `source_id` bigint(20) unsigned NOT NULL,
  `sub_source_name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_bank_sub_sources_source_id_foreign` (`source_id`),
  CONSTRAINT `question_bank_sub_sources_source_id_foreign` FOREIGN KEY (`source_id`) REFERENCES `question_bank_sources` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_subjects`;
CREATE TABLE `question_bank_subjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `class_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `question_category_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(191) NOT NULL,
  `code` varchar(191) DEFAULT NULL,
  `type` varchar(191) DEFAULT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `color_code` varchar(191) DEFAULT NULL COMMENT 'Color code for the bg category',
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `description` longtext DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_bank_subjects_class_id_foreign` (`class_id`),
  KEY `question_bank_subjects_group_id_foreign` (`group_id`),
  KEY `question_bank_subjects_question_category_id_foreign` (`question_category_id`),
  CONSTRAINT `question_bank_subjects_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `question_bank_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_bank_subjects_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `question_bank_groups` (`id`) ON DELETE SET NULL,
  CONSTRAINT `question_bank_subjects_question_category_id_foreign` FOREIGN KEY (`question_category_id`) REFERENCES `question_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_tags`;
CREATE TABLE `question_bank_tags` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_tests`;
CREATE TABLE `question_bank_tests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `test_name` varchar(191) NOT NULL,
  `test_id` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `duration` varchar(191) DEFAULT NULL,
  `start_date` timestamp NULL DEFAULT NULL,
  `end_date` timestamp NULL DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_topics`;
CREATE TABLE `question_bank_topics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_bank_chapter_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_bank_topics_question_bank_chapter_id_foreign` (`question_bank_chapter_id`),
  CONSTRAINT `question_bank_topics_question_bank_chapter_id_foreign` FOREIGN KEY (`question_bank_chapter_id`) REFERENCES `question_bank_chapters` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_types`;
CREATE TABLE `question_bank_types` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `type_name` varchar(191) NOT NULL,
  `default_mark` varchar(191) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_bank_years`;
CREATE TABLE `question_bank_years` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `year` varchar(191) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_categories`;
CREATE TABLE `question_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `slug` varchar(191) DEFAULT NULL,
  `color_code` varchar(191) DEFAULT NULL COMMENT 'Color code for the bg category',
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `description` longtext DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_categories_institute_id_foreign` (`institute_id`),
  KEY `question_categories_created_by_foreign` (`created_by`),
  CONSTRAINT `question_categories_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `question_categories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_level`;
CREATE TABLE `question_level` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_level_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_level_question_id_foreign` (`question_id`),
  KEY `question_level_question_bank_level_id_foreign` (`question_bank_level_id`),
  CONSTRAINT `question_level_question_bank_level_id_foreign` FOREIGN KEY (`question_bank_level_id`) REFERENCES `question_bank_levels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_level_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_session`;
CREATE TABLE `question_session` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_session_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_session_question_id_foreign` (`question_id`),
  KEY `question_session_question_bank_session_id_foreign` (`question_bank_session_id`),
  CONSTRAINT `question_session_question_bank_session_id_foreign` FOREIGN KEY (`question_bank_session_id`) REFERENCES `question_bank_sessions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_session_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_source`;
CREATE TABLE `question_source` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_source_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_source_question_id_foreign` (`question_id`),
  KEY `question_source_question_bank_source_id_foreign` (`question_bank_source_id`),
  CONSTRAINT `question_source_question_bank_source_id_foreign` FOREIGN KEY (`question_bank_source_id`) REFERENCES `question_bank_sources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_source_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_sub_source`;
CREATE TABLE `question_sub_source` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_sub_source_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_sub_source_question_id_foreign` (`question_id`),
  KEY `question_sub_source_question_bank_sub_source_id_foreign` (`question_bank_sub_source_id`),
  CONSTRAINT `question_sub_source_question_bank_sub_source_id_foreign` FOREIGN KEY (`question_bank_sub_source_id`) REFERENCES `question_bank_sub_sources` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_sub_source_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_tag`;
CREATE TABLE `question_tag` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_tag_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_tag_question_id_foreign` (`question_id`),
  KEY `question_tag_question_bank_tag_id_foreign` (`question_bank_tag_id`),
  CONSTRAINT `question_tag_question_bank_tag_id_foreign` FOREIGN KEY (`question_bank_tag_id`) REFERENCES `question_bank_tags` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_tag_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_test`;
CREATE TABLE `question_test` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_test_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_test_question_id_foreign` (`question_id`),
  KEY `question_test_question_bank_test_id_foreign` (`question_bank_test_id`),
  CONSTRAINT `question_test_question_bank_test_id_foreign` FOREIGN KEY (`question_bank_test_id`) REFERENCES `question_bank_tests` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_test_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_topic`;
CREATE TABLE `question_topic` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_topic_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_topic_question_id_foreign` (`question_id`),
  KEY `question_topic_question_bank_topic_id_foreign` (`question_bank_topic_id`),
  CONSTRAINT `question_topic_question_bank_topic_id_foreign` FOREIGN KEY (`question_bank_topic_id`) REFERENCES `question_bank_topics` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_topic_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `question_type`;
CREATE TABLE `question_type` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_id` bigint(20) unsigned NOT NULL,
  `question_bank_type_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `question_type_question_id_foreign` (`question_id`),
  KEY `question_type_question_bank_type_id_foreign` (`question_bank_type_id`),
  CONSTRAINT `question_type_question_bank_type_id_foreign` FOREIGN KEY (`question_bank_type_id`) REFERENCES `question_bank_types` (`id`) ON DELETE CASCADE,
  CONSTRAINT `question_type_question_id_foreign` FOREIGN KEY (`question_id`) REFERENCES `questions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `questions`;
CREATE TABLE `questions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question_bank_class_id` bigint(20) unsigned DEFAULT NULL,
  `question_bank_group_id` bigint(20) unsigned DEFAULT NULL,
  `question_category_id` bigint(20) unsigned DEFAULT NULL,
  `question_bank_subject_id` bigint(20) unsigned DEFAULT NULL,
  `question_bank_chapter_id` bigint(20) unsigned DEFAULT NULL,
  `question_bank_difficulty_level_id` bigint(20) unsigned DEFAULT NULL,
  `type` enum('true_false','multiple_choice','multiple_true_false') NOT NULL,
  `question_name` text DEFAULT NULL,
  `question` longtext NOT NULL,
  `options` longtext NOT NULL,
  `correct_answer` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin NOT NULL CHECK (json_valid(`correct_answer`)),
  `explanation` longtext DEFAULT NULL,
  `marks` int(11) NOT NULL DEFAULT 1,
  `negative_marks` int(11) NOT NULL DEFAULT 0,
  `negative_marks_type` enum('fixed','percentage') NOT NULL DEFAULT 'fixed',
  `image_file` varchar(191) DEFAULT NULL,
  `price` decimal(8,4) DEFAULT NULL,
  `question_year` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`question_year`)),
  `language` varchar(191) NOT NULL DEFAULT 'bn',
  `status` enum('active','inactive','draft') NOT NULL DEFAULT 'inactive' COMMENT 'Lesson status: active, inactive, draft',
  `institute_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `questions_question_bank_class_id_foreign` (`question_bank_class_id`),
  KEY `questions_question_bank_group_id_foreign` (`question_bank_group_id`),
  KEY `questions_question_category_id_foreign` (`question_category_id`),
  KEY `questions_question_bank_subject_id_foreign` (`question_bank_subject_id`),
  KEY `questions_question_bank_chapter_id_foreign` (`question_bank_chapter_id`),
  KEY `questions_question_bank_difficulty_level_id_foreign` (`question_bank_difficulty_level_id`),
  KEY `questions_institute_id_foreign` (`institute_id`),
  KEY `questions_created_by_foreign` (`created_by`),
  CONSTRAINT `questions_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `questions_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE SET NULL,
  CONSTRAINT `questions_question_bank_chapter_id_foreign` FOREIGN KEY (`question_bank_chapter_id`) REFERENCES `question_bank_chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `questions_question_bank_class_id_foreign` FOREIGN KEY (`question_bank_class_id`) REFERENCES `question_bank_classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `questions_question_bank_difficulty_level_id_foreign` FOREIGN KEY (`question_bank_difficulty_level_id`) REFERENCES `question_bank_difficulty_levels` (`id`) ON DELETE CASCADE,
  CONSTRAINT `questions_question_bank_group_id_foreign` FOREIGN KEY (`question_bank_group_id`) REFERENCES `question_bank_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `questions_question_bank_subject_id_foreign` FOREIGN KEY (`question_bank_subject_id`) REFERENCES `question_bank_subjects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `questions_question_category_id_foreign` FOREIGN KEY (`question_category_id`) REFERENCES `question_categories` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `quiz_attempts`;
CREATE TABLE `quiz_attempts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `quiz_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `answers` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`answers`)),
  `score` double NOT NULL DEFAULT 0,
  `status` enum('started','submitted','reviewed') NOT NULL DEFAULT 'started',
  `started_at` timestamp NULL DEFAULT NULL,
  `submitted_at` timestamp NULL DEFAULT NULL,
  `time_taken` int(11) DEFAULT NULL COMMENT 'Time taken in seconds',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_attempts_institute_id_foreign` (`institute_id`),
  KEY `quiz_attempts_branch_id_foreign` (`branch_id`),
  KEY `quiz_attempts_quiz_id_foreign` (`quiz_id`),
  KEY `quiz_attempts_user_id_foreign` (`user_id`),
  CONSTRAINT `quiz_attempts_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_attempts_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_attempts_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_attempts_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `quiz_results`;
CREATE TABLE `quiz_results` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `quiz_id` bigint(20) unsigned NOT NULL,
  `quiz_attempt_id` bigint(20) unsigned NOT NULL,
  `score` double NOT NULL DEFAULT 0,
  `negative_marks` double NOT NULL DEFAULT 0,
  `position` int(11) DEFAULT NULL,
  `question_count` int(11) DEFAULT NULL,
  `correct_count` int(11) NOT NULL DEFAULT 0,
  `incorrect_count` int(11) NOT NULL DEFAULT 0,
  `skipped_count` int(11) NOT NULL DEFAULT 0,
  `detailed_results` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`detailed_results`)),
  `is_passed` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_results_institute_id_foreign` (`institute_id`),
  KEY `quiz_results_branch_id_foreign` (`branch_id`),
  KEY `quiz_results_quiz_id_foreign` (`quiz_id`),
  KEY `quiz_results_quiz_attempt_id_foreign` (`quiz_attempt_id`),
  CONSTRAINT `quiz_results_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_results_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_results_quiz_attempt_id_foreign` FOREIGN KEY (`quiz_attempt_id`) REFERENCES `quiz_attempts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_results_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `quiz_topics`;
CREATE TABLE `quiz_topics` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `quiz_id` bigint(20) unsigned NOT NULL,
  `question_bank_subject_id` bigint(20) unsigned DEFAULT NULL,
  `question_bank_chapter_id` bigint(20) unsigned DEFAULT NULL,
  `question_category_id` bigint(20) unsigned DEFAULT NULL,
  `question_limit` int(11) NOT NULL DEFAULT 10,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quiz_topics_institute_id_foreign` (`institute_id`),
  KEY `quiz_topics_quiz_id_foreign` (`quiz_id`),
  KEY `quiz_topics_question_bank_subject_id_foreign` (`question_bank_subject_id`),
  KEY `quiz_topics_question_bank_chapter_id_foreign` (`question_bank_chapter_id`),
  KEY `quiz_topics_question_category_id_foreign` (`question_category_id`),
  CONSTRAINT `quiz_topics_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_topics_question_bank_chapter_id_foreign` FOREIGN KEY (`question_bank_chapter_id`) REFERENCES `question_bank_chapters` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_topics_question_bank_subject_id_foreign` FOREIGN KEY (`question_bank_subject_id`) REFERENCES `question_bank_subjects` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_topics_question_category_id_foreign` FOREIGN KEY (`question_category_id`) REFERENCES `question_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quiz_topics_quiz_id_foreign` FOREIGN KEY (`quiz_id`) REFERENCES `quizzes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `quizzes`;
CREATE TABLE `quizzes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `priority` int(10) unsigned NOT NULL DEFAULT 1,
  `title` varchar(191) NOT NULL,
  `description` longtext DEFAULT NULL,
  `guidelines` longtext DEFAULT NULL,
  `show_description_on_course_page` tinyint(1) NOT NULL DEFAULT 0,
  `type` enum('practice','mock','quick_test','exam') NOT NULL DEFAULT 'practice',
  `question_ids` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`question_ids`)),
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  `has_time_limit` tinyint(1) NOT NULL DEFAULT 0,
  `time_limit_value` int(11) DEFAULT NULL,
  `time_limit_unit` enum('seconds','minutes','hours','days','weeks') DEFAULT NULL,
  `on_expiry` enum('auto_submit','prevent_submit','grace_time') NOT NULL DEFAULT 'auto_submit',
  `marks_per_question` decimal(5,2) NOT NULL DEFAULT 1.00,
  `negative_marks_per_wrong_answer` decimal(5,2) NOT NULL DEFAULT 0.00,
  `pass_mark` decimal(5,2) NOT NULL DEFAULT 0.00,
  `attempts_allowed` int(11) DEFAULT NULL,
  `enable_negative_marking` tinyint(1) NOT NULL DEFAULT 0,
  `result_visibility` enum('immediate','after_review','never') NOT NULL DEFAULT 'immediate',
  `layout_pages` int(11) DEFAULT NULL,
  `shuffle_questions` tinyint(1) NOT NULL DEFAULT 0,
  `shuffle_options` tinyint(1) NOT NULL DEFAULT 0,
  `access_type` enum('none','password','public') NOT NULL DEFAULT 'none',
  `access_password` varchar(191) DEFAULT NULL,
  `status` enum('active','inactive','draft') NOT NULL DEFAULT 'active' COMMENT 'Lesson status: active, inactive, draft',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `quizzes_institute_id_foreign` (`institute_id`),
  KEY `quizzes_branch_id_foreign` (`branch_id`),
  KEY `quizzes_created_by_foreign` (`created_by`),
  CONSTRAINT `quizzes_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `quizzes_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `quizzes_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `ready_to_join_us`;
CREATE TABLE `ready_to_join_us` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `button_name` varchar(100) DEFAULT NULL,
  `button_link` varchar(500) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `ready_to_join_us_institute_id_foreign` (`institute_id`),
  KEY `ready_to_join_us_branch_id_foreign` (`branch_id`),
  CONSTRAINT `ready_to_join_us_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `ready_to_join_us_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `ready_to_join_us` VALUES (1,1,1,'Enquire & visit','Call us or book a campus tour to meet our teachers and see the school.','inquiry.png','Contact us','#','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,'Apply online','Fill in the application form and upload the learner\'s birth certificate and last report.','apply.png','Apply now','#','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,1,1,'Confirm your place','Pay the admission fee by M-Pesa and complete enrolment for the new term.','confirm.png','Admission requirements','#','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `remark_configs`;
CREATE TABLE `remark_configs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `remark_title` varchar(191) NOT NULL,
  `remarks` longtext NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `remark_configs_institute_id_foreign` (`institute_id`),
  KEY `remark_configs_branch_id_foreign` (`branch_id`),
  CONSTRAINT `remark_configs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `remark_configs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `remark_configs` VALUES (1,1,1,'A+','Outstanding performance. Keep up the excellent work!',NULL,NULL,NULL),(2,1,1,'A','Very good. A strong performance overall.',NULL,NULL,NULL),(3,1,1,'A-','Good job. Minor areas for improvement.',NULL,NULL,NULL),(4,1,1,'B','Above average. Keep pushing forward.',NULL,NULL,NULL),(5,1,1,'C','Average performance. Needs additional focus on key areas.',NULL,NULL,NULL),(6,1,1,'D','Weak performance. A lot of work is needed.',NULL,NULL,NULL),(7,1,1,'F','Unsatisfactory. Failed to meet the basic requirements.',NULL,NULL,NULL);
DROP TABLE IF EXISTS `resources`;
CREATE TABLE `resources` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(255) NOT NULL,
  `session_id` int(11) NOT NULL,
  `date` varchar(255) NOT NULL,
  `class_id` int(11) NOT NULL,
  `section_id` int(11) NOT NULL,
  `subject_id` int(11) DEFAULT NULL,
  `note` varchar(255) NOT NULL,
  `file` varchar(255) DEFAULT NULL,
  `file_2` varchar(255) DEFAULT NULL,
  `file_3` varchar(255) DEFAULT NULL,
  `file_4` varchar(255) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `resources_institute_id_foreign` (`institute_id`),
  KEY `resources_branch_id_foreign` (`branch_id`),
  CONSTRAINT `resources_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `resources_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `result_cards`;
CREATE TABLE `result_cards` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(100) NOT NULL,
  `qr_code` varchar(191) DEFAULT NULL,
  `signature_id` bigint(20) unsigned DEFAULT NULL,
  `teacher_signature_id` bigint(20) unsigned DEFAULT NULL,
  `background_image` varchar(191) DEFAULT NULL,
  `header_logo` varchar(191) DEFAULT NULL,
  `stamp_image` varchar(191) DEFAULT NULL,
  `border_design` varchar(191) DEFAULT NULL,
  `watermark` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `result_cards_institute_id_foreign` (`institute_id`),
  KEY `result_cards_branch_id_foreign` (`branch_id`),
  KEY `result_cards_signature_id_foreign` (`signature_id`),
  KEY `result_cards_teacher_signature_id_foreign` (`teacher_signature_id`),
  CONSTRAINT `result_cards_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `result_cards_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `result_cards_signature_id_foreign` FOREIGN KEY (`signature_id`) REFERENCES `signatures` (`id`) ON DELETE SET NULL,
  CONSTRAINT `result_cards_teacher_signature_id_foreign` FOREIGN KEY (`teacher_signature_id`) REFERENCES `signatures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `role_has_permissions`;
CREATE TABLE `role_has_permissions` (
  `permission_id` bigint(20) unsigned NOT NULL,
  `role_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY (`permission_id`,`role_id`),
  KEY `role_has_permissions_role_id_foreign` (`role_id`),
  CONSTRAINT `role_has_permissions_permission_id_foreign` FOREIGN KEY (`permission_id`) REFERENCES `permissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `role_has_permissions_role_id_foreign` FOREIGN KEY (`role_id`) REFERENCES `roles` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `role_has_permissions` VALUES (1,1),(2,1),(3,1),(4,6),(4,15),(5,7),(5,16),(6,8),(6,17),(7,2),(7,9),(7,11),(7,18),(8,2),(8,10),(8,11),(8,19),(9,1),(9,2),(9,3),(9,4),(9,5),(9,6),(9,7),(9,8),(9,9),(9,10),(9,11),(9,12),(9,13),(9,14),(9,15),(9,16),(9,17),(9,18),(9,19),(10,1),(10,2),(10,3),(10,4),(10,5),(10,11),(10,12),(10,13),(10,14),(11,2),(11,3),(11,11),(11,12),(12,2),(12,3),(12,11),(12,12),(13,2),(13,3),(13,11),(13,12),(14,2),(14,3),(14,11),(14,12),(15,2),(15,3),(15,11),(15,12),(16,2),(16,3),(16,11),(16,12),(17,2),(17,3),(17,11),(17,12),(18,2),(18,3),(18,11),(18,12),(19,2),(19,3),(19,11),(19,12),(20,2),(20,3),(20,11),(20,12),(21,2),(21,3),(21,11),(21,12),(22,2),(22,3),(22,11),(22,12),(23,2),(23,3),(23,11),(23,12),(24,2),(24,3),(24,11),(24,12),(25,2),(25,3),(25,11),(25,12),(26,2),(26,3),(26,11),(26,12),(27,2),(27,3),(27,11),(27,12),(28,2),(28,3),(28,11),(28,12),(29,2),(29,3),(29,11),(29,12),(30,2),(30,3),(30,11),(30,12),(31,2),(31,3),(31,11),(31,12),(32,2),(32,3),(32,11),(32,12),(33,2),(33,3),(33,11),(33,12),(34,2),(34,3),(34,11),(34,12),(35,2),(35,3),(35,11),(35,12),(36,2),(36,3),(36,11),(36,12),(37,2),(37,3),(37,11),(37,12),(38,2),(38,3),(38,11),(38,12),(39,2),(39,3),(39,11),(39,12),(40,2),(40,3),(40,11),(40,12),(41,2),(41,3),(41,11),(41,12),(42,2),(42,3),(42,11),(42,12),(43,2),(43,3),(43,11),(43,12),(44,2),(44,3),(44,11),(44,12),(45,2),(45,3),(45,11),(45,12),(46,2),(46,3),(46,11),(46,12),(47,2),(47,3),(47,11),(47,12),(48,2),(48,3),(48,11),(48,12),(49,2),(49,3),(49,11),(49,12),(50,2),(50,3),(50,11),(50,12),(51,2),(51,4),(51,11),(51,13),(52,2),(52,4),(52,11),(52,13),(53,2),(53,4),(53,11),(53,13),(54,2),(54,4),(54,11),(54,13),(55,2),(55,4),(55,11),(55,13),(56,2),(56,4),(56,11),(56,13),(57,2),(57,4),(57,11),(57,13),(58,2),(58,4),(58,11),(58,13),(59,2),(59,4),(59,11),(59,13),(60,2),(60,4),(60,11),(60,13),(61,2),(61,4),(61,11),(61,13),(62,2),(62,4),(62,11),(62,13),(63,2),(63,4),(63,11),(63,13),(64,2),(64,4),(64,11),(64,13),(65,2),(65,4),(65,11),(65,13),(66,2),(66,4),(66,11),(66,13),(67,2),(67,4),(67,11),(67,13),(68,2),(68,4),(68,11),(68,13),(69,2),(69,4),(69,11),(69,13),(70,2),(70,4),(70,11),(70,13),(71,2),(71,4),(71,11),(71,13),(72,2),(72,4),(72,11),(72,13),(73,2),(73,4),(73,11),(73,13),(74,2),(74,4),(74,11),(74,13),(75,2),(75,4),(75,11),(75,13),(76,2),(76,4),(76,11),(76,13),(77,2),(77,4),(77,11),(77,13),(78,2),(78,4),(78,11),(78,13),(79,2),(79,4),(79,11),(79,13),(80,2),(80,4),(80,11),(80,13),(81,2),(81,4),(81,11),(81,13),(82,2),(82,4),(82,11),(82,13),(83,2),(83,4),(83,11),(83,13),(84,2),(84,4),(84,11),(84,13),(85,2),(85,4),(85,11),(85,13),(86,2),(86,4),(86,11),(86,13),(87,2),(87,4),(87,11),(87,13),(88,2),(88,4),(88,11),(88,13),(89,2),(89,3),(89,11),(89,12),(90,2),(90,3),(90,11),(90,12),(91,2),(91,3),(91,11),(91,12),(92,2),(92,3),(92,11),(92,12),(93,2),(93,3),(93,11),(93,12),(94,2),(94,3),(94,5),(94,11),(94,12),(94,14),(95,2),(95,3),(95,5),(95,11),(95,12),(95,14),(96,2),(96,3),(96,5),(96,11),(96,12),(96,14),(97,2),(97,3),(97,5),(97,11),(97,12),(97,14),(98,2),(98,3),(98,5),(98,11),(98,12),(98,14),(99,2),(99,3),(99,5),(99,11),(99,12),(99,14),(100,2),(100,3),(100,11),(100,12),(101,2),(101,3),(101,11),(101,12),(102,2),(102,3),(102,11),(102,12),(103,2),(103,3),(103,11),(103,12),(104,2),(104,3),(104,11),(104,12),(105,2),(105,3),(105,11),(105,12),(106,2),(106,3),(106,11),(106,12),(107,2),(107,3),(107,11),(107,12),(108,2),(108,3),(108,11),(108,12),(109,2),(109,3),(109,11),(109,12),(110,2),(110,3),(110,11),(110,12),(111,2),(111,3),(111,11),(111,12),(112,2),(112,3),(112,11),(112,12),(113,2),(113,3),(113,11),(113,12),(114,2),(114,3),(114,11),(114,12),(115,2),(115,3),(115,11),(115,12),(116,2),(116,3),(116,11),(116,12),(117,2),(117,3),(117,11),(117,12),(118,2),(118,3),(118,11),(118,12),(119,2),(119,3),(119,11),(119,12),(120,2),(120,3),(120,11),(120,12),(121,2),(121,3),(121,11),(121,12),(122,2),(122,3),(122,11),(122,12),(123,2),(123,3),(123,11),(123,12),(124,2),(124,3),(124,11),(124,12),(125,2),(125,3),(125,11),(125,12),(126,2),(126,3),(126,11),(126,12),(127,2),(127,3),(127,11),(127,12),(128,1),(128,2),(128,3),(128,11),(128,12),(129,2),(129,3),(129,11),(129,12),(130,2),(130,3),(130,11),(130,12),(131,1),(131,2),(131,3),(131,11),(131,12),(132,2),(132,11),(133,2),(133,3),(133,11),(133,12),(134,2),(134,3),(134,11),(134,12),(135,2),(135,3),(135,11),(135,12),(136,2),(136,3),(136,11),(136,12),(137,2),(137,3),(137,11),(137,12),(138,2),(138,3),(138,11),(138,12),(139,2),(139,3),(139,11),(139,12),(140,2),(140,3),(140,11),(140,12),(141,2),(141,11),(142,2),(142,11),(143,2),(143,11),(144,2),(144,11),(145,2),(145,11),(146,2),(146,11),(147,2),(147,11),(148,2),(148,11),(149,1),(149,2),(149,11);
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `guard_name` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `roles_name_guard_name_institute_id_branch_id_unique` (`name`,`guard_name`,`institute_id`,`branch_id`),
  KEY `roles_institute_id_foreign` (`institute_id`),
  KEY `roles_branch_id_foreign` (`branch_id`),
  CONSTRAINT `roles_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `roles_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=56 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `roles` VALUES (1,1,1,'SAAS Admin','web','This is SAAS-Admin role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(2,1,1,'Super Admin','web','This is Super Admin role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(3,1,1,'System Admin','web','This is System Admin role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(4,1,1,'Accountant','web','This is Accountant role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(5,1,1,'Librarian','web','This is Librarian role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(6,1,1,'Teacher','web','This is Teacher role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(7,1,1,'Student','web','This is Student role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(8,1,1,'Parent','web','This is Parent role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(9,1,1,'Hostel','web','This is Hostel role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(10,1,1,'Transport','web','This is Transport role','2026-03-30 11:21:04','2026-03-30 11:21:04'),(11,1,2,'Super Admin','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(12,1,2,'System Admin','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(13,1,2,'Accountant','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(14,1,2,'Librarian','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(15,1,2,'Teacher','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(16,1,2,'Student','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(17,1,2,'Parent','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(18,1,2,'Hostel','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34'),(19,1,2,'Transport','web',NULL,'2026-10-19 16:38:34','2026-10-19 16:38:34');
DROP TABLE IF EXISTS `room_members`;
CREATE TABLE `room_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `room_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `room_members_institute_id_foreign` (`institute_id`),
  KEY `room_members_branch_id_foreign` (`branch_id`),
  KEY `room_members_room_id_foreign` (`room_id`),
  KEY `room_members_student_id_foreign` (`student_id`),
  CONSTRAINT `room_members_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_members_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_members_room_id_foreign` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`id`) ON DELETE CASCADE,
  CONSTRAINT `room_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `rooms`;
CREATE TABLE `rooms` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `hostel_category_id` bigint(20) unsigned NOT NULL,
  `room_number` varchar(20) NOT NULL,
  `capacity` int(11) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rooms_institute_id_foreign` (`institute_id`),
  KEY `rooms_branch_id_foreign` (`branch_id`),
  KEY `rooms_hostel_category_id_foreign` (`hostel_category_id`),
  CONSTRAINT `rooms_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rooms_hostel_category_id_foreign` FOREIGN KEY (`hostel_category_id`) REFERENCES `hostel_categories` (`id`) ON DELETE CASCADE,
  CONSTRAINT `rooms_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `s_a_a_s_faqs`;
CREATE TABLE `s_a_a_s_faqs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `question` varchar(255) NOT NULL,
  `answer` longtext DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `s_a_a_s_faqs_created_by_foreign` (`created_by`),
  CONSTRAINT `s_a_a_s_faqs_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `s_a_a_s_faqs` VALUES (1,'What is an academic program?','The academic program is a one stop solution for students. Where every student has the opportunity to ensure A+ preparation for  board exams through interactive live classes, homework, live tests and progress analysis by the best mentors in each subject throughout the year. Once a student starts this program, he will not have to go to any coaching or private tutor after school/college.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,'What is an academic program?','The academic program is a one stop solution for students. Where every student has the opportunity to ensure A+ preparation for  board exams through interactive live classes, homework, live tests and progress analysis by the best mentors in each subject throughout the year. Once a student starts this program, he will not have to go to any coaching or private tutor after school/college.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,'What is an academic program?','The academic program is a one stop solution for students. Where every student has the opportunity to ensure A+ preparation for  board exams through interactive live classes, homework, live tests and progress analysis by the best mentors in each subject throughout the year. Once a student starts this program, he will not have to go to any coaching or private tutor after school/college.',1,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `s_a_a_s_settings`;
CREATE TABLE `s_a_a_s_settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `value` longtext DEFAULT NULL,
  `payment_info` longtext DEFAULT NULL,
  `sms_info` longtext DEFAULT NULL,
  `type` varchar(191) DEFAULT 'general',
  `mode` varchar(191) DEFAULT NULL,
  `status` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=46 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `s_a_a_s_settings` VALUES (1,'site_name','Class Compass',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(2,'site_title','Class Compass - School Management System',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(3,'phone','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(4,'office_phone','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(5,'email','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(6,'language','en',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(7,'google_map','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(8,'address','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(9,'on_google_map','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(10,'currency_symbol','KSh',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(11,'logo','logo.png',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(12,'disabled_website','no',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(13,'copyright_text','&copy; Copyright 2025. All Rights Reserved by Class Compass',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(14,'facebook_link','https://www.facebook.com/',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(15,'google_plus_link','https://www.google.com/',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(16,'youtube_link','https://www.youtube.com/',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(17,'whats_app_link','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(18,'twitter_link','https://www.twitter.com',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(19,'header_notice','',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(20,'app_version','1.0.0',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(21,'app_url','drive-link',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(22,'primary_color','0xFF016DF6',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(23,'secondary_color','0xFF043268',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(24,'primary_container_color','0xFF00C090',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(25,'dark_primary_color','0xFF5AA2FF',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(26,'dark_secondary_color','0xFF00C090',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(27,'dark_container_color','0xFF043268',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(28,'text_color','0xFF043268',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(29,'dark_text_colo',NULL,NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(30,'sidebar_selected_bg_color','0xFF016DF6',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(31,'sidebar_selected_text_color','0xFFFFFFFF',NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(32,'sidebar_selected_text_color',NULL,NULL,NULL,'general',NULL,NULL,NULL,NULL,NULL),(33,'vercel_project_id','prj_8PvmJHMdDZNsnjGEK3AarjW75uO4',NULL,NULL,'vercel',NULL,NULL,NULL,NULL,NULL),(34,'vercel_token','',NULL,NULL,'vercel',NULL,NULL,NULL,NULL,NULL),(35,'bkash',NULL,'{\"app_key\":\"\",\"app_secret\":\"\",\"username\":\"\",\"password\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(36,'paystack',NULL,'{\"public_key\":\"\",\"secret_key\":\"\",\"merchant_email\":\"\",\"callback_url\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(37,'razor_pay',NULL,'{\"api_key\":\"rzp_test_jXtU63C342FF9B\",\"api_secret\":\"nrzllzn50ELsRHwFwYthIgBT\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(38,'stripe',NULL,'{\"published_key\":\"\",\"api_key\":\"\",\"mode\":\"test\",\"other_config_key\":\"test_value\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(39,'ssl_commerz',NULL,'{\"store_id\":\"\",\"store_password\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(40,'pvit',NULL,'{\"mc_tel_merchant\":\"\",\"access_token\":\"\",\"mc_merchant_code\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(41,'paypal',NULL,'{\"client_id\":\"\",\"client_secret\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(42,'paymob_accept',NULL,'{\"api_key\":\"\",\"integration_id\":\"\",\"iframe_id\":\"\",\"hmac_secret\":\"\",\"supported_country\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(43,'flutterwave',NULL,'{\"public_key\":\"\",\"secret_key\":\"\",\"encryption_key\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(44,'senang_pay',NULL,'{\"merchant_id\":\"\",\"secret_key\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL),(45,'paytm',NULL,'{\"merchant_id\":\"\",\"merchant_key\":\"\",\"merchant_website_link\":\"\",\"refund_url\":\"\"}',NULL,'payment_config','test','1',NULL,NULL,NULL);
DROP TABLE IF EXISTS `s_a_a_s_subscriptions`;
CREATE TABLE `s_a_a_s_subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `email` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `s_a_a_s_subscriptions_email_unique` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `salary_head_user_payrolls`;
CREATE TABLE `salary_head_user_payrolls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_payroll_id` bigint(20) unsigned NOT NULL,
  `salary_head_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salary_head_user_payrolls_institute_id_foreign` (`institute_id`),
  KEY `salary_head_user_payrolls_branch_id_foreign` (`branch_id`),
  CONSTRAINT `salary_head_user_payrolls_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `salary_head_user_payrolls_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `salary_head_user_payrolls` VALUES (1,1,1,1,1,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(2,1,1,1,2,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(3,1,1,1,3,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(4,1,1,1,4,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(5,1,1,1,5,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(6,1,1,1,6,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(7,1,1,1,7,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(8,1,1,1,8,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(9,1,1,1,9,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(10,1,1,1,10,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(11,1,1,2,1,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(12,1,1,2,2,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(13,1,1,2,3,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(14,1,1,2,4,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(15,1,1,2,5,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(16,1,1,2,6,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(17,1,1,2,7,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(18,1,1,2,8,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(19,1,1,2,9,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(20,1,1,2,10,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(21,1,1,3,1,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(22,1,1,3,2,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(23,1,1,3,3,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(24,1,1,3,4,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(25,1,1,3,5,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(26,1,1,3,6,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(27,1,1,3,7,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(28,1,1,3,8,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(29,1,1,3,9,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(30,1,1,3,10,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(31,1,1,4,1,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(32,1,1,4,2,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(33,1,1,4,3,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(34,1,1,4,4,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(35,1,1,4,5,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(36,1,1,4,6,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(37,1,1,4,7,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(38,1,1,4,8,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(39,1,1,4,9,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(40,1,1,4,10,10.00,'2026-03-30 11:21:14','2026-03-30 11:21:14');
DROP TABLE IF EXISTS `salary_heads`;
CREATE TABLE `salary_heads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(50) NOT NULL,
  `type` enum('Addition','Deduction') NOT NULL DEFAULT 'Addition',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `salary_heads_institute_id_foreign` (`institute_id`),
  KEY `salary_heads_branch_id_foreign` (`branch_id`),
  CONSTRAINT `salary_heads_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `salary_heads_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `salary_heads` VALUES (1,1,1,'Basic','Addition','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Allowance','Addition','2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'Early Leave Fine','Deduction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'Festival Allowance','Addition','2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Welfare Fund','Deduction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'Professional Tax','Deduction','2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,'Conveyance','Addition','2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,1,'Exam Hall Duty','Addition','2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,1,'Incentive','Addition','2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,1,'Medical','Addition','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `sections`;
CREATE TABLE `sections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `student_group_id` bigint(20) unsigned DEFAULT NULL,
  `section_name` varchar(20) NOT NULL,
  `room_no` varchar(20) DEFAULT NULL,
  `class_teacher_id` int(11) DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `rank` int(11) DEFAULT NULL,
  `capacity` int(11) DEFAULT NULL,
  `attendance_time_config_id` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sections_institute_id_foreign` (`institute_id`),
  KEY `sections_branch_id_foreign` (`branch_id`),
  KEY `sections_student_group_id_foreign` (`student_group_id`),
  KEY `sections_class_id_student_group_id_index` (`class_id`,`student_group_id`),
  CONSTRAINT `sections_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  CONSTRAINT `sections_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_student_group_id_foreign` FOREIGN KEY (`student_group_id`) REFERENCES `student_groups` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB AUTO_INCREMENT=87 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `sections` VALUES (1,1,1,1,1,'A','101',NULL,1,NULL,40,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,2,2,'B','102',NULL,1,NULL,35,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,3,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(4,1,1,4,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(5,1,1,5,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(6,1,1,6,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(7,1,1,7,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(8,1,1,8,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(9,1,1,9,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(10,1,1,10,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(11,1,1,11,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(12,1,1,12,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(13,1,1,13,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(14,1,1,14,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(15,1,1,15,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(16,1,1,16,NULL,'A',NULL,NULL,1,NULL,NULL,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40');
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
  `id` varchar(191) NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `payload` longtext NOT NULL,
  `last_activity` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `sessions_user_id_index` (`user_id`),
  KEY `sessions_last_activity_index` (`last_activity`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `value` longtext DEFAULT NULL,
  `payment_info` longtext DEFAULT NULL,
  `sms_info` longtext DEFAULT NULL,
  `type` varchar(191) DEFAULT 'general',
  `mode` varchar(191) DEFAULT NULL,
  `status` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `settings_institute_id_foreign` (`institute_id`),
  KEY `settings_branch_id_foreign` (`branch_id`),
  CONSTRAINT `settings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `settings_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=269 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `settings` VALUES (1,1,1,'school_name','Compass Academy',NULL,NULL,'general',NULL,NULL,NULL,NULL),(2,1,1,'site_title','Compass Academy — CBC School, Nairobi',NULL,NULL,'general',NULL,NULL,NULL,NULL),(3,1,1,'phone','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(4,1,1,'email','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(5,1,1,'language','en',NULL,NULL,'general',NULL,NULL,NULL,NULL),(6,1,1,'google_map','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(7,1,1,'address','Nairobi, Kenya',NULL,NULL,'general',NULL,NULL,NULL,NULL),(8,1,1,'on_google_map','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(9,1,1,'institute_code','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(10,1,1,'timezone','Africa/Nairobi',NULL,NULL,'general',NULL,NULL,NULL,'2026-10-19 09:06:04'),(11,1,1,'academic_year','1',NULL,NULL,'general',NULL,NULL,NULL,NULL),(12,1,1,'currency_symbol','KSh',NULL,NULL,'general',NULL,NULL,NULL,'2026-10-19 09:06:04'),(13,1,1,'mail_type','mail',NULL,NULL,'general',NULL,NULL,NULL,NULL),(14,1,1,'logo','logo.png',NULL,NULL,'general',NULL,NULL,NULL,NULL),(15,1,1,'disabled_website','no',NULL,NULL,'general',NULL,NULL,NULL,NULL),(16,1,1,'copyright_text','&copy; Compass Academy. Powered by Class Compass',NULL,NULL,'general',NULL,NULL,NULL,NULL),(17,1,1,'exam_result_phone','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(18,1,1,'tuition_fee_phone','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(19,1,1,'facebook_link','https://www.facebook.com/',NULL,NULL,'general',NULL,NULL,NULL,NULL),(20,1,1,'google_plus_link','https://www.google.com/',NULL,NULL,'general',NULL,NULL,NULL,NULL),(21,1,1,'youtube_link','https://www.youtube.com/',NULL,NULL,'general',NULL,NULL,NULL,NULL),(22,1,1,'whats_app_link','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(23,1,1,'twitter_link','https://www.twitter.com',NULL,NULL,'general',NULL,NULL,NULL,NULL),(24,1,1,'eiin_code','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(25,1,1,'sms_gateway','twilio',NULL,NULL,'general',NULL,NULL,NULL,NULL),(26,1,1,'bulk_sms_api_key','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(27,1,1,'bulk_sms_sender_id','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(28,1,1,'twilio_sid','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(29,1,1,'twilio_token','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(30,1,1,'twilio_from_number','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(31,1,1,'zoom_account_id','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(32,1,1,'zoom_client_key','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(33,1,1,'zoom_client_secret','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(34,1,1,'header_notice','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(35,1,1,'exam_result_status','no',NULL,NULL,'general',NULL,NULL,NULL,NULL),(36,1,1,'admission_display_status','no',NULL,NULL,'general',NULL,NULL,NULL,NULL),(37,1,1,'tc_amount',NULL,NULL,NULL,'general',NULL,NULL,NULL,NULL),(38,1,1,'primary_color','0xFF016DF6',NULL,NULL,'general',NULL,NULL,NULL,NULL),(39,1,1,'secondary_color','0xFF043268',NULL,NULL,'general',NULL,NULL,NULL,NULL),(40,1,1,'primary_container_color','0xFF00C090',NULL,NULL,'general',NULL,NULL,NULL,NULL),(41,1,1,'dark_primary_color','0xFF5AA2FF',NULL,NULL,'general',NULL,NULL,NULL,NULL),(42,1,1,'dark_secondary_color','0xFF00C090',NULL,NULL,'general',NULL,NULL,NULL,NULL),(43,1,1,'dark_container_color','0xFF043268',NULL,NULL,'general',NULL,NULL,NULL,NULL),(44,1,1,'text_color','0xFF043268',NULL,NULL,'general',NULL,NULL,NULL,NULL),(45,1,1,'dark_text_colo',NULL,NULL,NULL,'general',NULL,NULL,NULL,NULL),(46,1,1,'sidebar_selected_bg_color','0xFF016DF6',NULL,NULL,'general',NULL,NULL,NULL,NULL),(47,1,1,'sidebar_selected_text_color','0xFFFFFFFF',NULL,NULL,'general',NULL,NULL,NULL,NULL),(48,1,1,'sidebar_selected_text_color',NULL,NULL,NULL,'general',NULL,NULL,NULL,NULL),(49,1,1,'guidance','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(50,1,1,'academic_office','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(51,1,1,'tuition_fee','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(52,1,1,'exam_office','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(53,1,1,'website_link','',NULL,NULL,'general',NULL,NULL,NULL,NULL),(54,1,1,'bkash',NULL,'{\"app_key\":\"\",\"app_secret\":\"\",\"username\":\"\",\"password\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(55,1,1,'paystack',NULL,'{\"public_key\": \"\", \"secret_key\": \"\", \"merchant_email\": \"\", \"callback_url\": \"\"}',NULL,'payment_config','test','0',NULL,'2026-10-19 16:45:30'),(56,1,1,'razor_pay',NULL,'{\"api_key\":\"rzp_test_jXtU63C342FF9B\",\"api_secret\":\"nrzllzn50ELsRHwFwYthIgBT\"}',NULL,'payment_config','test','1',NULL,NULL),(57,1,1,'stripe',NULL,'{\"published_key\":\"\",\"api_key\":\"\",\"mode\":\"test\",\"other_config_key\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(58,1,1,'ssl_commerz',NULL,'{\"store_id\":\"\",\"store_password\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(59,1,1,'pvit',NULL,'{\"mc_tel_merchant\":\"\",\"access_token\":\"\",\"mc_merchant_code\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(60,1,1,'paypal',NULL,'{\"client_id\":\"\",\"client_secret\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(61,1,1,'paymob_accept',NULL,'{\"api_key\":\"\",\"integration_id\":\"\",\"iframe_id\":\"\",\"hmac_secret\":\"\",\"supported_country\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(62,1,1,'flutterwave',NULL,'{\"public_key\":\"\",\"secret_key\":\"\",\"encryption_key\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(63,1,1,'senang_pay',NULL,'{\"merchant_id\":\"\",\"secret_key\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(64,1,1,'paytm',NULL,'{\"merchant_id\":\"\",\"merchant_key\":\"\",\"merchant_website_link\":\"\",\"refund_url\":\"\"}',NULL,'payment_config','test','1',NULL,NULL),(65,1,1,'curriculum','cbc',NULL,NULL,'general',NULL,NULL,NULL,'2026-10-19 09:06:04'),(67,1,1,'currency_code','KES',NULL,NULL,'general',NULL,NULL,NULL,'2026-10-19 09:06:04'),(68,1,1,'mpesa',NULL,'{\"consumer_key\": \"\", \"consumer_secret\": \"\", \"shortcode\": \"\", \"passkey\": \"\", \"transaction_type\": \"paybill\", \"till_number\": \"\", \"environment\": \"sandbox\", \"callback_url\": \"\"}',NULL,'payment_config','test','0','2026-10-19 09:07:23','2026-10-19 16:45:29');
DROP TABLE IF EXISTS `shifts`;
CREATE TABLE `shifts` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(20) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `shifts_institute_id_foreign` (`institute_id`),
  KEY `shifts_branch_id_foreign` (`branch_id`),
  CONSTRAINT `shifts_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shifts_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `shifts` VALUES (1,1,1,'Morning Shift','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Day Shift','2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,2,'Morning Shift','2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,2,'Day Shift','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `short_codes`;
CREATE TABLE `short_codes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `short_code_title` varchar(191) NOT NULL,
  `short_code_note` varchar(191) NOT NULL,
  `default_id` int(11) NOT NULL,
  `total_mark` decimal(5,2) NOT NULL,
  `accept_percent` decimal(5,2) NOT NULL,
  `pass_mark` decimal(5,2) NOT NULL,
  `session_id` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `short_codes_institute_id_foreign` (`institute_id`),
  KEY `short_codes_branch_id_foreign` (`branch_id`),
  CONSTRAINT `short_codes_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `short_codes_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `short_codes` VALUES (1,1,1,'SC-1','Short Code -1',1,100.00,1.00,0.00,1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'SC-2','Short Code -2',2,100.00,1.00,0.00,1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'SC-3','Short Code -3',3,100.00,1.00,0.00,1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'SC-4','Short Code -4',4,100.00,1.00,0.00,1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'SC-5','Short Code -5',5,100.00,1.00,0.00,1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'SC-6','Short Code -6',6,100.00,1.00,0.00,1,'2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `signatures`;
CREATE TABLE `signatures` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `place_at` varchar(50) DEFAULT NULL,
  `title` varchar(100) DEFAULT NULL,
  `image` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `signatures_institute_id_foreign` (`institute_id`),
  KEY `signatures_branch_id_foreign` (`branch_id`),
  KEY `signatures_user_id_index` (`user_id`),
  CONSTRAINT `signatures_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `signatures_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `sms_balances`;
CREATE TABLE `sms_balances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `masking_balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `non_masking_balance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_balances_institute_id_foreign` (`institute_id`),
  KEY `sms_balances_branch_id_foreign` (`branch_id`),
  CONSTRAINT `sms_balances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sms_balances_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `sms_balances` VALUES (1,1,1,0.00,0.00,'2026-03-30 11:21:14','2026-03-30 11:21:14');
DROP TABLE IF EXISTS `sms_logs`;
CREATE TABLE `sms_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `receiver` varchar(20) NOT NULL,
  `user_type` enum('Teacher','Staff','Accountant','Librarian','Employee','Student') NOT NULL DEFAULT 'Teacher',
  `message` text NOT NULL,
  `sender_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned DEFAULT NULL,
  `staff_id` bigint(20) unsigned DEFAULT NULL,
  `teacher_id` bigint(20) unsigned DEFAULT NULL,
  `student_id` bigint(20) unsigned DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_logs_institute_id_foreign` (`institute_id`),
  KEY `sms_logs_branch_id_foreign` (`branch_id`),
  KEY `sms_logs_user_id_foreign` (`user_id`),
  KEY `sms_logs_staff_id_foreign` (`staff_id`),
  KEY `sms_logs_teacher_id_foreign` (`teacher_id`),
  KEY `sms_logs_student_id_foreign` (`student_id`),
  KEY `sms_logs_receiver_user_type_status_index` (`receiver`,`user_type`,`status`),
  KEY `sms_logs_sender_id_index` (`sender_id`),
  CONSTRAINT `sms_logs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sms_logs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sms_logs_sender_id_foreign` FOREIGN KEY (`sender_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sms_logs_staff_id_foreign` FOREIGN KEY (`staff_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `sms_logs_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE SET NULL,
  CONSTRAINT `sms_logs_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `sms_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `sms_purchases`;
CREATE TABLE `sms_purchases` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `sms_gateway` varchar(191) NOT NULL,
  `masking_type` varchar(191) NOT NULL,
  `transaction_date` date NOT NULL,
  `no_of_sms` int(10) unsigned NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_purchases_institute_id_foreign` (`institute_id`),
  KEY `sms_purchases_branch_id_foreign` (`branch_id`),
  CONSTRAINT `sms_purchases_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sms_purchases_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `sms_templates`;
CREATE TABLE `sms_templates` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `description` text NOT NULL,
  `active` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `sms_templates_institute_id_foreign` (`institute_id`),
  KEY `sms_templates_branch_id_foreign` (`branch_id`),
  CONSTRAINT `sms_templates_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sms_templates_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `sms_templates` VALUES (1,1,1,'Admission','Congratulations!🎓 You`ve been accepted into DEMO. 📚 Get ready for an exciting academic journey ahead. 🌟 Orientation  details will be sent shortly. Welcome to the DEMO family!',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(2,1,1,'Exam Notice','Annual exam will be held on pls collect your admit card',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(3,1,1,'Headmaster','Dear Parents, This is to inform you that school will be closed tomorrow.',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(4,1,1,'Holiday Notice','Kindly note that the school will remain closed on 14th & 15th April 16 for the Occasion of Pohela Boishakh',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(5,1,1,'Urgent Meeting','Dear Teacher, An Urgent Meeting will held on Today at 5.30pm. Please Attend on Just Time. Principal',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(6,1,1,'Guardian Assembly','Respected Parents Dear Sir, On 01/01/2025 school has organized a parent meeting, I would like to request your presence in the said meeting.',1,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(7,1,1,'Present','Your child did not attend today.',1,'2026-03-30 11:21:14','2026-03-30 11:21:14');
DROP TABLE IF EXISTS `staff_attendances`;
CREATE TABLE `staff_attendances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `date` date NOT NULL,
  `type` enum('Teacher','Staff','Accountant','Librarian','Employee') NOT NULL DEFAULT 'Teacher',
  `attendance` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `start_time` time DEFAULT NULL,
  `end_time` time DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_user_attendance_date` (`user_id`,`date`),
  KEY `staff_attendances_institute_id_foreign` (`institute_id`),
  KEY `staff_attendances_branch_id_foreign` (`branch_id`),
  KEY `staff_attendances_user_id_date_index` (`user_id`,`date`),
  CONSTRAINT `staff_attendances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_attendances_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staff_attendances_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `staffs`;
CREATE TABLE `staffs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `designation` varchar(191) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `phone` varchar(25) NOT NULL,
  `blood` varchar(5) DEFAULT NULL,
  `sl` int(11) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `is_administrator` enum('0','1') NOT NULL DEFAULT '0',
  `access_key` varchar(25) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `staffs_institute_id_foreign` (`institute_id`),
  KEY `staffs_branch_id_foreign` (`branch_id`),
  KEY `staffs_department_id_foreign` (`department_id`),
  KEY `staffs_user_id_department_id_index` (`user_id`,`department_id`),
  CONSTRAINT `staffs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staffs_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `staffs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `staffs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `staffs` VALUES (1,1,1,4,1,'Accountant','Accountant',NULL,NULL,NULL,'000000000004',NULL,NULL,NULL,NULL,'0','0',NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,5,1,'Librarian','Librarian',NULL,NULL,NULL,'000000000005',NULL,NULL,NULL,NULL,'0','0',NULL,'2026-03-30 11:21:13','2026-03-30 11:21:13',NULL),(3,1,1,6,1,'Hostel','Hostel',NULL,NULL,NULL,'000000000006',NULL,NULL,NULL,NULL,'0','0',NULL,'2026-03-30 11:21:13','2026-03-30 11:21:13',NULL),(4,1,1,7,1,'Transport','Transport',NULL,NULL,NULL,'000000000007',NULL,NULL,NULL,NULL,'0','0',NULL,'2026-03-30 11:21:14','2026-03-30 11:21:14',NULL);
DROP TABLE IF EXISTS `student_attendances`;
CREATE TABLE `student_attendances` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `period_id` bigint(20) unsigned NOT NULL,
  `subject_id` bigint(20) unsigned DEFAULT NULL,
  `date` date NOT NULL,
  `attendance` tinyint(3) unsigned NOT NULL DEFAULT 2,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_unique_attendance` (`student_id`,`class_id`,`section_id`,`period_id`,`date`),
  KEY `student_attendances_institute_id_foreign` (`institute_id`),
  KEY `student_attendances_branch_id_foreign` (`branch_id`),
  KEY `student_attendances_class_id_foreign` (`class_id`),
  KEY `student_attendances_section_id_foreign` (`section_id`),
  KEY `student_attendances_period_id_foreign` (`period_id`),
  KEY `student_attendances_subject_id_foreign` (`subject_id`),
  KEY `student_attendances_date_index` (`date`),
  CONSTRAINT `student_attendances_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_attendances_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_attendances_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_attendances_period_id_foreign` FOREIGN KEY (`period_id`) REFERENCES `periods` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_attendances_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_attendances_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_attendances_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `student_attendances` VALUES (2,1,1,1,11,11,1,NULL,'2026-10-19',2,'2026-10-19 16:31:23','2026-10-19 16:31:23',NULL);
DROP TABLE IF EXISTS `student_categories`;
CREATE TABLE `student_categories` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `name` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_categories_institute_id_foreign` (`institute_id`),
  KEY `student_categories_branch_id_foreign` (`branch_id`),
  CONSTRAINT `student_categories_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_categories_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `student_categories` VALUES (1,1,1,'General','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Special','2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,2,'General','2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,2,'Special','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `student_collection_details`;
CREATE TABLE `student_collection_details` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL COMMENT 'Academic year',
  `student_collection_id` bigint(20) unsigned NOT NULL,
  `fee_head_id` bigint(20) unsigned NOT NULL,
  `ledger_id` bigint(20) unsigned DEFAULT NULL,
  `total_due` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_payable` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_paid` decimal(8,2) NOT NULL DEFAULT 0.00,
  `waiver` decimal(8,2) NOT NULL DEFAULT 0.00,
  `fine_payable` decimal(8,2) NOT NULL DEFAULT 0.00,
  `fee_payable` decimal(8,2) NOT NULL DEFAULT 0.00,
  `fee_and_fine_payable` decimal(8,2) NOT NULL DEFAULT 0.00,
  `fee_and_fine_paid` decimal(8,2) NOT NULL DEFAULT 0.00,
  `previous_due_payable` decimal(8,2) NOT NULL DEFAULT 0.00,
  `previous_due_paid` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_collection_details_institute_id_foreign` (`institute_id`),
  KEY `student_collection_details_branch_id_foreign` (`branch_id`),
  KEY `student_collection_details_student_id_index` (`student_id`),
  CONSTRAINT `student_collection_details_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_collection_details_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `student_collection_details_sub_heads`;
CREATE TABLE `student_collection_details_sub_heads` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL COMMENT 'Academic year',
  `student_collection_id` bigint(20) unsigned NOT NULL,
  `student_collection_details_id` bigint(20) unsigned NOT NULL,
  `fee_head_id` bigint(20) unsigned NOT NULL,
  `sub_head_id` bigint(20) unsigned NOT NULL,
  `total_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `paid_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `due_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_collection_details_sub_heads_institute_id_foreign` (`institute_id`),
  KEY `student_collection_details_sub_heads_branch_id_foreign` (`branch_id`),
  KEY `student_collection_details_sub_heads_student_id_index` (`student_id`),
  CONSTRAINT `student_collection_details_sub_heads_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_collection_details_sub_heads_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `student_collections`;
CREATE TABLE `student_collections` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `invoice_id` varchar(191) NOT NULL,
  `invoice_date` date DEFAULT NULL,
  `session_id` bigint(20) unsigned NOT NULL COMMENT 'Academic year',
  `tc_amount` decimal(8,2) NOT NULL DEFAULT 0.00,
  `attendance_fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `quiz_fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `lab_fine` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_payable` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_paid` decimal(8,2) NOT NULL DEFAULT 0.00,
  `total_due` decimal(8,2) NOT NULL DEFAULT 0.00,
  `note` text DEFAULT NULL,
  `ledger_id` bigint(20) unsigned DEFAULT NULL,
  `receive_ledger_id` bigint(20) unsigned DEFAULT NULL,
  `fund_id` bigint(20) unsigned DEFAULT NULL,
  `created_by` bigint(20) unsigned NOT NULL,
  `updated_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `student_collections_invoice_id_unique` (`invoice_id`),
  KEY `student_collections_institute_id_foreign` (`institute_id`),
  KEY `student_collections_branch_id_foreign` (`branch_id`),
  KEY `student_collections_class_id_session_id_index` (`class_id`,`session_id`),
  CONSTRAINT `student_collections_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_collections_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `student_devices`;
CREATE TABLE `student_devices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `student_id` bigint(20) unsigned NOT NULL,
  `device_name` varchar(191) DEFAULT NULL,
  `mac_id` varchar(191) DEFAULT NULL,
  `ip_address` varchar(191) DEFAULT NULL,
  `device_info` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`device_info`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_devices_student_id_foreign` (`student_id`),
  CONSTRAINT `student_devices_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `student_groups`;
CREATE TABLE `student_groups` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `group_name` varchar(100) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_groups_institute_id_foreign` (`institute_id`),
  KEY `student_groups_branch_id_foreign` (`branch_id`),
  CONSTRAINT `student_groups_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_groups_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `student_groups` VALUES (1,1,1,'Science','2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Arts','2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `student_migrations`;
CREATE TABLE `student_migrations` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `type` varchar(191) NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned DEFAULT NULL,
  `section_id` bigint(20) unsigned DEFAULT NULL,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `prev_class_id` bigint(20) unsigned DEFAULT NULL,
  `prev_section_id` bigint(20) unsigned DEFAULT NULL,
  `prev_group_id` bigint(20) unsigned DEFAULT NULL,
  `prev_roll` bigint(20) unsigned DEFAULT NULL,
  `new_roll` bigint(20) unsigned DEFAULT NULL,
  `academic_year` bigint(20) unsigned NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_migrations_institute_id_foreign` (`institute_id`),
  KEY `student_migrations_branch_id_foreign` (`branch_id`),
  KEY `student_migrations_class_id_section_id_group_id_index` (`class_id`,`section_id`,`group_id`),
  CONSTRAINT `student_migrations_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_migrations_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `student_sessions`;
CREATE TABLE `student_sessions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `session_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `section_id` bigint(20) unsigned NOT NULL,
  `roll` varchar(15) NOT NULL,
  `qr_code` varchar(32) DEFAULT NULL,
  `optional_subject` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`session_id`,`student_id`,`class_id`,`section_id`,`roll`),
  KEY `student_sessions_institute_id_foreign` (`institute_id`),
  KEY `student_sessions_branch_id_foreign` (`branch_id`),
  KEY `student_sessions_student_id_foreign` (`student_id`),
  KEY `student_sessions_class_id_foreign` (`class_id`),
  KEY `student_sessions_section_id_foreign` (`section_id`),
  KEY `student_sessions_session_id_student_id_class_id_section_id_index` (`session_id`,`student_id`,`class_id`,`section_id`),
  KEY `student_sessions_roll_index` (`roll`),
  KEY `student_sessions_qr_code_index` (`qr_code`),
  CONSTRAINT `student_sessions_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_sessions_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  CONSTRAINT `student_sessions_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_sessions_section_id_foreign` FOREIGN KEY (`section_id`) REFERENCES `sections` (`id`),
  CONSTRAINT `student_sessions_session_id_foreign` FOREIGN KEY (`session_id`) REFERENCES `academic_years` (`id`),
  CONSTRAINT `student_sessions_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `student_sessions` VALUES (1,1,1,1,1,11,11,'1',NULL,NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04',NULL),(2,1,1,1,2,11,11,'9281','15166491',NULL,'2026-10-19 16:31:23','2026-10-19 16:31:25','2026-10-19 16:31:25'),(3,1,1,1,3,11,11,'9383','48463604',NULL,'2026-10-19 16:33:03','2026-10-19 16:33:05','2026-10-19 16:33:05'),(6,1,1,1,6,11,11,'9074','55477475',NULL,'2026-10-19 16:44:35','2026-10-19 16:44:37','2026-10-19 16:44:37');
DROP TABLE IF EXISTS `student_waiver_configs`;
CREATE TABLE `student_waiver_configs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `fee_head_id` bigint(20) unsigned DEFAULT NULL,
  `waiver_id` bigint(20) unsigned NOT NULL,
  `amount` decimal(8,2) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `student_waiver_configs_institute_id_foreign` (`institute_id`),
  KEY `student_waiver_configs_branch_id_foreign` (`branch_id`),
  KEY `student_waiver_configs_student_id_index` (`student_id`),
  CONSTRAINT `student_waiver_configs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `student_waiver_configs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `students`;
CREATE TABLE `students` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `group` varchar(20) DEFAULT NULL,
  `student_category_id` bigint(20) unsigned NOT NULL DEFAULT 1,
  `first_name` varchar(50) NOT NULL,
  `last_name` varchar(20) DEFAULT NULL,
  `phone` varchar(25) NOT NULL,
  `registration_no` bigint(20) unsigned DEFAULT NULL,
  `roll_no` bigint(20) unsigned DEFAULT NULL,
  `father_name` varchar(50) DEFAULT NULL,
  `mother_name` varchar(50) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(20) DEFAULT NULL,
  `blood_group` varchar(5) DEFAULT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `parent_id` bigint(20) unsigned DEFAULT NULL,
  `information_sent_to_name` varchar(191) DEFAULT NULL,
  `information_sent_to_relation` varchar(191) DEFAULT NULL,
  `information_sent_to_phone` varchar(15) DEFAULT NULL,
  `information_sent_to_address` varchar(191) DEFAULT NULL,
  `state` varchar(30) DEFAULT NULL,
  `country` varchar(40) DEFAULT NULL,
  `activities` varchar(191) DEFAULT NULL,
  `access_key` varchar(191) DEFAULT NULL,
  `remarks` longtext DEFAULT NULL,
  `nationality` varchar(191) DEFAULT 'Bangladeshi',
  `birth_certificate_no` varchar(100) DEFAULT NULL,
  `nid_no` varchar(100) DEFAULT NULL,
  `ethnic` varchar(191) DEFAULT NULL,
  `date_of_admission` date DEFAULT NULL,
  `application_number` varchar(20) DEFAULT NULL,
  `admission_place` varchar(191) DEFAULT NULL,
  `tc_date` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `students_institute_id_foreign` (`institute_id`),
  KEY `students_branch_id_foreign` (`branch_id`),
  KEY `students_user_id_phone_group_index` (`user_id`,`phone`,`group`),
  KEY `students_phone_index` (`phone`),
  CONSTRAINT `students_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `students_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `students_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `students` VALUES (1,1,1,9,NULL,1,'Wanjiku','Kamau','254700000101',2026001,1,'Peter Kamau','Grace Kamau',NULL,'Female',NULL,NULL,NULL,'0',1,NULL,NULL,NULL,NULL,NULL,'Kenya',NULL,NULL,NULL,'Kenyan',NULL,NULL,NULL,'2026-10-19',NULL,NULL,NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04',NULL);
DROP TABLE IF EXISTS `subject_configs`;
CREATE TABLE `subject_configs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `group_id` bigint(20) unsigned NOT NULL,
  `subject_id` bigint(20) unsigned NOT NULL,
  `subject_type` varchar(191) DEFAULT NULL,
  `sr_no` int(11) NOT NULL DEFAULT 0,
  `merge_config_id` int(11) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subject_configs_institute_id_foreign` (`institute_id`),
  KEY `subject_configs_branch_id_foreign` (`branch_id`),
  KEY `subject_configs_group_id_foreign` (`group_id`),
  KEY `subject_configs_subject_id_foreign` (`subject_id`),
  KEY `subject_configs_class_id_group_id_subject_id_index` (`class_id`,`group_id`,`subject_id`),
  CONSTRAINT `subject_configs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subject_configs_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subject_configs_group_id_foreign` FOREIGN KEY (`group_id`) REFERENCES `student_groups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subject_configs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subject_configs_subject_id_foreign` FOREIGN KEY (`subject_id`) REFERENCES `subjects` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `subjects`;
CREATE TABLE `subjects` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `subject_name` varchar(40) NOT NULL,
  `subject_code` varchar(20) NOT NULL,
  `subject_short_form` varchar(191) DEFAULT NULL,
  `subject_type` varchar(30) DEFAULT NULL,
  `subject_type_form` varchar(30) DEFAULT NULL,
  `class_id` bigint(20) unsigned NOT NULL,
  `sl_no` bigint(20) unsigned DEFAULT 20,
  `group_id` bigint(20) unsigned DEFAULT NULL,
  `objective` int(10) unsigned DEFAULT 0,
  `written` int(10) unsigned DEFAULT 0,
  `practical` int(10) unsigned DEFAULT 0,
  `full_mark` int(10) unsigned DEFAULT 0,
  `pass_mark` int(10) unsigned DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subjects_institute_id_foreign` (`institute_id`),
  KEY `subjects_branch_id_foreign` (`branch_id`),
  KEY `subjects_class_id_foreign` (`class_id`),
  KEY `subjects_id_class_id_group_id_index` (`id`,`class_id`,`group_id`),
  CONSTRAINT `subjects_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subjects_class_id_foreign` FOREIGN KEY (`class_id`) REFERENCES `classes` (`id`),
  CONSTRAINT `subjects_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=729 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `subjects` VALUES (1,1,1,'Bangla','BAN101','BAN',NULL,NULL,1,20,NULL,0,0,0,100,33,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'English','ENG101','ENG',NULL,NULL,1,20,NULL,0,0,0,100,33,NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'Language Activities','LA-PP1','LA',NULL,NULL,3,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(4,1,1,'Mathematical Activities','MA-PP1','MA',NULL,NULL,3,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(5,1,1,'Environmental Activities','EA-PP1','EA',NULL,NULL,3,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(6,1,1,'Psychomotor & Creative Activities','PCA-PP1','PCA',NULL,NULL,3,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(7,1,1,'Religious Education Activities','REA-PP1','REA',NULL,NULL,3,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(8,1,1,'Language Activities','LA-PP2','LA',NULL,NULL,4,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(9,1,1,'Mathematical Activities','MA-PP2','MA',NULL,NULL,4,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(10,1,1,'Environmental Activities','EA-PP2','EA',NULL,NULL,4,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(11,1,1,'Psychomotor & Creative Activities','PCA-PP2','PCA',NULL,NULL,4,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(12,1,1,'Religious Education Activities','REA-PP2','REA',NULL,NULL,4,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(13,1,1,'English','ENG-1','ENG',NULL,NULL,5,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(14,1,1,'Kiswahili','KIS-1','KIS',NULL,NULL,5,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(15,1,1,'Mathematics','MAT-1','MAT',NULL,NULL,5,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(16,1,1,'Environmental Activities','EA-1','EA',NULL,NULL,5,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(17,1,1,'Creative Activities','CA-1','CA',NULL,NULL,5,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(18,1,1,'Religious Education','RE-1','RE',NULL,NULL,5,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(19,1,1,'Indigenous Language','IL-1','IL',NULL,NULL,5,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(20,1,1,'English','ENG-2','ENG',NULL,NULL,6,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(21,1,1,'Kiswahili','KIS-2','KIS',NULL,NULL,6,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(22,1,1,'Mathematics','MAT-2','MAT',NULL,NULL,6,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(23,1,1,'Environmental Activities','EA-2','EA',NULL,NULL,6,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(24,1,1,'Creative Activities','CA-2','CA',NULL,NULL,6,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(25,1,1,'Religious Education','RE-2','RE',NULL,NULL,6,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(26,1,1,'Indigenous Language','IL-2','IL',NULL,NULL,6,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(27,1,1,'English','ENG-3','ENG',NULL,NULL,7,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(28,1,1,'Kiswahili','KIS-3','KIS',NULL,NULL,7,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(29,1,1,'Mathematics','MAT-3','MAT',NULL,NULL,7,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(30,1,1,'Environmental Activities','EA-3','EA',NULL,NULL,7,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(31,1,1,'Creative Activities','CA-3','CA',NULL,NULL,7,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(32,1,1,'Religious Education','RE-3','RE',NULL,NULL,7,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(33,1,1,'Indigenous Language','IL-3','IL',NULL,NULL,7,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(34,1,1,'English','ENG-4','ENG',NULL,NULL,8,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(35,1,1,'Kiswahili','KIS-4','KIS',NULL,NULL,8,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(36,1,1,'Mathematics','MAT-4','MAT',NULL,NULL,8,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(37,1,1,'Science & Technology','ST-4','ST',NULL,NULL,8,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(38,1,1,'Social Studies','SS-4','SS',NULL,NULL,8,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(39,1,1,'Agriculture & Nutrition','AN-4','AN',NULL,NULL,8,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(40,1,1,'Creative Arts','CA-4','CA',NULL,NULL,8,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(41,1,1,'Religious Education','RE-4','RE',NULL,NULL,8,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(42,1,1,'English','ENG-5','ENG',NULL,NULL,9,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(43,1,1,'Kiswahili','KIS-5','KIS',NULL,NULL,9,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(44,1,1,'Mathematics','MAT-5','MAT',NULL,NULL,9,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(45,1,1,'Science & Technology','ST-5','ST',NULL,NULL,9,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(46,1,1,'Social Studies','SS-5','SS',NULL,NULL,9,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(47,1,1,'Agriculture & Nutrition','AN-5','AN',NULL,NULL,9,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(48,1,1,'Creative Arts','CA-5','CA',NULL,NULL,9,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(49,1,1,'Religious Education','RE-5','RE',NULL,NULL,9,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(50,1,1,'English','ENG-6','ENG',NULL,NULL,10,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(51,1,1,'Kiswahili','KIS-6','KIS',NULL,NULL,10,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(52,1,1,'Mathematics','MAT-6','MAT',NULL,NULL,10,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(53,1,1,'Science & Technology','ST-6','ST',NULL,NULL,10,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(54,1,1,'Social Studies','SS-6','SS',NULL,NULL,10,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(55,1,1,'Agriculture & Nutrition','AN-6','AN',NULL,NULL,10,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(56,1,1,'Creative Arts','CA-6','CA',NULL,NULL,10,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(57,1,1,'Religious Education','RE-6','RE',NULL,NULL,10,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(58,1,1,'English','ENG-7','ENG',NULL,NULL,11,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(59,1,1,'Kiswahili','KIS-7','KIS',NULL,NULL,11,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(60,1,1,'Mathematics','MAT-7','MAT',NULL,NULL,11,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(61,1,1,'Integrated Science','IS-7','IS',NULL,NULL,11,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(62,1,1,'Social Studies','SS-7','SS',NULL,NULL,11,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(63,1,1,'Pre-Technical Studies','PTS-7','PTS',NULL,NULL,11,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(64,1,1,'Agriculture & Nutrition','AN-7','AN',NULL,NULL,11,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(65,1,1,'Creative Arts & Sports','CAS-7','CAS',NULL,NULL,11,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(66,1,1,'Religious Education','RE-7','RE',NULL,NULL,11,9,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(67,1,1,'English','ENG-8','ENG',NULL,NULL,12,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(68,1,1,'Kiswahili','KIS-8','KIS',NULL,NULL,12,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(69,1,1,'Mathematics','MAT-8','MAT',NULL,NULL,12,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(70,1,1,'Integrated Science','IS-8','IS',NULL,NULL,12,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(71,1,1,'Social Studies','SS-8','SS',NULL,NULL,12,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(72,1,1,'Pre-Technical Studies','PTS-8','PTS',NULL,NULL,12,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(73,1,1,'Agriculture & Nutrition','AN-8','AN',NULL,NULL,12,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(74,1,1,'Creative Arts & Sports','CAS-8','CAS',NULL,NULL,12,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(75,1,1,'Religious Education','RE-8','RE',NULL,NULL,12,9,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(76,1,1,'English','ENG-9','ENG',NULL,NULL,13,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(77,1,1,'Kiswahili','KIS-9','KIS',NULL,NULL,13,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(78,1,1,'Mathematics','MAT-9','MAT',NULL,NULL,13,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(79,1,1,'Integrated Science','IS-9','IS',NULL,NULL,13,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(80,1,1,'Social Studies','SS-9','SS',NULL,NULL,13,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(81,1,1,'Pre-Technical Studies','PTS-9','PTS',NULL,NULL,13,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(82,1,1,'Agriculture & Nutrition','AN-9','AN',NULL,NULL,13,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(83,1,1,'Creative Arts & Sports','CAS-9','CAS',NULL,NULL,13,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(84,1,1,'Religious Education','RE-9','RE',NULL,NULL,13,9,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(85,1,1,'English','ENG-10','ENG',NULL,NULL,14,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(86,1,1,'Kiswahili','KIS-10','KIS',NULL,NULL,14,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(87,1,1,'Core Mathematics','CM-10','CM',NULL,NULL,14,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(88,1,1,'Community Service Learning','CSL-10','CSL',NULL,NULL,14,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(89,1,1,'Physical Education','PE-10','PE',NULL,NULL,14,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(90,1,1,'Biology','BIO-10','BIO',NULL,NULL,14,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(91,1,1,'Chemistry','CHE-10','CHE',NULL,NULL,14,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(92,1,1,'Physics','PHY-10','PHY',NULL,NULL,14,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(93,1,1,'Computer Studies','CS-10','CS',NULL,NULL,14,9,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(94,1,1,'Geography','GEO-10','GEO',NULL,NULL,14,10,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(95,1,1,'History & Citizenship','HC-10','HC',NULL,NULL,14,11,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(96,1,1,'Business Studies','BS-10','BS',NULL,NULL,14,12,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(97,1,1,'Agriculture','AGR-10','AGR',NULL,NULL,14,13,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(98,1,1,'English','ENG-11','ENG',NULL,NULL,15,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(99,1,1,'Kiswahili','KIS-11','KIS',NULL,NULL,15,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(100,1,1,'Core Mathematics','CM-11','CM',NULL,NULL,15,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(101,1,1,'Community Service Learning','CSL-11','CSL',NULL,NULL,15,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(102,1,1,'Physical Education','PE-11','PE',NULL,NULL,15,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(103,1,1,'Biology','BIO-11','BIO',NULL,NULL,15,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(104,1,1,'Chemistry','CHE-11','CHE',NULL,NULL,15,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(105,1,1,'Physics','PHY-11','PHY',NULL,NULL,15,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(106,1,1,'Computer Studies','CS-11','CS',NULL,NULL,15,9,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(107,1,1,'Geography','GEO-11','GEO',NULL,NULL,15,10,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(108,1,1,'History & Citizenship','HC-11','HC',NULL,NULL,15,11,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(109,1,1,'Business Studies','BS-11','BS',NULL,NULL,15,12,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(110,1,1,'Agriculture','AGR-11','AGR',NULL,NULL,15,13,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(111,1,1,'English','ENG-12','ENG',NULL,NULL,16,1,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(112,1,1,'Kiswahili','KIS-12','KIS',NULL,NULL,16,2,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(113,1,1,'Core Mathematics','CM-12','CM',NULL,NULL,16,3,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(114,1,1,'Community Service Learning','CSL-12','CSL',NULL,NULL,16,4,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(115,1,1,'Physical Education','PE-12','PE',NULL,NULL,16,5,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(116,1,1,'Biology','BIO-12','BIO',NULL,NULL,16,6,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(117,1,1,'Chemistry','CHE-12','CHE',NULL,NULL,16,7,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(118,1,1,'Physics','PHY-12','PHY',NULL,NULL,16,8,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(119,1,1,'Computer Studies','CS-12','CS',NULL,NULL,16,9,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(120,1,1,'Geography','GEO-12','GEO',NULL,NULL,16,10,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(121,1,1,'History & Citizenship','HC-12','HC',NULL,NULL,16,11,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(122,1,1,'Business Studies','BS-12','BS',NULL,NULL,16,12,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40'),(123,1,1,'Agriculture','AGR-12','AGR',NULL,NULL,16,13,NULL,0,0,0,100,40,NULL,'2026-10-19 09:03:40','2026-10-19 09:03:40');
DROP TABLE IF EXISTS `subscription_items`;
CREATE TABLE `subscription_items` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `subscription_id` bigint(20) unsigned NOT NULL,
  `reference_no` varchar(191) DEFAULT NULL,
  `amount_paid` decimal(8,2) DEFAULT NULL,
  `payment_method` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscription_items_subscription_id_foreign` (`subscription_id`),
  CONSTRAINT `subscription_items_subscription_id_foreign` FOREIGN KEY (`subscription_id`) REFERENCES `subscriptions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `subscription_items` VALUES (1,1,'PAY-3B4RYRJV',299.00,'Manual','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,2,NULL,0.00,NULL,'2026-10-19 09:48:19','2026-10-19 09:48:19',NULL),(3,3,NULL,0.00,NULL,'2026-10-19 16:34:37','2026-10-19 16:34:37',NULL),(4,4,NULL,0.00,NULL,'2026-10-19 16:38:50','2026-10-19 16:38:50',NULL),(5,5,NULL,0.00,NULL,'2026-10-19 16:44:27','2026-10-19 16:44:27',NULL),(6,6,NULL,0.00,NULL,'2026-10-19 16:45:03','2026-10-19 16:45:03',NULL);
DROP TABLE IF EXISTS `subscription_upgrade_requests`;
CREATE TABLE `subscription_upgrade_requests` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `plan_id` bigint(20) unsigned NOT NULL,
  `extra_days` int(11) NOT NULL DEFAULT 0,
  `amount_paid` decimal(10,2) NOT NULL DEFAULT 0.00,
  `payment_method` varchar(191) DEFAULT NULL,
  `notes` varchar(191) DEFAULT NULL,
  `status` enum('pending','approved','rejected') NOT NULL DEFAULT 'pending',
  `approved_by` bigint(20) unsigned DEFAULT NULL,
  `approved_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscription_upgrade_requests_institute_id_foreign` (`institute_id`),
  KEY `subscription_upgrade_requests_plan_id_foreign` (`plan_id`),
  CONSTRAINT `subscription_upgrade_requests_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscription_upgrade_requests_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `subscriptions`;
CREATE TABLE `subscriptions` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `plan_id` bigint(20) unsigned NOT NULL,
  `start_date` date NOT NULL,
  `end_date` date NOT NULL,
  `status` enum('active','expired','cancelled') NOT NULL DEFAULT 'active',
  `invoice_details` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_bin DEFAULT NULL CHECK (json_valid(`invoice_details`)),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `subscriptions_institute_id_foreign` (`institute_id`),
  KEY `subscriptions_plan_id_foreign` (`plan_id`),
  CONSTRAINT `subscriptions_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `subscriptions_plan_id_foreign` FOREIGN KEY (`plan_id`) REFERENCES `plans` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `subscriptions` VALUES (1,1,3,'2026-03-30','2027-03-30','active','\"{\\\"invoice_no\\\":\\\"INV-81DEVP\\\",\\\"issued_at\\\":\\\"2026-03-30\\\",\\\"notes\\\":\\\"Auto-generated in seeder\\\"}\"','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `syllabus`;
CREATE TABLE `syllabus` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `session_id` int(11) NOT NULL,
  `title` varchar(100) NOT NULL,
  `description` longtext DEFAULT NULL,
  `class_id` int(11) NOT NULL,
  `file` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `syllabus_institute_id_foreign` (`institute_id`),
  KEY `syllabus_branch_id_foreign` (`branch_id`),
  KEY `syllabus_session_id_class_id_index` (`session_id`,`class_id`),
  CONSTRAINT `syllabus_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `syllabus_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `teacher_signatures`;
CREATE TABLE `teacher_signatures` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `teacher_id` bigint(20) unsigned DEFAULT NULL,
  `signature_image` varchar(191) DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=Inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teacher_signatures_institute_id_foreign` (`institute_id`),
  KEY `teacher_signatures_branch_id_foreign` (`branch_id`),
  KEY `teacher_signatures_teacher_id_foreign` (`teacher_id`),
  CONSTRAINT `teacher_signatures_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `teacher_signatures_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `teacher_signatures_teacher_id_foreign` FOREIGN KEY (`teacher_id`) REFERENCES `teachers` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `teachers`;
CREATE TABLE `teachers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `department_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(30) NOT NULL,
  `designation` varchar(191) DEFAULT NULL,
  `birthday` date DEFAULT NULL,
  `gender` varchar(20) NOT NULL,
  `religion` varchar(20) DEFAULT NULL,
  `phone` varchar(25) NOT NULL,
  `blood` varchar(5) DEFAULT NULL,
  `sl` int(11) DEFAULT NULL,
  `marital_status` varchar(20) DEFAULT NULL,
  `father_name` varchar(30) DEFAULT NULL,
  `mother_name` varchar(40) DEFAULT NULL,
  `nationality` varchar(20) DEFAULT NULL,
  `national_id` varchar(20) DEFAULT NULL,
  `spouse_name` varchar(20) DEFAULT NULL,
  `passport_no` varchar(20) DEFAULT NULL,
  `tin_no` varchar(20) DEFAULT NULL,
  `address` longtext DEFAULT NULL,
  `joining_date` date DEFAULT NULL,
  `permanent_address` longtext DEFAULT NULL,
  `access_key` varchar(25) DEFAULT NULL,
  `attachment` varchar(191) DEFAULT NULL,
  `training_attachment` varchar(191) DEFAULT NULL,
  `is_administrator` enum('0','1') NOT NULL DEFAULT '0',
  `is_visible_website` enum('0','1') NOT NULL DEFAULT '1',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `teachers_institute_id_foreign` (`institute_id`),
  KEY `teachers_branch_id_foreign` (`branch_id`),
  KEY `teachers_department_id_foreign` (`department_id`),
  KEY `teachers_user_id_department_id_index` (`user_id`,`department_id`),
  CONSTRAINT `teachers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `teachers_department_id_foreign` FOREIGN KEY (`department_id`) REFERENCES `departments` (`id`),
  CONSTRAINT `teachers_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `teachers_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `testimonials`;
CREATE TABLE `testimonials` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `description` text DEFAULT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `testimonials_institute_id_foreign` (`institute_id`),
  KEY `testimonials_branch_id_foreign` (`branch_id`),
  KEY `testimonials_user_id_foreign` (`user_id`),
  CONSTRAINT `testimonials_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `testimonials_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `testimonials_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `testimonials` VALUES (1,1,1,9,'I love learning here! The teachers are supportive, and the clubs and science projects are fun.',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,2,'A great place to teach! The school values both students and educators.',1,'2026-03-30 11:21:12','2026-03-30 11:21:12','2026-10-19 14:03:48'),(3,1,1,10,'The best decision for our daughter. We see her CBC reports online and paying fees by M-Pesa saves us a trip to the bank.',1,'2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `themes`;
CREATE TABLE `themes` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `category` varchar(191) NOT NULL,
  `name` varchar(191) NOT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `description` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `themes` VALUES (1,'Core Academic','Elementary School','🏫','Bright, engaging design for young learners','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,'Core Academic','Middle School','🎒','Balanced design for transitional years','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,'Core Academic','High School','🎓','Dynamic, aspirational design for teens','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(4,'Core Academic','College','🎓','Modern, sophisticated design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(5,'Core Academic','University','🏛️','Academic, prestigious design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(6,'Early Childhood','Kindergarten','🌈','Bright, playful design for young children','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(7,'Specialized Training','Vocational School','🔧','Practical, hands-on design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(8,'Specialized Training','Culinary School','👨‍🍳','Warm, appetizing design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(9,'Arts & Creative','Music School','🎵','Creative, artistic design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(10,'Arts & Creative','Art School','🎨','Inspiring, expressive design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(11,'Physical Training','Fitness School','💪','Energetic, motivational design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(12,'Physical Training','Karate School','🥋','Disciplined, traditional design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(13,'Physical Training','Swimming School','🏊','Aquatic, refreshing design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(14,'Language & Communication','Language School','🌍','Global, communicative design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(15,'Transportation','Driving School','🚗','Dynamic, safety-focused design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(16,'Specialized Programs','Diploma Programs','🏆','Achievement-focused design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(17,'Specialized Programs','Generic School','🏫','Default professional design','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `transport_members`;
CREATE TABLE `transport_members` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `student_id` bigint(20) unsigned NOT NULL,
  `assigned_route_id` bigint(20) unsigned NOT NULL,
  `assigned_stop_id` bigint(20) unsigned NOT NULL,
  `fare_amount` decimal(8,2) NOT NULL,
  `status` smallint(6) NOT NULL DEFAULT 1 COMMENT '1=Active, 2=InActive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `transport_members_institute_id_foreign` (`institute_id`),
  KEY `transport_members_branch_id_foreign` (`branch_id`),
  KEY `transport_members_student_id_foreign` (`student_id`),
  KEY `transport_members_assigned_route_id_foreign` (`assigned_route_id`),
  KEY `transport_members_assigned_stop_id_foreign` (`assigned_stop_id`),
  CONSTRAINT `transport_members_assigned_route_id_foreign` FOREIGN KEY (`assigned_route_id`) REFERENCES `bus_routes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transport_members_assigned_stop_id_foreign` FOREIGN KEY (`assigned_stop_id`) REFERENCES `bus_stops` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transport_members_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transport_members_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `transport_members_student_id_foreign` FOREIGN KEY (`student_id`) REFERENCES `students` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `user_logs`;
CREATE TABLE `user_logs` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `ip_address` varchar(191) DEFAULT NULL,
  `action` enum('create','update','view','delete','fee_collect','payment','receipt') NOT NULL DEFAULT 'create',
  `detail` varchar(191) DEFAULT NULL,
  `previous_detail` varchar(191) DEFAULT NULL,
  `model` varchar(191) DEFAULT NULL,
  `model_id` bigint(20) unsigned DEFAULT NULL,
  `url` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_logs_institute_id_foreign` (`institute_id`),
  KEY `user_logs_branch_id_foreign` (`branch_id`),
  KEY `user_logs_user_id_index` (`user_id`),
  CONSTRAINT `user_logs_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_logs_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_logs_user_id_foreign` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
DROP TABLE IF EXISTS `user_notices`;
CREATE TABLE `user_notices` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `notice_id` int(11) NOT NULL,
  `user_type` varchar(191) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `user_notices_institute_id_foreign` (`institute_id`),
  KEY `user_notices_branch_id_foreign` (`branch_id`),
  CONSTRAINT `user_notices_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_notices_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `user_notices` VALUES (1,1,1,1,'8','2026-10-19 16:33:04','2026-10-19 16:33:04'),(2,1,1,1,'7','2026-10-19 16:33:04','2026-10-19 16:33:04'),(3,1,1,2,'8','2026-10-19 16:44:35','2026-10-19 16:44:35'),(4,1,1,2,'7','2026-10-19 16:44:35','2026-10-19 16:44:35');
DROP TABLE IF EXISTS `user_payrolls`;
CREATE TABLE `user_payrolls` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `user_id` bigint(20) unsigned NOT NULL,
  `net_salary` decimal(10,2) NOT NULL DEFAULT 0.00,
  `current_due` decimal(10,2) NOT NULL DEFAULT 0.00,
  `current_advance` decimal(10,2) NOT NULL DEFAULT 0.00,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `user_payrolls_user_id_unique` (`user_id`),
  KEY `user_payrolls_institute_id_foreign` (`institute_id`),
  KEY `user_payrolls_branch_id_foreign` (`branch_id`),
  CONSTRAINT `user_payrolls_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `user_payrolls_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `user_payrolls` VALUES (1,1,1,4,1000.00,0.00,0.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(2,1,1,5,1000.00,0.00,0.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(3,1,1,6,1000.00,0.00,0.00,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(4,1,1,7,1000.00,0.00,0.00,'2026-03-30 11:21:14','2026-03-30 11:21:14');
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned DEFAULT NULL,
  `branch_id` bigint(20) unsigned DEFAULT NULL,
  `name` varchar(40) NOT NULL,
  `username` varchar(192) DEFAULT NULL,
  `email` varchar(40) DEFAULT NULL,
  `password` varchar(191) NOT NULL,
  `phone` varchar(25) NOT NULL,
  `image` varchar(192) DEFAULT NULL,
  `role_id` int(11) NOT NULL DEFAULT 7,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 1,
  `user_type` varchar(20) NOT NULL DEFAULT 'Student',
  `facebook` varchar(192) DEFAULT NULL,
  `twitter` varchar(192) DEFAULT NULL,
  `linkedin` varchar(192) DEFAULT NULL,
  `google_plus` varchar(192) DEFAULT NULL,
  `user_status` enum('0','1') NOT NULL DEFAULT '1',
  `nid` varchar(191) DEFAULT NULL,
  `address` varchar(191) DEFAULT NULL,
  `platform` enum('APP','WEB') DEFAULT NULL,
  `device_info` longtext DEFAULT NULL,
  `last_active_time` timestamp NULL DEFAULT NULL,
  `remember_token` varchar(100) DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `users_phone_index` (`phone`)
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `users` VALUES (1,1,1,'SAAS Admin',NULL,'saasadmin@gmail.com','$2y$12$zUL91JihloM47gzv0jOPKu8cAiA/WW0wYd2l0W68oCCICSiWd4UHi','000000000001','5.png',1,'2026-03-30 11:21:05',1,'SAAS Admin','http://www.marquardt.com/dolores-est-consectetur-corporis-nisi-totam-molestiae-magnam','http://reichert.com/','https://schulist.com/autem-ut-labore-quo-quae-rerum-eum-rerum.html','http://bogisich.biz/hic-rerum-ut-quas','0',NULL,NULL,'WEB',NULL,'2026-03-30 11:21:05','s0nIid84Op',NULL,'2026-03-30 11:21:05','2026-03-30 11:21:05'),(2,1,1,'Super Admin',NULL,'superadmin@gmail.com','$2y$12$4PSGOGBCyEP5XEAFOE1XrOQUxr7qrtklCtgE1cKxMLcPIFCfvKqe.','000000000002','5.png',2,'2026-03-30 11:21:05',1,'Super Admin','http://rosenbaum.com/earum-qui-porro-possimus-amet-et','https://www.powlowski.com/adipisci-sed-enim-non-nisi-doloremque','http://www.cummings.com/','http://greenfelder.org/omnis-omnis-illo-omnis-est-similique','0',NULL,NULL,'WEB',NULL,'2026-03-30 11:21:05','idSDP39BgC',NULL,'2026-03-30 11:21:05','2026-03-30 11:21:05'),(3,1,1,'System Admin',NULL,'systemadmin@gmail.com','$2y$12$ic.65p6s8Jj1ubtuRdj/Z.Pljeohn0mwWHAUlWQUy0IJ6n3pCXU9K','000000000003','5.png',3,'2026-03-30 11:21:05',1,'System Admin','http://johnston.com/voluptas-molestias-maxime-molestias-dicta-sint','http://wyman.com/','https://www.wiza.org/dolore-perspiciatis-sit-autem-est','http://glover.com/quia-quasi-est-incidunt-ad-nostrum-in-qui.html','0',NULL,NULL,'WEB',NULL,'2026-03-30 11:21:05','mlChNee1TN',NULL,'2026-03-30 11:21:06','2026-03-30 11:21:06'),(4,1,1,'Accountant',NULL,'accountant@gmail.com','$2y$12$fQiNlgEUGgdWfzLPPpU1WeHNsAQ2CVEUStXfkNE.3pTsFcUQvVYiq','000000000004','5.png',4,'2026-03-30 11:21:12',1,'Accountant','http://www.trantow.biz/voluptatem-dignissimos-blanditiis-aut-iste','https://gerlach.com/et-ad-est-eos-deserunt-rem-id.html','http://www.rempel.info/beatae-non-accusantium-est-recusandae-eveniet-rem-quo-beatae.html','http://torp.org/molestias-facere-provident-rerum-omnis-ipsam-nesciunt-exercitationem-doloribus','0',NULL,NULL,'WEB',NULL,'2026-03-30 11:21:12','jDBZw7MHGC',NULL,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Librarian',NULL,'librarian@gmail.com','$2y$12$pYylBlCJMMV0ssKurV1MEO/WaXMwdvk/wkIGR3b1k5sLJixeykpX2','000000000005','5.png',5,'2026-03-30 11:21:13',1,'Librarian','http://kuhic.org/','http://www.fritsch.com/ut-temporibus-est-ut-ut-asperiores','https://waters.com/labore-ut-nihil-voluptatem-aliquam-et-repellendus-aut.html','http://www.moen.org/quasi-dolores-quaerat-atque-porro-illum-quis.html','0',NULL,NULL,'WEB',NULL,'2026-03-30 11:21:13','jLviJfsz6x',NULL,'2026-03-30 11:21:13','2026-03-30 11:21:13'),(6,1,1,'Hostel',NULL,'hostel@gmail.com','$2y$12$4kxK85hlnKf3605pwnoUo.arPZ6YCACFKc8bdFX/x9okau4FgAKTC','000000000006','5.png',9,'2026-03-30 11:21:13',1,'Hostel','http://ryan.net/quis-dolorum-magni-exercitationem-tempore-repellendus-tempora-odit','http://www.green.org/','http://miller.com/','http://wyman.com/','0',NULL,NULL,'WEB',NULL,'2026-03-30 11:21:13','fVThotS3nS',NULL,'2026-03-30 11:21:13','2026-03-30 11:21:13'),(7,1,1,'Transport',NULL,'transport@gmail.com','$2y$12$OasfpBvIoTv0C1GzLT171OyY88kG/FkgSktM4UG8oj71rb7UCeu5u','000000000007','5.png',10,'2026-03-30 11:21:13',1,'Transport','http://www.ritchie.info/aut-eum-quasi-maiores','http://www.schumm.biz/','http://www.brekke.com/ut-quia-quae-nemo-quas-sit-sed-recusandae','http://bashirian.org/non-reprehenderit-aspernatur-et-omnis-aut','0',NULL,NULL,'WEB',NULL,'2026-03-30 11:21:13','npdhyBRU41',NULL,'2026-03-30 11:21:14','2026-03-30 11:21:14'),(9,1,1,'Wanjiku Kamau',NULL,'learner@classcompass.test','$2y$12$ITJXjdJAo8gPoK//JEk5XONjZ4oBGILmnASw4gK0pGVsC4ngE4G.u','254700000101',NULL,7,'2026-10-19 09:06:04',1,'Student',NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04'),(10,1,1,'Peter Kamau',NULL,'parent@classcompass.test','$2y$12$ITJXjdJAo8gPoK//JEk5XONjZ4oBGILmnASw4gK0pGVsC4ngE4G.u','254700000102',NULL,8,'2026-10-19 09:06:04',1,'Parent',NULL,NULL,NULL,NULL,'1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,'2026-10-19 09:06:04','2026-10-19 09:06:04');
DROP TABLE IF EXISTS `waivers`;
CREATE TABLE `waivers` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `waiver` varchar(191) NOT NULL,
  `serial` int(11) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`waiver`),
  KEY `waivers_branch_id_foreign` (`branch_id`),
  CONSTRAINT `waivers_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `waivers_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `waivers` VALUES (1,1,1,'Class Waiver',1,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(2,1,1,'Girl Waiver',2,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(3,1,1,'Merit Waiver',3,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(4,1,1,'Poor Waiver',3,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(5,1,1,'Scout Waiver',4,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(6,1,1,'BNCC Waiver',5,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(7,1,1,'Special Waiver',6,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(8,1,1,'Govt. Waiver',7,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(9,1,1,'Invention Waiver',8,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(10,1,1,'Creative Waiver',9,'2026-03-30 11:21:12','2026-03-30 11:21:12'),(11,1,1,'Other Waiver',10,'2026-03-30 11:21:12','2026-03-30 11:21:12');
DROP TABLE IF EXISTS `why_choose_us`;
CREATE TABLE `why_choose_us` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `title` varchar(191) NOT NULL,
  `description` text DEFAULT NULL,
  `icon` varchar(191) DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `why_choose_us_institute_id_foreign` (`institute_id`),
  KEY `why_choose_us_branch_id_foreign` (`branch_id`),
  CONSTRAINT `why_choose_us_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `why_choose_us_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
INSERT INTO `why_choose_us` VALUES (1,1,1,'Learner-centred CBC','Small classes and competency-based assessment that follow each learner\'s strengths and needs.','personalised.png','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(2,1,1,'TSC-registered teachers','Experienced, caring teachers trained in CBC delivery and continuous assessment.','faculty.png','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(3,1,1,'Modern facilities','Science and computer labs, a library, playing fields and safe school transport.','facilities.png','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL),(4,1,1,'Talent & values','Music, drama, sports, clubs and mentorship that build confident, responsible citizens.','holistic.png','2026-03-30 11:21:12','2026-03-30 11:21:12',NULL);
DROP TABLE IF EXISTS `zoom_meetings`;
CREATE TABLE `zoom_meetings` (
  `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
  `institute_id` bigint(20) unsigned NOT NULL,
  `branch_id` bigint(20) unsigned NOT NULL,
  `meeting_id` varchar(191) NOT NULL,
  `topic` text NOT NULL,
  `agenda` text DEFAULT NULL,
  `start_time` varchar(191) NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `password` varchar(191) DEFAULT NULL,
  `join_url` longtext NOT NULL,
  `start_url` longtext NOT NULL,
  `created_by` bigint(20) unsigned DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_combination` (`institute_id`,`branch_id`,`meeting_id`),
  KEY `zoom_meetings_branch_id_foreign` (`branch_id`),
  KEY `zoom_meetings_created_by_foreign` (`created_by`),
  CONSTRAINT `zoom_meetings_branch_id_foreign` FOREIGN KEY (`branch_id`) REFERENCES `branches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zoom_meetings_created_by_foreign` FOREIGN KEY (`created_by`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `zoom_meetings_institute_id_foreign` FOREIGN KEY (`institute_id`) REFERENCES `institutes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

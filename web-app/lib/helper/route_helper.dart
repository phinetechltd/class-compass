import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/curriculum/curriculum_screen.dart';
import 'package:class_compass/feature/online_fees/online_fees_screen.dart';
import 'package:class_compass/common/enums/enums.dart';
import 'package:class_compass/common/widget/set_canonical_url_widget.dart';
import 'package:class_compass/feature/common/presentation/screens/placeholder_screens.dart';
import 'package:class_compass/feature/academic_configuration/class/presentation/screens/class_screen.dart';
import 'package:class_compass/feature/academic_configuration/department/presentation/screens/department_screen.dart';
import 'package:class_compass/feature/academic_configuration/group/presentation/screens/group_screen.dart';
import 'package:class_compass/feature/academic_configuration/period/presentation/screens/period_screen.dart';
import 'package:class_compass/feature/academic_configuration/picklist/presentation/screens/picklist_screen.dart';
import 'package:class_compass/feature/academic_configuration/presentation/academic_configuration_screen.dart';
import 'package:class_compass/feature/academic_configuration/section/presentation/screens/section_screen.dart';
import 'package:class_compass/feature/academic_configuration/session/presentation/screens/session_screen.dart';
import 'package:class_compass/feature/academic_configuration/shift/presentation/screens/shift_screen.dart';
import 'package:class_compass/feature/academic_configuration/signature/presentation/screens/signature_screen.dart';
import 'package:class_compass/feature/academic_configuration/student_categories/presentation/screens/student_categories_screen.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/screens/add_new_subject_screen.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/screens/subject_config_screen.dart';
import 'package:class_compass/feature/academic_configuration/subject/presentation/screens/subject_screen.dart';
import 'package:class_compass/feature/account_management/accounting_category/presentation/screens/accounting_category_screen.dart';
import 'package:class_compass/feature/account_management/accounting_funds/presentation/screen/accounting_fund_screen.dart';
import 'package:class_compass/feature/account_management/accounting_group/presentation/screen/accounting_group_screen.dart';
import 'package:class_compass/feature/account_management/accounting_ledger/presentation/screen/accounting_ledger_screen.dart';
import 'package:class_compass/feature/account_management/chart_of_account/presentation/screen/chart_of_account_screen.dart';
import 'package:class_compass/feature/account_management/contra/presentation/screen/contra_screen.dart';
import 'package:class_compass/feature/account_management/fund_transfer/presentation/screen/fund_transfer_screen.dart';
import 'package:class_compass/feature/account_management/journal/presentation/screen/journal_screen.dart';
import 'package:class_compass/feature/account_management/payment/presentation/screen/payment_screen.dart';
import 'package:class_compass/feature/account_management/payment/presentation/screen/receipt_screen.dart';
import 'package:class_compass/feature/account_management/presentation/account_managment_screen.dart';
import 'package:class_compass/feature/administrator/event/presentation/screens/event_screen.dart';
import 'package:class_compass/feature/administrator/notice/presentation/screens/notice_screen.dart';
import 'package:class_compass/feature/administrator/notice/presentation/screens/user_log_screen.dart';
import 'package:class_compass/feature/administrator/presentation/administration_screen.dart';
import 'package:class_compass/feature/administrator/system_settings/presentation/screens/system_setting_screen.dart';
import 'package:class_compass/feature/authentication/presentation/screen/delete_account_screen.dart';
import 'package:class_compass/feature/authentication/presentation/screen/login_screen.dart';
import 'package:class_compass/feature/authentication/presentation/screen/password_change_screen.dart';
import 'package:class_compass/feature/branch/presentation/screens/branch_screen.dart';
import 'package:class_compass/feature/chatgpt/screens/chat_gpt_screen.dart';
import 'package:class_compass/feature/client_license/presentation/screens/client_license_screen.dart';
import 'package:class_compass/feature/cms_management/about_us/presentation/screens/about_us_screen.dart';
import 'package:class_compass/feature/cms_management/academic_image/presentation/screens/academic_image_screen.dart';
import 'package:class_compass/feature/cms_management/banner/presentation/screens/banner_screen.dart';
import 'package:class_compass/feature/cms_management/cms_settings/presentation/widgets/select_theme_widget.dart';
import 'package:class_compass/feature/cms_management/faq/presentation/screens/faq_screen.dart';
import 'package:class_compass/feature/cms_management/feedback/presentation/screens/feedback_screen.dart';
import 'package:class_compass/feature/cms_management/mobile_app_section/presentation/screens/mobile_app_screen.dart';
import 'package:class_compass/feature/cms_management/policy_pages/presentation/screens/policy_pages_screen.dart';
import 'package:class_compass/feature/cms_management/ready_to_join_us/presentation/screens/ready_to_join_screen.dart';
import 'package:class_compass/feature/cms_management/why_choose_us/presentation/screens/why_choose_us_screen.dart';
import 'package:class_compass/feature/course_management/course/domain/model/course_model.dart';
import 'package:class_compass/feature/course_management/course/presentation/screens/course_details_screen.dart';
import 'package:class_compass/feature/course_management/course/presentation/screens/course_screen.dart';
import 'package:class_compass/feature/course_management/course/presentation/screens/create_new_course_screen.dart';
import 'package:class_compass/feature/course_management/course_category/presentation/screens/course_category_screen.dart';
import 'package:class_compass/feature/course_management/lesson/presentation/screens/create_new_lesson_screen.dart';
import 'package:class_compass/feature/dashboard/presentation/dashboard_screen.dart';
import 'package:class_compass/feature/exam_management/exam/presentation/screens/exam_screen.dart';
import 'package:class_compass/feature/exam_management/exam_result/presentation/screens/exam_result_screen.dart';
import 'package:class_compass/feature/exam_management/exam_startup/presentation/screens/exam_startup_screen.dart';
import 'package:class_compass/feature/exam_management/mark_config/presentation/screens/mark_config_screen.dart';
import 'package:class_compass/feature/exam_management/mark_input/presentation/screens/mark_input_screen.dart';
import 'package:class_compass/feature/exam_management/marksheet/screens/marksheet_config_screen.dart';
import 'package:class_compass/feature/exam_management/presentation/exam_management_screen.dart';
import 'package:class_compass/feature/exam_management/remark_config/presentation/screens/re_mark_config_screen.dart';
import 'package:class_compass/feature/fees_management/fees_date/presentation/screens/fee_date_config_screen.dart';
import 'package:class_compass/feature/fees_management/fees_start_up/presentation/screens/fees_startup_screen.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/screens/paid_reports_screen.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/screens/unpaid_report_screen.dart';
import 'package:class_compass/feature/fees_management/presentation/fees_managment_screen.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/screens/quick_collection_details_screen.dart';
import 'package:class_compass/feature/fees_management/smart_collection/presentation/screens/smart_collection_screen.dart';
import 'package:class_compass/feature/fees_management/waiver/presentation/screens/fine_waiver_screen.dart';
import 'package:class_compass/feature/hostel_management/presentation/hostel_management_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel/presentation/screens/hostel_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_categories/presentation/screens/hostel_category_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_members/presentation/screens/hostel_member_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_rooms/presentation/screens/hostel_rooms_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/presentation/screens/hostel_meals_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_bill/presentation/screens/hostel_bill_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_plan/presentation/screens/hostel_meal_plan_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_meal_entries/presentation/screens/hostel_meal_entries_screen.dart';
import 'package:class_compass/feature/hostel_management/hostel_room_member/presentation/screens/hostel_room_member_screen.dart';
import 'package:class_compass/feature/html/html_viewer_screen.dart';
import 'package:class_compass/feature/id_card/presentation/screens/id_card_screen.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/frontend_course_details_screen.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/frontend_course_screen.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/my_course_details_screen.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/my_course_screen.dart';
import 'package:class_compass/feature/landing_page/frontend_course/presentation/screens/quiz_exam_review_result_screen.dart';
import 'package:class_compass/feature/landing_page/presentation/policy_enum.dart';
import 'package:class_compass/feature/landing_page/presentation/screens/policy_screen.dart';
import 'package:class_compass/feature/landing_page/presentation/screens/school_home_page.dart';
import 'package:class_compass/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/screens/layout_and_certificate_screen.dart';
import 'package:class_compass/feature/layout_and_certificate/presentation/screens/layout_and_certificate_management_screen.dart';
import 'package:class_compass/feature/library_management/book/presentation/screens/book_issue_report_screen.dart';
import 'package:class_compass/feature/library_management/book/presentation/screens/book_issue_screen.dart';
import 'package:class_compass/feature/library_management/book/presentation/screens/book_return_screen.dart';
import 'package:class_compass/feature/library_management/book/presentation/screens/book_screen.dart';
import 'package:class_compass/feature/library_management/book_category/presentation/screens/book_category_screen.dart';
import 'package:class_compass/feature/library_management/library_member/presentation/screens/library_member_screen.dart';
import 'package:class_compass/feature/library_management/presentation/library_management_screen.dart';
import 'package:class_compass/feature/master_configuration/employee/presentation/screens/employee_screen.dart';
import 'package:class_compass/feature/master_configuration/presentation/master_configuration_screen.dart';
import 'package:class_compass/feature/master_configuration/role/presentation/screens/role_screen.dart';
import 'package:class_compass/feature/package_plan/presentation/screens/subscription_screen.dart';
import 'package:class_compass/feature/payment_gateway/presentation/screens/payment_gateway_screen.dart';
import 'package:class_compass/feature/question_bank/question/domain/model/question_model.dart';
import 'package:class_compass/feature/question_bank/question/presentation/screens/create_new_question_screen.dart';
import 'package:class_compass/feature/question_bank/question/presentation/screens/question_paper_create_screen.dart';
import 'package:class_compass/feature/question_bank/question/presentation/screens/question_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_board/presentation/screens/question_bank_board_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_chapter/presentation/screens/question_bank_chapter_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_class/presentation/screens/question_bank_class_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_group/presentation/screens/question_bank_group_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_level/presentation/screens/question_bank_level_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_sources/presentation/screens/question_bank_sources_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_sub_sources/presentation/screens/question_bank_sub_sources_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_subject/presentation/screens/question_bank_subject_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_tag/presentation/screens/question_bank_tag_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_topics/presentation/screens/question_bank_topic_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_types/presentation/screens/question_bank_types_screen.dart';
import 'package:class_compass/feature/question_bank/question_bank_year/presentation/screens/question_bank_year_screen.dart';
import 'package:class_compass/feature/question_bank/question_category/presentation/screens/question_category_screen.dart';
import 'package:class_compass/feature/quiz_setting/presentation/screens/quiz_setting_screen.dart';
import 'package:class_compass/feature/payroll_management/advance/presentation/screens/advance_salary_screen.dart';
import 'package:class_compass/feature/payroll_management/due/presentation/screens/due_salary_screen.dart';
import 'package:class_compass/feature/payroll_management/payroll_assign/presentation/screens/payroll_assign_screen.dart';
import 'package:class_compass/feature/payroll_management/payroll_mapping/presentation/screens/payroll_mapping_screen.dart';
import 'package:class_compass/feature/payroll_management/payroll_start_up/presentation/screens/payroll_start_up_screen.dart';
import 'package:class_compass/feature/payroll_management/presentation/payroll_management_screen.dart';
import 'package:class_compass/feature/payroll_management/return_advance/presentation/screens/return_advance_screen.dart';
import 'package:class_compass/feature/payroll_management/salary/presentation/screens/salary_payment_info_screen.dart';
import 'package:class_compass/feature/payroll_management/salary/presentation/screens/salary_screen.dart';
import 'package:class_compass/feature/payroll_management/salary/presentation/screens/salary_statement_screen.dart';
import 'package:class_compass/feature/payroll_management/salary_slip/presentation/screens/salary_slip_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/balance_sheet_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/cash_flow_statement_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/fund_wise_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/income_statement_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/ledger_wise_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/trail_balance_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/user_wise_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/voucher_wise_screen.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/screens/fees_monthly_report_screen.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/screens/fees_payment_info_screen.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/screens/fees_payment_ratio_screen.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/screens/fees_reports_screen.dart';
import 'package:class_compass/feature/reports_management/accounting_reports/presentation/screens/accounting_reports_screen.dart';
import 'package:class_compass/feature/parent_module/children/presentation/screens/behavior_screen.dart';
import 'package:class_compass/feature/parent_module/parent_assignment/presentation/screens/parent_assignment_screen.dart';
import 'package:class_compass/feature/parent_module/parent_class_routine/presentation/screens/parent_class_routine_screen.dart';
import 'package:class_compass/feature/parent_module/parent_event/presentation/screens/parent_event_screen.dart';
import 'package:class_compass/feature/parent_module/parent_exam/presentation/screens/parent_exam_screen.dart';
import 'package:class_compass/feature/parent_module/parent_library/presentation/screens/parent_library_screen.dart';
import 'package:class_compass/feature/parent_module/parent_notice/presentation/screens/parent_notice_screen.dart';
import 'package:class_compass/feature/parent_module/parent_paid_info/presentation/screens/parent_fees_screen.dart';
import 'package:class_compass/feature/parent_module/parent_profile/presentation/screens/parent_profile_screen.dart';
import 'package:class_compass/feature/parent_module/parent_subject/presentation/screens/parent_subject_screen.dart';
import 'package:class_compass/feature/profile/presentation/screens/profile_screen.dart';
import 'package:class_compass/feature/quiz/answer/presentation/screens/answer_screen.dart';
import 'package:class_compass/feature/quiz/quiz_topic/presentation/screens/quiz_topic_screen.dart';
import 'package:class_compass/feature/reports_management/fees_reports/presentation/screens/head_wise_fees_info_screen.dart';
import 'package:class_compass/feature/fees_management/paid_info/presentation/screens/unpaid_fees_info_screen.dart';
import 'package:class_compass/feature/routine_management/admit_and_seat_plan/presentation/screens/admit_card_and_sear_plan_screen.dart';
import 'package:class_compass/feature/routine_management/assignment/presentation/screens/assignment_screen.dart';
import 'package:class_compass/feature/routine_management/class_routine/presentation/screens/class_routine_screen.dart';
import 'package:class_compass/feature/routine_management/exam_routine/presentation/screens/exam_routine_screen.dart';
import 'package:class_compass/feature/routine_management/presentation/routine_management_screen.dart';
import 'package:class_compass/feature/routine_management/syllabus/presentation/screens/create_new_syllabus_screen.dart';
import 'package:class_compass/feature/routine_management/syllabus/presentation/screens/syllabus_screen.dart';
import 'package:class_compass/feature/sms/phone_book/presentation/screens/phone_book_screen.dart';
import 'package:class_compass/feature/sms/phone_book_category/presentation/screens/phone_book_category_screen.dart';
import 'package:class_compass/feature/sms/presentation/sms_management_screen.dart';
import 'package:class_compass/feature/sms/purchase_sms/presentation/screens/purchase_sms_screen.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/screens/absent_sms_screen.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/screens/sent_sms_report_screen.dart';
import 'package:class_compass/feature/sms/sent_sms/presentation/screens/sms_user_screen.dart';
import 'package:class_compass/feature/sms/sms_config/sms_config_screen.dart';
import 'package:class_compass/feature/sms/sms_template/presentation/screens/sms_template_screen.dart';
import 'package:class_compass/feature/staff_information/presentation/staff_information_screen.dart';
import 'package:class_compass/feature/staff_information/staff/presentation/screens/add_new_staff_screen.dart';
import 'package:class_compass/feature/staff_information/staff/presentation/screens/staff_screen.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/presentation/screens/staff_attendance_report_screen.dart';
import 'package:class_compass/feature/staff_information/staff_attendance/presentation/screens/staff_attendance_screen.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/screens/add_new_teacher_screen.dart';
import 'package:class_compass/feature/staff_information/teacher/presentation/screens/teacher_screen.dart';
import 'package:class_compass/feature/student_attendance_information/presentation/student_attenance_information_screen.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/screens/absent_fine_screen.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/screens/attendance_report_screen.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/screens/exam_attendance_screen.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/screens/exam_schedule_screen.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/screens/monthly_attendance_report_screen.dart';
import 'package:class_compass/feature/student_attendance_information/student_attendance/presentation/screens/student_attendance_screen.dart';
import 'package:class_compass/feature/student_module/student_assignment/presentation/screens/student_assignment_screen.dart';
import 'package:class_compass/feature/student_module/student_class_routine/presentation/screens/student_class_routine_screen.dart';
import 'package:class_compass/feature/student_module/student_library/presentation/screens/student_library_screen.dart';
import 'package:class_compass/feature/student_module/student_notice/presentation/screens/student_notice_screen.dart';
import 'package:class_compass/feature/student_module/student_profile/presentation/screens/student_profile_screen.dart';
import 'package:class_compass/feature/student_module/student_subject/presentation/screens/student_subject_screen.dart';
import 'package:class_compass/feature/students_information/presentation/student_information_screen.dart';
import 'package:class_compass/feature/students_information/student/presentation/screens/add_new_student_screen.dart';
import 'package:class_compass/feature/students_information/student/presentation/screens/all_student_screen.dart';
import 'package:class_compass/feature/students_information/student/presentation/screens/student_screen.dart';
import 'package:class_compass/feature/students_information/student_migration/presentation/screens/migration_list_screen.dart';
import 'package:class_compass/feature/students_information/student_migration/presentation/screens/student_branch_migration_screen.dart';
import 'package:class_compass/feature/students_information/student_migration/presentation/screens/student_migration_screen.dart';
import 'package:class_compass/feature/third_party/third_party_screen.dart';
import 'package:class_compass/feature/transportation_management/presentation/screens/transportation_management_screen.dart';
import 'package:class_compass/feature/transportation_management/transport_bus/presentation/screens/transport_bus_screen.dart';
import 'package:class_compass/feature/transportation_management/transport_driver/presentation/screens/transport_driver_screen.dart';
import 'package:class_compass/feature/transportation_management/transport_bus_route/presentation/screens/transport_bus_route_screen.dart';
import 'package:class_compass/feature/transportation_management/transport_bus_stop/presentation/screens/transport_bus_stop_screen.dart';
import 'package:class_compass/feature/transportation_management/transport_member/presentation/screens/transport_member_screen.dart';
import 'package:class_compass/feature/zoom_class/presentation/screens/zoom_class_screen.dart';
import 'package:class_compass/feature/fees_management/fees_head/presentation/screens/fees_head_screen.dart';
import 'package:class_compass/feature/fees_management/fees_sub_head/presentation/screens/fees_sub_head_screen.dart';
import 'package:class_compass/feature/fees_management/waiver/presentation/screens/waiver_screen.dart';
import 'package:class_compass/feature/fees_management/fees_amount_config/presentation/screens/fees_amount_config_screen.dart';
import 'package:class_compass/feature/fees_management/waiver_config/presentation/screens/waiver_config_screen.dart';
import 'package:class_compass/feature/fees_management/fees_mapping/presentation/screens/fees_mapping_screen.dart';
import 'package:class_compass/feature/zoom_class/presentation/screens/zoom_config_screen.dart';
import 'package:class_compass/helper/custom_page.dart';
import 'package:class_compass/util/app_constants.dart';


class RouteHelper {
  static const String initial = '/';
  static const String signIn = '/sign-in';
  static const String signUp = '/sign-up';
  static const String changePassword = '/change-password';
  static const String forgotPassword = '/forgot-password';
  static const String otpVerify = '/otp-verify';
  static const String resetPassword = '/reset-password';
  static const String dashboard = '/dashboard';
  static const String notification = '/notification';
  static const String profile = '/profile';
  static const String html = '/html';
  static const String branch = '/branch';
  static const String studentList = '/student-list';
  static const String studentMigration = '/student-migration';
  static const String migrationPushback = '/migration_pushback';
  static const String migrationList = '/migration_list';
  static const String studentBranchMigration = '/student-branch-migration';
  static const String allStudentViewList = '/all_student_view_list';
  static const String staffAttendance = '/staff_attendance';
  static const String staffAttendanceReport = '/staff_attendance-report';
  static const String teacherList = '/teacher_list';
  static const String staffList = '/staff_list';
  static const String studentAttendance = '/student_attendance';
  static const String examAttendance = '/exam_attendance';
  static const String examSchedule = '/exam_schedule';
  static const String attendanceReport = '/attendance_report';
  static const String monthlyAttendanceReport = '/monthly-attendance-report';
  static const String absentFine = '/absent-fine';
  static const String academicSession = '/academic_session';
  static const String shift = '/shift';
  static const String classList = '/class';
  static const String section = '/section';
  static const String group = '/group';
  static const String period = '/period';
  static const String subjects = '/subjects';
  static const String addNewSubject = '/add-new-subject';
  static const String subjectConfig = '/subject_config';
  static const String exam = '/exam';
  static const String studentCategories = '/student_categories';
  static const String department = '/department';
  static const String picklist = '/picklist';
  static const String principalSignature = '/principal-signature';
  static const String feesStartUp = '/fees_start_up';
  static const String feesMapping = '/fees_mapping';
  static const String feesDate = '/fees_date';
  static const String feesAmountConfig = '/fees_amount_config';
  static const String fineWaiver = '/fine_waiver';
  static const String waiverConfig = '/waiver_config';
  static const String waiverList = '/waiver_list';
  static const String smartCollection = '/smart_collection';
  static const String quickCollectionDetails = '/quick_collection_details';
  static const String paidInfo = '/paid_info';
  static const String unpaidInfo = '/unpaid_info';
  static const String ledger = '/ledger';
  static const String accountingGroup = '/accounting_group';
  static const String accountingCategory = '/accounting_category';
  static const String accountingFund = '/accounting_fund';
  static const String chartOfAccount = '/chart_of_account';
  static const String journal = '/journal';
  static const String payment = '/payment';
  static const String contra = '/contra';
  static const String fundTransfer = '/fund_transfer';
  static const String receipt = '/receipt';
  static const String syllabus = '/syllabus';
  static const String addNewSyllabus = '/add_new_syllabus';
  static const String assignments = '/assignments';
  static const String classRoutine = '/class_routine';
  static const String examRoutine = '/exam_routine';
  static const String admitAndSeatPlan = '/admit_and_seat_plan';
  static const String bookCategories = '/book_categories';
  static const String books = '/books';
  static const String bookIssue = '/book_issue';
  static const String bookIssueReport = '/book_issue_report';
  static const String bookReturn = '/book_return';
  static const String libraryMember = '/library_member';
  static const String phoneBook = '/phone_book';
  static const String phoneBookCategory = '/phone_book_category';
  static const String purchaseSms = '/purchase_sms';
  static const String smsTemplate = '/sms_template';
  static const String smsSent = '/sms_sent';
  static const String absentSmsSent = '/absent-sms';
  static const String smsReport = '/sms_report';
  static const String smsManagement = '/sms_management';
  static const String markConfig = '/mark_config';
  static const String markInput = '/mark_input';
  static const String remarkConfig = '/remark_config';
  static const String examResult = '/exam_result';
  static const String examMarkSheet = '/mark-sheet';
  static const String examStartUp = '/exam_start_up';
  static const String assignShift = '/assign_shift';
  static const String assignSubject = '/assign_subject';
  static const String systemSettings = '/system_settings';
  static const String notice = '/notice';
  static const String question = '/question';
  static const String questionTopic = '/question_topic';
  static const String answer = '/answer';
  static const String quizTopic = '/quiz_topic';
  static const String quiz = '/quiz';
  static const String quizResult = '/quiz-result';
  static const String userActivities = '/user_activities';
  static const String roles = '/roles';
  static const String users = '/users';
  static const String thirdParty = '/third-party';
  static const String zoomMeeting = '/zoom-meeting';
  static const String zoomConfig = '/zoom-config';
  static const String applyInstitute = '/apply-institute';
  static const String deleteAccount = '/delete-account';

  //cms
  static const String aboutUs = '/about-us';
  static const String banner = '/banner';
  static const String whyChooseUs = '/why-choose-us';
  static const String mobileApp = '/mobile-app';
  static const String readyToJoin = '/ready-to-join';
  static const String faq = '/faq';
  static const String feedback = '/feedback';
  static const String theme = '/theme';
  static const String academicImage = '/academic-image';
  static const String policyPages = '/policy-pages';
  static const String feesHead = '/fees_head';
  static const String feesSubHead = '/fees_sub_head';
  static const String waiver = '/waiver';
  static const String feeDateConfig = '/fee_date_config';
  static const String paidReport = '/paid_report';
  static const String unpaidReport = '/unpaid_report';
  static const String feesManagement = '/fees_management';
  static const String libraryManagement = '/library_management';
  //payroll
  static const String payrollManagement = '/payroll_management';
  static const String payrollStartUp = '/payroll_start_up';
  static const String payrollMapping = '/payroll_mapping';
  static const String payrollAssign = '/payroll_assign';
  static const String salary = '/salary';
  static const String salarySlip = '/salary_slip';
  static const String due = '/due';
  static const String advanced = '/advanced';
  static const String returnedAdvanced = '/returned_advanced';
  static const String salaryStatement = '/salary_statement';
  static const String paymentInfo = '/payment_info';


  static const String feesReports = '/fees_reports';
  static const String accountingReports = '/accounting_reports';
  static const String addNewStudent = '/add-new-student';
  static const String addNewStaff = '/add-new-staff';
  static const String addNewTeacher = '/add-new-teacher';
  static const String chatGpt = '/chatgpt';
  static const String event = '/event';
  static const String employee = '/employee';
  static const String subscription = '/subscription';
  static const String certificate = '/certificate';
  static const String idCard = '/id-card';
  static const String layoutAndCertificateManagement = '/layout-and-certificate-management';
  static const String studentInformation = '/student-information';
  static const String staffInformation = '/staff-information';
  static const String studentAttendanceInformation = '/student-attendance-information';
  static const String academicConfiguration = '/academic-configuration';
  static const String accountManagement = '/account-management';
  static const String routineManagement = '/routine-management';
  static const String examManagement = '/exam-management';
  static const String administration = '/administration';
  static const String masterConfiguration = '/masterConfiguration';
  static const String clientLicense = '/client-license';






  //parent module
  static const String parentSubject = '/parent-subject';
  static const String parentClassRoutine = '/parent-class-routine';
  static const String parentFees = '/parent-fees';
  static const String parentProfile = '/parent-profile';
  static const String parentAttendance = '/parent-attendance';
  static const String parentAssignment = '/parent-assignment';
  static const String parentLibrary = '/parent-library';
  static const String parentNotice = '/parent-notice';
  static const String parentEvent = '/parent-event';
  static const String parentExam = '/parent-exam';
  static const String parentBehaviour = '/parent-behaviour';


  //student Module
  static const String studentSubject = '/student-subject';
  static const String studentClassRoutine = '/student-class-routine';
  static const String studentFees = '/student-fees';
  static const String studentProfile = '/student-profile';
  static const String studentSelfAttendance = '/student-attendance';
  static const String studentAssignment = '/student-assignment';
  static const String studentLibrary = '/student-library';
  static const String studentNotice = '/student-notice';
  static const String studentEvent = '/student-event';
  static const String studentExam = '/student-exam';
  static const String studentBehaviour = '/student-behaviour';



  //accounting reports
  static const String balanceSheet = '/balance-sheet';
  static const String trailBalance = '/trail-balance';
  static const String cashFlow = '/cash-flow';
  static const String fundWiseReport = '/fund-wise-report';
  static const String incomeStatement = '/income-statement';
  static const String ledgerWiseReport = '/ledger-wise-report';
  static const String userWiseReport = '/user-wise-report';
  static const String voucherWiseReport = '/voucher-wise-report';


  //fees reports
  static const String feesMonthlyPaymentInfo = '/monthly_fees-report';
  static const String feesReportPaymentInfo = '/fees_payment_info_report';
  static const String headWiseFeesInfoReport = '/head_wise_fees_info_report';
  static const String unpaidFeesInfoReport = '/unpaid_fees_info_report';
  static const String feesPaymentRatioInfoReport = '/fees_payment_ratio_info_report';



  //Hostel Management
  static const String hostelManagement = '/hostel-management';
  static const String hostels = '/hostels';
  static const String hostelCategories = '/hostel-categories';
  static const String hostelMembers = '/hostel-members';
  static const String hostelRooms = '/hostel-rooms';
  static const String hostelMeals = '/hostel-meals';
  static const String hostelBills = '/hostel-bills';
  static const String hostelMealPlan = '/hostel-meal-plan';
  static const String hostelMealEntries = '/hostel-meal-entries';
  static const String hostelRoomMembers = '/hostel-room-members';



  // Transportation Management
  static const String transportationManagement = '/transportation-management';
  static const String transportBuses = '/transport-buses';
  static const String transportDrivers = '/transport-drivers';
  static const String busRoutes = '/bus-routes';
  static const String busStops = '/bus-stops';
  static const String transportMembers = '/transport-members';


  ///.....................question Bank---------------
  static const String addNewQuestion = '/add-new-question';
  static const String questionCategory = '/question-category';
  static const String questionBankClass = '/question-bank-class';
  static const String questionBankGroup = '/question-bank-group';
  static const String questionBankSubject = '/question-bank-subject';
  static const String questionBankChapter = '/question-bank-chapter';
  static const String questionBankTypes = '/question-bank-types';
  static const String questionBankTopic = '/question-bank-topic';
  static const String questionBankLevel = '/question-bank-level';
  static const String questionBankSources = '/question-bank-sources';
  static const String questionBankSubSources = '/question-bank-sub-sources';
  static const String questionBankYear = '/question-bank-year';
  static const String questionBankBoard = '/question-bank-board';
  static const String questionBankTag = '/question-bank-tag';
  static const String courseCategory = '/course-category';
  static const String course = '/course';
  static const String courseDetails = '/course-details';
  static const String addNewCourse = '/add-new-course';
  static const String quizSetting = '/quiz-setting';
  static const String chapter = '/chapter';
  static const String lesson = '/lesson';
  static const String frontendCourseDetail = '/public-course-details';
  static const String myCourses = '/my-courses';
  static const String myCourseDetails = '/my-course-details';
  static const String policy = '/policy/:type';
  static const String frontendCourses = '/all-courses';
  static const String smsConfig = '/sms-config';

  // Inventory Management
  static const String inventoryItems = '/inventory-items';
  static const String inventoryCategories = '/inventory-categories';
  static const String inventorySuppliers = '/inventory-suppliers';
  static const String inventoryStock = '/inventory-stock';
  static const String inventoryTransactions = '/inventory-transactions';

  // Supplier Management
  static const String supplierList = '/supplier-list';
  static const String addSupplier = '/add-supplier';
  static const String supplierPayments = '/supplier-payments';
  static const String supplierLedger = '/supplier-ledger';

  // Reports
  static const String studentAttendanceReport = '/student-attendance-report';
  static const String studentFeeReport = '/student-fee-report';
  static const String studentPerformanceReport = '/student-performance-report';
  static const String examResultReport = '/exam-result-report';
  static const String classWiseReport = '/class-wise-report';
  static const String feeCollectionReport = '/fee-collection-report';
  static const String expenseReport = '/expense-report';
  static const String incomeReport = '/income-report';
  static const String balanceSheetReport = '/balance-sheet-report';
  static const String libraryBookReport = '/library-book-report';
  static const String libraryIssueReport = '/library-issue-report';
  static const String transportRouteReport = '/transport-route-report';
  static const String transportVehicleReport = '/transport-vehicle-report';
  static const String inventoryStockReport = '/inventory-stock-report';
  static const String inventoryTransactionReport = '/inventory-transaction-report';
  static const String supplierReport = '/supplier-report';
  static const String supplierPaymentReport = '/supplier-payment-report';

  static const String paymentGateway = '/payment-gateway';
  static String getPaymentGatewayRoute() => paymentGateway;
  static const String payFees = '/pay-fees';
  static String getPayFeesRoute() => payFees;
  static const String onlineFeePayments = '/online-fee-payments';
  static String getOnlineFeePaymentsRoute() => onlineFeePayments;
  static const String curriculum = '/curriculum';
  static String getCurriculumRoute() => curriculum;

  static const String createQuestionPaper = '/create-question-paper';
  static String getCreateQuestionPaperRoute() => createQuestionPaper;



  static getInitialRoute() => initial;
  static String getPolicyRoute(PolicyEnum type) => '/policy/${toSeoPath(type)}';
  static getMyCoursesRoute() => myCourses;
  static getMyCourseDetailsRoute(String slug)=> "$myCourseDetails?slug=$slug";
  static getQuizResultRoute({String? slug}) => "$quizResult?slug=$slug";
  static String getFrontendCourseDetailsRoute(String slug) => '$frontendCourseDetail?slug=$slug';
  static getSignInRoute() => signIn;
  static getDashboardRoute() => dashboard;
  static getNotificationRoute() => notification;
  static getProfileRoute() => profile;
  static String getHtmlRoute(String page) => '$html?page=$page';
  static getBranchRoute() => branch;
  static getStudentListRoute() => studentList;
  static getStudentMigrationRoute() => studentMigration;
  static getMigrationPushbackRoute() => migrationPushback;
  static getMigrationListRoute() => migrationList;
  static getStudentBranchMigrationRoute() => studentBranchMigration;
  static getAllStudentViewListRoute() => allStudentViewList;
  static getStaffAttendanceRoute() => staffAttendance;
  static getStaffAttendanceReportRoute() => staffAttendanceReport;
  static getTeacherListRoute() => teacherList;
  static getStaffListRoute() => staffList;
  static getStudentAttendanceRoute() => studentAttendance;
  static getExamAttendanceRoute() => examAttendance;
  static getExamScheduleRoute() => examSchedule;
  static getAttendanceReportRoute() => attendanceReport;
  static getMonthlyAttendanceReportRoute() => monthlyAttendanceReport;
  static getAbsentFineRoute() => absentFine;
  static getAcademicSessionRoute() => academicSession;
  static getShiftRoute() => shift;
  static getClassListRoute() => classList;
  static getSectionRoute() => section;
  static getGroupRoute() => group;
  static getPeriodRoute() => period;
  static getSubjectsRoute() => subjects;
  static getAddNewSubjectRoute() => addNewSubject;
  static getSubjectConfigRoute() => subjectConfig;
  static getExamRoute() => exam;
  static getStudentCategoriesRoute() => studentCategories;
  static getDepartmentRoute() => department;
  static getPicklistRoute() => picklist;
  static getPrincipalSignatureRoute() => principalSignature;
  static getFeesStartUpRoute() => feesStartUp;
  static getFeesMappingRoute() => feesMapping;
  static getFeesDateRoute() => feesDate;
  static getFeesAmountConfigRoute() => feesAmountConfig;
  static getFineWaiverRoute() => fineWaiver;
  static getWaiverConfigRoute() => waiverConfig;
  static getWaiverListRoute() => waiverList;
  static getSmartCollectionRoute() => smartCollection;
  static getQuickCollectionDetailsRoute(String id) => "$quickCollectionDetails?id=$id";
  static getPaidInfoRoute() => paidInfo;
  static getUnpaidInfoRoute() => unpaidInfo;
  static getLedgerRoute() => ledger;
  static getAccountingGroupRoute() => accountingGroup;
  static getAccountingCategoryRoute() => accountingCategory;
  static getAccountingFundRoute() => accountingFund;
  static getChartOfAccountRoute() => chartOfAccount;
  static getJournalRoute() => journal;
  static getPaymentRoute() => payment;
  static getContraRoute() => contra;
  static getFundTransferRoute() => fundTransfer;
  static getReceiptRoute() => receipt;
  static getSyllabusRoute() => syllabus;
  static getAddNewSyllabusRoute() => addNewSyllabus;
  static getAssignmentsRoute() => assignments;
  static getClassRoutineRoute() => classRoutine;
  static getExamRoutineRoute() => examRoutine;
  static getAdmitAndSeatPlanRoute() => admitAndSeatPlan;

  static getBookCategoriesRoute() => bookCategories;
  static getBooksRoute() => books;
  static getBookIssueRoute() => bookIssue;
  static getBookIssueReportRoute() => bookIssueReport;
  static getBookReturnRoute() => bookReturn;
  static getLibraryMemberRoute() => libraryMember;
  static getPhoneBookRoute() => phoneBook;
  static getPhoneBookCategoryRoute() => phoneBookCategory;
  static getPurchaseSmsRoute() => purchaseSms;
  static getSmsTemplateRoute() => smsTemplate;
  static getSmsSentRoute() => smsSent;
  static getAbsentSmsRoute() => absentSmsSent;
  static getSmsReportRoute() => smsReport;
  static getSmsManagementRoute() => smsManagement;
  static getMarkConfigRoute() => markConfig;
  static getMarkInputRoute() => markInput;
  static getRemarkConfigRoute() => remarkConfig;
  static getExamResultRoute() => examResult;
  static getExamMarksheetRoute() => examMarkSheet;
  static getExamStartUpRoute() => examStartUp;
  static getAssignShiftRoute() => assignShift;
  static getAssignSubjectRoute() => assignSubject;
  static getSystemSettingsRoute() => systemSettings;
  static getNoticeRoute() => notice;
  static getQuestionRoute(String? page, {String? courseId}) => "$question?page=$page&courseId=$courseId";
  static getCourseDetailsRoute(String id) => "$courseDetails?id=$id";
  static getQuestionTopicRoute() => questionTopic;
  static getAnswerRoute() => answer;
  static getQuizTopicRoute() => quizTopic;
  static getQuizRoute() => quiz;
  static getUserActivitiesRoute() => userActivities;
  static getRolesRoute() => roles;
  static getUsersRoute() => users;
  static getThirdPartyRoute() => thirdParty;
  static getZoomMeetingRoute() => zoomMeeting;
  static getZoomConfigRoute() => zoomConfig;
  static getApplyInstituteRoute() => applyInstitute;
  static getChangePasswordRoute() => changePassword;
  static getDeleteAccountRoute() => deleteAccount;
  static getAddNewStudentRoute() => addNewStudent;
  static getAddNewStaffRoute() => addNewStaff;
  static getAddNewTeacherRoute() => addNewTeacher;
  static getChatGptRoute() => chatGpt;
  static getSubscriptionRoute() => subscription;
  static getCertificateRoute(CertificateTypeEnum type) => "$certificate?type=${type.name}";
  static getIdCardRoute() => idCard;
  static getLayoutAndCertificateManagementRoute() => layoutAndCertificateManagement;


  //CMS
  static getAboutUsRoute() => aboutUs;
  static getBannerRoute() => banner;
  static getWhyChooseUsRoute() => whyChooseUs;
  static getMobileAppSectionRoute() => mobileApp;
  static getReadyToJoinRoute() => readyToJoin;
  static getFaqRoute() => faq;
  static getFeedbackRoute() => feedback;
  static getAcademicImageRoute() => academicImage;
  static getPolicyPagesRoute() => policyPages;
  static getThemeRoute() => theme;

  static getFeesHeadRoute() => feesHead;
  static getFeesSubHeadRoute() => feesSubHead;
  static getWaiverRoute() => waiver;
  static getFeeDateConfigRoute() => feeDateConfig;
  static getPaidReportRoute() => paidReport;
  static getUnpaidReportRoute() => unpaidReport;
  static getFeesManagementRoute() => feesManagement;
  static getLibraryManagementRoute() => libraryManagement;

  //payroll
  static getPayrollManagementRoute() => payrollManagement;
  static getPayrollStartUpRoute() => payrollStartUp;
  static getPayrollMappingRoute() => payrollMapping;
  static getPayrollAssignRoute() => payrollAssign;
  static getSalaryRoute() => salary;
  static getSalarySlipRoute() => salarySlip;
  static getDueRoute() => due;
  static getAdvancedRoute() => advanced;
  static getReturnedAdvancedRoute() => returnedAdvanced;
  static getSalaryStatementRoute() => salaryStatement;
  static getPaymentInfoRoute() => paymentInfo;


  static getEventRoute() => event;
  static getFeesReportsRoute() => feesReports;
  static getAccountingReportsRoute() => accountingReports;
  static getEmployeeRoute() => employee;


  //parent module
  static getParentSubjectRoute() => parentSubject;
  static getParentClassRoutineRoute() => parentClassRoutine;
  static getParentFeesRoute() => parentFees;
  static getParentProfileRoute() => parentProfile;
  static getParentAttendanceRoute() => parentAttendance;
  static getParentAssignmentRoute() => parentAssignment;
  static getParentLibraryRoute() => parentLibrary;
  static getParentNoticeRoute() => parentNotice;
  static getParentEventRoute() => parentEvent;
  static getParentExamRoute() => parentExam;
  static getParentBehaviourRoute() => parentBehaviour;



  //Student Module
  static getStudentSubjectRoute() => studentSubject;
  static getStudentClassRoutineRoute() => studentClassRoutine;
  static getStudentFeesRoute() => studentFees;
  static getStudentProfileRoute() => studentProfile;
  static getStudentSelfAttendanceRoute() => studentSelfAttendance;
  static getStudentAssignmentRoute() => studentAssignment;
  static getStudentLibraryRoute() => studentLibrary;
  static getStudentNoticeRoute() => studentNotice;
  static getStudentEventRoute() => studentEvent;
  static getStudentExamRoute() => studentExam;
  static getStudentBehaviourRoute() => studentBehaviour;





  static getStudentInformationRoute() => studentInformation;
  static getStaffInformationRoute() => staffInformation;
  static getStudentAttendanceInformationRoute() => studentAttendanceInformation;
  static getAcademicConfigurationRoute() => academicConfiguration;
  static getAccountManagementRoute() => accountManagement;
  static getRoutineManagementRoute() => routineManagement;
  static getExamManagementRoute() => examManagement;
  static getAdministrationRoute() => administration;
  static getMasterConfigurationRoute() => masterConfiguration;
  static getClientLicenseRoute() => clientLicense;


  //accounting reports
  static getBalanceSheetRoute() => balanceSheet;
  static getTrailBalanceRoute() => trailBalance;
  static getCashFlowRoute() => cashFlow;
  static getFundWiseReportRoute() => fundWiseReport;
  static getIncomeStatementRoute() => incomeStatement;
  static getLedgerWiseReportRoute() => ledgerWiseReport;
  static getUserWiseReportRoute() => userWiseReport;
  static getVoucherWiseReportRoute() => voucherWiseReport;


  //fees reports
  static getFeesMonthlyPaymentInfoRoute() => feesMonthlyPaymentInfo;
  static getFeesReportPaymentInfoRoute() => feesReportPaymentInfo;
  static getHeadWiseFeesInfoReportRoute() => headWiseFeesInfoReport;
  static getUnpaidFeesInfoReportRoute() => unpaidFeesInfoReport;
  static getFeesPaymentRatioInfoReportRoute() => feesPaymentRatioInfoReport;


  //Hostel Management
  static getHostelManagementRoute() => hostelManagement;
  static getHostelsRoute() => hostels;
  static getHostelCategoriesRoute() => hostelCategories;
  static getHostelMembersRoute() => hostelMembers;
  static getHostelRoomsRoute() => hostelRooms;
  static getHostelMealsRoute() => hostelMeals;
  static getHostelBillsRoute() => hostelBills;
  static getHostelMealPlanRoute() => hostelMealPlan;
  static getHostelMealEntriesRoute() => hostelMealEntries;
  static getHostelRoomMembersRoute() => hostelRoomMembers;


  // Transportation Management
  static getTransportationManagementRoute() => transportationManagement;
  static getTransportBusesRoute() => transportBuses;
  static getTransportDriversRoute() => transportDrivers;
  static getBusRoutesRoute() => busRoutes;
  static getBusStopsRoute() => busStops;
  static getTransportMembersRoute() => transportMembers;

  // Inventory Management
  static getInventoryItemsRoute() => inventoryItems;
  static getInventoryCategoriesRoute() => inventoryCategories;
  static getInventorySuppliersRoute() => inventorySuppliers;
  static getInventoryStockRoute() => inventoryStock;
  static getInventoryTransactionsRoute() => inventoryTransactions;

  // Supplier Management
  static getSupplierListRoute() => supplierList;
  static getAddSupplierRoute() => addSupplier;
  static getSupplierPaymentsRoute() => supplierPayments;
  static getSupplierLedgerRoute() => supplierLedger;

  // Reports
  static getStudentAttendanceReportRoute() => studentAttendanceReport;
  static getStudentFeeReportRoute() => studentFeeReport;
  static getStudentPerformanceReport() => studentPerformanceReport;
  static getExamResultReportRoute() => examResultReport;
  static getClassWiseReportRoute() => classWiseReport;
  static getFeeCollectionReportRoute() => feeCollectionReport;
  static getExpenseReportRoute() => expenseReport;
  static getIncomeReportRoute() => incomeReport;
  static getLibraryBookReportRoute() => libraryBookReport;
  static getLibraryIssueReportRoute() => libraryIssueReport;
  static getTransportRouteReportRoute() => transportRouteReport;
  static getTransportVehicleReportRoute() => transportVehicleReport;
  static getInventoryStockReportRoute() => inventoryStockReport;
  static getInventoryTransactionReportRoute() => inventoryTransactionReport;
  static getSupplierReportRoute() => supplierReport;
  static getSupplierPaymentReportRoute() => supplierPaymentReport;

  static getSmsConfigRoute() => smsConfig;



  //------------------Question Bank---------------------
  static getQuestionCategoryRoute() => questionCategory;
  static getAddNewQuestionRoute({QuestionItem? questionItem}) {
    String? data;
    if(questionItem != null) {
      data = base64Url.encode(utf8.encode(jsonEncode(questionItem.toJson())));
      return '$addNewQuestion?data=$data';
    }else {
      return addNewQuestion;
    }

  }
  static getQuestionBankClassRoute() => questionBankClass;
  static getQuestionBankGroupRoute() => questionBankGroup;
  static getQuestionBankSubjectRoute() => questionBankSubject;
  static getQuestionBankChapterRoute() => questionBankChapter;
  static getQuestionBankTypesRoute() => questionBankTypes;
  static getQuestionBankTopicRoute() => questionBankTopic;
  static getQuestionBankLevelRoute() => questionBankLevel;
  static getQuestionBankSourcesRoute() => questionBankSources;
  static getQuestionBankSubSourcesRoute() => questionBankSubSources;
  static getQuestionBankYearRoute() => questionBankYear;
  static getQuestionBankBoardRoute() => questionBankBoard;
  static getQuestionBankTagRoute() => questionBankTag;


  static getCourseCategoryRoute() => courseCategory;
  static getCourseRoute() => course;
  static getAddNewCourseRoute({CourseItem? courseItem}) {
    String? data;
    if(courseItem != null) {
      data = base64Url.encode(utf8.encode(jsonEncode(courseItem.toJson())));
      return '$addNewCourse?data=$data';
    }else {
      return addNewCourse;
    }
  }
  static getQuizSettingRoute() => quizSetting;
  static getChapterRoute() => chapter;
  static getLessonRoute() => lesson;
  static getFrontendCoursesRoute() => frontendCourses;










  static List<GetPage> routes = [
    customPage(name: initial, page: () => const SchoolHomePage(),
      arguments: SeoData(title: 'Welcome to ${AppConstants.appName}',
        description: '${AppConstants.appName} is an all-in-one LMS system for modern education.'),
    ),
    customPage(name: signIn, page: () => const LoginScreen(),
      arguments: SeoData(title: 'Sign In - ${AppConstants.appName}',
        description: 'Access your ${AppConstants.appName} account securely.'),
    ),
    customPage(name: dashboard, page: () => const DashboardScreen(),
      arguments: SeoData(title: 'Dashboard - ${AppConstants.appName}',
        description: 'Your dashboard overview in ${AppConstants.appName}.'),
    ),

    customPage(name: profile, page: () => const ProfileScreen()),
    customPage(name: systemSettings, page: () => const SystemSettingScreen()),
    customPage(name: html, page: () => HtmlViewerScreen(
        htmlType: Get.parameters['page'] == 'terms-and-condition'
            ? HtmlType.termsAndCondition
            : Get.parameters['page'] == 'privacy-policy'
            ? HtmlType.privacyPolicy
            : Get.parameters['page'] == 'cancellation_policy'
            ? HtmlType.cancellationPolicy
            : Get.parameters['page'] == 'refund_policy'
            ? HtmlType.refundPolicy
            : HtmlType.aboutUs,
      )),
    customPage(name: branch, page: () => const BranchScreen() ),
    customPage(name: thirdParty, page: () => const ThirdPartyScreen()),
    customPage(name: zoomMeeting, page: () => const ZoomClassScreen()),
    customPage(name: zoomConfig, page: () => const ZoomConfigScreen()),
    customPage(name: notice, page: () => const NoticeScreen()),
    customPage(name: changePassword, page: () => const PasswordChangeScreen()),
    customPage(name: studentList, page: () => const StudentScreen()),
    customPage(name: allStudentViewList, page: () => const AllStudentScreen()),
    customPage(name: studentMigration, page: () => const StudentMigrationScreen()),
    customPage(name: migrationPushback, page: () => const StudentMigrationScreen(isMigrationPushback: true)),
    customPage(name: migrationList, page: () => const StudentMigrationListScreen()),
    customPage(name: studentBranchMigration, page: () => const StudentBranchMigrationScreen()),
    customPage(name: deleteAccount, page: () => const DeleteAccountScreen()),
    customPage(name: teacherList, page: () => const TeacherScreen() ),
    customPage(name: staffList, page: () => const StaffScreen()),
    customPage(name: staffAttendance, page: () => const StaffAttendanceScreen()),
    customPage(name: staffAttendanceReport, page: () => const StaffAttendanceReportScreen()),
    customPage(name: feesStartUp, page: () => const FeesStartupScreen()),
    customPage(name: smartCollection, page: () => const SmartCollectionScreen()),
    customPage(name: quickCollectionDetails, page: () => QuickCollectionDetailsScreen(id: Get.parameters['id']?? "0")),


    // CMS
    customPage(name: aboutUs, page: () => const AboutUsScreen() ),
    customPage(name: banner, page: () => const BannerScreen()),
    customPage(name: whyChooseUs, page: () => const WhyChooseUsScreen()),
    customPage(name: mobileApp, page: () => const MobileAppScreen()),
    customPage(name: readyToJoin, page: () => const ReadyToJoinScreen()),
    customPage(name: faq, page: () => const FaqScreen()),
    customPage(name: feedback, page: () => const FeedbackScreen()),
    customPage(name: academicImage, page: () => const AcademicImageScreen()),
    customPage(name: policyPages, page: () => const PolicyPagesScreen()),
    customPage(name: theme, page: () => const SelectThemeWidget()),
    // Fees
    customPage(name: feesHead, page: () => const FeesHeadScreen()),
    customPage(name: feesSubHead, page: () => const FeesSubHeadScreen()),
    customPage(name: waiver, page: () => const WaiverScreen()),
    customPage(name: feesAmountConfig, page: () => const FeesAmountConfigScreen()),
    customPage(name: feeDateConfig, page: () => const FeeDateConfigScreen()),
    customPage(name: waiverConfig, page: () => const WaiverConfigScreen() ),
    customPage(name: feesMapping, page: () => const FeesMappingScreen()),
    customPage(name: paidReport, page: () => const PaidReportScreen()),
    customPage(name: unpaidReport, page: () => const UnPaidReportScreen()),
    customPage(name: feesManagement, page: () => const FeesManagementScreen()),
    customPage(name: libraryManagement, page: () => const LibraryManagementScreen()),

    // Payroll
    customPage(name: payrollManagement, page: () => const PayrollManagementScreen()),
    customPage(name: payrollStartUp, page: () => const PayrollStartUpScreen()),
    customPage(name: payrollMapping, page: () => const PayrollMappingScreen()),
    customPage(name: payrollAssign, page: () => const PayrollAssignScreen()),
    customPage(name: salary, page: () => const SalaryScreen()),
    customPage(name: salarySlip, page: () => const SalarySlipScreen()),
    customPage(name: due, page: () => const DueSalaryScreen()),
    customPage(name: advanced, page: () => const AdvanceSalaryScreen()),
    customPage(name: returnedAdvanced, page: () => const ReturnAdvanceScreen()),
    customPage(name: salaryStatement, page: () => const SalaryStatementScreen()),
    customPage(name: paymentInfo, page: () => const SalaryPaymentInfoScreen()),


    customPage(name: feesReports, page: () => const FeesReportsScreen()),
    customPage(name: accountingReports, page: () => const AccountingReportsScreen()),
    customPage(name: studentAttendance, page: () => const StudentAttendanceScreen() ),
    customPage(name: section, page: () => const SectionScreen()),
    customPage(name: addNewStudent, page: () => const AddNewStudentScreen()),


    //add new staff
    customPage(name: addNewStaff, page: () => const AddNewStaffScreen()),
    customPage(name: addNewTeacher, page: () => const AddNewTeacherScreen()),
    customPage(name: chatGpt, page: () => const ChatGptScreen()),
    customPage(name: absentFine, page: () => const AbsentFineScreen()),

    // Parent module
    customPage(name: parentSubject, page: () => const ParentSubjectScreen()),
    customPage(name: parentClassRoutine, page: () => const ParentClassRoutineScreen()),
    customPage(name: parentFees, page: () => const ParentFeesScreen()),
    customPage(name: parentProfile, page: () => const ParentProfileScreen()),
    customPage(name: parentAssignment, page: () => const ParentAssignmentScreen()),
    customPage(name: parentLibrary, page: () => const ParentLibraryScreen()),
    customPage(name: parentNotice, page: () => const ParentNoticeScreen()),
    customPage(name: parentEvent, page: () => const ParentEventScreen()),
    customPage(name: parentExam, page: () => const ParentExamScreen()),
    customPage(name: parentBehaviour, page: () => const BehaviourScreen()),


    //student Module
    customPage(name: studentSubject, page: () => const StudentSubjectScreen()),
    customPage(name: studentClassRoutine, page: () => const StudentClassRoutineScreen()),
    // customPage(name: studentFees, page: () => const StudentFeesScreen()),
    customPage(name: studentProfile, page: () => const StudentProfileScreen()),
    // customPage(name: studentSelfAttendance, page: () => const StudentSelfAttendanceScreen()),
    customPage(name: studentAssignment, page: () => const StudentAssignmentScreen()),
    customPage(name: studentLibrary, page: () => const StudentLibraryScreen()),
    customPage(name: studentNotice, page: () => const StudentNoticeScreen()),
    // customPage(name: studentEvent, page: () => const StudentEventScreen()),
    // customPage(name: studentExam, page: () => const StudentExamScreen()),
    customPage(name: studentBehaviour, page: () => const BehaviourScreen()),




    customPage(name: attendanceReport, page: () => const AttendanceReportScreen()),
    customPage(name: monthlyAttendanceReport, page: () => const MonthlyAttendanceReportScreen()),
    customPage(name: syllabus, page: () => const SyllabusScreen()),
    customPage(name: addNewSyllabus, page: () => const CreateNewSyllabusScreen()),
    customPage(name: classList, page: () => const ClassScreen()),
    customPage(name: shift, page: () => const ShiftScreen()),
    customPage(name: group, page: () => const GroupScreen()),
    customPage(name: period, page: () => const PeriodScreen()),
    customPage(name: subjects, page: () => const SubjectScreen()),
    customPage(name: subjectConfig, page: () => const SubjectConfigScreen()),
    customPage(name: addNewSubject, page: () => const AddNewSubjectScreen()),
    customPage(name: assignments, page: () => const AssignmentScreen()),
    customPage(name: admitAndSeatPlan, page: () => const AdmitAndSeatPlanScreen()),
    customPage(name: bookCategories, page: () => const BookCategoryScreen()),
    customPage(name: books, page: () => const BookScreen()),
    customPage(name: libraryMember, page: () => const LibraryMemberScreen()),
    customPage(name: academicSession, page: () => const SessionScreen()),
    customPage(name: unpaidInfo, page: () => const UnpaidFeesInfoScreen()),
    customPage(name: bookIssueReport, page: () => const BookIssueReportScreen()),
    customPage(name: studentCategories, page: () => const StudentCategoriesScreen()),
    customPage(name: department, page: () => const DepartmentScreen()),
    customPage(name: picklist, page: () => const PickListScreen()),
    customPage(name: principalSignature, page: () => const SignatureScreen()),
    customPage(name: markConfig, page: () => const MarkConfigScreen()),
    customPage(name: remarkConfig, page: () => const ReMarkConfigScreen()),
    customPage(name: userActivities, page: () => const UserLogScreen()),
    customPage(name: event, page: () => const EventScreen()),
    customPage(name: employee, page: () => const EmployeeScreen()),
    customPage(name: roles, page: () => const RoleManagementScreen()),
    customPage(name: bookReturn, page: () => const BookReturnScreen()),
    customPage(name: bookIssue, page: () => const BookIssueScreen()),
    customPage(name: chartOfAccount, page: () => const ChartOfAccountScreen()),
    customPage(name: fundTransfer, page: () => const FundTransferScreen()),
    customPage(name: journal, page: () => const JournalScreen()),
    customPage(name: contra, page: () => const ContraScreen()),
    customPage(name: receipt, page: () => const ReceiptScreen()),
    customPage(name: payment, page: () => const PaymentScreen()),
    customPage(name: accountingGroup, page: () => const AccountingGroupScreen()),
    customPage(name: accountingCategory, page: () => const AccountingCategoryScreen()),
    customPage(name: accountingFund, page: () => const AccountingFundScreen()),
    customPage(name: ledger, page: () => const AccountingLedgerScreen()),
    customPage(name: examResult, page: () => const ExamResultScreen()),
    customPage(name: examMarkSheet, page: () => const MarksheetConfigScreen()),
    customPage(name: exam, page: () => const ExamScreen()),
    customPage(name: markInput, page: () => const MarkInputScreen()),
    customPage(name: examStartUp, page: () => const ExamStartupScreen()),
    customPage(name: examSchedule, page: () => const ExamScheduleScreen()),
    customPage(name: examAttendance, page: () => const ExamAttendanceScreen()),
    // customPage(name: quizResult, page: () => const QuizResultScreen()),
    // Legacy quiz answers/topics had no backend any more: send users to the current quiz manager.
    customPage(name: answer, page: () => const QuizSettingScreen()),
    customPage(name: question, page: () => QuestionScreen(page: Get.parameters['page'],)),


    //Neeeeddddd update
    // customPage(name: questionTopic, page: () => const QuestionTopicScreen()),




    customPage(name: quizTopic, page: () => const QuizSettingScreen()),
    customPage(name: purchaseSms, page: () => const PurchaseSmsScreen()),
    customPage(name: phoneBook, page: () => const PhoneBookScreen()),
    customPage(name: phoneBookCategory, page: () => const PhoneBookCategoryScreen()),
    customPage(name: smsTemplate, page: () => const SmsTemplateScreen()),
    customPage(name: fineWaiver, page: () => const FineWaiverScreen()),
    customPage(name: examRoutine, page: () => const ExamRoutineScreen()),
    customPage(name: classRoutine, page: () => const ClassRoutineScreen()),
    customPage(name: subscription, page: () => const SubscriptionScreen()),
    customPage(name: smsSent, page: () => const SmsUserScreen()),
    customPage(name: absentSmsSent, page: () => const AbsentSmsScreen()),
    customPage(name: smsReport, page: () => const SentSmsReportScreen()),
    customPage(name: smsManagement, page: () => const SmsManagementScreen()),



    customPage(name: studentInformation, page: () => const StudentInformationScreen()),
    customPage(name: staffInformation, page: () => const StaffInformationScreen()),
    customPage(name: studentAttendanceInformation, page: () => const StudentAttendanceInformationScreen()),
    customPage(name: academicConfiguration, page: () => const AcademicConfigurationScreen()),
    customPage(name: accountManagement, page: () => const AccountManagementScreen()),
    customPage(name: routineManagement, page: () => const RoutineManagementScreen()),
    customPage(name: examManagement, page: () => const ExamManagementScreen()),
    customPage(name: administration, page: () => const AdministrationScreen()),
    customPage(name: masterConfiguration, page: () => const MasterConfigurationScreen()),
    customPage(name: clientLicense, page: () => const ClientLicenseScreen()),


    //accounting reports
    customPage(name: balanceSheet, page: () => const BalanceSheetScreen()),
    customPage(name: trailBalance, page: () => const TrailBalanceScreen()),
    customPage(name: cashFlow, page: () => const CashFlowStatementScreen()),
    customPage(name: fundWiseReport, page: () => const FundWiseScreen()),
    customPage(name: incomeStatement, page: () => const IncomeStatementScreen()),
    customPage(name: ledgerWiseReport, page: () => const LedgerWiseScreen()),
    customPage(name: userWiseReport, page: () => const UserWiseScreen()),
    customPage(name: voucherWiseReport, page: () => const VoucherWiseScreen()),

    //fees reports
    customPage(name: feesMonthlyPaymentInfo, page: () => const FeesMonthlyReportScreen()),
    customPage(name: feesReportPaymentInfo, page: () => const FeesPaymentInfoScreen()),
    customPage(name: headWiseFeesInfoReport, page: () => const HeadWiseFeesInfoScreen()),
    customPage(name: unpaidFeesInfoReport, page: () => const UnpaidFeesInfoScreen()),
    customPage(name: feesPaymentRatioInfoReport, page: () => const FeesPaymentRatioScreen()),


    //Hostel Management
    customPage(name: hostelManagement, page: () => const HostelManagementScreen()),
    customPage(name: hostels, page: () => const HostelScreen()),
    customPage(name: hostelCategories, page: () => const HostelCategoryScreen()),
    customPage(name: hostelMembers, page: () => const HostelMemberScreen()),
    customPage(name: hostelRooms, page: () => const HostelRoomsScreen()),
    customPage(name: hostelMeals, page: () => const HostelMealsScreen()),
    customPage(name: hostelBills, page: () => const HostelBillScreen()),
    customPage(name: hostelMealPlan, page: () => const HostelMealPlanScreen()),
    customPage(name: hostelMealEntries, page: () => const HostelMealEntriesScreen()),
    customPage(name: hostelRoomMembers, page: () => const HostelRoomMemberScreen()),


    //Transport Management
    customPage(name: transportationManagement, page: () => const TransportationManagementScreen()),
    customPage(name: transportBuses, page: () => const TransportBusScreen()),
    customPage(name: transportDrivers, page: () => const TransportDriverScreen()),
    customPage(name: busRoutes, page: () => const TransportBusRouteScreen()),
    customPage(name: busStops, page: () => const TransportBusStopScreen()),
    customPage(name: transportMembers, page: () => const TransportMemberScreen()),
    customPage(name: idCard, page: () => const IdCardScreen()),

    // Inventory Management
    customPage(name: inventoryItems, page: () => const InventoryItemsScreen()),
    customPage(name: inventoryCategories, page: () => const InventoryCategoriesScreen()),
    customPage(name: inventorySuppliers, page: () => const InventorySuppliersScreen()),
    customPage(name: inventoryStock, page: () => const InventoryStockScreen()),
    customPage(name: inventoryTransactions, page: () => const InventoryTransactionsScreen()),

    // Supplier Management
    customPage(name: supplierList, page: () => const SupplierListScreen()),
    customPage(name: addSupplier, page: () => const AddSupplierScreen()),
    customPage(name: supplierPayments, page: () => const SupplierPaymentsScreen()),
    customPage(name: supplierLedger, page: () => const SupplierLedgerScreen()),

    // Reports
    customPage(name: studentAttendanceReport, page: () => const StudentAttendanceReportScreen()),
    customPage(name: studentFeeReport, page: () => const StudentFeeReportScreen()),
    customPage(name: studentPerformanceReport, page: () => const StudentPerformanceReportScreen()),
    customPage(name: examResultReport, page: () => const ExamResultReportScreen()),
    customPage(name: classWiseReport, page: () => const ClassWiseReportScreen()),
    customPage(name: feeCollectionReport, page: () => const FeeCollectionReportScreen()),
    customPage(name: expenseReport, page: () => const ExpenseReportScreen()),
    customPage(name: incomeReport, page: () => const IncomeReportScreen()),
    customPage(name: balanceSheetReport, page: () => const BalanceSheetReportScreen()),
    customPage(name: libraryBookReport, page: () => const LibraryBookReportScreen()),
    customPage(name: libraryIssueReport, page: () => const LibraryIssueReportScreen()),
    customPage(name: transportRouteReport, page: () => const TransportRouteReportScreen()),
    customPage(name: transportVehicleReport, page: () => const TransportVehicleReportScreen()),
    customPage(name: inventoryStockReport, page: () => const InventoryStockReportScreen()),
    customPage(name: inventoryTransactionReport, page: () => const InventoryTransactionReportScreen()),
    customPage(name: supplierReport, page: () => const SupplierReportScreen()),
    customPage(name: supplierPaymentReport, page: () => const SupplierPaymentReportScreen()),

    //------------------------Question Bank-------------------------------
    GetPage(name: questionCategory, page: () => const QuestionCategoryScreen()),
    GetPage(name: addNewQuestion, page: () {
      String? data = Get.parameters['data'];
      if(data != null) {
        QuestionItem questionItem = QuestionItem.fromJson(jsonDecode(utf8.decode(base64Url.decode(data))));
        return CreateNewQuestionScreen(questionItem: questionItem);
      } else {
        return const CreateNewQuestionScreen();
      }
    }),
    GetPage(name: questionBankClass, page: () => const QuestionBankClassScreen()),
    GetPage(name: questionBankGroup, page: () => const QuestionBankGroupScreen()),
    GetPage(name: questionBankSubject, page: () => const QuestionBankSubjectScreen()),
    GetPage(name: questionBankChapter, page: () => const QuestionBankChapterScreen()),
    GetPage(name: questionBankTypes, page: () => const QuestionBankTypeScreen()),
    GetPage(name: questionBankTopic, page: () => const QuestionBankTopicScreen()),
    GetPage(name: questionBankLevel, page: () => const QuestionBankLevelScreen()),
    GetPage(name: questionBankSources, page: () => const QuestionBankSourceScreen()),
    GetPage(name: questionBankSubSources, page: () => const QuestionBankSubSourceScreen()),
    GetPage(name: questionBankYear, page: () => const QuestionBankYearScreen()),
    GetPage(name: questionBankBoard, page: () => const QuestionBankBoardScreen()),
    GetPage(name: questionBankTag, page: () => const QuestionBankTagScreen()),


    GetPage(name: courseCategory, page: () => const CourseCategoryScreen()),
    GetPage(name: course, page: () => const CourseScreen()),
    GetPage(name: courseDetails, page: () => CourseDetailsScreen(courseId: Get.parameters['id']??"0")),
    GetPage(name: addNewCourse, page: () {
      String? data = Get.parameters['data'];
      if(data != null) {
        CourseItem courseItem = CourseItem.fromJson(jsonDecode(utf8.decode(base64Url.decode(data))));
        return CreateNewCourseScreen(courseItem: courseItem);
      } else {
        return const CreateNewCourseScreen();
      }
    }),
    GetPage(name: quizSetting, page: () => const QuizSettingScreen()),
    GetPage(name: lesson, page: () => const CreateNewLessonScreen()),

    GetPage(name: policy,
      page: () {
        final typeParam = Get.parameters['type'];
        final policyType = PolicyEnum.values.firstWhere(
              (e) => toSeoPath(e) == typeParam,
          orElse: () => PolicyEnum.termsOfService,
        );

        return PolicyScreen(policyType: policyType);
      },
    ),

    GetPage(name: frontendCourseDetail, page: () => FrontendCourseDetailsScreen( slug: Get.parameters['slug'])),
    GetPage(name: myCourses, page: () => const MyCourseScreen()),
    GetPage(name: myCourseDetails, page: () => getRoute(MyCourseDetailsScreen(slug: Get.parameters['slug']))),
    GetPage(name: quizResult, page: () => QuizExamReviewResultScreen(courseId: Get.parameters['slug'])),


    GetPage(name: certificate, page: () => LayoutAndCertificateScreen(type: CertificateTypeEnum.values.firstWhere((e) =>
          e.name.toLowerCase() == (Get.parameters['type'] ?? 'layout').toLowerCase(), orElse: () => CertificateTypeEnum.recommendation))),

    customPage(name: layoutAndCertificateManagement, page: () => const LayoutAndCertificateManagementScreen()),
    customPage(name: frontendCourses, page: () => const FrontendCourseScreen()),
    customPage(name: smsConfig, page: () => const SmsSettingScreen()),
    customPage(name: paymentGateway, page: () => const PaymentGatewayScreen()),
    customPage(name: payFees, page: () => const OnlineFeesScreen()),
    customPage(name: onlineFeePayments, page: () => const OnlineFeePaymentsAdminScreen()),
    customPage(name: curriculum, page: () => const CurriculumScreen()),
    customPage(name: createQuestionPaper, page: () => const QuestionPaperCreateScreen()),
  ];

  static getRoute(Widget navigateTo) {
    return  navigateTo;
  }


}
String toSeoPath(PolicyEnum type) {
  switch (type) {
    case PolicyEnum.termsOfService:
      return 'terms-of-service';
    case PolicyEnum.privacyPolicy:
      return 'privacy-policy';
    case PolicyEnum.cookiePolicy:
      return 'cookie-policy';
  }
}






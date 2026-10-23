
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/side_menu/src/side_menu_item_widget.dart';
import 'package:class_compass/common/widget/side_menu/src/side_menu_nested_expension_item.dart';
import 'package:class_compass/feature/home/domain/repository/home_repository.dart';
import 'package:class_compass/feature/home/widget/data_sync.dart';
import 'package:class_compass/feature/layout_and_certificate/enum/certificate_type_enum.dart';
import 'package:class_compass/feature/parent_module/parent_profile/logic/parent_profile_controller.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/images.dart';

class SideMenuBarController extends GetxController implements GetxService{
  final HomeRepository homeRepository;
  final ProfileController profileController = Get.find<ProfileController>();
  SideMenuBarController({required this.homeRepository});


  List<dynamic> sideMenuItems = [];
  late List<dynamic> _allMenuItems;
  bool isExpanded = true;


  void toggleSideMenu(bool exp) {
    isExpanded = exp;
    update();
  }


  @override
  void onInit() {
    sideMenuItems = _buildInitSideMenuItems();
    _allMenuItems = List.from(sideMenuItems);
    super.onInit();
  }


  void updateSideMenuItems() {
    sideMenuItems = _buildSideMenuItems();
    _allMenuItems = List.from(sideMenuItems);
    update();
  }

  void updateParentSideMenuItems() {
    sideMenuItems = _buildParentSideMenuItems();
    _allMenuItems = List.from(sideMenuItems);
    update();
  }

  void updateStudentSideMenuItems() {
    sideMenuItems = _buildStudentSideMenuItems();
    _allMenuItems = List.from(sideMenuItems);
    update();
  }



  void filterMenu(String query) {
    final q = query.trim().toLowerCase();

    if (q.isEmpty) {
      sideMenuItems = List.from(_allMenuItems);
    } else {
      sideMenuItems = _allMenuItems.map((item) {
        if (item is SideMenuNestedItem) {
          final List<Widget> matchedChildren = item.children
              ?.where((child) =>
              _getItemTitle(child).contains(q))
              .toList() ??
              [];

          if (matchedChildren.isNotEmpty) {
            return SideMenuNestedItem(
              keyValue: item.keyValue,
              title: item.title,
              icon: item.icon,
              parent: item.parent,
              onTap: item.onTap,
              sectionTitle: item.sectionTitle,
              children: matchedChildren,
            );
          }
          if (_getItemTitle(item).contains(q)) return item;

          return null;
        }
        return _getItemTitle(item).contains(q) ? item : null;
      }).whereType<SideMenuNestedItem>().toList();
    }
    update();
  }

  String _getItemTitle(dynamic item) {
    if (item is SideMenuChildItemWidget) return item.title.toLowerCase();
    if (item is SideMenuNestedItem) return item.title.toLowerCase();
    return '';
  }





  List<dynamic> _buildSideMenuItems() {
    return  [
    if(profileController.hasPermission("dashboard"))
      SideMenuNestedItem(title: "dashboard".tr, keyValue: "dashboard", parent: true,
        icon: Images.dashboardSvgIcon,
        onTap: () => Get.toNamed(RouteHelper.getDashboardRoute()),),



   if(profileController.hasPermission("master_configuration.branches"))
    SideMenuNestedItem(title: 'branch'.tr, keyValue: "branch", parent: true,
         icon: Images.dashboardSvgIcon,
        onTap: () => Get.toNamed(RouteHelper.getBranchRoute())),



    if(profileController.hasPermission("student_information.student_index") ||
        profileController.hasPermission("student_information.student_migration") ||
        profileController.hasPermission("student_information.student_pullback") ||
        profileController.hasPermission("student_information.migration_list") ||
        profileController.hasPermission("student_information.all_student_list"))
    SideMenuNestedItem(sectionTitle: "student_management".tr,
        title: "student_information".tr, keyValue: "student_information", parent: true,
        icon: Images.studentInformationSvgIcon, children: [

      if(profileController.hasPermission("student_information.student_index"))
    SideMenuChildItemWidget(title: 'student_list'.tr, keyValue: "student_list",
          onTap: () => Get.toNamed(RouteHelper.getStudentListRoute()),),

      if(profileController.hasPermission("student_information.student_migration"))
    SideMenuChildItemWidget(title: 'student_migration'.tr, keyValue: "student_migration",
          onTap: () => Get.toNamed(RouteHelper.getStudentMigrationRoute())),

      if(profileController.hasPermission("student_information.student_pullback"))
    SideMenuChildItemWidget(title: 'migration_pushback'.tr, keyValue: "migration_pushback",
          onTap: () => Get.toNamed(RouteHelper.getMigrationPushbackRoute())),

      if(profileController.hasPermission("student_information.migration_list"))
    SideMenuChildItemWidget(title: 'migration_list'.tr, keyValue: "migration_list",
          onTap: () => Get.toNamed(RouteHelper.getMigrationListRoute())),


          if(profileController.hasPermission("student_information.migration_list"))
            SideMenuChildItemWidget(title: 'student_branch_migration'.tr, keyValue: "student_branch_migration",
                onTap: () => Get.toNamed(RouteHelper.getStudentBranchMigrationRoute())),



          if(profileController.hasPermission("student_information.all_student_list"))
    SideMenuChildItemWidget(title: 'all_student_view_list'.tr, keyValue: "all_student_view_list",
          onTap: () => Get.toNamed(RouteHelper.getAllStudentViewListRoute())),

      ]),


    if(profileController.hasPermission("student_attendance.student_attendance_index") || profileController.hasPermission("student_attendance.exam_attendance_schedule") || profileController.hasPermission("student_attendance.exam_attendance_index") || profileController.hasPermission("student_attendance.student_attendance_report") || profileController.hasPermission("student_attendance.student_absent_report"))
    SideMenuNestedItem(title: "student_attendance".tr, keyValue: "student_attendance", parent: true,
          icon: Images.studentAttendanceSvgIcon, children: [


      if(profileController.hasPermission("student_attendance.student_attendance_create"))
    SideMenuChildItemWidget(title: 'student_attendance'.tr, keyValue: "student_attendance",
          onTap: () => Get.toNamed(RouteHelper.getStudentAttendanceRoute())),


      if(profileController.hasPermission("student_attendance.student_attendance_report"))
    SideMenuChildItemWidget(title: 'attendance_report'.tr, keyValue: "attendance_report",
          onTap: () => Get.toNamed(RouteHelper.getAttendanceReportRoute())),

          if(profileController.hasPermission("student_attendance.student_attendance_report"))
            SideMenuChildItemWidget(title: 'monthly_attendance_report'.tr,
                keyValue: "monthly_attendance_report",
                onTap: () => Get.toNamed(RouteHelper.getMonthlyAttendanceReportRoute())),


    //       if(profileController.hasPermission("student_attendance.student_absent_report"))
    // SideMenuChildItemWidget(title: 'absent_fine'.tr, keyValue: "absent_fine",
    //       onTap: () => Get.toNamed(RouteHelper.getAbsentFineRoute())),

      ]),


    if(profileController.hasPermission("academic_configuration.academic_session") || profileController.hasPermission("academic_configuration.shifts") || profileController.hasPermission("academic_configuration.classes") || profileController.hasPermission("academic_configuration.sections") || profileController.hasPermission("academic_configuration.groups") || profileController.hasPermission("academic_configuration.periods") || profileController.hasPermission("academic_configuration.subjects") || profileController.hasPermission("academic_configuration.subject_config") || profileController.hasPermission("academic_configuration.exams") || profileController.hasPermission("academic_configuration.student_categories") || profileController.hasPermission("academic_configuration.departments") || profileController.hasPermission("academic_configuration.picklist") || profileController.hasPermission("academic_configuration.principal_signatures"))
    SideMenuNestedItem(title: "academic_configuration".tr, keyValue: "academic_configuration", parent: true,
          icon: Images.academicSvgIcon, children: [

    if(profileController.hasPermission("academic_configuration.academic_session"))
    SideMenuChildItemWidget(title: 'academic_session'.tr, keyValue: "academic_session",
          onTap: () => Get.toNamed(RouteHelper.getAcademicSessionRoute())),

      if(profileController.hasPermission("academic_configuration.shifts"))
    SideMenuChildItemWidget(title: 'shift'.tr, keyValue: "shift",
          onTap: () => Get.toNamed(RouteHelper.getShiftRoute())),

      if(profileController.hasPermission("academic_configuration.classes"))
    SideMenuChildItemWidget(title: 'class'.tr, keyValue: "class",
          onTap: () => Get.toNamed(RouteHelper.getClassListRoute())),

      if(profileController.hasPermission("academic_configuration.sections"))
    SideMenuChildItemWidget(title: 'section'.tr, keyValue: "section",
          onTap: () => Get.toNamed(RouteHelper.getSectionRoute())),

      if(profileController.hasPermission("academic_configuration.groups"))
    SideMenuChildItemWidget(title: 'group'.tr, keyValue: "group",
          onTap: () => Get.toNamed(RouteHelper.getGroupRoute())),

      if(profileController.hasPermission("academic_configuration.periods"))
    SideMenuChildItemWidget(title: 'period'.tr, keyValue: "period",
          onTap: () => Get.toNamed(RouteHelper.getPeriodRoute())),

      if(profileController.hasPermission("academic_configuration.subjects"))
    SideMenuChildItemWidget(title: 'subjects'.tr,keyValue: "subjects",
          onTap: () => Get.toNamed(RouteHelper.getSubjectsRoute())),

    //   if(profileController.hasPermission("academic_configuration.subject_config"))
    // SideMenuChildItemWidget(title: 'subject_config'.tr,keyValue: "subject_config",
    //       onTap: () => Get.toNamed(RouteHelper.getSubjectConfigRoute())),


      if(profileController.hasPermission("academic_configuration.student_categories"))
    SideMenuChildItemWidget(title: 'student_categories'.tr,keyValue: "student_categories",
          onTap: () => Get.toNamed(RouteHelper.getStudentCategoriesRoute())),

      if(profileController.hasPermission("academic_configuration.departments"))
    SideMenuChildItemWidget(title: 'department'.tr,keyValue: "department",
          onTap: () => Get.toNamed(RouteHelper.getDepartmentRoute())),

      if(profileController.hasPermission("academic_configuration.picklist"))
    SideMenuChildItemWidget(title: 'picklist'.tr,keyValue: "picklist",
          onTap: () => Get.toNamed(RouteHelper.getPicklistRoute())),

      if(profileController.hasPermission("academic_configuration.principal_signatures"))
    SideMenuChildItemWidget(title: 'signature'.tr,keyValue: "signature",
          onTap: () => Get.toNamed(RouteHelper.getPrincipalSignatureRoute())),

      ]),


      if(profileController.hasPermission("staff_information.staff_index") || profileController.hasPermission("staff_information.staff_attendance_create") || profileController.hasPermission("staff_information.teachers_index") || profileController.hasPermission("staff_information.staffs_index"))
        SideMenuNestedItem(sectionTitle: "staff_and_payroll".tr,
            title: "staff_information".tr, keyValue: "staff_information", parent: true,
            icon: Images.staffInformationSvgIcon, children: [


              if(profileController.hasPermission("staff_information.staff_attendance_create"))
                SideMenuChildItemWidget(title: 'staff_attendance'.tr, keyValue: "staff_attendance",
                  onTap: () => Get.toNamed(RouteHelper.getStaffAttendanceRoute()),),

              if(profileController.hasPermission("staff_information.staff_attendance_create"))
                SideMenuChildItemWidget(title: 'staff_attendance_report'.tr, keyValue: "staff_attendance_report",
                  onTap: () => Get.toNamed(RouteHelper.getStaffAttendanceReportRoute()),),

              if(profileController.hasPermission("staff_information.teachers_index"))
                SideMenuChildItemWidget(title: 'teacher_list'.tr,keyValue: "teacher_list",
                    onTap: () => Get.toNamed(RouteHelper.getTeacherListRoute())),

              if(profileController.hasPermission("staff_information.staffs_index"))
                SideMenuChildItemWidget(title: 'staff_list'.tr,keyValue: "staff_list",
                    onTap: () => Get.toNamed(RouteHelper.getStaffListRoute())),


            ]),

      //payroll_management
      if(profileController.hasPermission("payroll.payroll_start_up") || profileController.hasPermission("payroll.payroll_mapping") ||
          profileController.hasPermission("payroll.payroll_assign") || profileController.hasPermission("payroll.salary_slip") ||
          profileController.hasPermission("payroll.salary") || profileController.hasPermission("payroll.due") ||
          profileController.hasPermission("payroll.advance") || profileController.hasPermission("payroll.return_advance_payment") ||
          profileController.hasPermission("payroll.salary_statement") || profileController.hasPermission("payroll.payment_info"))

        SideMenuNestedItem(title: "payroll_management".tr, keyValue: "payroll_management", parent: true,
            icon: Images.payrollManagementSvgIcon, children: [

              if(profileController.hasPermission("payroll.payroll_start_up"))
                SideMenuChildItemWidget(title: 'payroll_start_up'.tr, keyValue: "payroll_start_up",
                    onTap: () => Get.toNamed(RouteHelper.getPayrollStartUpRoute())),

              if(profileController.hasPermission("payroll.payroll_mapping"))
                SideMenuChildItemWidget(title: 'payroll_mapping'.tr, keyValue: "payroll_mapping",
                    onTap: () => Get.toNamed(RouteHelper.getPayrollMappingRoute())),

              if(profileController.hasPermission("payroll.payroll_assign"))
                SideMenuChildItemWidget(title: 'payroll_assign'.tr,keyValue: "payroll_assign",
                    onTap: () => Get.toNamed(RouteHelper.getPayrollAssignRoute())),

              if(profileController.hasPermission("payroll.salary_slip"))
                SideMenuChildItemWidget(title: 'salary_slip'.tr, keyValue: "salary_slip",
                    onTap: () => Get.toNamed(RouteHelper.getSalarySlipRoute())),

              if(profileController.hasPermission("payroll.salary"))
                SideMenuChildItemWidget(title: 'salary'.tr, keyValue: "salary",
                    onTap: () => Get.toNamed(RouteHelper.getSalaryRoute())),

              if(profileController.hasPermission("payroll.due"))
                SideMenuChildItemWidget(title: 'due'.tr, keyValue: "due",
                    onTap: () => Get.toNamed(RouteHelper.getDueRoute())),

              if(profileController.hasPermission("payroll.advance"))
                SideMenuChildItemWidget(title: 'advance'.tr,keyValue: "advance",
                    onTap: () => Get.toNamed(RouteHelper.getAdvancedRoute())),

              // if(profileController.hasPermission("payroll.return_advance_payment"))
              //   SideMenuChildItemWidget(title: 'return_advance_payment'.tr, keyValue: "return_advance_payment",
              //       onTap: () => Get.toNamed(RouteHelper.getReturnedAdvancedRoute())),

              // if(profileController.hasPermission("payroll.salary_statement"))
              //   SideMenuChildItemWidget(title: 'salary_statement'.tr, keyValue: "salary_statement",
              //       onTap: () => Get.toNamed(RouteHelper.getSalaryStatementRoute())),
              //
              // if(profileController.hasPermission("payroll.payment_info"))
              //   SideMenuChildItemWidget(title: 'payment_info'.tr, keyValue: "payment_info",
              //       onTap: () => Get.toNamed(RouteHelper.getPaymentInfoRoute())),

            ]),





      if(profileController.hasPermission("fees_management.startup") || profileController.hasPermission("fees_management.mapping") ||
        profileController.hasPermission("fees_management.amount_config")|| profileController.hasPermission("fees_management.date_config")||
        profileController.hasPermission("fees_management.fine_waiver")|| profileController.hasPermission("fees_management.waiver") ||
        profileController.hasPermission("fees_management.waiver_config")|| profileController.hasPermission("fees_management.smart_collection") ||
        profileController.hasPermission("fees_management.paid_info") || profileController.hasPermission("fees_management.unpaid_info"))
    SideMenuNestedItem(sectionTitle: "finance_and_accounts".tr,
        title: "fees_management".tr, keyValue: "fees_management", parent: true,
        icon: Images.feesManagementSvgIcon, children: [

      if(profileController.hasPermission("fees_management.startup"))
    SideMenuChildItemWidget(title: 'fees_start_up'.tr, keyValue: "fees_start_up",
          onTap: () => Get.toNamed(RouteHelper.getFeesStartUpRoute()),),

        if(profileController.hasPermission("fees_management.mapping"))
    SideMenuChildItemWidget(title: 'fees_mapping'.tr,keyValue: "fees_mapping",
          onTap: () {

          Get.toNamed(RouteHelper.getFeesMappingRoute());
          }),

      if(profileController.hasPermission("fees_management.amount_config"))
    SideMenuChildItemWidget(title: 'amount_config'.tr,keyValue: "amount_config",
          onTap: () => Get.toNamed(RouteHelper.getFeesAmountConfigRoute())),

      if(profileController.hasPermission("fees_management.date_config"))
    SideMenuChildItemWidget(title: 'date_config'.tr,keyValue: "date_config",
          onTap: () => Get.toNamed(RouteHelper.getFeeDateConfigRoute())),


      if(profileController.hasPermission("fees_management.waiver"))
    SideMenuChildItemWidget(title: 'waiver'.tr, keyValue: "waiver",
          onTap: () => Get.toNamed(RouteHelper.getWaiverRoute())),

      if(profileController.hasPermission("fees_management.waiver_config"))
    SideMenuChildItemWidget(title: 'waiver_config'.tr,keyValue: "waiver_config",
          onTap: () => Get.toNamed(RouteHelper.getWaiverConfigRoute())),

      if(profileController.hasPermission("fees_management.smart_collection"))
    SideMenuChildItemWidget(title: 'smart_collection'.tr,keyValue: "smart_collection",
          onTap: () => Get.toNamed(RouteHelper.getSmartCollectionRoute())),

      if(profileController.hasPermission("fees_management.paid_info"))
    SideMenuChildItemWidget(title: 'paid_info'.tr, keyValue: "paid_info",
          onTap: () => Get.toNamed(RouteHelper.getPaidReportRoute())),

      if(profileController.hasPermission("fees_management.unpaid_info"))
    SideMenuChildItemWidget(title: 'unpaid_info'.tr,keyValue: "unpaid_info",
          onTap: () => Get.toNamed(RouteHelper.getUnpaidInfoRoute())),
      ]),



    if(profileController.hasPermission("accounting_management.ledgers") || profileController.hasPermission("accounting_management.funds") ||
        profileController.hasPermission("accounting_management.categories") || profileController.hasPermission("accounting_management.groups") ||
        profileController.hasPermission("accounting_management.payment") || profileController.hasPermission("accounting_management.receipt") ||
        profileController.hasPermission("accounting_management.contra") || profileController.hasPermission("accounting_management.journal") ||
        profileController.hasPermission("accounting_management.fund_transfer") || profileController.hasPermission("accounting_management.chart_of_accounts"))
    SideMenuNestedItem(title: "account_management".tr, keyValue: "account_management",
        parent: true, icon: Images.accountManagementSvgIcon,
        children: [

      if(profileController.hasPermission("accounting_management.ledgers"))
    SideMenuChildItemWidget(title: 'ledger'.tr, keyValue: "ledger",
          onTap: () => Get.toNamed(RouteHelper.getLedgerRoute())),

      if(profileController.hasPermission("accounting_management.funds"))
    SideMenuChildItemWidget(title: 'fund'.tr, keyValue: "fund",
          onTap: () => Get.toNamed(RouteHelper.getAccountingFundRoute())),

      if(profileController.hasPermission("accounting_management.categories"))
    SideMenuChildItemWidget(title: 'category'.tr, keyValue: "category",
          onTap: () => Get.toNamed(RouteHelper.getAccountingCategoryRoute())),

      if(profileController.hasPermission("accounting_management.groups"))
    SideMenuChildItemWidget(title: 'group'.tr, keyValue: "group",
          onTap: () => Get.toNamed(RouteHelper.getAccountingGroupRoute())),

      if(profileController.hasPermission("accounting_management.payment"))
    SideMenuChildItemWidget(title: 'payment'.tr,keyValue: "payment",
          onTap: () => Get.toNamed(RouteHelper.getPaymentRoute())),

      if(profileController.hasPermission("accounting_management.receipt"))
    SideMenuChildItemWidget(title: 'receipt'.tr,keyValue: "receipt",
          onTap: () => Get.toNamed(RouteHelper.getReceiptRoute())),


      if(profileController.hasPermission("accounting_management.contra"))
    SideMenuChildItemWidget(title: 'contra'.tr,keyValue: "contra",
          onTap: () => Get.toNamed(RouteHelper.getContraRoute())),

      if(profileController.hasPermission("accounting_management.journal"))
    SideMenuChildItemWidget(title: 'journal'.tr,keyValue: "journal",
          onTap: () => Get.toNamed(RouteHelper.getJournalRoute())),

      if(profileController.hasPermission("accounting_management.fund_transfer"))
    SideMenuChildItemWidget(title: 'fund_transfer'.tr,keyValue: "fund_transfer",
          onTap: () => Get.toNamed(RouteHelper.getFundTransferRoute())),

      if(profileController.hasPermission("accounting_management.chart_of_accounts"))
    SideMenuChildItemWidget(title: 'chart_of_account'.tr, keyValue: "chart_of_account",
          onTap: () => Get.toNamed(RouteHelper.getChartOfAccountRoute())),
      ]),

      // Reports Management Section
      if(profileController.hasPermission("accounting_report.balance_sheet"))
        SideMenuNestedItem(title: "accounting_reports_management".tr, keyValue: "accounting_reports_management", parent: true,
            icon: Images.accountReportSvgIcon, children: [
              SideMenuChildItemWidget(title: 'balance_sheet'.tr, keyValue: "balance_sheet",
                  onTap: () => Get.toNamed(RouteHelper.getBalanceSheetRoute())),

              SideMenuChildItemWidget(title: 'trail_balance'.tr, keyValue: "trail_balance",
                  onTap: () => Get.toNamed(RouteHelper.getTrailBalanceRoute())),

              SideMenuChildItemWidget(title: 'cash_flow'.tr, keyValue: "cash_flow",
                  onTap: () => Get.toNamed(RouteHelper.getCashFlowRoute())),

              SideMenuChildItemWidget(title: 'income_statement'.tr, keyValue: "income_statement",
                  onTap: () => Get.toNamed(RouteHelper.getIncomeStatementRoute())),

              SideMenuChildItemWidget(title: 'fund_wise_report'.tr, keyValue: "fund_wise_report",
                  onTap: () => Get.toNamed(RouteHelper.getFundWiseReportRoute())),

              SideMenuChildItemWidget(title: 'ledger_wise_report'.tr,keyValue: "ledger_wise_report",
                  onTap: () => Get.toNamed(RouteHelper.getLedgerWiseReportRoute())),

              SideMenuChildItemWidget(title: 'user_wise_report'.tr, keyValue: "user_wise_report",
                  onTap: () => Get.toNamed(RouteHelper.getUserWiseReportRoute())),

              SideMenuChildItemWidget(title: 'voucher_wise_report'.tr, keyValue: "voucher_wise_report",
                  onTap: () => Get.toNamed(RouteHelper.getVoucherWiseReportRoute())),

            ]),


    if(profileController.hasPermission("routine_management.admit_seat_plan") || profileController.hasPermission("routine_management.exam_routine") ||
        profileController.hasPermission("routine_management.class_routine") || profileController.hasPermission("routine_management.assignments") || profileController.hasPermission("routine_management.syllabuses"))
    SideMenuNestedItem(sectionTitle: "academic_and_learning".tr,
        title: "routine_management".tr, keyValue: "routine_management", parent: true,
        icon: Images.routineManagementSvgIcon, children: [

      if(profileController.hasPermission("routine_management.syllabuses"))
    SideMenuChildItemWidget(title: 'syllabus'.tr,keyValue: "syllabus",
          onTap: () => Get.toNamed(RouteHelper.getSyllabusRoute())),

      if(profileController.hasPermission("routine_management.assignments"))
    SideMenuChildItemWidget(title: 'assignments'.tr, keyValue: "assignments",
          onTap: () => Get.toNamed(RouteHelper.getAssignmentsRoute())),

      if(profileController.hasPermission("routine_management.class_routine"))
    SideMenuChildItemWidget(title: 'class_routine'.tr, keyValue: "class_routine",
          onTap: () => Get.toNamed(RouteHelper.getClassRoutineRoute())),

      if(profileController.hasPermission("routine_management.exam_routine"))
    SideMenuChildItemWidget(title: 'exam_routine'.tr, keyValue: "exam_routine",
          onTap: () => Get.toNamed(RouteHelper.getExamRoutineRoute())),

      if(profileController.hasPermission("routine_management.admit_seat_plan"))
    SideMenuChildItemWidget(title: 'admit_and_seat_plan'.tr, keyValue: "admit_and_seat_plan",
          onTap: () => Get.toNamed(RouteHelper.getAdmitAndSeatPlanRoute())),

      ]),


    if(profileController.hasPermission("library_management.book_category") || profileController.hasPermission("library_management.books") ||
        profileController.hasPermission("library_management.members") || profileController.hasPermission("library_management.book_issue_search") ||
        profileController.hasPermission("library_management.book_issue_report"))
    SideMenuNestedItem(title: "library_management".tr, keyValue: "library_management", parent: true,
        icon: Images.dashboardSvgIcon, children: [

      if(profileController.hasPermission("library_management.book_category"))
    SideMenuChildItemWidget(title: 'book_categories'.tr, keyValue: "book_categories",
          onTap: () => Get.toNamed(RouteHelper.getBookCategoriesRoute())),

      if(profileController.hasPermission("library_management.books"))
    SideMenuChildItemWidget(title: 'books'.tr, keyValue: "books",
          onTap: () => Get.toNamed(RouteHelper.getBooksRoute())),

      if(profileController.hasPermission("library_management.members"))
    SideMenuChildItemWidget(title: 'members'.tr, keyValue: "members",
          onTap: () => Get.toNamed(RouteHelper.getLibraryMemberRoute())),

      if(profileController.hasPermission("library_management.book_issue_search"))
    SideMenuChildItemWidget(title: 'books_issue'.tr, keyValue: "books_issue",
          onTap: () => Get.toNamed(RouteHelper.getBookIssueRoute())),

      if(profileController.hasPermission("library_management.book_issue_search"))
    SideMenuChildItemWidget(title: 'books_issue_search'.tr, keyValue: "books_issue_search",
          onTap: () => Get.toNamed(RouteHelper.getBookReturnRoute())),

      if(profileController.hasPermission("library_management.book_issue_report"))
    SideMenuChildItemWidget(title: 'books_issue_report'.tr, keyValue: "books_issue_report",
          onTap: () => Get.toNamed(RouteHelper.getBookIssueReportRoute())),

      ]),

    if(profileController.hasPermission("exam_module.exam_start_up") || profileController.hasPermission("exam_module.mark_config") ||
        profileController.hasPermission("exam_module.remarks_config") || profileController.hasPermission("exam_module.mark_input") ||
        profileController.hasPermission("exam_module.exam_result"))
    SideMenuNestedItem(title: "exm_management".tr, keyValue: "exm_management", parent: true,
        icon: Images.dashboardSvgIcon, children: [

          if(profileController.hasPermission("academic_configuration.exams"))
            SideMenuChildItemWidget(title: 'exam'.tr,keyValue: "exam",
                onTap: () => Get.toNamed(RouteHelper.getExamRoute())),

      if(profileController.hasPermission("exam_module.exam_start_up"))
    SideMenuChildItemWidget(title: 'exam_start_up'.tr,keyValue: "exam_start_up",
          onTap: () => Get.toNamed(RouteHelper.getExamStartUpRoute())),

      if(profileController.hasPermission("exam_module.mark_config"))
    SideMenuChildItemWidget(title: 'mark_config'.tr, keyValue: "mark_config",
          onTap: () => Get.toNamed(RouteHelper.getMarkConfigRoute())),

      if(profileController.hasPermission("exam_module.remarks_config"))
    SideMenuChildItemWidget(title: 'remark_config'.tr, keyValue: "remark_config",
          onTap: () => Get.toNamed(RouteHelper.getRemarkConfigRoute())),

      if(profileController.hasPermission("exam_module.mark_input"))
    SideMenuChildItemWidget(title: 'mark_input'.tr, keyValue: "mark_input",
          onTap: () => Get.toNamed(RouteHelper.getMarkInputRoute())),

          if(profileController.hasPermission("exam_module.exam_result"))
            SideMenuChildItemWidget(title: 'mark_sheet'.tr, keyValue: "mark_sheet",
                onTap: () => Get.toNamed(RouteHelper.getExamMarksheetRoute())),

      if(profileController.hasPermission("exam_module.exam_result"))
    SideMenuChildItemWidget(title: 'exam_result'.tr, keyValue: "exam_result",
          onTap: () => Get.toNamed(RouteHelper.getExamResultRoute())),
      ]),

    if(profileController.hasPermission("student_information.student_migration"))
    SideMenuNestedItem(title: "layout_and_certificate".tr, keyValue: "layout_and_certificate", parent: true,
        icon: Images.dashboardSvgIcon, children: [

          SideMenuChildItemWidget(title: 'general_recommendation_letter'.tr, keyValue: "general_recommendation_letter",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.recommendation))),

          SideMenuChildItemWidget(title: 'testimonial'.tr, keyValue: "testimonial",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.testimonial))),

          SideMenuChildItemWidget(title: 'attendance_certificate'.tr, keyValue: "attendance_certificate",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.attendanceCertificate))),

          SideMenuChildItemWidget(title: 'hsc_recommendation_letter'.tr,keyValue: "hsc_recommendation_letter",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.hscRecommendationLetter))),

          SideMenuChildItemWidget(title: 'abroad_letter'.tr, keyValue: "abroad_letter",
              onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.abroadLetter))),

          SideMenuChildItemWidget(title: 'transfer_certificate'.tr,keyValue: "transfer_certificate",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.transferCertificate))),
          SideMenuChildItemWidget(title: 'character_certificate'.tr,keyValue: "character_certificate",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.characterCertificate))),

          SideMenuChildItemWidget(title: 'study_certificate'.tr,keyValue: "study_certificate",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.studyCertificate))),

          SideMenuChildItemWidget(title: 'bonafide_certificate'.tr,keyValue: "bonafide_certificate",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.bonafideCertificate))),

          SideMenuChildItemWidget(title: 'migration_certificate'.tr, keyValue: "migration_certificate",
          onTap: () => Get.toNamed(RouteHelper.getCertificateRoute(CertificateTypeEnum.migrationCertificate))),

          SideMenuChildItemWidget(title: 'id_card'.tr,keyValue: "id_card",
          onTap: () => Get.toNamed(RouteHelper.getIdCardRoute())),
      ]),


    if(profileController.hasPermission("sms_notifications.templates") || profileController.hasPermission("sms_notifications.phonebook_category") ||
        profileController.hasPermission("sms_notifications.phonebook") || profileController.hasPermission("sms_notifications.sms_sent") ||
        profileController.hasPermission("sms_notifications.purchase_sms") || profileController.hasPermission("sms_notifications.sms_report"))
      SideMenuNestedItem(title: "sms_management".tr, keyValue: "sms_management", parent: true,
          icon: Images.dashboardSvgIcon, children: [


            if(profileController.hasPermission("sms_notifications.templates"))
              SideMenuChildItemWidget(title: 'sms_configuration'.tr,keyValue: "sms_configuration",
                onTap: () => Get.toNamed(RouteHelper.getSmsConfigRoute()),),

      if(profileController.hasPermission("sms_notifications.templates"))
        SideMenuChildItemWidget(title: 'sms_template'.tr,keyValue: "sms_template",
          onTap: () => Get.toNamed(RouteHelper.getSmsTemplateRoute()),),

      if(profileController.hasPermission("sms_notifications.phonebook_category"))
        SideMenuChildItemWidget(title: 'phone_book_category'.tr,keyValue: "phone_book_category",
          onTap: () => Get.toNamed(RouteHelper.getPhoneBookCategoryRoute())),

      if(profileController.hasPermission("sms_notifications.phonebook"))
        SideMenuChildItemWidget(title: 'phone_book'.tr,keyValue: "phone_book",
          onTap: () => Get.toNamed(RouteHelper.getPhoneBookRoute())),

      if(profileController.hasPermission("sms_notifications.sent_sms"))
      SideMenuChildItemWidget(title: 'sms_sent'.tr, keyValue: "sms_sent",
          onTap: () => Get.toNamed(RouteHelper.getSmsSentRoute())),

      if(profileController.hasPermission("sms_notifications.sent_sms"))
        SideMenuChildItemWidget(title: 'absent_sms'.tr, keyValue: "absent_sms",
            onTap: () => Get.toNamed(RouteHelper.getAbsentSmsRoute())),

      if(profileController.hasPermission("sms_notifications.purchase_sms"))
      SideMenuChildItemWidget(title: 'purchase_sms'.tr,keyValue: "purchase_sms",
          onTap: () => Get.toNamed(RouteHelper.getPurchaseSmsRoute())),

      if(profileController.hasPermission("sms_notifications.sms_report"))
      SideMenuChildItemWidget(title: 'sms_report'.tr, keyValue: "sms_report",
          onTap: () => Get.toNamed(RouteHelper.getSmsReportRoute())),
      ]),


    if(profileController.hasPermission("administrator.assign_shift") || profileController.hasPermission("administrator.assign_subject") ||
        profileController.hasPermission("administrator.assign_class") || profileController.hasPermission("administrator.notice") ||
        profileController.hasPermission("administrator.event") || profileController.hasPermission("administrator.contact_message") ||
        profileController.hasPermission("administrator.user_activities"))
    SideMenuNestedItem(title: "administrator".tr, keyValue: "administrator", parent: true,
        icon: Images.dashboardSvgIcon, children: [


      if(profileController.hasPermission("administrator.notice"))
      SideMenuChildItemWidget(title: 'notice'.tr,keyValue: "notice",
          onTap: () => Get.toNamed(RouteHelper.getNoticeRoute())),

      if(profileController.hasPermission("administrator.event"))
      SideMenuChildItemWidget(title: 'event'.tr,keyValue: "event",
          onTap: () => Get.toNamed(RouteHelper.getEventRoute())),

      if(profileController.hasPermission("administrator.user_activities"))
      SideMenuChildItemWidget(title: 'user_activities'.tr,keyValue: "user_activities",
          onTap: () => Get.toNamed(RouteHelper.getUserActivitiesRoute())),
      ]),


      SideMenuNestedItem(title: "question_bank".tr, keyValue: "question_bank", parent: true,
          icon: Images.dashboardSvgIcon, children: [
        SideMenuChildItemWidget(title: 'question_category'.tr, keyValue: "question_category",
            onTap: () => Get.toNamed(RouteHelper.getQuestionCategoryRoute())),

        SideMenuChildItemWidget(title: 'add_new_question'.tr, keyValue: "add_new_question",
            onTap: () => Get.toNamed(RouteHelper.getAddNewQuestionRoute())),

        SideMenuChildItemWidget(title: 'question'.tr, keyValue: "question",
            onTap: () => Get.toNamed(RouteHelper.getQuestionRoute("question"))),

        SideMenuChildItemWidget(title: 'class'.tr, keyValue: "class",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankClassRoute())),

        SideMenuChildItemWidget(title: 'group'.tr, keyValue: "group",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankGroupRoute())),

        SideMenuChildItemWidget(title: 'subject'.tr, keyValue: "subject",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankSubjectRoute())),

        SideMenuChildItemWidget(title: 'chapter'.tr,keyValue: "chapter",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankChapterRoute())),

        SideMenuChildItemWidget(title: 'types'.tr, keyValue: "types",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankTypesRoute())),

        SideMenuChildItemWidget(title: 'level'.tr, keyValue: "level",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankLevelRoute())),

        SideMenuChildItemWidget(title: 'topics'.tr, keyValue: "topics",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankTopicRoute())),

        SideMenuChildItemWidget(title: 'sources'.tr, keyValue: "sources",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankSourcesRoute())),

        SideMenuChildItemWidget(title: 'sub_sources'.tr, keyValue: "sub_sources",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankSubSourcesRoute())),

        SideMenuChildItemWidget(title: 'year'.tr, keyValue: "year",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankYearRoute())),

        SideMenuChildItemWidget(title: 'board'.tr, keyValue: "board",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankBoardRoute())),

        SideMenuChildItemWidget(title: 'tag'.tr, keyValue: "tag",
            onTap: () => Get.toNamed(RouteHelper.getQuestionBankTagRoute())),

            SideMenuChildItemWidget(title: 'question_paper'.tr, keyValue: "question_paper",
                onTap: () => Get.toNamed(RouteHelper.getQuestionRoute("quiz",courseId : "quiz", ))),


          ]),


      // SideMenuNestedItem(title: "course_management".tr, keyValue: "course_management", parent: true,
      //     icon: Images.dashboardSvgIcon, children: [
      //
      //   SideMenuChildItemWidget(title: 'course_category'.tr, keyValue: "course_category",
      //       onTap: () => Get.toNamed(RouteHelper.getCourseCategoryRoute())),
      //
      //
      //   SideMenuChildItemWidget(title: 'course'.tr, keyValue: "course",
      //       onTap: () => Get.toNamed(RouteHelper.getCourseRoute())),
      //
      //   SideMenuChildItemWidget(title: 'add_new_course'.tr, keyValue: "add_new_course",
      //       onTap: () => Get.toNamed(RouteHelper.getAddNewCourseRoute())),
      //
      // ]),





      //Fees Reports Management
      if(profileController.hasPermission("fees_management.startup"))
      SideMenuNestedItem(title: "fees_reports_management".tr, keyValue: "fees_reports_management", parent: true,
          icon: Images.dashboardSvgIcon, children: [
        SideMenuChildItemWidget(title: 'fee_monthly_report'.tr, keyValue: "fee_monthly_report",
          onTap: () => Get.toNamed(RouteHelper.getFeesMonthlyPaymentInfoRoute())),

        SideMenuChildItemWidget(title: 'payment_info'.tr, keyValue: "payment_info",
            onTap: () => Get.toNamed(RouteHelper.getFeesReportPaymentInfoRoute())),

        SideMenuChildItemWidget(title: 'head_wise_info'.tr, keyValue: "head_wise_info",
            onTap: () => Get.toNamed(RouteHelper.getHeadWiseFeesInfoReportRoute())),

        SideMenuChildItemWidget(title: 'unpaid_info'.tr, keyValue: "unpaid_info",
            onTap: () => Get.toNamed(RouteHelper.getUnpaidFeesInfoReportRoute())),

        SideMenuChildItemWidget(title: 'online_fee_payments'.tr, keyValue: "online_fee_payments",
            onTap: () => Get.toNamed(RouteHelper.getOnlineFeePaymentsRoute())),

        SideMenuChildItemWidget(title: 'payment_ratio_info'.tr, keyValue: "payment_ratio_info",
            onTap: () => Get.toNamed(RouteHelper.getFeesPaymentRatioInfoReportRoute())),

      ]),






      if(profileController.hasPermission("master_configuration.system_settings"))
        SideMenuNestedItem(title: "master_configuration".tr, keyValue: "master_configuration", parent: true,
            icon: Images.dashboardSvgIcon, children: [

              if(profileController.hasPermission("master_configuration.system_settings"))
                SideMenuChildItemWidget(title: 'system_settings'.tr, keyValue: "system_settings",
                    onTap: () => Get.toNamed(RouteHelper.getSystemSettingsRoute())),

        if(profileController.hasPermission("master_configuration.system_settings"))
        SideMenuChildItemWidget(title: 'payment_gateway'.tr, keyValue: "payment_gateway",
          onTap: () => Get.toNamed(RouteHelper.getPaymentGatewayRoute())),

        if(profileController.hasPermission("master_configuration.system_settings"))
        SideMenuChildItemWidget(title: 'curriculum'.tr, keyValue: "curriculum",
          onTap: () => Get.toNamed(RouteHelper.getCurriculumRoute())),


          if(profileController.hasPermission("master_configuration.roles"))
            SideMenuChildItemWidget(title: 'role'.tr, keyValue: "role",
                onTap: () => Get.toNamed(RouteHelper.getRolesRoute())),

              if(profileController.hasPermission("master_configuration.users"))
                SideMenuChildItemWidget(title: 'employee'.tr, keyValue: "employee",
                    onTap: () => Get.toNamed(RouteHelper.getEmployeeRoute())),

              if(profileController.hasPermission("master_configuration.client_licenses"))
                SideMenuChildItemWidget(title: 'client_licenses'.tr, keyValue: "client_licenses",
                    onTap: () => Get.toNamed(RouteHelper.getClientLicenseRoute())),



      if(profileController.hasPermission("database_backup"))
      SideMenuChildItemWidget(title: 'database_backup'.tr, keyValue: "database_backup", onTap: () {
        Get.dialog(ConfirmationDialog(backup: true, title: "backup", content: "backup", onTap: (){
          Get.back();
          Get.dialog(barrierDismissible: false, const DataSyncWidget());
          Future.delayed(const Duration(seconds: 10), () {
            if (Navigator.canPop(Get.context!)) {
              Navigator.of(Get.context!).pop();
              showCustomSnackBar("data_backup_successfully".tr, isError: false);
            }});
          },));
          }),
      ]),

    if(profileController.hasPermission("zoom-index"))
      SideMenuNestedItem(title: "zoom_meeting".tr, keyValue: "zoom_meeting", parent: true,
          icon: Images.dashboardSvgIcon, children: [

        SideMenuChildItemWidget(title: 'zoom_config'.tr, keyValue: "zoom_config",
            onTap: () => Get.toNamed(RouteHelper.getZoomConfigRoute())),

        SideMenuChildItemWidget(title: 'zoom_meeting'.tr, keyValue: "zoom_meeting",
            onTap: () => Get.toNamed(RouteHelper.getZoomMeetingRoute())),
      ]),




      if(profileController.hasPermission("master_configuration.branches"))
    SideMenuNestedItem(title: "cms_management".tr, keyValue: "cms_management", parent: true,
        icon: Images.dashboardSvgIcon, children: [

      SideMenuChildItemWidget(title: 'about_us'.tr, keyValue: "about_us",
          onTap: () => Get.toNamed(RouteHelper.getAboutUsRoute())),

      SideMenuChildItemWidget(title: 'banner'.tr, keyValue: "banner",
          onTap: () => Get.toNamed(RouteHelper.getBannerRoute())),

      SideMenuChildItemWidget(title: 'why_choose_us'.tr, keyValue: "why_choose_us",
          onTap: () => Get.toNamed(RouteHelper.getWhyChooseUsRoute())),

      SideMenuChildItemWidget(title: 'mobile_app_section'.tr, keyValue: "mobile_app_section",
          onTap: () => Get.toNamed(RouteHelper.getMobileAppSectionRoute())),

      SideMenuChildItemWidget(title: 'ready_to_join'.tr, keyValue: "ready_to_join",
          onTap: () => Get.toNamed(RouteHelper.getReadyToJoinRoute())),


      SideMenuChildItemWidget(title: 'faq'.tr, keyValue: "faq",
          onTap: () => Get.toNamed(RouteHelper.getFaqRoute())),

      SideMenuChildItemWidget(title: 'feedback'.tr, keyValue: "feedback",
          onTap: () => Get.toNamed(RouteHelper.getFeedbackRoute())),

          SideMenuChildItemWidget(title: 'gallery'.tr, keyValue: "gallery",
          onTap: () => Get.toNamed(RouteHelper.getAcademicImageRoute())),

      SideMenuChildItemWidget(title: 'theme'.tr, keyValue: "theme",
          onTap: () => Get.toNamed(RouteHelper.getThemeRoute())),

    ]),


      // Hostel Management Section
      if(profileController.hasPermission("hostel_panel"))
      SideMenuNestedItem(title: "hostel_management".tr, keyValue: "hostel_management", parent: true,
          icon: Images.dashboardSvgIcon, children: [

          SideMenuChildItemWidget(title: 'hostels'.tr, keyValue: "hostels",
            onTap: () => Get.toNamed(RouteHelper.getHostelsRoute())),

          SideMenuChildItemWidget(title: 'hostel_categories'.tr, keyValue: "hostel_categories",
            onTap: () => Get.toNamed(RouteHelper.getHostelCategoriesRoute())),

          SideMenuChildItemWidget(title: 'hostel_rooms'.tr, keyValue: "hostel_rooms",
            onTap: () => Get.toNamed(RouteHelper.getHostelRoomsRoute())),

          SideMenuChildItemWidget(title: 'hostel_members'.tr, keyValue: "hostel_members",
            onTap: () => Get.toNamed(RouteHelper.getHostelMembersRoute())),

          SideMenuChildItemWidget(title: 'hostel_meals'.tr,keyValue: "hostel_meals",
            onTap: () => Get.toNamed(RouteHelper.getHostelMealsRoute())),

          SideMenuChildItemWidget(title: 'hostel_meal_plan'.tr, keyValue: "hostel_meal_plan",
            onTap: () => Get.toNamed(RouteHelper.getHostelMealPlanRoute())),

          SideMenuChildItemWidget(title: 'hostel_meal_entries'.tr, keyValue: "hostel_meal_entries",
            onTap: () => Get.toNamed(RouteHelper.getHostelMealEntriesRoute())),

          SideMenuChildItemWidget(title: 'hostel_bills'.tr, keyValue: "hostel_bills",
            onTap: () => Get.toNamed(RouteHelper.getHostelBillsRoute())),

      ]),


      // Transportation Management Section
      if(profileController.hasPermission("transport_panel_off") )
      SideMenuNestedItem(title: "transportation_management".tr, keyValue: "transportation_management", parent: true,
          icon: Images.dashboardSvgIcon, children: [

          SideMenuChildItemWidget(title: 'transport_buses'.tr, keyValue: "transport_buses",
            onTap: () => Get.toNamed(RouteHelper.getTransportBusesRoute())),

          SideMenuChildItemWidget(title: 'transport_drivers'.tr, keyValue: "transport_drivers",
            onTap: () => Get.toNamed(RouteHelper.getTransportDriversRoute())),

          SideMenuChildItemWidget(title: 'bus_routes'.tr, keyValue: "bus_routes",
            onTap: () => Get.toNamed(RouteHelper.getBusRoutesRoute())),

          SideMenuChildItemWidget(title: 'bus_stops'.tr, keyValue: "bus_stops",
            onTap: () => Get.toNamed(RouteHelper.getBusStopsRoute())),

          SideMenuChildItemWidget(title: 'transport_members'.tr, keyValue: "transport_members",
            onTap: () => Get.toNamed(RouteHelper.getTransportMembersRoute())),

      ]),


      if(profileController.hasPermission("master_configuration.branches"))
        SideMenuNestedItem(title: "AI".tr, keyValue: "AI", parent: true,
            icon: Images.dashboardSvgIcon, children:   [
          SideMenuChildItemWidget(title: 'chatgpt'.tr, keyValue: "",
              onTap: () => Get.toNamed(RouteHelper.getChatGptRoute())),
            ]),

      // Inventory Management Section
      if(profileController.hasPermission("inventory_panel_off"))
      SideMenuNestedItem(title: "inventory_management".tr, keyValue: "inventory_management", parent: true,
          icon: Images.dashboardSvgIcon, children: [

        SideMenuChildItemWidget(title: 'inventory_items'.tr, keyValue: "inventory_items",
          onTap: () => Get.toNamed(RouteHelper.getInventoryItemsRoute())),

        SideMenuChildItemWidget(title: 'inventory_categories'.tr, keyValue: "inventory_categories",
          onTap: () => Get.toNamed(RouteHelper.getInventoryCategoriesRoute())),

        SideMenuChildItemWidget(title: 'inventory_suppliers'.tr, keyValue: "inventory_suppliers",
          onTap: () => Get.toNamed(RouteHelper.getInventorySuppliersRoute())),

        SideMenuChildItemWidget(title: 'inventory_stock'.tr, keyValue: "inventory_stock",
          onTap: () => Get.toNamed(RouteHelper.getInventoryStockRoute())),

        SideMenuChildItemWidget(title: 'inventory_transactions'.tr, keyValue: "inventory_transactions",
          onTap: () => Get.toNamed(RouteHelper.getInventoryTransactionsRoute())),
      ]),

      // Supplier Management Section
      if(profileController.hasPermission("supplier_panel_off"))
      SideMenuNestedItem(title: "supplier_management".tr, keyValue: "supplier_management", parent: true,
          icon: Images.dashboardSvgIcon, children: [

        SideMenuChildItemWidget(title: 'supplier_list'.tr, keyValue: "supplier_list",
          onTap: () => Get.toNamed(RouteHelper.getSupplierListRoute())),

        SideMenuChildItemWidget(title: 'add_supplier'.tr, keyValue: "add_supplier",
          onTap: () => Get.toNamed(RouteHelper.getAddSupplierRoute())),

        SideMenuChildItemWidget(title: 'supplier_payments'.tr, keyValue: "supplier_payments",
          onTap: () => Get.toNamed(RouteHelper.getSupplierPaymentsRoute())),

        SideMenuChildItemWidget(title: 'supplier_ledger'.tr, keyValue: "supplier_ledger",
          onTap: () => Get.toNamed(RouteHelper.getSupplierLedgerRoute())),
      ]),

      // Reports Management Section
      if(profileController.hasPermission("reports_panel_off"))
      SideMenuNestedItem(title: "reports_management".tr, keyValue: "reports_management", parent: true,
          icon: Images.dashboardSvgIcon, children: [

        // Student Reports
        SideMenuChildItemWidget(title: 'student_attendance_report'.tr, keyValue: "student_attendance_report",
          onTap: () => Get.toNamed(RouteHelper.getStudentAttendanceReportRoute())),

        SideMenuChildItemWidget(title: 'student_fee_report'.tr, keyValue: "student_fee_report",
          onTap: () => Get.toNamed(RouteHelper.getStudentFeeReportRoute())),

        SideMenuChildItemWidget(title: 'student_performance_report'.tr, keyValue: "student_performance_report",
          onTap: () => Get.toNamed(RouteHelper.getStudentPerformanceReport())),

        // Academic Reports
        SideMenuChildItemWidget(title: 'exam_result_report'.tr, keyValue: "exam_result_report",
          onTap: () => Get.toNamed(RouteHelper.getExamResultReportRoute())),

        SideMenuChildItemWidget(title: 'class_wise_report'.tr, keyValue: "class_wise_report",
          onTap: () => Get.toNamed(RouteHelper.getClassWiseReportRoute())),

        // Financial Reports
        SideMenuChildItemWidget(title: 'fee_collection_report'.tr, keyValue: "fee_collection_report",
          onTap: () => Get.toNamed(RouteHelper.getFeeCollectionReportRoute())),

        SideMenuChildItemWidget(title: 'expense_report'.tr, keyValue: "expense_report",
          onTap: () => Get.toNamed(RouteHelper.getExpenseReportRoute())),

        SideMenuChildItemWidget(title: 'income_report'.tr, keyValue: "income_report",
          onTap: () => Get.toNamed(RouteHelper.getIncomeReportRoute())),

        SideMenuChildItemWidget(title: 'balance_sheet_report'.tr, keyValue: "balance_sheet_report",
          onTap: () => Get.toNamed(RouteHelper.getBalanceSheetRoute())),

        // Library Reports
        SideMenuChildItemWidget(title: 'library_book_report'.tr, keyValue: "library_book_report",
          onTap: () => Get.toNamed(RouteHelper.getLibraryBookReportRoute())),

        SideMenuChildItemWidget(title: 'library_issue_report'.tr, keyValue: "library_issue_report",
          onTap: () => Get.toNamed(RouteHelper.getLibraryIssueReportRoute())),

        // Transport Reports
        SideMenuChildItemWidget(title: 'transport_route_report'.tr, keyValue: "transport_route_report",
          onTap: () => Get.toNamed(RouteHelper.getTransportRouteReportRoute())),

        SideMenuChildItemWidget(title: 'transport_vehicle_report'.tr, keyValue: "transport_vehicle_report",
          onTap: () => Get.toNamed(RouteHelper.getTransportVehicleReportRoute())),

        // Inventory Reports
        SideMenuChildItemWidget(title: 'inventory_stock_report'.tr, keyValue: "inventory_stock_report",
          onTap: () => Get.toNamed(RouteHelper.getInventoryStockReportRoute())),

        SideMenuChildItemWidget(title: 'inventory_transaction_report'.tr, keyValue: "inventory_transaction_report",
          onTap: () => Get.toNamed(RouteHelper.getInventoryTransactionReportRoute())),

        // Supplier Reports
        SideMenuChildItemWidget(title: 'supplier_report'.tr, keyValue: "supplier_report",
          onTap: () => Get.toNamed(RouteHelper.getSupplierReportRoute())),

        SideMenuChildItemWidget(title: 'supplier_payment_report'.tr, keyValue: "supplier_payment_report",
          onTap: () => Get.toNamed(RouteHelper.getSupplierPaymentReportRoute())),
      ]),
    ];}



  List<dynamic> _buildParentSideMenuItems() {
    return  [
      SideMenuNestedItem(title: 'dashboard'.tr, keyValue: "dashboard", parent: true,
          icon: Images.dashboardSvgIcon,
            onTap: () => Get.toNamed(RouteHelper.getDashboardRoute())),

      SideMenuNestedItem(title: 'routine'.tr, keyValue: "routine", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentClassRoutineRoute())),

      SideMenuNestedItem(title: 'fees'.tr, keyValue: "fees", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentFeesRoute())),


      SideMenuNestedItem(title: 'pay_school_fees'.tr, keyValue: "pay_school_fees",
          parent: true,
          icon: Images.feesManagementSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getPayFeesRoute())),


      SideMenuNestedItem(title: 'library'.tr, keyValue: "library", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentLibraryRoute())),

      SideMenuNestedItem(title: 'assignment'.tr, keyValue: "assignment", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentAssignmentRoute())),

      SideMenuNestedItem(title: 'behavior'.tr, keyValue: "behavior", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentBehaviourRoute())),

      SideMenuNestedItem(title: 'notice'.tr, keyValue: "notice", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentNoticeRoute())),

      SideMenuNestedItem(title: 'event'.tr, keyValue: "event", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentEventRoute())),

      SideMenuNestedItem(title: 'exams'.tr, keyValue: "exams", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentExamRoute())),

    ];}

  List<dynamic> _buildStudentSideMenuItems() {
    return  [
      SideMenuNestedItem(title: 'dashboard'.tr, keyValue: "dashboard", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getDashboardRoute())),

      SideMenuNestedItem(title: 'routine'.tr, keyValue: "routine", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getStudentClassRoutineRoute())),

      SideMenuNestedItem(title: 'fees'.tr, keyValue: "fees", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentFeesRoute())),

      SideMenuNestedItem(title: 'pay_school_fees'.tr, keyValue: "pay_school_fees", parent: true,
          icon: Images.feesManagementSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getPayFeesRoute())),

      SideMenuNestedItem(title: 'library'.tr, keyValue: "library", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getStudentLibraryRoute())),

      SideMenuNestedItem(title: 'assignment'.tr, keyValue: "assignment", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getStudentAssignmentRoute())),

      SideMenuNestedItem(title: 'behavior'.tr, keyValue: "behavior", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentBehaviourRoute())),

      SideMenuNestedItem(title: 'notice'.tr, keyValue: "notice", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getStudentNoticeRoute())),

      SideMenuNestedItem(title: 'event'.tr, keyValue: "event", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getParentEventRoute())),


      SideMenuNestedItem(title: 'profile'.tr, keyValue: "profile", parent: true,
          icon: Images.dashboardSvgIcon,
          onTap: () => Get.toNamed(RouteHelper.getStudentProfileRoute())),
    ];}

  List<dynamic> _buildInitSideMenuItems() {
    return  [
    ];}

}
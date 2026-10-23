import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/helper/route_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class _QuickAction {
  final String label;
  final String subtitle;
  final IconData icon;
  final String route;
  final String? permission;

  const _QuickAction(this.label, this.subtitle, this.icon, this.route, {this.permission});
}

class QuickAccessWidget extends StatelessWidget {
  const QuickAccessWidget({super.key});

  static const List<Color> _accents = [
    AppColors.secondary,
    AppColors.accent,
    AppColors.warning,
    Color(0xFF8B5CF6),
    Color(0xFF0EA5E9),
    AppColors.error,
    Color(0xFF14B8A6),
    AppColors.secondaryLight,
  ];

  static const List<_QuickAction> _admin = [
    _QuickAction('Add student', 'New admission', Icons.person_add_alt_1_rounded,
        RouteHelper.addNewStudent, permission: 'student_information.student_index'),
    _QuickAction('Collect fees', 'M-Pesa & cash', Icons.point_of_sale_rounded,
        RouteHelper.smartCollection, permission: 'fees_management.smart_collection'),
    _QuickAction('Attendance', 'Daily register', Icons.fact_check_rounded,
        RouteHelper.studentAttendance, permission: 'student_attendance.student_attendance_create'),
    _QuickAction('Exams', 'Marks & results', Icons.assignment_rounded,
        RouteHelper.markInput, permission: 'exam_module.mark_input'),
    _QuickAction('Payroll', 'Salaries', Icons.payments_rounded,
        RouteHelper.salary, permission: 'payroll.salary'),
    _QuickAction('Library', 'Books & issues', Icons.local_library_rounded,
        RouteHelper.books, permission: 'library_management.books'),
    _QuickAction('Notices', 'Broadcast news', Icons.campaign_rounded,
        RouteHelper.notice, permission: 'administrator.notice'),
    _QuickAction('Settings', 'School setup', Icons.settings_suggest_rounded,
        RouteHelper.systemSettings, permission: 'master_configuration.system_settings'),
  ];

  static const List<_QuickAction> _accountant = [
    _QuickAction('Collect fees', 'M-Pesa & cash', Icons.point_of_sale_rounded, RouteHelper.smartCollection),
    _QuickAction('Paid fees', 'Receipts', Icons.receipt_long_rounded, RouteHelper.paidReport),
    _QuickAction('Unpaid fees', 'Follow-ups', Icons.pending_actions_rounded, RouteHelper.unpaidInfo),
    _QuickAction('Fee reports', 'Collections', Icons.insert_chart_rounded, RouteHelper.feesReports),
    _QuickAction('Payments', 'Post entries', Icons.account_balance_wallet_rounded, RouteHelper.payment),
    _QuickAction('Students', 'Learner list', Icons.groups_rounded, RouteHelper.studentList),
  ];

  static const List<_QuickAction> _teacher = [
    _QuickAction('Attendance', 'Daily register', Icons.fact_check_rounded, RouteHelper.studentAttendance),
    _QuickAction('Mark input', 'Enter scores', Icons.edit_note_rounded, RouteHelper.markInput),
    _QuickAction('Assignments', 'Homework', Icons.assignment_rounded, RouteHelper.assignments),
    _QuickAction('Class routine', 'Timetable', Icons.calendar_month_rounded, RouteHelper.classRoutine),
    _QuickAction('Results', 'Exam results', Icons.assessment_rounded, RouteHelper.examResult),
    _QuickAction('Syllabus', 'Coverage', Icons.menu_book_rounded, RouteHelper.syllabus),
    _QuickAction('Notices', 'Share updates', Icons.campaign_rounded, RouteHelper.notice),
    _QuickAction('Students', 'Learner list', Icons.groups_rounded, RouteHelper.studentList),
  ];

  static const List<_QuickAction> _librarian = [
    _QuickAction('Books', 'Catalogue', Icons.local_library_rounded, RouteHelper.books),
    _QuickAction('Issue book', 'Lend copies', Icons.book_rounded, RouteHelper.bookIssue),
    _QuickAction('Return book', 'Check in', Icons.assignment_return_rounded, RouteHelper.bookReturn),
    _QuickAction('Members', 'Borrowers', Icons.people_alt_rounded, RouteHelper.libraryMember),
    _QuickAction('Categories', 'Shelves', Icons.category_rounded, RouteHelper.bookCategories),
    _QuickAction('Issue report', 'History', Icons.receipt_long_rounded, RouteHelper.bookIssueReport),
  ];

  static const List<_QuickAction> _hostel = [
    _QuickAction('Hostels', 'Boarding', Icons.hotel_rounded, RouteHelper.hostels),
    _QuickAction('Rooms', 'Beds', Icons.meeting_room_rounded, RouteHelper.hostelRooms),
    _QuickAction('Members', 'Boarders', Icons.people_alt_rounded, RouteHelper.hostelMembers),
    _QuickAction('Meals', 'Menu', Icons.restaurant_rounded, RouteHelper.hostelMeals),
    _QuickAction('Meal plan', 'Schedule', Icons.event_note_rounded, RouteHelper.hostelMealPlan),
    _QuickAction('Bills', 'Boarding fees', Icons.request_quote_rounded, RouteHelper.hostelBills),
  ];

  static const List<_QuickAction> _transport = [
    _QuickAction('Buses', 'Fleet', Icons.directions_bus_rounded, RouteHelper.transportBuses),
    _QuickAction('Drivers', 'Staff', Icons.badge_rounded, RouteHelper.transportDrivers),
    _QuickAction('Bus routes', 'Stops', Icons.alt_route_rounded, RouteHelper.busRoutes),
    _QuickAction('Bus stops', 'Pickups', Icons.place_rounded, RouteHelper.busStops),
    _QuickAction('Members', 'Riders', Icons.people_alt_rounded, RouteHelper.transportMembers),
  ];

  static const List<_QuickAction> _parent = [
    _QuickAction('Pay fees', 'M-Pesa & card', Icons.payments_rounded, RouteHelper.payFees),
    _QuickAction('Fee statement', 'Balances', Icons.receipt_long_rounded, RouteHelper.parentFees),
    _QuickAction('Behaviour', 'Conduct notes', Icons.psychology_rounded, RouteHelper.parentBehaviour),
    _QuickAction('Class routine', 'Timetable', Icons.calendar_month_rounded, RouteHelper.parentClassRoutine),
    _QuickAction('Assignments', 'Homework', Icons.assignment_rounded, RouteHelper.parentAssignment),
    _QuickAction('Exam results', 'Report cards', Icons.assessment_rounded, RouteHelper.parentExam),
    _QuickAction('Library', 'Borrowed books', Icons.local_library_rounded, RouteHelper.parentLibrary),
    _QuickAction('Notices', 'School news', Icons.campaign_rounded, RouteHelper.parentNotice),
  ];

  static const List<_QuickAction> _student = [
    _QuickAction('Pay fees', 'M-Pesa & card', Icons.payments_rounded, RouteHelper.payFees),
    _QuickAction('My fees', 'Balances', Icons.receipt_long_rounded, RouteHelper.parentFees),
    _QuickAction('Class routine', 'Timetable', Icons.calendar_month_rounded, RouteHelper.studentClassRoutine),
    _QuickAction('Assignments', 'Homework', Icons.assignment_rounded, RouteHelper.studentAssignment),
    _QuickAction('Subjects', 'My subjects', Icons.menu_book_rounded, RouteHelper.studentSubject),
    _QuickAction('Library', 'Borrowed books', Icons.local_library_rounded, RouteHelper.studentLibrary),
    _QuickAction('Notices', 'School news', Icons.campaign_rounded, RouteHelper.studentNotice),
    _QuickAction('Behaviour', 'Conduct notes', Icons.psychology_rounded, RouteHelper.studentBehaviour),
    _QuickAction('Profile', 'My details', Icons.person_rounded, RouteHelper.studentProfile),
  ];

  static const List<_QuickAction> _saas = [
    _QuickAction('Subscription', 'Plans & billing', Icons.workspace_premium_rounded, RouteHelper.subscription),
    _QuickAction('Client licenses', 'Issued keys', Icons.vpn_key_rounded, RouteHelper.clientLicense),
    _QuickAction('Users', 'Accounts', Icons.people_alt_rounded, RouteHelper.employee),
    _QuickAction('Roles', 'Permissions', Icons.admin_panel_settings_rounded, RouteHelper.roles),
    _QuickAction('Settings', 'Platform setup', Icons.settings_suggest_rounded, RouteHelper.systemSettings),
    _QuickAction('Notices', 'Announcements', Icons.campaign_rounded, RouteHelper.notice),
  ];

  List<_QuickAction> _actionsFor(String role, ProfileController controller) {
    switch (role) {
      case 'Parent':
        return _parent;
      case 'Student':
        return _student;
      case 'Teacher':
        return _teacher;
      case 'Librarian':
        return _librarian;
      case 'Hostel':
        return _hostel;
      case 'Transport':
        return _transport;
      case 'Accountant':
        return _accountant;
      case 'SAAS Admin':
        return _saas;
      default:
        return _permittedAdmin(controller);
    }
  }

  List<_QuickAction> _permittedAdmin(ProfileController controller) {
    final permissions = controller.profileModel?.data?.permissions;
    if (permissions == null || permissions.isEmpty) return _admin;
    final allowed = _admin
        .where((action) => action.permission == null || permissions.contains(action.permission))
        .toList();
    return allowed.isEmpty ? _admin.take(4).toList() : allowed;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileController>(builder: (profileController) {
      final actions = _actionsFor(profileController.userType(), profileController);
      if (actions.isEmpty) return const SizedBox.shrink();

      return LayoutBuilder(builder: (context, constraints) {
        final width = constraints.maxWidth.isFinite ? constraints.maxWidth : 900.0;
        final columns = width >= 1100 ? 4 : (width >= 760 ? 3 : 2);
        const gap = 12.0;
        final tileWidth = (width - gap * (columns - 1)) / columns;

        return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Text('Quick Access', style: textBold.copyWith(fontSize: Dimensions.fontSizeLarge)),
            const Spacer(),
            Text('${actions.length} shortcuts',
                style: textRegular.copyWith(
                    fontSize: Dimensions.fontSizeSmall, color: AppColors.textTertiaryColor)),
          ]),
          const SizedBox(height: 2),
          Text('One-tap shortcuts for your role.',
              style: textRegular.copyWith(
                  fontSize: Dimensions.fontSizeSmall, color: AppColors.textTertiaryColor)),
          const SizedBox(height: 14),
          Wrap(
            spacing: gap,
            runSpacing: gap,
            children: [
              for (int i = 0; i < actions.length; i++)
                SizedBox(
                  width: tileWidth,
                  child: _QuickAccessTile(
                    action: actions[i],
                    accent: _accents[i % _accents.length],
                  ),
                ),
            ],
          ),
        ]);
      });
    });
  }
}

class _QuickAccessTile extends StatelessWidget {
  final _QuickAction action;
  final Color accent;

  const _QuickAccessTile({required this.action, required this.accent});

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(AppBorderRadius.lg);
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: Material(
        color: Theme.of(context).cardColor,
        borderRadius: radius,
        child: InkWell(
          borderRadius: radius,
          hoverColor: accent.withValues(alpha: 0.06),
          onTap: () => Get.toNamed(action.route),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            decoration: BoxDecoration(
              borderRadius: radius,
              border: Border.all(color: Theme.of(context).dividerColor),
            ),
            child: Row(children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: accent.withValues(alpha: 0.14),
                  borderRadius: BorderRadius.circular(AppBorderRadius.md),
                ),
                child: Icon(action.icon, size: 20, color: accent),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(action.label,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textMedium.copyWith(fontSize: Dimensions.fontSizeSmall)),
                    const SizedBox(height: 2),
                    Text(action.subtitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: textRegular.copyWith(
                            fontSize: 11, color: AppColors.textTertiaryColor)),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

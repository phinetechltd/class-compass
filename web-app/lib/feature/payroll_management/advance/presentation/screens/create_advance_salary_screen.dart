import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/payroll_management/advance/domain/models/advance_salary_model.dart';
import 'package:class_compass/feature/payroll_management/advance/presentation/widgets/add_advance_salary_widget.dart';

class CreateAdvanceSalaryScreen extends StatefulWidget {
  final UserPayroll? advanceSalaryItem;
  
  const CreateAdvanceSalaryScreen({super.key, this.advanceSalaryItem});

  @override
  State<CreateAdvanceSalaryScreen> createState() => _CreateAdvanceSalaryScreenState();
}

class _CreateAdvanceSalaryScreenState extends State<CreateAdvanceSalaryScreen> {
  ScrollController scrollController = ScrollController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: CustomAppBar(title:  "advance_salary".tr),
      body: CustomWebScrollView(controller: scrollController, slivers: [
        SliverToBoxAdapter(
            child: Column(children: [
                SectionHeaderWithPath(sectionTitle: "payroll_management".tr,
                  pathItems: ["advance_salary".tr],),
                AddAdvanceSalaryWidget(advanceSalaryItem: widget.advanceSalaryItem),
              ],
            )),
        ],
      ),
    );
  }
}

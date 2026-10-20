import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/section_header_with_path_widget.dart';
import 'package:class_compass/feature/payroll_management/payroll_assign/domain/model/payroll_assign_model.dart';
import 'package:class_compass/feature/payroll_management/payroll_assign/logic/payroll_assign_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class PayrollAssignListWidget extends StatefulWidget {
  final ScrollController scrollController;

  const PayrollAssignListWidget({
    super.key,
    required this.scrollController,
  });

  @override
  State<PayrollAssignListWidget> createState() =>
      _PayrollAssignListWidgetState();
}

class _PayrollAssignListWidgetState extends State<PayrollAssignListWidget> {
  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  final double columnWidth = 120;
  final double rowHeight = 60;

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PayrollAssignController>(
      initState: (_) =>
          Get.find<PayrollAssignController>().getPayrollAssign(),
      builder: (controller) {
        PayrollAssignModel? payrollModel = controller.payrollAssignModel;
        List<PayrollUserItem> payrollData = payrollModel?.data ?? [];

        if (payrollModel == null) {
          return const Center(child: CircularProgressIndicator());
        }

        double tableWidth = _calculateTableWidth(payrollData);

        return Padding(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionHeaderWithPath(
                sectionTitle: "payroll_management".tr,
                pathItems: ["payroll_assign".tr],
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              /// TABLE
              Scrollbar(
                controller: _horizontalController,
                thumbVisibility: true,
                trackVisibility: true,
                child: SingleChildScrollView(
                  controller: _horizontalController,
                  scrollDirection: Axis.horizontal,
                  child: SizedBox(
                    width: tableWidth,
                    child: Column(
                      children: [
                        /// HEADER
                        CustomContainer(
                          horizontalPadding: 0,
                          height: rowHeight,
                          child: Row(
                            children: [
                              _headerCell("name".tr),
                              _divider(),
                              _headerCell("designation".tr),
                              _divider(),
                              if (payrollData.isNotEmpty)
                                ...payrollData.first.salaryHeads
                                    ?.map((head) => [
                                  SizedBox(
                                    width: columnWidth,
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: [
                                          Flexible(
                                            child: Text(
                                              head.name ?? "",
                                              maxLines: 2,
                                              overflow:
                                              TextOverflow.ellipsis,
                                              style: textRegular,
                                            ),
                                          ),
                                          Text(
                                            head.type == "Addition"
                                                ? "(+)"
                                                : "(-)",
                                            style: textRegular.copyWith(
                                              color: head.type == "Addition"
                                                  ? Colors.green
                                                  : Colors.red,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  _divider(),
                                ])
                                    .expand((e) => e)
                                    .toList() ??
                                    [],
                            ],
                          ),
                        ),

                        /// BODY
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 0.45,
                          child: Scrollbar(
                            controller: _verticalController,
                            thumbVisibility: true,
                            trackVisibility: true,
                            child: ListView.builder(
                              controller: _verticalController,
                              itemCount: payrollData.length,
                              itemBuilder: (context, index) {
                                PayrollUserItem user = payrollData[index];

                                return Column(
                                  children: [
                                    SizedBox(
                                      height: rowHeight,
                                      child: Row(
                                        children: [
                                          /// Name
                                          SizedBox(
                                            width: columnWidth,
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(
                                                  horizontal: 8),
                                              child: Text(
                                                "${index + 1}. ${user.user?.name ?? ''}",
                                                style: textRegular,
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                          _divider(),

                                          /// Designation
                                          SizedBox(
                                            width: columnWidth,
                                            child: Center(
                                              child: Text(
                                                user.user?.userType ?? "",
                                                style: textRegular,
                                              ),
                                            ),
                                          ),
                                          _divider(),

                                          /// Salary Inputs with default 0
                                          if (user.salaryHeadUserPayrolls != null)
                                            ...user.salaryHeadUserPayrolls!.map(
                                                  (head) {
                                                // Get existing controller or default to 0
                                                TextEditingController controllerForCell =
                                                    controller.textControllers[
                                                    user.user?.id ?? 0]?[head
                                                        .salaryHeadId ??
                                                        0] ??
                                                        TextEditingController(
                                                            text: "0");

                                                // Ensure controller is saved in map
                                                controller.textControllers[
                                                user.user?.id ?? 0] ??= {};
                                                controller.textControllers[
                                                user.user?.id ?? 0]![
                                                head.salaryHeadId ?? 0] =
                                                    controllerForCell;

                                                return [
                                                  SizedBox(
                                                    width: columnWidth,
                                                    child: Padding(
                                                      padding: const EdgeInsets.all(4),
                                                      child: TextField(
                                                        controller: controllerForCell,
                                                        keyboardType:
                                                        TextInputType.number,
                                                        decoration:
                                                        const InputDecoration(
                                                          border: OutlineInputBorder(),
                                                          isDense: true,
                                                        ),
                                                        onChanged: (val) {
                                                          controller.updateAmount(
                                                            user.user?.id ?? 0,
                                                            head.salaryHeadId ?? 0,
                                                            val.isEmpty ? "0" : val,
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  _divider(),
                                                ];
                                              },
                                            ).expand((e) => e),
                                        ],
                                      ),
                                    ),
                                    if (index < payrollData.length - 1)
                                      Container(height: 1, color: Theme.of(context).dividerColor),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  width: 200,
                  child: CustomButton(
                    onTap: () => controller.createPayrollAssign(),
                    text: "update".tr,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _headerCell(String text) {
    return SizedBox(
      width: columnWidth,
      child: Center(
        child: Text(text, style: textRegular),
      ),
    );
  }

  Widget _divider() {
    return Container(
      width: 1,
      height: rowHeight,
      color: Colors.grey.shade300,
    );
  }

  double _calculateTableWidth(List<PayrollUserItem> data) {
    int salaryHeads =
    data.isNotEmpty ? data.first.salaryHeads?.length ?? 0 : 0;
    return (salaryHeads + 2) * columnWidth + 13;
  }
}
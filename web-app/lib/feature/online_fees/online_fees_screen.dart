import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/online_fees/online_fees_controller.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

const _mpesaGreen = Color(0xFF00A651);

class OnlineFeesScreen extends StatefulWidget {
  const OnlineFeesScreen({super.key});

  @override
  State<OnlineFeesScreen> createState() => _OnlineFeesScreenState();
}

class _OnlineFeesScreenState extends State<OnlineFeesScreen> {
  final amountController = TextEditingController();
  final phoneController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final controller = Get.find<OnlineFeesController>();
    controller.load().then((_) {
      if (amountController.text.isEmpty && controller.totalDue > 0) {
        amountController.text = controller.totalDue.toStringAsFixed(0);
      }
    });
    final returnedPayment = Uri.base.queryParameters['payment_id'];
    if (returnedPayment != null) {
      controller.resumeFromRedirect(returnedPayment);
    }
  }

  String _money(String currency, num value) {
    final s = value.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (m) => ',');
    return '${currency == 'KES' ? 'KSh' : currency} $s';
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = ResponsiveHelper.isDesktop(context);
    return Scaffold(
      appBar: CustomAppBar(title: "pay_school_fees".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<OnlineFeesController>(builder: (controller) {
          if (controller.loading && controller.due == null) {
            return const Padding(padding: EdgeInsets.all(60), child: Center(child: CircularProgressIndicator()));
          }
          final due = controller.due;
          final student = due?['student'] ?? {};
          final heads = (due?['fee_heads'] as List?) ?? [];

          final summary = CustomContainer(borderRadius: Dimensions.radiusDefault, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
              Text("${student['name'] ?? ''}", style: textBold.copyWith(fontSize: 18)),
              Text("${'admission_no'.tr}: ${student['admission_no'] ?? '-'}", style: textRegular.copyWith(color: Theme.of(context).hintColor)),
              const Divider(),
              Text("outstanding_balance".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
              Text(_money(controller.currency, controller.totalDue),
                  style: textBold.copyWith(fontSize: 30, color: controller.totalDue > 0 ? Theme.of(context).colorScheme.error : _mpesaGreen)),
              if (heads.isNotEmpty) ...[
                const SizedBox(height: Dimensions.paddingSizeSmall),
                ...heads.map((h) => Padding(padding: const EdgeInsets.symmetric(vertical: 4), child: Row(children: [
                  Expanded(child: Text("${h['fee_head_name']} · ${(h['sub_heads'] as List).map((s) => s['name']).join(', ')}", style: textRegular)),
                  Text(_money(controller.currency, h['fee_and_fine_payable'] ?? 0), style: textMedium),
                ]))),
              ],
            ]));

          final payCard = CustomContainer(borderRadius: Dimensions.radiusDefault, child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
              Text("pay_now".tr, style: textBold.copyWith(fontSize: 18)),
              if (controller.totalDue <= 0)
                Text("no_outstanding_fees".tr, style: textMedium.copyWith(color: _mpesaGreen))
              else if (controller.methods.isEmpty)
                Text("online_payment_not_enabled".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor))
              else ...[
                Wrap(spacing: Dimensions.paddingSizeSmall, runSpacing: Dimensions.paddingSizeSmall, children: controller.methods.map<Widget>((m) {
                  final selected = controller.selectedMethod == m['key'];
                  return ChoiceChip(
                    avatar: Icon(m['key'] == 'mpesa' ? Icons.phone_android : Icons.credit_card, size: 18,
                        color: selected ? Colors.white : null),
                    label: Text("${m['label']}"),
                    selected: selected,
                    selectedColor: m['key'] == 'mpesa' ? _mpesaGreen : Theme.of(context).primaryColor,
                    labelStyle: TextStyle(color: selected ? Colors.white : null),
                    onSelected: (_) => controller.selectMethod(m['key']),
                  );
                }).toList()),
                CustomTextField(title: "${'amount'.tr} (${controller.currency})", controller: amountController,
                    hintText: controller.totalDue.toStringAsFixed(0), inputType: TextInputType.number),
                if (controller.selectedMethod == 'mpesa')
                  CustomTextField(title: "mpesa_phone_number".tr, controller: phoneController,
                      hintText: "0712 345 678", inputType: TextInputType.phone),
                Text(controller.selectedMethod == 'mpesa' ? "mpesa_pay_hint".tr : "paystack_pay_hint".tr,
                    style: textRegular.copyWith(fontSize: 12, color: Theme.of(context).hintColor)),
                CustomButton(
                  height: 46,
                  buttonColor: controller.selectedMethod == 'mpesa' ? _mpesaGreen : null,
                  text: controller.paying ? "please_wait".tr : (controller.selectedMethod == 'mpesa' ? "send_mpesa_prompt".tr : "continue_to_paystack".tr),
                  onTap: controller.paying || controller.trackingStatus == 'pending' ? null : () {
                    controller.pay(
                      amount: double.tryParse(amountController.text.replaceAll(',', '').trim()) ?? 0,
                      phone: controller.selectedMethod == 'mpesa' ? phoneController.text.trim() : null,
                    );
                  },
                ),
              ],
              if (controller.trackingStatus != null) _TrackingBanner(controller: controller),
            ]));

          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault), child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, spacing: Dimensions.paddingSizeDefault, children: [
              isDesktop
                  ? Row(crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeDefault,
                      children: [Expanded(child: summary), Expanded(child: payCard)])
                  : Column(crossAxisAlignment: CrossAxisAlignment.stretch, spacing: Dimensions.paddingSizeDefault, children: [summary, payCard]),
              if (controller.history.isNotEmpty) CustomContainer(borderRadius: Dimensions.radiusDefault, child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text("online_payment_history".tr, style: textBold.copyWith(fontSize: 16)),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  ...controller.history.map((p) => ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: Icon(p['method'] == 'mpesa' ? Icons.phone_android : Icons.credit_card),
                    title: Text(_money('${p['currency']}', p['amount'] ?? 0)),
                    subtitle: Text("${p['created_at'] ?? ''}${p['receipt'] != null ? ' · ${p['receipt']}' : ''}"),
                    trailing: _StatusChip(status: '${p['status']}'),
                  )),
                ])),
            ]));
        })),
      ]),
    );
  }
}

class _TrackingBanner extends StatelessWidget {
  final OnlineFeesController controller;
  const _TrackingBanner({required this.controller});

  @override
  Widget build(BuildContext context) {
    final status = controller.trackingStatus;
    final color = status == 'paid' ? _mpesaGreen : status == 'failed' ? Theme.of(context).colorScheme.error : Theme.of(context).primaryColor;
    return Container(
      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
          border: Border.all(color: color.withValues(alpha: 0.4))),
      child: Row(spacing: Dimensions.paddingSizeDefault, children: [
        status == 'pending'
            ? SizedBox(width: 26, height: 26, child: CircularProgressIndicator(strokeWidth: 3, color: color))
            : Icon(status == 'paid' ? Icons.check_circle : Icons.error, color: color, size: 30),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(status == 'pending' ? "waiting_for_confirmation".tr : status == 'paid' ? "payment_successful".tr : "payment_failed".tr,
              style: textBold.copyWith(color: color)),
          if (controller.trackingMessage != null) Text(controller.trackingMessage!, style: textRegular),
          if (controller.trackingReceipt != null) Text("${'receipt'.tr}: ${controller.trackingReceipt}", style: textMedium),
        ])),
        if (status != 'pending') IconButton(onPressed: controller.clearTracking, icon: const Icon(Icons.close)),
      ]),
    );
  }
}

class _StatusChip extends StatelessWidget {
  final String status;
  const _StatusChip({required this.status});

  @override
  Widget build(BuildContext context) {
    final color = status == 'paid' ? _mpesaGreen : status == 'failed' ? Theme.of(context).colorScheme.error : Colors.orange;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.12), borderRadius: BorderRadius.circular(20)),
      child: Text(status.tr, style: textMedium.copyWith(color: color, fontSize: 12)),
    );
  }
}

/// School admin: every online fee payment (M-Pesa and Paystack) with receipt and posting status.
class OnlineFeePaymentsAdminScreen extends StatefulWidget {
  const OnlineFeePaymentsAdminScreen({super.key});

  @override
  State<OnlineFeePaymentsAdminScreen> createState() => _OnlineFeePaymentsAdminScreenState();
}

class _OnlineFeePaymentsAdminScreenState extends State<OnlineFeePaymentsAdminScreen> {
  @override
  void initState() {
    super.initState();
    Get.find<OnlineFeesController>().loadAdmin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "online_fee_payments".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<OnlineFeesController>(builder: (controller) {
          if (controller.adminLoading && controller.adminPayments.isEmpty) {
            return const Padding(padding: EdgeInsets.all(60), child: Center(child: CircularProgressIndicator()));
          }
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault), child: CustomContainer(
            borderRadius: Dimensions.radiusDefault,
            child: controller.adminPayments.isEmpty
                ? Padding(padding: const EdgeInsets.all(40), child: Center(child: Text("no_online_payments_yet".tr)))
                : Column(children: [
                    SingleChildScrollView(scrollDirection: Axis.horizontal, child: DataTable(columns: [
                      DataColumn(label: Text("date".tr)),
                      DataColumn(label: Text("student".tr)),
                      DataColumn(label: Text("method".tr)),
                      DataColumn(label: Text("amount".tr)),
                      DataColumn(label: Text("receipt".tr)),
                      DataColumn(label: Text("status".tr)),
                      DataColumn(label: Text("posted_to_fees".tr)),
                    ], rows: controller.adminPayments.map((p) => DataRow(cells: [
                      DataCell(Text("${p['created_at'] ?? ''}")),
                      DataCell(Text("${p['student_name'] ?? p['student_id'] ?? ''}")),
                      DataCell(Text(p['method'] == 'mpesa' ? 'M-Pesa' : 'Paystack')),
                      DataCell(Text("${p['currency']} ${p['amount']}")),
                      DataCell(Text("${p['receipt'] ?? '-'}")),
                      DataCell(_StatusChip(status: "${p['status']}")),
                      DataCell(p['posting_error'] != null
                          ? Tooltip(message: "${p['posting_error']}", child: const Icon(Icons.warning_amber, color: Colors.orange))
                          : Icon(p['posted_to_fees'] == true ? Icons.check : Icons.remove,
                              color: p['posted_to_fees'] == true ? _mpesaGreen : Theme.of(context).hintColor)),
                    ])).toList())),
                    if (controller.adminLastPage > 1) Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                      IconButton(onPressed: controller.adminPage > 1 ? () => controller.loadAdmin(page: controller.adminPage - 1) : null, icon: const Icon(Icons.chevron_left)),
                      Text("${controller.adminPage} / ${controller.adminLastPage}"),
                      IconButton(onPressed: controller.adminPage < controller.adminLastPage ? () => controller.loadAdmin(page: controller.adminPage + 1) : null, icon: const Icon(Icons.chevron_right)),
                    ]),
                  ]),
          ));
        })),
      ]),
    );
  }
}

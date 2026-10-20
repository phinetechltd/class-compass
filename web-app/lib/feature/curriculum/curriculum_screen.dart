import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/api_handle/api_checker.dart';
import 'package:class_compass/api_handle/api_client.dart';
import 'package:class_compass/common/global_widget/custom_web_scroll_view_widget.dart';
import 'package:class_compass/common/widget/custom_app_bar.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/helper/responsive_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

/// Lets a school pick CBC, 8-4-4, British or College/TVET and creates the matching
/// classes, subjects and grading scale.
class CurriculumController extends GetxController implements GetxService {
  final ApiClient apiClient;
  CurriculumController({required this.apiClient});

  bool loading = false;
  bool applying = false;
  String? current;
  String? selected;
  List<dynamic> presets = [];
  bool applyClasses = true;
  bool applySubjects = true;
  bool applyGrades = true;

  Map<String, dynamic>? get selectedPreset =>
      presets.cast<Map<String, dynamic>?>().firstWhere((p) => p?['key'] == selected, orElse: () => null);

  Future<void> load() async {
    loading = true;
    update();
    final response = await apiClient.getData(AppConstants.curriculum);
    if (response.statusCode == 200) {
      presets = response.body['data']['presets'] ?? [];
      current = response.body['data']['current'];
      selected = current ?? (presets.isNotEmpty ? presets.first['key'] : null);
    } else {
      ApiChecker.checkApi(response);
    }
    loading = false;
    update();
  }

  void select(String key) {
    selected = key;
    update();
  }

  void toggle(String what, bool value) {
    if (what == 'classes') applyClasses = value;
    if (what == 'subjects') applySubjects = value;
    if (what == 'grades') applyGrades = value;
    update();
  }

  Future<void> apply() async {
    if (selected == null) return;
    applying = true;
    update();
    final response = await apiClient.postData(AppConstants.curriculumApply, {
      'curriculum': selected,
      'classes': applyClasses,
      'subjects': applySubjects,
      'grades': applyGrades,
    });
    applying = false;
    if (response.statusCode == 200) {
      final d = response.body['data'];
      current = d['current'];
      showCustomSnackBar(
          "${'curriculum_applied'.tr}: ${d['classes_created']} ${'classes'.tr}, ${d['subjects_created']} ${'subjects'.tr}, ${d['grades_created']} ${'grades'.tr}",
          isError: false);
    } else {
      ApiChecker.checkApi(response);
    }
    update();
  }
}

class CurriculumScreen extends StatefulWidget {
  const CurriculumScreen({super.key});

  @override
  State<CurriculumScreen> createState() => _CurriculumScreenState();
}

class _CurriculumScreenState extends State<CurriculumScreen> {
  static const _icons = {'cbc': Icons.explore, '844': Icons.menu_book, 'british': Icons.public, 'college': Icons.school};

  @override
  void initState() {
    super.initState();
    Get.find<CurriculumController>().load();
  }

  @override
  Widget build(BuildContext context) {
    final columns = ResponsiveHelper.isDesktop(context) ? 4 : ResponsiveHelper.isTablet(context) ? 2 : 1;
    return Scaffold(
      appBar: CustomAppBar(title: "curriculum".tr),
      body: CustomWebScrollView(slivers: [
        SliverToBoxAdapter(child: GetBuilder<CurriculumController>(builder: (c) {
          if (c.loading && c.presets.isEmpty) {
            return const Padding(padding: EdgeInsets.all(60), child: Center(child: CircularProgressIndicator()));
          }
          final preset = c.selectedPreset;
          final primary = Theme.of(context).primaryColor;
          return Padding(padding: const EdgeInsets.all(Dimensions.paddingSizeDefault), child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch, spacing: Dimensions.paddingSizeDefault, children: [
              Text("choose_curriculum_hint".tr, style: textRegular.copyWith(color: Theme.of(context).hintColor)),
              GridView.count(
                crossAxisCount: columns, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: Dimensions.paddingSizeDefault, mainAxisSpacing: Dimensions.paddingSizeDefault,
                childAspectRatio: columns == 1 ? 3.4 : 1.25,
                children: c.presets.map<Widget>((p) {
                  final isSelected = p['key'] == c.selected;
                  return InkWell(
                    borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                    onTap: () => c.select(p['key']),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
                      decoration: BoxDecoration(
                        color: isSelected ? primary.withValues(alpha: 0.08) : Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                        border: Border.all(color: isSelected ? primary : Theme.of(context).dividerColor, width: isSelected ? 2 : 1),
                      ),
                      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Row(children: [
                          Icon(_icons[p['key']] ?? Icons.school, color: primary),
                          const Spacer(),
                          if (p['key'] == c.current)
                            Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(color: const Color(0xFF00C090), borderRadius: BorderRadius.circular(12)),
                                child: Text("active".tr, style: textMedium.copyWith(color: Colors.white, fontSize: 11))),
                        ]),
                        const SizedBox(height: Dimensions.paddingSizeSmall),
                        Text("${p['name']}", style: textBold.copyWith(fontSize: 15)),
                        const SizedBox(height: 4),
                        Expanded(child: Text("${p['description']}", overflow: TextOverflow.fade,
                            style: textRegular.copyWith(fontSize: 12, color: Theme.of(context).hintColor))),
                      ]),
                    ),
                  );
                }).toList(),
              ),
              if (preset != null) CustomContainer(borderRadius: Dimensions.radiusDefault, child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, spacing: Dimensions.paddingSizeSmall, children: [
                  Text("${preset['name']}", style: textBold.copyWith(fontSize: 17)),
                  ...((preset['levels'] as List).map((l) => Padding(padding: const EdgeInsets.only(top: 6), child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text("${l['name']}: ${(l['classes'] as List).join(', ')}", style: textMedium),
                      Text((l['subjects'] as List).join(' · '), style: textRegular.copyWith(fontSize: 12, color: Theme.of(context).hintColor)),
                    ])))),
                  const SizedBox(height: Dimensions.paddingSizeSmall),
                  Text("grading_scale".tr, style: textMedium),
                  Wrap(spacing: 8, runSpacing: 8, children: (preset['grades'] as List).map<Widget>((g) => Chip(
                    label: Text("${g['grade']}  ${g['from']}–${g['to']}%  (${g['points']} ${'pts'.tr})"),
                  )).toList()),
                  const Divider(),
                  CheckboxListTile(contentPadding: EdgeInsets.zero, value: c.applyClasses, onChanged: (v) => c.toggle('classes', v ?? false),
                      title: Text("create_classes_and_streams".tr)),
                  CheckboxListTile(contentPadding: EdgeInsets.zero, value: c.applySubjects, onChanged: (v) => c.toggle('subjects', v ?? false),
                      title: Text("create_subjects_per_class".tr)),
                  CheckboxListTile(contentPadding: EdgeInsets.zero, value: c.applyGrades, onChanged: (v) => c.toggle('grades', v ?? false),
                      title: Text("replace_grading_scale".tr)),
                  Align(alignment: Alignment.centerRight, child: CustomButton(width: 200, height: 44,
                      text: c.applying ? "please_wait".tr : "apply_curriculum".tr,
                      onTap: c.applying ? null : () => c.apply())),
                ])),
            ]));
        })),
      ]),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/layout/custom_dialog_widget.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/feature/routine_management/assignment/domain/models/assignment_model.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:class_compass/util/styles.dart';

class AssignmentFilesWidget extends StatelessWidget {
  final AssignmentItem? assignmentItem;
  const AssignmentFilesWidget({super.key, this.assignmentItem});

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      verticalPadding: 0,
      horizontalPadding: 0,
      borderRadius: 3,
      width: 30,
      height: 30,
      onTap: () {
        final files = [
          assignmentItem?.file,
          assignmentItem?.file2,
          assignmentItem?.file3,
          assignmentItem?.file4,
        ].where((e) => e != null && e.isNotEmpty).toList();

        Get.dialog(
          CustomDialogWidget(
            title: "files".tr,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(files.length, (index) {
                final file = files[index];

                return InkWell(
                  onTap: () {
                    AppConstants.openUrl(
                      "${AppConstants.baseUrl}/uploads/files/assignments/$file",
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      border: Border.all(color: Colors.grey.shade300),
                    ),
                    child: Row(
                      children: [
                        const Icon(Icons.insert_drive_file, size: 20),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            "${"file".tr} ${index + 1}",
                            style: textRegular,
                          ),
                        ),
                        const Icon(Icons.download, size: 20),
                      ],
                    ),
                  ),
                );
              }),
            ),
          ),
        );
      },
      child: const Icon(Icons.file_download),
    );
  }
}

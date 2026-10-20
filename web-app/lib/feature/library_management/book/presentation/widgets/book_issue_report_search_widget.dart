import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_dropdown.dart';
import 'package:class_compass/feature/library_management/book/controller/book_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class BookIssueReportSearchWidget extends StatefulWidget {
  const BookIssueReportSearchWidget({super.key});

  @override
  State<BookIssueReportSearchWidget> createState() => _BookIssueReportSearchWidgetState();
}

class _BookIssueReportSearchWidgetState extends State<BookIssueReportSearchWidget> {
   TextEditingController idController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BookController>(builder: (bookController) {
        return Padding(padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeSmall), child: Row(
            spacing: Dimensions.paddingSizeSmall, children: [
              Expanded(
                child: Padding(padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CustomDropdown(
                    width: Get.width,
                    title: "select".tr,
                    items: bookController.statusTypes,
                    selectedValue: bookController.selectedType,
                    onChanged: (val) {
                      bookController.setSelectedStatusType(val!);
                    },
                  ))),


              SizedBox(width: 70,
                child: CustomButton(onTap: () {
                    bookController.getBookIssueReport(1,
                      statusId: bookController.selectedTypeIndex.toString(),
                      userId: idController.text.trim());
                  }, text: "search".tr)),
            ],
          ),
        );
      }
    );
  }
}

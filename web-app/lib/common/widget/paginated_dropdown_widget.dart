import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/controller/paginate_dropdown_controller.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class PaginatedDropDownWidget<T> extends StatelessWidget {
  final double? width;
  final bool border;
  final String title;
  final PaginatedDropdownController<T> controller;
  final String Function(T item) getLabel;

  const PaginatedDropDownWidget({
    super.key,
    this.width,
    this.border = false,
    required this.title,
    required this.controller,
    required this.getLabel,
  });

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PaginatedDropdownController<T>>(
      init: controller, builder: (_) {
        final dropdownItems = <DropdownMenuItem<T>>[
          ...controller.items.map((item) => DropdownMenuItem<T>(
            value: item,
            child: Text(getLabel(item),
              style: textRegular.copyWith(fontSize: Dimensions.fontSizeSmall)))),
          if (controller.hasMore)
            DropdownMenuItem<T>(enabled: false,
              child: Center(child: controller.isLoading ?
              const Padding(padding: EdgeInsets.all(8.0),
                child: SizedBox(height: 16, width: 16,
                    child: CircularProgressIndicator(strokeWidth: 2)))
                  : TextButton(onPressed: controller.loadMore,
                child: Text("Show More", style: textRegular.copyWith(
                  color: systemPrimaryColor(), fontSize: Dimensions.fontSizeSmall)),
                ),
              ),
            ),
        ];

        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(Dimensions.paddingSizeExtraSmall),
            border: Border.all(width: .5, color: Theme.of(context).hintColor),
          ),
          child: DropdownButton2<T>(
            isDense: true,
            isExpanded: true,
            underline: const SizedBox(),
            hint: Text(
              controller.selectedItem != null
                  ? getLabel(controller.selectedItem as T)
                  : title.tr,
              style: textRegular.copyWith(
                color: controller.selectedItem != null
                    ? Theme.of(context).textTheme.displayMedium?.color
                    : Theme.of(context).hintColor,
                fontSize: Dimensions.fontSizeDefault,
              ),
            ),
            items: dropdownItems,
            value: controller.selectedItem,
            onChanged: (val) {
              if (val != null) controller.setSelectedItem(val);
            },
            buttonStyleData: ButtonStyleData(
              height: 35,
              width: width,
              padding: const EdgeInsets.only(right: 14),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                border: border ? Border.all(color: Colors.black26) : null,
                color: Colors.transparent,
              ),
              elevation: 0,
            ),
            iconStyleData: const IconStyleData(
              icon: Icon(Icons.arrow_forward_ios_outlined),
              iconSize: 14,
              iconEnabledColor: Colors.grey,
              iconDisabledColor: Colors.grey,
            ),
            dropdownStyleData: DropdownStyleData(
              maxHeight: 250,
              width: width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: Theme.of(context).cardColor,
              ),
              offset: const Offset(-20, 0),
              scrollbarTheme: ScrollbarThemeData(
                radius: const Radius.circular(40),
                thickness: WidgetStateProperty.all<double>(6),
                thumbVisibility: WidgetStateProperty.all<bool>(true),
              ),
            ),
            menuItemStyleData: const MenuItemStyleData(
              height: 40,
              padding: EdgeInsets.only(left: 14, right: 14),
            ),
          ),
        );
      },
    );
  }
}

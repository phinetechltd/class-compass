import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

typedef ItemLabel<T> = String Function(T item);
typedef OnSearch = void Function(String query);
typedef ListBuilder = Widget Function();

class DropdownSearch<T> extends StatelessWidget {
  final ItemLabel<T> itemLabel;
  final String hintText;
  final String? sectionTitle;
  final T? selectedItem;
  final OnSearch? onSearch;
  final ListBuilder listWidgetBuilder;
  final TextEditingController searchController;
  final Function()? onTap;

  const DropdownSearch({
    super.key,
    required this.itemLabel,
    required this.listWidgetBuilder,
    required this.searchController,
    this.hintText = 'Select',
    this.sectionTitle,
    this.selectedItem,
    this.onSearch, this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        searchController.clear();
        await showDialog(context: context, barrierDismissible: true,
          builder: (context) {
            return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: SizedBox(height: MediaQuery.of(context).size.height * 0.75,
                child: Padding(padding: const EdgeInsets.all(16),
                  child: Column(children: [
                    Row(spacing: Dimensions.paddingSizeDefault, children: [
                      Expanded(child: TextField(controller: searchController,

                          onChanged: (value) => onSearch?.call(value),
                          decoration: InputDecoration(hintText: "Search",
                            suffixIcon: IconButton(icon: const Icon(Icons.search),
                              onPressed: () => onSearch?.call(searchController.text),
                            ),
                            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          ))),
                      CustomContainer(onTap: onTap ?? ()=> Get.back(),
                          color: systemPrimaryColor(),borderRadius: 3,
                          child: const Icon(Icons.check, color: Colors.white,))
                    ],
                    ),
                    const SizedBox(height: 12),
                    Expanded(child: listWidgetBuilder()),
                  ],
                  ),
                ),
              ),
            );
          },
        );
      },
      child: Column(crossAxisAlignment: CrossAxisAlignment.start,spacing: Dimensions.paddingSizeTiny,
        children: [
          if(sectionTitle != null)
            Padding(padding: const EdgeInsets.only(top: 5.0, bottom: 5),
              child: Text("$sectionTitle", style: textRegular.copyWith()),
            ),
          Container(height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            decoration: BoxDecoration(border: Border.all(width: .5, color: Theme.of(context).hintColor),
                borderRadius: BorderRadius.circular(5)),
            child: Row(children: [
              Expanded(child: Text(
                  selectedItem != null ? itemLabel(selectedItem as T) : hintText,
                  overflow: TextOverflow.ellipsis)),
              Icon(Icons.keyboard_arrow_down_rounded,
                  size: 16, color: Theme.of(context).hintColor),
            ],
            ),
          ),
        ],
      ),
    );
  }
}

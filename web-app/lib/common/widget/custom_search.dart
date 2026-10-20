import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';


class CustomSearch extends StatefulWidget {
  final String? hintText;
  final TextEditingController searchController;
  final Function()? onSearch;
  final Function(String value)? onChange;
  final Function()? reset;
  const CustomSearch({super.key, required this.hintText, required this.searchController,
    this.onSearch, this.reset, this.onChange});

  @override
  State<CustomSearch> createState() => _CustomSearchState();
}

class _CustomSearchState extends State<CustomSearch> {

  @override
  Widget build(BuildContext context) {
    return Container(width : MediaQuery.of(context).size.width, height:  50 ,
      alignment: Alignment.center,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(Dimensions.paddingSizeSmall),
          border: Border.all(color: Theme.of(context).hintColor.withValues(alpha: .15))),
      child: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
        Expanded(child: Container(
          decoration: const BoxDecoration(
              borderRadius: BorderRadius.all( Radius.circular(Dimensions.paddingSizeDefault))),

          child: Padding(padding:  const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeSmall),

            child: TextFormField(controller: widget.searchController,
              textInputAction: TextInputAction.search,
              maxLines: 1,
              textAlignVertical: TextAlignVertical.center,
              style: textRegular.copyWith(color: Theme.of(context).hintColor),
              onFieldSubmitted: (val){

              },
              onChanged: (val) {
                setState(() {});
                if (widget.onChange != null) {
                  widget.onChange!(val);
                }
              },
              decoration: InputDecoration(
                hintText: widget.hintText,
                isDense: true,

                contentPadding: const EdgeInsets.only(bottom: 5),
                suffixIconConstraints: const BoxConstraints(maxHeight: 25),
                hintStyle: textRegular.copyWith(color: Theme.of(context).hintColor),

                border: InputBorder.none,
                suffixIcon: widget.searchController.text.isNotEmpty?
                InkWell(onTap: () {
                    setState(() {
                      widget.searchController.clear();
                    });
                    widget.reset?.call();
                    widget.onChange?.call("");
                  },
                  child: Icon(Icons.clear, size: 20, color: Theme.of(context).colorScheme.error),)
                    :const SizedBox(),
              ),
            ),
          ),

        )),

        InkWell(onTap: widget.onSearch,
          child: Padding(
            padding: const EdgeInsets.all(3.0),
            child: Container(padding: const EdgeInsets.all(5),
              width: 40,height: 40 ,decoration: BoxDecoration(color: systemPrimaryColor(),
                  borderRadius: const BorderRadius.all(Radius.circular(Dimensions.paddingSizeSmall))),
              child:  const Icon(CupertinoIcons.search, color: Colors.white),
            ),
          ),
        )


      ]),
    );
  }
}

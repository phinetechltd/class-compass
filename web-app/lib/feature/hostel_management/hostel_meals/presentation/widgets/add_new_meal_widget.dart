import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_button.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/common/widget/custom_text_field.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/domain/model/hostel_meal_body.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/domain/model/hostel_meal_model.dart';
import 'package:class_compass/feature/hostel_management/hostel_meals/logic/hostel_meals_controller.dart';
import 'package:class_compass/util/dimensions.dart';

class AddNewMealWidget extends StatefulWidget {
  final HostelMealItem? item;
  const AddNewMealWidget({super.key, this.item});

  @override
  State<AddNewMealWidget> createState() => _AddNewMealWidgetState();
}

class _AddNewMealWidgetState extends State<AddNewMealWidget> {
  TextEditingController mealNameController = TextEditingController();
  TextEditingController mealTypeController = TextEditingController();
  @override
  void initState() {
    super.initState();
    if(widget.item != null){
      mealNameController.text = widget.item?.mealName??"";
      mealTypeController.text = widget.item?.mealType??"";
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(spacing: Dimensions.paddingSizeDefault, children: [
      CustomTextField(controller: mealNameController,
      hintText: "meal_name".tr,
      title: "meal_name".tr,),
      CustomTextField(
        controller: mealTypeController,
        hintText: "meal_type".tr,
        title: "meal_type".tr,),
      GetBuilder<HostelMealsController>(
        builder: (mealController) {
          return CustomButton(onTap: (){
            String mealName = mealNameController.text.trim();
            String mealType = mealTypeController.text.trim();
            if(mealName.isEmpty){
              showCustomSnackBar("meal_name_is_required".tr);
            }else if(mealType.isEmpty){
              showCustomSnackBar("meal_type_is_required".tr);
            }else{
              HostelMealBody mealBody = HostelMealBody(mealName: mealName, mealType: mealType);
              if(widget.item != null){
                mealController.editHostelMeals(widget.item!.id!, mealBody);
              }else {
                mealController.createHostelMeals(mealBody);
              }
            }
          }, text: "confirm".tr);
        }
      )
    ]);
  }
}

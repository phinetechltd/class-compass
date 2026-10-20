import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/confirmation_dialog.dart';
import 'package:class_compass/common/widget/edit_delete_section.dart';
import 'package:class_compass/common/widget/numbering_widget.dart';
import 'package:class_compass/feature/transportation_management/transport_driver/domain/model/transport_driver_model.dart';
import 'package:class_compass/feature/transportation_management/transport_driver/logic/transport_driver_controller.dart';
import 'package:class_compass/feature/transportation_management/transport_driver/presentation/screens/create_new_transport_driver_dialog.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class TransportDriverItemWidget extends StatelessWidget {
  final TransportDriverItem transportDriverItem;
  final int index;
  const TransportDriverItemWidget({super.key, required this.transportDriverItem, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.fromLTRB(Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, Dimensions.paddingSizeDefault, 0),
      child: Row(spacing: Dimensions.paddingSizeDefault, crossAxisAlignment: CrossAxisAlignment.start, children: [

        NumberingWidget(index: index),
        Expanded(child: Text('${transportDriverItem.name}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportDriverItem.phone}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportDriverItem.licenseNumber}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportDriverItem.experience} years', style: textRegular.copyWith())),
        Expanded(child: Text('\$${transportDriverItem.salary}', style: textRegular.copyWith())),
        Expanded(child: Text('${transportDriverItem.status}', style: textRegular.copyWith())),
        EditDeleteSection(horizontal: true, onDelete: (){
          Get.dialog(ConfirmationDialog(title: "transport_driver", content: "transport_driver",
            onTap: (){
              Get.back();
              Get.find<TransportDriverController>().deleteTransportDriver(transportDriverItem.id!);
            },));

        }, onEdit: (){
          Get.dialog(CreateNewTransportDriverDialog(transportDriverItem: transportDriverItem));
        },)
      ],
      ),
    );
  }
}

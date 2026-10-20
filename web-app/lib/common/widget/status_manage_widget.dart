import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_toggle_switch.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/styles.dart';

class StatusManageWidget extends StatelessWidget {
  final bool active;
  final ValueChanged<bool>? onChanged;

  const StatusManageWidget({super.key, required this.active, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: CustomToggleSwitch(
        value: active, onChanged: onChanged, width: 40, height: 20,
          activeColor: systemPrimaryColor(), inactiveColor: Theme.of(context).hintColor));
  }
}


class AttendanceStatusWidget extends StatelessWidget {
  final bool active;
  final String status;
  const AttendanceStatusWidget({super.key, required this.active, required this.status});

  @override
  Widget build(BuildContext context) {
    return Padding(padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(50),
        color: active? Colors.green : Colors.red),
        child: Padding(padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 3),
          child: Row(mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center, children: [
            if(active)
            const Icon(Icons.check_circle, color: Colors.white, size: 15,),
            const SizedBox(width: 5),
            Text(status.tr, style: textRegular.copyWith(color:  Colors.white),)
          ])),
      ),
    );
  }
}
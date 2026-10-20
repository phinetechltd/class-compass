import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DatePickerController extends GetxController implements GetxService{

  String? isoTime;
  DateTime selectedDate = DateTime.now();
  DateTime selectedEndDate = DateTime.now();
  String formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  String formatedEndDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
  Future<void> setSelectDate(
      BuildContext context, {bool end = false, bool allowPast = true, bool allowFuture = true}) async {
    DateTime now = DateTime.now();

    DateTime firstDate = allowPast ? DateTime(2015, 1) : now;
    DateTime lastDate = allowFuture ? DateTime(2101) : now;

    final DateTime? picked = await showDatePicker(context: context, initialDate: now, firstDate: firstDate, lastDate: lastDate);

    if (picked != null) {

      isoTime = '${picked.toUtc().toIso8601String().split('.').first}Z';

      if (end) {
        selectedEndDate = picked;
        formatedEndDate =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      } else {
        selectedDate = picked;
        formatedDate =
        "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      }
      log("Selected Date: $picked");
    }

    update();
  }

  void resetDate() {
    selectedDate = DateTime.now();
    selectedEndDate = DateTime.now();
    formatedDate = "${DateTime.now().year.toString()}-${DateTime.now().month.toString().padLeft(2,'0')}-${DateTime.now().day.toString().padLeft(2,'0')}";
    formatedEndDate = "";
    update();
  }

  void setDateFromString(String dateString) {
    try {
      selectedDate = DateTime.parse(dateString);
      formatedDate = "${selectedDate.year.toString()}-${selectedDate.month.toString().padLeft(2,'0')}-${selectedDate.day.toString().padLeft(2,'0')}";
      update();
    } catch (e) {
      log("Error parsing date: $e");
    }
  }

  void setEndDateFromString(String dateString) {
    try {
      selectedEndDate = DateTime.parse(dateString);
      formatedEndDate = "${selectedEndDate.year.toString()}-${selectedEndDate.month.toString().padLeft(2,'0')}-${selectedEndDate.day.toString().padLeft(2,'0')}";
      update();
    } catch (e) {
      log("Error parsing end date: $e");
    }
  }

}
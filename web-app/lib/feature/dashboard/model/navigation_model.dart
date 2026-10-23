import 'package:flutter/material.dart';

class NavigationModel {
  String name;
  String activeIcon;
  String inactiveIcon;
  Widget screen;
  /// Shown only to users holding a permission that starts with this (null: everyone).
  String? permission;

  NavigationModel({required this.name, required this.activeIcon, required this.inactiveIcon, required this.screen, this.permission});
}
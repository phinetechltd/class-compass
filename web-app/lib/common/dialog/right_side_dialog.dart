import 'package:flutter/material.dart';

Future<T?> showRightSideDialog<T>(
    BuildContext context, {
      required Widget child,
      double width = 400,
    }) {
  return showGeneralDialog<T>(
    context: context,
    barrierDismissible: true,
    barrierLabel: "Dismiss",
    transitionDuration: const Duration(milliseconds: 300),
    pageBuilder: (context, anim1, anim2) {
      return Align(
        alignment: Alignment.centerRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 20, top: 50, bottom: 50),
          child: SizedBox(
            width: width,
            child: Material(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              child: child,
            ),
          ),
        ),
      );
    },
    transitionBuilder: (context, anim1, anim2, child) {
      return SlideTransition(
        position: Tween(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(CurvedAnimation(parent: anim1, curve: Curves.easeOut)),
        child: child,
      );
    },
  );
}


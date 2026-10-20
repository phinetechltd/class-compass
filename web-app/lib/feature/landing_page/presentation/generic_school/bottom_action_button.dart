import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/app_constants.dart';
import 'package:url_launcher/url_launcher.dart';

class BottomActionButton extends StatelessWidget {
  final ValueNotifier<bool> isFabVisible;
  const BottomActionButton({super.key, required this.isFabVisible});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
      valueListenable: isFabVisible,
      builder: (context, isVisible, child) {
        return Padding(padding: const EdgeInsets.only(left: 40),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
              FloatingActionButton(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                  const url = "https://wa.me/${AppConstants.whatsAppNumber}";
                  launchUrl(Uri.parse(url));
                },
                backgroundColor: Colors.green,
                child: const FaIcon(FontAwesomeIcons.whatsapp, color: Colors.white)),
              isVisible ? FloatingActionButton(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
                onPressed: () {
                },
                backgroundColor: systemLandingPagePrimaryColor(),
                child: const FaIcon(FontAwesomeIcons.arrowUp, color: Colors.white))
                  : const SizedBox(),
            ],
          ),
        );
      },
    );
  }
}

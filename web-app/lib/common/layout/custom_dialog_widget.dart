import 'package:flutter/material.dart';
import 'package:class_compass/util/dimensions.dart';

class CustomDialogWidget extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double radius;
  final double? width;
  final String? title;
  final bool showCloseButton;
  final VoidCallback? onClose;

  const CustomDialogWidget({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(Dimensions.paddingSizeDefault),
    this.radius = Dimensions.paddingSizeDefault,
    this.title,
    this.showCloseButton = true,
    this.onClose,
    this.width = 600,
  });

  @override
  Widget build(BuildContext context) {
    final maxHeight = MediaQuery.of(context).size.height * 0.78;

    return Dialog(shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
      insetPadding: const EdgeInsets.all(16),
      child: Container(width: width, padding: padding,
        constraints: BoxConstraints(maxHeight: maxHeight),
        decoration: BoxDecoration(color: Theme.of(context).dialogTheme.backgroundColor,
            borderRadius: BorderRadius.circular(radius)),
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          if (title != null || showCloseButton)
            Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
              if (title != null)
                Expanded(child: Text(title!,
                    style: Theme.of(context).textTheme.titleMedium)),
              if (showCloseButton)
                InkWell(onTap: onClose ?? () => Navigator.pop(context),
                    borderRadius: BorderRadius.circular(50),
                    child: const Padding(
                        padding: EdgeInsets.all(4.0),
                        child: Icon(Icons.close))),
            ],
            ),
          if (title != null || showCloseButton)
            const SizedBox(height: 12),
          Flexible(child: SingleChildScrollView(child: child)),
        ],
        ),
      ),
    );
  }
}
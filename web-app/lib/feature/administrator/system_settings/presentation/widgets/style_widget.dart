
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:class_compass/common/widget/custom_contaner.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class ColorPickerField extends StatefulWidget {
  final Color initialColor;
  final ValueChanged<Color> onChanged;
  final String? label;
  final String? heading;

  const ColorPickerField({super.key, required this.initialColor, required this.onChanged, this.label, this.heading});

  @override
  State<ColorPickerField> createState() => _ColorPickerFieldState();
}

class _ColorPickerFieldState extends State<ColorPickerField> {
  late Color _color;

  @override
  void initState() {
    super.initState();
    _color = widget.initialColor;
  }

  Future<void> _openPicker() async {
    Color temp = _color;
    final TextEditingController hexController = TextEditingController(
      text: temp.toARGB32().toRadixString(16).padLeft(8, '0').substring(2).toUpperCase(),
    );

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            void updateFromHex(String hex) {
              try {
                if (hex.length == 6) {
                  final newColor = Color(int.parse("FF$hex", radix: 16));
                  temp = newColor;
                  setDialogState(() {});
                }
              } catch (_) {}
            }

            return AlertDialog(
              title: Text(widget.label ?? 'Pick a color'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ColorPicker(
                      pickerColor: temp,
                      onColorChanged: (c) {
                        temp = c;
                        hexController.text = temp
                            .toARGB32()
                            .toRadixString(16)
                            .padLeft(8, '0')
                            .substring(2)
                            .toUpperCase();

                        setDialogState(() {});
                      },
                      pickerAreaHeightPercent: 0.7,
                      enableAlpha: false,
                    ),

                    const SizedBox(height: 16),

                    /// HEX INPUT
                    TextField(
                      controller: hexController,
                      maxLength: 6,
                      decoration: const InputDecoration(
                        labelText: "HEX Code",
                        prefixText: "#",
                        border: OutlineInputBorder(),
                        counterText: "",
                      ),
                      onChanged: (value) {
                        updateFromHex(value.toUpperCase());
                      },
                    ),

                    const SizedBox(height: 8),

                    /// COPY BUTTON
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        icon: const Icon(Icons.copy),
                        label: const Text("Copy HEX"),
                        onPressed: () {
                          final hex = hexController.text.toUpperCase();
                          Clipboard.setData(ClipboardData(text: "#$hex"));

                          Get.snackbar(
                            "Copied",
                            "#$hex copied to clipboard",
                            snackPosition: SnackPosition.BOTTOM,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel'),
                ),
                FilledButton(
                  onPressed: () {
                    setState(() => _color = temp);
                    widget.onChanged(_color);
                    Navigator.pop(context);
                  },
                  child: const Text('Select'),
                ),
              ],
            );
          },
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final border = BorderRadius.circular(10);
    return Padding(padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeDefault),
      child: InkWell(onTap: _openPicker, borderRadius: border,
        child: CustomContainer(showShadow: false,
          border: Border.all(color: Theme.of(context).hintColor, width: .5),
          borderRadius: Dimensions.paddingSizeExtraSmall,
          child: Row(children: [
            Text("${widget.heading ?? widget.label ?? 'sidebar_color'.tr}: ",
                style: textRegular.copyWith(fontSize: 14, color: Theme.of(context).hintColor)),

            CustomContainer(width: 28, height: 28,color: _color, showShadow: false,
              borderRadius: 5,),
            const SizedBox(width: 12),
            Expanded(child: Text('#${_color.toARGB32().toRadixString(16).padLeft(8, '0').toUpperCase()}',
                style: textRegular.copyWith(fontFeatures: [const FontFeature.tabularFigures()])),
            ),
            const Icon(Icons.color_lens_outlined),
          ],
          ),
        ),
      ),
    );
  }
}

import 'package:get/get.dart';
import 'package:html_editor_enhanced/html_editor.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:class_compass/common/widget/custom_rich_text_editor_widget/latex_dialog.dart';
import 'package:class_compass/common/widget/custom_snackbar.dart';
import 'package:class_compass/feature/profile/logic/profile_controller.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';

class CustomRichEditor extends StatefulWidget {
  final HtmlEditorController? controller;
  final Color? toolbarColor;
  final String? title;
  final String? hintText;
  final bool required;
  final double? height; // Optional height
  final bool showToolbar;

  const CustomRichEditor({
    super.key,
    required this.controller,
    this.toolbarColor,
    this.title,
    this.hintText,
    this.required = false,
    this.height,
    this.showToolbar = true,
  });

  @override
  State<CustomRichEditor> createState() => _CustomRichEditorState();
}

class _CustomRichEditorState extends State<CustomRichEditor> {
  static const double _defaultEditorHeight = 100.0;

  Future<void> _pickAndUploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final url = await Get.find<ProfileController>().uploadImage(pickedFile);
      widget.controller?.insertNetworkImage(url);
    }
  }

  void _showLatexDialog() {
    if (widget.controller == null) {
      Get.snackbar(
        'Error',
        'Editor controller is not available',
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return LatexDialog(
          onLatexInserted: (String latexCode) async {
            try {
              if (latexCode.trim().isEmpty) {
                Get.snackbar(
                  'Error',
                  'LaTeX code cannot be empty',
                  snackPosition: SnackPosition.BOTTOM,
                  backgroundColor: Colors.red,
                  colorText: Colors.white,
                );
                return;
              }

              final htmlLatex =
                  '<span class="latex">\\(${latexCode.replaceAll('\\', '\\\\')}\\)</span>';
              widget.controller?.insertHtml(htmlLatex);
              final html = await widget.controller?.getText();
              if (html != null) {
                widget.controller?.setText(html);
              }
              showCustomSnackBar('LaTeX formula inserted successfully',
                  isError: false);
            } catch (e) {
              showCustomSnackBar("Failed to insert LaTeX formula");
            }
          },
        );
      },
    );
  }

  void _expandEditorDialog() {
    if (widget.controller == null) return;
    FocusManager.instance.primaryFocus?.unfocus();

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          insetPadding: const EdgeInsets.all(10),
          child: Container(
            padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
            color: Theme.of(context).cardColor,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with title and close button
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title ?? "Rich Editor",
                      style: textRegular.copyWith(
                        fontSize: Dimensions.fontSizeLarge,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                // Expanded editor
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: HtmlEditor(
                    controller: widget.controller!,
                    htmlEditorOptions: HtmlEditorOptions(
                      hint: widget.hintText ?? 'Write something...',
                      autoAdjustHeight: true,
                      adjustHeightForKeyboard: true,
                      darkMode: Get.isDarkMode,
                    ),
                    htmlToolbarOptions: const HtmlToolbarOptions(
                      toolbarType: ToolbarType.nativeScrollable,
                      defaultToolbarButtons: [],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final double toolbarHeight = widget.showToolbar ? 50.0 : 0.0;
    final double editorHeight = widget.height ?? _defaultEditorHeight;
    final double totalHeight = toolbarHeight + editorHeight;

    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      if (widget.title != null)
        Text.rich(TextSpan(children: [
          TextSpan(text: widget.title!,
            style: textRegular.copyWith(fontSize: Dimensions.fontSizeLarge)),

        ])),
      const SizedBox(height: Dimensions.paddingSizeSmall),
      Stack(
        children: [
            Column(
              children: [
                if (widget.showToolbar)
                  Container(
                    height: toolbarHeight,
                    decoration: BoxDecoration(
                      border: Border(
                        top: BorderSide(
                            color: Theme.of(context).disabledColor, width: 0.5),
                        left: BorderSide(
                            color: Theme.of(context).disabledColor, width: 0.5),
                        right: BorderSide(
                            color: Theme.of(context).disabledColor, width: 0.5),
                      ),
                      color: widget.toolbarColor ?? Theme.of(context).hoverColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(Dimensions.radiusDefault),
                      ),
                    ),
                  ),
                Container(
                  height: editorHeight,
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius: widget.showToolbar
                        ? const BorderRadius.vertical(
                      bottom: Radius.circular(Dimensions.radiusDefault),
                    )
                        : BorderRadius.circular(Dimensions.radiusDefault),
                    border: Border.all(
                        color: Theme.of(context).disabledColor, width: 0.5),
                  ),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                FocusManager.instance.primaryFocus?.unfocus();
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  Future.delayed(const Duration(milliseconds: 200), () {
                    widget.controller?.setFocus();
                  });
                });
              },
              child: SizedBox(
                height: totalHeight,
                child: HtmlEditor(

                  controller: widget.controller!,
                  htmlEditorOptions: HtmlEditorOptions(
                    hint: widget.hintText ?? 'Write something...',
                    spellCheck: true,
                    autoAdjustHeight: true,
                    adjustHeightForKeyboard: false,
                    darkMode: Get.isDarkMode,
                    shouldEnsureVisible: false,
                    initialText: "",
                    characterLimit: null,
                    disabled: false,
                  ),
                  otherOptions: OtherOptions(

                      decoration: BoxDecoration(
                    border: Border.all(color: Theme.of(context).disabledColor, width: 0.5),),
                    height: editorHeight),
                  callbacks: Callbacks(
                    onInit: () {},
                    onFocus: () {},
                    onBlur: () {},
                    onChangeContent: (String? changed) {},
                  ),
                  htmlToolbarOptions: widget.showToolbar
                      ? HtmlToolbarOptions(
                    initiallyExpanded: true,
                    buttonColor:
                    Theme.of(context).textTheme.bodyLarge!.color,
                    toolbarType: ToolbarType.nativeScrollable,
                    renderSeparatorWidget: false,
                    dropdownBackgroundColor:
                    Theme.of(context).cardColor,
                    dropdownIconColor:
                    Theme.of(context).disabledColor,
                    textStyle: textRegular.copyWith(
                      color: Theme.of(context).textTheme.bodyLarge!.color,
                    ),
                    dropdownBoxDecoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      border: Border.all(
                          color: Theme.of(context).disabledColor),
                      borderRadius:
                      BorderRadius.circular(Dimensions.radiusDefault),
                    ),
                    defaultToolbarButtons: [
                      const FontSettingButtons(
                          fontSizeUnit: false, fontName: false),
                      const FontButtons(
                          subscript: false,
                          superscript: false,
                          clearAll: true),
                      const ListButtons(
                          ul: true, ol: true, listStyles: false),
                      const ColorButtons(highlightColor: true),
                      const ParagraphButtons(
                        caseConverter: false,
                        alignLeft: true,
                        alignCenter: true,
                        alignRight: true,
                        alignJustify: true,
                        increaseIndent: false,
                        decreaseIndent: false,
                        textDirection: false,
                        lineHeight: false,
                      ),
                      const InsertButtons(
                        hr: false,
                        audio: false,
                        video: false,
                        picture: false,
                        table: false,
                      ),
                    ],
                    customToolbarButtons: [
                      IconButton(
                        onPressed: () => widget.controller!.undo(),
                        icon: Icon(Icons.undo,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color),
                      ),
                      IconButton(
                        onPressed: () => widget.controller!.redo(),
                        icon: Icon(Icons.redo,
                            color: Theme.of(context)
                                .textTheme
                                .bodyLarge!
                                .color),
                      ),
                      IconButton(
                        icon: const Icon(Icons.image, size: 20),
                        tooltip: "Upload Image",
                        onPressed: _pickAndUploadImage,
                      ),
                      IconButton(
                        icon: const Icon(Icons.functions, size: 20),
                        tooltip: "Insert LaTeX",
                        onPressed: _showLatexDialog,
                      ),
                      IconButton(
                        icon: const Icon(Icons.open_in_full, size: 20),
                        tooltip: "Expand Editor",
                        onPressed: _expandEditorDialog,
                      ),
                    ],
                  )
                      : const HtmlToolbarOptions(
                    toolbarType: ToolbarType.nativeScrollable,
                    defaultToolbarButtons: [],
                    customToolbarButtons: [],
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

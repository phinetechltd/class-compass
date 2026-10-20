import 'package:flutter/material.dart';
import 'package:class_compass/helper/app_color_helper.dart';
import 'package:class_compass/util/dimensions.dart';
import 'package:class_compass/util/styles.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LatexDialog extends StatefulWidget {
  final Function(String) onLatexInserted;

  const LatexDialog({
    super.key,
    required this.onLatexInserted,
  });

  @override
  State<LatexDialog> createState() => _LatexDialogState();
}

class _LatexDialogState extends State<LatexDialog> {
  final TextEditingController _latexController = TextEditingController();
  String _previewLatex = '';
  bool _isValidLatex = false;

  @override
  void initState() {
    super.initState();
    _latexController.addListener(_updatePreview);
  }

  @override
  void dispose() {
    _latexController.dispose();
    super.dispose();
  }

  void _updatePreview() {
    setState(() {
      _previewLatex = _latexController.text.trim();
      _isValidLatex = _previewLatex.isNotEmpty;
    });
  }

  void _insertLatex() {
    if (_isValidLatex) {
      final latexCode = _latexController.text.trim();
      widget.onLatexInserted(latexCode);
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
      ),
      child: Container(
        constraints: const BoxConstraints(maxWidth: 500, maxHeight: 600),
        padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Insert LaTeX',
                    style: textBold.copyWith(
                      fontSize: Dimensions.fontSizeLarge,
                      color: systemPrimaryColor(),
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.of(context).pop(),
                    icon: Icon(
                      Icons.close,
                      color: Theme.of(context).hintColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              // LaTeX Input
              Text(
                'Enter LaTeX Code:',
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: systemPrimaryColor(),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              TextField(
                controller: _latexController,
                maxLines: 3,
                decoration: InputDecoration(
                  hintText: 'e.g., \\frac{a}{b} or \\sqrt{x^2 + y^2}',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    borderSide: BorderSide(color: systemPrimaryColor()),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),

              // Preview Section
              if (_isValidLatex) ...[
                Text(
                  'Preview:',
                  style: textMedium.copyWith(
                    fontSize: Dimensions.fontSizeDefault,
                    color: systemPrimaryColor(),
                  ),
                ),
                const SizedBox(height: Dimensions.paddingSizeSmall),
                _buildLatexPreview(_previewLatex),
                const SizedBox(height: Dimensions.paddingSizeDefault),
              ],

              // Common LaTeX Examples
              Text(
                'Common Examples:',
                style: textMedium.copyWith(
                  fontSize: Dimensions.fontSizeDefault,
                  color: systemPrimaryColor(),
                ),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Wrap(
                spacing: Dimensions.paddingSizeSmall,
                runSpacing: Dimensions.paddingSizeTiny,
                children: [
                  _buildExampleChip('\\frac{a}{b}', 'Fraction'),
                  _buildExampleChip('\\sqrt{x}', 'Square Root'),
                  _buildExampleChip('x^2', 'Power'),
                  _buildExampleChip('\\sum_{i=1}^{n}', 'Sum'),
                  _buildExampleChip('\\int_{a}^{b}', 'Integral'),
                  _buildExampleChip('\\alpha', 'Greek Letter'),
                  _buildExampleChip('\\pi', 'Pi'),
                  _buildExampleChip('\\theta', 'Theta'),
                  _buildExampleChip('\\infty', 'Infinity'),
                  _buildExampleChip('\\pm', 'Plus Minus'),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeLarge),

              // Action Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      'Cancel',
                      style: textMedium.copyWith(
                        color: Theme.of(context).hintColor,
                      ),
                    ),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  ElevatedButton(
                    onPressed: _isValidLatex ? _insertLatex : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: systemPrimaryColor(),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                      ),
                    ),
                    child: Text(
                      'Insert',
                      style: textMedium.copyWith(color: Colors.white),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildExampleChip(String latex, String label) {
    return InkWell(
      onTap: () {
        _latexController.text = latex;
      },
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: Dimensions.paddingSizeSmall,
          vertical: Dimensions.paddingSizeTiny,
        ),
        decoration: BoxDecoration(
          color: systemPrimaryColor().withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
          border: Border.all(
            color: systemPrimaryColor().withValues(alpha: 0.3),
          ),
        ),
        child: Column(
          children: [
            Text(
              latex,
              style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: systemPrimaryColor(),
              ),
            ),
            Text(
              label,
              style: textRegular.copyWith(
                fontSize: Dimensions.fontSizeSmall,
                color: Theme.of(context).hintColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatexPreview(String latex) {
    final html = '''
    <!DOCTYPE html>
    <html>
    <head>
      <meta charset="utf-8">
      <script src="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"></script>
      <style>
        body { margin: 0; padding: 0; background: transparent; }
        .math { font-size: 1.5em; text-align: center; margin-top: 20px; }
      </style>
    </head>
    <body>
      <div class="math">\\[ $latex \\]</div>
    </body>
    </html>
    ''';

    final controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString(html);

    return SizedBox(
      height: 100,
      child: WebViewWidget(controller: controller),
    );
  }
} 
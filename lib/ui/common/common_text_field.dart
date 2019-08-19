import 'package:flutter/material.dart';

class CommonTextField extends StatefulWidget {
  final String hint;
  final String label;
  final String initialValue;
  final FormFieldValidator<String> validator;
  final bool obscureText;
  final IconData suffixIcon;
  final TextInputType keyboardType;
  final int maxLines;
  final ValueChanged<String> onChanged;

  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController] and
  /// initialize its [TextEditingController.text] with [initialValue].
  final TextEditingController controller;

  @override
  _CommonTextFieldState createState() => _CommonTextFieldState();

  CommonTextField({
    this.hint,
    this.label,
    this.validator,
    this.initialValue,
    this.controller,
    this.obscureText = false,
    this.suffixIcon,
    this.keyboardType,
    this.maxLines = 1,
    this.onChanged,
  });
}

class _CommonTextFieldState extends State<CommonTextField> {
  TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    if (widget.controller == null) {
      _controller = TextEditingController(text: widget.initialValue);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          obscureText: widget.obscureText,
          controller: widget.controller ?? _controller,
          keyboardType: widget.keyboardType,
          maxLines: widget.maxLines,
          onChanged: widget.onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            filled: true,
            hintText: widget.hint,
            labelText: widget.label,
            suffixIcon: Icon(widget.suffixIcon),
          ),
        ),
      ),
    );
  }
}

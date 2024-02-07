import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField(
      {super.key,
      this.type,
      this.suffixText,
      required this.label,
      required this.controller,
      this.maxLines,
      this.suffixIcon});
  final String label;
  final TextEditingController controller;
  final TextInputType? type;
  final int? maxLines;
  final IconButton? suffixIcon;
  final String? suffixText;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: TextFormField(
        //key: ValueKey(uuid.v1()),
        controller: controller,
        keyboardType: type,
        maxLines: maxLines,
        validator: (String? data) {
          if (data == null || data.isEmpty) {
            return 'Please Fill This Form';
          }
          return null;
        },
        enableInteractiveSelection: false,
        decoration: InputDecoration(
          constraints: BoxConstraints.tight(const Size.fromHeight(65)),
          labelText: label,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          suffixIcon: suffixIcon,
          suffixText: suffixText,
        ),
      ),
    );
  }
}

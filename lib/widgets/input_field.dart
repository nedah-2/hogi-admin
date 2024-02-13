import 'package:flutter/material.dart';
import 'package:hogi_milk_admin/models/constant.dart';

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
        onChanged: (String str) {
          controller.text = formatAmount(str.replaceAll(',', ''));
        },
        validator: (String? data) {
          if (data == null || data.isEmpty) {
            showMessage(context, 'Please fill all forms');
          }
          return null;
        },
        enableInteractiveSelection: false,

        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          isDense: true,
          contentPadding: const EdgeInsets.all(8),
          constraints: BoxConstraints.tight(const Size.fromHeight(65)),
          hintText: label,
          border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(10))),
          suffixIcon: suffixIcon,
          suffixText: suffixText,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String label;
  final String? hintText;
  final String? initialValue;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CustomTextFormField({
    required this.label,
    this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.obscureText,
    this.initialValue,
    this.onSaved,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    var theme = Theme.of(context);

    return TextFormField(
      obscureText: obscureText ?? false,
      initialValue: initialValue,
      decoration: InputDecoration(
        label: Text(label),
        hintText: hintText,
        hintStyle: const TextStyle(
          fontFamily: 'roboto',
          fontSize: 16,
          color: Colors.black,
          fontWeight: FontWeight.w400,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.3)),
          borderRadius:BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.withOpacity(0.8)),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      controller: controller,
      keyboardType: keyboardType,
      validator: validator,
      onSaved: onSaved,
    );
  }
}

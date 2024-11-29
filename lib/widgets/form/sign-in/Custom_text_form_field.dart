import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {final String? hintText;
  final IconData? icon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final TextEditingController? controller;
  final FormFieldValidator<String>? validator;
  final FormFieldSetter<String>? onSaved;

  const CustomTextFormField({
    this.hintText,
    this.keyboardType,
    this.controller,
    this.validator,
    this.obscureText,
    this.icon,
    this.onSaved,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 5,
            blurRadius: 7,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: Colors.grey, size: 20),
              const SizedBox(width: 10),
              Expanded(
                child: TextFormField(
                  obscureText: obscureText ?? false,
                  controller: controller,
                  keyboardType: keyboardType,
                  validator: validator,
                  decoration: InputDecoration(
                    hintText: hintText,
                    border: InputBorder.none,
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  onSaved: onSaved,
                ),
              ),
            ],
          ),

        ],
      ),
    );
  }
}

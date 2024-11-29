import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function? onPressed;
  final Icon icon;
  const CustomIconButton({required this.onPressed, required this.icon, super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed != null ? onPressed as void Function()? : () {},
      customBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
      ),
      child: Ink(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: icon,
      ),
    );
  }
}

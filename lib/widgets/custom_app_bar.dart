import 'package:flutter/material.dart';

import 'custom_icon_button.dart';

class CustomAppBar extends StatelessWidget {
  final Icon? leftIcon;
  final Icon? rightIcon;
  final Function? leftIconPressed;
  final Function? rightIconPressed;
  const CustomAppBar({required this.leftIcon, required this.rightIcon, this.leftIconPressed, this.rightIconPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: MediaQuery.of(context).padding.top, left: 25, right: 25),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomIconButton(
            onPressed: leftIconPressed,
            icon: leftIcon ?? const Icon(null),
          ),

          CustomIconButton(
            onPressed: rightIconPressed,
            icon: rightIcon ?? const Icon(null),
          ),
        ],
      ),
    );
  }
}

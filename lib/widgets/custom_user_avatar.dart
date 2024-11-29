import 'package:flutter/material.dart';

class CustomUserAvatar extends StatelessWidget {
  final ImageProvider image;
  final double size;
  const CustomUserAvatar({required this.image, required this.size, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Image(image: image, width: size, height: size),
    );
  }
}

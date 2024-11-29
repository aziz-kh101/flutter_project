import 'package:flutter/material.dart';

class CustomSlider extends StatelessWidget {
  final double value;
  final double max;
  final Function(double) onChanged;
  final Color color;
  const CustomSlider({super.key, required this.value, required this.max, required this.onChanged, required this.color});

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
          trackShape: CustomTrackShape(),
      ), child: Slider(max: 5,  onChanged: onChanged, activeColor: color, value: value,),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {
  @override
  Rect getPreferredRect({
    required RenderBox parentBox,
    Offset offset = Offset.zero,
    required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight!;
    final double trackLeft = offset.dx;
    final double trackTop = offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

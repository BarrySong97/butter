import 'package:flutter/material.dart';
import 'package:rotated_corner_decoration/rotated_corner_decoration.dart';

class HeatMapDay extends StatelessWidget {
  final int value;
  final double size;
  final Map<int, Color> thresholds;
  final bool chcked;
  final Color defaultColor;
  final int currentDay;
  final double opacity;
  final Duration animationDuration;
  final Color textColor;
  final FontWeight fontWeight;

  const HeatMapDay(
      {Key? key,
      required this.value,
      required this.chcked,
      required this.size,
      required this.thresholds,
      this.defaultColor = Colors.black12,
      required this.currentDay,
      this.opacity = 0.3,
      this.animationDuration = const Duration(milliseconds: 300),
      this.textColor: Colors.black,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  /// Loop for getting the right color based on [thresholds] values
  ///
  /// If the [value] is greater than or equal one of [thresholds]' key,
  /// it will receive its value
  Color getColorFromThreshold() {
    Color color = defaultColor;
    if (chcked) {
      color = thresholds[1]!;
    }

    return value == 0 ? Colors.transparent : color;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: size,
      width: size,
      color: getColorFromThreshold(),
      margin: EdgeInsets.all(2.0),
      foregroundDecoration: value == 1
          ? const RotatedCornerDecoration(
              color: Colors.blue,
              geometry:
                  const BadgeGeometry(width: 4, height: 4, cornerRadius: 0),
            )
          : null,
      child: AnimatedOpacity(
        opacity: opacity,
        duration: animationDuration,
        child: Text(
          value == 0 ? '' : value.toString(),
          style: TextStyle(
              fontWeight: fontWeight, color: Colors.white, fontSize: size - 7),
        ),
      ),
    );
  }
}

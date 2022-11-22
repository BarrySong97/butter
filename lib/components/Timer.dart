import 'dart:developer';

import 'package:flutter/material.dart';

class Timer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: TimerPainter());
  }
}

class TimerPainter extends CustomPainter {
  final TextPainter textPainter = TextPainter(
    textAlign: TextAlign.center,
    textDirection: TextDirection.ltr,
  );
  TextStyle get commonStyle => TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w100,
        fontFamily: 'IBMPlexMono',
        color: const Color(0xff343434),
      );
  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(canvas, size);
    _drawTimeText(canvas, size);
  }

  void _drawCircle(Canvas canvas, Size size) {
    canvas.translate(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = Colors.blue
      ..strokeWidth = 2;
    // 绘制圆
    canvas.drawCircle(Offset(0, 0), 100, paint);
  }

  void _drawTimeText(Canvas canvas, Size size) {
    textPainter.text = TextSpan(
        text: '10:12:', style: commonStyle, children: [TextSpan(text: '32')]);
    textPainter.layout(); // 进行布局
    final double width = textPainter.size.width;
    final double height = textPainter.size.height;
    textPainter.paint(canvas, Offset(-width / 2, -height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

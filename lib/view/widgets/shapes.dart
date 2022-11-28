import 'package:flutter/material.dart';

class MyPainter extends CustomPainter {
  final Color bodyColor;

  final Color borderColor;

  final double borderWith;

  MyPainter(this.bodyColor, this.borderColor, this.borderWith);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint body = Paint();
    body
      ..color = bodyColor
      ..style = PaintingStyle.fill
      ..strokeWidth = 0;

    final Paint border = Paint();
    border
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderWith;

    final double width = size.width;
    final double height = size.height;

    final Path path = Path();
    path.moveTo(0.5 * width, height * 0.4);
    path.cubicTo(0.2 * width, height * 0.1, -0.25 * width, height * 0.6,
        0.5 * width, height);
    path.moveTo(0.5 * width, height * 0.4);
    path.cubicTo(0.8 * width, height * 0.1, 1.25 * width, height * 0.6,
        0.5 * width, height);

    canvas.drawPath(path, body);
    canvas.drawPath(path, border);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

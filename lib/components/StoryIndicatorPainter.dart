import 'package:flutter/material.dart';
import 'package:textz/main.dart';

class StoryIndicatorPainter extends CustomPainter {
  final int numSegments;
  final double strokeWidth;
  final Color color;

  StoryIndicatorPainter({
    required this.numSegments,
    this.strokeWidth = 3.0,
    this.color = blueAppColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    double radius = size.width / 2;
    double segmentAngle = (2 * 3.141592653589793) / numSegments;

    for (int i = 0; i < numSegments; i++) {
      double startAngle = i * segmentAngle;
      double sweepAngle = segmentAngle - 0.1; // Small gap between segments

      Paint paint = Paint()
        ..color = color
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth;

      canvas.drawArc(
        Rect.fromCircle(center: Offset(radius, radius), radius: radius),
        startAngle,
        sweepAngle,
        false,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

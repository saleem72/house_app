//

import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';
import 'package:house_app/core/extensions/num_extension.dart';

class ProgressCircle extends StatelessWidget {
  const ProgressCircle({
    super.key,
    required this.percent,
  });
  final int percent;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 38,
      height: 38,
      // decoration:
      //     const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter: CircleBorderPainter(borderWidth: 4, percent: 20),
          ),
          _buildPercent(context),
        ],
      ),
    );
  }

  Widget _buildPercent(BuildContext context) {
    return Center(
      child: Text(
        '$percent%',
        style: context.textTheme.bodySmall?.copyWith(
          color: Colors.black,
          fontSize: 12,
        ),
      ),
    );
  }
}

class CircleBorderPainter extends CustomPainter {
  final double borderWidth;
  final int percent;
  CircleBorderPainter({
    required this.borderWidth,
    required this.percent,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final center = size.center(const Offset(0, 0));
    final radius = math.min(size.width, size.height) / 2 - borderWidth / 2;
    final rect = Rect.fromCircle(center: center, radius: radius);
    final painter = Paint()
      ..color = percent.percentColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    final bkPainter = Paint()
      ..color = Colors.grey.shade200
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    canvas.drawOval(rect, bkPainter);
    canvas.drawArc(rect, (270.0).toRadian(), ((percent * 360) / 100).toRadian(),
        false, painter);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

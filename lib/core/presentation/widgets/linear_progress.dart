//
import 'dart:math' as math;
import 'package:flutter/material.dart';

import 'package:house_app/core/extensions/build_context_extension.dart';
import 'package:house_app/core/extensions/int_extension.dart';

class LinearProgressBar extends StatelessWidget {
  const LinearProgressBar({
    super.key,
    required this.percent,
    this.borderWidth = 4,
  });
  final int percent;
  final double borderWidth;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: borderWidth + 32,
      // decoration:
      //     const BoxDecoration(color: Colors.green, shape: BoxShape.circle),
      child: Stack(
        children: [
          CustomPaint(
            size: Size.infinite,
            painter:
                LinearBorderPainter(borderWidth: borderWidth, percent: percent),
          ),
          _buildPercent(context),
        ],
      ),
    );
  }

  Widget _buildPercent(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            '$percent%',
            style: context.textTheme.bodySmall?.copyWith(
              color: Colors.black,
              // fontSize: 12,
              fontWeight: percent > 100 ? FontWeight.bold : FontWeight.w400,
            ),
          ),
        ),
        Text('100%')
      ],
    );
  }
}

class LinearBorderPainter extends CustomPainter {
  final double borderWidth;
  final int percent;
  LinearBorderPainter({
    required this.borderWidth,
    required this.percent,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = percent.percentColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderWidth;
    final bkPainter = Paint()
      ..color = Colors.grey.shade200
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    final level = size.height - borderWidth;
    final to = math
        .max(math.min(((percent / 100) * size.width), size.width), 0)
        .toDouble();
    canvas.drawLine(
      Offset(0, level),
      Offset(size.width, level),
      bkPainter,
    );
    canvas.drawLine(
      Offset(0, level),
      Offset(to, level),
      painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

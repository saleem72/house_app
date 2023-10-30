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
          LinearBorderPaint(
            borderWidth: borderWidth,
            percent: percent,
          ),
          _buildPercent(context),
        ],
      ),
    );
  }

  Widget _buildPercent(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$percent%',
          style: context.textTheme.bodySmall?.copyWith(
            color: Colors.black,
            // fontSize: 12,
            fontWeight: percent > 100 ? FontWeight.bold : FontWeight.w400,
          ),
          textAlign: TextAlign.center,
        ),
        const Text(
          '100%',
          textAlign: TextAlign.end,
        )
      ],
    );
  }
}

class LinearBorderPaint extends StatefulWidget {
  const LinearBorderPaint({
    super.key,
    required this.borderWidth,
    required this.percent,
  });

  final int percent;
  final double borderWidth;
  @override
  State<LinearBorderPaint> createState() => _LinearBorderPaintState();
}

class _LinearBorderPaintState extends State<LinearBorderPaint>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late CurvedAnimation _curve;
  late Animation<double> _persentage;
  @override
  void initState() {
    super.initState();
    _initAnimation();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  _initAnimation() {
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );
    _curve =
        CurvedAnimation(parent: _animationController, curve: Curves.easeInOut);
    _persentage =
        Tween<double>(begin: 0, end: widget.percent.toDouble()).animate(_curve);
    _animationController.forward();
  }

  @override
  void didUpdateWidget(covariant LinearBorderPaint oldWidget) {
    super.didUpdateWidget(oldWidget);
    _persentage = Tween<double>(
            begin: oldWidget.percent.toDouble(), end: widget.percent.toDouble())
        .animate(_curve);
    _animationController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _animationController,
        builder: (context, child) {
          return CustomPaint(
            size: Size.infinite,
            painter: LinearBorderPainter(
              borderWidth: widget.borderWidth,
              percent: _persentage.value,
              direction: context.currentDirection,
            ),
          );
        });
  }
}

class LinearBorderPainter extends CustomPainter {
  final double borderWidth;
  final double percent;
  final TextDirection direction;
  LinearBorderPainter({
    required this.borderWidth,
    required this.percent,
    required this.direction,
  });
  @override
  void paint(Canvas canvas, Size size) {
    final painter = Paint()
      ..color = percent.toInt().percentColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = borderWidth;
    final bkPainter = Paint()
      ..color = Colors.grey.shade200
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = borderWidth;
    final level = size.height - borderWidth;
    final diff = math
        .max(math.min(((percent / 100) * size.width), size.width), 0)
        .toDouble();

    final Offset from = direction == TextDirection.rtl
        ? Offset(size.width, level)
        : Offset(0, level);
    final Offset to = direction == TextDirection.rtl
        ? Offset(size.width - diff, level)
        : Offset(diff, level);
    canvas.drawLine(
      Offset(0, level),
      Offset(size.width, level),
      bkPainter,
    );
    canvas.drawLine(
      from,
      to,
      painter,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

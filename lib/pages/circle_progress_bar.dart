import 'dart:math' as math;

import 'package:flutter/material.dart';

class CircularProgressBar extends StatefulWidget {
  final double width;
  final double height;
  final double progressPercent;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;
  final int animationDurationInSeconds;

  CircularProgressBar({
    required this.width,
    required this.height,
    required this.progressPercent,
    required this.progressColor,
    required this.backgroundColor,
    this.strokeWidth = 10,
    this.animationDurationInSeconds = 5,
  });

  @override
  _CircularProgressBarState createState() => _CircularProgressBarState();
}

class _CircularProgressBarState extends State<CircularProgressBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();

    _progressController = AnimationController(
        vsync: this,
        duration: Duration(seconds: widget.animationDurationInSeconds));
    _progressAnimation = Tween(begin: 0.0, end: widget.progressPercent / 100)
        .animate(CurvedAnimation(
            parent: _progressController, curve: Curves.easeInOut))
      ..addListener(() {
        setState(() {});
      });

    _progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      height: widget.height,
      child: CustomPaint(
        foregroundPainter: CircularProgressBarPainter(
          progressPercent: _progressAnimation.value * 100,
          progressColor: widget.progressColor,
          backgroundColor: widget.backgroundColor,
          strokeWidth: widget.strokeWidth,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _progressController.dispose();
    super.dispose();
  }
}

class CircularProgressBarPainter extends CustomPainter {
  final double progressPercent;
  final Color progressColor;
  final Color backgroundColor;
  final double strokeWidth;

  CircularProgressBarPainter({
    required this.progressPercent,
    required this.progressColor,
    required this.backgroundColor,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..color = backgroundColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Paint progressPaint = Paint()
      ..color = progressColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = math.min(size.width / 2, size.height / 2);

    canvas.drawCircle(center, radius, bgPaint);

    double angle = 2 * math.pi * (progressPercent / 100);
    canvas.drawArc(Rect.fromCircle(center: center, radius: radius),
        -math.pi / 2, angle, false, progressPaint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

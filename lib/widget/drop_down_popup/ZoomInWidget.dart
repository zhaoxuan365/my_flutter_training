import 'package:flutter/material.dart';

class ZoomInWidget extends StatefulWidget {
  final Widget child;
  final Duration duration;
  final Duration delay;

  ///把控制器通过函数传递出去，可以在父组件进行控制
  final Function(AnimationController) controller;
  final bool manualTrigger;
  final bool animate;
  final double from;

  ///这是我自己写的 起点
  final Offset? offset;

  ZoomInWidget({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 300),
    this.delay = const Duration(milliseconds: 0),
    required this.controller,
    this.manualTrigger = false,
    this.animate = true,
    this.offset,
    this.from = 1.0,
  }) {
    if (manualTrigger == true) {
      throw FlutterError('If you want to use manualTrigger:true, \n\n'
          'Then you must provide the controller property, that is a callback like:\n\n'
          ' ( controller: AnimationController) => yourController = controller \n\n');
    }
  }

  @override
  State createState() => _ZoomInWidgetState();
}

/// State class, where the magic happens
class _ZoomInWidgetState extends State<ZoomInWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  bool disposed = false;
  late Animation<double> fade;
  late Animation<double> opacity;

  @override
  void dispose() async {
    disposed = true;
    controller.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();

    controller = AnimationController(duration: widget.duration, vsync: this);
    fade = Tween(begin: 0.0, end: widget.from).animate(
      CurvedAnimation(
        curve: Curves.easeOut,
        parent: controller,
      ),
    );

    opacity = Tween<double>(begin: 0.0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0, 0.65),
      ),
    );

    if (!widget.manualTrigger && widget.animate) {
      Future.delayed(widget.delay, () {
        if (!disposed) {
          controller.forward();
        }
      });
    }

    widget.controller(controller);
  }

  @override
  Widget build(BuildContext context) {
    if (widget.animate && widget.delay.inMilliseconds == 0) {
      controller.forward();
    }

    return AnimatedBuilder(
      animation: fade,
      builder: (BuildContext context, Widget? child) {
        return Transform.scale(
          origin: widget.offset,
          scale: fade.value,
          child: Opacity(
            opacity: opacity.value,
            child: widget.child,
          ),
        );
      },
    );
  }
}

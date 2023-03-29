import 'package:flutter/material.dart';

class Popup extends PopupRoute {
  final Duration _duration = const Duration(milliseconds: 300);
  Widget child;

  Popup({
    required this.child,
  });

  @override
  Color get barrierColor => Colors.transparent;

  @override
  bool get barrierDismissible => true;

  @override
  Duration get transitionDuration => _duration;


  @override
  String get barrierLabel => '';

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return child;
  }
}

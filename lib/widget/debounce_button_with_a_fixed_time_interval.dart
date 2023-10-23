import 'package:flutter/material.dart';
import 'dart:async';

/// 防止重复点击按钮, 每次点击过后, 经过固定的时间间隔后才会恢复可点击状态. 可修改为任意的可点击widget
class DebounceButtonWithAFixedTimeInterval extends StatefulWidget {
  final VoidCallback onPressed;
  final String text;
  final Duration debounceDuration;

  const DebounceButtonWithAFixedTimeInterval({super.key,
    required this.onPressed,
    required this.text,
    this.debounceDuration = const Duration(seconds: 1),
  });

  @override
  State createState() => _DebounceButtonWithAFixedTimeIntervalState();
}

class _DebounceButtonWithAFixedTimeIntervalState extends State<DebounceButtonWithAFixedTimeInterval> {
  bool _isButtonDisabled = false;
  Timer? _debounceTimer;

  void _enableButton() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isButtonDisabled
          ? null
          : () {
        if (_debounceTimer == null || !_debounceTimer!.isActive) {
          widget.onPressed();
          setState(() {
            _isButtonDisabled = true;
          });

          _debounceTimer = Timer(widget.debounceDuration, _enableButton);
        }
      },
      child: Text(widget.text),
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

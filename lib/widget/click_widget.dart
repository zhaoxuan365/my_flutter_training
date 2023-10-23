import 'package:flutter/material.dart';
import 'dart:async';

/// 可点击widget
/// 如果点击事件是非耗时操作, 那么默认每隔1秒才能再次响应点击事件, 即1秒内只会响应一次点击事件
/// 如果点击事件是耗时操作, 那么在耗时操作执行完毕之前, 不再响应点击事件
class ClickWidget extends StatefulWidget {
  bool isTimeConsumingOperation;
  final Future<void> Function()? onPressedTimeConsumingOperation;
  final VoidCallback? onPressed;
  final Widget child;
  final Duration debounceDuration;

  ClickWidget({
    super.key,
    required this.child,
    required this.isTimeConsumingOperation,
    this.onPressed,
    this.onPressedTimeConsumingOperation,
    this.debounceDuration = const Duration(seconds: 1),
  });

  @override
  State createState() => _ClickWidgetState();
}

class _ClickWidgetState extends State<ClickWidget> {
  bool _isButtonDisabled = false;
  Timer? _debounceTimer;

  void _enableButton() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  void _disableButton() {
    setState(() {
      _isButtonDisabled = true;
    });
  }

  void _onButtonPressed() async {
    if (widget.isTimeConsumingOperation) {
      // 耗时操作
      if (!_isButtonDisabled) {
        _disableButton(); // 先禁用按钮

        // 调用传入的耗时操作
        await widget.onPressedTimeConsumingOperation?.call();

        // 耗时操作完成后，再次启用按钮
        _enableButton();
      }
      return;
    }

    // 非耗时操作
    if (_debounceTimer == null || !_debounceTimer!.isActive) {
      widget.onPressed?.call();
      _disableButton();
      // 经过widget.debounceDuration时间间隔后, 再次启用按钮
      _debounceTimer = Timer(widget.debounceDuration, _enableButton);
    }
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _isButtonDisabled ? null : _onButtonPressed,
      child: widget.child,
    );
  }

  @override
  void dispose() {
    _debounceTimer?.cancel();
    super.dispose();
  }
}

import 'package:flutter/material.dart';

class DebounceButtonWithIndeterminateTimeInterval extends StatefulWidget {
  final Future<void> Function() timeConsumingOperation;

  const DebounceButtonWithIndeterminateTimeInterval(
      {super.key, required this.timeConsumingOperation});

  @override
  State createState() => _DebounceButtonWithIndeterminateTimeIntervalState();
}

class _DebounceButtonWithIndeterminateTimeIntervalState
    extends State<DebounceButtonWithIndeterminateTimeInterval> {
  bool _isButtonDisabled = false;

  void _enableButton() {
    setState(() {
      _isButtonDisabled = false;
    });
  }

  void _onButtonPressed() async {
    setState(() {
      _isButtonDisabled = true;
    });

    // 调用传入的耗时操作
    await widget.timeConsumingOperation();

    // 接口请求完成后，再次启用按钮
    _enableButton();
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: _isButtonDisabled ? null : _onButtonPressed,
      child: const Text(
        '点击后执行耗时操作',
      ),
    );
  }
}

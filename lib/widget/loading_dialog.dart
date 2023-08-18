
import 'package:flutter/material.dart';

class LoadingDialog extends StatefulWidget {
  String text;

  LoadingDialog({
    super.key,
    required this.text,
  });

  @override
  State<LoadingDialog> createState() => _LoadingDialogState();

  static late BuildContext mContext;

  static void show({
    required String text,
    required BuildContext context,
  }) {
    showDialog(
      context: context,
      builder: (context) {
        mContext = context;
        return UnconstrainedBox(
          child: LoadingDialog(text: text),
        );
      },
    );
  }

  static void dismiss() {
    Navigator.pop(mContext);
  }
}

class _LoadingDialogState extends State<LoadingDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _turns;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this, // 防止屏幕外动画消耗资源
      duration: const Duration(milliseconds: 1500), // 设置动画时长
    )..repeat(); // 让动画重复播放

    _turns = Tween(begin: 0.0, end: 1.0).animate(_controller);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 124,
      height: 90,
      decoration: BoxDecoration(
        color: const Color(0xff666666),
        borderRadius: BorderRadius.circular(13),
      ),
      alignment: Alignment.center,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          RotationTransition(
            // 旋转动画
            turns: _turns,
            child: const Icon(
              Icons.refresh,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 12,
          ),
          Text(
            widget.text,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:my_flutter_training/widget/text_circle_progress_bar.dart';

class TextCircleProgressBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TextCircleProgressBarDemo'),
      ),
      body: const Center(
        child: TextCircularProgressBar(
          progress: 0.35, // 设置进度，取值范围为 0.0 到 1.0
          strokeWidth: 20, // 设置圆环的宽度
          backgroundColor: Colors.grey, // 设置圆环的背景色
          progressColor: Colors.blue, // 设置圆环的进度颜色
        ),
      ),
    );
  }
}

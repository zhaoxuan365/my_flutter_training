import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'circle_progress_bar.dart';

class CircleProgressBarDemo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CircleProgressBarDemo'),
      ),
      body: Center(
        child: CircularProgressBar(
          width: 150.0,
          height: 150.0,
          progressPercent: 100,
          progressColor: Colors.green,
          backgroundColor: Colors.green.withOpacity(0.5),
          strokeWidth: 13,
          animationDurationInSeconds: 10,
        ),
      ),
    );
  }
}

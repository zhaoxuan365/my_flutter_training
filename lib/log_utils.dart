import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class LogUtils {
  static late String _split;
  static late bool _isShowLogPrinting;
  static late int _limitLength;
  static late String _startLine;
  static late String _endLine;
  static const String timeFormat = 'yyyy-MM-dd HH:mm:ss';

  static void init({
    required bool isShowLogPrinting,
    String logFilterTag = '=========>>>',
    int limitLength = 800,
  }) {
    _split = logFilterTag;
    _isShowLogPrinting = isShowLogPrinting;
    _limitLength = limitLength;
    _startLine =
        "\n$_split日志打印开始: ${DateFormat(timeFormat).format(DateTime.now())}\n";
    _endLine =
        "\n$_split日志打印结束: ${DateFormat(timeFormat).format(DateTime.now())}\n";
  }

  /// You need to call the LogUtils.init() method first
  static void print(Object obj) {
    if (_isShowLogPrinting) {
      _print(obj.toString());
    }
  }

  static void _print(String msg) {
    debugPrint(_startLine);
    if (msg.length < _limitLength) {
      debugPrint('$_split$msg');
    } else {
      _splitLog(msg);
    }
    debugPrint(_endLine);
  }

  static void _splitLog(String msg) {
    var outStr = StringBuffer();
    for (var index = 0; index < msg.length; index++) {
      outStr.write(msg[index]);
      if (outStr.length == _limitLength) {
        debugPrint('$_split$outStr');
        outStr.clear();
      }
    }
    if (outStr.isNotEmpty) {
      debugPrint('$_split$outStr');
    }
  }
}

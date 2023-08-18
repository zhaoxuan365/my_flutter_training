
import 'package:flutter/material.dart';

class LoadingDialogOverlayEntry extends StatefulWidget {
  String text;

  // 私有化构造函数
  LoadingDialogOverlayEntry._({
    super.key,
    required this.text,
  });

  @override
  State<LoadingDialogOverlayEntry> createState() => _LoadingDialogOverlayEntryState();

  // 定义一个静态变量来存储唯一实例
  static LoadingDialogOverlayEntry? _instance;

  // 定义一个静态变量来存储OverlayEntry列表
  static final List<OverlayEntry> _overlayEntries = [];

  // 定义一个静态方法来返回实例
  static LoadingDialogOverlayEntry getInstance({
    Key? key,
    required String text,
  }) {
    // 如果实例为空，或者key不相同，就创建一个新的
    if (_instance == null || _instance!.key != key) {
      _instance = LoadingDialogOverlayEntry._(key: key, text: text);
    } else {
      _instance!.text = text;
    }
    // 返回实例
    return _instance!;
  }

  static void show({
    required String text,
    required BuildContext context,
  }) {
    // 使用getInstance()方法来获取实例
    var dialog = getInstance(text: text);
    // 创建一个新的OverlayEntry
    var overlayEntry = OverlayEntry(
      builder: (context) {
        return UnconstrainedBox(
          child: dialog,
        );
      },
    );
    // 将OverlayEntry添加到Overlay中
    Overlay.of(context).insert(overlayEntry);
    // 将OverlayEntry添加到列表中
    _overlayEntries.add(overlayEntry);
  }

  static void dismiss() {
    // 遍历列表，移除所有的OverlayEntry
    for (var overlayEntry in _overlayEntries) {
      overlayEntry.remove();
    }
    // 清空列表
    _overlayEntries.clear();
  }
}

class _LoadingDialogOverlayEntryState extends State<LoadingDialogOverlayEntry>
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

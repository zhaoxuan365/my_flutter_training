import 'package:flutter/material.dart';

import '../widget/drop_down_popup/Popup.dart';
import '../widget/drop_down_popup/PopupChild.dart';

class DropDownPopupDemo extends StatefulWidget {
  const DropDownPopupDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DropDownPopupDemoState();
  }
}

class _DropDownPopupDemoState extends State<DropDownPopupDemo> {
  ///给获取详细信息的widget设置一个key
  GlobalKey iconKey = GlobalKey();

  ///获取位置，给后续弹窗设置位置
  late Offset iconOffset;

  ///获取size 后续计算弹出位置
  late Size iconSize;

  ///接受弹窗类构造成功传递来的关闭参数
  late Function closeModel;

  @override
  Widget build(BuildContext context) {
    ///等待widget初始化完成
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      var currentContext = iconKey.currentContext;
      if (currentContext == null) {
        return;
      }
      var renderObject = currentContext.findRenderObject();
      if (renderObject == null) {
        return;
      }

      ///通过key获取到widget的位置
      RenderBox box = renderObject as RenderBox;

      ///获取widget的高宽
      iconSize = box.size;

      ///获取位置
      iconOffset = box.localToGlobal(Offset.zero);
    });

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            key: iconKey,
            icon: const Icon(
              Icons.favorite,
              color: Colors.red,
            ),
            onPressed: () {
              showModel(context);
            },
          ),
        ],
      ),
      body: const SizedBox(),
    );
  }

  ///播放动画
  void showModel(BuildContext context) {
    /// 设置传入弹窗的高宽
    // double _width = (MediaQuery.of(context).size.width);
    double height = 300;
    double width = 150;
    double marginHorizontal = 16;
    Navigator.push(
      context,
      Popup(
        child: PopupChild(
          left: width >= iconOffset.dx
              ? marginHorizontal
              : iconOffset.dx - width + iconSize.width / 1.2,
          top: iconOffset.dy + iconSize.height / 1.3,
          right: marginHorizontal,
          offset: Offset(width / 2, -height / 2),
          child: buildMenu(
            width,
            height,
          ),
          fun: (close) {
            closeModel = close;
          },
        ),
      ),
    );
  }

  ///构造传入的widget
  Widget buildMenu(double width, double height) {
    ///构造List
    List list = [1, 2, 3, 4, 5];

    return Stack(
      children: [
        SizedBox(
          width: width,
          height: height,
        ),
        Positioned(
          right: 0,
          top: 0,
          child: Container(
            width: 20,
            height: 20,
            transform: Matrix4.rotationZ(45 * 3.14 / 180),
            decoration: BoxDecoration(
              color: const Color.fromRGBO(46, 53, 61, 1),
              borderRadius: BorderRadius.circular(5),
            ),
          ),
        ),

        ///菜单内容
        Positioned(
          left: 0,
          top: 10,
          bottom: 0,
          right: 0,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            // width: width,
            // height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(46, 53, 61, 1),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: list
                  .map<Widget>(
                    (e) => InkWell(
                      child: Container(
                        width: double.infinity,
                        alignment: Alignment.center,
                        child: Text(
                          '选项${e.toString()}',
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                        ),
                      ),
                      onTap: () async {
                        await Future.delayed(const Duration(milliseconds: 10))
                            .then(
                          (value) => {
                            // todo
                          },
                        );
                        await closeModel();
                      },
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}

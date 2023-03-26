import 'dart:ui';

import 'package:flutter/material.dart';

import 'pages/drop_down_popup_demo.dart';
import 'widget_invallid/drop_down_menu_route.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'my_flutter_training',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'my_flutter_training'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: _body(),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body() {
    List<Widget> list = [];
    list.add(_item(
      text: 'drop down popup',
      tapCallback: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) {
              return const DropDownPopupDemo();
            },
          ),
        );
      },
    ));
    return ListView(
      padding: const EdgeInsets.all(16),
      children: list,
    );
  }

  void showPopup({required GlobalKey globalKey}) {
    var currentContext = globalKey.currentContext;
    if (currentContext == null) {
      return;
    }
    var renderObject = currentContext.findRenderObject();
    if (renderObject == null) {
      return;
    }
    RenderBox renderBox = renderObject as RenderBox;
    Rect box = renderBox.localToGlobal(Offset.zero) & renderBox.size;
    Navigator.push(
      context,
      DropDownMenuRoute(
        position: box,
        //弹窗位置信息
        menuWidth: 300,
        //弹窗宽度
        menuHeight: 200,
        //弹窗高度
        offset: 0,
        //偏移量
        itemView: _popup(),
      ),
    );
  }

  Widget _popup() {
    return Container(
      color: Colors.green,
    );
  }

  Widget _item({
    required String text,
    required GestureTapCallback tapCallback,
  }) {
    return InkWell(
      onTap: tapCallback,
      child: Container(
        width: double.infinity,
        height: 48,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.lightGreen,
        ),
        margin: const EdgeInsets.only(top: 16),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 18,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}

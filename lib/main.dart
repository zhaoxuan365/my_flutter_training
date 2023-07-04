import 'package:flutter/material.dart';
import 'package:my_flutter_training/pages/circle_progress_bar_demo.dart';

import 'pages/drop_down_menu_demo.dart';
import 'pages/drop_down_popup_demo.dart';
import 'pages/tab_bar_demo.dart';
import 'pages/text_circle_progress_bar_demo.dart';

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
    initData(list);
    return ListView(
      padding: const EdgeInsets.all(16),
      children: list,
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
          color: Colors.blue,
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

  void initData(List<Widget> list) {
    list.add(
      _item(
        text: 'drop down menu',
        tapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return const DropDownMenuDemo();
              },
            ),
          );
        },
      ),
    );

    list.add(
      _item(
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
      ),
    );

    list.add(
      _item(
        text: 'CircleProgressBar',
        tapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return CircleProgressBarDemo();
              },
            ),
          );
        },
      ),
    );

    list.add(
      _item(
        text: 'TextCircleProgressBar',
        tapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TextCircleProgressBarDemo();
              },
            ),
          );
        },
      ),
    );

    list.add(
      _item(
        text: 'TabBarDemo',
        tapCallback: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return TabBarDemo();
              },
            ),
          );
        },
      ),
    );
  }
}

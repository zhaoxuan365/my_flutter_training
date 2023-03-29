import 'package:flutter/material.dart';

import '../widget/drop_down_menu/drop_down_header.dart';
import '../widget/drop_down_menu/drop_down_menu.dart';
import '../widget/drop_down_menu/drop_down_menu_controller.dart';

class DropDownMenuDemo extends StatefulWidget {
  const DropDownMenuDemo({super.key});

  @override
  State<StatefulWidget> createState() {
    return _DropDownMenuDemoState();
  }
}

class _DropDownMenuDemoState extends State<DropDownMenuDemo> {
  final DropdownMenuController _dropdownMenuController =
      DropdownMenuController();
  final GlobalKey _stackKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('DropDownPopupDemo'),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return Stack(
      key: _stackKey,
      children: [
        Column(
          children: [
            DropDownHeader(
              items: [
                DropDownHeaderItem('left'),
                DropDownHeaderItem('right'),
              ],
              controller: _dropdownMenuController,
              stackKey: _stackKey,
            ),
            const Expanded(
              child: SizedBox(),
            ),
          ],
        ),
        DropDownMenu(
          controller: _dropdownMenuController,
          menus: [
            DropdownMenuBuilder(
              dropDownWidget: Container(
                color: Colors.green,
                margin: EdgeInsets.only(
                  left: 15,
                  right: (15 + (MediaQuery.of(context).size.width / 2)),
                ),
              ),
              dropDownHeight: 200,
            ),
            DropdownMenuBuilder(
              dropDownWidget: Container(
                color: Colors.yellow,
                child: CustomScrollView(
                  slivers: [
                    SliverAppBar(
                      automaticallyImplyLeading: false,
                      pinned: true,
                      elevation: 0,
                      flexibleSpace: Container(
                        width: double.infinity,
                        height: double.infinity,
                        color: Colors.black,
                      ),
                    ),
                    SliverFixedExtentList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(
                          alignment: Alignment.center,
                          child: Text('$index'),
                        ),
                        childCount: 20,
                      ),
                      itemExtent: 50,
                    ),
                  ],
                ),
              ),
              dropDownHeight: 300,
            ),
            // DropdownMenuBuilder(
            //   dropDownWidget: Container(
            //     color: Colors.yellow,
            //     child: Column(
            //       children: [
            //         Expanded(
            //           flex: 50 * 100 ~/ 300,
            //           child: Container(
            //             width: double.infinity,
            //             height: double.infinity,
            //             color: Colors.black,
            //           ),
            //         ),
            //         Expanded(
            //           flex: 100 - ((50 * 100 ~/ 300)),
            //           child: ListView.builder(
            //             itemCount: 20,
            //             itemExtent: 50,
            //             itemBuilder: (BuildContext context, int index) {
            //               return Container(
            //                 alignment: Alignment.center,
            //                 child: Text('$index'),
            //               );
            //             },
            //           ),
            //         ),
            //       ],
            //     ),
            //   ),
            //   dropDownHeight: 300,
            // ),
          ],
        ),
      ],
    );
  }
}

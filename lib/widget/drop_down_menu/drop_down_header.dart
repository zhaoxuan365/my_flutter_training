import 'package:flutter/material.dart';

import 'drop_down_menu_controller.dart';


/// Signature for when a tap has occurred.
typedef OnItemTap<T> = void Function(T value);

/// Dropdown header widget.
class DropDownHeader extends StatefulWidget {
  final Color headerBgColor;
  final Color? headerItemBgColor;
  final double headerItemBorderRadius;
  final double borderWidth;
  final Color borderColor;
  final TextStyle headerItemTextStyle;
  final TextStyle? headerItemDropDownTextStyle;
  final double iconSize;
  final Color iconColor;
  final Color? iconDropDownColor;
  final MainAxisAlignment headerItemMainAxisAlignment;

//  final List<String> menuStrings;
  final double height;

  // final double dividerHeight;
  // final double dividerWidth;
  // final Color dividerColor;
  final DropdownMenuController controller;
  final OnItemTap? onItemTap;
  final List<DropDownHeaderItem> items;
  final GlobalKey stackKey;

  /// Creates a dropdown header widget, Contains more than one header items.
  DropDownHeader({
    Key? key,
    required this.items,
    required this.controller,
    required this.stackKey,
    this.headerItemTextStyle =
        const TextStyle(color: Color(0xFF666666), fontSize: 13),
    this.headerItemDropDownTextStyle,
    this.height = 40,
    this.iconColor = const Color(0xFFafada7),
    this.iconDropDownColor,
    this.iconSize = 20,
    this.borderWidth = 1,
    this.borderColor = const Color(0xFFeeede6),
    // this.dividerHeight = 20,
    // this.dividerWidth = 1,
    // this.dividerColor = const Color(0xFFeeede6),
    this.onItemTap,
    this.headerBgColor = Colors.white,
    this.headerItemBgColor,
    this.headerItemBorderRadius = 8,
    this.headerItemMainAxisAlignment = MainAxisAlignment.center,
  }) : super(key: key);

  @override
  State createState() {
    return _DropDownHeaderState();
  }
}

class _DropDownHeaderState extends State<DropDownHeader>
    with SingleTickerProviderStateMixin {
  bool _isShowDropDownItemWidget = false;
  late double _screenWidth;
  late int _menuCount;
  final GlobalKey _keyDropDownHeader = GlobalKey();
  TextStyle? _dropDownStyle;
  Color? _iconDropDownColor;

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(_onController);
  }

  _onController() {
    if (mounted) {
      setState(() {});
    }
//    print(widget.controller.menuIndex);
  }

  @override
  Widget build(BuildContext context) {
    _screenWidth = MediaQuery.of(context).size.width;
    _menuCount = widget.items.length;
    _dropDownStyle = widget.headerItemDropDownTextStyle ??
        TextStyle(color: Theme.of(context).primaryColor, fontSize: 13);
    _iconDropDownColor =
        widget.iconDropDownColor ?? Theme.of(context).primaryColor;
//    print('_DropDownHeaderState.build');

    // var gridView = GridView.count(
    //   physics: const NeverScrollableScrollPhysics(),
    //   crossAxisCount: _menuCount,
    //   childAspectRatio: (_screenWidth / _menuCount) / widget.height,
    //   children: widget.items.map<Widget>((item) {
    //     return _menu(item);
    //   }).toList(),
    // );

    return Container(
      key: _keyDropDownHeader,
      height: widget.height,
      width: double.infinity,
//      padding: EdgeInsets.only(top: 1, bottom: 1),
      decoration: BoxDecoration(
        color: widget.headerBgColor,
        border: Border.symmetric(
          vertical: BorderSide(
            color: widget.borderColor,
            width: widget.borderWidth,
          ),
        ),
      ),
      child: Row(
        children: widget.items.map<Widget>((item) {
          return _menu(item);
        }).toList(),
      ),
      // child: gridView,
    );
  }

  @override
  dispose() {
    super.dispose();
  }

  _menu(DropDownHeaderItem item) {
    int index = widget.items.indexOf(item);
    int menuIndex = widget.controller.menuIndex;
    _isShowDropDownItemWidget = index == menuIndex && widget.controller.isShow;
    double itemWidth = _screenWidth / _menuCount;
    double itemHeight = widget.height;
    return Expanded(
      child: InkWell(
        onTap: () {
          final RenderBox? overlay =
              widget.stackKey.currentContext!.findRenderObject() as RenderBox?;
          final RenderBox dropDownItemRenderBox =
              _keyDropDownHeader.currentContext!.findRenderObject()
                  as RenderBox;
          var position = dropDownItemRenderBox.localToGlobal(Offset.zero,
              ancestor: overlay);
//        print("POSITION : $position ");
          var size = dropDownItemRenderBox.size;
//        print("SIZE : $size");

          widget.controller.dropDownMenuTop = size.height + position.dy;
          if (index == menuIndex) {
            if (widget.controller.isShow) {
              widget.controller.hide();
            } else {
              widget.controller.show(index);
            }
          } else {
            if (widget.controller.isShow) {
              widget.controller.hide(isShowHideAnimation: false);
            }
            widget.controller.show(index);
          }

          if (widget.onItemTap != null) {
            widget.onItemTap!(index);
          }

          setState(() {});
        },
        child: SizedBox(
          height: itemHeight,
          width: itemWidth,
          child: Center(
            child: SizedBox(
              width: itemWidth / 3 * 2,
              height: itemHeight / 3 * 2,
              child: Container(
                decoration: BoxDecoration(
                  color:
                      widget.headerItemBgColor ?? Colors.grey.withOpacity(0.4),
                  borderRadius:
                      BorderRadius.circular(widget.headerItemBorderRadius),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: Row(
                  mainAxisAlignment: widget.headerItemMainAxisAlignment,
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        item.title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: _isShowDropDownItemWidget
                            ? _dropDownStyle
                            : widget.headerItemTextStyle.merge(item.style),
                      ),
                    ),
                    Icon(
                      !_isShowDropDownItemWidget
                          ? item.iconData ?? Icons.arrow_drop_down
                          : item.iconDropDownData ??
                              item.iconData ??
                              Icons.arrow_drop_up,
                      color: _isShowDropDownItemWidget
                          ? _iconDropDownColor
                          : item.style?.color ?? widget.iconColor,
                      size: item.iconSize ?? widget.iconSize,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );

//     return GestureDetector(
//       onTap: () {
//         final RenderBox? overlay =
//             widget.stackKey.currentContext!.findRenderObject() as RenderBox?;
//
//         final RenderBox dropDownItemRenderBox =
//             _keyDropDownHeader.currentContext!.findRenderObject() as RenderBox;
//
//         var position =
//             dropDownItemRenderBox.localToGlobal(Offset.zero, ancestor: overlay);
// //        print("POSITION : $position ");
//         var size = dropDownItemRenderBox.size;
// //        print("SIZE : $size");
//
//         widget.controller.dropDownMenuTop = size.height + position.dy;
//
//         if (index == menuIndex) {
//           if (widget.controller.isShow) {
//             widget.controller.hide();
//           } else {
//             widget.controller.show(index);
//           }
//         } else {
//           if (widget.controller.isShow) {
//             widget.controller.hide(isShowHideAnimation: false);
//           }
//           widget.controller.show(index);
//         }
//
//         if (widget.onItemTap != null) {
//           widget.onItemTap!(index);
//         }
//
//         setState(() {});
//       },
//       child: Container(
//         color: widget.color,
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Expanded(
//               child: Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 child: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.grey.withOpacity(0.5),
//                     borderRadius: BorderRadius.circular(8),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Flexible(
//                         child: Text(
//                           item.title,
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                           style: _isShowDropDownItemWidget
//                               ? _dropDownStyle
//                               : widget.style.merge(item.style),
//                         ),
//                       ),
//                       Icon(
//                         !_isShowDropDownItemWidget
//                             ? item.iconData ?? Icons.arrow_drop_down
//                             : item.iconDropDownData ??
//                                 item.iconData ??
//                                 Icons.arrow_drop_up,
//                         color: _isShowDropDownItemWidget
//                             ? _iconDropDownColor
//                             : item.style?.color ?? widget.iconColor,
//                         size: item.iconSize ?? widget.iconSize,
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ),
//             index == widget.items.length - 1
//                 ? Container()
//                 : Container(
//                     height: widget.dividerHeight,
//                     decoration: BoxDecoration(
//                       border: Border(
//                         right: BorderSide(
//                           color: widget.dividerColor,
//                           width: widget.dividerWidth,
//                         ),
//                       ),
//                     ),
//                   ),
//           ],
//         ),
//       ),
//     );
  }
}

class DropDownHeaderItem {
  final String title;
  final IconData? iconData;
  final IconData? iconDropDownData;
  final double? iconSize;
  final TextStyle? style;

  DropDownHeaderItem(
    this.title, {
    this.iconData,
    this.iconDropDownData,
    this.iconSize,
    this.style,
  });
}

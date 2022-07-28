import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';

import '../bloc/homepage_ploc.dart';
import '../widgets/main_menu_item_widget.dart';

class MenuScreenPage extends StatelessWidget {
  final widthBox = SizedBox(
    width: 16.0,
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomePagePloc>(
      // initState: (_) => Get.find<DcRoomTypePloc>().getDcRoomTypeTableWidget(),
      builder: (_) => Scaffold(
        backgroundColor: Colors.blue,
        body: Container(
          child: SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 24.0, left: 24.0, right: 24.0),
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      bottom: 36.0, left: 24.0, right: 24.0),
                  child: Text(
                    "Server (VM) Data",
                    style: TextStyle(
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Selector<MenuProvider, int>(
                //   selector: (_, provider) => provider.currentPage,
                //   builder: (_, index, __) => Column(
                //     mainAxisSize: MainAxisSize.min,
                //     crossAxisAlignment: CrossAxisAlignment.start,
                //     children: <Widget>[
                //       ...widget.mainMenu
                //           .map((item) => MenuItemWidget(
                //                 key: Key(item.index.toString()),
                //                 item: item,
                //                 callback: widget.callback,
                //                 widthBox: widthBox,
                //                 style: style,
                //                 selected: index == item.index,
                //               ))
                //           .toList()
                //     ],
                //   ),
                // ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: _.mainMenu
                      .map((item) => MenuItemWidget(
                            key: Key(item.index.toString()),
                            item: item,
                            callback: item.callback,
                            widthBox: widthBox,
                            selected: false,
                          ))
                      .toList(),
                ),
                Spacer(),
                Padding(
                  padding: const EdgeInsets.only(left: 24.0, right: 24.0),
                  child: OutlineButton(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "back",
                        style: TextStyle(fontSize: 18),
                      ),
                    ),
                    borderSide: BorderSide(color: Colors.white, width: 2.0),
                    onPressed: () => ZoomDrawer.of(context).close(),
                    textColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16.0)),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

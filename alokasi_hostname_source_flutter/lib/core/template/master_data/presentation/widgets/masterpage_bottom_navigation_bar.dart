import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../bloc/masterpage_ploc.dart';

class MasterPageBottomNavigationBar extends StatelessWidget {
  final MasterPagePloc ploc;

  const MasterPageBottomNavigationBar({
    @required this.ploc,
  });

  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      items: <Widget>[
        Icon(
          Icons.table_chart,
          size: 30,
        ),
        Icon(
          Icons.list,
          size: 30,
        ),
        Icon(
          Icons.map,
          size: 30,
        ),
        Icon(
          Icons.transform,
          size: 30,
        ),
      ],
      backgroundColor: Colors.blue,
      onTap: (index) {
        ploc.onBottomNavigationChange(index: index);
        switch (index) {
          case 0:
            ploc.resetFilteredAndRefreshData();
            break;
          case 1:
            ploc.resetFilteredAndRefreshData();
            break;
          case 2:
            ploc.resetFilteredAndRefreshData();
            break;
          default:
            ploc.resetFilteredAndRefreshData();
        }
      },
    );
  }
}

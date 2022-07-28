import 'package:flutter/material.dart';

import '../bloc/masterpage_ploc.dart';
import 'masterpage_appbar_search.dart';
import 'masterpage_btn_filter.dart';
import 'masterpage_btn_refresh.dart';
import 'masterpage_btn_search.dart';

class MasterPageAppBar extends StatelessWidget implements PreferredSizeWidget {
  final MasterPagePloc ploc;
  final double height;
  final Widget filterPage;

  MasterPageAppBar({
    @required this.ploc,
    @required this.height,
    @required this.filterPage,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: ploc.inSearchMode
          ? MasterPageAppBarTitleSearchMode(
              ploc: ploc,
            )
          : MasterPageAppBarTitleDefault(ploc: ploc),
      actions: [
        Visibility(
          visible: ploc.isBtnCloseSearchVisible,
          child: BtnCloseSearch(ploc: ploc),
        ),
        MasterPageBtnSearch(ploc: ploc),
        MasterPageBtnFilter(
          ploc: ploc,
          filterPage: filterPage,
        ),
        MasterPageBtnRefresh(ploc: ploc),
      ],
      // backgroundColor: Colors.blue,
      elevation: 0,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(height);
}

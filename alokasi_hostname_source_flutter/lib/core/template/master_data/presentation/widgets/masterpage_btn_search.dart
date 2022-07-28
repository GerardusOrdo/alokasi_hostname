import 'package:flutter/material.dart';

import '../bloc/masterpage_ploc.dart';

class MasterPageBtnSearch extends StatelessWidget {
  final MasterPagePloc ploc;

  const MasterPageBtnSearch({@required this.ploc});
  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.search),
      onPressed: () => ploc.setSearchMode(true),
      tooltip: 'Search',
    );
  }
}

class BtnCloseSearch extends StatelessWidget {
  final MasterPagePloc ploc;

  const BtnCloseSearch({@required this.ploc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.close),
      onPressed: () => ploc.setSearchMode(false),
      tooltip: 'Close Search',
    );
  }
}

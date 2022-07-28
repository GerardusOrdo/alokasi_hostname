import 'package:flutter/material.dart';

import '../bloc/masterpage_ploc.dart';

class MasterPageBtnRefresh extends StatelessWidget {
  final MasterPagePloc ploc;

  const MasterPageBtnRefresh({@required this.ploc});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: 'Refresh',
      icon: Icon(Icons.refresh),
      onPressed: () => ploc.resetFilteredAndRefreshData(),
    );
  }
}

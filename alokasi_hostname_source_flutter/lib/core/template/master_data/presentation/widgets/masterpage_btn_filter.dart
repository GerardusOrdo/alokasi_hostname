import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../bloc/masterpage_ploc.dart';
import 'masterpage_initial_widget.dart';

class MasterPageBtnFilter extends StatelessWidget {
  final MasterPagePloc ploc;
  final Widget filterPage;

  const MasterPageBtnFilter({
    @required this.ploc,
    @required this.filterPage,
  });
  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: 40.0,
          width: 40.0,
          child: Center(
            child: Tooltip(
              message: 'Filter',
              child: Icon(
                Icons.filter_list,
                color: Colors.white,
              ),
            ),
          ),
        );
      },
      closedElevation: 0.0,
      openBuilder: (BuildContext context, VoidCallback _) {
        if (ploc.isDataFetchSuccess) {
          ploc.onFilterPageShowed();
          return filterPage;
        } else {
          ploc.showSnackbarDataFetchFailed('Failed to load data');
          return MasterPageInitialWidget();
        }
      },
      // closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(30.0 / 2),
        ),
      ),
      closedColor: Colors.blue,
    );
  }
}

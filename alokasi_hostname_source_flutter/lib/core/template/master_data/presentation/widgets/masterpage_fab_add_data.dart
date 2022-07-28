import 'package:animations/animations.dart';
import 'package:flutter/material.dart';

import '../bloc/masterpage_ploc.dart';

class MasterPageFABAddData extends StatelessWidget {
  final Widget inputPage;
  final MasterPagePloc ploc;

  const MasterPageFABAddData({
    @required this.inputPage,
    @required this.ploc,
  });

  @override
  Widget build(BuildContext context) {
    return OpenContainer(
      transitionType: ContainerTransitionType.fade,
      closedBuilder: (BuildContext context, VoidCallback openContainer) {
        return SizedBox(
          height: 56.0,
          width: 56.0,
          child: Center(
            child: Icon(
              Icons.add,
              color: Colors.white,
            ),
          ),
        );
      },
      useRootNavigator: true,
      openBuilder: (BuildContext context, VoidCallback _) {
        ploc.onInsertPageShowed();
        // Get.toNamed(GetRouteOf.ownerRouteInput);
        return inputPage;
      },
      closedElevation: 6.0,
      closedShape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(56.0 / 2),
        ),
      ),
      closedColor: Colors.pink,
    );
  }
}

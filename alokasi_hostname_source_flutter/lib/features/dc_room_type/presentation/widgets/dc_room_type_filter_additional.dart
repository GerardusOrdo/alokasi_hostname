import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_room_type_ploc.dart';

class DcRoomTypeFilterAdditional extends StatelessWidget {
  const DcRoomTypeFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomTypePloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }
}

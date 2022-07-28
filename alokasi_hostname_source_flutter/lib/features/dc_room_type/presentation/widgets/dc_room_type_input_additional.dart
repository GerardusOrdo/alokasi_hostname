import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../bloc/dc_room_type_ploc.dart';

class DcRoomTypeInputAdditional extends StatelessWidget {
  const DcRoomTypeInputAdditional({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomTypePloc>(
      builder: (_) => Form(
        // key: _.formKeyInputAdditional,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this additional Information',
            ),
          ],
        ),
      ),
    );
  }
}

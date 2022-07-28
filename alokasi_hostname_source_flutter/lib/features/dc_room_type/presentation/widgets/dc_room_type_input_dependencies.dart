import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_room_type_ploc.dart';

class DcRoomTypeInputDependencies extends StatelessWidget {
  const DcRoomTypeInputDependencies({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcRoomTypePloc>(
      builder: (_) {
        return Form(
          // key: _.formKeyInputDependencies,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                child: SizedBox(
                  child: Text('Dependencies'),
                  width: double.infinity,
                ),
                color: Colors.blue[50],
                height: 70.0,
                padding: EdgeInsets.all(20.0),
              ),
              // MasterPageDependenciesTypeAheadTextField(
              //   labelText: 'RoomType',
              //   onSuggestionSelected: (s) => _.inputRoomTypeTextSelected(s),
              //   onSuggestionCallback: (pattern) => _.debouncer.run(() {
              //         _.getInputRoomTypeSuggestionFromAPI(pattern);
              //       }),
              //   textEditingController: _.inputTextCtrl.roomType,
              //   onButtonAddClick: () {},
              // ),
            ],
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';

class MasterPageTextFormFieldTap extends StatelessWidget {
  final Function onTap;
  final TextEditingController textEditingController;
  final String inputText;
  final void Function(String) onChanged;

  const MasterPageTextFormFieldTap({
    Key key,
    @required this.onTap,
    @required this.textEditingController,
    @required this.inputText,
    @required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormField(
            onTap: onTap,
            controller: textEditingController,
            keyboardType: TextInputType.text,
            readOnly: true,
            decoration: InputDecoration(
              hintText: inputText,
              labelText: inputText,
              labelStyle: TextStyle(
                fontSize: 15.0,
              ),
            ),
            onChanged: onChanged,
          ),
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => textEditingController.clear(),
        ),
      ],
    );
    // InkWell(
    //   onTap: () {
    //     _.selectDate(context);
    //   },
    //   child: Container(
    //     width: Get.width / 1.7,
    //     height: Get.height / 9,
    //     margin: EdgeInsets.only(top: 30),
    //     alignment: Alignment.center,
    //     decoration: BoxDecoration(color: Colors.grey[200]),
    //     child: TextFormField(
    //       style: TextStyle(fontSize: 40),
    //       textAlign: TextAlign.center,
    //       enabled: false,
    //       keyboardType: TextInputType.text,
    //       controller: _.dateController,
    //       onSaved: (String val) {
    //         _.setDate = val;
    //       },
    //       decoration: InputDecoration(
    //           disabledBorder:
    //               UnderlineInputBorder(borderSide: BorderSide.none),
    //           // labelText: 'Time',
    //           contentPadding: EdgeInsets.only(top: 0.0)),
    //     ),
    //   ),
    // );
  }
}

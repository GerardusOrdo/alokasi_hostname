import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../helper/helper.dart';

class MasterPageTextFormFieldValidator extends StatelessWidget {
  final String inputText;
  final String Function(String) onValidate;
  final TextEditingController textEditingController;
  final int maxLines;
  final EnumDataType dataType;

  TextInputFormatter getTextInputFormatter() {
    switch (dataType) {
      case EnumDataType.integer:
        return FilteringTextInputFormatter.allow(RegExp("[0-9]"));
      default:
        return FilteringTextInputFormatter.deny(RegExp(""));
    }
  }

  TextInputType getTextInputType() {
    switch (dataType) {
      case EnumDataType.integer:
        return TextInputType.number;
      case EnumDataType.string:
        return TextInputType.text;
      default:
        return TextInputType.text;
    }
  }

  const MasterPageTextFormFieldValidator({
    @required this.inputText,
    @required this.onValidate,
    @required this.textEditingController,
    this.maxLines = 1,
    this.dataType = EnumDataType.string,
  });
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TextFormField(
            controller: textEditingController,
            maxLines: maxLines,
            inputFormatters: [
              getTextInputFormatter(),
            ],
            keyboardType: getTextInputType(),
            decoration: InputDecoration(
              hintText: 'Please input $inputText',
              labelText: inputText,
              labelStyle: TextStyle(
                fontSize: 15.0,
              ),
            ),
            validator: onValidate,
          ),
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => textEditingController.clear(),
        ),
      ],
    );
  }
}

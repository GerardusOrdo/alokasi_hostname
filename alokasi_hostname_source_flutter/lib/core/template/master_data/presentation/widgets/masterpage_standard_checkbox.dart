import 'package:flutter/material.dart';

class MasterPageStandardCheckbox extends StatelessWidget {
  final Function(bool) onChanged;
  final bool value;
  final String text;

  const MasterPageStandardCheckbox(
      {@required this.onChanged, @required this.text, @required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Checkbox(
            onChanged: onChanged,
            value: value,
          ),
          Text(text),
        ],
      ),
    );
  }
}

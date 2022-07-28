import 'package:flutter/material.dart';

class MasterPageStandardDropdown extends StatelessWidget {
  final value;
  final List<DropdownMenuItem<dynamic>> items;
  final Function(dynamic) onChanged;
  final String text;

  const MasterPageStandardDropdown({
    @required this.text,
    @required this.value,
    @required this.items,
    @required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(text),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: DropdownButton(
            value: value,
            items: items,
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}

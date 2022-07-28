import 'package:flutter/material.dart';

class MasterPageNotesBox extends StatelessWidget {
  final String bodyText;

  const MasterPageNotesBox({@required this.bodyText});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SizedBox(
        child: Text(bodyText),
        width: double.infinity,
      ),
      color: Colors.blue[50],
      height: 70.0,
      padding: EdgeInsets.all(20.0),
    );
  }
}

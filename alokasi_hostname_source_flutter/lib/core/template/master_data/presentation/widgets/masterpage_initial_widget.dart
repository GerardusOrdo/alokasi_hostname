import 'package:flutter/material.dart';

class MasterPageInitialWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100.0,
          child: Center(
            child: CircularProgressIndicator(
              backgroundColor: Colors.pink,
            ),
          ),
        ),
        Text('Please wait ...'),
      ],
    );
  }
}

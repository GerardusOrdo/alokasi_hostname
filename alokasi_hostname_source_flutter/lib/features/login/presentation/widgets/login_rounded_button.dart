import 'package:flutter/material.dart';

class LoginRoundedButton extends StatelessWidget {
  final String text;
  final Function press;
  final Color color, textColor;
  const LoginRoundedButton({
    Key key,
    this.text,
    this.press,
    this.color = Colors.pink,
    this.textColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: TextButton(
        // autofocus: true,
        style: TextButton.styleFrom(
          primary: Colors.white,
          backgroundColor: Colors.pink,
          onSurface: Colors.grey,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(30))),
          padding: EdgeInsets.all(30),
        ),
        child: Text(
          text,
          style: TextStyle(color: Colors.white),
        ),
        onPressed: press,
      ),
      // ClipRRect(
      //   borderRadius: BorderRadius.circular(29),
      //   child: TextButton(
      //     // padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      //     // color: color,
      //     onPressed: press,
      //     child: Text(
      //       text,
      //       style: TextStyle(color: textColor),
      //     ),
      //   ),
      // ),
    );
  }
}

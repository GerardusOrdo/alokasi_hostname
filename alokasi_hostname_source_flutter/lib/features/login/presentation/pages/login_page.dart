import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/login_ploc.dart';
import '../widgets/login_rounded_button.dart';
import '../widgets/login_rounded_input_field.dart';
import '../widgets/login_rounded_password_field.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GetBuilder<LoginPloc>(
      // init: LoginPloc(),
      // initState: (_) {},
      builder: (_) {
        return Scaffold(
          backgroundColor: Colors.blue,
          body: SingleChildScrollView(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: Get.height / 8,
                  ),
                  Text(
                    "LOGIN",
                    style: TextStyle(
                      // fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  // _.riveArtboard == null
                  //     ? const SizedBox()
                  //     : Rive(artboard: _.riveArtboard),
                  // svg.asset(
                  //   "assets/icons/login.svg",
                  //   height: size.height * 0.35,
                  // ),
                  SizedBox(height: size.height * 0.03),
                  LoginRoundedInputField(
                    autoFocus: true,
                    textEditingController: _.usernameTextController,
                    hintText: "Username",
                    onChanged: (value) {
                      _.username = value;
                    },
                  ),
                  LoginRoundedPasswordField(
                    textEditingController: _.passwordTextController,
                    onChanged: (value) {
                      _.password = value;
                    },
                  ),
                  LoginRoundedButton(
                    text: "LOGIN",
                    press: () {
                      _.login();
                    },
                  ),
                  SizedBox(height: size.height * 0.03),
                  // LoginAlreadyHaveAnAccountCheck(
                  //   press: () {
                  //     Navigator.push(
                  //       context,
                  //       MaterialPageRoute(
                  //         builder: (context) {
                  //           return SignUpScreen();
                  //         },
                  //       ),
                  //     );
                  //   },
                  // ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

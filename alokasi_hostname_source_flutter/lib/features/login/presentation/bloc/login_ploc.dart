import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/helper/helper.dart';

class LoginPloc extends GetxController {
  bool isLogin = false;
  TextEditingController usernameTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();

  String username = '';
  String password = '';

  // Artboard riveArtboard = RuntimeArtboard();
  // RiveAnimationController riveController = SimpleAnimation('idle');

  /// Tracks if the animation is playing by whether controller is running.
  // bool get isPlaying => riveController?.isActive ?? false;
  @override
  void onInit() {
    super.onInit();
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    // rootBundle.load('assets/animations/juice063.riv').then(
    //   (data) async {
    //     final file = RiveFile();

    //     // Load the RiveFile from the binary data.
    //     if (file.import(data)) {
    //       // The artboard is the root of the animation and gets drawn in the
    //       // Rive widget.
    //       final artboard = file.mainArtboard;
    //       // Add a controller to play back a known animation on the main/default
    //       // artboard.We store a reference to it so we can toggle playback.
    //       artboard.addController(riveController = SimpleAnimation('walk'));
    //       riveArtboard = artboard;
    //     }
    //   },
    // );
  }

  void togglePlay() {
    // riveController.isActive = !riveController.isActive;
  }

  void login() {
    isLogin = (username == 'admin') && (password == 'P@ssw0rdOPD##');
    if (isLogin) {
      Get.offNamed(GetRouteOf.homepageRoute);
    } else {
      Get.snackbar('Failed to Login', 'Please check your username and password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM);
    }
  }
}

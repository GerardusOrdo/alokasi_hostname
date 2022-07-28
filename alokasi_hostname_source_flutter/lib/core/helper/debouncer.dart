import 'dart:async';

import 'package:flutter/material.dart';

class Debouncer {
  int milliseconds;
  VoidCallback action = () {};
  Timer _timer = Timer(Duration(milliseconds: 300), () {});

  Debouncer({this.milliseconds = 300});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

import 'package:flutter/material.dart';

class MenuItem {
  final String title;
  final IconData icon;
  final int index;
  final Function callback;

  const MenuItem(this.title, this.icon, this.index, this.callback);
}

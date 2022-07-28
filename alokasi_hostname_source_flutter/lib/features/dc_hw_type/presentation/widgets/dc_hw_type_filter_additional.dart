import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../bloc/dc_hw_type_ploc.dart';

class DcHwTypeFilterAdditional extends StatelessWidget {
  const DcHwTypeFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcHwTypePloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_standard_typeahead_textfield.dart';
import '../bloc/dc_mounted_form_ploc.dart';

class DcMountedFormFilterAdditional extends StatelessWidget {
  const DcMountedFormFilterAdditional({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcMountedFormPloc>(
      builder: (_) => Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [],
      ),
    );
  }
}

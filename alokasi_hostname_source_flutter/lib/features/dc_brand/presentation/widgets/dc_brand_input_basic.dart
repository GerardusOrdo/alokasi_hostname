import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_brand_ploc.dart';

class DcBrandInputBasic extends StatelessWidget {
  const DcBrandInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcBrandPloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Brand',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcBrand.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'Brand',
                onChanged: (s) => _.inputDcBrand.brand = s,
                textEditingController: _.inputTextCtrl.brand),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcBrandInput),
            // textEditingController: _.dcBrandNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}

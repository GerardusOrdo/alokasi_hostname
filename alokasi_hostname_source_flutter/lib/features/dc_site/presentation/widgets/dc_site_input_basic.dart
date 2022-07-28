import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/template/master_data/presentation/widgets/masterpage_notesbox.dart';
import '../../../../core/template/master_data/presentation/widgets/masterpage_textformfield.dart';
import '../bloc/dc_site_ploc.dart';

class DcSiteInputBasic extends StatelessWidget {
  const DcSiteInputBasic({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DcSitePloc>(
      builder: (_) => Form(
        // key: _.formKeyInputBasic,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            MasterPageNotesBox(
              bodyText: 'Please fill this basic Information',
            ),
            // MasterPageTextFormFieldValidator(
            //   inputText: 'Site',
            //   onValidate: (s) {
            //     if (s.isEmpty) {
            //       return 'Please enter some text';
            //     } else {
            //       _.inputDcSite.hwName = s;
            //       return null;
            //     }
            //   },
            //   textEditingController: _.inputTextCtrl.hwName,
            // ),
            MasterPageTextFormField(
                inputText: 'Site',
                onChanged: (s) => _.inputDcSite.dcSiteName = s,
                textEditingController: _.inputTextCtrl.dcSiteName),
            // _.validateTextFormField(
            //     stringToValidate: s, stringToSave: _.dcSiteInput),
            // textEditingController: _.dcSiteNameInputTextEditingController),
          ],
        ),
      ),
    );
  }
}

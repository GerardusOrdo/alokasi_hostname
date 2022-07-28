import 'package:flutter/material.dart';

import '../bloc/masterpage_ploc.dart';

/// Default appbar
class MasterPageAppBarTitleDefault extends StatelessWidget {
  final MasterPagePloc ploc;

  const MasterPageAppBarTitleDefault({@required this.ploc});

  @override
  Widget build(BuildContext context) {
    return Text(ploc.pageName);
  }
}

/// Appbar ketika dalam search mode
class MasterPageAppBarTitleSearchMode extends StatelessWidget {
  final MasterPagePloc ploc;

  const MasterPageAppBarTitleSearchMode({
    @required this.ploc,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      cursorColor: Colors.white,
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        hintText: 'Search ...',
        hintStyle: TextStyle(
          color: Colors.white,
        ),
        labelText: ploc.pageName,
        labelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
        focusColor: Colors.white,
        hoverColor: Colors.white,
        fillColor: Colors.white,
      ),
      onChanged: (s) => ploc.searchMainPage(s),
    );
    // TypeAheadFormField(
    //   onSuggestionSelected: (suggestion) => ploc.selectSuggestion(suggestion),
    //   itemBuilder: (context, suggestion) {
    //     return ListTile(
    //       title: Text(suggestion),
    //     );
    //   },
    //   suggestionsCallback: (pattern) => ploc.getSearchSuggestions(pattern),
    //   textFieldConfiguration: TextFieldConfiguration(
    //     decoration: InputDecoration(
    //       labelText: ploc.pageName,
    //       labelStyle: TextStyle(
    //         color: Colors.white,
    //         fontWeight: FontWeight.bold,
    //       ),
    //     ),
    //     controller: ploc.appBarSearchTextEditingController,
    //     cursorColor: Colors.white,
    //     autofocus: true,
    //     autocorrect: true,
    //     style: TextStyle(
    //       color: Colors.white,
    //     ),
    //   ),
    //   transitionBuilder: (context, suggestionsBox, controller) {
    //     return suggestionsBox;
    //   },
    //   validator: (value) {
    //     if (value.isEmpty) {
    //       return 'Please fill this';
    //     } else
    //       return null;
    //   },
    // );
  }
}

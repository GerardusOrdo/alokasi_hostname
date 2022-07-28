import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MasterPageDependenciesTypeAheadTextFieldCustom extends StatelessWidget {
  final String labelText;
  final Function(dynamic) onSuggestionSelected;
  final Function(String) onSuggestionCallback;
  final TextEditingController textEditingController;
  final Function() onButtonAddClick;
  final Widget Function(BuildContext, dynamic) itemBuilder;
  final bool autofocus;

  const MasterPageDependenciesTypeAheadTextFieldCustom({
    @required this.labelText,
    @required this.onSuggestionSelected,
    @required this.onSuggestionCallback,
    @required this.textEditingController,
    @required this.onButtonAddClick,
    @required this.itemBuilder,
    this.autofocus = true,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TypeAheadFormField(
            debounceDuration: Duration(milliseconds: 300),
            onSuggestionSelected: onSuggestionSelected,
            itemBuilder: itemBuilder,
            suggestionsCallback: (pattern) async =>
                await onSuggestionCallback(pattern),
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                labelText: labelText,
              ),
              controller: textEditingController,
              // cursorColor: Colors.white,
              autofocus: autofocus,
              autocorrect: true,
            ),
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            validator: (value) {
              final val = value;
              if (val == '') {
                return 'Please fill this';
              } else {
                return null;
              }
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => textEditingController.clear(),
        ),
        IconButton(
          icon: Icon(Icons.add),
          onPressed: onButtonAddClick,
        ),
      ],
    );
  }
}

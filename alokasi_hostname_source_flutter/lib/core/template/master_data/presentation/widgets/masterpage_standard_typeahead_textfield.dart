import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class MasterPageStandardTypeAheadTextField extends StatelessWidget {
  final String labelText;
  final Function(String) onSuggestionSelected;
  final Function(String) onSuggestionCallback;
  final TextEditingController textEditingController;

  const MasterPageStandardTypeAheadTextField({
    @required this.labelText,
    @required this.onSuggestionSelected,
    @required this.onSuggestionCallback,
    @required this.textEditingController,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Expanded(
          child: TypeAheadFormField(
            debounceDuration: Duration(milliseconds: 300),
            onSuggestionSelected: (suggestion) =>
                onSuggestionSelected(suggestion.toString()),
            itemBuilder: (context, suggestion) {
              return ListTile(
                title: Text(suggestion.toString()),
              );
            },
            suggestionsCallback: (pattern) async =>
                await onSuggestionCallback(pattern),
            textFieldConfiguration: TextFieldConfiguration(
              decoration: InputDecoration(
                labelText: labelText,
              ),
              controller: textEditingController,
              // cursorColor: Colors.white,
              autofocus: true,
              autocorrect: true,
            ),
            transitionBuilder: (context, suggestionsBox, controller) {
              return suggestionsBox;
            },
            validator: (value) {
              final val = value;
              if (val == '') {
                return 'Please fill this';
              } else
                return null;
            },
          ),
        ),
        IconButton(
          icon: Icon(Icons.clear),
          onPressed: () => textEditingController.clear(),
        ),
      ],
    );
  }
}

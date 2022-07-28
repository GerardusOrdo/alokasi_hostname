class HasuraUtil {
  static String getMinimalHasuraQuery(String str) {
    String _queryWithoutNewLine = str.replaceAll('\n', '');
    String _queryWithoutReturn = _queryWithoutNewLine.replaceAll('\r', '');
    String _queryWithoutWhiteSpace = _queryWithoutReturn.replaceAll(' ', '');

    String _queryWithoutLeadingData =
        _queryWithoutWhiteSpace.replaceFirst('{"data":', '');
    int _lastCurlyBraces = _queryWithoutLeadingData.lastIndexOf('}');
    String result =
        _queryWithoutLeadingData.replaceFirst('}', '', _lastCurlyBraces);
    return result;
  }
}

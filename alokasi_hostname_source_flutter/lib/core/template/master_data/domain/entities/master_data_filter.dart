import '../../../../helper/helper.dart';

mixin MasterDataFilter {
  int offsets = 0;
  int limits = 100;

  String fieldToOrderBy = 'id';
  bool orderByAscending = false;

  bool selected = false;
  final EnumLogicalOperator dataFilterByLogicalOperator =
      EnumLogicalOperator.and;
}

import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcHwType extends MasterData {
  @override
  final int id;
  final String hwType;
  DcHwType({
    this.id,
    @required this.hwType,
  });

  @override
  List<Object> get props => [
        id,
        hwType,
      ];
}

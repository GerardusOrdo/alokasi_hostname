import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcHwModel extends MasterData {
  @override
  final int id;
  final String hwModel;
  final String image;
  final String notes;
  final bool deleted;
  final String created;
  DcHwModel({
    this.id,
    @required this.hwModel,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });

  @override
  List<Object> get props => [
        id,
        hwModel,
        image,
        notes,
        deleted,
        created,
      ];
}

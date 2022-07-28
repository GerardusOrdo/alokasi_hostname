import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcOwner extends MasterData {
  @override
  final int id;
  final String owner;
  final String image;
  final String notes;
  final bool deleted;
  final String created;
  DcOwner({
    this.id,
    @required this.owner,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });

  @override
  List<Object> get props => [
        id,
        owner,
        image,
        notes,
        deleted,
        created,
      ];
}

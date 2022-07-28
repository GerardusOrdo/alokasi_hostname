import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcBrand extends MasterData {
  @override
  final int id;
  final String brand;
  final String image;
  final String notes;
  final bool deleted;
  final String created;
  DcBrand({
    this.id,
    @required this.brand,
    this.image,
    this.notes,
    this.deleted,
    this.created,
  });

  @override
  List<Object> get props => [
        id,
        brand,
        image,
        notes,
        deleted,
        created,
      ];
}

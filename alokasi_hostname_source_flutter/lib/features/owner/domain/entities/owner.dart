import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class Owner extends MasterData {
  @override
  final int id;
  @required
  final String owner;
  final String email;
  final String phone;
  final String notes;
  final bool deleted;
  final String created;
  Owner({
    this.id,
    @required this.owner,
    this.email,
    this.phone,
    this.notes,
    this.deleted,
    this.created,
  });

  @override
  List<Object> get props => [
        id,
        owner,
        email,
        phone,
        notes,
        deleted,
        created,
      ];
}

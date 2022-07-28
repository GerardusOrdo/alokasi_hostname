import 'package:meta/meta.dart';

import '../../../../core/template/master_data/domain/entities/master_data.dart';

class DcMountedForm extends MasterData {
  @override
  final int id;
  final String mountedForm;
  DcMountedForm({
    this.id,
    @required this.mountedForm,
  });

  @override
  List<Object> get props => [
        id,
        mountedForm,
      ];
}

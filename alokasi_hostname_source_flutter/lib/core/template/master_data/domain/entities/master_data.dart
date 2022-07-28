import 'package:equatable/equatable.dart';

/// Class dimana semua Domain-Entities class mixin dengan ini, sehingga dapat diselect dari UI
class MasterData extends Equatable {
  int id;
  bool selected = false;

  @override
  List<Object> get props => [id ?? 0, selected];
}

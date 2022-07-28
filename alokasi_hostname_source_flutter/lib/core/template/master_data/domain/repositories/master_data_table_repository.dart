import 'package:dartz/dartz.dart';

import '../../../../error/failures.dart';
import '../entities/master_data.dart';
import '../entities/master_data_filter.dart';
import '../entities/master_data_table.dart';

/// Class ini merupakan kontrak yang menjanjikan domain usecase fungsi default CRUD database

abstract class MasterDataTableRepository {
  Future<Either<Failure, MasterDataTable>> selectDataTable(
      MasterDataFilter dataTable);
  Future<Either<Failure, MasterDataTable>> insertDataTable(
      MasterData dataTable);
  Future<Either<Failure, MasterDataTable>> cloneDataTable(
      List<MasterData> dataTable);
  Future<Either<Failure, MasterDataTable>> updateDataTable(
      MasterData dataTable);
  Future<Either<Failure, MasterDataTable>> setDeleteDataTable(
      List<MasterData> dataTable);
  Future<Either<Failure, MasterDataTable>> deleteDataTable(
      List<MasterData> dataTable);
}

import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_brand.dart';
import '../repositories/dc_brand_table_repository.dart';

class InsertDcBrandTable implements UseCase<List<int>, DcBrand> {
  final DcBrandTableRepository repository;

  InsertDcBrandTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcBrand params) async {
    return await repository.getIdsFromInserted(params);
  }
}

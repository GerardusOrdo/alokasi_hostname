import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_brand.dart';
import '../repositories/dc_brand_table_repository.dart';

class UpdateDcBrandTable implements UseCase<List<int>, DcBrand> {
  final DcBrandTableRepository repository;

  UpdateDcBrandTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(DcBrand params) async {
    return await repository.getIdsFromUpdated(params);
  }
}

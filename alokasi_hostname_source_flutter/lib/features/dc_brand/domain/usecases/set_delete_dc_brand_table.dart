import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/dc_brand.dart';
import '../repositories/dc_brand_table_repository.dart';

class SetDeleteDcBrandTable implements UseCase<List<int>, List<DcBrand>> {
  final DcBrandTableRepository repository;

  SetDeleteDcBrandTable(this.repository);

  @override
  Future<Either<Failure, List<int>>> call(List<DcBrand> params) async {
    return await repository.getIdsFromSetToDeleted(params);
  }
}

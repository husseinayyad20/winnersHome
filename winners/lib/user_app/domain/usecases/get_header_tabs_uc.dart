import 'package:winners/user_app/domain/entities/header/header_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_header_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:winners/user_app/data/failure.dart';

class GetHeaderUC {
  final IHeaderRepository repository;

  GetHeaderUC(this.repository);

  Future<Either<Failure, HeaderEntity>> execute() {
    return repository.get();
  }
}

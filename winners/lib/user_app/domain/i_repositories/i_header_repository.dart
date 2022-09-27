import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/header/header_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IHeaderRepository {
  Future<Either<Failure, HeaderEntity>> get();
}

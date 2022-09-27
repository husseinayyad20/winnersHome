import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/currency/currency_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ICurrencyRepository {
  Future<Either<Failure, CurrencyEntity>> get();
}

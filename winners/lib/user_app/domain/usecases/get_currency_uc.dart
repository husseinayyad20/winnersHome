import 'package:winners/user_app/domain/entities/currency/currency_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_currency_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:winners/user_app/data/failure.dart';

class GetCurrencyUC {
  final ICurrencyRepository repository;

  GetCurrencyUC(this.repository);

  Future<Either<Failure, CurrencyEntity>> execute() {
    return repository.get();
  }
}

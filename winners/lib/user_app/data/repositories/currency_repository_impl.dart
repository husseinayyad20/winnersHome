import 'dart:io';

import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/exception.dart';
import 'package:winners/user_app/domain/entities/currency/currency_entity.dart';
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/i_repositories/i_currency_repository.dart';
import 'package:dartz/dartz.dart';

class CurrencyRepositoryImpl implements ICurrencyRepository {
  final RemoteDataSource remoteDataSource;

  CurrencyRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, CurrencyEntity>> get() async {
    try {
      final result = await remoteDataSource.getCurrency();
      return Right(
        result.toEntity(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(
          'Server Failure on getGlobalConfiguration()',
        ),
      );
    } on SocketException {
      return const Left(
        ConnectionFailure(
          'Failed to connect to the network',
        ),
      );
    }
  }
}

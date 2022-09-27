import 'dart:io';

import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/exception.dart';
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/page/page_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_pages_repository.dart';
import 'package:dartz/dartz.dart';

class PagesRepositoryImpl implements IPageRepository {
  final RemoteDataSource remoteDataSource;

  PagesRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, PageEntity>> getPage(String pageName) async {
    try {
      final result = await remoteDataSource.getPage(pageName);
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

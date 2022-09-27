import 'dart:io';


import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/exception.dart';
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/banner/banner_entity.dart';

import 'package:winners/user_app/domain/i_repositories/i_banner_repository.dart';
import 'package:dartz/dartz.dart';

class BannerRepositoryImpl implements IBannerRepository {
  final RemoteDataSource remoteDataSource;

  BannerRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BannerEntity>> getBanners() async {
    try {
      final result = await remoteDataSource.getBanners();
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

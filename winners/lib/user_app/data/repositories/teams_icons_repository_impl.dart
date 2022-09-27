import 'dart:io';

import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/exception.dart';
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/teams_icons_entity/teams_icons_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_teams_icons_repository.dart';
import 'package:dartz/dartz.dart';

class TeamsIconsRepositoryImpl implements ITeamsIconsRepository {
  final RemoteDataSource remoteDataSource;

  TeamsIconsRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, TeamsIconsDataEntity>> get() async {
    try {
      final result = await remoteDataSource.getTeamsIcons();
      return Right(
        result.toDataEntity(),
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

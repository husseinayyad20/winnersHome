import 'dart:io';

import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/exception.dart';
import 'package:winners/user_app/data/models/country_flag/countries_flag_model.dart';
import 'package:winners/user_app/domain/entities/bet_slip_configuration/bet_slip_configuration_entity.dart';
import 'package:winners/user_app/domain/entities/general_configuration/general_configuration_entity.dart';
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/leagues_tabs/leagues_tabs_entity.dart';
import 'package:winners/user_app/domain/entities/sport_type_icon/sport_type_icon_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_general_configuration_repository.dart';
import 'package:dartz/dartz.dart';

class GeneralConfigurationRepositoryImpl
    implements IGeneralConfigurationRepository {
  final RemoteDataSource remoteDataSource;

  GeneralConfigurationRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, GeneralConfigurationEntity>>
      getGeneralConfigurations() async {
    try {
      final result = await remoteDataSource.getGeneralConfiguration();
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

  @override
  Future<Either<Failure, LeaguesTabsEntity>> getLeaguesTabs() async {
    try {
      final result = await remoteDataSource.getLaguesTabs();
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

  @override
  Future<Either<Failure, BetSlipConfigurationEntity>>
      getBetSlipConfiguration() async {
    try {
      final result = await remoteDataSource.getBetSlipConfiguration();
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

  @override
  Future<Either<Failure, SportTypeIconEntity>> getSportTypeIcon() async {
    try {
      final result = await remoteDataSource.getSportTypeIcon();
      return Right(
        result.toEntity(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(
          'Server Failure on getSportTypeIcon()',
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

  @override
  Future<Either<Failure, CountriesFlagModel>> getCountriesFlags() async {
    try {
      final result = await remoteDataSource.getCountriesFlags();
      return Right(
        result,
      );
    } on ServerException {
      return const Left(
        ServerFailure(
          'Server Failure on getCountriesFlags()',
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

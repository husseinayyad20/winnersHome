import 'dart:io';
import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/exception.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_code_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_entity.dart';
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_sports_icons_entity%20copy.dart';
import 'package:winners/user_app/domain/entities/bet_slip/place_bet_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_bet_slip_repository.dart';
import 'package:dartz/dartz.dart';

class BetSlipRepositoryImpl implements IBetSlipRepository {
  final RemoteDataSource remoteDataSource;

  BetSlipRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, BetSlipEntity>> getBetSlip(
      Map<String, dynamic> data) async {
    try {
      final result = await remoteDataSource.getBetSlip(data);
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
  Future<Either<Failure, BetCodeEntity>> createBetCode(
      Map<String, dynamic> data) async {
    try {
      final result = await remoteDataSource.createBetCode(data);
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
  Future<Either<Failure, PlaceBetEntity>> placeBetMultiple(
      Map<String, dynamic> data) async {
    try {
      final result = await remoteDataSource.placeBetMultiple(data);
      return Right(
        result.toEntity(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(
          'Server Failure on placeBetMultiple()',
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
  Future<Either<Failure, PlaceBetEntity>> placeBetSingle(
      Map<String, dynamic> data) async {
    try {
      final result = await remoteDataSource.placeBetSingle(data);
      return Right(
        result.toEntity(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(
          'Server Failure on placeBetSingle()',
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
  Future<Either<Failure, BetSlipSportIconsEntity>> getSportTypeIcon() async {
    try {
      final result = await remoteDataSource.getBetSlipSportsIcons();
      return Right(
        result.toEntity(),
      );
    } on ServerException {
      return const Left(
        ServerFailure(
          'Server Failure on placeBetSingle()',
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

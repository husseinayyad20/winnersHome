import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_code_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_sports_icons_entity%20copy.dart';
import 'package:winners/user_app/domain/entities/bet_slip/place_bet_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IBetSlipRepository {
  Future<Either<Failure, BetSlipEntity>> getBetSlip(Map<String, dynamic> data);
  Future<Either<Failure, BetCodeEntity>> createBetCode(
      Map<String, dynamic> data);
  Future<Either<Failure, PlaceBetEntity>> placeBetMultiple(
      Map<String, dynamic> data);
  Future<Either<Failure, PlaceBetEntity>> placeBetSingle(
      Map<String, dynamic> data);
  Future<Either<Failure, BetSlipSportIconsEntity>> getSportTypeIcon();
}

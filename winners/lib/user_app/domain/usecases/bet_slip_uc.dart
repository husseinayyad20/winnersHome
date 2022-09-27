import 'package:winners/user_app/domain/entities/bet_slip/bet_code_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_sports_icons_entity%20copy.dart';
import 'package:winners/user_app/domain/entities/bet_slip/place_bet_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_bet_slip_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:winners/user_app/data/failure.dart';

class BetSlipUC {
  final IBetSlipRepository repository;

  BetSlipUC(this.repository);

  Future<Either<Failure, BetSlipEntity>> executeGetBetSlip(
      Map<String, dynamic> data) {
    return repository.getBetSlip(data);
  }

  Future<Either<Failure, BetCodeEntity>> executeCreateBetCode(
      Map<String, dynamic> data) {
    return repository.createBetCode(data);
  }

  Future<Either<Failure, PlaceBetEntity>> executePlaceBetMultiple(
      Map<String, dynamic> data) {
    return repository.placeBetMultiple(data);
  }

  Future<Either<Failure, PlaceBetEntity>> executePlaceBetSingle(
      Map<String, dynamic> data) {
    return repository.placeBetSingle(data);
  }

  Future<Either<Failure, BetSlipSportIconsEntity>> executeGetSportTypeIcon() {
    return repository.getSportTypeIcon();
  }
}

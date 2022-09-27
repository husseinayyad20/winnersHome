import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_bet_slip_repository.dart';

import 'package:dartz/dartz.dart';
import 'package:winners/user_app/data/failure.dart';

class GetBetSlipUC {
  final IBetSlipRepository repository;

  GetBetSlipUC(this.repository);

  Future<Either<Failure, BetSlipEntity>> execute(Map<String, dynamic> data) {
    return repository.getBetSlip(data);
  }
}

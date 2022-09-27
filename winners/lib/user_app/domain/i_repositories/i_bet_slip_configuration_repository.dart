import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/bet_slip_configuration/bet_slip_configuration_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IBetSlipConfigurationRepository {
  Future<Either<Failure, BetSlipConfigurationEntity>> getBetSlipConfiguration();
}

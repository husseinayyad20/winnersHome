import 'package:winners/user_app/data/models/country_flag/countries_flag_model.dart';

import 'package:winners/user_app/domain/entities/bet_slip_configuration/bet_slip_configuration_entity.dart';
import 'package:winners/user_app/domain/entities/general_configuration/general_configuration_entity.dart';
import 'package:winners/user_app/domain/entities/leagues_tabs/leagues_tabs_entity.dart';
import 'package:winners/user_app/domain/entities/sport_type_icon/sport_type_icon_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_general_configuration_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:winners/user_app/data/failure.dart';

class GetGeneralConfigurationUC {
  final IGeneralConfigurationRepository repository;

  GetGeneralConfigurationUC(this.repository);

  Future<Either<Failure, GeneralConfigurationEntity>>
      executeGetGeneralConfig() {
    return repository.getGeneralConfigurations();
  }

  Future<Either<Failure, LeaguesTabsEntity>> executeGetLeaguesTabs() {
    return repository.getLeaguesTabs();
  }

  Future<Either<Failure, BetSlipConfigurationEntity>>
      executeGetBetSlipConfiguration() {
    return repository.getBetSlipConfiguration();
  }

  Future<Either<Failure, SportTypeIconEntity>> executeGetSportTypeIcon() {
    return repository.getSportTypeIcon();
  }

  Future<Either<Failure, CountriesFlagModel>> executeGetCountriesFlags() {
    return repository.getCountriesFlags();
  }
}

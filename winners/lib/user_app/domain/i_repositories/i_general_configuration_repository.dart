import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/data/models/country_flag/countries_flag_model.dart';
import 'package:winners/user_app/domain/entities/bet_slip_configuration/bet_slip_configuration_entity.dart';
import 'package:winners/user_app/domain/entities/general_configuration/general_configuration_entity.dart';
import 'package:winners/user_app/domain/entities/leagues_tabs/leagues_tabs_entity.dart';
import 'package:winners/user_app/domain/entities/sport_type_icon/sport_type_icon_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IGeneralConfigurationRepository {
  Future<Either<Failure, GeneralConfigurationEntity>>
      getGeneralConfigurations();

  Future<Either<Failure, LeaguesTabsEntity>> getLeaguesTabs();

  Future<Either<Failure, BetSlipConfigurationEntity>> getBetSlipConfiguration();

  Future<Either<Failure, SportTypeIconEntity>> getSportTypeIcon();

  Future<Either<Failure, CountriesFlagModel>> getCountriesFlags();
}

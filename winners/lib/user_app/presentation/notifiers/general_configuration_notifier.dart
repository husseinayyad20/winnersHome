import 'dart:async';
import 'dart:convert';
import 'package:winners/user_app/core/constants/app_config.dart';
import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/models/country_flag/countries_flag_model.dart';
import 'package:winners/user_app/data/models/leagues_tabs/sport_top_leagues_tab.dart';
import 'package:winners/user_app/data/repositories/currency_repository_impl.dart';
import 'package:winners/user_app/data/repositories/general_configuration_repository_impl.dart';
import 'package:winners/user_app/data/repositories/teams_icons_repository_impl.dart';
import 'package:winners/user_app/domain/entities/bet_slip_configuration/bet_slip_configuration_entity.dart';
import 'package:winners/user_app/domain/entities/currency/currency_entity.dart';
import 'package:winners/user_app/domain/entities/general_configuration/general_configuration_entity.dart';
import 'package:winners/user_app/domain/entities/leagues_tabs/leagues_tabs_entity.dart';
import 'package:winners/user_app/domain/entities/sport_type_icon/sport_type_icon_entity.dart';
import 'package:winners/user_app/domain/entities/teams_icons_entity/teams_icons_entity.dart';
import 'package:winners/user_app/domain/usecases/get_currency_uc.dart';
import 'package:winners/user_app/domain/usecases/get_general_configuration_uc.dart';
import 'package:winners/user_app/domain/usecases/get_teams_icons_uc.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';

class GeneralConfigurationNotifier extends ChangeNotifier {
  GeneralConfigurationEntity? _config;
  CurrencyEntity? _currency;
  TeamsIconsDataEntity? _teamsIcons;
  LeaguesTabsEntity? _leaguesTabsEntity;
  LeaguesTab? _selectedLeaguesTab;
  SportTypeIconEntity? _sportTypeIconEntity;
  SportTypeIconEntity? get sportTypeIconEntity => _sportTypeIconEntity;
  CountriesFlagModel? _countriesFlag;
  late BetSlipConfigurationEntity _betSlipConfigurationEntity;
  bool _generalConfigurationIsLoading = false;
  bool get generalConfigurationIsLoading => _generalConfigurationIsLoading;
  final GetGeneralConfigurationUC _getGeneralConfigurationUsecase =
      GetGeneralConfigurationUC(
    GeneralConfigurationRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(
          // client: http.Client(),
          ),
    ),
  );
  final GetTeamsIconsUC _getTeamsIconsUsecase = GetTeamsIconsUC(
    TeamsIconsRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(
          // client: http.Client(),
          ),
    ),
  );
  final GetCurrencyUC _getCurrenciesUsecase = GetCurrencyUC(
    CurrencyRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(
          // client: http.Client(),
          ),
    ),
  );
  GeneralConfigurationEntity? get config => _config;
  CurrencyEntity? get currency => _currency;
  LeaguesTabsEntity? get leaguesTabsEntity => _leaguesTabsEntity;
  LeaguesTab? get selectedLeagueTab => _selectedLeaguesTab;
  CountriesFlagModel? get getContriesFlags => _countriesFlag;
  TeamsIconsDataEntity? get teamsIcons => _teamsIcons;
  BetSlipConfigurationEntity get betSlipConfigurationEntity =>
      _betSlipConfigurationEntity;
  String base64Decode(String encoded) {
    return utf8.decode(base64.decode(encoded));
  }

  Future<void> executeGetCurrencies() async {
    _getCurrenciesUsecase.execute().then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
          },
          (result) => setCurrency(result),
        );
      },
    );
  }

  Future<bool> executeGetGeneralConfigurations() async {
    bool done = false;
    _generalConfigurationIsLoading = true;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      notifyListeners();
    });

    await _getGeneralConfigurationUsecase.executeGetGeneralConfig().then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
            _generalConfigurationIsLoading = false;
            notifyListeners();
          },
          (result) => setGeneralConfiguration(result),
        );
        done = true;
      },
    );
    return done;
  }

  Future<void> executeGetCountriesFlags() async {
    _getGeneralConfigurationUsecase.executeGetCountriesFlags().then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
          },
          (result) => setFlags(result),
        );
      },
    );
  }

  Future<void> executeGetBetSlipConfiguration() async {
    await _getGeneralConfigurationUsecase.executeGetBetSlipConfiguration().then(
      (usecaseResult) {
        usecaseResult.fold((failure) {
          debugPrint('Failure');
        }, (result) => setBetSlipConfiguration(result));
      },
    );
  }

  Future<void> executeGetLeaguesTabs(HomeNotifier homeNotifier) async {
    _getGeneralConfigurationUsecase.executeGetLeaguesTabs().then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
          },
          (result) => setLeaguesTabs(result, homeNotifier),
        );
      },
    );
  }

  Future<void> executeGetTeamsIcons() async {
    _getTeamsIconsUsecase.execute().then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
          },
          (result) => setTeamsIcons(result),
        );
      },
    );
  }

  void setCurrency(CurrencyEntity newCurrency) {
    _currency = newCurrency;
    notifyListeners();
  }

  void setGeneralConfiguration(GeneralConfigurationEntity newConfig) {
    _config = newConfig;
    if (_config!.success!) {
      AppConfig.feedSr = _config!.data!.feedSr!;
    }

    notifyListeners();
  }

  void setFlags(CountriesFlagModel flags) {
    _countriesFlag = flags;
    notifyListeners();
  }

  void setBetSlipConfiguration(BetSlipConfigurationEntity betSlipConfig) {
    _betSlipConfigurationEntity = betSlipConfig;
    if (_betSlipConfigurationEntity.success!) {
      AppConfig.betSlipAmountLd =
          betSlipConfigurationEntity.data!.betSlipConstants!.betSlipAmountLd!;
      AppConfig.betSlipAmountUsd =
          betSlipConfigurationEntity.data!.betSlipConstants!.betSlipAmountUsd!;
    }

    notifyListeners();
  }

  void setLeaguesTabs(LeaguesTabsEntity newEntity, HomeNotifier homeNotifier) {
    _leaguesTabsEntity = newEntity;
    setLeaguesTab(
      _leaguesTabsEntity!.sportTopLeaguesTab!.firstWhere(
        (element) {
          return element.preMatchTopLeaguesTabId == 1;
        },
      ),
    );

    // homeNotifier.startHub(config!.data!.feedSr!);

    Future.delayed(const Duration(seconds: 2), () {
      homeNotifier.league = selectedLeagueTab;
      homeNotifier.invokeWithDate();
      notifyListeners();
    });
  }

  void setTeamsIcons(TeamsIconsDataEntity newTeamsIcons) {
    _teamsIcons = newTeamsIcons;
    notifyListeners();
  }

  void setLeaguesTab(LeaguesTab newLeagueTab) {
    _selectedLeaguesTab = newLeagueTab;
    notifyListeners();
  }

  //get data
  Future<void> executeGetSportTypeIcon() async {
    _getGeneralConfigurationUsecase.executeGetSportTypeIcon().then(
      (useCaseResult) {
        useCaseResult.fold(
          (failure) {
            debugPrint(failure.message);
          },
          (result) => setSportTypeIcon(result),
        );
      },
    );
  }

  void setSportTypeIcon(SportTypeIconEntity sportTypeIconEntity) {
    _sportTypeIconEntity = sportTypeIconEntity;
  }
}

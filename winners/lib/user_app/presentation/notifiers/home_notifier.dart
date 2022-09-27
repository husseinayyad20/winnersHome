import 'dart:convert';
import 'dart:developer';
import 'package:archive/archive_io.dart';
import 'package:winners/user_app/data/datasources/remote_data_source.dart';

import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/data.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/event_odd.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/event_score.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/get_top_bet_sport_event_response_model.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/sport_event.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/top_bet_type.dart';
import 'package:winners/user_app/data/models/leagues_tabs/sport_top_leagues_tab.dart';
import 'package:winners/user_app/data/models/sport_type/sport.dart';
import 'package:winners/user_app/data/models/sport_type/sport_type.dart';
import 'package:winners/user_app/data/models/sports_categories/sports_categories.dart';
import 'package:winners/user_app/data/repositories/banner_repository_impl.dart';
import 'package:winners/user_app/data/repositories/header_repository_impl.dart';
import 'package:winners/user_app/data/repositories/pages_repository_implementation.dart';
import 'package:winners/user_app/domain/entities/banner/banner_entity.dart';
import 'package:winners/user_app/domain/entities/header/header_entity.dart';
import 'package:winners/user_app/domain/entities/page/page_entity.dart';
import 'package:winners/user_app/domain/entities/sport_category/sport_category_data_entity.dart';
import 'package:winners/user_app/domain/entities/sport_type/sport_type_entity.dart';
import 'package:winners/user_app/domain/entities/top_bet_sport_event/top_bet_sport_event_entity.dart';
import 'package:winners/user_app/domain/usecases/get_banner_uc.dart';
import 'package:winners/user_app/domain/usecases/get_header_tabs_uc.dart';
import 'package:winners/user_app/domain/usecases/get_page_uc.dart';
import 'package:winners/user_app/presentation/notifiers/general_configuration_notifier.dart';
import 'package:winners/user_app/presentation/notifiers/match_notifier.dart';
import 'package:flutter/material.dart';

import 'package:signalr_netcore/http_connection_options.dart';
import 'package:signalr_netcore/hub_connection.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';
import 'package:signalr_netcore/itransport.dart';


import '../pages/home/home_page.dart';

class HomeNotifier extends ChangeNotifier {
  GeneralConfigurationNotifier? configurationNotifier;
  int _feedId = 6;
  Map<String, dynamic> _virtualOdds = {};
  Map<String, dynamic> _odds = {};
  Map<String, dynamic> get virtualOdds => _virtualOdds;
  Map<String, dynamic> get odds => _odds;
  List<LeaguesTabItem> _leaguesTabs = [];
  bool _isStaticIconSelected = false;
  bool showVirtualSportType = false;
  bool showVirtualMatches = false;
  PageEntity? _pageEntity;
  PageEntity? get pageEntity => _pageEntity;
  GetPageUC getPageUseCase = GetPageUC(
    PagesRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(),
    ),
  );
    Future getPage(String pageName) async {
    _pageEntity = null;
    await getPageUseCase.execute(pageName).then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
          },
          (result) => setPage(result),
        );
      },
    );
  }
 void setPage(PageEntity newPage) {
    _pageEntity = newPage;
    notifyListeners();
  }
  void setShowVirtualSportType(bool newBoolean) {
    showVirtualSportType = newBoolean;
    notifyListeners();
  }

  void setShowVirtualMatches(bool newBoolean) {
    showVirtualMatches = newBoolean;
    notifyListeners();
  }

  bool get isStaticIconSelected => _isStaticIconSelected;
  // when user tab on static icon show frame or hide
  void setStaticIconSelected(bool value) {
    _isStaticIconSelected = value;
    notifyListeners();
  }

  void setConfigNotifier(GeneralConfigurationNotifier notifier) {
    configurationNotifier = notifier;
  }

  void setOdds(Map<String, dynamic> newOdds) {
    _odds = newOdds;
    notifyListeners();
  }

  void setVirtualOdds(Map<String, dynamic> newOdds) {
    _virtualOdds = newOdds;
    notifyListeners();
  }

  MatchNotifier? _matchNotifier;
  MatchNotifier? _virtualMatchNotifier;
  MatchNotifier? get virtualMatchNotifier => _virtualMatchNotifier;
  setMatchNotifier(MatchNotifier matchNotifier) {
    _matchNotifier = matchNotifier;
    notifyListeners();
  }

  setVirtualMatchNotifier(MatchNotifier matchNotifier) {
    _virtualMatchNotifier = matchNotifier;
    notifyListeners();
  }

  setLeaguesTabs(List<LeaguesTabItem> leagues) {
    _leaguesTabs = leagues;
  }

  deselectMatchNotifier() {
    _matchNotifier = null;
    _virtualMatchNotifier = null;
    notifyListeners();
  }


  MatchNotifier? get matchNotifier => _matchNotifier;
  List<LeaguesTabItem> get leaguesTabs => _leaguesTabs;

  SportTypeEntity? sportTypes = const SportTypeEntity();
  SportTypeEntity virtualSportTypes = const SportTypeEntity(
    data: [],
  );
  Sport selectedSport = const Sport(
      sportId: 1, sportDisplayName: 'Soccer', sportOrder: 1, feedId: 1);
  SportEvent? _selectedSportEvent = const SportEvent();
  SportEvent? _selectedVirtualSportEvent = const SportEvent();
  String? _country;
  String? _virtualCountry;
  HeaderEntity? _header;
  BannerEntity? _banners;
  TopBetSportEventEntity? _betSportEventEntity;
  TopBetSportEventEntity? _virtualBetSportEventEntity;
  SportCategoryDataEntity? _sportsCategoryDataEntity;
  LeaguesTab? league;
  List<TopBetType>? _betTypes;
  TopBetType? _selectedBetType;
  TopBetType? get selectedBetType => _selectedBetType;
  List<TopBetType>? _virtualBetTypes;
  List<TopBetType>? get virtualBetTypes => _virtualBetTypes;
  TopBetType? _selectedVirtualBetType;
  TopBetType? get selectedVirtualBetType => _selectedVirtualBetType;

  String? _virtualMatchDay = '';
  String? _virtualSeasonId = '';
  int? _virtualSportId;
  Sport? _virtualSportType;
  int? _virtualFeedId;
  Sport? get virtualSportType => _virtualSportType;
  String? get virtualMatchDay => _virtualMatchDay;
  String? get virtualSeasonId => _virtualSeasonId;
  int? get virtualSportId => _virtualSportId;
  int? get virtualFeedId => _virtualFeedId;

  void setVirtualBetTypes(List<TopBetType> newVirtualBetTypes) {
    if (_virtualBetTypes?.isNotEmpty ?? false) {
      _virtualBetTypes!.clear();
    }
    _virtualBetTypes = newVirtualBetTypes;
    notifyListeners();
  }

  void setVirtualMatchDay(String newMatchDay) {
    _virtualMatchDay = newMatchDay;
    notifyListeners();
  }

  void setVirtualSeasonId(String newSeasonId) {
    _virtualSeasonId = newSeasonId;
    notifyListeners();
  }

  void setVirtualFeedId(int feedId) {
    _virtualFeedId = feedId;

    notifyListeners();
  }

  void setVirtualSportId(int newSportId, Sport sportType) {
    _virtualSportId = newSportId;
    _virtualSportType = sportType;
    notifyListeners();
  }

  void setLeague(LeaguesTab newLeague) {
    league = newLeague;
    notifyListeners();
  }

  void setSelectedBetType(TopBetType betType) {
    _selectedBetType = betType;
    notifyListeners();
  }

  void setSelectedDay(int day) {
    selectedDay = day;
    notifyListeners();
  }

  String? _noMatchesErrorMessage = "";
  Map<String, dynamic>? _matchOdds;
  Map<String, dynamic>? _virtualMatchOdds;
  Map<String, dynamic>? get matchOdds => _matchOdds;
  Map<String, dynamic>? get virtualMatchOdds => _virtualMatchOdds;
  String? get noMatchesErrorMessage => _noMatchesErrorMessage;
  SportEvent? _selectedMatch;
  SportEvent? get selectedMatch => _selectedMatch;
  void setSelectedMatch(SportEvent sportEvent) {
    _selectedMatch = sportEvent;
    notifyListeners();
  }

  void setNoMatchesErrorMessage(String newError) {
    _noMatchesErrorMessage = newError;
    notifyListeners();
  }

  void setMatch(Map<String, dynamic> odds) {
    _matchOdds = odds;
    notifyListeners();
  }

  void setVirtualMatch(Map<String, dynamic> odds) {
    _virtualMatchOdds = odds;
    notifyListeners();
  }

  int selectedDay = 0;
  int selectedHeaderId = 0;
  Map<String, dynamic> eventOddFields = {};
  Map<String, dynamic> _virtualEventOddFields = {};
  Map<String, dynamic> get virtualEventOddFields => _virtualEventOddFields;
  void setVirtualEventOddFields(Map<String, dynamic> newMap) {
    _virtualEventOddFields = newMap;
    notifyListeners();
  }

  GetBannerUC getBannersUsecase = GetBannerUC(
    BannerRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(
          // client: http.Client(),
          ),
    ),
  );
  GetHeaderUC getHeaderUC = GetHeaderUC(
    HeaderRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(
          // client: http.Client(),
          ),
    ),
  );

  BannerEntity? get banners => _banners;
  TopBetSportEventEntity? get betSportEventEntity => _betSportEventEntity;
  TopBetSportEventEntity? get virtualBetSportEventEntity =>
      _virtualBetSportEventEntity;
  List<TopBetType> get betTypes => _betTypes ?? [];
  String? get country => _country;
  String? get virtualCountry => _virtualCountry;
  HeaderEntity? get header => _header;
  int get feedIndex => _feedId;
  // TopBetType get selectedBetType => betTypes[betTypeIndex];

  SportEvent? get selectedSportEvent => _selectedSportEvent;
  SportEvent? get selectedVirtualSportEvent => _selectedVirtualSportEvent;
  SportCategoryDataEntity? get sportsCategories => _sportsCategoryDataEntity;

  String decode(String data) {
    final str = base64.decode(data);
    final deflated = Inflate(str);
    final decodedString = String.fromCharCodes(deflated.getBytes());
    return decodedString;
  }

  executeGetBanners() async {
    await getBannersUsecase.execute().then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
          },
          (result) => setBanners(result),
        );
      },
    );
  }

  executeGetHeader() async {
    await getHeaderUC.execute().then(
      (usecaseResult) {
        usecaseResult.fold(
          (failure) {
            debugPrint('Failure');
          },
          (result) => setHeader(result),
        );
      },
    );
  }

  getSportTypes({int? feedId}) async {
    await hubConnection.invoke(
      'GetSportTypes',
      args: [
        {
          'Data': {
            'Feed': {
              'FeedId': feedId ?? 6,
            },
          },
        },
      ],
    ).then((value) {
      debugPrint('GetSportTypes Invoke.then');
    }).catchError((onError) {
      debugPrint('GetSportTypes Invoke.catchError ${onError.toString()}');
    });
  }

  setBetTypes(List<TopBetType> bets) {
    _betTypes = bets;
    notifyListeners();
  }

  Future<bool> getTopBetSportEvent() async {
    bool done = false;
    hubConnection.on('OnSportCategories', (arguments) {
      try {
        String response = decode(arguments!.first.toString());
        Map<String, dynamic> encodedResponse = json.decode(response);
        SportsCategoriesModel model =
            SportsCategoriesModel.fromMap(encodedResponse);
        setSportsCategories(model.toDataEntity());
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    hubConnection.on('OnTopBetTypes', (arguments) {
      try {
        String response = decode(arguments!.first.toString());
        Map<String, dynamic> encodedResponse = json.decode(response);
        List<TopBetType> temp = [];
        var list = encodedResponse['data'] as List;
        for (var element in list) {
          temp.add(TopBetType.fromMap(element));
        }
        setBetTypes(temp);
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    hubConnection.invoke(
      'GetTopBetTypes',
      args: [
        {
          'Data': {
            'Feed': {
              'FeedId': feedIndex,
            },
            'Sport': {
              'SportId': selectedSport.sportId,
            },
          },
        },
      ],
    );
    hubConnection.invoke(
      'GetSportCategories',
      args: [
        {
          'Data': {
            'Feed': {
              'FeedId': feedIndex,
            },
            'Sport': {
              'SportId': selectedSport.sportId,
            },
          },
        }
      ],
    ).then((value) {
      debugPrint(
        hubConnection.state.toString(),
      );
      debugPrint(
        'GetSportCategories:::::: invoke ',
      );
    }).catchError((onError) {
      debugPrint(
        'GetSportCategories:::::: invoke error ${onError.toString()}',
      );
    });
    return done;
  }

  setBanners(BannerEntity newBanners) {
    _banners = newBanners;
    notifyListeners();
  }

  setBetSportEvent(TopBetSportEventEntity? newBetSportEvent) {
    _betSportEventEntity = newBetSportEvent;
    notifyListeners();
  }

  setFeedId(int newId) {
    _feedId = newId;
    notifyListeners();
  }

  setHeader(HeaderEntity newHeader) {
    if (newHeader.data == null) {
      return;
    }
    _header = newHeader;
    selectedHeaderId = newHeader.data!.headerTabs!.first.headerTabsId!;
    notifyListeners();
  }

  int selectedSportIndex = 0;
  setSelectedSport(Sport newSport, {int? index}) {
    if (index != null) {
      selectedSportIndex = index;
    }
    selectedSport = newSport;
    _betSportEventEntity = null;
    Future.delayed(
      const Duration(microseconds: 500),
      () {
        setSelectedBetType(const TopBetType());
      },
    );
    getTopBetSportEvent();
    notifyListeners();
  }

  setSportEvent(SportEvent newSportEvent, String newCountry) {
    _country = newCountry;
    _selectedSportEvent = newSportEvent;
    notifyListeners();
  }

  setVirtualSportEvent(SportEvent newSportEvent, String newCountry) {
    _virtualCountry = newCountry;
    _selectedVirtualSportEvent = newSportEvent;
  }

  clearSelectedEvent() {
    _selectedSportEvent = null;
    _selectedVirtualSportEvent = null;
    notifyListeners();
  }

  setSportsCategories(SportCategoryDataEntity newSportsCategory) {
    _sportsCategoryDataEntity = newSportsCategory;
    notifyListeners();
  }

  void setSportTypes(SportTypeEntity? newEntity) {
    bool containsVirtual = newEntity?.data
            ?.where((element) =>
                element.feed!.feedId == 7 ||
                element.feed!.feedId == 8 ||
                element.feed!.feedId == 9)
            .isNotEmpty ??
        false;
    if (containsVirtual) {
      virtualSportTypes = newEntity!;
    } else {
      sportTypes = newEntity;
      if (sportTypes?.data?.isNotEmpty ?? false) {
        selectedSport = sportTypes!.data!.first.sport!;
      }
    }
    notifyListeners();
  }

  late HubConnection hubConnection;

  invokeGroup(String group, List<String> args) async {
    hubConnection
        .invoke(
      group,
      args: args,
    )
        .then((value) {
      debugPrint('$group invoked with ${args.toString()}');
    }).catchError((onError) {
      debugPrint('$group error with ${args.toString()} ${onError.toString()}');
    });
  }

  var reconnectTry = 5;

  startHub(String hub) async {
    hubConnection = HubConnectionBuilder()
        .withAutomaticReconnect()
        .withUrl(hub,
            options: HttpConnectionOptions(
                logMessageContent: true,
                skipNegotiation: true,
                transport: HttpTransportType.WebSockets))
        .build();
    hubConnection.keepAliveIntervalInMilliseconds = 100000;
    hubConnection.serverTimeoutInMilliseconds = 100000;

    await hubConnection.start()!.then((value) {
      debugPrint(
        'hubConnection   :::::: Started ${hubConnection.state.toString()}',
      );
      reconnectTry = 5;

      getHubData();
    }).catchError((onError) {
      debugPrint(
        'hubConnection :::::: Start error ${onError.toString()}',
      );
      reconnectTry -= 1;
      if (reconnectTry > 0) {
        debugPrint(
          'hubConnection ::::  retry counter $reconnectTry',
        );
        startHub(hub);
      }
    });
    hubConnection.onreconnecting(({error}) {
      debugPrint(
        'onReconnecting ${error.toString()}',
      );
    });
    hubConnection.onclose(({error}) {
      debugPrint(
        'onClose ${error.toString()}',
      );
    });
    hubConnection.onreconnected(({connectionId}) {
      debugPrint(
        'onReconnected $connectionId',
      );
      if (feedIndex != 5) {
        getHubData();
      }
    });
  }

  getHubData() {
    streamIt();
    if (feedIndex == 5) {
      getSportTypes(feedId: 5);
    } else {
      getSportTypes();
    }
    getTopBetSportEvent();
    executeGetBanners();
    executeGetHeader();
  }

  bool loading = false;
  setLoading(bool newValue) {
    loading = newValue;
    notifyListeners();
  }

  streamIt() async {
    hubConnection.on(
      'OnSportEvents',
      (arguments) {
        debugPrint(
            '************************************************** OnVirtualEvents *****************************************************************');
        try {
          _virtualBetSportEventEntity = null;
          _virtualBetSportEventEntity = TopBetSportEventEntity();
          _virtualBetSportEventEntity!.data = TopBetSportEventData();
          _virtualBetSportEventEntity!.data!.sportEvents = [];

          notifyListeners();
          String decoded = decode(arguments!.first.toString());
          Map<String, dynamic> encodedResponse = json.decode(decoded);
          if (encodedResponse['status'] == 3) {
            virtualErrorMessage = encodedResponse['message'];
            setLoading(false);
            notifyListeners();
            return;
          }

          List<TopBetType> temp = [];

          var list = encodedResponse['data']['topBetTypes'] ?? [];
          for (var element in list) {
            temp.add(TopBetType.fromMap(element));
          }

          // Virtual Sport Events
          final sportEvents =
              encodedResponse['data']['sportEvents'] as Map<String, dynamic>;
          List<SportEvent> tempSportEvents = [];
          debugPrint(
              '**************************************************sportEvents.length ::::: ${sportEvents.length} *****************************************************************');
          sportEvents.forEach(
            (key, value) {
              bool empty = tempSportEvents.isEmpty;
              // (_virtualBetSportEventEntity?.data?.sportEvents ?? [])
              //     .isEmpty;
              bool exist = tempSportEvents
                  // (_virtualBetSportEventEntity?.data?.sportEvents ?? [])
                  .where((element) => element.id.toString() == value['id'])
                  .isNotEmpty;
              if (empty) {
                // _virtualBetSportEventEntity?.data?.sportEvents
                tempSportEvents = [SportEvent.fromMap(value)];
              }
              // else if (exist) {
              //   int itemIndex = tempSportEvents
              //       // _virtualBetSportEventEntity!.data!.sportEvents!
              //       .indexWhere((element) =>
              //           element.id.toString() == value['id'].toString());
              //   // _virtualBetSportEventEntity!.data!.sportEvents!
              //   tempSportEvents[itemIndex] = SportEvent.fromMap(value);
              // }
              else {
                // _virtualBetSportEventEntity?.data?.sportEvents?
                tempSportEvents.add(
                  SportEvent.fromMap(value),
                );
              }
            },
          );
          // // Virtual Event Odd Fields
          // // Virtual Event Odds
          _virtualBetSportEventEntity?.data?.eventOdds = [];
          final newEventOdds = encodedResponse['data']['eventOdds'];
          newEventOdds.forEach((key, eventOdd) {
            final eventOdds = eventOdd as Map<String, dynamic>;
            eventOdds.forEach((innerKey, innerOdd) {
              bool empty =
                  (_virtualBetSportEventEntity?.data?.eventOdds ?? []).isEmpty;
              bool exist = (_virtualBetSportEventEntity?.data?.eventOdds ?? [])
                  .where((element) => element.id.toString() == eventOdd['id'])
                  .isNotEmpty;
              if (empty) {
                _virtualBetSportEventEntity?.data?.eventOdds = [
                  EventOdd.fromMap(eventOdds)
                ];
              } else if (exist) {
                // If exist, replace the existing record

                // Gets the index of the existing record
                var itemIndex = _virtualBetSportEventEntity!.data!.eventOdds!
                    .indexWhere((item) => item.key == innerOdd[key]);

                // Replaces existing record with the new one
                _virtualBetSportEventEntity!.data!.eventOdds!
                    .removeAt(itemIndex == -1 ? 0 : itemIndex);
                _virtualBetSportEventEntity!.data!.eventOdds!.insert(
                  itemIndex == -1 ? 0 : itemIndex,
                  EventOdd.fromMap(
                    innerOdd,
                  ),
                );
              } else {
                /// If does not exist add it to the origin list
                _virtualBetSportEventEntity?.data!.eventOdds!.add(
                  EventOdd.fromMap(
                    innerOdd,
                  ),
                );
              }
            });
          });

          final eventOddFields = encodedResponse['data']['eventOddFields'];
          _virtualBetSportEventEntity!.data!.sportEvents = tempSportEvents;
          notifyListeners();

          setVirtualEventOddFields(eventOddFields);
          setVirtualBetTypes(temp);
          // Future.delayed(const Duration(seconds: 2), () {
          setLoading(false);
          notifyListeners();
          return;
          // });
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
    hubConnection.on('OnSportTypes', (arguments) {
      try {
        // TODO:- Declare Index is Changing
        String response = decode(arguments!.first.toString());
        SportType model =
            SportType.fromJson(json.encode(json.decode(response)));
        model.data!.sort((a, b) {
          return a.sport!.sportOrder!.compareTo(b.sport!.sportOrder!);
        });
        setSportTypes(model.toEntity());
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    hubConnection.on('OnJoinGroup', (arguments) {
      // debugPrint(
      //   'OnJoinGroup',
      // );
    });
    hubConnection.on('OnPartGroup', (arguments) {
      // debugPrint(
      //   'OnPartGroup',
      // );
    });
    hubConnection.on('OnEventOddsChange', (arguments) {
      try {
        String response = decode(arguments!.first.toString());
        Map<String, dynamic> encodedEventOdds = json.decode(response);
        final newEventOdds =
            encodedEventOdds['data']['eventOdds'] as Map<String, dynamic>;
        newEventOdds.forEach((key, eventOdd) {
          final eventOdds = eventOdd as Map<String, dynamic>;
          eventOdds.forEach((innerKey, innerOdd) {
            var exist = _betSportEventEntity?.data!.eventOdds!
                .where((item) => innerOdd['key'].toString() == item.key)
                .isNotEmpty;
            if (exist ?? false) {
              /// If exist, replace the existing record

              /// Gets the index of the existing record
              var itemIndex = _betSportEventEntity!.data!.eventOdds!
                  .indexWhere((item) => item.key == innerOdd[key]);

              /// Replaces existing record with the new one
              _betSportEventEntity!.data!.eventOdds!
                  .removeAt(itemIndex == -1 ? 0 : itemIndex);
              _betSportEventEntity!.data!.eventOdds!.insert(
                itemIndex == -1 ? 0 : itemIndex,
                EventOdd.fromMap(
                  innerOdd,
                ),
              );
            } else {
              /// If does not exist add it to the origin list
              _betSportEventEntity?.data!.eventOdds!.add(
                EventOdd.fromMap(
                  innerOdd,
                ),
              );
            }
          });
        });
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    hubConnection.on('OnSportEventsChange', (arguments) {
      try {
        String response = decode(arguments!.first.toString());
        Map<String, dynamic> encodedResponse = json.decode(response);
        final sportEvents =
            encodedResponse['data']['sportEvents'] as Map<String, dynamic>;
        sportEvents.forEach(
          (key, value) {
            final vals = _betSportEventEntity?.data?.sportEvents ?? [];
            bool exist = vals
                .where((element) => element.id.toString() == value['id'])
                .isNotEmpty;

            if (exist) {
              int itemIndex = _betSportEventEntity!.data!.sportEvents!
                  .indexWhere((element) =>
                      element.id.toString() == value['id'].toString());
              _betSportEventEntity!.data!.sportEvents![itemIndex] =
                  SportEvent.fromMap(value);
            } else {
              _betSportEventEntity!.data!.sportEvents!.add(
                SportEvent.fromMap(value),
              );
            }
          },
        );
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    hubConnection.on('OnUpcomingEventsChange', (arguments) {
      debugPrint('OnUpcomingEventsChange');
      //debugPrint(decode(arguments!.first.toString()));
    });
    hubConnection.on('OnSportTopLeaguesChange', (arguments) {
      debugPrint('OnSportTopLeaguesChange');
      // debugPrint(decode(arguments!.first.toString()));
    });
    hubConnection.on('OnSportCategoriesChange', (arguments) {
      debugPrint('OnSportCategoriesChange');
      // debugPrint(decode(arguments!.first.toString()));
    });
    hubConnection.on('OnSportTypesChange', (arguments) {
      try {
        // debugPrint(decode(arguments!.first.toString()));
        String response = decode(arguments!.first.toString());
        Map<String, dynamic> encodedResponse = json.decode(response);
        final topBetTypes = encodedResponse['data']['topBetTypes'] as List;
        for (var betType in topBetTypes) {
          var exist = _betSportEventEntity!.data!.topBetTypes!
              .where((element) => element.key! == betType['key'])
              .isNotEmpty;
          if (exist) {
            int itemIndex = _betSportEventEntity!.data!.topBetTypes!
                .indexWhere((element) => element.key! == betType['key']);
            _betSportEventEntity!.data!.topBetTypes!.removeAt(itemIndex);
            _betSportEventEntity!.data!.topBetTypes!
                .add(TopBetType.fromJson(betType));
          } else {
            _betSportEventEntity!.data!.topBetTypes!
                .add(TopBetType.fromJson(betType));
          }
        }
        _betSportEventEntity!.data!.topBetTypes!.sort(((a, b) {
          return a.betTypeId!.compareTo(b.id);
        }));
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    hubConnection.on('OnEventScoreChange', (arguments) {
      try {
        String response = decode(arguments!.first.toString());
        Map<String, dynamic> encodedResponse = json.decode(response);
        final sportScores = encodedResponse['data']['eventScores'] as List;
        if (sportScores.isEmpty) return;

        final eventScoreJson = sportScores.first;
        final score = EventScore.fromMap(eventScoreJson);
      } catch (e) {
        debugPrint(e.toString());
      }
    });
    hubConnection.on('OnSportTournamentsChange', (arguments) {
      debugPrint('OnSportTournamentsChange');
      //debugPrintdecode(arguments!.first.toString()));
    });
    hubConnection.on('OnEventOddGroupsChange', (arguments) {
      debugPrint('OnEventOddGroupsChange');
      //debugPrint(decode(arguments!.first.toString()));
    });
    hubConnection.on('OnSportEventsByTabAndDate', (arguments) {
      try {
        setNoMatchesErrorMessage("");
        String response = decode(arguments!.first.toString());
        // debugPrint(response);
        Map<String, dynamic> encodedResponse = json.decode(response);
        log(encodedResponse.toString());
        GetTopBetSportEventResponseModel newModel =
            GetTopBetSportEventResponseModel.fromMap(encodedResponse);
        // The condition below allows to switch to All Countries
        if (newModel.data?.tournamentsByDayList == null &&
            newModel.status != 3) {
          league = configurationNotifier!.leaguesTabsEntity?.sportTopLeaguesTab
              ?.firstWhere((element) => element.id == 0);
          configurationNotifier!.setLeaguesTab(league!);
          notifyListeners();
          invokeWithDate();
          return;
        } else if (newModel.status == 3) {
          setNoMatchesErrorMessage(newModel.message);
        }
        setTopBetSportEvents(newModel);
      } catch (e) {
        debugPrint(e.toString());
      }

      // setBetSportEvent(model.toEntity());
    });
  }

  GetTopBetSportEventResponseModel? _topBetSportEvent;
  GetTopBetSportEventResponseModel? get topBetSportEvent => _topBetSportEvent;
  GetTopBetSportEventResponseModel? _virtualSportEvent;
  GetTopBetSportEventResponseModel? get virtualSportEvent => _virtualSportEvent;
  setTopBetSportEvents(GetTopBetSportEventResponseModel? newTopBetSportevent) {
    _topBetSportEvent = newTopBetSportevent;
    final tournamentsByDayListCount =
        _topBetSportEvent?.data?.tournamentsByDayList?.length ?? 0;
    final categoriesByBetTypeListCount =
        _topBetSportEvent?.data?.categoriesByBetTypeList?.length ?? 0;
    final categoriesByDateListCount =
        _topBetSportEvent?.data?.categoriesByDateList?.length ?? 0;
    final catsCount = categoriesByDateListCount +
        categoriesByBetTypeListCount +
        tournamentsByDayListCount;
    if ((catsCount) > 0) {
      if (_topBetSportEvent?.data?.tournamentsByDayList?.isNotEmpty ?? false) {
        _topBetSportEvent?.data?.tournamentsByDayList?.first.isExpanded = true;
        _topBetSportEvent?.data?.tournamentsByDayList?.first.sportTournaments
            ?.first.isExpanded = true;
      }
      // if (_topBetSportEvent?.data?.categoriesByBetTypeList?.isNotEmpty ??
      //     false) {
      //   // _topBetSportEvent?.data?.categoriesByBetTypeList?.first.isExpanded =
      //   //     true;
      //   // _topBetSportEvent?.data?.categoriesByBetTypeList?.first.isExpanded =
      //   //     true;
      // }

      // if (_topBetSportEvent?.data?.categoriesByDateList?.isNotEmpty ?? false) {
      //   _topBetSportEvent?.data?.categoriesByDateList?.first.isExpanded = true;
      //   _topBetSportEvent?.data?.categoriesByDateList?.first.sportTournaments
      //       ?.first.isExpanded = true;
      // }
    }

    notifyListeners();
  }

  setVirtualSportEvents(GetTopBetSportEventResponseModel? newTopBetSportevent) {
    _virtualSportEvent = newTopBetSportevent;
    notifyListeners();
  }

  invokeWithDate({int? sportId}) async {
    if (hubConnection.state != HubConnectionState.Connected) {
      Future.delayed(const Duration(seconds: 2), () {
        if (reconnectTry == 0) {
          return;
        }
        invokeWithDate();
      });
      return;
    }
    setBetSportEvent(null);
    setTopBetSportEvents(null);
    int? liveLeague = league?.liveTopLeaguesTabId;
    int? prematchLeague = league?.preMatchTopLeaguesTabId;
    int? feedId = _feedId;
    int day = selectedDay;
    int betTypeId = selectedBetType?.betTypeId ?? 1;
    debugPrint('$liveLeague $prematchLeague $feedId $day $betTypeId ');
    if (liveLeague == null || prematchLeague == null) {
      debugPrint('GetSportEventsByTabAndDate returned');
      return;
    }
    final map = {
      'Data': {
        'Feed': {'FeedId': feedIndex},
        'Sport': {
          'SportId': sportId ?? selectedSport.sportId,
        },

        /// Always zero for LIVE TAB
        'Day': day,
        'PreMatchCategoryTabId': feedIndex == 5 ? 4 : prematchLeague,
        'LiveCategoryTabId': feedIndex == 5 ? 4 : liveLeague,
        'BetTypeId': _selectedBetType?.betTypeId ?? 1,
        // 'BetTypeId': 1,
        'IsLastMin': false,
      },
    };

    hubConnection.invoke(
      'GetSportEventsByTabAndDate',
      args: [map],
    ).then((value) {
      // debugPrint(
      //   hubConnection.state.toString(),
      // );
      debugPrint(map.toString());
      debugPrint(
        'GetSportEventsByTabAndDate :::::: invoke ',
      );
    }).catchError((onError) {
      debugPrint(
        'GetSportEventsByTabAndDate :::::: invoke error ${onError.toString()}',
      );
    });
  }

  String virtualErrorMessage = '';

  invokeVirtual() async {
    Map<String, dynamic> invokeMap = {
      'Data': {
        'Feed': {
          'FeedId': _virtualFeedId,
        },
        'MatchDay': int.parse(virtualMatchDay.toString()),
        'Season': int.parse(virtualSeasonId.toString()),
        'Sport': {
          'SportId': _virtualSportId,
        }
      },
    };
    debugPrint(invokeMap.toString());
    setLoading(true);
    hubConnection.invoke(
      'GetVirtualEvents',
      args: [invokeMap],
    ).then((value) {
      debugPrint('GetVirtualEvents Invoked $invokeMap');
    }).catchError((e) {
      debugPrint('GetVirtualEvents Invoke Error $e');
    });
    debugPrint(
        '************************************************** GetVirtualEvents $invokeMap *****************************************************************');
  }

  setVirtualSelectedBetType(TopBetType bet) {
    _selectedVirtualBetType = bet;
    notifyListeners();
  }
}

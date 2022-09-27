import 'dart:convert';
import 'dart:developer';
import 'package:archive/archive.dart';
import 'package:winners/user_app/core/constants/app_config.dart';
import 'package:winners/user_app/core/constants/strings.dart';
import 'package:winners/user_app/data/datasources/remote_data_source.dart';
import 'package:winners/user_app/data/models/bet_slip/bet_slip_item/bet_slip_item.dart';
import 'package:winners/user_app/data/models/bet_slip/place_bet/singles_bet_form_detail.dart';
import 'package:winners/user_app/data/repositories/bet_slip_repository_impl.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_code_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_sports_icons_entity%20copy.dart';
import 'package:winners/user_app/domain/entities/bet_slip/place_bet_entity.dart';
import 'package:winners/user_app/domain/entities/bet_slip_configuration/bet_slip_configuration_entity.dart';
import 'package:winners/user_app/domain/usecases/bet_slip_uc.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection_builder.dart';

import 'package:winners/user_app/data/models/bet_slip/data.dart';

class BetSlipNotifier extends ChangeNotifier {
  bool _isBetSlipLoaded = false;
  bool _isCreateBetCodeLoading = false;
  bool _loadBetCodeLoading = false;
  bool _isPlaceBetLoading = false;
  bool _hideStakeAmount = false;
  bool _showData = false;

  bool? _betSlipConfigurationIsLoad;

  int _index = 1;
  int _stakeAmount = 100;
  int _stakeAmountForMultiple = 100;
  late double _totalOdd;

  List<int> _amount = [];
  List<double> _possibleWinnings = [];

  late double _stakePossibleWinnings, _stakePossibleWinningsForMultiple;
  final TextEditingController _betCodeEditingController =
      TextEditingController();
  String _currency = "LD";
  bool isMultiple = true;
  final List<BetSlipItem> _betItems = [];
  late List<BetSlipItem> _tempBetItems = [];
  List<int> eventIdList = [];
  BetSlipEntity? _betSlip;
  PlaceBetEntity? _placeBet;
  BetCodeEntity? _betCodeEntity;
  BetSlipConfigurationEntity? _betSlipConfigurationEntity;
  BetSlipSportIconsEntity? _betSlipSportIconsEntity;
  final List<Map> _errorsMsg = [];
  bool hasErrorOnPlaceBetSingle = false;
  final List<String> _placeBetSingleErrorsMsg = [];

  List<String> get placeBetSingleErrorsMsg => _placeBetSingleErrorsMsg;

  BetSlipEntity? get betSlip => _betSlip;

  PlaceBetEntity? get placeBet => _placeBet;

  BetCodeEntity? get betCodeEntity => _betCodeEntity;

  BetSlipSportIconsEntity? get betSlipSportIconsEntity =>
      _betSlipSportIconsEntity;

  List<BetSlipItem> get betItems => _betItems;

  String get currency => _currency;

  bool get isBetSlipLoaded => _isBetSlipLoaded;

  bool get isCreateBetCodeLoading => _isCreateBetCodeLoading;

  bool get isPlaceBetLoading => _isPlaceBetLoading;

  bool get hideStakeAmount => _hideStakeAmount;

  bool get showData => _showData;

  bool get loadBetCodeLoading => _loadBetCodeLoading;

  bool? get betSlipConfigurationIsLoad => _betSlipConfigurationIsLoad;

  TextEditingController get betCodeEditingController =>
      _betCodeEditingController;

  int get stakeAmount => _stakeAmount;

  int get stakeAmountForMultiple => _stakeAmountForMultiple;

  double get totalOdd => _totalOdd;

  double get stakePossibleWinnings => _stakePossibleWinnings;

  double get stakePossibleWinningsForMultiple =>
      _stakePossibleWinningsForMultiple;

  List<int> get amount => _amount;

  List<double> get possibleWinnings => _possibleWinnings;

  List<Map> get errorsMsg => _errorsMsg;

  int get index => _index;
  final BetSlipUC _getBetSlipUseCase = BetSlipUC(
    BetSlipRepositoryImpl(
      remoteDataSource: RemoteDataSourceImpl(
          // client: http.Client(),
          ),
    ),
  );

  ///on tab click get current page index[index]
  void onTab(int index) {
    _index = index;
    isMultiple = index == 1;
    _checkErrors();

    //notifyListeners();
  }

  void changeBetCodeState() {
    notifyListeners();
  }

  //get data
  Future<bool> executeGetBetSlip(String hub, int amount) async {
    bool done = false;
    _loadBetCodeLoading = true;

    notifyListeners();
    await _getBetSlipUseCase.executeGetBetSlip({
      "token": "string",
      "memberId": 0,
      "data": {
        "id": _betCodeEditingController.text,
        "name": "string",
        "currencyId": _currency == "LD" ? 1 : 2,
        "amount": 0,
        "betCode": _betCodeEditingController.text,
      }
    }).then(
      (useCaseResult) {
        useCaseResult.fold(
          (failure) {
            debugPrint(failure.message);
            _isBetSlipLoaded = true;
            _loadBetCodeLoading = false;
            notifyListeners();
          },
          (result) => setBetSlip(hub, result, amount),
        );
        done = true;
      },
    );
    return done;
  }

// create bet code
  Future<bool> executeCreateBetCode() async {
    bool done = false;
    _isCreateBetCodeLoading = true;
    notifyListeners();
    List<Object> requestData = [];
    for (int i = 0; i < _betItems.length; i++) {
      requestData.add({
        //"id": _betItems[i].id,
        "name": "",
        "feedId": _betItems[i].feed!.feedId,
        "sportId": _betItems[i].sport!.sportId,
        "eventId": _betItems[i].eventId,
        "oddId": _betItems[i].oddId,
        "oddFieldNumber": _betItems[i].oddFieldNumber,
        "betLineNo": _betItems[i].eventBetLineNo,
        "amount": _amount[i]
      });
    }

    await _getBetSlipUseCase.executeCreateBetCode({
      "token": "",
      "memberId": 0,
      "data": {
        "id": 0,
        "name": "string",
        "currencyId": _currency == "LD" ? 1 : 2,
        "amount": 0,
        "betLines": requestData
      }
    }).then(
      (useCaseResult) {
        useCaseResult.fold(
          (failure) {
            debugPrint(failure.message);
            _isCreateBetCodeLoading = false;
            notifyListeners();
          },
          (result) => setCreateBetCode(result),
        );
        done = true;
      },
    );
    return done;
  }

// get sports icons
  Future<bool> executeGetSportIcons() async {
    bool done = false;

    await _getBetSlipUseCase.executeGetSportTypeIcon().then(
      (useCaseResult) {
        useCaseResult.fold(
          (failure) {
            debugPrint(failure.message);
          },
          (result) => setSportIcons(result),
        );
        done = true;
      },
    );
    return done;
  }

// place bet multiple
  Future<bool> executePlaceBetMultiple(
      {required String token, required String memberId}) async {
    bool done = false;
    _isPlaceBetLoading = true;
    _placeBet = null;
    notifyListeners();
    List<Object> requestData = [];
    for (var element in _betItems) {
      requestData.add({
        "id": "0",
        "name": "",
        "feedId": element.feed!.feedId,
        "sportId": element.sport!.sportId,
        "eventId": element.eventId,
        "oddId": element.oddId,
        "oddFieldNumber": element.oddFieldNumber,
        "betLineNo": element.eventBetLineNo,
        "betTypeId": element.betType!.betTypeId,
        //"betCode": "0",
        "oddSpecialField": element.oddSpecialField.toString(),
        "activeOddFieldId": element.activeOddFieldId
      });
    }
    debugPrint(requestData.toString());
    await _getBetSlipUseCase.executePlaceBetMultiple({
      "token": token,
      "memberId": memberId,
       "amount": stakeAmountForMultiple,
        "currencyId": _currency == "LD" ? 1 : 2,
        //"betCode": 0,
        "betLines": requestData
    }).then(
      (useCaseResult) {
        useCaseResult.fold(
          (failure) {
            debugPrint(failure.message);
            _isPlaceBetLoading = false;
            notifyListeners();
          },
          (result) => setPlaceBet(result, false),
        );
        done = true;
      },
    );

    return done;
  }

// place bet single
  Future<bool> executePlaceBetSingle(
      {required String token, required String memberId}) async {
    bool done = false;
    _isPlaceBetLoading = true;
    _placeBet = null;
    notifyListeners();
    List<Object> requestData = [];
    for (int i = 0; i < _betItems.length; i++) {
      requestData.add({
        //"id": "0",
        "name": "",
        "feedId": _betItems[i].feed!.feedId,
        "sportId": _betItems[i].sport!.sportId,
        "eventId": _betItems[i].eventId,
        "oddId": _betItems[i].oddId,
        "oddFieldNumber": _betItems[i].oddFieldNumber,
        "betLineNo": _betItems[i].eventBetLineNo,
        "betTypeId": _betItems[i].betType!.betTypeId,
        "amount": amount[i],
        //"betCode": "0",
        "oddSpecialField": _betItems[i].oddSpecialField.toString(),
        "activeOddFieldId": _betItems[i].activeOddFieldId
      });
    }
    debugPrint(requestData.toString());
    setPlaceBetErrorMsgForSingle();

    await _getBetSlipUseCase.executePlaceBetSingle({
      "token": token,
      "memberId": memberId,
 
       "currencyId": _currency == "LD" ? 1 : 2,
        // "betCode": 0,
        "betLines": requestData
    }).then(
      (useCaseResult) {
        useCaseResult.fold(
          (failure) {
            debugPrint(failure.message);
            _isPlaceBetLoading = false;

            notifyListeners();
          },
          (result) => setPlaceBet(result, true),
        );
        done = true;
      },
    );

    return done;
  }

  void setPlaceBetErrorMsgForSingle() {
    hasErrorOnPlaceBetSingle = false;
    for (var _ in _betItems) {
      _placeBetSingleErrorsMsg.add("");
    }
  }

  /// set bet slip data from api response [betSlip]
  void setBetSlip(String hub, BetSlipEntity betSlip, int amount) {
    _betSlip = betSlip;
    if (_betSlip!.success!) {
      getLiveData(hub, _betSlip!.data!, amount);
    } else {
      _isBetSlipLoaded = true;
      _loadBetCodeLoading = false;
      notifyListeners();
    }
  }

  /// set bet code data from api response [betCode]
  void setCreateBetCode(BetCodeEntity betCode) {
    _isCreateBetCodeLoading = false;

    _betCodeEntity = betCode;
    notifyListeners();
  }

  /// set bet code data from api response [sportIcons]
  void setSportIcons(BetSlipSportIconsEntity sportIcons) {
    _betSlipSportIconsEntity = sportIcons;
    notifyListeners();
  }

  /// set place bet  data from api response [placeBet]
  void setPlaceBet(PlaceBetEntity placeBet, bool isSingel) {
    _isPlaceBetLoading = false;
    _placeBet = placeBet;
    if (_placeBet!.data != null) {
      if (isSingel) {
        List<SinglesBetFormDetail> singlesBetFormDetails =
            _placeBet!.data!.singlesBetFormDetails!;

        if (_placeBet!.data!.singlesBetFormDetails != null) {
          for (int i = 0; i < singlesBetFormDetails.length; i++) {
            if (singlesBetFormDetails[i].betSucceed!) {
            } else {
              hasErrorOnPlaceBetSingle = true;
              _placeBetSingleErrorsMsg[i] = singlesBetFormDetails[i]
                  .messages!
                  .first["message"]
                  .toString();
            }
          }
          if (_betItems.length > 1) {
            for (int i = 0; i < _betItems.length; i++) {
              if (_placeBetSingleErrorsMsg[i].isEmpty) {
                onSingleRemoveBet(index: i, odd: _betItems[i].oddValue!);
              }
            }

            notifyListeners();
          } else {
            notifyListeners();
          }
        }
      } else {}
    } else {
      notifyListeners();
    }
  }

  var hubConnection;
  getLiveData(String hub, List<Data> data, int amount) async {
    List<Object> requestData = [];
    for (var element in data) {
      requestData.add({
        "feed": {"feedId": element.feedId},
        "sport": {"sportId": element.sportId},
        "eventId": element.eventId,
        "betType": {"betTypeId": element.betTypeId},
        "oddSpecialField": element.oddSpecialField,
        "activeOddFieldId": element.activeOddFieldId
      });
    }
    if (hubConnection == null) {
      hubConnection =
          HubConnectionBuilder().withUrl(hub).withAutomaticReconnect().build();

      await hubConnection.start()!.then((value) {
        debugPrint(
          'Streamit:::::: Started ${hubConnection.state.toString()}',
        );
      }).catchError((onError) {
        debugPrint(
          'Streamit:::::: Start error ${onError.toString()}',
        );
      });
    }
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
    });

    hubConnection.on('OnEventOddFieldData', (arguments) {
      debugPrint('On EventOddFieldData');
      // when user enter new code clear old data and re init
      _betItems.clear();
      String response = decode(arguments!.first.toString());

      Map data = jsonDecode(response);
      log("betSlipRes" + data.toString());

      data["data"].forEach((key, value) {
        _betItems.add(BetSlipItem.fromMap(value));
      });
      initAmount(list: _betItems, betSlipAmount: amount);
      _errorsMsg.clear();
      _placeBetSingleErrorsMsg.clear();
      for (var _ in _betItems) {
        _errorsMsg.add({
          "maxPossibleWinning": "",
          "maxPossibleWinningForMultiple": "",
          "combinedError": "",
          "oddChange": ""
        });
        _placeBetSingleErrorsMsg.add("");
      }

      initPossibleWinnings(betSlipAmount: amount);

      _isBetSlipLoaded = true;
      _loadBetCodeLoading = false;
      _betCodeEditingController.clear();
      _changeStakeAmount();
      _checkErrors();
      invokeNewData();
    });
    hubConnection.onreconnecting(({error}) {
      debugPrint(
        'onReconnecting ${error.toString()}',
      );
    });
    hubConnection.onclose(({error}) {
      debugPrint('On EventOddFieldData.onClose with Error $error');
    });
    hubConnection.onreconnected(({connectionId}) {
      debugPrint('On EventOddFieldData.onReconnected $connectionId');
    });
    hubConnection.onreconnecting(({error}) {
      debugPrint('On EventOddFieldData.onReconnecting with Error $error');
    });
    await hubConnection.invoke(
      'GetEventOddFieldData',
      args: [requestData],
    ).then((value) {
      debugPrint('EventOddFieldData Invoke.then' + value.toString());
    }).catchError((onError) {
      debugPrint('EventOddFieldData error' + onError.toString());
    });
  }

  void invokeNewData() async {
    int amount = isMultiple ? _stakeAmountForMultiple : _stakeAmount;
    if (hubConnection == null) {
      hubConnection = HubConnectionBuilder()
          .withAutomaticReconnect()
          .withUrl(AppConfig.feedSr)
          .build();

      await hubConnection.start()!.then((value) {
        debugPrint(
          'Streamit:::::: Started ${hubConnection.state.toString()}',
        );
      }).catchError((onError) {
        debugPrint(
          'Streamit:::::: Start error ${onError.toString()}',
        );
      });
    }
    hubConnection.on('OnEventOddFieldsChange', (arguments) {
      debugPrint('On EventOddFieldsChange');

      String response = decode(arguments!.first.toString());

      Map data = jsonDecode(response);
      //  log('On EventOddFieldsChange'+data.toString());
      for (var element in _betItems) {
        data["data"]["eventOddFields"].forEach((key, value) {
          Map<String, dynamic> events = value;
          events.forEach((key, value) {
            // declare object
            if (BetSlipItem.fromMap(value).activeOddFieldId ==
                element.activeOddFieldId) {
              // element=BetSlipItem.fromMap(value);
              // Take index of element
              // Remove at index
              // Add at index

              _betItems
                  .elementAt(_betItems
                      .indexWhere((oldElement) => oldElement == element))
                  .setOddValue(BetSlipItem.fromMap(value).oddValue!);
              _betItems
                  .elementAt(_betItems
                      .indexWhere((oldElement) => oldElement == element))
                  .enableBet = BetSlipItem.fromMap(value).enableBet!;
              _betItems
                  .elementAt(_betItems
                      .indexWhere((oldElement) => oldElement == element))
                  .eventEnableBet = BetSlipItem.fromMap(value).eventEnableBet!;
              _betItems
                  .elementAt(_betItems
                      .indexWhere((oldElement) => oldElement == element))
                  .oddEnableBet = BetSlipItem.fromMap(value).oddEnableBet!;
              _errorsMsg[_betItems
                      .indexWhere((oldElement) => oldElement == element)]
                  ["oddChange"] = _betItems[_betItems
                          .indexWhere((oldElement) => oldElement == element)]
                      .betType!
                      .betTypeName! +
                  " Values Changed";

              // notifyListeners();
              //  initAmount(list: _betItems, betSlipAmount: amount);
              initPossibleWinnings(betSlipAmount: amount);

              // _changeStakeAmount();
              // _checkErrors();
            }
          });

          // _betItems.add(BetSlipItem.fromMap(value));
        });
      }
    });
    for (var element in _betItems) {
      hubConnection.invoke(
        "JoinGroup",
        args: [
          "F${element.feed!.feedId!}S${element.sport!.sportId!}E${element.eventId}"
        ],
      ).then((value) {
        debugPrint(
            'JoinGroup invoked with "F${element.feed!.feedId!}S${element.sport!.sportId!}E${element.eventId}"}');
      }).catchError((onError) {
        debugPrint(
            'JoinGroup error with "F${element.feed!.feedId!}S${element.sport!.sportId!}E${element.eventId}"');
      });
    }
  }

// on Stake Tap Change value
  void setStakeAmount(int amount) {
    _stakeAmount = amount;

    _hideStakeAmount = false;
    // change value in all item
    _amount = _amount.map((e) => amount).toList();
    _possibleWinnings = _betItems.map((e) => (amount * e.oddValue!)).toList();

    setStakePossibleWinnings(amount);
  }

// on Multiple Tap Change to default value
  void setStakeAmountFroMultiple(int amount) {
    _stakeAmountForMultiple = amount;
    _hideStakeAmount = false;

    setStakePossibleWinnings(amount);
  }

  void setStakePossibleWinnings(int amount) {
    double _totalPossibleWinnings = 0.0;
    double _totalOdds = 1.0;
    for (var element in _possibleWinnings) {
      _totalPossibleWinnings = _totalPossibleWinnings + element;
    }
    for (var element in _betItems) {
      _totalOdds = _totalOdds * element.oddValue!;
    }
    _stakePossibleWinnings = _totalPossibleWinnings;
    _totalOdd = _totalOdds;
    _stakePossibleWinningsForMultiple = _totalOdd * amount;

    checkMaxPossibleWinning();
    checkMaxPossibleWinningForMultiple();

    _showData = true;

    notifyListeners();
  }

  void initStakePossibleWinnings(int amount) {
    double _totalPossibleWinnings = 0.0;
    double _totalOdds = 1.0;
    for (var element in _possibleWinnings) {
      _totalPossibleWinnings = _totalPossibleWinnings + element;
    }
    for (var element in _betItems) {
      _totalOdds = _totalOdds * element.oddValue!;
    }
    _stakePossibleWinnings = _totalPossibleWinnings;
    _totalOdd = _totalOdds;
    _stakePossibleWinningsForMultiple = _totalOdd * _stakeAmountForMultiple;

    _showData = true;

    notifyListeners();
  }

// change amount on tap on current bet index (plus or min)
  void setAmount(
      {required int amount, required int index, required double odd}) {
    _amount[index] = amount;
    _hideStakeAmount = true;

    setPossibleWinnings(
        possibleWinnings: _getPossibleWinnings((amount * odd)),
        index: index,
        amount: amount);
  }

  double _getPossibleWinnings(double number) {
    if (currency == "LD") {
      if (number % 5 == 0) {
        // no need to round off
        return number;
      } else {
        number = number - number % 5;
        return number;
      }
    } else {
      return number;
    }
  }

  /// change currency from drop down [currency]
  void setCurrency(String currency) {
    _currency = currency;
    notifyListeners();
  }

// change possible winnings tap on current bet index (plus or min)
  void setPossibleWinnings(
      {required double possibleWinnings,
      required int index,
      required int amount}) {
    _possibleWinnings[index] = possibleWinnings;

    setStakePossibleWinnings(amount);
  }

  void initAmount(
      {required List<BetSlipItem> list, required int betSlipAmount}) {
    _amount = list.map((e) => betSlipAmount).toList();
    if (_betItems.isEmpty) {
      _stakeAmount = amount[0];
      _stakeAmountForMultiple = amount[0];
    } else {
      _changeStakeAmount();
    }
  }

  void initPossibleWinnings({required int betSlipAmount}) {
    _possibleWinnings.clear();
    _possibleWinnings = _betItems
        .map((e) => (_getPossibleWinnings(e.oddValue! * betSlipAmount)))
        .toList();

    initStakePossibleWinnings(betSlipAmount);
  }

// on plus icon tab change amount from amount addition value from api
  onPlusTab({required double number, required int index, required double odd}) {
    setAmount(
        index: index, amount: (_amount[index] + number).toInt(), odd: odd);
  }

// on plus icon tab change amount from amount min value from api
  onMinTab({required double number, required int index, required double odd}) {
    if (_amount[index] > 0) {
      setAmount(
          index: index, amount: (_amount[index] - number).toInt(), odd: odd);
    }
  }

  /// on tab on  remove icon at current index delete from list [index]
  void onRemoveIconTab({required int index, required double odd}) {
    _stakePossibleWinnings = _stakePossibleWinnings - (_amount[index] * odd);
    _stakePossibleWinningsForMultiple =
        _stakePossibleWinningsForMultiple - (_stakeAmountForMultiple * odd);
    _totalOdd = _totalOdd / odd;
    _betItems.removeAt(index);
    // _betSlip!.data!.removeAt(index);

//    _errorsMsg.removeAt(index);
    _checkErrors();
    _placeBetSingleErrorsMsg.removeAt(index);

    _possibleWinnings.removeAt(index);
    _amount.removeAt(index);
    _changeStakeAmount();
    invokeNewData();

    notifyListeners();
  }

  /// on single at current index delete from list [index]
  void onSingleRemoveBet({required int index, required double odd}) {
    _stakePossibleWinnings = _stakePossibleWinnings - (_amount[index] * odd);
    _stakePossibleWinningsForMultiple =
        _stakePossibleWinningsForMultiple - (_stakeAmountForMultiple * odd);
    _totalOdd = _totalOdd / odd;
    _betItems.removeAt(index);
    // _betSlip!.data!.removeAt(index);

    _checkErrors();
    _placeBetSingleErrorsMsg.removeAt(index);

    _possibleWinnings.removeAt(index);
    _amount.removeAt(index);
    invokeNewData();
    _changeStakeAmount();
  }

// delete list
  void onClearAllTab() {
    _betItems.clear();
    _betSlip = null;
    _showData = false;
    eventIdList.clear();
    notifyListeners();
  }

  void setBetSlipConfigurationEntity(
      BetSlipConfigurationEntity betSlipConfigurationEntity) {
    _betSlipConfigurationEntity = betSlipConfigurationEntity;
  }

  void checkMaxPossibleWinning() {
    for (int i = 0; i < _possibleWinnings.length; i++) {
      if (_possibleWinnings[i] >=
              _betSlipConfigurationEntity!
                  .data!.betSlipConstants!.maxPossibleWinning! &&
          _currency == "LD") {
        _errorsMsg[i]["maxPossibleWinning"] = "Maximum " +
            _betSlipConfigurationEntity!
                .data!.betSlipConstants!.maxPossibleWinning!
                .toString() +
            " PossibleWinning allowed";
      } else if (_possibleWinnings[i] >=
              _betSlipConfigurationEntity!
                  .data!.betSlipConstants!.maxPossibleWinningUsd! &&
          _currency != "LD") {
        _errorsMsg[i]["maxPossibleWinning"] = "Maximum " +
            _betSlipConfigurationEntity!
                .data!.betSlipConstants!.maxPossibleWinningUsd!
                .toString() +
            " PossibleWinning allowed";
      } else {
        _errorsMsg[i]["maxPossibleWinning"] = "";
      }
    }
  }

  void checkMaxPossibleWinningForMultiple() {
    for (int i = 0; i < _possibleWinnings.length; i++) {
      if (_stakePossibleWinningsForMultiple >=
              _betSlipConfigurationEntity!
                  .data!.betSlipConstants!.maxPossibleWinning! &&
          _currency == "LD") {
        _errorsMsg[i]["maxPossibleWinningForMultiple"] = "Maximum " +
            _betSlipConfigurationEntity!
                .data!.betSlipConstants!.maxPossibleWinning!
                .toString() +
            " PossibleWinning allowed";
      } else if (_stakePossibleWinningsForMultiple >=
              _betSlipConfigurationEntity!
                  .data!.betSlipConstants!.maxPossibleWinningUsd! &&
          _currency != "LD") {
        _errorsMsg[i]["maxPossibleWinningForMultiple"] = "Maximum " +
            _betSlipConfigurationEntity!
                .data!.betSlipConstants!.maxPossibleWinningUsd!
                .toString() +
            " PossibleWinning allowed";
      } else {
        _errorsMsg[i]["maxPossibleWinningForMultiple"] = "";
      }
    }
  }

  bool isButtonDisabled(bool isMultiple) {
    bool isButtonDisabled = false;
    for (var element in _errorsMsg) {
      if (element["maxPossibleWinning"].toString().isNotEmpty && !isMultiple) {
        isButtonDisabled = true;
      }
      if ((element["maxPossibleWinningForMultiple"].toString().isNotEmpty ||
              element["combinedError"].toString().isNotEmpty) &&
          isMultiple) {
        isButtonDisabled = true;
      }
    }
    return isButtonDisabled;
  }

  List<String> errorOutput(bool isMultiple) {
    List<String> errors = [];
    for (var element in _errorsMsg) {
      if (element["maxPossibleWinningForMultiple"].toString().isNotEmpty &&
          isMultiple) {
        if (!errors
            .contains(element["maxPossibleWinningForMultiple"].toString())) {
          errors.add(element["maxPossibleWinningForMultiple"].toString());
        }
      }
      if (element["maxPossibleWinning"].toString().isNotEmpty && !isMultiple) {
        if (!errors.contains(element["maxPossibleWinning"].toString())) {
          errors.add(element["maxPossibleWinning"].toString());
        }
      }
      if (element["combinedError"].toString().isNotEmpty && isMultiple) {
        if (!errors.contains(Strings.betCannotCombined)) {
          errors.add(Strings.betCannotCombined);
        }
      }
      if (element["oddChange"].toString().isNotEmpty) {
        if (!errors.contains(element["oddChange"].toString())) {
          errors.remove(Strings.someBetsValuesChanged);
          errors.add(Strings.someBetsValuesChanged);
        }
      }
    }
    return errors;
  }

  void setBetSlipConfigurationIsLoad(bool value) {
    _betSlipConfigurationIsLoad = value;
    notifyListeners();
  }

  String decode(String data) {
    final str = base64.decode(data);
    final deflated = Inflate(str);
    final decodedString = String.fromCharCodes(deflated.getBytes());
    return decodedString;
  }

// void _checkErrors() {
//     bool hasCombinedError = false;
//     bool hasEventIdError = false;
//     String typeName = "";
//
//     for (int j = 0; j < _betItems.length; j++) {
//       if (_tempBetItems.isNotEmpty) {
//         // check if list has odds changed
//         if (_betItems[j].oddValue != _tempBetItems[j].oddValue) {
//           _errorsMsg[j]["oddChange"] =
//               _betItems[j].betType!.betTypeName! + " Values Changed";
//         }
//       }
//       if (eventIdList.contains(_betItems[j].eventId)) {
//         hasEventIdError = true;
//       } else {
//         eventIdList.add(_betItems[j].eventId!);
//       }
//
//       for (int i = 0;
//           i < _betSlipConfigurationEntity!.data!.betsRestrictions!.length;
//           i++) {
//         for (var element in _betItems) {
//           if (element.betType!.betTypeId ==
//               _betSlipConfigurationEntity!
//                   .data!.betsRestrictions![i].betTypeId2) {
//             hasCombinedError = true;
//             typeName = element.betType!.betTypeName!;
//           } else {}
//         }
//
//         if ((_betSlipConfigurationEntity!.data!.betsRestrictions![i].feedId ==
//                 _betItems[j].feed!.feedId &&
//             _betSlipConfigurationEntity!.data!.betsRestrictions![i].sportId ==
//                 _betItems[j].sport!.sportId &&
//             _betSlipConfigurationEntity!
//                     .data!.betsRestrictions![i].betTypeId1 ==
//                 _betItems[j].betType!.betTypeId &&
//             hasCombinedError &&
//             hasEventIdError )) {
//               if(!_betSlipConfigurationEntity!
//                     .data!.betsRestrictions![i].isAllowed!){
//           _errorsMsg[j]["combinedError"] = _betItems[j].betType!.betTypeName! +
//               " Cannot Combine with " +
//               typeName;
//           _errorsMsg[i]["combinedError"] = _betItems[i].betType!.betTypeName! +
//               " Cannot Combine with " +
//               _betItems[j].betType!.betTypeName!;
//               }
//
//         } else {
//
//         }
//       }
//     }
//     _tempBetItems = _betItems;
//     notifyListeners();
//   }

  void _checkErrors() {
    bool hasEventIdError = false;

    _errorsMsg.clear();
    AppConfig.placeBetVirtual = false;

    for (var _ in _betItems) {
      _errorsMsg.add({
        "maxPossibleWinning": "",
        "maxPossibleWinningForMultiple": "",
        "combinedError": "",
        "oddChange": ""
      });
    }
    for (int j = 0; j < _betItems.length; j++) {
      if (_betItems[j].season != null && _betItems[j].season!.isNotEmpty) {
        AppConfig.placeBetVirtual = true;
      }

      if (_betItems.length > 1) {
        for (int x = j + 1; x < _betItems.length; x++) {
          if (x < _betItems.length) {
            if (_betItems[j].eventId == _betItems[x].eventId) {
              hasEventIdError = true;
            }
            if (hasEventIdError) {
              _errorsMsg[j]["combinedError"] =
                  _betItems[j].betType!.betTypeName! +
                      " Cannot Combine with " +
                      _betItems[x].betType!.betTypeName!;
              _errorsMsg[x]["combinedError"] =
                  _betItems[x].betType!.betTypeName! +
                      " Cannot Combine with " +
                      _betItems[j].betType!.betTypeName!;
            }

            if ((_betItems[x].season != null &&
                    _betItems[x].season!.isNotEmpty) &&
                (_betItems[j].season == null) &&
                isMultiple) {
              _errorsMsg[j]["combinedError"] =
                  _betItems[j].betType!.betTypeName! +
                      " Cannot Combine with " +
                      "virtual";
              _errorsMsg[x]["combinedError"] =
                  _betItems[x].betType!.betTypeName! +
                      " Cannot Combine with " +
                      "virtual";
              AppConfig.placeBetVirtual = true;
            } else if ((_betItems[j].season != null &&
                    _betItems[j].season!.isNotEmpty) &&
                (_betItems[x].season == null) &&
                isMultiple) {
              _errorsMsg[j]["combinedError"] =
                  _betItems[j].betType!.betTypeName! +
                      " Cannot Combine with " +
                      "virtual";
              _errorsMsg[x]["combinedError"] =
                  _betItems[x].betType!.betTypeName! +
                      " Cannot Combine with " +
                      "virtual";
              AppConfig.placeBetVirtual = true;
            }
            for (int i = 0;
                i < _betSlipConfigurationEntity!.data!.betsRestrictions!.length;
                i++) {
              if (_betSlipConfigurationEntity!
                          .data!.betsRestrictions![i].feedId ==
                      _betItems[j].feed!.feedId &&
                  _betSlipConfigurationEntity!
                          .data!.betsRestrictions![i].sportId ==
                      _betItems[j].sport!.sportId &&
                  hasEventIdError &&
                  ((_betSlipConfigurationEntity!
                                  .data!.betsRestrictions![i].betTypeId1 ==
                              _betItems[j].betType!.betTypeId &&
                          _betSlipConfigurationEntity!
                                  .data!.betsRestrictions![i].betTypeId2 ==
                              _betItems[x].betType!.betTypeId) ||
                      (_betSlipConfigurationEntity!
                                  .data!.betsRestrictions![i].betTypeId1 ==
                              _betItems[x].betType!.betTypeId &&
                          _betSlipConfigurationEntity!
                                  .data!.betsRestrictions![i].betTypeId2 ==
                              _betItems[j].betType!.betTypeId))) {
                if (_betSlipConfigurationEntity!
                    .data!.betsRestrictions![i].isAllowed!) {
                  _errorsMsg[j]["combinedError"] = "";
                  _errorsMsg[x]["combinedError"] = "";
                }
              }
            }
          }
        }
      } else {
        if (_betItems[0].season != null && _betItems[j].season!.isNotEmpty) {
          AppConfig.placeBetVirtual = true;
        }
      }
    }
    _tempBetItems = _betItems;
    notifyListeners();
  }

  void _changeStakeAmount() {
    for (var element in _betSlipConfigurationEntity!.data!.minimumBetsAmount!) {
      if (element.noOfBetLines == _betItems.length) {
        if (_currency == "LD") {
          _stakeAmount = element.amount!.toInt();
          _stakeAmountForMultiple = element.amount!.toInt();
        } else {
          _stakeAmount = element.usdAmount!.toInt();
          _stakeAmountForMultiple = element.usdAmount!.toInt();
        }
      }
    }
  }

  /// check if bet  is exist in bet slip list by id [id]
  bool isBetExist({required String id}) {
    bool _isBetExist = false;
    for (var element in _betItems) {
      String _betId = element.feed!.feedId.toString() +
          "_" +
          element.sport!.sportId.toString() +
          "_" +
          element.activeOddFieldId.toString();
      if (id == _betId) {
        _isBetExist = true;
      }
    }
    return _isBetExist;
  }

  /// remove bet from list by id (remove from another page) [id]
  void removeBet({required String id}) {
    double odd = 0.0;
    for (int i = 0; i < _betItems.length; i++) {
      String _betId = _betItems[i].feed!.feedId.toString() +
          "_" +
          _betItems[i].sport!.sportId.toString() +
          "_" +
          _betItems[i].activeOddFieldId.toString();
      if (_betId == id) {
        odd = _betItems[i].oddValue!;
        _betItems.removeAt(i);
        //_betSlip!.data!.removeAt(i);
        _checkErrors();
        _placeBetSingleErrorsMsg.removeAt(i);
        _possibleWinnings.removeAt(i);

        if (_amount.isEmpty) {
          _stakePossibleWinnings = 0;
        } else {
          _stakePossibleWinnings = _stakePossibleWinnings - (_amount[i] * odd);
        }
        _amount.removeAt(i);

        _stakePossibleWinningsForMultiple =
            _stakePossibleWinningsForMultiple - (_stakeAmountForMultiple * odd);
        _totalOdd = _totalOdd / odd;

        _changeStakeAmount();
        invokeNewData();

        notifyListeners();
      }
    }
  }

  void removeDuplicate({required String id}) {
    double odd = 0.0;
    for (int i = 0; i < _betItems.length; i++) {
      /// (item.betType!.betTypeId.toString() +"_"+ item.oddSpecialField.toString())
      String _betId = (betItems[i].betType!.betTypeId.toString() +
          "_" +
          betItems[i].oddSpecialField.toString() +
          "_" +
          betItems[i].eventId.toString());
      if (_betId == id) {
        odd = _betItems[i].oddValue!;
        _betItems.removeAt(i);
        //_betSlip!.data!.removeAt(i);
        _checkErrors();
        _placeBetSingleErrorsMsg.removeAt(i);
        _possibleWinnings.removeAt(i);

        _stakePossibleWinnings = _stakePossibleWinnings - (_amount[i] * odd);
        _amount.removeAt(i);
        _stakePossibleWinningsForMultiple =
            _stakePossibleWinningsForMultiple - (_stakeAmountForMultiple * odd);
        _totalOdd = _totalOdd / odd;

        _changeStakeAmount();

        notifyListeners();
      }
    }
  }

  /// add bet item to list [betSlipItem]
  void addBet({required BetSlipItem betSlipItem}) {
    int amount = _currency == "LD"
        ? _betSlipConfigurationEntity!.data!.betSlipConstants!.betSlipAmountLd!
        : _betSlipConfigurationEntity!
            .data!.betSlipConstants!.betSlipAmountUsd!;

    for (final item in _betItems) {
      if ((item.betType!.betTypeId.toString() +
                  "_" +
                  item.oddSpecialField.toString()) ==
              (betSlipItem.betType!.betTypeId.toString() +
                  "_" +
                  betSlipItem.oddSpecialField.toString()) &&
          (item.eventBetLineNo == betSlipItem.eventBetLineNo)) {
        if (_betItems.length == 1) {
          onClearAllTab();
          break;
        } else {
          removeDuplicate(
              id: (item.betType!.betTypeId.toString() +
                  "_" +
                  item.oddSpecialField.toString() +
                  "_" +
                  item.eventId.toString()));
          break;
        }
      }
    }

    //
    _betItems.add(betSlipItem);
    _errorsMsg.clear();
    _placeBetSingleErrorsMsg.clear();
    for (var _ in _betItems) {
      _errorsMsg.add({
        "maxPossibleWinning": "",
        "maxPossibleWinningForMultiple": "",
        "combinedError": "",
        "oddChange": ""
      });
      _placeBetSingleErrorsMsg.add("");
    }
    initAmount(list: _betItems, betSlipAmount: amount);
    initPossibleWinnings(betSlipAmount: amount);

    _changeStakeAmount();
    _checkErrors();
    _isBetSlipLoaded = true;
    invokeNewData();
    notifyListeners();
  }
}

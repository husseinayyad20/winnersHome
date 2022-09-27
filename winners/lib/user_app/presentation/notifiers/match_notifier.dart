import 'dart:convert';
import 'dart:developer';
import 'package:archive/archive.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/sport_event.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';
import 'package:signalr_netcore/hub_connection.dart';

import '../../data/models/get_top_bet_sport_event_response_model/event_score.dart';

class MatchNotifier extends ChangeNotifier {
  late HubConnection hub;
  HomeNotifier? homeNotifier;
  late int eventId;
  late int feedId;
  late int sportId;
  late int betTypeId;
  late String specialBetTypeId;
  EventScore? eventScore;
  late bool isLastMin;
  late SportEvent sportEvent;
  late SportEvent homeSportEvent;
  String selectedGroup = '';
  String errorMessage = '';
  bool didUpdate = false;

  bool _loading = true;
  bool get loading => _loading;
  void setLoading(bool newValue) {
    _loading = newValue;
    notifyListeners();
  }

  void setSelectedGroup(String newGroup) {
    selectedGroup = newGroup;
    notifyListeners();
  }

  ///widget.matchNotifier.setSelectedGroup(e);
  ///widget.matchNotifier.getGroups();

  /// NEW RESPONSE DATA
  Map<String, dynamic> eventOddGroups = {};
  Map<String, dynamic> eventOdds = {};
  Map<String, dynamic> homeEventOdds = {};
  Map<String, dynamic> mEventOddFields = {};
  Map<String, dynamic> homeEventOddFields = {};
  List<dynamic> eventOddGroupIds = [];
  // Map<String, dynamic> sportEvent = {};
  String eventSpecialId = "Main";

  String decode(String data) {
    final str = base64.decode(data);
    final deflated = Inflate(str);
    final decodedString = String.fromCharCodes(deflated.getBytes());
    return decodedString;
  }

  @override
  MatchNotifier(hubco, SportEvent sEvent, eventOddsMap, eventID, feedID,
      sportID, betTypeID, isLastMIN, odds,
      {specialBetTypeId = "-1", this.homeNotifier}) {
    hub = hubco;
    sportEvent = sEvent;
    homeSportEvent = sEvent;
    eventId = eventID;
    feedId = feedID;
    sportId = sportID;
    betTypeId = betTypeID;
    homeEventOdds = eventOddsMap ?? {};
    eventOdds = odds;
    isLastMin = isLastMIN;
    eventSpecialId =
        '${feedId}_${sportId}_${eventId}_${betTypeId}_$specialBetTypeId';
    eventOdds = eventOddsMap ?? {};
    eventSpecialId = '${feedId}_${sportId}_${eventId}_${betTypeId}_-1';
    mEventOddFields = eventOddsMap ?? {};
    homeEventOddFields = eventOddsMap ?? {};

    eventScore = sEvent.eventScore;
    initHub();
  }
  List<String> uniqueDrillDowns = [];
  List<String>? get getUniqueDrillDowns {
    var originalList = eventOddGroups.values.toList();
    originalList.sort(((a, b) {
      return a['betTypeDrillDownDisplayOrder']
          .compareTo(b['betTypeDrillDownDisplayOrder']);
    }));

    List<String> temp = [];
    for (var element in originalList) {
      if (!temp.contains(element['betTypeDrillDownGroupName'])) {
        temp.add(element['betTypeDrillDownGroupName'] ?? '');
      }
    }

    return temp;
  }

  List<Map<String, dynamic>> currentGroups = [];
  getGroups() {
    currentGroups.clear();
    for (var eventOddValue in eventOdds.values) {
      Map<String, dynamic> eMap = eventOddValue as Map<String, dynamic>;
      for (var element in eMap.entries) {
        if (element.value['betType']['betTypeDrillDownGroupName'] ==
            selectedGroup) {
          currentGroups.add(element.value);
        }
      }
      setLoading(false);
      notifyListeners();
    }
  }

  onAllBetTypes() {
    hub.on(
      'OnAllBetTypes',
      (arguments) {
        try {
          String decoded = decode(arguments!.first.toString());
          Map<String, dynamic> newData = json.decode(decoded);
          eventOddGroupIds =
              newData['data']['eventOddGroupIds'] as List<dynamic>;
          eventOdds = newData['data']['eventOdds'];
          eventOddGroups = newData['data']['eventOddGroups'];
          sportEvent = SportEvent.fromMap(newData['data']['sportEvent']);
          mEventOddFields = newData['data']['eventOddFields'];
          if (getUniqueDrillDowns?.isNotEmpty ?? false) {
            setSelectedGroup(getUniqueDrillDowns!.first);
          }
          errorMessage = '';
          setLoading(false);
          getGroups();
          notifyListeners();
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }

  // feedChangeStatus
  // 0 -> update
  // 1 -> add
  // 2 -> delete
  onEventOddGroupsChange() {
    hub.on(
      'OnEventOddGroupsChange',
      (arguments) {
        try {
          String decoded = decode(arguments!.first.toString());
          Map<String, dynamic> newData = json.decode(decoded);
          // TODO:- Modify old data with new data
          List<String> currentKeys = eventOddGroups.keys.toList();
          Map<String, dynamic> newEventOddGroups =
              newData['data']['eventOddGroups'] as Map<String, dynamic>;
          List<String> newKeys = newEventOddGroups.keys.toList();
          for (var key in newKeys) {
            if (currentKeys.contains(key)) {
              if (newEventOddGroups[key]['feedChangeStatus'] == 2) {
                eventOddGroups.remove(key);
              } else if (newEventOddGroups[key]['feedChangeStatus'] == 0) {
                eventOddGroups[key] = newEventOddGroups[key];
              } else if (newEventOddGroups[key]['feedChangeStatus'] == 1) {
                eventOddGroups.addEntries([
                  MapEntry(
                    key,
                    newEventOddGroups[key],
                  ),
                ]);
              }
            } else {
              //
              eventOddGroups
                  .addEntries([MapEntry(key, newEventOddGroups[key])]);
              // eventOddGroups.addAll(newEventOddGroups[key]);
            }
          }
          if (eventOddGroups.keys.isEmpty) {
            eventOdds = {};
            eventOddGroups = {};
            mEventOddFields = {};
          }
          getGroups();
          errorMessage = '';
          setLoading(false);
          // getGroups();
          notifyListeners();
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }

  // key
  // feedChangeStatus
  // 0 -> update
  // 1 -> add
  // 2 -> delete
  onEventOddsChange() {
    hub.on(
      'OnEventOddsChange',
      (arguments) {
        try {
          String decoded = decode(arguments!.first.toString());
          Map<String, dynamic> newData = json.decode(decoded);
          // TODO:- Modify old data with new data
          List<String> currentKeys = eventOdds.keys.toList();
          Map<String, dynamic> newEventOdds =
              newData['data']['eventOdds'] as Map<String, dynamic>;
          List<String> newKeys = newEventOdds.keys.toList();
          for (var key in newKeys) {
            if (currentKeys.contains(key)) {
              if (newEventOdds[key]['feedChangeStatus'] == 2) {
                eventOdds.remove(key);
              } else if (newEventOdds[key]['feedChangeStatus'] == 0) {
                eventOdds[key] = newEventOdds[key];
              } else if (newEventOdds[key]['feedChangeStatus'] == 1) {
                eventOdds.addEntries([
                  MapEntry(
                    key,
                    newEventOdds[key],
                  ),
                ]);
              }
            } else {
              eventOdds.addEntries([MapEntry(key, newEventOdds[key])]);
            }
          } // TODO:- Modify old data with new data
          // eventOdds = newData['data']['eventOdds'];
          errorMessage = '';
          setLoading(false);
          notifyListeners();
          getGroups();
        } catch (e) {
          debugPrint(e.toString());
        }
      },
    );
  }

  Future getAllBetTypes() async {
    onAllBetTypes();
    hub
        .invoke(
          'GetAllBetTypes',
          args: [
            {
              'Data': {
                'EventId': eventId,
                'Feed': {
                  'FeedId': feedId,
                },
                'Sport': {
                  'SportId': sportId,
                }
              },
            }
          ],
        )
        .catchError(
          (e) => debugPrint(
            'GetAllBetTypes ${e.toString()}',
          ),
        )
        .then(
          (value) {
            // setLoading(true);
            Future.delayed(const Duration(seconds: 5), () {
              errorMessage = 'Top bets not exist';
            });
            notifyListeners();
          },
        );
  }

  onEventScoreFieldsChange(List<Object>? arguments) {
    try {
      String response = decode(arguments!.first.toString());
      Map<String, dynamic> encodedResponse = json.decode(response);
      final sportScores = encodedResponse['data']['eventScores'] as List;
      if (sportScores.isEmpty) return;
      final eventScoreJson = sportScores.first;
      final score = EventScore.fromMap(eventScoreJson);
      if (sportEvent.eventId == score.eventId) {
        eventScore = score;
        if (mounted) {
          notifyListeners();
        }
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  // OnEventOddFieldsChange
  // feedChangeStatus
  // 0 -> update
  // 1 -> add
  // 2 -> delete
  onEventOddFieldsChange(List<Object>? arguments) {
    if (!mounted) {
      return;
    }
    try {
      if (homeNotifier != null) {
        eventSpecialId =
            '${feedId}_${sportId}_${eventId}_${homeNotifier?.selectedBetType?.betTypeId ?? '1'}_${homeNotifier?.selectedBetType?.defaultSpecialField ?? '-1'}';
      }
      String response = decode(arguments!.first.toString());
      Map<String, dynamic> encodedEventOddFields = json.decode(response);
      final data = encodedEventOddFields["data"];
      final Map<String, dynamic> eventOddFields = data["eventOddFields"];
      if (eventOddFields.containsKey(eventSpecialId) &&
          homeNotifier?.matchNotifier == null) {
        final Map<String, dynamic> newOddsMap =
            eventOddFields[eventSpecialId] ?? {};
        for (final map in newOddsMap.keys) {
          if (newOddsMap[map]['feedChangeStatus'] == 0) {
            homeEventOddFields[map] = newOddsMap[map];
          } else if (newOddsMap[map]['feedChangeStatus'] == 1) {
            eventOdds.addAll(newOddsMap);
            // mEventOddFields.addAll(newOddsMap);
            homeEventOddFields.addAll(newOddsMap);
          } else if (newOddsMap[map]['feedChangeStatus'] == 2) {
            eventOdds.remove(newOddsMap[map]);
          }
        }
      } else {
        if (homeNotifier?.matchNotifier != null) {
          List<String> keys = eventOddFields.keys.toList();
          var feedSportEvent = '${feedId}_${sportId}_$eventId';
          eventOddFields.forEach((k, v) {
            if (k.startsWith(feedSportEvent)) {
              Map<String, dynamic> ac =
                  eventOddFields[k] as Map<String, dynamic>;
              for (var e in ac.entries) {
                Map<String, dynamic> inner = {};
                if (mEventOddFields.containsKey(k)) {
                  inner = mEventOddFields[k];
                  int feedChangeStatus = 0;
                  inner.containsKey(e.key)
                      ? feedChangeStatus = inner[e.key]['feedChangeStatus']
                      : 0;
                  //  = inner[e.key]['feedChangeStatus'] ?? 0;
                  if (feedChangeStatus == 0 || feedChangeStatus == 1) {
                    // Updates the oddField
                    mEventOddFields[k][e.key] = eventOddFields[k][e.key];
                    try {
                      homeEventOddFields[e.key] = eventOddFields[k][e.key];
                    } catch (e) {
                      log(e.toString() + ' - SOMETHING');
                    }
                  } else if (feedChangeStatus == 2) {
                    mEventOddFields.remove(k);
                  }
                } else {
                  mEventOddFields[k] = eventOddFields[k];
                }
              }
            }
          });
        }
      }
      notifyListeners();
      getGroups();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  initHub() {
    hub.on('OnEventScoreChange', onEventScoreFieldsChange);
    hub.on('OnEventOddFieldsChange', onEventOddFieldsChange);
    onEventOddGroupsChange();
    onEventOddsChange();
  }

  partGroup() {}
  bool _mounted = true;
  bool get mounted => _mounted;

  @override
  void dispose() {
    super.dispose();
    _mounted = false;
  }
}

import 'dart:convert';
import 'package:archive/archive.dart';
import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';
import 'package:flutter/material.dart';

class SelectedLeagueNotifier extends ChangeNotifier {
  Map<String, dynamic> sportEvents = {};
  Map<String, dynamic> eventOdds = {};
  Map<String, dynamic> eventOddFields = {};

  String decode(String data) {
    final str = base64.decode(data);
    final deflated = Inflate(str);
    final decodedString = String.fromCharCodes(deflated.getBytes());
    return decodedString;
  }

  late HomeNotifier homeNotifier;

  Set<String> joinedGroup = {};
  bool joined = false;
  int tournamentId = 0;
  late int sportCategoryId;

  @override
  SelectedLeagueNotifier(
    HomeNotifier selectedhomeNotifier,
  ) {
    homeNotifier = selectedhomeNotifier;
  }
  initWithTournament(tournament) {
    //onMatches();
    partGroup();
    tournamentId = tournament.tournamentUId ?? 0;
    sportCategoryId = tournament.sportCategory?.sportCategoryUId ?? 0;
    final selectedDate = homeNotifier.selectedDay;
    final withDate = 'S1C' +
        sportCategoryId.toString() +
        'T' +
        tournamentId.toString() +
        'D' +
        selectedDate.toString() +
        'B1';
    joinedGroup = {};
    joinedGroup.add(withDate);
  }

  joinGroup() {
    sportEvents = {};
    eventOdds = {};
    eventOddFields = {};

    partGroup();
    //getMatches();

    if (joined) {
      return;
    }
    for (var element in joinedGroup) {
      homeNotifier.invokeGroup('JoinGroup', [
        element,
      ]);
    }
    joined = true;
  }

  partGroup() {
    sportEvents = {};
    eventOdds = {};
    eventOddFields = {};
    if (!joined) {
      return;
    }
    for (var element in joinedGroup) {
      homeNotifier.invokeGroup('PartGroup', [
        element,
      ]);
    }
    joined = false;
  }

  @override
  void dispose() {
    for (var element in joinedGroup) {
      homeNotifier.invokeGroup('PartGroup', [
        element,
      ]);
    }
    joinedGroup = {};

    super.dispose();
    _mounted = false;
  }

  bool _mounted = true;
  bool get mounted => _mounted;
}

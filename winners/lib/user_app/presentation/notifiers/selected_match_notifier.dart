import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/sport_event.dart';

import 'package:winners/user_app/presentation/notifiers/home_notifier.dart';

import 'package:flutter/material.dart';

class SelectedMatchNotifier extends ChangeNotifier {
  late HomeNotifier homeNotifier;
  late SportEvent selectedEvent;
  late Map<String, dynamic> matchOdds;
  List<String> joinedGroup = [];

  @override
  SelectedMatchNotifier(selectedhomeNotifier, event) {
    homeNotifier = selectedhomeNotifier;
    selectedEvent = event;
    final feedId = homeNotifier.feedIndex;
    final sportId = homeNotifier.selectedSport.sportId ?? 1;

    final groupName =
        'F${feedId}S${sportId}E' + selectedEvent.eventId!.toString();
    // final tournamentName = 'F5S1C' +
    //     selectedEvent.eventCategory!.sportCategoryId.toString() +
    //     'T' +
    //selectedEvent.eventTournament!.tournamentId.toString();
    joinedGroup.add(groupName);
    //joinedGroup.add(tournamentName);

    for (var element in joinedGroup) {
      homeNotifier.invokeGroup('JoinGroup', [
        element,
      ]);
    }
  }
  @override
  void dispose() {
    for (var element in joinedGroup) {
      homeNotifier.invokeGroup('PartGroup', [
        element,
      ]);
    }
    joinedGroup = [];
    super.dispose();
  }
}

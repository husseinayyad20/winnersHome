// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/top_league/top_league.dart';
import 'package:equatable/equatable.dart';

import 'event_odd.dart';
import 'event_odd_field.dart';
import 'sport_event.dart';
import 'top_bet_type.dart';
import 'upcoming_events.dart';

class TopBetSportEventData extends Equatable {
  late List<SportEvent>? sportEvents;
  late List<dynamic>? sportTypes;
  late List<dynamic>? sportCategories;
  late List<TopLeague>? sportTopLeagues;
  late UpcomingEvents? upcomingEvents;
  late List<EventOdd>? eventOdds;
  late List<String>? sportEventIds;
  late List<List<EventOddField>>? eventOddFields;
  late List<dynamic>? eventOddFieldIds;
  late List<dynamic>? eventOddIds;
  late List<TopBetType>? topBetTypes;
  late List<dynamic>? upcomingEventIds;

  TopBetSportEventData({
    this.sportEvents,
    this.sportTypes,
    this.sportCategories,
    this.sportTopLeagues,
    this.upcomingEvents,
    this.eventOdds,
    this.sportEventIds,
    this.eventOddFields,
    this.eventOddFieldIds,
    this.eventOddIds,
    this.topBetTypes,
    this.upcomingEventIds,
  });

  factory TopBetSportEventData.fromMap(Map<String, dynamic> data) =>
      TopBetSportEventData(
        // sportEvents: (data['sportEvents'] as List<dynamic>?)
        //     ?.map((e) => SportEvent.fromMap(e as Map<String, dynamic>))
        //     .toList(),
        sportTypes: data['sportTypes'] as List<dynamic>?,
        sportCategories: data['sportCategories'] as List<dynamic>?,
        sportTopLeagues: (data['sportTopLeagues'] as List<dynamic>?)
            ?.map((e) => TopLeague.fromMap(e as Map<String, dynamic>))
            .toList(),
        // upcomingEvents: data['upcomingEvents'] == null
        //     ? null
        //     : UpcomingEvents.fromMap(
        //         data['upcomingEvents'] as Map<String, dynamic>),
        // eventOdds: (data['eventOdds'] as List<dynamic>?)
        //     ?.map((e) => EventOdd.fromMap(e as Map<String, dynamic>))
        //     .toList(),
        sportEventIds: data['sportEventIds'] as List<String>?,
        // eventOddFields: (data['eventOddFields'] as List<dynamic>?)
        //     ?.map((e) => (e as List<dynamic>)
        //         .map((e) => EventOddField.fromMap(e as Map<String, dynamic>))
        //         .toList())
        //     .toList(),
        eventOddFieldIds: data['eventOddFieldIds'] as List<dynamic>?,
        eventOddIds: data['eventOddIds'] as List<dynamic>?,
        topBetTypes: (data['topBetTypes'] as List<dynamic>?)
            ?.map((e) => TopBetType.fromMap(e as Map<String, dynamic>))
            .toList(),
        upcomingEventIds: data['upcomingEventIds'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'sportEvents': sportEvents?.map((e) => e.toMap()).toList(),
        'sportTypes': sportTypes,
        'sportCategories': sportCategories,
        'sportTopLeagues': sportTopLeagues,
        // 'upcomingEvents': upcomingEvents?.toMap(),
        'eventOdds': eventOdds?.map((e) => e.toMap()).toList(),
        'sportEventIds': sportEventIds,
        'eventOddFields': eventOddFields
            ?.map((e) => e.map((e) => e.toMap()).toList())
            .toList(),
        'eventOddFieldIds': eventOddFieldIds,
        'eventOddIds': eventOddIds,
        'topBetTypes': topBetTypes?.map((e) => e.toMap()).toList(),
        'upcomingEventIds': upcomingEventIds,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopBetSportEventData].
  factory TopBetSportEventData.fromJson(String data) {
    return TopBetSportEventData.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopBetSportEventData] to a JSON string.
  String toJson() => json.encode(toMap());

  TopBetSportEventData copyWith({
    List<SportEvent>? sportEvents,
    List<dynamic>? sportTypes,
    List<dynamic>? sportCategories,
    List<TopLeague>? sportTopLeagues,
    UpcomingEvents? upcomingEvents,
    List<EventOdd>? eventOdds,
    List<String>? sportEventIds,
    List<List<EventOddField>>? eventOddFields,
    List<dynamic>? eventOddFieldIds,
    List<dynamic>? eventOddIds,
    List<TopBetType>? topBetTypes,
    List<dynamic>? upcomingEventIds,
  }) {
    return TopBetSportEventData(
      sportEvents: sportEvents ?? this.sportEvents,
      sportTypes: sportTypes ?? this.sportTypes,
      sportCategories: sportCategories ?? this.sportCategories,
      sportTopLeagues: sportTopLeagues ?? this.sportTopLeagues,
      upcomingEvents: upcomingEvents ?? this.upcomingEvents,
      eventOdds: eventOdds ?? this.eventOdds,
      sportEventIds: sportEventIds ?? this.sportEventIds,
      eventOddFields: eventOddFields ?? this.eventOddFields,
      eventOddFieldIds: eventOddFieldIds ?? this.eventOddFieldIds,
      eventOddIds: eventOddIds ?? this.eventOddIds,
      topBetTypes: topBetTypes ?? this.topBetTypes,
      upcomingEventIds: upcomingEventIds ?? this.upcomingEventIds,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      sportEvents,
      sportTypes,
      sportCategories,
      sportTopLeagues,
      upcomingEvents,
      eventOdds,
      sportEventIds,
      eventOddFields,
      eventOddFieldIds,
      eventOddIds,
      topBetTypes,
      upcomingEventIds,
    ];
  }
}

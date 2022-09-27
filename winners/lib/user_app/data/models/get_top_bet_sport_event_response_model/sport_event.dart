import 'dart:convert';

import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/event_category.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/event_score.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/event_status.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/event_tournament.dart';
import 'package:equatable/equatable.dart';
import 'feed.dart';
import 'sport.dart';

class SportEvent extends Equatable {
  final String? key;
  final int? eventIndex;
  final int? eventBetLineNo;
  final bool? eventActive;
  final dynamic eventApprove;
  final bool? isTopBet;
  final bool? isStarted;
  final int? topBetDisplayOrder;
  final bool? enableBet;
  final DateTime? eventDateOfMatch;
  final String? eventDateOfMatchFormated;
  final EventCategory? eventCategory;
  final EventTournament? eventTournament;
  final String? eventBetOpenDate;
  final DateTime? eventBetCloseDate;
  final int? eventWinnersStatus;
  final String? eventHomeTeamName;
  final String? eventAwayTeamName;
  final String? eventHomeTeamColor;
  final String? eventAwayTeamColor;
  final EventStatus? eventStatus;
  final EventScore? eventScore;
  final int? eventBetStatus;
  final int? eventBetTypesCount;
  final int? eventTime;
  final int? eventHomeTeamId;
  final int? eventHomeTeamUid;
  final int? eventAwayTeamId;
  final int? eventAwayTeamUid;
  final int? eventTimeToStart;
  final int? searchDisplayOrder;
  final int? feedChangeStatus;
  final dynamic virtualSeasonName;
  final dynamic virtualDayName;
  final dynamic trackName;
  final int? racedayId;
  final int? raceday;
  final int? kironEventNumber;
  final bool? dayActive;
  final bool? isEnded;
  final int? homeTeamRank;
  final int? awayTeamRank;
  final bool? currentDay;
  final DateTime? feedChangeUpdateCache;
  final Feed? feed;
  final Sport? sport;
  final int? eventId;
  final dynamic id;

  const SportEvent({
    this.key,
    this.eventHomeTeamColor,
    this.eventAwayTeamColor,
    this.eventIndex,
    this.eventBetLineNo,
    this.eventActive,
    this.eventApprove,
    this.isTopBet,
    this.isStarted,
    this.topBetDisplayOrder,
    this.enableBet,
    this.eventDateOfMatch,
    this.eventDateOfMatchFormated,
    this.eventCategory,
    this.eventTournament,
    this.eventBetOpenDate,
    this.eventBetCloseDate,
    this.eventWinnersStatus,
    this.eventHomeTeamName,
    this.eventAwayTeamName,
    this.eventStatus,
    this.eventScore,
    this.eventBetStatus,
    this.eventBetTypesCount,
    this.eventTime,
    this.eventHomeTeamId,
    this.eventHomeTeamUid,
    this.eventAwayTeamId,
    this.eventAwayTeamUid,
    this.eventTimeToStart,
    this.searchDisplayOrder,
    this.feedChangeStatus,
    this.virtualSeasonName,
    this.virtualDayName,
    this.trackName,
    this.racedayId,
    this.raceday,
    this.kironEventNumber,
    this.dayActive,
    this.isEnded,
    this.homeTeamRank,
    this.awayTeamRank,
    this.currentDay,
    this.feedChangeUpdateCache,
    this.feed,
    this.sport,
    this.eventId,
    this.id,
  });

  factory SportEvent.fromMap(Map<String, dynamic> data) => SportEvent(
        key: data['key'] as String?,
        eventHomeTeamColor: data['eventHomeTeamColor'] as String?,
        eventAwayTeamColor: data['eventAwayTeamColor'] as String?,
        eventIndex: data['eventIndex'] as int?,
        eventBetLineNo: data['eventBetLineNo'] as int?,
        eventActive: data['eventActive'] as bool?,
        eventApprove: data['eventApprove'] as dynamic,
        isTopBet: data['isTopBet'] as bool?,
        isStarted: data['isStarted'] as bool?,
        topBetDisplayOrder: data['topBetDisplayOrder'] as int?,
        enableBet: data['enableBet'] as bool?,
        eventDateOfMatch: data['eventDateOfMatch'] == null
            ? null
            : DateTime.parse(data['eventDateOfMatch'] as String),
        eventDateOfMatchFormated: data['eventDateOfMatchFormated'] as String?,
        eventCategory: data['eventCategory'] == null
            ? null
            : EventCategory.fromMap(
                data['eventCategory'] as Map<String, dynamic>),
        eventTournament: data['eventTournament'] == null
            ? null
            : EventTournament.fromMap(
                data['eventTournament'] as Map<String, dynamic>),
        eventBetOpenDate: data['eventBetOpenDate'] as String?,
        eventBetCloseDate: data['eventBetCloseDate'] == null
            ? null
            : DateTime.parse(data['eventBetCloseDate'] as String),
        eventWinnersStatus: data['eventWinnersStatus'] as int?,
        eventHomeTeamName: data['eventHomeTeamName'] as String?,
        eventAwayTeamName: data['eventAwayTeamName'] as String?,
        eventStatus: data['eventStatus'] == null
            ? null
            : EventStatus.fromMap(data['eventStatus'] as Map<String, dynamic>),
        eventScore: data['eventScore'] == null
            ? null
            : EventScore.fromMap(data['eventScore'] as Map<String, dynamic>),
        eventBetStatus: data['eventBetStatus'] as int?,
        eventBetTypesCount: data['eventBetTypesCount'] as int?,
        eventTime: data['eventTime'] as int?,
        eventHomeTeamId: data['eventHomeTeamId'] as int?,
        eventHomeTeamUid: data['eventHomeTeamUid'] as int?,
        eventAwayTeamId: data['eventAwayTeamId'] as int?,
        eventAwayTeamUid: data['eventAwayTeamUid'] as int?,
        eventTimeToStart: data['eventTimeToStart'] as int?,
        searchDisplayOrder: data['searchDisplayOrder'] as int?,
        feedChangeStatus: data['feedChangeStatus'] as int?,
        virtualSeasonName: data['virtualSeasonName'] as dynamic,
        virtualDayName: data['virtualDayName'] as dynamic,
        trackName: data['trackName'] as dynamic,
        racedayId: data['racedayId'] as int?,
        raceday: data['raceday'] as int?,
        kironEventNumber: data['kironEventNumber'] as int?,
        dayActive: data['dayActive'] as bool?,
        isEnded: data['isEnded'] as bool?,
        homeTeamRank: data['homeTeamRank'] as int?,
        awayTeamRank: data['awayTeamRank'] as int?,
        currentDay: data['currentDay'] as bool?,
        feedChangeUpdateCache: data['feedChangeUpdateCache'] == null
            ? null
            : DateTime.parse(data['feedChangeUpdateCache'] as String),
        feed: data['feed'] == null
            ? null
            : Feed.fromMap(data['feed'] as Map<String, dynamic>),
        sport: data['sport'] == null
            ? null
            : Sport.fromMap(data['sport'] as Map<String, dynamic>),
        eventId: data['eventId'] as int?,
        id: data['id'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'key': key,
        'eventAwayTeamColor': eventAwayTeamColor,
        'eventHomeTeamColor': eventHomeTeamColor,
        'eventIndex': eventIndex,
        'eventBetLineNo': eventBetLineNo,
        'eventActive': eventActive,
        'eventApprove': eventApprove,
        'isTopBet': isTopBet,
        'isStarted': isStarted,
        'topBetDisplayOrder': topBetDisplayOrder,
        'enableBet': enableBet,
        'eventDateOfMatch': eventDateOfMatch?.toIso8601String(),
        'eventDateOfMatchFormated': eventDateOfMatchFormated,
        'eventCategory': eventCategory?.toMap(),
        'eventTournament': eventTournament?.toMap(),
        'eventBetOpenDate': eventBetOpenDate,
        'eventBetCloseDate': eventBetCloseDate?.toIso8601String(),
        'eventWinnersStatus': eventWinnersStatus,
        'eventHomeTeamName': eventHomeTeamName,
        'eventAwayTeamName': eventAwayTeamName,
        'eventStatus': eventStatus?.toMap(),
        'eventScore': eventScore?.toMap(),
        'eventBetStatus': eventBetStatus,
        'eventBetTypesCount': eventBetTypesCount,
        'eventTime': eventTime,
        'eventHomeTeamId': eventHomeTeamId,
        'eventHomeTeamUid': eventHomeTeamUid,
        'eventAwayTeamId': eventAwayTeamId,
        'eventAwayTeamUid': eventAwayTeamUid,
        'eventTimeToStart': eventTimeToStart,
        'searchDisplayOrder': searchDisplayOrder,
        'feedChangeStatus': feedChangeStatus,
        'virtualSeasonName': virtualSeasonName,
        'virtualDayName': virtualDayName,
        'trackName': trackName,
        'racedayId': racedayId,
        'raceday': raceday,
        'kironEventNumber': kironEventNumber,
        'dayActive': dayActive,
        'isEnded': isEnded,
        'homeTeamRank': homeTeamRank,
        'awayTeamRank': awayTeamRank,
        'currentDay': currentDay,
        'feedChangeUpdateCache': feedChangeUpdateCache?.toIso8601String(),
        'feed': feed?.toMap(),
        'sport': sport?.toMap(),
        'eventId': eventId,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SportEvent].
  factory SportEvent.fromJson(String data) {
    return SportEvent.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SportEvent] to a JSON string.
  String toJson() => json.encode(toMap());

  SportEvent copyWith({
    String? key,
    int? eventIndex,
    int? eventBetLineNo,
    bool? eventActive,
    dynamic eventApprove,
    bool? isTopBet,
    bool? isStarted,
    int? topBetDisplayOrder,
    bool? enableBet,
    DateTime? eventDateOfMatch,
    String? eventDateOfMatchFormated,
    EventCategory? eventCategory,
    EventTournament? eventTournament,
    String? eventBetOpenDate,
    DateTime? eventBetCloseDate,
    int? eventWinnersStatus,
    String? eventHomeTeamName,
    String? eventAwayTeamName,
    EventStatus? eventStatus,
    EventScore? eventScore,
    int? eventBetStatus,
    int? eventBetTypesCount,
    int? eventTime,
    int? eventHomeTeamId,
    int? eventHomeTeamUid,
    int? eventAwayTeamId,
    int? eventAwayTeamUid,
    int? eventTimeToStart,
    int? searchDisplayOrder,
    int? feedChangeStatus,
    dynamic virtualSeasonName,
    dynamic virtualDayName,
    dynamic trackName,
    int? racedayId,
    int? raceday,
    int? kironEventNumber,
    bool? dayActive,
    bool? isEnded,
    int? homeTeamRank,
    int? awayTeamRank,
    bool? currentDay,
    DateTime? feedChangeUpdateCache,
    Feed? feed,
    Sport? sport,
    int? eventId,
    dynamic id,
  }) {
    return SportEvent(
      key: key ?? this.key,
      eventIndex: eventIndex ?? this.eventIndex,
      eventBetLineNo: eventBetLineNo ?? this.eventBetLineNo,
      eventActive: eventActive ?? this.eventActive,
      eventApprove: eventApprove ?? this.eventApprove,
      isTopBet: isTopBet ?? this.isTopBet,
      isStarted: isStarted ?? this.isStarted,
      topBetDisplayOrder: topBetDisplayOrder ?? this.topBetDisplayOrder,
      enableBet: enableBet ?? this.enableBet,
      eventDateOfMatch: eventDateOfMatch ?? this.eventDateOfMatch,
      eventDateOfMatchFormated:
          eventDateOfMatchFormated ?? this.eventDateOfMatchFormated,
      eventCategory: eventCategory ?? this.eventCategory,
      eventTournament: eventTournament ?? this.eventTournament,
      eventBetOpenDate: eventBetOpenDate ?? this.eventBetOpenDate,
      eventBetCloseDate: eventBetCloseDate ?? this.eventBetCloseDate,
      eventWinnersStatus: eventWinnersStatus ?? this.eventWinnersStatus,
      eventHomeTeamName: eventHomeTeamName ?? this.eventHomeTeamName,
      eventAwayTeamName: eventAwayTeamName ?? this.eventAwayTeamName,
      eventStatus: eventStatus ?? this.eventStatus,
      eventScore: eventScore ?? this.eventScore,
      eventBetStatus: eventBetStatus ?? this.eventBetStatus,
      eventBetTypesCount: eventBetTypesCount ?? this.eventBetTypesCount,
      eventTime: eventTime ?? this.eventTime,
      eventHomeTeamId: eventHomeTeamId ?? this.eventHomeTeamId,
      eventHomeTeamUid: eventHomeTeamUid ?? this.eventHomeTeamUid,
      eventAwayTeamId: eventAwayTeamId ?? this.eventAwayTeamId,
      eventAwayTeamUid: eventAwayTeamUid ?? this.eventAwayTeamUid,
      eventTimeToStart: eventTimeToStart ?? this.eventTimeToStart,
      searchDisplayOrder: searchDisplayOrder ?? this.searchDisplayOrder,
      feedChangeStatus: feedChangeStatus ?? this.feedChangeStatus,
      virtualSeasonName: virtualSeasonName ?? this.virtualSeasonName,
      virtualDayName: virtualDayName ?? this.virtualDayName,
      trackName: trackName ?? this.trackName,
      racedayId: racedayId ?? this.racedayId,
      raceday: raceday ?? this.raceday,
      kironEventNumber: kironEventNumber ?? this.kironEventNumber,
      dayActive: dayActive ?? this.dayActive,
      isEnded: isEnded ?? this.isEnded,
      homeTeamRank: homeTeamRank ?? this.homeTeamRank,
      awayTeamRank: awayTeamRank ?? this.awayTeamRank,
      currentDay: currentDay ?? this.currentDay,
      feedChangeUpdateCache:
          feedChangeUpdateCache ?? this.feedChangeUpdateCache,
      feed: feed ?? this.feed,
      sport: sport ?? this.sport,
      eventId: eventId ?? this.eventId,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      key,
      eventAwayTeamColor,
      eventHomeTeamColor,
      eventIndex,
      eventBetLineNo,
      eventActive,
      eventApprove,
      isTopBet,
      isStarted,
      topBetDisplayOrder,
      enableBet,
      eventDateOfMatch,
      eventDateOfMatchFormated,
      eventCategory,
      eventTournament,
      eventBetOpenDate,
      eventBetCloseDate,
      eventWinnersStatus,
      eventHomeTeamName,
      eventAwayTeamName,
      eventStatus,
      eventScore,
      eventBetStatus,
      eventBetTypesCount,
      eventTime,
      eventHomeTeamId,
      eventHomeTeamUid,
      eventAwayTeamId,
      eventAwayTeamUid,
      eventTimeToStart,
      searchDisplayOrder,
      feedChangeStatus,
      virtualSeasonName,
      virtualDayName,
      trackName,
      racedayId,
      raceday,
      kironEventNumber,
      dayActive,
      isEnded,
      homeTeamRank,
      awayTeamRank,
      currentDay,
      feedChangeUpdateCache,
      feed,
      sport,
      eventId,
      id,
    ];
  }
}

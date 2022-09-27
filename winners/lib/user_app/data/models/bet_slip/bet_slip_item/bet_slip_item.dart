// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'bet_type.dart';
import 'event_category.dart';
import 'event_tournament.dart';
import 'feed.dart';
import 'sport.dart';

class BetSlipItem extends Equatable {
  final int? activeOddFieldId;
  final String? oddField;
  final String? oddFieldDisplayName;
  final String? eventDisplayName;
  final int? oddFieldColumn;
  final int? oddFieldRow;
  double? oddValue;
  final int? oddFieldNumber;
  final int? oddValueStatus;
  final int? oddStatus;
  final int? eventBetLineNo;
  final bool? oddOutcome;
  bool? oddEnableBet;
  final int? competitorId;
  final dynamic competitorName;
  final int? jockeyId;
  String? homeTeamName;
  String? awayTeamName;
  int? homeTeamId;
  int? awayTeamId;
  final dynamic locations;
  final String? key;
  final int? activeOddId;
  final int? oddId;
  final BetType? betType;
  final bool? oddActive;
  final bool? oddApproved;
  final String? oddSpecialField;
  bool? enableBet;
  final EventCategory? eventCategory;
  final EventTournament? eventTournament;
  final int? feedChangeStatus;
  final DateTime? dateOfMatch;
  final bool? specialBetType;
  final bool? isTopBet;
  final bool? isTopLeageEvent;
  bool? eventEnableBet;
  final bool? paused;
  final bool? oddInactive;
  final DateTime? feedChangeUpdateCache;
  final Feed? feed;
  final Sport? sport;
  final int? eventId;
  String? season;
  String? day;
  final dynamic id;
  final List<String>? errors;

  BetSlipItem(
      {this.activeOddFieldId,
      this.oddField,
      this.oddFieldDisplayName,
      this.eventDisplayName,
      this.oddFieldColumn,
      this.oddFieldRow,
      this.oddValue,
      this.oddFieldNumber,
      this.oddValueStatus,
      this.oddStatus,
      this.eventBetLineNo,
      this.oddOutcome,
      this.oddEnableBet,
      this.competitorId,
      this.competitorName,
      this.jockeyId,
      this.homeTeamName,
      this.awayTeamName,
      this.homeTeamId,
      this.awayTeamId,
      this.locations,
      this.key,
      this.activeOddId,
      this.oddId,
      this.betType,
      this.oddActive,
      this.oddApproved,
      this.oddSpecialField,
      this.enableBet,
      this.eventCategory,
      this.eventTournament,
      this.feedChangeStatus,
      this.dateOfMatch,
      this.specialBetType,
      this.isTopBet,
      this.isTopLeageEvent,
      this.eventEnableBet,
      this.paused,
      this.oddInactive,
      this.feedChangeUpdateCache,
      this.feed,
      this.sport,
      this.eventId,
      this.id,
      this.season,
      this.day,
      this.errors});

  factory BetSlipItem.fromMap(Map<String, dynamic> data) => BetSlipItem(
      activeOddFieldId: data['activeOddFieldId'] as int?,
      oddField: data['oddField'] as String?,
      oddFieldDisplayName: data['oddFieldDisplayName'] as String?,
      eventDisplayName: data['eventDisplayName'] as String?,
      oddFieldColumn: data['oddFieldColumn'] as int?,
      oddFieldRow: data['oddFieldRow'] as int?,
      oddValue: (data['oddValue'] as num?)?.toDouble(),
      oddFieldNumber: data['oddFieldNumber'] as int?,
      oddValueStatus: data['oddValueStatus'] as int?,
      oddStatus: data['oddStatus'] as int?,
      eventBetLineNo: data['eventBetLineNo'] as int?,
      oddOutcome: data['oddOutcome'] as bool?,
      oddEnableBet: data['oddEnableBet'] as bool?,
      competitorId: data['competitorId'] as int?,
      competitorName: data['competitorName'] as dynamic,
      jockeyId: data['jockeyId'] as int?,
      homeTeamName: data['homeTeamName'] as String?,
      awayTeamName: data['awayTeamName'] as String?,
      homeTeamId: data['homeTeamId'] as int?,
      awayTeamId: data['awayTeamId'] as int?,
      locations: data['locations'] as dynamic,
      key: data['key'] as String?,
      activeOddId: data['activeOddId'] as int?,
      oddId: data['oddId'] as int?,
      betType: data['betType'] == null
          ? null
          : BetType.fromMap(data['betType'] as Map<String, dynamic>),
      oddActive: data['oddActive'] as bool?,
      oddApproved: data['oddApproved'] as bool?,
      oddSpecialField: data['oddSpecialField'] as String?,
      enableBet: data['enableBet'] as bool?,
      eventCategory: data['eventCategory'] == null
          ? null
          : EventCategory.fromMap(
              data['eventCategory'] as Map<String, dynamic>),
      eventTournament: data['eventTournament'] == null
          ? null
          : EventTournament.fromMap(
              data['eventTournament'] as Map<String, dynamic>),
      feedChangeStatus: data['feedChangeStatus'] as int?,
      dateOfMatch: data['dateOfMatch'] == null
          ? null
          : DateTime.parse(data['dateOfMatch'] as String),
      specialBetType: data['specialBetType'] as bool?,
      isTopBet: data['isTopBet'] as bool?,
      isTopLeageEvent: data['isTopLeageEvent'] as bool?,
      eventEnableBet: data['eventEnableBet'] as bool?,
      paused: data['paused'] as bool?,
      oddInactive: data['oddInactive'] as bool?,
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
      season: data['season'] == null ? "" : data['season'] as String,
      day: data['day'] == null ? "" : data['day'] as String);

  Map<String, dynamic> toMap() => {
        'activeOddFieldId': activeOddFieldId,
        'oddField': oddField,
        'oddFieldDisplayName': oddFieldDisplayName,
        'eventDisplayName': eventDisplayName,
        'oddFieldColumn': oddFieldColumn,
        'oddFieldRow': oddFieldRow,
        'oddValue': oddValue,
        'oddFieldNumber': oddFieldNumber,
        'oddValueStatus': oddValueStatus,
        'oddStatus': oddStatus,
        'eventBetLineNo': eventBetLineNo,
        'oddOutcome': oddOutcome,
        'oddEnableBet': oddEnableBet,
        'competitorId': competitorId,
        'competitorName': competitorName,
        'jockeyId': jockeyId,
        'homeTeamName': homeTeamName,
        'awayTeamName': awayTeamName,
        'homeTeamId': homeTeamId,
        'awayTeamId': awayTeamId,
        'locations': locations,
        'key': key,
        'activeOddId': activeOddId,
        'oddId': oddId,
        'betType': betType?.toMap(),
        'oddActive': oddActive,
        'oddApproved': oddApproved,
        'oddSpecialField': oddSpecialField,
        'enableBet': enableBet,
        'eventCategory': eventCategory?.toMap(),
        'eventTournament': eventTournament?.toMap(),
        'feedChangeStatus': feedChangeStatus,
        'dateOfMatch': dateOfMatch?.toIso8601String(),
        'specialBetType': specialBetType,
        'isTopBet': isTopBet,
        'isTopLeageEvent': isTopLeageEvent,
        'eventEnableBet': eventEnableBet,
        'paused': paused,
        'oddInactive': oddInactive,
        'feedChangeUpdateCache': feedChangeUpdateCache?.toIso8601String(),
        'feed': feed?.toMap(),
        'sport': sport?.toMap(),
        'eventId': eventId,
        'id': id,
        'season': season,
        'day': day
      };
  void setOddValue(double odd) {
    oddValue = odd;
  }

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetSlipItem].
  factory BetSlipItem.fromJson(String data) {
    return BetSlipItem.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetSlipItem] to a JSON string.
  String toJson() => json.encode(toMap());

  BetSlipItem copyWith(
      {int? activeOddFieldId,
      String? oddField,
      String? oddFieldDisplayName,
      String? eventDisplayName,
      int? oddFieldColumn,
      int? oddFieldRow,
      double? oddValue,
      int? oddFieldNumber,
      int? oddValueStatus,
      int? oddStatus,
      int? eventBetLineNo,
      bool? oddOutcome,
      bool? oddEnableBet,
      int? competitorId,
      dynamic competitorName,
      int? jockeyId,
      String? homeTeamName,
      String? awayTeamName,
      int? homeTeamId,
      int? awayTeamId,
      dynamic locations,
      String? key,
      int? activeOddId,
      int? oddId,
      BetType? betType,
      bool? oddActive,
      bool? oddApproved,
      String? oddSpecialField,
      bool? enableBet,
      EventCategory? eventCategory,
      EventTournament? eventTournament,
      int? feedChangeStatus,
      DateTime? dateOfMatch,
      bool? specialBetType,
      bool? isTopBet,
      bool? isTopLeageEvent,
      bool? eventEnableBet,
      bool? paused,
      bool? oddInactive,
      DateTime? feedChangeUpdateCache,
      Feed? feed,
      Sport? sport,
      int? eventId,
      dynamic id,
      String? season,
      String? day}) {
    return BetSlipItem(
        activeOddFieldId: activeOddFieldId ?? this.activeOddFieldId,
        oddField: oddField ?? this.oddField,
        oddFieldDisplayName: oddFieldDisplayName ?? this.oddFieldDisplayName,
        eventDisplayName: eventDisplayName ?? this.eventDisplayName,
        oddFieldColumn: oddFieldColumn ?? this.oddFieldColumn,
        oddFieldRow: oddFieldRow ?? this.oddFieldRow,
        oddValue: oddValue ?? this.oddValue,
        oddFieldNumber: oddFieldNumber ?? this.oddFieldNumber,
        oddValueStatus: oddValueStatus ?? this.oddValueStatus,
        oddStatus: oddStatus ?? this.oddStatus,
        eventBetLineNo: eventBetLineNo ?? this.eventBetLineNo,
        oddOutcome: oddOutcome ?? this.oddOutcome,
        oddEnableBet: oddEnableBet ?? this.oddEnableBet,
        competitorId: competitorId ?? this.competitorId,
        competitorName: competitorName ?? this.competitorName,
        jockeyId: jockeyId ?? this.jockeyId,
        homeTeamName: homeTeamName ?? this.homeTeamName,
        awayTeamName: awayTeamName ?? this.awayTeamName,
        homeTeamId: homeTeamId ?? this.homeTeamId,
        awayTeamId: awayTeamId ?? this.awayTeamId,
        locations: locations ?? this.locations,
        key: key ?? this.key,
        activeOddId: activeOddId ?? this.activeOddId,
        oddId: oddId ?? this.oddId,
        betType: betType ?? this.betType,
        oddActive: oddActive ?? this.oddActive,
        oddApproved: oddApproved ?? this.oddApproved,
        oddSpecialField: oddSpecialField ?? this.oddSpecialField,
        enableBet: enableBet ?? this.enableBet,
        eventCategory: eventCategory ?? this.eventCategory,
        eventTournament: eventTournament ?? this.eventTournament,
        feedChangeStatus: feedChangeStatus ?? this.feedChangeStatus,
        dateOfMatch: dateOfMatch ?? this.dateOfMatch,
        specialBetType: specialBetType ?? this.specialBetType,
        isTopBet: isTopBet ?? this.isTopBet,
        isTopLeageEvent: isTopLeageEvent ?? this.isTopLeageEvent,
        eventEnableBet: eventEnableBet ?? this.eventEnableBet,
        paused: paused ?? this.paused,
        oddInactive: oddInactive ?? this.oddInactive,
        feedChangeUpdateCache:
            feedChangeUpdateCache ?? this.feedChangeUpdateCache,
        feed: feed ?? this.feed,
        sport: sport ?? this.sport,
        eventId: eventId ?? this.eventId,
        id: id ?? this.id,
        season: season ?? this.season,
        day: day ?? this.day);
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      activeOddFieldId,
      oddField,
      oddFieldDisplayName,
      eventDisplayName,
      oddFieldColumn,
      oddFieldRow,
      oddValue,
      oddFieldNumber,
      oddValueStatus,
      oddStatus,
      eventBetLineNo,
      oddOutcome,
      oddEnableBet,
      competitorId,
      competitorName,
      jockeyId,
      homeTeamName,
      awayTeamName,
      homeTeamId,
      awayTeamId,
      locations,
      key,
      activeOddId,
      oddId,
      betType,
      oddActive,
      oddApproved,
      oddSpecialField,
      enableBet,
      eventCategory,
      eventTournament,
      feedChangeStatus,
      dateOfMatch,
      specialBetType,
      isTopBet,
      isTopLeageEvent,
      eventEnableBet,
      paused,
      oddInactive,
      feedChangeUpdateCache,
      feed,
      sport,
      eventId,
      id,
    ];
  }
}

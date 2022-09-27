import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'feed.dart';
import 'sport.dart';

class EventScore extends Equatable {
  final dynamic scoreTypeName;
  final dynamic score;
  final int? eventStatus;
  final bool? eventActive;
  final int? eventBetStatus;
  final int? eventTime;
  final int? categoryId;
  final int? tournamentId;
  final dynamic eventStatusDisplayName;
  final DateTime? dateOfMatch;
  final dynamic setScores;
  final int? server;
  final dynamic gameScore;
  final bool? isTopBet;
  final int? eventTimeStatus;
  final DateTime? feedChangeUpdateCache;
  final Feed? feed;
  final Sport? sport;
  final int? eventId;
  final dynamic id;

  const EventScore({
    this.scoreTypeName,
    this.score,
    this.eventStatus,
    this.eventActive,
    this.eventBetStatus,
    this.eventTime,
    this.categoryId,
    this.tournamentId,
    this.eventStatusDisplayName,
    this.dateOfMatch,
    this.setScores,
    this.server,
    this.gameScore,
    this.isTopBet,
    this.eventTimeStatus,
    this.feedChangeUpdateCache,
    this.feed,
    this.sport,
    this.eventId,
    this.id,
  });

  factory EventScore.fromMap(Map<String, dynamic> data) => EventScore(
        scoreTypeName: data['scoreTypeName'] as dynamic,
        score: data['score'] as dynamic,
        eventStatus: data['eventStatus'] as int?,
        eventActive: data['eventActive'] as bool?,
        eventBetStatus: data['eventBetStatus'] as int?,
        eventTime: data['eventTime'] as int?,
        categoryId: data['categoryId'] as int?,
        tournamentId: data['tournamentId'] as int?,
        eventStatusDisplayName: data['eventStatusDisplayName'] as dynamic,
        dateOfMatch: data['dateOfMatch'] == null
            ? null
            : DateTime.parse(data['dateOfMatch'] as String),
        setScores: data['setScores'] as dynamic,
        server: data['server'] as int?,
        gameScore: data['gameScore'] as dynamic,
        isTopBet: data['isTopBet'] as bool?,
        eventTimeStatus: data['eventTimeStatus'] as int?,
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
        'scoreTypeName': scoreTypeName,
        'score': score,
        'eventStatus': eventStatus,
        'eventActive': eventActive,
        'eventBetStatus': eventBetStatus,
        'eventTime': eventTime,
        'categoryId': categoryId,
        'tournamentId': tournamentId,
        'eventStatusDisplayName': eventStatusDisplayName,
        'dateOfMatch': dateOfMatch?.toIso8601String(),
        'setScores': setScores,
        'server': server,
        'gameScore': gameScore,
        'isTopBet': isTopBet,
        'eventTimeStatus': eventTimeStatus,
        'feedChangeUpdateCache': feedChangeUpdateCache?.toIso8601String(),
        'feed': feed?.toMap(),
        'sport': sport?.toMap(),
        'eventId': eventId,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EventScore].
  factory EventScore.fromJson(String data) {
    return EventScore.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EventScore] to a JSON string.
  String toJson() => json.encode(toMap());

  EventScore copyWith({
    dynamic scoreTypeName,
    dynamic score,
    int? eventStatus,
    bool? eventActive,
    int? eventBetStatus,
    int? eventTime,
    int? categoryId,
    int? tournamentId,
    dynamic eventStatusDisplayName,
    DateTime? dateOfMatch,
    dynamic setScores,
    int? server,
    dynamic gameScore,
    bool? isTopBet,
    int? eventTimeStatus,
    DateTime? feedChangeUpdateCache,
    Feed? feed,
    Sport? sport,
    int? eventId,
    dynamic id,
  }) {
    return EventScore(
      scoreTypeName: scoreTypeName ?? this.scoreTypeName,
      score: score ?? this.score,
      eventStatus: eventStatus ?? this.eventStatus,
      eventActive: eventActive ?? this.eventActive,
      eventBetStatus: eventBetStatus ?? this.eventBetStatus,
      eventTime: eventTime ?? this.eventTime,
      categoryId: categoryId ?? this.categoryId,
      tournamentId: tournamentId ?? this.tournamentId,
      eventStatusDisplayName:
          eventStatusDisplayName ?? this.eventStatusDisplayName,
      dateOfMatch: dateOfMatch ?? this.dateOfMatch,
      setScores: setScores ?? this.setScores,
      server: server ?? this.server,
      gameScore: gameScore ?? this.gameScore,
      isTopBet: isTopBet ?? this.isTopBet,
      eventTimeStatus: eventTimeStatus ?? this.eventTimeStatus,
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
      scoreTypeName,
      score,
      eventStatus,
      eventActive,
      eventBetStatus,
      eventTime,
      categoryId,
      tournamentId,
      eventStatusDisplayName,
      dateOfMatch,
      setScores,
      server,
      gameScore,
      isTopBet,
      eventTimeStatus,
      feedChangeUpdateCache,
      feed,
      sport,
      eventId,
      id,
    ];
  }
}

import 'package:equatable/equatable.dart';

import 'feed.dart';
import 'sport.dart';

class MatchScore extends Equatable {
  final String? scoreTypeName;
  final String? score;
  final int? eventStatus;
  final bool? eventActive;
  final int? eventBetStatus;
  final int? eventTime;
  final int? categoryId;
  final int? tournamentId;
  final int? categoryUId;
  final int? tournamentUId;
  final String? eventStatusDisplayName;
  final DateTime? dateOfMatch;
  final dynamic setScores;
  final int? server;
  final dynamic gameScore;
  final bool? isTopBet;
  final bool? isTopLeageEvent;
  final int? eventTimeStatus;
  final String? feedChangeUpdateCache;
  final Feed? feed;
  final Sport? sport;
  final int? eventId;
  final dynamic id;

  const MatchScore({
    this.scoreTypeName,
    this.score,
    this.eventStatus,
    this.eventActive,
    this.eventBetStatus,
    this.eventTime,
    this.categoryId,
    this.tournamentId,
    this.categoryUId,
    this.tournamentUId,
    this.eventStatusDisplayName,
    this.dateOfMatch,
    this.setScores,
    this.server,
    this.gameScore,
    this.isTopBet,
    this.isTopLeageEvent,
    this.eventTimeStatus,
    this.feedChangeUpdateCache,
    this.feed,
    this.sport,
    this.eventId,
    this.id,
  });

  factory MatchScore.fromJson(Map<String, dynamic> json) => MatchScore(
        scoreTypeName: json['scoreTypeName'] as String?,
        score: json['score'] as String?,
        eventStatus: json['eventStatus'] as int?,
        eventActive: json['eventActive'] as bool?,
        eventBetStatus: json['eventBetStatus'] as int?,
        eventTime: json['eventTime'] as int?,
        categoryId: json['categoryId'] as int?,
        tournamentId: json['tournamentId'] as int?,
        categoryUId: json['categoryUId'] as int?,
        tournamentUId: json['tournamentUId'] as int?,
        eventStatusDisplayName: json['eventStatusDisplayName'] as String?,
        dateOfMatch: json['dateOfMatch'] == null
            ? null
            : DateTime.parse(json['dateOfMatch'] as String),
        setScores: json['setScores'],
        server: json['server'] as int?,
        gameScore: json['gameScore'],
        isTopBet: json['isTopBet'] as bool?,
        isTopLeageEvent: json['isTopLeageEvent'] as bool?,
        eventTimeStatus: json['eventTimeStatus'] as int?,
        feedChangeUpdateCache: json['feedChangeUpdateCache'] as String?,
        feed: json['feed'] == null
            ? null
            : Feed.fromJson(json['feed'] as Map<String, dynamic>),
        sport: json['sport'] == null
            ? null
            : Sport.fromJson(json['sport'] as Map<String, dynamic>),
        eventId: json['eventId'] as int?,
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'scoreTypeName': scoreTypeName,
        'score': score,
        'eventStatus': eventStatus,
        'eventActive': eventActive,
        'eventBetStatus': eventBetStatus,
        'eventTime': eventTime,
        'categoryId': categoryId,
        'tournamentId': tournamentId,
        'categoryUId': categoryUId,
        'tournamentUId': tournamentUId,
        'eventStatusDisplayName': eventStatusDisplayName,
        'dateOfMatch': dateOfMatch?.toIso8601String(),
        'setScores': setScores,
        'server': server,
        'gameScore': gameScore,
        'isTopBet': isTopBet,
        'isTopLeageEvent': isTopLeageEvent,
        'eventTimeStatus': eventTimeStatus,
        'feedChangeUpdateCache': feedChangeUpdateCache,
        'feed': feed?.toJson(),
        'sport': sport?.toJson(),
        'eventId': eventId,
        'id': id,
      };

  MatchScore copyWith({
    String? scoreTypeName,
    String? score,
    int? eventStatus,
    bool? eventActive,
    int? eventBetStatus,
    int? eventTime,
    int? categoryId,
    int? tournamentId,
    int? categoryUId,
    int? tournamentUId,
    String? eventStatusDisplayName,
    DateTime? dateOfMatch,
    dynamic setScores,
    int? server,
    dynamic gameScore,
    bool? isTopBet,
    bool? isTopLeageEvent,
    int? eventTimeStatus,
    String? feedChangeUpdateCache,
    Feed? feed,
    Sport? sport,
    int? eventId,
    dynamic id,
  }) {
    return MatchScore(
      scoreTypeName: scoreTypeName ?? this.scoreTypeName,
      score: score ?? this.score,
      eventStatus: eventStatus ?? this.eventStatus,
      eventActive: eventActive ?? this.eventActive,
      eventBetStatus: eventBetStatus ?? this.eventBetStatus,
      eventTime: eventTime ?? this.eventTime,
      categoryId: categoryId ?? this.categoryId,
      tournamentId: tournamentId ?? this.tournamentId,
      categoryUId: categoryUId ?? this.categoryUId,
      tournamentUId: tournamentUId ?? this.tournamentUId,
      eventStatusDisplayName:
          eventStatusDisplayName ?? this.eventStatusDisplayName,
      dateOfMatch: dateOfMatch ?? this.dateOfMatch,
      setScores: setScores ?? this.setScores,
      server: server ?? this.server,
      gameScore: gameScore ?? this.gameScore,
      isTopBet: isTopBet ?? this.isTopBet,
      isTopLeageEvent: isTopLeageEvent ?? this.isTopLeageEvent,
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
      categoryUId,
      tournamentUId,
      eventStatusDisplayName,
      dateOfMatch,
      setScores,
      server,
      gameScore,
      isTopBet,
      isTopLeageEvent,
      eventTimeStatus,
      feedChangeUpdateCache,
      feed,
      sport,
      eventId,
      id,
    ];
  }
}

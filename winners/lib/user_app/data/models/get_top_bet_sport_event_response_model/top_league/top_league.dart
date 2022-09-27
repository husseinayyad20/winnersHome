import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'feed.dart';
import 'sport.dart';
import 'sport_category.dart';

class TopLeague extends Equatable {
  final int? eventId;
  final Feed? feed;
  final int? feedChangeStatus;
  final DateTime? feedChangeUpdateCache;
  final dynamic id;
  final Sport? sport;
  final SportCategory? sportCategory;
  final int? topLeaguesDisplayOrder;
  final bool? tournamentActive;
  final int? tournamentActiveEvents;
  final String? tournamentDisplayName;
  final int? tournamentDisplayOrder;
  final int? tournamentId;
  final int? tournamentUId;

  const TopLeague({
    this.eventId,
    this.feed,
    this.feedChangeStatus,
    this.feedChangeUpdateCache,
    this.id,
    this.sport,
    this.sportCategory,
    this.topLeaguesDisplayOrder,
    this.tournamentActive,
    this.tournamentActiveEvents,
    this.tournamentDisplayName,
    this.tournamentDisplayOrder,
    this.tournamentId,
    this.tournamentUId,
  });

  factory TopLeague.fromMap(Map<String, dynamic> data) => TopLeague(
        eventId: data['eventId'] as int?,
        feed: data['feed'] == null
            ? null
            : Feed.fromMap(data['feed'] as Map<String, dynamic>),
        feedChangeStatus: data['feedChangeStatus'] as int?,
        feedChangeUpdateCache: data['feedChangeUpdateCache'] == null
            ? null
            : DateTime.parse(data['feedChangeUpdateCache'] as String),
        id: data['id'] as dynamic,
        sport: data['sport'] == null
            ? null
            : Sport.fromMap(data['sport'] as Map<String, dynamic>),
        sportCategory: data['sportCategory'] == null
            ? null
            : SportCategory.fromMap(
                data['sportCategory'] as Map<String, dynamic>),
        topLeaguesDisplayOrder: data['topLeaguesDisplayOrder'] as int?,
        tournamentActive: data['tournamentActive'] as bool?,
        tournamentActiveEvents: data['tournamentActiveEvents'] as int?,
        tournamentDisplayName: data['tournamentDisplayName'] as String?,
        tournamentDisplayOrder: data['tournamentDisplayOrder'] as int?,
        tournamentId: data['tournamentId'] as int?,
        tournamentUId: data['tournamentUId'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'eventId': eventId,
        'feed': feed?.toMap(),
        'feedChangeStatus': feedChangeStatus,
        'feedChangeUpdateCache': feedChangeUpdateCache?.toIso8601String(),
        'id': id,
        'sport': sport?.toMap(),
        'sportCategory': sportCategory?.toMap(),
        'topLeaguesDisplayOrder': topLeaguesDisplayOrder,
        'tournamentActive': tournamentActive,
        'tournamentActiveEvents': tournamentActiveEvents,
        'tournamentDisplayName': tournamentDisplayName,
        'tournamentDisplayOrder': tournamentDisplayOrder,
        'tournamentId': tournamentId,
        'tournamentUId': tournamentUId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopLeague].
  factory TopLeague.fromJson(String data) {
    return TopLeague.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopLeague] to a JSON string.
  String toJson() => json.encode(toMap());

  TopLeague copyWith({
    int? eventId,
    Feed? feed,
    int? feedChangeStatus,
    DateTime? feedChangeUpdateCache,
    dynamic id,
    Sport? sport,
    SportCategory? sportCategory,
    int? topLeaguesDisplayOrder,
    bool? tournamentActive,
    int? tournamentActiveEvents,
    String? tournamentDisplayName,
    int? tournamentDisplayOrder,
    int? tournamentId,
    int? tournamentUId,
  }) {
    return TopLeague(
      eventId: eventId ?? this.eventId,
      feed: feed ?? this.feed,
      feedChangeStatus: feedChangeStatus ?? this.feedChangeStatus,
      feedChangeUpdateCache:
          feedChangeUpdateCache ?? this.feedChangeUpdateCache,
      id: id ?? this.id,
      sport: sport ?? this.sport,
      sportCategory: sportCategory ?? this.sportCategory,
      topLeaguesDisplayOrder:
          topLeaguesDisplayOrder ?? this.topLeaguesDisplayOrder,
      tournamentActive: tournamentActive ?? this.tournamentActive,
      tournamentActiveEvents:
          tournamentActiveEvents ?? this.tournamentActiveEvents,
      tournamentDisplayName:
          tournamentDisplayName ?? this.tournamentDisplayName,
      tournamentDisplayOrder:
          tournamentDisplayOrder ?? this.tournamentDisplayOrder,
      tournamentId: tournamentId ?? this.tournamentId,
      tournamentUId: tournamentUId ?? this.tournamentUId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      eventId,
      feed,
      feedChangeStatus,
      feedChangeUpdateCache,
      id,
      sport,
      sportCategory,
      topLeaguesDisplayOrder,
      tournamentActive,
      tournamentActiveEvents,
      tournamentDisplayName,
      tournamentDisplayOrder,
      tournamentId,
      tournamentUId,
    ];
  }
}

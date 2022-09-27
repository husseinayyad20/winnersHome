import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'feed.dart';
import 'sport.dart';
import 'sport_category.dart';

class SportTournament extends Equatable {
  final int? tournamentId;
  final String? tournamentDisplayName;
  final int? tournamentDisplayOrder;
  final int? topLeaguesDisplayOrder;
  final bool? tournamentActive;
  final int? tournamentActiveEvents;
  final SportCategory? sportCategory;
  final int? feedChangeStatus;
  final DateTime? feedChangeUpdateCache;
  final Feed? feed;
  final Sport? sport;
  final int? eventId;
  final dynamic id;

  const SportTournament({
    this.tournamentId,
    this.tournamentDisplayName,
    this.tournamentDisplayOrder,
    this.topLeaguesDisplayOrder,
    this.tournamentActive,
    this.tournamentActiveEvents,
    this.sportCategory,
    this.feedChangeStatus,
    this.feedChangeUpdateCache,
    this.feed,
    this.sport,
    this.eventId,
    this.id,
  });

  factory SportTournament.fromMap(Map<String, dynamic> data) {
    return SportTournament(
      tournamentId: data['tournamentId'] as int?,
      tournamentDisplayName: data['tournamentDisplayName'] as String?,
      tournamentDisplayOrder: data['tournamentDisplayOrder'] as int?,
      topLeaguesDisplayOrder: data['topLeaguesDisplayOrder'] as int?,
      tournamentActive: data['tournamentActive'] as bool?,
      tournamentActiveEvents: data['tournamentActiveEvents'] as int?,
      sportCategory: data['sportCategory'] == null
          ? null
          : SportCategory.fromMap(
              data['sportCategory'] as Map<String, dynamic>),
      feedChangeStatus: data['feedChangeStatus'] as int?,
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
  }

  Map<String, dynamic> toMap() => {
        'tournamentId': tournamentId,
        'tournamentDisplayName': tournamentDisplayName,
        'tournamentDisplayOrder': tournamentDisplayOrder,
        'topLeaguesDisplayOrder': topLeaguesDisplayOrder,
        'tournamentActive': tournamentActive,
        'tournamentActiveEvents': tournamentActiveEvents,
        'sportCategory': sportCategory?.toMap(),
        'feedChangeStatus': feedChangeStatus,
        'feedChangeUpdateCache': feedChangeUpdateCache?.toIso8601String(),
        'feed': feed?.toMap(),
        'sport': sport?.toMap(),
        'eventId': eventId,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SportTournament].
  factory SportTournament.fromJson(String data) {
    return SportTournament.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SportTournament] to a JSON string.
  String toJson() => json.encode(toMap());

  SportTournament copyWith({
    int? tournamentId,
    String? tournamentDisplayName,
    int? tournamentDisplayOrder,
    int? topLeaguesDisplayOrder,
    bool? tournamentActive,
    int? tournamentActiveEvents,
    SportCategory? sportCategory,
    int? feedChangeStatus,
    DateTime? feedChangeUpdateCache,
    Feed? feed,
    Sport? sport,
    int? eventId,
    dynamic id,
  }) {
    return SportTournament(
      tournamentId: tournamentId ?? this.tournamentId,
      tournamentDisplayName:
          tournamentDisplayName ?? this.tournamentDisplayName,
      tournamentDisplayOrder:
          tournamentDisplayOrder ?? this.tournamentDisplayOrder,
      topLeaguesDisplayOrder:
          topLeaguesDisplayOrder ?? this.topLeaguesDisplayOrder,
      tournamentActive: tournamentActive ?? this.tournamentActive,
      tournamentActiveEvents:
          tournamentActiveEvents ?? this.tournamentActiveEvents,
      sportCategory: sportCategory ?? this.sportCategory,
      feedChangeStatus: feedChangeStatus ?? this.feedChangeStatus,
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
      tournamentId,
      tournamentDisplayName,
      tournamentDisplayOrder,
      topLeaguesDisplayOrder,
      tournamentActive,
      tournamentActiveEvents,
      sportCategory,
      feedChangeStatus,
      feedChangeUpdateCache,
      feed,
      sport,
      eventId,
      id,
    ];
  }
}

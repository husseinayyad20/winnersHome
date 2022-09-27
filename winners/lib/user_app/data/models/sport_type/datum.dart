import 'dart:convert';

import 'package:winners/user_app/data/models/sport_type/feed.dart';
import 'package:winners/user_app/data/models/sport_type/sport.dart';
import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final Feed? feed;
  final Sport? sport;
  final String? eventDateTime;
  final int? feedChangeStatus;
  final bool? isVirtual;

  const Datum(
      {this.feed,
      this.sport,
      this.eventDateTime,
      this.feedChangeStatus,
      this.isVirtual});

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
      feed: data['feed'] == null
          ? null
          : Feed.fromMap(data['feed'] as Map<String, dynamic>),
      sport: data['sport'] == null
          ? null
          : Sport.fromMap(data['sport'] as Map<String, dynamic>),
      eventDateTime: data['eventDateTime'] as String?,
      feedChangeStatus: data['feedChangeStatus'] as int?,
      isVirtual: data['isVirtual'] as bool?);

  Map<String, dynamic> toMap() => {
        'feed': feed?.toMap(),
        'sport': sport?.toMap(),
        'eventDateTime': eventDateTime,
        'feedChangeStatus': feedChangeStatus,
        'isVirtual': isVirtual,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    Feed? feed,
    Sport? sport,
    String? eventDateTime,
    int? feedChangeStatus,
    bool? isVirtual,
  }) {
    return Datum(
      feed: feed ?? this.feed,
      sport: sport ?? this.sport,
      eventDateTime: eventDateTime ?? this.eventDateTime,
      feedChangeStatus: feedChangeStatus ?? this.feedChangeStatus,
      isVirtual: isVirtual ?? this.isVirtual,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      feed,
      sport,
      eventDateTime,
      feedChangeStatus,
    ];
  }
}

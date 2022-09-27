import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'feed.dart';
import 'sport.dart';

class EventCategory extends Equatable {
  final int? sportCategoryId;
  final String? categoryDisplayName;
  final int? categoryDisplayOrder;
  final List<dynamic>? sportTournaments;
  final int? feedChangeStatus;
  final Feed? feed;
  final Sport? sport;
  final int? eventId;
  final dynamic id;
  final int? sportCategoryUId;

  const EventCategory({
    this.sportCategoryId,
    this.categoryDisplayName,
    this.categoryDisplayOrder,
    this.sportTournaments,
    this.feedChangeStatus,
    this.feed,
    this.sport,
    this.eventId,
    this.id,
    this.sportCategoryUId,
  });

  factory EventCategory.fromMap(Map<String, dynamic> data) => EventCategory(
        sportCategoryId: data['sportCategoryId'] as int?,
        categoryDisplayName: data['categoryDisplayName'] as String?,
        categoryDisplayOrder: data['categoryDisplayOrder'] as int?,
        sportTournaments: data['sportTournaments'] as List<dynamic>?,
        feedChangeStatus: data['feedChangeStatus'] as int?,
        sportCategoryUId: data['sportCategoryUId'] as int?,
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
        'sportCategoryId': sportCategoryId,
        'categoryDisplayName': categoryDisplayName,
        'categoryDisplayOrder': categoryDisplayOrder,
        'sportTournaments': sportTournaments,
        'feedChangeStatus': feedChangeStatus,
        'feed': feed?.toMap(),
        'sport': sport?.toMap(),
        'eventId': eventId,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EventCategory].
  factory EventCategory.fromJson(String data) {
    return EventCategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EventCategory] to a JSON string.
  String toJson() => json.encode(toMap());

  EventCategory copyWith({
    int? sportCategoryId,
    String? categoryDisplayName,
    int? categoryDisplayOrder,
    List<dynamic>? sportTournaments,
    int? feedChangeStatus,
    Feed? feed,
    Sport? sport,
    int? eventId,
    dynamic id,
  }) {
    return EventCategory(
      sportCategoryId: sportCategoryId ?? this.sportCategoryId,
      categoryDisplayName: categoryDisplayName ?? this.categoryDisplayName,
      categoryDisplayOrder: categoryDisplayOrder ?? this.categoryDisplayOrder,
      sportTournaments: sportTournaments ?? this.sportTournaments,
      feedChangeStatus: feedChangeStatus ?? this.feedChangeStatus,
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
      sportCategoryId,
      categoryDisplayName,
      categoryDisplayOrder,
      sportTournaments,
      feedChangeStatus,
      feed,
      sport,
      eventId,
      id,
    ];
  }
}

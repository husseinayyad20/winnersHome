import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'feed.dart';
import 'sport.dart';

class SportCategory extends Equatable {
  final String? categoryDisplayName;
  final int? categoryDisplayOrder;
  final int? eventId;
  final Feed? feed;
  final int? feedChangeStatus;
  final dynamic id;
  final Sport? sport;
  final int? sportCategoryId;
  final int? sportCategoryUId;
  final List<dynamic>? sportTournaments;

  const SportCategory({
    this.categoryDisplayName,
    this.categoryDisplayOrder,
    this.eventId,
    this.feed,
    this.feedChangeStatus,
    this.id,
    this.sport,
    this.sportCategoryId,
    this.sportCategoryUId,
    this.sportTournaments,
  });

  factory SportCategory.fromMap(Map<String, dynamic> data) => SportCategory(
        categoryDisplayName: data['categoryDisplayName'] as String?,
        categoryDisplayOrder: data['categoryDisplayOrder'] as int?,
        eventId: data['eventId'] as int?,
        feed: data['feed'] == null
            ? null
            : Feed.fromMap(data['feed'] as Map<String, dynamic>),
        feedChangeStatus: data['feedChangeStatus'] as int?,
        id: data['id'] as dynamic,
        sport: data['sport'] == null
            ? null
            : Sport.fromMap(data['sport'] as Map<String, dynamic>),
        sportCategoryId: data['sportCategoryId'] as int?,
        sportCategoryUId: data['sportCategoryUId'] as int?,
        sportTournaments: data['sportTournaments'] as List<dynamic>?,
      );

  Map<String, dynamic> toMap() => {
        'categoryDisplayName': categoryDisplayName,
        'categoryDisplayOrder': categoryDisplayOrder,
        'eventId': eventId,
        'feed': feed?.toMap(),
        'feedChangeStatus': feedChangeStatus,
        'id': id,
        'sport': sport?.toMap(),
        'sportCategoryId': sportCategoryId,
        'sportCategoryUId': sportCategoryUId,
        'sportTournaments': sportTournaments,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SportCategory].
  factory SportCategory.fromJson(String data) {
    return SportCategory.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SportCategory] to a JSON string.
  String toJson() => json.encode(toMap());

  SportCategory copyWith({
    String? categoryDisplayName,
    int? categoryDisplayOrder,
    int? eventId,
    Feed? feed,
    int? feedChangeStatus,
    dynamic id,
    Sport? sport,
    int? sportCategoryId,
    int? sportCategoryUId,
    List<dynamic>? sportTournaments,
  }) {
    return SportCategory(
      categoryDisplayName: categoryDisplayName ?? this.categoryDisplayName,
      categoryDisplayOrder: categoryDisplayOrder ?? this.categoryDisplayOrder,
      eventId: eventId ?? this.eventId,
      feed: feed ?? this.feed,
      feedChangeStatus: feedChangeStatus ?? this.feedChangeStatus,
      id: id ?? this.id,
      sport: sport ?? this.sport,
      sportCategoryId: sportCategoryId ?? this.sportCategoryId,
      sportCategoryUId: sportCategoryUId ?? this.sportCategoryUId,
      sportTournaments: sportTournaments ?? this.sportTournaments,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      categoryDisplayName,
      categoryDisplayOrder,
      eventId,
      feed,
      feedChangeStatus,
      id,
      sport,
      sportCategoryId,
      sportCategoryUId,
      sportTournaments,
    ];
  }
}

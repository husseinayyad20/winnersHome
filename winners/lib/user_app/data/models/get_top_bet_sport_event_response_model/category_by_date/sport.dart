import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final int? sportId;
  final dynamic sportDisplayName;
  final int? sportOrder;
  final dynamic key;
  final int? feedId;
  final dynamic feedName;
  final dynamic id;

  const Sport({
    this.sportId,
    this.sportDisplayName,
    this.sportOrder,
    this.key,
    this.feedId,
    this.feedName,
    this.id,
  });

  factory Sport.fromMap(Map<String, dynamic> data) => Sport(
        sportId: data['sportId'] as int?,
        sportDisplayName: data['sportDisplayName'] as dynamic,
        sportOrder: data['sportOrder'] as int?,
        key: data['key'] as dynamic,
        feedId: data['feedId'] as int?,
        feedName: data['feedName'] as dynamic,
        id: data['id'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'sportId': sportId,
        'sportDisplayName': sportDisplayName,
        'sportOrder': sportOrder,
        'key': key,
        'feedId': feedId,
        'feedName': feedName,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Sport].
  factory Sport.fromJson(String data) {
    return Sport.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Sport] to a JSON string.
  String toJson() => json.encode(toMap());

  Sport copyWith({
    int? sportId,
    dynamic sportDisplayName,
    int? sportOrder,
    dynamic key,
    int? feedId,
    dynamic feedName,
    dynamic id,
  }) {
    return Sport(
      sportId: sportId ?? this.sportId,
      sportDisplayName: sportDisplayName ?? this.sportDisplayName,
      sportOrder: sportOrder ?? this.sportOrder,
      key: key ?? this.key,
      feedId: feedId ?? this.feedId,
      feedName: feedName ?? this.feedName,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      sportId,
      sportDisplayName,
      sportOrder,
      key,
      feedId,
      feedName,
      id,
    ];
  }
}

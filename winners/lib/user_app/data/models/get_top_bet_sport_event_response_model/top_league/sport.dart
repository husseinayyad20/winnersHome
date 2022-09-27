import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final int? feedId;
  final dynamic feedName;
  final dynamic id;
  final dynamic key;
  final String? sportDisplayName;
  final int? sportId;
  final int? sportOrder;

  const Sport({
    this.feedId,
    this.feedName,
    this.id,
    this.key,
    this.sportDisplayName,
    this.sportId,
    this.sportOrder,
  });

  factory Sport.fromMap(Map<String, dynamic> data) => Sport(
        feedId: data['feedId'] as int?,
        feedName: data['feedName'] as dynamic,
        id: data['id'] as dynamic,
        key: data['key'] as dynamic,
        sportDisplayName: data['sportDisplayName'] as String?,
        sportId: data['sportId'] as int?,
        sportOrder: data['sportOrder'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'feedId': feedId,
        'feedName': feedName,
        'id': id,
        'key': key,
        'sportDisplayName': sportDisplayName,
        'sportId': sportId,
        'sportOrder': sportOrder,
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
    int? feedId,
    dynamic feedName,
    dynamic id,
    dynamic key,
    String? sportDisplayName,
    int? sportId,
    int? sportOrder,
  }) {
    return Sport(
      feedId: feedId ?? this.feedId,
      feedName: feedName ?? this.feedName,
      id: id ?? this.id,
      key: key ?? this.key,
      sportDisplayName: sportDisplayName ?? this.sportDisplayName,
      sportId: sportId ?? this.sportId,
      sportOrder: sportOrder ?? this.sportOrder,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      feedId,
      feedName,
      id,
      key,
      sportDisplayName,
      sportId,
      sportOrder,
    ];
  }
}

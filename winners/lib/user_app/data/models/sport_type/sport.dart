import 'dart:convert';

import 'package:equatable/equatable.dart';

class Sport extends Equatable {
  final int? sportId;
  final String? sportDisplayName;
  final int? sportOrder;
  final int? feedId;

  const Sport({
    this.sportId,
    this.sportDisplayName,
    this.sportOrder,
    this.feedId,
  });

  factory Sport.fromMap(Map<String, dynamic> data) => Sport(
        sportId: data['sportId'] as int?,
        sportDisplayName: data['sportDisplayName'] as String?,
        sportOrder: data['sportOrder'] as int?,
        feedId: data['feedId'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'sportId': sportId,
        'sportDisplayName': sportDisplayName,
        'sportOrder': sportOrder,
        'feedId': feedId,
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
    String? sportDisplayName,
    int? sportOrder,
    int? feedId,
  }) {
    return Sport(
      sportId: sportId ?? this.sportId,
      sportDisplayName: sportDisplayName ?? this.sportDisplayName,
      sportOrder: sportOrder ?? this.sportOrder,
      feedId: feedId ?? this.feedId,
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
      feedId,
    ];
  }
}

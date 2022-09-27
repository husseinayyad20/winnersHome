import 'dart:convert';

import 'package:equatable/equatable.dart';

class Feed extends Equatable {
  final int? feedId;

  const Feed({this.feedId});

  factory Feed.fromMap(Map<String, dynamic> data) => Feed(
        feedId: data['feedId'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'feedId': feedId,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Feed].
  factory Feed.fromJson(String data) {
    return Feed.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Feed] to a JSON string.
  String toJson() => json.encode(toMap());

  Feed copyWith({
    int? feedId,
  }) {
    return Feed(
      feedId: feedId ?? this.feedId,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [feedId];
}

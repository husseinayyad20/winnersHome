import 'dart:convert';

import 'package:equatable/equatable.dart';

class Feed extends Equatable {
  final int? feedId;
  final dynamic feedName;
  final dynamic id;

  const Feed({this.feedId, this.feedName, this.id});

  factory Feed.fromMap(Map<String, dynamic> data) => Feed(
        feedId: data['feedId'] as int?,
        feedName: data['feedName'] as dynamic,
        id: data['id'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'feedId': feedId,
        'feedName': feedName,
        'id': id,
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
    dynamic feedName,
    dynamic id,
  }) {
    return Feed(
      feedId: feedId ?? this.feedId,
      feedName: feedName ?? this.feedName,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [feedId, feedName, id];
}

import 'package:equatable/equatable.dart';

class Feed extends Equatable {
  final int? feedId;
  final dynamic feedName;
  final dynamic id;

  const Feed({this.feedId, this.feedName, this.id});

  factory Feed.fromJson(Map<String, dynamic> json) => Feed(
        feedId: json['feedId'] as int?,
        feedName: json['feedName'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'feedId': feedId,
        'feedName': feedName,
        'id': id,
      };

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

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

  factory Sport.fromJson(Map<String, dynamic> json) => Sport(
        sportId: json['sportId'] as int?,
        sportDisplayName: json['sportDisplayName'],
        sportOrder: json['sportOrder'] as int?,
        key: json['key'],
        feedId: json['feedId'] as int?,
        feedName: json['feedName'],
        id: json['id'],
      );

  Map<String, dynamic> toJson() => {
        'sportId': sportId,
        'sportDisplayName': sportDisplayName,
        'sportOrder': sportOrder,
        'key': key,
        'feedId': feedId,
        'feedName': feedName,
        'id': id,
      };

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

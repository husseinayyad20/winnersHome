import 'dart:convert';

import 'package:equatable/equatable.dart';

class BetsRestriction extends Equatable {
  final int? feedId;
  final int? sportId;
  final int? betTypeId1;
  final int? betTypeId2;
  final bool? isAllowed;
  final int? id;
  final dynamic name;

  const BetsRestriction({
    this.feedId,
    this.sportId,
    this.betTypeId1,
    this.betTypeId2,
    this.isAllowed,
    this.id,
    this.name,
  });

  factory BetsRestriction.fromMap(Map<String, dynamic> data) {
    return BetsRestriction(
      feedId: data['feedId'] as int?,
      sportId: data['sportId'] as int?,
      betTypeId1: data['betTypeId1'] as int?,
      betTypeId2: data['betTypeId2'] as int?,
      isAllowed: data['isAllowed'] as bool?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'feedId': feedId,
        'sportId': sportId,
        'betTypeId1': betTypeId1,
        'betTypeId2': betTypeId2,
        'isAllowed': isAllowed,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetsRestriction].
  factory BetsRestriction.fromJson(String data) {
    return BetsRestriction.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetsRestriction] to a JSON string.
  String toJson() => json.encode(toMap());

  BetsRestriction copyWith({
    int? feedId,
    int? sportId,
    int? betTypeId1,
    int? betTypeId2,
    bool? isAllowed,
    int? id,
    dynamic name,
  }) {
    return BetsRestriction(
      feedId: feedId ?? this.feedId,
      sportId: sportId ?? this.sportId,
      betTypeId1: betTypeId1 ?? this.betTypeId1,
      betTypeId2: betTypeId2 ?? this.betTypeId2,
      isAllowed: isAllowed ?? this.isAllowed,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      feedId,
      sportId,
      betTypeId1,
      betTypeId2,
      isAllowed,
      id,
      name,
    ];
  }
}

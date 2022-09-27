import 'dart:convert';

import 'package:equatable/equatable.dart';

class BetType extends Equatable {
  final dynamic feed;
  final dynamic sport;
  final int? betTypeId;
  final String? betTypeName;
  final int? betTypeGroupId;
  final String? betTypeGroupName;
  final int? betTypeDisplayOrder;
  final String? betTypeDrillDownGroupName;
  final int? betTypeDrillDownGroupId;
  final int? betTypeDrillDownDisplayOrder;
  final dynamic id;

  const BetType({
    this.feed,
    this.sport,
    this.betTypeId,
    this.betTypeName,
    this.betTypeGroupId,
    this.betTypeGroupName,
    this.betTypeDisplayOrder,
    this.betTypeDrillDownGroupName,
    this.betTypeDrillDownGroupId,
    this.betTypeDrillDownDisplayOrder,
    this.id,
  });

  factory BetType.fromMap(Map<String, dynamic> data) => BetType(
        feed: data['feed'] as dynamic,
        sport: data['sport'] as dynamic,
        betTypeId: data['betTypeId'] as int?,
        betTypeName: data['betTypeName'] as String?,
        betTypeGroupId: data['betTypeGroupId'] as int?,
        betTypeGroupName: data['betTypeGroupName'] as String?,
        betTypeDisplayOrder: data['betTypeDisplayOrder'] as int?,
        betTypeDrillDownGroupName: data['betTypeDrillDownGroupName'] as String?,
        betTypeDrillDownGroupId: data['betTypeDrillDownGroupId'] as int?,
        betTypeDrillDownDisplayOrder:
            data['betTypeDrillDownDisplayOrder'] as int?,
        id: data['id'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'feed': feed,
        'sport': sport,
        'betTypeId': betTypeId,
        'betTypeName': betTypeName,
        'betTypeGroupId': betTypeGroupId,
        'betTypeGroupName': betTypeGroupName,
        'betTypeDisplayOrder': betTypeDisplayOrder,
        'betTypeDrillDownGroupName': betTypeDrillDownGroupName,
        'betTypeDrillDownGroupId': betTypeDrillDownGroupId,
        'betTypeDrillDownDisplayOrder': betTypeDrillDownDisplayOrder,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetType].
  factory BetType.fromJson(String data) {
    return BetType.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetType] to a JSON string.
  String toJson() => json.encode(toMap());

  BetType copyWith({
    dynamic feed,
    dynamic sport,
    int? betTypeId,
    String? betTypeName,
    int? betTypeGroupId,
    String? betTypeGroupName,
    int? betTypeDisplayOrder,
    String? betTypeDrillDownGroupName,
    int? betTypeDrillDownGroupId,
    int? betTypeDrillDownDisplayOrder,
    dynamic id,
  }) {
    return BetType(
      feed: feed ?? this.feed,
      sport: sport ?? this.sport,
      betTypeId: betTypeId ?? this.betTypeId,
      betTypeName: betTypeName ?? this.betTypeName,
      betTypeGroupId: betTypeGroupId ?? this.betTypeGroupId,
      betTypeGroupName: betTypeGroupName ?? this.betTypeGroupName,
      betTypeDisplayOrder: betTypeDisplayOrder ?? this.betTypeDisplayOrder,
      betTypeDrillDownGroupName:
          betTypeDrillDownGroupName ?? this.betTypeDrillDownGroupName,
      betTypeDrillDownGroupId:
          betTypeDrillDownGroupId ?? this.betTypeDrillDownGroupId,
      betTypeDrillDownDisplayOrder:
          betTypeDrillDownDisplayOrder ?? this.betTypeDrillDownDisplayOrder,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      feed,
      sport,
      betTypeId,
      betTypeName,
      betTypeGroupId,
      betTypeGroupName,
      betTypeDisplayOrder,
      betTypeDrillDownGroupName,
      betTypeDrillDownGroupId,
      betTypeDrillDownDisplayOrder,
      id,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class BetSlipSportTypesIcon extends Equatable {
  final int? betSlipSportIconsId;
  final int? typeId;
  final String? betSlipSportIconsName;
  final int? id;
  final dynamic name;

  const BetSlipSportTypesIcon({
    this.betSlipSportIconsId,
    this.typeId,
    this.betSlipSportIconsName,
    this.id,
    this.name,
  });

  factory BetSlipSportTypesIcon.fromMap(Map<String, dynamic> data) {
    return BetSlipSportTypesIcon(
      betSlipSportIconsId: data['betSlipSportIconsID'] as int?,
      typeId: data['typeID'] as int?,
      betSlipSportIconsName: data['betSlipSportIconsName'] as String?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'betSlipSportIconsID': betSlipSportIconsId,
        'typeID': typeId,
        'betSlipSportIconsName': betSlipSportIconsName,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetSlipSportTypesIcon].
  factory BetSlipSportTypesIcon.fromJson(String data) {
    return BetSlipSportTypesIcon.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetSlipSportTypesIcon] to a JSON string.
  String toJson() => json.encode(toMap());

  BetSlipSportTypesIcon copyWith({
    int? betSlipSportIconsId,
    int? typeId,
    String? betSlipSportIconsName,
    int? id,
    dynamic name,
  }) {
    return BetSlipSportTypesIcon(
      betSlipSportIconsId: betSlipSportIconsId ?? this.betSlipSportIconsId,
      typeId: typeId ?? this.typeId,
      betSlipSportIconsName:
          betSlipSportIconsName ?? this.betSlipSportIconsName,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      betSlipSportIconsId,
      typeId,
      betSlipSportIconsName,
      id,
      name,
    ];
  }
}

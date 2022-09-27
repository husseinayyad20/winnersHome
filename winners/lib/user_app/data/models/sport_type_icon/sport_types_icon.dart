import 'dart:convert';

import 'package:equatable/equatable.dart';

class SportTypesIcon extends Equatable {
  final int? sportTypesIconsId;
  final int? typeId;
  final String? sportTypesIconsName;
  final int? id;
  final dynamic name;

  const SportTypesIcon({
    this.sportTypesIconsId,
    this.typeId,
    this.sportTypesIconsName,
    this.id,
    this.name,
  });

  factory SportTypesIcon.fromMap(Map<String, dynamic> data) {
    return SportTypesIcon(
      sportTypesIconsId: data['sportTypesIconsID'] as int?,
      typeId: data['typeID'] as int?,
      sportTypesIconsName: data['sportTypesIconsName'] as String?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'sportTypesIconsID': sportTypesIconsId,
        'typeID': typeId,
        'sportTypesIconsName': sportTypesIconsName,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SportTypesIcon].
  factory SportTypesIcon.fromJson(String data) {
    return SportTypesIcon.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SportTypesIcon] to a JSON string.
  String toJson() => json.encode(toMap());

  SportTypesIcon copyWith({
    int? sportTypesIconsId,
    int? typeId,
    String? sportTypesIconsName,
    int? id,
    dynamic name,
  }) {
    return SportTypesIcon(
      sportTypesIconsId: sportTypesIconsId ?? this.sportTypesIconsId,
      typeId: typeId ?? this.typeId,
      sportTypesIconsName: sportTypesIconsName ?? this.sportTypesIconsName,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      sportTypesIconsId,
      typeId,
      sportTypesIconsName,
      id,
      name,
    ];
  }
}

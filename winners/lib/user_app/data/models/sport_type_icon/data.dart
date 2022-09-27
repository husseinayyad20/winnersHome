import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sport_types_icon.dart';

class Data extends Equatable {
  final List<SportTypesIcon>? sportTypesIcons;
  final int? id;
  final dynamic name;

  const Data({this.sportTypesIcons, this.id, this.name});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        sportTypesIcons: (data['sportTypesIcons'] as List<dynamic>?)
            ?.map((e) => SportTypesIcon.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'sportTypesIcons': sportTypesIcons?.map((e) => e.toMap()).toList(),
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    List<SportTypesIcon>? sportTypesIcons,
    int? id,
    dynamic name,
  }) {
    return Data(
      sportTypesIcons: sportTypesIcons ?? this.sportTypesIcons,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [sportTypesIcons, id, name];
}

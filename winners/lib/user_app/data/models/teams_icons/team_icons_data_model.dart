import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'teams_icon.dart';

class TeamsIconsDataModel extends Equatable {
  final List<TeamsIconModel>? teamsIcons;
  final int? id;
  final dynamic name;

  const TeamsIconsDataModel({this.teamsIcons, this.id, this.name});

  factory TeamsIconsDataModel.fromMap(Map<String, dynamic> data) =>
      TeamsIconsDataModel(
        teamsIcons: (data['teamsIcons'] as List<dynamic>?)
            ?.map((e) => TeamsIconModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'teamsIcons': teamsIcons?.map((e) => e.toMap()).toList(),
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TeamsIconsDataModel].
  factory TeamsIconsDataModel.fromJson(String data) {
    return TeamsIconsDataModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TeamsIconsDataModel] to a JSON string.
  String toJson() => json.encode(toMap());

  TeamsIconsDataModel copyWith({
    List<TeamsIconModel>? teamsIcons,
    int? id,
    dynamic name,
  }) {
    return TeamsIconsDataModel(
      teamsIcons: teamsIcons ?? this.teamsIcons,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [teamsIcons, id, name];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'header_tab.dart';

class HeaderModelData extends Equatable {
  final List<HeaderTabModel>? headerTabs;
  final int? id;
  final dynamic name;

  const HeaderModelData({this.headerTabs, this.id, this.name});

  factory HeaderModelData.fromMap(Map<String, dynamic> data) => HeaderModelData(
        headerTabs: (data['headerTabs'] as List<dynamic>?)
            ?.map((e) => HeaderTabModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'headerTabs': headerTabs?.map((e) => e.toMap()).toList(),
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HeaderModelData].
  factory HeaderModelData.fromJson(String data) {
    return HeaderModelData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HeaderModelData] to a JSON string.
  String toJson() => json.encode(toMap());

  HeaderModelData copyWith({
    List<HeaderTabModel>? headerTabs,
    int? id,
    dynamic name,
  }) {
    return HeaderModelData(
      headerTabs: headerTabs ?? this.headerTabs,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [headerTabs, id, name];
}

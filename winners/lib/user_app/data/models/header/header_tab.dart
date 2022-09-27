import 'dart:convert';

import 'package:equatable/equatable.dart';

class HeaderTabModel extends Equatable {
  final int? headerTabsId;
  final String? headerTabsName;
  final bool? active;
  final int? id;
  final dynamic name;

  const HeaderTabModel({
    this.headerTabsId,
    this.headerTabsName,
    this.active,
    this.id,
    this.name,
  });

  factory HeaderTabModel.fromMap(Map<String, dynamic> data) => HeaderTabModel(
        headerTabsId: data['headerTabsID'] as int?,
        headerTabsName: data['headerTabsName'] as String?,
        active: data['active'] as bool?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'headerTabsID': headerTabsId,
        'headerTabsName': headerTabsName,
        'active': active,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HeaderTabModel].
  factory HeaderTabModel.fromJson(String data) {
    return HeaderTabModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HeaderTabModel] to a JSON string.
  String toJson() => json.encode(toMap());

  HeaderTabModel copyWith({
    int? headerTabsId,
    String? headerTabsName,
    bool? active,
    int? id,
    dynamic name,
  }) {
    return HeaderTabModel(
      headerTabsId: headerTabsId ?? this.headerTabsId,
      headerTabsName: headerTabsName ?? this.headerTabsName,
      active: active ?? this.active,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      headerTabsId,
      headerTabsName,
      active,
      id,
      name,
    ];
  }
}

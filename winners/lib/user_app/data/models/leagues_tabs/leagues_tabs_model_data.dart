import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sport_top_leagues_tab.dart';

class LeaguesTabsModelData extends Equatable {
  final List<LeaguesTab>? sportTopLeaguesTab;
  final int? id;
  final dynamic name;

  const LeaguesTabsModelData({this.sportTopLeaguesTab, this.id, this.name});

  factory LeaguesTabsModelData.fromMap(Map<String, dynamic> data) =>
      LeaguesTabsModelData(
        sportTopLeaguesTab: (data['sportTopLeaguesTab'] as List<dynamic>?)
            ?.map((e) => LeaguesTab.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'sportTopLeaguesTab':
            sportTopLeaguesTab?.map((e) => e.toMap()).toList(),
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LeaguesTabsModelData].
  factory LeaguesTabsModelData.fromJson(String data) {
    return LeaguesTabsModelData.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LeaguesTabsModelData] to a JSON string.
  String toJson() => json.encode(toMap());

  LeaguesTabsModelData copyWith({
    List<LeaguesTab>? sportTopLeaguesTab,
    int? id,
    dynamic name,
  }) {
    return LeaguesTabsModelData(
      sportTopLeaguesTab: sportTopLeaguesTab ?? this.sportTopLeaguesTab,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [sportTopLeaguesTab, id, name];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class LeaguesTab extends Equatable {
  final int? preMatchTopLeaguesTabId;
  final String? sportTopLeaguesTabName;
  final bool? disable;
  final int? tournamnetUId;
  final int? liveTopLeaguesTabId;
  final int? id;
  final dynamic name;

  const LeaguesTab({
    this.preMatchTopLeaguesTabId,
    this.sportTopLeaguesTabName,
    this.disable,
    this.tournamnetUId,
    this.liveTopLeaguesTabId,
    this.id,
    this.name,
  });

  factory LeaguesTab.fromMap(Map<String, dynamic> data) {
    return LeaguesTab(
      preMatchTopLeaguesTabId: data['preMatchTopLeaguesTabID'] as int?,
      sportTopLeaguesTabName: data['sportTopLeaguesTabName'] as String?,
      disable: data['disable'] as bool?,
      tournamnetUId: data['tournamnetUId'] as int?,
      liveTopLeaguesTabId: data['liveTopLeaguesTabID'] as int?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'preMatchTopLeaguesTabID': preMatchTopLeaguesTabId,
        'sportTopLeaguesTabName': sportTopLeaguesTabName,
        'disable': disable,
        'tournamnetUId': tournamnetUId,
        'liveTopLeaguesTabID': liveTopLeaguesTabId,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [LeaguesTab].
  factory LeaguesTab.fromJson(String data) {
    return LeaguesTab.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LeaguesTab] to a JSON string.
  String toJson() => json.encode(toMap());

  LeaguesTab copyWith({
    int? preMatchTopLeaguesTabId,
    String? sportTopLeaguesTabName,
    bool? disable,
    int? tournamnetUId,
    int? liveTopLeaguesTabId,
    int? id,
    dynamic name,
  }) {
    return LeaguesTab(
      preMatchTopLeaguesTabId:
          preMatchTopLeaguesTabId ?? this.preMatchTopLeaguesTabId,
      sportTopLeaguesTabName:
          sportTopLeaguesTabName ?? this.sportTopLeaguesTabName,
      disable: disable ?? this.disable,
      tournamnetUId: tournamnetUId ?? this.tournamnetUId,
      liveTopLeaguesTabId: liveTopLeaguesTabId ?? this.liveTopLeaguesTabId,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      preMatchTopLeaguesTabId,
      sportTopLeaguesTabName,
      disable,
      tournamnetUId,
      liveTopLeaguesTabId,
      id,
      name,
    ];
  }
}

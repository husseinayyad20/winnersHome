import 'dart:convert';

import 'package:equatable/equatable.dart';

class TeamsIconModel extends Equatable {
  final int? feedId;
  final int? sportId;
  final int? teamId;
  final String? smallPath;
  final String? mediumPath;
  final String? bigPath;
  final int? id;
  final dynamic name;

  const TeamsIconModel({
    this.feedId,
    this.sportId,
    this.teamId,
    this.smallPath,
    this.mediumPath,
    this.bigPath,
    this.id,
    this.name,
  });

  factory TeamsIconModel.fromMap(Map<String, dynamic> data) => TeamsIconModel(
        feedId: data['feedId'] as int?,
        sportId: data['sportId'] as int?,
        teamId: data['teamId'] as int?,
        smallPath: data['smallPath'] as String?,
        mediumPath: data['mediumPath'] as String?,
        bigPath: data['bigPath'] as String?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'feedId': feedId,
        'sportId': sportId,
        'teamId': teamId,
        'smallPath': smallPath,
        'mediumPath': mediumPath,
        'bigPath': bigPath,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TeamsIconModel].
  factory TeamsIconModel.fromJson(String data) {
    return TeamsIconModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TeamsIconModel] to a JSON string.
  String toJson() => json.encode(toMap());

  TeamsIconModel copyWith({
    int? feedId,
    int? sportId,
    int? teamId,
    String? smallPath,
    String? mediumPath,
    String? bigPath,
    int? id,
    dynamic name,
  }) {
    return TeamsIconModel(
      feedId: feedId ?? this.feedId,
      sportId: sportId ?? this.sportId,
      teamId: teamId ?? this.teamId,
      smallPath: smallPath ?? this.smallPath,
      mediumPath: mediumPath ?? this.mediumPath,
      bigPath: bigPath ?? this.bigPath,
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
      teamId,
      smallPath,
      mediumPath,
      bigPath,
      id,
      name,
    ];
  }
}

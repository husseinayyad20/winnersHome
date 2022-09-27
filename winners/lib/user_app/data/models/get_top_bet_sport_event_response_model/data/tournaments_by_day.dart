import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sport_tournament.dart';

class TournamentsByDay extends Equatable {
  final int? day;
  final List<SportTournament>? sportTournaments;
  final List<dynamic>? sportTopLeagues;
  final dynamic id;

  const TournamentsByDay({
    this.day,
    this.sportTournaments,
    this.sportTopLeagues,
    this.id,
  });

  factory TournamentsByDay.fromMap(Map<String, dynamic> data) {
    return TournamentsByDay(
      day: data['day'] as int?,
      sportTournaments: (data['sportTournaments'] as List<dynamic>?)
          ?.map((e) => SportTournament.fromMap(e as Map<String, dynamic>))
          .toList(),
      sportTopLeagues: data['sportTopLeagues'] as List<dynamic>?,
      id: data['id'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'day': day,
        'sportTournaments': sportTournaments?.map((e) => e.toMap()).toList(),
        'sportTopLeagues': sportTopLeagues,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TournamentsByDay].
  factory TournamentsByDay.fromJson(String data) {
    return TournamentsByDay.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TournamentsByDay] to a JSON string.
  String toJson() => json.encode(toMap());

  TournamentsByDay copyWith({
    int? day,
    List<SportTournament>? sportTournaments,
    List<dynamic>? sportTopLeagues,
    dynamic id,
  }) {
    return TournamentsByDay(
      day: day ?? this.day,
      sportTournaments: sportTournaments ?? this.sportTournaments,
      sportTopLeagues: sportTopLeagues ?? this.sportTopLeagues,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [day, sportTournaments, sportTopLeagues, id];
}

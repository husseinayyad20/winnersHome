// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sport_top_league.dart';

class TournamentByDay extends Equatable {
  final int? day;
  final List<SportTopLeague>? sportTournaments;
  final List<SportTopLeague>? sportTopLeagues;
  final dynamic id;
  bool isExpanded;

  TournamentByDay({
    this.day,
    this.sportTournaments,
    this.sportTopLeagues,
    this.id,
    this.isExpanded = false,
  });

  factory TournamentByDay.fromMap(Map<String, dynamic> data) {
    return TournamentByDay(
      day: data['day'] as int?,
      sportTournaments: (data['sportTournaments'] as List<dynamic>?)
          ?.map((e) => SportTopLeague.fromMap(e as Map<String, dynamic>))
          .toList(),
      sportTopLeagues: (data['sportTopLeagues'] as List<dynamic>?)
          ?.map((e) => SportTopLeague.fromMap(e as Map<String, dynamic>))
          .toList(),
      id: data['id'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'day': day,
        'sportTournaments': sportTournaments,
        'sportTopLeagues': sportTopLeagues?.map((e) => e.toMap()).toList(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TournamentByDay].
  factory TournamentByDay.fromJson(String data) {
    return TournamentByDay.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TournamentByDay] to a JSON string.
  String toJson() => json.encode(toMap());

  TournamentByDay copyWith({
    int? day,
    List<SportTopLeague>? sportTournaments,
    List<SportTopLeague>? sportTopLeagues,
    dynamic id,
  }) {
    return TournamentByDay(
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

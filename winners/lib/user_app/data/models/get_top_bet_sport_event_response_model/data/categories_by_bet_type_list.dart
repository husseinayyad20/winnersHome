// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/tournament_by_day/tournament_by_day.dart';
import 'package:equatable/equatable.dart';

class CategoriesByBetTypeList extends Equatable {
  final int? eventsCount;
  final String? categoryName;
  final int? categoryUId;
  final int? categoryOrderId;
  final List<TournamentByDay>? tournamentsByDays;
  final dynamic id;
  bool isExpanded = false;

  CategoriesByBetTypeList({
    this.eventsCount,
    this.categoryName,
    this.categoryUId,
    this.categoryOrderId,
    this.tournamentsByDays,
    this.id,
    this.isExpanded = false,
  });

  factory CategoriesByBetTypeList.fromMap(Map<String, dynamic> data) {
    return CategoriesByBetTypeList(
      isExpanded: false,
      eventsCount: data['eventsCount'] as int?,
      categoryName: data['categoryName'] as String?,
      categoryUId: data['categoryUId'] as int?,
      categoryOrderId: data['categoryOrderId'] as int?,
      tournamentsByDays: (data['tournamentsByDays'] as List<dynamic>?)
          ?.map((e) => TournamentByDay.fromMap(e as Map<String, dynamic>))
          .toList(),
      id: data['id'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'eventsCount': eventsCount,
        'categoryName': categoryName,
        'categoryUId': categoryUId,
        'categoryOrderId': categoryOrderId,
        'tournamentsByDays': tournamentsByDays?.map((e) => e.toMap()).toList(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CategoriesByBetTypeList].
  factory CategoriesByBetTypeList.fromJson(String data) {
    return CategoriesByBetTypeList.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CategoriesByBetTypeList] to a JSON string.
  String toJson() => json.encode(toMap());

  CategoriesByBetTypeList copyWith({
    int? eventsCount,
    String? categoryName,
    int? categoryUId,
    int? categoryOrderId,
    List<TournamentByDay>? tournamentsByDays,
    dynamic id,
  }) {
    return CategoriesByBetTypeList(
      eventsCount: eventsCount ?? this.eventsCount,
      categoryName: categoryName ?? this.categoryName,
      categoryUId: categoryUId ?? this.categoryUId,
      categoryOrderId: categoryOrderId ?? this.categoryOrderId,
      tournamentsByDays: tournamentsByDays ?? this.tournamentsByDays,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      eventsCount,
      categoryName,
      categoryUId,
      categoryOrderId,
      tournamentsByDays,
      id,
    ];
  }
}

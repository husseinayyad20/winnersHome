// ignore_for_file: must_be_immutable

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sport_tournament.dart';

class CategoryByDate extends Equatable {
  final int? eventsCount;
  final String? categoryName;
  final int? categoryUId;
  final int? categoryOrderId;
  final List<SportTournament>? sportTournaments;
  final dynamic id;
  bool isExpanded = false;

  CategoryByDate({
    this.eventsCount,
    this.categoryName,
    this.categoryUId,
    this.categoryOrderId,
    this.sportTournaments,
    this.id,
    this.isExpanded = false,
  });

  factory CategoryByDate.fromMap(Map<String, dynamic> data) {
    return CategoryByDate(
      eventsCount: data['eventsCount'] as int?,
      categoryName: data['categoryName'] as String?,
      categoryUId: data['categoryUId'] as int?,
      categoryOrderId: data['categoryOrderId'] as int?,
      sportTournaments: (data['sportTournaments'] as List<dynamic>?)
          ?.map((e) => SportTournament.fromMap(e as Map<String, dynamic>))
          .toList(),
      id: data['id'] as dynamic,
      isExpanded: false,
    );
  }

  Map<String, dynamic> toMap() => {
        'eventsCount': eventsCount,
        'categoryName': categoryName,
        'categoryUId': categoryUId,
        'categoryOrderId': categoryOrderId,
        'sportTournaments': sportTournaments?.map((e) => e.toMap()).toList(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CategoryByDate].
  factory CategoryByDate.fromJson(String data) {
    return CategoryByDate.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CategoryByDate] to a JSON string.
  String toJson() => json.encode(toMap());

  CategoryByDate copyWith({
    int? eventsCount,
    String? categoryName,
    int? categoryUId,
    int? categoryOrderId,
    List<SportTournament>? sportTournaments,
    dynamic id,
  }) {
    return CategoryByDate(
      eventsCount: eventsCount ?? this.eventsCount,
      categoryName: categoryName ?? this.categoryName,
      categoryUId: categoryUId ?? this.categoryUId,
      categoryOrderId: categoryOrderId ?? this.categoryOrderId,
      sportTournaments: sportTournaments ?? this.sportTournaments,
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
      sportTournaments,
      id,
    ];
  }
}

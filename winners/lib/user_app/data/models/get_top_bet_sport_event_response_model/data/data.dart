import 'dart:convert';

import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/category_by_date/category_by_date.dart';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/tournament_by_day/tournament_by_day.dart';
import 'package:equatable/equatable.dart';

import 'categories_by_bet_type_list.dart';

class TopBetSportData extends Equatable {
  final List<CategoriesByBetTypeList>? categoriesByBetTypeList;
  final List<CategoryByDate>? categoriesByDateList;
  final List<TournamentByDay>? tournamentsByDayList;

  const TopBetSportData({
    this.categoriesByBetTypeList,
    this.categoriesByDateList,
    this.tournamentsByDayList,
  });

  factory TopBetSportData.fromMap(Map<String, dynamic> data) => TopBetSportData(
        categoriesByBetTypeList:
            (data['categoriesByBetTypeList'] as List<dynamic>?)
                ?.map((e) =>
                    CategoriesByBetTypeList.fromMap(e as Map<String, dynamic>))
                .toList(),
        categoriesByDateList: (data['categoriesByDateList'] as List<dynamic>?)
            ?.map((e) => CategoryByDate.fromMap(e as Map<String, dynamic>))
            .toList(),
        tournamentsByDayList: (data['tournamentsByDayList'] as List<dynamic>?)
            ?.map((e) => TournamentByDay.fromMap(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toMap() => {
        'categoriesByBetTypeList':
            categoriesByBetTypeList?.map((e) => e.toMap()).toList(),
        'categoriesByDateList': categoriesByDateList,
        'tournamentsByDayList': tournamentsByDayList,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopBetSportData].
  factory TopBetSportData.fromJson(String data) {
    return TopBetSportData.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopBetSportData] to a JSON string.
  String toJson() => json.encode(toMap());

  TopBetSportData copyWith({
    List<CategoriesByBetTypeList>? categoriesByBetTypeList,
    List<CategoryByDate>? categoriesByDateList,
    List<TournamentByDay>? tournamentsByDayList,
  }) {
    return TopBetSportData(
      categoriesByBetTypeList:
          categoriesByBetTypeList ?? this.categoriesByBetTypeList,
      categoriesByDateList: categoriesByDateList ?? this.categoriesByDateList,
      tournamentsByDayList: tournamentsByDayList ?? this.tournamentsByDayList,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      categoriesByBetTypeList,
      categoriesByDateList,
      tournamentsByDayList,
    ];
  }
}

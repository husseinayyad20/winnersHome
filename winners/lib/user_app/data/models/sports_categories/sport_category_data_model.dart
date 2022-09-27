import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'sport_category.dart';
import 'sport_top_league.dart';

class Data extends Equatable {
  final List<SportCategory>? sportCategories;
  final List<SportTopLeague>? sportTopLeagues;
  final dynamic id;

  const Data({this.sportCategories, this.sportTopLeagues, this.id});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        sportCategories: (data['sportCategories'] as List<dynamic>?)
            ?.map((e) => SportCategory.fromMap(e as Map<String, dynamic>))
            .toList(),
        sportTopLeagues: (data['sportTopLeagues'] as List<dynamic>?)
            ?.map((e) => SportTopLeague.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'sportCategories': sportCategories?.map((e) => e.toMap()).toList(),
        'sportTopLeagues': sportTopLeagues?.map((e) => e.toMap()).toList(),
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    List<SportCategory>? sportCategories,
    List<SportTopLeague>? sportTopLeagues,
    dynamic id,
  }) {
    return Data(
      sportCategories: sportCategories ?? this.sportCategories,
      sportTopLeagues: sportTopLeagues ?? this.sportTopLeagues,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [sportCategories, sportTopLeagues, id];
}

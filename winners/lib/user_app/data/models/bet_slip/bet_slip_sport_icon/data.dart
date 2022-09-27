import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'bet_slip_sport_types_icon.dart';

class Data extends Equatable {
  final List<BetSlipSportTypesIcon>? betSlipSportTypesIcons;
  final int? id;
  final dynamic name;

  const Data({this.betSlipSportTypesIcons, this.id, this.name});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        betSlipSportTypesIcons: (data['betSlipSportTypesIcons']
                as List<dynamic>?)
            ?.map(
                (e) => BetSlipSportTypesIcon.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'betSlipSportTypesIcons':
            betSlipSportTypesIcons?.map((e) => e.toMap()).toList(),
        'id': id,
        'name': name,
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
    List<BetSlipSportTypesIcon>? betSlipSportTypesIcons,
    int? id,
    dynamic name,
  }) {
    return Data(
      betSlipSportTypesIcons:
          betSlipSportTypesIcons ?? this.betSlipSportTypesIcons,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [betSlipSportTypesIcons, id, name];
}

import 'dart:convert';

import 'package:winners/user_app/data/models/bet_slip_configuration/bet_slip_amount.dart';
import 'package:winners/user_app/data/models/bet_slip_configuration/bet_slip_constants.dart';
import 'package:winners/user_app/data/models/bet_slip_configuration/bets_restriction.dart';
import 'package:winners/user_app/data/models/bet_slip_configuration/minimum_bets_amount.dart';
import 'package:winners/user_app/data/models/bet_slip_configuration/place_bet_function.dart';
import 'package:equatable/equatable.dart';

class BetSlipConfigurationData extends Equatable {
  final List<BetsRestriction>? betsRestrictions;
  final List<BetSlipAmount>? betSlipAmounts;
  final BetSlipConstants? betSlipConstants;
  final List<MinimumBetsAmount>? minimumBetsAmount;
  final List<PlaceBetFunction>? placeBetFunctions;
  final int? id;
  final dynamic name;

  const BetSlipConfigurationData({
    this.betsRestrictions,
    this.betSlipAmounts,
    this.betSlipConstants,
    this.minimumBetsAmount,
    this.placeBetFunctions,
    this.id,
    this.name,
  });

  factory BetSlipConfigurationData.fromMap(Map<String, dynamic> data) =>
      BetSlipConfigurationData(
        betsRestrictions: (data['betsRestrictions'] as List<dynamic>?)
            ?.map((e) => BetsRestriction.fromMap(e as Map<String, dynamic>))
            .toList(),
        betSlipAmounts: (data['betSlipAmounts'] as List<dynamic>?)
            ?.map((e) => BetSlipAmount.fromMap(e as Map<String, dynamic>))
            .toList(),
        betSlipConstants: data['betSlipConstants'] == null
            ? null
            : BetSlipConstants.fromMap(
                data['betSlipConstants'] as Map<String, dynamic>),
        minimumBetsAmount: (data['minimumBetsAmount'] as List<dynamic>?)
            ?.map((e) => MinimumBetsAmount.fromMap(e as Map<String, dynamic>))
            .toList(),
        placeBetFunctions: (data['placeBetFunctions'] as List<dynamic>?)
            ?.map((e) => PlaceBetFunction.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'betsRestrictions': betsRestrictions?.map((e) => e.toMap()).toList(),
        'betSlipAmounts': betSlipAmounts?.map((e) => e.toMap()).toList(),
        'betSlipConstants': betSlipConstants?.toMap(),
        'minimumBetsAmount': minimumBetsAmount?.map((e) => e.toMap()).toList(),
        'placeBetFunctions': placeBetFunctions?.map((e) => e.toMap()).toList(),
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetSlipConfigurationData].
  factory BetSlipConfigurationData.fromJson(String data) {
    return BetSlipConfigurationData.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetSlipConfigurationData] to a JSON string.
  String toJson() => json.encode(toMap());

  BetSlipConfigurationData copyWith({
    List<BetsRestriction>? betsRestrictions,
    List<BetSlipAmount>? betSlipAmounts,
    BetSlipConstants? betSlipConstants,
    List<MinimumBetsAmount>? minimumBetsAmount,
    List<PlaceBetFunction>? placeBetFunctions,
    int? id,
    dynamic name,
  }) {
    return BetSlipConfigurationData(
      betsRestrictions: betsRestrictions ?? this.betsRestrictions,
      betSlipAmounts: betSlipAmounts ?? this.betSlipAmounts,
      betSlipConstants: betSlipConstants ?? this.betSlipConstants,
      minimumBetsAmount: minimumBetsAmount ?? this.minimumBetsAmount,
      placeBetFunctions: placeBetFunctions ?? this.placeBetFunctions,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      betsRestrictions,
      betSlipAmounts,
      betSlipConstants,
      minimumBetsAmount,
      placeBetFunctions,
      id,
      name,
    ];
  }
}

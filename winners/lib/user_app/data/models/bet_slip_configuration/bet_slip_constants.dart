import 'dart:convert';

import 'package:equatable/equatable.dart';

class BetSlipConstants extends Equatable {
  final int? maxBetLines;
  final double? minOddsMultiplier;
  final num? maxOddsMultiplier;
  final int? maxPossibleWinning;
  final int? maxPossibleWinningUsd;
  final int? maxPossibleWinningVirtual;
  final int? betSlipAmountLd;
  final int? betSlipAmountUsd;
  final int? id;
  final int? betSlipChangeUSD;
  final int? betSlipChangeLD;
  final dynamic name;

  const BetSlipConstants({
    this.maxBetLines,
    this.minOddsMultiplier,
    this.maxOddsMultiplier,
    this.maxPossibleWinning,
    this.maxPossibleWinningUsd,
    this.maxPossibleWinningVirtual,
    this.betSlipAmountLd,
    this.betSlipAmountUsd,
    this.id,
    this.betSlipChangeUSD,
    this.betSlipChangeLD,
    this.name,
  });

  factory BetSlipConstants.fromMap(Map<String, dynamic> data) {
    return BetSlipConstants(
      maxBetLines: data['maxBetLines'] as int?,
      minOddsMultiplier: (data['minOddsMultiplier'] as num?)?.toDouble(),
      maxOddsMultiplier: data['maxOddsMultiplier'] as num?,
      maxPossibleWinning: data['maxPossibleWinning'] as int?,
      maxPossibleWinningUsd: data['maxPossibleWinningUSD'] as int?,
      maxPossibleWinningVirtual: data['maxPossibleWinningVirtual'] as int?,
      betSlipAmountLd: data['betSlipAmountLD'] as int?,
      betSlipAmountUsd: data['betSlipAmountUSD'] as int?,
      id: data['id'] as int?,
      betSlipChangeUSD: data['betSlipChangeUSD'] as int?,
      betSlipChangeLD: data['betSlipChangeLD'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'maxBetLines': maxBetLines,
        'minOddsMultiplier': minOddsMultiplier,
        'maxOddsMultiplier': maxOddsMultiplier,
        'maxPossibleWinning': maxPossibleWinning,
        'maxPossibleWinningUSD': maxPossibleWinningUsd,
        'maxPossibleWinningVirtual': maxPossibleWinningVirtual,
        'betSlipAmountLD': betSlipAmountLd,
        'betSlipAmountUSD': betSlipAmountUsd,
        'id': id,
        'betSlipChangeUSD': betSlipChangeUSD,
        'betSlipChangeLD': betSlipChangeLD,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetSlipConstants].
  factory BetSlipConstants.fromJson(String data) {
    return BetSlipConstants.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetSlipConstants] to a JSON string.
  String toJson() => json.encode(toMap());

  BetSlipConstants copyWith({
    int? maxBetLines,
    double? minOddsMultiplier,
    int? maxOddsMultiplier,
    int? maxPossibleWinning,
    int? maxPossibleWinningUsd,
    int? maxPossibleWinningVirtual,
    int? betSlipAmountLd,
    int? betSlipAmountUsd,
    int? id,
    int? betSlipChangeUSD,
    int? betSlipChangeLD,
    dynamic name,
  }) {
    return BetSlipConstants(
      maxBetLines: maxBetLines ?? this.maxBetLines,
      minOddsMultiplier: minOddsMultiplier ?? this.minOddsMultiplier,
      maxOddsMultiplier: maxOddsMultiplier ?? this.maxOddsMultiplier,
      maxPossibleWinning: maxPossibleWinning ?? this.maxPossibleWinning,
      maxPossibleWinningUsd:
          maxPossibleWinningUsd ?? this.maxPossibleWinningUsd,
      maxPossibleWinningVirtual:
          maxPossibleWinningVirtual ?? this.maxPossibleWinningVirtual,
      betSlipAmountLd: betSlipAmountLd ?? this.betSlipAmountLd,
      betSlipAmountUsd: betSlipAmountUsd ?? this.betSlipAmountUsd,
      id: id ?? this.id,
      betSlipChangeUSD: betSlipChangeUSD ?? this.betSlipChangeUSD,
      betSlipChangeLD: betSlipChangeUSD ?? this.betSlipChangeLD,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      maxBetLines,
      minOddsMultiplier,
      maxOddsMultiplier,
      maxPossibleWinning,
      maxPossibleWinningUsd,
      maxPossibleWinningVirtual,
      betSlipAmountLd,
      betSlipAmountUsd,
      id,
      betSlipChangeUSD,
      betSlipChangeLD,
      name,
    ];
  }
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

class MinimumBetsAmount extends Equatable {
  final int? noOfBetLines;
  final double? amount;
  final int? usdAmount;
  final int? id;
  final dynamic name;

  const MinimumBetsAmount({
    this.noOfBetLines,
    this.amount,
    this.usdAmount,
    this.id,
    this.name,
  });

  factory MinimumBetsAmount.fromMap(Map<String, dynamic> data) {
    return MinimumBetsAmount(
      noOfBetLines: data['noOfBetLines'] as int?,
      amount: data['amount'] as double?,
      usdAmount: data['usdAmount'] as int?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'noOfBetLines': noOfBetLines,
        'amount': amount,
        'usdAmount': usdAmount,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MinimumBetsAmount].
  factory MinimumBetsAmount.fromJson(String data) {
    return MinimumBetsAmount.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MinimumBetsAmount] to a JSON string.
  String toJson() => json.encode(toMap());

  MinimumBetsAmount copyWith({
    int? noOfBetLines,
    double? amount,
    int? usdAmount,
    int? id,
    dynamic name,
  }) {
    return MinimumBetsAmount(
      noOfBetLines: noOfBetLines ?? this.noOfBetLines,
      amount: amount ?? this.amount,
      usdAmount: usdAmount ?? this.usdAmount,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [noOfBetLines, amount, usdAmount, id, name];
}

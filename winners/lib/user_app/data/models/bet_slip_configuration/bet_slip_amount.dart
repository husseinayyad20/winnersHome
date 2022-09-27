import 'dart:convert';

import 'package:equatable/equatable.dart';

class BetSlipAmount extends Equatable {
  final int? amount;
  final int? id;
  final dynamic name;

  const BetSlipAmount({this.amount, this.id, this.name});

  factory BetSlipAmount.fromMap(Map<String, dynamic> data) => BetSlipAmount(
        amount: data['amount'] as int?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'amount': amount,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetSlipAmount].
  factory BetSlipAmount.fromJson(String data) {
    return BetSlipAmount.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetSlipAmount] to a JSON string.
  String toJson() => json.encode(toMap());

  BetSlipAmount copyWith({
    int? amount,
    int? id,
    dynamic name,
  }) {
    return BetSlipAmount(
      amount: amount ?? this.amount,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [amount, id, name];
}

import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'currency.dart';

class MemberBalance extends Equatable {
  final int? memberId;
  final double? balance;
  final Currency? currency;
  final int? id;
  final dynamic name;

  const MemberBalance({
    this.memberId,
    this.balance,
    this.currency,
    this.id,
    this.name,
  });

  factory MemberBalance.fromMap(Map<String, dynamic> data) => MemberBalance(
        memberId: data['memberId'] as int?,
        balance: data['balance'] as double?,
        currency: data['currency'] == null
            ? null
            : Currency.fromMap(data['currency'] as Map<String, dynamic>),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'memberId': memberId,
        'balance': balance,
        'currency': currency?.toMap(),
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MemberBalance].
  factory MemberBalance.fromJson(String data) {
    return MemberBalance.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MemberBalance] to a JSON string.
  String toJson() => json.encode(toMap());

  MemberBalance copyWith({
    int? memberId,
    double? balance,
    Currency? currency,
    int? id,
    dynamic name,
  }) {
    return MemberBalance(
      memberId: memberId ?? this.memberId,
      balance: balance ?? this.balance,
      currency: currency ?? this.currency,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [memberId, balance, currency, id, name];
}

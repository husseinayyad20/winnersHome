import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'currency.dart';

class MemberDepositBonusBalance extends Equatable {
  final int? memberId;
  final double? balance;
  final String? promotionText;
  final Currency? currency;
  final String? dateTimeBonusExpire;
  final int? id;
  final dynamic name;

  const MemberDepositBonusBalance({
    this.memberId,
    this.balance,
    this.promotionText,
    this.currency,
    this.dateTimeBonusExpire,
    this.id,
    this.name,
  });

  factory MemberDepositBonusBalance.fromMap(Map<String, dynamic> data) {
    return MemberDepositBonusBalance(
      memberId: data['memberId'] as int?,
      balance: data['balance'] as double?,
      promotionText: data['promotionText'] as String?,
      currency: data['currency'] == null
          ? null
          : Currency.fromMap(data['currency'] as Map<String, dynamic>),
      dateTimeBonusExpire: data['dateTimeBonusExpire'] as String?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'memberId': memberId,
        'balance': balance,
        'promotionText': promotionText,
        'currency': currency?.toMap(),
        'dateTimeBonusExpire': dateTimeBonusExpire,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [MemberDepositBonusBalance].
  factory MemberDepositBonusBalance.fromJson(String data) {
    return MemberDepositBonusBalance.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [MemberDepositBonusBalance] to a JSON string.
  String toJson() => json.encode(toMap());

  MemberDepositBonusBalance copyWith({
    int? memberId,
    double? balance,
    String? promotionText,
    Currency? currency,
    String? dateTimeBonusExpire,
    int? id,
    dynamic name,
  }) {
    return MemberDepositBonusBalance(
      memberId: memberId ?? this.memberId,
      balance: balance ?? this.balance,
      promotionText: promotionText ?? this.promotionText,
      currency: currency ?? this.currency,
      dateTimeBonusExpire: dateTimeBonusExpire ?? this.dateTimeBonusExpire,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      memberId,
      balance,
      promotionText,
      currency,
      dateTimeBonusExpire,
      id,
      name,
    ];
  }
}

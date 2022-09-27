import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'member_balance.dart';
import 'member_deposit_bonus_balance.dart';

class Member extends Equatable {
  final int? memberId;
  final dynamic userName;
  final dynamic firstName;
  final dynamic lastName;
  final dynamic email;
  final List<MemberBalance>? memberBalances;
  final MemberDepositBonusBalance? memberDepositBonusBalance;
  final dynamic token;
  final int? tokenExpiresMinutes;
  final bool? isSignedIn;
  final bool? isAllowUpdate;
  final int? id;
  final dynamic name;

  const Member({
    this.memberId,
    this.userName,
    this.firstName,
    this.lastName,
    this.email,
    this.memberBalances,
    this.memberDepositBonusBalance,
    this.token,
    this.tokenExpiresMinutes,
    this.isSignedIn,
    this.isAllowUpdate,
    this.id,
    this.name,
  });

  factory Member.fromMap(Map<String, dynamic> data) => Member(
        memberId: data['memberId'] as int?,
        userName: data['userName'] as dynamic,
        firstName: data['firstName'] as dynamic,
        lastName: data['lastName'] as dynamic,
        email: data['email'] as dynamic,
        memberBalances: (data['memberBalances'] as List<dynamic>?)
            ?.map((e) => MemberBalance.fromMap(e as Map<String, dynamic>))
            .toList(),
        memberDepositBonusBalance: data['memberDepositBonusBalance'] == null
            ? null
            : MemberDepositBonusBalance.fromMap(
                data['memberDepositBonusBalance'] as Map<String, dynamic>),
        token: data['token'] as dynamic,
        tokenExpiresMinutes: data['tokenExpiresMinutes'] as int?,
        isSignedIn: data['isSignedIn'] as bool?,
        isAllowUpdate: data['isAllowUpdate'] as bool?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'memberId': memberId,
        'userName': userName,
        'firstName': firstName,
        'lastName': lastName,
        'email': email,
        'memberBalances': memberBalances?.map((e) => e.toMap()).toList(),
        'memberDepositBonusBalance': memberDepositBonusBalance?.toMap(),
        'token': token,
        'tokenExpiresMinutes': tokenExpiresMinutes,
        'isSignedIn': isSignedIn,
        'isAllowUpdate': isAllowUpdate,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Member].
  factory Member.fromJson(String data) {
    return Member.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Member] to a JSON string.
  String toJson() => json.encode(toMap());

  Member copyWith({
    int? memberId,
    dynamic userName,
    dynamic firstName,
    dynamic lastName,
    dynamic email,
    List<MemberBalance>? memberBalances,
    MemberDepositBonusBalance? memberDepositBonusBalance,
    dynamic token,
    int? tokenExpiresMinutes,
    bool? isSignedIn,
    bool? isAllowUpdate,
    int? id,
    dynamic name,
  }) {
    return Member(
      memberId: memberId ?? this.memberId,
      userName: userName ?? this.userName,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      memberBalances: memberBalances ?? this.memberBalances,
      memberDepositBonusBalance:
          memberDepositBonusBalance ?? this.memberDepositBonusBalance,
      token: token ?? this.token,
      tokenExpiresMinutes: tokenExpiresMinutes ?? this.tokenExpiresMinutes,
      isSignedIn: isSignedIn ?? this.isSignedIn,
      isAllowUpdate: isAllowUpdate ?? this.isAllowUpdate,
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
      userName,
      firstName,
      lastName,
      email,
      memberBalances,
      memberDepositBonusBalance,
      token,
      tokenExpiresMinutes,
      isSignedIn,
      isAllowUpdate,
      id,
      name,
    ];
  }
}

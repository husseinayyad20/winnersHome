import 'dart:convert';

import 'package:equatable/equatable.dart';

class SinglesBetFormDetail extends Equatable {
  final String? formNumber;
  final int? betLineNo;
  final int? activeOddFieldId;
  final bool? betSucceed;
  final List<dynamic>? messages;
  final int? id;
  final dynamic name;

  const SinglesBetFormDetail({
    this.formNumber,
    this.betLineNo,
    this.activeOddFieldId,
    this.betSucceed,
    this.messages,
    this.id,
    this.name,
  });

  factory SinglesBetFormDetail.fromMap(Map<String, dynamic> data) {
    return SinglesBetFormDetail(
      formNumber: data['formNumber'] as String?,
      betLineNo: data['betLineNo'] as int?,
      activeOddFieldId: data['activeOddFieldId'] as int?,
      betSucceed: data['betSucceed'] as bool?,
      messages: data['messages'] as List<dynamic>?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'formNumber': formNumber,
        'betLineNo': betLineNo,
        'activeOddFieldId': activeOddFieldId,
        'betSucceed': betSucceed,
        'messages': messages,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SinglesBetFormDetail].
  factory SinglesBetFormDetail.fromJson(String data) {
    return SinglesBetFormDetail.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SinglesBetFormDetail] to a JSON string.
  String toJson() => json.encode(toMap());

  SinglesBetFormDetail copyWith({
    String? formNumber,
    int? betLineNo,
    int? activeOddFieldId,
    bool? betSucceed,
    List<dynamic>? messages,
    int? id,
    dynamic name,
  }) {
    return SinglesBetFormDetail(
      formNumber: formNumber ?? this.formNumber,
      betLineNo: betLineNo ?? this.betLineNo,
      activeOddFieldId: activeOddFieldId ?? this.activeOddFieldId,
      betSucceed: betSucceed ?? this.betSucceed,
      messages: messages ?? this.messages,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      formNumber,
      betLineNo,
      activeOddFieldId,
      betSucceed,
      messages,
      id,
      name,
    ];
  }
}

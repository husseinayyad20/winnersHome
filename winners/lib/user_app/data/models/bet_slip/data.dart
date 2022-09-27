import 'dart:convert';

import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? feedId;
  final int? sportId;
  final int? eventId;
  final int? oddId;
  final int? oddFieldNumber;
  final int? betLineNo;
  final int? betTypeId;
  final int? betCode;
  final String? oddSpecialField;
  final int? activeOddFieldId;
  final int? id;
  final dynamic name;

  const Data({
    this.feedId,
    this.sportId,
    this.eventId,
    this.oddId,
    this.oddFieldNumber,
    this.betLineNo,
    this.betTypeId,
    this.betCode,
    this.oddSpecialField,
    this.activeOddFieldId,
    this.id,
    this.name,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        feedId: data['feedId'] as int?,
        sportId: data['sportId'] as int?,
        eventId: data['eventId'] as int?,
        oddId: data['oddId'] as int?,
        oddFieldNumber: data['oddFieldNumber'] as int?,
        betLineNo: data['betLineNo'] as int?,
        betTypeId: data['betTypeId'] as int?,
        betCode: data['betCode'] as int?,
        oddSpecialField: data['oddSpecialField'] as String?,
        activeOddFieldId: data['activeOddFieldId'] as int?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'feedId': feedId,
        'sportId': sportId,
        'eventId': eventId,
        'oddId': oddId,
        'oddFieldNumber': oddFieldNumber,
        'betLineNo': betLineNo,
        'betTypeId': betTypeId,
        'betCode': betCode,
        'oddSpecialField': oddSpecialField,
        'activeOddFieldId': activeOddFieldId,
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
    int? feedId,
    int? sportId,
    int? eventId,
    int? oddId,
    int? oddFieldNumber,
    int? betLineNo,
    int? betTypeId,
    int? betCode,
    String? oddSpecialField,
    int? activeOddFieldId,
    int? id,
    dynamic name,
  }) {
    return Data(
      feedId: feedId ?? this.feedId,
      sportId: sportId ?? this.sportId,
      eventId: eventId ?? this.eventId,
      oddId: oddId ?? this.oddId,
      oddFieldNumber: oddFieldNumber ?? this.oddFieldNumber,
      betLineNo: betLineNo ?? this.betLineNo,
      betTypeId: betTypeId ?? this.betTypeId,
      betCode: betCode ?? this.betCode,
      oddSpecialField: oddSpecialField ?? this.oddSpecialField,
      activeOddFieldId: activeOddFieldId ?? this.activeOddFieldId,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      feedId,
      sportId,
      eventId,
      oddId,
      oddFieldNumber,
      betLineNo,
      betTypeId,
      betCode,
      oddSpecialField,
      activeOddFieldId,
      id,
      name,
    ];
  }
}

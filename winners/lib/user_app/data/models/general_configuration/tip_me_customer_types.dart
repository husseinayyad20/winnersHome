import 'dart:convert';

import 'package:equatable/equatable.dart';

class TipMeCustomerTypes extends Equatable {
  final int? typeId;
  final String? typeName;
  final int? id;
  final dynamic name;

  const TipMeCustomerTypes({
    this.typeId,
    this.typeName,
    this.id,
    this.name,
  });

  factory TipMeCustomerTypes.fromMap(Map<String, dynamic> data) =>
      TipMeCustomerTypes(
        typeId: data['typeId'] as int?,
        typeName: data['typeName'] as String?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'typeId': typeId,
        'tabText': typeName,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TipMeCustomerTypes].
  factory TipMeCustomerTypes.fromJson(String data) {
    return TipMeCustomerTypes.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TipMeCustomerTypes] to a JSON string.
  String toJson() => json.encode(toMap());

  TipMeCustomerTypes copyWith({
    int? formStatusId,
    String? formStatusName,
    int? id,
    dynamic name,
  }) {
    return TipMeCustomerTypes(
      typeId: formStatusId ?? typeId,
      typeName: formStatusName ?? typeName,
      id: id ?? id,
      name: name ?? name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [typeId, typeName, id, name];
}

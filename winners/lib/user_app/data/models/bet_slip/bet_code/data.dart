import 'dart:convert';

import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? code;
  final int? id;
  final dynamic name;

  const Data({this.code, this.id, this.name});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        code: data['code'] as int?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'code': code,
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
    int? code,
    int? id,
    dynamic name,
  }) {
    return Data(
      code: code ?? this.code,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [code, id, name];
}

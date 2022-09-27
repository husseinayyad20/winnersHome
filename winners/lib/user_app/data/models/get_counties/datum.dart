import 'dart:convert';

import 'package:equatable/equatable.dart';

class Datum extends Equatable {
  final int? countyId;
  final dynamic countyName;
  final int? id;
  final dynamic name;

  const Datum({this.countyId, this.countyName, this.id, this.name});

  factory Datum.fromMap(Map<String, dynamic> data) => Datum(
        countyId: data['countyId'] as int?,
        countyName: data['countyName'] as dynamic,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'countyId': countyId,
        'countyName': countyName,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Datum].
  factory Datum.fromJson(String data) {
    return Datum.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Datum] to a JSON string.
  String toJson() => json.encode(toMap());

  Datum copyWith({
    int? countyId,
    dynamic countyName,
    int? id,
    dynamic name,
  }) {
    return Datum(
      countyId: countyId ?? this.countyId,
      countyName: countyName ?? this.countyName,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [countyId, countyName, id, name];
}

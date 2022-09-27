import 'dart:convert';
import 'package:equatable/equatable.dart';

class CurrencyDatumModel extends Equatable {
  final int? currencyId;
  final String? currencySymbol;
  final String? currencyName;
  final String? currencyCode;
  final bool? currencyIsDefault;
  final int? id;
  final dynamic name;

  const CurrencyDatumModel({
    this.currencyId,
    this.currencySymbol,
    this.currencyName,
    this.currencyCode,
    this.currencyIsDefault,
    this.id,
    this.name,
  });

  factory CurrencyDatumModel.fromMap(Map<String, dynamic> data) =>
      CurrencyDatumModel(
        currencyId: data['currencyId'] as int?,
        currencySymbol: data['currencySymbol'] as String?,
        currencyName: data['currencyName'] as String?,
        currencyCode: data['currencyCode'] as String?,
        currencyIsDefault: data['currencyIsDefault'] as bool?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'currencyId': currencyId,
        'currencySymbol': currencySymbol,
        'currencyName': currencyName,
        'currencyCode': currencyCode,
        'currencyIsDefault': currencyIsDefault,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CurrencyDatumModel].
  factory CurrencyDatumModel.fromJson(String data) {
    return CurrencyDatumModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CurrencyDatumModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CurrencyDatumModel copyWith({
    int? currencyId,
    String? currencySymbol,
    String? currencyName,
    String? currencyCode,
    bool? currencyIsDefault,
    int? id,
    dynamic name,
  }) {
    return CurrencyDatumModel(
      currencyId: currencyId ?? this.currencyId,
      currencySymbol: currencySymbol ?? this.currencySymbol,
      currencyName: currencyName ?? this.currencyName,
      currencyCode: currencyCode ?? this.currencyCode,
      currencyIsDefault: currencyIsDefault ?? this.currencyIsDefault,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      currencyId,
      currencySymbol,
      currencyName,
      currencyCode,
      currencyIsDefault,
      id,
      name,
    ];
  }
}

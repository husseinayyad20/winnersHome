import 'package:equatable/equatable.dart';

class CurrencyDatumEntity extends Equatable {
  const CurrencyDatumEntity({
    this.currencyId,
    this.currencySymbol,
    this.currencyName,
    this.currencyCode,
    this.currencyIsDefault,
    this.id,
    this.name,
  });

  final int? currencyId;
  final String? currencySymbol;
  final String? currencyName;
  final String? currencyCode;
  final bool? currencyIsDefault;
  final int? id;
  final dynamic name;

  CurrencyDatumEntity copyWith({
    int? currencyId,
    String? currencySymbol,
    String? currencyName,
    String? currencyCode,
    bool? currencyIsDefault,
    int? id,
    dynamic name,
  }) {
    return CurrencyDatumEntity(
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

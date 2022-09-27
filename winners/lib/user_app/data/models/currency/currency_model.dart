import 'dart:convert';

import 'package:winners/user_app/data/models/currency/currency_datum_model.dart';
import 'package:winners/user_app/domain/entities/currency/currency_entity.dart';
import 'package:equatable/equatable.dart';

class CurrencyModel extends Equatable {
  final List<CurrencyDatumModel>? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const CurrencyModel({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory CurrencyModel.fromMap(Map<String, dynamic> data) => CurrencyModel(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => CurrencyDatumModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        status: data['status'] as int?,
        message: data['message'] as String?,
        success: data['success'] as bool?,
        detail: data['detail'] as dynamic,
        serverDateTime: data['serverDateTime'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
        'status': status,
        'message': message,
        'success': success,
        'detail': detail,
        'serverDateTime': serverDateTime,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [CurrencyModel].
  factory CurrencyModel.fromJson(String data) {
    return CurrencyModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [CurrencyModel] to a JSON string.
  String toJson() => json.encode(toMap());

  CurrencyModel copyWith({
    List<CurrencyDatumModel>? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return CurrencyModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

  CurrencyEntity toEntity() => CurrencyEntity(
        data: data,
        status: status,
        message: message,
        success: success,
        detail: detail,
        serverDateTime: serverDateTime,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      data,
      status,
      message,
      success,
      detail,
      serverDateTime,
    ];
  }
}

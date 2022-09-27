import 'package:equatable/equatable.dart';

import 'data.dart';

class CountriesFlagModel extends Equatable {
  final Data? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const CountriesFlagModel({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory CountriesFlagModel.fromJson(Map<String, dynamic> json) =>
      CountriesFlagModel(
        data: json['data'] == null
            ? null
            : Data.fromJson(json['data'] as Map<String, dynamic>),
        status: json['status'] as int?,
        message: json['message'] as String?,
        success: json['success'] as bool?,
        detail: json['detail'],
        serverDateTime: json['serverDateTime'] as int?,
      );

  Map<String, dynamic> toJson() => {
        'data': data?.toJson(),
        'status': status,
        'message': message,
        'success': success,
        'detail': detail,
        'serverDateTime': serverDateTime,
      };

  CountriesFlagModel copyWith({
    Data? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return CountriesFlagModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

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

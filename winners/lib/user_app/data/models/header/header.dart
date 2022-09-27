import 'dart:convert';

import 'package:winners/user_app/data/models/header/data.dart';
import 'package:winners/user_app/domain/entities/header/header_entity.dart';
import 'package:equatable/equatable.dart';

class HeaderModel extends Equatable {
  final HeaderModelData? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const HeaderModel({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory HeaderModel.fromMap(Map<String, dynamic> data) => HeaderModel(
        data: data['data'] == null
            ? null
            : HeaderModelData.fromMap(data['data'] as Map<String, dynamic>),
        status: data['status'] as int?,
        message: data['message'] as String?,
        success: data['success'] as bool?,
        detail: data['detail'] as dynamic,
        serverDateTime: data['serverDateTime'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
        'status': status,
        'message': message,
        'success': success,
        'detail': detail,
        'serverDateTime': serverDateTime,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HeaderModel].
  factory HeaderModel.fromJson(String data) {
    return HeaderModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HeaderModel] to a JSON string.
  String toJson() => json.encode(toMap());

  HeaderModel copyWith({
    HeaderModelData? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return HeaderModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

  HeaderEntity toEntity() => HeaderEntity(
        data: data,
        serverDateTime: serverDateTime,
        status: status,
        success: success,
        message: message,
        detail: detail,
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

import 'dart:convert';

import 'package:winners/user_app/data/models/get_counties/datum.dart';
import 'package:winners/user_app/domain/entities/county_entities/county_entity.dart';
import 'package:equatable/equatable.dart';

class GetCounties extends Equatable {
  final List<Datum>? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const GetCounties({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory GetCounties.fromMap(Map<String, dynamic> data) => GetCounties(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
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
  /// Parses the string and returns the resulting Json object as [GetCounties].
  factory GetCounties.fromJson(String data) {
    return GetCounties.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetCounties] to a JSON string.
  String toJson() => json.encode(toMap());

  GetCounties copyWith({
    List<Datum>? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return GetCounties(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

  CountyEntity toEntity() => CountyEntity(
        data: data,
        status: status,
        message: message,
        serverDateTime: serverDateTime,
        success: success,
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

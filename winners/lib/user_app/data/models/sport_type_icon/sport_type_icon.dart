import 'dart:convert';

import 'package:winners/user_app/domain/entities/sport_type_icon/sport_type_icon_entity.dart';
import 'package:equatable/equatable.dart';

import 'data.dart';

class SportTypeIcon extends Equatable {
  final Data? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const SportTypeIcon({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory SportTypeIcon.fromMap(Map<String, dynamic> data) => SportTypeIcon(
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [SportTypeIcon].
  factory SportTypeIcon.fromJson(String data) {
    return SportTypeIcon.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SportTypeIcon] to a JSON string.
  String toJson() => json.encode(toMap());

  SportTypeIcon copyWith({
    Data? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return SportTypeIcon(
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

  SportTypeIconEntity toEntity() => SportTypeIconEntity(
        data: data,
        status: status,
        serverDateTime: serverDateTime,
        success: success,
      );

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

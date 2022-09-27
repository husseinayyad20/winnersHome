import 'dart:convert';

import 'package:winners/user_app/domain/entities/teams_icons_entity/teams_icons_entity.dart';
import 'package:equatable/equatable.dart';

import 'team_icons_data_model.dart';

class TeamsIcons extends Equatable {
  final TeamsIconsDataModel? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const TeamsIcons({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  TeamsIconsDataEntity toDataEntity() => TeamsIconsDataEntity(
        teamsIcons: data!.teamsIcons,
        id: data!.id,
        name: data!.name,
      );

  factory TeamsIcons.fromMap(Map<String, dynamic> data) => TeamsIcons(
        data: data['data'] == null
            ? null
            : TeamsIconsDataModel.fromMap(data['data'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [TeamsIcons].
  factory TeamsIcons.fromJson(String data) {
    return TeamsIcons.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TeamsIcons] to a JSON string.
  String toJson() => json.encode(toMap());

  TeamsIcons copyWith({
    TeamsIconsDataModel? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return TeamsIcons(
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

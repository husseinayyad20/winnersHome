import 'dart:convert';

import 'package:winners/user_app/domain/entities/leagues_tabs/leagues_tabs_entity.dart';
import 'package:equatable/equatable.dart';

import 'leagues_tabs_model_data.dart';

class LeaguesTabsModel extends Equatable {
  final LeaguesTabsModelData? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const LeaguesTabsModel({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory LeaguesTabsModel.fromMap(Map<String, dynamic> data) {
    return LeaguesTabsModel(
      data: data['data'] == null
          ? null
          : LeaguesTabsModelData.fromMap(data['data'] as Map<String, dynamic>),
      status: data['status'] as int?,
      message: data['message'] as String?,
      success: data['success'] as bool?,
      detail: data['detail'] as dynamic,
      serverDateTime: data['serverDateTime'] as int?,
    );
  }

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
  /// Parses the string and returns the resulting Json object as [LeaguesTabsModel].
  factory LeaguesTabsModel.fromJson(String data) {
    return LeaguesTabsModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [LeaguesTabsModel] to a JSON string.
  String toJson() => json.encode(toMap());

  LeaguesTabsEntity toEntity() => LeaguesTabsEntity(
        sportTopLeaguesTab: data!.sportTopLeaguesTab,
        id: data!.id,
        name: data!.name,
      );
  LeaguesTabsModel copyWith({
    LeaguesTabsModelData? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return LeaguesTabsModel(
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

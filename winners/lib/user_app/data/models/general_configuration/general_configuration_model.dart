import 'dart:convert';

import 'package:winners/user_app/data/models/general_configuration/general_configuration_data_model.dart';
import 'package:winners/user_app/domain/entities/general_configuration/general_configuration_entity.dart';
import 'package:equatable/equatable.dart';

class GeneralConfigurationModel extends Equatable {
  final GeneralConfigurationDataModel? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const GeneralConfigurationModel({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory GeneralConfigurationModel.fromMap(Map<String, dynamic> data) {
    return GeneralConfigurationModel(
      data: data['data'] == null
          ? null
          : GeneralConfigurationDataModel.fromMap(
              data['data'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [GeneralConfigurationModel].
  factory GeneralConfigurationModel.fromJson(String data) {
    return GeneralConfigurationModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GeneralConfigurationModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GeneralConfigurationModel copyWith({
    GeneralConfigurationDataModel? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return GeneralConfigurationModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

  GeneralConfigurationEntity toEntity() => GeneralConfigurationEntity(
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

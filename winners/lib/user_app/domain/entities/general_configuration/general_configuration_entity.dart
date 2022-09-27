import 'dart:convert';


import 'package:winners/user_app/data/models/general_configuration/general_configuration_data_model.dart';
import 'package:equatable/equatable.dart';

class GeneralConfigurationEntity extends Equatable {
  final GeneralConfigurationDataModel? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const GeneralConfigurationEntity({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory GeneralConfigurationEntity.fromMap(Map<String, dynamic> data) {
    return GeneralConfigurationEntity(
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
  /// Parses the string and returns the resulting Json object as [GeneralConfigurationEntity].
  factory GeneralConfigurationEntity.fromJson(String data) {
    return GeneralConfigurationEntity.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GeneralConfigurationEntity] to a JSON string.
  String toJson() => json.encode(toMap());

  GeneralConfigurationEntity copyWith({
    GeneralConfigurationDataModel? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return GeneralConfigurationEntity(
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

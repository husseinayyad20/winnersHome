import 'dart:convert';

import 'package:winners/user_app/data/models/banner/banner_data_model.dart';
import 'package:winners/user_app/domain/entities/banner/banner_entity.dart';
import 'package:equatable/equatable.dart';

class BannerModel extends Equatable {
  final BannerDataModel? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const BannerModel({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory BannerModel.fromMap(Map<String, dynamic> data) => BannerModel(
        data: data['data'] == null
            ? null
            : BannerDataModel.fromMap(data['data'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [BannerModel].
  factory BannerModel.fromJson(String data) {
    return BannerModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BannerModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BannerModel copyWith({
    BannerDataModel? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return BannerModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

  BannerEntity toEntity() => BannerEntity(
        data: data,
        status: status,
        detail: detail,
        success: success,
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

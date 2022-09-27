import 'dart:convert';

import 'package:winners/user_app/domain/entities/sport_category/sport_category_data_entity.dart';
import 'package:equatable/equatable.dart';

import 'sport_category_data_model.dart';

class SportsCategoriesModel extends Equatable {
  final Data? data;
  final int? status;
  final dynamic message;
  final int? serverDateTime;
  final int? serverId;
  final bool? success;

  const SportsCategoriesModel({
    this.data,
    this.status,
    this.message,
    this.serverDateTime,
    this.serverId,
    this.success,
  });

  factory SportsCategoriesModel.fromMap(Map<String, dynamic> data) {
    return SportsCategoriesModel(
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
      status: data['status'] as int?,
      message: data['message'] as dynamic,
      serverDateTime: data['serverDateTime'] as int?,
      serverId: data['serverId'] as int?,
      success: data['success'] as bool?,
    );
  }

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
        'status': status,
        'message': message,
        'serverDateTime': serverDateTime,
        'serverId': serverId,
        'success': success,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SportsCategoriesModel].
  factory SportsCategoriesModel.fromJson(String data) {
    return SportsCategoriesModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SportsCategoriesModel] to a JSON string.
  String toJson() => json.encode(toMap());

  SportsCategoriesModel copyWith({
    Data? data,
    int? status,
    dynamic message,
    int? serverDateTime,
    int? serverId,
    bool? success,
  }) {
    return SportsCategoriesModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      serverDateTime: serverDateTime ?? this.serverDateTime,
      serverId: serverId ?? this.serverId,
      success: success ?? this.success,
    );
  }

  SportCategoryDataEntity toDataEntity() => SportCategoryDataEntity(
        sportCategories: data!.sportCategories,
        sportTopLeagues: data!.sportTopLeagues,
      );

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      data,
      status,
      message,
      serverDateTime,
      serverId,
      success,
    ];
  }
}

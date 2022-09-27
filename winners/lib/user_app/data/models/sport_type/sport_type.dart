import 'dart:convert';

import 'package:winners/user_app/data/models/sport_type/datum.dart';
import 'package:winners/user_app/domain/entities/sport_type/sport_type_entity.dart';
import 'package:equatable/equatable.dart';

class SportType extends Equatable {
  final List<Datum>? data;
  final int? status;
  final int? serverDateTime;
  final int? serverId;
  final bool? success;

  const SportType({
    this.data,
    this.status,
    this.serverDateTime,
    this.serverId,
    this.success,
  });

  factory SportType.fromMap(Map<String, dynamic> data) => SportType(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Datum.fromMap(e as Map<String, dynamic>))
            .toList(),
        status: data['status'] as int?,
        serverDateTime: data['serverDateTime'] as int?,
        serverId: data['serverId'] as int?,
        success: data['success'] as bool?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
        'status': status,
        'serverDateTime': serverDateTime,
        'serverId': serverId,
        'success': success,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [SportType].
  factory SportType.fromJson(String data) {
    return SportType.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [SportType] to a JSON string.
  String toJson() => json.encode(toMap());

  SportType copyWith({
    List<Datum>? data,
    int? status,
    int? serverDateTime,
    int? serverId,
    bool? success,
  }) {
    return SportType(
      data: data ?? this.data,
      status: status ?? this.status,
      serverDateTime: serverDateTime ?? this.serverDateTime,
      serverId: serverId ?? this.serverId,
      success: success ?? this.success,
    );
  }

  @override
  bool get stringify => true;

  SportTypeEntity toEntity() => SportTypeEntity(
        data: data,
        status: status,
        serverId: serverId,
        serverDateTime: serverDateTime,
        success: success,
      );

  @override
  List<Object?> get props {
    return [
      data,
      status,
      serverDateTime,
      serverId,
      success,
    ];
  }
}

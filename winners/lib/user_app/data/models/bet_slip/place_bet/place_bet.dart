import 'dart:convert';

import 'package:winners/user_app/domain/entities/bet_slip/place_bet_entity.dart';
import 'package:equatable/equatable.dart';

import 'data.dart';

class PlaceBet extends Equatable {
  final Data? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final dynamic serverDateTime;

  const PlaceBet({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory PlaceBet.fromMap(Map<String, dynamic> data) => PlaceBet(
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
        status: data['status'] as int?,
        message: data['message'] as String?,
        success: data['success'] as bool?,
        detail: data['detail'] as dynamic,
        serverDateTime: data['serverDateTime'] as dynamic?,
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
  /// Parses the string and returns the resulting Json object as [PlaceBet].
  factory PlaceBet.fromJson(String data) {
    return PlaceBet.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PlaceBet] to a JSON string.
  String toJson() => json.encode(toMap());

  PlaceBet copyWith({
    Data? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return PlaceBet(
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
  PlaceBetEntity toEntity() => PlaceBetEntity(
        data: data,
        status: status,
        message: message,
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

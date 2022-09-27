import 'dart:convert';

import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_sports_icons_entity%20copy.dart';
import 'package:equatable/equatable.dart';

import 'data.dart';

class BetSlipSportIcon extends Equatable {
  final Data? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const BetSlipSportIcon({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory BetSlipSportIcon.fromMap(Map<String, dynamic> data) {
    return BetSlipSportIcon(
      data: data['data'] == null
          ? null
          : Data.fromMap(data['data'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [BetSlipSportIcon].
  factory BetSlipSportIcon.fromJson(String data) {
    return BetSlipSportIcon.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetSlipSportIcon] to a JSON string.
  String toJson() => json.encode(toMap());

  BetSlipSportIcon copyWith({
    Data? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return BetSlipSportIcon(
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

  BetSlipSportIconsEntity toEntity() => BetSlipSportIconsEntity(
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

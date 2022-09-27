import 'dart:convert';

import 'package:winners/user_app/domain/entities/bet_slip/bet_slip_entity.dart';
import 'package:equatable/equatable.dart';

import 'data.dart';

class BetSlip extends Equatable {
  final List<Data>? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final num? serverDateTime;

  const BetSlip({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

  factory BetSlip.fromMap(Map<String, dynamic> data) => BetSlip(
        data: (data['data'] as List<dynamic>?)
            ?.map((e) => Data.fromMap(e as Map<String, dynamic>))
            .toList(),
        status: data['status'] as int?,
        message: data['message'] as String?,
        success: data['success'] as bool?,
        detail: data['detail'] as dynamic,
        serverDateTime: data['serverDateTime'] as num?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.map((e) => e.toMap()).toList(),
        'status': status,
        'message': message,
        'success': success,
        'detail': detail,
        'serverDateTime': serverDateTime,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BetSlip].
  factory BetSlip.fromJson(String data) {
    return BetSlip.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BetSlip] to a JSON string.
  String toJson() => json.encode(toMap());

  BetSlip copyWith({
    List<Data>? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return BetSlip(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

  BetSlipEntity toEntity() => BetSlipEntity(
        data: data,
        status: status,
        message: message,
        serverDateTime: serverDateTime,
        success: success,
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

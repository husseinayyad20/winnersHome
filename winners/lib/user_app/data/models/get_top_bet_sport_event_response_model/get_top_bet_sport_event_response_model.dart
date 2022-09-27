// ignore_for_file: must_be_immutable
import 'dart:convert';
import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/data/data.dart';
import 'package:winners/user_app/domain/entities/top_bet_sport_event/top_bet_sport_event_entity.dart';
import 'package:equatable/equatable.dart';

class GetTopBetSportEventResponseModel extends Equatable {
  final TopBetSportData? data;
  final int? status;
  final dynamic message;
  final int? serverDateTime;
  final int? serverId;
  final bool? success;

  const GetTopBetSportEventResponseModel({
    this.data,
    this.status,
    this.message,
    this.serverDateTime,
    this.serverId,
    this.success,
  });

  factory GetTopBetSportEventResponseModel.fromMap(Map<String, dynamic> data) {
    return GetTopBetSportEventResponseModel(
      status: data['status'] as int?,
      message: data['message'] as dynamic,
      serverDateTime: data['serverDateTime'] as int?,
      serverId: data['serverId'] as int?,
      success: data['success'] as bool?,
      data: data['data'] == null
          ? null
          : TopBetSportData.fromMap(data['data'] as Map<String, dynamic>),
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
  /// Parses the string and returns the resulting Json object as [GetTopBetSportEventResponseModel].
  factory GetTopBetSportEventResponseModel.fromJson(String data) {
    return GetTopBetSportEventResponseModel.fromMap(
        json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [GetTopBetSportEventResponseModel] to a JSON string.
  String toJson() => json.encode(toMap());

  GetTopBetSportEventResponseModel copyWith({
    TopBetSportData? data,
    int? status,
    dynamic message,
    int? serverDateTime,
    int? serverId,
    bool? success,
  }) {
    return GetTopBetSportEventResponseModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      serverDateTime: serverDateTime ?? this.serverDateTime,
      serverId: serverId ?? this.serverId,
      success: success ?? this.success,
    );
  }

  TopBetSportEventEntity toEntity() => TopBetSportEventEntity(
        // data: data,
        success: success,
        serverDateTime: serverDateTime,
        serverId: serverId,
        message: message,
        status: status,
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

// ignore_for_file: must_be_immutable

import 'package:winners/user_app/data/models/get_top_bet_sport_event_response_model/data.dart';
import 'package:equatable/equatable.dart';

class TopBetSportEventEntity extends Equatable {
  late TopBetSportEventData? data;
  final int? status;
  final dynamic message;
  final int? serverDateTime;
  final int? serverId;
  final bool? success;

  TopBetSportEventEntity({
    this.data,
    this.status,
    this.message,
    this.serverDateTime,
    this.serverId,
    this.success,
  });

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

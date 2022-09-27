import 'package:winners/user_app/data/models/sport_type/datum.dart';
import 'package:equatable/equatable.dart';

class SportTypeEntity extends Equatable {
  final List<Datum>? data;
  final int? status;
  final int? serverDateTime;
  final int? serverId;
  final bool? success;

  const SportTypeEntity({
    this.data,
    this.status,
    this.serverDateTime,
    this.serverId,
    this.success,
  });

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

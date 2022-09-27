import 'package:winners/user_app/data/models/get_counties/datum.dart';
import 'package:equatable/equatable.dart';

class CountyEntity extends Equatable {
  final List<Datum>? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const CountyEntity({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });

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

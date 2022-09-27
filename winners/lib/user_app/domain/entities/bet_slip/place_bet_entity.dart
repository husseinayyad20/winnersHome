import 'package:equatable/equatable.dart';

import '../../../data/models/bet_slip/place_bet/data.dart';

class PlaceBetEntity extends Equatable {
  final Data? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final dynamic serverDateTime;

  const PlaceBetEntity({
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

import 'package:winners/user_app/data/models/bet_slip/data.dart';
import 'package:equatable/equatable.dart';

class BetSlipEntity extends Equatable {
  final List<Data>? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final num? serverDateTime;

  const BetSlipEntity({
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

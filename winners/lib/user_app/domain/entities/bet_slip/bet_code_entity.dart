import 'package:equatable/equatable.dart';

import '../../../data/models/bet_slip/bet_code/data.dart';

class BetCodeEntity extends Equatable {
  final Data? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final num? serverDateTime;

  const BetCodeEntity({
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

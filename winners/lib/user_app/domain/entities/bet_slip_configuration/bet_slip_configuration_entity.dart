import 'package:winners/user_app/data/models/bet_slip_configuration/bet_slip_configuration_data.dart';
import 'package:equatable/equatable.dart';

class BetSlipConfigurationEntity extends Equatable {
  final BetSlipConfigurationData? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const BetSlipConfigurationEntity({
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

import 'package:winners/user_app/data/models/header/data.dart';
import 'package:equatable/equatable.dart';

class HeaderEntity extends Equatable {
  final HeaderModelData? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const HeaderEntity({
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

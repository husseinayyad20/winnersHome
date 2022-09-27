
import 'package:winners/user_app/data/models/banner/banner_data_model.dart';
import 'package:equatable/equatable.dart';

class BannerEntity extends Equatable {
  final BannerDataModel? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const BannerEntity({
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

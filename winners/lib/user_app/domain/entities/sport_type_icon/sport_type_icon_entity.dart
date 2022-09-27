import 'package:winners/user_app/data/models/sport_type_icon/data.dart';
import 'package:equatable/equatable.dart';

class SportTypeIconEntity extends Equatable {
  final Data? data;
  final int? status;
  final int? serverDateTime;

  final bool? success;

  const SportTypeIconEntity({
    this.data,
    this.status,
    this.serverDateTime,
    this.success,
  });

  @override
  List<Object?> get props {
    return [
      data,
      status,
      serverDateTime,
      success,
    ];
  }
}

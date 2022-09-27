import 'dart:convert';

import 'package:winners/user_app/domain/entities/page/page_entity.dart';
import 'package:equatable/equatable.dart';

import 'data.dart';

class PageModel extends Equatable {
  final Data? data;
  final int? status;
  final String? message;
  final bool? success;
  final dynamic detail;
  final int? serverDateTime;

  const PageModel({
    this.data,
    this.status,
    this.message,
    this.success,
    this.detail,
    this.serverDateTime,
  });
  PageEntity toEntity() => PageEntity(
        pageId: data == null ? 0 : data!.pageId,
        pageName: data!.pageName,
        pageText: data!.pageText,
        pageTitle: data!.pageTitle,
        id: data!.id,
        name: data!.name,
      );
  factory PageModel.fromMap(Map<String, dynamic> data) => PageModel(
        data: data['data'] == null
            ? null
            : Data.fromMap(data['data'] as Map<String, dynamic>),
        status: data['status'] as int?,
        message: data['message'] as String?,
        success: data['success'] as bool?,
        detail: data['detail'] as dynamic,
        serverDateTime: data['serverDateTime'] as int?,
      );

  Map<String, dynamic> toMap() => {
        'data': data?.toMap(),
        'status': status,
        'message': message,
        'success': success,
        'detail': detail,
        'serverDateTime': serverDateTime,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PageModel].
  factory PageModel.fromJson(String data) {
    return PageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PageModel] to a JSON string.
  String toJson() => json.encode(toMap());

  PageModel copyWith({
    Data? data,
    int? status,
    String? message,
    bool? success,
    dynamic detail,
    int? serverDateTime,
  }) {
    return PageModel(
      data: data ?? this.data,
      status: status ?? this.status,
      message: message ?? this.message,
      success: success ?? this.success,
      detail: detail ?? this.detail,
      serverDateTime: serverDateTime ?? this.serverDateTime,
    );
  }

  @override
  bool get stringify => true;

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

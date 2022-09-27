import 'dart:convert';
import 'package:equatable/equatable.dart';

class Data extends Equatable {
  final int? pageId;
  final String? pageName;
  final String? pageTitle;
  final String? pageText;
  final int? id;
  final dynamic name;

  const Data({
    this.pageId,
    this.pageName,
    this.pageTitle,
    this.pageText,
    this.id,
    this.name,
  });

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        pageId: data['pageId'] as int?,
        pageName: data['pageName'] as String?,
        pageTitle: data['pageTitle'] as String?,
        pageText: data['pageText'] as String?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'pageId': pageId,
        'pageName': pageName,
        'pageTitle': pageTitle,
        'pageText': pageText,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [Data].
  factory Data.fromJson(String data) {
    return Data.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [Data] to a JSON string.
  String toJson() => json.encode(toMap());

  Data copyWith({
    int? pageId,
    String? pageName,
    String? pageTitle,
    String? pageText,
    int? id,
    dynamic name,
  }) {
    return Data(
      pageId: pageId ?? this.pageId,
      pageName: pageName ?? this.pageName,
      pageTitle: pageTitle ?? this.pageTitle,
      pageText: pageText ?? this.pageText,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      pageId,
      pageName,
      pageTitle,
      pageText,
      id,
      name,
    ];
  }
}

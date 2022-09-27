import 'package:equatable/equatable.dart';

class PageEntity extends Equatable {
  final int? pageId;
  final String? pageName;
  final String? pageTitle;
  final String? pageText;
  final int? id;
  final dynamic name;

  const PageEntity({
    this.pageId,
    this.pageName,
    this.pageTitle,
    this.pageText,
    this.id,
    this.name,
  });

  PageEntity copyWith({
    int? pageId,
    String? pageName,
    String? pageTitle,
    String? pageText,
    int? id,
    dynamic name,
  }) {
    return PageEntity(
      pageId: pageId ?? this.pageId,
      pageName: pageName ?? this.pageName,
      pageTitle: pageTitle ?? this.pageTitle,
      pageText: pageText ?? this.pageText,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

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

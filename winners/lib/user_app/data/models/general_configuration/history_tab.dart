import 'dart:convert';

import 'package:equatable/equatable.dart';

class HistoryTab extends Equatable {
  final int? tabId;
  final String? tabtext;
  final int? id;
  final dynamic name;

  const HistoryTab({
    this.tabId,
    this.tabtext,
    this.id,
    this.name,
  });

  factory HistoryTab.fromMap(Map<String, dynamic> data) => HistoryTab(
        tabId: data['tabId'] as int?,
        tabtext: data['tabText'] as String?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'tabId': tabId,
        'tabText': tabtext,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [HistoryTab].
  factory HistoryTab.fromJson(String data) {
    return HistoryTab.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [HistoryTab] to a JSON string.
  String toJson() => json.encode(toMap());

  HistoryTab copyWith({
    int? formStatusId,
    String? formStatusName,
    int? id,
    dynamic name,
  }) {
    return HistoryTab(
      tabId: formStatusId ?? tabId,
      tabtext: formStatusName ?? tabtext,
      id: id ?? id,
      name: name ?? name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [tabId, tabtext, id, name];
}

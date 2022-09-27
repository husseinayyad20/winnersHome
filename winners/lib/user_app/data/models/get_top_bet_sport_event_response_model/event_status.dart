import 'dart:convert';

import 'package:equatable/equatable.dart';

class EventStatus extends Equatable {
  final int? eventStatusValue;
  final String? eventStatusDisplayName;
  final dynamic id;

  const EventStatus({
    this.eventStatusValue,
    this.eventStatusDisplayName,
    this.id,
  });

  factory EventStatus.fromMap(Map<String, dynamic> data) => EventStatus(
        eventStatusValue: data['eventStatusValue'] as int?,
        eventStatusDisplayName: data['eventStatusDisplayName'] as String?,
        id: data['id'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'eventStatusValue': eventStatusValue,
        'eventStatusDisplayName': eventStatusDisplayName,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [EventStatus].
  factory EventStatus.fromJson(String data) {
    return EventStatus.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [EventStatus] to a JSON string.
  String toJson() => json.encode(toMap());

  EventStatus copyWith({
    int? eventStatusValue,
    String? eventStatusDisplayName,
    dynamic id,
  }) {
    return EventStatus(
      eventStatusValue: eventStatusValue ?? this.eventStatusValue,
      eventStatusDisplayName:
          eventStatusDisplayName ?? this.eventStatusDisplayName,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      eventStatusValue,
      eventStatusDisplayName,
      id,
    ];
  }
}

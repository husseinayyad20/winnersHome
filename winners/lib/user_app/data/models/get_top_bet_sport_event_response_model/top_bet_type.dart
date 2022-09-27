import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'event_odd_field.dart';

class TopBetType extends Equatable {
  final String? betTypeDisplayName;
  final String? oddSpecialField;
  final int? activeOddId;
  final List<EventOddField>? eventOddFields;
  final String? key;
  final bool? isDefault;
  final int? clientHub;
  final dynamic defaultSpecialField;
  final int? topBetTypeOrder;
  final dynamic feed;
  final dynamic sport;
  final int? betTypeId;
  final String? betTypeName;
  final int? betTypeGroupId;
  final dynamic betTypeGroupName;
  final int? betTypeDisplayOrder;
  final dynamic betTypeDrillDownGroupName;
  final int? betTypeDrillDownGroupId;
  final int? betTypeDrillDownDisplayOrder;
  final dynamic id;

  const TopBetType({
    this.betTypeDisplayName,
    this.oddSpecialField,
    this.activeOddId,
    this.eventOddFields,
    this.key,
    this.isDefault,
    this.clientHub,
    this.defaultSpecialField,
    this.topBetTypeOrder,
    this.feed,
    this.sport,
    this.betTypeId,
    this.betTypeName,
    this.betTypeGroupId,
    this.betTypeGroupName,
    this.betTypeDisplayOrder,
    this.betTypeDrillDownGroupName,
    this.betTypeDrillDownGroupId,
    this.betTypeDrillDownDisplayOrder,
    this.id,
  });

  factory TopBetType.fromMap(Map<String, dynamic> data) => TopBetType(
        betTypeDisplayName: data['betTypeDisplayName'] as String?,
        oddSpecialField: data['oddSpecialField'] as String?,
        activeOddId: data['activeOddId'] as int?,
        eventOddFields: (data['eventOddFields'] as List<dynamic>?)
            ?.map((e) => EventOddField.fromMap(e as Map<String, dynamic>))
            .toList(),
        key: data['key'] as String?,
        isDefault: data['isDefault'] as bool?,
        clientHub: data['clientHub'] as int?,
        defaultSpecialField: data['defaultSpecialField'] as dynamic,
        topBetTypeOrder: data['topBetTypeOrder'] as int?,
        feed: data['feed'] as dynamic,
        sport: data['sport'] as dynamic,
        betTypeId: data['betTypeId'] as int?,
        betTypeName: data['betTypeName'] as String?,
        betTypeGroupId: data['betTypeGroupId'] as int?,
        betTypeGroupName: data['betTypeGroupName'] as dynamic,
        betTypeDisplayOrder: data['betTypeDisplayOrder'] as int?,
        betTypeDrillDownGroupName: data['betTypeDrillDownGroupName'] as dynamic,
        betTypeDrillDownGroupId: data['betTypeDrillDownGroupId'] as int?,
        betTypeDrillDownDisplayOrder:
            data['betTypeDrillDownDisplayOrder'] as int?,
        id: data['id'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'betTypeDisplayName': betTypeDisplayName,
        'oddSpecialField': oddSpecialField,
        'activeOddId': activeOddId,
        'eventOddFields': eventOddFields?.map((e) => e.toMap()).toList(),
        'key': key,
        'isDefault': isDefault,
        'clientHub': clientHub,
        'defaultSpecialField': defaultSpecialField,
        'topBetTypeOrder': topBetTypeOrder,
        'feed': feed,
        'sport': sport,
        'betTypeId': betTypeId,
        'betTypeName': betTypeName,
        'betTypeGroupId': betTypeGroupId,
        'betTypeGroupName': betTypeGroupName,
        'betTypeDisplayOrder': betTypeDisplayOrder,
        'betTypeDrillDownGroupName': betTypeDrillDownGroupName,
        'betTypeDrillDownGroupId': betTypeDrillDownGroupId,
        'betTypeDrillDownDisplayOrder': betTypeDrillDownDisplayOrder,
        'id': id,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [TopBetType].
  factory TopBetType.fromJson(String data) {
    return TopBetType.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [TopBetType] to a JSON string.
  String toJson() => json.encode(toMap());

  TopBetType copyWith({
    String? oddSpecialField,
    int? activeOddId,
    List<EventOddField>? eventOddFields,
    String? key,
    bool? isDefault,
    int? clientHub,
    dynamic defaultSpecialField,
    int? topBetTypeOrder,
    dynamic feed,
    dynamic sport,
    int? betTypeId,
    String? betTypeName,
    int? betTypeGroupId,
    dynamic betTypeGroupName,
    int? betTypeDisplayOrder,
    dynamic betTypeDrillDownGroupName,
    int? betTypeDrillDownGroupId,
    int? betTypeDrillDownDisplayOrder,
    dynamic id,
  }) {
    return TopBetType(
      oddSpecialField: oddSpecialField ?? this.oddSpecialField,
      activeOddId: activeOddId ?? this.activeOddId,
      eventOddFields: eventOddFields ?? this.eventOddFields,
      key: key ?? this.key,
      isDefault: isDefault ?? this.isDefault,
      clientHub: clientHub ?? this.clientHub,
      defaultSpecialField: defaultSpecialField ?? this.defaultSpecialField,
      topBetTypeOrder: topBetTypeOrder ?? this.topBetTypeOrder,
      feed: feed ?? this.feed,
      sport: sport ?? this.sport,
      betTypeId: betTypeId ?? this.betTypeId,
      betTypeName: betTypeName ?? this.betTypeName,
      betTypeGroupId: betTypeGroupId ?? this.betTypeGroupId,
      betTypeGroupName: betTypeGroupName ?? this.betTypeGroupName,
      betTypeDisplayOrder: betTypeDisplayOrder ?? this.betTypeDisplayOrder,
      betTypeDrillDownGroupName:
          betTypeDrillDownGroupName ?? this.betTypeDrillDownGroupName,
      betTypeDrillDownGroupId:
          betTypeDrillDownGroupId ?? this.betTypeDrillDownGroupId,
      betTypeDrillDownDisplayOrder:
          betTypeDrillDownDisplayOrder ?? this.betTypeDrillDownDisplayOrder,
      id: id ?? this.id,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      oddSpecialField,
      activeOddId,
      eventOddFields,
      key,
      isDefault,
      clientHub,
      defaultSpecialField,
      topBetTypeOrder,
      feed,
      sport,
      betTypeId,
      betTypeName,
      betTypeGroupId,
      betTypeGroupName,
      betTypeDisplayOrder,
      betTypeDrillDownGroupName,
      betTypeDrillDownGroupId,
      betTypeDrillDownDisplayOrder,
      id,
    ];
  }
}

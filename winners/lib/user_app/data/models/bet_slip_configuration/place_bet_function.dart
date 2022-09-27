import 'dart:convert';

import 'package:equatable/equatable.dart';

class PlaceBetFunction extends Equatable {
  final int? placeBetFunctionId;
  final String? option;
  final String? optionText;
  final bool? optionIsDefault;
  final bool? active;
  final int? id;
  final dynamic name;

  const PlaceBetFunction({
    this.placeBetFunctionId,
    this.option,
    this.optionText,
    this.optionIsDefault,
    this.active,
    this.id,
    this.name,
  });

  factory PlaceBetFunction.fromMap(Map<String, dynamic> data) {
    return PlaceBetFunction(
      placeBetFunctionId: data['placeBetFunctionId'] as int?,
      option: data['option'] as String?,
      optionText: data['optionText'] as String?,
      optionIsDefault: data['optionIsDefault'] as bool?,
      active: data['active'] as bool?,
      id: data['id'] as int?,
      name: data['name'] as dynamic,
    );
  }

  Map<String, dynamic> toMap() => {
        'placeBetFunctionId': placeBetFunctionId,
        'option': option,
        'optionText': optionText,
        'optionIsDefault': optionIsDefault,
        'active': active,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [PlaceBetFunction].
  factory PlaceBetFunction.fromJson(String data) {
    return PlaceBetFunction.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [PlaceBetFunction] to a JSON string.
  String toJson() => json.encode(toMap());

  PlaceBetFunction copyWith({
    int? placeBetFunctionId,
    String? option,
    String? optionText,
    bool? optionIsDefault,
    bool? active,
    int? id,
    dynamic name,
  }) {
    return PlaceBetFunction(
      placeBetFunctionId: placeBetFunctionId ?? this.placeBetFunctionId,
      option: option ?? this.option,
      optionText: optionText ?? this.optionText,
      optionIsDefault: optionIsDefault ?? this.optionIsDefault,
      active: active ?? this.active,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      placeBetFunctionId,
      option,
      optionText,
      optionIsDefault,
      active,
      id,
      name,
    ];
  }
}

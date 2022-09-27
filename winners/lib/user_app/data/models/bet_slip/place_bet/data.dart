import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'member.dart';
import 'singles_bet_form_detail.dart';

class Data extends Equatable {
  final List<SinglesBetFormDetail>? singlesBetFormDetails;
  final Member? member;
  final int? id;
  final dynamic name;

  const Data({this.singlesBetFormDetails, this.member, this.id, this.name});

  factory Data.fromMap(Map<String, dynamic> data) => Data(
        singlesBetFormDetails: (data['singlesBetFormDetails'] as List<dynamic>?)
            ?.map(
                (e) => SinglesBetFormDetail.fromMap(e as Map<String, dynamic>))
            .toList(),
        member: data['member'] == null
            ? null
            : Member.fromMap(data['member'] as Map<String, dynamic>),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'singlesBetFormDetails':
            singlesBetFormDetails?.map((e) => e.toMap()).toList(),
        'member': member?.toMap(),
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
    List<SinglesBetFormDetail>? singlesBetFormDetails,
    Member? member,
    int? id,
    dynamic name,
  }) {
    return Data(
      singlesBetFormDetails:
          singlesBetFormDetails ?? this.singlesBetFormDetails,
      member: member ?? this.member,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [singlesBetFormDetails, member, id, name];
}

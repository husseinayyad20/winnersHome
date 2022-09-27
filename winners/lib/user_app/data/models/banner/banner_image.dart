import 'dart:convert';

import 'package:equatable/equatable.dart';

class BannerImageModel extends Equatable {
  final int? bannerId;
  final int? bannerType;
  final String? bannerPath;
  final int? sportType;
  final int? id;
  final dynamic name;

  const BannerImageModel({
    this.bannerId,
    this.bannerType,
    this.bannerPath,
    this.sportType,
    this.id,
    this.name,
  });

  factory BannerImageModel.fromMap(Map<String, dynamic> data) =>
      BannerImageModel(
        bannerId: data['bannerID'] as int?,
        bannerType: data['bannerType'] as int?,
        bannerPath: data['bannerPath'] as String?,
        sportType: data['sportType'] as int?,
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'bannerID': bannerId,
        'bannerType': bannerType,
        'bannerPath': bannerPath,
        'sportType': sportType,
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BannerImageModel].
  factory BannerImageModel.fromJson(String data) {
    return BannerImageModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BannerImageModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BannerImageModel copyWith({
    int? bannerId,
    int? bannerType,
    String? bannerPath,
    int? sportType,
    int? id,
    dynamic name,
  }) {
    return BannerImageModel(
      bannerId: bannerId ?? this.bannerId,
      bannerType: bannerType ?? this.bannerType,
      bannerPath: bannerPath ?? this.bannerPath,
      sportType: sportType ?? this.sportType,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props =>
      [bannerId, bannerType, bannerPath, sportType, id, name];
}

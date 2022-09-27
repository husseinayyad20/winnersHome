import 'dart:convert';

import 'package:winners/user_app/data/models/banner/banner_image.dart';
import 'package:equatable/equatable.dart';

class BannerDataModel extends Equatable {
  final List<BannerImageModel>? bannerImages;
  final int? id;
  final dynamic name;

  const BannerDataModel({this.bannerImages, this.id, this.name});

  factory BannerDataModel.fromMap(Map<String, dynamic> data) => BannerDataModel(
        bannerImages: (data['bannerImages'] as List<dynamic>?)
            ?.map((e) => BannerImageModel.fromMap(e as Map<String, dynamic>))
            .toList(),
        id: data['id'] as int?,
        name: data['name'] as dynamic,
      );

  Map<String, dynamic> toMap() => {
        'bannerImages': bannerImages?.map((e) => e.toMap()).toList(),
        'id': id,
        'name': name,
      };

  /// `dart:convert`
  ///
  /// Parses the string and returns the resulting Json object as [BannerDataModel].
  factory BannerDataModel.fromJson(String data) {
    return BannerDataModel.fromMap(json.decode(data) as Map<String, dynamic>);
  }

  /// `dart:convert`
  ///
  /// Converts [BannerDataModel] to a JSON string.
  String toJson() => json.encode(toMap());

  BannerDataModel copyWith({
    List<BannerImageModel>? bannerImages,
    int? id,
    dynamic name,
  }) {
    return BannerDataModel(
      bannerImages: bannerImages ?? this.bannerImages,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [bannerImages, id, name];
}

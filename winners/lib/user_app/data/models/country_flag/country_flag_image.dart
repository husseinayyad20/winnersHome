import 'package:equatable/equatable.dart';

class CountryFlagImage extends Equatable {
  final int? countryFlagImagesId;
  final String? countryFlagImagesName;
  final int? feedId;
  final int? sportId;
  final int? sportCategoryId;
  final String? countryName;
  final int? id;
  final dynamic name;

  const CountryFlagImage({
    this.countryFlagImagesId,
    this.countryFlagImagesName,
    this.feedId,
    this.sportId,
    this.sportCategoryId,
    this.countryName,
    this.id,
    this.name,
  });

  factory CountryFlagImage.fromJson(Map<String, dynamic> json) =>
      CountryFlagImage(
        countryFlagImagesId: json['countryFlagImagesID'] as int?,
        countryFlagImagesName: json['countryFlagImagesName'] as String?,
        feedId: json['feedId'] as int?,
        sportId: json['sportId'] as int?,
        sportCategoryId: json['sportCategoryId'] as int?,
        countryName: json['countryName'] as String?,
        id: json['id'] as int?,
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'countryFlagImagesID': countryFlagImagesId,
        'countryFlagImagesName': countryFlagImagesName,
        'feedId': feedId,
        'sportId': sportId,
        'sportCategoryId': sportCategoryId,
        'countryName': countryName,
        'id': id,
        'name': name,
      };

  CountryFlagImage copyWith({
    int? countryFlagImagesId,
    String? countryFlagImagesName,
    int? feedId,
    int? sportId,
    int? sportCategoryId,
    String? countryName,
    int? id,
    dynamic name,
  }) {
    return CountryFlagImage(
      countryFlagImagesId: countryFlagImagesId ?? this.countryFlagImagesId,
      countryFlagImagesName:
          countryFlagImagesName ?? this.countryFlagImagesName,
      feedId: feedId ?? this.feedId,
      sportId: sportId ?? this.sportId,
      sportCategoryId: sportCategoryId ?? this.sportCategoryId,
      countryName: countryName ?? this.countryName,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props {
    return [
      countryFlagImagesId,
      countryFlagImagesName,
      feedId,
      sportId,
      sportCategoryId,
      countryName,
      id,
      name,
    ];
  }
}

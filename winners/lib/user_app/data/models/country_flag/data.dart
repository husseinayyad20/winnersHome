import 'package:equatable/equatable.dart';

import 'country_flag_image.dart';

class Data extends Equatable {
  final List<CountryFlagImage>? countryFlagImages;
  final int? id;
  final dynamic name;

  const Data({this.countryFlagImages, this.id, this.name});

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        countryFlagImages: (json['countryFlagImages'] as List<dynamic>?)
            ?.map((e) => CountryFlagImage.fromJson(e as Map<String, dynamic>))
            .toList(),
        id: json['id'] as int?,
        name: json['name'],
      );

  Map<String, dynamic> toJson() => {
        'countryFlagImages': countryFlagImages?.map((e) => e.toJson()).toList(),
        'id': id,
        'name': name,
      };

  Data copyWith({
    List<CountryFlagImage>? countryFlagImages,
    int? id,
    dynamic name,
  }) {
    return Data(
      countryFlagImages: countryFlagImages ?? this.countryFlagImages,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [countryFlagImages, id, name];
}

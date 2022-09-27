import 'package:winners/user_app/data/models/teams_icons/teams_icon.dart';
import 'package:equatable/equatable.dart';

class TeamsIconsDataEntity extends Equatable {
  final List<TeamsIconModel>? teamsIcons;
  final int? id;
  final dynamic name;

  const TeamsIconsDataEntity({this.teamsIcons, this.id, this.name});

  TeamsIconsDataEntity copyWith({
    List<TeamsIconModel>? teamsIcons,
    int? id,
    dynamic name,
  }) {
    return TeamsIconsDataEntity(
      teamsIcons: teamsIcons ?? this.teamsIcons,
      id: id ?? this.id,
      name: name ?? this.name,
    );
  }

  @override
  bool get stringify => true;

  @override
  List<Object?> get props => [teamsIcons, id, name];
}

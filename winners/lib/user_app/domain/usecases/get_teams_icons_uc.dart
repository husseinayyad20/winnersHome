import 'package:winners/user_app/domain/entities/teams_icons_entity/teams_icons_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_teams_icons_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:winners/user_app/data/failure.dart';

class GetTeamsIconsUC {
  final ITeamsIconsRepository repository;

  GetTeamsIconsUC(this.repository);

  Future<Either<Failure, TeamsIconsDataEntity>> execute() {
    return repository.get();
  }
}

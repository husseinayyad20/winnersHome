import 'package:winners/user_app/data/failure.dart';

import 'package:winners/user_app/domain/entities/teams_icons_entity/teams_icons_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ITeamsIconsRepository {
  Future<Either<Failure, TeamsIconsDataEntity>> get();
}

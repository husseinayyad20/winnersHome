import 'package:winners/user_app/domain/entities/banner/banner_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_banner_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:winners/user_app/data/failure.dart';

class GetBannerUC {
  final IBannerRepository repository;

  GetBannerUC(this.repository);

  Future<Either<Failure, BannerEntity>> execute() {
    return repository.getBanners();
  }
}

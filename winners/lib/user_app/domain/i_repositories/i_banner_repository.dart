import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/banner/banner_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IBannerRepository {
  Future<Either<Failure, BannerEntity>> getBanners();
}

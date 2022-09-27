
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/page/page_entity.dart';
import 'package:dartz/dartz.dart';

abstract class IPageRepository {
  Future<Either<Failure, PageEntity>> getPage(String pageName);
}

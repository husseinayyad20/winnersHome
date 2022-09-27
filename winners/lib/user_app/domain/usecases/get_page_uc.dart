
import 'package:winners/user_app/data/failure.dart';
import 'package:winners/user_app/domain/entities/page/page_entity.dart';
import 'package:winners/user_app/domain/i_repositories/i_pages_repository.dart';
import 'package:dartz/dartz.dart';


class GetPageUC {
  final IPageRepository repository;

  GetPageUC(this.repository);

  Future<Either<Failure, PageEntity>> execute(String pageName) {
    return repository.getPage(pageName);
  }
}

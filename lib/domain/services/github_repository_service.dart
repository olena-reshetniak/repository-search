import 'package:dartz/dartz.dart';
import 'package:repository_search/domain/entity/repository.dart';

abstract class GitHubRepositoryService {
  Future<Either<Exception, List<Repository>>> searchRepositories(
    String searchValue,
  );

  Future<Either<Exception, List<Repository>>> getSearchHistory();

  Future<void> addFavoriteItem(
    Repository repository,
  );

  Future<void> deleteFavoriteItem(
    Repository repository,
  );

  Future<Either<Exception, List<Repository>>> getFavoriteRepositories();
}

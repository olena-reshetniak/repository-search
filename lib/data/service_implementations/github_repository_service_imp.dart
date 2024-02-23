import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:repository_search/data/api/github_repository_api.dart.dart';
import 'package:repository_search/domain/entity/repository.dart';
import 'package:repository_search/domain/services/github_repository_service.dart';

@LazySingleton(as: GitHubRepositoryService)
class GitHubRepositoryServiceImp extends GitHubRepositoryService {
  final GitHubRepositoryApi repoApiService;

  GitHubRepositoryServiceImp({
    required this.repoApiService,
  });

  @override
  Future<Either<Exception, List<Repository>>> searchRepositories(
    String searchValue,
  ) async {
    final result = await repoApiService.searchRepositories(searchValue);

    return result.fold(
      (error) {
        return Left(error);
      },
      (response) {
        return Right(
          Repository.mapperFromSearchRepositoriesResponse(
            response,
          ),
        );
      },
    );
  }

  @override
  Future<Either<Exception, List<Repository>>> getSearchHistory() async {
    // TODO: implement getRepositoriesHistory
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, void>> updateFavoriteRepositoriesList(
    Repository repository,
  ) async {
    // TODO: implement updateFavoriteRepositoriesList
    throw UnimplementedError();
  }

  @override
  Future<Either<Exception, List<Repository>>> getFavoriteRepos() async {
    // TODO: implement getFavoriteRepos
    throw UnimplementedError();
  }
}

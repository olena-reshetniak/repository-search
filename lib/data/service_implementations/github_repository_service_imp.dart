import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:repository_search/data/api/github_repository_api.dart.dart';
import 'package:repository_search/data/preferences/preferences.dart';
import 'package:repository_search/data/response/search_repositories_response.dart';
import 'package:repository_search/domain/entity/repository.dart';
import 'package:repository_search/domain/services/github_repository_service.dart';

@LazySingleton(as: GitHubRepositoryService)
class GitHubRepositoryServiceImp extends GitHubRepositoryService {
  final GitHubRepositoryApi repoApiService;
  final Preferences preferences;

  GitHubRepositoryServiceImp({
    required this.repoApiService,
    required this.preferences,
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
        preferences.setSearchHistory(json.encode(response.toJson()));

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
    try {
      final result = await preferences.getSearchHistory();

      if (result.isNotEmpty) {
        final repositories =
            SearchRepositoriesResponse.fromJson(json.decode(result));

        return Right(
          Repository.mapperFromSearchRepositoriesResponse(
            repositories,
          ),
        );
      } else {
        return const Right([]);
      }
    } on Exception catch (exception) {
      return Left(exception);
    }
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

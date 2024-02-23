import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:repository_search/data/api/github_repository_api.dart';
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

    final favoriteResult = await preferences.getFavoriteList();

    List<Repository> favoriteRepositories = [];

    if (favoriteResult.isNotEmpty) {
      favoriteRepositories = Repository.mapperFavoriteRepositories(
        SearchRepositoriesResponse.fromJson(json.decode(favoriteResult)),
      );
    }

    return result.fold(
      (error) {
        return Left(error);
      },
      (response) {
        preferences.setSearchHistory(json.encode(response.toJson()));

        return Right(
          Repository.mapperFromSearchRepositoriesResponse(
            response,
            favoriteRepositories,
          ),
        );
      },
    );
  }

  @override
  Future<Either<Exception, List<Repository>>> getSearchHistory() async {
    try {
      final result = await preferences.getSearchHistory();

      final favoriteResult = await preferences.getFavoriteList();

      List<Repository> favoriteRepositories = [];

      if (favoriteResult.isNotEmpty) {
        favoriteRepositories = Repository.mapperFavoriteRepositories(
          SearchRepositoriesResponse.fromJson(json.decode(favoriteResult)),
        );
      }

      if (result.isNotEmpty) {
        final repositories =
            SearchRepositoriesResponse.fromJson(json.decode(result));

        return Right(
          Repository.mapperFromSearchRepositoriesResponse(
            repositories,
            favoriteRepositories,
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
  Future<void> addFavoriteItem(Repository repository) async {
    final result = await preferences.getFavoriteList();

    List<Repository> favoriteRepositories = [];

    if (result.isNotEmpty) {
      favoriteRepositories = Repository.mapperFavoriteRepositories(
        SearchRepositoriesResponse.fromJson(json.decode(result)),
      );
    }

    favoriteRepositories.add(repository);

    preferences.setFavoriteList(
      json.encode(
        Repository.mapperToSearchRepositoriesResponse(
          favoriteRepositories,
        ).toJson(),
      ),
    );
  }

  @override
  Future<void> deleteFavoriteItem(Repository repository) async {
    final result = await preferences.getFavoriteList();

    List<Repository> newFavoriteRepositories = [];

    if (result.isNotEmpty) {
      final favoriteRepositories = Repository.mapperFavoriteRepositories(
        SearchRepositoriesResponse.fromJson(json.decode(result)),
      );

      for (var item in favoriteRepositories) {
        if (item.id != repository.id) {
          newFavoriteRepositories.add(item);
        }
      }
    }

    preferences.setFavoriteList(
      json.encode(
        Repository.mapperToSearchRepositoriesResponse(
          newFavoriteRepositories,
        ).toJson(),
      ),
    );
  }

  @override
  Future<Either<Exception, List<Repository>>> getFavoriteRepositories() async {
    try {
      final result = await preferences.getFavoriteList();

      if (result.isNotEmpty) {
        final repositories =
            SearchRepositoriesResponse.fromJson(json.decode(result));

        return Right(
          Repository.mapperFavoriteRepositories(
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
}

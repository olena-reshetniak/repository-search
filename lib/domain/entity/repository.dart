import 'package:repository_search/data/response/search_repositories_response.dart';

class Repository {
  final int id;
  final String name;
  final bool isFavorite;

  Repository({
    required this.id,
    required this.name,
    required this.isFavorite,
  });

  static List<Repository> mapperFromSearchRepositoriesResponse(
    SearchRepositoriesResponse response,
    List<Repository> favoriteList,
  ) {
    List<Repository> list = [];
    for (var item in response.items) {
      var test = 0;
      for (var favoriteItem in favoriteList) {
        if (favoriteItem.id == item.id) {
          test = 1;
        }
      }

      list.add(
        Repository.mapperFromResponse(
          item,
          test != 0,
        ),
      );
    }

    return list;
  }

  static List<Repository> mapperFavoriteRepositories(
    SearchRepositoriesResponse response,
  ) {
    List<Repository> list = [];
    for (var item in response.items) {
      list.add(Repository.mapperFromResponse(
        item,
        true,
      ));
    }

    return list;
  }

  factory Repository.mapperFromResponse(
    RepositoryResponse response,
    bool isFavorite,
  ) {
    return Repository(
      id: response.id,
      name: response.name,
      isFavorite: isFavorite,
    );
  }

  static SearchRepositoriesResponse mapperToSearchRepositoriesResponse(
    List<Repository> repositories,
  ) {
    List<RepositoryResponse> list = [];
    for (var item in repositories) {
      list.add(mapperToResponse(item));
    }

    return SearchRepositoriesResponse(
      items: list,
    );
  }

  static RepositoryResponse mapperToResponse(
    Repository repository,
  ) {
    return RepositoryResponse(
      id: repository.id,
      name: repository.name,
    );
  }
}

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
  ) {
    List<Repository> list = [];
    for (var item in response.items) {
      list.add(Repository.mapperFromResponse(item));
    }

    return list;
  }

  factory Repository.mapperFromResponse(
    RepositoryResponse response,
  ) {
    return Repository(
      id: response.id,
      name: response.name,
      isFavorite: false,
    );
  }
}

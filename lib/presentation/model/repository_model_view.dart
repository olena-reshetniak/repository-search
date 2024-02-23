import 'package:repository_search/domain/entity/repository.dart';

class RepositoryModelView {
  final int id;
  final String name;
  final bool isFavorite;

  RepositoryModelView({
    required this.id,
    required this.name,
    required this.isFavorite,
  });

  static List<RepositoryModelView> mapperList(
    List<Repository> repositories,
  ) {
    List<RepositoryModelView> list = [];
    for (var item in repositories) {
      list.add(RepositoryModelView.mapperItem(item));
    }

    return list;
  }

  factory RepositoryModelView.mapperItem(
    Repository repository,
  ) {
    return RepositoryModelView(
      id: repository.id,
      name: repository.name,
      isFavorite: repository.isFavorite,
    );
  }
}

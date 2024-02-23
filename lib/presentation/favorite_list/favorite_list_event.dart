part of 'favorite_list_bloc.dart';

@freezed
class FavoriteListEvent with _$FavoriteListEvent {
  const factory FavoriteListEvent.getFavoriteList() = _GetFavoriteList;

  const factory FavoriteListEvent.updateFavoriteList(
    RepositoryModelView repository,
  ) = _UpdateFavoriteList;
}

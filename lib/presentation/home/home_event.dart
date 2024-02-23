part of 'home_bloc.dart';

@freezed
class HomeEvent with _$HomeEvent {
  const factory HomeEvent.showSearchHistory() = _ShowSearchHistory;

  const factory HomeEvent.updateFavoriteList(
      RepositoryModelView repository,
      ) = _UpdateFavoriteList;

  const factory HomeEvent.search(
    String value,
  ) = _Search;
}

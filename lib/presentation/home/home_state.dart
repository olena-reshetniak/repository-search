part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  factory HomeState.initial() => HomeState();

  factory HomeState({
    @Default(false) bool isLoading,
    @Default([]) List<RepositoryModelView> searchHistory,
    @Default("") String searchValue,
    RepositoryModelView? repository,
    @Default([]) List<RepositoryModelView> searchResult,
  }) = _HomeState;
}

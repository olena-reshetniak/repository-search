part of 'favorite_list_bloc.dart';

@freezed
class FavoriteListState with _$FavoriteListState {
  factory FavoriteListState.initial() => FavoriteListState();

  factory FavoriteListState({
    @Default(false) bool isLoading,
    RepositoryModelView? repository,
    @Default([]) List<RepositoryModelView> list,
  }) = _FavoriteListState;
}

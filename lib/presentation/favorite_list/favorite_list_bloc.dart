import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:repository_search/domain/services/github_repository_service.dart';
import 'package:repository_search/presentation/model/repository_model_view.dart';

part 'favorite_list_bloc.freezed.dart';

part 'favorite_list_event.dart';

part 'favorite_list_state.dart';

@injectable
class FavoriteListBloc extends Bloc<FavoriteListEvent, FavoriteListState> {
  final GitHubRepositoryService reposRepository;

  FavoriteListBloc({
    required this.reposRepository,
  }) : super(FavoriteListState.initial()) {
    on<_GetFavoriteList>(_onGetFavoriteList);
    on<_UpdateFavoriteList>(_onUpdateFavoriteList);
  }

  Future<void> _onGetFavoriteList(
    _GetFavoriteList event,
    Emitter<FavoriteListState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final result = await reposRepository.getFavoriteRepositories();

    result.fold((error) {
      emit(state.copyWith(
        isLoading: false,
      ));
    }, (repositories) {
      emit(state.copyWith(
        isLoading: false,
        list: RepositoryModelView.mapperList(repositories),
      ));
    });
  }

  Future<void> _onUpdateFavoriteList(
    _UpdateFavoriteList event,
    Emitter<FavoriteListState> emit,
  ) async {
    if (event.repository.isFavorite) {
      await reposRepository.deleteFavoriteItem(
        RepositoryModelView.mapperToRepository(
          event.repository,
        ),
      );
    } else {
      await reposRepository.addFavoriteItem(
        RepositoryModelView.mapperToRepository(
          event.repository,
        ),
      );
    }

    emit(
      state.copyWith(
        repository: event.repository,
      ),
    );
  }
}

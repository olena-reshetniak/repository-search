import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:repository_search/domain/services/github_repository_service.dart';
import 'package:repository_search/presentation/model/repository_model_view.dart';

part 'home_bloc.freezed.dart';

part 'home_event.dart';

part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GitHubRepositoryService reposRepository;

  HomeBloc({
    required this.reposRepository,
  }) : super(HomeState.initial()) {
    on<_ShowSearchHistory>(_onShowSearchHistory);
    on<_Search>(_onSearch);
    on<_UpdateFavoriteList>(_onUpdateFavoriteList);
  }

  Future<void> _onShowSearchHistory(
    _ShowSearchHistory event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final result = await reposRepository.getSearchHistory();

    result.fold((error) {
      emit(state.copyWith(
        isLoading: false,
      ));
    }, (repositories) {
      emit(state.copyWith(
        isLoading: false,
        searchHistory: RepositoryModelView.mapperList(repositories),
      ));
    });
  }

  Future<void> _onSearch(
    _Search event,
    Emitter<HomeState> emit,
  ) async {
    emit(state.copyWith(
      searchValue: event.value,
    ));

    if (event.value.isNotEmpty) {
      emit(state.copyWith(
        isLoading: true,
      ));

      final result = await reposRepository.searchRepositories(
        event.value,
      );

      result.fold((error) {
        emit(state.copyWith(
          isLoading: false,
        ));
      }, (repositories) {
        emit(state.copyWith(
          isLoading: false,
          searchResult: RepositoryModelView.mapperList(repositories),
        ));
      });
    } else {
      add(
        const HomeEvent.showSearchHistory(),
      );
    }
  }

  Future<void> _onUpdateFavoriteList(
    _UpdateFavoriteList event,
    Emitter<HomeState> emit,
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

    if (state.searchValue.isEmpty) {
      add(
        const HomeEvent.showSearchHistory(),
      );
    } else {
      add(
        HomeEvent.search(state.searchValue),
      );
    }
  }
}

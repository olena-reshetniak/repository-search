import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

part 'splash_bloc.freezed.dart';
part 'splash_event.dart';
part 'splash_state.dart';

@injectable
class SplashBloc extends Bloc<SplashEvent, SplashState> {
  SplashBloc() : super(SplashState.initial()) {
    on<_CheckSession>(_onCheckSession);
  }

  Future<void> _onCheckSession(
    _CheckSession event,
    Emitter<SplashState> emit,
  ) async {
    await Future.delayed(
      const Duration(seconds: 5),
    );

    emit(
      state.copyWith(
        openHomeScreen: true,
      ),
    );
  }
}

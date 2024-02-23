part of 'splash_bloc.dart';

@freezed
class SplashState with _$SplashState {
  factory SplashState.initial() => SplashState();

  factory SplashState({
    bool? openHomeScreen,
  }) = _SplashState;
}

part of 'splash_cubit.dart';

@immutable
sealed class SplashState {}

final class SplashInitial extends SplashState {
  final bool loaded;

  SplashInitial({required this.loaded});
}

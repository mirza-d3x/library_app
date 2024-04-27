// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit() : super(SplashInitial(loaded: false));

  void splashDelay() {
    // Add a 2-second delay before emitting the SplashInitial state
    Future.delayed(const Duration(seconds: 2), () {
      emit(SplashInitial(loaded: true));
    });
  }
}

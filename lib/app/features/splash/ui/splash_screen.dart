import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:library_app/app/features/splash/cubit/splash_cubit.dart';
import 'package:library_app/constants/assets.dart';
import 'package:library_app/services/navigation_services/navigation_services.dart';
import 'package:lottie/lottie.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    BlocProvider.of<SplashCubit>(context).splashDelay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SplashCubit, SplashState>(
      listener: (context, state) {
        if (state is SplashInitial) {
          if (state.loaded) {
            NavigationServices().createBooksPageRouteBuilder(context);
          }
        }
      },
      child: Scaffold(
        body: Container(
          color: const Color(0xff2382AA),
          alignment: Alignment.center,
          child: Lottie.asset(
            Assets.splashIcon,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:repository_search/presentation/home/home_screen.dart';
import 'package:repository_search/presentation/resources/colors/color_resources.dart';
import 'package:repository_search/presentation/resources/strings/strings_resources.dart';
import 'package:repository_search/presentation/resources/styles/text_style_resources.dart';
import 'package:repository_search/presentation/splash/splash_bloc.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    context.read<SplashBloc>().add(const SplashEvent.checkSession());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SplashBloc, SplashState>(
      listener: _onSplashBlocListener,
      builder: (context, status) {
        return Scaffold(
          backgroundColor: ColorResources.primaryColor,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                StringsResources.appName,
                style: TextStyleResources.header.copyWith(
                  color: ColorResources.secondaryColor,
                ),
              ),
              const SizedBox(
                height: 50,
              ),
              SpinKitFadingCircle(
                color: ColorResources.secondaryColor,
              ),
            ],
          ),
        );
      },
    );
  }

  void _onSplashBlocListener(
    BuildContext context,
    SplashState state,
  ) {
    if (state.openHomeScreen == true) {
      _openHomeScreen();
    }
  }

  void _openHomeScreen() {
    Navigator.pushNamed(
      context,
      HomeScreen.routeName,
    );
  }
}

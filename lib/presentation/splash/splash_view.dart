import 'package:flutter/material.dart';
import 'package:repository_search/presentation/resources/colors/color_resources.dart';

class SplashView extends StatefulWidget {
  const SplashView({Key? key}) : super(key: key);

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorResources.backgroundColor,
      body: SafeArea(
        child: Container(),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:repository_search/presentation/favorite_list/favorite_list_screen.dart';
import 'package:repository_search/presentation/home/home_screen.dart';
import 'package:repository_search/presentation/splash/splash_screen.dart';

class RepositorySearchApp extends StatelessWidget {
  const RepositorySearchApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        HomeScreen.routeName: (context) => const HomeScreen(),
        FavoriteListScreen.routeName: (context) => const FavoriteListScreen(),
      },
    );
  }
}

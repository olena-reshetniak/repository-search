import 'package:flutter/material.dart';
import 'package:repository_search/presentation/splash/splash_screen.dart';

class RepositorySearchApp extends StatelessWidget {
  const RepositorySearchApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home: SplashScreen(),
    );
  }
}
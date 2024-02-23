import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_search/di/injectable.dart';
import 'package:repository_search/presentation/favorite_list/favorite_list_bloc.dart';
import 'package:repository_search/presentation/home/home_bloc.dart';
import 'package:repository_search/presentation/home/home_view.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => getIt<HomeBloc>(),
        ),
        BlocProvider(
          create: (context) => getIt<FavoriteListBloc>(),
        ),
      ],
      child: const HomeView(),
    );
  }
}

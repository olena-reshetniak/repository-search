import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:repository_search/di/injectable.dart';
import 'package:repository_search/presentation/favorite_list/favorite_list_bloc.dart';
import 'package:repository_search/presentation/favorite_list/favorite_list_view.dart';

class FavoriteListScreen extends StatefulWidget {
  static const String routeName = '/favorite_list';

  const FavoriteListScreen({Key? key}) : super(key: key);

  @override
  State<FavoriteListScreen> createState() => _FavoriteListScreenState();
}

class _FavoriteListScreenState extends State<FavoriteListScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<FavoriteListBloc>(),
      child: const FavoriteListView(),
    );
  }
}

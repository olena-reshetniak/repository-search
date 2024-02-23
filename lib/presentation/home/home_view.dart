import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:repository_search/presentation/home/home_bloc.dart';
import 'package:repository_search/presentation/model/repository_model_view.dart';
import 'package:repository_search/presentation/resources/colors/color_resources.dart';
import 'package:repository_search/presentation/resources/strings/strings_resources.dart';
import 'package:repository_search/presentation/resources/styles/text_style_resources.dart';
import 'package:repository_search/presentation/widgets/repositories_list_widget.dart';
import 'package:repository_search/presentation/widgets/search_field_widget.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final TextEditingController _searchValueController = TextEditingController();

  @override
  void initState() {
    context.read<HomeBloc>().add(const HomeEvent.showSearchHistory());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
      listener: _onSplashBlocListener,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorResources.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorResources.backgroundColor,
            title: Text(
              StringsResources.homeScreenAppBarTitle,
              style: TextStyleResources.header.copyWith(
                color: ColorResources.textPrimaryColor,
              ),
            ),
            elevation: 0.0,
            shape: Border(
              bottom: BorderSide(
                width: 3,
                color: ColorResources.borderColor,
              ),
            ),
            leading: const SizedBox.square(),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SearchFieldWidget(
                  controller: _searchValueController,
                  hint: StringsResources.search,
                  onChangedValue: (String value) {
                    context.read<HomeBloc>().add(
                        HomeEvent.search(_searchValueController.value.text));
                  },
                ),
                state.isLoading
                    ? SpinKitFadingCircle(
                        color: ColorResources.primaryColor,
                      )
                    : state.searchValue.isEmpty
                        ? RepositoriesListWidget(
                            repositories: state.searchHistory,
                            title: StringsResources.searchHistory,
                            emptyList: StringsResources.emptyListSearchHistory,
                            updateFavoriteStatus: _onUpdateFavoriteStatus,
                          )
                        : RepositoriesListWidget(
                            repositories: state.searchResult,
                            title: StringsResources.whatWeFound,
                            emptyList: StringsResources.emptyListSearchResult,
                            updateFavoriteStatus: _onUpdateFavoriteStatus,
                          )
              ],
            ),
          ),
        );
      },
    );
  }

  void _onUpdateFavoriteStatus(
    RepositoryModelView repo,
  ) {}

  void _onSplashBlocListener(
    BuildContext context,
    HomeState state,
  ) {}
}

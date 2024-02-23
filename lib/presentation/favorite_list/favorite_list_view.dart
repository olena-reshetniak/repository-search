import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:repository_search/presentation/favorite_list/favorite_list_bloc.dart';
import 'package:repository_search/presentation/model/repository_model_view.dart';
import 'package:repository_search/presentation/resources/colors/color_resources.dart';
import 'package:repository_search/presentation/resources/images/image_resources.dart';
import 'package:repository_search/presentation/resources/strings/strings_resources.dart';
import 'package:repository_search/presentation/resources/styles/text_style_resources.dart';
import 'package:repository_search/presentation/widgets/image_widget.dart';
import 'package:repository_search/presentation/widgets/item_repositories_list_widget.dart';

class FavoriteListView extends StatefulWidget {
  const FavoriteListView({Key? key}) : super(key: key);

  @override
  State<FavoriteListView> createState() => _FavoriteListViewState();
}

class _FavoriteListViewState extends State<FavoriteListView> {
  @override
  void initState() {
    context
        .read<FavoriteListBloc>()
        .add(const FavoriteListEvent.getFavoriteList());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FavoriteListBloc, FavoriteListState>(
      listener: _onFavoriteListBlocListener,
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorResources.backgroundColor,
          appBar: AppBar(
            backgroundColor: ColorResources.backgroundColor,
            title: Text(
              StringsResources.favoriteScreenScreenAppBarTitle,
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
            leading: GestureDetector(
              onTap: _onCloseScreen,
              child: Container(
                margin: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: ColorResources.primaryColor,
                  borderRadius: BorderRadius.circular(
                    12.0,
                  ),
                ),
                child: ImageWidget(
                  size: 24.0,
                  image: ImageResources.arrowLeft,
                  color: ColorResources.backgroundColor,
                ),
              ),
            ),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                state.isLoading
                    ? SpinKitFadingCircle(
                        color: ColorResources.primaryColor,
                      )
                    : const SizedBox.shrink(),
                state.list.isEmpty
                    ? Expanded(
                        child: Center(
                          child: Text(
                            StringsResources.emptyFavoriteList,
                            textAlign: TextAlign.center,
                            style: TextStyleResources.body.copyWith(
                              color: ColorResources.textPlaceholderColor,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: ListView.custom(
                          childrenDelegate: SliverChildBuilderDelegate(
                            (context, index) {
                              return ItemRepositoriesListWidget(
                                  repository: state.list[index],
                                  updateFavoriteStatus: () {
                                    _onUpdateFavoriteStatus(
                                      state.list[index],
                                    );
                                  });
                            },
                            childCount: state.list.length,
                          ),
                        ),
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _onUpdateFavoriteStatus(
    RepositoryModelView repository,
  ) {
    context
        .read<FavoriteListBloc>()
        .add(FavoriteListEvent.updateFavoriteList(repository));
  }

  void _onFavoriteListBlocListener(
    BuildContext context,
    FavoriteListState state,
  ) {
    if (state.repository != null) {
      context
          .read<FavoriteListBloc>()
          .add(const FavoriteListEvent.getFavoriteList());
    }
  }

  void _onCloseScreen() {
    Navigator.pop(context);
  }
}

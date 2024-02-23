import 'package:flutter/material.dart';
import 'package:repository_search/presentation/model/repository_model_view.dart';
import 'package:repository_search/presentation/resources/colors/color_resources.dart';
import 'package:repository_search/presentation/resources/styles/text_style_resources.dart';
import 'package:repository_search/presentation/widgets/item_repositories_list_widget.dart';

class RepositoriesListWidget extends StatefulWidget {
  final List<RepositoryModelView> repositories;

  final String title;
  final String emptyList;

  final Function(RepositoryModelView repository) updateFavoriteStatus;

  const RepositoriesListWidget({
    Key? key,
    required this.repositories,
    required this.title,
    required this.emptyList,
    required this.updateFavoriteStatus,
  }) : super(key: key);

  @override
  State<RepositoriesListWidget> createState() => _RepositoriesListWidgetState();
}

class _RepositoriesListWidgetState extends State<RepositoriesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15.0),
            child: Text(
              widget.title,
              style: TextStyleResources.header.copyWith(
                color: ColorResources.primaryColor,
              ),
            ),
          ),
          widget.repositories.isEmpty
              ? Expanded(
                  child: Center(
                    child: Text(
                      widget.emptyList,
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
                            repository: widget.repositories[index],
                            updateFavoriteStatus: () {
                              widget.updateFavoriteStatus(
                                widget.repositories[index],
                              );
                            });
                      },
                      childCount: widget.repositories.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}

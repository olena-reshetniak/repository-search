import 'package:flutter/material.dart';
import 'package:repository_search/presentation/model/repository_model_view.dart';
import 'package:repository_search/presentation/resources/colors/color_resources.dart';
import 'package:repository_search/presentation/resources/images/image_resources.dart';
import 'package:repository_search/presentation/resources/styles/text_style_resources.dart';
import 'package:repository_search/presentation/widgets/image_widget.dart';

class ItemRepositoriesListWidget extends StatefulWidget {
  final RepositoryModelView repository;

  final Function() updateFavoriteStatus;

  const ItemRepositoriesListWidget({
    Key? key,
    required this.repository,
    required this.updateFavoriteStatus,
  }) : super(key: key);

  @override
  State<ItemRepositoriesListWidget> createState() =>
      _ItemRepositoriesListWidgetState();
}

class _ItemRepositoriesListWidgetState
    extends State<ItemRepositoriesListWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: ColorResources.layerColor,
        borderRadius: BorderRadius.circular(
          10.0,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              widget.repository.name,
              style: TextStyleResources.body.copyWith(
                color: ColorResources.textPrimaryColor,
              ),
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          GestureDetector(
            onTap: widget.updateFavoriteStatus,
            child: ImageWidget(
              size: 24.0,
              image: ImageResources.favoriteActive,
              color: widget.repository.isFavorite
                  ? ColorResources.primaryColor
                  : ColorResources.textPlaceholderColor,
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:repository_search/presentation/resources/colors/color_resources.dart';
import 'package:repository_search/presentation/resources/images/image_resources.dart';
import 'package:repository_search/presentation/resources/styles/text_style_resources.dart';
import 'package:repository_search/presentation/widgets/image_widget.dart';

class SearchFieldWidget extends StatefulWidget {
  final TextEditingController controller;
  final String hint;

  final Function(String value) onChangedValue;

  const SearchFieldWidget({
    Key? key,
    required this.controller,
    required this.hint,
    required this.onChangedValue,
  }) : super(key: key);

  @override
  State<SearchFieldWidget> createState() => _SearchFieldWidgetState();
}

class _SearchFieldWidgetState extends State<SearchFieldWidget> {
  final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    widget.controller.addListener(() {
      setState(() {});
    });
    focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      focusNode: focusNode,
      onChanged: widget.onChangedValue,
      cursorColor: ColorResources.primaryColor,
      style: TextStyleResources.body.copyWith(
        color: ColorResources.textPrimaryColor,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: focusNode.hasFocus
            ? ColorResources.secondaryColor
            : ColorResources.layerColor,
        hintText: widget.hint,
        hintStyle: TextStyleResources.body.copyWith(
          color: ColorResources.textPlaceholderColor,
        ),
        prefixIcon: ImageWidget(
          size: 24.0,
          image: ImageResources.search,
          color: ColorResources.primaryColor,
        ),
        suffixIcon: widget.controller.text.isNotEmpty
            ? GestureDetector(
                onTap: () {
                  widget.controller.text = "";
                  widget.onChangedValue("");
                },
                child: ImageWidget(
                  size: 24.0,
                  image: ImageResources.close,
                  color: ColorResources.primaryColor,
                ),
              )
            : null,
        enabledBorder: _getInputBorder(
          ColorResources.layerColor,
        ),
        focusedBorder: _getInputBorder(
          ColorResources.primaryColor,
        ),
      ),
    );
  }

  InputBorder _getInputBorder(
    Color color,
  ) {
    return OutlineInputBorder(
      borderRadius: const BorderRadius.all(
        Radius.circular(30.0),
      ),
      borderSide: BorderSide(
        width: 2,
        color: color,
      ),
    );
  }
}

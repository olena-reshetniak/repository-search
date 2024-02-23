import 'package:flutter/material.dart';

class ImageWidget extends StatelessWidget {
  final AssetImage image;
  final double size;
  final Color color;

  const ImageWidget({
    Key? key,
    required this.image,
    required this.size,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: image,
          colorFilter: ColorFilter.mode(
            color,
            BlendMode.srcIn,
          ),
        ),
      ),
    );
  }
}

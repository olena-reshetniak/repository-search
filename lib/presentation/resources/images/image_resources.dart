import 'package:flutter/material.dart';

abstract class ImageResources {
  static String buildPath(String fileName) {
    return 'assets/images/$fileName';
  }

  static AssetImage get arrowLeft => AssetImage(
    buildPath('arrow_left.png'),
  );

  static AssetImage get favoriteActive => AssetImage(
    buildPath('favorite_active.png'),
  );

  static AssetImage get favoriteDefault => AssetImage(
    buildPath('favorite_default.png.png'),
  );

  static AssetImage get search => AssetImage(
    buildPath('search.png'),
  );

  static AssetImage get close => AssetImage(
    buildPath('close.png'),
  );
}

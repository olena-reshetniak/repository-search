import 'package:flutter/material.dart';

const _fontFamilyName = 'Raleway';

abstract class TextStyleResources {

  static const header = TextStyle(
    fontSize: 16,
    height: 19,
    fontFamily: _fontFamilyName,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
  );

  static const body = TextStyle(
    fontSize: 14,
    height: 20,
    fontFamily: _fontFamilyName,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
  );
}

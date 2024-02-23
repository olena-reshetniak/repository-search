import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:repository_search/app/app.dart';

import 'package:repository_search/di/injectable.dart' as di;

void main() {
  runZonedGuarded<Future<void>>(body, error);
}

Future<void> body() async {
  WidgetsFlutterBinding.ensureInitialized();
  di.configureDependencies();

  runApp(const RepositorySearchApp());
}


void error(Object error, StackTrace stackTrace) {
  log(error.toString(), stackTrace: stackTrace);
}

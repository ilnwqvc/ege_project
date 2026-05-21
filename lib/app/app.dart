import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../data/local/auth_controller.dart';
import '../data/local/app_database.dart';
import '../data/repositories/content_repository.dart';
import 'router.dart';
import 'theme.dart';

class EgeRussianApp extends StatelessWidget {
  const EgeRussianApp({
    super.key,
    required this.repository,
    required this.database,
    required this.authController,
  });

  final ContentRepository repository;
  final AppDatabase database;
  final AuthController authController;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<ContentRepository>.value(value: repository),
        Provider<AppDatabase>.value(value: database),
        ChangeNotifierProvider<AuthController>.value(value: authController),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'ЕГЭ Русский',
        theme: buildAppTheme(),
        routerConfig: buildRouter(),
      ),
    );
  }
}

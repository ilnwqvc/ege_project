import 'package:flutter/material.dart';

import 'app/app.dart';
import 'data/local/auth_controller.dart';
import 'data/local/app_database.dart';
import 'data/local/content_sync_service.dart';
import 'data/repositories/asset_content_repository.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final repository = AssetContentRepository();
  final bundle = await repository.loadBundle();
  final database = AppDatabase();
  final syncService = ContentSyncService(database: database);
  await syncService.importBundle(bundle);
  final authController = AuthController(database: database);
  await authController.load();

  runApp(
    EgeRussianApp(
      repository: repository,
      database: database,
      authController: authController,
    ),
  );
}

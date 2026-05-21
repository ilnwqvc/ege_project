import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/content_bundle.dart';
import '../models/exam_task_content.dart';
import '../models/practice_task.dart';
import '../../shared/task_labels.dart';
import 'content_repository.dart';

class AssetContentRepository implements ContentRepository {
  AssetContentRepository();

  static const _manifestPath = 'assets/content/manifest.json';

  ContentBundle? _bundle;

  @override
  Future<ContentBundle> loadBundle() async {
    if (_bundle != null) {
      return _bundle!;
    }

    final manifestJson = jsonDecode(await rootBundle.loadString(_manifestPath))
        as Map<String, dynamic>;
    final packageFiles =
        ((manifestJson['packageFiles'] as List<dynamic>?) ?? const [])
            .cast<String>();
    final importFiles =
        ((manifestJson['importFiles'] as List<dynamic>?) ?? const [])
            .cast<String>();

    final taskContents = <ExamTaskContent>[];
    final seedTasks = <PracticeTask>[];

    for (final file in packageFiles) {
      final packageJson =
          jsonDecode(await rootBundle.loadString(file)) as Map<String, dynamic>;
      taskContents.add(
        ExamTaskContent.fromJson(packageJson['task'] as Map<String, dynamic>),
      );
      seedTasks.addAll(
        (packageJson['practice'] as List<dynamic>)
            .map((item) => PracticeTask.fromJson(item as Map<String, dynamic>)),
      );
    }

    for (final file in importFiles) {
      final importedJson =
          jsonDecode(await rootBundle.loadString(file)) as List<dynamic>;
      seedTasks.addAll(
        importedJson
            .map((item) => PracticeTask.fromJson(item as Map<String, dynamic>)),
      );
    }

    _bundle = ContentBundle(
      version: manifestJson['version'] as String,
      generatedAt: manifestJson['generatedAt'] as String,
      platforms: (manifestJson['platforms'] as List<dynamic>).cast<String>(),
      taskContents: taskContents
          .where((task) => isVisibleTaskNumber(task.number))
          .toList(growable: false),
      seedTasks: seedTasks,
    );

    return _bundle!;
  }

  @override
  List<ExamTaskContent> getTaskContents() {
    _ensureLoaded();
    return _bundle!.taskContents;
  }

  @override
  ExamTaskContent getTaskContentByNumber(int taskNumber) {
    _ensureLoaded();
    return _bundle!.taskContents
        .firstWhere((task) => task.number == taskNumber);
  }

  @override
  List<PracticeTask> getPracticeTasks({int? taskNumber}) {
    _ensureLoaded();

    final tasksToBuild = taskNumber == null
        ? _bundle!.taskContents
        : [getTaskContentByNumber(taskNumber)];

    return tasksToBuild.expand((task) {
      final imported = _bundle!.seedTasks
          .where((item) => item.taskNumber == task.number)
          .toList(growable: false);
      return _mergePracticeTasks(imported);
    }).toList(growable: false);
  }

  List<PracticeTask> _mergePracticeTasks(
    List<PracticeTask> imported,
  ) {
    final result = <PracticeTask>[];
    final seenIds = <String>{};
    final prioritizedImported = [...imported]..sort(_comparePracticePriority);

    void addIfNew(PracticeTask task) {
      if (!seenIds.add(task.id)) {
        return;
      }
      result.add(task);
    }

    for (final task in prioritizedImported) {
      addIfNew(task);
    }

    return result.toList(growable: false);
  }

  int _comparePracticePriority(PracticeTask a, PracticeTask b) {
    return _sourcePriority(a.source).compareTo(_sourcePriority(b.source));
  }

  int _sourcePriority(String source) {
    if (source == 'primer-docx' ||
        source == 'original-ege-format-bank' ||
        source == 'original-offline-bank') {
      return 0;
    }
    if (source.startsWith('reshuege:')) {
      return 1;
    }
    if (source == 'seed') {
      return 3;
    }
    return 2;
  }

  void _ensureLoaded() {
    if (_bundle == null) {
      throw StateError(
        'ContentBundle is not loaded yet. Call loadBundle() first.',
      );
    }
  }
}

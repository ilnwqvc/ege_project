import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:drift/wasm.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:sqlite3/wasm.dart';

part 'app_database.g.dart';

class ContentPackages extends Table {
  TextColumn get id => text()();

  TextColumn get version => text()();

  TextColumn get generatedAt => text()();

  DateTimeColumn get importedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TaskContentsTable extends Table {
  TextColumn get id => text()();

  IntColumn get number => integer()();

  TextColumn get title => text()();

  TextColumn get skill => text()();

  TextColumn get shortDescription => text()();

  TextColumn get officialBasis => text()();

  BoolColumn get isEssay => boolean()();

  TextColumn get tagsJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TaskTheorySectionsTable extends Table {
  TextColumn get id => text()();

  TextColumn get taskId => text().references(TaskContentsTable, #id)();

  TextColumn get sectionType => text()();

  TextColumn get title => text()();

  IntColumn get orderIndex => integer()();

  TextColumn get pointsJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class TaskSourcesTable extends Table {
  TextColumn get id => text()();

  TextColumn get taskId => text().references(TaskContentsTable, #id)();

  TextColumn get label => text()();

  TextColumn get url => text()();

  TextColumn get kind => text()();

  IntColumn get orderIndex => integer()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class PracticeItemsTable extends Table {
  TextColumn get id => text()();

  TextColumn get taskId => text().references(TaskContentsTable, #id)();

  IntColumn get taskNumber => integer()();

  TextColumn get title => text()();

  TextColumn get topic => text()();

  TextColumn get question => text()();

  TextColumn get optionsJson => text()();

  IntColumn get correctIndex => integer()();

  TextColumn get explanation => text()();

  TextColumn get ruleSummary => text()();

  TextColumn get rulePointsJson => text()();

  TextColumn get source => text()();

  TextColumn get difficulty => text()();

  TextColumn get tagsJson => text()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class UserProfilesTable extends Table {
  TextColumn get id => text()();

  TextColumn get email => text().unique()();

  TextColumn get displayName => text()();

  TextColumn get passwordHash => text()();

  DateTimeColumn get createdAt => dateTime()();

  DateTimeColumn get lastLoginAt => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => {id};
}

class UserAttemptsTable extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get remoteAttemptId => integer().nullable()();

  TextColumn get practiceItemId => text().references(PracticeItemsTable, #id)();

  TextColumn get userId =>
      text().nullable().references(UserProfilesTable, #id)();

  IntColumn get selectedIndex => integer()();

  BoolColumn get isCorrect => boolean()();

  DateTimeColumn get answeredAt => dateTime()();
}

class FavoriteItemsTable extends Table {
  TextColumn get practiceItemId => text().references(PracticeItemsTable, #id)();

  DateTimeColumn get createdAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {practiceItemId};
}

class MistakeItemsTable extends Table {
  TextColumn get practiceItemId => text().references(PracticeItemsTable, #id)();

  IntColumn get lastSelectedIndex => integer().nullable()();

  DateTimeColumn get updatedAt => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => {practiceItemId};
}

class SyncStateTable extends Table {
  TextColumn get key => text()();

  TextColumn get value => text()();

  @override
  Set<Column<Object>> get primaryKey => {key};
}

@DriftDatabase(
  tables: [
    ContentPackages,
    TaskContentsTable,
    TaskTheorySectionsTable,
    TaskSourcesTable,
    PracticeItemsTable,
    UserProfilesTable,
    UserAttemptsTable,
    FavoriteItemsTable,
    MistakeItemsTable,
    SyncStateTable,
  ],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  static QueryExecutor _openConnection() {
    if (kIsWeb) {
      return DatabaseConnection.delayed(_openWebDatabase());
    }

    return driftDatabase(
      name: 'ege_russian_app',
      web: DriftWebOptions(
        sqlite3Wasm: Uri.parse('sqlite3.wasm'),
        driftWorker: Uri.parse('drift_worker.js'),
      ),
    );
  }

  static Future<DatabaseConnection> _openWebDatabase() async {
    final sqlite3 = await WasmSqlite3.loadFromUrl(Uri.parse('sqlite3.wasm'));
    final fileSystem =
        await IndexedDbFileSystem.open(dbName: 'ege_russian_app');
    sqlite3.registerVirtualFileSystem(fileSystem, makeDefault: true);
    return DatabaseConnection(
      WasmDatabase(
        sqlite3: sqlite3,
        path: 'ege_russian_app.sqlite3',
        fileSystem: fileSystem,
      ),
    );
  }

  @override
  int get schemaVersion => 3;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (migrator) => migrator.createAll(),
        onUpgrade: (migrator, from, to) async {
          if (from < 2) {
            await migrator.createTable(userProfilesTable);
            await migrator.addColumn(
                userAttemptsTable, userAttemptsTable.userId);
          }
          if (from < 3) {
            await migrator.addColumn(
                userAttemptsTable, userAttemptsTable.remoteAttemptId);
          }
        },
      );

  Future<void> replaceContent({
    required String packageId,
    required String version,
    required String generatedAt,
    required List<ContentTaskInsert> tasks,
    required List<ContentSectionInsert> sections,
    required List<ContentSourceInsert> sources,
    required List<PracticeItemInsert> practiceItems,
  }) async {
    await transaction(() async {
      await delete(contentPackages).go();
      await delete(taskSourcesTable).go();
      await delete(taskTheorySectionsTable).go();

      await into(contentPackages).insert(
        ContentPackagesCompanion.insert(
          id: packageId,
          version: version,
          generatedAt: generatedAt,
          importedAt: DateTime.now(),
        ),
      );

      await batch((batch) {
        batch.insertAllOnConflictUpdate(
          taskContentsTable,
          tasks
              .map(
                (task) => TaskContentsTableCompanion.insert(
                  id: task.id,
                  number: task.number,
                  title: task.title,
                  skill: task.skill,
                  shortDescription: task.shortDescription,
                  officialBasis: task.officialBasis,
                  isEssay: task.isEssay,
                  tagsJson: jsonEncode(task.tags),
                ),
              )
              .toList(),
        );

        batch.insertAll(
          taskTheorySectionsTable,
          sections
              .map(
                (section) => TaskTheorySectionsTableCompanion.insert(
                  id: section.id,
                  taskId: section.taskId,
                  sectionType: section.sectionType,
                  title: section.title,
                  orderIndex: section.orderIndex,
                  pointsJson: jsonEncode(section.points),
                ),
              )
              .toList(),
        );

        batch.insertAll(
          taskSourcesTable,
          sources
              .map(
                (source) => TaskSourcesTableCompanion.insert(
                  id: source.id,
                  taskId: source.taskId,
                  label: source.label,
                  url: source.url,
                  kind: source.kind,
                  orderIndex: source.orderIndex,
                ),
              )
              .toList(),
        );

        batch.insertAllOnConflictUpdate(
          practiceItemsTable,
          practiceItems
              .map(
                (item) => PracticeItemsTableCompanion.insert(
                  id: item.id,
                  taskId: item.taskId,
                  taskNumber: item.taskNumber,
                  title: item.title,
                  topic: item.topic,
                  question: item.question,
                  optionsJson: jsonEncode(item.options),
                  correctIndex: item.correctIndex,
                  explanation: item.explanation,
                  ruleSummary: item.ruleSummary,
                  rulePointsJson: jsonEncode(item.rulePoints),
                  source: item.source,
                  difficulty: item.difficulty,
                  tagsJson: jsonEncode(item.tags),
                ),
              )
              .toList(),
        );
      });
    });
  }

  Future<UserProfilesTableData?> findUserByEmail(String email) {
    return (select(userProfilesTable)
          ..where((user) => user.email.equals(email.toLowerCase().trim())))
        .getSingleOrNull();
  }

  Future<UserProfilesTableData?> getCurrentUser() async {
    final currentUserId = await getSyncValue('currentUserId');
    if (currentUserId == null || currentUserId.isEmpty) {
      return null;
    }

    return (select(userProfilesTable)
          ..where((user) => user.id.equals(currentUserId)))
        .getSingleOrNull();
  }

  Future<void> createUserProfile({
    required String id,
    required String email,
    required String displayName,
    required String passwordHash,
  }) async {
    await into(userProfilesTable).insert(
      UserProfilesTableCompanion.insert(
        id: id,
        email: email.toLowerCase().trim(),
        displayName: displayName.trim(),
        passwordHash: passwordHash,
        createdAt: DateTime.now(),
        lastLoginAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> cacheRemoteUserProfile({
    required String id,
    required String email,
    required String displayName,
  }) async {
    await into(userProfilesTable).insertOnConflictUpdate(
      UserProfilesTableCompanion.insert(
        id: id,
        email: email.toLowerCase().trim(),
        displayName: displayName.trim(),
        passwordHash: 'remote',
        createdAt: DateTime.now(),
        lastLoginAt: Value(DateTime.now()),
      ),
    );
  }

  Future<void> setCurrentUser(String? userId) async {
    if (userId == null) {
      await (delete(syncStateTable)
            ..where((item) => item.key.equals('currentUserId')))
          .go();
      return;
    }

    await into(syncStateTable).insertOnConflictUpdate(
      SyncStateTableCompanion.insert(
        key: 'currentUserId',
        value: userId,
      ),
    );

    await (update(userProfilesTable)..where((user) => user.id.equals(userId)))
        .write(
      UserProfilesTableCompanion(
        lastLoginAt: Value(DateTime.now()),
      ),
    );
  }

  Future<String?> getSyncValue(String key) async {
    final item = await (select(syncStateTable)
          ..where((row) => row.key.equals(key)))
        .getSingleOrNull();
    return item?.value;
  }

  Future<void> setSyncValue(String key, String? value) async {
    if (value == null) {
      await (delete(syncStateTable)..where((row) => row.key.equals(key))).go();
      return;
    }

    await into(syncStateTable).insertOnConflictUpdate(
      SyncStateTableCompanion.insert(
        key: key,
        value: value,
      ),
    );
  }

  Future<void> recordAttempt({
    required String userId,
    required String practiceItemId,
    required int selectedIndex,
    required bool isCorrect,
  }) async {
    final now = DateTime.now();
    await transaction(() async {
      await into(userAttemptsTable).insert(
        UserAttemptsTableCompanion.insert(
          practiceItemId: practiceItemId,
          userId: Value(userId),
          selectedIndex: selectedIndex,
          isCorrect: isCorrect,
          answeredAt: now,
        ),
      );

      if (isCorrect) {
        await (delete(mistakeItemsTable)
              ..where((item) => item.practiceItemId.equals(practiceItemId)))
            .go();
      } else {
        await into(mistakeItemsTable).insertOnConflictUpdate(
          MistakeItemsTableCompanion.insert(
            practiceItemId: practiceItemId,
            lastSelectedIndex: Value(selectedIndex),
            updatedAt: now,
          ),
        );
      }
    });
  }

  Future<void> cacheRemoteAttempts({
    required String userId,
    required List<RemoteAttemptCacheInsert> attempts,
  }) async {
    if (attempts.isEmpty) {
      return;
    }

    final existingPracticeIds = (await (select(practiceItemsTable)
          ..where((item) => item.id.isIn(attempts
              .map((attempt) => attempt.practiceItemId)
              .toSet()
              .toList())))
        .get())
        .map((item) => item.id)
        .toSet();
    final existingRemoteAttemptIds = (await (select(userAttemptsTable)
          ..where((attempt) => attempt.remoteAttemptId.isIn(
                attempts.map((attempt) => attempt.remoteAttemptId).toList(),
              )))
        .get())
        .map((attempt) => attempt.remoteAttemptId)
        .whereType<int>()
        .toSet();
    final unsyncedLocalAttempts = await (select(userAttemptsTable)
          ..where((attempt) =>
              attempt.userId.equals(userId) & attempt.remoteAttemptId.isNull()))
        .get();
    final matchedLocalAttemptIds = <int>{};

    await transaction(() async {
      for (final attempt in attempts) {
        if (!existingPracticeIds.contains(attempt.practiceItemId)) {
          continue;
        }
        if (existingRemoteAttemptIds.contains(attempt.remoteAttemptId)) {
          continue;
        }

        UserAttemptsTableData? matchingLocalAttempt;
        for (final localAttempt in unsyncedLocalAttempts) {
          final isSameAnswer =
              localAttempt.practiceItemId == attempt.practiceItemId &&
                  localAttempt.selectedIndex == attempt.selectedIndex &&
                  localAttempt.isCorrect == attempt.isCorrect;
          final isCloseInTime = localAttempt.answeredAt
                  .difference(attempt.answeredAt)
                  .inSeconds
                  .abs() <=
              60;
          if (!matchedLocalAttemptIds.contains(localAttempt.id) &&
              isSameAnswer &&
              isCloseInTime) {
            matchingLocalAttempt = localAttempt;
            break;
          }
        }
        if (matchingLocalAttempt != null) {
          final localAttemptId = matchingLocalAttempt.id;
          matchedLocalAttemptIds.add(localAttemptId);
          await (update(userAttemptsTable)
                ..where((row) => row.id.equals(localAttemptId)))
              .write(
            UserAttemptsTableCompanion(
              remoteAttemptId: Value(attempt.remoteAttemptId),
            ),
          );
          continue;
        }

        await into(userAttemptsTable).insert(
          UserAttemptsTableCompanion.insert(
            remoteAttemptId: Value(attempt.remoteAttemptId),
            practiceItemId: attempt.practiceItemId,
            userId: Value(userId),
            selectedIndex: attempt.selectedIndex,
            isCorrect: attempt.isCorrect,
            answeredAt: attempt.answeredAt,
          ),
        );

        if (attempt.isCorrect) {
          await (delete(mistakeItemsTable)
                ..where(
                    (item) => item.practiceItemId.equals(attempt.practiceItemId)))
              .go();
        } else {
          await into(mistakeItemsTable).insertOnConflictUpdate(
            MistakeItemsTableCompanion.insert(
              practiceItemId: attempt.practiceItemId,
              lastSelectedIndex: Value(attempt.selectedIndex),
              updatedAt: attempt.answeredAt,
            ),
          );
        }
      }
    });
  }

  Future<ProgressSummary> loadProgressSummary(String userId) async {
    final attempts = await (select(userAttemptsTable)
          ..where((attempt) => attempt.userId.equals(userId)))
        .get();
    final practiceItems = await select(practiceItemsTable).get();
    final practiceById = {
      for (final item in practiceItems) item.id: item,
    };

    final total = attempts.length;
    final correct = attempts.where((attempt) => attempt.isCorrect).length;
    final today = DateTime.now();
    final todayCount = attempts
        .where((attempt) => _sameDate(attempt.answeredAt, today))
        .length;

    final taskStats = <int, _MutableTaskStats>{};
    for (final attempt in attempts) {
      final practice = practiceById[attempt.practiceItemId];
      if (practice == null) {
        continue;
      }

      final stats = taskStats.putIfAbsent(
        practice.taskNumber,
        () => _MutableTaskStats(taskNumber: practice.taskNumber),
      );
      stats.total += 1;
      if (attempt.isCorrect) {
        stats.correct += 1;
      }
    }

    final latestAttemptsByPractice = <String, UserAttemptsTableData>{};
    for (final attempt in attempts) {
      final previous = latestAttemptsByPractice[attempt.practiceItemId];
      if (previous == null || attempt.answeredAt.isAfter(previous.answeredAt)) {
        latestAttemptsByPractice[attempt.practiceItemId] = attempt;
      }
    }

    final mistakeSummaries = latestAttemptsByPractice.values
        .where((attempt) => !attempt.isCorrect)
        .map((attempt) {
          final practice = practiceById[attempt.practiceItemId];
          if (practice == null) {
            return null;
          }
          return ProgressMistakeSummary(
            practiceItemId: practice.id,
            taskNumber: practice.taskNumber,
            title: practice.title,
            question: practice.question,
            ruleSummary: practice.ruleSummary,
            rulePoints: (jsonDecode(practice.rulePointsJson) as List<dynamic>)
                .cast<String>(),
            lastSelectedIndex: attempt.selectedIndex,
            updatedAt: attempt.answeredAt,
          );
        })
        .whereType<ProgressMistakeSummary>()
        .toList()
      ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));

    return ProgressSummary(
      totalAttempts: total,
      correctAttempts: correct,
      todayAttempts: todayCount,
      streakDays:
          _calculateStreak(attempts.map((attempt) => attempt.answeredAt)),
      activeMistakes: mistakeSummaries.length,
      mistakes: mistakeSummaries,
      taskStats: taskStats.values
          .map(
            (stats) => ProgressTaskSummary(
              taskNumber: stats.taskNumber,
              totalAttempts: stats.total,
              correctAttempts: stats.correct,
            ),
          )
          .toList()
        ..sort((a, b) => a.taskNumber.compareTo(b.taskNumber)),
    );
  }

  bool _sameDate(DateTime a, DateTime b) {
    return a.year == b.year && a.month == b.month && a.day == b.day;
  }

  int _calculateStreak(Iterable<DateTime> dates) {
    final days =
        dates.map((date) => DateTime(date.year, date.month, date.day)).toSet();
    var cursor = DateTime.now();
    cursor = DateTime(cursor.year, cursor.month, cursor.day);
    var streak = 0;

    while (days.contains(cursor)) {
      streak += 1;
      cursor = cursor.subtract(const Duration(days: 1));
    }

    return streak;
  }
}

class _MutableTaskStats {
  _MutableTaskStats({required this.taskNumber});

  final int taskNumber;
  int total = 0;
  int correct = 0;
}

class ProgressSummary {
  const ProgressSummary({
    required this.totalAttempts,
    required this.correctAttempts,
    required this.todayAttempts,
    required this.streakDays,
    required this.activeMistakes,
    required this.mistakes,
    required this.taskStats,
  });

  final int totalAttempts;
  final int correctAttempts;
  final int todayAttempts;
  final int streakDays;
  final int activeMistakes;
  final List<ProgressMistakeSummary> mistakes;
  final List<ProgressTaskSummary> taskStats;

  double get accuracy =>
      totalAttempts == 0 ? 0 : correctAttempts / totalAttempts;
}

class RemoteAttemptCacheInsert {
  const RemoteAttemptCacheInsert({
    required this.remoteAttemptId,
    required this.practiceItemId,
    required this.selectedIndex,
    required this.isCorrect,
    required this.answeredAt,
  });

  final int remoteAttemptId;
  final String practiceItemId;
  final int selectedIndex;
  final bool isCorrect;
  final DateTime answeredAt;
}

class ProgressMistakeSummary {
  const ProgressMistakeSummary({
    required this.practiceItemId,
    required this.taskNumber,
    required this.title,
    required this.question,
    required this.ruleSummary,
    required this.rulePoints,
    required this.lastSelectedIndex,
    required this.updatedAt,
  });

  final String practiceItemId;
  final int taskNumber;
  final String title;
  final String question;
  final String ruleSummary;
  final List<String> rulePoints;
  final int lastSelectedIndex;
  final DateTime updatedAt;
}

class ProgressTaskSummary {
  const ProgressTaskSummary({
    required this.taskNumber,
    required this.totalAttempts,
    required this.correctAttempts,
  });

  final int taskNumber;
  final int totalAttempts;
  final int correctAttempts;

  double get accuracy =>
      totalAttempts == 0 ? 0 : correctAttempts / totalAttempts;
}

class ContentTaskInsert {
  const ContentTaskInsert({
    required this.id,
    required this.number,
    required this.title,
    required this.skill,
    required this.shortDescription,
    required this.officialBasis,
    required this.isEssay,
    required this.tags,
  });

  final String id;
  final int number;
  final String title;
  final String skill;
  final String shortDescription;
  final String officialBasis;
  final bool isEssay;
  final List<String> tags;
}

class ContentSectionInsert {
  const ContentSectionInsert({
    required this.id,
    required this.taskId,
    required this.sectionType,
    required this.title,
    required this.orderIndex,
    required this.points,
  });

  final String id;
  final String taskId;
  final String sectionType;
  final String title;
  final int orderIndex;
  final List<String> points;
}

class ContentSourceInsert {
  const ContentSourceInsert({
    required this.id,
    required this.taskId,
    required this.label,
    required this.url,
    required this.kind,
    required this.orderIndex,
  });

  final String id;
  final String taskId;
  final String label;
  final String url;
  final String kind;
  final int orderIndex;
}

class PracticeItemInsert {
  const PracticeItemInsert({
    required this.id,
    required this.taskId,
    required this.taskNumber,
    required this.title,
    required this.topic,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.ruleSummary,
    required this.rulePoints,
    required this.source,
    required this.difficulty,
    required this.tags,
  });

  final String id;
  final String taskId;
  final int taskNumber;
  final String title;
  final String topic;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String ruleSummary;
  final List<String> rulePoints;
  final String source;
  final String difficulty;
  final List<String> tags;
}

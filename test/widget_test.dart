import 'package:flutter_test/flutter_test.dart';

import 'package:ege_russian_app/data/repositories/asset_content_repository.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('practice content uses production task packages', () async {
    final repository = AssetContentRepository();
    await repository.loadBundle();

    for (var taskNumber = 1; taskNumber <= 26; taskNumber++) {
      final tasks = repository.getPracticeTasks(taskNumber: taskNumber);

      expect(tasks, hasLength(30));
      final sources = tasks.map((task) => task.source).toSet();
      final modes = tasks.map((task) => task.answerMode.name).toSet();

      expect(tasks.every((task) => task.source == 'unique-bank-v2'),
          isTrue,
          reason: 'task $taskNumber sources=$sources modes=$modes');
      expect(tasks.every((task) => task.isInputTask), isTrue);
      expect(
        tasks.every((task) => !task.question.contains('Прототип')),
        isTrue,
      );
      expect(tasks.every((task) => task.explanation.trim().isNotEmpty), isTrue);
      expect(tasks.every((task) => task.ruleSummary.trim().isNotEmpty), isTrue);
      expect(tasks.every((task) => task.rulePoints.isNotEmpty), isTrue);

      for (final task in tasks) {
        if (task.isInputTask) {
          expect(task.acceptedAnswers, isNotEmpty);
          continue;
        }

        expect(task.options.length, greaterThanOrEqualTo(4));
        expect(task.correctIndex, greaterThanOrEqualTo(0));
        expect(task.correctIndex, lessThan(task.options.length));
      }
    }
  });
}

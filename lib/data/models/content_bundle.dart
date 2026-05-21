import 'exam_task_content.dart';
import 'practice_task.dart';

class ContentBundle {
  const ContentBundle({
    required this.version,
    required this.generatedAt,
    required this.platforms,
    required this.taskContents,
    required this.seedTasks,
  });

  final String version;
  final String generatedAt;
  final List<String> platforms;
  final List<ExamTaskContent> taskContents;
  final List<PracticeTask> seedTasks;
}

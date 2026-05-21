import '../models/content_bundle.dart';
import '../models/exam_task_content.dart';
import '../models/practice_task.dart';

abstract class ContentRepository {
  Future<ContentBundle> loadBundle();

  List<ExamTaskContent> getTaskContents();

  ExamTaskContent getTaskContentByNumber(int taskNumber);

  List<PracticeTask> getPracticeTasks({int? taskNumber});
}

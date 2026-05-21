import '../models/content_bundle.dart';
import '../models/exam_task_content.dart';
import '../models/practice_task.dart';
import 'app_database.dart';

class ContentSyncService {
  const ContentSyncService({
    required this.database,
  });

  final AppDatabase database;

  Future<void> importBundle(ContentBundle bundle) async {
    final tasks = bundle.taskContents
        .map(
          (task) => ContentTaskInsert(
            id: task.id,
            number: task.number,
            title: task.title,
            skill: task.skill,
            shortDescription: task.shortDescription,
            officialBasis: task.officialBasis,
            isEssay: task.isEssay,
            tags: task.tags,
          ),
        )
        .toList();

    final sections = bundle.taskContents.expand(_buildSections).toList();
    final sources = bundle.taskContents.expand(_buildSources).toList();
    final items = bundle.seedTasks.map((task) => _toPracticeInsert(task)).toList();

    await database.replaceContent(
      packageId: 'offline-seed',
      version: bundle.version,
      generatedAt: bundle.generatedAt,
      tasks: tasks,
      sections: sections,
      sources: sources,
      practiceItems: items,
    );
  }

  List<ContentSectionInsert> _buildSections(ExamTaskContent task) {
    return [
      ContentSectionInsert(
        id: '${task.id}-theory',
        taskId: task.id,
        sectionType: 'theory',
        title: 'База по номеру',
        orderIndex: 0,
        points: task.theoryPoints,
      ),
      ContentSectionInsert(
        id: '${task.id}-steps',
        taskId: task.id,
        sectionType: 'algorithm',
        title: 'Алгоритм решения',
        orderIndex: 1,
        points: task.solvingSteps,
      ),
      ContentSectionInsert(
        id: '${task.id}-pitfalls',
        taskId: task.id,
        sectionType: 'pitfalls',
        title: 'Частые ловушки',
        orderIndex: 2,
        points: task.pitfalls,
      ),
      ContentSectionInsert(
        id: '${task.id}-checklist',
        taskId: task.id,
        sectionType: 'checklist',
        title: 'Чек-лист',
        orderIndex: 3,
        points: task.checklist,
      ),
    ];
  }

  List<ContentSourceInsert> _buildSources(ExamTaskContent task) {
    return task.sources
        .asMap()
        .entries
        .map(
          (entry) => ContentSourceInsert(
            id: '${task.id}-source-${entry.key}',
            taskId: task.id,
            label: entry.value.label,
            url: entry.value.url,
            kind: entry.value.kind,
            orderIndex: entry.key,
          ),
        )
        .toList();
  }

  PracticeItemInsert _toPracticeInsert(PracticeTask task) {
    return PracticeItemInsert(
      id: task.id,
      taskId: 'task-${task.taskNumber}',
      taskNumber: task.taskNumber,
      title: task.title,
      topic: task.topic,
      question: task.question,
      options: task.options,
      correctIndex: task.correctIndex,
      explanation: task.explanation,
      ruleSummary: task.ruleSummary,
      rulePoints: task.rulePoints,
      source: task.source,
      difficulty: task.difficulty,
      tags: task.tags,
    );
  }
}

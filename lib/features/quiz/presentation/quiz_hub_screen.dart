import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/content_repository.dart';
import '../../../shared/task_labels.dart';
import '../../../shared/widgets/app_shell.dart';
import '../../../shared/widgets/info_card.dart';

class QuizHubScreen extends StatelessWidget {
  const QuizHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ContentRepository>();
    final taskContents = repository.getTaskContents();

    return AppShell(
      title: 'Тренажёр',
      currentIndex: 2,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF1F8A70), Color(0xFF2854A3)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: const [
                BoxShadow(
                  color: Color(0x221F8A70),
                  blurRadius: 28,
                  offset: Offset(0, 14),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Смешанный режим',
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Проверка общей готовности: разные номера, разные темы, правило после каждой ошибки.',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: Colors.white.withValues(alpha: 0.90),
                        height: 1.38,
                      ),
                ),
                const SizedBox(height: 18),
                FilledButton.icon(
                  onPressed: () => context.go('/quiz/mixed'),
                  style: FilledButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF173B32),
                  ),
                  icon: const Icon(Icons.shuffle_rounded),
                  label: const Text('Запустить микс'),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Text(
            'Тренировка по номеру задания',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: taskContents.map((task) {
              return Material(
                color: const Color(0xFFFFFCF6),
                borderRadius: BorderRadius.circular(999),
                child: InkWell(
                  borderRadius: BorderRadius.circular(999),
                  onTap: () => context.go('/quiz/task/${task.number}'),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(999),
                      border: Border.all(color: const Color(0x1A152238)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          task.isEssay
                              ? Icons.article_outlined
                              : Icons.school_outlined,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          taskChipLabel(task.number),
                          style:
                              Theme.of(context).textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w800,
                                  ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 18),
          ...taskContents.map(
            (task) {
              final count =
                  repository.getPracticeTasks(taskNumber: task.number).length;

              return InfoCard(
                title:
                    '${taskScreenTitle(task.number)}. ${officialTaskTitle(task.number, defaultTitle: task.title)}',
                subtitle:
                    '${task.shortDescription} Внутри уже $count карточек на отработку.',
                icon: task.isEssay
                    ? Icons.edit_document
                    : Icons.fact_check_outlined,
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/quiz/task/${task.number}'),
              );
            },
          ),
        ],
      ),
    );
  }
}

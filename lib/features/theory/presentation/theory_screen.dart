import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/content_repository.dart';
import '../../../shared/widgets/app_shell.dart';
import '../../../shared/widgets/info_card.dart';
import '../../../shared/task_labels.dart';

class TheoryScreen extends StatelessWidget {
  const TheoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ContentRepository>();
    final tasks = repository.getTaskContents();

    return AppShell(
      title: 'Теория',
      currentIndex: 1,
      body: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(22),
            decoration: BoxDecoration(
              color: const Color(0xFFFFFCF6),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(color: const Color(0x1A152238)),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFE4ECFF),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Icon(Icons.auto_stories_outlined),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Теория как конспект, а не свалка',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w900,
                              letterSpacing: -0.2,
                            ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Разделы очищены, сгруппированы и открываются по номерам ЕГЭ. Читай сверху вниз: база, алгоритм, ловушки, чек-лист.',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF667085),
                              height: 1.42,
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          ...tasks.map(
            (task) => InfoCard(
              title:
                  '${taskScreenTitle(task.number)}. ${officialTaskTitle(task.number, defaultTitle: task.title)}',
              subtitle: task.shortDescription,
              icon:
                  task.isEssay ? Icons.edit_document : Icons.menu_book_outlined,
              trailing: const Icon(Icons.chevron_right),
              onTap: () => context.go('/theory/${task.number}'),
            ),
          ),
        ],
      ),
    );
  }
}

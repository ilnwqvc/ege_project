import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/content_repository.dart';
import '../../../shared/widgets/app_shell.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ContentRepository>();
    final taskContents = repository.getTaskContents();
    final taskCount = taskContents.where((task) => !task.isEssay).length;
    final practiceCount = taskContents.where((task) => !task.isEssay).fold<int>(
          0,
          (sum, task) =>
              sum + repository.getPracticeTasks(taskNumber: task.number).length,
        );

    return AppShell(
      title: 'Русский ЕГЭ',
      currentIndex: 0,
      body: ListView(
        children: [
          _ColorStartCard(
            taskCount: taskCount,
            practiceCount: practiceCount,
          ),
          const SizedBox(height: 14),
          _ActionTile(
            title: 'Тренажёр',
            subtitle: 'Смешанный режим или отдельный номер задания.',
            icon: Icons.edit_note_outlined,
            onTap: () => context.go('/quiz'),
          ),
          _ActionTile(
            title: 'Теория',
            subtitle: 'Короткий путь к правилам, алгоритмам и ловушкам.',
            icon: Icons.menu_book_outlined,
            onTap: () => context.go('/theory'),
          ),
          _ActionTile(
            title: 'Прогресс',
            subtitle: 'Ошибки, точность и правила, которые нужно повторить.',
            icon: Icons.insights_outlined,
            onTap: () => context.go('/progress'),
          ),
        ],
      ),
    );
  }
}

class _ColorStartCard extends StatelessWidget {
  const _ColorStartCard({
    required this.taskCount,
    required this.practiceCount,
  });

  final int taskCount;
  final int practiceCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF172A4A),
            Color(0xFF2854A3),
            Color(0xFF1F8A70),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: const [
          BoxShadow(
            color: Color(0x332854A3),
            blurRadius: 34,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -34,
            top: -42,
            child: Container(
              width: 142,
              height: 142,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Positioned(
            right: 34,
            bottom: -28,
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                color: const Color(0xFFB85C38).withValues(alpha: 0.32),
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _HeroPill(text: '$taskCount номеров'),
                  _HeroPill(text: '$practiceCount заданий'),
                ],
              ),
              const SizedBox(height: 18),
              Text(
                'Выбери режим и работаем',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w900,
                      letterSpacing: -0.5,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Тренажер, теория и прогресс без лишних экранов.',
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withValues(alpha: 0.90),
                      height: 1.35,
                    ),
              ),
              const SizedBox(height: 20),
              LayoutBuilder(
                builder: (context, constraints) {
                  final compact = constraints.maxWidth < 560;
                  final mixedButton = FilledButton.icon(
                    onPressed: () => context.go('/quiz/mixed'),
                    style: FilledButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: const Color(0xFF172A4A),
                    ),
                    icon: const Icon(Icons.shuffle_rounded),
                    label: const Text('Смешанный тренажёр'),
                  );
                  final theoryButton = OutlinedButton.icon(
                    onPressed: () => context.go('/theory'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.white,
                      side: BorderSide(
                        color: Colors.white.withValues(alpha: 0.55),
                      ),
                    ),
                    icon: const Icon(Icons.auto_stories_outlined),
                    label: const Text('Открыть теорию'),
                  );

                  if (compact) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        mixedButton,
                        const SizedBox(height: 10),
                        theoryButton,
                      ],
                    );
                  }

                  return Row(
                    children: [
                      Expanded(child: mixedButton),
                      const SizedBox(width: 12),
                      Expanded(child: theoryButton),
                    ],
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeroPill extends StatelessWidget {
  const _HeroPill({
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.14),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: Colors.white.withValues(alpha: 0.18)),
      ),
      child: Text(
        text,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.w900,
            ),
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(24),
        child: InkWell(
          borderRadius: BorderRadius.circular(24),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Container(
                  width: 46,
                  height: 46,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(
                    icon,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w900,
                                ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: const Color(0xFF667085),
                              height: 1.3,
                            ),
                      ),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

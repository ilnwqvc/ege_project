import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../data/repositories/content_repository.dart';
import '../../../shared/task_labels.dart';
import '../../../shared/widgets/app_shell.dart';

class TheoryDetailScreen extends StatelessWidget {
  const TheoryDetailScreen({
    super.key,
    required this.taskNumber,
  });

  final int taskNumber;

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ContentRepository>();
    final task = repository.getTaskContentByNumber(taskNumber);

    return AppShell(
      title: 'Теория: ${taskScreenTitle(task.number)}',
      currentIndex: 1,
      body: ListView(
        children: [
          _TheoryHero(
            taskNumber: task.number,
            title: officialTaskTitle(task.number, defaultTitle: task.title),
            description: task.shortDescription,
            basis: task.officialBasis,
          ),
          const SizedBox(height: 16),
          _StudyHintStrip(task: task),
          const SizedBox(height: 16),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.icon(
              onPressed: () => context.go('/quiz/task/${task.number}'),
              icon: const Icon(Icons.play_circle_outline),
              label: const Text('Открыть тренировку по этому номеру'),
            ),
          ),
          const SizedBox(height: 16),
          _TheoryGroupCard(
            title: 'База по номеру',
            subtitle:
                'Сначала разберись в сути темы, терминах и частых закономерностях.',
            icon: Icons.auto_stories_outlined,
            points: task.theoryPoints,
            presentation: _TheoryGroupPresentation.reference,
          ),
          const SizedBox(height: 14),
          _TheoryGroupCard(
            title: 'Алгоритм решения',
            subtitle:
                'Это рабочий порядок действий, который удобно держать в голове на экзамене.',
            icon: Icons.route_outlined,
            points: task.solvingSteps,
            presentation: _TheoryGroupPresentation.steps,
          ),
          const SizedBox(height: 14),
          _TheoryGroupCard(
            title: 'Частые ловушки',
            subtitle:
                'Проверь себя на типичных ошибках, которые чаще всего срезают баллы.',
            icon: Icons.error_outline,
            points: task.pitfalls,
            accent: const Color(0xFFD97706),
            presentation: _TheoryGroupPresentation.warnings,
          ),
          const SizedBox(height: 14),
          _TheoryGroupCard(
            title: 'Чек-лист перед ответом',
            subtitle: 'Быстрая самопроверка перед тем, как жать на ответ.',
            icon: Icons.check_circle_outline,
            points: task.checklist,
            accent: const Color(0xFF2E7D32),
            presentation: _TheoryGroupPresentation.checklist,
          ),
          const SizedBox(height: 14),
          _SourcesCard(task.sources),
        ],
      ),
    );
  }
}

class _TheoryHero extends StatelessWidget {
  const _TheoryHero({
    required this.taskNumber,
    required this.title,
    required this.description,
    required this.basis,
  });

  final int taskNumber;
  final String title;
  final String description;
  final String basis;

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
        borderRadius: BorderRadius.circular(34),
        boxShadow: const [
          BoxShadow(
            color: Color(0x262854A3),
            blurRadius: 34,
            offset: Offset(0, 18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.16),
              borderRadius: BorderRadius.circular(999),
            ),
            child: Text(
              'Задание $taskNumber',
              style: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                  ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w900,
                  height: 1.1,
                ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.95),
                  height: 1.4,
                ),
          ),
          const SizedBox(height: 14),
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              basis,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.white.withValues(alpha: 0.92),
                    height: 1.35,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StudyHintStrip extends StatelessWidget {
  const _StudyHintStrip({
    required this.task,
  });

  final dynamic task;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final cards = [
          _QuickHintCard(
            icon: Icons.visibility_outlined,
            title: 'Фокус',
            text: task.shortDescription,
            accent: const Color(0xFF2854A3),
          ),
          _QuickHintCard(
            icon: Icons.layers_outlined,
            title: 'Материал',
            text:
                'Теория: ${task.theoryPoints.length} пунктов\nАлгоритм: ${task.solvingSteps.length} шагов',
            accent: const Color(0xFF1F8A70),
          ),
          _QuickHintCard(
            icon: Icons.psychology_alt_outlined,
            title: 'Как читать',
            text:
                'База → алгоритм → ловушки → чек-лист. Не зубрим, а собираем схему.',
            accent: const Color(0xFFB85C38),
          ),
        ];

        if (constraints.maxWidth < 720) {
          return Column(
            children: cards
                .map(
                  (card) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: card,
                  ),
                )
                .toList(growable: false),
          );
        }

        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: cards[0]),
            const SizedBox(width: 12),
            Expanded(child: cards[1]),
            const SizedBox(width: 12),
            Expanded(child: cards[2]),
          ],
        );
      },
    );
  }
}

class _QuickHintCard extends StatelessWidget {
  const _QuickHintCard({
    required this.icon,
    required this.title,
    required this.text,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String text;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: accent.withValues(alpha: 0.18)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x12000000),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: accent.withValues(alpha: 0.10),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(icon, color: accent),
          ),
          const SizedBox(height: 12),
          Text(
            title,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w800,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.42,
                  color: const Color(0xFF425466),
                ),
          ),
        ],
      ),
    );
  }
}

enum _TheoryGroupPresentation {
  reference,
  steps,
  warnings,
  checklist,
}

class _TheoryGroupCard extends StatelessWidget {
  const _TheoryGroupCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.points,
    required this.presentation,
    this.accent = const Color(0xFF1565C0),
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final List<String> points;
  final Color accent;
  final _TheoryGroupPresentation presentation;

  @override
  Widget build(BuildContext context) {
    final sections = _buildSections(points);
    if (sections.isEmpty) {
      return const SizedBox.shrink();
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: const Color(0xFFFFFCF6),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: const Color(0x1A152238)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Icon(icon, color: accent),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.4,
                              color: const Color(0xFF5B6676),
                            ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            ...sections.asMap().entries.map((entry) {
              final section = entry.value;
              return Padding(
                padding: EdgeInsets.only(
                  bottom: entry.key == sections.length - 1 ? 0 : 18,
                ),
                child: _TheorySectionCard(
                  title: section.title,
                  items: section.items,
                  accent: accent,
                  presentation: presentation,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}

class _TheorySectionCard extends StatelessWidget {
  const _TheorySectionCard({
    required this.title,
    required this.items,
    required this.accent,
    required this.presentation,
  });

  final String? title;
  final List<String> items;
  final Color accent;
  final _TheoryGroupPresentation presentation;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFFFFFFF), Color(0xFFF8FAFD)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: accent.withValues(alpha: 0.14)),
        boxShadow: const [
          BoxShadow(
            color: Color(0x0D0F172A),
            blurRadius: 18,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null) ...[
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Text(
                title!,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w900,
                      color: const Color(0xFF10233F),
                    ),
              ),
            ),
            const SizedBox(height: 12),
          ],
          ...items.asMap().entries.map(
                (entry) => _TheoryEntry(
                  item: entry.value,
                  accent: accent,
                  presentation: presentation,
                  index: entry.key,
                ),
              ),
        ],
      ),
    );
  }
}

class _TheoryEntry extends StatelessWidget {
  const _TheoryEntry({
    required this.item,
    required this.accent,
    required this.presentation,
    required this.index,
  });

  final String item;
  final Color accent;
  final _TheoryGroupPresentation presentation;
  final int index;

  bool get _isAllCapsHeading {
    final cleaned =
        item.replaceAll(RegExp(r'[^A-Za-zА-Яа-яЁё0-9 ]'), '').trim();
    if (cleaned.length < 4 || cleaned.length > 80) {
      return false;
    }
    final hasLetters = cleaned.contains(RegExp(r'[A-Za-zА-Яа-яЁё]'));
    return hasLetters && cleaned == cleaned.toUpperCase();
  }

  bool get _isAlphabetMarker {
    final cleaned = item.replaceAll(RegExp(r'[^A-Za-zА-Яа-яЁё]'), '').trim();
    return cleaned.length == 1 && cleaned == cleaned.toUpperCase();
  }

  bool get _isNoteLine {
    const notePrefixes = [
      'ЗАПОМНИ',
      'ПРИМЕЧАНИЕ',
      'НЕ ПУТАЙ',
      'ОСТОРОЖНО',
      'НО:',
    ];

    return notePrefixes.any((prefix) => item.startsWith(prefix));
  }

  List<String> get _subItems {
    if (item.length < 70) {
      return const [];
    }

    final candidates = item
        .split(';')
        .map((part) => part.trim())
        .where((part) => part.isNotEmpty)
        .toList(growable: false);

    if (candidates.length < 3) {
      return const [];
    }

    if (candidates.any((part) => part.length < 6)) {
      return const [];
    }

    return candidates;
  }

  @override
  Widget build(BuildContext context) {
    final displayItem = _cleanTheoryDisplayText(item);
    final numberedItem = _parseNumberedTheoryItem(displayItem);

    if (numberedItem != null) {
      return _NumberedTheoryEntryCard(
        data: numberedItem,
        accent: accent,
      );
    }

    if (_isAlphabetMarker) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 12),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.14),
            borderRadius: BorderRadius.circular(999),
          ),
          child: Text(
            'Блок ${displayItem.trim()}',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: accent,
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      );
    }

    if (_isAllCapsHeading) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 14),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.10),
            borderRadius: BorderRadius.circular(14),
          ),
          child: Text(
            displayItem,
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
        ),
      );
    }

    if (_isNoteLine) {
      return _DecoratedInfoCard(
        accent: accent,
        icon: Icons.push_pin_outlined,
        background: accent.withValues(alpha: 0.08),
        borderColor: accent.withValues(alpha: 0.18),
        child: Text(
          displayItem,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.45,
                fontWeight: FontWeight.w700,
              ),
        ),
      );
    }

    final dashIndex = displayItem.indexOf(' – ');
    final colonIndex = displayItem.indexOf(':');
    final dividerIndex = dashIndex >= 0
        ? dashIndex
        : (colonIndex > 0 && colonIndex < 36 ? colonIndex : -1);

    if (dividerIndex > 0) {
      final label = displayItem.substring(0, dividerIndex).trim();
      final body =
          displayItem.substring(dividerIndex + (dashIndex >= 0 ? 3 : 1)).trim();
      if (label.length <= 34 && body.isNotEmpty) {
        return _DecoratedInfoCard(
          accent: accent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 6),
              Text(
                body,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.42,
                    ),
              ),
            ],
          ),
        );
      }
    }

    final subItems = _subItems;
    if (subItems.isNotEmpty) {
      final displaySubItems = displayItem
          .split(';')
          .map((part) => part.trim())
          .where((part) => part.isNotEmpty)
          .toList(growable: false);
      return _DecoratedInfoCard(
        accent: accent,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              displayItem.split(';').first.trim(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.42,
                    fontWeight: FontWeight.w700,
                  ),
            ),
            const SizedBox(height: 10),
            ...displaySubItems.skip(1).map(
                  (part) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 7),
                          child: Container(
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              color: accent,
                              borderRadius: BorderRadius.circular(999),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            part,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  height: 1.42,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
          ],
        ),
      );
    }

    if (presentation == _TheoryGroupPresentation.steps ||
        presentation == _TheoryGroupPresentation.checklist) {
      final number = index + 1;
      return _DecoratedInfoCard(
        accent: accent,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 28,
              height: 28,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(999),
              ),
              child: Text(
                '$number',
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                displayItem,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      height: 1.45,
                    ),
              ),
            ),
          ],
        ),
      );
    }

    if (presentation == _TheoryGroupPresentation.warnings) {
      return _DecoratedInfoCard(
        accent: accent,
        icon: Icons.warning_amber_rounded,
        background: accent.withValues(alpha: 0.07),
        borderColor: accent.withValues(alpha: 0.14),
        child: Text(
          displayItem,
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                height: 1.45,
              ),
        ),
      );
    }

    return _DecoratedInfoCard(
      accent: accent,
      child: Text(
        displayItem,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              height: 1.45,
            ),
      ),
    );
  }
}

class _NumberedTheoryEntryCard extends StatelessWidget {
  const _NumberedTheoryEntryCard({
    required this.data,
    required this.accent,
  });

  final _NumberedTheoryItemData data;
  final Color accent;

  @override
  Widget build(BuildContext context) {
    final titleStyle = Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w900,
          color: const Color(0xFF10233F),
          height: 1.25,
        );
    final bodyStyle = Theme.of(context).textTheme.bodyMedium?.copyWith(
          height: 1.48,
          color: const Color(0xFF344054),
        );

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: accent.withValues(alpha: 0.16)),
          boxShadow: const [
            BoxShadow(
              color: Color(0x0A0F172A),
              blurRadius: 16,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 34,
              height: 34,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: accent.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                data.number,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: accent,
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(data.title, style: titleStyle),
                  if (data.lead != null) ...[
                    const SizedBox(height: 6),
                    Text(data.lead!, style: bodyStyle),
                  ],
                  ...data.paragraphs.map(
                    (paragraph) => Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Text(paragraph, style: bodyStyle),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DecoratedInfoCard extends StatelessWidget {
  const _DecoratedInfoCard({
    required this.accent,
    required this.child,
    this.icon,
    this.background = Colors.white,
    this.borderColor,
  });

  final Color accent;
  final Widget child;
  final IconData? icon;
  final Color background;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(16),
          border: borderColor == null ? null : Border.all(color: borderColor!),
        ),
        child: icon == null
            ? child
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 2),
                    child: Icon(icon, color: accent, size: 18),
                  ),
                  const SizedBox(width: 10),
                  Expanded(child: child),
                ],
              ),
      ),
    );
  }
}

String _cleanTheoryDisplayText(String value) {
  final replacements = <String, String>{
    'дощ ан ой': 'дощаной',
    'плат яной': 'платяной',
    'вощ аной': 'вощаной',
    'берест ян ой': 'берестяной',
    'вод янист ый': 'водянистый',
    'трав янисты й': 'травянистый',
    'масл янист ый': 'маслянистый',
    'масля ный': 'масляный',
    'жемчуж ина': 'жемчужина',
    'жемчужи нк а': 'жемчужинка',
    'хижи нка': 'хижинка',
    'пес ня': 'песня',
    'пес енк а': 'песенка',
    'спаль ня': 'спальня',
    'спал енк а': 'спаленка',
    'больши нство': 'большинство',
    'товарищ еств о': 'товарищество',
    'юнош еств о': 'юношество',
    'заступнич еств о': 'заступничество',
    'Желт изн а': 'Желтизна',
    'бел изн а': 'белизна',
    'крут изн а': 'крутизна',
    'Десят ер ичный': 'Десятеричный',
    'восьм ер ичный': 'восьмеричный',
    'Кам ешек': 'Камешек',
    'плакс ив ый': 'плаксивый',
    'крас ив ый': 'красивый',
    'кле ев ой': 'клеевой',
    'эмал евый': 'эмалевый',
    'щавел евый': 'щавелевый',
    'фасоле вый': 'фасолевый',
    'сух оньк ий': 'сухонький',
    'лёг оньк ий': 'лёгонький',
    'высок оньк ий': 'высоконкий',
    'убо гоньк ий': 'убогонький',
    'Ялт инск ий': 'Ялтинский',
    'Соч инск ий': 'сочинский',
    'Грозн енск ий': 'грозненский',
    'нищ енск ий': 'нищенский',
    'Син еват ый': 'синеватый',
    'вити еват ый': 'витиеватый',
    'Глин ист ый': 'глинистый',
    'залив ист ый': 'заливистый',
    'размаш ист ый': 'размашистый',
    'Веснуш чат ый': 'веснушчатый',
    'бревен чат ый': 'бревенчатый',
    'Перебе жчик': 'перебежчик',
    'расска зчик': 'рассказчик',
    'разда тчик': 'раздатчик',
    'сма зчик': 'смазчик',
    'Кровель щик': 'кровельщик',
  };

  var text = value.replaceAll(RegExp(r'\n\s*\n'), ' <paragraph> ');
  for (final entry in replacements.entries) {
    text = text.replaceAll(entry.key, entry.value);
  }

  text = text
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(' - ', ' – ')
      .replaceAll(RegExp(r'(?<=\w)\s+-(?=\w)'), '-')
      .replaceAll(RegExp(r'(?<=\w)-\s+(?=\w)'), '-')
      .replaceAll(RegExp(r'\s+([,.;:!?])'), r'$1')
      .replaceAll(' <paragraph> ', '\n\n')
      .trim();

  return text;
}

class _SourcesCard extends StatelessWidget {
  const _SourcesCard(this.sources);

  final List<dynamic> sources;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Источники',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800,
                  ),
            ),
            const SizedBox(height: 8),
            Text(
              'Оставил их здесь как ориентир, но сам экран теперь рассчитан на чтение без переходов по ссылкам.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    color: const Color(0xFF5B6676),
                  ),
            ),
            const SizedBox(height: 12),
            ...sources.map(
              (source) => Padding(
                padding: const EdgeInsets.only(bottom: 12),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF5F7FB),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        source.label,
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                      ),
                      const SizedBox(height: 6),
                      SelectableText(source.url),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TheorySectionData {
  const _TheorySectionData({
    required this.title,
    required this.items,
  });

  final String? title;
  final List<String> items;
}

class _NumberedTheoryItemData {
  const _NumberedTheoryItemData({
    required this.number,
    required this.title,
    required this.paragraphs,
    this.lead,
  });

  final String number;
  final String title;
  final String? lead;
  final List<String> paragraphs;
}

_NumberedTheoryItemData? _parseNumberedTheoryItem(String value) {
  final match = RegExp(r'^(\d{1,2})[.)]\s+(.+)$').firstMatch(value.trim());
  if (match == null) {
    return null;
  }

  final number = match.group(1)!;
  final blocks = match
      .group(2)!
      .split(RegExp(r'\n\s*\n'))
      .map((part) => part.trim())
      .where((part) => part.isNotEmpty)
      .toList(growable: false);

  if (blocks.isEmpty) {
    return null;
  }

  final first = blocks.first;
  final titleMatch =
      RegExp(r'^([А-ЯЁA-Z][А-ЯЁA-Z0-9\s-]{2,})(.*)$').firstMatch(first);
  final title = titleMatch == null
      ? first
      : titleMatch.group(1)!.replaceAll(RegExp(r'\s+'), ' ').trim();
  final lead = titleMatch?.group(2)?.trim();

  return _NumberedTheoryItemData(
    number: number,
    title: title,
    lead: lead == null || lead.isEmpty ? null : lead,
    paragraphs: blocks.skip(1).toList(growable: false),
  );
}

List<_TheorySectionData> _buildSections(List<String> lines) {
  final cleaned = _compactNumberedTheoryItems(
      _splitInlineNumberedItems(_normalizeTheoryLines(lines)));

  if (cleaned.isEmpty) {
    return const [];
  }

  final sections = <_TheorySectionData>[];
  String? currentTitle;
  var buffer = <String>[];

  void flush() {
    if (buffer.isEmpty) {
      return;
    }
    sections.add(
      _TheorySectionData(
        title: currentTitle,
        items: List<String>.from(buffer),
      ),
    );
    buffer = <String>[];
  }

  for (final line in cleaned) {
    if (line.startsWith('##')) {
      flush();
      currentTitle = line.replaceFirst(RegExp(r'^##\s*'), '').trim();
      continue;
    }

    if (_looksLikeSectionTitle(line) && buffer.isNotEmpty) {
      flush();
      currentTitle = line;
      continue;
    }

    if (_looksLikeSectionTitle(line) &&
        currentTitle == null &&
        buffer.isEmpty) {
      currentTitle = line;
      continue;
    }

    buffer.add(line.startsWith('! ') ? line.substring(2).trim() : line);
  }

  flush();
  return sections;
}

List<String> _compactNumberedTheoryItems(List<String> lines) {
  final result = <String>[];
  String? numberedBuffer;

  void flushNumbered() {
    if (numberedBuffer == null) {
      return;
    }
    result.add(numberedBuffer!);
    numberedBuffer = null;
  }

  for (final line in lines) {
    final startsNumberedItem = RegExp(r'^\d{1,2}[.)]\s+').hasMatch(line);
    final startsHeading =
        line.startsWith('## ') || _looksLikeSectionTitle(line);

    if (startsNumberedItem) {
      flushNumbered();
      numberedBuffer = line;
      continue;
    }

    if (numberedBuffer != null && !startsHeading) {
      numberedBuffer = '$numberedBuffer\n\n$line';
      continue;
    }

    flushNumbered();
    result.add(line);
  }

  flushNumbered();
  return result;
}

List<String> _splitInlineNumberedItems(List<String> lines) {
  return lines
      .expand((line) => _splitInlineNumberedItem(line))
      .toList(growable: false);
}

List<String> _splitInlineNumberedItem(String line) {
  final markerMatches =
      RegExp(r'(^|\s)(\d{1,2})[.)]\s+').allMatches(line).where((match) {
    final markerStart = match.start + ((match.group(1) ?? '').isEmpty ? 0 : 1);
    if (markerStart == 0) {
      return true;
    }

    final before = line.substring(0, markerStart).trimRight();
    if (before.endsWith('№')) {
      return false;
    }

    return true;
  }).toList(growable: false);

  if (markerMatches.length < 2) {
    return [line];
  }

  final result = <String>[];
  for (var index = 0; index < markerMatches.length; index += 1) {
    final match = markerMatches[index];
    final leading = match.group(1) ?? '';
    final start = match.start + (leading.isEmpty ? 0 : 1);
    final end = index == markerMatches.length - 1
        ? line.length
        : markerMatches[index + 1].start +
            (((markerMatches[index + 1].group(1) ?? '').isEmpty) ? 0 : 1);
    final part = line.substring(start, end).trim();
    if (part.isNotEmpty) {
      result.add(part);
    }
  }

  return result;
}

List<String> _normalizeTheoryLines(List<String> lines) {
  final result = <String>[];

  for (final rawLine in lines) {
    final line = rawLine
        .trim()
        .replaceAll(RegExp(r'\s+'), ' ')
        .replaceAll(' -', '-')
        .replaceAll('- ', '-');

    if (line.isEmpty) {
      continue;
    }

    if (line.startsWith('##')) {
      result.add('## ${line.replaceFirst(RegExp(r'^##\s*'), '').trim()}');
      continue;
    }

    if (result.isNotEmpty && _shouldJoinWithPrevious(result.last, line)) {
      result[result.length - 1] = '${result.last} $line';
      continue;
    }

    result.add(line);
  }

  return result;
}

bool _shouldJoinWithPrevious(String previous, String current) {
  if (previous.startsWith('## ') || current.startsWith('## ')) {
    return false;
  }

  if (_looksLikeSectionTitle(previous) || _looksLikeSectionTitle(current)) {
    return false;
  }

  if (current.startsWith(RegExp(r'\d+[.)]\s'))) {
    return false;
  }

  if (previous.endsWith('.') ||
      previous.endsWith('!') ||
      previous.endsWith('?') ||
      previous.endsWith(':')) {
    return false;
  }

  if (previous.endsWith(',') ||
      previous.endsWith(';') ||
      previous.endsWith('(') ||
      previous.endsWith('…')) {
    return true;
  }

  final startsLowercase = current.isNotEmpty &&
      current[0].toLowerCase() == current[0] &&
      current[0].toUpperCase() != current[0];
  final previousLooksCut = previous.length < 90 &&
      !previous.contains(RegExp(r'[.!?]$')) &&
      current.length < 90;

  return startsLowercase || previousLooksCut;
}

bool _looksLikeSectionTitle(String line) {
  final cleaned = line.replaceAll(RegExp(r'[^A-Za-zА-Яа-яЁё0-9 ]'), '').trim();
  if (cleaned.length < 4 || cleaned.length > 70) {
    return false;
  }

  final hasLetters = cleaned.contains(RegExp(r'[A-Za-zА-Яа-яЁё]'));
  return hasLetters && cleaned == cleaned.toUpperCase();
}

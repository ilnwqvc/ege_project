import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/local/auth_controller.dart';
import '../../../data/local/app_database.dart';
import '../../../data/models/exam_task_content.dart';
import '../../../data/models/practice_task.dart';
import '../../../data/repositories/content_repository.dart';
import '../../../shared/task_labels.dart';
import '../../../shared/widgets/app_shell.dart';

class QuizSessionScreen extends StatefulWidget {
  const QuizSessionScreen({
    super.key,
    this.taskNumber,
  });

  final int? taskNumber;

  @override
  State<QuizSessionScreen> createState() => _QuizSessionScreenState();
}

class _QuizSessionScreenState extends State<QuizSessionScreen> {
  int _taskIndex = 0;
  int? _selectedAnswer;
  final TextEditingController _textController = TextEditingController();
  bool _answered = false;
  int _correctAnswers = 0;
  List<PracticeTask> _tasks = const [];
  int? _loadedTaskNumber;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _ensureSessionTasks();
  }

  @override
  void didUpdateWidget(covariant QuizSessionScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.taskNumber != widget.taskNumber) {
      _tasks = const [];
      _loadedTaskNumber = null;
      _ensureSessionTasks();
    }
  }

  void _ensureSessionTasks() {
    if (_loadedTaskNumber == widget.taskNumber && _tasks.isNotEmpty) {
      return;
    }

    final repository = context.read<ContentRepository>();
    _tasks = _buildRandomTaskOrder(repository);
    _loadedTaskNumber = widget.taskNumber;
    _resetSessionProgress();
  }

  List<PracticeTask> _buildRandomTaskOrder(ContentRepository repository) {
    final tasks = repository
        .getPracticeTasks(taskNumber: widget.taskNumber)
        .toList(growable: false);

    if (tasks.length < 2) {
      return tasks;
    }

    return [...tasks]..shuffle(Random());
  }

  void _resetSessionProgress() {
    _taskIndex = 0;
    _selectedAnswer = null;
    _answered = false;
    _correctAnswers = 0;
    _textController.clear();
  }

  Future<void> _submitAnswer(PracticeTask task) async {
    if (_answered) {
      return;
    }

    final isCorrect = task.isInputTask
        ? _checkTextAnswer(task)
        : _selectedAnswer == task.correctIndex;

    if (!task.isInputTask && _selectedAnswer == null) {
      return;
    }

    if (task.isInputTask && _textController.text.trim().isEmpty) {
      return;
    }

    setState(() {
      _answered = true;
      if (isCorrect) {
        _correctAnswers += 1;
      }
    });

    final auth = context.read<AuthController>();
    final user = auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Создай профиль во вкладке прогресса, чтобы ответы сохранялись.'),
        ),
      );
      return;
    }

    final selectedIndex = task.isInputTask
        ? (isCorrect ? task.correctIndex : -1)
        : (_selectedAnswer ?? -1);

    await context.read<AppDatabase>().recordAttempt(
          userId: user.id,
          practiceItemId: task.id,
          selectedIndex: selectedIndex,
          isCorrect: isCorrect,
        );
    await auth.recordRemoteAttempt(
      practiceItemId: task.id,
      taskNumber: task.taskNumber,
      selectedIndex: selectedIndex,
      isCorrect: isCorrect,
      ruleSummary: task.ruleSummary,
    );
  }

  void _nextTask(int total) {
    if (_taskIndex == total - 1) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Сессия завершена: $_correctAnswers из $total'),
        ),
      );

      setState(() {
        final repository = context.read<ContentRepository>();
        _tasks = _buildRandomTaskOrder(repository);
        _resetSessionProgress();
      });

      return;
    }

    setState(() {
      _taskIndex += 1;
      _selectedAnswer = null;
      _answered = false;
      _textController.clear();
    });
  }

  bool _checkTextAnswer(PracticeTask task) {
    final userAnswer = _normalizeAnswer(_textController.text);

    return task.acceptedAnswers.any(
      (answer) => _normalizeAnswer(answer) == userAnswer,
    );
  }

  String _normalizeAnswer(String value) {
    return value
        .toLowerCase()
        .replaceAll('ё', 'е')
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll(RegExp(r'[.,;:()«»-]'), '');
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final repository = context.read<ContentRepository>();
    _ensureSessionTasks();
    final tasks = _tasks;

    if (tasks.isEmpty) {
      return AppShell(
        title: 'Тренажёр',
        currentIndex: 2,
        body: const Center(
          child: Text('Для этого режима пока нет заданий.'),
        ),
      );
    }

    final task = tasks[_taskIndex];
    final taskContent = repository.getTaskContentByNumber(task.taskNumber);
    final sessionTitle = widget.taskNumber == null
        ? 'Смешанный тренажёр'
        : taskScreenTitle(task.taskNumber);

    return AppShell(
      title: sessionTitle,
      currentIndex: 2,
      body: ListView(
        children: [
          _SessionHeader(
            title: task.title,
            subtitle: task.topic,
            progress: '${_taskIndex + 1} / ${tasks.length}',
            accuracy: 'Верно: $_correctAnswers',
          ),
          const SizedBox(height: 12),
          _QuestionCard(
            task: task,
            textController: _textController,
            selectedAnswer: _selectedAnswer,
            answered: _answered,
            onAnswerSelected: (value) {
              setState(() {
                _selectedAnswer = value;
              });
            },
            onSubmit: () => _submitAnswer(task),
            onNext: () => _nextTask(tasks.length),
            isLastTask: _taskIndex == tasks.length - 1,
          ),
          const SizedBox(height: 12),
          if (_answered)
            _AnswerReview(
              task: task,
              taskContent: taskContent,
              selectedAnswer: _selectedAnswer,
              userInput: _textController.text,
            ),
        ],
      ),
    );
  }
}

class _QuestionCard extends StatelessWidget {
  const _QuestionCard({
    required this.task,
    required this.textController,
    required this.selectedAnswer,
    required this.answered,
    required this.onAnswerSelected,
    required this.onSubmit,
    required this.onNext,
    required this.isLastTask,
  });

  final PracticeTask task;
  final TextEditingController textController;
  final int? selectedAnswer;
  final bool answered;
  final ValueChanged<int?> onAnswerSelected;
  final VoidCallback onSubmit;
  final VoidCallback onNext;
  final bool isLastTask;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _QuestionText(question: task.question),
            const SizedBox(height: 18),
            if (task.isInputTask)
              _AnswerInput(
                controller: textController,
                enabled: !answered,
                placeholder: task.inputPlaceholder,
                minLines: task.taskNumber == 27 ? 4 : 1,
              )
            else
              RadioGroup<int>(
                groupValue: selectedAnswer,
                onChanged: answered ? (_) {} : onAnswerSelected,
                child: Column(
                  children: List.generate(task.options.length, (index) {
                    final option = task.options[index];
                    final selected = selectedAnswer == index;

                    Color borderColor = const Color(0xFFE2E8F0);
                    Color background = const Color(0xFFF8FAFC);
                    IconData icon = Icons.radio_button_unchecked;
                    Color iconColor = const Color(0xFF64748B);

                    if (answered && index == task.correctIndex) {
                      borderColor = const Color(0xFF16A34A);
                      background = const Color(0xFFEFFAF2);
                      icon = Icons.check_circle;
                      iconColor = const Color(0xFF16A34A);
                    } else if (answered &&
                        selected &&
                        index != task.correctIndex) {
                      borderColor = colorScheme.error;
                      background =
                          colorScheme.errorContainer.withValues(alpha: 0.35);
                      icon = Icons.cancel;
                      iconColor = colorScheme.error;
                    } else if (selected) {
                      borderColor = colorScheme.primary;
                      background =
                          colorScheme.primaryContainer.withValues(alpha: 0.38);
                      icon = Icons.radio_button_checked;
                      iconColor = colorScheme.primary;
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(18),
                        onTap: answered ? null : () => onAnswerSelected(index),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          width: double.infinity,
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: background,
                            borderRadius: BorderRadius.circular(18),
                            border: Border.all(color: borderColor),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Icon(icon, color: iconColor, size: 22),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  option,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.copyWith(height: 1.38),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            const SizedBox(height: 10),
            LayoutBuilder(
              builder: (context, constraints) {
                final compact = constraints.maxWidth < 520;
                final checkButton = OutlinedButton.icon(
                  onPressed: answered ? null : onSubmit,
                  icon: const Icon(Icons.task_alt_outlined),
                  label: const Text('Проверить'),
                );
                final nextButton = FilledButton.icon(
                  onPressed: answered ? onNext : null,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: Text(isLastTask ? 'Завершить' : 'Дальше'),
                );

                if (compact) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      checkButton,
                      const SizedBox(height: 10),
                      nextButton,
                    ],
                  );
                }

                return Row(
                  children: [
                    Expanded(child: checkButton),
                    const SizedBox(width: 12),
                    Expanded(child: nextButton),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _QuestionText extends StatelessWidget {
  const _QuestionText({
    required this.question,
  });

  final String question;

  @override
  Widget build(BuildContext context) {
    final blocks = question
        .split(RegExp(r'\n\s*\n'))
        .map((block) => block.trim())
        .where((block) => block.isNotEmpty)
        .toList(growable: false);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: blocks.asMap().entries.map((entry) {
        final isFirst = entry.key == 0;
        final text = entry.value;
        final isTextBlock =
            text.contains(RegExp(r'\(\d+\)')) || text.length > 220;

        if (isFirst) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              text,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                    height: 1.25,
                  ),
            ),
          );
        }

        return Container(
          width: double.infinity,
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: isTextBlock
                ? const Color(0xFFF8FAFC)
                : Theme.of(context)
                    .colorScheme
                    .primaryContainer
                    .withValues(alpha: 0.30),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: const Color(0xFFE2E8F0)),
          ),
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  height: 1.5,
                  fontWeight: isTextBlock ? FontWeight.w500 : FontWeight.w700,
                ),
          ),
        );
      }).toList(growable: false),
    );
  }
}

class _AnswerInput extends StatelessWidget {
  const _AnswerInput({
    required this.controller,
    required this.enabled,
    required this.placeholder,
    required this.minLines,
  });

  final TextEditingController controller;
  final bool enabled;
  final String placeholder;
  final int minLines;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFF8FAFC), Color(0xFFEFF6FF)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(22),
        border: Border.all(color: const Color(0xFFD8E2F0)),
      ),
      child: TextField(
        controller: controller,
        enabled: enabled,
        minLines: minLines,
        maxLines: minLines == 1 ? 1 : 6,
        textInputAction:
            minLines == 1 ? TextInputAction.done : TextInputAction.newline,
        decoration: InputDecoration(
          prefixIcon: minLines == 1
              ? const Icon(Icons.edit_note_rounded)
              : const Padding(
                  padding: EdgeInsets.only(bottom: 64),
                  child: Icon(Icons.edit_note_rounded),
                ),
          hintText: placeholder,
          helperText: 'Пиши только сам ответ: слово, цифры или нужную форму.',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(18),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }
}

class _SessionHeader extends StatelessWidget {
  const _SessionHeader({
    required this.title,
    required this.subtitle,
    required this.progress,
    required this.accuracy,
  });

  final String title;
  final String subtitle;
  final String progress;
  final String accuracy;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
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
                    color: Colors.black54,
                  ),
            ),
            const SizedBox(height: 14),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                Chip(label: Text('Прогресс: $progress')),
                Chip(label: Text(accuracy)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _AnswerReview extends StatelessWidget {
  const _AnswerReview({
    required this.task,
    required this.taskContent,
    required this.selectedAnswer,
    required this.userInput,
  });

  final PracticeTask task;
  final ExamTaskContent taskContent;
  final int? selectedAnswer;
  final String userInput;

  @override
  Widget build(BuildContext context) {
    final normalizedUserInput = _normalizeAnswer(userInput);
    final isCorrect = task.isInputTask
        ? task.acceptedAnswers.any(
            (answer) => _normalizeAnswer(answer) == normalizedUserInput,
          )
        : selectedAnswer == task.correctIndex;

    return Column(
      children: [
        Card(
          color: isCorrect
              ? Colors.green.withValues(alpha: 0.10)
              : Colors.red.withValues(alpha: 0.10),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  isCorrect
                      ? 'Ответ верный'
                      : 'Ответ неверный, повтори правило',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 10),
                Text(task.explanation),
                if (task.isInputTask) ...[
                  const SizedBox(height: 10),
                  Text(
                    'Правильный ответ: ${task.acceptedAnswers.first}',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ],
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .primaryContainer
                        .withValues(alpha: 0.65),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Text(
                    task.ruleSummary,
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Правила по этому заданию',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 12),
                ...task.rulePoints.map(
                  (point) => _RulePoint(point: point),
                ),
                const SizedBox(height: 8),
                Text(
                  'Полная памятка',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 10),
                ...taskContent.theoryPoints.map(
                  (point) => _RulePoint(point: point),
                ),
                const SizedBox(height: 8),
                Text(
                  'Как решать',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
                const SizedBox(height: 10),
                ...taskContent.solvingSteps.map(
                  (point) => _RulePoint(point: point),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _normalizeAnswer(String value) {
    return value
        .toLowerCase()
        .replaceAll('ё', 'е')
        .replaceAll(RegExp(r'\s+'), '')
        .replaceAll(RegExp(r'[.,;:()«»-]'), '');
  }
}

class _RulePoint extends StatelessWidget {
  const _RulePoint({
    required this.point,
  });

  final String point;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final text = point.trim();

    if (point.startsWith('## ')) {
      return Padding(
        padding: const EdgeInsets.only(top: 14, bottom: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 11),
          decoration: BoxDecoration(
            color: colorScheme.primaryContainer.withValues(alpha: 0.50),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            point.substring(3),
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                  color: colorScheme.onPrimaryContainer,
                ),
          ),
        ),
      );
    }

    if (point.startsWith('! ')) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 10),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: Theme.of(context)
                .colorScheme
                .primaryContainer
                .withValues(alpha: 0.55),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Text(
            point.substring(2),
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ),
      );
    }

    final dashIndex = text.indexOf(' – ');
    final colonIndex = text.indexOf(':');
    final dividerIndex = dashIndex >= 0
        ? dashIndex
        : (colonIndex > 0 && colonIndex < 42 ? colonIndex : -1);

    if (dividerIndex > 0) {
      final label = text.substring(0, dividerIndex).trim();
      final body =
          text.substring(dividerIndex + (dashIndex >= 0 ? 3 : 1)).trim();

      if (label.length <= 42 && body.isNotEmpty) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: const Color(0xFFE2E8F0)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: colorScheme.primary,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 6),
                Text(
                  body,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        height: 1.45,
                      ),
                ),
              ],
            ),
          ),
        );
      }
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(
                color: colorScheme.primary,
                borderRadius: BorderRadius.circular(999),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.45,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

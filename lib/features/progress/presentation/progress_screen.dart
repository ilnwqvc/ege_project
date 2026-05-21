import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/local/auth_controller.dart';
import '../../../data/local/app_database.dart';
import '../../../shared/task_labels.dart';
import '../../../shared/widgets/app_shell.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AppShell(
      title: 'Профиль',
      currentIndex: 3,
      body: Consumer<AuthController>(
        builder: (context, auth, _) {
          if (auth.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (!auth.isSignedIn) {
            return const _AuthView();
          }

          return _ProfileProgressView(auth: auth);
        },
      ),
    );
  }
}

class _AuthView extends StatefulWidget {
  const _AuthView();

  @override
  State<_AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<_AuthView> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isSignUp = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    setState(() => _isSubmitting = true);
    final auth = context.read<AuthController>();
    final result = _isSignUp
        ? await auth.signUp(
            email: _emailController.text,
            displayName: _nameController.text,
            password: _passwordController.text,
          )
        : await auth.signIn(
            email: _emailController.text,
            password: _passwordController.text,
          );

    if (!mounted) {
      return;
    }

    setState(() => _isSubmitting = false);
    if (!result.isSuccess) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(result.message ?? 'Не получилось войти.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Container(
          padding: const EdgeInsets.all(22),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isSignUp ? 'Создай профиль' : 'Войди в профиль',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
              const SizedBox(height: 8),
              Text(
                'Прогресс, ошибки и точность будут сохраняться в локальной базе этого устройства.',
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.black54,
                      height: 1.4,
                    ),
              ),
              const SizedBox(height: 18),
              SegmentedButton<bool>(
                segments: const [
                  ButtonSegment(
                    value: true,
                    icon: Icon(Icons.person_add_alt_1_outlined),
                    label: Text('Регистрация'),
                  ),
                  ButtonSegment(
                    value: false,
                    icon: Icon(Icons.login_outlined),
                    label: Text('Вход'),
                  ),
                ],
                selected: {_isSignUp},
                onSelectionChanged: (values) {
                  setState(() => _isSignUp = values.first);
                },
              ),
              const SizedBox(height: 18),
              if (_isSignUp) ...[
                TextField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: const InputDecoration(
                    labelText: 'Имя',
                    prefixIcon: Icon(Icons.badge_outlined),
                  ),
                ),
                const SizedBox(height: 12),
              ],
              TextField(
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                decoration: const InputDecoration(
                  labelText: 'Почта',
                  prefixIcon: Icon(Icons.alternate_email),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _passwordController,
                obscureText: true,
                onSubmitted: (_) => _submit(),
                decoration: const InputDecoration(
                  labelText: 'Пароль',
                  prefixIcon: Icon(Icons.lock_outline),
                ),
              ),
              const SizedBox(height: 18),
              SizedBox(
                width: double.infinity,
                child: FilledButton.icon(
                  onPressed: _isSubmitting ? null : _submit,
                  icon: _isSubmitting
                      ? const SizedBox(
                          width: 18,
                          height: 18,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Icon(_isSignUp ? Icons.person_add_alt_1 : Icons.login),
                  label: Text(_isSignUp ? 'Создать профиль' : 'Войти'),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _ProfileProgressView extends StatelessWidget {
  const _ProfileProgressView({
    required this.auth,
  });

  final AuthController auth;

  @override
  Widget build(BuildContext context) {
    final database = context.read<AppDatabase>();
    final user = auth.currentUser!;

    return FutureBuilder<ProgressSummary>(
      future: database.loadProgressSummary(user.id),
      builder: (context, snapshot) {
        final summary = snapshot.data;

        return RefreshIndicator(
          onRefresh: () async {
            await database.loadProgressSummary(user.id);
          },
          child: ListView(
            children: [
              _ProfileHeader(
                name: user.displayName,
                email: user.email,
                onSignOut: auth.signOut,
              ),
              const SizedBox(height: 12),
              if (snapshot.connectionState == ConnectionState.waiting &&
                  summary == null)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.all(24),
                    child: CircularProgressIndicator(),
                  ),
                )
              else
                _ProgressContent(summary: summary ?? _emptySummary),
            ],
          ),
        );
      },
    );
  }
}

const _emptySummary = ProgressSummary(
  totalAttempts: 0,
  correctAttempts: 0,
  todayAttempts: 0,
  streakDays: 0,
  activeMistakes: 0,
  mistakes: [],
  taskStats: [],
);

class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({
    required this.name,
    required this.email,
    required this.onSignOut,
  });

  final String name;
  final String email;
  final VoidCallback onSignOut;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: const Color(0xFF10233F),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: Colors.white.withValues(alpha: 0.14),
            child: Text(
              name.trim().isEmpty ? '?' : name.trim()[0].toUpperCase(),
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.72),
                      ),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Выйти',
            onPressed: onSignOut,
            color: Colors.white,
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}

class _ProgressContent extends StatelessWidget {
  const _ProgressContent({
    required this.summary,
  });

  final ProgressSummary summary;

  @override
  Widget build(BuildContext context) {
    final accuracy = '${(summary.accuracy * 100).round()}%';
    final weakTasks = summary.taskStats
        .where((task) => task.totalAttempts >= 2 && task.accuracy < 0.7)
        .toList()
      ..sort((a, b) => a.accuracy.compareTo(b.accuracy));

    return Column(
      children: [
        GridView.count(
          crossAxisCount: MediaQuery.sizeOf(context).width > 700 ? 4 : 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
          childAspectRatio: 1.35,
          children: [
            _MetricCard(
                value: accuracy, label: 'Точность', icon: Icons.track_changes),
            _MetricCard(
                value: '${summary.totalAttempts}',
                label: 'Ответов',
                icon: Icons.done_all),
            _MetricCard(
                value: '${summary.todayAttempts}',
                label: 'Сегодня',
                icon: Icons.today_outlined),
            _MetricCard(
                value: '${summary.streakDays}',
                label: 'Дней подряд',
                icon: Icons.local_fire_department_outlined),
          ],
        ),
        const SizedBox(height: 14),
        _FocusCard(
          mistakes: summary.activeMistakes,
          mistakeItems: summary.mistakes,
          weakTasks: weakTasks,
        ),
        const SizedBox(height: 14),
        _TaskStatsCard(taskStats: summary.taskStats),
      ],
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.value,
    required this.label,
    required this.icon,
  });

  final String value;
  final String label;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(18),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Theme.of(context).colorScheme.primary),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Colors.black54,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FocusCard extends StatelessWidget {
  const _FocusCard({
    required this.mistakes,
    required this.mistakeItems,
    required this.weakTasks,
  });

  final int mistakes;
  final List<ProgressMistakeSummary> mistakeItems;
  final List<ProgressTaskSummary> weakTasks;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Фокус на ближайшую тренировку',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 12),
            if (mistakes == 0 && weakTasks.isEmpty)
              const Text(
                  'Пока нет накопленных ошибок. Реши несколько заданий, и здесь появятся слабые места.')
            else ...[
              _FocusLine(
                icon: Icons.error_outline,
                text: 'Активных ошибок: $mistakes',
              ),
              ...mistakeItems.take(5).map(
                    (mistake) => _MistakeRuleCard(mistake: mistake),
                  ),
              ...weakTasks.take(4).map(
                    (task) => _FocusLine(
                      icon: Icons.school_outlined,
                      text:
                          '${taskScreenTitle(task.taskNumber)}: точность ${(task.accuracy * 100).round()}%',
                    ),
                  ),
            ],
          ],
        ),
      ),
    );
  }
}

class _FocusLine extends StatelessWidget {
  const _FocusLine({
    required this.icon,
    required this.text,
  });

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Theme.of(context).colorScheme.primary),
          const SizedBox(width: 10),
          Expanded(child: Text(text)),
        ],
      ),
    );
  }
}

class _MistakeRuleCard extends StatelessWidget {
  const _MistakeRuleCard({
    required this.mistake,
  });

  final ProgressMistakeSummary mistake;

  @override
  Widget build(BuildContext context) {
    String? firstRulePoint;
    for (final point in mistake.rulePoints) {
      if (point.trim().isNotEmpty && !point.startsWith('## ')) {
        firstRulePoint = point;
        break;
      }
    }

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .errorContainer
            .withValues(alpha: 0.45),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: Theme.of(context).colorScheme.error.withValues(alpha: 0.16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${taskScreenTitle(mistake.taskNumber)} · правило к ошибке',
            style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w900,
                ),
          ),
          const SizedBox(height: 8),
          Text(
            mistake.ruleSummary,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  height: 1.35,
                ),
          ),
          if (firstRulePoint != null &&
              firstRulePoint != mistake.ruleSummary) ...[
            const SizedBox(height: 6),
            Text(
              firstRulePoint,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.black54,
                    height: 1.35,
                  ),
            ),
          ],
        ],
      ),
    );
  }
}

class _TaskStatsCard extends StatelessWidget {
  const _TaskStatsCard({
    required this.taskStats,
  });

  final List<ProgressTaskSummary> taskStats;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Статистика по заданиям',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w900,
                  ),
            ),
            const SizedBox(height: 12),
            if (taskStats.isEmpty)
              const Text(
                  'Здесь появится статистика после первых ответов в тренажёре.')
            else
              ...taskStats.map((task) => _TaskStatLine(task: task)),
          ],
        ),
      ),
    );
  }
}

class _TaskStatLine extends StatelessWidget {
  const _TaskStatLine({
    required this.task,
  });

  final ProgressTaskSummary task;

  @override
  Widget build(BuildContext context) {
    final percent = (task.accuracy * 100).round();
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${taskScreenTitle(task.taskNumber)}. ${officialTaskTitle(task.taskNumber, defaultTitle: '')}',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                ),
              ),
              const SizedBox(width: 12),
              Text('$percent%'),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: task.accuracy,
            minHeight: 8,
            borderRadius: BorderRadius.circular(999),
          ),
          const SizedBox(height: 4),
          Text(
            '${task.correctAttempts} верно из ${task.totalAttempts}',
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Colors.black54,
                ),
          ),
        ],
      ),
    );
  }
}

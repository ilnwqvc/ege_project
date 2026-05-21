import 'package:go_router/go_router.dart';

import '../features/home/presentation/home_screen.dart';
import '../features/progress/presentation/progress_screen.dart';
import '../features/quiz/presentation/quiz_hub_screen.dart';
import '../features/quiz/presentation/quiz_session_screen.dart';
import '../features/theory/presentation/theory_detail_screen.dart';
import '../features/theory/presentation/theory_screen.dart';

GoRouter buildRouter() {
  return GoRouter(
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/theory',
        builder: (context, state) => const TheoryScreen(),
      ),
      GoRoute(
        path: '/theory/:taskNumber',
        builder: (context, state) {
          final taskNumber = int.parse(state.pathParameters['taskNumber']!);
          return TheoryDetailScreen(taskNumber: taskNumber);
        },
      ),
      GoRoute(
        path: '/quiz',
        builder: (context, state) => const QuizHubScreen(),
      ),
      GoRoute(
        path: '/quiz/mixed',
        builder: (context, state) => const QuizSessionScreen(),
      ),
      GoRoute(
        path: '/quiz/task/:taskNumber',
        builder: (context, state) {
          final taskNumber = int.parse(state.pathParameters['taskNumber']!);
          return QuizSessionScreen(taskNumber: taskNumber);
        },
      ),
      GoRoute(
        path: '/progress',
        builder: (context, state) => const ProgressScreen(),
      ),
    ],
  );
}

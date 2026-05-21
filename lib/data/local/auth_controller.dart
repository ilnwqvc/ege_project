import 'package:flutter/foundation.dart';

import '../remote/auth_api_client.dart';
import 'app_database.dart';

class AuthController extends ChangeNotifier {
  AuthController({
    required AppDatabase database,
    AuthApiClient? apiClient,
  })  : _database = database,
        _apiClient = apiClient ?? AuthApiClient();

  final AppDatabase _database;
  final AuthApiClient _apiClient;

  UserProfilesTableData? _currentUser;
  String? _token;
  bool _isLoading = true;

  UserProfilesTableData? get currentUser => _currentUser;

  String? get token => _token;

  bool get isLoading => _isLoading;

  bool get isSignedIn => _currentUser != null;

  Future<void> load() async {
    _currentUser = await _database.getCurrentUser();
    _token = await _database.getSyncValue('authToken');
    _isLoading = false;
    notifyListeners();
  }

  Future<AuthResult> signUp({
    required String email,
    required String displayName,
    required String password,
  }) async {
    final validationError = _validateCredentials(
      email: email,
      displayName: displayName,
      password: password,
      requireDisplayName: true,
    );
    if (validationError != null) {
      return AuthResult.error(validationError);
    }

    try {
      final session = await _apiClient.register(
        email: email.toLowerCase().trim(),
        displayName: displayName.trim(),
        password: password,
      );
      await _applySession(session);
      return const AuthResult.success();
    } on AuthApiException catch (error) {
      return AuthResult.error(error.message);
    } catch (_) {
      return const AuthResult.error(
          'Не удалось подключиться к серверу авторизации.');
    }
  }

  Future<AuthResult> signIn({
    required String email,
    required String password,
  }) async {
    final validationError = _validateCredentials(
      email: email,
      displayName: 'user',
      password: password,
      requireDisplayName: false,
    );
    if (validationError != null) {
      return AuthResult.error(validationError);
    }

    try {
      final session = await _apiClient.login(
        email: email.toLowerCase().trim(),
        password: password,
      );
      await _applySession(session);
      return const AuthResult.success();
    } on AuthApiException catch (error) {
      return AuthResult.error(error.message);
    } catch (_) {
      return const AuthResult.error(
          'Не удалось подключиться к серверу авторизации.');
    }
  }

  Future<void> signOut() async {
    await _database.setCurrentUser(null);
    await _database.setSyncValue('authToken', null);
    _currentUser = null;
    _token = null;
    notifyListeners();
  }

  Future<void> recordRemoteAttempt({
    required String practiceItemId,
    required int taskNumber,
    required int selectedIndex,
    required bool isCorrect,
    required String ruleSummary,
  }) async {
    final currentToken = _token;
    if (currentToken == null) {
      return;
    }

    try {
      await _apiClient.recordAttempt(
        token: currentToken,
        practiceItemId: practiceItemId,
        taskNumber: taskNumber,
        selectedIndex: selectedIndex,
        isCorrect: isCorrect,
        ruleSummary: ruleSummary,
      );
    } catch (_) {
      // Локальный прогресс уже сохранен, синхронизация повторится позже.
    }
  }

  String? _validateCredentials({
    required String email,
    required String displayName,
    required String password,
    required bool requireDisplayName,
  }) {
    if (!email.contains('@') || !email.contains('.')) {
      return 'Введи нормальную почту.';
    }

    if (requireDisplayName && displayName.trim().length < 2) {
      return 'Имя профиля должно быть чуть длиннее.';
    }

    if (password.length < 6) {
      return 'Пароль должен быть минимум 6 символов.';
    }

    return null;
  }

  Future<void> _applySession(AuthApiSession session) async {
    await _database.cacheRemoteUserProfile(
      id: session.user.id,
      email: session.user.email,
      displayName: session.user.displayName,
    );
    await _syncRemoteProgress(session);
    await _database.setCurrentUser(session.user.id);
    await _database.setSyncValue('authToken', session.token);
    _token = session.token;
    _currentUser = await _database.getCurrentUser();
    notifyListeners();
  }

  Future<void> _syncRemoteProgress(AuthApiSession session) async {
    try {
      final attempts = await _apiClient.loadAttempts(token: session.token);
      await _database.cacheRemoteAttempts(
        userId: session.user.id,
        attempts: attempts
            .map(
              (attempt) => RemoteAttemptCacheInsert(
                remoteAttemptId: attempt.id,
                practiceItemId: attempt.practiceItemId,
                selectedIndex: attempt.selectedIndex,
                isCorrect: attempt.isCorrect,
                answeredAt: attempt.answeredAt,
              ),
            )
            .toList(growable: false),
      );
    } catch (_) {
      // Пользователь продолжает работу с локальным кешем до следующего входа.
    }
  }
}

class AuthResult {
  const AuthResult._({
    required this.isSuccess,
    this.message,
  });

  const AuthResult.success() : this._(isSuccess: true);

  const AuthResult.error(String message)
      : this._(
          isSuccess: false,
          message: message,
        );

  final bool isSuccess;
  final String? message;
}

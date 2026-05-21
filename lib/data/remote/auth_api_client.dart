import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class AuthApiClient {
  AuthApiClient({
    http.Client? httpClient,
    Uri? baseUri,
  })  : _httpClient = httpClient ?? http.Client(),
        _baseUri = baseUri ?? _defaultBaseUri();

  final http.Client _httpClient;
  final Uri _baseUri;

  static Uri _defaultBaseUri() {
    if (kIsWeb) {
      return Uri.base.resolve('/api');
    }

    return Uri.parse('https://bellatores.fun/api');
  }

  Future<AuthApiSession> register({
    required String email,
    required String displayName,
    required String password,
  }) {
    return _postSession(
      '/auth/register',
      {
        'email': email,
        'displayName': displayName,
        'password': password,
      },
    );
  }

  Future<AuthApiSession> login({
    required String email,
    required String password,
  }) {
    return _postSession(
      '/auth/login',
      {
        'email': email,
        'password': password,
      },
    );
  }

  Future<void> recordAttempt({
    required String token,
    required String practiceItemId,
    required int taskNumber,
    required int selectedIndex,
    required bool isCorrect,
    required String ruleSummary,
  }) async {
    final response = await _httpClient.post(
      _url('/progress/attempts'),
      headers: _headers(token: token),
      body: jsonEncode({
        'practiceItemId': practiceItemId,
        'taskNumber': taskNumber,
        'selectedIndex': selectedIndex,
        'isCorrect': isCorrect,
        'ruleSummary': ruleSummary,
      }),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AuthApiException(_errorMessage(response));
    }
  }

  Future<List<AuthApiAttempt>> loadAttempts({
    required String token,
  }) async {
    final response = await _httpClient.get(
      _url('/progress/attempts'),
      headers: _headers(token: token),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AuthApiException(_errorMessage(response));
    }

    final json =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final attemptsJson = (json['attempts'] as List<dynamic>? ?? const []);
    return attemptsJson
        .map((item) => AuthApiAttempt.fromJson(item as Map<String, dynamic>))
        .toList(growable: false);
  }

  Future<AuthApiSession> _postSession(
    String path,
    Map<String, Object?> payload,
  ) async {
    final response = await _httpClient.post(
      _url(path),
      headers: _headers(),
      body: jsonEncode(payload),
    );

    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw AuthApiException(_errorMessage(response));
    }

    final json =
        jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
    final userJson = json['user'] as Map<String, dynamic>;
    return AuthApiSession(
      token: json['token'] as String,
      user: AuthApiUser(
        id: userJson['id'] as String,
        email: userJson['email'] as String,
        displayName: userJson['displayName'] as String,
      ),
    );
  }

  Uri _url(String path) {
    final cleanBase = _baseUri.toString().replaceFirst(RegExp(r'/$'), '');
    return Uri.parse('$cleanBase$path');
  }

  Map<String, String> _headers({String? token}) {
    return {
      'Content-Type': 'application/json; charset=utf-8',
      if (token != null) 'Authorization': 'Bearer $token',
    };
  }

  String _errorMessage(http.Response response) {
    try {
      final json =
          jsonDecode(utf8.decode(response.bodyBytes)) as Map<String, dynamic>;
      return (json['error'] as String?) ?? 'Ошибка сервера авторизации.';
    } catch (_) {
      return 'Ошибка сервера авторизации: ${response.statusCode}.';
    }
  }
}

class AuthApiSession {
  const AuthApiSession({
    required this.token,
    required this.user,
  });

  final String token;
  final AuthApiUser user;
}

class AuthApiUser {
  const AuthApiUser({
    required this.id,
    required this.email,
    required this.displayName,
  });

  final String id;
  final String email;
  final String displayName;
}

class AuthApiAttempt {
  const AuthApiAttempt({
    required this.id,
    required this.practiceItemId,
    required this.taskNumber,
    required this.selectedIndex,
    required this.isCorrect,
    required this.ruleSummary,
    required this.answeredAt,
  });

  factory AuthApiAttempt.fromJson(Map<String, dynamic> json) {
    return AuthApiAttempt(
      id: json['id'] as int,
      practiceItemId: json['practiceItemId'] as String,
      taskNumber: json['taskNumber'] as int,
      selectedIndex: json['selectedIndex'] as int,
      isCorrect: json['isCorrect'] as bool,
      ruleSummary: json['ruleSummary'] as String? ?? '',
      answeredAt: DateTime.fromMillisecondsSinceEpoch(
        (json['answeredAt'] as int) * 1000,
      ),
    );
  }

  final int id;
  final String practiceItemId;
  final int taskNumber;
  final int selectedIndex;
  final bool isCorrect;
  final String ruleSummary;
  final DateTime answeredAt;
}

class AuthApiException implements Exception {
  const AuthApiException(this.message);

  final String message;

  @override
  String toString() => message;
}

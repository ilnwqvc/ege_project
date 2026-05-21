class PracticeTask {
  const PracticeTask({
    required this.id,
    required this.taskNumber,
    required this.title,
    required this.topic,
    required this.question,
    required this.options,
    required this.correctIndex,
    required this.explanation,
    required this.ruleSummary,
    required this.rulePoints,
    this.source = 'seed',
    this.difficulty = 'medium',
    this.tags = const [],
    this.answerMode = PracticeTaskAnswerMode.singleChoice,
    this.acceptedAnswers = const [],
    this.inputPlaceholder = 'Введите ответ',
  });

  final String id;
  final int taskNumber;
  final String title;
  final String topic;
  final String question;
  final List<String> options;
  final int correctIndex;
  final String explanation;
  final String ruleSummary;
  final List<String> rulePoints;
  final String source;
  final String difficulty;
  final List<String> tags;
  final PracticeTaskAnswerMode answerMode;
  final List<String> acceptedAnswers;
  final String inputPlaceholder;

  bool get isInputTask => answerMode == PracticeTaskAnswerMode.textInput;

  factory PracticeTask.fromJson(Map<String, dynamic> json) {
    final answerMode = PracticeTaskAnswerModeX.fromJson(
      json['answerMode'] as String?,
    );
    final acceptedAnswers = ((json['acceptedAnswers'] as List<dynamic>?) ?? const [])
        .cast<String>();

    return PracticeTask(
      id: json['id'] as String,
      taskNumber: json['taskNumber'] as int,
      title: json['title'] as String,
      topic: json['topic'] as String,
      question: json['question'] as String,
      options: (json['options'] as List<dynamic>).cast<String>(),
      correctIndex: json['correctIndex'] as int,
      explanation: json['explanation'] as String,
      ruleSummary: json['ruleSummary'] as String,
      rulePoints: (json['rulePoints'] as List<dynamic>).cast<String>(),
      source: (json['source'] as String?) ?? 'seed',
      difficulty: (json['difficulty'] as String?) ?? 'medium',
      tags: ((json['tags'] as List<dynamic>?) ?? const []).cast<String>(),
      answerMode: answerMode,
      acceptedAnswers: acceptedAnswers,
      inputPlaceholder:
          (json['inputPlaceholder'] as String?) ?? 'Введите ответ',
    );
  }
}

enum PracticeTaskAnswerMode {
  singleChoice,
  textInput,
}

extension PracticeTaskAnswerModeX on PracticeTaskAnswerMode {
  static PracticeTaskAnswerMode fromJson(String? value) {
    switch (value) {
      case 'textInput':
        return PracticeTaskAnswerMode.textInput;
      case 'singleChoice':
      case null:
        return PracticeTaskAnswerMode.singleChoice;
    }

    return PracticeTaskAnswerMode.singleChoice;
  }

  String get jsonValue {
    switch (this) {
      case PracticeTaskAnswerMode.singleChoice:
        return 'singleChoice';
      case PracticeTaskAnswerMode.textInput:
        return 'textInput';
    }
  }
}

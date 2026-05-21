class ExamTaskContent {
  const ExamTaskContent({
    required this.id,
    required this.number,
    required this.title,
    required this.skill,
    required this.shortDescription,
    required this.officialBasis,
    required this.theoryPoints,
    required this.solvingSteps,
    required this.tags,
    required this.sources,
    this.pitfalls = const [],
    this.checklist = const [],
    this.isEssay = false,
  });

  final String id;
  final int number;
  final String title;
  final String skill;
  final String shortDescription;
  final String officialBasis;
  final List<String> theoryPoints;
  final List<String> solvingSteps;
  final List<String> pitfalls;
  final List<String> checklist;
  final List<String> tags;
  final List<ContentSource> sources;
  final bool isEssay;

  factory ExamTaskContent.fromJson(Map<String, dynamic> json) {
    final taskNumber = json['number'] as int;

    List<String> readPoints(String key) {
      final raw = (json[key] as List<dynamic>?) ?? const [];
      final cleaned = raw
          .cast<String>()
          .map((item) => _normalizeTheoryLine(item, taskNumber))
          .where((item) => item.isNotEmpty && item != r'\')
          .toList(growable: false);
      return _mergeWrappedTheoryLines(cleaned);
    }

    return ExamTaskContent(
      id: json['id'] as String,
      number: taskNumber,
      title: json['title'] as String,
      skill: json['skill'] as String,
      shortDescription: _readCleanText(
        json['shortDescription'] as String,
        taskNumber: taskNumber,
        field: 'shortDescription',
      ),
      officialBasis: json['officialBasis'] as String,
      theoryPoints: readPoints('theoryPoints'),
      solvingSteps: readPoints('solvingSteps'),
      pitfalls: readPoints('pitfalls'),
      checklist: readPoints('checklist'),
      tags: ((json['tags'] as List<dynamic>?) ?? const []).cast<String>(),
      sources: (json['sources'] as List<dynamic>)
          .map((item) => ContentSource.fromJson(item as Map<String, dynamic>))
          .toList(),
      isEssay: (json['isEssay'] as bool?) ?? false,
    );
  }
}

String _readCleanText(
  String value, {
  required int taskNumber,
  required String field,
}) {
  if (!_isBrokenImportedText(value)) {
    return value;
  }

  if (field == 'shortDescription') {
    switch (taskNumber) {
      case 21:
        return 'Пунктуационный анализ: выбираем предложения с нужной постановкой знаков препинания и проверяем каждое основание.';
      case 22:
        return 'Средства выразительности: тропы, фигуры речи, звукопись и синтаксические приемы в художественном тексте.';
    }
  }

  return '';
}

bool _isBrokenImportedText(String value) {
  final letters = RegExp(r'[A-Za-zА-Яа-яЁё]').allMatches(value).length;
  final questionMarks = '?'.allMatches(value).length;

  return questionMarks >= 5 && questionMarks > letters;
}

String _normalizeTheoryLine(String value, int taskNumber) {
  var line = value.trim();

  if (line.isEmpty || line == r'\') {
    return '';
  }

  if (_isBrokenImportedText(line)) {
    return '';
  }

  line = line
      .replaceAll(RegExp(r'(?<=[A-Za-zА-Яа-яЁё])-\s+(?=[A-Za-zА-Яа-яЁё])'), '')
      .replaceAll(RegExp(r'\s+'), ' ')
      .replaceAll(RegExp(r'\s*–\s*'), ' – ')
      .replaceAll(' ,', ',')
      .replaceAll(' .', '.')
      .replaceAll('( ', '(')
      .replaceAll(' )', ')');

  line = _removePdfImportArtifacts(line, taskNumber);

  line = line.replaceAllMapped(
    RegExp(r'(^|[\s(])n(?=[А-Яа-яЁё])'),
    (match) => '${match.group(1)}п',
  );

  if (line.contains('непроверяемыечередующиеся')) {
    return '';
  }

  if (line.contains('Синтаксические средстваЛексические средства')) {
    return '';
  }

  if (line == '26') {
    return '';
  }

  if (taskNumber == 21 &&
      (line.startsWith('приСПП') ||
          line.startsWith('при ОЧП') ||
          (line.startsWith('при') && line.length < 18))) {
    return '';
  }

  if (RegExp(r'^\(\d+\s+балл[а-я]*\)').hasMatch(line)) {
    return '';
  }

  return line;
}

String _removePdfImportArtifacts(String line, int taskNumber) {
  var result = line;

  result = result.replaceAllMapped(
    RegExp(
      r'(?<=[А-Яа-яЁё])\s+'
      r'(ан|ян|янист|ист|чн|чив|лив|тель|ени|ение|ении|ни|ств|еват|оват|инск|енск|оньк|еньк|ищ|ин|ичн|зч|сч|тч|щ)'
      r'\s+(?=[А-Яа-яЁё])',
    ),
    (match) => match.group(1)!,
  );

  const replacements = <String, String>{
    'ЧН ый': 'ЧНый',
    'ЧИВ-ЛИВ': 'ЧИВ-ЛИВ',
    'дипломати чный': 'дипломатичный',
    'артисти чный': 'артистичный',
    'практи чный': 'практичный',
    'ирони чными': 'ироничными',
    'довер чивый': 'доверчивый',
    'удач ливый': 'удачливый',
    'памят ливый': 'памятливый',
    'глин истая': 'глинистая',
    'камен истая': 'каменистая',
    'уточнении': 'уточнении',
    'определени': 'определении',
    'приложении': 'приложении',
    'обстоятельстве': 'обстоятельстве',
    'лексич.': 'лексический',
    'ритор.': 'риторическое',
  };

  for (final entry in replacements.entries) {
    result = result.replaceAll(entry.key, entry.value);
  }

  if (taskNumber == 21) {
    const noisyLines = {
      'при БСП при',
      'при',
      'ьстве при',
    };
    if (noisyLines.contains(result) ||
        result.startsWith('Запятая при ОЧП при вводных словах') ||
        result.startsWith('при определ')) {
      return '';
    }
  }

  if (taskNumber == 22 &&
      !result.startsWith('## ') &&
      result.length > 90 &&
      !result.contains(RegExp(r'[.:;–]'))) {
    return '';
  }

  return result.replaceAll(RegExp(r'\s+'), ' ').trim();
}

List<String> _mergeWrappedTheoryLines(List<String> lines) {
  final merged = <String>[];

  for (final line in lines) {
    if (line.isEmpty) {
      continue;
    }

    if (merged.isEmpty) {
      merged.add(line);
      continue;
    }

    final previous = merged.last;
    final shouldMerge = _shouldMergeLines(previous, line);
    if (shouldMerge) {
      merged[merged.length - 1] =
          '$previous $line'.replaceAll(RegExp(r'\s+'), ' ').trim();
    } else if (previous != line) {
      merged.add(line);
    }
  }

  return merged;
}

bool _shouldMergeLines(String previous, String current) {
  if (_isSingleLetterHeader(previous) || _isSingleLetterHeader(current)) {
    return false;
  }

  if (previous.endsWith(':') ||
      previous.endsWith('.') ||
      previous.endsWith('!') ||
      previous.endsWith('?')) {
    return false;
  }

  if (current.startsWith('## ') || current.startsWith('! ')) {
    return false;
  }

  final looksLikeHeader =
      current == current.toUpperCase() && current.length <= 40;
  if (looksLikeHeader) {
    return false;
  }

  final previousHasOpenParen =
      '('.allMatches(previous).length > ')'.allMatches(previous).length;
  final startsLowercaseOrBracket = RegExp(r'^[а-яa-z(]').hasMatch(current);
  final startsTinyContinuation = current.length <= 18 && !current.contains(':');
  final previousShort = previous.length < 120;

  return previousShort &&
      (previousHasOpenParen ||
          startsLowercaseOrBracket ||
          startsTinyContinuation);
}

bool _isSingleLetterHeader(String value) {
  final cleaned = value.replaceAll(RegExp(r'[^A-Za-zА-Яа-яЁё]'), '').trim();
  if (cleaned.length != 1) {
    return false;
  }

  return cleaned == cleaned.toUpperCase();
}

class ContentSource {
  const ContentSource({
    required this.label,
    required this.url,
    required this.kind,
  });

  final String label;
  final String url;
  final String kind;

  factory ContentSource.fromJson(Map<String, dynamic> json) {
    return ContentSource(
      label: json['label'] as String,
      url: json['url'] as String,
      kind: json['kind'] as String,
    );
  }
}

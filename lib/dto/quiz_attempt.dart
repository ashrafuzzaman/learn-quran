class QuizAttempt {
  final String wordId;
  final DateTime? attemptAt;
  final bool isCorrect;

  QuizAttempt({required this.wordId, this.attemptAt, required this.isCorrect});

  Map<String, Object?> toMap() {
    return {'wordId': wordId, 'isCorrect': isCorrect, 'attemptAt': attemptAt};
  }
}

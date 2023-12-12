class QuizAttempt {
  final String wordId;
  final DateTime attemptAt;
  final bool isCorrect;

  QuizAttempt(
      {required this.wordId, required this.attemptAt, required this.isCorrect});
}

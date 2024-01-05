class Lesson {
  final String name;
  final String description;
  final int id;
  final int totalWords;
  final int wordsLearned;

  Lesson(
      {required this.id,
      required this.name,
      required this.description,
      this.totalWords = 0,
      this.wordsLearned = 0});
}

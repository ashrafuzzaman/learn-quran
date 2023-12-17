import 'package:learnquran/dto/multi_Choice_question.dart';

class Quiz {
  final Iterable<MultiChoiceQuestion> mcqList;
  int attempted = 0;
  int corrected = 0;

  Quiz({required this.mcqList});

  recordAttempt(bool isCorrect) {
    attempted += 1;
    if (isCorrect) {
      corrected += 1;
    }
  }
}

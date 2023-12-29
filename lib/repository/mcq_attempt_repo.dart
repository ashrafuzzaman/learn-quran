import 'package:learnquran/repository/words_repo.dart';
import 'package:learnquran/service/database.dart';
import 'package:logging/logging.dart';

const String tableQuizAttempt = 'mcq_attempts';
const String columnWordId = 'wordId';
const String columnIsCorrect = 'isCorrect';

class WordAttempt {
  final String wordId;
  int? totalCorrect;
  int? totalFailed;

  WordAttempt({required this.wordId});
}

class MCQAttemptRepo extends DbService {
  @override
  final log = Logger('MCQAttemptRepo');

  recordAttempt(int wordId, isCorrect) async {
    log.info('recordAttempt: $wordId $isCorrect');

    await insert(tableQuizAttempt, {
      'wordId': wordId,
      'isCorrect': isCorrect ? 1 : 0,
    });

    // Mark word as learned if corrected once
    // Later need to check if the last 2 attempts were correct
    if (isCorrect) {
      await WordRepo().markLearned(wordId);
    }
  }

  getTotalWordIdsAttempted() async {
    return await query(tableQuizAttempt);
  }

  Future<List<WordAttempt>> getWordAttemptsWithCount() async {
    var result = await query(tableQuizAttempt,
        distinct: true,
        columns: [columnWordId, columnIsCorrect, 'count(*) as total'],
        groupBy: "$columnWordId, $columnIsCorrect");

    Map<String, WordAttempt> wordsAttemptMap = {};
    for (final row in result) {
      var wordId = row[columnWordId].toString();
      wordsAttemptMap[wordId] ??= WordAttempt(wordId: wordId);

      WordAttempt attempt =
          wordsAttemptMap[wordId] ?? WordAttempt(wordId: wordId);
      var total = int.parse(row['total'].toString());

      if (row[columnIsCorrect] != 0) {
        attempt.totalCorrect = total;
      } else {
        attempt.totalFailed = total;
      }
      wordsAttemptMap[wordId] = attempt;
    }

    var wordAttempts = List<WordAttempt>.of(wordsAttemptMap.values);
    wordAttempts.sort((a, b) =>
        ((b.totalFailed ?? 0) - (b.totalCorrect ?? 0)) -
        ((a.totalFailed ?? 0) - (a.totalCorrect ?? 0)));
    return wordAttempts;
  }
}

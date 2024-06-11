import 'package:learnquran/repository/repo_base.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:logging/logging.dart';

const String tableQuizAttempt = 'mcq_attempts';
const String columnWordId = 'wordId';
const String columnIsCorrect = 'isCorrect';
const String columnAttemptAt = 'attemptAt';

class WordAttemptResult {
  final String wordId;
  int? totalCorrect;
  int? totalFailed;

  WordAttemptResult({required this.wordId});
}

class WordAttempt {
  final String wordId;
  bool isCorrect;
  DateTime attemptAt;

  WordAttempt(
      {required this.wordId, required this.isCorrect, required this.attemptAt});
}

class MCQAttemptRepo extends RepoBase {
  @override
  final log = Logger('MCQAttemptRepo');

  recordAttempt(int wordId, isCorrect) async {
    const int lastConsecutiveCorrect = 1;
    log.info('recordAttempt: $wordId $isCorrect');

    await insert(tableQuizAttempt, {
      'wordId': wordId,
      'isCorrect': isCorrect ? 1 : 0,
    });

    if (isCorrect) {
      await WordRepo().touchLastCorrectedAt(wordId);

      int totaltLastCorrected = await getTotalLastConsecutiveCorrect(wordId);
      if (totaltLastCorrected >= lastConsecutiveCorrect) {
        await WordRepo().markLearned(wordId);
      }
    }
  }

  Future<int> getTotalLastConsecutiveCorrect(int wordId) async {
    List<WordAttempt> attempts = await getWordAttemptsForWord(wordId);
    int totaltLastCorrected = 0;
    for (var i = 0; i < attempts.length; i++) {
      if (attempts[i].isCorrect) {
        totaltLastCorrected++;
      } else {
        break;
      }
    }
    return totaltLastCorrected;
  }

  getTotalWordIdsAttempted() async {
    return await query(tableQuizAttempt);
  }

  Future<List<WordAttempt>> getWordAttemptsForWord(wordId) async {
    var result = await query(tableQuizAttempt,
        columns: [columnWordId, columnIsCorrect, columnAttemptAt],
        where: '$columnWordId = ?',
        whereArgs: [wordId],
        orderBy: '$columnAttemptAt DESC');
    return result
        .map((row) => WordAttempt(
            wordId: row[columnWordId].toString(),
            isCorrect: row[columnIsCorrect] == 1,
            attemptAt: DateTime.parse(row[columnAttemptAt].toString())))
        .toList();
  }

  // Not planning use this method as this would be very expensive
  @deprecated
  Future<List<WordAttemptResult>> getWordAttemptsWithCount() async {
    var result = await query(tableQuizAttempt,
        distinct: true,
        columns: [columnWordId, columnIsCorrect, 'count(*) as total'],
        groupBy: "$columnWordId, $columnIsCorrect");

    Map<String, WordAttemptResult> wordsAttemptMap = {};
    for (final row in result) {
      var wordId = row[columnWordId].toString();
      wordsAttemptMap[wordId] ??= WordAttemptResult(wordId: wordId);

      WordAttemptResult attempt =
          wordsAttemptMap[wordId] ?? WordAttemptResult(wordId: wordId);
      var total = int.parse(row['total'].toString());

      if (row[columnIsCorrect] != 0) {
        attempt.totalCorrect = total;
      } else {
        attempt.totalFailed = total;
      }
      wordsAttemptMap[wordId] = attempt;
    }

    var wordAttempts = List<WordAttemptResult>.of(wordsAttemptMap.values);
    wordAttempts.sort((a, b) =>
        ((b.totalFailed ?? 0) - (b.totalCorrect ?? 0)) -
        ((a.totalFailed ?? 0) - (a.totalCorrect ?? 0)));
    return wordAttempts;
  }
}

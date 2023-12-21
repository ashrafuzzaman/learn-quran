import 'package:learnquran/service/database.dart';
import 'package:logging/logging.dart';

const String tableProgression = 'progression';
const String columnWordId = 'wordId';
const String columnLessonId = 'lessonId';

class Progression {
  final String wordId;
  final int lessonId;

  Progression({required this.wordId, required this.lessonId});
}

class ProgressionRepo extends DbService {
  final log = Logger('ProgressionRepo');

  recordProgression(String wordId, int lessonId) async {
    await resetProgression();
    await insert(tableProgression, {
      'wordId': wordId,
      'lessonId': lessonId,
    });
  }

  resetProgression() async {
    await delete(tableProgression);
  }

  Future<Progression?> getProgression() async {
    var record = await query(tableProgression);
    if (record.isNotEmpty) {
      return Progression(
          wordId: record.first[columnWordId].toString(),
          lessonId: int.parse(record.first[columnLessonId].toString()));
    }
    return null;
  }
}

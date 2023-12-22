import 'package:learnquran/service/database.dart';
import 'package:logging/logging.dart';

const String tableProgression = 'progression';
const String columnWordId = 'wordId';

class ProgressionRepo extends DbService {
  final log = Logger('ProgressionRepo');

  recordProgression(String wordId) async {
    await resetProgression();
    await insert(tableProgression, {
      'wordId': wordId,
    });
  }

  resetProgression() async {
    await delete(tableProgression);
  }

  Future<String?> getLatestReadWordId() async {
    var record = await query(tableProgression);
    if (record.isNotEmpty) {
      return record.first[columnWordId].toString();
    }
    return null;
  }
}

import 'package:learnquran/dto/bookmark.dart';
import 'package:learnquran/service/database.dart';
import 'package:logging/logging.dart';

const String tableBookmark = 'bookmark_words';
const String columnWordId = 'wordId';

class BookmarkRepo extends DbService {
  final log = Logger('BookmarkRepo');

  Future<List<String>> getBookmarkedWordIds() async {
    var result = await query(tableBookmark, columns: [columnWordId]);
    return result.map((row) => row[columnWordId].toString()).toList();
  }

  Future<bool> isMarked(int wordId) async {
    final result = await query(tableBookmark,
        columns: ['count(*) as total'],
        where: '$columnWordId=?',
        whereArgs: [wordId]);
    return result.first['total'] == 1;
  }

  Future<Bookmark> toggleMarked(int wordId) async {
    var marked = await isMarked(wordId);
    if (marked) {
      await unMark(wordId);
    } else {
      await mark(wordId);
    }
    marked = await isMarked(wordId);
    return Bookmark(wordId: wordId, isMarked: marked);
  }

  mark(int wordId) async {
    var marked = await isMarked(wordId);
    if (marked) {
      return;
    }
    await insert(tableBookmark, {
      columnWordId: wordId,
    });
  }

  unMark(int wordId) async {
    return await delete(tableBookmark,
        where: '$columnWordId = ?', whereArgs: [wordId]);
  }
}

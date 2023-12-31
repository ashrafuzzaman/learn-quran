import 'package:learnquran/dto/example.dart';
import 'package:learnquran/repository/repo_base.dart';
import 'package:learnquran/repository/word_example_csv_repo.dart';
import 'package:learnquran/repository/words_repo.dart';
import 'package:logging/logging.dart';

const String tableExamples = 'examples';
const String columnWordId = 'wordId';
const String columnArabic = 'arabic';
const String columnMeaning = 'meaning';
const String columnAyahRef = 'ayah_ref';
const String columnHighlight = 'highlight';

class ExamplesRepo extends RepoBase {
  @override
  final log = Logger('ExamplesRepo');

  Future<Example?> findByWordAndAyahRef(String word, String ayahRef) async {
    var result = await rawQuery('''
        SELECT e.*
        FROM words w
        INNER JOIN $tableExamples e ON w.id=e.$columnWordId
        WHERE w.arabic=? AND $columnAyahRef=?
        LIMIT 1
        ''', [word, ayahRef]);
    if (result.isNotEmpty) {
      return _recordToExample(result.first);
    }
    return null;
  }

  Future<Example?> findByWordIdAndAyahRef(int wordId, String ayahRef) async {
    var result = await query(tableExamples,
        where: '$columnWordId = ? AND $columnAyahRef = ?',
        whereArgs: [wordId, ayahRef]);
    if (result.isNotEmpty) {
      return _recordToExample(result.first);
    }
    return null;
  }

  Future<List<Example>?> findExamplesByWordId(int wordId) async {
    var result = await query(tableExamples,
        where: '$columnWordId = ?', whereArgs: [wordId]);
    if (result.isNotEmpty) {
      return result.map((record) => _recordToExample(record)).toList();
    }
    return null;
  }

  Future<List<Map<String, Object?>>> getExampleCountByWord() async {
    return await query(tableExamples, groupBy: columnWordId, columns: [
      columnWordId,
      'COUNT(*) as count',
    ]);
  }

  sync(ExampleFromCsv example) async {
    var dbExample =
        await findByWordIdAndAyahRef(example.wordId, example.ayahRef);
    var wordRepo = WordRepo();
    if (dbExample == null) {
      var word = (await wordRepo.findWordById(example.wordId))!;
      await insert(tableExamples, {
        columnWordId: word.id,
        columnArabic: example.arabic,
        columnHighlight: example.highlight,
        columnMeaning: example.meaning,
        columnAyahRef: example.ayahRef,
      });
    } else {
      await update(
          tableExamples,
          {
            columnArabic: example.arabic,
            columnHighlight: example.highlight,
            columnMeaning: example.meaning,
          },
          where: '$columnWordId = ? AND $columnAyahRef = ?',
          whereArgs: [
            example.wordId,
            example.ayahRef,
          ]);
    }
  }

  Example _recordToExample(Map<String, Object?> record) {
    return Example(
      wordId: int.parse(record[columnWordId].toString()),
      arabic: record[columnArabic].toString(),
      meaning: record[columnMeaning].toString(),
      ayahRef: record[columnAyahRef].toString(),
      highlight: record[columnHighlight].toString(),
    );
  }
}

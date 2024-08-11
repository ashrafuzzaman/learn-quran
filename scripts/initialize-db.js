import { exec } from 'child_process';
import { parse } from 'csv-parse/sync';
import * as fsPromises from 'node:fs/promises';

import Realm from 'realm';

// TODO: Can not import Stage from existing app in the script directory. Fix it
class Stage extends Realm.Object {
  id;
  name;
  description;
  totalLessons;
  totalLessonsComplete;

  static schema = {
    name: "Stage",
    primaryKey: "id",
    properties: {
      id: "int",
      totalLessons: { type: "int", default: 0 },
      totalLessonsComplete: { type: "int", default: 0 },
      name: "string",
      description: "string",
    },
  };
}

class Lesson extends Realm.Object {
  id;
  stageId;
  name;
  totalWords;
  totalWordsLearned;

  static schema = {
    name: "Lesson",
    properties: {
      id: "int",
      stageId: "int",
      totalWords: { type: "int", default: 0 },
      totalWordsLearned: { type: "int", default: 0 },
      name: "string",
    },
  };
}

class Word extends Realm.Object {
  id;
  lessonId;
  stageId;
  audioId;
  gender;
  number;
  arabic;
  meaning;
  learned;

  static schema = {
    name: "Word",
    primaryKey: "id",

    properties: {
      id: "int",
      lessonId: "int",
      stageId: "int",
      audioId: "string",
      gender: "string",
      number: "string",
      arabic: "string",
      meaning: "string",
      learned: { type: "bool", default: false },
    },
  };
}

class Example extends Realm.Object {
  ayahRef;
  wordId;
  arabic;
  translation;
  highlight;

  static schema = {
    name: "Example",
    properties: {
      ayahRef: "string",
      wordId: "int",
      arabic: "string",
      translation: "string",
      highlight: "string",
    },
  };
}

const localConfig = {
  schema: [Stage, Lesson, Word, Example],
  path: "assets/db.realm",
  deleteRealmIfMigrationNeeded: true,
};

async function getData(fileName) {
  const content = await fsPromises.readFile(`${process.cwd()}/scripts/data/${fileName}.csv`);
  return parse(content, {
    columns: true,
    skip_empty_lines: true
  });
}

async function getStages() {
  return await getData('Stages');
}

async function getLessons() {
  return await getData('Lessons');
}

async function getWords() {
  return await getData('Words');
}

async function getExamples() {
  return await getData('Examples');
}

function getWordByArabic(realm, arabic) {
  return realm.objects('Word').filtered('arabic = $0', arabic.trim())[0];
}

function loadExamplesToDB(realm, examples) {
  let currentWordId, totalWordsNotFound = 0;
  examples.forEach(example => {
    const isWordNewWord = example.ayahRef === '' && example.highlight === '';
    if (isWordNewWord) {
      if (example.wordId !== '') {
        currentWordId = parseInt(example.wordId);
        return;
      }
      const currentWord = getWordByArabic(realm, example.word);
      if (currentWord === undefined) {
        console.log(`Word not found[${currentWordId + 1}]: ${example.word}`);
        totalWordsNotFound++;
        currentWordId = undefined;
        return;
      }
      currentWordId = currentWord.id;
      return;
    }

    if (currentWordId === undefined) {
      return;
    }

    realm.create("Example", {
      ayahRef: example.ayahRef.trim(),
      wordId: currentWordId,
      arabic: example.word.trim(),
      translation: example.translation.trim(),
      highlight: example.highlight.trim(),
    }, "modified");
  });
  console.log(`Total words not found: ${totalWordsNotFound}`);
}


function upsertStage(realm, stage) {
  realm.create("Stage", {
    id: parseInt(stage.id),
    name: stage.name,
    description: stage.description,
    isComplete: false
  }, "modified");
}

function upsertLesson(realm, lesson) {
  const lessonExists = realm.objects('Lesson').filtered('id = $0 && stageId = $1', lesson.id, lesson.stageId).length > 0;
  if (lessonExists) {
    return;
  }
  realm.create("Lesson", {
    id: parseInt(lesson.id),
    stageId: parseInt(lesson.stageId),
    name: lesson.name,
  }, "modified");
}

function upsertWord(realm, word) {
  realm.create("Word", {
    ...word,
    id: parseInt(word.id),
    lessonId: parseInt(word.lessonId),
    stageId: parseInt(word.stageId),
    arabic: word.word.trim(),
    gender: word.gender.trim(),
    number: word.number.trim(),
    audioId: word.audioId.trim(),
  }, "modified");
}

async function updateCounters(realm) {
  realm.objects("Stage").map(stage => {
    const totalLessons = realm.objects('Lesson').filtered('stageId == $0', stage.id).length;
    realm.write(() => {
      stage.totalLessons = totalLessons;
    });
  });
  realm.objects("Lesson").map(lesson => {
    const totalWords = realm.objects('Word').filtered('lessonId = $0 and stageId == $1',
      lesson.id, lesson.stageId).length;
    realm.write(() => {
      lesson.totalWords = totalWords;
    });
  });
}

async function seed() {
  const realm = await Realm.open(localConfig);

  const stages = await getStages(realm);
  const lessons = await getLessons(realm);
  const words = await getWords(realm);
  const examples = await getExamples(realm);

  realm.write(() => {
    stages.map(stage => upsertStage(realm, stage));
    lessons.map(lesson => upsertLesson(realm, lesson));
    words.map(word => upsertWord(realm, word));
    loadExamplesToDB(realm, examples);
  });

  updateCounters(realm);
}

async function main() {
  await seed()
  exec('rm -rf assets/db.realm.management* assets/db.realm.note*');
  process.exit();
}

await main();

import { exec } from 'child_process';
import { parse } from 'csv-parse/sync';
import * as fsPromises from 'node:fs/promises';

import Realm from 'realm';

// TODO: Can not import Stage from existing app in the script directory. Fix it
class Stage extends Realm.Object {
  id;
  description;
  isComplete = false;

  static schema = {
    name: "Stage",
    primaryKey: "id",
    properties: {
      id: "int",
      description: "string",
      isComplete: "bool",
    },
  };
}

class Lesson extends Realm.Object {
  id;
  stageId;
  name;

  static schema = {
    name: "Lesson",
    properties: {
      id: "int",
      stageId: "int",
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
};
const realm = await Realm.open(localConfig);

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

function getWordByArabic(id, arabic) {
  if(id) {
    return realm.objects('Word').filtered('id = $0', id)[0];
  }
  return realm.objects('Word').filtered('arabic = $0', arabic)[0];
}

function loadExamplesToDB(examples) {
  let currentWordId;
  examples.map(example => {
    const isWordNewWord = example.ayahRef === '' && example.highlight === '';
    if(isWordNewWord) {
      const currentWord = getWordByArabic(example.wordId, example.word);
      if (currentWord === undefined) {
        console.log(`Word not found: ${example.word}`);
        return;
      }
      currentWordId = currentWord.id;
      return;
    }

    realm.create("Example", {
      ayahRef: example.ayahRef,
      wordId: currentWordId,
      arabic: example.word,
      translation: example.translation,
      highlight: example.highlight,
    }, "modified");
  });
}


async function seed() {
  const stages = await getStages();
  const lessons = await getLessons();
  const words = await getWords();
  const examples = await getExamples();

  realm.write(() => {
    stages.map(stage => upsertStage(stage));
    lessons.map(lesson => upsertLesson(lesson));
    words.map(word => upsertWord(word));
    loadExamplesToDB(examples);
  });
}

function upsertStage(stage) {
  realm.create("Stage", {
    id: parseInt(stage.id),
    name: stage.name,
    description: stage.description,
    isComplete: false
  }, "modified");
}

function upsertLesson(lesson) {
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

function upsertWord(word) {
  realm.create("Word", {
    ...word,
    id: parseInt(word.id),
    lessonId: parseInt(word.lessonId),
    stageId: parseInt(word.stageId),
    arabic: word.word,
  }, "modified");
}

await seed();

exec('rm -rf assets/db.realm.management assets/db.realm.lock assets/db.realm.note');

process.exit();

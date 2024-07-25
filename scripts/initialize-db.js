import { exec } from 'child_process';
import { parse } from 'csv-parse/sync';
import * as fsPromises from 'node:fs/promises';

import Realm from 'realm';

// TODO: Can not import Stage from existing app in the script directory. Fix it
class Stage extends Realm.Object {
  id;
  description;
  isComplete = false;

  constructor(realm, description) {
    super(realm, { description });
  }

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

  constructor(realm, description) {
    super(realm, { description });
  }

  static schema = {
    name: "Lesson",
    properties: {
      id: "int",
      stageId: "int",
      name: "string",
    },
  };
}
const localConfig = {
  schema: [Stage, Lesson],
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

async function getExamples() {
  return await getData('Examples');
}

async function seed() {
  const stages = await getStages();
  const lessons = await getLessons();

  realm.write(() => {
    stages.map(stage => upsertStage(stage));
    lessons.map(lesson => upsertLesson(lesson));
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


await seed();

exec('rm -rf assets/db.realm.management assets/db.realm.lock assets/db.realm.note');

process.exit();

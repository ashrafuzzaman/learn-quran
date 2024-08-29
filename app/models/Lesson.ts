import { Realm } from 'realm';

export class Lesson extends Realm.Object {
  id!: number;
  stageId!: number;
  name!: string;
  isComplete = false;

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

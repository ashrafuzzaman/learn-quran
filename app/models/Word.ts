import { Realm } from 'realm';

export class Word extends Realm.Object {
  id!: number;
  lessonId!: number;
  stageId!: number;
  audioId!: string;
  gender!: string;
  number!: string;
  arabic!: string;
  meaning!: string;
  learned!: boolean;

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

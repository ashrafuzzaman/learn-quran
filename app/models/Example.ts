import { Realm } from 'realm';

export class Example extends Realm.Object {
  ayahRef!: string;
  wordId!: number;
  arabic!: string;
  translation!: string;
  highlight!: string;

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

import { Realm } from 'realm';

export class Lesson extends Realm.Object {
  id!: number;
  stageId!: number;
  name!: string;
  isComplete = false;

  static primaryKey = "id";

  constructor(realm: Realm, description: string) {
    super(realm, { description });
  }
}

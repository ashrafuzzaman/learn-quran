import { Realm } from 'realm';

export class Stage extends Realm.Object {
  id!: number;
  description!: string;
  isComplete = false;

  static primaryKey = "id";

  constructor(realm: Realm, description: string) {
    super(realm, { description });
  }
}

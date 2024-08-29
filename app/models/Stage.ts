import { Realm } from 'realm';

export class Stage extends Realm.Object {
  id!: number;
  name!: string;
  description!: string;
  isComplete = false;

  static primaryKey = 'id';
  static schema: Realm.ObjectSchema = {
    name: 'Stage',
    primaryKey: 'id',
    properties: {
      id: 'int',
      totalLessons: { type: 'int', default: 0 },
      totalLessonsComplete: { type: 'int', default: 0 },
      name: 'string',
      description: 'string',
    },
  };
}

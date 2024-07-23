import { exec } from 'child_process';

import Realm from 'realm';

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

const localConfig = {
  schema: [Stage],
  path: "assets/db.realm",
};
const realm = await Realm.open(localConfig);


realm.write(() => {
  realm.create("Stage", {
    id: 1,
    name: "PART I",
    description: "From 0% to 50%",
    isComplete: false
  }, "modified");
});

exec('rm -rf assets/db.realm.management assets/db.realm.lock assets/db.realm.note');

process.exit();

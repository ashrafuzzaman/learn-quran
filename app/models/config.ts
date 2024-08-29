import { Realm } from '@realm/react';
import { Configuration } from 'realm';
import { Stage } from './Stage';

Realm.copyBundledRealmFiles();
export const config: Configuration = {
  schema: [Stage],
  path: "bundle.realm",
};

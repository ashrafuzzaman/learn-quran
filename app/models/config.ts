import { Configuration } from 'realm';
import { Stage } from './Stage';

export const config: Configuration = {
  schema: [Stage],
  path: "bundle.realm",
};

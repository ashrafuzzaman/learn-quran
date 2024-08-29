import { FlatList, StyleSheet, Text } from 'react-native';

import { ThemedText } from '@/components/ThemedText';
import { ThemedView } from '@/components/ThemedView';
import { useQuery } from '@realm/react';
import Realm from "realm";
import { Stage } from '../models/Stage';
import { config } from '../models/config';

export default function StageListScreen() {

  // TODO: Move to custom hooks to fetch data
  // const realm = useRealm();
  const stages = useQuery(Stage);
  console.log(stages);
  Realm.open(config);

  return (
    <ThemedView style={styles.container}>
      <ThemedView style={styles.box}>
        <ThemedText type="title">Learn</ThemedText>
        <ThemedView>
          <FlatList
            style={styles.listItemContainer}
            data={stages}
            renderItem={({ item }) => <Text style={styles.listItem}>{item.name}</Text>}
          />
        </ThemedView>
      </ThemedView>
    </ThemedView>
  );
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    flexDirection: 'column',
    gap: 8,
  },
  box: {
    padding: 32,
  },
  listItemContainer: {
    backgroundColor: '#998080',
    borderRadius: 12,
    marginTop: 60,
  },
  listItem: {
    padding: 32,
  }
});

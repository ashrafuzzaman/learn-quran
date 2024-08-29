// import { config } from '@/app/models/config';
// import { parse } from 'csv-parse/sync';
// import { useEffect } from 'react';
// // import fs from "react-native-fs";
// import Realm from 'realm';

// async function getData(fileName: string) {
//   const content = require(`./assets/data/${fileName}.csv`)
//   // const content = await fs.readFileAssets(`data/${fileName}.csv`);
//   return parse(content, {
//     columns: true,
//     skip_empty_lines: true
//   });
// }

// async function getStages() {
//   return await getData('Stages');
// }

// async function getLessons() {
//   return await getData('Lessons');
// }

// async function getWords() {
//   return await getData('Words');
// }

// async function getExamples() {
//   return await getData('Examples');
// }

// function getWordByArabic(realm: Realm, arabic: any) {
//   return realm.objects('Word').filtered('arabic = $0', arabic.trim())[0];
// }

// function loadExamplesToDB(realm: Realm, examples: any[]) {
//   let currentWordId = 0, totalWordsNotFound = 0;
//   examples.forEach(example => {
//     const isWordNewWord = example.ayahRef === '' && example.highlight === '';
//     if (isWordNewWord) {
//       if (example.wordId !== '') {
//         currentWordId = parseInt(example.wordId);
//         return;
//       }
//       const currentWord = getWordByArabic(realm, example.word);
//       if (currentWord.id === 0) {
//         console.log(`Word not found[${currentWordId + 1}]: ${example.word}`);
//         totalWordsNotFound++;
//         currentWordId = 0;
//         return;
//       }
//       currentWordId = currentWord.id as number;
//       return;
//     }

//     if (currentWordId === 0) {
//       return;
//     }

//     realm.create("Example", {
//       ayahRef: example.ayahRef.trim(),
//       wordId: currentWordId,
//       arabic: example.word.trim(),
//       translation: example.translation.trim(),
//       highlight: example.highlight.trim(),
//     });
//   });
//   console.log(`Total words not found: ${totalWordsNotFound}`);
// }


// function upsertStage(realm: Realm, stage: any) {
//   realm.create("Stage", {
//     id: parseInt(stage.id),
//     name: stage.name,
//     description: stage.description,
//     isComplete: false
//   });
// }

// function upsertLesson(realm: Realm, lesson: any) {
//   const lessonExists = realm.objects('Lesson').filtered('id = $0 && stageId = $1',
//     lesson.id, lesson.stageId).length > 0;
//   if (lessonExists) {
//     return;
//   }
//   realm.create("Lesson", {
//     id: parseInt(lesson.id),
//     stageId: parseInt(lesson.stageId),
//     name: lesson.name,
//   });
// }

// function upsertWord(realm: Realm, word: any) {
//   realm.create("Word", {
//     ...word,
//     id: parseInt(word.id),
//     lessonId: parseInt(word.lessonId),
//     stageId: parseInt(word.stageId),
//     arabic: word.word.trim(),
//     gender: word.gender.trim(),
//     number: word.number.trim(),
//     audioId: word.audioId.trim(),
//   });
// }

// async function updateCounters(realm: Realm) {
//   realm.objects("Stage").map(stage => {
//     const totalLessons = realm.objects('Lesson').filtered('stageId == $0', stage.id).length;
//     realm.write(() => {
//       stage.totalLessons = totalLessons;
//     });
//   });
//   realm.objects("Lesson").map(lesson => {
//     const totalWords = realm.objects('Word').filtered('lessonId = $0 and stageId == $1',
//       lesson.id, lesson.stageId).length;
//     realm.write(() => {
//       lesson.totalWords = totalWords;
//     });
//   });
// }

// async function seed() {
//   const realm = await Realm.open(config);

//   const stages = await getStages();
//   const lessons = await getLessons();
//   const words = await getWords();
//   const examples = await getExamples();

//   realm.write(() => {
//     stages.map((stage: any) => upsertStage(realm, stage));
//     lessons.map((lesson: any) => upsertLesson(realm, lesson));
//     words.map((word: any) => upsertWord(realm, word));
//     loadExamplesToDB(realm, examples);
//   });

//   updateCounters(realm);
//   realm.close();
// }

// export function useInitDb() {
//   useEffect(() => {
//     (async () => seed())();
//   }, []);
// }

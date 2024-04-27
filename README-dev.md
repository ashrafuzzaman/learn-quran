# Contribution guide

## How to run the app

1. Ensure you have flutter development setup ready following this [guide](https://docs.flutter.dev/get-started/install)
2. Run `$ pub get` to install dependencies
3. Run `$ flutter run` to run the app, or you may follow this [guide](https://docs.flutter.dev/get-started/test-drive?tab=terminal)

## How to connect to db within emulator

1. Run `$ ./adb devices`, usually in `~/Android/Sdk/platform-tools/`

Sample output
```bash
List of devices attached
emulator-5554	device
```
2. Log into the emulator shell
`$ ./adb -s emulator-5554 shell`
Change user,
`$ run-as com.opensource.learnquran`
3. Go to the db directory,
`$ cd /data/user/0/com.opensource.learnquran/databases/`
`$ sqlite3 learn_quran.db`
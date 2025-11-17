# Daily Mood Tracker

A minimal beginner Flutter project that teaches UI basics, state management, navigation, simple model creation, list handling, and optional local storage.

## Features

- Home screen asking "How are you feeling today?"
- Five mood buttons (great, good, neutral, bad, awful)
- Save mood entries with timestamp
- View history of saved moods
- Persist moods using `shared_preferences` (local storage)

## Project structure

```
lib/
  main.dart
  screens/
    home_screen.dart
    history_screen.dart
  models/
    mood_entry.dart
  widgets/
    mood_button.dart
  services/
    storage_service.dart
```

## Run

1. Ensure Flutter is installed.
2. Run `flutter pub get`.
3. Run `flutter run` in the project directory.

## Extending the app

- Add charts (e.g., `fl_chart`) for weekly mood trends.
- Add authentication and cloud sync using Firebase.
- Add themes (light/dark).
- Add daily reminders using local notifications.

## License

This is an educational starter project; use and adapt it as you like.

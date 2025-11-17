import 'package:shared_preferences/shared_preferences.dart';
import '../models/mood_entry.dart';

/// Simple storage service using SharedPreferences to persist mood entries.
class StorageService {
  static const _kMoodListKey = 'mood_history';

  /// Save entire list of MoodEntry objects (overwrite).
  static Future<void> saveMoodList(List<MoodEntry> moods) async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = moods.map((e) => e.toJson()).toList();
    await prefs.setStringList(_kMoodListKey, jsonList);
  }

  /// Load the saved list of moods. Returns an empty list if nothing found.
  static Future<List<MoodEntry>> loadMoodList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = prefs.getStringList(_kMoodListKey);
    if (jsonList == null) return <MoodEntry>[];
    return jsonList.map((s) => MoodEntry.fromJson(s)).toList();
  }

  /// Clear stored mood history (helper for debugging or reset).
  static Future<void> clearMoodList() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_kMoodListKey);
  }
}
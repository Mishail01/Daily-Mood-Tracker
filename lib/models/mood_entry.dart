import 'dart:convert';

/// Model representing a single mood entry with the mood emoji and timestamp.
class MoodEntry {
  final String mood; // e.g., "😊"
  final DateTime date;

  MoodEntry({required this.mood, required this.date});

  /// Convert to a map for serialization.
  Map<String, dynamic> toMap() {
    return {
      'mood': mood,
      'date': date.toIso8601String(),
    };
  }

  /// Create a MoodEntry from a map.
  factory MoodEntry.fromMap(Map<String, dynamic> map) {
    return MoodEntry(
      mood: map['mood'] as String,
      date: DateTime.parse(map['date'] as String),
    );
  }

  /// Convert to JSON string (convenience for SharedPreferences storage).
  String toJson() => json.encode(toMap());

  /// Create from JSON string.
  factory MoodEntry.fromJson(String source) =>
      MoodEntry.fromMap(json.decode(source) as Map<String, dynamic>);
}
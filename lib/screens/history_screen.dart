import 'package:flutter/material.dart';
import '../models/mood_entry.dart';

/// Screen showing the list of saved mood entries.
///
/// The [history] list is expected with most recent first.
class HistoryScreen extends StatelessWidget {
  final List<MoodEntry> history;

  const HistoryScreen({super.key, required this.history});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mood History')),
      body: history.isEmpty
          ? const Center(
              child: Text(
                'No moods logged yet.\nTap an emoji on the home screen to add one.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 16),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.symmetric(vertical: 8),
              itemCount: history.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final entry = history[index];
                return ListTile(
                  leading: Text(entry.mood, style: const TextStyle(fontSize: 28)),
                  title: Text(_formatDate(entry.date)),
                  // optional: subtitle or trailing for extra UI
                );
              },
            ),
    );
  }

  String _formatDate(DateTime dt) {
    final local = dt.toLocal();
    final datePart =
        '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    final timePart =
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    return '$datePart $timePart';
  }
}
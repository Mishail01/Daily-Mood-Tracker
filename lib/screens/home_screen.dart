import 'package:flutter/material.dart';
import '../models/mood_entry.dart';
import '../widgets/mood_button.dart';
import 'history_screen.dart';
import '../services/storage_service.dart';

/// Home screen where the user selects today's mood.
///
/// It loads persisted mood history on start and saves new moods immediately.
class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<MoodEntry> _moodHistory = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadHistory();
  }

  Future<void> _loadHistory() async {
    final loaded = await StorageService.loadMoodList();
    setState(() {
      _moodHistory = loaded;
      _loading = false;
    });
  }

  Future<void> _selectMood(String emoji) async {
    final entry = MoodEntry(mood: emoji, date: DateTime.now());
    setState(() {
      _moodHistory.insert(0, entry); // newest at top
    });
    await StorageService.saveMoodList(_moodHistory);
    // Show a small confirmation
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Saved mood $emoji')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daily Mood Tracker'),
        actions: [
          IconButton(
            tooltip: 'View History',
            icon: const Icon(Icons.history),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => HistoryScreen(history: _moodHistory),
                ),
              );
            },
          ),
          PopupMenuButton<String>(
            onSelected: (value) async {
              if (value == 'clear') {
                await StorageService.clearMoodList();
                setState(() => _moodHistory.clear());
              }
            },
            itemBuilder: (_) => [
              const PopupMenuItem(value: 'clear', child: Text('Clear history')),
            ],
          ),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 18),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'How are you feeling today?',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MoodButton(
                          emoji: '😊',
                          label: 'Great',
                          onPressed: () => _selectMood('😊'),
                        ),
                        MoodButton(
                          emoji: '🙂',
                          label: 'Good',
                          onPressed: () => _selectMood('🙂'),
                        ),
                        MoodButton(
                          emoji: '😐',
                          label: 'Neutral',
                          onPressed: () => _selectMood('😐'),
                        ),
                        MoodButton(
                          emoji: '🙁',
                          label: 'Bad',
                          onPressed: () => _selectMood('🙁'),
                        ),
                        MoodButton(
                          emoji: '😣',
                          label: 'Awful',
                          onPressed: () => _selectMood('😣'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.history),
                      label: const Text('View History'),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => HistoryScreen(history: _moodHistory),
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    if (_moodHistory.isNotEmpty)
                      Text(
                        'Last saved: ${_formatDate(_moodHistory.first.date)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  /// Simple local formatting for date/time for display (no intl dependency).
  String _formatDate(DateTime dt) {
    final local = dt.toLocal();
    final datePart =
        '${local.year.toString().padLeft(4, '0')}-${local.month.toString().padLeft(2, '0')}-${local.day.toString().padLeft(2, '0')}';
    final timePart =
        '${local.hour.toString().padLeft(2, '0')}:${local.minute.toString().padLeft(2, '0')}';
    return '$datePart $timePart';
  }
}
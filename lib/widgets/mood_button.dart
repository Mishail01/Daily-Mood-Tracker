import 'package:flutter/material.dart';

/// A reusable mood button widget showing an emoji and handling taps.
/// - [emoji] is the displayed mood character.
/// - [label] is an optional accessibility label.
/// - [onPressed] is called when the button is tapped.
class MoodButton extends StatelessWidget {
  final String emoji;
  final String? label;
  final VoidCallback onPressed;

  const MoodButton({
    super.key,
    required this.emoji,
    this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    // Use IconButton-like presentation but with text emoji
    return Semantics(
      label: label ?? emoji,
      button: true,
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.indigo.shade50,
            shape: BoxShape.circle,
          ),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 32),
          ),
        ),
      ),
    );
  }
}
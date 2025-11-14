import 'package:emotional_release/main.dart';
import 'package:flutter/material.dart';

class EmotionalTagSelector extends StatelessWidget {
  final List<String> availableTags;
  final List<String> selectedTags;
  final Function(List<String>) onTagsChanged;
  final String title;
  final int? maxSelection;

  const EmotionalTagSelector({
    super.key,
    required this.availableTags,
    required this.selectedTags,
    required this.onTagsChanged,
    required this.title,
    this.maxSelection,
  });

  void _toggleTag(String tag) {
    final newSelectedTags = List<String>.from(selectedTags);
    if (newSelectedTags.contains(tag)) {
      newSelectedTags.remove(tag);
    } else {
      if (maxSelection == null || newSelectedTags.length < maxSelection!) {
        newSelectedTags.add(tag);
      }
    }
    onTagsChanged(newSelectedTags);
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      alignment: WrapAlignment.center,
      children: availableTags.map((tag) {
        final isSelected = selectedTags.contains(tag);
        return InkWell(
          onTap: () => _toggleTag(tag),
          borderRadius: BorderRadius.circular(20),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: isSelected ? primaryColor : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? primaryColor : Colors.grey[300]!,
                width: 2,
              ),
            ),
            child: Text(
              tag,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.grey[700],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}


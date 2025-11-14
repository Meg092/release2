import 'package:flutter/material.dart';

class EmotionalRatingSelector extends StatelessWidget {
  final int selectedRating;
  final Function(int) onRatingChanged;

  const EmotionalRatingSelector({
    super.key,
    required this.selectedRating,
    required this.onRatingChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(5, (index) {
        final rating = index + 1;
        return GestureDetector(
          onTap: () => onRatingChanged(rating),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(8),
            child: Icon(
              rating <= selectedRating ? Icons.star : Icons.star_border,
              size: 40,
              color: rating <= selectedRating
                  ? Colors.amber
                  : Colors.grey[400],
            ),
          ),
        );
      }),
    );
  }
}


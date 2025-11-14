import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class EmotionalHeatmapCalendar extends StatelessWidget {
  final Map<DateTime, double> intensityData;

  const EmotionalHeatmapCalendar({
    super.key,
    required this.intensityData,
  });

  Color _getColorForIntensity(double intensity) {
    if (intensity == 0) return Colors.grey[200]!;
    if (intensity <= 1) return const Color(0xFFE8F5E9);
    if (intensity <= 2) return const Color(0xFFC8E6C9);
    if (intensity <= 3) return const Color(0xFFA5D6A7);
    if (intensity <= 4) return const Color(0xFF81C784);
    return const Color(0xFF66BB6A);
  }

  @override
  Widget build(BuildContext context) {
    if (intensityData.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text(
            'No data available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    
    final Map<DateTime, int> heatmapData = {};
    intensityData.forEach((date, intensity) {
      
      final normalizedDate = DateTime(date.year, date.month, date.day);
      heatmapData[normalizedDate] = (intensity * 20).toInt(); 
    });

    return Container(
      padding: const EdgeInsets.all(16),
      child: HeatMapCalendar(
        datasets: heatmapData,
        colorMode: ColorMode.color,
        defaultColor: Colors.grey[200]!,
        textColor: Colors.black87,
        showColorTip: false,
        size: 30,
        fontSize: 12,
        monthFontSize: 14,
        weekFontSize: 12,
        colorsets: {
          1: _getColorForIntensity(0.5),
          20: _getColorForIntensity(1),
          40: _getColorForIntensity(2),
          60: _getColorForIntensity(3),
          80: _getColorForIntensity(4),
          100: _getColorForIntensity(5),
        },
      ),
    );
  }
}


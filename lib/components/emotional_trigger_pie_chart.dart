import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class EmotionalTriggerPieChart extends StatelessWidget {
  final Map<String, int> triggerData;

  const EmotionalTriggerPieChart({
    super.key,
    required this.triggerData,
  });

  static const List<Color> _colorPalette = [
    Color(0xFF66BB6A),
    Color(0xFF42A5F5),
    Color(0xFFFF7043),
    Color(0xFFAB47BC),
    Color(0xFFFFCA28),
    Color(0xFF26A69A),
    Color(0xFFEC407A),
    Color(0xFF8D6E63),
  ];

  @override
  Widget build(BuildContext context) {
    if (triggerData.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(40.0),
          child: Text(
            'No trigger data available',
            style: TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ),
      );
    }

    final total = triggerData.values.reduce((a, b) => a + b);
    final sortedEntries = triggerData.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Container(
      height: 300,
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          
          Expanded(
            flex: 3,
            child: PieChart(
              PieChartData(
                sections: sortedEntries.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;
                  final percentage = (data.value / total * 100);

                  return PieChartSectionData(
                    color: _colorPalette[index % _colorPalette.length],
                    value: data.value.toDouble(),
                    title: '${percentage.toStringAsFixed(1)}%',
                    radius: 80,
                    titleStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  );
                }).toList(),
                sectionsSpace: 2,
                centerSpaceRadius: 40,
              ),
            ),
          ),
          const SizedBox(width: 20),
          
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: sortedEntries.asMap().entries.map((entry) {
                  final index = entry.key;
                  final data = entry.value;

                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        Container(
                          width: 16,
                          height: 16,
                          decoration: BoxDecoration(
                            color: _colorPalette[index % _colorPalette.length],
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            '${data.key} (${data.value})',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}


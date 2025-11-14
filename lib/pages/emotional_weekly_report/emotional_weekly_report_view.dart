import 'package:emotional_release/main.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';
import 'emotional_weekly_report_logic.dart';

class EmotionalWeeklyReportPage extends GetView<EmotionalWeeklyReportLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weekly Report'),
        backgroundColor: primaryColor,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final data = controller.reportData.value;
        if (data == null || data['hasData'] != true) {
          return _buildNoDataView();
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: <Widget>[
            
            _buildHeader(),
            const SizedBox(height: 25),

            
            _buildOverviewCard(data),
            const SizedBox(height: 20),

            
            _buildTopTriggersCard(data),
            const SizedBox(height: 20),

            
            _buildInsightsCard(data),
            const SizedBox(height: 20),

            
            _buildEncouragementCard(),
          ].toColumn(),
        );
      }),
    );
  }

  Widget _buildNoDataView() {
    return Center(
      child: <Widget>[
        Icon(Icons.info_outline, size: 80, color: Colors.grey[400]),
        const SizedBox(height: 20),
        const Text(
          'No data available',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 10),
        Text(
          'Start recording your emotions\nto see your weekly report',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
      ].toColumn(mainAxisSize: MainAxisSize.min),
    );
  }

  Widget _buildHeader() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [primaryColor, primaryColor.withOpacity(0.8)],
            ),
            borderRadius: BorderRadius.circular(15),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.assessment, color: Colors.white, size: 30),
              SizedBox(width: 10),
              Text(
                'Weekly Report',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 15),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
              const SizedBox(width: 8),
              Text(
                controller.getWeekDateRange(),
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildOverviewCard(Map<String, dynamic> data) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: <Widget>[
        Row(
          children: [
            Icon(Icons.bar_chart, color: primaryColor, size: 24),
            const SizedBox(width: 10),
            const Text(
              '📊 Overview',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: _buildStatBox(
                'Records',
                '${data['recordCount']}',
                Icons.article_outlined,
                Colors.blue,
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: _buildStatBox(
                'Avg Intensity',
                (data['averageIntensity'] as double).toStringAsFixed(1),
                Icons.favorite_outline,
                Colors.red,
              ),
            ),
          ],
        ),
        const SizedBox(height: 15),
        _buildStatBox(
          'Most Common Emotion',
          moodTypes[data['mostCommonEmotionType'] as int],
          Icons.mood,
          primaryColor,
        ),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildStatBox(String label, String value, IconData icon, Color color) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        children: [
          Icon(icon, size: 30, color: color),
          const SizedBox(height: 10),
          Text(
            value,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: color,
            ),
          ),
          const SizedBox(height: 5),
          Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTopTriggersCard(Map<String, dynamic> data) {
    final topTriggers = data['topTriggers'] as List<MapEntry<String, int>>;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: <Widget>[
        Row(
          children: [
            Icon(Icons.flash_on, color: Colors.orange, size: 24),
            const SizedBox(width: 10),
            const Text(
              '🎯 Top Triggers',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 15),
        if (topTriggers.isEmpty)
          const Text(
            'No triggers recorded this week',
            style: TextStyle(fontSize: 14, color: Colors.grey),
          )
        else
          ...topTriggers.asMap().entries.map((entry) {
            final index = entry.key;
            final trigger = entry.value;
            final total = data['recordCount'] as int;
            final percentage = (trigger.value / total * 100).toStringAsFixed(0);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Row(
                children: [
                  Container(
                    width: 30,
                    height: 30,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          trigger.key,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          '${trigger.value} times ($percentage%)',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildInsightsCard(Map<String, dynamic> data) {
    final insights = data['insights'] as List<String>;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: <Widget>[
        Row(
          children: [
            const Icon(Icons.lightbulb, color: Colors.amber, size: 24),
            const SizedBox(width: 10),
            const Text(
              '💭 Insights',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
            ),
          ],
        ),
        const SizedBox(height: 15),
        ...insights.map((insight) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.only(top: 7),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    insight,
                    style: const TextStyle(
                      fontSize: 14,
                      height: 1.5,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ],
            ),
          );
        }).toList(),
      ].toColumn(crossAxisAlignment: CrossAxisAlignment.start),
    );
  }

  Widget _buildEncouragementCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            primaryColor.withOpacity(0.8),
            primaryColor.withOpacity(0.6),
          ],
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      child: const Column(
        children: [
          Text(
            '💪 Keep Going!',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: Colors.white,
            ),
          ),
          SizedBox(height: 15),
          Text(
            'You\'re doing great by tracking your emotions. Remember, understanding your feelings is the first step towards emotional well-being. Keep up the excellent work!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 15,
              height: 1.6,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}


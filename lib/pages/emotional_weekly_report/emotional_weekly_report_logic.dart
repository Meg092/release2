import 'package:emotional_release/db_emotional/db_emotional.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class EmotionalWeeklyReportLogic extends GetxController {
  DBEmotional dbEmotional = Get.find();

  var reportData = Rxn<Map<String, dynamic>>();
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    generateWeeklyReport();
  }

  void generateWeeklyReport() async {
    isLoading.value = true;

    final now = DateTime.now();
    final weekStart = now.subtract(const Duration(days: 7));
    final allData = await dbEmotional.getEmotionalAllData();
    final weekData =
        allData.where((entity) => entity.createdTime.isAfter(weekStart)).toList();

    if (weekData.isEmpty) {
      reportData.value = {
        'hasData': false,
      };
      isLoading.value = false;
      return;
    }

    
    Map<int, int> emotionTypeCount = {};
    Map<String, int> triggerCount = {};
    double totalIntensity = 0.0;

    for (var entity in weekData) {
      emotionTypeCount[entity.type] = (emotionTypeCount[entity.type] ?? 0) + 1;
      for (var trigger in entity.triggers) {
        triggerCount[trigger] = (triggerCount[trigger] ?? 0) + 1;
      }
      totalIntensity += entity.intensity;
    }

    
    int mostCommonEmotionType = 0;
    int maxCount = 0;
    emotionTypeCount.forEach((type, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommonEmotionType = type;
      }
    });

    
    List<MapEntry<String, int>> sortedTriggers = triggerCount.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    
    List<String> insights = _generateInsights(
      weekData.length,
      totalIntensity / weekData.length,
      mostCommonEmotionType,
      sortedTriggers,
    );

    reportData.value = {
      'hasData': true,
      'weekStart': weekStart,
      'weekEnd': now,
      'recordCount': weekData.length,
      'averageIntensity': totalIntensity / weekData.length,
      'mostCommonEmotionType': mostCommonEmotionType,
      'emotionTypeCount': emotionTypeCount,
      'topTriggers': sortedTriggers.take(3).toList(),
      'insights': insights,
    };

    isLoading.value = false;
  }

  List<String> _generateInsights(
    int recordCount,
    double avgIntensity,
    int mostCommonEmotion,
    List<MapEntry<String, int>> triggers,
  ) {
    List<String> insights = [];

    
    if (recordCount >= 10) {
      insights.add(
          'You\'ve been very active this week with $recordCount emotional records. Consistent tracking helps build self-awareness!');
    } else if (recordCount >= 5) {
      insights.add(
          'Good job keeping up with your emotional tracking. Consider recording more frequently for better insights.');
    } else {
      insights.add(
          'Try to record your emotions more often. The more you track, the better you understand yourself.');
    }

    
    if (avgIntensity >= 4.0) {
      insights.add(
          'Your emotions have been quite intense this week (${avgIntensity.toStringAsFixed(1)}/5). Remember to practice self-care and reach out for support if needed.');
    } else if (avgIntensity <= 2.0) {
      insights.add(
          'Your emotional intensity has been relatively low this week (${avgIntensity.toStringAsFixed(1)}/5). This could be a sign of emotional stability or perhaps feeling a bit numb. Check in with yourself.');
    } else {
      insights.add(
          'Your average emotional intensity is ${avgIntensity.toStringAsFixed(1)}/5, which is moderate. You seem to be managing your emotions well.');
    }

    
    if (triggers.isNotEmpty) {
      final topTrigger = triggers.first;
      final percentage = (topTrigger.value / recordCount * 100).toStringAsFixed(0);
      insights.add(
          'Most of your emotions were triggered by ${topTrigger.key} ($percentage%). Understanding your triggers is key to emotional growth.');
    }

    return insights;
  }

  String getWeekDateRange() {
    if (reportData.value == null || reportData.value!['hasData'] != true) {
      return '';
    }
    final start = reportData.value!['weekStart'] as DateTime;
    final end = reportData.value!['weekEnd'] as DateTime;
    return '${DateFormat('MM/dd').format(start)} - ${DateFormat('MM/dd').format(end)}';
  }
}


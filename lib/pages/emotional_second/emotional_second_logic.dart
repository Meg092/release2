import 'package:emotional_release/db_emotional/db_emotional.dart';
import 'package:emotional_release/db_emotional/emotional_entity.dart';
import 'package:emotional_release/models/emotional_statistics.dart';
import 'package:get/get.dart';

class EmotionalSecondLogic extends GetxController {

  DBEmotional dbEmotional = Get.find();

  var list = <EmotionalEntity>[].obs;
  var viewMode = 'records'.obs; 
  var statisticsData = Rxn<EmotionalStatistics>();
  var dateRange = 'week'.obs; 

  void getData() async {
    list.value = await dbEmotional.getEmotionalAllData();
    if (viewMode.value == 'statistics') {
      calculateStatistics();
    }
  }

  void switchViewMode(String mode) {
    viewMode.value = mode;
    if (mode == 'statistics') {
      calculateStatistics();
    }
  }

  void changeDateRange(String range) {
    dateRange.value = range;
    calculateStatistics();
  }

  List<EmotionalEntity> getFilteredData() {
    final now = DateTime.now();
    DateTime startDate;

    switch (dateRange.value) {
      case 'week':
        startDate = now.subtract(const Duration(days: 7));
        break;
      case 'month':
        startDate = now.subtract(const Duration(days: 30));
        break;
      case 'all':
      default:
        startDate = DateTime(2000); 
        break;
    }

    return list.where((entity) => entity.createdTime.isAfter(startDate)).toList();
  }

  void calculateStatistics() async {
    final filteredData = getFilteredData();

    if (filteredData.isEmpty) {
      statisticsData.value = EmotionalStatistics(
        totalRecords: 0,
        emotionTypeCount: {},
        triggerCount: {},
        averageIntensity: 0.0,
        dailyEmotions: [],
        mostCommonEmotionType: 0,
        mostCommonTrigger: 'None',
      );
      return;
    }

    
    Map<int, int> emotionTypeCount = {};
    Map<String, int> triggerCount = {};
    double totalIntensity = 0.0;
    Map<String, List<EmotionalEntity>> dailyData = {};

    for (var entity in filteredData) {
      
      emotionTypeCount[entity.type] = (emotionTypeCount[entity.type] ?? 0) + 1;

      
      for (var trigger in entity.triggers) {
        triggerCount[trigger] = (triggerCount[trigger] ?? 0) + 1;
      }

      
      totalIntensity += entity.intensity;

      
      final dateKey = '${entity.createdTime.year}-${entity.createdTime.month}-${entity.createdTime.day}';
      if (!dailyData.containsKey(dateKey)) {
        dailyData[dateKey] = [];
      }
      dailyData[dateKey]!.add(entity);
    }

    
    List<DailyEmotion> dailyEmotions = dailyData.entries.map((entry) {
      final entities = entry.value;
      final avgIntensity = entities.map((e) => e.intensity).reduce((a, b) => a + b) / entities.length;
      final emotionTypes = entities.map((e) => e.type).toSet().toList();
      final dateParts = entry.key.split('-');
      final date = DateTime(
        int.parse(dateParts[0]),
        int.parse(dateParts[1]),
        int.parse(dateParts[2]),
      );

      return DailyEmotion(
        date: date,
        averageIntensity: avgIntensity,
        recordCount: entities.length,
        emotionTypes: emotionTypes,
      );
    }).toList();

    
    dailyEmotions.sort((a, b) => a.date.compareTo(b.date));

    
    int mostCommonEmotionType = 0;
    int maxCount = 0;
    emotionTypeCount.forEach((type, count) {
      if (count > maxCount) {
        maxCount = count;
        mostCommonEmotionType = type;
      }
    });

    
    String mostCommonTrigger = 'None';
    int maxTriggerCount = 0;
    triggerCount.forEach((trigger, count) {
      if (count > maxTriggerCount) {
        maxTriggerCount = count;
        mostCommonTrigger = trigger;
      }
    });

    statisticsData.value = EmotionalStatistics(
      totalRecords: filteredData.length,
      emotionTypeCount: emotionTypeCount,
      triggerCount: triggerCount,
      averageIntensity: totalIntensity / filteredData.length,
      dailyEmotions: dailyEmotions,
      mostCommonEmotionType: mostCommonEmotionType,
      mostCommonTrigger: mostCommonTrigger,
    );
  }

  Map<String, dynamic> getWeeklyReportData() {
    final now = DateTime.now();
    final weekStart = now.subtract(const Duration(days: 7));
    final weekData = list.where((entity) => entity.createdTime.isAfter(weekStart)).toList();

    if (weekData.isEmpty) {
      return {
        'hasData': false,
        'recordCount': 0,
      };
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

    return {
      'hasData': true,
      'recordCount': weekData.length,
      'averageIntensity': totalIntensity / weekData.length,
      'mostCommonEmotionType': mostCommonEmotionType,
      'topTriggers': sortedTriggers.take(3).toList(),
      'weekStart': weekStart,
      'weekEnd': now,
    };
  }

  @override
  void onInit() {
    
    getData();
    super.onInit();
  }

}

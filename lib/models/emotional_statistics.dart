class EmotionalStatistics {
  int totalRecords;
  Map<int, int> emotionTypeCount;
  Map<String, int> triggerCount;
  double averageIntensity;
  List<DailyEmotion> dailyEmotions;
  int mostCommonEmotionType;
  String mostCommonTrigger;

  EmotionalStatistics({
    required this.totalRecords,
    required this.emotionTypeCount,
    required this.triggerCount,
    required this.averageIntensity,
    required this.dailyEmotions,
    required this.mostCommonEmotionType,
    required this.mostCommonTrigger,
  });
}

class DailyEmotion {
  DateTime date;
  double averageIntensity;
  int recordCount;
  List<int> emotionTypes;

  DailyEmotion({
    required this.date,
    required this.averageIntensity,
    required this.recordCount,
    required this.emotionTypes,
  });
}


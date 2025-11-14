import 'package:get/get.dart';
import 'emotional_weekly_report_logic.dart';

class EmotionalWeeklyReportBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmotionalWeeklyReportLogic());
  }
}


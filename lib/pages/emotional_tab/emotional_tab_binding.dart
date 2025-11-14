import 'package:emotional_release/pages/emotional_first/emotional_first_logic.dart';
import 'package:emotional_release/pages/emotional_second/emotional_second_logic.dart';
import 'package:get/get.dart';

import '../emotional_third/emotional_third_logic.dart';
import 'emotional_tab_logic.dart';

class EmotionalTabBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmotionalTabLogic());
    Get.lazyPut(() => EmotionalFirstLogic());
    Get.lazyPut(() => EmotionalSecondLogic());
    Get.lazyPut(() => EmotionalThirdLogic());
  }
}
import 'package:get/get.dart';

import 'emotional_second_logic.dart';

class EmotionalSecondBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmotionalSecondLogic());
  }
}
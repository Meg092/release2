import 'package:get/get.dart';

import 'emotional_first_logic.dart';

class EmotionalFirstBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmotionalFirstLogic());
  }
}
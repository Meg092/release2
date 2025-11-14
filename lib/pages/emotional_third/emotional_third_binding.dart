import 'package:get/get.dart';

import 'emotional_third_logic.dart';

class EmotionalThirdBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmotionalThirdLogic());
  }
}
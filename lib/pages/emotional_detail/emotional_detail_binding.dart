import 'package:get/get.dart';
import 'emotional_detail_logic.dart';

class EmotionalDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => EmotionalDetailLogic());
  }
}


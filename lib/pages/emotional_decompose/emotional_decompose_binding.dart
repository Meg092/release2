import 'package:get/get.dart';

import 'emotional_decompose_logic.dart';

class EmotionalDecomposeBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      EmotionalDecomposeLogic(),
      permanent: true,
    );
  }
}

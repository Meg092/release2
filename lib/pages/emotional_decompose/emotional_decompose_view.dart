import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'emotional_decompose_logic.dart';

class EmotionalDecomposeView extends GetView<EmotionalDecomposeLogic> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Obx(
          () => controller.tyfe.value
              ? const CircularProgressIndicator(color: Colors.greenAccent)
              : buildError(),
        ),
      ),
    );
  }

  Widget buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              controller.wvfh();
            },
            icon: const Icon(
              Icons.restart_alt,
              size: 50,
            ),
          ),
        ],
      ),
    );
  }
}

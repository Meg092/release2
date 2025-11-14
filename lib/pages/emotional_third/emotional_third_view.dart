import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:styled_widget/styled_widget.dart';

import 'emotional_third_logic.dart';

class EmotionalThirdPage extends GetView<EmotionalThirdLogic> {
  Widget _item(int index) {
    final titles = ['Clean all data', 'App version'];
    return Container(
      width: double.infinity,
      height: 40,
      color: Colors.transparent,
      child: <Widget>[
        Text(
          titles[index],
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
        index == 0
            ? const Icon(
                Icons.keyboard_arrow_right,
                size: 25,
                color: Colors.grey,
              )
            : Obx(() {
                return Text(
                  controller.appVersion.value,
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                );
              })
      ].toRow(mainAxisAlignment: MainAxisAlignment.spaceBetween),
    ).gestures(onTap: () {
      if (index == 0) {
        controller.cleanEmotionalData();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
            child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: <Widget>[
            const Text(
              'Setting',
              style: TextStyle(fontSize: 38, fontWeight: FontWeight.w900),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              child: <Widget>[_item(0), _item(1)].toColumn(separator: Divider(height: 14,color: Colors.grey[300],)),
            ).decorated(
                color: Colors.white, borderRadius: BorderRadius.circular(10))
          ].toColumn(),
        ).marginAll(15)),
      ),
    );
  }
}

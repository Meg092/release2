import 'package:emotional_release/pages/emotional_first/emotional_first_view.dart';
import 'package:emotional_release/pages/emotional_second/emotional_second_logic.dart';
import 'package:emotional_release/pages/emotional_second/emotional_second_view.dart';
import 'package:emotional_release/pages/emotional_third/emotional_third_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'emotional_tab_logic.dart';

class EmotionalTabPage extends GetView<EmotionalTabLogic> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        physics: const NeverScrollableScrollPhysics(),
        controller: controller.pageController,
        children: [
          EmotionalFirstPage(),
          EmotionalSecondPage(),
          EmotionalThirdPage()
        ],
      ),
      bottomNavigationBar: Obx(() => _navEmoBars()),
    );
  }

  Widget _navEmoBars() {
    return BottomNavigationBar(
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item0Grey.png',
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            'assets/item0Light.png',
            width: 22,
            height: 22,
          ),
          label: 'Release',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item1Grey.png',
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            'assets/item1Light.png',
            width: 22,
            height: 22,
          ),
          label: 'Release record',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/item2Grey.png',
            width: 22,
            height: 22,
          ),
          activeIcon: Image.asset(
            'assets/item2Light.png',
            width: 22,
            height: 22,
          ),
          label: 'Setting',
        ),
      ],
      currentIndex: controller.currentIndex.value,
      onTap: (index) {
        controller.currentIndex.value = index;
        controller.pageController.jumpToPage(index);
        if (index == 1) {
          EmotionalSecondLogic secondLogic = Get.find();
          secondLogic.getData();
        }
      },
    );
  }
}

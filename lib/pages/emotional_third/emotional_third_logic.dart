import 'package:emotional_release/db_emotional/db_emotional.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

class EmotionalThirdLogic extends GetxController {

  var appVersion = '1.0.0'.obs;

  DBEmotional dbEmotional = Get.find();


  cleanEmotionalData() async {
    Get.dialog(AlertDialog(
      title: const Text('Warm reminder'),
      content: const Text('Do you want to clean all records?'),
      actions: [
        TextButton(
          onPressed: () {
            Get.back();
          },
          child: const Text(
            'Cancel',
            style: TextStyle(color: Colors.black),
          ),
        ),
        TextButton(
          onPressed: () async {
            await dbEmotional.cleanEmotionalData();
            Get.back();
          },
          child: const Text(
            'OK',
            style: TextStyle(color: Colors.red),
          ),
        ),
      ],
    ));
  }

  @override
  void onInit() async {
    
    var info = await PackageInfo.fromPlatform();
    appVersion.value = info.version;
    super.onInit();
  }

}

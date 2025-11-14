import 'dart:async';
import 'package:emotional_release/db_emotional/emotional_entity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:emotional_release/db_emotional/db_emotional.dart';
import 'package:get/get.dart';
import 'package:sensors_plus/sensors_plus.dart';

class EmotionalFirstLogic extends GetxController {

  DBEmotional dbEmotional = Get.find();

  var style = 0.obs; 
  int type = 0;
  var releaseType = 0.obs; 
  var isShowCheck = false.obs;

  var waterLevel = 1.0.obs;
  var tiltAngle = 0.0.obs;
  
  
  var smashProgress = 0.0.obs;
  var cracks = <Offset>[].obs;

  String content = '';
  
  
  var intensity = 3.obs; 
  var selectedTriggers = <String>[].obs;
  var selectedFeelings = <String>[].obs;

  StreamSubscription<GyroscopeEvent>? _gyroscopeSubscription;

  void startListening() {
    _gyroscopeSubscription = gyroscopeEventStream().listen((GyroscopeEvent event) {
      tiltAngle.value = event.x.clamp(-0.8, 0.8);
      _updateWaterLevel();
    });
  }

  void stopListening() {
    _gyroscopeSubscription?.cancel();
  }

  void _updateWaterLevel() {
    if (tiltAngle.value.abs() > 0.1) {
      double drainRate = 0.03 * tiltAngle.value.abs();

      waterLevel.value = (waterLevel.value - drainRate).clamp(0.0, 1.0);
    }
    if (waterLevel.value <= 0.0) {
      isShowCheck.value = true;
      stopListening();
      tiltAngle.value = 0.0;
    }
  }

  void setIntensity(int value) {
    intensity.value = value;
  }

  void toggleTrigger(String trigger) {
    if (selectedTriggers.contains(trigger)) {
      selectedTriggers.remove(trigger);
    } else {
      selectedTriggers.add(trigger);
    }
  }

  void toggleFeeling(String feeling) {
    if (selectedFeelings.contains(feeling)) {
      selectedFeelings.remove(feeling);
    } else {
      selectedFeelings.add(feeling);
    }
  }

  
  void addSmash(Offset position) {
    if (isShowCheck.value) return;
    
    cracks.add(position);
    
    int totalClicks = 10; 
    double newProgress = (cracks.length / totalClicks).clamp(0.0, 1.0);
    
    smashProgress.value = newProgress;
    waterLevel.value = (1.0 - newProgress).clamp(0.0, 1.0);
    
    if (cracks.length >= totalClicks) {
      smashProgress.value = 1.0; 
      waterLevel.value = 0.0; 
      isShowCheck.value = true; 
    }
  }

  restart() {
    style.value = 0;
    waterLevel.value = 1.0;
    type = -1;
    content = '';
    releaseType.value = 0;
    smashProgress.value = 0.0;
    cracks.clear();
    intensity.value = 3;
    selectedTriggers.clear();
    selectedFeelings.clear();
  }

  addData() async {
    await dbEmotional.insertEmotional(EmotionalEntity(
      id: 0,
      createdTime: DateTime.now(),
      type: type,
      content: content,
      intensity: intensity.value,
      triggers: selectedTriggers.toList(),
      physicalFeelings: selectedFeelings.toList(),
    ));
    Fluttertoast.showToast(msg: 'Save Success');
    restart();
  }

  @override
  void onClose() {
    stopListening();
    super.onClose();
  }

}

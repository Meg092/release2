import 'package:emotional_release/db_emotional/db_emotional.dart';
import 'package:emotional_release/db_emotional/emotional_entity.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class EmotionalDetailLogic extends GetxController {
  DBEmotional dbEmotional = Get.find();

  var entity = Rxn<EmotionalEntity>();
  var reflectionText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    final int entityId = Get.arguments as int;
    loadDetail(entityId);
  }

  void loadDetail(int id) async {
    final allData = await dbEmotional.getEmotionalAllData();
    final foundEntity = allData.firstWhere((e) => e.id == id);
    entity.value = foundEntity;
    reflectionText.value = foundEntity.reflection ?? '';
  }

  void saveReflection() async {
    if (reflectionText.value.isEmpty) {
      Fluttertoast.showToast(msg: 'Please input reflection content');
      return;
    }

    if (entity.value == null) return;

    await dbEmotional.updateReflection(entity.value!.id, reflectionText.value);
    Fluttertoast.showToast(msg: 'Reflection saved successfully');
    Get.back(result: true);
  }
}

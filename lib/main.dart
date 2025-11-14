import 'package:emotional_release/db_emotional/db_emotional.dart';
import 'package:emotional_release/pages/emotional_decompose/emotional_decompose_binding.dart';
import 'package:emotional_release/pages/emotional_decompose/emotional_decompose_view.dart';
import 'package:emotional_release/pages/emotional_detail/emotional_detail_binding.dart';
import 'package:emotional_release/pages/emotional_detail/emotional_detail_view.dart';
import 'package:emotional_release/pages/emotional_first/emotional_first_binding.dart';
import 'package:emotional_release/pages/emotional_first/emotional_first_view.dart';
import 'package:emotional_release/pages/emotional_second/emotional_second_binding.dart';
import 'package:emotional_release/pages/emotional_second/emotional_second_filtration.dart';
import 'package:emotional_release/pages/emotional_second/emotional_second_view.dart';
import 'package:emotional_release/pages/emotional_tab/emotional_tab_binding.dart';
import 'package:emotional_release/pages/emotional_tab/emotional_tab_view.dart';
import 'package:emotional_release/pages/emotional_third/emotional_third_binding.dart';
import 'package:emotional_release/pages/emotional_third/emotional_third_view.dart';
import 'package:emotional_release/pages/emotional_weekly_report/emotional_weekly_report_binding.dart';
import 'package:emotional_release/pages/emotional_weekly_report/emotional_weekly_report_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Color primaryColor = const Color(0xff39bd80);
Color bgColor = const Color(0xfff7f7f7);

List<String> moodTypes = ['Anxiety', 'Anger', 'Fury', 'Extreme'];


Map<int, String> emotionalGuidance = {
  0: "Feeling anxious is completely normal. Let's calm it down through deep breathing and release.",
  1: "Anger is a natural emotion that tells us something matters to us. Let's release it safely.",
  2: "Fury can be overwhelming, but acknowledging it is the first step. Let's transform this energy together.",
  3: "Extreme emotions need attention and care. You're taking the right step by addressing them.",
};


List<String> releaseTypes = ['Shake & Pour', 'Smash'];
List<String> releaseDescriptions = [
  'Tilt your phone left and right to pour out the emotions like water',
  'Tap repeatedly to smash the emotional container into pieces',
];

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await Get.putAsync(() => DBEmotional().init());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: Emotional,
      initialRoute: '/',
      theme: ThemeData(
          useMaterial3: true,
          primaryColor: primaryColor,
          scaffoldBackgroundColor: bgColor,
          colorScheme: ColorScheme.light(
            primary: primaryColor,
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            foregroundColor: Colors.white,
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedItemColor: primaryColor,
            selectedLabelStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            elevation: 0,
            backgroundColor: Colors.white,
          )),
    );
  }
}

List<GetPage<dynamic>> Emotional = [
  GetPage(name: '/', page: () => EmotionalDecomposeView(), binding: EmotionalDecomposeBinding()),
  GetPage(name: '/emotionalTab', page: () => EmotionalTabPage(), binding: EmotionalTabBinding()),
  GetPage(name: '/emotionalFirst', page: () => EmotionalFirstPage(), binding: EmotionalFirstBinding()),
  GetPage(name: '/emotionalSecond', page: () => EmotionalSecondPage(), binding: EmotionalSecondBinding()),
  GetPage(name: '/emotionalSecondFilter', page: () => EmotionalSecondFiltration()),
  GetPage(name: '/emotionalThird', page: () => EmotionalThirdPage(), binding: EmotionalThirdBinding()),
  GetPage(name: '/emotionalDetail', page: () => EmotionalDetailPage(), binding: EmotionalDetailBinding()),
  GetPage(name: '/emotionalWeeklyReport', page: () => EmotionalWeeklyReportPage(), binding: EmotionalWeeklyReportBinding()),
];

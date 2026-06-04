import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/on_boarding_screens/splash_screen.dart';

import 'core/theme_service.dart';
//
// void main() {
//   Get.put(ThemeController());
//   runApp(const MyApp());
// }
void main() {
  Get.put(ThemeController());

  runApp(
    DevicePreview(
      enabled: true,
      builder: (context) => const MyApp(),
    ),
  );
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Highlights',

      theme: ThemeService.darkTheme,   // ✅ correct
      darkTheme: ThemeService.lightTheme, // ✅ correct
      themeMode: ThemeMode.light,

      home: const SplashScreen(),
    );
  }
}
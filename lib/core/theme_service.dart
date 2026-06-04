import 'package:flutter/material.dart';
import 'package:get/get.dart';

// 1. Controller jo theme switch karega
class ThemeController extends GetxController {
  // IsDarkMode ko observe karne ke liye .obs use kiya
  var isDarkMode = false.obs;

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    if (isDarkMode.value) {
      Get.changeThemeMode(ThemeMode.dark);
    } else {
      Get.changeThemeMode(ThemeMode.light);
    }
  }
}
class ThemeService {
  // 1. Light Theme (Default)
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: const Color(0xff35B8DD),
    cardColor: const Color(0xffF5F5F5), // Halka grey cards ke liye
    canvasColor: Colors.black, // Text ke liye
    iconTheme: const IconThemeData(color: Color(0xff56B6D0)),
  );

  // 2. Dark Theme
  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: const Color(0xff0F1012),
    primaryColor: const Color(0xff56B6D0),
    cardColor: const Color(0xff262626),
    canvasColor: Colors.white,
    iconTheme: const IconThemeData(color: Color(0xff56B6D0)),
  );

  // Theme switch karne ka function
  void switchTheme() {
    Get.changeThemeMode(Get.isDarkMode ? ThemeMode.light : ThemeMode.dark);
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/Contollers/post_controller.dart';
// import 'package:highlights/on_boarding_screens/splash_screen.dart';
// import 'package:highlights/Contollers/auth_controller.dart';
//
// import 'Contollers/chat_controller.dart';
// import 'Contollers/notificaion_controller.dart';
// import 'Contollers/profile_controller.dart';
// import 'core/theme_service.dart';
//
// void main() {
//   Get.put(ThemeController());
//   Get.put(AuthController(), permanent: true);
//   Get.put(ProfileController());
//   Get.put(ChatController(), permanent: true);
//   runApp(const MyApp());
// }
// // void main() {
// //   Get.put(ThemeController());
// //
// //   runApp(
// //     DevicePreview(
// //       enabled: true,
// //       builder: (context) => const MyApp(),
// //     ),
// //   );
// // }
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Highlights',
//
//       theme: ThemeService.darkTheme,   // ✅ correct
//       darkTheme: ThemeService.lightTheme, // ✅ correct
//       themeMode: ThemeMode.light,
//
//       home: const SplashScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:highlights/Contollers/post_controller.dart';
import 'package:highlights/on_boarding_screens/splash_screen.dart';
import 'package:highlights/Contollers/auth_controller.dart';
import 'Contollers/block_controller.dart';
import 'Contollers/chat_controller.dart';
import 'Contollers/profile_controller.dart';
import 'core/models/image_cache_config.dart';
import 'core/theme_service.dart';

void main() async {
  await GetStorage.init();

  WidgetsFlutterBinding.ensureInitialized();
  ImageCacheConfig.apply();

  PaintingBinding.instance.imageCache.maximumSize = 50;
  PaintingBinding.instance.imageCache.maximumSizeBytes = 50 * 1024 * 1024;

  Get.put(ThemeController());
  Get.put(AuthController(), permanent: true);
  Get.put(ProfileController());
  Get.put(BlockController());
  Get.put(ChatController(), permanent: true);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ThemeController>(
      builder: (themeController) {
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Highlights',
          theme: ThemeService.darkTheme,
          darkTheme: ThemeService.lightTheme,
          themeMode: ThemeMode.light,
          home: const SplashScreen(),
        );
      },
    );
  }
}
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/on_boarding_screens/on_boardingscreen_one.dart';

import '../Contollers/auth_controller.dart';
import '../main_pages/live_stream.dart';
import 'onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Get.find<AuthController>().checkLoginStatus();
      // Get.to(OnboardingScreen(),
      //   transition: Transition.noTransition,
      //   duration: Duration.zero,);
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      backgroundColor: AppColors.lightblue,
      body: Container(
        width: w,
        height: h,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/sp3.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.15,
            ),

            child: Image.asset(
              'assets/images/sp2.png',
              width: w * 0.9,   // responsive logo size
              height: h * 0.9,  // responsive height
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
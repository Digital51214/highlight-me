import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/auth_screen/sign_up.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/buttons.dart';

import '../Contollers/auth_controller.dart';
import '../auth_screen/login_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // --- MEDIA QUERY VARIABLES ---
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    // Theme references for easy access
    final Color textColor = Theme.of(context).canvasColor;
    final Color secondaryTextColor = const Color(0xFF777777);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: const Color(0xFF191919),
      body: SingleChildScrollView( // Added for safety on small screens
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: h * 0.28, // Responsive Image Height
              child: Image.asset(
                'assets/images/w1.png',
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: h * 0.018), // Responsive Spacer
            Text(
              'Create. Capture. Share.',
              style: MainTextStyles.inter(
                fontWeight: FontWeight.w900,
                fontSize: h * 0.037, // Responsive Font Size
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.0001), // Responsive Spacer
            Text(
              'Capture your weekend moments from Monday\nto Thursday.',
              style: MainTextStyles.inter(
                fontWeight: FontWeight.w400,
                fontSize: h * 0.018, // Responsive Font Size
                color: textColor,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: h * 0.047), // Responsive Spacer

            // Feature Cards
            _buildFeatureCard(
              context,
              iconPath: 'assets/images/v1.svg',
              title: '1 Photo per week',
              subtitle: 'Your best weekend shot',
              iconBoxColor: const Color(0xFF45959E),
            ),
            SizedBox(height: h * 0.018), // Responsive Spacer
            _buildFeatureCard(
              context,
              iconPath: 'assets/images/v2.svg',
              title: '1 Video per week',
              subtitle: 'Capture the full moment',
              iconBoxColor: const Color(0xFFB29CD0),
            ),
            SizedBox(height: h * 0.018), // Responsive Spacer
            _buildFeatureCard(
              context,
              iconPath: 'assets/images/v3.svg',
              title: 'Auto Archived',
              subtitle: 'Saved to your profile forever',
              iconBoxColor: const Color(0xFFFFFCC5),
            ),

            SizedBox(height: h * 0.07), // Responsive Spacer
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: w * 0.05),
              child: RoundButton(
                text: 'Get Started',
                onTap: () {
                    // ✅ Flag save karo ke onboarding dekh li
                    Get.find<AuthController>().completeOnboarding();

                    // Login screen par jao
                    Get.offAll(
                          () => SignUp(),
                      transition: Transition.fadeIn,
                    );
                },
              ),
            ),
            SizedBox(height: h * 0.024), // Responsive Bottom padding
          ],
        ),
      ),
    );
  }

  /// Helper widget for Feature Cards to keep code clean and theme-consistent
  Widget _buildFeatureCard(
      BuildContext context, {
        required String iconPath,
        required String title,
        required String subtitle,
        required Color iconBoxColor,
      }) {
    // --- MEDIA QUERY VARIABLES FOR HELPER WIDGET ---
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;
    final Color textColor = Theme.of(context).canvasColor;

    return Padding(
      padding:EdgeInsets.symmetric(horizontal: w * 0.05),
      child: Container(
        height: h * 0.1, // Responsive Card Height
        width: w,  // Responsive Card Width
        padding: EdgeInsets.symmetric(horizontal: w * 0.03), // Responsive Padding
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(h * 0.018), // Responsive Radius
        ),
        child: Row(
          children: [
            // ICON BOX
            Container(
              height: h * 0.07, // Responsive Icon Box Height
              width: h * 0.07,  // Kept 'h' to maintain a perfect 1:1 square ratio
              decoration: BoxDecoration(
                color: iconBoxColor.withOpacity(0.2),
                borderRadius: BorderRadius.circular(h * 0.018), // Responsive Radius
              ),
              child: Center(
                child: SvgPicture.asset(
                  iconPath,
                  height: h * 0.021, // Responsive SVG Height
                  width: h * 0.021,  // Responsive SVG Width
                  colorFilter: ColorFilter.mode(
                    Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : iconBoxColor.withOpacity(0.8),
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ),
            SizedBox(width: w * 0.03), // Responsive Spacer

            // TEXT SECTION
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w700,
                      fontSize: h * 0.02, // Responsive Font Size
                      color: textColor,
                    ),
                  ),
                  SizedBox(height: h * 0.0001,),
                  Text(
                    subtitle,
                    style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: h * 0.014, // Responsive Font Size
                      color: textColor.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
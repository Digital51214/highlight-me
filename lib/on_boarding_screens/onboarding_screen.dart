import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/on_boarding_screens/welcome_screen.dart';


// ==========================================
// 1. MODELS
// ==========================================
class TextPart {
  final String text;
  final bool isBold;
  TextPart({required this.text, this.isBold = false});
}

class OnboardingModel {
  final String topText;
  final Color themeColor;
  final String subtitle;
  final String title;
  final List<TextPart> bodyParts;
  final String bgImagePath;

  OnboardingModel({
    required this.topText,
    required this.themeColor,
    required this.subtitle,
    required this.title,
    required this.bodyParts,
    this.bgImagePath = "assets/images/Onboarding1.png",
  });
}

// ==========================================
// 2. CONTROLLER (GetX)
// ==========================================
class OnboardingController extends GetxController {
  var currentPage = 0.obs;

  final List<OnboardingModel> pages = [
    OnboardingModel(
      topText: "ENJOY YOUR\nWEEKEND",
      themeColor: const Color(0xFF4F98A7), // Teal
      subtitle: "WEEKEND LOG",
      title: "CAPTURE YOUR\nWEEKEND",
      bgImagePath: "assets/images/Onboarding1.png",
      bodyParts: [
        TextPart(text: "Less scrolling, more living.\nDocument your story with\nexactly "),
        TextPart(text: "1 photo", isBold: true),
        TextPart(text: " and "),
        TextPart(text: "1 video.\n", isBold: true),
        TextPart(text: "Raw, real, and gone by Monday."),
      ],
    ),
    OnboardingModel(
      topText: "ONE WEEKEND.\nONE STORY.",
      themeColor: const Color(0xFFA9D020), // Green
      subtitle: "LIVE YOUR WEEKEND",
      title: "WEEKENDS MADE\nTO REMEMBER",
      bgImagePath: "assets/images/Onboarding2.png",
      bodyParts: [
        TextPart(text: "From small smiles to big\nmemories, make every weekend\ncount Because the "),
        TextPart(text: "best\nweekends", isBold: true),
        TextPart(text: " aren't just "),
        TextPart(text: "lived", isBold: true),
      ],
    ),
    OnboardingModel(
      topText: "YOUR\nWEEKEND,\nYOUR STORY",
      themeColor: const Color(0xFFE28612), // Orange
      subtitle: "CHOOSE YOUR MOMENT",
      title: "SELECT WHAT\nMATTERS",
      bgImagePath: "assets/images/Onboarding3.png",
      bodyParts: [
        TextPart(text: "Pick the "),
        TextPart(text: "one memory", isBold: true),
        TextPart(text: " that\ndefines your weekend and\nturn it into a "),
        TextPart(text: "story worth\n", isBold: true),
        TextPart(text: "sharing.")
      ],
    ),
  ];

  void nextPage() {
    if (currentPage.value < pages.length - 1) {
      currentPage.value++;
    } else {
      Get.offAll(() => const WelcomeScreen());
    }
  }
}

// ==========================================
// 3. VIEW (UI)
// ==========================================
class OnboardingScreen extends StatelessWidget {
  final OnboardingController controller = Get.put(OnboardingController());

  OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Obx(() {
        // Current active page ka data link kiya
        final page = controller.pages[controller.currentPage.value];

        return Stack(
          children: [
            // --- SMOOTH BACKGROUND CROSS-FADE ---
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 400),
              child: Image.asset(
                page.bgImagePath,
                key: ValueKey(page.bgImagePath), // Key zaroori hai animation trigger karne ke liye
                fit: BoxFit.cover,
                height: h,
                width: w,
              ),
            ),

            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // --- TOP TEXT (Smooth Fade Transition) ---
                Padding(
                  padding: EdgeInsets.only(top: h * 0.13, ),
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 400),
                    child: Container(
                      key: ValueKey(page.topText),
                      child: Transform.rotate(
                        angle: -0.25,
                        child: ShaderMask(
                          blendMode: BlendMode.srcIn,
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Colors.white, page.themeColor],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            stops: const [0.0, 1],
                          ).createShader(bounds),
                          child: Text(
                            page.topText,
                            style: TextStyle(
                              fontSize: w * 0.13,
                              fontWeight: FontWeight.w900,
                              height: 1.0,
                              letterSpacing: 1.2,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                // --- FIXED BOTTOM GLASS CARD ---
                Container(
                  margin: EdgeInsets.only(
                    left: w * 0.05,
                    right: w * 0.05,
                    bottom: h * 0.05,
                  ),
                  padding: const EdgeInsets.all(1.5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(h * 0.048),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 2.0, sigmaY: 2.0), // Real glass look ke liye blur barhaya
                      child: Container(
                        width: w,
                        padding: EdgeInsets.symmetric(
                          horizontal: w * 0.08,
                          vertical: h * 0.05,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(h * 0.09),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // Card ke andar ke badalny waly text ko switcher me dala taake smooth lagay
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              layoutBuilder: (currentChild, previousChildren) {
                                return Stack(
                                  alignment: Alignment.topLeft,
                                  children: <Widget>[
                                    ...previousChildren,
                                    if (currentChild != null) currentChild,
                                  ],
                                );
                              },
                              child: Column(
                                key: ValueKey(controller.currentPage.value),
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Subtitle
                                  Text(
                                    page.subtitle,
                                    style: TextStyle(
                                      color: page.themeColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: h * 0.015,
                                      letterSpacing: 1.2,
                                    ),
                                  ),
                                  SizedBox(height: h * 0.015),

                                  // Title
                                  Text(
                                    page.title,
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: h * 0.033,
                                      height: 1.1,
                                    ),
                                  ),
                                  SizedBox(height: h * 0.025),

                                  // RichText Body
                                  RichText(
                                    text: TextSpan(
                                      style: TextStyle(
                                        color: Colors.white.withOpacity(0.8),
                                        fontSize: h * 0.025,
                                        height: 1.5,
                                      ),
                                      children: page.bodyParts.map((part) {
                                        return TextSpan(
                                          text: part.text,
                                          style: TextStyle(
                                            fontWeight: part.isBold
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                            color: part.isBold
                                                ? Colors.white
                                                : Colors.white.withOpacity(0.9),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: h * 0.04),

                            // Page Indicators
                            Row(
                              children: List.generate(
                                controller.pages.length,
                                    (i) => _buildIndicator(
                                  i == controller.currentPage.value,
                                      Color(0xFF4F98A7), // Dynamic indicators color
                                  w,
                                ),
                              ),
                            ),
                            SizedBox(height: h * 0.04),

                            // Next Button (With smooth color transition)
                            SizedBox(
                              width: double.infinity,
                              height: h * 0.07,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(h * 0.035),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Color(0xFF4F98A7),
                                      blurRadius: 5,
                                    )
                                  ],
                                ),
                                child: ElevatedButton(
                                  onPressed: controller.nextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:Color(0xFF4F98A7), // Dynamic button color
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(h * 0.035),
                                    ),
                                    elevation: 0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Next",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: h * 0.022,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(width: w * 0.02),
                                      Icon(Icons.arrow_forward, color: Colors.white, size: h * 0.025),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      }),
    );
  }

  // Helper Widget for Indicators
  Widget _buildIndicator(bool isActive, Color themeColor, double w) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: EdgeInsets.only(right: w * 0.01),
      height: 4,
      width: isActive ? w * 0.18 : w * 0.09,
      decoration: BoxDecoration(
        color: isActive ? themeColor : Colors.white,
        borderRadius: BorderRadius.circular(2),
      ),
    );
  }
}


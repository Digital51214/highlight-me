import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/buttons.dart';
import 'package:highlights/on_boarding_screens/on_boardingscreen_one.dart';
import 'package:highlights/on_boarding_screens/welcome_screen.dart';

class OnBoardingscreenThree extends StatefulWidget {
  const OnBoardingscreenThree({super.key});

  @override
  State<OnBoardingscreenThree> createState() => _OnBoardingscreenThreeState();
}

class _OnBoardingscreenThreeState extends State<OnBoardingscreenThree> {
  int currentIndex = 2;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      body: Container(
        width: w,
        constraints: BoxConstraints(minHeight: h), // ✅ FIX
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/onsc1.png'),
            fit: BoxFit.cover,
          ),
        ),

        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.black.withValues(alpha: 0.6),
                Colors.transparent,
                Colors.black.withValues(alpha:0.8),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),

          child: SafeArea(
            child: Column(
              children: [
                SizedBox(height: h * 0.43),

                Center(
                  child: Container(
                    padding: EdgeInsets.all(w * 0.06),
                    height: h * 0.45,
                    width: w * 0.85,
                    decoration: BoxDecoration(
                      color: Colors.black.withValues(alpha:0.4),
                      borderRadius: BorderRadius.circular(70),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min, // ✅ FIX
                      children: [
                        SizedBox(height: h * 0.02),

                        Text(
                          'CHOOSE YOUR MOMENT',
                          style: MainTextStyles.inter(
                            fontSize: w * 0.03,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFFE28612),
                          ),
                        ),

                        SizedBox(height: h * 0.01),

                        Text(
                          'SELECT WHAT\nMATTERS',
                          style: MainTextStyles.inter(
                            fontSize: w * 0.065,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),

                        SizedBox(height: h * 0.015),

                        RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Pick the ",
                                style: MainTextStyles.inter(
                                  fontSize: 18,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "one memory ",
                                style: MainTextStyles.inter(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    "that\ndefines your weekend and\nturn it into a ",
                                style: MainTextStyles.inter(
                                  fontSize: 18,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                              TextSpan(
                                text: "story worth\n",
                                style: MainTextStyles.inter(
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: "sharing.",
                                style: MainTextStyles.inter(
                                  fontSize: 18,
                                  color: AppColors.grey,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: h * 0.025),

                        ThreeLineIndexSelector(
                          selectedIndex: currentIndex,
                          onChanged: (index) {
                            setState(() {
                              currentIndex = index;
                            });
                          },
                        ),

                        const Spacer(), // ✅ PUSH BUTTON DOWN

                        Center(
                          child: RoundButton(
                            text: 'Next',
                            onTap: () {
                              Get.to(WelcomeScreen(),
                                transition: Transition.noTransition,
                                duration: Duration.zero,);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: h * 0.01),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

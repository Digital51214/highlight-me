import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/buttons.dart';
import 'package:highlights/on_boarding_screens/on_boardingscreen_one.dart';
import 'package:highlights/on_boarding_screens/on_boardingscreen_three.dart';

class OnBoardingscreenTwo extends StatefulWidget {
  const OnBoardingscreenTwo({super.key});

  @override
  State<OnBoardingscreenTwo> createState() => _OnBoardingscreenTwoState();
}

class _OnBoardingscreenTwoState extends State<OnBoardingscreenTwo> {
  int currentIndex = 1;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      body: Container(
        width: w,
        height: h,
        decoration: BoxDecoration(
          image: const DecorationImage(
            image: AssetImage('assets/images/onsc2.png'),
            fit: BoxFit.cover,
          ),
          gradient: LinearGradient(
            colors: [
              Colors.black.withValues(alpha:0.6),
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
                  width: w * 0.85,
                  height: h * 0.45,
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha:0.4),
                    borderRadius: BorderRadius.circular(70),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: h * 0.02),

                      Text(
                        'LIVE YOUR WEEKEND',
                        style: MainTextStyles.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFFA9D020),
                        ),
                      ),

                      SizedBox(height: h * 0.01),

                      Text(
                        'WEEKENDS MADE\nTO REMEMBER',
                        style: MainTextStyles.inter(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),

                      SizedBox(height: h * 0.015),

                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text:
                                  "From small smiles to big\nmemories, make every weekend\ncount. Because the ",
                              style: MainTextStyles.inter(
                                fontSize: 18,
                                color: AppColors.grey,
                              ),
                            ),
                            TextSpan(
                              text: "best\nweekends ",
                              style: GoogleFonts.inter(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: "aren’t just ",
                              style: MainTextStyles.inter(
                                fontSize: 18,
                                color: AppColors.grey,
                              ),
                            ),
                            TextSpan(
                              text: "lived.",
                              style: MainTextStyles.inter(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
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
                            Get.to(OnBoardingscreenThree(),
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
    );
  }
}

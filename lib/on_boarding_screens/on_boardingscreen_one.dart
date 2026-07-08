import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/buttons.dart';
import 'package:highlights/on_boarding_screens/welcome_screen.dart';
class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({super.key});

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final PageController _controller = PageController();
  int currentIndex = 0;

  final List<Map<String, dynamic>> data = [
    {
      "image": "assets/images/onsc3.png",
      "titleTop": "WEEKEND LOG",
      "titleMain": "CAPTURE YOUR\n WEEKEND",
      "color": AppColors.lightblue,
      "description": [
        {"text": "Less scrolling, more living.\nDocument your story with\nexactly ", "bold": false},
        {"text": "1 photo and 1 video\n", "bold": true},
        {"text": "Raw, real, and gone by Monday.", "bold": false},
      ]
    },
    {
      "image": "assets/images/onsc2.png",
      "titleTop": "LIVE YOUR WEEKEND",
      "titleMain": "WEEKENDS MADE\nTO REMEMBER",
      "color": const Color(0xFFA9D020),
      "description": [
        {"text": "From small smiles to big\nmemories, make every weekend\ncount. Because the ", "bold": false},
        {"text": "best\nweekends ", "bold": true},
        {"text": "aren’t just ", "bold": false},
        {"text": "lived.", "bold": true},
      ]
    },
    {
      "image": "assets/images/onsc1.png",
      "titleTop": "CHOOSE YOUR MOMENT",
      "titleMain": "SELECT WHAT\nMATTERS",
      "color": const Color(0xFFE28612),
      "description": [
        {"text": "Pick the ", "bold": false},
        {"text": "one memory ", "bold": true},
        {"text": "that\ndefines your weekend and\nturn it into a ", "bold": false},
        {"text": "story worth\n", "bold": true},
        {"text": "sharing.", "bold": false},
      ]
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      body: PageView.builder(
        controller: _controller,
        itemCount: data.length,
        onPageChanged: (index) {
          setState(() => currentIndex = index);
        },
        itemBuilder: (context, index) {
          final item = data[index];

          return Container(
            width: w,
            height: h,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(item["image"]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.6),
                    Colors.transparent,
                    Colors.black.withOpacity(0.8),
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
                        height: h * 0.5,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(70),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: h * 0.02),
                            Text(
                              item["titleTop"],
                              style: MainTextStyles.inter(
                                fontSize: w * 0.03,
                                fontWeight: FontWeight.w700,
                                color: item["color"],
                              ),
                            ),

                            SizedBox(height: h * 0.01),

                            Text(
                              item["titleMain"],
                              style: MainTextStyles.inter(
                                fontSize: w * 0.065,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),

                            SizedBox(height: h * 0.015),

                            RichText(
                              text: TextSpan(
                                children: item["description"].map<TextSpan>((e) {
                                  return TextSpan(
                                    text: e["text"],
                                    style: MainTextStyles.inter(
                                      fontSize: 18,
                                      color: e["bold"] ? Colors.white : AppColors.grey,
                                      fontWeight: e["bold"] ? FontWeight.bold : FontWeight.w400,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),

                            SizedBox(height: h * 0.025),

                            ThreeLineIndexSelector(
                              selectedIndex: currentIndex,
                              onChanged: (i) {
                                _controller.animateToPage(
                                  i,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              },
                            ),

                            const Spacer(),

                            Center(
                              child: RoundButton(
                                text: index == 2 ? 'Start' : 'Next',
                                onTap: () {
                                  if (index == 2) {
                                    Get.to(WelcomeScreen(),
                                      transition: Transition.noTransition,
                                      duration: Duration.zero,);

                                  } else {
                                    _controller.nextPage(
                                      duration: const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  }
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}



class ThreeLineIndexSelector extends StatelessWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;

  const ThreeLineIndexSelector({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;

    return Row(
      children: List.generate(3, (index) {
        final isActive = selectedIndex == index;

        return GestureDetector(
          onTap: () => onChanged(index),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            margin: EdgeInsets.only(right: w * 0.015),
            height: 6,
            width: isActive ? w * 0.1 : w * 0.05,
            decoration: BoxDecoration(
              color: isActive ? AppColors.lightblue : Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        );
      }),
    );
  }
}

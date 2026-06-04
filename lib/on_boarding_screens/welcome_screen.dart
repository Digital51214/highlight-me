// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:highlights/auth_screen/sign_up.dart';
// import 'package:highlights/basic_files/basic_fontstyles.dart';
// import 'package:highlights/basic_files/buttons.dart';
//
// class WelcomeScreen extends StatefulWidget {
//   const WelcomeScreen({super.key});
//
//   @override
//   State<WelcomeScreen> createState() => _WelcomeScreenState();
// }
//
// class _WelcomeScreenState extends State<WelcomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: Column(
//         children: [
//           SizedBox(
//             width: double.infinity,
//             height: 237,
//             child: Image.asset('assets/images/w1.png'),
//           ),
//           SizedBox(height: 15),
//           Text(
//             'Create. Capture. Share.',
//             style: MainTextStyles.inter(
//               fontWeight: FontWeight.w900,
//               fontSize: 28,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 8),
//           Text(
//             'Capture your weekend moments from Monday\nto Thursday.',
//             style: MainTextStyles.inter(
//               fontWeight: FontWeight.w400,
//               fontSize: 13,
//               color: Colors.white,
//             ),
//             textAlign: TextAlign.center,
//           ),
//           SizedBox(height: 40),
//           Container(
//             height: 68,
//             width: 335,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF706E6E).withValues(alpha: 0.2),
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
//             ),
//             child: Row(
//               children: [
//                 // ICON BOX
//                 Container(
//                   height: 42,
//                   width: 42,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF45959E).withValues(alpha: 0.2),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       'assets/images/v1.svg',
//                       height: 18,
//                       width: 18,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(width: 12),
//
//                 // TEXT SECTION
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '1 Photo per week',
//                         style: MainTextStyles.inter(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                           color: Colors.white,
//                         ),
//                       ),
//
//                       Text(
//                         'Your best weekend shot',
//                         style: MainTextStyles.inter(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 10,
//                           color: const Color(0xFF777777),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 15),
//           Container(
//             height: 68,
//             width: 335,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF706E6E).withValues(alpha: 0.2),
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
//             ),
//             child: Row(
//               children: [
//                 // ICON BOX
//                 Container(
//                   height: 42,
//                   width: 42,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFB29CD0).withValues(alpha: 0.2),
//                     borderRadius: BorderRadius.circular(15),
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       'assets/images/v2.svg',
//                       height: 18,
//                       width: 18,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(width: 12),
//
//                 // TEXT SECTION
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         '1 Video per week',
//                         style: MainTextStyles.inter(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                           color: Colors.white,
//                         ),
//                       ),
//
//                       Text(
//                         'Capture the full moment',
//                         style: MainTextStyles.inter(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 10,
//                           color: const Color(0xFF777777),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 15),
//           Container(
//             height: 68,
//             width: 335,
//             padding: const EdgeInsets.symmetric(horizontal: 12),
//             decoration: BoxDecoration(
//               color: const Color(0xFF706E6E).withValues(alpha: 0.2),
//               borderRadius: BorderRadius.circular(15),
//               border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
//             ),
//             child: Row(
//               children: [
//                 // ICON BOX
//                 Container(
//                   height: 42,
//                   width: 42,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFFFFCC5).withValues(alpha: 0.2),
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   child: Center(
//                     child: SvgPicture.asset(
//                       'assets/images/v3.svg',
//                       height: 18,
//                       width: 18,
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(width: 12),
//
//                 // TEXT SECTION
//                 Expanded(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         'Auto Archived',
//                         style: MainTextStyles.inter(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                           color: Colors.white,
//                         ),
//                       ),
//
//                       Text(
//                         'Saved to your profile forever',
//                         style: MainTextStyles.inter(
//                           fontWeight: FontWeight.w400,
//                           fontSize: 10,
//                           color: const Color(0xFF777777),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: 60),
//           RoundButton(
//             text: 'Get Started',
//             onTap: () {
//               Get.to(SignUp(),
//                 transition: Transition.noTransition,
//                 duration: Duration.zero,);
//             })
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:highlights/auth_screen/sign_up.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/buttons.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    // Theme references for easy access
    final Color textColor = Theme.of(context).canvasColor;
    final Color secondaryTextColor = const Color(0xFF777777);
    final bool isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView( // Added for safety on small screens
        child: Column(
          children: [
            SizedBox(
              width: double.infinity,
              height: 237,
              child: Image.asset(
                'assets/images/w1.png',
                fit: BoxFit.cover, // Image handle
              ),
            ),
            const SizedBox(height: 15),
            Text(
              'Create. Capture. Share.',
              style: MainTextStyles.inter(
                fontWeight: FontWeight.w900,
                fontSize: 28,
                color: textColor, // Theme dependent
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              'Capture your weekend moments from Monday\nto Thursday.',
              style: MainTextStyles.inter(
                fontWeight: FontWeight.w400,
                fontSize: 13,
                color: textColor.withOpacity(0.7), // Adaptive opacity
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),

            // Feature Cards
            _buildFeatureCard(
              context,
              iconPath: 'assets/images/v1.svg',
              title: '1 Photo per week',
              subtitle: 'Your best weekend shot',
              iconBoxColor: const Color(0xFF45959E),
            ),
            const SizedBox(height: 15),
            _buildFeatureCard(
              context,
              iconPath: 'assets/images/v2.svg',
              title: '1 Video per week',
              subtitle: 'Capture the full moment',
              iconBoxColor: const Color(0xFFB29CD0),
            ),
            const SizedBox(height: 15),
            _buildFeatureCard(
              context,
              iconPath: 'assets/images/v3.svg',
              title: 'Auto Archived',
              subtitle: 'Saved to your profile forever',
              iconBoxColor: const Color(0xFFFFFCC5),
            ),

            const SizedBox(height: 60),
            RoundButton(
              text: 'Get Started',
              onTap: () {
                Get.to(() => const SignUp(),
                  transition: Transition.noTransition,
                  duration: Duration.zero,
                );
              },
            ),
            const SizedBox(height: 20), // Bottom padding
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
    final Color textColor = Theme.of(context).canvasColor;

    return Container(
      height: 68,
      width: 335,
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        // Card background adjusts based on theme
        color: textColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: textColor.withOpacity(0.08)),
      ),
      child: Row(
        children: [
          // ICON BOX
          Container(
            height: 42,
            width: 42,
            decoration: BoxDecoration(
              color: iconBoxColor.withOpacity(0.2),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: SvgPicture.asset(
                iconPath,
                height: 18,
                width: 18,
                // Svg color adjustment if needed
                colorFilter: ColorFilter.mode(
                  Theme.of(context).brightness == Brightness.dark
                      ? Colors.white
                      : iconBoxColor.withOpacity(0.8),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          // TEXT SECTION
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: MainTextStyles.inter(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                    color: textColor,
                  ),
                ),
                Text(
                  subtitle,
                  style: MainTextStyles.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 10,
                    color: textColor.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
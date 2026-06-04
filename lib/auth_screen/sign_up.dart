// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/auth_screen/login_screen.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
// import 'package:highlights/basic_files/basic_fontstyles.dart';
// import 'package:highlights/basic_files/bottom_bar.dart';
// import 'package:highlights/basic_files/buttons.dart';
// import 'package:highlights/basic_files/check_box.dart';
// import 'package:highlights/basic_files/text_fields.dart';
// import 'package:highlights/presentation_screen/PrivacyPolicyScreen.dart';
// import 'package:highlights/presentation_screen/TermsAndConditionScreen.dart';
//
// class SignUp extends StatefulWidget {
//   const SignUp({super.key});
//
//   @override
//   State<SignUp> createState() => _SignUpState();
// }
//
// class _SignUpState extends State<SignUp> {
//   TextEditingController usernameController = TextEditingController();
//   TextEditingController emailController = TextEditingController();
//   TextEditingController passwordController = TextEditingController();
//   TextEditingController confirmPasswordController = TextEditingController();
//
//   bool rememberMe = false;
//
//   @override
//   Widget build(BuildContext context) {
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal:w * 0.055,
//             vertical: h * 0.012,
//           ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     height: 100,
//                     width: 180,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//                 SizedBox(height: h * 0.05),
//                 Text(
//                   'Sign Up',
//                   style: MainTextStyles.inter(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//                 SizedBox(height: h * 0.005),
//                 Text(
//                   'Enter Your Account Details!',
//                   style: MainTextStyles.inter(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.grey1,
//                   ),
//                 ),
//                 SizedBox(height: h * 0.02),
//                 RoundTextField(
//                   hintText: 'Username...',
//                   controller: usernameController,
//                 ),
//                 SizedBox(height: h * 0.01),
//                 EmailTextField(
//                   hintText: 'Email Address...',
//                   controller: emailController,
//                 ),
//                 SizedBox(height: h * 0.01),
//                 PasswordTextField(
//                   hintText: 'Password...',
//                   controller: passwordController,
//                 ),
//                 SizedBox(height: h * 0.01),
//                 PasswordTextField(
//                   hintText: 'Confirm Password...',
//                   controller: confirmPasswordController,
//                 ),
//                 SizedBox(height: h * 0.02),
//                 Row(
//                   children: [
//                     CircularCheckbox(
//                       initialValue: rememberMe,
//                       onChanged: (val) {
//                         setState(() {
//                           rememberMe = val;
//                         });
//                       },
//                     ),
//                     SizedBox(width: w * 0.02),
//                     Expanded(
//                       child: RichText(
//                         text: TextSpan(
//                           children: [
//                             TextSpan(
//                               text: 'I agree with all ',
//                               style: MainTextStyles.inter(
//                                 color: AppColors.grey1,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Terms & Conditions ',
//                               style: GoogleFonts.inter(
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: AppColors.lightblue,
//                                 color: AppColors.lightblue,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Get.to(TermsandConditionscreen());
//                                 },
//                             ),
//                             TextSpan(
//                               text: 'and ',
//                               style: MainTextStyles.inter(
//                                 color: const Color(0xFF767575),
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Privacy Policy',
//                               style: GoogleFonts.inter(
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: AppColors.lightblue,
//                                 color: AppColors.lightblue,
//                                 fontSize: 10,
//                                 fontWeight: FontWeight.w700,
//                               ),
//                               recognizer: TapGestureRecognizer()
//                                 ..onTap = () {
//                                   Get.to(PrivacyPolicyscreen());
//                                 },
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 SizedBox(height: h * 0.04),
//                 Center(
//                   child: RoundButton(
//                     text: 'Create Account',
//                     onTap: () {
//                       Get.to(MainScreen(),
//                         transition: Transition.noTransition,
//                         duration: Duration.zero,);
//                     },
//                   ),
//                 ),
//                 SizedBox(height: h * 0.01),
//                 SocialLoginSection(),
//               ],
//             ),
//           ),
//         ),
//
//     );
//   }
// }
//
// class SocialLoginSection extends StatelessWidget {
//   const SocialLoginSection({super.key});
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Expanded(
//               child: Container(height: 1, color: Colors.white.withValues(alpha:0.2)),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Text("OR", style: TextStyle(color: Colors.white70)),
//             ),
//             Expanded(
//               child: Container(height: 1, color: Colors.white.withValues(alpha:0.2)),
//             ),
//           ],
//         ),
//         SizedBox(height: 20),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _socialButton("assets/images/google.png"),
//             const SizedBox(width: 20),
//             _socialButton("assets/images/apple.png"),
//           ],
//         ),
//         SizedBox(height: 40),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Already have an account? ",
//               style: GoogleFonts.inter(
//                 color: AppColors.grey2,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w500
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Get.to(LoginScreen());
//               },
//               child:  Text(
//                 "Sign In",
//                 style:GoogleFonts.inter(
//                   color: AppColors.lightblue,
//                   decoration: TextDecoration.underline,
//                   decorationColor: AppColors.lightblue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _socialButton(String icon) {
//     return Container(
//       height: 55,
//       width: 55,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         border: Border.all(color: Colors.white.withValues(alpha:0.2)),
//       ),
//       child: Center(child: Image.asset(icon, height: 24, width: 24)),
//     );
//   }
// }
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/auth_screen/login_screen.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/bottom_bar.dart';
import 'package:highlights/basic_files/buttons.dart';
import 'package:highlights/basic_files/check_box.dart';
import 'package:highlights/basic_files/text_fields.dart';
import 'package:highlights/presentation_screen/PrivacyPolicyScreen.dart';
import 'package:highlights/presentation_screen/TermsAndConditionScreen.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  bool rememberMe = false;

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal:w * 0.055,
            vertical: h * 0.012,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'assets/images/logo.png',
                  height: 100,
                  width: 180,
                  fit: BoxFit.contain,
                  color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,
                ),
              ),
              SizedBox(height: h * 0.05),
              Text(
                'Sign Up',
                style: MainTextStyles.inter(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: Theme.of(context).canvasColor, // Changed to Theme
                ),
              ),
              SizedBox(height: h * 0.005),
              Text(
                'Enter Your Account Details!',
                style: MainTextStyles.inter(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: const Color(0xFF767575),
                ),
              ),
              SizedBox(height: h * 0.02),
              RoundTextField(
                hintText: 'Username...',
                controller: usernameController,
              ),
              SizedBox(height: h * 0.01),
              EmailTextField(
                hintText: 'Email Address...',
                controller: emailController,
              ),
              SizedBox(height: h * 0.01),
              PasswordTextField(
                hintText: 'Password...',
                controller: passwordController,
              ),
              SizedBox(height: h * 0.01),
              PasswordTextField(
                hintText: 'Confirm Password...',
                controller: confirmPasswordController,
              ),
              SizedBox(height: h * 0.02),
              Row(
                children: [
                  CircularCheckbox(
                    initialValue: rememberMe,
                    onChanged: (val) {
                      setState(() {
                        rememberMe = val;
                      });
                    },
                  ),
                  SizedBox(width: w * 0.02),
                  Expanded(
                    child: RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'I agree with all ',
                            style: MainTextStyles.inter(
                              color: const Color(0xFF767575),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'Terms & Conditions ',
                            style: GoogleFonts.inter(
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).primaryColor, // Changed to Theme
                              color: Theme.of(context).primaryColor, // Changed to Theme
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(TermsandConditionscreen());
                              },
                          ),
                          TextSpan(
                            text: 'and ',
                            style: MainTextStyles.inter(
                              color: const Color(0xFF767575),
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: GoogleFonts.inter(
                              decoration: TextDecoration.underline,
                              decorationColor: Theme.of(context).primaryColor, // Changed to Theme
                              color: Theme.of(context).primaryColor, // Changed to Theme
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(PrivacyPolicyscreen());
                              },
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: h * 0.04),
              Center(
                child: RoundButton(
                  text: 'Create Account',
                  onTap: () {
                    Get.to(MainScreen(),
                      transition: Transition.noTransition,
                      duration: Duration.zero,);
                  },
                ),
              ),
              SizedBox(height: h * 0.01),
              SocialLoginSection(),
            ],
          ),
        ),
      ),

    );
  }
}

class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Container(height: 1, color: Theme.of(context).canvasColor.withOpacity(0.2)), // Changed
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text("OR", style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.7))), // Changed
            ),
            Expanded(
              child: Container(height: 1, color: Theme.of(context).canvasColor.withOpacity(0.2)), // Changed
            ),
          ],
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(context, "assets/images/google.png"), // Context passed
            const SizedBox(width: 20),
            _socialButton(context, "assets/images/apple.png"), // Context passed
          ],
        ),
        SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: GoogleFonts.inter(
                  color: const Color(0xFF767575),
                  fontSize: 16,
                  fontWeight: FontWeight.w500
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(LoginScreen());
              },
              child:  Text(
                "Sign In",
                style:GoogleFonts.inter(
                  color: Theme.of(context).primaryColor, // Changed
                  decoration: TextDecoration.underline,
                  decorationColor: Theme.of(context).primaryColor, // Changed
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(BuildContext context, String icon) {
    return Container(
      height: 55,
      width: 55,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).canvasColor.withOpacity(0.2)), // Changed
      ),
      child: Center(child: Image.asset(icon, height: 24, width: 24)),
    );
  }
}
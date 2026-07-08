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
//     // --- MEDIA QUERY VARIABLES ---
//     final Size size = MediaQuery.of(context).size;
//     final double h = size.height;
//     final double w = size.width;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: w * 0.05,
//               vertical: h * 0.012,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     height: h * 0.125, // Responsive Height
//                     width: w * 0.5,    // Responsive Width
//                     fit: BoxFit.contain,
//                     color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,
//                   ),
//                 ),
//                 SizedBox(height: h * 0.02),
//                 Text(
//                   'Sign Up',
//                   style: MainTextStyles.inter(
//                     fontSize: h * 0.0325, // Responsive Font Size
//                     fontWeight: FontWeight.w700,
//                     color: Theme.of(context).canvasColor,
//                   ),
//                 ),
//                 SizedBox(height: h * 0.005),
//                 Text(
//                   'Enter Details to Create Your Account!',
//                   style: MainTextStyles.inter(
//                     fontSize: h * 0.016, // Responsive Font Size
//                     fontWeight: FontWeight.w400,
//                     color: const Color(0xFF767575),
//                   ),
//                 ),
//                 SizedBox(height: h * 0.02),
//                 RoundTextField(
//                   hintText: 'Full Name',
//                   controller: usernameController,
//                 ),
//                 SizedBox(height: h * 0.01),
//                 EmailTextField(
//                   hintText: 'Email Address',
//                   controller: emailController,
//                 ),
//                 SizedBox(height: h * 0.01),
//                 PasswordTextField(
//                   hintText: 'Create Password',
//                   controller: passwordController,
//                 ),
//                 SizedBox(height: h * 0.01),
//                 PasswordTextField(
//                   hintText: 'Confirm Password',
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
//                                 color: const Color(0xFF767575),
//                                 fontSize: h * 0.0125, // Responsive Font Size
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Terms & Conditions ',
//                               style: GoogleFonts.inter(
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: Theme.of(context).primaryColor,
//                                 color: Theme.of(context).primaryColor,
//                                 fontSize: h * 0.0125, // Responsive Font Size
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
//                                 fontSize: h * 0.0125, // Responsive Font Size
//                                 fontWeight: FontWeight.w700,
//                               ),
//                             ),
//                             TextSpan(
//                               text: 'Privacy Policy',
//                               style: GoogleFonts.inter(
//                                 decoration: TextDecoration.underline,
//                                 decorationColor: Theme.of(context).primaryColor,
//                                 color: Theme.of(context).primaryColor,
//                                 fontSize: h * 0.0125, // Responsive Font Size
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
//                 SizedBox(height: h * 0.05),
//                 const SocialLoginSection(),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SocialLoginSection extends StatelessWidget {
//   const SocialLoginSection({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // --- MEDIA QUERY VARIABLES FOR SOCIAL SECTION ---
//     final Size size = MediaQuery.of(context).size;
//     final double h = size.height;
//     final double w = size.width;
//
//     return Column(
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: w * 0.07), // Responsive Horizontal Padding
//           child: Row(
//             children: [
//               Expanded(
//                 child: Container(
//                   height: 1,
//                   color: Theme.of(context).canvasColor.withOpacity(0.2),
//                 ),
//               ),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: w * 0.028), // Responsive Text Padding
//                 child: Text(
//                   "OR",
//                   style: TextStyle(
//                     color: Theme.of(context).canvasColor.withOpacity(0.7),
//                     fontWeight: FontWeight.w700,
//                     fontSize: h * 0.016, // Responsive Font Size
//                   ),
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   height: 1,
//                   color: Theme.of(context).canvasColor.withOpacity(0.2),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: h * 0.025), // Responsive Spacer
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _socialButton(context, "assets/images/google.png", h, w),
//             SizedBox(width: w * 0.055), // Responsive Spacer
//             _socialButton(context, "assets/images/apple.png", h, w),
//           ],
//         ),
//         SizedBox(height: h * 0.05), // Responsive Spacer
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Already have an account? ",
//               style: GoogleFonts.inter(
//                   color: const Color(0xFF767575),
//                   fontSize: h * 0.02, // Responsive Font Size
//                   fontWeight: FontWeight.w500
//               ),
//             ),
//             InkWell(
//               onTap: () {
//                 Get.to(LoginScreen());
//               },
//               child: Text(
//                 "Sign In",
//                 style: GoogleFonts.inter(
//                   color: Theme.of(context).primaryColor,
//                   decoration: TextDecoration.underline,
//                   fontWeight: FontWeight.w600,
//                   fontSize: h * 0.02, // Responsive Font Size
//                   decorationColor: Theme.of(context).primaryColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _socialButton(BuildContext context, String icon, double h, double w) {
//     return Container(
//       height: h * 0.068, // Responsive Button Height
//       width: h * 0.068,  // Maintained 1:1 ratio for a perfect circle shape
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         // border: Border.all(color: Theme.of(context).canvasColor.withOpacity(0.2)),
//         image: DecorationImage(
//           image: AssetImage("assets/images/Socialbackground.png"),
//         ),
//       ),
//       child: Center(
//         child: Image.asset(
//           icon,
//           height: h * 0.037, // Responsive Icon Height
//           width: w * 0.066,  // Responsive Icon Width
//         ),
//       ),
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
import '../Contollers/auth_controller.dart';
import '../widgets/custom_loader.dart';

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

  // Controller yahan initialize kiya gaya hai
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.05,
              vertical: h * 0.012,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Center(
                  child: Image.asset(
                    'assets/images/logo.png',
                    height: h * 0.125,
                    width: w * 0.5,
                    fit: BoxFit.contain,
                    color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,
                  ),
                ),
                SizedBox(height: h * 0.02),
                Text(
                  'Sign Up',
                  style: MainTextStyles.inter(
                    fontSize: h * 0.0325,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).canvasColor,
                  ),
                ),
                SizedBox(height: h * 0.005),
                Text(
                  'Enter Details to Create Your Account!',
                  style: MainTextStyles.inter(
                    fontSize: h * 0.016,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF767575),
                  ),
                ),
                SizedBox(height: h * 0.02),

                // Obx aur errorText add kiya gaya hai
                Obx(() => RoundTextField(
                  hintText: 'Full Name',
                  controller: usernameController,
                  errorText: authController.nameError.value,
                )),
                SizedBox(height: h * 0.01),

                Obx(() => EmailTextField(
                  hintText: 'Email Address',
                  controller: emailController,
                  errorText: authController.emailError.value,
                )),
                SizedBox(height: h * 0.01),

                Obx(() => PasswordTextField(
                  hintText: 'Create Password',
                  controller: passwordController,
                  errorText: authController.passwordError.value,
                )),
                SizedBox(height: h * 0.01),

                Obx(() => PasswordTextField(
                  hintText: 'Confirm Password',
                  controller: confirmPasswordController,
                  errorText: authController.confirmPasswordError.value,
                )),

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
                                fontSize: h * 0.0125,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            TextSpan(
                              text: 'Terms & Conditions ',
                              style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                                color: Theme.of(context).primaryColor,
                                fontSize: h * 0.0125,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => TermsandConditionscreen());
                                },
                            ),
                            TextSpan(
                              text: 'and ',
                              style: MainTextStyles.inter(
                                color: const Color(0xFF767575),
                                fontSize: h * 0.0125,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            TextSpan(
                              text: 'Privacy Policy',
                              style: GoogleFonts.inter(
                                decoration: TextDecoration.underline,
                                decorationColor: Theme.of(context).primaryColor,
                                color: Theme.of(context).primaryColor,
                                fontSize: h * 0.0125,
                                fontWeight: FontWeight.w700,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Get.to(() => PrivacyPolicyscreen());
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: h * 0.04),

                // Button par API Integration
                Center(
                  child: Obx(() =>
                      RoundButton(
                    text:'Create Account',
                    isLoading: authController.isLoading.value,
                    showArrow: true,
                    onTap: () {
                      // Keyboard hide karna
                      FocusScope.of(context).unfocus();

                      // Controller function call karna
                      authController.validateAndSignUp(
                        fullName: usernameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        confirmPassword: confirmPasswordController.text,
                        rememberMe: rememberMe,
                      );
                    },
                  ),
                  ),
                ),

                SizedBox(height: h * 0.05),
                const SocialLoginSection(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Social Login Section ka code pehle jaisa hi rahega
class SocialLoginSection extends StatelessWidget {
  const SocialLoginSection({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: w * 0.07),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 1,
                  color: Theme.of(context).canvasColor.withOpacity(0.2),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: w * 0.028),
                child: Text(
                  "OR",
                  style: TextStyle(
                    color: Theme.of(context).canvasColor.withOpacity(0.7),
                    fontWeight: FontWeight.w700,
                    fontSize: h * 0.016,
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 1,
                  color: Theme.of(context).canvasColor.withOpacity(0.2),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: h * 0.025),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(context, "assets/images/google.png", h, w),
            SizedBox(width: w * 0.055),
            _socialButton(context, "assets/images/apple.png", h, w),
          ],
        ),
        SizedBox(height: h * 0.05),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Already have an account? ",
              style: GoogleFonts.inter(
                  color: const Color(0xFF767575),
                  fontSize: h * 0.02,
                  fontWeight: FontWeight.w500
              ),
            ),
            InkWell(
              onTap: () {
                Get.to(() => LoginScreen());
              },
              child: Text(
                "Sign In",
                style: GoogleFonts.inter(
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.w600,
                  fontSize: h * 0.02,
                  decorationColor: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(BuildContext context, String icon, double h, double w) {
    return Container(
      height: h * 0.068,
      width: h * 0.068,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        image: DecorationImage(
          image: AssetImage("assets/images/Socialbackground.png"),
        ),
      ),
      child: Center(
        child: Image.asset(
          icon,
          height: h * 0.037,
          width: w * 0.066,
        ),
      ),
    );
  }
}
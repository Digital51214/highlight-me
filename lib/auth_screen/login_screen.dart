// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/auth_screen/sign_up.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
// import 'package:highlights/basic_files/basic_fontstyles.dart';
// import 'package:highlights/basic_files/bottom_bar.dart';
// import 'package:highlights/basic_files/buttons.dart';
// import 'package:highlights/basic_files/check_box.dart';
// import 'package:highlights/basic_files/text_fields.dart';
// import 'package:highlights/presentation_screen/ForgetPasswordScreen.dart';
//
// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});
//
//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }
//
// class _LoginScreenState extends State<LoginScreen> {
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
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//
//         child: Padding(
//           padding: EdgeInsets.symmetric(
//             horizontal: w * 0.055,
//             vertical:h * 0.012,
//           ),
//           child: Form(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Center(
//                   child: Image.asset(
//                     'assets/images/logo.png',
//                     height: 100,
//                     width: 180,
//                     fit: BoxFit.contain,
//                   ),
//                 ),
//
//                 SizedBox(height: h * 0.05),
//
//                 Text(
//                   'Log In',
//                   style: MainTextStyles.inter(
//                     fontSize: 26,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.white,
//                   ),
//                 ),
//
//                 SizedBox(height: h * 0.005),
//
//                 Text(
//                   'Capture the pulse of your spontaneity.',
//                   style: MainTextStyles.inter(
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                     color: const Color(0xFF767575),
//                   ),
//                 ),
//
//                 SizedBox(height: h * 0.02),
//
//                 RoundTextField(
//                   hintText: 'Username...',
//                   controller: usernameController,
//                 ),
//
//                 SizedBox(height: h * 0.01),
//
//                 PasswordTextField(
//                   hintText: 'Password...',
//                   controller: passwordController,
//                 ),
//
//                 SizedBox(height: h * 0.02),
//
//                 Row(
//                   crossAxisAlignment: CrossAxisAlignment.start,
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
//                     Text(
//                       'Remember Me',
//                       style: GoogleFonts.inter(
//                         fontWeight: FontWeight.w700,
//                         fontSize: 13,
//                         decoration: TextDecoration.underline,
//                         color: AppColors.lightblue,
//                         decorationColor: AppColors.lightblue,
//                       ),
//                     ),
//                     Spacer(),
//                     GestureDetector(
//                       onTap: (){
//                         Get.to(Forgetpasswordscreen(),
//                           transition: Transition.noTransition,
//                           duration: Duration.zero,
//                         );
//                       },
//                       child: Text(
//                         'Forget Password',
//                         style: GoogleFonts.inter(
//                           fontWeight: FontWeight.w700,
//                           fontSize: 13,
//                           decoration: TextDecoration.underline,
//                           color: AppColors.lightblue,
//                           decorationColor: AppColors.lightblue,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//
//                 SizedBox(height: h * 0.04),
//
//                 Center(
//                   child: RoundButton(
//                     text: 'Sign In',
//                     onTap: () {
//                       Get.to(MainScreen());
//                     },
//                   ),
//                 ),
//
//                 SizedBox(height: h * 0.02),
//                 SocialSignupSection2(),
//               ],
//             ),
//           ),
//         ),
//       ),
//
//     );
//   }
// }
//
// class SocialSignupSection2 extends StatelessWidget {
//   const SocialSignupSection2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         /// 🔥 OR Divider
//         Row(
//           children: [
//             Expanded(
//               child: Container(height: 1, color: Colors.white.withValues(alpha:0.2)),
//             ),
//             const Padding(
//               padding: EdgeInsets.symmetric(horizontal: 10),
//               child: Text(
//                 "OR",
//                 style: TextStyle(color: Colors.white70, fontSize: 12),
//               ),
//             ),
//             Expanded(
//               child: Container(height: 1, color: Colors.white.withValues(alpha:0.2)),
//             ),
//           ],
//         ),
//
//         const SizedBox(height: 20),
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _socialButton(icon: "assets/images/google.png", onTap: () {}),
//             const SizedBox(width: 20),
//             _socialButton(icon: "assets/images/apple.png", onTap: () {}),
//           ],
//         ),
//
//         const SizedBox(height: 50,),
//
//         /// 🔥 Bottom Text (UPDATED)
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Don’t have an account? ",
//               style: GoogleFonts.inter(
//                   color: AppColors.grey2,
//                   fontSize: 16,fontWeight: FontWeight.w500
//               ),
//             ),
//
//             Material(
//               color: Colors.transparent,
//               child: InkWell(
//                 onTap: () {
//                   Get.to(SignUp());
//                 },
//                 borderRadius: BorderRadius.circular(4),
//                 child: Padding(
//                   padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
//                   child: Text(
//                     "Sign Up",
//                     style: GoogleFonts.inter(
//                       decorationColor: AppColors.lightblue,
//                       color:AppColors.lightblue,
//                       fontSize: 16,
//                       fontWeight: FontWeight.w700,
//                       decoration: TextDecoration.underline,
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
//
//   Widget _socialButton({required String icon, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: 55,
//         width: 55,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Colors.white.withValues(alpha:0.2)),
//         ),
//         child: Center(child: Image.asset(icon, height: 24, width: 24)),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/auth_screen/sign_up.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/bottom_bar.dart';
import 'package:highlights/basic_files/buttons.dart';
import 'package:highlights/basic_files/check_box.dart';
import 'package:highlights/basic_files/text_fields.dart';
import 'package:highlights/presentation_screen/ForgetPasswordScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
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
            horizontal: w * 0.055,
            vertical:h * 0.012,
          ),
          child: Form(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                  'Log In',
                  style: MainTextStyles.inter(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: Theme.of(context).canvasColor, // Changed to Theme
                  ),
                ),

                SizedBox(height: h * 0.005),

                Text(
                  'Capture the pulse of your spontaneity.',
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

                PasswordTextField(
                  hintText: 'Password...',
                  controller: passwordController,
                ),

                SizedBox(height: h * 0.02),

                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                    Text(
                      'Remember Me',
                      style: GoogleFonts.inter(
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                        decoration: TextDecoration.underline,
                        color: Theme.of(context).primaryColor, // Changed to Theme
                        decorationColor: Theme.of(context).primaryColor, // Changed to Theme
                      ),
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: (){
                        Get.to(Forgetpasswordscreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        );
                      },
                      child: Text(
                        'Forget Password',
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: 13,
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor, // Changed to Theme
                          decorationColor: Theme.of(context).primaryColor, // Changed to Theme
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: h * 0.04),

                Center(
                  child: RoundButton(
                    text: 'Sign In',
                    onTap: () {
                      Get.to(MainScreen());
                    },
                  ),
                ),

                SizedBox(height: h * 0.02),
                SocialSignupSection2(),
              ],
            ),
          ),
        ),
      ),

    );
  }
}

class SocialSignupSection2 extends StatelessWidget {
  const SocialSignupSection2({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        /// 🔥 OR Divider
        Row(
          children: [
            Expanded(
              child: Container(height: 1, color: Theme.of(context).canvasColor.withOpacity(0.2)), // Changed
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text(
                "OR",
                style: TextStyle(color: Theme.of(context).canvasColor.withOpacity(0.7), fontSize: 12), // Changed
              ),
            ),
            Expanded(
              child: Container(height: 1, color: Theme.of(context).canvasColor.withOpacity(0.2)), // Changed
            ),
          ],
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _socialButton(context, icon: "assets/images/google.png", onTap: () {}),
            const SizedBox(width: 20),
            _socialButton(context, icon: "assets/images/apple.png", onTap: () {}),
          ],
        ),

        const SizedBox(height: 50,),

        /// 🔥 Bottom Text (UPDATED)
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don’t have an account? ",
              style: GoogleFonts.inter(
                  color: const Color(0xFF767575),
                  fontSize: 16,fontWeight: FontWeight.w500
              ),
            ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.to(SignUp());
                },
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.inter(
                      decorationColor: Theme.of(context).primaryColor, // Changed
                      color: Theme.of(context).primaryColor, // Changed
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _socialButton(BuildContext context, {required String icon, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 55,
        width: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Theme.of(context).canvasColor.withOpacity(0.2)), // Changed
        ),
        child: Center(child: Image.asset(icon, height: 24, width: 24)),
      ),
    );
  }
}
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
//     // --- MEDIA QUERY VARIABLES ---
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SingleChildScrollView(
//         child: SafeArea(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: w * 0.05,
//               vertical: h * 0.012,
//             ),
//             child: Form(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Center(
//                     child: Image.asset(
//                       'assets/images/logo.png',
//                       height: h * 0.125, // Responsive Height
//                       width: w * 0.5,    // Responsive Width
//                       fit: BoxFit.contain,
//                       color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,
//                     ),
//                   ),
//
//                   SizedBox(height: h * 0.05),
//
//                   Text(
//                     'Log In',
//                     style: MainTextStyles.inter(
//                       fontSize: h * 0.0325, // Responsive Font Size
//                       fontWeight: FontWeight.w700,
//                       color: Theme.of(context).canvasColor,
//                     ),
//                   ),
//
//                   SizedBox(height: h * 0.005),
//
//                   Text(
//                     'Capture the pulse of your spontaneity.',
//                     style: MainTextStyles.inter(
//                       fontSize: h * 0.016, // Responsive Font Size
//                       fontWeight: FontWeight.w400,
//                       color: const Color(0xFF767575),
//                     ),
//                   ),
//
//                   SizedBox(height: h * 0.02),
//
//                   RoundTextField(
//                     hintText: 'Username...',
//                     controller: usernameController,
//                   ),
//
//                   SizedBox(height: h * 0.01),
//
//                   PasswordTextField(
//                     hintText: 'Password...',
//                     controller: passwordController,
//                   ),
//
//                   SizedBox(height: h * 0.02),
//
//                   Row(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       CircularCheckbox(
//                         initialValue: rememberMe,
//                         onChanged: (val) {
//                           setState(() {
//                             rememberMe = val;
//                           });
//                         },
//                       ),
//                       SizedBox(width: w * 0.02),
//                       Text(
//                         'Remember Me',
//                         style: GoogleFonts.inter(
//                           fontWeight: FontWeight.w700,
//                           fontSize: h * 0.016, // Responsive Font Size
//                           decoration: TextDecoration.underline,
//                           color: Theme.of(context).primaryColor,
//                           decorationColor: Theme.of(context).primaryColor,
//                         ),
//                       ),
//                       const Spacer(),
//                       GestureDetector(
//                         onTap: (){
//                           Get.to(Forgetpasswordscreen(),
//                             transition: Transition.noTransition,
//                             duration: Duration.zero,
//                           );
//                         },
//                         child: Text(
//                           'Forget Password',
//                           style: GoogleFonts.inter(
//                             fontWeight: FontWeight.w700,
//                             fontSize: h * 0.016, // Responsive Font Size
//                             decoration: TextDecoration.underline,
//                             color: Theme.of(context).primaryColor,
//                             decorationColor: Theme.of(context).primaryColor,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//
//                   SizedBox(height: h * 0.04),
//
//                   Center(
//                     child: RoundButton(
//                       text: 'Sign In',
//                       onTap: () {
//                         Get.to(MainScreen());
//                       },
//                     ),
//                   ),
//
//                   SizedBox(height: h * 0.02),
//                   const SocialSignupSection2(),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class SocialSignupSection2 extends StatelessWidget {
//   const SocialSignupSection2({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     // --- MEDIA QUERY VARIABLES FOR SOCIAL SECTION ---
//     double h = MediaQuery.of(context).size.height;
//     double w = MediaQuery.of(context).size.width;
//
//     return Column(
//       children: [
//         /// 🔥 OR Divider
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
//
//         SizedBox(height: h * 0.025), // Responsive Spacer
//
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             _socialButton(context, icon: "assets/images/google.png", h: h, w: w, onTap: () {}),
//             SizedBox(width: w * 0.055), // Responsive Spacer
//             _socialButton(context, icon: "assets/images/apple.png", h: h, w: w, onTap: () {}),
//           ],
//         ),
//
//         SizedBox(height: h * 0.06), // Responsive Spacer
//
//         /// 🔥 Bottom Text (UPDATED)
//         Row(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               "Don’t have an account? ",
//               style: GoogleFonts.inter(
//                   color: const Color(0xFF767575),
//                   fontSize: h * 0.02, // Responsive Font Size
//                   fontWeight: FontWeight.w500
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
//                   padding: EdgeInsets.symmetric(horizontal: w * 0.01, vertical: h * 0.0025), // Responsive Padding
//                   child: Text(
//                     "Sign Up",
//                     style: GoogleFonts.inter(
//                       decorationColor: Theme.of(context).primaryColor,
//                       color: Theme.of(context).primaryColor,
//                       fontSize: h * 0.02, // Responsive Font Size
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
//   Widget _socialButton(BuildContext context, {required String icon, platform, required double h, required double w, required VoidCallback onTap}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: h * 0.068, // Responsive Button Height
//         width: h * 0.068,  // Aspect ratio 1:1 barkarar rakhne ke liye 'h' ka use kiya hai
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           image: DecorationImage(
//             image: AssetImage("assets/images/Socialbackground.png"),
//           ),
//           //border: Border.all(color: Theme.of(context).canvasColor.withOpacity(0.2)),
//         ),
//         child: Center(
//           child: Image.asset(
//             icon,
//             height: h * 0.03, // Responsive Icon Height
//             width: h * 0.03,  // Responsive Icon Width
//           ),
//         ),
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

import '../Contollers/auth_controller.dart';
import '../widgets/custom_loader.dart';

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

  // Controller yahan initialize kiya gaya hai
  final AuthController authController = Get.put(AuthController());

  @override
  Widget build(BuildContext context) {
    // --- MEDIA QUERY VARIABLES ---
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * 0.05,
              vertical: h * 0.012,
            ),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
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

                  SizedBox(height: h * 0.05),

                  Text(
                    'Log In',
                    style: MainTextStyles.inter(
                      fontSize: h * 0.0325,
                      fontWeight: FontWeight.w700,
                      color: Theme.of(context).canvasColor,
                    ),
                  ),

                  SizedBox(height: h * 0.005),

                  Text(
                    'Capture the pulse of your spontaneity.',
                    style: MainTextStyles.inter(
                      fontSize: h * 0.016,
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF767575),
                    ),
                  ),

                  SizedBox(height: h * 0.02),

                  // Obx aur errorText add kiya gaya hai
                  Obx(() => RoundTextField(
                    hintText: 'Email',
                    controller: usernameController,
                    errorText: authController.loginEmailError.value,
                  )),

                  SizedBox(height: h * 0.01),

                  // Obx aur errorText add kiya gaya hai
                  Obx(() => PasswordTextField(
                    hintText: 'Password',
                    controller: passwordController,
                    errorText: authController.loginPasswordError.value,
                  )),

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
                          fontSize: h * 0.016,
                          decoration: TextDecoration.underline,
                          color: Theme.of(context).primaryColor,
                          decorationColor: Theme.of(context).primaryColor,
                        ),
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: (){
                          Get.to(() => Forgetpasswordscreen(),
                            transition: Transition.noTransition,
                            duration: Duration.zero,
                          );
                        },
                        child: Text(
                          'Forget Password',
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.w700,
                            fontSize: h * 0.016,
                            decoration: TextDecoration.underline,
                            color: Theme.of(context).primaryColor,
                            decorationColor: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * 0.04),

                  // Button par API Integration aur Loading indicator
                  Center(
                    child: Obx(()=>
                        RoundButton(
                        text: 'Sign In',
                        isLoading: authController.isLoading.value,
                        showArrow: true,
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        authController.validateAndLogin(
                          email: usernameController.text,
                          password: passwordController.text,
                        );
                      },
                    ),
                    ),
                  ),

                  SizedBox(height: h * 0.02),
                  const SocialSignupSection2(),
                ],
              ),
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
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

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
            _socialButton(context, icon: "assets/images/google.png", h: h, w: w, onTap: () {}),
            SizedBox(width: w * 0.055),
            _socialButton(context, icon: "assets/images/apple.png", h: h, w: w, onTap: () {}),
          ],
        ),

        SizedBox(height: h * 0.06),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Don’t have an account? ",
              style: GoogleFonts.inter(
                  color: const Color(0xFF767575),
                  fontSize: h * 0.02,
                  fontWeight: FontWeight.w500
              ),
            ),

            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Get.to(() => SignUp());
                },
                borderRadius: BorderRadius.circular(4),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * 0.01, vertical: h * 0.0025),
                  child: Text(
                    "Sign Up",
                    style: GoogleFonts.inter(
                      decorationColor: Theme.of(context).primaryColor,
                      color: Theme.of(context).primaryColor,
                      fontSize: h * 0.02,
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

  Widget _socialButton(BuildContext context, {required String icon, platform, required double h, required double w, required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
            height: h * 0.03,
            width: h * 0.03,
          ),
        ),
      ),
    );
  }
}
// // import 'package:flutter/material.dart';
// // import 'package:get/get.dart';
// // import 'package:highlights/presentation_screen/VerifyScreen.dart';
// // import 'package:highlights/widgets/Backbutton.dart';
// // import 'package:highlights/widgets/ElevatedButton.dart';
// //
// // class Forgetpasswordscreen extends StatefulWidget {
// //   const Forgetpasswordscreen({super.key});
// //
// //   @override
// //   State<Forgetpasswordscreen> createState() => _ForgetpasswordscreenState();
// // }
// //
// // class _ForgetpasswordscreenState extends State<Forgetpasswordscreen> {
// //   final TextEditingController _emailController = TextEditingController();
// //
// //   @override
// //   void dispose() {
// //     _emailController.dispose();
// //     super.dispose();
// //   }
// //
// //   @override
// //   Widget build(BuildContext context) {
// //     final size = MediaQuery.of(context).size;
// //
// //     return Scaffold(
// //       backgroundColor: const Color(0xff0F1012),
// //       body: SafeArea(
// //         child: SingleChildScrollView(
// //           padding: EdgeInsets.symmetric(
// //             horizontal: size.width * 0.055,
// //             vertical: size.height * 0.012,
// //           ),
// //           child: Column(
// //             crossAxisAlignment: CrossAxisAlignment.start,
// //             children: [
// //               SizedBox(height: size.height * 0.01),
// //
// //               const CustomBackButtonWidget(),
// //
// //               SizedBox(height: size.height * 0.07),
// //
// //               Center(
// //                 child: Image(image: AssetImage("assets/images/Vector.png"),height: size.height*0.2,width: double.infinity,),
// //               ),
// //
// //               SizedBox(height: size.height * 0.06),
// //
// //               Text(
// //                 "Verify Your Identity",
// //                 style: TextStyle(
// //                   color: Colors.white,
// //                   fontSize: size.width * 0.068,
// //                   fontWeight: FontWeight.w800,
// //                   height: 1.1,
// //                 ),
// //               ),
// //
// //               SizedBox(height: size.height * 0.01),
// //
// //               Text(
// //                 "Enter email to find your account",
// //                 style: TextStyle(
// //                   color: Colors.white60,
// //                   fontSize: size.width * 0.033,
// //                   fontWeight: FontWeight.w400,
// //                 ),
// //               ),
// //
// //               SizedBox(height: size.height * 0.025),
// //
// //               _buildEmailField(size),
// //
// //               SizedBox(height: size.height * 0.03),
// //               ElevatedButton1(text: "Send Reset Link", onPressed: (){
// //                 Get.to(Verifyscreen());
// //               }),
// //               SizedBox(height: size.height * 0.03),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// //
// //   Widget _buildEmailField(Size size) {
// //     return Container(
// //       width: double.infinity,
// //       height: size.height * 0.058,
// //       alignment: Alignment.center, // ⭐ IMPORTANT
// //       decoration: BoxDecoration(
// //         color: const Color(0xff262626),
// //         borderRadius: BorderRadius.circular(size.width * 0.06),
// //       ),
// //       child: TextField(
// //         controller: _emailController,
// //         keyboardType: TextInputType.emailAddress,
// //         textAlignVertical: TextAlignVertical.center, // ⭐ IMPORTANT
// //         style: TextStyle(
// //           color: Colors.white,
// //           fontSize: size.width * 0.035,
// //           fontWeight: FontWeight.w500,
// //         ),
// //         cursorColor: const Color(0xff62AFC1),
// //         decoration: InputDecoration(
// //           hintText: "Email Address",
// //           hintStyle: TextStyle(
// //             color: Colors.white38,
// //             fontSize: size.width * 0.035,
// //             fontWeight: FontWeight.w400,
// //           ),
// //           border: InputBorder.none,
// //           isDense: true,
// //           contentPadding: EdgeInsets.symmetric(
// //             horizontal: size.width * 0.05,
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/VerifyScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/ElevatedButton.dart';
//
// class Forgetpasswordscreen extends StatefulWidget {
//   const Forgetpasswordscreen({super.key});
//
//   @override
//   State<Forgetpasswordscreen> createState() => _ForgetpasswordscreenState();
// }
//
// class _ForgetpasswordscreenState extends State<Forgetpasswordscreen> {
//   final TextEditingController _emailController = TextEditingController();
//
//   @override
//   void dispose() {
//     _emailController.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     // Theme references
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color cardBgColor = Theme.of(context).cardColor;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Adaptive BG
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.055,
//             vertical: size.height * 0.012,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: size.height * 0.01),
//
//               const CustomBackButtonWidget(),
//
//               SizedBox(height: size.height * 0.07),
//
//               Center(
//                 child: Image(
//                   image: const AssetImage("assets/images/Vector.png"),
//                   height: size.height * 0.2,
//                   width: double.infinity,
//                   // Image color adjustment for light theme visibility
//                   color: Theme.of(context).brightness == Brightness.light
//                       ? primaryColor
//                       : null,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.06),
//
//               Text(
//                 "Verify Your Identity",
//                 style: TextStyle(
//                   color: textColor, // Adaptive Text
//                   fontSize: size.width * 0.068,
//                   fontWeight: FontWeight.w800,
//                   height: 1.1,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               Text(
//                 "Enter email to find your account",
//                 style: TextStyle(
//                   color: textColor.withOpacity(0.6), // Adaptive Subtitle
//                   fontSize: size.width * 0.033,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.025),
//
//               _buildEmailField(size, cardBgColor, textColor, primaryColor),
//
//               SizedBox(height: size.height * 0.03),
//               ElevatedButton1(
//                 text: "Send Reset Link",
//                 onPressed: () {
//                   Get.to(const Verifyscreen());
//                 },
//               ),
//               SizedBox(height: size.height * 0.03),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildEmailField(Size size, Color cardBg, Color textC, Color primary) {
//     return Container(
//       width: double.infinity,
//       height: size.height * 0.058,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: cardBg, // Adaptive Field BG
//         borderRadius: BorderRadius.circular(size.width * 0.06),
//       ),
//       child: TextField(
//         controller: _emailController,
//         keyboardType: TextInputType.emailAddress,
//         textAlignVertical: TextAlignVertical.center,
//         style: TextStyle(
//           color: textC, // Adaptive Input Text
//           fontSize: size.width * 0.035,
//           fontWeight: FontWeight.w500,
//         ),
//         cursorColor: primary, // Adaptive Cursor
//         decoration: InputDecoration(
//           hintText: "Email Address",
//           hintStyle: TextStyle(
//             color: textC.withOpacity(0.4), // Adaptive Hint
//             fontSize: size.width * 0.035,
//             fontWeight: FontWeight.w400,
//           ),
//           border: InputBorder.none,
//           isDense: true,
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.05,
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/buttons.dart';
import 'package:highlights/presentation_screen/VerifyScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/ElevatedButton.dart';
import '../Contollers/auth_controller.dart';
import '../basic_files/text_fields.dart';
import '../widgets/custom_loader.dart';

class Forgetpasswordscreen extends StatefulWidget {
  const Forgetpasswordscreen({super.key});

  @override
  State<Forgetpasswordscreen> createState() => _ForgetpasswordscreenState();
}

class _ForgetpasswordscreenState extends State<Forgetpasswordscreen> {
  final TextEditingController _emailController = TextEditingController();
  final AuthController authController = Get.find<AuthController>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * (20.625 / 375), // 0.055 scaled ratio
            vertical: h * (9.72 / 810),    // 0.012 scaled ratio
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * (8.1 / 810)),

              const CustomBackButtonWidget(),

              SizedBox(height: h * (56.7 / 810)),

              Center(
                child: Image(
                  image: const AssetImage("assets/images/Vector.png"),
                  height: h * (162.0 / 810), // Evaluated size.height * 0.2 conversion
                  width: double.infinity,
                  color: Theme.of(context).brightness == Brightness.light
                      ? primaryColor
                      : null,
                ),
              ),

              SizedBox(height: h * (48.6 / 810)),

              Text(
                "Verify Your Identity",
                style: TextStyle(
                  color: textColor,
                  fontSize: w * (25.5 / 375), // Mapped from size.width * 0.068
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: h * (8.1 / 810)),

              Text(
                "Enter email to find your account",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: w * (12.375 / 375), // Mapped from size.width * 0.033
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: h * (20.25 / 810)),

              Obx(() => EmailTextField(
                hintText: "Email Address",
                controller: _emailController,
                errorText: authController.emailError.value,
              )),

              SizedBox(height: h * (24.3 / 810)),

              Obx(() => RoundButton(
                text: 'Send Reset Link',
                isLoading: authController.isLoading.value,
                showArrow: false,
                onTap: () {
                  FocusScope.of(context).unfocus();
                  authController.sendResetLink(email: _emailController.text);
                },
              )),

              SizedBox(height: h * (24.3 / 810)),
            ],
          ),
        ),
      ),
    );
  }
}
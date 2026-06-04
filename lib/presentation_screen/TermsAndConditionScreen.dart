// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/auth_screen/sign_up.dart';
// import 'package:highlights/presentation_screen/ForgetPasswordScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
//
// class TermsandConditionscreen extends StatefulWidget {
//   const TermsandConditionscreen({super.key});
//
//   @override
//   State<TermsandConditionscreen> createState() =>
//       _TermsandConditionscreenState();
// }
//
// class _TermsandConditionscreenState extends State<TermsandConditionscreen> {
//   bool isAccepted = false;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color(0xff0F1012),
//       body: SafeArea(
//         child: Column(
//           children: [
//             Expanded(
//               child: SingleChildScrollView(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: size.width * 0.055,
//                   vertical: size.height * 0.012,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     SizedBox(height: size.height * 0.01),
//
//                     const CustomBackButtonWidget(),
//
//                     SizedBox(height: size.height * 0.035),
//
//                     Text(
//                       "Terms & Conditions",
//                       style: TextStyle(
//                         color: Colors.white,
//                         fontSize: size.width * 0.065,
//                         fontWeight: FontWeight.w800,
//                         height: 1.1,
//                       ),
//                     ),
//
//                     SizedBox(height: size.height * 0.007),
//
//                     Text(
//                       "Understand the rules for using our platform",
//                       style: TextStyle(
//                         color: Colors.white60,
//                         fontSize: size.width * 0.036,
//                         fontWeight: FontWeight.w400,
//                       ),
//                     ),
//
//                     SizedBox(height: size.height * 0.035),
//
//                     _buildBodyText(
//                       size: size,
//                       text:
//                       "By accessing or using this application, you agree to comply with and be bound by these Terms & Conditions. If you do not agree, please refrain from using the service.",
//                     ),
//
//                     SizedBox(height: size.height * 0.025),
//
//                     _buildBodyText(
//                       size: size,
//                       text:
//                       "This platform allows users to share personal moments through photos and videos within a defined posting window. Content may only be uploaded between Monday 12:00 AM and Thursday 11:59 PM.\nAfter this period, all submitted content becomes automatically restricted and no longer publicly accessible.",
//                     ),
//
//                     SizedBox(height: size.height * 0.025),
//
//                     _buildBodyText(
//                       size: size,
//                       text:
//                       "You retain ownership of all content you upload. However, by posting, you grant the platform a limited license to host, display, and process your content solely for providing the service.",
//                     ),
//
//                     SizedBox(height: size.height * 0.035),
//
//                     _buildSectionTitle(
//                       size: size,
//                       title: "Account & Security",
//                     ),
//
//                     SizedBox(height: size.height * 0.01),
//
//                     _buildBodyText(
//                       size: size,
//                       text:
//                       "Users are responsible for maintaining the confidentiality of their account credentials and for all activities that occur under their account.",
//                     ),
//
//                     SizedBox(height: size.height * 0.03),
//
//                     _buildSectionTitle(
//                       size: size,
//                       title: "Restrictions & Enforcement",
//                     ),
//
//                     SizedBox(height: size.height * 0.01),
//
//                     _buildBodyText(
//                       size: size,
//                       text: "We reserve the right to:",
//                     ),
//
//                     SizedBox(height: size.height * 0.007),
//
//                     _buildBulletText(
//                       size: size,
//                       text: "Remove content that violates these terms",
//                     ),
//                     _buildBulletText(
//                       size: size,
//                       text: "Restrict or suspend accounts involved in misuse",
//                     ),
//                     _buildBulletText(
//                       size: size,
//                       text: "Take necessary action to maintain a safe environment",
//                     ),
//
//                     SizedBox(height: size.height * 0.03),
//
//                     _buildAgreementRow(size),
//
//                     SizedBox(height: size.height * 0.03),
//                   ],
//                 ),
//               ),
//             ),
//
//             /// Fixed Bottom Button Area
//             Container(
//               width: double.infinity,
//               color: const Color(0xff0F1012),
//               padding: EdgeInsets.only(
//                 left: size.width * 0.055,
//                 right: size.width * 0.055,
//                 top: size.height * 0.01,
//                 bottom: size.height * 0.025,
//               ),
//               child: _buildAcceptButton(size),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSectionTitle({
//     required Size size,
//     required String title,
//   }) {
//     return Text(
//       title,
//       style: TextStyle(
//         color: Colors.white,
//         fontSize: size.width * 0.042,
//         fontWeight: FontWeight.w500,
//         height: 1.2,
//       ),
//     );
//   }
//
//   Widget _buildBodyText({
//     required Size size,
//     required String text,
//   }) {
//     return Text(
//       text,
//       style: TextStyle(
//         color: Colors.white38,
//         fontSize: size.width * 0.0325,
//         fontWeight: FontWeight.w400,
//         height: 1.2,
//       ),
//     );
//   }
//
//   Widget _buildBulletText({
//     required Size size,
//     required String text,
//   }) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.only(
//             top: size.height * 0.001,
//             right: size.width * 0.025,
//           ),
//           child: Text(
//             "•",
//             style: TextStyle(
//               color: Colors.white38,
//               fontSize: size.width * 0.05,
//               fontWeight: FontWeight.w400,
//               height: 1,
//             ),
//           ),
//         ),
//         Expanded(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: Colors.white38,
//               fontSize: size.width * 0.0325,
//               fontWeight: FontWeight.w400,
//               height: 1.15,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAgreementRow(Size size) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         GestureDetector(
//           onTap: () {
//             setState(() {
//               isAccepted = !isAccepted;
//             });
//           },
//           child: AnimatedContainer(
//             duration: const Duration(milliseconds: 180),
//             height: size.width * 0.06,
//             width: size.width * 0.06,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               color: isAccepted
//                   ? const Color(0xff4F98A7)
//                   : Colors.transparent,
//               border: Border.all(
//                 color: isAccepted
//                     ? const Color(0xff4F98A7)
//                     : Colors.white38,
//                 width: size.width * 0.003,
//               ),
//             ),
//             child: isAccepted
//                 ? Icon(
//               Icons.check,
//               color: Colors.white,
//               size: size.width * 0.04,
//             )
//                 : null,
//           ),
//         ),
//         SizedBox(width: size.width * 0.025),
//         Expanded(
//           child: Padding(
//             padding: EdgeInsets.only(top: size.height * 0.002),
//             child: RichText(
//               text: TextSpan(
//                 style: TextStyle(
//                   color: Colors.white54,
//                   fontSize: size.width * 0.029,
//                   fontWeight: FontWeight.w400,
//                   height: 1.4,
//                 ),
//                 children: const [
//                   TextSpan(text: "I agree with all "),
//                   TextSpan(
//                     text: "Terms & Conditions",
//                     style: TextStyle(
//                       color: Color(0xff4F98A7),
//                       decoration: TextDecoration.underline,
//                       decorationColor: Color(0xff4F98A7),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                   TextSpan(text: " and "),
//                   TextSpan(
//                     text: "Privacy Policy",
//                     style: TextStyle(
//                       color: Color(0xff4F98A7),
//                       decoration: TextDecoration.underline,
//                       decorationColor: Color(0xff4F98A7),
//                       fontWeight: FontWeight.w600,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildAcceptButton(Size size) {
//     return GestureDetector(
//       onTap: isAccepted
//           ? () {
//         Get.back();
//       }
//           : null,
//       child: AnimatedContainer(
//         duration: const Duration(milliseconds: 180),
//         width: double.infinity,
//         height: size.height * 0.058,
//         decoration: BoxDecoration(
//           color: isAccepted
//               ? const Color(0xff62AFC1)
//               : const Color(0xff62AFC1).withOpacity(0.35),
//           borderRadius: BorderRadius.circular(size.width * 0.09),
//           boxShadow: isAccepted
//               ? [
//             BoxShadow(
//               color: const Color(0xff62AFC1).withOpacity(0.35),
//               blurRadius: size.width * 0.04,
//               spreadRadius: 1,
//             ),
//           ]
//               : [],
//         ),
//         child: Center(
//           child: Text(
//             "Accept & Continue",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: size.width * 0.05,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/widgets/Backbutton.dart';

class TermsandConditionscreen extends StatefulWidget {
  const TermsandConditionscreen({super.key});

  @override
  State<TermsandConditionscreen> createState() =>
      _TermsandConditionscreenState();
}

class _TermsandConditionscreenState extends State<TermsandConditionscreen> {
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: size.width * 0.055,
                  vertical: size.height * 0.012,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: size.height * 0.01),

                    const CustomBackButtonWidget(),

                    SizedBox(height: size.height * 0.035),

                    Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: textColor,
                        fontSize: size.width * 0.065,
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),

                    SizedBox(height: size.height * 0.007),

                    Text(
                      "Understand the rules for using our platform",
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: size.width * 0.036,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: size.height * 0.035),

                    _buildBodyText(
                      size: size,
                      textColor: textColor,
                      text:
                      "By accessing or using this application, you agree to comply with and be bound by these Terms & Conditions. If you do not agree, please refrain from using the service.",
                    ),

                    SizedBox(height: size.height * 0.025),

                    _buildBodyText(
                      size: size,
                      textColor: textColor,
                      text:
                      "This platform allows users to share personal moments through photos and videos within a defined posting window. Content may only be uploaded between Monday 12:00 AM and Thursday 11:59 PM.\nAfter this period, all submitted content becomes automatically restricted and no longer publicly accessible.",
                    ),

                    SizedBox(height: size.height * 0.025),

                    _buildBodyText(
                      size: size,
                      textColor: textColor,
                      text:
                      "You retain ownership of all content you upload. However, by posting, you grant the platform a limited license to host, display, and process your content solely for providing the service.",
                    ),

                    SizedBox(height: size.height * 0.035),

                    _buildSectionTitle(
                      size: size,
                      textColor: textColor,
                      title: "Account & Security",
                    ),

                    SizedBox(height: size.height * 0.01),

                    _buildBodyText(
                      size: size,
                      textColor: textColor,
                      text:
                      "Users are responsible for maintaining the confidentiality of their account credentials and for all activities that occur under their account.",
                    ),

                    SizedBox(height: size.height * 0.03),

                    _buildSectionTitle(
                      size: size,
                      textColor: textColor,
                      title: "Restrictions & Enforcement",
                    ),

                    SizedBox(height: size.height * 0.01),

                    _buildBodyText(
                      size: size,
                      textColor: textColor,
                      text: "We reserve the right to:",
                    ),

                    SizedBox(height: size.height * 0.007),

                    _buildBulletText(
                      size: size,
                      textColor: textColor,
                      text: "Remove content that violates these terms",
                    ),
                    _buildBulletText(
                      size: size,
                      textColor: textColor,
                      text: "Restrict or suspend accounts involved in misuse",
                    ),
                    _buildBulletText(
                      size: size,
                      textColor: textColor,
                      text: "Take necessary action to maintain a safe environment",
                    ),

                    SizedBox(height: size.height * 0.03),

                    _buildAgreementRow(size, textColor, primaryColor),

                    SizedBox(height: size.height * 0.03),
                  ],
                ),
              ),
            ),

            /// Fixed Bottom Button Area
            Container(
              width: double.infinity,
              color: bgColor,
              padding: EdgeInsets.only(
                left: size.width * 0.055,
                right: size.width * 0.055,
                top: size.height * 0.01,
                bottom: size.height * 0.025,
              ),
              child: _buildAcceptButton(size, primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    required Size size,
    required String title,
    required Color textColor,
  }) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: size.width * 0.042,
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    );
  }

  Widget _buildBodyText({
    required Size size,
    required String text,
    required Color textColor,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: textColor.withOpacity(0.5),
        fontSize: size.width * 0.0325,
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
    );
  }

  Widget _buildBulletText({
    required Size size,
    required String text,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: size.height * 0.001,
            right: size.width * 0.025,
          ),
          child: Text(
            "•",
            style: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: size.width * 0.0325,
              fontWeight: FontWeight.w400,
              height: 1.15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgreementRow(Size size, Color textColor, Color primaryColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isAccepted = !isAccepted;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: size.width * 0.06,
            width: size.width * 0.06,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAccepted
                  ? primaryColor
                  : Colors.transparent,
              border: Border.all(
                color: isAccepted
                    ? primaryColor
                    : textColor.withOpacity(0.38),
                width: size.width * 0.003,
              ),
            ),
            child: isAccepted
                ? Icon(
              Icons.check,
              color: Colors.white,
              size: size.width * 0.04,
            )
                : null,
          ),
        ),
        SizedBox(width: size.width * 0.025),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: size.height * 0.002),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: textColor.withOpacity(0.54),
                  fontSize: size.width * 0.029,
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: "I agree with all "),
                  TextSpan(
                    text: "Terms & Conditions",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptButton(Size size, Color primaryColor) {
    return GestureDetector(
      onTap: isAccepted ? () => Get.back() : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        height: size.height * 0.058,
        decoration: BoxDecoration(
          color: isAccepted
              ? primaryColor
              : primaryColor.withOpacity(0.35),
          borderRadius: BorderRadius.circular(size.width * 0.09),
          boxShadow: isAccepted
              ? [
            BoxShadow(
              color: primaryColor.withOpacity(0.35),
              blurRadius: size.width * 0.04,
              spreadRadius: 1,
            ),
          ]
              : [],
        ),
        child: Center(
          child: Text(
            "Accept & Continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
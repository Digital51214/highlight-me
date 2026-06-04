// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/NotificationScreen.dart';
// import 'package:highlights/presentation_screen/PrivacyPolicyScreen.dart';
// import 'package:highlights/presentation_screen/TermsAndConditionScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/ElevatedButton.dart';
//
//
// class HelpandSupportscreen extends StatefulWidget {
//   const HelpandSupportscreen({super.key});
//
//   @override
//   State<HelpandSupportscreen> createState() => _HelpandSupportscreenState();
// }
//
// class _HelpandSupportscreenState extends State<HelpandSupportscreen> {
//   final TextEditingController _messageController = TextEditingController();
//
//   @override
//   void dispose() {
//     _messageController.dispose();
//     super.dispose();
//   }
//
//   bool get _isSendEnabled => _messageController.text.trim().isNotEmpty;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color(0xff0F1012),
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
//               SizedBox(height: size.height * 0.03),
//
//               Text(
//                 "Help & Support",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: size.width * 0.065,
//                   fontWeight: FontWeight.w800,
//                   height: 1.1,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.007),
//
//               Text(
//                 "Find support when you need it",
//                 style: TextStyle(
//                   color: Colors.white60,
//                   fontSize: size.width * 0.031,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.035),
//
//               _buildSupportBox(size),
//
//               SizedBox(height: size.height * 0.04),
//
//               ElevatedButton1(text: "Send", onPressed: (){
//                 Get.back();
//               }),
//
//               SizedBox(height: size.height * 0.14),
//
//               _buildFooterBranding(size),
//
//               SizedBox(height: size.height * 0.025),
//
//               Center(
//                 child: GestureDetector(
//                   onTap: () {
//                   Get.to(PrivacyPolicyscreen());
//                   },
//                   child: Text(
//                     "Privacy Ploicy",
//                     style: TextStyle(
//                       color: const Color(0xff4F98A7),
//                       fontSize: size.width * 0.042,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.018),
//
//               Center(
//                 child: GestureDetector(
//                   onTap: () {
//                     Get.to(TermsandConditionscreen());
//                   },
//                   child: Text(
//                     "Terms & Conditions",
//                     style: TextStyle(
//                       color: const Color(0xff4F98A7),
//                       fontSize: size.width * 0.042,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.03),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSupportBox(Size size) {
//     return Container(
//       width: double.infinity,
//       height: size.height * 0.18,
//       decoration: BoxDecoration(
//         color: const Color(0xff262626),
//         borderRadius: BorderRadius.circular(size.width * 0.07),
//       ),
//       child: Stack(
//         children: [
//           TextField(
//             controller: _messageController,
//             maxLength: 90,
//             maxLines: null,
//             onChanged: (value) {
//               setState(() {});
//             },
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: size.width * 0.035,
//               fontWeight: FontWeight.w500,
//             ),
//             cursorColor: const Color(0xff62AFC1),
//             decoration: InputDecoration(
//               counterText: "",
//               hintText: "Try asking: How can i.....",
//               hintStyle: TextStyle(
//                 color: Colors.white38,
//                 fontSize: size.width * 0.035,
//                 fontWeight: FontWeight.w400,
//               ),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.only(
//                 left: size.width * 0.14,
//                 right: size.width * 0.06,
//                 top: size.height * 0.017,
//                 bottom: size.height * 0.045,
//               ),
//             ),
//           ),
//
//           Positioned(
//             top: size.height * 0.018,
//             left: size.width * 0.04,
//             child: Icon(
//               Icons.search_rounded,
//               color: Colors.white70,
//               size: size.width * 0.065,
//             ),
//           ),
//
//           Positioned(
//             right: size.width * 0.05,
//             bottom: size.height * 0.018,
//             child: Text(
//               "${_messageController.text.length}/90",
//               style: TextStyle(
//                 color: Colors.white38,
//                 fontSize: size.width * 0.035,
//                 fontWeight: FontWeight.w400,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSendButton(Size size) {
//     return GestureDetector(
//       onTap: _isSendEnabled
//           ? () {
//         // Send support message logic
//       }
//           : null,
//       child: Container(
//         width: double.infinity,
//         height: size.height * 0.058,
//         decoration: BoxDecoration(
//           color: _isSendEnabled
//               ? const Color(0xff62AFC1)
//               : const Color(0xff62AFC1).withOpacity(0.45),
//           borderRadius: BorderRadius.circular(size.width * 0.09),
//           boxShadow: _isSendEnabled
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
//             "Send",
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
//
//   Widget _buildFooterBranding(Size size) {
//     return Center(
//       child: Column(
//         children: [
//           Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: size.width * 0.055,
//                 height: size.width * 0.055,
//                 decoration: BoxDecoration(
//                   borderRadius: BorderRadius.circular(size.width * 0.012),
//                   gradient: const LinearGradient(
//                     colors: [
//                       Color(0xff6F5BFF),
//                       Color(0xff62AFC1),
//                     ],
//                   ),
//                 ),
//                 child: Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     margin: EdgeInsets.only(left: size.width * 0.008),
//                     width: size.width * 0.016,
//                     height: size.width * 0.04,
//                     decoration: BoxDecoration(
//                       color: Colors.black,
//                       borderRadius: BorderRadius.circular(size.width * 0.004),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: size.width * 0.02),
//               Text(
//                 "HIGHLIGHT | ME",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: size.width * 0.055,
//                   fontWeight: FontWeight.w700,
//                   letterSpacing: 0.2,
//                 ),
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/presentation_screen/PrivacyPolicyScreen.dart';
import 'package:highlights/presentation_screen/TermsAndConditionScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/ElevatedButton.dart';

class HelpandSupportscreen extends StatefulWidget {
  const HelpandSupportscreen({super.key});

  @override
  State<HelpandSupportscreen> createState() => _HelpandSupportscreenState();
}

class _HelpandSupportscreenState extends State<HelpandSupportscreen> {
  final TextEditingController _messageController = TextEditingController();

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
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

              SizedBox(height: size.height * 0.03),

              Text(
                "Help & Support",
                style: TextStyle(
                  color: textColor,
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: size.height * 0.007),

              Text(
                "Find support when you need it",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.031,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: size.height * 0.035),

              _buildSupportBox(size, cardBgColor, textColor, primaryColor),

              SizedBox(height: size.height * 0.04),

              ElevatedButton1(text: "Send", onPressed: (){
                Get.back();
              }),

              SizedBox(height: size.height * 0.14),

              _buildFooterBranding(size, textColor),

              SizedBox(height: size.height * 0.025),

              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(const PrivacyPolicyscreen());
                  },
                  child: Text(
                    "Privacy Policy",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: size.width * 0.042,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.018),

              Center(
                child: GestureDetector(
                  onTap: () {
                    Get.to(const TermsandConditionscreen());
                  },
                  child: Text(
                    "Terms & Conditions",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: size.width * 0.042,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSupportBox(Size size, Color cardBg, Color textC, Color primary) {
    return Container(
      width: double.infinity,
      height: size.height * 0.18,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(size.width * 0.07),
      ),
      child: Stack(
        children: [
          TextField(
            controller: _messageController,
            maxLength: 90,
            maxLines: null,
            onChanged: (value) => setState(() {}),
            style: TextStyle(
              color: textC,
              fontSize: size.width * 0.035,
              fontWeight: FontWeight.w500,
            ),
            cursorColor: primary,
            decoration: InputDecoration(
              counterText: "",
              hintText: "Try asking: How can i.....",
              hintStyle: TextStyle(
                color: textC.withOpacity(0.35),
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(
                left: size.width * 0.14,
                right: size.width * 0.06,
                top: size.height * 0.017,
                bottom: size.height * 0.045,
              ),
            ),
          ),

          Positioned(
            top: size.height * 0.018,
            left: size.width * 0.04,
            child: Icon(
              Icons.search_rounded,
              color: textC.withOpacity(0.7),
              size: size.width * 0.065,
            ),
          ),

          Positioned(
            right: size.width * 0.05,
            bottom: size.height * 0.018,
            child: Text(
              "${_messageController.text.length}/90",
              style: TextStyle(
                color: textC.withOpacity(0.35),
                fontSize: size.width * 0.035,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterBranding(Size size, Color textColor) {
    return Center(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size.width * 0.055,
            height: size.width * 0.055,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(size.width * 0.012),
              gradient: const LinearGradient(
                colors: [Color(0xff6F5BFF), Color(0xff62AFC1)],
              ),
            ),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: EdgeInsets.only(left: size.width * 0.008),
                width: size.width * 0.016,
                height: size.width * 0.04,
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(size.width * 0.004),
                ),
              ),
            ),
          ),
          SizedBox(width: size.width * 0.02),
          Text(
            "HIGHLIGHT | ME",
            style: TextStyle(
              color: textColor,
              fontSize: size.width * 0.055,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
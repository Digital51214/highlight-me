// import 'package:flutter/material.dart';
// import 'package:highlights/widgets/Backbutton.dart';
//
//
// class PrivacyPolicyscreen extends StatefulWidget {
//   const PrivacyPolicyscreen({super.key});
//
//   @override
//   State<PrivacyPolicyscreen> createState() => _PrivacyPolicyscreenState();
// }
//
// class _PrivacyPolicyscreenState extends State<PrivacyPolicyscreen> {
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
//               SizedBox(height: size.height * 0.035),
//
//               Text(
//                 "Privacy Ploicy",
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
//                 "Accounts you’ve restricted",
//                 style: TextStyle(
//                   color: Colors.white60,
//                   fontSize: size.width * 0.036,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.035),
//
//               _buildSectionTitle(
//                 size: size,
//                 title: "Your Control, Your Moments",
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildBodyText(
//                 size: size,
//                 text:
//                 "We collect only what’s needed to deliver your experience, keep your content secure, and connect you with people you choose. Posts shared between Monday and Thursday are visible during that window and then automatically become private and locked. You control who sees your content, who can contact you, and how your data is used—every step of the way.”",
//               ),
//
//               SizedBox(height: size.height * 0.03),
//
//               _buildSectionTitle(
//                 size: size,
//                 title: "Data We Collect",
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildBulletText(
//                 size: size,
//                 text: "Account details (like name and profile info)",
//               ),
//               _buildBulletText(
//                 size: size,
//                 text: "Content you choose to upload (photos/videos)",
//               ),
//               _buildBulletText(
//                 size: size,
//                 text: "Basic usage data to improve performance",
//               ),
//
//               SizedBox(height: size.height * 0.02),
//
//               _buildBodyText(
//                 size: size,
//                 text:
//                 "We do not collect unnecessary or excessive personal data.",
//               ),
//
//               SizedBox(height: size.height * 0.035),
//
//               _buildSectionTitle(
//                 size: size,
//                 title: "How We Protect Your Data?",
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildBodyText(
//                 size: size,
//                 text:
//                 "Your data is secured using modern protection practices. We work to:",
//               ),
//
//               SizedBox(height: size.height * 0.017),
//
//               _buildBulletText(
//                 size: size,
//                 text: "Keep your content safe from unauthorized access",
//               ),
//               _buildBulletText(
//                 size: size,
//                 text: "Protect your account information",
//               ),
//               _buildBulletText(
//                 size: size,
//                 text: "Continuously improve our security systems",
//               ),
//
//               SizedBox(height: size.height * 0.035),
//
//               _buildSectionTitle(
//                 size: size,
//                 title: "Your Privacy Controls",
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildBodyText(
//                 size: size,
//                 text: "You stay in charge at all times:",
//               ),
//
//               SizedBox(height: size.height * 0.017),
//
//               _buildBulletText(
//                 size: size,
//                 text: "Choose who can view your content",
//               ),
//               _buildBulletText(
//                 size: size,
//                 text: "Control who can message or interact with you",
//               ),
//               _buildBulletText(
//                 size: size,
//                 text: "Block or restrict users anytime",
//               ),
//               _buildBulletText(
//                 size: size,
//                 text: "Manage your visibility and sharing preferences",
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
//         height: 1.25,
//       ),
//     );
//   }
//
//   Widget _buildBulletText({
//     required Size size,
//     required String text,
//   }) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: size.height * 0.004),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Padding(
//             padding: EdgeInsets.only(
//               top: size.height * 0.002,
//               right: size.width * 0.025,
//             ),
//             child: Text(
//               "•",
//               style: TextStyle(
//                 color: Colors.white38,
//                 fontSize: size.width * 0.05,
//                 fontWeight: FontWeight.w400,
//                 height: 1,
//               ),
//             ),
//           ),
//           Expanded(
//             child: Text(
//               text,
//               style: TextStyle(
//                 color: Colors.white38,
//                 fontSize: size.width * 0.0325,
//                 fontWeight: FontWeight.w400,
//                 height: 1.2,
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:highlights/widgets/Backbutton.dart';

class PrivacyPolicyscreen extends StatefulWidget {
  const PrivacyPolicyscreen({super.key});

  @override
  State<PrivacyPolicyscreen> createState() => _PrivacyPolicyscreenState();
}

class _PrivacyPolicyscreenState extends State<PrivacyPolicyscreen> {
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

              SizedBox(height: h * (28.35 / 810)),

              Text(
                "Privacy Policy",
                style: TextStyle(
                  color: textColor,
                  fontSize: w * (24.375 / 375), // Mapped from size.width * 0.065
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: h * (5.67 / 810)),

              Text(
                "Accounts you’ve restricted",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: w * (13.5 / 375), // Mapped from size.width * 0.036
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: h * (28.35 / 810)),

              _buildSectionTitle(
                w: w,
                title: "Your Control, Your Moments",
                textColor: textColor,
              ),

              SizedBox(height: h * (8.1 / 810)),

              _buildBodyText(
                w: w,
                textColor: textColor,
                text:
                "We collect only what’s needed to deliver your experience, keep your content secure, and connect you with people you choose. Posts shared between Monday and Thursday are visible during that window and then automatically become private and locked. You control who sees your content, who can contact you, and how your data is used—every step of the way.",
              ),

              SizedBox(height: h * (24.3 / 810)),

              _buildSectionTitle(
                w: w,
                title: "Data We Collect",
                textColor: textColor,
              ),

              SizedBox(height: h * (8.1 / 810)),

              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Account details (like name and profile info)",
              ),
              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Content you choose to upload (photos/videos)",
              ),
              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Basic usage data to improve performance",
              ),

              SizedBox(height: h * (16.2 / 810)),

              _buildBodyText(
                w: w,
                textColor: textColor,
                text:
                "We do not collect unnecessary or excessive personal data.",
              ),

              SizedBox(height: h * (28.35 / 810)),

              _buildSectionTitle(
                w: w,
                title: "How We Protect Your Data?",
                textColor: textColor,
              ),

              SizedBox(height: h * (8.1 / 810)),

              _buildBodyText(
                w: w,
                textColor: textColor,
                text:
                "Your data is secured using modern protection practices. We work to:",
              ),

              SizedBox(height: h * (13.77 / 810)),

              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Keep your content safe from unauthorized access",
              ),
              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Protect your account information",
              ),
              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Continuously improve our security systems",
              ),

              SizedBox(height: h * (28.35 / 810)),

              _buildSectionTitle(
                w: w,
                title: "Your Privacy Controls",
                textColor: textColor,
              ),

              SizedBox(height: h * (8.1 / 810)),

              _buildBodyText(
                w: w,
                textColor: textColor,
                text: "You stay in charge at all times:",
              ),

              SizedBox(height: h * (13.77 / 810)),

              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Choose who can view your content",
              ),
              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Control who can message or interact with you",
              ),
              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Block or restrict users anytime",
              ),
              _buildBulletText(
                w: w,
                h: h,
                textColor: textColor,
                text: "Manage your visibility and sharing preferences",
              ),

              SizedBox(height: h * (24.3 / 810)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    required double w,
    required String title,
    required Color textColor,
  }) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: w * (15.75 / 375), // Mapped from size.width * 0.042
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    );
  }

  Widget _buildBodyText({
    required double w,
    required String text,
    required Color textColor,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: textColor.withOpacity(0.5),
        fontSize: w * (12.1875 / 375), // Mapped from size.width * 0.0325
        fontWeight: FontWeight.w400,
        height: 1.25,
      ),
    );
  }

  Widget _buildBulletText({
    required double w,
    required double h,
    required String text,
    required Color textColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: h * (3.24 / 810)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: h * (1.62 / 810),
              right: w * (9.375 / 375),
            ),
            child: Text(
              "•",
              style: TextStyle(
                color: textColor.withOpacity(0.5),
                fontSize: w * (18.75 / 375), // Mapped from size.width * 0.05
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
                fontSize: w * (12.1875 / 375),
                fontWeight: FontWeight.w400,
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
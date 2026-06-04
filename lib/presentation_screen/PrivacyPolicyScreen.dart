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
    final size = MediaQuery.of(context).size;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;

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

              SizedBox(height: size.height * 0.035),

              Text(
                "Privacy Policy",
                style: TextStyle(
                  color: textColor,
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: size.height * 0.007),

              Text(
                "Accounts you’ve restricted",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.036,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: size.height * 0.035),

              _buildSectionTitle(
                size: size,
                title: "Your Control, Your Moments",
                textColor: textColor,
              ),

              SizedBox(height: size.height * 0.01),

              _buildBodyText(
                size: size,
                textColor: textColor,
                text:
                "We collect only what’s needed to deliver your experience, keep your content secure, and connect you with people you choose. Posts shared between Monday and Thursday are visible during that window and then automatically become private and locked. You control who sees your content, who can contact you, and how your data is used—every step of the way.",
              ),

              SizedBox(height: size.height * 0.03),

              _buildSectionTitle(
                size: size,
                title: "Data We Collect",
                textColor: textColor,
              ),

              SizedBox(height: size.height * 0.01),

              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Account details (like name and profile info)",
              ),
              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Content you choose to upload (photos/videos)",
              ),
              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Basic usage data to improve performance",
              ),

              SizedBox(height: size.height * 0.02),

              _buildBodyText(
                size: size,
                textColor: textColor,
                text:
                "We do not collect unnecessary or excessive personal data.",
              ),

              SizedBox(height: size.height * 0.035),

              _buildSectionTitle(
                size: size,
                title: "How We Protect Your Data?",
                textColor: textColor,
              ),

              SizedBox(height: size.height * 0.01),

              _buildBodyText(
                size: size,
                textColor: textColor,
                text:
                "Your data is secured using modern protection practices. We work to:",
              ),

              SizedBox(height: size.height * 0.017),

              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Keep your content safe from unauthorized access",
              ),
              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Protect your account information",
              ),
              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Continuously improve our security systems",
              ),

              SizedBox(height: size.height * 0.035),

              _buildSectionTitle(
                size: size,
                title: "Your Privacy Controls",
                textColor: textColor,
              ),

              SizedBox(height: size.height * 0.01),

              _buildBodyText(
                size: size,
                textColor: textColor,
                text: "You stay in charge at all times:",
              ),

              SizedBox(height: size.height * 0.017),

              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Choose who can view your content",
              ),
              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Control who can message or interact with you",
              ),
              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Block or restrict users anytime",
              ),
              _buildBulletText(
                size: size,
                textColor: textColor,
                text: "Manage your visibility and sharing preferences",
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
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
        height: 1.25,
      ),
    );
  }

  Widget _buildBulletText({
    required Size size,
    required String text,
    required Color textColor,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.height * 0.004),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: size.height * 0.002,
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
                height: 1.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/PrivacyPolicyScreen.dart';
// import 'package:highlights/presentation_screen/TermsAndConditionScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
//
// class Privacyscreen extends StatefulWidget {
//   const Privacyscreen({super.key});
//
//   @override
//   State<Privacyscreen> createState() => _PrivacyscreenState();
// }
//
// class _PrivacyscreenState extends State<Privacyscreen> {
//   bool isPrivateAccount = true;
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
//               SizedBox(height: size.height * 0.035),
//
//               Text(
//                 "Privacy",
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
//                 "Your account, protected and secure.",
//                 style: TextStyle(
//                   color: Colors.white60,
//                   fontSize: size.width * 0.036,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.035),
//
//               _buildPrivateAccountTile(size),
//
//               SizedBox(height: size.height * 0.011),
//
//               _buildArrowTile(
//                 size: size,
//                 title: "Privacy Policy",
//                 onTap: () {
//                   Get.to(PrivacyPolicyscreen(),
//                     transition: Transition.noTransition,
//                     duration: Duration.zero,);
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.011),
//
//               _buildArrowTile(
//                 size: size,
//                 title: "Terms & Conditions",
//                 onTap: () {
//                   Get.to(TermsandConditionscreen(),
//                     transition: Transition.noTransition,
//                     duration: Duration.zero,);
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPrivateAccountTile(Size size) {
//     return Container(
//       width: double.infinity,
//       height: size.height * 0.1,
//       padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
//       decoration: BoxDecoration(
//         color: const Color(0xff262626),
//         borderRadius: BorderRadius.circular(size.width * 0.07),
//       ),
//       child: Row(
//         children: [
//           Expanded(
//             child: Padding(
//               padding: EdgeInsets.only(top: size.height * 0.002),
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Private Account",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: size.width * 0.042,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: size.height * 0.004),
//                   Text(
//                     "When your account is public,your profile.....",
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                     style: TextStyle(
//                       color: Colors.white38,
//                       fontSize: size.width * 0.026,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Transform.scale(
//             scale: size.width * 0.0024,
//             child: Switch(
//               value: isPrivateAccount,
//               onChanged: (value) {
//                 setState(() {
//                   isPrivateAccount = value;
//                 });
//               },
//               activeColor: Colors.white,
//               activeTrackColor: const Color(0xff62AFC1),
//               inactiveThumbColor: Colors.white70,
//               inactiveTrackColor: Colors.grey.shade700,
//               materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildArrowTile({
//     required Size size,
//     required String title,
//     VoidCallback? onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: size.height * 0.086,
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//         decoration: BoxDecoration(
//           color: const Color(0xff262626),
//           borderRadius: BorderRadius.circular(size.width * 0.07),
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: Padding(
//                 padding: EdgeInsets.only(left: size.width * 0.04),
//                 child: Text(
//                   title,
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontSize: size.width * 0.042,
//                     fontWeight: FontWeight.w700,
//                   ),
//                 ),
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: Colors.white70,
//               size: size.width * 0.055,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/presentation_screen/PrivacyPolicyScreen.dart';
import 'package:highlights/presentation_screen/TermsAndConditionScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';

class Privacyscreen extends StatefulWidget {
  const Privacyscreen({super.key});

  @override
  State<Privacyscreen> createState() => _PrivacyscreenState();
}

class _PrivacyscreenState extends State<Privacyscreen> {
  bool isPrivateAccount = true;

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

              SizedBox(height: size.height * 0.035),

              Text(
                "Privacy",
                style: TextStyle(
                  color: textColor,
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: size.height * 0.007),

              Text(
                "Your account, protected and secure.",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.036,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: size.height * 0.035),

              _buildPrivateAccountTile(size, cardBgColor, textColor, primaryColor),

              SizedBox(height: size.height * 0.011),

              _buildArrowTile(
                size: size,
                title: "Privacy Policy",
                cardBg: cardBgColor,
                textC: textColor,
                onTap: () {
                  Get.to(
                    const PrivacyPolicyscreen(),
                    transition: Transition.noTransition,
                    duration: Duration.zero,
                  );
                },
              ),

              SizedBox(height: size.height * 0.011),

              _buildArrowTile(
                size: size,
                title: "Terms & Conditions",
                cardBg: cardBgColor,
                textC: textColor,
                onTap: () {
                  Get.to(
                    const TermsandConditionscreen(),
                    transition: Transition.noTransition,
                    duration: Duration.zero,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPrivateAccountTile(Size size, Color cardBg, Color textC, Color primary) {
    return Container(
      width: double.infinity,
      height: size.height * 0.1,
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.065),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(size.width * 0.07),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Private Account",
                  style: TextStyle(
                    color: textC,
                    fontSize: size.width * 0.042,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(height: size.height * 0.004),
                Text(
                  "When your account is public, your profile.....",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: textC.withOpacity(0.4),
                    fontSize: size.width * 0.026,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
          Transform.scale(
            scale: size.width * 0.0024,
            child: Switch(
              value: isPrivateAccount,
              onChanged: (value) => setState(() => isPrivateAccount = value),
              activeColor: Colors.white,
              activeTrackColor: primary,
              inactiveThumbColor: textC.withOpacity(0.5),
              inactiveTrackColor: textC.withOpacity(0.1),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArrowTile({
    required Size size,
    required String title,
    required Color cardBg,
    required Color textC,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: size.height * 0.086,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(size.width * 0.07),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: size.width * 0.04),
                child: Text(
                  title,
                  style: TextStyle(
                    color: textC,
                    fontSize: size.width * 0.042,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: textC.withOpacity(0.7),
              size: size.width * 0.055,
            ),
          ],
        ),
      ),
    );
  }
}
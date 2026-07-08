// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/ChangePasswordScreen.dart';
// import 'package:highlights/presentation_screen/EditProfileScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
//
// class AccountSettingscreen extends StatefulWidget {
//   const AccountSettingscreen({super.key});
//
//   @override
//   State<AccountSettingscreen> createState() => _AccountSettingscreenState();
// }
//
// class _AccountSettingscreenState extends State<AccountSettingscreen> {
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
//               /// Back Button
//               const CustomBackButtonWidget(),
//
//               SizedBox(height: size.height * 0.025),
//
//               /// Title
//               Text(
//                 "Account Settings",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: size.width * 0.067,
//                   fontWeight: FontWeight.w800,
//                   height: 1.1,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.013),
//
//               /// Subtitle
//               Text(
//                 "Passwords,security,personal details,connected\nexperiences,date of brith,email,security.",
//                 style: TextStyle(
//                   color: Colors.white54,
//                   fontSize: size.width * 0.033,
//                   fontWeight: FontWeight.w400,
//                   height: 1.3,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.048),
//
//               _buildOptionTile(
//                 size: size,
//                 title: "Edit Profile",
//                 onTap: () {
//                   Get.to(EditProfilescreen(),
//                     transition: Transition.noTransition,
//                     duration: Duration.zero,);
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildOptionTile(
//                 size: size,
//                 title: "Change password",
//                 onTap: () {
//                   Get.to(ChangePasswordscreen(),
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
//   Widget _buildOptionTile({
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
//                     fontSize: size.width * 0.045,
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
import 'package:highlights/presentation_screen/ChangePasswordScreen.dart';
import 'package:highlights/presentation_screen/EditProfileScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';

class AccountSettingscreen extends StatefulWidget {
  const AccountSettingscreen({super.key});

  @override
  State<AccountSettingscreen> createState() => _AccountSettingscreenState();
}

class _AccountSettingscreenState extends State<AccountSettingscreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Adaptive BG
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * (20.625 / 375), // 0.055 figma ratio
            vertical: h * (9.72 / 810),    // 0.012 figma ratio
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * (8.1 / 810)),

              /// Back Button
              const CustomBackButtonWidget(),

              SizedBox(height: h * (20.25 / 810)),

              /// Title
              Text(
                "Account Settings",
                style: TextStyle(
                  color: textColor, // Adaptive Text
                  fontSize: w * (26.0 / 375), // Scaled font size
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: h * (10.53 / 810)),

              /// Subtitle
              Text(
                "Passwords,security,personal details,connected\nexperiences,date of brith,email,security.",
                style: TextStyle(
                  color: textColor.withOpacity(0.6), // Adaptive Subtitle
                  fontSize: w * (13.0 / 375),
                  fontWeight: FontWeight.w400,
                  height: 1.3,
                ),
              ),

              SizedBox(height: h * (38.88 / 810)),

              _buildOptionTile(
                w: w,
                h: h,
                title: "Edit Profile",
                cardBgColor: cardBgColor,
                textColor: textColor,
                onTap: () {
                  Get.to(
                    EditProfilescreen(),
                    transition: Transition.noTransition,
                    duration: Duration.zero,
                  );
                },
              ),

              SizedBox(height: h * (8.1 / 810)),

              _buildOptionTile(
                w: w,
                h: h,
                title: "Change password",
                cardBgColor: cardBgColor,
                textColor: textColor,
                onTap: () {
                  Get.to(
                    ChangePasswordscreen(),
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

  Widget _buildOptionTile({
    required double w,
    required double h,
    required String title,
    required Color cardBgColor,
    required Color textColor,
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: h * (70.0 / 810), // Base scaled height (approx 0.086 scale mapped)
        padding: EdgeInsets.symmetric(horizontal: w * (18.75 / 375)),
        decoration: BoxDecoration(
          color: cardBgColor, // Adaptive Card Color
          borderRadius: BorderRadius.circular(w * (26.25 / 375)),
        ),
        child: Row(
          children: [
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: w * (15.0 / 375)),
                child: Text(
                  title,
                  style: TextStyle(
                    color: textColor, // Adaptive Text
                    fontSize: w * (15.0 / 375),
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: textColor.withOpacity(0.7), // Adaptive Icon Color
              size: w * (20.625 / 375),
            ),
          ],
        ),
      ),
    );
  }
}
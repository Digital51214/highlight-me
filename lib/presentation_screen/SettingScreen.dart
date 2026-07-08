//
// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/AccountSettingScreen.dart';
// import 'package:highlights/presentation_screen/HelpandSupportScreen.dart';
// import 'package:highlights/presentation_screen/PrivacyScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/DiologeWidget.dart';
// import '../Contollers/auth_controller.dart';
// import '../core/theme_service.dart';
//
// class Settingscreen extends StatefulWidget {
//   const Settingscreen({super.key});
//
//   @override
//   State<Settingscreen> createState() => _SettingscreenState();
// }
//
// class _SettingscreenState extends State<Settingscreen> {
//   final themeController = Get.find<ThemeController>();
//   bool isNotificationOn = true;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color cardBgColor = Theme.of(context).cardColor;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: size.width * 0.05, vertical: size.height * 0.01),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: size.height * 0.007),
//               const Row(children: [CustomBackButtonWidget()]),
//               SizedBox(height: size.height * 0.018),
//               Text("Settings", style: TextStyle(color: textColor, fontSize: size.width * 0.065, fontWeight: FontWeight.w800)),
//               SizedBox(height: size.height * 0.015),
//
//               _buildProfileSection(size, primaryColor, textColor), // FIXED SECTON
//
//               SizedBox(height: size.height * 0.02),
//               _buildSettingTile(size: size, icon: Icons.person, title: "Account Settings", subtitle: "Personal info, email, security", showArrow: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor, onTap: () => Get.to(const AccountSettingscreen(), transition: Transition.noTransition, duration: Duration.zero)),
//               SizedBox(height: size.height * 0.01),
//               _buildSettingTile(size: size, icon: Icons.lock, title: "Privacy", subtitle: "Terms & Conditions, blocked user", showArrow: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor, onTap: () => Get.to(const Privacyscreen(), transition: Transition.noTransition, duration: Duration.zero)),
//               SizedBox(height: size.height * 0.01),
//               _buildSettingTile(size: size, icon: Icons.notifications, title: "Notifications", subtitle: "Sleep Mode, Messages Only", showSwitch: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor, switchValue: isNotificationOn, onSwitchChanged: (value) => setState(() => isNotificationOn = value)),
//               SizedBox(height: size.height * 0.01),
//               Obx(() => _buildSettingTile(size: size, icon: Icons.palette_outlined, title: "Display Mode", subtitle: "Enable light or dark mode", showSwitch: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor, switchValue: themeController.isDarkMode.value, onSwitchChanged: (value) => themeController.toggleTheme())),
//               SizedBox(height: size.height * 0.02),
//               Text("RESOURCES", style: TextStyle(color: textColor.withOpacity(0.6), fontSize: size.width * 0.038, fontWeight: FontWeight.w500, letterSpacing: 0.7)),
//               SizedBox(height: size.height * 0.018),
//               _buildSettingTile(size: size, icon: Icons.help_outline_rounded, title: "Help", subtitle: "Support", showArrow: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor, onTap: () => Get.to(const HelpandSupportscreen(), transition: Transition.noTransition, duration: Duration.zero)),
//               SizedBox(height: size.height * 0.045),
//               _buildLogoutButton(size, primaryColor, cardBgColor),
//               SizedBox(height: size.height * 0.06),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileSection(Size size, Color primary, Color textC) {
//     final auth = Get.find<AuthController>();
//     return Obx(() {
//       // 🔥 3-Level Engine inside Setting screen
//       ImageProvider avatarImg;
//       if (auth.userAvatarLocalPath.value.isNotEmpty && File(auth.userAvatarLocalPath.value).existsSync()) {
//         avatarImg = FileImage(File(auth.userAvatarLocalPath.value));
//       } else if (auth.userAvatar.value != null && auth.userAvatar.value!.isNotEmpty) {
//         if (auth.userAvatar.value!.startsWith('http')) {
//           avatarImg = NetworkImage(auth.userAvatar.value!);
//         } else {
//           try {
//             final cleanBase64 = auth.userAvatar.value!.contains('base64,') ? auth.userAvatar.value!.split('base64,')[1] : auth.userAvatar.value!;
//             avatarImg = MemoryImage(base64Decode(cleanBase64.trim()));
//           } catch (_) {
//             avatarImg = const AssetImage("assets/images/image1.png");
//           }
//         }
//       } else {
//         avatarImg = const AssetImage("assets/images/image1.png");
//       }
//
//       return Center(
//         child: Column(
//           children: [
//             SizedBox(
//               height: size.width * 0.28, width: size.width * 0.28,
//               child: Stack(
//                 clipBehavior: Clip.none,
//                 children: [
//                   Container(
//                     height: size.width * 0.28, width: size.width * 0.28, padding: EdgeInsets.all(size.width * 0.01),
//                     decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: primary, width: size.width * 0.012)),
//                     child: Container(decoration: BoxDecoration(shape: BoxShape.circle, image: DecorationImage(image: avatarImg, fit: BoxFit.cover))),
//                   ),
//                   Positioned(right: size.width * 0.02, bottom: size.width * 0.01, child: Container(height: size.width * 0.06, width: size.width * 0.06, decoration: BoxDecoration(color: primary, shape: BoxShape.circle), child: Icon(Icons.check, color: Colors.white, size: size.width * 0.04))),
//                 ],
//               ),
//             ),
//             SizedBox(height: size.height * 0.009),
//             Text(auth.userName.value.isNotEmpty ? auth.userName.value : '', style: TextStyle(color: textC, fontSize: size.width * 0.05, fontWeight: FontWeight.w700)),
//           ],
//         ),
//       );
//     });
//   }
//
//   Widget _buildSettingTile({required Size size, required IconData icon, required String title, required String subtitle, required Color cardBg, required Color textC, required Color primary, bool showArrow = false, bool showSwitch = false, bool switchValue = false, VoidCallback? onTap, ValueChanged<bool>? onSwitchChanged}) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity, height: size.height * 0.1115, padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//         decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(size.width * 0.07)),
//         child: Row(
//           children: [
//             Container(height: size.width * 0.11, width: size.width * 0.11, decoration: BoxDecoration(color: textC.withOpacity(0.08), borderRadius: BorderRadius.circular(size.width * 0.03)), child: Icon(icon, color: primary, size: size.width * 0.06)),
//             SizedBox(width: size.width * 0.03),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center, crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(title, style: TextStyle(color: textC, fontSize: size.width * 0.045, fontWeight: FontWeight.w700)),
//                   SizedBox(height: size.height * 0.003),
//                   Text(subtitle, style: TextStyle(color: textC.withOpacity(0.4), fontSize: size.width * 0.032, fontWeight: FontWeight.w500)),
//                 ],
//               ),
//             ),
//             if (showArrow) Icon(Icons.arrow_forward_ios_rounded, color: textC.withOpacity(0.5), size: size.width * 0.05),
//             if (showSwitch) Transform.scale(scale: size.width * 0.0025, child: Switch(value: switchValue, onChanged: onSwitchChanged, activeColor: Colors.white, activeTrackColor: primary, inactiveThumbColor: textC.withOpacity(0.3), inactiveTrackColor: textC.withOpacity(0.1), materialTapTargetSize: MaterialTapTargetSize.shrinkWrap)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLogoutButton(Size size, Color primary, Color cardBg) {
//     return GestureDetector(onTap: () => LogoutDialog.show(context), child: Container(width: double.infinity, height: size.height * 0.073, decoration: BoxDecoration(color: primary.withOpacity(0.1), borderRadius: BorderRadius.circular(size.width * 0.09), border: Border.all(color: primary.withOpacity(0.5), width: 1.5)), child: Center(child: Text("Logout", style: TextStyle(color: primary, fontSize: size.width * 0.05, fontWeight: FontWeight.w700)))));
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/presentation_screen/AccountSettingScreen.dart';
import 'package:highlights/presentation_screen/HelpandSupportScreen.dart';
import 'package:highlights/presentation_screen/PrivacyScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/DiologeWidget.dart';
import '../Contollers/auth_controller.dart';
import '../core/theme_service.dart';

class Settingscreen extends StatefulWidget {
  const Settingscreen({super.key});

  @override
  State<Settingscreen> createState() => _SettingscreenState();
}

class _SettingscreenState extends State<Settingscreen> {
  final themeController = Get.find<ThemeController>();
  bool isNotificationOn = true;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * (18.75 / 375), // 0.05 scaled ratio
            vertical: h * (8.1 / 810),    // 0.01 scaled ratio
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * (5.67 / 810)),
              const Row(children: [CustomBackButtonWidget()]),
              SizedBox(height: h * (14.58 / 810)),
              Text(
                "Settings",
                style: TextStyle(
                  color: textColor,
                  fontSize: w * (24.375 / 375), // Mapped from size.width * 0.065
                  fontWeight: FontWeight.w800,
                ),
              ),
              SizedBox(height: h * (12.15 / 810)),

              _buildProfileSection(w, h, primaryColor, textColor),

              SizedBox(height: h * (16.2 / 810)),

              _buildSettingTile(
                w: w, h: h, icon: Icons.person,
                title: "Account Settings", subtitle: "Personal info, email, security",
                showArrow: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor,
                onTap: () => Get.to(const AccountSettingscreen(), transition: Transition.noTransition, duration: Duration.zero),
              ),
              SizedBox(height: h * (8.1 / 810)),

              _buildSettingTile(
                w: w, h: h, icon: Icons.lock,
                title: "Privacy", subtitle: "Terms & Conditions, blocked user",
                showArrow: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor,
                onTap: () => Get.to(const Privacyscreen(), transition: Transition.noTransition, duration: Duration.zero),
              ),
              SizedBox(height: h * (8.1 / 810)),

              _buildSettingTile(
                w: w, h: h, icon: Icons.notifications,
                title: "Notifications", subtitle: "Sleep Mode, Messages Only",
                showSwitch: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor,
                switchValue: isNotificationOn,
                onSwitchChanged: (value) => setState(() => isNotificationOn = value),
              ),
              SizedBox(height: h * (8.1 / 810)),

              Obx(() => _buildSettingTile(
                w: w, h: h, icon: Icons.palette_outlined,
                title: "Display Mode", subtitle: "Enable light or dark mode",
                showSwitch: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor,
                switchValue: themeController.isDarkMode.value,
                onSwitchChanged: (value) => themeController.toggleTheme(),
              )),

              SizedBox(height: h * (16.2 / 810)),
              Text(
                "RESOURCES",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: w * (14.25 / 375), // Mapped from size.width * 0.038
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),
              SizedBox(height: h * (14.58 / 810)),

              _buildSettingTile(
                w: w, h: h, icon: Icons.help_outline_rounded,
                title: "Help", subtitle: "Support",
                showArrow: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor,
                onTap: () => Get.to(const HelpandSupportscreen(), transition: Transition.noTransition, duration: Duration.zero),
              ),

              SizedBox(height: h * (36.45 / 810)),
              _buildLogoutButton(w, h, primaryColor, cardBgColor),
              SizedBox(height: h * (48.6 / 810)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(double w, double h, Color primary, Color textC) {
    final auth = Get.find<AuthController>();
    return Obx(() {
      ImageProvider avatarImg;
      if (auth.userAvatarLocalPath.value.isNotEmpty && File(auth.userAvatarLocalPath.value).existsSync()) {
        avatarImg = FileImage(File(auth.userAvatarLocalPath.value));
      } else if (auth.userAvatar.value != null && auth.userAvatar.value!.isNotEmpty) {
        if (auth.userAvatar.value!.startsWith('http')) {
          avatarImg = NetworkImage(auth.userAvatar.value!);
        } else {
          try {
            final cleanBase64 = auth.userAvatar.value!.contains('base64,') ? auth.userAvatar.value!.split('base64,')[1] : auth.userAvatar.value!;
            avatarImg = MemoryImage(base64Decode(cleanBase64.trim()));
          } catch (_) {
            avatarImg = const AssetImage("assets/images/h0.png");
          }
        }
      } else {
        avatarImg = const AssetImage("assets/images/h0.png");
      }

      double avatarSize = w * (105.0 / 375); // Evaluated from size.width * 0.28

      return Center(
        child: Column(
          children: [
            SizedBox(
              height: avatarSize,
              width: avatarSize,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    height: avatarSize,
                    width: avatarSize,
                    padding: EdgeInsets.all(w * (3.75 / 375)),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: primary, width: w * (4.5 / 375)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(image: avatarImg, fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Positioned(
                    right: w * (7.5 / 375),
                    bottom: w * (3.75 / 375),
                    child: Container(
                      height: w * (22.5 / 375),
                      width: w * (22.5 / 375),
                      decoration: BoxDecoration(color: primary, shape: BoxShape.circle),
                      child: Icon(Icons.check, color: Colors.white, size: w * (15.0 / 375)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: h * (7.29 / 810)),
            Text(
              auth.userName.value.isNotEmpty ? auth.userName.value : '',
              style: TextStyle(
                color: textC,
                fontSize: w * (18.75 / 375), // Mapped from size.width * 0.05
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget _buildSettingTile({
    required double w,
    required double h,
    required IconData icon,
    required String title,
    required String subtitle,
    required Color cardBg,
    required Color textC,
    required Color primary,
    bool showArrow = false,
    bool showSwitch = false,
    bool switchValue = false,
    VoidCallback? onTap,
    ValueChanged<bool>? onSwitchChanged,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: h * (90.315 / 810), // Evaluated size.height * 0.1115 conversion
        padding: EdgeInsets.symmetric(horizontal: w * (18.75 / 375)),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(w * (26.25 / 375)),
        ),
        child: Row(
          children: [
            Container(
              height: w * (41.25 / 375),
              width: w * (41.25 / 375),
              decoration: BoxDecoration(
                color: textC.withOpacity(0.08),
                borderRadius: BorderRadius.circular(w * (11.25 / 375)),
              ),
              child: Icon(icon, color: primary, size: w * (22.5 / 375)),
            ),
            SizedBox(width: w * (11.25 / 375)),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textC,
                      fontSize: w * (16.875 / 375), // Mapped from size.width * 0.045
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: h * (2.43 / 810)),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: textC.withOpacity(0.4),
                      fontSize: w * (12.0 / 375), // Mapped from size.width * 0.032
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            if (showArrow)
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: textC.withOpacity(0.5),
                size: w * (18.75 / 375),
              ),
            if (showSwitch)
              Transform.scale(
                scale: w * (0.9375 / 375), // Normalized transformation metric
                child: Switch(
                  value: switchValue,
                  onChanged: onSwitchChanged,
                  activeColor: Colors.white,
                  activeTrackColor: primary,
                  inactiveThumbColor: textC.withOpacity(0.3),
                  inactiveTrackColor: textC.withOpacity(0.1),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildLogoutButton(double w, double h, Color primary, Color cardBg) {
    return GestureDetector(
      onTap: () => LogoutDialog.show(context),
      child: Container(
        width: double.infinity,
        height: h * (59.13 / 810), // Evaluated size.height * 0.073 conversion
        decoration: BoxDecoration(
          color: primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(w * (33.75 / 375)),
          border: Border.all(color: primary.withOpacity(0.5), width: 1.5),
        ),
        child: Center(
          child: Text(
            "Logout",
            style: TextStyle(
              color: primary,
              fontSize: w * (18.75 / 375),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
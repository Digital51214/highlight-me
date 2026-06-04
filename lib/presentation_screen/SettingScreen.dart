// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/AccountSettingScreen.dart';
// import 'package:highlights/presentation_screen/HelpandSupportScreen.dart';
// import 'package:highlights/presentation_screen/PrivacyScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/DiologeWidget.dart';
//
// import '../core/theme_service.dart';
//
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
//
//   bool isNotificationOn = true;
//   bool isDarkmodeOn = true;
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.05,
//             vertical: size.height * 0.01,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: size.height * 0.007),
//
//               Row(
//                 children: [
//                   const CustomBackButtonWidget(),
//                 ],
//               ),
//
//               SizedBox(height: size.height * 0.018),
//
//               Text(
//                 "Settings",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: size.width * 0.065,
//                   fontWeight: FontWeight.w800,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.015),
//
//               _buildProfileSection(size),
//
//               SizedBox(height: size.height * 0.02),
//
//               _buildSettingTile(
//                 size: size,
//                 icon: Icons.person,
//                 title: "Account Settings",
//                 subtitle: "Personal info,email,security",
//                 showArrow: true,
//                 onTap: () {
//                   Get.to(AccountSettingscreen(), transition: Transition.noTransition,
//                     duration: Duration.zero,);
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildSettingTile(
//                 size: size,
//                 icon: Icons.lock,
//                 title: "Privacy",
//                 subtitle: "Terms & Conditions,blocked user",
//                 showArrow: true,
//                 onTap: () {
//                   Get.to(Privacyscreen(), transition: Transition.noTransition,
//                     duration: Duration.zero,);
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildSettingTile(
//                 size: size,
//                 icon: Icons.notifications,
//                 title: "Notifications",
//                 subtitle: "Sleep Mode,Messages Only",
//                 showSwitch: true,
//                 switchValue: isNotificationOn,
//                 onSwitchChanged: (value) {
//                   setState(() {
//                     isNotificationOn = value;
//                   });
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildSettingTile(
//                 size: size,
//                 icon: Icons.palette_outlined,
//                 title: "Display Mode",
//                 subtitle: "Enable light or dark mode",
//                 showSwitch: true,
//                 // Obx isliye taake switch ki position on/off nazar aaye
//                 switchValue: themeController.isDarkMode.value,
//                 onSwitchChanged: (value) {
//                   themeController.toggleTheme();
//                   setState(() {}); // Local UI refresh ke liye
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.02),
//
//               Text(
//                 "RESOURCES",
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: size.width * 0.038,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: 0.7,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.018),
//
//               _buildSettingTile(
//                 size: size,
//                 icon: Icons.help_outline_rounded,
//                 title: "Help",
//                 subtitle: "Support",
//                 showArrow: true,
//                 onTap: () {
//                   Get.to(HelpandSupportscreen(), transition: Transition.noTransition,
//                     duration: Duration.zero,);
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.045),
//
//               _buildLogoutButton(size),
//
//               SizedBox(height: size.height * 0.06),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileSection(Size size) {
//     return Center(
//       child: Column(
//         children: [
//           SizedBox(
//             height: size.width * 0.28,
//             width: size.width * 0.28,
//             child: Stack(
//               clipBehavior: Clip.none,
//               children: [
//                 Container(
//                   height: size.width * 0.28,
//                   width: size.width * 0.28,
//                   padding: EdgeInsets.all(size.width * 0.01),
//                   decoration: BoxDecoration(
//                     shape: BoxShape.circle,
//                     border: Border.all(
//                       color: const Color(0xff35B8DD),
//                       width: size.width * 0.012,
//                     ),
//                   ),
//                   child: Container(
//                     decoration: const BoxDecoration(
//                       shape: BoxShape.circle,
//                       image: DecorationImage(
//                         image: AssetImage("assets/images/image1.png"),
//                         fit: BoxFit.cover,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: size.width * 0.02,
//                   bottom: size.width * 0.01,
//                   child: Container(
//                     height: size.width * 0.06,
//                     width: size.width * 0.06,
//                     decoration: const BoxDecoration(
//                       color: Colors.white,
//                       shape: BoxShape.circle,
//                     ),
//                     child: Icon(
//                       Icons.check,
//                       color: const Color(0xff0F1012),
//                       size: size.width * 0.04,
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           SizedBox(height: size.height * 0.009),
//           Text(
//             "Lexa_Bravo",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: size.width * 0.05,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSettingTile({
//     required Size size,
//     required IconData icon,
//     required String title,
//     required String subtitle,
//     bool showArrow = false,
//     bool showSwitch = false,
//     bool switchValue = false,
//     VoidCallback? onTap,
//     ValueChanged<bool>? onSwitchChanged,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: double.infinity,
//         height: size.height * 0.1115,
//         padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
//         decoration: BoxDecoration(
//           color: const Color(0xff262626),
//           borderRadius: BorderRadius.circular(size.width * 0.07),
//         ),
//         child: Row(
//           children: [
//             Container(
//               height: size.width * 0.11,
//               width: size.width * 0.11,
//               decoration: BoxDecoration(
//                 color: const Color(0xff4A4448),
//                 borderRadius: BorderRadius.circular(size.width * 0.03),
//               ),
//               child: Icon(
//                 icon,
//                 color: const Color(0xff56B6D0),
//                 size: size.width * 0.06,
//               ),
//             ),
//
//             SizedBox(width: size.width * 0.03),
//
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: size.width * 0.045,
//                       fontWeight: FontWeight.w700,
//                     ),
//                   ),
//                   SizedBox(height: size.height * 0.003),
//                   Text(
//                     subtitle,
//                     style: TextStyle(
//                       color: Colors.white38,
//                       fontSize: size.width * 0.032,
//                       fontWeight: FontWeight.w500,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//
//             if (showArrow)
//               Icon(
//                 Icons.arrow_forward_ios_rounded,
//                 color: Colors.white70,
//                 size: size.width * 0.05,
//               ),
//
//             if (showSwitch)
//               Transform.scale(
//                 scale: size.width * 0.0025,
//                 child: Switch(
//                   value: switchValue,
//                   onChanged: onSwitchChanged,
//                   activeColor: Colors.white,
//                   activeTrackColor: const Color(0xff56B6D0),
//                   inactiveThumbColor: Colors.white70,
//                   inactiveTrackColor: Colors.grey.shade700,
//                   materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildLogoutButton(Size size) {
//     return GestureDetector(
//       onTap: () {
//         LogoutDialog.show(context);
//       },
//       child: Container(
//         width: double.infinity,
//         height: size.height * 0.073,
//         decoration: BoxDecoration(
//           color: const Color(0xff1D3538),
//           borderRadius: BorderRadius.circular(size.width * 0.09),
//           border: Border.all(
//             color: const Color(0xff2CCBFF),
//             width: size.width * 0.003,
//           ),
//         ),
//         child: Center(
//           child: Text(
//             "Logout",
//             style: TextStyle(
//               color: const Color(0xff36C4F1),
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
import 'package:highlights/presentation_screen/AccountSettingScreen.dart';
import 'package:highlights/presentation_screen/HelpandSupportScreen.dart';
import 'package:highlights/presentation_screen/PrivacyScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/DiologeWidget.dart';
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
            horizontal: size.width * 0.05,
            vertical: size.height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.007),

              const Row(
                children: [
                  CustomBackButtonWidget(),
                ],
              ),

              SizedBox(height: size.height * 0.018),

              Text(
                "Settings",
                style: TextStyle(
                  color: textColor,
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w800,
                ),
              ),

              SizedBox(height: size.height * 0.015),

              _buildProfileSection(size, primaryColor, textColor),

              SizedBox(height: size.height * 0.02),

              _buildSettingTile(
                size: size,
                icon: Icons.person,
                title: "Account Settings",
                subtitle: "Personal info, email, security",
                showArrow: true,
                cardBg: cardBgColor,
                textC: textColor,
                primary: primaryColor,
                onTap: () {
                  Get.to(const AccountSettingscreen(), transition: Transition.noTransition,
                      duration: Duration.zero);
                },
              ),

              SizedBox(height: size.height * 0.01),

              _buildSettingTile(
                size: size,
                icon: Icons.lock,
                title: "Privacy",
                subtitle: "Terms & Conditions, blocked user",
                showArrow: true,
                cardBg: cardBgColor,
                textC: textColor,
                primary: primaryColor,
                onTap: () {
                  Get.to(const Privacyscreen(), transition: Transition.noTransition,
                      duration: Duration.zero);
                },
              ),

              SizedBox(height: size.height * 0.01),

              _buildSettingTile(
                size: size,
                icon: Icons.notifications,
                title: "Notifications",
                subtitle: "Sleep Mode, Messages Only",
                showSwitch: true,
                cardBg: cardBgColor,
                textC: textColor,
                primary: primaryColor,
                switchValue: isNotificationOn,
                onSwitchChanged: (value) {
                  setState(() {
                    isNotificationOn = value;
                  });
                },
              ),

              SizedBox(height: size.height * 0.01),

              // Theme Switch Tile
              Obx(() => _buildSettingTile(
                size: size,
                icon: Icons.palette_outlined,
                title: "Display Mode",
                subtitle: "Enable light or dark mode",
                showSwitch: true,
                cardBg: cardBgColor,
                textC: textColor,
                primary: primaryColor,
                switchValue: themeController.isDarkMode.value,
                onSwitchChanged: (value) {
                  themeController.toggleTheme();
                },
              )),

              SizedBox(height: size.height * 0.02),

              Text(
                "RESOURCES",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.038,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),

              SizedBox(height: size.height * 0.018),

              _buildSettingTile(
                size: size,
                icon: Icons.help_outline_rounded,
                title: "Help",
                subtitle: "Support",
                showArrow: true,
                cardBg: cardBgColor,
                textC: textColor,
                primary: primaryColor,
                onTap: () {
                  Get.to(const HelpandSupportscreen(), transition: Transition.noTransition,
                      duration: Duration.zero);
                },
              ),

              SizedBox(height: size.height * 0.045),

              _buildLogoutButton(size, primaryColor, cardBgColor),

              SizedBox(height: size.height * 0.06),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileSection(Size size, Color primary, Color textC) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: size.width * 0.28,
            width: size.width * 0.28,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: size.width * 0.28,
                  width: size.width * 0.28,
                  padding: EdgeInsets.all(size.width * 0.01),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: primary,
                      width: size.width * 0.012,
                    ),
                  ),
                  child: Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: AssetImage("assets/images/image1.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: size.width * 0.02,
                  bottom: size.width * 0.01,
                  child: Container(
                    height: size.width * 0.06,
                    width: size.width * 0.06,
                    decoration: BoxDecoration(
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: size.width * 0.04,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.009),
          Text(
            "Lexa_Bravo",
            style: TextStyle(
              color: textC,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSettingTile({
    required Size size,
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
        height: size.height * 0.1115,
        padding: EdgeInsets.symmetric(horizontal: size.width * 0.05),
        decoration: BoxDecoration(
          color: cardBg,
          borderRadius: BorderRadius.circular(size.width * 0.07),
        ),
        child: Row(
          children: [
            Container(
              height: size.width * 0.11,
              width: size.width * 0.11,
              decoration: BoxDecoration(
                color: textC.withOpacity(0.08),
                borderRadius: BorderRadius.circular(size.width * 0.03),
              ),
              child: Icon(
                icon,
                color: primary,
                size: size.width * 0.06,
              ),
            ),
            SizedBox(width: size.width * 0.03),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: textC,
                      fontSize: size.width * 0.045,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  SizedBox(height: size.height * 0.003),
                  Text(
                    subtitle,
                    style: TextStyle(
                      color: textC.withOpacity(0.4),
                      fontSize: size.width * 0.032,
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
                size: size.width * 0.05,
              ),
            if (showSwitch)
              Transform.scale(
                scale: size.width * 0.0025,
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

  Widget _buildLogoutButton(Size size, Color primary, Color cardBg) {
    return GestureDetector(
      onTap: () => LogoutDialog.show(context),
      child: Container(
        width: double.infinity,
        height: size.height * 0.073,
        decoration: BoxDecoration(
          color: primary.withOpacity(0.1),
          borderRadius: BorderRadius.circular(size.width * 0.09),
          border: Border.all(
            color: primary.withOpacity(0.5),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            "Logout",
            style: TextStyle(
              color: primary,
              fontSize: size.width * 0.05,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
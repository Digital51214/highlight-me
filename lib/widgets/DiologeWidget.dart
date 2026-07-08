//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/auth_screen/login_screen.dart';
//
// import '../Contollers/auth_controller.dart';
// import '../Services/session_manager.dart';
//
// class LogoutDialog extends StatelessWidget {
//   final bool isDelete;
//
//   const LogoutDialog({super.key, this.isDelete = false});
//
//   static Future<void> show(BuildContext context, {bool isDelete = false}) {
//     return showDialog(
//       context: context,
//       barrierDismissible: true,
//       // Barrier color ko bhi theme ke mutabiq dark rakha hai
//       barrierColor: Colors.black.withValues(alpha: 0.7),
//       builder: (_) => LogoutDialog(isDelete: isDelete),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final double w = size.width;
//     final double h = size.height;
//
//     // Theme references
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color dialogBg = Theme.of(context).cardColor;
//
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.symmetric(horizontal: w * 0.07),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: dialogBg,
//           borderRadius: BorderRadius.circular(28),
//           border: Border.all(
//             color: primaryColor.withValues(alpha: 0.18),
//             width: 1.2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withValues(alpha: 0.2),
//               blurRadius: 30,
//               offset: const Offset(0, 10),
//             ),
//           ],
//         ),
//         padding: EdgeInsets.symmetric(
//           horizontal: w * 0.07,
//           vertical: h * 0.035,
//         ),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             // Top Icon Container
//             Container(
//               width: w * 0.2,
//               height: w * 0.2,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: primaryColor.withValues(alpha: 0.12),
//                 border: Border.all(
//                   color: primaryColor.withValues(alpha: 0.30),
//                   width: 2,
//                 ),
//               ),
//               child: Icon(
//                 isDelete ? Icons.delete_forever_rounded : Icons.logout_rounded,
//                 color: primaryColor,
//                 size: w * 0.1,
//               ),
//             ),
//
//             SizedBox(height: h * 0.025),
//
//             Text(
//               isDelete ? 'Delete Account' : 'Logout',
//               style: TextStyle(
//                 fontSize: w * 0.058,
//                 fontWeight: FontWeight.w800,
//                 color: textColor,
//                 letterSpacing: -0.3,
//               ),
//             ),
//
//             SizedBox(height: h * 0.012),
//
//             Text(
//               isDelete
//                   ? 'Are you sure you want to\ndelete your account? This\ncannot be undone.'
//                   : 'Are you sure you want to\nlog out of your account?',
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                 fontSize: w * 0.038,
//                 fontWeight: FontWeight.w400,
//                 color: textColor.withValues(alpha: 0.6),
//                 height: 1.5,
//               ),
//             ),
//
//             SizedBox(height: h * 0.035),
//
//             Row(
//               children: [
//                 // Cancel Button
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       height: h * 0.062,
//                       decoration: BoxDecoration(
//                         color: textColor.withValues(alpha: 0.05),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: textColor.withValues(alpha: 0.1),
//                           width: 1.2,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(
//                             fontSize: w * 0.04,
//                             fontWeight: FontWeight.w600,
//                             color: textColor.withValues(alpha: 0.7),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(width: w * 0.04),
//
//                 // Confirm Action Button
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       // Logout Confirm Button Click logic handler
//                       Future<void> handleAppLogout() async {
//                         // 1. SharedPreferences saaf karein (Disk Flush)
//                         await SessionManager.instance.clearSession();
//
//                         // 2. RAM Controller Memory clean karein (Crucial Reset)
//                         if (Get.isRegistered<AuthController>()) {
//                           final auth = Get.find<AuthController>();
//                           auth.userName.value = '';
//                           auth.userBio.value = '';
//                           auth.userAvatar.value = '';
//                           auth.userAvatarLocalPath.value = '';
//
//                           // Stats reset
//                           auth.likesCount.value = 0;
//                           auth.commentsCount.value = 0;
//                           auth.sharesCount.value = 0;
//                           auth.userRank.value = 0;
//                           auth.foodSupport.value = 0;
//                           auth.transportSupport.value = 0;
//                           auth.cashReward.value = 0;
//                         }
//
//                         // 3. Direct Splash/Login Screen par bhej dein flush stack ke sath
//                         Get.offAllNamed('/login'); // Ya jo bhi aapki login screen ka path h
//                       }
//                       // Navigator.pop(context) zaroori hai dialog band karne ke liye
//                       Navigator.pop(context);
//                       // Get.offAll(() => const LoginScreen());
//                       Get.find<AuthController>().logout();
//                       if (isDelete) {
//                         // TODO: Add delete account logic
//                       } else {
//                         // TODO: Add logout logic
//                       }
//                     },
//                     child: Container(
//                       height: h * 0.062,
//                       decoration: BoxDecoration(
//                         color: primaryColor,
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: primaryColor.withValues(alpha: 0.25),
//                             blurRadius: 12,
//                             offset: const Offset(0, 5),
//                           ),
//                         ],
//                       ),
//                       child: Center(
//                         child: Text(
//                           isDelete ? 'Delete' : 'Logout',
//                           style: TextStyle(
//                             fontSize: w * 0.04,
//                             fontWeight: FontWeight.w700,
//                             // Button text color dark background par white/dark switch
//                             color: Colors.white,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/auth_screen/login_screen.dart';
import '../Contollers/auth_controller.dart';
import '../Services/session_manager.dart';

class LogoutDialog extends StatelessWidget {
  final bool isDelete;

  const LogoutDialog({super.key, this.isDelete = false});

  static Future<void> show(BuildContext context, {bool isDelete = false}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.7),
      builder: (_) => LogoutDialog(isDelete: isDelete),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color dialogBg = Theme.of(context).cardColor;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: w * (26.25 / 375)), // size.width * 0.07 mapped
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: dialogBg,
          borderRadius: BorderRadius.circular(w * (28.0 / 375)), // Dynamic corner scaling
          border: Border.all(
            color: primaryColor.withOpacity(0.18),
            width: w * (1.2 / 375),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: w * (30.0 / 375),
              offset: Offset(0, h * (10.0 / 810)),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: w * (26.25 / 375), // size.width * 0.07 mapped
          vertical: h * (28.35 / 810),   // size.height * 0.035 mapped
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Icon Container
            Container(
              width: w * (75.0 / 375),  // size.width * 0.2 mapped
              height: w * (75.0 / 375), // Sync width & height to maintain clean circular aspect bounds
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withOpacity(0.12),
                border: Border.all(
                  color: primaryColor.withOpacity(0.30),
                  width: w * (2.0 / 375),
                ),
              ),
              child: Icon(
                isDelete ? Icons.delete_forever_rounded : Icons.logout_rounded,
                color: primaryColor,
                size: w * (37.5 / 375), // size.width * 0.1 mapped
              ),
            ),

            SizedBox(height: h * (20.25 / 810)),

            Text(
              isDelete ? 'Delete Account' : 'Logout',
              style: TextStyle(
                fontSize: w * (21.75 / 375), // size.width * 0.058 mapped
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -0.3,
              ),
            ),

            SizedBox(height: h * (9.72 / 810)),

            Text(
              isDelete
                  ? 'Are you sure you want to\ndelete your account? This\ncannot be undone.'
                  : 'Are you sure you want to\nlog out of your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * (14.25 / 375), // size.width * 0.038 mapped
                fontWeight: FontWeight.w400,
                color: textColor.withOpacity(0.6),
                height: 1.5,
              ),
            ),

            SizedBox(height: h * (28.35 / 810)),

            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: h * (50.22 / 810), // size.height * 0.062 mapped
                      decoration: BoxDecoration(
                        color: textColor.withOpacity(0.05),
                        borderRadius: BorderRadius.circular(w * (16.0 / 375)),
                        border: Border.all(
                          color: textColor.withOpacity(0.1),
                          width: w * (1.2 / 375),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: w * (15.0 / 375), // size.width * 0.04 mapped
                            fontWeight: FontWeight.w600,
                            color: textColor.withOpacity(0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: w * (15.0 / 375)), // size.width * 0.04 mapped

                // Confirm Action Button (FIXED INLINE ASYNC)
                Expanded(
                  child: GestureDetector(
                    onTap: () async {
                      Navigator.pop(context);

                      if (isDelete) {
                        // TODO: Add delete account api logic here if needed
                      } else {
                        await SessionManager.instance.clearSession();

                        if (Get.isRegistered<AuthController>()) {
                          final auth = Get.find<AuthController>();
                          auth.userName.value = '';
                          auth.userBio.value = '';
                          auth.userAvatar.value = '';
                          auth.userAvatarLocalPath.value = '';

                          auth.likesCount.value = 0;
                          auth.commentsCount.value = 0;
                          auth.sharesCount.value = 0;
                          auth.userRank.value = 0;
                          auth.foodSupport.value = 0;
                          auth.transportSupport.value = 0;
                          auth.cashReward.value = 0;
                        }

                        Get.offAll(() => const LoginScreen(), transition: Transition.noTransition);
                      }
                    },
                    child: Container(
                      height: h * (50.22 / 810), // size.height * 0.062 mapped
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(w * (16.0 / 375)),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withOpacity(0.25),
                            blurRadius: w * (12.0 / 375),
                            offset: Offset(0, h * (5.0 / 810)),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          isDelete ? 'Delete' : 'Logout',
                          style: TextStyle(
                            fontSize: w * (15.0 / 375), // size.width * 0.04 mapped
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
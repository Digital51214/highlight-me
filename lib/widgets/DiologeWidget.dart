// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/auth_screen/login_screen.dart';
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
//       barrierColor: Colors.black.withValues(alpha:0.65),
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
//     return Dialog(
//       backgroundColor: Colors.transparent,
//       insetPadding: EdgeInsets.symmetric(horizontal: w * 0.07),
//       child: Container(
//         width: double.infinity,
//         decoration: BoxDecoration(
//           color: const Color(0xff1A1D21),
//           borderRadius: BorderRadius.circular(28),
//           border: Border.all(
//             color: const Color(0xff2CCBFF).withValues(alpha:0.18),
//             width: 1.2,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: const Color(0xff2CCBFF).withValues(alpha:0.08),
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
//             Container(
//               width: w * 0.2,
//               height: w * 0.2,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: const Color(0xff20353A),
//                 border: Border.all(
//                   color: const Color(0xff2CCBFF).withValues(alpha:0.30),
//                   width: 2,
//                 ),
//               ),
//               child: Icon(
//                 isDelete ? Icons.delete_forever_rounded : Icons.logout_rounded,
//                 color: const Color(0xff36C4F1),
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
//                 color: Colors.white,
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
//                 color: Colors.white.withValues(alpha:0.6),
//                 height: 1.5,
//               ),
//             ),
//
//             SizedBox(height: h * 0.035),
//
//             Row(
//               children: [
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () => Navigator.pop(context),
//                     child: Container(
//                       height: h * 0.062,
//                       decoration: BoxDecoration(
//                         color: const Color(0xff2A2E33),
//                         borderRadius: BorderRadius.circular(16),
//                         border: Border.all(
//                           color: Colors.white.withValues(alpha:0.08),
//                           width: 1.2,
//                         ),
//                       ),
//                       child: Center(
//                         child: Text(
//                           'Cancel',
//                           style: TextStyle(
//                             fontSize: w * 0.04,
//                             fontWeight: FontWeight.w600,
//                             color: Colors.white70,
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(width: w * 0.04),
//
//                 Expanded(
//                   child: GestureDetector(
//                     onTap: () {
//                       Navigator.push(
//                           context, MaterialPageRoute(
//                           builder: (context)=> LoginScreen())
//                       );
//
//                       if (isDelete) {
//                         // TODO: Add delete account logic here
//                       } else {
//                         // TODO: Add logout logic here
//                       }
//                     },
//                     child: Container(
//                       height: h * 0.062,
//                       decoration: BoxDecoration(
//                         color: const Color(0xff36C4F1),
//                         borderRadius: BorderRadius.circular(16),
//                         boxShadow: [
//                           BoxShadow(
//                             color: const Color(0xff36C4F1).withValues(alpha:0.25),
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
//                             color: const Color(0xff0F1012),
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

class LogoutDialog extends StatelessWidget {
  final bool isDelete;

  const LogoutDialog({super.key, this.isDelete = false});

  static Future<void> show(BuildContext context, {bool isDelete = false}) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      // Barrier color ko bhi theme ke mutabiq dark rakha hai
      barrierColor: Colors.black.withValues(alpha: 0.7),
      builder: (_) => LogoutDialog(isDelete: isDelete),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final double w = size.width;
    final double h = size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color dialogBg = Theme.of(context).cardColor;

    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: EdgeInsets.symmetric(horizontal: w * 0.07),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: dialogBg,
          borderRadius: BorderRadius.circular(28),
          border: Border.all(
            color: primaryColor.withValues(alpha: 0.18),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.2),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: w * 0.07,
          vertical: h * 0.035,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Top Icon Container
            Container(
              width: w * 0.2,
              height: w * 0.2,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: primaryColor.withValues(alpha: 0.12),
                border: Border.all(
                  color: primaryColor.withValues(alpha: 0.30),
                  width: 2,
                ),
              ),
              child: Icon(
                isDelete ? Icons.delete_forever_rounded : Icons.logout_rounded,
                color: primaryColor,
                size: w * 0.1,
              ),
            ),

            SizedBox(height: h * 0.025),

            Text(
              isDelete ? 'Delete Account' : 'Logout',
              style: TextStyle(
                fontSize: w * 0.058,
                fontWeight: FontWeight.w800,
                color: textColor,
                letterSpacing: -0.3,
              ),
            ),

            SizedBox(height: h * 0.012),

            Text(
              isDelete
                  ? 'Are you sure you want to\ndelete your account? This\ncannot be undone.'
                  : 'Are you sure you want to\nlog out of your account?',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: w * 0.038,
                fontWeight: FontWeight.w400,
                color: textColor.withValues(alpha: 0.6),
                height: 1.5,
              ),
            ),

            SizedBox(height: h * 0.035),

            Row(
              children: [
                // Cancel Button
                Expanded(
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      height: h * 0.062,
                      decoration: BoxDecoration(
                        color: textColor.withValues(alpha: 0.05),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: textColor.withValues(alpha: 0.1),
                          width: 1.2,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w600,
                            color: textColor.withValues(alpha: 0.7),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(width: w * 0.04),

                // Confirm Action Button
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // Navigator.pop(context) zaroori hai dialog band karne ke liye
                      Navigator.pop(context);
                      Get.offAll(() => const LoginScreen());

                      if (isDelete) {
                        // TODO: Add delete account logic
                      } else {
                        // TODO: Add logout logic
                      }
                    },
                    child: Container(
                      height: h * 0.062,
                      decoration: BoxDecoration(
                        color: primaryColor,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: primaryColor.withValues(alpha: 0.25),
                            blurRadius: 12,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          isDelete ? 'Delete' : 'Logout',
                          style: TextStyle(
                            fontSize: w * 0.04,
                            fontWeight: FontWeight.w700,
                            // Button text color dark background par white/dark switch
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
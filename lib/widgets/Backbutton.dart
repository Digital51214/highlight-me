// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
//
// class CustomBackButtonWidget extends StatelessWidget {
//   const CustomBackButtonWidget({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Container(
//       height: size.width * 0.135,
//       width: size.width * 0.135,
//       decoration: BoxDecoration(
//         shape: BoxShape.circle,
//         color: const Color(0xff1A2A31),
//         border: Border.all(
//           color: const Color(0xff6F8C98).withValues(alpha: 0.5),
//           width: size.width * 0.0025,
//         ),
//       ),
//       child: IconButton(
//         onPressed: () {
//           Get.back();
//         },
//         icon: Icon(
//           Icons.arrow_back_ios_new_rounded,
//           color: Colors.white,
//           size: size.width * 0.06,
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomBackButtonWidget extends StatelessWidget {
  const CustomBackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme colors
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color iconColor = Theme.of(context).canvasColor;

    return Theme.of(context).brightness == Brightness.dark
        ? /* --- DARK THEME: Scaled Image Asset --- */
    GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Image.asset(
        'assets/images/icon.arrow.png',
        height: h * (48.0 / 810), // Normalized from absolute 48
        width: w * (48.0 / 375),  // Normalized from absolute 48
        fit: BoxFit.contain,
      ),
    )
        : /* --- LIGHT THEME: Custom Responsive Circle Button Style --- */
    GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: w * (45.0 / 375), // Synchronized with height scaling using width factor to keep perfect circle
        width: w * (45.0 / 375),  // Mapped from size.width * 0.12 scaling metrics
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Theme.of(context).primaryColor.withOpacity(0.15),
          border: Border.all(
            color: Theme.of(context).primaryColor.withOpacity(0.3),
            width: w * (0.9375 / 375), // Mapped from size.width * 0.0025
          ),
        ),
        child: Center(
          child: Icon(
            Icons.arrow_back_ios_new,
            color: Theme.of(context).canvasColor,
            size: w * (20.625 / 375), // Scaled cleanly down from raw 22 point mapping
          ),
        ),
      ),
    );
  }
}
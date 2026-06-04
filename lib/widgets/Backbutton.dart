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
    final size = MediaQuery.of(context).size;

    // Theme colors
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color iconColor = Theme.of(context).canvasColor;

    return Container(
      height: size.width * 0.135,
      width: size.width * 0.135,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        // Primary color ka halka shade background ke liye
        color: primaryColor.withOpacity(0.15),
        border: Border.all(
          color: primaryColor.withOpacity(0.3),
          width: size.width * 0.0025,
        ),
      ),
      child: IconButton(
        onPressed: () {
          Get.back();
        },
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: iconColor, // Theme ke mutabiq black ya white
          size: size.width * 0.05, // Thora sa chota kiya taake sophisticated lage
        ),
      ),
    );
  }
}
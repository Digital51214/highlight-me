// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
// class RoundButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onTap;
//
//   const RoundButton({super.key, required this.text, required this.onTap});
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//
//     return
//       GestureDetector(
//       onTap: onTap,
//       child: Container(
//         width: 333,
//         height: 45,
//         decoration: BoxDecoration(
//           color: const Color(0xFF4F98A7),
//           borderRadius: BorderRadius.circular(screenWidth * 0.1),
//         ),
//         child: Center(
//           child: Row(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 text,
//                 style: GoogleFonts.inter(
//                   fontSize: 16,
//                   fontWeight: FontWeight.w700,
//                   color: Colors.white,
//                   fontStyle: FontStyle.italic,
//                 ),
//               ),
//               const SizedBox(width: 6),
//
//               /// 👉 Arrow Icon
//               const Icon(
//                 Icons.arrow_forward,
//                 color: Colors.white,
//                 size: 18,
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const RoundButton({super.key, required this.text, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Theme Reference
    final Color primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 333,
        height: 45,
        decoration: BoxDecoration(
          color: primaryColor, // Ab ye theme se color uthayega
          borderRadius: BorderRadius.circular(screenWidth * 0.1),
        ),
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.white, // Button text white hi rahega contrast ke liye
                  fontStyle: FontStyle.italic,
                ),
              ),
              const SizedBox(width: 6),

              /// 👉 Arrow Icon
              const Icon(
                Icons.arrow_forward,
                color: Colors.white,
                size: 18,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
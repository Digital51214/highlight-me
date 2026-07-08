// import 'package:flutter/material.dart';
//
// class ElevatedButton1 extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//
//   const ElevatedButton1({
//     super.key,
//     required this.text,
//     required this.onPressed,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return SizedBox(
//       width: double.infinity,
//       height: size.height * 0.058,
//       child: Material(
//         color: Colors.transparent,
//         shadowColor: Colors.transparent,
//         surfaceTintColor: Colors.transparent,
//         child: InkWell(
//           onTap: onPressed,
//           borderRadius: BorderRadius.circular(30),
//           splashColor: Colors.transparent,
//           highlightColor: Colors.transparent,
//           child: Ink(
//             decoration: BoxDecoration(
//               color: const Color(0xff4F98A7),
//               borderRadius: BorderRadius.circular(30),
//             ),
//             child: Container(
//               alignment: Alignment.center,
//               child: Text(
//                 text,
//                 style: const TextStyle(
//                   fontSize: 14,
//                   fontWeight: FontWeight.bold,
//                   fontFamily: "poppinbold",
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class ElevatedButton1 extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const ElevatedButton1({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      width: double.infinity,
      height: h * (46.98 / 810), // Evaluated from size.height * 0.058 scaling metrics
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(w * (30.0 / 375)), // Dynamic corner radius scaling
          // Subtle feedback for better UX
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Ink(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(w * (30.0 / 375)),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: w * (12.0 / 375),
                  offset: Offset(0, h * (4.0 / 810)),
                ),
              ],
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: TextStyle(
                  fontSize: w * (14.0 / 375), // Normalized text scaling from raw 14 points
                  fontWeight: FontWeight.bold,
                  fontFamily: "poppinbold",
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
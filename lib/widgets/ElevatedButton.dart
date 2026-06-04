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
    final size = MediaQuery.of(context).size;

    // Theme references
    final Color primaryColor = Theme.of(context).primaryColor;

    return SizedBox(
      width: double.infinity,
      height: size.height * 0.058,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(30),
          // Subtle feedback for better UX
          splashColor: Colors.white.withOpacity(0.1),
          highlightColor: Colors.white.withOpacity(0.05),
          child: Ink(
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color: primaryColor.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Container(
              alignment: Alignment.center,
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 14,
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
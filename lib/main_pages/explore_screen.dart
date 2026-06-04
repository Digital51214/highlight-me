// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/main_pages/home_screen.dart';
//
// class ExploreScreen extends StatefulWidget {
//   const ExploreScreen({super.key});
//
//   @override
//   State<ExploreScreen> createState() => _ExploreScreenState();
// }
//
// class _ExploreScreenState extends State<ExploreScreen> {
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(child: SingleChildScrollView(
//        child: Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: [
//            Padding(
//              padding: EdgeInsets.symmetric(
//                horizontal:w * 0.055,
//                vertical: h * 0.012,
//              ),
//              child: Text(
//                "Explore Screen",
//                style: GoogleFonts.inter(
//                  color: Colors.white,
//                  fontSize: 26,
//                  fontWeight: FontWeight.w900,
//                ),
//              ),
//            ),
//            const SizedBox(height: 5),
//            ReelsScreen(),
//          ],
//        ),
//       ),
//
//       ),
//     );
//   }
// }
//
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/main_pages/home_screen.dart';

class ExploreScreen extends StatefulWidget {
  const ExploreScreen({super.key});

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal:w * 0.055,
                vertical: h * 0.012,
              ),
              child: Text(
                "Explore Screen",
                style: GoogleFonts.inter(
                  color: Theme.of(context).canvasColor, // Changed to Theme
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
            const SizedBox(height: 5),
            ReelsScreen(),
          ],
        ),
      ),

      ),
    );
  }
}
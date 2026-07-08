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
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * (20.625 / 375), // 0.055 scaled proportionally
                  vertical: h * (9.72 / 810),    // 0.012 scaled proportionally
                ),
                child: Text(
                  "Explore Screen",
                  style: GoogleFonts.inter(
                    color: Theme.of(context).canvasColor,
                    fontSize: w * (26.0 / 375),  // Text font-size optimized for scale
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              SizedBox(height: h * (5.0 / 810)), // Explicit layout gap converted
              const ReelsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
//
//
// class LiveScreen extends StatelessWidget {
//   const LiveScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned.fill(
//             child: Image.asset(
//               'assets/images/live_bg.png',
//               fit: BoxFit.cover,
//             ),
//           ),
//           Positioned(
//             top: 60,
//             left: 20,
//             right: 20,
//             child: Row(
//               children: [
//                 // LIVE Badge
//                 _glassContainer(
//                   color: Colors.red.withValues(alpha:0.8),
//                   child: const Text("● LIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
//                 ),
//                 const SizedBox(width: 10),
//                 _glassContainer(
//                   child: Row(
//                     children: const [
//                       Icon(Icons.visibility_outlined, color: Colors.white, size: 18),
//                       SizedBox(width: 5),
//                       Text("14.2K", style: TextStyle(color: Colors.white)),
//                     ],
//                   ),
//                 ),
//                 const Spacer(),
//                 _glassContainer(
//                   child: const Text("End Live", style: TextStyle(color: Colors.white)),
//                 ),
//               ],
//             ),
//           ),
//           Positioned(
//             top: 120,
//             left: 20,
//             child: Row(
//               children: [
//                 SizedBox(
//                   width: 80,
//                   height: 40,
//                   child: Stack(
//                     children: [
//                       _stackedAvatar('assets/images/l1.png', 0),
//                       _stackedAvatar('assets/images/h3.png', 20),
//                       _stackedAvatar('assets/images/h2.png', 40),
//                     ],
//                   ),
//                 ),
//                Text(
//                   "8 Followers active now",
//                   style: GoogleFonts.inter(color: Colors.white, fontSize: 9, shadows: [Shadow(blurRadius: 10, color: Colors.black45)]),
//                 )
//               ],
//             ),
//           ),
//
//           /// 4. Comments Section
//           Positioned(
//             bottom: 140,
//             left: 20,
//             right: 20,
//             child: Column(
//               children: [
//                 _commentBox("Charlie Thorne", "Highlighting this Moment ❤️", 'assets/images/h1.png'),
//                 const SizedBox(height: 12),
//                 _commentBox("Kiara Patel", "Play that new track from the album..", 'assets/images/h2.png'),
//                 const SizedBox(height: 12),
//                 _commentBox("Jimen Sort", "The lighting in this set is absolutely incredible.", 'assets/images/h3.png'),
//               ],
//             ),
//           ),
//
//           /// 5. Bottom Action Button (Capture/Shutter)
//           Positioned(
//             bottom: 40,
//             left: 0,
//             right: 0,
//             child: Center(
//               child: Container(
//                 padding: const EdgeInsets.all(4),
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   border: Border.all(color: Colors.white, width: 4),
//                 ),
//                 child: Container(
//                   height: 60,
//                   width: 60,
//                   decoration: const BoxDecoration(
//                     color: Color(0xFFD9D9D9), // Light greyish color from image
//                     shape: BoxShape.circle,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   // Helper: Translucent Rounded Container
//   Widget _glassContainer({required Widget child, Color? color}) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       decoration: BoxDecoration(
//         color: color ?? Colors.black.withValues(alpha:0.4),
//         borderRadius: BorderRadius.circular(25),
//       ),
//       child: child,
//     );
//   }
//
//   // Helper: Overlapping Avatars
//   Widget _stackedAvatar(String img, double leftPadding) {
//     return Positioned(
//       left: leftPadding,
//       child: Container(
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           border: Border.all(color: Color(0xFF171717).withValues(alpha: 60), width: 1),
//         ),
//         child: CircleAvatar(
//           radius: 18,
//           backgroundImage: AssetImage(img),
//         ),
//       ),
//     );
//   }
//
//   // Helper: Chat/Comment Box
//   Widget _commentBox(String name, String msg, String img) {
//     return Container(
//       padding: const EdgeInsets.all(12),
//       decoration: BoxDecoration(
//         color: Colors.black.withValues(alpha:0.5), // Match the dark tint in the UI
//         borderRadius: BorderRadius.circular(15),
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           CircleAvatar(radius: 20, backgroundImage: AssetImage(img)),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(name, style:GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.w600, fontSize: 13)),
//                 const SizedBox(height: 2),
//                 Text(msg, style:GoogleFonts.inter(color: Colors.white70, fontSize: 11,fontWeight: FontWeight.w400), maxLines: 2, overflow: TextOverflow.ellipsis),
//               ],
//             ),
//           )
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LiveScreen extends StatelessWidget {
  const LiveScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/live_bg.png',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 60,
            left: 20,
            right: 20,
            child: Row(
              children: [
                // LIVE Badge
                _glassContainer(
                  color: Colors.red.withOpacity(0.8),
                  child: const Text("● LIVE", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(width: 10),
                _glassContainer(
                  child: Row(
                    children: const [
                      Icon(Icons.visibility_outlined, color: Colors.white, size: 18),
                      SizedBox(width: 5),
                      Text("14.2K", style: TextStyle(color: Colors.white)),
                    ],
                  ),
                ),
                const Spacer(),
                _glassContainer(
                  child: const Text("End Live", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          ),
          Positioned(
            top: 120,
            left: 20,
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                  height: 40,
                  child: Stack(
                    children: [
                      _stackedAvatar(context, 'assets/images/l1.png', 0),
                      _stackedAvatar(context, 'assets/images/h3.png', 20),
                      _stackedAvatar(context, 'assets/images/h2.png', 40),
                    ],
                  ),
                ),
                Text(
                  "8 Followers active now",
                  style: GoogleFonts.inter(
                      color: Colors.white,
                      fontSize: 9,
                      shadows: [Shadow(blurRadius: 10, color: Colors.black45)]
                  ),
                )
              ],
            ),
          ),

          /// 4. Comments Section
          Positioned(
            bottom: 140,
            left: 20,
            right: 20,
            child: Column(
              children: [
                _commentBox(context, "Charlie Thorne", "Highlighting this Moment ❤️", 'assets/images/h1.png'),
                const SizedBox(height: 12),
                _commentBox(context, "Kiara Patel", "Play that new track from the album..", 'assets/images/h2.png'),
                const SizedBox(height: 12),
                _commentBox(context, "Jimen Sort", "The lighting in this set is absolutely incredible.", 'assets/images/h3.png'),
              ],
            ),
          ),

          /// 5. Bottom Action Button (Capture/Shutter)
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Center(
              child: Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 4),
                ),
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: Color(0xFFD9D9D9),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper: Translucent Rounded Container
  Widget _glassContainer({required Widget child, Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color ?? Colors.black.withOpacity(0.4),
        borderRadius: BorderRadius.circular(25),
      ),
      child: child,
    );
  }

  // Helper: Overlapping Avatars
  Widget _stackedAvatar(BuildContext context, String img, double leftPadding) {
    return Positioned(
      left: leftPadding,
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.6),
              width: 1
          ),
        ),
        child: CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage(img),
        ),
      ),
    );
  }

  // Helper: Chat/Comment Box
  Widget _commentBox(BuildContext context, String name, String msg, String img) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.5),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(radius: 20, backgroundImage: AssetImage(img)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.inter(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 13
                    )
                ),
                const SizedBox(height: 2),
                Text(msg,
                    style: GoogleFonts.inter(
                        color: Colors.white70,
                        fontSize: 11,
                        fontWeight: FontWeight.w400
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
//
// void main() => runApp(const ChatApp());
//
// class ChatApp extends StatelessWidget {
//   const ChatApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         brightness: Brightness.dark,
//         scaffoldBackgroundColor: const Color(0xFF121212),
//         // Inter font set globally
//         textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
//       ),
//       home: const ChatScreen(),
//     );
//   }
// }
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color(0xFF1E1E1E),
//         elevation: 0,
//         leading: GestureDetector( onTap:(){
//           Get.back();
//         },child: const Icon(Icons.arrow_back_ios_new, size: 20)),
//         title: Row(
//           children: [
//      CircleAvatar(
//               radius: 20,
//               backgroundColor: Colors.grey,
//               child: Image.asset('assets/images/ch1.png'),
//             ),
//             const SizedBox(width: 12),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   'Ben Thompson',
//                   style: GoogleFonts.inter(
//                     fontWeight: FontWeight.w600, // SemiBold
//                     fontSize: 16,
//                   ),
//                 ),
//                 Text(
//                   'Active Now',
//                   style: GoogleFonts.inter(
//                     color: AppColors.lightblue,
//                     fontWeight: FontWeight.w400, // Regular
//                     fontSize: 12,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: const [
//           Icon(Icons.videocam_outlined),
//           SizedBox(width: 15),
//           Icon(Icons.phone_outlined),
//           SizedBox(width: 15),
//           Icon(Icons.info_outline),
//           SizedBox(width: 15),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: ListView(
//               padding: const EdgeInsets.all(16),
//               children: [
//                 Center(
//                   child: Container(
//                     padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
//                     decoration: BoxDecoration(
//                       color: Colors.white10,
//                       borderRadius: BorderRadius.circular(12),
//                     ),
//                     child: Text('TODAY',
//                         style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: Colors.grey)),
//                   ),
//                 ),
//                 const SizedBox(height: 20),
//
//                 // Received Message
//                 _buildReceivedMessage("YO! Are you heading to that rooftop session tonight? I heard the lighting is going to be insane for the shots."),
//
//                 // Sent Message
//                 _buildSentMessage("Absolutely. Just Chargin the gimbal now. What time are we meeting? and what details u just share me."),
//
//                 // Image Message (Placeholder)
//                 _buildImageMessage(),
//
//                 _buildReceivedMessage("OK! i am sharing u an image take an inspiration and shot like this."),
//
//                 _buildSentMessage("Bet, I'm in."),
//
//                 _buildReceivedMessage("Sounds Good!"),
//
//                 // Typing Indicator
//                 Align(
//                   alignment: Alignment.centerLeft,
//                   child: Container(
//                     margin: const EdgeInsets.only(top: 8),
//                     padding: const EdgeInsets.all(12),
//                     decoration: BoxDecoration(color: Colors.white10, borderRadius: BorderRadius.circular(15)),
//                     child: const Icon(Icons.more_horiz, size: 20),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           // Bottom Input Field
//           _buildInputArea(),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildReceivedMessage(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           CircleAvatar(
//             radius: 12,
//             backgroundImage: AssetImage('assets/images/ch1.png'),
//           ),
//           const SizedBox(width: 8),
//           Flexible(
//             child: Container(
//               padding: const EdgeInsets.all(14),
//               decoration: const BoxDecoration(
//                 color: Color(0xFF262626),
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(18),
//                   topRight: Radius.circular(18),
//                   bottomRight: Radius.circular(18),
//                 ),
//               ),
//               child: Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w400, fontSize: 14)),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSentMessage(String text) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 15, left: 50),
//       child: Align(
//         alignment: Alignment.centerRight,
//         child: Container(
//           padding: const EdgeInsets.all(14),
//           decoration: const BoxDecoration(
//             color: Color(0xFF4A8C9C), // Teal color from image
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(18),
//               topRight: Radius.circular(18),
//               bottomLeft: Radius.circular(18),
//             ),
//           ),
//           child: Text(text, style: GoogleFonts.inter(fontWeight: FontWeight.w500, fontSize: 14, color: Colors.white)),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildImageMessage() {
//     return Align(
//       alignment: Alignment.centerLeft,
//       child: Container(
//         margin: const EdgeInsets.only(left: 32, bottom: 10),
//         height: 200,
//         width: 180,
//         decoration: BoxDecoration(
//           color: Colors.grey[900],
//           borderRadius: BorderRadius.circular(15),
//           // image: DecorationImage(image: AssetImage('assets/inspiration.jpg'), fit: BoxFit.cover),
//         ),
//         child: Center(child: Image.asset('assets/images/ch2.png')),
//       ),
//     );
//   }
//
//   Widget _buildInputArea() {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       decoration: const BoxDecoration(color: Colors.black),
//       child: Row(
//         children: [
//           const Icon(Icons.add_circle_outline, color: Colors.grey, size: 28),
//           const SizedBox(width: 12),
//           Expanded(
//             child: Container(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               decoration: BoxDecoration(
//                 color: const Color(0xFF1E1E1E),
//                 borderRadius: BorderRadius.circular(25),
//               ),
//               child: TextField(
//                 decoration: InputDecoration(
//                   hintText: "Say Something...",
//                   hintStyle: GoogleFonts.inter(color: Colors.grey, fontWeight: FontWeight.w400),
//                   border: InputBorder.none,
//                   suffixIcon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
//                 ),
//               ),
//             ),
//           ),
//           const SizedBox(width: 12),
//           const CircleAvatar(
//             backgroundColor:AppColors.lightblue,
//             child: Icon(Icons.send, color: Colors.white, size: 18),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';

class ChatApp extends StatelessWidget {
  const ChatApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Note: Theme data should be managed in your main entry point
    return const ChatScreen();
  }
}

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor, // Changed to Theme
        elevation: 0,
        leading: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: Icon(Icons.arrow_back_ios_new,
                size: 20, color: Theme.of(context).canvasColor)), // Changed
        title: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey,
              child: Image.asset('assets/images/ch1.png'),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Ben Thompson',
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).canvasColor, // Changed to Theme
                  ),
                ),
                Text(
                  'Active Now',
                  style: GoogleFonts.inter(
                    color: Theme.of(context).primaryColor, // Changed to Theme
                    fontWeight: FontWeight.w400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Icon(Icons.videocam_outlined, color: Theme.of(context).canvasColor),
          const SizedBox(width: 15),
          Icon(Icons.phone_outlined, color: Theme.of(context).canvasColor),
          const SizedBox(width: 15),
          Icon(Icons.info_outline, color: Theme.of(context).canvasColor),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Center(
                  child: Container(
                    padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: Theme.of(context).canvasColor.withOpacity(0.1), // Changed
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('TODAY',
                        style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey)),
                  ),
                ),
                const SizedBox(height: 20),

                // Received Message
                _buildReceivedMessage(context,
                    "YO! Are you heading to that rooftop session tonight? I heard the lighting is going to be insane for the shots."),

                // Sent Message
                _buildSentMessage(context,
                    "Absolutely. Just Chargin the gimbal now. What time are we meeting? and what details u just share me."),

                // Image Message
                _buildImageMessage(context),

                _buildReceivedMessage(context,
                    "OK! i am sharing u an image take an inspiration and shot like this."),

                _buildSentMessage(context, "Bet, I'm in."),

                _buildReceivedMessage(context, "Sounds Good!"),

                // Typing Indicator
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.only(top: 8),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                        color: Theme.of(context).cardColor, // Changed
                        borderRadius: BorderRadius.circular(15)),
                    child: Icon(Icons.more_horiz,
                        size: 20, color: Theme.of(context).canvasColor),
                  ),
                ),
              ],
            ),
          ),

          // Bottom Input Field
          _buildInputArea(context),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundImage: AssetImage('assets/images/ch1.png'),
          ),
          const SizedBox(width: 8),
          Flexible(
            child: Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, // Changed to Theme
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(18),
                  topRight: Radius.circular(18),
                  bottomRight: Radius.circular(18),
                ),
              ),
              child: Text(text,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Theme.of(context).canvasColor)), // Changed
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentMessage(BuildContext context, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15, left: 50),
      child: Align(
        alignment: Alignment.centerRight,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor, // Changed to Theme
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(18),
              topRight: Radius.circular(18),
              bottomLeft: Radius.circular(18),
            ),
          ),
          child: Text(text,
              style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                  color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildImageMessage(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(left: 32, bottom: 10),
        height: 200,
        width: 180,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, // Changed
          borderRadius: BorderRadius.circular(15),
        ),
        child: Center(child: Image.asset('assets/images/ch2.png')),
      ),
    );
  }

  Widget _buildInputArea(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor), // Changed
      child: Row(
        children: [
          const Icon(Icons.add_circle_outline, color: Colors.grey, size: 28),
          const SizedBox(width: 12),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor, // Changed
                borderRadius: BorderRadius.circular(25),
              ),
              child: TextField(
                style: TextStyle(color: Theme.of(context).canvasColor),
                decoration: InputDecoration(
                  hintText: "Say Something...",
                  hintStyle: GoogleFonts.inter(
                      color: Colors.grey, fontWeight: FontWeight.w400),
                  border: InputBorder.none,
                  suffixIcon:
                  const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          CircleAvatar(
            backgroundColor: Theme.of(context).primaryColor, // Changed
            child: const Icon(Icons.send, color: Colors.white, size: 18),
          ),
        ],
      ),
    );
  }
}
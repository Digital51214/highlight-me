// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
// import 'chat_screen2.dart';
//
// class ChatScreen extends StatelessWidget {
//   const ChatScreen({super.key});
//
//   static final List<Map<String, String>> chatList = [
//     {
//       "name": "Charlie Thorne",
//       "msg": "That concert last night which was guide...",
//       "time": "2 min ago",
//       "img": "assets/images/c1.png"
//     },
//     {
//       "name": "Maya Sterling",
//       "msg": "Lets Chat up at the galley open after you...",
//       "time": "2:45 PM",
//       "img": "assets/images/c5.png"
//     },
//     {
//       "name": "Ben Thompson",
//       "msg": "Sent a photo",
//       "time": "Yesterday",
//       "img": "assets/images/c6.png"
//     },
//     {
//       "name": "Charlie Thorne",
//       "msg": "Did you see the new update...",
//       "time": "Tuesday",
//       "img": "assets/images/c7.png"
//     },
//     {
//       "name": "Ben Thompson",
//       "msg": "Sent a photo",
//       "time": "December",
//       "img": "assets/images/c8.png"
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView( // ✅ ADDED
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//
//               /// HEADER
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: w* 0.055,
//                   vertical: h * 0.012,
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Chats",
//                       style: GoogleFonts.inter(
//                         color: Colors.white,
//                         fontSize: 26,
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     const SizedBox(height: 5),
//                     Text(
//                       "All your conversations in one place",
//                       style: GoogleFonts.inter(
//                           color: const Color(0xFFADAAAA),
//                           fontSize: 13),
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// SEARCH BAR
//               Padding(
//                 padding: const EdgeInsets.all(20.0),
//                 child: Container(
//                   height: 54,
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   decoration: BoxDecoration(
//                     color: const Color(0xFF262626),
//                     borderRadius: BorderRadius.circular(30),
//                   ),
//                   child: Center(
//                     child: TextField(
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         icon: const Icon(Icons.search, color: Colors.grey),
//                         hintText: "Search Conversations...",
//                         hintStyle: GoogleFonts.inter(
//                             color: const Color(0xFFADAAAA),
//                             fontSize: 13),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               /// ACTIVE USERS
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 child: Text(
//                   "Active Now",
//                   style: GoogleFonts.inter(
//                     color: Colors.white,
//                     fontSize: 16,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 15),
//
//               SizedBox(
//                 height: 90,
//                 child: ListView(
//                   scrollDirection: Axis.horizontal,
//                   padding: const EdgeInsets.only(left: 10),
//                   children: [
//                     _activeUser('assets/images/c1.png', true),
//                     _activeUser('assets/images/c2.png', false),
//                     _activeUser('assets/images/c3.png', true),
//                     _activeUser('assets/images/c4.png', false),
//                     _activeUser('assets/images/c1.png', true),
//                     _activeUser('assets/images/c2.png', false),
//                     _activeUser('assets/images/c3.png', true),
//                     _activeUser('assets/images/c4.png', false),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 25),
//
//               /// CHAT LIST (FIXED)
//               ListView.builder(
//                 shrinkWrap: true, // ✅ ADDED
//                 physics: const NeverScrollableScrollPhysics(), // ✅ ADDED
//                 padding: const EdgeInsets.symmetric(horizontal: 20),
//                 itemCount: chatList.length,
//                 itemBuilder: (context, index) {
//                   final chat = chatList[index];
//
//                   return _chatTile(
//                     chat["name"]!,
//                     chat["msg"]!,
//                     chat["time"]!,
//                     chat["img"]!,
//                     context,
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   /// ACTIVE USER
//   Widget _activeUser(String img, bool isActive) {
//     return Padding(
//       padding: const EdgeInsets.only(right: 15),
//       child: Stack(
//         children: [
//           Container(
//             padding: const EdgeInsets.all(2),
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: isActive
//                     ? AppColors.lightblue
//                     : Colors.transparent,
//                 width: 2,
//               ),
//             ),
//             child: CircleAvatar(
//               radius: 30,
//               backgroundImage: AssetImage(img),
//             ),
//           ),
//           if (isActive)
//             Positioned(
//               bottom: 15,
//               right: 15,
//               child: Container(
//                 height: 12,
//                 width: 12,
//                 decoration: BoxDecoration(
//                   color: Colors.green,
//                   shape: BoxShape.circle,
//                   border: Border.all(
//                       color: const Color(0xFF121212), width: 2),
//                 ),
//               ),
//             )
//         ],
//       ),
//     );
//   }
//
//   /// CHAT TILE
//   Widget _chatTile(
//       String name,
//       String msg,
//       String time,
//       String img,
//       BuildContext context) {
//     return InkWell(
//       onTap: () {
//         Get.to(ChatApp(),
//           transition: Transition.noTransition,
//           duration: Duration.zero,);
//       },
//       child: Container(
//         height: 87,
//         margin: const EdgeInsets.only(bottom: 12),
//         padding: const EdgeInsets.symmetric(horizontal: 15),
//         decoration: BoxDecoration(
//           color: const Color(0xFF262626),
//           borderRadius: BorderRadius.circular(25),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             CircleAvatar(radius: 25, backgroundImage: AssetImage(img)),
//             const SizedBox(width: 15),
//
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Text(
//                         name,
//                         style: GoogleFonts.inter(
//                           color: Colors.white,
//                           fontWeight: FontWeight.w600,
//                           fontSize: 13,
//                         ),
//                       ),
//                       const Spacer(),
//                       Text(
//                         time,
//                         style: GoogleFonts.inter(
//                           color: Colors.blueGrey,
//                           fontSize: 9,
//                         ),
//                       ),
//                     ],
//                   ),
//                   Text(
//                     msg,
//                     style: GoogleFonts.inter(
//                       color: Colors.grey,
//                       fontSize: 11,
//                     ),
//                     maxLines: 1,
//                     overflow: TextOverflow.ellipsis,
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'chat_screen2.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  static final List<Map<String, String>> chatList = [
    {
      "name": "Charlie Thorne",
      "msg": "That concert last night which was guide...",
      "time": "2 min ago",
      "img": "assets/images/c1.png"
    },
    {
      "name": "Maya Sterling",
      "msg": "Lets Chat up at the galley open after you...",
      "time": "2:45 PM",
      "img": "assets/images/c5.png"
    },
    {
      "name": "Ben Thompson",
      "msg": "Sent a photo",
      "time": "Yesterday",
      "img": "assets/images/c6.png"
    },
    {
      "name": "Charlie Thorne",
      "msg": "Did you see the new update...",
      "time": "Tuesday",
      "img": "assets/images/c7.png"
    },
    {
      "name": "Ben Thompson",
      "msg": "Sent a photo",
      "time": "December",
      "img": "assets/images/c8.png"
    },
  ];

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

              /// HEADER
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w* 0.055,
                  vertical: h * 0.012,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chats",
                      style: GoogleFonts.inter(
                        color: Theme.of(context).canvasColor, // Changed to Theme
                        fontSize: 26,
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      "All your conversations in one place",
                      style: GoogleFonts.inter(
                          color: const Color(0xFFADAAAA),
                          fontSize: 13),
                    ),
                  ],
                ),
              ),

              /// SEARCH BAR
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 54,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor, // Changed to Theme
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Center(
                    child: TextField(
                      style: TextStyle(color: Theme.of(context).canvasColor), // Changed to Theme
                      decoration: InputDecoration(
                        icon: const Icon(Icons.search, color: Colors.grey),
                        hintText: "Search Conversations...",
                        hintStyle: GoogleFonts.inter(
                            color: const Color(0xFFADAAAA),
                            fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ),

              /// ACTIVE USERS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Active Now",
                  style: GoogleFonts.inter(
                    color: Theme.of(context).canvasColor, // Changed to Theme
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(height: 15),

              SizedBox(
                height: 90,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 10),
                  children: [
                    _activeUser(context, 'assets/images/c1.png', true), // Added context
                    _activeUser(context, 'assets/images/c2.png', false),
                    _activeUser(context, 'assets/images/c3.png', true),
                    _activeUser(context, 'assets/images/c4.png', false),
                    _activeUser(context, 'assets/images/c1.png', true),
                    _activeUser(context, 'assets/images/c2.png', false),
                    _activeUser(context, 'assets/images/c3.png', true),
                    _activeUser(context, 'assets/images/c4.png', false),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// CHAT LIST
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: chatList.length,
                itemBuilder: (context, index) {
                  final chat = chatList[index];

                  return _chatTile(
                    chat["name"]!,
                    chat["msg"]!,
                    chat["time"]!,
                    chat["img"]!,
                    context,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// ACTIVE USER
  Widget _activeUser(BuildContext context, String img, bool isActive) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isActive
                    ? Theme.of(context).primaryColor // Changed to Theme
                    : Colors.transparent,
                width: 2,
              ),
            ),
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(img),
            ),
          ),
          if (isActive)
            Positioned(
              bottom: 15,
              right: 15,
              child: Container(
                height: 12,
                width: 12,
                decoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(
                      color: Theme.of(context).scaffoldBackgroundColor, width: 2), // Changed to Theme
                ),
              ),
            )
        ],
      ),
    );
  }

  /// CHAT TILE
  Widget _chatTile(
      String name,
      String msg,
      String time,
      String img,
      BuildContext context) {
    return InkWell(
      onTap: () {
        Get.to(ChatApp(),
          transition: Transition.noTransition,
          duration: Duration.zero,);
      },
      child: Container(
        height: 87,
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor, // Changed to Theme
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(radius: 25, backgroundImage: AssetImage(img)),
            const SizedBox(width: 15),

            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        name,
                        style: GoogleFonts.inter(
                          color: Theme.of(context).canvasColor, // Changed to Theme
                          fontWeight: FontWeight.w600,
                          fontSize: 13,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        time,
                        style: GoogleFonts.inter(
                          color: Colors.blueGrey,
                          fontSize: 9,
                        ),
                      ),
                    ],
                  ),
                  Text(
                    msg,
                    style: GoogleFonts.inter(
                      color: Colors.grey,
                      fontSize: 11,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
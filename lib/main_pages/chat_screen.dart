//
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/widgets/custom_loader.dart';
// import '../Contollers/chat_controller.dart';
// import 'chat_screen2.dart';
//
// class ChatListScreen extends StatefulWidget {
//   const ChatListScreen({super.key});
//
//   @override
//   State<ChatListScreen> createState() => _ChatListScreenState();
// }
//
// class _ChatListScreenState extends State<ChatListScreen> {
//   final ChatController chatCtrl = Get.put(ChatController());
//
//   // ── Search feature (naya) ───────────────────────────────────
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//
//   @override
//   void initState() {
//     super.initState();
//     // ✅ FIX: WidgetsBinding use karo taake build complete ho pehle
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       chatCtrl.fetchMyConversations();
//     });
//   }
//
//   @override
//   void dispose() {
//     _searchController.dispose(); // 👈 naya
//     super.dispose();
//   }
//
//   // ✅ naya — sirf naam ke hisaab se filter karta hai (local, no API call)
//   List<Map<String, dynamic>> _filterConversations(
//       List<Map<String, dynamic>> all) {
//     if (_searchQuery.trim().isEmpty) return all;
//     final query = _searchQuery.trim().toLowerCase();
//     return all.where((chat) {
//       final otherUser = chat['other_user'] as Map<String, dynamic>? ?? {};
//       final name = (otherUser['name']?.toString() ?? '').toLowerCase();
//       return name.contains(query);
//     }).toList();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               /// HEADER
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: w * (18.75 / 375), // Figma 18.75 width ratio
//                   vertical: h * (12.15 / 810),   // Figma 12.15 height ratio
//                 ),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       "Chats",
//                       style: GoogleFonts.inter(
//                         color: Theme.of(context).canvasColor,
//                         fontSize: w * (24.375 / 375), // Figma font size ratio
//                         fontWeight: FontWeight.w900,
//                       ),
//                     ),
//                     SizedBox(height: h * (4.05 / 810)), // Figma spacing ratio
//                     Text(
//                       "All your conversations in one place",
//                       style: GoogleFonts.inter(
//                         color: const Color(0xFFADAAAA),
//                         fontSize: w * (13.125 / 375), // Figma font size ratio
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               /// SEARCH BAR
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: w * (18.75 / 375),
//                   vertical: h * (16.2 / 810),
//                 ),
//                 child: Container(
//                   height: h * (56.7 / 810), // Precise responsive height
//                   padding: EdgeInsets.symmetric(horizontal: w * (15.0 / 375)),
//                   decoration: BoxDecoration(
//                     color: Theme.of(context).cardColor,
//                     borderRadius: BorderRadius.circular(w * (30.0 / 375)), // Responsive radius
//                   ),
//                   child: Center(
//                     child: TextField(
//                       controller: _searchController, // 👈 naya
//                       onChanged: (value) {
//                         setState(() => _searchQuery = value); // 👈 naya — filter trigger
//                       },
//                       style: TextStyle(color: Theme.of(context).canvasColor),
//                       decoration: InputDecoration(
//                         icon: Icon(
//                           Icons.search,
//                           color: Colors.grey,
//                           size: w * (18.75 / 375), // Responsive icon size
//                         ),
//                         hintText: "Search Conversations...",
//                         hintStyle: GoogleFonts.inter(
//                           color: const Color(0xFFADAAAA),
//                           fontSize: w * (13.125 / 375),
//                         ),
//                         border: InputBorder.none,
//                         // 👈 naya — jab kuch type ho to cross (X) button dikhao
//                         suffixIcon: _searchQuery.isNotEmpty
//                             ? GestureDetector(
//                           onTap: () {
//                             _searchController.clear();
//                             setState(() => _searchQuery = '');
//                           },
//                           child: Icon(
//                             Icons.close,
//                             color: Colors.grey,
//                             size: w * (16.0 / 375),
//                           ),
//                         )
//                             : null,
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//
//               /// CHAT LIST
//               Obx(() {
//                 if (chatCtrl.isLoadingConversations.value) {
//                   return SizedBox(
//                     height: h * (324.0 / 810),
//                     child: const Center(child: CustomLoader()), // 👈 tumhara custom loader — waisa hi rakha hai
//                   );
//                 }
//
//                 if (chatCtrl.conversations.isEmpty) {
//                   return Center(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: h * (81.0 / 810)),
//                       child: Text(
//                         "No conversations yet",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: w * (15.0 / 375),
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//
//                 // ✅ naya — search query ke hisaab se filter kiya hua list
//                 final filteredList = _filterConversations(chatCtrl.conversations);
//
//                 // ✅ naya — agar search kiya lekin koi match nahi mila
//                 if (filteredList.isEmpty) {
//                   return Center(
//                     child: Padding(
//                       padding: EdgeInsets.only(top: h * (81.0 / 810)),
//                       child: Text(
//                         "No results found",
//                         style: TextStyle(
//                           color: Colors.grey,
//                           fontSize: w * (15.0 / 375),
//                         ),
//                       ),
//                     ),
//                   );
//                 }
//
//                 return ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   padding: EdgeInsets.symmetric(horizontal: w * (18.75 / 375)),
//                   itemCount: filteredList.length, // 👈 naya
//                   itemBuilder: (context, index) {
//                     final chat = filteredList[index]; // 👈 naya
//                     final otherUser = chat['other_user'] as Map<String, dynamic>? ?? {};
//
//                     // ✅ FIX: unread_count safely parse karo
//                     final int unreadCount = (chat['unread_count'] ?? 0) is int
//                         ? (chat['unread_count'] ?? 0)
//                         : int.tryParse(chat['unread_count'].toString()) ?? 0;
//
//                     // ✅ FIX: avatar_url null ho sakta hai, safely handle karo
//                     final String? avatarUrl = (otherUser['avatar_url'] != null &&
//                         otherUser['avatar_url'].toString().isNotEmpty &&
//                         otherUser['avatar_url'].toString() != 'null')
//                         ? otherUser['avatar_url'].toString()
//                         : null;
//
//                     return _chatTile(
//                       name: otherUser['name']?.toString() ?? 'Unknown',
//                       msg: chat['last_message']?.toString() ?? 'No message',
//                       time: chat['last_message_at']?.toString() ?? '',
//                       img: avatarUrl,
//                       conversationId: chat['id'] is int
//                           ? chat['id']
//                           : int.tryParse(chat['id'].toString()) ?? 0,
//                       unreadCount: unreadCount,
//                       w: w,
//                       h: h,
//                       context: context,
//                     );
//                   },
//                 );
//               }),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _chatTile({
//     required String name,
//     required String msg,
//     required String time,
//     required String? img,
//     required int conversationId,
//     required int unreadCount,
//     required double w,
//     required double h,
//     required BuildContext context,
//   }) {
//     // ✅ FIX: Time properly format karo
//     // Backend UTC time bhejta hai (bina 'Z'/offset marker ke), isliye
//     // DateTime.parse() usay galti se "already local time" samajh leta tha —
//     // isi wajah se time galat (kam) dikh raha tha. Ab explicitly UTC declare
//     // karke .toLocal() se sahi device time mein convert karte hain.
//     String formattedTime = '';
//     if (time.isNotEmpty && time != 'null') {
//       try {
//         // "2026-07-02 05:41:25" jaisi string ko ISO-jaisi bana kar UTC mark karo
//         String normalized = time.contains('T') ? time : time.replaceFirst(' ', 'T');
//         if (!normalized.endsWith('Z') && !normalized.contains('+')) {
//           normalized = '${normalized}Z';
//         }
//         final dt = DateTime.parse(normalized).toLocal(); // 👈 asal fix
//         formattedTime =
//         '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
//       } catch (_) {
//         formattedTime = time.length > 10 ? time.substring(11, 16) : time;
//       }
//     }
//
//     return InkWell(
//       onTap: () {
//         Get.find<ChatController>()
//             .fetchMessages(conversationId: conversationId);
//         Get.to(() => ChatDetailScreen(
//           userName: name,
//           userImg: img,
//           conversationId: conversationId,
//           currentUserImg: chatCtrl.currentUserImg.value,
//         ));
//       },
//       child: Container(
//         height: h * (81.0 / 810), // Total height of tile responsive
//         margin: EdgeInsets.only(bottom: h * (12.15 / 810)),
//         padding: EdgeInsets.symmetric(horizontal: w * (15.0 / 375)),
//         decoration: BoxDecoration(
//           color: Theme.of(context).cardColor,
//           borderRadius: BorderRadius.circular(w * (22.5 / 375)),
//         ),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(
//               width: w * (45.0 / 375),  // Responsive Image Width
//               height: w * (45.0 / 375), // Responsive Image Height
//               child: ClipOval(
//                 child: (img != null && img.isNotEmpty && img != 'null')
//                     ? ExtendedImage.network(
//                   img,
//                   width: w * (45.0 / 375),
//                   height: w * (45.0 / 375),
//                   fit: BoxFit.cover,
//                   cache: true,
//                   loadStateChanged: (state) {
//                     if (state.extendedImageLoadState == LoadState.loading) {
//                       return Container(color: Colors.grey.shade700);
//                     }
//                     if (state.extendedImageLoadState == LoadState.failed) {
//                       return Container(
//                         color: Colors.grey.shade800,
//                         child: Icon(
//                           Icons.person,
//                           color: Colors.white,
//                           size: w * (22.5 / 375),
//                         ),
//                       );
//                     }
//                     return null;
//                   },
//                 )
//                     : Container(
//                   color: Colors.grey.shade800,
//                   child: Icon(
//                     Icons.person,
//                     color: Colors.white,
//                     size: w * (22.5 / 375),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(width: w * (11.25 / 375)),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           name,
//                           style: GoogleFonts.inter(
//                             color: Theme.of(context).canvasColor,
//                             fontWeight: FontWeight.w600,
//                             fontSize: w * (13.125 / 375),
//                           ),
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       Text(
//                         formattedTime,
//                         style: GoogleFonts.inter(
//                           color: Colors.blueGrey,
//                           fontSize: w * (9.375 / 375),
//                         ),
//                       ),
//                     ],
//                   ),
//                   SizedBox(height: h * (4.05 / 810)),
//                   Row(
//                     children: [
//                       Expanded(
//                         child: Text(
//                           msg,
//                           style: GoogleFonts.inter(
//                             color: unreadCount > 0
//                                 ? Theme.of(context).canvasColor
//                                 : Colors.grey,
//                             fontWeight: unreadCount > 0
//                                 ? FontWeight.bold
//                                 : FontWeight.normal,
//                             fontSize: w * (11.25 / 375),
//                           ),
//                           maxLines: 1,
//                           overflow: TextOverflow.ellipsis,
//                         ),
//                       ),
//                       if (unreadCount > 0)
//                         Container(
//                           padding: EdgeInsets.all(w * (5.625 / 375)),
//                           decoration: BoxDecoration(
//                             color: Theme.of(context).primaryColor,
//                             shape: BoxShape.circle,
//                           ),
//                           child: Text(
//                             unreadCount.toString(),
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: w * (9.375 / 375),
//                             ),
//                           ),
//                         ),
//                     ],
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
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/widgets/custom_loader.dart';
import '../Contollers/chat_controller.dart';
import '../Contollers/block_controller.dart';
import 'chat_screen2.dart'; // ChatDetailScreen

class ChatListScreen extends StatefulWidget {
  const ChatListScreen({super.key});

  @override
  State<ChatListScreen> createState() => _ChatListScreenState();
}

class _ChatListScreenState extends State<ChatListScreen> {
  final ChatController  chatCtrl  = Get.put(ChatController());
  // ✅ BlockController — share across screens
  late final BlockController blockCtrl;

  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    blockCtrl = Get.isRegistered<BlockController>()
        ? Get.find<BlockController>()
        : Get.put(BlockController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatCtrl.fetchMyConversations();
      // ✅ Blocked users bhi load karo — tile mein blocked status dikhane ke liye
      blockCtrl.fetchBlockedUsers();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<Map<String, dynamic>> _filterConversations(
      List<Map<String, dynamic>> all) {
    if (_searchQuery.trim().isEmpty) return all;
    final query = _searchQuery.trim().toLowerCase();
    return all.where((chat) {
      final otherUser = chat['other_user'] as Map<String, dynamic>? ?? {};
      final name = (otherUser['name']?.toString() ?? '').toLowerCase();
      return name.contains(query);
    }).toList();
  }

  // ✅ Other user ka ID safely extract karo
  int _getOtherUserId(Map<String, dynamic> chat) {
    final otherUser = chat['other_user'] as Map<String, dynamic>? ?? {};
    final id = otherUser['id'];
    if (id == null) return 0;
    if (id is int) return id;
    return int.tryParse(id.toString()) ?? 0;
  }

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
              // ── Header ──
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * (18.75 / 375),
                  vertical: h * (12.15 / 810),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Chats",
                      style: GoogleFonts.inter(
                        color: Theme.of(context).canvasColor,
                        fontSize: w * (24.375 / 375),
                        fontWeight: FontWeight.w900,
                      ),
                    ),
                    SizedBox(height: h * (4.05 / 810)),
                    Text(
                      "All your conversations in one place",
                      style: GoogleFonts.inter(
                        color: const Color(0xFFADAAAA),
                        fontSize: w * (13.125 / 375),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Search Bar ──
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * (18.75 / 375),
                  vertical: h * (16.2 / 810),
                ),
                child: Container(
                  height: h * (56.7 / 810),
                  padding:
                  EdgeInsets.symmetric(horizontal: w * (15.0 / 375)),
                  decoration: BoxDecoration(
                    color: Theme.of(context).cardColor,
                    borderRadius:
                    BorderRadius.circular(w * (30.0 / 375)),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _searchController,
                      onChanged: (value) {
                        setState(() => _searchQuery = value);
                      },
                      style: TextStyle(
                          color: Theme.of(context).canvasColor),
                      decoration: InputDecoration(
                        icon: Icon(Icons.search,
                            color: Colors.grey,
                            size: w * (18.75 / 375)),
                        hintText: "Search Conversations...",
                        hintStyle: GoogleFonts.inter(
                          color: const Color(0xFFADAAAA),
                          fontSize: w * (13.125 / 375),
                        ),
                        border: InputBorder.none,
                        suffixIcon: _searchQuery.isNotEmpty
                            ? GestureDetector(
                          onTap: () {
                            _searchController.clear();
                            setState(() => _searchQuery = '');
                          },
                          child: Icon(Icons.close,
                              color: Colors.grey,
                              size: w * (16.0 / 375)),
                        )
                            : null,
                      ),
                    ),
                  ),
                ),
              ),

              // ── Chat List ──
              Obx(() {
                if (chatCtrl.isLoadingConversations.value) {
                  return SizedBox(
                    height: h * (324.0 / 810),
                    child: const Center(child: CustomLoader()),
                  );
                }

                if (chatCtrl.conversations.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: h * (81.0 / 810)),
                      child: Text(
                        "No conversations yet",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: w * (15.0 / 375)),
                      ),
                    ),
                  );
                }

                final filteredList =
                _filterConversations(chatCtrl.conversations);

                if (filteredList.isEmpty) {
                  return Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: h * (81.0 / 810)),
                      child: Text(
                        "No results found",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: w * (15.0 / 375)),
                      ),
                    ),
                  );
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(
                      horizontal: w * (18.75 / 375)),
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    final chat     = filteredList[index];
                    final otherUser =
                        chat['other_user'] as Map<String, dynamic>? ?? {};

                    final int unreadCount =
                    (chat['unread_count'] ?? 0) is int
                        ? (chat['unread_count'] ?? 0)
                        : int.tryParse(
                        chat['unread_count'].toString()) ??
                        0;

                    final String? avatarUrl = (otherUser['avatar_url'] !=
                        null &&
                        otherUser['avatar_url'].toString().isNotEmpty &&
                        otherUser['avatar_url'].toString() != 'null')
                        ? otherUser['avatar_url'].toString()
                        : null;

                    final int otherUserId = _getOtherUserId(chat);

                    // ✅ Blocked check — Obx ke andar hai isliye reactive hai
                    final bool isBlocked =
                    blockCtrl.isUserBlocked(otherUserId);

                    return _chatTile(
                      name: otherUser['name']?.toString() ?? 'Unknown',
                      msg: chat['last_message']?.toString() ?? 'No message',
                      time: chat['last_message_at']?.toString() ?? '',
                      img: avatarUrl,
                      conversationId: chat['id'] is int
                          ? chat['id']
                          : int.tryParse(chat['id'].toString()) ?? 0,
                      unreadCount: unreadCount,
                      otherUserId: otherUserId,
                      isBlocked: isBlocked,
                      w: w,
                      h: h,
                      context: context,
                    );
                  },
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget _chatTile({
    required String name,
    required String msg,
    required String time,
    required String? img,
    required int conversationId,
    required int unreadCount,
    required int otherUserId,
    required bool isBlocked,
    required double w,
    required double h,
    required BuildContext context,
  }) {
    // ✅ Time format
    String formattedTime = '';
    if (time.isNotEmpty && time != 'null') {
      try {
        String normalized =
        time.contains('T') ? time : time.replaceFirst(' ', 'T');
        if (!normalized.endsWith('Z') && !normalized.contains('+')) {
          normalized = '${normalized}Z';
        }
        final dt = DateTime.parse(normalized).toLocal();
        formattedTime =
        '${dt.hour.toString().padLeft(2, '0')}:${dt.minute.toString().padLeft(2, '0')}';
      } catch (_) {
        formattedTime =
        time.length > 10 ? time.substring(11, 16) : time;
      }
    }

    return InkWell(
      // ✅ Blocked user pe tap karo to kuch nahi hoga
      onTap: isBlocked
          ? null
          : () {
        Get.find<ChatController>()
            .fetchMessages(conversationId: conversationId);
        Get.to(() => ChatDetailScreen(
          userName: name,
          userImg: img,
          conversationId: conversationId,
          currentUserImg: chatCtrl.currentUserImg.value,
          otherUserId: otherUserId,
        ));
      },
      child: Container(
        height: h * (81.0 / 810),
        margin: EdgeInsets.only(bottom: h * (12.15 / 810)),
        padding:
        EdgeInsets.symmetric(horizontal: w * (15.0 / 375)),
        decoration: BoxDecoration(
          // ✅ Blocked tile thodi grey/dim dikhti hai
          color: isBlocked
              ? Theme.of(context).cardColor.withOpacity(0.5)
              : Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(w * (22.5 / 375)),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // ── Avatar ──
            Stack(
              children: [
                SizedBox(
                  width: w * (45.0 / 375),
                  height: w * (45.0 / 375),
                  child: ClipOval(
                    child: (img != null &&
                        img.isNotEmpty &&
                        img != 'null')
                        ? ExtendedImage.network(
                      img,
                      width: w * (45.0 / 375),
                      height: w * (45.0 / 375),
                      fit: BoxFit.cover,
                      cache: true,
                      // ✅ Blocked user ka avatar grayscale
                      colorBlendMode: isBlocked
                          ? BlendMode.saturation
                          : null,
                      color: isBlocked
                          ? Colors.grey
                          : null,
                      loadStateChanged: (state) {
                        if (state.extendedImageLoadState ==
                            LoadState.loading) {
                          return Container(
                              color: Colors.grey.shade700);
                        }
                        if (state.extendedImageLoadState ==
                            LoadState.failed) {
                          return Container(
                            color: Colors.grey.shade800,
                            child: Icon(Icons.person,
                                color: Colors.white,
                                size: w * (22.5 / 375)),
                          );
                        }
                        return null;
                      },
                    )
                        : Container(
                      color: Colors.grey.shade800,
                      child: Icon(Icons.person,
                          color: Colors.white,
                          size: w * (22.5 / 375)),
                    ),
                  ),
                ),
                // ✅ Blocked icon — avatar ke uper chhota block icon
                if (isBlocked)
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: w * (16.0 / 375),
                      height: w * (16.0 / 375),
                      decoration: BoxDecoration(
                        color: Colors.red.shade600,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Theme.of(context).cardColor,
                          width: 1.5,
                        ),
                      ),
                      child: Icon(
                        Icons.block,
                        color: Colors.white,
                        size: w * (9.0 / 375),
                      ),
                    ),
                  ),
              ],
            ),

            SizedBox(width: w * (11.25 / 375)),

            // ── Name + Message ──
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          name,
                          style: GoogleFonts.inter(
                            color: isBlocked
                                ? Theme.of(context)
                                .canvasColor
                                .withOpacity(0.5)
                                : Theme.of(context).canvasColor,
                            fontWeight: FontWeight.w600,
                            fontSize: w * (13.125 / 375),
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        formattedTime,
                        style: GoogleFonts.inter(
                          color: Colors.blueGrey,
                          fontSize: w * (9.375 / 375),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: h * (4.05 / 810)),
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          // ✅ Blocked user ke liye special message
                          isBlocked
                              ? 'This user is blocked · Go to Settings to unblock'
                              : msg,
                          style: GoogleFonts.inter(
                            color: isBlocked
                                ? Colors.red.shade400
                                : (unreadCount > 0
                                ? Theme.of(context).canvasColor
                                : Colors.grey),
                            fontWeight: isBlocked
                                ? FontWeight.w400
                                : (unreadCount > 0
                                ? FontWeight.bold
                                : FontWeight.normal),
                            fontSize: w * (11.25 / 375),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      // ✅ Blocked user pe unread badge nahi dikhana
                      if (unreadCount > 0 && !isBlocked)
                        Container(
                          padding: EdgeInsets.all(w * (5.625 / 375)),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: Text(
                            unreadCount.toString(),
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: w * (9.375 / 375),
                            ),
                          ),
                        ),
                    ],
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
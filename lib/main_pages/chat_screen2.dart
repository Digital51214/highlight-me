//
// import 'dart:async';
// import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
// import 'package:extended_image/extended_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart' hide Config;
// import 'package:highlights/widgets/custom_loader.dart';
// import 'package:image_picker/image_picker.dart';
// import '../Contollers/chat_controller.dart';
//
// class ChatDetailScreen extends StatefulWidget {
//   final String userName;
//   final String? userImg;
//   final int conversationId;
//   final String? currentUserImg;
//
//   const ChatDetailScreen({
//     super.key,
//     required this.userName,
//     this.userImg,
//     required this.conversationId,
//     this.currentUserImg,
//   });
//
//   @override
//   State<ChatDetailScreen> createState() => _ChatDetailScreenState();
// }
//
// class _ChatDetailScreenState extends State<ChatDetailScreen> {
//   final ChatController chatCtrl = Get.find<ChatController>();
//   final TextEditingController messageController = TextEditingController();
//   final FocusNode _textFieldFocusNode = FocusNode(); // 👈 naya — keyboard/emoji switch ke liye
//
//   // ✅ Current user ID store karo
//   int? _myUserId;
//   Timer? _pollingTimer;
//
//   // ── Attachment + Emoji (naya) ────────────────────────────────
//   final ImagePicker _imagePicker = ImagePicker();
//   bool _showEmojiPicker = false;
//   bool _isSendingAttachment = false; // attachment upload ke waqt chhota loader
//
//   @override
//   void initState() {
//     super.initState();
//     _loadMyUserId();
//
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//
//       chatCtrl.fetchMessages(conversationId: widget.conversationId);
//
//       // Polling: silent mode — loader nahi aega, messages flash nahi honge
//       _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
//         chatCtrl.fetchMessages(
//           conversationId: widget.conversationId,
//           silent: true,   // ← yeh add karo
//         );
//       });
//     });
//   }
//
//   Future<void> _loadMyUserId() async {
//     final id = await chatCtrl.getMyUserId();
//     if (mounted) {
//       setState(() {
//         _myUserId = id;
//       });
//     }
//   }
//
//   @override
//   void dispose() {
//     _pollingTimer?.cancel();
//     chatCtrl.clearMessages();
//     messageController.dispose();
//     _textFieldFocusNode.dispose(); // 👈 naya
//     super.dispose();
//   }
//
//   void _sendMessage() {
//     if (messageController.text.trim().isNotEmpty) {
//       chatCtrl.sendMessage(
//         conversationId: widget.conversationId,
//         message: messageController.text.trim(),
//       );
//       messageController.clear();
//     }
//   }
//
//   // ─────────────────────────────────────────────
//   //  Attachment (naya) — "+" button
//   // ─────────────────────────────────────────────
//   void _showAttachmentOptions() {
//     // ✅ agar emoji picker khula ho to pehle band karo
//     if (_showEmojiPicker) setState(() => _showEmojiPicker = false);
//
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Theme.of(context).cardColor,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
//       ),
//       builder: (ctx) {
//         return SafeArea(
//           child: Wrap(
//             children: [
//               ListTile(
//                 leading: Icon(Icons.photo_camera_outlined,
//                     color: Theme.of(context).primaryColor),
//                 title: Text('Take Photo',
//                     style: TextStyle(color: Theme.of(context).canvasColor)),
//                 onTap: () {
//                   Navigator.pop(ctx);
//                   _pickImage(ImageSource.camera);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.photo_library_outlined,
//                     color: Theme.of(context).primaryColor),
//                 title: Text('Choose Photo',
//                     style: TextStyle(color: Theme.of(context).canvasColor)),
//                 onTap: () {
//                   Navigator.pop(ctx);
//                   _pickImage(ImageSource.gallery);
//                 },
//               ),
//               ListTile(
//                 leading: Icon(Icons.videocam_outlined,
//                     color: Theme.of(context).primaryColor),
//                 title: Text('Choose Video',
//                     style: TextStyle(color: Theme.of(context).canvasColor)),
//                 onTap: () {
//                   Navigator.pop(ctx);
//                   _pickVideo();
//                 },
//               ),
//               SizedBox(height: MediaQuery.of(context).padding.bottom),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final XFile? picked =
//       await _imagePicker.pickImage(source: source, imageQuality: 80);
//       if (picked != null) await _sendAttachment(picked.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Photo select nahi ho saki.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> _pickVideo() async {
//     try {
//       final XFile? picked =
//       await _imagePicker.pickVideo(source: ImageSource.gallery);
//       if (picked != null) await _sendAttachment(picked.path);
//     } catch (e) {
//       Get.snackbar('Error', 'Video select nahi ho saki.',
//           snackPosition: SnackPosition.BOTTOM);
//     }
//   }
//
//   Future<void> _sendAttachment(String filePath) async {
//     setState(() => _isSendingAttachment = true);
//     final text = messageController.text.trim();
//     await chatCtrl.sendMessage(
//       conversationId: widget.conversationId,
//       message: text, // agar sirf photo/video bhej rahe ho to yeh khali bhi ja sakta hai
//       filePath: filePath,
//     );
//     messageController.clear();
//     if (mounted) setState(() => _isSendingAttachment = false);
//   }
//
//   // ─────────────────────────────────────────────
//   //  Emoji picker toggle (naya)
//   // ─────────────────────────────────────────────
//   void _toggleEmojiPicker() {
//     if (_showEmojiPicker) {
//       // emoji picker band karo, keyboard wapas kholo
//       setState(() => _showEmojiPicker = false);
//       _textFieldFocusNode.requestFocus();
//     } else {
//       // keyboard band karo, emoji picker kholo
//       _textFieldFocusNode.unfocus();
//       setState(() => _showEmojiPicker = true);
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       appBar: AppBar(
//         backgroundColor: Theme.of(context).cardColor,
//         elevation: 0,
//         leadingWidth: w * (56.25 / 375), // Responsive leading width
//         titleSpacing: w * 0.0,
//         leading: GestureDetector(
//           onTap: () => Get.back(),
//           child: Icon(
//             Icons.arrow_back_ios_new,
//             size: w * (18.75 / 375), // Responsive back icon
//             color: Theme.of(context).canvasColor,
//           ),
//         ),
//         title: Row(
//           children: [
//             _buildAvatar(widget.userImg, w * (18.75 / 375), context), // Explicit profile radius
//             SizedBox(width: w * (11.25 / 375)),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   widget.userName,
//                   style: GoogleFonts.inter(
//                     fontWeight: FontWeight.w600,
//                     fontSize: w * (15.0 / 375), // Responsive text size
//                     color: Theme.of(context).canvasColor,
//                   ),
//                 ),
//                 Text(
//                   'Active',
//                   style: GoogleFonts.inter(
//                     color: Theme.of(context).primaryColor,
//                     fontWeight: FontWeight.w400,
//                     fontSize: w * (11.25 / 375),
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//         actions: [
//           Icon(Icons.videocam_outlined, color: Theme.of(context).canvasColor),
//           SizedBox(width: w * (18.75 / 375)),
//           Icon(Icons.phone_outlined, color: Theme.of(context).canvasColor),
//           SizedBox(width: w * (18.75 / 375)),
//           Icon(Icons.info_outline, color: Theme.of(context).canvasColor),
//           SizedBox(width: w * (18.75 / 375)),
//         ],
//       ),
//       body: Column(
//         children: [
//           Expanded(
//             child: Obx(() {
//               if (chatCtrl.isLoadingMessages.value) {
//                 return const Center(child: CustomLoader());
//               }
//
//               if (chatCtrl.messages.isEmpty) {
//                 return Center(
//                   child: Text(
//                     "No messages yet",
//                     style: TextStyle(
//                       color: Colors.grey,
//                       fontSize: w * (15.0 / 375),
//                     ),
//                   ),
//                 );
//               }
//
//               return ListView.builder(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: w * (15.0 / 375),
//                   vertical: h * (16.2 / 810),
//                 ),
//                 reverse: true,
//                 itemCount: chatCtrl.messages.length,
//                 itemBuilder: (context, index) {
//                   final msg = chatCtrl
//                       .messages[chatCtrl.messages.length - 1 - index];
//
//                   // ✅ FIXED: Session se liya hua myUserId se compare karo
//                   final isMe = _myUserId != null &&
//                       msg['sender_id'] == _myUserId;
//
//                   if (isMe) {
//                     return _buildSentMessage(
//                         context, msg['message'] ?? '', w, h);
//                   } else {
//                     return _buildReceivedMessage(
//                         context, msg['message'] ?? '', widget.userImg, w, h);
//                   }
//                 },
//               );
//             }),
//           ),
//           _buildInputArea(context, w, h),
//           // ✅ naya — emoji picker input ke bilkul neeche khulta hai (WhatsApp jaisa)
//           if (_showEmojiPicker)
//             SizedBox(
//               height: h * (250.0 / 810),
//               child: EmojiPicker(
//                 onEmojiSelected: (category, emoji) {
//                   final cursorPos = messageController.selection.baseOffset;
//                   final text = messageController.text;
//                   final safePos = cursorPos < 0 ? text.length : cursorPos;
//                   final newText =
//                       text.substring(0, safePos) + emoji.emoji + text.substring(safePos);
//                   messageController.text = newText;
//                   messageController.selection = TextSelection.collapsed(
//                     offset: safePos + emoji.emoji.length,
//                   );
//                 },
//                 config: Config(
//                   height: h * (250.0 / 810),
//                   emojiViewConfig: EmojiViewConfig(
//                     columns: 7,
//                     emojiSizeMax: w * (28.0 / 375),
//                     backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//                   ),
//                   bottomActionBarConfig: BottomActionBarConfig(
//                     backgroundColor: Theme.of(context).cardColor,
//                   ),
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildReceivedMessage(
//       BuildContext context, String text, String? img, double w, double h) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: h * (16.2 / 810)),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           _buildAvatar(img, w * (13.125 / 375), context),
//           SizedBox(width: w * (7.5 / 375)),
//           Flexible(
//             child: Container(
//               padding: EdgeInsets.all(w * (13.125 / 375)),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(w * (18.75 / 375)),
//                   topRight: Radius.circular(w * (18.75 / 375)),
//                   bottomRight: Radius.circular(w * (18.75 / 375)),
//                 ),
//               ),
//               child: Text(
//                 text,
//                 style: GoogleFonts.inter(
//                   fontWeight: FontWeight.w400,
//                   fontSize: w * (13.125 / 375),
//                   color: Theme.of(context).canvasColor,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildSentMessage(
//       BuildContext context, String text, double w, double h) {
//     return Padding(
//       padding: EdgeInsets.only(bottom: h * (16.2 / 810)),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.end,
//         crossAxisAlignment: CrossAxisAlignment.end,
//         children: [
//           Flexible(
//             child: Container(
//               margin: EdgeInsets.only(left: w * (56.25 / 375)),
//               padding: EdgeInsets.all(w * (13.125 / 375)),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).primaryColor,
//                 borderRadius: BorderRadius.only(
//                   topLeft: Radius.circular(w * (18.75 / 375)),
//                   topRight: Radius.circular(w * (18.75 / 375)),
//                   bottomLeft: Radius.circular(w * (18.75 / 375)),
//                 ),
//               ),
//               child: Text(
//                 text,
//                 style: GoogleFonts.inter(
//                   fontWeight: FontWeight.w500,
//                   fontSize: w * (13.125 / 375),
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: w * (7.5 / 375)),
//           _buildAvatar(widget.currentUserImg, w * (13.125 / 375), context),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildInputArea(BuildContext context, double w, double h) {
//     return Container(
//       padding: EdgeInsets.symmetric(
//         horizontal: w * (15.0 / 375),
//         vertical: h * (12.15 / 810),
//       ),
//       decoration: BoxDecoration(color: Theme.of(context).scaffoldBackgroundColor),
//       child: Row(
//         children: [
//           // ✅ naya — "+" button ab functional hai (Camera / Gallery / Video)
//           GestureDetector(
//             onTap: _isSendingAttachment ? null : _showAttachmentOptions,
//             child: _isSendingAttachment
//                 ? SizedBox(
//               width: w * (26.25 / 375),
//               height: w * (26.25 / 375),
//               child: CircularProgressIndicator(
//                 strokeWidth: 2,
//                 color: Theme.of(context).primaryColor,
//               ),
//             )
//                 : Icon(
//               Icons.add_circle_outline,
//               color: Colors.grey,
//               size: w * (26.25 / 375), // Responsive attachment icon
//             ),
//           ),
//           SizedBox(width: w * (11.25 / 375)),
//           Expanded(
//             child: Container(
//               height: h * (48.6 / 810), // Responsive height for input textfield
//               padding: EdgeInsets.symmetric(horizontal: w * (15.0 / 375)),
//               decoration: BoxDecoration(
//                 color: Theme.of(context).cardColor,
//                 borderRadius: BorderRadius.circular(w * (30.0 / 375)),
//               ),
//               child: TextField(
//                 controller: messageController,
//                 focusNode: _textFieldFocusNode, // 👈 naya
//                 onTap: () {
//                   // ✅ agar emoji picker khula ho aur user text field pe tap kare
//                   // to emoji picker band ho ke normal keyboard aa jaye
//                   if (_showEmojiPicker) setState(() => _showEmojiPicker = false);
//                 },
//                 style: TextStyle(color: Theme.of(context).canvasColor),
//                 decoration: InputDecoration(
//                   hintText: "Say Something...",
//                   hintStyle: GoogleFonts.inter(
//                     color: Colors.grey,
//                     fontSize: w * (13.125 / 375),
//                     fontWeight: FontWeight.w400,
//                   ),
//                   border: InputBorder.none,
//                   suffixIcon: GestureDetector(
//                     // ✅ naya — emoji icon ab functional hai
//                     onTap: _toggleEmojiPicker,
//                     child: Icon(
//                       _showEmojiPicker
//                           ? Icons.keyboard_alt_outlined
//                           : Icons.emoji_emotions_outlined,
//                       color: Colors.grey,
//                       size: w * (18.75 / 375),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ),
//           SizedBox(width: w * (11.25 / 375)),
//           GestureDetector(
//             onTap: () {
//               if (!chatCtrl.isSendingMessage.value) _sendMessage();
//             },
//             child: CircleAvatar(
//               radius: w * (18.75 / 375), // Send button circle sizing
//               backgroundColor: Theme.of(context).primaryColor,
//               child: Obx(() => chatCtrl.isSendingMessage.value
//                   ? Padding(
//                 padding: EdgeInsets.all(w * (7.5 / 375)),
//                 child: CustomLoader(size: h * (24.3 / 810)),
//               )
//                   : Icon(
//                 Icons.send,
//                 color: Colors.white,
//                 size: w * (16.875 / 375),
//               )),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildAvatar(String? imgUrl, double radius, BuildContext context) {
//     final bool hasImage =
//         imgUrl != null && imgUrl.isNotEmpty && imgUrl != 'null';
//     return SizedBox(
//       width: radius * 2,
//       height: radius * 2,
//       child: ClipOval(
//         child: hasImage
//             ? ExtendedImage.network(
//           imgUrl,
//           width: radius * 2,
//           height: radius * 2,
//           fit: BoxFit.cover,
//           cache: true,
//           loadStateChanged: (state) {
//             if (state.extendedImageLoadState == LoadState.loading) {
//               return Container(color: Colors.grey.shade700);
//             }
//             if (state.extendedImageLoadState == LoadState.failed) {
//               return Container(
//                 color: Colors.grey.shade800,
//                 child: Icon(Icons.person, color: Colors.white, size: radius),
//               );
//             }
//             return null;
//           },
//         )
//             : Container(
//           color: Colors.grey.shade800,
//           child: Icon(Icons.person, color: Colors.white, size: radius),
//         ),
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart' hide Config;
import 'package:highlights/widgets/custom_loader.dart';
import 'package:image_picker/image_picker.dart';
import '../Contollers/chat_controller.dart';
import '../Contollers/block_controller.dart';

class ChatDetailScreen extends StatefulWidget {
  final String userName;
  final String? userImg;
  final int conversationId;
  final String? currentUserImg;
  // ✅ Other user ka ID — block ke liye zaroori
  final int otherUserId;

  const ChatDetailScreen({
    super.key,
    required this.userName,
    this.userImg,
    required this.conversationId,
    this.currentUserImg,
    required this.otherUserId,
  });

  @override
  State<ChatDetailScreen> createState() => _ChatDetailScreenState();
}

class _ChatDetailScreenState extends State<ChatDetailScreen> {
  final ChatController  chatCtrl  = Get.find<ChatController>();
  // ✅ BlockController — Get.find ya Get.put
  late final BlockController blockCtrl;

  final TextEditingController messageController = TextEditingController();
  final FocusNode _textFieldFocusNode = FocusNode();

  int? _myUserId;
  Timer? _pollingTimer;

  final ImagePicker _imagePicker   = ImagePicker();
  bool _showEmojiPicker            = false;
  bool _isSendingAttachment        = false;

  @override
  void initState() {
    super.initState();
    // ✅ BlockController register karo agar nahi hai
    blockCtrl = Get.isRegistered<BlockController>()
        ? Get.find<BlockController>()
        : Get.put(BlockController());

    _loadMyUserId();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      chatCtrl.fetchMessages(conversationId: widget.conversationId);

      _pollingTimer = Timer.periodic(const Duration(seconds: 3), (_) {
        chatCtrl.fetchMessages(
          conversationId: widget.conversationId,
          silent: true,
        );
      });
    });
  }

  Future<void> _loadMyUserId() async {
    final id = await chatCtrl.getMyUserId();
    if (mounted) setState(() => _myUserId = id);
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    chatCtrl.clearMessages();
    messageController.dispose();
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    if (messageController.text.trim().isNotEmpty) {
      chatCtrl.sendMessage(
        conversationId: widget.conversationId,
        message: messageController.text.trim(),
      );
      messageController.clear();
    }
  }

  // ─────────────────────────────────────────────
  //  3-dot menu — Block option
  // ─────────────────────────────────────────────
  void _showMoreOptions() {
    final double w = MediaQuery.of(context).size.width;
    final bool isBlocked = blockCtrl.isUserBlocked(widget.otherUserId);

    showMenu(
      context: context,
      color: Theme.of(context).cardColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(w * (12.0 / 375)),
      ),
      // AppBar ke neeche right side mein popup aaye
      position: RelativeRect.fromLTRB(
        MediaQuery.of(context).size.width,
        kToolbarHeight + MediaQuery.of(context).padding.top,
        w * (16.0 / 375),
        0,
      ),
      items: [
        PopupMenuItem(
          enabled: !isBlocked, // Already blocked hai to disable
          onTap: isBlocked ? null : () => _confirmBlock(),
          child: Row(
            children: [
              Icon(
                isBlocked ? Icons.block : Icons.block_outlined,
                color: isBlocked ? Colors.grey : Colors.red,
                size: w * (18.0 / 375),
              ),
              SizedBox(width: w * (10.0 / 375)),
              Text(
                isBlocked ? 'User Blocked' : 'Block User',
                style: GoogleFonts.inter(
                  color: isBlocked
                      ? Colors.grey
                      : Theme.of(context).canvasColor,
                  fontSize: w * (14.0 / 375),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // ─────────────────────────────────────────────
  //  Block confirm dialog
  // ─────────────────────────────────────────────
  void _confirmBlock() {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(w * (16.0 / 375)),
        ),
        title: Text(
          'Block ${widget.userName}?',
          style: GoogleFonts.inter(
            color: Theme.of(context).canvasColor,
            fontWeight: FontWeight.w700,
            fontSize: w * (16.0 / 375),
          ),
        ),
        content: Text(
          'They won\'t be able to message you, and you won\'t see their messages. You can unblock them anytime from Settings.',
          style: GoogleFonts.inter(
            color: Theme.of(context).canvasColor.withOpacity(0.7),
            fontSize: w * (13.0 / 375),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: w * (14.0 / 375),
              ),
            ),
          ),
          Obx(() => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * (8.0 / 375)),
              ),
            ),
            onPressed: blockCtrl.isBlocking.value
                ? null
                : () async {
              Navigator.of(dialogContext).pop();
              await _doBlock();
            },
            child: blockCtrl.isBlocking.value
                ? SizedBox(
              width: w * (16.0 / 375),
              height: w * (16.0 / 375),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Text(
              'Block',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: w * (14.0 / 375),
              ),
            ),
          )),
        ],
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Block action
  // ─────────────────────────────────────────────
  Future<void> _doBlock() async {
    final result = await blockCtrl.blockUser(
      blockedUserId: widget.otherUserId,
    );

    if (result != null && result.success) {
      // ✅ Block successful — ChatList pe wapas jao
      // Polling band karo pehle
      _pollingTimer?.cancel();

      // ChatList refresh karo
      if (Get.isRegistered<ChatController>()) {
        Get.find<ChatController>().fetchMyConversations();
      }

      // ChatList screen pe navigate karo
      // Saari screens hata ke ChatList pe jao
      Get.until((route) => route.isFirst);
    }
  }

  // ─────────────────────────────────────────────
  //  Attachment options
  // ─────────────────────────────────────────────
  void _showAttachmentOptions() {
    if (_showEmojiPicker) setState(() => _showEmojiPicker = false);

    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).cardColor,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (ctx) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_camera_outlined,
                    color: Theme.of(context).primaryColor),
                title: Text('Take Photo',
                    style: TextStyle(color: Theme.of(context).canvasColor)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library_outlined,
                    color: Theme.of(context).primaryColor),
                title: Text('Choose Photo',
                    style: TextStyle(color: Theme.of(context).canvasColor)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickImage(ImageSource.gallery);
                },
              ),
              ListTile(
                leading: Icon(Icons.videocam_outlined,
                    color: Theme.of(context).primaryColor),
                title: Text('Choose Video',
                    style: TextStyle(color: Theme.of(context).canvasColor)),
                onTap: () {
                  Navigator.pop(ctx);
                  _pickVideo();
                },
              ),
              SizedBox(height: MediaQuery.of(context).padding.bottom),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? picked =
      await _imagePicker.pickImage(source: source, imageQuality: 80);
      if (picked != null) await _sendAttachment(picked.path);
    } catch (e) {
      Get.snackbar('Error', 'Photo select nahi ho saki.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? picked =
      await _imagePicker.pickVideo(source: ImageSource.gallery);
      if (picked != null) await _sendAttachment(picked.path);
    } catch (e) {
      Get.snackbar('Error', 'Video select nahi ho saki.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _sendAttachment(String filePath) async {
    setState(() => _isSendingAttachment = true);
    final text = messageController.text.trim();
    await chatCtrl.sendMessage(
      conversationId: widget.conversationId,
      message: text,
      filePath: filePath,
    );
    messageController.clear();
    if (mounted) setState(() => _isSendingAttachment = false);
  }

  void _toggleEmojiPicker() {
    if (_showEmojiPicker) {
      setState(() => _showEmojiPicker = false);
      _textFieldFocusNode.requestFocus();
    } else {
      _textFieldFocusNode.unfocus();
      setState(() => _showEmojiPicker = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).cardColor,
        elevation: 0,
        leadingWidth: w * (56.25 / 375),
        titleSpacing: w * 0.0,
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: Icon(
            Icons.arrow_back_ios_new,
            size: w * (18.75 / 375),
            color: Theme.of(context).canvasColor,
          ),
        ),
        title: Row(
          children: [
            _buildAvatar(widget.userImg, w * (18.75 / 375), context),
            SizedBox(width: w * (11.25 / 375)),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.userName,
                  style: GoogleFonts.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: w * (15.0 / 375),
                    color: Theme.of(context).canvasColor,
                  ),
                ),
                Text(
                  'Active',
                  style: GoogleFonts.inter(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w400,
                    fontSize: w * (11.25 / 375),
                  ),
                ),
              ],
            ),
          ],
        ),
        actions: [
          Icon(Icons.videocam_outlined, color: Theme.of(context).canvasColor),
          SizedBox(width: w * (18.75 / 375)),
          Icon(Icons.phone_outlined, color: Theme.of(context).canvasColor),
          SizedBox(width: w * (10.0 / 375)),
          // ✅ 3-dot menu — Block option yahan hai
          GestureDetector(
            onTap: _showMoreOptions,
            child: Icon(
              Icons.more_vert,
              color: Theme.of(context).canvasColor,
              size: w * (24.0 / 375),
            ),
          ),
          SizedBox(width: w * (12.0 / 375)),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (chatCtrl.isLoadingMessages.value) {
                return const Center(child: CustomLoader());
              }

              if (chatCtrl.messages.isEmpty) {
                return Center(
                  child: Text(
                    "No messages yet",
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: w * (15.0 / 375),
                    ),
                  ),
                );
              }

              return ListView.builder(
                padding: EdgeInsets.symmetric(
                  horizontal: w * (15.0 / 375),
                  vertical: h * (16.2 / 810),
                ),
                reverse: true,
                itemCount: chatCtrl.messages.length,
                itemBuilder: (context, index) {
                  final msg = chatCtrl
                      .messages[chatCtrl.messages.length - 1 - index];
                  final isMe = _myUserId != null &&
                      msg['sender_id'] == _myUserId;

                  if (isMe) {
                    return _buildSentMessage(
                        context, msg['message'] ?? '', w, h);
                  } else {
                    return _buildReceivedMessage(
                        context, msg['message'] ?? '', widget.userImg, w, h);
                  }
                },
              );
            }),
          ),
          _buildInputArea(context, w, h),
          if (_showEmojiPicker)
            SizedBox(
              height: h * (250.0 / 810),
              child: EmojiPicker(
                onEmojiSelected: (category, emoji) {
                  final cursorPos = messageController.selection.baseOffset;
                  final text = messageController.text;
                  final safePos = cursorPos < 0 ? text.length : cursorPos;
                  final newText = text.substring(0, safePos) +
                      emoji.emoji +
                      text.substring(safePos);
                  messageController.text = newText;
                  messageController.selection = TextSelection.collapsed(
                    offset: safePos + emoji.emoji.length,
                  );
                },
                config: Config(
                  height: h * (250.0 / 810),
                  emojiViewConfig: EmojiViewConfig(
                    columns: 7,
                    emojiSizeMax: w * (28.0 / 375),
                    backgroundColor:
                    Theme.of(context).scaffoldBackgroundColor,
                  ),
                  bottomActionBarConfig: BottomActionBarConfig(
                    backgroundColor: Theme.of(context).cardColor,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildReceivedMessage(
      BuildContext context, String text, String? img, double w, double h) {
    return Padding(
      padding: EdgeInsets.only(bottom: h * (16.2 / 810)),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _buildAvatar(img, w * (13.125 / 375), context),
          SizedBox(width: w * (7.5 / 375)),
          Flexible(
            child: Container(
              padding: EdgeInsets.all(w * (13.125 / 375)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w * (18.75 / 375)),
                  topRight: Radius.circular(w * (18.75 / 375)),
                  bottomRight: Radius.circular(w * (18.75 / 375)),
                ),
              ),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w400,
                  fontSize: w * (13.125 / 375),
                  color: Theme.of(context).canvasColor,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSentMessage(
      BuildContext context, String text, double w, double h) {
    return Padding(
      padding: EdgeInsets.only(bottom: h * (16.2 / 810)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Flexible(
            child: Container(
              margin: EdgeInsets.only(left: w * (56.25 / 375)),
              padding: EdgeInsets.all(w * (13.125 / 375)),
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(w * (18.75 / 375)),
                  topRight: Radius.circular(w * (18.75 / 375)),
                  bottomLeft: Radius.circular(w * (18.75 / 375)),
                ),
              ),
              child: Text(
                text,
                style: GoogleFonts.inter(
                  fontWeight: FontWeight.w500,
                  fontSize: w * (13.125 / 375),
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SizedBox(width: w * (7.5 / 375)),
          _buildAvatar(widget.currentUserImg, w * (13.125 / 375), context),
        ],
      ),
    );
  }

  Widget _buildInputArea(BuildContext context, double w, double h) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: w * (15.0 / 375),
        vertical: h * (12.15 / 810),
      ),
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor),
      child: Row(
        children: [
          GestureDetector(
            onTap: _isSendingAttachment ? null : _showAttachmentOptions,
            child: _isSendingAttachment
                ? SizedBox(
              width: w * (26.25 / 375),
              height: w * (26.25 / 375),
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: Theme.of(context).primaryColor,
              ),
            )
                : Icon(
              Icons.add_circle_outline,
              color: Colors.grey,
              size: w * (26.25 / 375),
            ),
          ),
          SizedBox(width: w * (11.25 / 375)),
          Expanded(
            child: Container(
              height: h * (48.6 / 810),
              padding:
              EdgeInsets.symmetric(horizontal: w * (15.0 / 375)),
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: BorderRadius.circular(w * (30.0 / 375)),
              ),
              child: TextField(
                controller: messageController,
                focusNode: _textFieldFocusNode,
                onTap: () {
                  if (_showEmojiPicker)
                    setState(() => _showEmojiPicker = false);
                },
                style:
                TextStyle(color: Theme.of(context).canvasColor),
                decoration: InputDecoration(
                  hintText: "Say Something...",
                  hintStyle: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: w * (13.125 / 375),
                    fontWeight: FontWeight.w400,
                  ),
                  border: InputBorder.none,
                  suffixIcon: GestureDetector(
                    onTap: _toggleEmojiPicker,
                    child: Icon(
                      _showEmojiPicker
                          ? Icons.keyboard_alt_outlined
                          : Icons.emoji_emotions_outlined,
                      color: Colors.grey,
                      size: w * (18.75 / 375),
                    ),
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: w * (11.25 / 375)),
          GestureDetector(
            onTap: () {
              if (!chatCtrl.isSendingMessage.value) _sendMessage();
            },
            child: CircleAvatar(
              radius: w * (18.75 / 375),
              backgroundColor: Theme.of(context).primaryColor,
              child: Obx(() => chatCtrl.isSendingMessage.value
                  ? Padding(
                padding: EdgeInsets.all(w * (7.5 / 375)),
                child: CustomLoader(size: h * (24.3 / 810)),
              )
                  : Icon(
                Icons.send,
                color: Colors.white,
                size: w * (16.875 / 375),
              )),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAvatar(
      String? imgUrl, double radius, BuildContext context) {
    final bool hasImage =
        imgUrl != null && imgUrl.isNotEmpty && imgUrl != 'null';
    return SizedBox(
      width: radius * 2,
      height: radius * 2,
      child: ClipOval(
        child: hasImage
            ? ExtendedImage.network(
          imgUrl,
          width: radius * 2,
          height: radius * 2,
          fit: BoxFit.cover,
          cache: true,
          loadStateChanged: (state) {
            if (state.extendedImageLoadState == LoadState.loading) {
              return Container(color: Colors.grey.shade700);
            }
            if (state.extendedImageLoadState == LoadState.failed) {
              return Container(
                color: Colors.grey.shade800,
                child: Icon(Icons.person,
                    color: Colors.white, size: radius),
              );
            }
            return null;
          },
        )
            : Container(
          color: Colors.grey.shade800,
          child: Icon(Icons.person,
              color: Colors.white, size: radius),
        ),
      ),
    );
  }
}
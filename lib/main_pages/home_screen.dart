// import 'dart:io';
// import 'dart:convert';
// import 'dart:async';
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/basic_files/basic_fontstyles.dart';
// import 'package:highlights/presentation_screen/NotificationScreen.dart';
// import 'package:highlights/widgets/custom_loader.dart';
// import 'package:share_plus/share_plus.dart';
// import '../Contollers/auth_controller.dart';
// import '../Contollers/post_controller.dart';
// import '../Contollers/chat_controller.dart';
// import '../Services/time_services.dart';
// import 'chat_screen2.dart';
//
// class HomeScreen extends StatefulWidget {
//   const HomeScreen({super.key});
//
//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }
//
// class _HomeScreenState extends State<HomeScreen> {
//   Timer? _timer;
//   String _displayTime = "Loading...";
//   final AuthController _auth = Get.find<AuthController>();
//   final GlobalKey<_ReelsScreenState> _reelsKey = GlobalKey<_ReelsScreenState>();
//   final ScrollController _scrollController = ScrollController(); // 👈 naya — pagination ke liye
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//     _scrollController.addListener(_onScroll); // 👈 naya
//   }
//
//   // ✅ Pagination trigger — jab list ke end ke qareeb pahunche (200px pehle)
//   void _onScroll() {
//     if (!_scrollController.hasClients) return;
//     final threshold = _scrollController.position.maxScrollExtent - 200;
//     if (_scrollController.position.pixels >= threshold) {
//       _reelsKey.currentState?._loadMorePosts();
//     }
//   }
//
//   void _startTimer() {
//     if (mounted) {
//       setState(() {
//         _displayTime = TimeService.formatDuration(TimeService.getTimeRemaining());
//       });
//     }
//     _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
//       if (mounted) {
//         setState(() {
//           _displayTime = TimeService.formatDuration(TimeService.getTimeRemaining());
//         });
//       }
//     });
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     _scrollController.dispose(); // 👈 naya
//     super.dispose();
//   }
//
//   double _calculateProgress() {
//     double progress = TimeService.getTimeRemaining().inSeconds / (3 * 24 * 3600);
//     return (1.0 - progress).clamp(0.0, 1.0);
//   }
//
//   ImageProvider _getAvatarProvider() {
//     if (_auth.userAvatarLocalPath.value.isNotEmpty &&
//         File(_auth.userAvatarLocalPath.value).existsSync()) {
//       return FileImage(File(_auth.userAvatarLocalPath.value));
//     }
//     final netOrBase64 = _auth.userAvatar.value;
//     if (netOrBase64 != null && netOrBase64.isNotEmpty) {
//       if (netOrBase64.startsWith('http')) return NetworkImage(netOrBase64);
//       try {
//         final cleanBase64 = netOrBase64.contains('base64,')
//             ? netOrBase64.split('base64,')[1]
//             : netOrBase64;
//         return MemoryImage(base64Decode(cleanBase64.trim()));
//       } catch (_) {}
//     }
//     return const AssetImage('assets/images/h0.png');
//   }
//
//   Set<int> selectedStories = {};
//   final List<String> storyImages = [
//     'assets/images/h1.png', 'assets/images/h2.png',
//     'assets/images/h3.png', 'assets/images/h4.png',
//     'assets/images/h1.png', 'assets/images/h2.png',
//     'assets/images/h3.png', 'assets/images/h4.png',
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: RefreshIndicator(
//           color: Theme.of(context).primaryColor,
//           onRefresh: () async {
//             await _reelsKey.currentState?._loadPosts();
//           },
//           child: SingleChildScrollView(
//             controller: _scrollController, // 👈 naya — pagination scroll detect karne ke liye
//             // ✅ FIX: NeverScrollableScrollPhysics hatao — yeh infinite loop ka cause tha
//             physics: const AlwaysScrollableScrollPhysics(),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 // ── Header ──
//                 Obx(() => Padding(
//                   padding: EdgeInsets.symmetric(
//                       horizontal: w * (20.625 / 375),
//                       vertical: h * (9.72 / 810)),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Row(children: [
//                         CircleAvatar(
//                           radius: w * (24.0 / 375),
//                           backgroundImage: _getAvatarProvider(),
//                         ),
//                         SizedBox(width: w * (10.0 / 375)),
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               'Welcome ${_auth.userName.value.isNotEmpty ? _auth.userName.value : 'User'}!',
//                               style: MainTextStyles.inter(
//                                 fontSize: w * (13.0 / 375),
//                                 fontWeight: FontWeight.w700,
//                                 color: Theme.of(context).canvasColor,
//                               ),
//                             ),
//                             Text(
//                               'Your moments are waiting',
//                               style: MainTextStyles.inter(
//                                 fontSize: w * (9.0 / 375),
//                                 fontWeight: FontWeight.w400,
//                                 color: const Color(0xFFADAAAA),
//                               ),
//                             ),
//                           ],
//                         ),
//                       ]),
//                       GestureDetector(
//                         onTap: () => Get.to(
//                           Notificationscreen(),
//                           transition: Transition.noTransition,
//                           duration: Duration.zero,
//                         ),
//                         child: Theme.of(context).brightness == Brightness.dark
//                             ? Image.asset('assets/images/icon.bell.png',
//                             height: w * (48.0 / 375), width: w * (48.0 / 375))
//                             : Container(
//                           height: w * (45.0 / 375),
//                           width: w * (45.0 / 375),
//                           decoration: BoxDecoration(
//                             shape: BoxShape.circle,
//                             color: Theme.of(context).primaryColor.withOpacity(0.15),
//                             border: Border.all(
//                               color: Theme.of(context).primaryColor.withOpacity(0.3),
//                               width: w * (0.9375 / 375),
//                             ),
//                           ),
//                           child: Center(
//                             child: Icon(Icons.notifications_none_rounded,
//                                 color: Theme.of(context).canvasColor,
//                                 size: w * (22.0 / 375)),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 )),
//
//                 SizedBox(height: h * (20.25 / 810)),
//
//                 // ── Timer Card ──
//                 Center(
//                   child: Container(
//                     width: w * (335.0 / 375),
//                     height: h * (127.0 / 810),
//                     padding: EdgeInsets.symmetric(
//                         horizontal: w * (22.5 / 375),
//                         vertical: h * (12.15 / 810)),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(w * (40.0 / 375)),
//                       color: Theme.of(context).cardColor,
//                     ),
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         Text(
//                           TimeService.isPostingWindowOpen()
//                               ? 'POSTING WINDOW CLOSES IN:'
//                               : 'POSTING WINDOW OPENS IN:',
//                           style: MainTextStyles.inter(
//                             fontWeight: FontWeight.w300,
//                             fontSize: w * (12.0 / 375),
//                             color: const Color(0xFFADAAAA),
//                           ),
//                         ),
//                         SizedBox(height: h * (4.05 / 810)),
//                         Text(_displayTime,
//                             style: MainTextStyles.inter(
//                               fontWeight: FontWeight.w700,
//                               fontSize: w * (26.25 / 375),
//                               color: Theme.of(context).primaryColor,
//                             )),
//                         SizedBox(height: h * (8.1 / 810)),
//                         Stack(children: [
//                           Container(
//                             height: h * (5.0 / 810),
//                             width: w * (245.0 / 375),
//                             decoration: BoxDecoration(
//                               color: Theme.of(context).canvasColor.withOpacity(0.1),
//                               borderRadius: BorderRadius.circular(w * (100.0 / 375)),
//                             ),
//                           ),
//                           AnimatedContainer(
//                             duration: const Duration(seconds: 1),
//                             height: h * (5.0 / 810),
//                             width: w * (245.0 / 375) * _calculateProgress(),
//                             decoration: BoxDecoration(
//                               gradient: LinearGradient(colors: [
//                                 Theme.of(context).primaryColor.withOpacity(0.5),
//                                 Theme.of(context).primaryColor,
//                               ]),
//                               borderRadius: BorderRadius.circular(w * (100.0 / 375)),
//                               boxShadow: [
//                                 BoxShadow(
//                                   color: Theme.of(context).primaryColor.withOpacity(0.3),
//                                   blurRadius: w * (4.0 / 375),
//                                   offset: Offset(0, h * (2.0 / 810)),
//                                 )
//                               ],
//                             ),
//                           ),
//                         ]),
//                       ],
//                     ),
//                   ),
//                 ),
//
//                 SizedBox(height: h * (16.2 / 810)),
//
//                 // ── Stories ──
//                 Container(
//                   padding: EdgeInsets.symmetric(horizontal: w * (20.625 / 375)),
//                   child: Text('Trending Now',
//                       style: MainTextStyles.inter(
//                         fontWeight: FontWeight.w600,
//                         fontSize: w * (16.0 / 375),
//                         color: Theme.of(context).canvasColor,
//                       )),
//                 ),
//                 SizedBox(height: h * (8.1 / 810)),
//                 SizedBox(
//                   height: h * (90.0 / 810),
//                   child: ListView.builder(
//                     scrollDirection: Axis.horizontal,
//                     physics: const BouncingScrollPhysics(),
//                     itemCount: storyImages.length,
//                     itemBuilder: (context, index) {
//                       final bool isSelected = selectedStories.contains(index);
//                       return Padding(
//                         padding: EdgeInsets.symmetric(horizontal: w * (8.0 / 375)),
//                         child: GestureDetector(
//                           onTap: () => setState(() => selectedStories.add(index)),
//                           child: Stack(children: [
//                             Container(
//                               width: w * (69.0 / 375),
//                               height: w * (69.0 / 375),
//                               padding: EdgeInsets.all(w * (1.0 / 375)),
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: isSelected ? Colors.grey : Theme.of(context).primaryColor,
//                                 border: Border.all(
//                                   color: isSelected
//                                       ? Colors.grey
//                                       : Theme.of(context).primaryColor.withOpacity(0.5),
//                                   width: w * (2.0 / 375),
//                                 ),
//                               ),
//                               child: CircleAvatar(
//                                   backgroundImage: AssetImage(storyImages[index])),
//                             ),
//                             if (index == 0)
//                               Positioned(
//                                 right: w * (5.0 / 375),
//                                 bottom: h * (10.0 / 810),
//                                 child: Container(
//                                   width: w * (22.0 / 375),
//                                   height: w * (22.0 / 375),
//                                   decoration: BoxDecoration(
//                                     shape: BoxShape.circle,
//                                     color: Theme.of(context).canvasColor,
//                                   ),
//                                   child: Center(
//                                     child: Icon(Icons.add,
//                                         color: Theme.of(context).scaffoldBackgroundColor,
//                                         size: w * (16.0 / 375)),
//                                   ),
//                                 ),
//                               ),
//                           ]),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//
//                 SizedBox(height: h * (8.1 / 810)),
//
//                 // ── Posts Feed ──
//                 ReelsScreen(key: _reelsKey),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// // ═══════════════════════════════════════════════════════════════
// //  ReelsScreen
// // ═══════════════════════════════════════════════════════════════
// class ReelsScreen extends StatefulWidget {
//   const ReelsScreen({super.key});
//
//   @override
//   State<ReelsScreen> createState() => _ReelsScreenState();
// }
//
// class _ReelsScreenState extends State<ReelsScreen> {
//   List<Map<String, dynamic>> posts = [];
//
//   // ✅ Per-post local state — refresh tak yaad rakhta hai
//   // Map<postId, {liked, likesCount, commentsCount}>
//   final Map<int, _PostLocalState> _localState = {};
//
//   bool _isLoading = true;
//   bool _hasError  = false;
//   // ✅ FIX: infinite loop rokne ke liye
//   bool _isFetching = false;
//
//   // ── View tracking (naya) ─────────────────────────────────────
//   // ✅ FIX: views_count kabhi barhta hi nahi tha kyunki PostController.viewPost()
//   // ko kahin call hi nahi kiya ja raha tha. Ab jab bhi koi post pehli baar
//   // screen pe build ho (dikhe), ek dafa view count karte hain. Yeh Set track
//   // karta hai ke kis-kis post ka view already bheja ja chuka hai (isi session
//   // mein dobara dobara na bheje, warna views_count galat tarike se barh jayega)
//   final Set<int> _viewedPostIds = {};
//
//   // ── Pagination (naya) ───────────────────────────────────────
//   static const int _pageLimit = 20; // backend jitna ek baar mein deta hai
//   bool _hasMore     = true;  // aur posts baaki hain ya nahi
//   bool _isLoadingMore = false;
//
//   // ── Message feature (naya) ──────────────────────────────────
//   List<bool> _messageLoading = [];
//   final ChatController chatCtrl = Get.isRegistered<ChatController>()
//       ? Get.find<ChatController>()
//       : Get.put(ChatController()); // 👈 agar ChatListScreen abhi tak open nahi hui to bhi safe
//   int? _myUserId;
//
//   @override
//   void initState() {
//     super.initState();
//     _loadPosts();
//     _loadMyUserId(); // 👈 naya
//   }
//
//   Future<void> _loadMyUserId() async {
//     final id = await chatCtrl.getMyUserId();
//     if (mounted) setState(() => _myUserId = id);
//   }
//
//   // ─────────────────────────────────────────────
//   //  Load posts (pehla page — refresh pe bhi yehi chalta hai)
//   // ─────────────────────────────────────────────
//   Future<void> _loadPosts() async {
//     // ✅ FIX: double call guard
//     if (_isFetching) return;
//     if (!mounted) return;
//
//     _isFetching = true;
//     setState(() {
//       _isLoading = true;
//       _hasError  = false;
//     });
//
//     try {
//       final result = await PostController.getPostFeed(limit: _pageLimit, offset: 0);
//       debugPrint('[HomeScreen] posts fetched: ${result.length}');
//
//       if (mounted) {
//         // ✅ Naye posts ke liye local state banao
//         // Purani liked state preserve karo agar same post dobara aaye
//         for (final post in result) {
//           final id = _parseInt(post['id'] ?? post['post_id']);
//           if (!_localState.containsKey(id)) {
//             // Pehli baar — API se is_liked aur counts lo
//             _localState[id] = _PostLocalState(
//               liked:         post['is_liked'] == true,
//               likesCount:    _parseInt(post['likes_count'] ?? post['likes'] ?? 0),
//               commentsCount: _parseInt(post['comments_count'] ?? post['comments'] ?? 0),
//             );
//           }
//           // Agar already exist karta hai to purani liked/count state rakho
//           // (refresh pe like na gayab ho)
//         }
//
//         setState(() {
//           posts           = result;
//           _messageLoading = List.filled(result.length, false); // 👈 naya
//           _isLoading      = false;
//           // ✅ agar pehle page mein hi limit se kam posts aaye, matlab aur nahi hain
//           _hasMore        = result.length >= _pageLimit;
//         });
//       }
//     } catch (e) {
//       debugPrint('[HomeScreen] Error: $e');
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//           _hasError  = true;
//         });
//       }
//     } finally {
//       _isFetching = false;
//     }
//   }
//
//   // ─────────────────────────────────────────────
//   //  Load MORE posts (agla page — scroll se trigger hota hai)
//   // ─────────────────────────────────────────────
//   Future<void> _loadMorePosts() async {
//     // guard: pehle se load ho raha ho, ya aur posts hi na bache ho,
//     // ya list pehli baar load ho hi rahi ho — to kuch mat karo
//     if (_isLoadingMore || !_hasMore || _isFetching || !mounted) return;
//
//     setState(() => _isLoadingMore = true);
//
//     try {
//       final result = await PostController.getPostFeed(
//         limit:  _pageLimit,
//         offset: posts.length, // 👈 jitne posts already load ho chuke hain, wahan se aage
//       );
//       debugPrint('[HomeScreen] more posts fetched: ${result.length}');
//
//       if (!mounted) return;
//
//       // Naye posts ke liye local state banao (jaise _loadPosts mein hota hai)
//       for (final post in result) {
//         final id = _parseInt(post['id'] ?? post['post_id']);
//         if (!_localState.containsKey(id)) {
//           _localState[id] = _PostLocalState(
//             liked:         post['is_liked'] == true,
//             likesCount:    _parseInt(post['likes_count'] ?? post['likes'] ?? 0),
//             commentsCount: _parseInt(post['comments_count'] ?? post['comments'] ?? 0),
//           );
//         }
//       }
//
//       setState(() {
//         posts.addAll(result);
//         _messageLoading.addAll(List.filled(result.length, false));
//         _isLoadingMore = false;
//         // ✅ agar is baar limit se kam posts aaye, matlab yeh aakhri page tha
//         _hasMore = result.length >= _pageLimit;
//       });
//     } catch (e) {
//       debugPrint('[HomeScreen] load more error: $e');
//       if (mounted) setState(() => _isLoadingMore = false);
//     }
//   }
//
//   // ─────────────────────────────────────────────
//   //  Like / Dislike
//   // ─────────────────────────────────────────────
//   Future<void> _handleLike(int postId) async {
//     final state = _localState[postId];
//     if (state == null || state.likeLoading) return;
//
//     final wasLiked = state.liked;
//
//     // Optimistic update — turant dikhao
//     setState(() {
//       state.liked      = !wasLiked;
//       state.likesCount = wasLiked
//           ? (state.likesCount - 1).clamp(0, 999999)
//           : state.likesCount + 1;
//       state.likeLoading = true;
//     });
//
//     final result = await PostController.likeDislikePost(postId: postId);
//
//     if (!mounted) return;
//
//     if (result != null && result.success) {
//       // Success — loading hatao, count sahi rakho
//       setState(() => state.likeLoading = false);
//     } else {
//       // Fail — revert karo
//       setState(() {
//         state.liked      = wasLiked;
//         state.likesCount = wasLiked
//             ? state.likesCount + 1
//             : (state.likesCount - 1).clamp(0, 999999);
//         state.likeLoading = false;
//       });
//     }
//   }
//
//   // ─────────────────────────────────────────────
//   //  Comment Dialog
//   //  ✅ RED SCREEN FIX: mounted check + dialogContext
//   // ─────────────────────────────────────────────
//   Future<void> _showCommentDialog(int postId) async {
//     // ✅ context mounted check pehle
//     if (!mounted) return;
//
//     final double w = MediaQuery.of(context).size.width;
//     final double h = MediaQuery.of(context).size.height;
//     final TextEditingController commentCtrl = TextEditingController();
//
//     await showDialog<void>(
//       context: context,
//       barrierDismissible: true,
//       builder: (dialogContext) {
//         // ✅ FIX: isPosting ab yahan (outer builder scope) declare kiya hai,
//         // isliye setDialogState() call hone par yeh reset nahi hoga —
//         // pehle yeh StatefulBuilder ke andar wale builder mein tha jo
//         // har rebuild pe wapas false ho jata tha (spinner kabhi dikhta hi nahi tha)
//         bool isPosting = false;
//
//         // ✅ StatefulBuilder — dialog ke andar apna setState
//         return StatefulBuilder(
//           builder: (dialogContext, setDialogState) {
//             return Dialog(
//               backgroundColor: Theme.of(dialogContext).cardColor,
//               shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(w * (16.0 / 375))),
//               child: Padding(
//                 padding: EdgeInsets.all(w * (16.0 / 375)),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     Text(
//                       "Add Comment",
//                       style: TextStyle(
//                         fontSize: w * (18.0 / 375),
//                         fontWeight: FontWeight.w600,
//                         color: Theme.of(dialogContext).canvasColor,
//                       ),
//                     ),
//                     SizedBox(height: h * (15.0 / 810)),
//                     TextField(
//                       controller: commentCtrl,
//                       maxLines: 4,
//                       autofocus: true,
//                       style: TextStyle(color: Theme.of(dialogContext).canvasColor),
//                       decoration: InputDecoration(
//                         hintText: "Write your comment...",
//                         hintStyle: const TextStyle(color: Colors.grey),
//                         border: OutlineInputBorder(
//                             borderRadius: BorderRadius.circular(w * (12.0 / 375))),
//                         contentPadding: EdgeInsets.all(w * (12.0 / 375)),
//                       ),
//                     ),
//                     SizedBox(height: h * (15.0 / 810)),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.end,
//                       children: [
//                         TextButton(
//                           // ✅ dialogContext use karo — red screen fix
//                           onPressed: isPosting
//                               ? null
//                               : () => Navigator.of(dialogContext).pop(),
//                           child: const Text("Cancel",
//                               style: TextStyle(color: Colors.grey)),
//                         ),
//                         SizedBox(width: w * (8.0 / 375)),
//                         ElevatedButton(
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Theme.of(dialogContext).primaryColor,
//                           ),
//                           onPressed: isPosting
//                               ? null
//                               : () async {
//                             final text = commentCtrl.text.trim();
//                             if (text.isEmpty) return;
//
//                             // ✅ FIX: dialog ab turant band nahi hota —
//                             // pehle spinner dikhao, request complete hone
//                             // do, phir hi band karo. Isse TextField/controller
//                             // request ke dauran zinda rehta hai — "used after
//                             // disposed" wali red-screen error yahi se aati thi.
//                             setDialogState(() => isPosting = true);
//
//                             final result = await PostController.addComment(
//                               postId: postId,
//                               comment: text,
//                             );
//
//                             if (dialogContext.mounted) {
//                               Navigator.of(dialogContext).pop();
//                             }
//
//                             // ✅ Comment count locally update karo — refresh pe bhi rahega
//                             if (result != null && result.success && mounted) {
//                               setState(() {
//                                 final state = _localState[postId];
//                                 if (state != null) {
//                                   state.commentsCount = state.commentsCount + 1;
//                                 }
//                               });
//                             }
//                           },
//                           child: isPosting
//                               ? SizedBox(
//                             width: w * (16.0 / 375),
//                             height: w * (16.0 / 375),
//                             child: const CircularProgressIndicator(
//                                 strokeWidth: 2, color: Colors.white),
//                           )
//                               : const Text("Post",
//                               style: TextStyle(color: Colors.white)),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           },
//         );
//       },
//     );
//
//     // ✅ FIX: dialog ka exit-animation poora khatam hone ke liye chhota sa
//     // delay diya hai — is se pehle "controller used after disposed" error
//     // aata tha kyunki animation abhi chal raha hota tha jab dispose() call
//     // ho jata tha
//     await Future.delayed(const Duration(milliseconds: 300));
//     commentCtrl.dispose();
//   }
//
//   // ─────────────────────────────────────────────
//   //  Share
//   // ─────────────────────────────────────────────
//   Future<void> _handleShare(int postId, Map<String, dynamic> post) async {
//     final caption  = post['caption']?.toString() ?? '';
//     final location = post['location']?.toString() ?? '';
//     final fileUrl  = post['file_url'] ?? post['display_url'] ?? '';
//
//     final shareText = [
//       if (caption.isNotEmpty) caption,
//       if (location.isNotEmpty) 'Location: $location',
//       if (fileUrl.isNotEmpty) fileUrl,
//     ].join('\n');
//
//     await Share.share(shareText);
//     await PostController.sharePost(postId: postId);
//   }
//
//   // ─────────────────────────────────────────────
//   //  Message (naya)
//   // ─────────────────────────────────────────────
//   Future<void> _handleMessage(int index) async {
//     if (index < 0 || index >= _messageLoading.length) return;
//     if (_messageLoading[index]) return;
//
//     final post     = posts[index];
//     final posterId = _parseInt(post['user_id']);
//
//     if (_myUserId != null && posterId == _myUserId) {
//       Get.snackbar('Info', 'Ye aap ki apni post hai.',
//           snackPosition: SnackPosition.BOTTOM);
//       return;
//     }
//
//     setState(() => _messageLoading[index] = true);
//
//     final conversation = await chatCtrl.createConversation(otherUserId: posterId);
//
//     if (!mounted) return;
//     setState(() => _messageLoading[index] = false);
//
//     if (conversation != null) {
//       final posterName   = post['user_name']?.toString() ?? 'User';
//       final posterAvatar = post['user_avatar_url']?.toString() ?? '';
//       Get.to(() => ChatDetailScreen(
//         conversationId : _parseInt(conversation['id']),
//         userName       : posterName,
//         userImg        : posterAvatar.isNotEmpty ? posterAvatar : null,
//         currentUserImg : chatCtrl.currentUserImg.value,
//       ));
//     }
//     // conversation null aaye to createConversation() khud error snackbar dikha chuka hoga
//   }
//
//   // ─────────────────────────────────────────────
//   //  Helpers
//   // ─────────────────────────────────────────────
//   int _parseInt(dynamic val) {
//     if (val == null) return 0;
//     if (val is int) return val;
//     if (val is double) return val.toInt();
//     return int.tryParse(val.toString()) ?? 0;
//   }
//
//   String _fmt(int n) {
//     if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
//     if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}k';
//     return n.toString();
//   }
//
//   List<String> _getTags(dynamic tags) {
//     if (tags == null) return [];
//     if (tags is List) return tags.map((e) => e.toString()).toList();
//     if (tags is String && tags.isNotEmpty) {
//       return tags.split(',').map((e) => e.trim().toUpperCase()).toList();
//     }
//     return [];
//   }
//
//   // ─────────────────────────────────────────────
//   //  BUILD
//   // ─────────────────────────────────────────────
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     if (_isLoading) {
//       return SizedBox(
//         height: h * (300.0 / 810),
//         child: const Center(child: CustomLoader()),
//       );
//     }
//
//     if (_hasError) {
//       return SizedBox(
//         height: h * (200.0 / 810),
//         child: Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Icon(Icons.wifi_off_rounded,
//                 color: Theme.of(context).canvasColor.withOpacity(0.4),
//                 size: w * (40.0 / 375)),
//             SizedBox(height: h * (12.0 / 810)),
//             Text("Could not load posts",
//                 style: TextStyle(
//                     color: Theme.of(context).canvasColor.withOpacity(0.5))),
//             SizedBox(height: h * (12.0 / 810)),
//             TextButton(
//               onPressed: _loadPosts,
//               child: Text("Retry",
//                   style: TextStyle(color: Theme.of(context).primaryColor)),
//             ),
//           ]),
//         ),
//       );
//     }
//
//     if (posts.isEmpty) {
//       return SizedBox(
//         height: h * (200.0 / 810),
//         child: Center(
//           child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
//             Icon(Icons.photo_library_outlined,
//                 color: Theme.of(context).canvasColor.withOpacity(0.3),
//                 size: w * (48.0 / 375)),
//             SizedBox(height: h * (12.0 / 810)),
//             Text(
//               "No posts yet.\nBe the first to post a moment!",
//               textAlign: TextAlign.center,
//               style: TextStyle(
//                   color: Theme.of(context).canvasColor.withOpacity(0.4),
//                   fontSize: w * (14.0 / 375)),
//             ),
//           ]),
//         ),
//       );
//     }
//
//     return ListView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       // ✅ FIX: cacheExtent kam karo — purane mobile ke liye
//       cacheExtent: 200,
//       addAutomaticKeepAlives: false,
//       addRepaintBoundaries: true,
//       // ✅ Pagination: agar aur posts baaki hain to end mein ek extra
//       // "loading" item dikhao
//       itemCount: posts.length + (_hasMore ? 1 : 0),
//       itemBuilder: (context, index) {
//         // ✅ Yeh wala item asal post nahi, "loading more" indicator hai
//         if (index >= posts.length) {
//           return Padding(
//             padding: EdgeInsets.symmetric(vertical: h * (20.0 / 810)),
//             child: Center(
//               child: _isLoadingMore
//                   ? SizedBox(
//                 width: w * (24.0 / 375),
//                 height: w * (24.0 / 375),
//                 child: CircularProgressIndicator(
//                   strokeWidth: 2,
//                   color: Theme.of(context).primaryColor,
//                 ),
//               )
//                   : const SizedBox.shrink(),
//             ),
//           );
//         }
//
//         final post    = posts[index];
//         final postId  = _parseInt(post['id'] ?? post['post_id']);
//
//         // ✅ FIX: is post ka view sirf ek dafa (is session mein) count karo
//         if (postId != 0 && !_viewedPostIds.contains(postId)) {
//           _viewedPostIds.add(postId);
//           // itemBuilder ke andar seedha setState/async call karne ki bajaye
//           // agla frame aane ke baad call karo — build ke dauran side-effect
//           // chalane se bachne ke liye
//           WidgetsBinding.instance.addPostFrameCallback((_) {
//             PostController.viewPost(postId: postId);
//           });
//         }
//
//         final state   = _localState[postId] ?? _PostLocalState();
//         final caption = post['caption']?.toString() ?? '';
//         final location      = post['location']?.toString() ?? '';
//         final createdAt     = post['date_text'] ?? post['created_at'] ?? '';
//         final tags          = _getTags(post['tags']);
//         final userAvatarUrl = post['user_avatar_url'] ?? post['user']?['avatar_url'] ?? '';
//         final postImageUrl  = post['file_url'] ?? post['display_url'] ?? '';
//         final postType      = post['type']?.toString() ?? '';
//         final bool msgLoading = index < _messageLoading.length ? _messageLoading[index] : false; // 👈 naya
//
//         return Container(
//           height: h * (379.0 / 810),
//           width: w * (335.0 / 375),
//           padding: EdgeInsets.symmetric(
//               horizontal: w * (10.0 / 375), vertical: h * (10.0 / 810)),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(w * (25.0 / 375)),
//             child: Stack(children: [
//               // ── Post image ──
//               Positioned.fill(child: _buildPostImage(postImageUrl, postType)),
//
//               // ── Gradient ──
//               Positioned.fill(
//                 child: Container(
//                   decoration: BoxDecoration(
//                     gradient: LinearGradient(
//                       colors: [
//                         Colors.black.withOpacity(0.5),
//                         Colors.transparent,
//                         Colors.black.withOpacity(0.9),
//                       ],
//                       begin: Alignment.topCenter,
//                       end: Alignment.bottomCenter,
//                     ),
//                   ),
//                 ),
//               ),
//
//               // ── User info top ──
//               Positioned(
//                 top: h * (20.0 / 810),
//                 left: w * (12.0 / 375),
//                 child: Row(children: [
//                   CircleAvatar(
//                     radius: w * (18.0 / 375),
//                     backgroundColor: Colors.grey.shade800,
//                     child: ClipOval(
//                       child: userAvatarUrl.toString().startsWith('http')
//                           ? CachedNetworkImage(
//                         imageUrl: userAvatarUrl.toString(),
//                         width: w * (36.0 / 375),
//                         height: w * (36.0 / 375),
//                         fit: BoxFit.cover,
//                         memCacheWidth: 80,
//                         memCacheHeight: 80,
//                         errorWidget: (_, __, ___) => Image.asset(
//                             'assets/images/author.png',
//                             fit: BoxFit.cover),
//                       )
//                           : Image.asset('assets/images/author.png',
//                           fit: BoxFit.cover),
//                     ),
//                   ),
//                   SizedBox(width: w * (8.0 / 375)),
//                   Text(
//                     createdAt.isNotEmpty
//                         ? '$createdAt${location.isNotEmpty ? ' • $location' : ''}'
//                         : location,
//                     style: TextStyle(
//                         color: Colors.white70, fontSize: w * (12.0 / 375)),
//                   ),
//                 ]),
//               ),
//
//               // ── Action buttons ──
//               Positioned(
//                 right: w * (10.0 / 375),
//                 bottom: h * (80.0 / 810),
//                 child: Column(children: [
//                   // Like
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () => _handleLike(postId),
//                       borderRadius: BorderRadius.circular(w * (30.0 / 375)),
//                       child: Padding(
//                         padding: EdgeInsets.all(w * (8.0 / 375)),
//                         child: state.likeLoading
//                             ? SizedBox(
//                           width: w * (24.0 / 375),
//                           height: w * (24.0 / 375),
//                           child: const CircularProgressIndicator(
//                               strokeWidth: 2, color: Colors.white),
//                         )
//                             : Icon(
//                           state.liked ? Icons.favorite : Icons.favorite_border,
//                           color: state.liked ? Colors.red : Colors.white,
//                           size: w * (28.0 / 375),
//                         ),
//                       ),
//                     ),
//                   ),
//                   Text(_fmt(state.likesCount),
//                       style: const TextStyle(color: Colors.white)),
//
//                   SizedBox(height: h * (12.0 / 810)),
//
//                   // Comment
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () => _showCommentDialog(postId),
//                       borderRadius: BorderRadius.circular(w * (30.0 / 375)),
//                       child: Padding(
//                         padding: EdgeInsets.all(w * (6.0 / 375)),
//                         child: Icon(Icons.chat_bubble_outline,
//                             color: Colors.white, size: w * (26.0 / 375)),
//                       ),
//                     ),
//                   ),
//                   Text(_fmt(state.commentsCount),
//                       style: const TextStyle(color: Colors.white)),
//
//                   SizedBox(height: h * (12.0 / 810)),
//
//                   // Share
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () => _handleShare(postId, post),
//                       borderRadius: BorderRadius.circular(w * (30.0 / 375)),
//                       child: Padding(
//                         padding: EdgeInsets.all(w * (6.0 / 375)),
//                         child: Icon(Icons.share,
//                             color: Colors.white, size: w * (26.0 / 375)),
//                       ),
//                     ),
//                   ),
//
//                   SizedBox(height: h * (12.0 / 810)), // 👈 gap kam kiya
//
//                   // ✅ Message — naya
//                   Material(
//                     color: Colors.transparent,
//                     child: InkWell(
//                       onTap: () => _handleMessage(index),
//                       borderRadius: BorderRadius.circular(w * (30.0 / 375)),
//                       child: Padding(
//                         padding: EdgeInsets.all(w * (6.0 / 375)),
//                         child: msgLoading
//                             ? SizedBox(
//                           width: w * (22.0 / 375),
//                           height: w * (22.0 / 375),
//                           child: const CircularProgressIndicator(
//                               strokeWidth: 2, color: Colors.white),
//                         )
//                             : Icon(Icons.send_outlined,
//                             color: Colors.white, size: w * (26.0 / 375)),
//                       ),
//                     ),
//                   ),
//                 ]),
//               ),
//
//               // ── Caption + Tags ──
//               Positioned(
//                 bottom: h * (20.0 / 810),
//                 left: w * (12.0 / 375),
//                 right: w * (70.0 / 375),
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     if (caption.isNotEmpty)
//                       Text(
//                         caption,
//                         maxLines: 2,
//                         overflow: TextOverflow.ellipsis,
//                         style: TextStyle(
//                           color: Colors.white,
//                           fontSize: w * (14.0 / 375),
//                           fontWeight: FontWeight.w400,
//                         ),
//                       ),
//                     if (tags.isNotEmpty) ...[
//                       SizedBox(height: h * (10.0 / 810)),
//                       Row(
//                         children: tags.take(2).map((tag) => Container(
//                           margin: EdgeInsets.only(right: w * (8.0 / 375)),
//                           padding: EdgeInsets.symmetric(
//                               horizontal: w * (12.0 / 375),
//                               vertical: h * (6.0 / 810)),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.white),
//                             borderRadius: BorderRadius.circular(w * (20.0 / 375)),
//                           ),
//                           child: Text(tag,
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontSize: w * (11.0 / 375))),
//                         )).toList(),
//                       ),
//                     ],
//                   ],
//                 ),
//               ),
//             ]),
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildPostImage(String url, String postType) {
//     double w = MediaQuery.of(context).size.width;
//     if (postType == 'video' || url.endsWith('.mp4') || url.endsWith('.mov')) {
//       return Container(
//         color: Colors.black,
//         child: Center(
//           child: Icon(Icons.play_circle_outline_rounded,
//               color: Colors.white54, size: w * (60.0 / 375)),
//         ),
//       );
//     }
//     if (url.startsWith('http')) {
//       return CachedNetworkImage(
//         imageUrl: url,
//         fit: BoxFit.cover,
//         memCacheWidth: 500,
//         memCacheHeight: 500,
//         placeholder: (context, url) => Container(
//           color: Colors.grey.shade900,
//           child: const Center(
//             child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white30),
//           ),
//         ),
//         errorWidget: (context, url, error) =>
//             Image.asset('assets/images/bh1.png', fit: BoxFit.cover),
//       );
//     }
//     return Image.asset('assets/images/bh1.png', fit: BoxFit.cover);
//   }
// }
//
// // ═══════════════════════════════════════════════════════════════
// //  Per-post local state — session mein yaad rakhta hai
// // ═══════════════════════════════════════════════════════════════
// class _PostLocalState {
//   bool liked;
//   int  likesCount;
//   int  commentsCount;
//   bool likeLoading;
//
//   _PostLocalState({
//     this.liked         = false,
//     this.likesCount    = 0,
//     this.commentsCount = 0,
//     this.likeLoading   = false,
//   });
// }
import 'dart:ffi';
import 'dart:io';
import 'dart:convert';
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/presentation_screen/NotificationScreen.dart';
import 'package:highlights/widgets/custom_loader.dart';
import 'package:share_plus/share_plus.dart';
import 'package:visibility_detector/visibility_detector.dart';
import '../Contollers/auth_controller.dart';
import '../Contollers/post_controller.dart';
import '../Contollers/chat_controller.dart';
import '../Services/time_services.dart';
import '../widgets/video_post_player.dart';
import 'chat_screen2.dart';
import 'post_viewer_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  String _displayTime = "Loading...";
  final AuthController _auth = Get.find<AuthController>();
  final GlobalKey<_ReelsScreenState> _reelsKey = GlobalKey<_ReelsScreenState>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _startTimer();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;
    final threshold = _scrollController.position.maxScrollExtent - 200;
    if (_scrollController.position.pixels >= threshold) {
      _reelsKey.currentState?._loadMorePosts();
    }
  }

  void _startTimer() {
    if (mounted) {
      setState(() {
        _displayTime = TimeService.formatDuration(TimeService.getTimeRemaining());
      });
    }
    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (mounted) {
        setState(() {
          _displayTime = TimeService.formatDuration(TimeService.getTimeRemaining());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _scrollController.dispose(); // 👈 naya
    super.dispose();
  }

  double _calculateProgress() {
    double progress = TimeService.getTimeRemaining().inSeconds / (3 * 24 * 3600);
    return (1.0 - progress).clamp(0.0, 1.0);
  }

  ImageProvider _getAvatarProvider() {
    if (_auth.userAvatarLocalPath.value.isNotEmpty &&
        File(_auth.userAvatarLocalPath.value).existsSync()) {
      return FileImage(File(_auth.userAvatarLocalPath.value));
    }
    final netOrBase64 = _auth.userAvatar.value;
    if (netOrBase64 != null && netOrBase64.isNotEmpty) {
      if (netOrBase64.startsWith('http')) return NetworkImage(netOrBase64);
      try {
        final cleanBase64 = netOrBase64.contains('base64,')
            ? netOrBase64.split('base64,')[1]
            : netOrBase64;
        return MemoryImage(base64Decode(cleanBase64.trim()));
      } catch (_) {}
    }
    return const AssetImage('assets/images/h0.png');
  }

  Set<int> selectedStories = {};
  final List<String> storyImages = [
    'assets/images/h1.png', 'assets/images/h2.png',
    'assets/images/h3.png', 'assets/images/h4.png',
    'assets/images/h1.png', 'assets/images/h2.png',
    'assets/images/h3.png', 'assets/images/h4.png',
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: () async {
            await _reelsKey.currentState?._loadPosts();
          },
          child: SingleChildScrollView(
            controller: _scrollController, // 👈 naya — pagination scroll detect karne ke liye
            // ✅ FIX: NeverScrollableScrollPhysics hatao — yeh infinite loop ka cause tha
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header ──
                Obx(() => Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: w * (20.625 / 375),
                      vertical: h * (9.72 / 810)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(children: [
                        CircleAvatar(
                          radius: w * (24.0 / 375),
                          backgroundImage: _getAvatarProvider(),
                        ),
                        SizedBox(width: w * (10.0 / 375)),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome ${_auth.userName.value.isNotEmpty ? _auth.userName.value : 'User'}!',
                              style: MainTextStyles.inter(
                                fontSize: w * (13.0 / 375),
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).canvasColor,
                              ),
                            ),
                            Text(
                              'Your moments are waiting',
                              style: MainTextStyles.inter(
                                fontSize: w * (9.0 / 375),
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFADAAAA),
                              ),
                            ),
                          ],
                        ),
                      ]),
                      GestureDetector(
                        onTap: () => Get.to(
                          Notificationscreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        ),
                        child: Theme.of(context).brightness == Brightness.dark
                            ? Image.asset('assets/images/icon.bell.png',
                            height: w * (48.0 / 375), width: w * (48.0 / 375))
                            : Container(
                          height: w * (45.0 / 375),
                          width: w * (45.0 / 375),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: Theme.of(context).primaryColor.withOpacity(0.15),
                            border: Border.all(
                              color: Theme.of(context).primaryColor.withOpacity(0.3),
                              width: w * (0.9375 / 375),
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.notifications_none_rounded,
                                color: Theme.of(context).canvasColor,
                                size: w * (22.0 / 375)),
                          ),
                        ),
                      ),
                    ],
                  ),
                )),

                SizedBox(height: h * (20.25 / 810)),

                // ── Timer Card ──
                Center(
                  child: Container(
                    width: w * (335.0 / 375),
                    height: h * (127.0 / 810),
                    padding: EdgeInsets.symmetric(
                        horizontal: w * (22.5 / 375),
                        vertical: h * (12.15 / 810)),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(w * (40.0 / 375)),
                      color: Theme.of(context).cardColor,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          TimeService.isPostingWindowOpen()
                              ? 'POSTING WINDOW CLOSES IN:'
                              : 'POSTING WINDOW OPENS IN:',
                          style: MainTextStyles.inter(
                            fontWeight: FontWeight.w300,
                            fontSize: w * (12.0 / 375),
                            color: const Color(0xFFADAAAA),
                          ),
                        ),
                        SizedBox(height: h * (4.05 / 810)),
                        Text(_displayTime,
                            style: MainTextStyles.inter(
                              fontWeight: FontWeight.w700,
                              fontSize: w * (26.25 / 375),
                              color: Theme.of(context).primaryColor,
                            )),
                        SizedBox(height: h * (8.1 / 810)),
                        Stack(children: [
                          Container(
                            height: h * (5.0 / 810),
                            width: w * (245.0 / 375),
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(w * (100.0 / 375)),
                            ),
                          ),
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: h * (5.0 / 810),
                            width: w * (245.0 / 375) * _calculateProgress(),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Theme.of(context).primaryColor.withOpacity(0.5),
                                Theme.of(context).primaryColor,
                              ]),
                              borderRadius: BorderRadius.circular(w * (100.0 / 375)),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: w * (4.0 / 375),
                                  offset: Offset(0, h * (2.0 / 810)),
                                )
                              ],
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: h * (16.2 / 810)),

                // ── Stories ──
                Container(
                  padding: EdgeInsets.symmetric(horizontal: w * (20.625 / 375)),
                  child: Text('Trending Now',
                      style: MainTextStyles.inter(
                        fontWeight: FontWeight.w600,
                        fontSize: w * (16.0 / 375),
                        color: Theme.of(context).canvasColor,
                      )),
                ),
                SizedBox(height: h * (8.1 / 810)),
                SizedBox(
                  height: h * (90.0 / 810),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    itemCount: storyImages.length,
                    itemBuilder: (context, index) {
                      final bool isSelected = selectedStories.contains(index);
                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: w * (8.0 / 375)),
                        child: GestureDetector(
                          onTap: () => setState(() => selectedStories.add(index)),
                          child: Stack(children: [
                            Container(
                              width: w * (69.0 / 375),
                              height: w * (69.0 / 375),
                              padding: EdgeInsets.all(w * (1.0 / 375)),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected ? Colors.grey : Theme.of(context).primaryColor,
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.grey
                                      : Theme.of(context).primaryColor.withOpacity(0.5),
                                  width: w * (2.0 / 375),
                                ),
                              ),
                              child: CircleAvatar(
                                  backgroundImage: AssetImage(storyImages[index])),
                            ),
                            if (index == 0)
                              Positioned(
                                right: w * (5.0 / 375),
                                bottom: h * (10.0 / 810),
                                child: Container(
                                  width: w * (22.0 / 375),
                                  height: w * (22.0 / 375),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).canvasColor,
                                  ),
                                  child: Center(
                                    child: Icon(Icons.add,
                                        color: Theme.of(context).scaffoldBackgroundColor,
                                        size: w * (16.0 / 375)),
                                  ),
                                ),
                              ),
                          ]),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: h * (8.1 / 810)),

                // ── Posts Feed ──
                ReelsScreen(key: _reelsKey),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  ReelsScreen
// ═══════════════════════════════════════════════════════════════
class ReelsScreen extends StatefulWidget {
  const ReelsScreen({super.key});

  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  List<Map<String, dynamic>> posts = [];

  // ✅ Per-post local state — refresh tak yaad rakhta hai
  // Map<postId, {liked, likesCount, commentsCount}>
  final Map<int, _PostLocalState> _localState = {};

  bool _isLoading = true;
  bool _hasError  = false;
  // ✅ FIX: infinite loop rokne ke liye
  bool _isFetching = false;

  // ── View tracking (naya) ─────────────────────────────────────
  // ✅ FIX: views_count kabhi barhta hi nahi tha kyunki PostController.viewPost()
  // ko kahin call hi nahi kiya ja raha tha. Ab jab bhi koi post pehli baar
  // screen pe build ho (dikhe), ek dafa view count karte hain. Yeh Set track
  // karta hai ke kis-kis post ka view already bheja ja chuka hai (isi session
  // mein dobara dobara na bheje, warna views_count galat tarike se barh jayega)
  final Set<int> _viewedPostIds = {};

  // ── Video autoplay/pause (naya) ──────────────────────────────
  // ✅ Sirf ek hi post ka video ek waqt mein "active" (playing) hota hai —
  // yeh woh post hai jo screen pe sab se zyada visible hai
  int? _currentlyPlayingPostId;

  // ── Pagination (naya) ───────────────────────────────────────
  static const int _pageLimit = 20; // backend jitna ek baar mein deta hai
  bool _hasMore     = true;  // aur posts baaki hain ya nahi
  bool _isLoadingMore = false;

  // ── Message feature (naya) ──────────────────────────────────
  List<bool> _messageLoading = [];
  final ChatController chatCtrl = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController()); // 👈 agar ChatListScreen abhi tak open nahi hui to bhi safe
  int? _myUserId;

  @override
  void initState() {
    super.initState();
    _loadPosts();
    _loadMyUserId(); // 👈 naya
  }

  Future<void> _loadMyUserId() async {
    final id = await chatCtrl.getMyUserId();
    if (mounted) setState(() => _myUserId = id);
  }

  // ─────────────────────────────────────────────
  //  Load posts (pehla page — refresh pe bhi yehi chalta hai)
  // ─────────────────────────────────────────────
  Future<void> _loadPosts() async {
    // ✅ FIX: double call guard
    if (_isFetching) return;
    if (!mounted) return;

    _isFetching = true;
    setState(() {
      _isLoading = true;
      _hasError  = false;
    });

    try {
      final result = await PostController.getPostFeed(limit: _pageLimit, offset: 0);
      debugPrint('[HomeScreen] posts fetched: ${result.length}');

      if (mounted) {
        // ✅ Naye posts ke liye local state banao
        // Purani liked state preserve karo agar same post dobara aaye
        for (final post in result) {
          final id = _parseInt(post['id'] ?? post['post_id']);
          if (!_localState.containsKey(id)) {
            // Pehli baar — API se is_liked aur counts lo
            _localState[id] = _PostLocalState(
              liked:         post['is_liked'] == true,
              likesCount:    _parseInt(post['likes_count'] ?? post['likes'] ?? 0),
              commentsCount: _parseInt(post['comments_count'] ?? post['comments'] ?? 0),
            );
          }
          // Agar already exist karta hai to purani liked/count state rakho
          // (refresh pe like na gayab ho)
        }

        setState(() {
          posts           = result;
          _messageLoading = List.filled(result.length, false); // 👈 naya
          _isLoading      = false;
          // ✅ agar pehle page mein hi limit se kam posts aaye, matlab aur nahi hain
          _hasMore        = result.length >= _pageLimit;
        });
      }
    } catch (e) {
      debugPrint('[HomeScreen] Error: $e');
      if (mounted) {
        setState(() {
          _isLoading = false;
          _hasError  = true;
        });
      }
    } finally {
      _isFetching = false;
    }
  }

  // ─────────────────────────────────────────────
  //  Load MORE posts (agla page — scroll se trigger hota hai)
  // ─────────────────────────────────────────────
  Future<void> _loadMorePosts() async {
    // guard: pehle se load ho raha ho, ya aur posts hi na bache ho,
    // ya list pehli baar load ho hi rahi ho — to kuch mat karo
    if (_isLoadingMore || !_hasMore || _isFetching || !mounted) return;

    setState(() => _isLoadingMore = true);

    try {
      final result = await PostController.getPostFeed(
        limit:  _pageLimit,
        offset: posts.length, // 👈 jitne posts already load ho chuke hain, wahan se aage
      );
      debugPrint('[HomeScreen] more posts fetched: ${result.length}');

      if (!mounted) return;

      // Naye posts ke liye local state banao (jaise _loadPosts mein hota hai)
      for (final post in result) {
        final id = _parseInt(post['id'] ?? post['post_id']);
        if (!_localState.containsKey(id)) {
          _localState[id] = _PostLocalState(
            liked:         post['is_liked'] == true,
            likesCount:    _parseInt(post['likes_count'] ?? post['likes'] ?? 0),
            commentsCount: _parseInt(post['comments_count'] ?? post['comments'] ?? 0),
          );
        }
      }

      setState(() {
        posts.addAll(result);
        _messageLoading.addAll(List.filled(result.length, false));
        _isLoadingMore = false;
        // ✅ agar is baar limit se kam posts aaye, matlab yeh aakhri page tha
        _hasMore = result.length >= _pageLimit;
      });
    } catch (e) {
      debugPrint('[HomeScreen] load more error: $e');
      if (mounted) setState(() => _isLoadingMore = false);
    }
  }

  // ─────────────────────────────────────────────
  //  Like / Dislike
  // ─────────────────────────────────────────────
  Future<void> _handleLike(int postId) async {
    final state = _localState[postId];
    if (state == null || state.likeLoading) return;

    final wasLiked = state.liked;

    // Optimistic update — turant dikhao
    setState(() {
      state.liked      = !wasLiked;
      state.likesCount = wasLiked
          ? (state.likesCount - 1).clamp(0, 999999)
          : state.likesCount + 1;
      state.likeLoading = true;
    });

    final result = await PostController.likeDislikePost(postId: postId);

    if (!mounted) return;

    if (result != null && result.success) {
      // Success — loading hatao, count sahi rakho
      setState(() => state.likeLoading = false);
    } else {
      // Fail — revert karo
      setState(() {
        state.liked      = wasLiked;
        state.likesCount = wasLiked
            ? state.likesCount + 1
            : (state.likesCount - 1).clamp(0, 999999);
        state.likeLoading = false;
      });
    }
  }

  // ─────────────────────────────────────────────
  //  Comment Dialog
  //  ✅ RED SCREEN FIX: mounted check + dialogContext
  // ─────────────────────────────────────────────
  Future<void> _showCommentDialog(int postId) async {
    // ✅ context mounted check pehle
    if (!mounted) return;

    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    final TextEditingController commentCtrl = TextEditingController();

    await showDialog<void>(
      context: context,
      barrierDismissible: true,
      builder: (dialogContext) {
        // ✅ FIX: isPosting ab yahan (outer builder scope) declare kiya hai,
        // isliye setDialogState() call hone par yeh reset nahi hoga —
        // pehle yeh StatefulBuilder ke andar wale builder mein tha jo
        // har rebuild pe wapas false ho jata tha (spinner kabhi dikhta hi nahi tha)
        bool isPosting = false;

        // ✅ StatefulBuilder — dialog ke andar apna setState
        return StatefulBuilder(
          builder: (dialogContext, setDialogState) {
            return Dialog(
              backgroundColor: Theme.of(dialogContext).cardColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * (16.0 / 375))),
              child: Padding(
                padding: EdgeInsets.all(w * (16.0 / 375)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Add Comment",
                      style: TextStyle(
                        fontSize: w * (18.0 / 375),
                        fontWeight: FontWeight.w600,
                        color: Theme.of(dialogContext).canvasColor,
                      ),
                    ),
                    SizedBox(height: h * (15.0 / 810)),
                    TextField(
                      controller: commentCtrl,
                      maxLines: 4,
                      autofocus: true,
                      style: TextStyle(color: Theme.of(dialogContext).canvasColor),
                      decoration: InputDecoration(
                        hintText: "Write your comment...",
                        hintStyle: const TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(w * (12.0 / 375))),
                        contentPadding: EdgeInsets.all(w * (12.0 / 375)),
                      ),
                    ),
                    SizedBox(height: h * (15.0 / 810)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          // ✅ dialogContext use karo — red screen fix
                          onPressed: isPosting
                              ? null
                              : () => Navigator.of(dialogContext).pop(),
                          child: const Text("Cancel",
                              style: TextStyle(color: Colors.grey)),
                        ),
                        SizedBox(width: w * (8.0 / 375)),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(dialogContext).primaryColor,
                          ),
                          onPressed: isPosting
                              ? null
                              : () async {
                            final text = commentCtrl.text.trim();
                            if (text.isEmpty) return;

                            // ✅ FIX: dialog ab turant band nahi hota —
                            // pehle spinner dikhao, request complete hone
                            // do, phir hi band karo. Isse TextField/controller
                            // request ke dauran zinda rehta hai — "used after
                            // disposed" wali red-screen error yahi se aati thi.
                            setDialogState(() => isPosting = true);

                            final result = await PostController.addComment(
                              postId: postId,
                              comment: text,
                            );

                            if (dialogContext.mounted) {
                              Navigator.of(dialogContext).pop();
                            }

                            // ✅ Comment count locally update karo — refresh pe bhi rahega
                            if (result != null && result.success && mounted) {
                              setState(() {
                                final state = _localState[postId];
                                if (state != null) {
                                  state.commentsCount = state.commentsCount + 1;
                                }
                              });
                            }
                          },
                          child: isPosting
                              ? SizedBox(
                            width: w * (16.0 / 375),
                            height: w * (16.0 / 375),
                            child: const CircularProgressIndicator(
                                strokeWidth: 2, color: Colors.white),
                          )
                              : const Text("Post",
                              style: TextStyle(color: Colors.white)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );

    // ✅ FIX: dialog ka exit-animation poora khatam hone ke liye chhota sa
    // delay diya hai — is se pehle "controller used after disposed" error
    // aata tha kyunki animation abhi chal raha hota tha jab dispose() call
    // ho jata tha
    await Future.delayed(const Duration(milliseconds: 300));
    commentCtrl.dispose();
  }

  // ─────────────────────────────────────────────
  //  Share
  // ─────────────────────────────────────────────
  Future<void> _handleShare(int postId, Map<String, dynamic> post) async {
    final caption  = post['caption']?.toString() ?? '';
    final location = post['location']?.toString() ?? '';
    final fileUrl  = post['file_url'] ?? post['display_url'] ?? '';

    final shareText = [
      if (caption.isNotEmpty) caption,
      if (location.isNotEmpty) 'Location: $location',
      if (fileUrl.isNotEmpty) fileUrl,
    ].join('\n');

    await Share.share(shareText);
    await PostController.sharePost(postId: postId);
  }

  // ─────────────────────────────────────────────
  //  Message (naya)
  // ─────────────────────────────────────────────
  Future<void> _handleMessage(int index) async {
    if (index < 0 || index >= _messageLoading.length) return;
    if (_messageLoading[index]) return;

    final post     = posts[index];
    final posterId = _parseInt(post['user_id']);

    if (_myUserId != null && posterId == _myUserId) {
      Get.snackbar('Info', 'Ye aap ki apni post hai.',
          snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() => _messageLoading[index] = true);

    final conversation = await chatCtrl.createConversation(otherUserId: posterId);

    if (!mounted) return;
    setState(() => _messageLoading[index] = false);

    if (conversation != null) {
      final posterName   = post['user_name']?.toString() ?? 'User';
      final posterAvatar = post['user_avatar_url']?.toString() ?? '';
      Get.to(() => ChatDetailScreen(
        conversationId : _parseInt(conversation['id']),
        userName       : posterName,
        userImg        : posterAvatar.isNotEmpty ? posterAvatar : null,
        currentUserImg : chatCtrl.currentUserImg.value,
        otherUserId: posterId,
      ));
    }
    // conversation null aaye to createConversation() khud error snackbar dikha chuka hoga
  }

  // ─────────────────────────────────────────────
  //  Helpers
  // ─────────────────────────────────────────────
  int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is double) return val.toInt();
    return int.tryParse(val.toString()) ?? 0;
  }

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }

  List<String> _getTags(dynamic tags) {
    if (tags == null) return [];
    if (tags is List) return tags.map((e) => e.toString()).toList();
    if (tags is String && tags.isNotEmpty) {
      return tags.split(',').map((e) => e.trim().toUpperCase()).toList();
    }
    return [];
  }

  // ✅ naya — "14 MINS AGO", "2 HOURS AGO", "TODAY", "YESTERDAY", ya
  // purani date ke liye "DD MMM YYYY". Backend UTC time bhejta hai
  // (bina 'Z' marker ke), isliye pehle usay explicitly UTC declare
  // kar ke .toLocal() se sahi device time mein convert karte hain
  // (jaise chat_list_screen.dart mein bhi kiya tha).
  static const List<String> _monthNames = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
  ];

  String _formatRelativeTime(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty || rawDate == 'null') return '';

    DateTime dt;
    try {
      String normalized = rawDate.contains('T') ? rawDate : rawDate.replaceFirst(' ', 'T');
      if (!normalized.endsWith('Z') && !normalized.contains('+')) {
        normalized = '${normalized}Z';
      }
      dt = DateTime.parse(normalized).toLocal();
    } catch (_) {
      return rawDate; // parse fail ho to raw string hi dikha do
    }

    final now  = DateTime.now();
    final diff = now.difference(dt);

    if (diff.inSeconds < 5)   return 'JUST NOW';
    if (diff.inMinutes < 1)   return '${diff.inSeconds} SECS AGO';
    if (diff.inMinutes < 60)  return '${diff.inMinutes} MINS AGO';
    if (diff.inHours < 24 && _isSameDay(dt, now)) {
      return '${diff.inHours} HOURS AGO';
    }

    final today     = DateTime(now.year, now.month, now.day);
    final postDay   = DateTime(dt.year, dt.month, dt.day);
    final dayDiff   = today.difference(postDay).inDays;

    if (dayDiff == 0) return 'TODAY';
    if (dayDiff == 1) return 'YESTERDAY';
    if (dayDiff < 7)  return '$dayDiff DAYS AGO';

    // ✅ ek hafte se purani post — asal date dikhao
    final monthName = _monthNames[dt.month - 1];
    if (dt.year == now.year) return '${dt.day} $monthName';
    return '${dt.day} $monthName ${dt.year}';
  }

  bool _isSameDay(DateTime a, DateTime b) =>
      a.year == b.year && a.month == b.month && a.day == b.day;

  // ─────────────────────────────────────────────
  //  BUILD
  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    if (_isLoading) {
      return SizedBox(
        height: h * (300.0 / 810),
        child: const Center(child: CustomLoader()),
      );
    }

    if (_hasError) {
      return SizedBox(
        height: h * (200.0 / 810),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.wifi_off_rounded,
                color: Theme.of(context).canvasColor.withOpacity(0.4),
                size: w * (40.0 / 375)),
            SizedBox(height: h * (12.0 / 810)),
            Text("Could not load posts",
                style: TextStyle(
                    color: Theme.of(context).canvasColor.withOpacity(0.5))),
            SizedBox(height: h * (12.0 / 810)),
            TextButton(
              onPressed: _loadPosts,
              child: Text("Retry",
                  style: TextStyle(color: Theme.of(context).primaryColor)),
            ),
          ]),
        ),
      );
    }

    if (posts.isEmpty) {
      return SizedBox(
        height: h * (200.0 / 810),
        child: Center(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Icon(Icons.photo_library_outlined,
                color: Theme.of(context).canvasColor.withOpacity(0.3),
                size: w * (48.0 / 375)),
            SizedBox(height: h * (12.0 / 810)),
            Text(
              "No posts yet.\nBe the first to post a moment!",
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).canvasColor.withOpacity(0.4),
                  fontSize: w * (14.0 / 375)),
            ),
          ]),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      // ✅ FIX: cacheExtent kam karo — purane mobile ke liye
      cacheExtent: 200,
      addAutomaticKeepAlives: false,
      addRepaintBoundaries: true,
      // ✅ Pagination: agar aur posts baaki hain to end mein ek extra
      // "loading" item dikhao
      itemCount: posts.length + (_hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        // ✅ Yeh wala item asal post nahi, "loading more" indicator hai
        if (index >= posts.length) {
          return Padding(
            padding: EdgeInsets.symmetric(vertical: h * (20.0 / 810)),
            child: Center(
              child: _isLoadingMore
                  ? SizedBox(
                width: w * (24.0 / 375),
                height: w * (24.0 / 375),
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: Theme.of(context).primaryColor,
                ),
              )
                  : const SizedBox.shrink(),
            ),
          );
        }

        final post    = posts[index];
        final postId  = _parseInt(post['id'] ?? post['post_id']);

        // ✅ FIX: is post ka view sirf ek dafa (is session mein) count karo
        if (postId != 0 && !_viewedPostIds.contains(postId)) {
          _viewedPostIds.add(postId);
          // itemBuilder ke andar seedha setState/async call karne ki bajaye
          // agla frame aane ke baad call karo — build ke dauran side-effect
          // chalane se bachne ke liye
          WidgetsBinding.instance.addPostFrameCallback((_) {
            PostController.viewPost(postId: postId);
          });
        }

        final state   = _localState[postId] ?? _PostLocalState();
        final caption = post['caption']?.toString() ?? '';
        final location      = post['location']?.toString() ?? '';
        final createdAt     = post['date_text'] ?? post['created_at'] ?? '';
        final tags          = _getTags(post['tags']);
        final userAvatarUrl = post['user_avatar_url'] ?? post['user']?['avatar_url'] ?? '';
        final postImageUrl  = post['file_url'] ?? post['display_url'] ?? '';
        final postType      = post['type']?.toString() ?? '';
        // ✅ naya — username aur "14 MINS AGO" jaisa relative time
        final userName      = post['user_name']?.toString() ??
            post['username']?.toString() ?? 'User';
        final relativeTime  = _formatRelativeTime(createdAt?.toString());
        final bool msgLoading = index < _messageLoading.length ? _messageLoading[index] : false; // 👈 naya

        return VisibilityDetector(
          // ✅ naya — is post ki visibility track karta hai
          key: ValueKey('post-visibility-$postId'),
          onVisibilityChanged: (info) {
            if (!mounted) return;
            final visibleFraction = info.visibleFraction;
            // ✅ 65%+ visible ho to yeh post "active" (playing) ban jati hai
            if (visibleFraction > 0.65) {
              if (_currentlyPlayingPostId != postId) {
                setState(() => _currentlyPlayingPostId = postId);
              }
            } else if (_currentlyPlayingPostId == postId) {
              // ✅ yehi post ab kaafi neeche/upar scroll ho chuki hai — pause
              setState(() => _currentlyPlayingPostId = null);
            }
          },
          child: GestureDetector(
            // ✅ naya — post pe tap karo to TikTok jaisa full-screen viewer khule
            onTap: () => Get.to(
                  () => PostViewerScreen(posts: posts, initialIndex: index),
              transition: Transition.fadeIn,
            ),
            child: Container(
              height: h * (379.0 / 810),
              width: w * (335.0 / 375),
              padding: EdgeInsets.symmetric(
                  horizontal: w * (10.0 / 375), vertical: h * (10.0 / 810)),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(w * (25.0 / 375)),
                child: Stack(children: [
                  // ── Post image/video ──
                  Positioned.fill(
                    child: _buildPostImage(
                      postImageUrl,
                      postType,
                      isActive: _currentlyPlayingPostId == postId, // 👈 naya
                    ),
                  ),

                  // ── Gradient ──
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withOpacity(0.5),
                            Colors.transparent,
                            Colors.black.withOpacity(0.9),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),

                  // ── User info top ──
                  Positioned(
                    top: h * (20.0 / 810),
                    left: w * (12.0 / 375),
                    right: w * (60.0 / 375),
                    child: Row(children: [
                      CircleAvatar(
                        radius: w * (18.0 / 375),
                        backgroundColor: Colors.grey.shade800,
                        child: ClipOval(
                          child: userAvatarUrl.toString().startsWith('http')
                              ? CachedNetworkImage(
                            imageUrl: userAvatarUrl.toString(),
                            width: w * (36.0 / 375),
                            height: w * (36.0 / 375),
                            fit: BoxFit.cover,
                            memCacheWidth: 80,
                            memCacheHeight: 80,
                            errorWidget: (_, __, ___) => Image.asset(
                                'assets/images/author.png',
                                fit: BoxFit.cover),
                          )
                              : Image.asset('assets/images/author.png',
                              fit: BoxFit.cover),
                        ),
                      ),
                      SizedBox(width: w * (8.0 / 375)),
                      // ✅ naya — username (bold) upar, time • location neeche
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              userName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: w * (13.0 / 375),
                              ),
                            ),
                            SizedBox(height: h * (2.0 / 810)),
                            Text(
                              relativeTime.isNotEmpty
                                  ? '$relativeTime${location.isNotEmpty ? ' • $location' : ''}'
                                  : location,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: w * (10.5 / 375),
                                letterSpacing: 0.3,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),

                  // ── Action buttons ──
                  Positioned(
                    right: w * (10.0 / 375),
                    bottom: h * (80.0 / 810),
                    child: Column(children: [
                      // Like
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _handleLike(postId),
                          borderRadius: BorderRadius.circular(w * (30.0 / 375)),
                          child: Padding(
                            padding: EdgeInsets.all(w * (8.0 / 375)),
                            child: state.likeLoading
                                ? SizedBox(
                              width: w * (24.0 / 375),
                              height: w * (24.0 / 375),
                              child: const CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                                : Icon(
                              state.liked ? Icons.favorite : Icons.favorite_border,
                              color: state.liked ? Colors.red : Colors.white,
                              size: w * (28.0 / 375),
                            ),
                          ),
                        ),
                      ),
                      Text(_fmt(state.likesCount),
                          style: const TextStyle(color: Colors.white)),

                      SizedBox(height: h * (12.0 / 810)),

                      // Comment
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _showCommentDialog(postId),
                          borderRadius: BorderRadius.circular(w * (30.0 / 375)),
                          child: Padding(
                            padding: EdgeInsets.all(w * (6.0 / 375)),
                            child: Icon(Icons.chat_bubble_outline,
                                color: Colors.white, size: w * (26.0 / 375)),
                          ),
                        ),
                      ),
                      Text(_fmt(state.commentsCount),
                          style: const TextStyle(color: Colors.white)),

                      SizedBox(height: h * (12.0 / 810)),

                      // Share
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _handleShare(postId, post),
                          borderRadius: BorderRadius.circular(w * (30.0 / 375)),
                          child: Padding(
                            padding: EdgeInsets.all(w * (6.0 / 375)),
                            child: Icon(Icons.share,
                                color: Colors.white, size: w * (26.0 / 375)),
                          ),
                        ),
                      ),

                      SizedBox(height: h * (12.0 / 810)), // 👈 gap kam kiya

                      // ✅ Message — naya
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _handleMessage(index),
                          borderRadius: BorderRadius.circular(w * (30.0 / 375)),
                          child: Padding(
                            padding: EdgeInsets.all(w * (6.0 / 375)),
                            child: msgLoading
                                ? SizedBox(
                              width: w * (22.0 / 375),
                              height: w * (22.0 / 375),
                              child: const CircularProgressIndicator(
                                  strokeWidth: 2, color: Colors.white),
                            )
                                : Icon(Icons.send_outlined,
                                color: Colors.white, size: w * (26.0 / 375)),
                          ),
                        ),
                      ),
                    ]),
                  ),

                  // ── Caption + Tags ──
                  Positioned(
                    bottom: h * (20.0 / 810),
                    left: w * (12.0 / 375),
                    right: w * (70.0 / 375),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (caption.isNotEmpty)
                          Text(
                            caption,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: w * (14.0 / 375),
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        if (tags.isNotEmpty) ...[
                          SizedBox(height: h * (10.0 / 810)),
                          Row(
                            children: tags.take(2).map((tag) => Container(
                              margin: EdgeInsets.only(right: w * (8.0 / 375)),
                              padding: EdgeInsets.symmetric(
                                  horizontal: w * (12.0 / 375),
                                  vertical: h * (6.0 / 810)),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(w * (20.0 / 375)),
                              ),
                              child: Text(tag,
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: w * (11.0 / 375))),
                            )).toList(),
                          ),
                        ],
                      ],
                    ),
                  ),
                ]),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPostImage(String url, String postType, {required bool isActive}) {
    double w = MediaQuery.of(context).size.width;
    if (postType == 'video' || url.endsWith('.mp4') || url.endsWith('.mov')) {
      // ✅ naya — ab sirf static icon nahi, asal video chalti hai jab
      // yeh post screen pe visible ho (isActive)
      return VideoPostPlayer(
        videoUrl: url,
        isActive: isActive,
        showMuteButton: isActive, // sirf jo abhi chal rahi ho usi pe mute button
      );
    }
    if (url.startsWith('http')) {
      return CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
        memCacheWidth: 500,
        memCacheHeight: 500,
        placeholder: (context, url) => Container(
          color: Colors.grey.shade900,
          child: const Center(
            child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white30),
          ),
        ),
        errorWidget: (context, url, error) =>
            Image.asset('assets/images/bh1.png', fit: BoxFit.cover),
      );
    }
    return Image.asset('assets/images/bh1.png', fit: BoxFit.cover);
  }
}

// ═══════════════════════════════════════════════════════════════
//  Per-post local state — session mein yaad rakhta hai
// ═══════════════════════════════════════════════════════════════
class _PostLocalState {
  bool liked;
  int  likesCount;
  int  commentsCount;
  bool likeLoading;

  _PostLocalState({
    this.liked         = false,
    this.likesCount    = 0,
    this.commentsCount = 0,
    this.likeLoading   = false,
  });
}
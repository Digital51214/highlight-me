//
// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
// import 'package:highlights/main_pages/chat_screen2.dart';
// import 'package:highlights/main_pages/memories_screen.dart';
// import 'package:highlights/presentation_screen/SettingScreen.dart';
// import '../Contollers/auth_controller.dart';
// import '../Contollers/profile_controller.dart';
//
// class ProfileScreen extends StatefulWidget {
//   const ProfileScreen({super.key});
//
//   @override
//   State<ProfileScreen> createState() => _ProfileScreenState();
// }
//
// class _ProfileScreenState extends State<ProfileScreen> {
//   final List<String> postImages = const [
//     'assets/images/pr1.png', 'assets/images/pr2.png', 'assets/images/pr3.png',
//     'assets/images/pr4.png', 'assets/images/pr5.png', 'assets/images/pr6.png',
//   ];
//   late final AuthController _auth;
//
//   @override
//   void initState() {
//     super.initState();
//     _auth = Get.find<AuthController>();
//     _refreshProfileData();
//   }
//
//   void _refreshProfileData() {
//     ProfileController.getProfileStats();
//     ProfileController.getProfileStatsWithRank();
//   }
//
//   String _fmt(int n) {
//     if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
//     if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}k';
//     return n.toString();
//   }
//
//   ImageProvider _getAvatarProvider() {
//     if (_auth.userAvatarLocalPath.value.isNotEmpty && File(_auth.userAvatarLocalPath.value).existsSync()) {
//       return FileImage(File(_auth.userAvatarLocalPath.value));
//     }
//     final netOrBase64 = _auth.userAvatar.value;
//     if (netOrBase64 != null && netOrBase64.isNotEmpty) {
//       if (netOrBase64.startsWith('http')) {
//         print(netOrBase64);
//         return NetworkImage(netOrBase64);
//       } else {
//         try {
//           final cleanBase64 = netOrBase64.contains('base64,') ? netOrBase64.split('base64,')[1] : netOrBase64;
//           return MemoryImage(base64Decode(cleanBase64.trim()));
//         } catch (_) {}
//       }
//     }
//     return const AssetImage('assets/images/h0.png');
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color cardBgColor = Theme.of(context).cardColor;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               Padding(
//                 padding: EdgeInsets.symmetric(
//                   horizontal: w * (20.625 / 375),
//                   vertical: h * (9.72 / 810),
//                 ),
//                 child: Row(
//                   children: [
//                     Image.asset(
//                       'assets/images/logo.png',
//                       height: h * (80.0 / 810),
//                       width: w * (120.0 / 375),
//                       color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,
//                     ),
//                     const Spacer(),
//                     GestureDetector(
//                       onTap: () => Get.to(Settingscreen(), transition: Transition.noTransition, duration: Duration.zero),
//                       child: Theme.of(context).brightness == Brightness.dark
//                           ? Image.asset('assets/images/icon.setting.png', height: w * (48.0 / 375), width: w * (48.0 / 375))
//                           : Container(
//                         height: w * (45.0 / 375),
//                         width: w * (45.0 / 375),
//                         decoration: BoxDecoration(
//                           shape: BoxShape.circle,
//                           color: Theme.of(context).primaryColor.withOpacity(0.15),
//                           border: Border.all(color: Theme.of(context).primaryColor.withOpacity(0.3), width: w * (1.0 / 375)),
//                         ),
//                         child: Center(child: Icon(Icons.settings, color: Theme.of(context).canvasColor, size: w * (22.0 / 375))),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: h * (8.1 / 810)),
//               Obx(() => Column(
//                 children: [
//                   Stack(
//                     children: [
//                       CircleAvatar(
//                         radius: w * (55.0 / 375),
//                         backgroundColor: primaryColor.withOpacity(0.5),
//                         child: CircleAvatar(
//                           radius: w * (52.0 / 375),
//                           backgroundImage: _getAvatarProvider(),
//                         ),
//                       ),
//                       Positioned(
//                         bottom: h * (4.05 / 810),
//                         right: w * (5.0 / 375),
//                         child: Image.asset('assets/images/check.png', height: w * (30.0 / 375), width: w * (30.0 / 375)),
//                       )
//                     ],
//                   ),
//                   SizedBox(height: h * (12.15 / 810)),
//                   Text(
//                     _auth.userName.value.isNotEmpty ? _auth.userName.value : '',
//                     style: GoogleFonts.inter(color: textColor, fontSize: w * (16.0 / 375), fontWeight: FontWeight.w700),
//                   ),
//                   SizedBox(height: h * (6.48 / 810)),
//                   Padding(
//                     padding: EdgeInsets.symmetric(horizontal: w * (30.0 / 375)),
//                     child: Text(
//                       _auth.userBio.value,
//                       textAlign: TextAlign.center,
//                       style: GoogleFonts.inter(fontWeight: FontWeight.w400, color: textColor.withOpacity(0.6), fontSize: w * (14.0 / 375)),
//                     ),
//                   ),
//                 ],
//               )),
//               SizedBox(height: h * (20.25 / 810)),
//               Obx(() => Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _StatItem(val: _fmt(_auth.likesCount.value), label: "Likes", textColor: textColor, primaryColor: primaryColor, w: w),
//                   _StatItem(val: _fmt(_auth.commentsCount.value), label: "Comments", textColor: textColor, primaryColor: primaryColor, w: w),
//                   _StatItem(val: _fmt(_auth.sharesCount.value), label: "Shares", textColor: textColor, primaryColor: primaryColor, w: w),
//                   _StatItem(val: _auth.userRank.value > 0 ? _auth.userRank.value.toString() : "—", label: "Rank", isRank: true, textColor: textColor, primaryColor: primaryColor, w: w),
//                 ],
//               )),
//               SizedBox(height: h * (20.25 / 810)),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: w * (10.0 / 375)),
//                 child: SizedBox(
//                   height: h * (73.0 / 810),
//                   child: Obx(() => ListView(
//                     scrollDirection: Axis.horizontal,
//                     children: [
//                       _SupportCard(icon: Icons.restaurant, title: "Food Support", sub: "${_auth.foodSupport.value} vouchers", cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
//                       _SupportCard(icon: Icons.directions_bus, title: "Free Transport", sub: "${_auth.transportSupport.value} days", cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
//                       _SupportCard(icon: Icons.card_giftcard, title: "Cash Reward", sub: "Rs ${_auth.cashReward.value}", cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
//                       _SupportCard(icon: Icons.school, title: "Scholarship", sub: "Yearly bonuses", cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
//                       _SupportCard(icon: Icons.medical_services, title: "Medical", sub: "emergency case", cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
//                     ],
//                   )),
//                 ),
//               ),
//               SizedBox(height: h * (20.25 / 810)),
//               Padding(
//                 padding: EdgeInsets.symmetric(horizontal: w * (20.0 / 375)),
//                 child: Row(
//                   children: [
//                     Icon(Icons.add, color: primaryColor, size: w * (20.0 / 375)),
//                     SizedBox(width: w * (10.0 / 375)),
//                     Text("Post Analytics", style: GoogleFonts.inter(color: textColor, fontSize: w * (18.0 / 375), fontWeight: FontWeight.bold)),
//                     const Spacer(),
//                     Text("Latest", style: GoogleFonts.inter(color: textColor.withOpacity(0.6), fontSize: w * (12.0 / 375))),
//                     SizedBox(width: w * (15.0 / 375)),
//                     GestureDetector(
//                       onTap: () => Get.to(YourMemoriesScreen(), transition: Transition.noTransition, duration: Duration.zero),
//                       child: Text("Archived Posts", style: GoogleFonts.inter(color: primaryColor, fontSize: w * (12.0 / 375))),
//                     ),
//                   ],
//                 ),
//               ),
//               SizedBox(height: h * (16.2 / 810)),
//               GridView.builder(
//                 padding: EdgeInsets.symmetric(horizontal: w * (20.0 / 375)),
//                 shrinkWrap: true,
//                 physics: const NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   crossAxisSpacing: w * (12.0 / 375),
//                   mainAxisSpacing: h * (12.0 / 810),
//                   childAspectRatio: 1.4,
//                 ),
//                 itemCount: postImages.length,
//                 itemBuilder: (context, index) => _PostItem(imagePath: postImages[index], w: w, h: h),
//               ),
//               SizedBox(height: h * (32.4 / 810)),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class _StatItem extends StatelessWidget {
//   final String val, label; final bool isRank; final Color textColor; final Color primaryColor; final double w;
//   const _StatItem({required this.val, required this.label, required this.textColor, required this.primaryColor, required this.w, this.isRank = false});
//   @override Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Row(
//           children: [
//             Text(val, style: GoogleFonts.inter(fontWeight: FontWeight.w400, color: textColor, fontSize: w * (16.0 / 375))),
//             if (isRank) Icon(Icons.bolt, color: primaryColor, size: w * (11.0 / 375))
//           ],
//         ),
//         Text(label, style: GoogleFonts.inter(fontWeight: FontWeight.w400, color: AppColors.grey1, fontSize: w * (11.0 / 375)))
//       ],
//     );
//   }
// }
//
// class _SupportCard extends StatelessWidget {
//   final IconData icon; final String title, sub; final Color cardColor; final Color textColor; final Color primaryColor; final double w; final double h;
//   const _SupportCard({required this.icon, required this.title, required this.sub, required this.cardColor, required this.textColor, required this.primaryColor, required this.w, required this.h});
//   @override Widget build(BuildContext context) {
//     return Container(
//       height: h * (73.0 / 810),
//       width: w * (110.0 / 375),
//       margin: EdgeInsets.symmetric(horizontal: w * (5.0 / 375)),
//       padding: EdgeInsets.all(w * (8.0 / 375)),
//       decoration: BoxDecoration(color: cardColor, borderRadius: BorderRadius.circular(w * (20.0 / 375)), image: const DecorationImage(image: AssetImage('assets/images/box.png'), fit: BoxFit.cover, opacity: 0.1)),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(icon, color: primaryColor, size: w * (14.0 / 375)),
//           SizedBox(height: h * (4.86 / 810)),
//           Text(title, maxLines: 1, overflow: TextOverflow.ellipsis, style: GoogleFonts.inter(color: textColor, fontSize: w * (10.0 / 375), fontWeight: FontWeight.w400)),
//           SizedBox(height: h * (1.62 / 810)),
//           Text(sub, textAlign: TextAlign.center, style: GoogleFonts.inter(color: AppColors.grey, fontSize: w * (6.0 / 375), fontWeight: FontWeight.w400)),
//         ],
//       ),
//     );
//   }
// }
//
// class _PostItem extends StatelessWidget {
//   final String imagePath; final double w; final double h;
//   const _PostItem({required this.imagePath, required this.w, required this.h});
//   @override Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(w * (15.0 / 375)),
//         image: DecorationImage(image: imagePath.contains('assets') ? AssetImage(imagePath) : FileImage(File(imagePath)) as ImageProvider, fit: BoxFit.cover),
//       ),
//       child: Container(
//         padding: EdgeInsets.all(w * (10.0 / 375)),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(w * (15.0 / 375)), gradient: LinearGradient(begin: Alignment.topCenter, end: Alignment.bottomCenter, colors: [Colors.transparent, Colors.black.withOpacity(0.8)])),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             Row(
//               children: [
//                 Icon(Icons.visibility, color: Colors.white, size: w * (12.0 / 375)),
//                 SizedBox(width: w * (4.0 / 375)),
//                 Text("4.1k", style: TextStyle(color: Colors.white, fontSize: w * (10.0 / 375))),
//                 SizedBox(width: w * (8.0 / 375)),
//                 Icon(Icons.favorite, color: Colors.white, size: w * (12.0 / 375)),
//                 SizedBox(width: w * (4.0 / 375)),
//                 Text("820", style: TextStyle(color: Colors.white, fontSize: w * (10.0 / 375))),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/main_pages/memories_screen.dart';
import 'package:highlights/presentation_screen/SettingScreen.dart';
import '../Contollers/auth_controller.dart';
import '../Contollers/profile_controller.dart';
import '../Contollers/post_controller.dart';
import '../core/models/post_analytics.dart';

// ═══════════════════════════════════════════════════════════════
//  Shimmer — YouTube jaisa animated loading
// ═══════════════════════════════════════════════════════════════
class _Shimmer extends StatefulWidget {
  final double width, height, borderRadius;
  const _Shimmer({
    required this.width,
    required this.height,
    this.borderRadius = 8,
  });

  @override
  State<_Shimmer> createState() => _ShimmerState();
}

class _ShimmerState extends State<_Shimmer>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat();
    _anim = Tween<double>(begin: -2, end: 2)
        .animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final Color base      = isDark ? Colors.grey[800]! : Colors.grey[300]!;
    final Color highlight = isDark ? Colors.grey[600]! : Colors.grey[100]!;

    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.borderRadius),
          gradient: LinearGradient(
            begin: Alignment(_anim.value - 1, 0),
            end:   Alignment(_anim.value + 1, 0),
            colors: [base, highlight, base],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  ProfileScreen
// ═══════════════════════════════════════════════════════════════
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late final AuthController _auth;

  // ── Analytics state ──
  AnalyticsSummary _summary = AnalyticsSummary.empty();
  final List<AnalyticsPost> _posts = [];

  // ── Loading flags ──
  bool _statsLoading = true;
  bool _postsLoading = true;
  bool _loadingMore  = false;
  bool _hasMore      = true;

  // ── Pagination (client-side slice from full list) ──
  List<AnalyticsPost> _allPosts = [];
  // ✅ Purane mobile ke liye 4 — zyada images ek saath crash kar sakti hain
  static const int _pageSize = 4;

  final ScrollController _scrollController = ScrollController();

  // ───────────────────────────────────────────
  @override
  void initState() {
    super.initState();
    _auth = Get.find<AuthController>();
    _loadAll();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  // ── Pull-to-refresh / first load ──
  Future<void> _loadAll() async {
    setState(() {
      _statsLoading = true;
      _postsLoading = true;
      _posts.clear();
      _allPosts.clear();
      _hasMore = true;
    });

    // Rank parallel mein
    ProfileController.getProfileStatsWithRank();

    // Analytics — ek hi call mein summary + posts dono
    final model = await PostController.getPostAnalytics(type: 'latest');

    if (!mounted) return;

    if (model != null && model.success && model.data != null) {
      _summary  = model.data!.summary;
      _allPosts = model.data!.posts;

      // Pehla page slice karo
      final firstPage = _allPosts.take(_pageSize).toList();

      setState(() {
        _summary      = model.data!.summary;
        _posts.addAll(firstPage);
        _hasMore      = _allPosts.length > _pageSize;
        _statsLoading = false;
        _postsLoading = false;
      });
    } else {
      // Error snackbar PostController ne already dikha diya
      setState(() {
        _statsLoading = false;
        _postsLoading = false;
        _hasMore      = false;
      });
    }
  }

  // ── Infinite scroll ──
  void _onScroll() {
    final pos = _scrollController.position;
    if (pos.pixels >= pos.maxScrollExtent - 250) {
      if (!_loadingMore && _hasMore) _loadNextPage();
    }
  }

  // ── Next page (client-side slice) ──
  Future<void> _loadNextPage() async {
    setState(() => _loadingMore = true);
    await Future.delayed(const Duration(milliseconds: 300)); // smooth UX

    final nextSlice =
    _allPosts.skip(_posts.length).take(_pageSize).toList();

    if (!mounted) return;
    setState(() {
      _posts.addAll(nextSlice);
      _hasMore      = _posts.length < _allPosts.length;
      _loadingMore  = false;
    });
  }

  // ── Helpers ──
  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }

  ImageProvider _getAvatarProvider() {
    if (_auth.userAvatarLocalPath.value.isNotEmpty &&
        File(_auth.userAvatarLocalPath.value).existsSync()) {
      return FileImage(File(_auth.userAvatarLocalPath.value));
    }
    final net = _auth.userAvatar.value;
    if (net != null && net.isNotEmpty) {
      if (net.startsWith('http')) return NetworkImage(net);
      try {
        final clean =
        net.contains('base64,') ? net.split('base64,')[1] : net;
        return MemoryImage(base64Decode(clean.trim()));
      } catch (_) {}
    }
    return const AssetImage('assets/images/h0.png');
  }

  // ───────────────────────────────────────────
  //  BUILD
  // ───────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;
    final Color textColor    = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor  = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          color: Theme.of(context).primaryColor,
          onRefresh: _loadAll,
          child: SingleChildScrollView(
            controller: _scrollController,
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              children: [

                // ── Top Bar ──────────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: w * (20.625 / 375),
                    vertical:   h * (9.72 / 810),
                  ),
                  child: Row(
                    children: [
                      Image.asset(
                        'assets/images/logo.png',
                        height: h * (80.0 / 810),
                        width:  w * (120.0 / 375),
                        color: Theme.of(context).brightness == Brightness.light
                            ? Colors.black
                            : null,
                      ),
                      const Spacer(),
                      GestureDetector(
                        onTap: () => Get.to(
                          Settingscreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        ),
                        child: Theme.of(context).brightness == Brightness.dark
                            ? Image.asset(
                          'assets/images/icon.setting.png',
                          height: w * (48.0 / 375),
                          width:  w * (48.0 / 375),
                        )
                            : Container(
                          height: w * (45.0 / 375),
                          width:  w * (45.0 / 375),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor.withOpacity(0.15),
                            border: Border.all(
                              color: primaryColor.withOpacity(0.3),
                              width: w * (1.0 / 375),
                            ),
                          ),
                          child: Center(
                            child: Icon(Icons.settings,
                                color: textColor,
                                size: w * (22.0 / 375)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: h * (8.1 / 810)),

                // ── Avatar + Name + Bio ───────────────────────
                Obx(() => Column(
                  children: [
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: w * (55.0 / 375),
                          backgroundColor: primaryColor.withOpacity(0.5),
                          child: CircleAvatar(
                            radius: w * (52.0 / 375),
                            backgroundImage: _getAvatarProvider(),
                          ),
                        ),
                        Positioned(
                          bottom: h * (4.05 / 810),
                          right:  w * (5.0 / 375),
                          child: Image.asset(
                            'assets/images/check.png',
                            height: w * (30.0 / 375),
                            width:  w * (30.0 / 375),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: h * (12.15 / 810)),
                    Text(
                      _auth.userName.value,
                      style: GoogleFonts.inter(
                        color: textColor,
                        fontSize: w * (16.0 / 375),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: h * (6.48 / 810)),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: w * (30.0 / 375)),
                      child: Text(
                        _auth.userBio.value,
                        textAlign: TextAlign.center,
                        style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          color: textColor.withOpacity(0.6),
                          fontSize: w * (14.0 / 375),
                        ),
                      ),
                    ),
                  ],
                )),

                SizedBox(height: h * (20.25 / 810)),

                // ── Stats Row ─────────────────────────────────
                // Shimmer ya Real — PostAnalytics summary se
                _statsLoading
                    ? _StatsShimmer(w: w, h: h)
                    : Obx(() => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _StatItem(
                      val: _fmt(_summary.totalLikes),
                      label: "Likes",
                      textColor: textColor,
                      primaryColor: primaryColor,
                      w: w,
                    ),
                    _StatItem(
                      val: _fmt(_summary.totalComments),
                      label: "Comments",
                      textColor: textColor,
                      primaryColor: primaryColor,
                      w: w,
                    ),
                    _StatItem(
                      val: _fmt(_summary.totalShares),
                      label: "Shares",
                      textColor: textColor,
                      primaryColor: primaryColor,
                      w: w,
                    ),
                    _StatItem(
                      val: _auth.userRank.value > 0
                          ? _auth.userRank.value.toString()
                          : '—',
                      label: "Rank",
                      isRank: true,
                      textColor: textColor,
                      primaryColor: primaryColor,
                      w: w,
                    ),
                  ],
                )),

                SizedBox(height: h * (20.25 / 810)),

                // ── Support Cards ─────────────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * (10.0 / 375)),
                  child: SizedBox(
                    height: h * (73.0 / 810),
                    child: Obx(() => ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        _SupportCard(icon: Icons.restaurant,      title: "Food Support",   sub: "${_auth.foodSupport.value} vouchers",      cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
                        _SupportCard(icon: Icons.directions_bus,  title: "Free Transport", sub: "${_auth.transportSupport.value} days",       cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
                        _SupportCard(icon: Icons.card_giftcard,   title: "Cash Reward",    sub: "Rs ${_auth.cashReward.value}",               cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
                        _SupportCard(icon: Icons.school,          title: "Scholarship",    sub: "Yearly bonuses",                            cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
                        _SupportCard(icon: Icons.medical_services,title: "Medical",        sub: "emergency case",                            cardColor: cardBgColor, textColor: textColor, primaryColor: primaryColor, w: w, h: h),
                      ],
                    )),
                  ),
                ),

                SizedBox(height: h * (20.25 / 810)),

                // ── Post Analytics Header ─────────────────────
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: w * (20.0 / 375)),
                  child: Row(
                    children: [
                      Icon(Icons.add, color: primaryColor, size: w * (20.0 / 375)),
                      SizedBox(width: w * (10.0 / 375)),
                      Text(
                        "Post Analytics",
                        style: GoogleFonts.inter(
                          color: textColor,
                          fontSize: w * (18.0 / 375),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        "Latest",
                        style: GoogleFonts.inter(
                          color: textColor.withOpacity(0.6),
                          fontSize: w * (12.0 / 375),
                        ),
                      ),
                      SizedBox(width: w * (15.0 / 375)),
                      GestureDetector(
                        onTap: () => Get.to(
                          YourMemoriesScreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        ),
                        child: Text(
                          "Archived Posts",
                          style: GoogleFonts.inter(
                            color: primaryColor,
                            fontSize: w * (12.0 / 375),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: h * (16.2 / 810)),

                // ── Posts Grid ────────────────────────────────
                _buildPostsSection(w, h, textColor, primaryColor),

                // ── Pagination shimmer ────────────────────────
                if (_loadingMore)
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: h * (12.0 / 810)),
                    child: _PostsGridShimmer(w: w, h: h, count: 2),
                  ),

                SizedBox(height: h * (32.4 / 810)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Posts section
  // ─────────────────────────────────────────────
  Widget _buildPostsSection(
      double w, double h, Color textColor, Color primaryColor) {
    if (_postsLoading) {
      return _PostsGridShimmer(w: w, h: h, count: 6);
    }
    if (_posts.isEmpty) {
      return _EmptyPostsState(
          w: w, h: h, textColor: textColor, primaryColor: primaryColor);
    }
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: w * (20.0 / 375)),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: w * (12.0 / 375),
        mainAxisSpacing:  h * (12.0 / 810),
        childAspectRatio: 1.4,
      ),
      itemCount: _posts.length,
      itemBuilder: (_, i) {
        final post = _posts[i];
        return _PostItem(
          imageUrl: post.bestImageUrl,
          views:    post.viewsCount,
          likes:    post.likesCount,
          w: w,
          h: h,
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  Stats Shimmer
// ═══════════════════════════════════════════════════════════════
class _StatsShimmer extends StatelessWidget {
  final double w, h;
  const _StatsShimmer({required this.w, required this.h});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(4, (_) => Column(
        children: [
          _Shimmer(width: w * (40.0 / 375), height: h * (18.0 / 810), borderRadius: 6),
          SizedBox(height: h * (4.0 / 810)),
          _Shimmer(width: w * (55.0 / 375), height: h * (12.0 / 810), borderRadius: 4),
        ],
      )),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  Posts Grid Shimmer
// ═══════════════════════════════════════════════════════════════
class _PostsGridShimmer extends StatelessWidget {
  final double w, h;
  final int count;
  const _PostsGridShimmer({required this.w, required this.h, this.count = 6});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.symmetric(horizontal: w * (20.0 / 375)),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: w * (12.0 / 375),
        mainAxisSpacing:  h * (12.0 / 810),
        childAspectRatio: 1.4,
      ),
      itemCount: count,
      itemBuilder: (_, __) => _Shimmer(
        width: double.infinity,
        height: double.infinity,
        borderRadius: w * (15.0 / 375),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  Empty State
// ═══════════════════════════════════════════════════════════════
class _EmptyPostsState extends StatelessWidget {
  final double w, h;
  final Color textColor, primaryColor;
  const _EmptyPostsState({
    required this.w, required this.h,
    required this.textColor, required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: h * (40.0 / 810), horizontal: w * (40.0 / 375)),
      child: Column(
        children: [
          Icon(Icons.photo_library_outlined,
              size: w * (64.0 / 375),
              color: textColor.withOpacity(0.25)),
          SizedBox(height: h * (16.0 / 810)),
          Text(
            "No posts yet",
            style: GoogleFonts.inter(
              color: textColor.withOpacity(0.7),
              fontSize: w * (16.0 / 375),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: h * (8.0 / 810)),
          Text(
            "Share your first moment and let the world see your highlights.",
            textAlign: TextAlign.center,
            style: GoogleFonts.inter(
              color: textColor.withOpacity(0.4),
              fontSize: w * (13.0 / 375),
              fontWeight: FontWeight.w400,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  _StatItem
// ═══════════════════════════════════════════════════════════════
class _StatItem extends StatelessWidget {
  final String val, label;
  final bool isRank;
  final Color textColor, primaryColor;
  final double w;

  const _StatItem({
    required this.val, required this.label,
    required this.textColor, required this.primaryColor, required this.w,
    this.isRank = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(children: [
          Text(val, style: GoogleFonts.inter(
              fontWeight: FontWeight.w400, color: textColor,
              fontSize: w * (16.0 / 375))),
          if (isRank)
            Icon(Icons.bolt, color: primaryColor, size: w * (11.0 / 375)),
        ]),
        Text(label, style: GoogleFonts.inter(
            fontWeight: FontWeight.w400, color: AppColors.grey1,
            fontSize: w * (11.0 / 375))),
      ],
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  _SupportCard
// ═══════════════════════════════════════════════════════════════
class _SupportCard extends StatelessWidget {
  final IconData icon;
  final String title, sub;
  final Color cardColor, textColor, primaryColor;
  final double w, h;

  const _SupportCard({
    required this.icon, required this.title, required this.sub,
    required this.cardColor, required this.textColor,
    required this.primaryColor, required this.w, required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: h * (73.0 / 810),
      width:  w * (110.0 / 375),
      margin:  EdgeInsets.symmetric(horizontal: w * (5.0 / 375)),
      padding: EdgeInsets.all(w * (8.0 / 375)),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(w * (20.0 / 375)),
        image: const DecorationImage(
          image: AssetImage('assets/images/box.png'),
          fit: BoxFit.cover, opacity: 0.1,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primaryColor, size: w * (14.0 / 375)),
          SizedBox(height: h * (4.86 / 810)),
          Text(title, maxLines: 1, overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(color: textColor,
                  fontSize: w * (10.0 / 375), fontWeight: FontWeight.w400)),
          SizedBox(height: h * (1.62 / 810)),
          Text(sub, textAlign: TextAlign.center,
              style: GoogleFonts.inter(color: AppColors.grey,
                  fontSize: w * (6.0 / 375), fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  _PostItem — CachedNetworkImage + memory safe + lazy load
// ═══════════════════════════════════════════════════════════════
class _PostItem extends StatelessWidget {
  final String? imageUrl;
  final int views, likes;
  final double w, h;

  const _PostItem({
    required this.imageUrl, required this.views,
    required this.likes, required this.w, required this.h,
  });

  String _fmt(int n) {
    if (n >= 1000000) return '${(n / 1000000).toStringAsFixed(1)}M';
    if (n >= 1000)    return '${(n / 1000).toStringAsFixed(1)}k';
    return n.toString();
  }

  // Stats overlay — views + likes
  Widget _statsOverlay() {
    return Padding(
      padding: EdgeInsets.all(w * (10.0 / 375)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(children: [
            Icon(Icons.visibility, color: Colors.white, size: w * (12.0 / 375)),
            SizedBox(width: w * (4.0 / 375)),
            Text(_fmt(views),
                style: TextStyle(color: Colors.white, fontSize: w * (10.0 / 375))),
            SizedBox(width: w * (8.0 / 375)),
            Icon(Icons.favorite, color: Colors.white, size: w * (12.0 / 375)),
            SizedBox(width: w * (4.0 / 375)),
            Text(_fmt(likes),
                style: TextStyle(color: Colors.white, fontSize: w * (10.0 / 375))),
          ]),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isDark = Theme.of(context).brightness == Brightness.dark;
    final radius = BorderRadius.circular(w * (15.0 / 375));

    // Gradient overlay — hamesha bottom pe stats ke liye
    final gradientOverlay = Container(
      decoration: BoxDecoration(
        borderRadius: radius,
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end:   Alignment.bottomCenter,
          colors: [Colors.transparent, Colors.black.withOpacity(0.75)],
        ),
      ),
      child: _statsOverlay(),
    );

    // ── Koi image nahi ──
    if (imageUrl == null || imageUrl!.isEmpty) {
      return ClipRRect(
        borderRadius: radius,
        child: Container(
          color: isDark ? Colors.grey[850] : Colors.grey[200],
          child: Stack(fit: StackFit.expand, children: [
            Center(
              child: Icon(Icons.image_not_supported_outlined,
                  color: Colors.grey[500], size: w * (28.0 / 375)),
            ),
            gradientOverlay,
          ]),
        ),
      );
    }

    // ── CachedNetworkImage ──
    // memCacheWidth/Height → decode size limit → purane mobile ke liye crucial
    final cacheWidth  = (w * 0.5 * 1.5).toInt(); // grid cell ~50% width, 1.5x for clarity
    final cacheHeight = (cacheWidth / 1.4).toInt(); // childAspectRatio: 1.4

    return ClipRRect(
      borderRadius: radius,
      child: CachedNetworkImage(
        imageUrl: imageUrl!,
        // ✅ Yeh 2 lines memory crash rokti hain — decode size limit
        memCacheWidth:  cacheWidth,
        memCacheHeight: cacheHeight,
        // ✅ Disk cache: 7 din tak store, dobara download nahi hoga
        fadeInDuration: const Duration(milliseconds: 250),
        fit: BoxFit.cover,
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            image: DecorationImage(image: imageProvider, fit: BoxFit.cover),
          ),
          child: gradientOverlay,
        ),
        // ✅ Load hote waqt shimmer
        placeholder: (context, url) => _Shimmer(
          width: double.infinity,
          height: double.infinity,
          borderRadius: w * (15.0 / 375),
        ),
        // ✅ Error pe placeholder
        errorWidget: (context, url, error) => Container(
          color: isDark ? Colors.grey[850] : Colors.grey[200],
          child: Stack(fit: StackFit.expand, children: [
            Center(
              child: Icon(Icons.broken_image_outlined,
                  color: Colors.grey[500], size: w * (28.0 / 375)),
            ),
            gradientOverlay,
          ]),
        ),
      ),
    );
  }
}
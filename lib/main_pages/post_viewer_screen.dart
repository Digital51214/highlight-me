import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../widgets/video_post_player.dart';


// ═══════════════════════════════════════════════════════════════
//  PostViewerScreen
//  ─────────────────────────────────────────────────────────────
//  TikTok/Reels jaisa full-screen viewer — vertical PageView.
//  Home ya Profile se kisi post pe tap karo, yeh screen usi post
//  se khulti hai (initialIndex) aur upar-neeche swipe se agli/
//  pichli post dikhti hai. Jo video "current page" hai sirf wahi
//  chalti hai, baaki sab pause/dispose ho jati hain.
// ═══════════════════════════════════════════════════════════════
class PostViewerScreen extends StatefulWidget {
  final List<Map<String, dynamic>> posts;
  final int initialIndex;

  const PostViewerScreen({
    super.key,
    required this.posts,
    required this.initialIndex,
  });

  @override
  State<PostViewerScreen> createState() => _PostViewerScreenState();
}

class _PostViewerScreenState extends State<PostViewerScreen> {
  late final PageController _pageController;
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: widget.initialIndex);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  bool _isVideo(Map<String, dynamic> post) {
    final type = post['type']?.toString() ?? '';
    final url  = (post['file_url'] ?? post['display_url'] ?? '').toString();
    return type == 'video' || url.endsWith('.mp4') || url.endsWith('.mov');
  }

  @override
  Widget build(BuildContext context) {
    // ✅ naya — home_screen.dart jaisa hi responsive scaling (375 x 810 Figma base)
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            scrollDirection: Axis.vertical,
            itemCount: widget.posts.length,
            onPageChanged: (index) => setState(() => _currentIndex = index),
            itemBuilder: (context, index) {
              final post = widget.posts[index];
              final isVideo = _isVideo(post);
              final url = (post['file_url'] ?? post['display_url'] ?? '').toString();
              final caption = post['caption']?.toString() ?? '';
              final userName = post['user_name']?.toString() ?? '';

              return Stack(
                children: [Center(
                  child: Stack(
                    fit: StackFit.loose,
                    children: [
                      // ✅ Sirf current index wali video active hoti hai — baaki
                      // pages jab render honge, unki isActive false rahegi to
                      // wo apne aap pause rahengi (VideoPostPlayer khud handle
                      // karta hai)
                      isVideo
                          ? VideoPostPlayer(
                        videoUrl: url,
                        isActive: index == _currentIndex,
                      )
                          : CachedNetworkImage(
                        imageUrl: url,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => Container(color: Colors.grey.shade900),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey.shade900,
                          child: Icon(Icons.broken_image_outlined,
                              color: Colors.white38, size: w * (40.0 / 375)),
                        ),
                      ),

                      // ── Gradient overlay bottom ──
                      Positioned.fill(
                        child: IgnorePointer(
                          child: Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.6),
                                ],
                                stops: const [0.6, 1.0],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                  // ── Caption + user name bottom ──
                  Positioned(
                    left: w * (16.0 / 375),
                    right: w * (80.0 / 375),
                    bottom: h * (24.0 / 810),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (userName.isNotEmpty)
                          Text(
                            userName,
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: w * (15.0 / 375),
                            ),
                          ),
                        if (caption.isNotEmpty) ...[
                          SizedBox(height: h * (4.0 / 810)),
                          Text(
                            caption,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(color: Colors.white, fontSize: w * (13.0 / 375)),
                          ),
                        ],
                      ],
                    ),
                  ),
              ]
              );
            },
          ),

          // ── Back button ──
          Positioned(
            top: h * (30.0 / 810),
            left: w * (12.0 / 375),
            child: SafeArea(
              child: GestureDetector(
                onTap: () => Get.back(),
                child:Image.asset(
                'assets/images/icon.arrow.png',
                height: w * (48.0 / 375),
                width: w * (48.0 / 375),
              ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

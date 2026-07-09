import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:share_plus/share_plus.dart';
import 'package:video_player/video_player.dart';
import '../Contollers/chat_controller.dart';
import 'chat_screen2.dart';

// ═══════════════════════════════════════════════════════════════
//  StoryViewerScreen
// ═══════════════════════════════════════════════════════════════
class StoryViewerScreen extends StatefulWidget {
  final List<Map<String, dynamic>> groupedStories;
  final int initialUserIndex;

  const StoryViewerScreen({
    required this.groupedStories,
    required this.initialUserIndex,
    super.key,
  });

  @override
  State<StoryViewerScreen> createState() => _StoryViewerScreenState();
}

class _StoryViewerScreenState extends State<StoryViewerScreen> {
  late final PageController _userPageController;
  late int _currentUserIndex;

  @override
  void initState() {
    super.initState();
    _currentUserIndex = widget.initialUserIndex;
    _userPageController = PageController(initialPage: _currentUserIndex);
  }

  @override
  void dispose() {
    _userPageController.dispose();
    super.dispose();
  }

  void _goToNextUser() {
    if (_currentUserIndex < widget.groupedStories.length - 1) {
      _userPageController.nextPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    } else {
      Get.back();
    }
  }

  void _goToPreviousUser() {
    if (_currentUserIndex > 0) {
      _userPageController.previousPage(
          duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: _userPageController,
        itemCount: widget.groupedStories.length,
        onPageChanged: (i) => setState(() => _currentUserIndex = i),
        itemBuilder: (context, index) {
          final group = widget.groupedStories[index];
          return _UserStoryPage(
            key: ValueKey('user-story-$index'),
            userGroup: group,
            isCurrentPage: index == _currentUserIndex,
            onFinished: _goToNextUser,
            onPreviousUser: _goToPreviousUser,
          );
        },
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  _UserStoryPage — TickerProviderStateMixin ke saath fixed
// ═══════════════════════════════════════════════════════════════
class _UserStoryPage extends StatefulWidget {
  final Map<String, dynamic> userGroup;
  final bool isCurrentPage;
  final VoidCallback onFinished;
  final VoidCallback onPreviousUser;

  const _UserStoryPage({
    required this.userGroup,
    required this.isCurrentPage,
    required this.onFinished,
    required this.onPreviousUser,
    super.key,
  });

  @override
  State<_UserStoryPage> createState() => _UserStoryPageState();
}

// ✅ FIX: SingleTickerProviderStateMixin ko TickerProviderStateMixin se badal diya gaya hai
class _UserStoryPageState extends State<_UserStoryPage>
    with TickerProviderStateMixin {
  late final List<Map<String, dynamic>> _stories;
  int _currentIndex = 0;

  AnimationController? _progressController;
  VideoPlayerController? _videoController;

  bool _isSendingMessage = false;
  bool _liked = false;

  final TextEditingController _msgCtrl = TextEditingController();
  final FocusNode _msgFocusNode = FocusNode();

  late final ChatController _chatCtrl = Get.isRegistered<ChatController>()
      ? Get.find<ChatController>()
      : Get.put(ChatController());

  static const Duration _imageDuration = Duration(seconds: 5);

  @override
  void initState() {
    super.initState();
    _stories = List<Map<String, dynamic>>.from(widget.userGroup['stories'] ?? []);
    if (widget.isCurrentPage) _loadStory(_currentIndex);

    _msgFocusNode.addListener(() {
      if (!_msgFocusNode.hasFocus && !_isSendingMessage) {
        _resume();
      }
    });
  }

  @override
  void didUpdateWidget(covariant _UserStoryPage oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isCurrentPage && !oldWidget.isCurrentPage) {
      _loadStory(_currentIndex);
    } else if (!widget.isCurrentPage && oldWidget.isCurrentPage) {
      _pause();
    }
  }

  @override
  void dispose() {
    _progressController?.dispose();
    _videoController?.dispose();
    _msgCtrl.dispose();
    _msgFocusNode.dispose();
    super.dispose();
  }

  int _asInt(dynamic v) {
    if (v == null) return 0;
    if (v is int) return v;
    if (v is double) return v.toInt();
    return int.tryParse(v.toString()) ?? 0;
  }

  void _pause() {
    _progressController?.stop();
    _videoController?.pause();
  }

  void _resume() {
    _progressController?.forward();
    _videoController?.play();
  }

  Future<void> _loadStory(int index) async {
    _progressController?.dispose();
    _progressController = null;
    await _videoController?.dispose();
    _videoController = null;

    if (index < 0 || index >= _stories.length) return;
    final story = _stories[index];
    final type = story['type']?.toString() ?? 'image';
    final url = story['media_url']?.toString() ?? '';

    if (type == 'video' && url.isNotEmpty) {
      final controller = VideoPlayerController.networkUrl(Uri.parse(url));
      _videoController = controller;
      try {
        await controller.initialize();
        if (!mounted) return;
        final duration = controller.value.duration.inMilliseconds > 0
            ? controller.value.duration
            : _imageDuration;
        _progressController = AnimationController(vsync: this, duration: duration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) _goNext();
          });
        controller.play();
        _progressController!.forward();
        setState(() {});
      } catch (_) {
        _goNext();
      }
    } else {
      _progressController = AnimationController(vsync: this, duration: _imageDuration)
        ..addStatusListener((status) {
          if (status == AnimationStatus.completed) _goNext();
        });
      _progressController!.forward();
      setState(() {});
    }
  }

  void _goNext() {
    if (!mounted) return;
    if (_currentIndex < _stories.length - 1) {
      setState(() => _currentIndex++);
      _loadStory(_currentIndex);
    } else {
      widget.onFinished();
    }
  }

  void _goPrevious() {
    if (_currentIndex > 0) {
      setState(() => _currentIndex--);
      _loadStory(_currentIndex);
    } else {
      widget.onPreviousUser();
    }
  }

  String _formatTime(String? raw) {
    if (raw == null || raw.isEmpty) return '';
    DateTime dt;
    try {
      String normalized = raw.contains('T') ? raw : raw.replaceFirst(' ', 'T');
      if (!normalized.endsWith('Z') && !normalized.contains('+')) {
        normalized = '${normalized}Z';
      }
      dt = DateTime.parse(normalized).toLocal();
    } catch (_) {
      return '';
    }
    final diff = DateTime.now().difference(dt);
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  Future<void> _handleSendMessage() async {
    final text = _msgCtrl.text.trim();
    if (text.isEmpty || _isSendingMessage) return;

    final posterId = _asInt(widget.userGroup['user_id']);
    setState(() => _isSendingMessage = true);
    _pause();

    final conversation = await _chatCtrl.createConversation(otherUserId: posterId);

    if (!mounted) return;

    if (conversation != null) {
      final convId = _asInt(conversation['id']);
      final sent = await _chatCtrl.sendMessage(conversationId: convId, message: text);

      if (!mounted) return;

      if (sent) {
        _msgCtrl.clear();
        setState(() => _isSendingMessage = false);

        final posterName = widget.userGroup['user_name']?.toString() ?? 'User';
        final posterAvatar = widget.userGroup['user_avatar_url']?.toString() ?? '';

        Get.to(() => ChatDetailScreen(
          conversationId: convId,
          userName: posterName,
          userImg: posterAvatar.isNotEmpty ? posterAvatar : null,
          currentUserImg: _chatCtrl.currentUserImg.value,
          otherUserId: posterId,
        ));
      } else {
        setState(() => _isSendingMessage = false);
        _resume();
      }
    } else {
      setState(() => _isSendingMessage = false);
      _resume();
    }
  }

  Future<void> _handleShare() async {
    if (_currentIndex >= _stories.length) return;
    final url = _stories[_currentIndex]['media_url']?.toString() ?? '';
    _pause();
    await Share.share(url);
    _resume();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    final topSafe = MediaQuery.of(context).padding.top;
    final bottomSafe = MediaQuery.of(context).padding.bottom;

    if (_stories.isEmpty) {
      return Center(
        child: Text('No stories',
            style: TextStyle(color: Colors.white70, fontSize: w * (14.0 / 375))),
      );
    }

    final story = _stories[_currentIndex];
    final type = story['type']?.toString() ?? 'image';
    final mediaUrl = story['media_url']?.toString() ?? '';
    final userName = widget.userGroup['user_name']?.toString() ?? 'User';
    final avatarUrl = widget.userGroup['user_avatar_url']?.toString() ?? '';
    final timeText = _formatTime(story['created_at']?.toString());

    return GestureDetector(
      onTapDown: (details) {
        final tapX = details.globalPosition.dx;
        if (tapX < w * 0.3) {
          _goPrevious();
        } else {
          _goNext();
        }
      },
      onLongPressStart: (_) => _pause(),
      onLongPressEnd: (_) => _resume(),
      onVerticalDragEnd: (details) {
        if ((details.primaryVelocity ?? 0) > 250) Get.back();
      },
      child: Stack(fit: StackFit.expand, children: [
        // Media Container
        Container(
          color: Colors.black,
          child: Center(
            child: type == 'video' &&
                _videoController != null &&
                _videoController!.value.isInitialized
                ? AspectRatio(
              aspectRatio: _videoController!.value.aspectRatio,
              child: VideoPlayer(_videoController!),
            )
                : type == 'video'
                ? CircularProgressIndicator(
                color: Colors.white54, strokeWidth: w * (2.0 / 375))
                : CachedNetworkImage(
              imageUrl: mediaUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              placeholder: (_, __) => Center(
                  child: CircularProgressIndicator(
                      color: Colors.white54, strokeWidth: w * (2.0 / 375))),
              errorWidget: (_, __, ___) => Icon(Icons.broken_image,
                  color: Colors.white54, size: w * (48.0 / 375)),
            ),
          ),
        ),

        // Gradient
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            height: h * 0.22,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.65), Colors.transparent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
        ),

        // Progress bars
        Positioned(
          top: topSafe + h * (12.0 / 810),
          left: w * (12.0 / 375),
          right: w * (12.0 / 375),
          child: Row(
            children: List.generate(_stories.length, (i) {
              return Expanded(
                child: Container(
                  height: h * (3.0 / 810),
                  margin: EdgeInsets.symmetric(horizontal: w * (2.0 / 375)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(w * (4.0 / 375)),
                  ),
                  child: i < _currentIndex
                      ? const DecoratedBox(decoration: BoxDecoration(color: Colors.white))
                      : i == _currentIndex
                      ? AnimatedBuilder(
                    animation: _progressController ?? const AlwaysStoppedAnimation(0),
                    builder: (context, _) => FractionallySizedBox(
                      alignment: Alignment.centerLeft,
                      widthFactor: _progressController?.value ?? 0,
                      child: Container(color: Colors.white),
                    ),
                  )
                      : const SizedBox.shrink(),
                ),
              );
            }),
          ),
        ),

        // Header
        Positioned(
          top: topSafe + h * (28.0 / 810),
          left: w * (14.0 / 375),
          right: w * (14.0 / 375),
          child: Row(children: [
            CircleAvatar(
              radius: w * (17.0 / 375),
              backgroundColor: Colors.grey.shade800,
              backgroundImage: avatarUrl.startsWith('http')
                  ? CachedNetworkImageProvider(avatarUrl)
                  : const AssetImage('assets/images/author.png') as ImageProvider,
            ),
            SizedBox(width: w * (10.0 / 375)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(userName,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w700,
                          fontSize: w * (13.5 / 375))),
                  if (timeText.isNotEmpty) ...[
                    SizedBox(height: h * (2.0 / 810)),
                    Text(timeText,
                        style: TextStyle(
                            color: Colors.white70, fontSize: w * (11.0 / 375))),
                  ],
                ],
              ),
            ),
            SizedBox(width: w * (8.0 / 375)),
            GestureDetector(
              onTap: () => Get.back(),
              child: Container(
                padding: EdgeInsets.all(w * (6.0 / 375)),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.3),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: w * (20.0 / 375)),
              ),
            ),
          ]),
        ),

        // Bottom Field
        Positioned(
          bottom: bottomSafe + h * (18.0 / 810),
          left: w * (14.0 / 375),
          right: w * (14.0 / 375),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: h * (46.0 / 810),
                  padding: EdgeInsets.symmetric(horizontal: w * (16.0 / 375)),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(w * (30.0 / 375)),
                    border: Border.all(color: Colors.white38),
                  ),
                  child: Center(
                    child: TextField(
                      controller: _msgCtrl,
                      focusNode: _msgFocusNode,
                      style: TextStyle(color: Colors.white, fontSize: w * (13.0 / 375)),
                      onTap: _pause,
                      onSubmitted: (_) => _handleSendMessage(),
                      decoration: InputDecoration(
                        hintText: 'Send a message...',
                        hintStyle: TextStyle(
                            color: Colors.white60, fontSize: w * (13.0 / 375)),
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: h * (12.0 / 810)),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: w * (10.0 / 375)),
              GestureDetector(
                onTap: () => setState(() => _liked = !_liked),
                child: Icon(_liked ? Icons.favorite : Icons.favorite_border,
                    color: _liked ? Colors.red : Colors.white, size: w * (26.0 / 375)),
              ),
              SizedBox(width: w * (12.0 / 375)),
              GestureDetector(
                onTap: _handleShare,
                child: Icon(Icons.share, color: Colors.white, size: w * (24.0 / 375)),
              ),
              SizedBox(width: w * (12.0 / 375)),
              GestureDetector(
                onTap: _handleSendMessage,
                child: _isSendingMessage
                    ? SizedBox(
                  width: w * (22.0 / 375),
                  height: w * (22.0 / 375),
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
                    : Icon(Icons.send, color: Colors.white, size: w * (24.0 / 375)),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
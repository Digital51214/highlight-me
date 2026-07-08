import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

// ═══════════════════════════════════════════════════════════════
//  VideoPostPlayer
//  ─────────────────────────────────────────────────────────────
//  Reusable video widget — feed (Home) aur full-screen viewer
//  dono jagah yehi use hota hai. Parent widget "isActive" bata kar
//  control karta hai ke video chale ya ruke (parent ko khud fikar
//  nahi karni ke video kaise play/pause hoti hai, bas isActive
//  true/false pass karna hai).
// ═══════════════════════════════════════════════════════════════
class VideoPostPlayer extends StatefulWidget {
  final String videoUrl;
  final bool isActive;   // true = yeh video abhi visible/current hai
  final bool showMuteButton;

  const VideoPostPlayer({
    super.key,
    required this.videoUrl,
    required this.isActive,
    this.showMuteButton = true,
  });

  @override
  State<VideoPostPlayer> createState() => _VideoPostPlayerState();
}

class _VideoPostPlayerState extends State<VideoPostPlayer> {
  VideoPlayerController? _controller;
  bool _initialized = false;
  bool _hasError = false;
  bool _muted = false;

  @override
  void initState() {
    super.initState();
    _initVideo();
  }

  Future<void> _initVideo() async {
    try {
      final controller = VideoPlayerController.networkUrl(
        Uri.parse(widget.videoUrl),
      );
      _controller = controller;
      await controller.initialize();
      controller.setLooping(true); // ✅ TikTok jaisa — khatam hote hi dobara chale
      if (!mounted) return;
      setState(() => _initialized = true);
      if (widget.isActive) controller.play();
    } catch (e) {
      if (mounted) setState(() => _hasError = true);
    }
  }

  // ✅ Yeh sabse zaroori hissa hai — jab parent se isActive badle
  // (matlab yeh video visible ho gayi ya visible nahi rahi),
  // yahan play/pause fire hota hai. Naya controller nahi banta,
  // isi controller ko play/pause kiya jata hai — fast aur smooth.
  @override
  void didUpdateWidget(covariant VideoPostPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_initialized || _controller == null) return;
    if (widget.isActive && !_controller!.value.isPlaying) {
      _controller!.play();
    } else if (!widget.isActive && _controller!.value.isPlaying) {
      _controller!.pause();
    }
  }

  @override
  void dispose() {
    // ✅ Memory ke liye zaroori — is widget ke hatate hi controller
    // fori taur pe dispose ho, warna purane videos memory mein
    // atke rehte hain aur app slow/crash ho sakti hai
    _controller?.dispose();
    super.dispose();
  }

  void _toggleMute() {
    if (_controller == null) return;
    setState(() {
      _muted = !_muted;
      _controller!.setVolume(_muted ? 0 : 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // ✅ naya — home_screen.dart jaisa hi responsive scaling pattern
    // (375 x 810 Figma base size ke hisaab se scale hota hai)
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    if (_hasError) {
      return Container(
        color: Colors.black,
        child: Center(
          child: Icon(Icons.error_outline,
              color: Colors.white54, size: w * (40.0 / 375)),
        ),
      );
    }

    if (!_initialized || _controller == null) {
      // Video buffer hote waqt kaala background (thumbnail bhi laga sakte ho)
      return Container(
        color: Colors.black,
        child: Center(
          child: SizedBox(
            width: w * (28.0 / 375),
            height: w * (28.0 / 375),
            child: const CircularProgressIndicator(strokeWidth: 2, color: Colors.white54),
          ),
        ),
      );
    }

    return GestureDetector(
      onTap: _toggleMute,
      child: Stack(
        fit: StackFit.expand,
        children: [
          // ✅ BoxFit.cover jaisa effect video ke liye — poori screen fill karta hai
          ClipRect(
            child: OverflowBox(
              maxWidth: double.infinity,
              maxHeight: double.infinity,
              child: FittedBox(
                fit: BoxFit.cover,
                child: SizedBox(
                  width: _controller!.value.size.width,
                  height: _controller!.value.size.height,
                  child: VideoPlayer(_controller!),
                ),
              ),
            ),
          ),
          if (widget.showMuteButton)
            Positioned(
              top: h * (20.0 / 810),
              right: w * (16.0 / 375),
              child: Container(
                padding: EdgeInsets.all(w * (6.0 / 375)),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.4),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  _muted ? Icons.volume_off : Icons.volume_up,
                  color: Colors.white,
                  size: w * (25.0 / 375),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
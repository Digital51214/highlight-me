import 'dart:io';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../Contollers/story_controller.dart';

// ═══════════════════════════════════════════════════════════════
//  CreateStoryScreen
//  ─────────────────────────────────────────────────────────────
//  Home screen ke stories row mein "+" avatar pe tap karne se yeh
//  khulti hai. Front camera default, camera-switch button, tap se
//  photo, long-press se video record, gallery se bhi pick kar sakte
//  ho. Capture ke baad preview + confirm (✓) button se story post
//  hoti hai.
// ═══════════════════════════════════════════════════════════════
class CreateStoryScreen extends StatefulWidget {
  const CreateStoryScreen({super.key});

  @override
  State<CreateStoryScreen> createState() => _CreateStoryScreenState();
}

class _CreateStoryScreenState extends State<CreateStoryScreen>
    with WidgetsBindingObserver {
  CameraController? _cameraController;
  List<CameraDescription> _cameras = [];
  int _selectedCameraIndex = 0;
  bool _isCameraInitialized = false;
  bool _isRecordingVideo = false;
  bool _isFlashOn = false;

  // ── Captured media ──
  File? _capturedFile;
  String? _capturedType; // "image" | "video"
  VideoPlayerController? _previewVideoController;

  final StoryController storyCtrl = Get.isRegistered<StoryController>()
      ? Get.find<StoryController>()
      : Get.put(StoryController());
  final ImagePicker _imagePicker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initCamera();
  }

  Future<void> _initCamera() async {
    try {
      _cameras = await availableCameras();
      if (_cameras.isEmpty) {
        Get.snackbar('Error', 'No camera found on this device.',
            snackPosition: SnackPosition.BOTTOM);
        return;
      }
      // ✅ front camera dhundo — TikTok/Instagram jaisa default
      final frontIndex = _cameras.indexWhere(
              (c) => c.lensDirection == CameraLensDirection.front);
      _selectedCameraIndex = frontIndex != -1 ? frontIndex : 0;
      await _startCamera(_selectedCameraIndex);
    } catch (e) {
      Get.snackbar('Error', 'Could not open camera. Please check permissions.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _startCamera(int index) async {
    final controller = CameraController(
      _cameras[index],
      ResolutionPreset.high,
      enableAudio: true,
    );
    _cameraController = controller;
    try {
      await controller.initialize();
      if (!mounted) return;
      setState(() => _isCameraInitialized = true);
    } catch (e) {
      Get.snackbar('Error', 'Could not start camera.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras.length < 2 || _isRecordingVideo) return;
    setState(() => _isCameraInitialized = false);
    await _cameraController?.dispose();
    _selectedCameraIndex = (_selectedCameraIndex + 1) % _cameras.length;
    await _startCamera(_selectedCameraIndex);
  }

  Future<void> _toggleFlash() async {
    if (_cameraController == null || !_isCameraInitialized) return;
    try {
      _isFlashOn = !_isFlashOn;
      await _cameraController!.setFlashMode(_isFlashOn ? FlashMode.torch : FlashMode.off);
      setState(() {});
    } catch (_) {
      // ✅ front camera pe flash na ho to chup chaap ignore karo
    }
  }

  Future<void> _takePicture() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    if (_isRecordingVideo) return; // recording ke dauran photo na le
    try {
      final XFile file = await _cameraController!.takePicture();
      setState(() {
        _capturedFile = File(file.path);
        _capturedType = 'image';
      });
    } catch (e) {
      Get.snackbar('Error', 'Could not capture photo.', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _startVideoRecording() async {
    if (_cameraController == null || !_cameraController!.value.isInitialized) return;
    if (_isRecordingVideo) return;
    try {
      await _cameraController!.startVideoRecording();
      if (mounted) setState(() => _isRecordingVideo = true);
    } catch (e) {
      Get.snackbar('Error', 'Could not start video recording.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _stopVideoRecording() async {
    if (_cameraController == null || !_isRecordingVideo) return;
    try {
      final XFile file = await _cameraController!.stopVideoRecording();
      if (!mounted) return;
      setState(() {
        _isRecordingVideo = false;
        _capturedFile = File(file.path);
        _capturedType = 'video';
      });
      await _initPreviewVideo();
    } catch (e) {
      if (mounted) setState(() => _isRecordingVideo = false);
      Get.snackbar('Error', 'Could not save video.', snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> _initPreviewVideo() async {
    if (_capturedFile == null) return;
    final controller = VideoPlayerController.file(_capturedFile!);
    _previewVideoController = controller;
    await controller.initialize();
    controller.setLooping(true);
    controller.play();
    if (mounted) setState(() {});
  }

  Future<void> _pickFromGallery() async {
    try {
      // ✅ image_picker 1.x — photo ya video dono choose karne deta hai
      final XFile? picked = await _imagePicker.pickMedia();
      if (picked == null) return;
      final lower = picked.path.toLowerCase();
      final isVideo = lower.endsWith('.mp4') || lower.endsWith('.mov') || lower.endsWith('.m4v');
      setState(() {
        _capturedFile = File(picked.path);
        _capturedType = isVideo ? 'video' : 'image';
      });
      if (isVideo) await _initPreviewVideo();
    } catch (e) {
      Get.snackbar('Error', 'Could not select file from gallery.',
          snackPosition: SnackPosition.BOTTOM);
    }
  }

  void _discardCapture() {
    _previewVideoController?.dispose();
    _previewVideoController = null;
    setState(() {
      _capturedFile = null;
      _capturedType = null;
    });
  }

  Future<void> _confirmAndPost() async {
    if (_capturedFile == null || _capturedType == null) return;
    final success = await storyCtrl.addStory(file: _capturedFile!, type: _capturedType!);
    if (success && mounted) {
      // ✅ Home screen ko batao ke story post ho gayi (refresh trigger karne ke liye)
      Get.back(result: true);
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _cameraController?.dispose();
    _previewVideoController?.dispose();
    super.dispose();
  }

  // ✅ App background/foreground hone par camera sahi se pause/resume ho —
  // warna background jaane pe camera resource leak/crash ho sakta hai
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final controller = _cameraController;
    if (controller == null || !controller.value.isInitialized) return;
    if (state == AppLifecycleState.inactive) {
      controller.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _startCamera(_selectedCameraIndex);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    final double h = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // 👈 home_screen jaisa theme color
      body: SafeArea(
        child: _capturedFile != null
            ? _buildPreview(context, w, h)
            : _buildCameraView(context, w, h),
      ),
    );
  }

  // ─────────────────────────────────────────────
  //  Camera view (Instagram/Snapchat jaisa)
  // ─────────────────────────────────────────────
  Widget _buildCameraView(BuildContext context, double w, double h) {
    return Stack(
      fit: StackFit.expand,
      children: [
        // ── Camera preview ──
        if (_isCameraInitialized && _cameraController != null)
          Center(
            child: CameraPreview(_cameraController!),
          )
        else
          Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)),

        // ── Top: close button ──
        Positioned(
          top: h * (10.0 / 810),
          left: w * (12.0 / 375),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: Container(
              padding: EdgeInsets.all(w * (8.0 / 375)),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.85), shape: BoxShape.circle),
              child: Icon(Icons.close, color: Colors.white, size: w * (20.0 / 375)),
            ),
          ),
        ),

        // ── Top: title ──
        Positioned(
          top: h * (14.0 / 810),
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              'Create Story',
              style: TextStyle(
                color: Colors.white,
                fontSize: w * (15.0 / 375),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        // ── Right side icons ──
        Positioned(
          top: h * (70.0 / 810),
          right: w * (14.0 / 375),
          child: Column(
            children: [
              _sideIcon(
                icon: _isFlashOn ? Icons.flash_on : Icons.flash_off,
                onTap: _toggleFlash,
                w: w,
              ),
              SizedBox(height: h * (20.0 / 810)),
              _sideIcon(icon: Icons.music_note_outlined, onTap: () {}, w: w),
              SizedBox(height: h * (20.0 / 810)),
              _sideIcon(icon: Icons.timer_outlined, onTap: () {}, w: w),
              SizedBox(height: h * (20.0 / 810)),
              _sideIcon(icon: Icons.grid_view_outlined, onTap: () {}, w: w),
              SizedBox(height: h * (20.0 / 810)),
              _sideIcon(icon: Icons.auto_fix_high_outlined, onTap: () {}, w: w),
            ],
          ),
        ),

        // ── Bottom controls ──
        Positioned(
          bottom: h * (55.0 / 810),
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // ✅ Gallery pick (screenshot ke bottom-left rounded icon jaisa)
              GestureDetector(
                onTap: _pickFromGallery,
                child: Container(
                  width: w * (45.0 / 375),
                  height: w * (45.0 / 375),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 2),
                    color: Theme.of(context).cardColor,
                  ),
                  child: Icon(Icons.photo_library_outlined,
                      color: Colors.white, size: w * (20.0 / 375)),
                ),
              ),

              // ✅ Capture button — tap = photo, hold = video
              GestureDetector(
                onTap: _takePicture,
                onLongPressStart: (_) => _startVideoRecording(),
                onLongPressEnd: (_) => _stopVideoRecording(),
                child: Container(
                  width: w * (75.0 / 375),
                  height: w * (75.0 / 375),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 4),
                    color: _isRecordingVideo
                        ? Colors.red.withOpacity(0.55)
                        : Theme.of(context).primaryColor.withOpacity(0.3),
                  ),
                ),
              ),

              // ✅ Camera switch (front/back)
              GestureDetector(
                onTap: _switchCamera,
                child: Container(
                  width: w * (45.0 / 375),
                  height: w * (45.0 / 375),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Theme.of(context).cardColor.withOpacity(0.85),
                  ),
                  child: Icon(Icons.cameraswitch_outlined,
                      color: Colors.white, size: w * (22.0 / 375)),
                ),
              ),
            ],
          ),
        ),

        // ── Hint text ──
        Positioned(
          bottom: h * (18.0 / 810),
          left: 0,
          right: 0,
          child: Center(
            child: Text(
              _isRecordingVideo ? 'RECORDING...' : 'TAP FOR PHOTO, HOLD FOR VIDEO',
              style: TextStyle(
                color: _isRecordingVideo ? Colors.redAccent : Colors.white54,
                fontSize: w * (10.0 / 375),
                letterSpacing: 1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _sideIcon({required IconData icon, required VoidCallback onTap, required double w}) {
    return GestureDetector(
      onTap: onTap,
      child: Icon(icon, color: Colors.white, size: w * (22.0 / 375)),
    );
  }

  // ─────────────────────────────────────────────
  //  Preview (capture hone ke baad) + confirm/discard
  // ─────────────────────────────────────────────
  Widget _buildPreview(BuildContext context, double w, double h) {
    return Stack(
      fit: StackFit.expand,
      children: [
        _capturedType == 'video'
            ? (_previewVideoController != null && _previewVideoController!.value.isInitialized
            ? FittedBox(
          fit: BoxFit.cover,
          child: SizedBox(
            width: _previewVideoController!.value.size.width,
            height: _previewVideoController!.value.size.height,
            child: VideoPlayer(_previewVideoController!),
          ),
        )
            : Center(child: CircularProgressIndicator(color: Theme.of(context).primaryColor)))
            : Image.file(_capturedFile!, fit: BoxFit.cover),

        // ── Discard (X) ──
        Positioned(
          top: h * (10.0 / 810),
          left: w * (12.0 / 375),
          child: GestureDetector(
            onTap: _discardCapture,
            child: Container(
              padding: EdgeInsets.all(w * (8.0 / 375)),
              decoration: BoxDecoration(
                  color: Theme.of(context).cardColor.withOpacity(0.85), shape: BoxShape.circle),
              child: Icon(Icons.close, color: Colors.white, size: w * (20.0 / 375)),
            ),
          ),
        ),

        // ── Confirm (✓) — story post karo ──
        Positioned(
          bottom: h * (30.0 / 810),
          right: w * (20.0 / 375),
          child: Obx(() => GestureDetector(
            onTap: storyCtrl.isPosting.value ? null : _confirmAndPost,
            child: Container(
              width: w * (60.0 / 375),
              height: w * (60.0 / 375),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).primaryColor,
              ),
              child: Center(
                child: storyCtrl.isPosting.value
                    ? SizedBox(
                  width: w * (24.0 / 375),
                  height: w * (24.0 / 375),
                  child: const CircularProgressIndicator(
                      strokeWidth: 2, color: Colors.white),
                )
                    : Icon(Icons.check, color: Colors.white, size: w * (28.0 / 375)),
              ),
            ),
          )),
        ),
      ],
    );
  }
}
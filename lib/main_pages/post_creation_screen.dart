//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/extension_navigation.dart';
// import 'package:highlights/main_pages/post_lock_screen.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
// import 'package:highlights/basic_files/basic_fontstyles.dart';
// import 'package:highlights/basic_files/basic_images.dart';
//
// class PostCreationScreen extends StatefulWidget {
//   const PostCreationScreen({super.key});
//
//   @override
//   State<PostCreationScreen> createState() => _PostCreationScreenState();
// }
//
// class _PostCreationScreenState extends State<PostCreationScreen> {
//   File? selectedImage;
//   final ImagePicker picker = ImagePicker();
//
//   Future<void> pickImage() async {
//     final XFile? image = await picker.pickImage(source: ImageSource.gallery);
//
//     if (image != null) {
//       setState(() {
//         selectedImage = File(image.path);
//       });
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     // Dynamic theme colors
//     final Color surfaceColor = Theme.of(context).canvasColor.withOpacity(0.05);
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color textColor = Theme.of(context).canvasColor;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Changed
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: w * 0.055,
//             vertical: h * 0.012,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               Image.asset(
//                 AppImages.logo,
//                 height: 80,
//                 width: 120,
//                 color: Theme.of(context).brightness == Brightness.light ? Colors.black : null, // Logo color adjustment
//               ),
//
//               const SizedBox(height: 20),
//
//               /// Info Card
//               GestureDetector(
//                 onTap: (){
//                   Get.to(PostingWindowScreen());
//                 },
//                 child: Container(
//                   height: 87,
//                   width: 335,
//                   padding: const EdgeInsets.symmetric(horizontal: 15),
//                   decoration: BoxDecoration(
//                     color: surfaceColor, // Dynamic surface
//                     borderRadius: BorderRadius.circular(25),
//                   ),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     crossAxisAlignment: CrossAxisAlignment.center,
//                     children: [
//                       Row(
//                         children: [
//                           Icon(
//                             Icons.circle,
//                             color: primaryColor, // Dynamic primary
//                             size: 12,
//                           ),
//                           const SizedBox(width: 10),
//                           Column(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Text(
//                                 "WINDOW IS LOCK",
//                                 style: MainTextStyles.inter(
//                                   color: primaryColor, // Dynamic primary
//                                   fontSize: 12,
//                                   fontWeight: FontWeight.w600,
//                                 ),
//                               ),
//                               Text(
//                                 "Section your moments with me",
//                                 style: MainTextStyles.inter(
//                                   color: AppColors.grey1,
//                                   fontWeight: FontWeight.w400,
//                                   fontSize: 8,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                       Text(
//                         "04:22",
//                         style: MainTextStyles.inter(
//                           color: primaryColor, // Dynamic primary
//                           fontSize: 16,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               /// PHOTO CARD
//               GestureDetector(
//                 onTap: pickImage,
//                 child: _buildSelectionCard(
//                   context,
//                   imageFile: selectedImage,
//                   imagePath: 'assets/images/p1.png',
//                   label: "Select Photo",
//                   icon: Icons.add_a_photo_outlined,
//                 ),
//               ),
//
//               const SizedBox(height: 15),
//
//               GestureDetector(
//                 onTap: pickImage, // Placeholder for video picking
//                 child: _buildSelectionCard(
//                   context,
//                   imageFile: null,
//                   imagePath: 'assets/images/p2.png',
//                   label: "Select Video",
//                   icon: Icons.videocam_outlined,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               /// TEXT FIELD / STORY BOX
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: surfaceColor, // Dynamic surface
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Column(
//                   children: [
//                     TextField(
//                       maxLines: 2,
//                       style: TextStyle(color: textColor), // Dynamic text color
//                       decoration: InputDecoration(
//                         hintText: "What's the story behind this moment.....",
//                         hintStyle: GoogleFonts.inter(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//                     const SizedBox(height: 10),
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.emoji_emotions_outlined,
//                           color: Color(0xFF767575),
//                         ),
//                         const Spacer(),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 12,
//                             vertical: 6,
//                           ),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: Colors.grey),
//                             borderRadius: BorderRadius.circular(15),
//                           ),
//                           child: Text(
//                             "Add Tags",
//                             style: GoogleFonts.inter(
//                               color: const Color(0xFFADAAAA),
//                               fontSize: 11,
//                               fontWeight: FontWeight.w700,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               /// POST BUTTON
//               Container(
//                 width: double.infinity,
//                 height: 55,
//                 decoration: BoxDecoration(
//                   color: primaryColor, // Dynamic primary
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Post Moment",
//                       style: GoogleFonts.inter(
//                         color: Colors.white, // Always white on primary
//                         fontWeight: FontWeight.w700,
//                         fontSize: 13,
//                       ),
//                     ),
//                     const SizedBox(width: 10),
//                     const Icon(Icons.share, color: Colors.white, size: 18),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 40),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildSelectionCard(
//       BuildContext context, {
//         required String imagePath,
//         required String label,
//         required IconData icon,
//         File? imageFile,
//       }) {
//     return Container(
//       height: 300,
//       width: double.infinity,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(40),
//         image: DecorationImage(
//           image: imageFile != null
//               ? FileImage(imageFile)
//               : AssetImage(imagePath) as ImageProvider,
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(
//             Colors.black.withOpacity(0.4),
//             BlendMode.darken,
//           ),
//         ),
//       ),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             padding: const EdgeInsets.all(10),
//             decoration: const BoxDecoration(
//               shape: BoxShape.circle,
//               color: Colors.black26,
//             ),
//             child: Icon(
//                 icon,
//                 color: Theme.of(context).primaryColor, // Dynamic primary
//                 size: 30
//             ),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             label,
//             style: GoogleFonts.inter(
//               color: Colors.white, // Keep white for overlay visibility
//               fontWeight: FontWeight.w700,
//               fontSize: 16,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/bottom_bar.dart';
import 'package:highlights/main_pages/post_lock_screen.dart';
import 'package:highlights/widgets/custom_loader.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/basic_images.dart';

import '../Contollers/post_controller.dart';
import 'home_screen.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  File? selectedImage;
  File? selectedVideo;
  final TextEditingController _captionController = TextEditingController();
  final TextEditingController _tagsController = TextEditingController();
  bool _isLoading = false;

  final ImagePicker picker = ImagePicker();

  Future<void> pickPhoto() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) setState(() { selectedImage = File(image.path); selectedVideo = null; });
  }

  Future<void> pickVideo() async {
    final XFile? video = await picker.pickVideo(source: ImageSource.gallery);
    if (video != null) setState(() { selectedVideo = File(video.path); selectedImage = null; });
  }

  Future<void> _onPostTap() async {
    final file = selectedImage ?? selectedVideo;
    if (file == null) {
      Get.snackbar('Error', 'Please select a photo or video first.', snackPosition: SnackPosition.BOTTOM);
      return;
    }
    if (_captionController.text.trim().isEmpty) {
      Get.snackbar('Error', 'Please write a caption.', snackPosition: SnackPosition.BOTTOM);
      return;
    }

    setState(() => _isLoading = true);

    final result = await PostController.addPost(
      file: file,
      type: selectedImage != null ? 'photo' : 'video',
      caption: _captionController.text.trim(),
      tags: _tagsController.text.trim().isNotEmpty ? _tagsController.text.trim() : null,
    );

    if (mounted) setState(() => _isLoading = false);

    if (result['status'] == true) {
      Get.snackbar(
        'Success 🎉',
        'Post added successfully.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );

      Future.delayed(const Duration(milliseconds: 1500), () {
        if (mounted) {
          Get.offAll(() => const MainScreen());
        }
      });
    } else {
      Get.snackbar(
        'Validation Error ❌',
        result['message'].toString(),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 5),
      );
    }
  }

  @override
  void dispose() {
    _captionController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Color surfaceColor = Theme.of(context).canvasColor.withOpacity(0.05);
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * (20.625 / 375),
            vertical: h * (9.72 / 810),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * (8.1 / 810)),
              Image.asset(
                AppImages.logo,
                height: h * (80.0 / 810),
                width: w * (120.0 / 375),
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,
              ),

              SizedBox(height: h * (16.2 / 810)),

              /// Info Card
              GestureDetector(
                onTap: () {
                  Get.to(PostingWindowScreen());
                },
                child: Container(
                  height: h * (87.0 / 810),
                  width: w * (335.0 / 375),
                  padding: EdgeInsets.symmetric(horizontal: w * (15.0 / 375)),
                  decoration: BoxDecoration(
                    color: surfaceColor,
                    borderRadius: BorderRadius.circular(w * (25.0 / 375)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: primaryColor,
                            size: w * (12.0 / 375),
                          ),
                          SizedBox(width: w * (10.0 / 375)),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "WINDOW IS LOCK",
                                style: MainTextStyles.inter(
                                  color: primaryColor,
                                  fontSize: w * (12.0 / 375),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Section your moments with me",
                                style: MainTextStyles.inter(
                                  color: AppColors.grey1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: w * (8.0 / 375),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "04:22",
                        style: MainTextStyles.inter(
                          color: primaryColor,
                          fontSize: w * (16.0 / 375),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: h * (16.2 / 810)),

              /// PHOTO CARD
              GestureDetector(
                onTap: pickPhoto,
                child: _buildSelectionCard(
                  context,
                  imageFile: selectedImage,
                  imagePath: 'assets/images/p1.png',
                  label: "Select Photo",
                  icon: Icons.add_a_photo_outlined,
                  w: w,
                  h: h,
                ),
              ),

              SizedBox(height: h * (12.15 / 810)),

              /// VIDEO CARD
              GestureDetector(
                onTap: pickVideo,
                child: _buildSelectionCard(
                  context,
                  imageFile: selectedVideo,
                  imagePath: 'assets/images/p2.png',
                  label: "Select Video",
                  icon: Icons.videocam_outlined,
                  w: w,
                  h: h,
                ),
              ),

              SizedBox(height: h * (16.2 / 810)),

              /// TEXT FIELD / STORY BOX
              Container(
                padding: EdgeInsets.all(w * (12.0 / 375)),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius: BorderRadius.circular(w * (30.0 / 375)),
                ),
                child: Column(
                  children: [
                    TextField(
                      maxLines: 2,
                      controller: _captionController,
                      style: TextStyle(color: textColor, fontSize: w * (14.0 / 375)),
                      decoration: InputDecoration(
                        hintText: "What's the story behind this moment.....",
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: w * (13.0 / 375),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    SizedBox(height: h * (8.1 / 810)),
                    Row(
                      children: [
                        Icon(
                          Icons.emoji_emotions_outlined,
                          color: const Color(0xFF767575),
                          size: w * (24.0 / 375),
                        ),
                        const Spacer(),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * (12.0 / 375),
                            vertical: h * (4.86 / 810),
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(w * (15.0 / 375)),
                          ),
                          child: SizedBox(
                            width: w * (100.0 / 375),
                            child: TextField(
                              controller: _tagsController,
                              style: GoogleFonts.inter(
                                color: const Color(0xFFADAAAA),
                                fontSize: w * (11.0 / 375),
                                fontWeight: FontWeight.w700,
                              ),
                              decoration: InputDecoration(
                                hintText: "Add Tags",
                                hintStyle: GoogleFonts.inter(color: const Color(0xFFADAAAA), fontSize: w * (11.0 / 375)),
                                border: InputBorder.none,
                                isDense: true,
                                contentPadding: EdgeInsets.zero,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: h * (16.2 / 810)),

              /// POST MOMENT BUTTON
              GestureDetector(
                onTap: _isLoading ? null : _onPostTap,
                child: Container(
                  width: double.infinity,
                  height: h * (55.0 / 810),
                  decoration: BoxDecoration(color: primaryColor, borderRadius: BorderRadius.circular(w * (30.0 / 375))),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      if (_isLoading)
                        const CustomLoader()
                      else ...[
                        Text(
                          "Post Moment",
                          style: GoogleFonts.inter(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: w * (13.0 / 375),
                          ),
                        ),
                        SizedBox(width: w * (10.0 / 375)),
                        Icon(Icons.share, color: Colors.white, size: w * (18.0 / 375)),
                      ],
                    ],
                  ),
                ),
              ),

              SizedBox(height: h * (32.4 / 810)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSelectionCard(
      BuildContext context, {
        required String imagePath,
        required String label,
        required IconData icon,
        File? imageFile,
        required double w,
        required double h,
      }) {
    return Container(
      height: h * (300.0 / 810),
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * (40.0 / 375)),
        image: DecorationImage(
          image: imageFile != null
              ? FileImage(imageFile)
              : AssetImage(imagePath) as ImageProvider,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.4),
            BlendMode.darken,
          ),
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: EdgeInsets.all(w * (10.0 / 375)),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26,
            ),
            child: Icon(
              icon,
              color: Theme.of(context).primaryColor,
              size: w * (30.0 / 375),
            ),
          ),
          SizedBox(height: h * (8.1 / 810)),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: w * (16.0 / 375),
            ),
          ),
        ],
      ),
    );
  }
}
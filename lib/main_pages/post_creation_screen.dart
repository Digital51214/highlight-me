// import 'dart:io';
// import 'package:flutter/material.dart';
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
//     return Scaffold(
//       backgroundColor: const Color(0xFF121212),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal:w * 0.055,
//             vertical: h * 0.012,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 10),
//               Image.asset(AppImages.logo, height: 80, width: 120),
//
//
//               const SizedBox(height: 20),
//
//               /// Info Card
//               ///
//               Container(
//                 height: 87,
//                 width: 335,
//                 padding: const EdgeInsets.symmetric(horizontal: 15),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha:0.05),
//                   borderRadius: BorderRadius.circular(25),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: [
//
//                     /// LEFT SIDE
//                     Row(
//                       children: [
//                         const Icon(
//                           Icons.circle,
//                           color: AppColors.lightblue,
//                           size: 12,
//                         ),
//                         const SizedBox(width: 10),
//
//                         Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Text(
//                               "WINDOW IS LOCK",
//                               style: MainTextStyles.inter(
//                                 color: AppColors.lightblue,
//                                 fontSize: 12,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                             Text(
//                               "Section your moments with me",
//                               style: MainTextStyles.inter(
//                                 color: AppColors.grey1,
//                                 fontWeight: FontWeight.w400,
//                                 fontSize: 8,
//                               ),
//                             ),
//                           ],
//                         ),
//                       ],
//                     ),
//
//                     /// RIGHT SIDE
//                     Text(
//                       "04:22",
//                       style: MainTextStyles.inter(
//                         color: AppColors.lightblue,
//                         fontSize: 16,
//                         fontWeight: FontWeight.w700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               /// PHOTO CARD (CLICKABLE)
//               GestureDetector(
//                 onTap: pickImage,
//                 child: _buildSelectionCard(
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
//                 onTap: pickImage,
//                 child: _buildSelectionCard(
//                   imageFile: null,
//                   imagePath: 'assets/images/p2.png',
//                   label: "Select Video",
//                   icon: Icons.videocam_outlined,
//                 ),
//               ),
//
//               const SizedBox(height: 20),
//
//               /// TEXT FIELD
//               Container(
//                 padding: const EdgeInsets.all(12),
//                 decoration: BoxDecoration(
//                   color: Colors.white.withValues(alpha:0.05),
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Column(
//                   children: [
//                     TextField(
//                       maxLines: 2,
//                       style: const TextStyle(color: Colors.white),
//                       decoration: InputDecoration(
//                         hintText: "What's the story behind this moment.....",
//                         hintStyle: GoogleFonts.inter(
//                           color: Colors.grey,
//                           fontSize: 13,
//                         ),
//                         border: InputBorder.none,
//                       ),
//                     ),
//
//                     const SizedBox(height: 10),
//
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
//               /// BUTTON
//               Container(
//                 width: double.infinity,
//                 height: 55,
//                 decoration: BoxDecoration(
//                   color: AppColors.lightblue,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     Text(
//                       "Post Moment",
//                       style: GoogleFonts.inter(
//                         color: Colors.white,
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
//   /// UPDATED CARD
//   Widget _buildSelectionCard({
//     required String imagePath,
//     required String label,
//     required IconData icon,
//     File? imageFile,
//   }) {
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
//             Colors.black.withValues(alpha:0.4),
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
//             child: Icon(icon, color: AppColors.lightblue, size: 30),
//           ),
//           const SizedBox(height: 10),
//           Text(
//             label,
//             style: GoogleFonts.inter(
//               color: Colors.white,
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
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:highlights/main_pages/post_lock_screen.dart';
import 'package:image_picker/image_picker.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/basic_files/basic_images.dart';

class PostCreationScreen extends StatefulWidget {
  const PostCreationScreen({super.key});

  @override
  State<PostCreationScreen> createState() => _PostCreationScreenState();
}

class _PostCreationScreenState extends State<PostCreationScreen> {
  File? selectedImage;
  final ImagePicker picker = ImagePicker();

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Dynamic theme colors
    final Color surfaceColor = Theme.of(context).canvasColor.withOpacity(0.05);
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // Changed
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * 0.055,
            vertical: h * 0.012,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10),
              Image.asset(
                AppImages.logo,
                height: 80,
                width: 120,
                color: Theme.of(context).brightness == Brightness.light ? Colors.black : null, // Logo color adjustment
              ),

              const SizedBox(height: 20),

              /// Info Card
              GestureDetector(
                onTap: (){
                  Get.to(PostingWindowScreen());
                },
                child: Container(
                  height: 87,
                  width: 335,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: surfaceColor, // Dynamic surface
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.circle,
                            color: primaryColor, // Dynamic primary
                            size: 12,
                          ),
                          const SizedBox(width: 10),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "WINDOW IS LOCK",
                                style: MainTextStyles.inter(
                                  color: primaryColor, // Dynamic primary
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              Text(
                                "Section your moments with me",
                                style: MainTextStyles.inter(
                                  color: AppColors.grey1,
                                  fontWeight: FontWeight.w400,
                                  fontSize: 8,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      Text(
                        "04:22",
                        style: MainTextStyles.inter(
                          color: primaryColor, // Dynamic primary
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// PHOTO CARD
              GestureDetector(
                onTap: pickImage,
                child: _buildSelectionCard(
                  context,
                  imageFile: selectedImage,
                  imagePath: 'assets/images/p1.png',
                  label: "Select Photo",
                  icon: Icons.add_a_photo_outlined,
                ),
              ),

              const SizedBox(height: 15),

              GestureDetector(
                onTap: pickImage, // Placeholder for video picking
                child: _buildSelectionCard(
                  context,
                  imageFile: null,
                  imagePath: 'assets/images/p2.png',
                  label: "Select Video",
                  icon: Icons.videocam_outlined,
                ),
              ),

              const SizedBox(height: 20),

              /// TEXT FIELD / STORY BOX
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: surfaceColor, // Dynamic surface
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  children: [
                    TextField(
                      maxLines: 2,
                      style: TextStyle(color: textColor), // Dynamic text color
                      decoration: InputDecoration(
                        hintText: "What's the story behind this moment.....",
                        hintStyle: GoogleFonts.inter(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.emoji_emotions_outlined,
                          color: Color(0xFF767575),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Text(
                            "Add Tags",
                            style: GoogleFonts.inter(
                              color: const Color(0xFFADAAAA),
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// POST BUTTON
              Container(
                width: double.infinity,
                height: 55,
                decoration: BoxDecoration(
                  color: primaryColor, // Dynamic primary
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Post Moment",
                      style: GoogleFonts.inter(
                        color: Colors.white, // Always white on primary
                        fontWeight: FontWeight.w700,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(width: 10),
                    const Icon(Icons.share, color: Colors.white, size: 18),
                  ],
                ),
              ),

              const SizedBox(height: 40),
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
      }) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
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
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black26,
            ),
            child: Icon(
                icon,
                color: Theme.of(context).primaryColor, // Dynamic primary
                size: 30
            ),
          ),
          const SizedBox(height: 10),
          Text(
            label,
            style: GoogleFonts.inter(
              color: Colors.white, // Keep white for overlay visibility
              fontWeight: FontWeight.w700,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
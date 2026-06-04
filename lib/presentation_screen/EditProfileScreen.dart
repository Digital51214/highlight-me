// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/ElevatedButton.dart';
// import 'package:image_picker/image_picker.dart';
//
// class EditProfilescreen extends StatefulWidget {
//   const EditProfilescreen({super.key});
//
//   @override
//   State<EditProfilescreen> createState() => _EditProfilescreenState();
// }
//
// class _EditProfilescreenState extends State<EditProfilescreen> {
//   final ImagePicker _picker = ImagePicker();
//
//   File? _selectedImage;
//
//   final TextEditingController _usernameController = TextEditingController(
//     text: "Lexas",
//   );
//
//   final TextEditingController _nameController = TextEditingController(
//     text: "Lexa Bravo",
//   );
//
//   final TextEditingController _bioController = TextEditingController(text: "");
//
//   @override
//   void dispose() {
//     _usernameController.dispose();
//     _nameController.dispose();
//     _bioController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(
//         source: source,
//         imageQuality: 85,
//       );
//
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//         });
//       }
//     } catch (e) {
//       debugPrint("Image Picker Error: $e");
//     }
//   }
//
//   void _showImagePickerSheet(Size size) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       isScrollControlled: false,
//       builder: (context) {
//         return Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.05,
//             vertical: size.height * 0.025,
//           ),
//           decoration: BoxDecoration(
//             color: const Color(0xff1B1C1F),
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(size.width * 0.07),
//               topRight: Radius.circular(size.width * 0.07),
//             ),
//             border: Border.all(
//               color: const Color(0xff2CCBFF).withValues(alpha:0.12),
//               width: size.width * 0.002,
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: size.width * 0.14,
//                 height: size.height * 0.005,
//                 decoration: BoxDecoration(
//                   color: Colors.white24,
//                   borderRadius: BorderRadius.circular(size.width * 0.03),
//                 ),
//               ),
//               SizedBox(height: size.height * 0.025),
//               Text(
//                 "Choose Profile Photo",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: size.width * 0.05,
//                   fontWeight: FontWeight.w700,
//                 ),
//               ),
//               SizedBox(height: size.height * 0.025),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildSheetOption(
//                       size: size,
//                       icon: Icons.camera_alt_rounded,
//                       title: "Camera",
//                       onTap: () async {
//                         Get.back();
//                         await _pickImage(ImageSource.camera);
//                       },
//                     ),
//                   ),
//                   SizedBox(width: size.width * 0.04),
//                   Expanded(
//                     child: _buildSheetOption(
//                       size: size,
//                       icon: Icons.photo_library_rounded,
//                       title: "Gallery",
//                       onTap: () async {
//                         Get.back();
//                         await _pickImage(ImageSource.gallery);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: size.height * 0.02),
//             ],
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _buildSheetOption({
//     required Size size,
//     required IconData icon,
//     required String title,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: size.height * 0.12,
//         decoration: BoxDecoration(
//           color: const Color(0xff262626),
//           borderRadius: BorderRadius.circular(size.width * 0.05),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Container(
//               height: size.width * 0.13,
//               width: size.width * 0.13,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: Color(0xff5AA9BC),
//               ),
//               child: Icon(icon, color: Colors.white, size: size.width * 0.065),
//             ),
//             SizedBox(height: size.height * 0.01),
//             Text(
//               title,
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: size.width * 0.04,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color(0xff0F1012),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.055,
//             vertical: size.height * 0.012,
//           ),
//           child: Column(
//             children: [
//               SizedBox(height: size.height * 0.01),
//
//               Row(children: const [CustomBackButtonWidget()]),
//
//               SizedBox(height: size.height * 0.025),
//
//               _buildProfileImageSection(size),
//
//               SizedBox(height: size.height * 0.038),
//
//               _buildTextField(
//                 size: size,
//                 controller: _usernameController,
//                 hintText: "Lexas",
//                 maxLines: 1,
//               ),
//               SizedBox(height: size.height * 0.01),
//
//               _buildTextField(
//                 size: size,
//                 controller: _nameController,
//                 hintText: "Lexa Bravo",
//                 maxLines: 1,
//               ),
//               SizedBox(height: size.height * 0.01),
//
//               _buildTextField(
//                 size: size,
//                 controller: _bioController,
//                 hintText: "Bio...",
//                 maxLines: 5,
//                 isBio: true,
//               ),
//
//               SizedBox(height: size.height * 0.04),
//               ElevatedButton1(
//                 text: "Update",
//                 onPressed: () {
//                   Get.back();
//                 },
//               ),
//               SizedBox(height: size.height * 0.04),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileImageSection(Size size) {
//     return Center(
//       child: SizedBox(
//         height: size.width * 0.36,
//         width: size.width * 0.36,
//         child: Stack(
//           clipBehavior: Clip.none,
//           children: [
//             Container(
//               height: size.width * 0.33,
//               width: size.width * 0.33,
//               padding: EdgeInsets.all(size.width * 0.012),
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 border: Border.all(
//                   color: const Color(0xff2FB7DD),
//                   width: size.width * 0.012,
//                 ),
//               ),
//               child: Container(
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   image: DecorationImage(
//                     image: _selectedImage != null
//                         ? FileImage(_selectedImage!)
//                         : const AssetImage("assets/images/h0.png")
//                               as ImageProvider,
//                     fit: BoxFit.cover,
//                   ),
//                 ),
//               ),
//             ),
//             Positioned(
//               right: size.width * 0.005,
//               bottom: size.width * 0.03,
//               child: GestureDetector(
//                 onTap: () {
//                   _showImagePickerSheet(size);
//                 },
//                 child: Container(
//                   height: size.width * 0.11,
//                   width: size.width * 0.11,
//                   decoration: const BoxDecoration(
//                     shape: BoxShape.circle,
//                     color: Color(0xff62AFC1),
//                   ),
//                   child: Icon(
//                     Icons.camera_alt_rounded,
//                     color: Colors.white,
//                     size: size.width * 0.055,
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({
//     required Size size,
//     required TextEditingController controller,
//     required String hintText,
//     required int maxLines,
//     bool isBio = false,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: isBio ? size.height * 0.12 : size.height * 0.058,
//       decoration: BoxDecoration(
//         color: const Color(0xff262626),
//         borderRadius: BorderRadius.circular(size.width * 0.06),
//       ),
//       child: TextField(
//         controller: controller,
//         maxLines: maxLines,
//         textAlignVertical: TextAlignVertical.center,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: size.width * 0.035,
//           fontWeight: FontWeight.w500,
//         ),
//         cursorColor: const Color(0xff5EC2DD),
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Colors.white38,
//             fontSize: size.width * 0.035,
//             fontWeight: FontWeight.w400,
//           ),
//           border: InputBorder.none,
//           isDense: true,
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.065,
//             vertical: size.height * 0.015,
//           ),
//           suffixIcon: isBio
//               ? Padding(
//                   padding: EdgeInsets.only(
//                     right: size.width * 0.04,
//                     top: size.height * 0.055,
//                   ),
//                   child: Icon(
//                     Icons.sentiment_satisfied_alt_rounded,
//                     color: Colors.white38,
//                     size: size.width * 0.08,
//                   ),
//                 )
//               : null,
//           suffixIconConstraints: isBio
//               ? BoxConstraints(
//                   minWidth: size.width * 0.12,
//                   minHeight: size.height * 0.05,
//                 )
//               : null,
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/ElevatedButton.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilescreen extends StatefulWidget {
  const EditProfilescreen({super.key});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final TextEditingController _usernameController = TextEditingController(text: "Lexas");
  final TextEditingController _nameController = TextEditingController(text: "Lexa Bravo");
  final TextEditingController _bioController = TextEditingController(text: "");

  @override
  void dispose() {
    _usernameController.dispose();
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 85);
      if (pickedFile != null) {
        setState(() => _selectedImage = File(pickedFile.path));
      }
    } catch (e) {
      debugPrint("Image Picker Error: $e");
    }
  }

  void _showImagePickerSheet(Size size, Color cardBg, Color textC, Color primary) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.025,
          ),
          decoration: BoxDecoration(
            color: cardBg, // Use cardColor for sheet BG
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(size.width * 0.07),
              topRight: Radius.circular(size.width * 0.07),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: size.width * 0.14,
                height: size.height * 0.005,
                decoration: BoxDecoration(
                  color: textC.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(size.width * 0.03),
                ),
              ),
              SizedBox(height: size.height * 0.025),
              Text(
                "Choose Profile Photo",
                style: TextStyle(color: textC, fontSize: size.width * 0.05, fontWeight: FontWeight.w700),
              ),
              SizedBox(height: size.height * 0.025),
              Row(
                children: [
                  Expanded(
                    child: _buildSheetOption(
                      size: size,
                      icon: Icons.camera_alt_rounded,
                      title: "Camera",
                      primaryColor: primary,
                      textColor: textC,
                      onTap: () { Get.back(); _pickImage(ImageSource.camera); },
                    ),
                  ),
                  SizedBox(width: size.width * 0.04),
                  Expanded(
                    child: _buildSheetOption(
                      size: size,
                      icon: Icons.photo_library_rounded,
                      title: "Gallery",
                      primaryColor: primary,
                      textColor: textC,
                      onTap: () { Get.back(); _pickImage(ImageSource.gallery); },
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSheetOption({
    required Size size,
    required IconData icon,
    required String title,
    required Color primaryColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: size.height * 0.12,
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(size.width * 0.05),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: size.width * 0.06,
              child: Icon(icon, color: Colors.white, size: size.width * 0.06),
            ),
            SizedBox(height: size.height * 0.01),
            Text(title, style: TextStyle(color: textColor, fontSize: size.width * 0.035, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: size.width * 0.055, vertical: size.height * 0.012),
          child: Column(
            children: [
              SizedBox(height: size.height * 0.01),
              const Row(children: [CustomBackButtonWidget()]),
              SizedBox(height: size.height * 0.025),
              _buildProfileImageSection(size, primaryColor, cardBgColor, textColor),
              SizedBox(height: size.height * 0.038),
              _buildTextField(size: size, controller: _usernameController, hintText: "Username", maxLines: 1, cardBg: cardBgColor, textC: textColor, primary: primaryColor),
              SizedBox(height: size.height * 0.01),
              _buildTextField(size: size, controller: _nameController, hintText: "Full Name", maxLines: 1, cardBg: cardBgColor, textC: textColor, primary: primaryColor),
              SizedBox(height: size.height * 0.01),
              _buildTextField(size: size, controller: _bioController, hintText: "Bio...", maxLines: 5, isBio: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor),
              SizedBox(height: size.height * 0.04),
              ElevatedButton1(text: "Update", onPressed: () => Get.back()),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection(Size size, Color primary, Color cardBg, Color textC) {
    return Center(
      child: SizedBox(
        height: size.width * 0.36,
        width: size.width * 0.36,
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: size.width * 0.33,
              width: size.width * 0.33,
              padding: EdgeInsets.all(size.width * 0.012),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primary, width: size.width * 0.012),
              ),
              child: CircleAvatar(
                backgroundImage: _selectedImage != null
                    ? FileImage(_selectedImage!)
                    : const AssetImage("assets/images/h0.png") as ImageProvider,
              ),
            ),
            Positioned(
              right: 0,
              bottom: 10,
              child: GestureDetector(
                onTap: () => _showImagePickerSheet(size, cardBg, textC, primary),
                child: CircleAvatar(
                  radius: size.width * 0.055,
                  backgroundColor: primary,
                  child: Icon(Icons.camera_alt_rounded, color: Colors.white, size: size.width * 0.055),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required Size size,
    required TextEditingController controller,
    required String hintText,
    required int maxLines,
    required Color cardBg,
    required Color textC,
    required Color primary,
    bool isBio = false,
  }) {
    return Container(
      width: double.infinity,
      height: isBio ? size.height * 0.12 : size.height * 0.058,
      decoration: BoxDecoration(color: cardBg, borderRadius: BorderRadius.circular(size.width * 0.06)),
      child: TextField(
        controller: controller,
        maxLines: maxLines,
        style: TextStyle(color: textC, fontSize: size.width * 0.035, fontWeight: FontWeight.w500),
        cursorColor: primary,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: textC.withOpacity(0.4), fontSize: size.width * 0.035),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.065, vertical: size.height * 0.015),
          suffixIcon: isBio ? Icon(Icons.sentiment_satisfied_alt_rounded, color: textC.withOpacity(0.4)) : null,
        ),
      ),
    );
  }
}
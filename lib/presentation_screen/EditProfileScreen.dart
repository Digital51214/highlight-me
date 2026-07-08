//
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:dio/dio.dart' show DioException;
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:image_picker/image_picker.dart';
//
// import '../basic_files/buttons.dart';
// import '../Contollers/profile_controller.dart';
// import '../Services/session_manager.dart';
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
//   File? _selectedImage;
//
//   final TextEditingController _nameController = TextEditingController();
//   final TextEditingController _bioController = TextEditingController(text: "");
//
//   String? _nameError;
//   bool _isLoading = false;
//   String? _savedAvatarPath;
//
//   @override
//   void initState() {
//     super.initState();
//     _prefillFields();
//   }
//
//   // Pehle se saved Name, Bio aur Avatar session se le aate hain, taake screen
//   // dobara khulne par dikhe ke pehle se kya save hai (warna khali lag kar
//   // aisa lagta hai jaise data save hi nahi hua).
//   Future<void> _prefillFields() async {
//     final savedName = await SessionManager.instance.getFullName();
//     final savedBio = await SessionManager.instance.getBio();
//     final savedPath = await SessionManager.instance.getAvatarLocalPath();
//     if (!mounted) return;
//     setState(() {
//       if (savedName != null && savedName.isNotEmpty) _nameController.text = savedName;
//       if (savedBio != null) _bioController.text = savedBio;
//       if (savedPath != null && File(savedPath).existsSync()) {
//         _savedAvatarPath = savedPath;
//       }
//     });
//   }
//
//   // Saved avatar "data:image/...;base64,XXXX" format mein hota hai —
//   // ise display ke liye actual bytes mein decode karta hai.
//   // Uint8List? _decodeExistingAvatar() {
//   //   final raw = _existingAvatarRaw;
//   //   if (raw == null || raw.isEmpty) return null;
//   //   try {
//   //     final commaIndex = raw.indexOf(',');
//   //     final pureBase64 = commaIndex != -1 ? raw.substring(commaIndex + 1) : raw;
//   //     return base64Decode(pureBase64);
//   //   } catch (e) {
//   //     return null;
//   //   }
//   // }
//
//   @override
//   void dispose() {
//     _nameController.dispose();
//     _bioController.dispose();
//     super.dispose();
//   }
//
//   Future<void> _pickImage(ImageSource source) async {
//     try {
//       final XFile? pickedFile = await _picker.pickImage(source: source, imageQuality: 85);
//       if (pickedFile != null) {
//         setState(() {
//           _selectedImage = File(pickedFile.path);
//           _savedAvatarPath = pickedFile.path;
//         });
//         final userId = await SessionManager.instance.getUserId();
//         if (userId != null) {
//           await SessionManager.instance.saveSession(
//             userId: userId,
//             avatarLocalPath: pickedFile.path,
//           );
//         }
//       }
//     } catch (e) {
//       debugPrint("Image Picker Error: $e");
//     }
//   }
//
//   // Selected image ko backend ke expected format mein convert karta hai:
//   // "data:image/png;base64,...." (jaisa Postman collection mein tha)
//   Future<String?> _imageToBase64() async {
//     if (_selectedImage == null) return null;
//     final bytes = await _selectedImage!.readAsBytes();
//     final base64Str = base64Encode(bytes);
//     final ext = _selectedImage!.path.split('.').last.toLowerCase();
//     final mime = ext == 'png' ? 'image/png' : 'image/jpeg';
//     return 'data:$mime;base64,$base64Str';
//   }
//
//   Future<void> _onUpdateTap() async {
//     setState(() {
//       _nameError = _nameController.text.trim().isEmpty ? 'Full name is required' : null;
//     });
//     if (_nameError != null) return;
//
//     setState(() => _isLoading = true);
//     try {
//       final avatarBase64 = await _imageToBase64();
//
//       final success = await ProfileController.editProfile(
//         name: _nameController.text.trim(),
//         bio: _bioController.text.trim(),
//         avatarBase64: avatarBase64,
//       );
//
//       if (success) {
//         Get.snackbar('Success', 'Profile updated successfully!');
//         await Future.delayed(const Duration(milliseconds: 300));
//         Get.back();
//       }
//     } on DioException catch (e) {
//       String errorMessage = 'Failed to update profile. Please try again.';
//       if (e.response != null && e.response?.data is Map) {
//         errorMessage = e.response?.data['message'] ?? errorMessage;
//       }
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     } catch (e) {
//       Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       if (mounted) setState(() => _isLoading = false);
//     }
//   }
//
//   void _showImagePickerSheet(Size size, Color cardBg, Color textC, Color primary) {
//     showModalBottomSheet(
//       context: context,
//       backgroundColor: Colors.transparent,
//       builder: (context) {
//         return Container(
//           width: double.infinity,
//           padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.05,
//             vertical: size.height * 0.025,
//           ),
//           decoration: BoxDecoration(
//             color: cardBg, // Use cardColor for sheet BG
//             borderRadius: BorderRadius.only(
//               topLeft: Radius.circular(size.width * 0.07),
//               topRight: Radius.circular(size.width * 0.07),
//             ),
//           ),
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Container(
//                 width: size.width * 0.14,
//                 height: size.height * 0.005,
//                 decoration: BoxDecoration(
//                   color: textC.withOpacity(0.2),
//                   borderRadius: BorderRadius.circular(size.width * 0.03),
//                 ),
//               ),
//               SizedBox(height: size.height * 0.025),
//               Text(
//                 "Choose Profile Photo",
//                 style: TextStyle(color: textC, fontSize: size.width * 0.05, fontWeight: FontWeight.w700),
//               ),
//               SizedBox(height: size.height * 0.025),
//               Row(
//                 children: [
//                   Expanded(
//                     child: _buildSheetOption(
//                       size: size,
//                       icon: Icons.camera_alt_rounded,
//                       title: "Camera",
//                       primaryColor: primary,
//                       textColor: textC,
//                       onTap: () { Get.back(); _pickImage(ImageSource.camera); },
//                     ),
//                   ),
//                   SizedBox(width: size.width * 0.04),
//                   Expanded(
//                     child: _buildSheetOption(
//                       size: size,
//                       icon: Icons.photo_library_rounded,
//                       title: "Gallery",
//                       primaryColor: primary,
//                       textColor: textC,
//                       onTap: () { Get.back(); _pickImage(ImageSource.gallery); },
//                     ),
//                   ),
//                 ],
//               ),
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
//     required Color primaryColor,
//     required Color textColor,
//     required VoidCallback onTap,
//   }) {
//     return GestureDetector(
//       onTap: onTap,
//       child: Container(
//         height: size.height * 0.12,
//         decoration: BoxDecoration(
//           color: textColor.withOpacity(0.05),
//           borderRadius: BorderRadius.circular(size.width * 0.05),
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             CircleAvatar(
//               backgroundColor: primaryColor,
//               radius: size.width * 0.06,
//               child: Icon(icon, color: Colors.white, size: size.width * 0.06),
//             ),
//             SizedBox(height: size.height * 0.01),
//             Text(title, style: TextStyle(color: textColor, fontSize: size.width * 0.035, fontWeight: FontWeight.w600)),
//           ],
//         ),
//       ),
//     );
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color cardBgColor = Theme.of(context).cardColor;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(horizontal: size.width * 0.055, vertical: size.height * 0.012),
//           child: Column(
//             children: [
//               SizedBox(height: size.height * 0.01),
//               const Row(children: [CustomBackButtonWidget()]),
//               SizedBox(height: size.height * 0.025),
//               _buildProfileImageSection(size, primaryColor, cardBgColor, textColor),
//               SizedBox(height: size.height * 0.001),
//               Text("Edit Picture or Avatar",
//                 style: GoogleFonts.inter(
//                     color: primaryColor
//                 ),),
//               SizedBox(height: size.height * 0.05),
//               _buildTextField(size: size, controller: _nameController,
//                   hintText: "Full Name", maxLines: 1, cardBg: cardBgColor, textC: textColor, primary: primaryColor,
//                   errorText: _nameError),
//               SizedBox(height: size.height * 0.01),
//               _buildTextField(size: size, controller: _bioController,
//                   hintText: "Bio...", maxLines: 5, isBio: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor),
//               SizedBox(height: size.height * 0.04),
//               RoundButton(text: "Update", showArrow: false, isLoading: _isLoading,
//                   onTap: _isLoading ? () {} : _onUpdateTap),
//               SizedBox(height: size.height * 0.04),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildProfileImageSection(Size size, Color primary, Color cardBg, Color textC) {
//     final File? displayFile = _selectedImage ??
//         (_savedAvatarPath != null ? File(_savedAvatarPath!) : null);
//     final ImageProvider avatarImage = displayFile != null
//         ? FileImage(displayFile)
//         : const AssetImage("assets/images/h0.png") as ImageProvider;
//
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
//                 border: Border.all(color: primary, width: size.width * 0.012),
//               ),
//               child: CircleAvatar(
//                 backgroundImage: avatarImage,
//               ),
//             ),
//             Positioned(
//               right: 0,
//               bottom: size.height * 0.02,
//               child: GestureDetector(
//                 onTap: () => _showImagePickerSheet(size, cardBg, textC, primary),
//                 child: CircleAvatar(
//                   radius: size.width * 0.05,
//                   backgroundColor: Color(0xFF262626),
//                   child: Icon(Icons.camera_alt_rounded,
//                       color: Colors.white, size: size.width * 0.055),
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
//     required Color cardBg,
//     required Color textC,
//     required Color primary,
//     bool isBio = false,
//     String? errorText,
//   }) {
//     final bool hasError = errorText != null;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           width: double.infinity,
//           height: isBio ? size.height * 0.12 : size.height * 0.058,
//           decoration: BoxDecoration(
//             color: cardBg,
//             borderRadius: BorderRadius.circular(size.width * 0.06),
//             border: hasError ? Border.all(color: Colors.red, width: 1.2) : null,
//           ),
//           child: TextField(
//             controller: controller,
//             maxLines: maxLines,
//             style: TextStyle(color: textC,
//                 fontSize: size.width * 0.035, fontWeight: FontWeight.w500),
//             cursorColor: primary,
//             decoration: InputDecoration(
//               hintText: hintText,
//               hintStyle: TextStyle(color: textC.withOpacity(0.4),
//                   fontSize: size.width * 0.035),
//               border: InputBorder.none,
//               contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.065,
//                   vertical: size.height * 0.015),
//               suffixIcon: isBio ? Icon(Icons.sentiment_satisfied_alt_rounded,
//                   color: textC.withOpacity(0.4)) : null,
//             ),
//           ),
//         ),
//         if (hasError)
//           Padding(
//             padding: EdgeInsets.only(top: size.height * 0.006, left: size.width * 0.03),
//             child: Text(errorText, style: TextStyle(color: Colors.red, fontSize: size.width * 0.03)),
//           ),
//       ],
//     );
//   }
// }
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart' show DioException;
import 'package:highlights/widgets/Backbutton.dart';
import 'package:image_picker/image_picker.dart';

import '../basic_files/buttons.dart';
import '../Contollers/profile_controller.dart';
import '../Services/session_manager.dart';
import 'SettingScreen.dart';

class EditProfilescreen extends StatefulWidget {
  const EditProfilescreen({super.key});

  @override
  State<EditProfilescreen> createState() => _EditProfilescreenState();
}

class _EditProfilescreenState extends State<EditProfilescreen> {
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();

  String? _nameError;
  bool _isLoading = false;
  String? _savedAvatarPath;
  String? _networkAvatar;

  @override
  void initState() {
    super.initState();
    _prefillFields();
  }

  Future<void> _prefillFields() async {
    final savedName = await SessionManager.instance.getFullName();
    final savedBio = await SessionManager.instance.getBio();
    final savedPath = await SessionManager.instance.getAvatarLocalPath();
    final savedNetworkAvatar = await SessionManager.instance.getAvatar();

    if (!mounted) return;

    setState(() {
      _nameController.text = savedName ?? "";
      _bioController.text = savedBio ?? "";
      _networkAvatar = savedNetworkAvatar;

      if (savedPath != null && File(savedPath).existsSync()) {
        _savedAvatarPath = savedPath;
      } else {
        _savedAvatarPath = null;
      }
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
          source: source, imageQuality: 85);
      if (pickedFile != null) {
        setState(() {
          _selectedImage = File(pickedFile.path);
          _savedAvatarPath = pickedFile.path;
        });
      }
    } catch (e) {
      debugPrint("Image Picker Error: $e");
    }
  }

  Future<String?> _imageToBase64() async {
    if (_selectedImage == null) return null;
    final bytes = await _selectedImage!.readAsBytes();
    final base64Str = base64Encode(bytes);
    final ext = _selectedImage!.path.split('.').last.toLowerCase();
    final mime = ext == 'png' ? 'image/png' : 'image/jpeg';
    return 'data:$mime;base64,$base64Str';
  }

  Future<void> _onUpdateTap() async {
    setState(() {
      _nameError = _nameController.text.trim().isEmpty ? 'Full name is required' : null;
    });
    if (_nameError != null) return;

    setState(() => _isLoading = true);
    try {
      final avatarBase64 = await _imageToBase64();

      final success = await ProfileController.editProfile(
        name: _nameController.text.trim(),
        bio: _bioController.text.trim(),
        avatarBase64: avatarBase64,
        avatarLocalPath: _selectedImage?.path,
      );

      if (success) {
        Get.snackbar('Success', 'Profile updated successfully!');
        Get.to(
          Settingscreen(),
          transition: Transition.noTransition,
          duration: Duration.zero,
        );
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to update profile. Please try again.';
      if (e.response != null && e.response?.data is Map) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } catch (e) {
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  Widget _buildNameInitialsPlaceholder(Color primaryColor, double w) {
    String name = _nameController.text.trim();
    String initials = "";
    if (name.isNotEmpty) {
      List<String> words = name.split(" ");
      if (words.length > 1 && words[1].isNotEmpty) {
        initials = (words[0][0] + words[1][0]).toUpperCase();
      } else if (words[0].isNotEmpty) {
        initials = words[0][0].toUpperCase();
      }
    }
    if (initials.isEmpty) initials = "?";

    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: primaryColor.withOpacity(0.12),
      ),
      alignment: Alignment.center,
      child: Text(
        initials,
        style: GoogleFonts.inter(
          color: primaryColor,
          fontSize: w * (41.25 / 375),
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildAvatarWidget(Color primaryColor, double w) {
    if (_selectedImage != null) {
      return CircleAvatar(backgroundImage: FileImage(_selectedImage!));
    }

    if (_savedAvatarPath != null && File(_savedAvatarPath!).existsSync()) {
      return CircleAvatar(backgroundImage: FileImage(File(_savedAvatarPath!)));
    }

    if (_networkAvatar != null && _networkAvatar!.isNotEmpty) {
      if (_networkAvatar!.startsWith('http://') || _networkAvatar!.startsWith('https://')) {
        return CircleAvatar(backgroundImage: NetworkImage(_networkAvatar!));
      } else {
        try {
          final commaIndex = _networkAvatar!.indexOf(',');
          final pureBase64 = commaIndex != -1 ? _networkAvatar!.substring(commaIndex + 1) : _networkAvatar!;
          return CircleAvatar(backgroundImage: MemoryImage(base64Decode(pureBase64.trim())));
        } catch (_) {
          return _buildNameInitialsPlaceholder(primaryColor, w);
        }
      }
    }

    return _buildNameInitialsPlaceholder(primaryColor, w);
  }

  void _showImagePickerSheet(double w, double h, Color cardBg, Color textC, Color primary) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: w * (18.75 / 375),
            vertical: h * (20.25 / 810),
          ),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(w * (26.25 / 375)),
              topRight: Radius.circular(w * (26.25 / 375)),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: w * (52.5 / 375),
                height: h * (4.05 / 810),
                decoration: BoxDecoration(
                  color: textC.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(w * (11.25 / 375)),
                ),
              ),
              SizedBox(height: h * (20.25 / 810)),
              Text(
                "Choose Profile Photo",
                style: TextStyle(color: textC, fontSize: w * (18.75 / 375), fontWeight: FontWeight.w700),
              ),
              SizedBox(height: h * (20.25 / 810)),
              Row(
                children: [
                  Expanded(
                    child: _buildSheetOption(
                      w: w,
                      h: h,
                      icon: Icons.camera_alt_rounded,
                      title: "Camera",
                      primaryColor: primary,
                      textColor: textC,
                      onTap: () { Get.back(); _pickImage(ImageSource.camera); },
                    ),
                  ),
                  SizedBox(width: w * (15.0 / 375)),
                  Expanded(
                    child: _buildSheetOption(
                      w: w,
                      h: h,
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
    required double w,
    required double h,
    required IconData icon,
    required String title,
    required Color primaryColor,
    required Color textColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: h * (97.2 / 810),
        decoration: BoxDecoration(
          color: textColor.withOpacity(0.05),
          borderRadius: BorderRadius.circular(w * (18.75 / 375)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              backgroundColor: primaryColor,
              radius: w * (22.5 / 375),
              child: Icon(icon, color: Colors.white, size: w * (22.5 / 375)),
            ),
            SizedBox(height: h * (8.1 / 810)),
            Text(title, style: TextStyle(color: textColor, fontSize: w * (13.125 / 375), fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: w * (20.625 / 375), vertical: h * (9.72 / 810)),
          child: Column(
            children: [
              SizedBox(height: h * (8.1 / 810)),
              const Row(children: [CustomBackButtonWidget()]),
              SizedBox(height: h * (20.25 / 810)),
              _buildProfileImageSection(w, h, primaryColor, cardBgColor, textColor),
              SizedBox(height: h * (6.48 / 810)),
              Text(
                "Edit Picture or Avatar",
                style: GoogleFonts.inter(
                  color: primaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: w * (14.0 / 375),
                ),
              ),
              SizedBox(height: h * (40.5 / 810)),
              _buildTextField(w: w, h: h, controller: _nameController,
                  hintText: "Full Name", maxLines: 1, cardBg: cardBgColor, textC: textColor, primary: primaryColor,
                  errorText: _nameError),
              SizedBox(height: h * (12.15 / 810)),
              _buildTextField(w: w, h: h, controller: _bioController,
                  hintText: "Bio...", maxLines: 5, isBio: true, cardBg: cardBgColor, textC: textColor, primary: primaryColor),
              SizedBox(height: h * (32.4 / 810)),
              RoundButton(text: "Update", showArrow: false, isLoading: _isLoading,
                  onTap: _isLoading ? () {} : _onUpdateTap),
              SizedBox(height: h * (32.4 / 810)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileImageSection(double w, double h, Color primary, Color cardBg, Color textC) {
    return Center(
      child: SizedBox(
        height: w * (135.0 / 375),
        width: w * (135.0 / 375),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: w * (123.75 / 375),
              width: w * (123.75 / 375),
              padding: EdgeInsets.all(w * (4.5 / 375)),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: primary, width: w * (4.5 / 375)),
              ),
              child: _buildAvatarWidget(primary, w),
            ),
            Positioned(
              right: 0,
              bottom: h * (16.2 / 810),
              child: GestureDetector(
                onTap: () => _showImagePickerSheet(w, h, cardBg, textC, primary),
                child: CircleAvatar(
                  radius: w * (18.75 / 375),
                  backgroundColor: const Color(0xFF262626),
                  child: Icon(Icons.camera_alt_rounded,
                      color: Colors.white, size: w * (20.625 / 375)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required double w,
    required double h,
    required TextEditingController controller,
    required String hintText,
    required int maxLines,
    required Color cardBg,
    required Color textC,
    required Color primary,
    bool isBio = false,
    String? errorText,
  }) {
    final bool hasError = errorText != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: isBio ? h * (97.2 / 810) : h * (46.98 / 810),
          decoration: BoxDecoration(
            color: cardBg,
            borderRadius: BorderRadius.circular(w * (22.5 / 375)),
            border: hasError ? Border.all(color: Colors.red, width: w * (1.2 / 375)) : null,
          ),
          child: TextField(
            controller: controller,
            maxLines: maxLines,
            style: TextStyle(color: textC, fontSize: w * (13.125 / 375), fontWeight: FontWeight.w500),
            cursorColor: primary,
            onChanged: (val) {
              if(!isBio) setState(() {});
            },
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: textC.withOpacity(0.4), fontSize: w * (13.125 / 375)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(horizontal: w * (24.375 / 375), vertical: h * (12.15 / 810)),
              suffixIcon: isBio ? Icon(Icons.sentiment_satisfied_alt_rounded, color: textC.withOpacity(0.4), size: w * (22.0 / 375)) : null,
            ),
          ),
        ),
        if (hasError)
          Padding(
            padding: EdgeInsets.only(top: h * (4.86 / 810), left: w * (11.25 / 375)),
            child: Text(errorText, style: TextStyle(color: Colors.red, fontSize: w * (11.25 / 375))),
          ),
      ],
    );
  }
}
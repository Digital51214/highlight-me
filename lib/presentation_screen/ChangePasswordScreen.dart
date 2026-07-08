// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/widgets/Backbutton.dart';
//
//
// import '../basic_files/buttons.dart';
//
// class ChangePasswordscreen extends StatefulWidget {
//   const ChangePasswordscreen({super.key});
//
//   @override
//   State<ChangePasswordscreen> createState() => _ChangePasswordscreenState();
// }
//
// class _ChangePasswordscreenState extends State<ChangePasswordscreen> {
//   final TextEditingController _oldPasswordController = TextEditingController();
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//   TextEditingController();
//
//   bool _oldPasswordObscure = true;
//   bool _newPasswordObscure = true;
//   bool _confirmPasswordObscure = true;
//
//   double _strengthValue = 0.0;
//   String _strengthText = "";
//
//   @override
//   void initState() {
//     super.initState();
//     _newPasswordController.addListener(_checkPasswordStrength);
//   }
//
//   @override
//   void dispose() {
//     _oldPasswordController.dispose();
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   void _checkPasswordStrength() {
//     final password = _newPasswordController.text.trim();
//
//     double strength = 0;
//     String label = "";
//
//     if (password.isEmpty) {
//       strength = 0;
//       label = "";
//     } else if (password.length < 6) {
//       strength = 0.35;
//       label = "Weak";
//     } else if (password.length < 10 ||
//         !RegExp(r'[A-Z]').hasMatch(password) ||
//         !RegExp(r'[0-9]').hasMatch(password)) {
//       strength = 0.65;
//       label = "Medium";
//     } else {
//       strength = 1.0;
//       label = "Strong";
//     }
//
//     setState(() {
//       _strengthValue = strength;
//       _strengthText = label;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     // Theme references
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color cardBgColor = Theme.of(context).cardColor;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.055,
//             vertical: size.height * 0.012,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: size.height * 0.01),
//
//               const CustomBackButtonWidget(),
//
//               SizedBox(height: size.height * 0.035),
//
//               Text(
//                 "Change Password",
//                 style: TextStyle(
//                   color: textColor,
//                   fontSize: size.width * 0.065,
//                   fontWeight: FontWeight.w800,
//                   height: 1.1,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.012),
//
//               Text(
//                 "Change Your Password.",
//                 style: TextStyle(
//                   color: textColor.withOpacity(0.6),
//                   fontSize: size.width * 0.036,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.035),
//
//               _buildPasswordField(
//                 size: size,
//                 controller: _oldPasswordController,
//                 hintText: "Enter Old Password",
//                 obscureText: _oldPasswordObscure,
//                 cardBgColor: cardBgColor,
//                 textColor: textColor,
//                 primaryColor: primaryColor,
//                 onToggle: () {
//                   setState(() {
//                     _oldPasswordObscure = !_oldPasswordObscure;
//                   });
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildPasswordField(
//                 size: size,
//                 controller: _newPasswordController,
//                 hintText: "Enter New Password",
//                 obscureText: _newPasswordObscure,
//                 cardBgColor: cardBgColor,
//                 textColor: textColor,
//                 primaryColor: primaryColor,
//                 onToggle: () {
//                   setState(() {
//                     _newPasswordObscure = !_newPasswordObscure;
//                   });
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.017),
//
//               _buildStrengthSection(size, primaryColor, textColor),
//
//               SizedBox(height: size.height * 0.023),
//
//               _buildPasswordField(
//                 size: size,
//                 controller: _confirmPasswordController,
//                 hintText: "Confirm New Password",
//                 obscureText: _confirmPasswordObscure,
//                 cardBgColor: cardBgColor,
//                 textColor: textColor,
//                 primaryColor: primaryColor,
//                 onToggle: () {
//                   setState(() {
//                     _confirmPasswordObscure = !_confirmPasswordObscure;
//                   });
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.05),
//               RoundButton(
//                   text: "Change Password", onTap: (){
//                 Get.back();
//               }),
//               SizedBox(height: size.height * 0.03),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildPasswordField({
//     required Size size,
//     required TextEditingController controller,
//     required String hintText,
//     required bool obscureText,
//     required Color cardBgColor,
//     required Color textColor,
//     required Color primaryColor,
//     required VoidCallback onToggle,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: size.height * 0.058,
//       decoration: BoxDecoration(
//         color: cardBgColor,
//         borderRadius: BorderRadius.circular(size.width * 0.06),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         style: TextStyle(
//           color: textColor,
//           fontSize: size.width * 0.035,
//           fontWeight: FontWeight.w500,
//         ),
//         cursorColor: primaryColor,
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: textColor.withOpacity(0.4),
//             fontSize: size.width * 0.035,
//             fontWeight: FontWeight.w400,
//           ),
//           border: InputBorder.none,
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.065,
//             vertical: size.height * 0.015,
//           ),
//           suffixIcon: GestureDetector(
//             onTap: onToggle,
//             child: Icon(
//               obscureText
//                   ? Icons.remove_red_eye_outlined
//                   : Icons.visibility_off_outlined,
//               color: textColor.withOpacity(0.4),
//               size: size.width * 0.065,
//             ),
//           ),
//           suffixIconConstraints: BoxConstraints(
//             minWidth: size.width * 0.14,
//             minHeight: size.height * 0.05,
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildStrengthSection(Size size, Color primaryColor, Color textColor) {
//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(size.width * 0.02),
//           child: LinearProgressIndicator(
//             value: _strengthValue,
//             minHeight: size.height * 0.008,
//             backgroundColor: textColor.withOpacity(0.1),
//             valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
//           ),
//         ),
//         SizedBox(height: size.height * 0.008),
//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             _strengthText,
//             style: TextStyle(
//               color: primaryColor,
//               fontSize: size.width * 0.043,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/widgets/Backbutton.dart';

import '../Contollers/profile_controller.dart';
import '../basic_files/buttons.dart';

class ChangePasswordscreen extends StatefulWidget {
  const ChangePasswordscreen({super.key});

  @override
  State<ChangePasswordscreen> createState() => _ChangePasswordscreenState();
}

class _ChangePasswordscreenState extends State<ChangePasswordscreen> {
  final ProfileController controller = Get.put(ProfileController());

  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _oldPasswordObscure = true;
  bool _newPasswordObscure = true;
  bool _confirmPasswordObscure = true;

  double _strengthValue = 0.0;
  String _strengthText = "";

  @override
  void initState() {
    super.initState();
    _newPasswordController.addListener(_checkPasswordStrength);
  }

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _checkPasswordStrength() {
    final password = _newPasswordController.text.trim();

    double strength = 0;
    String label = "";

    if (password.isEmpty) {
      strength = 0;
      label = "";
    } else if (password.length < 6) {
      strength = 0.35;
      label = "Weak";
    } else if (password.length < 10 ||
        !RegExp(r'[A-Z]').hasMatch(password) ||
        !RegExp(r'[0-9]').hasMatch(password)) {
      strength = 0.65;
      label = "Medium";
    } else {
      strength = 1.0;
      label = "Strong";
    }

    setState(() {
      _strengthValue = strength;
      _strengthText = label;
    });
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * (20.625 / 375), // 0.055 scaled ratio
            vertical: h * (9.72 / 810),    // 0.012 scaled ratio
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * (8.1 / 810)),

              const CustomBackButtonWidget(),

              SizedBox(height: h * (28.35 / 810)),

              Text(
                "Change Password",
                style: TextStyle(
                  color: textColor,
                  fontSize: w * (26.25 / 375),
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: h * (9.72 / 810)),

              Text(
                "Change Your Password.",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: w * (13.5 / 375),
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: h * (28.35 / 810)),

              // Old Password Field
              Obx(() => _buildPasswordField(
                w: w,
                h: h,
                controller: _oldPasswordController,
                hintText: "Enter Old Password",
                obscureText: _oldPasswordObscure,
                cardBgColor: cardBgColor,
                textColor: textColor,
                primaryColor: primaryColor,
                errorText: controller.oldPasswordError.value,
                onToggle: () {
                  setState(() {
                    _oldPasswordObscure = !_oldPasswordObscure;
                  });
                },
              )),

              SizedBox(height: h * (8.1 / 810)),

              // New Password Field
              Obx(() => _buildPasswordField(
                w: w,
                h: h,
                controller: _newPasswordController,
                hintText: "Enter New Password",
                obscureText: _newPasswordObscure,
                cardBgColor: cardBgColor,
                textColor: textColor,
                primaryColor: primaryColor,
                errorText: controller.newPasswordError.value,
                onToggle: () {
                  setState(() {
                    _newPasswordObscure = !_newPasswordObscure;
                  });
                },
              )),

              SizedBox(height: h * (13.77 / 810)),

              _buildStrengthSection(w, h, primaryColor, textColor),

              SizedBox(height: h * (18.63 / 810)),

              // Confirm Password Field
              Obx(() => _buildPasswordField(
                w: w,
                h: h,
                controller: _confirmPasswordController,
                hintText: "Confirm New Password",
                obscureText: _confirmPasswordObscure,
                cardBgColor: cardBgColor,
                textColor: textColor,
                primaryColor: primaryColor,
                errorText: controller.confirmPasswordError.value,
                onToggle: () {
                  setState(() {
                    _confirmPasswordObscure = !_confirmPasswordObscure;
                  });
                },
              )),

              SizedBox(height: h * (40.5 / 810)),

              // Update Button
              Obx(() => RoundButton(
                text: "Update Password",
                isLoading: controller.isLoading.value,
                showArrow: false,
                onTap: () {
                  controller.validateAndChangePassword(
                    oldPassword: _oldPasswordController.text,
                    newPassword: _newPasswordController.text,
                    confirmPassword: _confirmPasswordController.text,
                  );
                },
              )),

              SizedBox(height: h * (24.3 / 810)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required double w,
    required double h,
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required Color cardBgColor,
    required Color textColor,
    required Color primaryColor,
    required VoidCallback onToggle,
    String? errorText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: double.infinity,
          height: h * (51.03 / 810), // Evaluated size.height * 0.063 conversion
          decoration: BoxDecoration(
            color: cardBgColor,
            borderRadius: BorderRadius.circular(w * (22.5 / 375)),
            border: errorText != null
                ? Border.all(color: Colors.red.shade400, width: w * (1.2 / 375))
                : null,
          ),
          child: TextField(
            controller: controller,
            obscureText: obscureText,
            style: TextStyle(
              color: textColor,
              fontSize: w * (13.125 / 375),
              fontWeight: FontWeight.w500,
            ),
            cursorColor: primaryColor,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(
                color: textColor.withOpacity(0.4),
                fontSize: w * (13.125 / 375),
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: w * (24.375 / 375),
                vertical: h * (12.15 / 810),
              ),
              suffixIcon: GestureDetector(
                onTap: onToggle,
                child: Icon(
                  obscureText
                      ? Icons.remove_red_eye_outlined
                      : Icons.visibility_off_outlined,
                  color: textColor.withOpacity(0.4),
                  size: w * (22.875 / 375),
                ),
              ),
              suffixIconConstraints: BoxConstraints(
                minWidth: w * (52.5 / 375),
                minHeight: h * (40.5 / 810),
              ),
            ),
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: h * (4.05 / 810)),
          Padding(
            padding: EdgeInsets.only(left: w * (15.0 / 375)),
            child: Text(
              errorText,
              style: TextStyle(
                color: Colors.red.shade400,
                fontSize: w * (12.0 / 375),
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildStrengthSection(double w, double h, Color primaryColor, Color textColor) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(w * (7.5 / 375)),
          child: LinearProgressIndicator(
            value: _strengthValue,
            minHeight: h * (6.48 / 810),
            backgroundColor: textColor.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
        SizedBox(height: h * (6.48 / 810)),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            _strengthText,
            style: TextStyle(
              color: primaryColor,
              fontSize: w * (16.125 / 375),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
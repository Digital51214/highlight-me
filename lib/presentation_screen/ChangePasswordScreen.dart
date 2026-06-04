// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/ElevatedButton.dart';
//
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
//   Color _strengthColor = const Color(0xff4F98A7);
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
//     Color color = const Color(0xff4F98A7);
//
//     if (password.isEmpty) {
//       strength = 0;
//       label = "";
//     } else if (password.length < 6) {
//       strength = 0.35;
//       label = "Weak";
//       color = const Color(0xff4F98A7);
//     } else if (password.length < 10 ||
//         !RegExp(r'[A-Z]').hasMatch(password) ||
//         !RegExp(r'[0-9]').hasMatch(password)) {
//       strength = 0.65;
//       label = "Medium";
//       color = const Color(0xff4F98A7);
//     } else {
//       strength = 1.0;
//       label = "Strong";
//       color = const Color(0xff4F98A7);
//     }
//
//     setState(() {
//       _strengthValue = strength;
//       _strengthText = label;
//       _strengthColor = color;
//     });
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
//                   color: Colors.white,
//                   fontSize: size.width * 0.065,
//                   fontWeight: FontWeight.w800,
//                   height: 1.1,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.012),
//
//               Text(
//                 "Enter new password",
//                 style: TextStyle(
//                   color: Colors.white60,
//                   fontSize: size.width * 0.033,
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
//                 onToggle: () {
//                   setState(() {
//                     _newPasswordObscure = !_newPasswordObscure;
//                   });
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.017),
//
//               _buildStrengthSection(size),
//
//               SizedBox(height: size.height * 0.023),
//
//               _buildPasswordField(
//                 size: size,
//                 controller: _confirmPasswordController,
//                 hintText: "Confirm New Password",
//                 obscureText: _confirmPasswordObscure,
//                 onToggle: () {
//                   setState(() {
//                     _confirmPasswordObscure = !_confirmPasswordObscure;
//                   });
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.05),
//               ElevatedButton1(text: "Change Password", onPressed: (){
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
//     required VoidCallback onToggle,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: size.height * 0.058,
//       decoration: BoxDecoration(
//         color: const Color(0xff262626),
//         borderRadius: BorderRadius.circular(size.width * 0.06),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: size.width * 0.035,
//           fontWeight: FontWeight.w500,
//         ),
//         cursorColor: const Color(0xff62AFC1),
//         decoration: InputDecoration(
//           hintText: hintText,
//           hintStyle: TextStyle(
//             color: Colors.white38,
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
//               color: Colors.white38,
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
//   Widget _buildStrengthSection(Size size) {
//     return Column(
//       children: [
//         ClipRRect(
//           borderRadius: BorderRadius.circular(size.width * 0.02),
//           child: LinearProgressIndicator(
//             value: _strengthValue,
//             minHeight: size.height * 0.008,
//             backgroundColor: Colors.white.withValues(alpha:0.85),
//             valueColor: AlwaysStoppedAnimation<Color>(_strengthColor),
//           ),
//         ),
//         SizedBox(height: size.height * 0.008),
//         Align(
//           alignment: Alignment.centerRight,
//           child: Text(
//             _strengthText,
//             style: TextStyle(
//               color: const Color(0xff4F98A7),
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
import 'package:highlights/widgets/ElevatedButton.dart';

class ChangePasswordscreen extends StatefulWidget {
  const ChangePasswordscreen({super.key});

  @override
  State<ChangePasswordscreen> createState() => _ChangePasswordscreenState();
}

class _ChangePasswordscreenState extends State<ChangePasswordscreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
  TextEditingController();

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
    final size = MediaQuery.of(context).size;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.055,
            vertical: size.height * 0.012,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.01),

              const CustomBackButtonWidget(),

              SizedBox(height: size.height * 0.035),

              Text(
                "Change Password",
                style: TextStyle(
                  color: textColor,
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: size.height * 0.012),

              Text(
                "Enter new password",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.033,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: size.height * 0.035),

              _buildPasswordField(
                size: size,
                controller: _oldPasswordController,
                hintText: "Enter Old Password",
                obscureText: _oldPasswordObscure,
                cardBgColor: cardBgColor,
                textColor: textColor,
                primaryColor: primaryColor,
                onToggle: () {
                  setState(() {
                    _oldPasswordObscure = !_oldPasswordObscure;
                  });
                },
              ),

              SizedBox(height: size.height * 0.01),

              _buildPasswordField(
                size: size,
                controller: _newPasswordController,
                hintText: "Enter New Password",
                obscureText: _newPasswordObscure,
                cardBgColor: cardBgColor,
                textColor: textColor,
                primaryColor: primaryColor,
                onToggle: () {
                  setState(() {
                    _newPasswordObscure = !_newPasswordObscure;
                  });
                },
              ),

              SizedBox(height: size.height * 0.017),

              _buildStrengthSection(size, primaryColor, textColor),

              SizedBox(height: size.height * 0.023),

              _buildPasswordField(
                size: size,
                controller: _confirmPasswordController,
                hintText: "Confirm New Password",
                obscureText: _confirmPasswordObscure,
                cardBgColor: cardBgColor,
                textColor: textColor,
                primaryColor: primaryColor,
                onToggle: () {
                  setState(() {
                    _confirmPasswordObscure = !_confirmPasswordObscure;
                  });
                },
              ),

              SizedBox(height: size.height * 0.05),
              ElevatedButton1(text: "Change Password", onPressed: (){
                Get.back();
              }),
              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required Size size,
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required Color cardBgColor,
    required Color textColor,
    required Color primaryColor,
    required VoidCallback onToggle,
  }) {
    return Container(
      width: double.infinity,
      height: size.height * 0.058,
      decoration: BoxDecoration(
        color: cardBgColor,
        borderRadius: BorderRadius.circular(size.width * 0.06),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        style: TextStyle(
          color: textColor,
          fontSize: size.width * 0.035,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: primaryColor,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: textColor.withOpacity(0.4),
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.065,
            vertical: size.height * 0.015,
          ),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: textColor.withOpacity(0.4),
              size: size.width * 0.065,
            ),
          ),
          suffixIconConstraints: BoxConstraints(
            minWidth: size.width * 0.14,
            minHeight: size.height * 0.05,
          ),
        ),
      ),
    );
  }

  Widget _buildStrengthSection(Size size, Color primaryColor, Color textColor) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(size.width * 0.02),
          child: LinearProgressIndicator(
            value: _strengthValue,
            minHeight: size.height * 0.008,
            backgroundColor: textColor.withOpacity(0.1),
            valueColor: AlwaysStoppedAnimation<Color>(primaryColor),
          ),
        ),
        SizedBox(height: size.height * 0.008),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            _strengthText,
            style: TextStyle(
              color: primaryColor,
              fontSize: size.width * 0.043,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}
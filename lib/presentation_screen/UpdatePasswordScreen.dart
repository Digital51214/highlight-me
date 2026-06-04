// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/auth_screen/login_screen.dart';
// import 'package:highlights/presentation_screen/HelpandSupportScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/ElevatedButton.dart';
//
// class UpdatePasswordscreen extends StatefulWidget {
//   const UpdatePasswordscreen({super.key});
//
//   @override
//   State<UpdatePasswordscreen> createState() => _UpdatePasswordscreenState();
// }
//
// class _UpdatePasswordscreenState extends State<UpdatePasswordscreen> {
//   final TextEditingController _newPasswordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//   TextEditingController();
//
//   bool _isNewPasswordObscure = true;
//   bool _isConfirmPasswordObscure = true;
//
//   @override
//   void dispose() {
//     _newPasswordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }
//
//   bool get _isButtonEnabled {
//     return _newPasswordController.text.trim().isNotEmpty &&
//         _confirmPasswordController.text.trim().isNotEmpty;
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
//               SizedBox(height: size.height * 0.07),
//
//               Center(
//                 child:Image(image: AssetImage("assets/images/Vector.png"),height: size.height*0.2,width: double.infinity,),
//       ),
//
//               SizedBox(height: size.height * 0.06),
//
//               Text(
//                 "Update Password",
//                 style: TextStyle(
//                   color: Colors.white,
//                   fontSize: size.width * 0.068,
//                   fontWeight: FontWeight.w800,
//                   height: 1.1,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               Text(
//                 "Create a new password for your account",
//                 style: TextStyle(
//                   color: Colors.white60,
//                   fontSize: size.width * 0.033,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.025),
//
//               _buildPasswordField(
//                 size: size,
//                 controller: _newPasswordController,
//                 hintText: "New Password",
//                 obscureText: _isNewPasswordObscure,
//                 onToggle: () {
//                   setState(() {
//                     _isNewPasswordObscure = !_isNewPasswordObscure;
//                   });
//                 },
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.01),
//
//               _buildPasswordField(
//                 size: size,
//                 controller: _confirmPasswordController,
//                 hintText: "Confirm New Password",
//                 obscureText: _isConfirmPasswordObscure,
//                 onToggle: () {
//                   setState(() {
//                     _isConfirmPasswordObscure =
//                     !_isConfirmPasswordObscure;
//                   });
//                 },
//                 onChanged: (value) {
//                   setState(() {});
//                 },
//               ),
//
//               SizedBox(height: size.height * 0.035),
//               ElevatedButton1(text: "Update Password", onPressed: (){
//                 Get.to(LoginScreen());
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
//     required ValueChanged<String> onChanged,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: size.height * 0.058,
//       alignment: Alignment.center,
//       decoration: BoxDecoration(
//         color: const Color(0xff262626),
//         borderRadius: BorderRadius.circular(size.width * 0.06),
//       ),
//       child: TextField(
//         controller: controller,
//         obscureText: obscureText,
//         onChanged: onChanged,
//         textAlignVertical: TextAlignVertical.center,
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
//           isDense: true,
//           contentPadding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.05,
//           ),
//           suffixIcon: GestureDetector(
//             onTap: onToggle,
//             child: Icon(
//               obscureText
//                   ? Icons.remove_red_eye_outlined
//                   : Icons.visibility_off_outlined,
//               color: Colors.white38,
//               size: size.width * 0.06,
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
//   Widget _buildUpdateButton(Size size) {
//     return GestureDetector(
//       onTap: _isButtonEnabled
//           ? () {
//         // update password logic yahan likh dena
//       }
//           : null,
//       child: Container(
//         width: double.infinity,
//         height: size.height * 0.058,
//         decoration: BoxDecoration(
//           color: _isButtonEnabled
//               ? const Color(0xff62AFC1)
//               : const Color(0xff62AFC1).withOpacity(0.45),
//           borderRadius: BorderRadius.circular(size.width * 0.09),
//           boxShadow: _isButtonEnabled
//               ? [
//             BoxShadow(
//               color: const Color(0xff62AFC1).withOpacity(0.35),
//               blurRadius: size.width * 0.04,
//               spreadRadius: 1,
//             ),
//           ]
//               : [],
//         ),
//         child: Center(
//           child: Text(
//             "Update Password",
//             style: TextStyle(
//               color: Colors.white,
//               fontSize: size.width * 0.05,
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/auth_screen/login_screen.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/ElevatedButton.dart';

class UpdatePasswordscreen extends StatefulWidget {
  const UpdatePasswordscreen({super.key});

  @override
  State<UpdatePasswordscreen> createState() => _UpdatePasswordscreenState();
}

class _UpdatePasswordscreenState extends State<UpdatePasswordscreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isNewPasswordObscure = true;
  bool _isConfirmPasswordObscure = true;

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
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

              SizedBox(height: size.height * 0.07),

              Center(
                child: Image(
                  image: const AssetImage("assets/images/Vector.png"),
                  height: size.height * 0.2,
                  width: double.infinity,
                  // Image color adjust karne ke liye agar zaroorat ho:
                  // color: primaryColor,
                ),
              ),

              SizedBox(height: size.height * 0.06),

              Text(
                "Update Password",
                style: TextStyle(
                  color: textColor,
                  fontSize: size.width * 0.068,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: size.height * 0.01),

              Text(
                "Create a new password for your account",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.033,
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: size.height * 0.025),

              _buildPasswordField(
                size: size,
                cardBg: cardBgColor,
                textC: textColor,
                primary: primaryColor,
                controller: _newPasswordController,
                hintText: "New Password",
                obscureText: _isNewPasswordObscure,
                onToggle: () {
                  setState(() {
                    _isNewPasswordObscure = !_isNewPasswordObscure;
                  });
                },
                onChanged: (value) => setState(() {}),
              ),

              SizedBox(height: size.height * 0.01),

              _buildPasswordField(
                size: size,
                cardBg: cardBgColor,
                textC: textColor,
                primary: primaryColor,
                controller: _confirmPasswordController,
                hintText: "Confirm New Password",
                obscureText: _isConfirmPasswordObscure,
                onToggle: () {
                  setState(() {
                    _isConfirmPasswordObscure = !_isConfirmPasswordObscure;
                  });
                },
                onChanged: (value) => setState(() {}),
              ),

              SizedBox(height: size.height * 0.035),

              ElevatedButton1(
                text: "Update Password",
                onPressed: () {
                  Get.to(const LoginScreen());
                },
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField({
    required Size size,
    required Color cardBg,
    required Color textC,
    required Color primary,
    required TextEditingController controller,
    required String hintText,
    required bool obscureText,
    required VoidCallback onToggle,
    required ValueChanged<String> onChanged,
  }) {
    return Container(
      width: double.infinity,
      height: size.height * 0.058,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(size.width * 0.06),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        onChanged: onChanged,
        textAlignVertical: TextAlignVertical.center,
        style: TextStyle(
          color: textC,
          fontSize: size.width * 0.035,
          fontWeight: FontWeight.w500,
        ),
        cursorColor: primary,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: textC.withOpacity(0.38),
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          isDense: true,
          contentPadding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
          ),
          suffixIcon: GestureDetector(
            onTap: onToggle,
            child: Icon(
              obscureText
                  ? Icons.remove_red_eye_outlined
                  : Icons.visibility_off_outlined,
              color: textC.withOpacity(0.38),
              size: size.width * 0.06,
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
}
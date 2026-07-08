import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/text_fields.dart';
import 'package:highlights/widgets/Backbutton.dart';
import '../Contollers/auth_controller.dart';
import '../basic_files/buttons.dart';
import '../widgets/custom_loader.dart';

class UpdatePasswordscreen extends StatefulWidget {
  const UpdatePasswordscreen({super.key});

  @override
  State<UpdatePasswordscreen> createState() => _UpdatePasswordscreenState();
}

class _UpdatePasswordscreenState extends State<UpdatePasswordscreen> {
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  final AuthController authController = Get.find<AuthController>();

  String? _newPasswordError;
  String? _confirmPasswordError;

  int userId = 0;

  @override
  void initState() {
    super.initState();
    var args = Get.arguments;
    print("✅ UpdatePassword — Arguments received: $args");
    if (args is Map) {
      userId = args['userId'] is int
          ? args['userId']
          : int.tryParse(args['userId']?.toString() ?? '') ?? 0;
    }
    print("✅ UpdatePassword — userId set to: $userId");
  }

  @override
  void dispose() {
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  bool _validate() {
    String? newPassErr;
    String? confirmPassErr;

    final newPass    = _newPasswordController.text.trim();
    final confirmPass = _confirmPasswordController.text.trim();

    if (newPass.isEmpty) {
      newPassErr = "New password is required";
    } else if (newPass.length < 6) {
      newPassErr = "Password must be at least 6 characters";
    }

    if (confirmPass.isEmpty) {
      confirmPassErr = "Please confirm your password";
    } else if (newPass.isNotEmpty && confirmPass != newPass) {
      confirmPassErr = "Passwords do not match";
    }

    setState(() {
      _newPasswordError    = newPassErr;
      _confirmPasswordError = confirmPassErr;
    });

    return newPassErr == null && confirmPassErr == null;
  }

  // ✅ Yahi function button se call hoga
  void _onUpdatePressed() {
    if (userId == 0) {
      Get.snackbar("Error", "User ID not found. Please go back and try again.");
      return;
    }
    if (!_validate()) return;

    FocusScope.of(context).unfocus();
    authController.updatePassword(
      userId:          userId,
      newPassword:     _newPasswordController.text.trim(),
      confirmPassword: _confirmPasswordController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Color textColor = Theme.of(context).canvasColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: w * (20.625 / 375), // 0.055 scaled ratio
            vertical:   h * (9.72 / 810),    // 0.012 scaled ratio
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: h * (8.1 / 810)),

              const CustomBackButtonWidget(),

              SizedBox(height: h * (56.7 / 810)),

              Center(
                child: Image(
                  image: const AssetImage("assets/images/Vector.png"),
                  height: h * (162.0 / 810), // Mapped from size.height * 0.2
                  width: double.infinity,
                ),
              ),

              SizedBox(height: h * (48.6 / 810)),

              Text(
                "Update Password",
                style: TextStyle(
                  color: textColor,
                  fontSize: w * (25.5 / 375), // Mapped from size.width * 0.068
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: h * (8.1 / 810)),

              Text(
                "Create a new password for your account",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: w * (12.375 / 375), // Mapped from size.width * 0.033
                  fontWeight: FontWeight.w400,
                ),
              ),

              SizedBox(height: h * (20.25 / 810)),

              // New Password field — red border + error text auto aayega
              PasswordTextField(
                hintText:  "New Password",
                controller: _newPasswordController,
                errorText:  _newPasswordError,
              ),

              SizedBox(height: h * (12.15 / 810)),

              // Confirm Password field
              PasswordTextField(
                hintText:  "Confirm New Password",
                controller: _confirmPasswordController,
                errorText:  _confirmPasswordError,
              ),

              SizedBox(height: h * (28.35 / 810)),

              Obx(
                    () => RoundButton(
                  text:      "Update Password",
                  isLoading: authController.isLoading.value,
                  showArrow: false,  // Figma mein arrow nahi hai
                  onTap:     _onUpdatePressed,
                ),
              ),

              SizedBox(height: h * (24.3 / 810)),
            ],
          ),
        ),
      ),
    );
  }
}
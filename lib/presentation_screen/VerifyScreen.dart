import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/buttons.dart';
import 'package:highlights/presentation_screen/UpdatePasswordScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/ElevatedButton.dart';
import '../Contollers/auth_controller.dart';

class Verifyscreen extends StatefulWidget {
  const Verifyscreen({super.key});

  @override
  State<Verifyscreen> createState() => _VerifyscreenState();
}

class _VerifyscreenState extends State<Verifyscreen> {
  final List<TextEditingController> _otpControllers =
  List.generate(6, (index) => TextEditingController());

  final List<FocusNode> _focusNodes =
  List.generate(6, (index) => FocusNode());

  Timer? _timer;
  int _secondsRemaining = 32;

  final AuthController authController = Get.find<AuthController>();

  // Pichli screen se aane wala data
  String userEmail  = '';
  int    userId     = 0;
  String sentOtp    = ''; // Server ne jo OTP bheja

  String? _otpError;

  @override
  void initState() {
    super.initState();

    final args = Get.arguments;
    if (args is Map) {
      userEmail = args['email']?.toString() ?? '';
      sentOtp   = args['otp']?.toString()   ?? '';
      userId    = args['user_id'] is int
          ? args['user_id']
          : int.tryParse(args['user_id']?.toString() ?? '') ?? 0;
    }

    print("✅ VerifyScreen — userId: $userId, otp: $sentOtp, email: $userEmail");
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 32;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  String _formattedTime() =>
      "00:${_secondsRemaining.toString().padLeft(2, '0')}";

  @override
  void dispose() {
    _timer?.cancel();
    for (final c in _otpControllers) c.dispose();
    for (final n in _focusNodes) n.dispose();
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty && index < 5) {
      _focusNodes[index + 1].requestFocus();
    } else if (value.isNotEmpty && index == 5) {
      _focusNodes[index].unfocus();
    }
  }

  void _onBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  void _clearOtpFields() {
    for (final c in _otpControllers) c.clear();
    _focusNodes[0].requestFocus();
  }

  void _verifyOtp() {
    FocusScope.of(context).unfocus();

    final String enteredOtp =
    _otpControllers.map((e) => e.text).join();

    if (enteredOtp.length < 6) {
      setState(() => _otpError = "Please enter the complete 6-digit code");
      return;
    }

    if (userId == 0) {
      setState(() => _otpError = "Session expired. Please go back and try again.");
      return;
    }

    if (enteredOtp == sentOtp) {
      setState(() => _otpError = null);

      Get.to(
            () => const UpdatePasswordscreen(),
        arguments: {'userId': userId},
        transition: Transition.noTransition,
        duration: Duration.zero,
      );
    } else {
      setState(() => _otpError = "Invalid code. Please try again.");
      _clearOtpFields();
    }
  }

  Future<void> _resendOtp() async {
    setState(() => _otpError = null);
    _clearOtpFields();

    final result = await authController.sendForgotPasswordOtp(
      email: userEmail,
    );

    if (result != null) {
      setState(() {
        userId  = result['user_id'];
        sentOtp = result['otp'].toString();
      });
      _startTimer();
    }
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Color textColor    = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;

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
                "Enter Code",
                style: TextStyle(
                  color: textColor,
                  fontSize: w * (25.5 / 375), // Mapped from size.width * 0.068
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: h * (8.1 / 810)),

              Text(
                "We have sent you a code to your email\n$userEmail",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: w * (12.375 / 375), // Mapped from size.width * 0.033
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                ),
              ),

              SizedBox(height: h * (20.25 / 810)),

              // OTP Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                      (index) => _buildOtpField(w, h, index, primaryColor, textColor),
                ),
              ),

              // Inline error
              if (_otpError != null) ...[
                SizedBox(height: h * (12.15 / 810)),
                Text(
                  _otpError!,
                  style: TextStyle(
                    color: Colors.redAccent,
                    fontSize: w * (12.375 / 375),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],

              SizedBox(height: h * (36.45 / 810)),

              // Resend
              Center(
                child: GestureDetector(
                  onTap: _secondsRemaining == 0 ? _resendOtp : null,
                  child: Text(
                    _secondsRemaining == 0
                        ? "Resend Code"
                        : "Resend in ${_formattedTime()}",
                    style: TextStyle(
                      color: _secondsRemaining == 0
                          ? primaryColor
                          : textColor.withOpacity(0.5),
                      fontSize: w * (16.125 / 375), // Mapped from size.width * 0.043
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: h * (40.5 / 810)),

              // Verify Button
              RoundButton(
                text: "Verify Code",
                showArrow: false,
                onTap : _verifyOtp,
              ),

              SizedBox(height: h * (24.3 / 810)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(double w, double h, int index, Color primary, Color textC) {
    final bool hasError = _otpError != null;

    return Container(
      width: w * (50.625 / 375),  // Evaluated from size.width * 0.135
      height: h * (56.7 / 810),    // Evaluated from size.height * 0.07
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(w * (15.0 / 375)), // Evaluated from size.width * 0.04
        border: Border.all(
          color: hasError ? Colors.redAccent : primary.withOpacity(0.6),
          width: w * (1.05 / 375), // Evaluated from size.width * 0.0028
        ),
      ),
      child: TextField(
        controller: _otpControllers[index],
        focusNode: _focusNodes[index],
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        textAlignVertical: TextAlignVertical.center,
        maxLength: 1,
        style: TextStyle(
          color: textC,
          fontSize: w * (18.75 / 375), // Mapped from size.width * 0.05
          fontWeight: FontWeight.w600,
        ),
        cursorColor: primary,
        decoration: const InputDecoration(
          counterText: "",
          border: InputBorder.none,
        ),
        onChanged: (value) {
          if (value.isEmpty) {
            _onBackspace(value, index);
          } else {
            _onOtpChanged(value, index);
          }
          if (_otpError != null) setState(() => _otpError = null);
          else setState(() {});
        },
      ),
    );
  }
}
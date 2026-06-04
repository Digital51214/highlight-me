// import 'dart:async';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/UpdatePasswordScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
// import 'package:highlights/widgets/ElevatedButton.dart';
//
// class Verifyscreen extends StatefulWidget {
//   const Verifyscreen({super.key});
//
//   @override
//   State<Verifyscreen> createState() => _VerifyscreenState();
// }
//
// class _VerifyscreenState extends State<Verifyscreen> {
//   final List<TextEditingController> _otpControllers =
//   List.generate(6, (index) => TextEditingController());
//
//   final List<FocusNode> _focusNodes =
//   List.generate(6, (index) => FocusNode());
//
//   Timer? _timer;
//   int _secondsRemaining = 32;
//
//   @override
//   void initState() {
//     super.initState();
//     _startTimer();
//   }
//
//   void _startTimer() {
//     _timer?.cancel();
//     _secondsRemaining = 32;
//
//     _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
//       if (_secondsRemaining == 0) {
//         timer.cancel();
//       } else {
//         setState(() {
//           _secondsRemaining--;
//         });
//       }
//     });
//   }
//
//   String _formattedTime() {
//     final seconds = _secondsRemaining.toString().padLeft(2, '0');
//     return "00:$seconds";
//   }
//
//   String get enteredOtp {
//     return _otpControllers.map((e) => e.text).join();
//   }
//
//   @override
//   void dispose() {
//     _timer?.cancel();
//     for (final controller in _otpControllers) {
//       controller.dispose();
//     }
//     for (final node in _focusNodes) {
//       node.dispose();
//     }
//     super.dispose();
//   }
//
//   void _onOtpChanged(String value, int index) {
//     if (value.isNotEmpty) {
//       if (index < 5) {
//         _focusNodes[index + 1].requestFocus();
//       } else {
//         _focusNodes[index].unfocus();
//       }
//     }
//   }
//
//   void _onBackspace(String value, int index) {
//     if (value.isEmpty && index > 0) {
//       _focusNodes[index - 1].requestFocus();
//     }
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
//
//       ),
//
//               SizedBox(height: size.height * 0.06),
//
//               Text(
//                 "Enter Code",
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
//                 "We have sent you a code to your email\nlexabravo@yahoo.com",
//                 style: TextStyle(
//                   color: Colors.white60,
//                   fontSize: size.width * 0.033,
//                   fontWeight: FontWeight.w400,
//                   height: 1.25,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.025),
//
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: List.generate(
//                   6,
//                       (index) => _buildOtpField(size, index),
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.045),
//
//               Center(
//                 child: GestureDetector(
//                   onTap: _secondsRemaining == 0
//                       ? () {
//                     setState(() {
//                       for (final controller in _otpControllers) {
//                         controller.clear();
//                       }
//                     });
//                     _startTimer();
//                   }
//                       : null,
//                   child: Text(
//                     _secondsRemaining == 0
//                         ? "Resend Code"
//                         : "Resend in ${_formattedTime()}",
//                     style: TextStyle(
//                       color: _secondsRemaining == 0
//                           ? const Color(0xff62AFC1)
//                           : Colors.white60,
//                       fontSize: size.width * 0.043,
//                       fontWeight: FontWeight.w400,
//                     ),
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.05),
//               ElevatedButton1(text: "Verify Code", onPressed: (){
//                 Get.to(UpdatePasswordscreen(),
//                   transition: Transition.noTransition,
//                   duration: Duration.zero,);
//               }),
//               SizedBox(height: size.height * 0.03),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildOtpField(Size size, int index) {
//     return Container(
//       width: size.width * 0.135,
//       height: size.height * 0.06,
//       alignment: Alignment.center, // ⭐ IMPORTANT
//       decoration: BoxDecoration(
//         color: const Color(0xff15262B),
//         borderRadius: BorderRadius.circular(size.width * 0.04),
//         border: Border.all(
//           color: const Color(0xff3EA8C7),
//           width: size.width * 0.0028,
//         ),
//       ),
//       child: TextField(
//         controller: _otpControllers[index],
//         focusNode: _focusNodes[index],
//         keyboardType: TextInputType.number,
//         textAlign: TextAlign.center,
//         textAlignVertical: TextAlignVertical.center,
//         maxLength: 1,
//         style: TextStyle(
//           color: Colors.white,
//           fontSize: size.width * 0.05,
//           fontWeight: FontWeight.w600,
//         ),
//         cursorColor: const Color(0xff62AFC1),
//         decoration: const InputDecoration(
//           counterText: "",
//           border: InputBorder.none,
//         ),
//         onChanged: (value) {
//           if (value.isEmpty) {
//             _onBackspace(value, index);
//           } else {
//             _onOtpChanged(value, index);
//           }
//           setState(() {});
//         },
//       ),
//     );
//   }
// }
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/presentation_screen/UpdatePasswordScreen.dart';
import 'package:highlights/widgets/Backbutton.dart';
import 'package:highlights/widgets/ElevatedButton.dart';

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

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    _secondsRemaining = 32;

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  String _formattedTime() {
    final seconds = _secondsRemaining.toString().padLeft(2, '0');
    return "00:$seconds";
  }

  @override
  void dispose() {
    _timer?.cancel();
    for (final controller in _otpControllers) {
      controller.dispose();
    }
    for (final node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  void _onOtpChanged(String value, int index) {
    if (value.isNotEmpty) {
      if (index < 5) {
        _focusNodes[index + 1].requestFocus();
      } else {
        _focusNodes[index].unfocus();
      }
    }
  }

  void _onBackspace(String value, int index) {
    if (value.isEmpty && index > 0) {
      _focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;

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
                ),
              ),

              SizedBox(height: size.height * 0.06),

              Text(
                "Enter Code",
                style: TextStyle(
                  color: textColor,
                  fontSize: size.width * 0.068,
                  fontWeight: FontWeight.w800,
                  height: 1.1,
                ),
              ),

              SizedBox(height: size.height * 0.01),

              Text(
                "We have sent you a code to your email\nlexabravo@yahoo.com",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.033,
                  fontWeight: FontWeight.w400,
                  height: 1.25,
                ),
              ),

              SizedBox(height: size.height * 0.025),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  6,
                      (index) => _buildOtpField(size, index, primaryColor, textColor),
                ),
              ),

              SizedBox(height: size.height * 0.045),

              Center(
                child: GestureDetector(
                  onTap: _secondsRemaining == 0
                      ? () {
                    setState(() {
                      for (final controller in _otpControllers) {
                        controller.clear();
                      }
                    });
                    _startTimer();
                  }
                      : null,
                  child: Text(
                    _secondsRemaining == 0
                        ? "Resend Code"
                        : "Resend in ${_formattedTime()}",
                    style: TextStyle(
                      color: _secondsRemaining == 0
                          ? primaryColor
                          : textColor.withOpacity(0.5),
                      fontSize: size.width * 0.043,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.05),

              ElevatedButton1(
                text: "Verify Code",
                onPressed: () {
                  Get.to(
                    const UpdatePasswordscreen(),
                    transition: Transition.noTransition,
                    duration: Duration.zero,
                  );
                },
              ),

              SizedBox(height: size.height * 0.03),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpField(Size size, int index, Color primary, Color textC) {
    return Container(
      width: size.width * 0.135,
      height: size.height * 0.06,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        // Dynamic background based on primary color
        color: primary.withOpacity(0.12),
        borderRadius: BorderRadius.circular(size.width * 0.04),
        border: Border.all(
          color: primary.withOpacity(0.6),
          width: size.width * 0.0028,
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
          fontSize: size.width * 0.05,
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
          setState(() {});
        },
      ),
    );
  }
}
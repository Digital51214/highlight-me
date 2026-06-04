// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
// class EmailTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final double width;
//   final double height;
//
//   const EmailTextField({
//     super.key,
//     required this.hintText,
//     this.controller,
//     this.width = 335,
//     this.height = 45,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100),
//
//         // 🔥 Gradient like your UI
//        color: AppColors.tf
//       ),
//       width: width,
//       height: height,
//       child: Center(
//         child: TextFormField(
//           controller: controller,
//           keyboardType: TextInputType.emailAddress, // Email keyboard
//           style: GoogleFonts.inter(color:AppColors.grey1,fontWeight: FontWeight.w400,fontSize: 13), // Typed text color
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             focusedBorder: InputBorder.none,
//
//             // 🎯 Perfect alignment
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 14,
//             ),
//             hintText: hintText,
//             hintStyle: GoogleFonts.manrope(
//               color:   Color(0xFF767575),
//               fontWeight: FontWeight.w400,
//               fontSize: 12,
//             ),
//
//
//           ),
//         ),
//       ),
//     );
//   }
// }
// class PasswordTextField extends StatefulWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final double width;
//   final double height;
//   final int maxLength;
//
//   const PasswordTextField({
//     super.key,
//     required this.hintText,
//     this.controller,
//     this.width = 335,
//     this.height = 48,
//     this.maxLength = 20,
//   });
//
//   @override
//   State<PasswordTextField> createState() => _PasswordTextFieldState();
// }
//
// class _PasswordTextFieldState extends State<PasswordTextField> {
//   bool _obscure = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: widget.width,
//       height: widget.height,
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100),
//
//        color: AppColors.tf
//       ),
//       child: TextFormField(
//         controller: widget.controller,
//         obscureText: _obscure,
//         maxLength: widget.maxLength,
//         style: const TextStyle(
//           color: Colors.white,
//           fontSize: 14,
//         ),
//         inputFormatters: [
//           LengthLimitingTextInputFormatter(widget.maxLength),
//         ],
//         decoration: InputDecoration(
//           counterText: "",
//
//           // ✨ Hint Text
//           hintText: widget.hintText,
//           hintStyle: GoogleFonts.manrope(
//             color:AppColors.grey1,
//             fontSize: 13,
//             fontWeight: FontWeight.w400,
//           ),
//
//           // ❌ Remove underline
//           border: InputBorder.none,
//           enabledBorder: InputBorder.none,
//           focusedBorder: InputBorder.none,
//
//           // 🎯 Perfect alignment
//           contentPadding: const EdgeInsets.symmetric(
//             horizontal: 20,
//             vertical: 14,
//           ),
//
//           // 👁 Eye icon (like image)
//           suffixIcon: IconButton(
//             icon: Icon(
//               _obscure
//                   ? Icons.visibility_outlined
//                   : Icons.visibility_off_outlined,
//               color: AppColors.grey1,
//               size: 20,
//             ),
//             onPressed: () {
//               setState(() {
//                 _obscure = !_obscure;
//               });
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class RoundTextField extends StatelessWidget {
//   final String hintText;
//   final TextEditingController? controller;
//   final double width;
//   final double height;
//
//   const RoundTextField({
//     super.key,
//     required this.hintText,
//     this.controller,
//     this.width = 335,
//     this.height = 45,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(100),
// color: AppColors.tf
//       ),
//       width: width,
//       height: height,
//       child: Center(
//         child: TextFormField(
//           controller: controller,
//           keyboardType: TextInputType.emailAddress,
//           style: GoogleFonts.inter(
//             color: AppColors.tf,
//             fontWeight: FontWeight.w400,
//             fontSize: 13,
//           ),
//           decoration: InputDecoration(
//             border: InputBorder.none,
//             enabledBorder: InputBorder.none,
//             focusedBorder: InputBorder.none,
//
//             contentPadding: const EdgeInsets.symmetric(
//               horizontal: 20,
//               vertical: 14,
//             ),
//
//             hintText: hintText,
//             hintStyle: GoogleFonts.manrope(
//               color: AppColors.grey1,
//               fontWeight: FontWeight.w400,
//               fontSize: 12,
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final double width;
  final double height;

  const EmailTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.width = 335,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: cardColor, // Adaptive background
      ),
      width: width,
      height: height,
      child: Center(
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.emailAddress,
          style: GoogleFonts.inter(
            color: textColor.withOpacity(0.8),
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.manrope(
              color: textColor.withOpacity(0.4),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final double width;
  final double height;
  final int maxLength;

  const PasswordTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.width = 335,
    this.height = 48,
    this.maxLength = 20,
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Container(
      width: widget.width,
      height: widget.height,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: cardColor,
      ),
      child: TextFormField(
        controller: widget.controller,
        obscureText: _obscure,
        maxLength: widget.maxLength,
        style: TextStyle(
          color: textColor,
          fontSize: 14,
        ),
        inputFormatters: [
          LengthLimitingTextInputFormatter(widget.maxLength),
        ],
        decoration: InputDecoration(
          counterText: "",
          hintText: widget.hintText,
          hintStyle: GoogleFonts.manrope(
            color: textColor.withOpacity(0.4),
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 20,
            vertical: 14,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscure
                  ? Icons.visibility_outlined
                  : Icons.visibility_off_outlined,
              color: textColor.withOpacity(0.4),
              size: 20,
            ),
            onPressed: () {
              setState(() {
                _obscure = !_obscure;
              });
            },
          ),
        ),
      ),
    );
  }
}

class RoundTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final double width;
  final double height;

  const RoundTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.width = 335,
    this.height = 45,
  });

  @override
  Widget build(BuildContext context) {
    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(100),
        color: cardColor,
      ),
      width: width,
      height: height,
      child: Center(
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.text, // Generalized for round text field
          style: GoogleFonts.inter(
            color: textColor,
            fontWeight: FontWeight.w400,
            fontSize: 13,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 14,
            ),
            hintText: hintText,
            hintStyle: GoogleFonts.manrope(
              color: textColor.withOpacity(0.4),
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
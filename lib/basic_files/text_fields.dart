import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final double width;
  final double height;
  final String? errorText; // Naya parameter add kiya

  const EmailTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.width = 335,
    this.height = 45,
    this.errorText, // Constructor mein add kiya
  });

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    final double scaleW = w;
    final double scaleH = h * 0.0014;

    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: cardColor,
            // Error border logic

            border: errorText != null
                ? Border.all(color: Colors.red.shade400, width: 1.2)
                : null,
          ),
          width: width * scaleW,
          height: height * scaleH,
          child: Center(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.emailAddress,
              style: GoogleFonts.inter(
                color: textColor.withOpacity(0.8),
                fontWeight: FontWeight.w400,
                fontSize: h * 0.016,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: w * 0.053,
                  vertical: h * 0.017,
                ),
                hintText: hintText,
                hintStyle: GoogleFonts.manrope(
                  color: textColor.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                  fontSize: h * 0.0148,
                ),
              ),
            ),
          ),
        ),
        // Error Message UI
        if (errorText != null) ...[
          SizedBox(height: h * 0.005),
          Padding(
            padding: EdgeInsets.only(left: w * 0.04),
            child: Text(
              errorText!,
              style: GoogleFonts.inter(
                color: Colors.red.shade400,
                fontSize: h * 0.0135,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class PasswordTextField extends StatefulWidget {
  final String hintText;
  final TextEditingController? controller;
  final double width;
  final double height;
  final int maxLength;
  final String? errorText; // Naya parameter

  const PasswordTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.width = 335,
    this.height = 48,
    this.maxLength = 20,
    this.errorText, // Constructor mein add kiya
  });

  @override
  State<PasswordTextField> createState() => _PasswordTextFieldState();
}

class _PasswordTextFieldState extends State<PasswordTextField> {
  bool _obscure = true;

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    final double scaleW = w;
    final double scaleH = h * 0.0013;

    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: widget.width * scaleW,
          height: widget.height * scaleH,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: cardColor,
            // Error border logic
            border: widget.errorText != null
                ? Border.all(color: Colors.red.shade400, width: 1.2)
                : null,
          ),
          child: TextFormField(
            controller: widget.controller,
            obscureText: _obscure,
            maxLength: widget.maxLength,
            style: TextStyle(
              color: textColor,
              fontSize: h * 0.0172,
            ),
            inputFormatters: [
              LengthLimitingTextInputFormatter(widget.maxLength),
            ],
            decoration: InputDecoration(
              counterText: "",
              hintText: widget.hintText,
              hintStyle: GoogleFonts.manrope(
                color: textColor.withOpacity(0.4),
                fontSize: h * 0.016,
                fontWeight: FontWeight.w400,
              ),
              border: InputBorder.none,
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(
                horizontal: w * 0.053,
                vertical: h * 0.017,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscure
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                  color: textColor.withOpacity(0.4),
                  size: h * 0.0246,
                ),
                onPressed: () {
                  setState(() {
                    _obscure = !_obscure;
                  });
                },
              ),
            ),
          ),
        ),
        // Error Message UI
        if (widget.errorText != null) ...[
          SizedBox(height: h * 0.005),
          Padding(
            padding: EdgeInsets.only(left: w * 0.04),
            child: Text(
              widget.errorText!,
              style: GoogleFonts.inter(
                color: Colors.red.shade400,
                fontSize: h * 0.0135,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

class RoundTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController? controller;
  final double width;
  final double height;
  final String? errorText; // Naya parameter

  const RoundTextField({
    super.key,
    required this.hintText,
    this.controller,
    this.width = 335,
    this.height = 45,
    this.errorText, // Constructor mein add kiya
  });

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;

    final double scaleW = w ;
    final double scaleH = h * 0.0014;

    final Color cardColor = Theme.of(context).cardColor;
    final Color textColor = Theme.of(context).canvasColor;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            color: cardColor,
            // Error border logic
            border: errorText != null
                ? Border.all(color: Colors.red.shade400, width: 1.2)
                : null,
          ),
          width: width * scaleW,
          height: height * scaleH,
          child: Center(
            child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.text,
              style: GoogleFonts.inter(
                color: textColor,
                fontWeight: FontWeight.w400,
                fontSize: h * 0.016,
              ),
              decoration: InputDecoration(
                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: w * 0.053,
                  vertical: h * 0.017,
                ),
                hintText: hintText,
                hintStyle: GoogleFonts.manrope(
                  color: textColor.withOpacity(0.4),
                  fontWeight: FontWeight.w400,
                  fontSize: h * 0.0148,
                ),
              ),
            ),
          ),
        ),
        // Error Message UI
        if (errorText != null) ...[
          SizedBox(height: h * 0.005),
          Padding(
            padding: EdgeInsets.only(left: w * 0.04),
            child: Text(
              errorText!,
              style: GoogleFonts.inter(
                color: Colors.red.shade400,
                fontSize: h * 0.0135,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ],
    );
  }
}
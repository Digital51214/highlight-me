import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

class RoundButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;
  final bool isLoading;
  final bool showArrow;

  const RoundButton({
    super.key,
    required this.text,
    required this.onTap,
    this.isLoading = false,  // default: loader nahi
    this.showArrow = true,   // default: arrow dikhega (SignUp/Login)
  });

  @override
  Widget build(BuildContext context) {
    // --- MEDIA QUERY VARIABLES ---
    final screenWidth  = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final Color primaryColor = Theme.of(context).primaryColor;

    return GestureDetector(
      // ✅ Loading ho to tap disable
      onTap: isLoading ? null : onTap,
      child: Container(
        width:  screenWidth,
        height: screenHeight * 0.074, // Already responsive
        decoration: BoxDecoration(
          color:        primaryColor,
          borderRadius: BorderRadius.circular(screenWidth * 0.1),
          boxShadow: const [
            BoxShadow(
              color:      Color(0xFF4F98A7),
              blurRadius: 5,
            ),
          ],
        ),
        child: Center(
          child: isLoading
              ? SpinKitCircle(
            color: Colors.white,
            size:  screenHeight * 0.042, // Already responsive
          )
              : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                text,
                style: GoogleFonts.inter(
                  fontSize: screenHeight * 0.023,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
              if (showArrow) ...[
                SizedBox(width: screenWidth * 0.016),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  size:  screenHeight * 0.023,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
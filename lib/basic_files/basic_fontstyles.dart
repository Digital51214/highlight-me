// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// class MainTextStyles {
//   static TextStyle inter({
//     double fontSize = 12,
//     FontWeight fontWeight = FontWeight.w500,
//     bool italic = true,
//     Color color = Colors.white,
//   }) {
//     return GoogleFonts.inter(
//       fontSize: fontSize,
//       fontWeight: fontWeight,
//       fontStyle: italic ? FontStyle.normal : FontStyle.italic,
//       color: color,
//       letterSpacing: 0,
//     );
//   }
//
//
//   }
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

class MainTextStyles {
  static TextStyle inter({
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w500,
    bool italic = true,
    Color? color, // Default hataya taake niche logic apply ho sake
  }) {
    return GoogleFonts.inter(
      fontSize: fontSize,
      fontWeight: fontWeight,
      fontStyle: italic ? FontStyle.normal : FontStyle.italic,
      // Agar color nahi diya gaya toh theme ke mutabiq canvasColor uthayega
      color: color ?? Theme.of(Get.context!).canvasColor,
      letterSpacing: 0,
    );
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_spinkit/flutter_spinkit.dart';
//
// class CustomLoader extends StatelessWidget {
//   final double size;
//   final Color color;
//
//   const CustomLoader({
//     super.key,
//     this.size = 50.0,
//     this.color = Colors.white,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SpinKitCircle(
//         color: color,
//         size: size,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CustomLoader extends StatelessWidget {
  final double? size; // Made nullable to detect default override
  final Color color;

  const CustomLoader({
    super.key,
    this.size,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

    // If a custom size is passed, we scale it, else default to 50 dynamically scaled
    double evaluatedSize = size != null
        ? w * (size! / 375)
        : w * (50.0 / 375);

    return Center(
      child: SpinKitCircle(
        color: color,
        size: evaluatedSize,
      ),
    );
  }
}
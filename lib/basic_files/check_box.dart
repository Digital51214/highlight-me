// import 'package:flutter/material.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
//
// class CircularCheckbox extends StatefulWidget {
//   final bool initialValue;
//   final ValueChanged<bool> onChanged;
//
//   const CircularCheckbox({
//     super.key,
//     this.initialValue = false,
//     required this.onChanged,
//   });
//
//   @override
//   State<CircularCheckbox> createState() => _CircularCheckboxState();
// }
//
// class _CircularCheckboxState extends State<CircularCheckbox> {
//   late bool isChecked;
//
//   @override
//   void initState() {
//     super.initState();
//     isChecked = widget.initialValue;
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return GestureDetector(
//     //   onTap: () {
//     //     setState(() {
//     //       isChecked = !isChecked; // toggle true/false
//     //     });
//     //     widget.onChanged(isChecked); // callback
//     //   },
//     //   child: Container(
//     //     width: 18,
//     //     height: 18,
//     //     decoration: BoxDecoration(
//     //       color: isChecked ?  Color(0xFF232323) : Color(0xFF232323), // fill color
//     //       shape: BoxShape.circle,
//     //
//     //
//     //     ),
//     //     child: isChecked
//     //         ? const Icon(Icons.check, color: AppColors.lightblue, size: 16)
//     //         : null,
//     //   ),
//     // );
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           isChecked = !isChecked; // toggle
//         });
//         widget.onChanged(isChecked);
//       },
//       child: Container(
//         width: 18,
//         height: 18,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//
//           // 🔥 background color change on select
//           color: isChecked
//               ? AppColors.lightblue
//               : const Color(0xFF232323),
//
//           // 🔥 border
//           border: Border.all(
//             color: AppColors.grey1,
//             width: 1,
//           ),
//         ),
//
//         child: isChecked
//             ? const Icon(
//           Icons.check,
//           color: Colors.white, // ✔ icon white
//           size: 14,
//         )
//             : null,
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';

class CircularCheckbox extends StatefulWidget {
  final bool initialValue;
  final ValueChanged<bool> onChanged;

  const CircularCheckbox({
    super.key,
    this.initialValue = false,
    required this.onChanged,
  });

  @override
  State<CircularCheckbox> createState() => _CircularCheckboxState();
}

class _CircularCheckboxState extends State<CircularCheckbox> {
  late bool isChecked;

  @override
  void initState() {
    super.initState();
    isChecked = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color unselectedBg = Theme.of(context).cardColor;
    final Color borderColor = Theme.of(context).dividerColor.withOpacity(0.5);

    return GestureDetector(
      onTap: () {
        setState(() {
          isChecked = !isChecked;
        });
        widget.onChanged(isChecked);
      },
      child: Container(
        width: 18,
        height: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          // Background color theme ke mutabiq
          color: isChecked
              ? primaryColor
              : unselectedBg,

          border: Border.all(
            color: isChecked ? primaryColor : borderColor,
            width: 1,
          ),
        ),
        child: isChecked
            ? const Icon(
          Icons.check,
          color: Colors.white,
          size: 14,
        )
            : null,
      ),
    );
  }
}
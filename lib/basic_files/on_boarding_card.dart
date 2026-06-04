import 'package:flutter/material.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';

class PageIndicator extends StatelessWidget {
  final int itemCount;
  final int currentIndex;
  final Color activeColor;
  final Color inactiveColor;

  const PageIndicator({
    super.key,
    required this.itemCount,
    required this.currentIndex,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(itemCount, (index) {
        final isActive = currentIndex == index;

        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 2),
          height: 6,
          width: isActive ? 61 : 33,
          decoration: BoxDecoration(
            color: isActive ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(10),
          ),
        );
      }),
    );
  }
}

class ReusableCard extends StatefulWidget {

  final String title;
  final String subtitle;

  final String text1;
  final String text2;
  final String text3;

  final Color color1;
  final Color color2;
  final Color color3;

  final List<Widget> pages; // only used for length (no PageView)
  final String buttonText;
  final VoidCallback onButtonPressed;

  const ReusableCard({
    super.key,
    required this.title,

    required this.subtitle,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.color1,
    required this.color2,
    required this.color3,
    required this.pages,
    required this.buttonText,
    required this.onButtonPressed,
  });

  @override
  State<ReusableCard> createState() => _ReusableCardState();
}

class _ReusableCardState extends State<ReusableCard> {

  int currentIndex = 0;

  void changeIndex(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 437,
      width: 332,
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        color: Colors.black.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(70),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 10),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          /// Title
          Text(
            widget.title,
            style: MainTextStyles.inter(
              fontSize: 12,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          /// Subtitle
          Text(
            widget.subtitle,
            style: MainTextStyles.inter(
              fontSize: 26,
              fontWeight: FontWeight.w700,
            ),
          ),

          const SizedBox(height: 20),

          /// Rich Text
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: widget.text1,
                  style: MainTextStyles.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: widget.text2,
                  style: MainTextStyles.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                TextSpan(
                  text: widget.text3,
                  style: MainTextStyles.inter(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 25),
          PageIndicator(
            itemCount: widget.pages.length,
            currentIndex: currentIndex,
            activeColor: AppColors.lightblue,
            inactiveColor: Colors.white,
          ),

          const SizedBox(height: 25),


        ],
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/widgets/Backbutton.dart';

class TermsandConditionscreen extends StatefulWidget {
  const TermsandConditionscreen({super.key});

  @override
  State<TermsandConditionscreen> createState() =>
      _TermsandConditionscreenState();
}

class _TermsandConditionscreenState extends State<TermsandConditionscreen> {
  bool isAccepted = false;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color bgColor = Theme.of(context).scaffoldBackgroundColor;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: w * (20.625 / 375), // 0.055 scaled ratio
                  vertical: h * (9.72 / 810),    // 0.012 scaled ratio
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: h * (8.1 / 810)),

                    const CustomBackButtonWidget(),

                    SizedBox(height: h * (28.35 / 810)),

                    Text(
                      "Terms & Conditions",
                      style: TextStyle(
                        color: textColor,
                        fontSize: w * (24.375 / 375), // Mapped from size.width * 0.065
                        fontWeight: FontWeight.w800,
                        height: 1.1,
                      ),
                    ),

                    SizedBox(height: h * (5.67 / 810)),

                    Text(
                      "Understand the rules for using our platform",
                      style: TextStyle(
                        color: textColor.withOpacity(0.6),
                        fontSize: w * (13.5 / 375), // Mapped from size.width * 0.036
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: h * (28.35 / 810)),

                    _buildBodyText(
                      w: w,
                      textColor: textColor,
                      text:
                      "By accessing or using this application, you agree to comply with and be bound by these Terms & Conditions. If you do not agree, please refrain from using the service.",
                    ),

                    SizedBox(height: h * (20.25 / 810)),

                    _buildBodyText(
                      w: w,
                      textColor: textColor,
                      text:
                      "This platform allows users to share personal moments through photos and videos within a defined posting window. Content may only be uploaded between Monday 12:00 AM and Thursday 11:59 PM.\nAfter this period, all submitted content becomes automatically restricted and no longer publicly accessible.",
                    ),

                    SizedBox(height: h * (20.25 / 810)),

                    _buildBodyText(
                      w: w,
                      textColor: textColor,
                      text:
                      "You retain ownership of all content you upload. However, by posting, you grant the platform a limited license to host, display, and process your content solely for providing the service.",
                    ),

                    SizedBox(height: h * (28.35 / 810)),

                    _buildSectionTitle(
                      w: w,
                      textColor: textColor,
                      title: "Account & Security",
                    ),

                    SizedBox(height: h * (8.1 / 810)),

                    _buildBodyText(
                      w: w,
                      textColor: textColor,
                      text:
                      "Users are responsible for maintaining the confidentiality of their account credentials and for all activities that occur under their account.",
                    ),

                    SizedBox(height: h * (24.3 / 810)),

                    _buildSectionTitle(
                      w: w,
                      textColor: textColor,
                      title: "Restrictions & Enforcement",
                    ),

                    SizedBox(height: h * (8.1 / 810)),

                    _buildBodyText(
                      w: w,
                      textColor: textColor,
                      text: "We reserve the right to:",
                    ),

                    SizedBox(height: h * (5.67 / 810)),

                    _buildBulletText(
                      w: w,
                      h: h,
                      textColor: textColor,
                      text: "Remove content that violates these terms",
                    ),
                    _buildBulletText(
                      w: w,
                      h: h,
                      textColor: textColor,
                      text: "Restrict or suspend accounts involved in misuse",
                    ),
                    _buildBulletText(
                      w: w,
                      h: h,
                      textColor: textColor,
                      text: "Take necessary action to maintain a safe environment",
                    ),

                    SizedBox(height: h * (24.3 / 810)),

                    _buildAgreementRow(w, h, textColor, primaryColor),

                    SizedBox(height: h * (24.3 / 810)),
                  ],
                ),
              ),
            ),

            /// Fixed Bottom Button Area
            Container(
              width: double.infinity,
              color: bgColor,
              padding: EdgeInsets.only(
                left: w * (20.625 / 375),
                right: w * (20.625 / 375),
                top: h * (8.1 / 810),
                bottom: h * (20.25 / 810),
              ),
              child: _buildAcceptButton(w, h, primaryColor),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle({
    required double w,
    required String title,
    required Color textColor,
  }) {
    return Text(
      title,
      style: TextStyle(
        color: textColor,
        fontSize: w * (15.75 / 375), // Mapped from size.width * 0.042
        fontWeight: FontWeight.w500,
        height: 1.2,
      ),
    );
  }

  Widget _buildBodyText({
    required double w,
    required String text,
    required Color textColor,
  }) {
    return Text(
      text,
      style: TextStyle(
        color: textColor.withOpacity(0.5),
        fontSize: w * (12.1875 / 375), // Mapped from size.width * 0.0325
        fontWeight: FontWeight.w400,
        height: 1.2,
      ),
    );
  }

  Widget _buildBulletText({
    required double w,
    required double h,
    required String text,
    required Color textColor,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: h * (0.81 / 810),
            right: w * (9.375 / 375),
          ),
          child: Text(
            "•",
            style: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: w * (18.75 / 375), // Mapped from size.width * 0.05
              fontWeight: FontWeight.w400,
              height: 1,
            ),
          ),
        ),
        Expanded(
          child: Text(
            text,
            style: TextStyle(
              color: textColor.withOpacity(0.5),
              fontSize: w * (12.1875 / 375),
              fontWeight: FontWeight.w400,
              height: 1.15,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAgreementRow(double w, double h, Color textColor, Color primaryColor) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              isAccepted = !isAccepted;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 180),
            height: w * (22.5 / 375), // Mapped from size.width * 0.06
            width: w * (22.5 / 375),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isAccepted ? primaryColor : Colors.transparent,
              border: Border.all(
                color: isAccepted ? primaryColor : textColor.withOpacity(0.38),
                width: w * (1.125 / 375), // Mapped from size.width * 0.003
              ),
            ),
            child: isAccepted
                ? Icon(
              Icons.check,
              color: Colors.white,
              size: w * (15.0 / 375), // Mapped from size.width * 0.04
            )
                : null,
          ),
        ),
        SizedBox(width: w * (9.375 / 375)),
        Expanded(
          child: Padding(
            padding: EdgeInsets.only(top: h * (1.62 / 810)),
            child: RichText(
              text: TextSpan(
                style: TextStyle(
                  color: textColor.withOpacity(0.54),
                  fontSize: w * (10.875 / 375), // Mapped from size.width * 0.029
                  fontWeight: FontWeight.w400,
                  height: 1.4,
                ),
                children: [
                  const TextSpan(text: "I agree with all "),
                  TextSpan(
                    text: "Terms & Conditions",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const TextSpan(text: " and "),
                  TextSpan(
                    text: "Privacy Policy",
                    style: TextStyle(
                      color: primaryColor,
                      decoration: TextDecoration.underline,
                      decorationColor: primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildAcceptButton(double w, double h, Color primaryColor) {
    return GestureDetector(
      onTap: isAccepted ? () => Get.back() : null,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        width: double.infinity,
        height: h * (46.98 / 810), // Evaluated from size.height * 0.058
        decoration: BoxDecoration(
          color: isAccepted ? primaryColor : primaryColor.withOpacity(0.35),
          borderRadius: BorderRadius.circular(w * (33.75 / 375)), // Evaluated from size.width * 0.09
          boxShadow: isAccepted
              ? [
            BoxShadow(
              color: primaryColor.withOpacity(0.35),
              blurRadius: w * (15.0 / 375),
              spreadRadius: 1,
            ),
          ]
              : [],
        ),
        child: Center(
          child: Text(
            "Accept & Continue",
            style: TextStyle(
              color: Colors.white,
              fontSize: w * (18.75 / 375), // Mapped from size.width * 0.05
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}
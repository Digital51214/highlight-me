import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Services/time_services.dart';

class PostingWindowScreen extends StatefulWidget {
  const PostingWindowScreen({super.key});

  @override
  State<PostingWindowScreen> createState() => _PostingWindowScreenState();
}

class _PostingWindowScreenState extends State<PostingWindowScreen> {
  Timer? _timer;
  Duration _timeLeft = TimeService.getTimeRemaining();

  @override
  void initState() {
    super.initState();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          _timeLeft = TimeService.getTimeRemaining();
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardColor = Theme.of(context).cardColor;

    String days = _timeLeft.inDays.toString().padLeft(2, '0');
    String hours = _timeLeft.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes = _timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = _timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: w * (20.0 / 375)),
          child: Column(
            children: [
              // Back Button
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: EdgeInsets.only(top: h * (20.0 / 810)),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Theme.of(context).brightness == Brightness.dark
                        ? Image.asset('assets/images/icon.arrow.png', height: w * (48.0 / 375), width: w * (48.0 / 375))
                        : Container(
                      height: w * (45.0 / 375),
                      width: w * (45.0 / 375),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withOpacity(0.15),
                        border: Border.all(color: primaryColor.withOpacity(0.3), width: w * (1.0 / 375)),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, color: textColor, size: w * (22.0 / 375)),
                    ),
                  ),
                ),
              ),
              const Spacer(),

              // Central Card
              Container(
                padding: EdgeInsets.all(w * (30.0 / 375)),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(w * (40.0 / 375)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: w * (20.0 / 375),
                        spreadRadius: w * (5.0 / 375)
                    )
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: w * (60.0 / 375), color: primaryColor),
                    SizedBox(height: h * (16.2 / 810)),
                    Text(
                      'Posting Window Is\nClosed.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(fontSize: w * (26.0 / 375), fontWeight: FontWeight.w900, color: textColor),
                    ),
                    Text(
                      'See you on Friday!',
                      style: GoogleFonts.inter(fontSize: w * (22.0 / 375), color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: h * (16.2 / 810)),
                    Text(
                      'Weekend Moments are locked during the week to keep the excitement for the weekend.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(color: textColor.withOpacity(0.5), fontSize: w * (13.0 / 375)),
                    ),
                    SizedBox(height: h * (24.3 / 810)),

                    // Countdown Timer
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CountdownUnit(value: days, label: 'Days', color: textColor, w: w, h: h),
                        CountdownUnit(value: hours, label: 'Hours', color: textColor, w: w, h: h),
                        CountdownUnit(value: minutes, label: 'Minutes', color: textColor, w: w, h: h),
                        CountdownUnit(value: seconds, label: 'Seconds', color: textColor, w: w, h: h),
                      ],
                    ),
                    SizedBox(height: h * (32.4 / 810)),

                    // Action Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar("Success", "We'll notify you on Friday!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: primaryColor,
                            colorText: Colors.white);
                      },
                      icon: Icon(Icons.notifications_active, color: Colors.white, size: w * (20.0 / 375)),
                      label: Text('Notify Me When It Opens', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold, fontSize: w * (14.0 / 375))),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: Size(double.infinity, h * (55.0 / 810)),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(w * (30.0 / 375))),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),

              // Social Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('👥 ', style: TextStyle(fontSize: w * (18.0 / 375))),
                  Text(
                    '+12k People are waiting for the drop',
                    style: GoogleFonts.inter(color: textColor.withOpacity(0.4), fontSize: w * (12.0 / 375)),
                  ),
                ],
              ),
              SizedBox(height: h * (16.2 / 810)),
            ],
          ),
        ),
      ),
    );
  }
}

class CountdownUnit extends StatelessWidget {
  final String value, label;
  final Color color;
  final double w;
  final double h;

  const CountdownUnit({
    super.key,
    required this.value,
    required this.label,
    required this.color,
    required this.w,
    required this.h,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(w * (10.0 / 375)),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.1), width: w * (1.0 / 375)),
          ),
          child: Text(
            value,
            style: GoogleFonts.inter(fontSize: w * (24.0 / 375), fontWeight: FontWeight.w900, color: color),
          ),
        ),
        SizedBox(height: h * (4.05 / 810)),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: w * (10.0 / 375), fontWeight: FontWeight.w500, color: color.withOpacity(0.5)),
        ),
      ],
    );
  }
}
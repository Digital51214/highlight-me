import 'dart:async'; // Timer ke liye zaroori ha
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
    // Har second UI update karne ke liye timer
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
    _timer?.cancel(); // Memory leak se bachne ke liye timer cancel
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardColor = Theme.of(context).cardColor;

    // Time calculations
    String days = _timeLeft.inDays.toString().padLeft(2, '0');
    String hours = _timeLeft.inHours.remainder(24).toString().padLeft(2, '0');
    String minutes = _timeLeft.inMinutes.remainder(60).toString().padLeft(2, '0');
    String seconds = _timeLeft.inSeconds.remainder(60).toString().padLeft(2, '0');

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            children: [
              // Back Button (Original Logic)
              Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: GestureDetector(
                    onTap: () => Get.back(),
                    child: Theme.of(context).brightness == Brightness.dark
                        ? Image.asset('assets/images/icon.arrow.png', height: 48, width: 48)
                        : Container(
                      height: 48,
                      width: 48,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: primaryColor.withOpacity(0.15),
                        border: Border.all(color: primaryColor.withOpacity(0.3)),
                      ),
                      child: Icon(Icons.arrow_back_ios_new, color: textColor, size: 22),
                    ),
                  ),
                ),
              ),
              const Spacer(),

              // Central Card
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 20, spreadRadius: 5)
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.lock_outline, size: 60, color: primaryColor),
                    const SizedBox(height: 20),
                    Text(
                      'Posting Window Is\nClosed.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(fontSize: 26, fontWeight: FontWeight.w900, color: textColor),
                    ),
                    Text(
                      'See you on Friday!', // Requirement: Window Friday ko khulti ha
                      style: GoogleFonts.inter(fontSize: 22, color: primaryColor, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Weekend Moments are locked during the week to keep the excitement for the weekend.',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(color: textColor.withOpacity(0.5), fontSize: 13),
                    ),
                    const SizedBox(height: 30),

                    // Countdown Timer (Now Functional)
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        CountdownUnit(value: days, label: 'Days', color: textColor),
                        CountdownUnit(value: hours, label: 'Hours', color: textColor),
                        CountdownUnit(value: minutes, label: 'Minutes', color: textColor),
                        CountdownUnit(value: seconds, label: 'Seconds', color: textColor),
                      ],
                    ),
                    const SizedBox(height: 40),

                    // Action Button
                    ElevatedButton.icon(
                      onPressed: () {
                        Get.snackbar("Success", "We'll notify you on Friday!",
                            snackPosition: SnackPosition.BOTTOM,
                            backgroundColor: primaryColor,
                            colorText: Colors.white);
                      },
                      icon: const Icon(Icons.notifications_active, color: Colors.white),
                      label: Text('Notify Me When It Opens', style: GoogleFonts.inter(color: Colors.white, fontWeight: FontWeight.bold)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        minimumSize: const Size(double.infinity, 55),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
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
                  const Text('👥 ', style: TextStyle(fontSize: 18)),
                  Text(
                    '+12k People are waiting for the drop',
                    style: GoogleFonts.inter(color: textColor.withOpacity(0.4), fontSize: 12),
                  ),
                ],
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// CountdownUnit remains the same (Stateless)
class CountdownUnit extends StatelessWidget {
  final String value, label;
  final Color color;
  const CountdownUnit({super.key, required this.value, required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Aapki UI ke mutabiq Circular design ke liye hum yahan border add kar sakte hain
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(color: color.withOpacity(0.1), width: 1),
          ),
          child: Text(
            value,
            style: GoogleFonts.inter(fontSize: 24, fontWeight: FontWeight.w900, color: color),
          ),
        ),
        const SizedBox(height: 5),
        Text(
          label,
          style: GoogleFonts.inter(fontSize: 10, fontWeight: FontWeight.w500, color: color.withOpacity(0.5)),
        ),
      ],
    );
  }
}
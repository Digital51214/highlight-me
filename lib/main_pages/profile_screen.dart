import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/main_pages/memories_screen.dart';
import 'package:highlights/presentation_screen/AccountSettingScreen.dart';
import 'package:highlights/presentation_screen/SettingScreen.dart';

import '../core/theme_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  final List<String> postImages = const [
    'assets/images/pr1.png',
    'assets/images/pr2.png',
    'assets/images/pr3.png',
    'assets/images/pr4.png',
    'assets/images/pr5.png',
    'assets/images/pr6.png',
  ];

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              /// TOP BAR
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.055,
                  vertical: h * 0.012,
                ),
                child: Row(
                  children: [
                    Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                      width: 120,
                      // Logo color adjustment for visibility if needed
                      color: Theme.of(context).brightness == Brightness.light ? Colors.black : null,
                    ),
                    const Spacer(),
                    // Header section ke andar Row ka notification wala hissa:

                    Theme.of(context).brightness == Brightness.dark
                        ? /* --- DARK THEME: Aapki Original Image --- */
                    GestureDetector(
                      onTap: () {
                        Get.to(Settingscreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        );
                      },
                      child: Image.asset(
                        'assets/images/icon.setting.png',
                        height: 48,
                        width: 48,
                        // Yahan koi color tint nahi hai, original image dikhegi
                      ),
                    )
                        : /* --- LIGHT THEME: Custom Circle Button Style --- */
                    GestureDetector(
                      onTap: () {
                        Get.to(Settingscreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        );
                      },
                      child: Container(
                        height: w * 0.12,
                        width: w * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor.withOpacity(0.15),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            width: w * 0.0025,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.settings, // Notification Icon
                            color: Theme.of(context).canvasColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              /// PROFILE
              Column(
                children: [
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: 55,
                        backgroundColor: primaryColor.withOpacity(0.5), // Adaptive border
                        child: const CircleAvatar(
                          radius: 52,
                          backgroundImage: AssetImage('assets/images/h0.png'),
                        ),
                      ),
                      Positioned(
                          bottom: 5,
                          right: 5,
                          child: Image.asset('assets/images/check.png', height: 30, width: 30))
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    "Lexa_Bravo",
                    style: GoogleFonts.inter(
                        color: textColor, // Dynamic Text
                        fontSize: 16,
                        fontWeight: FontWeight.w700),
                  ),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: Text(
                      "Capturing the neon pulse of the city one\nweekend at a time. Digital Nomad & Visual Artist.",
                      textAlign: TextAlign.center,
                      style: GoogleFonts.inter(
                          fontWeight: FontWeight.w400,
                          color: textColor.withOpacity(0.6),
                          fontSize: 14),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// STATS
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _StatItem(val: "12.4k", label: "Likes", textColor: textColor, primaryColor: primaryColor),
                  _StatItem(val: "842", label: "Comments", textColor: textColor, primaryColor: primaryColor),
                  _StatItem(val: "1.4k", label: "Shares", textColor: textColor, primaryColor: primaryColor),
                  _StatItem(val: "98", label: "Rank", isRank: true, textColor: textColor, primaryColor: primaryColor),
                ],
              ),

              const SizedBox(height: 25),

              /// SUPPORT CARDS
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 73,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      _SupportCard(
                        icon: Icons.restaurant,
                        title: "Food Support",
                        sub: "2 vouchers",
                        cardColor: cardBgColor,
                        textColor: textColor,
                        primaryColor: primaryColor,
                      ),
                      _SupportCard(
                        icon: Icons.directions_bus,
                        title: "Free Transport",
                        sub: "12 days",
                        cardColor: cardBgColor,
                        textColor: textColor,
                        primaryColor: primaryColor,
                      ),
                      _SupportCard(
                        icon: Icons.card_giftcard,
                        title: "Cash Reward",
                        sub: "Monthly bonuses",
                        cardColor: cardBgColor,
                        textColor: textColor,
                        primaryColor: primaryColor,
                      ),
                      _SupportCard(
                        icon: Icons.school,
                        title: "Scholarship",
                        sub: "Yearly bonuses",
                        cardColor: cardBgColor,
                        textColor: textColor,
                        primaryColor: primaryColor,
                      ),
                      _SupportCard(
                        icon: Icons.medical_services,
                        title: "Medical",
                        sub: "emergency case",
                        cardColor: cardBgColor,
                        textColor: textColor,
                        primaryColor: primaryColor,
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 25),

              /// HEADER
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    Icon(Icons.add, color: primaryColor, size: 20),
                    const SizedBox(width: 10),
                    Text("Post Analytics",
                        style: GoogleFonts.inter(
                            color: textColor,
                            fontSize: 18,
                            fontWeight: FontWeight.bold)),
                    const Spacer(),
                    Text("Latest",
                        style: GoogleFonts.inter(
                            color: textColor.withOpacity(0.6), fontSize: 12)),
                    const SizedBox(width: 15),
                    GestureDetector(
                      onTap: () {
                        Get.to(YourMemoriesScreen(),
                            transition: Transition.noTransition,
                            duration: Duration.zero);
                      },
                      child: Text("Archived Posts",
                          style: GoogleFonts.inter(
                              color: primaryColor, fontSize: 12)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              /// GRID
              GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.4,
                ),
                itemCount: postImages.length,
                itemBuilder: (context, index) => _PostItem(
                  imagePath: postImages[index],
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatItem extends StatelessWidget {
  final String val, label;
  final bool isRank;
  final Color textColor;
  final Color primaryColor;

  const _StatItem(
      {required this.val,
        required this.label,
        required this.textColor,
        required this.primaryColor,
        this.isRank = false});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Text(val,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400, color: textColor, fontSize: 16)),
            if (isRank) Icon(Icons.bolt, color: primaryColor, size: 11),
          ],
        ),
        Text(label,
            style: GoogleFonts.inter(
                fontWeight: FontWeight.w400, color: AppColors.grey1, fontSize: 11)),
      ],
    );
  }
}

class _SupportCard extends StatelessWidget {
  final IconData icon;
  final String title, sub;
  final Color cardColor;
  final Color textColor;
  final Color primaryColor;

  const _SupportCard(
      {required this.icon,
        required this.title,
        required this.sub,
        required this.cardColor,
        required this.textColor,
        required this.primaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 73,
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 5),
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        image: const DecorationImage(
          image: AssetImage('assets/images/box.png'),
          fit: BoxFit.cover,
          opacity: 0.1, // Adjusted opacity for theme compatibility
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: primaryColor, size: 14),
          const SizedBox(height: 6),
          Text(title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.inter(
                  color: textColor, fontSize: 10, fontWeight: FontWeight.w400)),
          const SizedBox(height: 2),
          Text(sub,
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                  color: AppColors.grey, fontSize: 6, fontWeight: FontWeight.w400)),
        ],
      ),
    );
  }
}

class _PostItem extends StatelessWidget {
  final String imagePath;

  const _PostItem({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.transparent,
              Colors.black.withOpacity(0.8), // Keep black for overlay visibility
            ],
          ),
        ),
        child: const Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Icon(Icons.visibility, color: Colors.white, size: 12),
                SizedBox(width: 4),
                Text("4.1k", style: TextStyle(color: Colors.white, fontSize: 10)),
                SizedBox(width: 8),
                Icon(Icons.favorite, color: Colors.white, size: 12),
                SizedBox(width: 4),
                Text("820", style: TextStyle(color: Colors.white, fontSize: 10)),
              ],
            )
          ],
        ),
      ),
    );
  }
}
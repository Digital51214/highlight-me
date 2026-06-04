import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:highlights/main_pages/chat_screen.dart';
import 'package:highlights/main_pages/explore_screen.dart';
import 'package:highlights/main_pages/home_screen.dart';
import 'package:highlights/main_pages/post_creation_screen.dart';
import 'package:highlights/main_pages/post_lock_screen.dart';
import 'package:highlights/main_pages/profile_screen.dart';

import '../Services/time_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    ExploreScreen(),
    const PostCreationScreen(),
    const ChatScreen(),
    const ProfileScreen(),
  ];

  final List<String> icons = [
    'assets/images/vv1.svg',
    'assets/images/vv2.svg',
    'assets/images/vv3.svg',
    'assets/images/v4.svg',
    'assets/images/v5.svg',
  ];

  @override
  Widget build(BuildContext context) {
    // Theme colors access
    final Color bgColor = Theme
        .of(context)
        .scaffoldBackgroundColor;
    final Color navBarColor = Theme
        .of(context)
        .cardColor;
    final Color iconDefaultColor = Theme
        .of(context)
        .canvasColor
        .withOpacity(0.5);

    return Scaffold(
      backgroundColor: bgColor,

      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),

      bottomNavigationBar: _buildBottomNavBar(navBarColor, iconDefaultColor),
    );
  }

  Widget _buildBottomNavBar(Color navBarColor, Color iconDefaultColor) {
    final size = MediaQuery
        .of(context)
        .size;

    return Container(
      height: 87,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: navBarColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(48),
          topRight: Radius.circular(48),
        ),
        // Subtle shadow for light mode visibility
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(icons.length, (index) {
          return _navItem(index, icons[index], iconDefaultColor);
        }),
      ),
    );
  }

  Widget _navItem(int index, String iconPath, Color iconDefaultColor) {
    bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
        // --- CLIENT REQUIREMENT LOGIC START ---
        // Index 2 hamara 'PostCreation' wala icon hai (Plus icon)
        if (index == 2) {
          if (!TimeService.isPostingWindowOpen()) {
            // Agar window band hai (Mon-Thu), toh PostLockScreen par bhejo
            Get.to(
                  () => PostingWindowScreen(),
              transition: Transition.fadeIn, // Smooth transition ke liye
            );
            return; // Function ko yahin rok dein taake screen switch na ho
          }
        }
        // --- CLIENT REQUIREMENT LOGIC END ---

        setState(() {
          _currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: 46,
        width: 46,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: isActive
              ? const LinearGradient(
            colors: [Color(0xFFB9A9CD), Color(0xFF4F98A7)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          )
              : null,
        ),
        child: Center(
          child: SvgPicture.asset(
            iconPath,
            height: 20,
            width: 20,
            colorFilter: ColorFilter.mode(
              isActive ? Colors.white : iconDefaultColor,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
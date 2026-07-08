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
import 'package:get/get.dart';
import '../Contollers/chat_controller.dart';
import '../Contollers/profile_controller.dart';
import '../Services/time_services.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  static const int _chatTabIndex = 3;

  @override
  void initState() {
    super.initState();
    ProfileController.getProfileStats();
  }

  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomeScreen(),
    ExploreScreen(),
    const PostCreationScreen(),
    const ChatListScreen(),
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
    // --- MEDIA QUERY VARIABLES ---
    final Size size = MediaQuery.of(context).size;
    final double h = size.height;
    final double w = size.width;

    return Container(
      height: h * 0.107, // Responsive Bottom Bar Height
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: w * 0.055), // Responsive Horizontal Padding
      decoration: BoxDecoration(
        color: navBarColor,
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
          return _navItem(index, icons[index], iconDefaultColor, h, w);
        }),
      ),
    );
  }

  Widget _navItem(int index, String iconPath, Color iconDefaultColor, double h, double w) {
    bool isActive = _currentIndex == index;

    return GestureDetector(
      onTap: () {
      // --- CLIENT REQUIREMENT LOGIC START ---
      // Index 2 hamara 'PostCreation' wala icon hai (Plus icon)
      // if (index == 2) {
      //   if (!TimeService.isPostingWindowOpen()) {
      //     // Agar window band hai (Mon-Thu), toh PostLockScreen par bhejo
      //     Get.to(
      //           () => PostingWindowScreen(),
      //       transition: Transition.fadeIn, // Smooth transition ke liye
      //     );
      //     return; // Function ko yahin rok dein taake screen switch na ho
      //   }
      // }
      // --- CLIENT REQUIREMENT LOGIC END ---
        if (index == _chatTabIndex && _currentIndex != _chatTabIndex) {
          Get.find<ChatController>().fetchMyConversations();
        }

      setState(() {
        _currentIndex = index;
      });
    },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        height: h * 0.06, // Responsive Item Height
        width: h * 0.06,  // Kept 1:1 ratio for perfect circle shape
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
            height: h * 0.028, // Responsive Svg Height
            width: h * 0.028,  // Responsive Svg Width
            colorFilter: ColorFilter.mode(
              isActive ? Colors.white : Colors.white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
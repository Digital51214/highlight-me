import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/basic_files/basic_fontstyles.dart';
import 'package:highlights/presentation_screen/NotificationScreen.dart';
import 'package:share_plus/share_plus.dart';

import '../Services/time_services.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Timer? _timer;
  String _displayTime = "Loading...";

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    if (mounted) {
      setState(() {
        _displayTime = TimeService.formatDuration(TimeService.getTimeRemaining());
      });
    }

    _timer = Timer.periodic(const Duration(seconds: 20), (timer) {
      if (mounted) {
        setState(() {
          _displayTime = TimeService.formatDuration(TimeService.getTimeRemaining());
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  double _calculateProgress() {
    final now = DateTime.now();
    // Total window duration (e.g., 3 days for posting, 4 days for lock)
    // Hum isay simple rakhne ke liye percentage nikalenge
    double progress = TimeService.getTimeRemaining().inSeconds / (3 * 24 * 3600);

    // Progress 0.0 se 1.0 ke darmiyan honi chahiye
    return (1.0 - progress).clamp(0.0, 1.0);
  }
  Set<int> selectedStories = {};
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    final List<String> images = [
      'assets/images/h1.png',
      'assets/images/h2.png',
      'assets/images/h3.png',
      'assets/images/h4.png',
      'assets/images/h1.png',
      'assets/images/h2.png',
      'assets/images/h3.png',
      'assets/images/h4.png',
    ];
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// HEADER
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: w * 0.055,
                  vertical: h * 0.012,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          child: Image.asset(
                            'assets/images/ht.png',
                            height: 48,
                            width: 48,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(width: 10),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Welcome Lexa Bravo!',
                              style: MainTextStyles.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                                color: Theme.of(context).canvasColor, // Changed to Theme
                              ),
                            ),
                            Text(
                              'Your moments are waiting',
                              style: MainTextStyles.inter(
                                fontSize: 9,
                                fontWeight: FontWeight.w400,
                                color: const Color(0xFFADAAAA), // Soft Grey
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    // Header section ke andar Row ka notification wala hissa:

                    Theme.of(context).brightness == Brightness.dark
                        ? /* --- DARK THEME: Aapki Original Image --- */
                    GestureDetector(
                      onTap: () {
                        Get.to(Notificationscreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        );
                      },
                      child: Image.asset(
                        'assets/images/icon.bell.png',
                        height: 48,
                        width: 48,
                      ),
                    )
                        :
                    GestureDetector(
                      onTap: () {
                        Get.to(Notificationscreen(),
                          transition: Transition.noTransition,
                          duration: Duration.zero,
                        );
                      },
                      child: Container(
                        height: w * 0.12,
                        width: w * 0.12,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                          border: Border.all(
                            color: Theme.of(context).primaryColor.withOpacity(0.3),
                            width: w * 0.0025,
                          ),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.notifications_none_rounded, // Notification Icon
                            color: Theme.of(context).canvasColor,
                            size: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),

              /// CARD
              Center(
                child: Container(
                  width: 335,
                  height: 127,
                  padding: EdgeInsets.symmetric(
                    horizontal: w * 0.06,
                    vertical: h * 0.015,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    color: Theme.of(context).cardColor, // Changed to Theme cardColor
                  ),
                  child: Column(
                    children: [
                      Text(
                        TimeService.isPostingWindowOpen()
                            ? 'POSTING WINDOW CLOSES IN:' : 'POSTING WINDOW OPENS IN:',
                        style: MainTextStyles.inter(
                          fontWeight: FontWeight.w300,
                          fontSize: 12,
                          color: const Color(0xFFADAAAA),
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        _displayTime, // <--- Ye change karein
                        style: MainTextStyles.inter(
                          fontWeight: FontWeight.w700,
                          fontSize: size.width * 0.07,
                          color: Theme.of(context).primaryColor, // Changed to Theme
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Purana Container replace karein:
                      Stack(
                        children: [
                          // Background Line (Empty state)
                          Container(
                            height: 5,
                            width: 245,
                            decoration: BoxDecoration(
                              color: Theme.of(context).canvasColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(100),
                            ),
                          ),
                          // Functional Fill Line
                          AnimatedContainer(
                            duration: const Duration(seconds: 1),
                            height: 5,
                            width: 245 * _calculateProgress(), // Ye width dynamic ho gayi
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Theme.of(context).primaryColor.withOpacity(0.5),
                                  Theme.of(context).primaryColor, // Timer wala color
                                ],
                              ),
                              borderRadius: BorderRadius.circular(100),
                              boxShadow: [
                                BoxShadow(
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                  blurRadius: 4,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Container(
                padding: EdgeInsets.symmetric(horizontal: w * 0.055),
                child: Text(
                  'Trending Now',
                  style: MainTextStyles.inter(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    color: Theme.of(context).canvasColor, // Changed to Theme
                  ),
                ),
              ),

              const SizedBox(height: 10),

              /// STORIES
              SizedBox(
                height: 90,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  itemCount: images.length,
                  itemBuilder: (context, index) {
                    final bool isSelected = selectedStories.contains(index);

                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedStories.add(index);
                          });
                        },
                        child: Stack(
                          children: [
                            Container(
                              width: 69,
                              height: 69,
                              padding: const EdgeInsets.all(1),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: isSelected
                                    ? Colors.grey
                                    : Theme.of(context).primaryColor, // Changed to Theme
                                border: Border.all(
                                  color: isSelected
                                      ? Colors.grey
                                      : Theme.of(context).primaryColor.withOpacity(0.5),
                                  width: 2,
                                ),
                              ),
                              child: CircleAvatar(
                                backgroundImage: AssetImage(images[index]),
                              ),
                            ),
                            if (index == 0)
                              Positioned(
                                right: 5,
                                bottom: 10,
                                child: Container(
                                  width: 22,
                                  height: 22,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Theme.of(context).canvasColor, // Changed to Theme
                                  ),
                                  child: Center(
                                    child: Icon(
                                      Icons.add,
                                      color: Theme.of(context).scaffoldBackgroundColor, // Inverted for visibility
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 10),

              /// REELS
              ReelsScreen(),
            ],
          ),
        ),
      ),
    );
  }
}

class ReelsScreen extends StatefulWidget {
  @override
  State<ReelsScreen> createState() => _ReelsScreenState();
}

class _ReelsScreenState extends State<ReelsScreen> {
  final List<Map<String, dynamic>> data = [
    {
      "image": "assets/images/bh1.png",
      "title": "The mist this morning was\nabsolutely unreal. Nature's own…",
      "tags": ["NATURE", "CINEMATIC"],
      "userImage": "assets/images/author.png",
      "time": "14 MINS AGO",
      "location": "BERLIN",
    },
    {
      "image": "assets/images/bh2.png",
      "title": "Weekened Vibes hit\ndifferent here.",
      "tags": ["ADVENTURE", "TRAVEL"],
      "userImage": "assets/images/author.png",
      "time": "2 HOURS AGO",
      "location": "PARIS",
    },
  ];

  List<bool> liked = [false, false];

  Future<void> _showCommentDialog(int index) async {
    final TextEditingController commentController = TextEditingController();

    await showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Theme.of(context).cardColor, // Changed
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Add Comment",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Theme.of(context).canvasColor, // Changed
                  ),
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: commentController,
                  maxLines: 4,
                  style: TextStyle(color: Theme.of(context).canvasColor),
                  decoration: InputDecoration(
                    hintText: "Write your comment...",
                    hintStyle: const TextStyle(color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    contentPadding: const EdgeInsets.all(12),
                  ),
                ),
                const SizedBox(height: 15),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).primaryColor,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text("Post", style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _sharePost(int index) async {
    await Share.share(
      "${data[index]["title"]}\nLocation: ${data[index]["location"]}",
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: data.length,
      itemBuilder: (context, index) {
        return Container(
          height: 379,
          width: 335,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(25),
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    data[index]["image"],
                    fit: BoxFit.cover,
                  ),
                ),

                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.5),
                          Colors.transparent,
                          Colors.black.withOpacity(0.9),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ),

                Positioned(
                  top: 20,
                  left: 12,
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 18,
                        backgroundImage: AssetImage(data[index]["userImage"]),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "${data[index]["time"]} • ${data[index]["location"]}",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  right: 10,
                  bottom: 80,
                  child: Column(
                    children: [
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              liked[index] = !liked[index];
                            });
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              liked[index]
                                  ? Icons.favorite
                                  : Icons.favorite_border,
                              color: liked[index] ? Colors.red : Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "1.2k",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _showCommentDialog(index);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.chat_bubble_outline,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "84",
                        style: TextStyle(color: Colors.white),
                      ),
                      const SizedBox(height: 20),

                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            _sharePost(index);
                          },
                          borderRadius: BorderRadius.circular(30),
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.share,
                              color: Colors.white,
                              size: 28,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                  bottom: 20,
                  left: 12,
                  right: 70,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        data[index]["title"],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Row(
                        children: List.generate(
                          data[index]["tags"].length,
                              (i) {
                            return Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.white),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                data[index]["tags"][i],
                                style: const TextStyle(color: Colors.white),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
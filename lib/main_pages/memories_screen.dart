//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
// import 'package:get/get.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:highlights/basic_files/basic_colors.dart';
// import 'package:highlights/main_pages/profile_screen.dart';
// import 'package:table_calendar/table_calendar.dart';
//
// class YourMemoriesScreen extends StatefulWidget {
//   const YourMemoriesScreen({super.key});
//
//   @override
//   State<YourMemoriesScreen> createState() => _YourMemoriesScreenState();
// }
//
// class MemoryModel {
//   final String tag;
//   final String date;
//   final String description;
//   final String image;
//
//   MemoryModel({
//     required this.tag,
//     required this.date,
//     required this.description,
//     required this.image,
//   });
// }
//
// class _YourMemoriesScreenState extends State<YourMemoriesScreen> {
//   int selectedIndex = 0;
//
//   final List<MemoryModel> memories = [
//     MemoryModel(
//       tag: "Weekend",
//       date: "Nov 03-05",
//       description: "The mist this morning was absolutely unreal.",
//       image: 'assets/images/m1.png',
//     ),
//     MemoryModel(
//       tag: "Morning",
//       date: "May 25-28",
//       description: "Beautiful coffee vibes.",
//       image: 'assets/images/m2.png',
//     ),
//     MemoryModel(
//       tag: "Reading",
//       date: "Dec 28-01",
//       description: "Late night reading session.",
//       image: 'assets/images/m3.png',
//     ),
//     MemoryModel(
//       tag: "Travel",
//       date: "Jan 10-12",
//       description: "Exploring new mountains.",
//       image: 'assets/images/m4.png',
//     ),
//     MemoryModel(
//       tag: "Chill",
//       date: "Feb 14-16",
//       description: "Relaxing with music.",
//       image: 'assets/images/m5.png',
//     ),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     double w = MediaQuery.of(context).size.width;
//     double h = MediaQuery.of(context).size.height;
//
//     // Theme references
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//
//     final List<Map<String, dynamic>> tabs = [
//       {"type": "text", "label": "2025"},
//       {"type": "text", "label": "November"},
//       {"type": "text", "label": "December"},
//       {"type": "icon", "icon": "assets/images/calender.svg"},
//     ];
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(
//               horizontal: w * 0.055,
//               vertical: h * 0.012,
//             ),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Theme.of(context).brightness == Brightness.dark
//                     ? /* --- DARK THEME: Aapki Original Image --- */
//                 GestureDetector(
//                   onTap: () {
//                     Get.back();
//                   },
//                   child: Image.asset(
//                     'assets/images/icon.arrow.png',
//                     height: 48,
//                     width: 48,
//                     // Yahan koi color tint nahi hai, original image dikhegi
//                   ),
//                 )
//                     : /* --- LIGHT THEME: Custom Circle Button Style --- */
//                 GestureDetector(
//                   onTap: () {
//                     Get.back(
//                     );
//                   },
//                   child: Container(
//                     height: w * 0.12,
//                     width: w * 0.12,
//                     decoration: BoxDecoration(
//                       shape: BoxShape.circle,
//                       color: Theme.of(context).primaryColor.withOpacity(0.15),
//                       border: Border.all(
//                         color: Theme.of(context).primaryColor.withOpacity(0.3),
//                         width: w * 0.0025,
//                       ),
//                     ),
//                     child: Center(
//                       child: Icon(
//                         Icons.arrow_back_ios_new, // Notification Icon
//                         color: Theme.of(context).canvasColor,
//                         size: 22,
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 const SizedBox(height: 15),
//
//                 Text(
//                   "Your Memories",
//                   style: GoogleFonts.inter(
//                     color: textColor,
//                     fontSize: 26,
//                     fontWeight: FontWeight.w900,
//                   ),
//                 ),
//
//                 const SizedBox(height: 2),
//
//                 Text(
//                   "Relive every spark from your past weekends.\nCaptured, well-lived, and strictly for your eyes.",
//                   style: GoogleFonts.inter(
//                     color: textColor.withOpacity(0.6),
//                     fontSize: 13,
//                     fontWeight: FontWeight.w400,
//                   ),
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 /// TABS
//                 SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: Row(
//                     children: List.generate(tabs.length, (index) {
//                       final item = tabs[index];
//                       final isActive = selectedIndex == index;
//
//                       return GestureDetector(
//                         onTap: () {
//                           setState(() {
//                             selectedIndex = index;
//                           });
//
//                           if (item["type"] == "icon") {
//                             _showCalendarDialog(context);
//                           }
//                         },
//                         child: Container(
//                           margin: const EdgeInsets.only(right: 15),
//                           padding: const EdgeInsets.symmetric(
//                             horizontal: 15,
//                             vertical: 8,
//                           ),
//                           decoration: BoxDecoration(
//                             color: isActive
//                                 ? primaryColor
//                                 : Colors.transparent,
//                             border: isActive
//                                 ? null
//                                 : Border.all(
//                               color: textColor.withOpacity(0.2),
//                             ),
//                             borderRadius: BorderRadius.circular(20),
//                           ),
//                           child: item["type"] == "icon"
//                               ? SvgPicture.asset(
//                             item["icon"],
//                             height: 18,
//                             width: 18,
//                             colorFilter: ColorFilter.mode(
//                               isActive ? Colors.white : textColor,
//                               BlendMode.srcIn,
//                             ),
//                           )
//                               : Text(
//                             item["label"],
//                             style: GoogleFonts.inter(
//                               color: isActive ? Colors.white : textColor,
//                               fontSize: 13,
//                               fontWeight: isActive
//                                   ? FontWeight.bold
//                                   : FontWeight.normal,
//                             ),
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//
//                 const SizedBox(height: 25),
//
//                 /// MEMORY LIST
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: const NeverScrollableScrollPhysics(),
//                   itemCount: memories.length,
//                   itemBuilder: (context, index) {
//                     final item = memories[index];
//                     return _memoryCard(
//                       item.tag,
//                       item.date,
//                       item.description,
//                       item.image,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
//
//   void _showCalendarDialog(BuildContext context) {
//     DateTime focusedDay = DateTime.now();
//     DateTime? selectedDay;
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color cardColor = Theme.of(context).cardColor;
//
//     showDialog(
//       context: context,
//       builder: (context) {
//         return Center(
//           child: StatefulBuilder(
//             builder: (context, setState) {
//               return Dialog(
//                 backgroundColor: cardColor, // Adaptive BG
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Container(
//                   width: 300,
//                   height: 420,
//                   padding: const EdgeInsets.all(12),
//                   child: TableCalendar(
//                     firstDay: DateTime.utc(2020, 1, 1),
//                     lastDay: DateTime.utc(2030, 12, 31),
//                     focusedDay: focusedDay,
//                     selectedDayPredicate: (day) => isSameDay(selectedDay, day),
//                     onDaySelected: (selected, focused) {
//                       setState(() {
//                         selectedDay = selected;
//                         focusedDay = focused;
//                       });
//                     },
//                     calendarStyle: CalendarStyle(
//                       todayDecoration: const BoxDecoration(
//                         color: Colors.grey,
//                         shape: BoxShape.circle,
//                       ),
//                       selectedDecoration: BoxDecoration(
//                         color: Theme.of(context).primaryColor,
//                         shape: BoxShape.circle,
//                       ),
//                       defaultTextStyle: TextStyle(color: textColor),
//                       weekendTextStyle: TextStyle(color: textColor),
//                     ),
//                     headerStyle: HeaderStyle(
//                       formatButtonVisible: false,
//                       titleTextStyle: TextStyle(color: textColor),
//                       leftChevronIcon: Icon(Icons.chevron_left, color: textColor),
//                       rightChevronIcon: Icon(Icons.chevron_right, color: textColor),
//                     ),
//                   ),
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
//
//   Widget _memoryCard(String tag, String date, String description, String imgPath) {
//     return Container(
//       height: 335,
//       margin: const EdgeInsets.only(bottom: 20),
//       decoration: BoxDecoration(
//         borderRadius: BorderRadius.circular(40),
//         image: DecorationImage(
//           image: AssetImage(imgPath),
//           fit: BoxFit.cover,
//           colorFilter: ColorFilter.mode(
//             Colors.black.withOpacity(0.3),
//             BlendMode.darken,
//           ),
//         ),
//       ),
//       child: Padding(
//         padding: const EdgeInsets.all(25),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Align(
//               alignment: Alignment.topRight,
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
//                 decoration: BoxDecoration(
//                   border: Border.all(color: Colors.white54),
//                   borderRadius: BorderRadius.circular(20),
//                 ),
//                 child: Text(
//                   tag,
//                   style: GoogleFonts.inter(color: Colors.white, fontSize: 10),
//                 ),
//               ),
//             ),
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   date,
//                   style: GoogleFonts.inter(
//                     color: Colors.white70,
//                     fontSize: 10,
//                     fontWeight: FontWeight.w600,
//                   ),
//                 ),
//                 const SizedBox(height: 5),
//                 Text(
//                   description,
//                   style: GoogleFonts.inter(
//                     color: Colors.white,
//                     fontSize: 15,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/basic_files/basic_colors.dart';
import 'package:highlights/main_pages/profile_screen.dart';
import 'package:highlights/widgets/custom_loader.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Contollers/post_controller.dart';

class YourMemoriesScreen extends StatefulWidget {
  const YourMemoriesScreen({super.key});

  @override
  State<YourMemoriesScreen> createState() => _YourMemoriesScreenState();
}

class MemoryModel {
  final int id;
  final String tag;
  final String date;
  final String description;
  final String imageUrl;
  final bool isNetworkImage;

  MemoryModel({
    required this.id,
    required this.tag,
    required this.date,
    required this.description,
    required this.imageUrl,
    this.isNetworkImage = true,
  });
}

class _YourMemoriesScreenState extends State<YourMemoriesScreen> {
  int selectedIndex = 0;
  bool _isLoading = true;
  List<MemoryModel> memories = [];
  List<String> _monthTabs = [];
  List<String> _tagTabs = [];
  int _selectedYear = DateTime.now().year;
  int? _selectedMonth;
  String? _selectedTag;

  @override
  void initState() {
    super.initState();
    _loadMemories();
  }

  Future<void> _loadMemories({int? month, String? tag}) async {
    setState(() => _isLoading = true);
    final data = await PostController.getUserMemories(
      year: _selectedYear,
      month: month,
      tag: tag,
    );
    if (data == null || !mounted) { setState(() => _isLoading = false); return; }

    // Available months tabs
    final months = data['available_months'] as List? ?? [];
    _monthTabs = months.map<String>((m) => m['month_name'].toString()).toList();

    // Memories list
    final rawList = data['memories'] as List? ?? [];
    memories = rawList.map((m) => MemoryModel(
      id: m['id'] ?? 0,
      tag: m['memory_label'] ?? m['tags'] ?? '',
      date: m['date_text'] ?? '',
      description: m['caption'] ?? '',
      imageUrl: m['display_url'] ?? m['file_url'] ?? '',
      isNetworkImage: true,
    )).toList();

    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    // Theme references
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;

    final List<Map<String, dynamic>> tabs = [
      {"type": "text", "label": _selectedYear.toString()},
      ..._monthTabs.map((m) => {"type": "text", "label": m}),
      {"type": "icon", "icon": "assets/images/calender.svg"},
    ];

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: w * (20.625 / 375), // 0.055 figma ratio
              vertical: h * (9.72 / 810),    // 0.012 figma ratio
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Theme.of(context).brightness == Brightness.dark
                    ? /* --- DARK THEME: Original Image --- */
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Image.asset(
                    'assets/images/icon.arrow.png',
                    height: w * (48.0 / 375),
                    width: w * (48.0 / 375),
                  ),
                )
                    : /* --- LIGHT THEME: Custom Circle Button Style --- */
                GestureDetector(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(
                    height: w * (45.0 / 375),
                    width: w * (45.0 / 375),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Theme.of(context).primaryColor.withOpacity(0.15),
                      border: Border.all(
                        color: Theme.of(context).primaryColor.withOpacity(0.3),
                        width: w * (0.9375 / 375),
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Theme.of(context).canvasColor,
                        size: w * (22.0 / 375),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: h * (12.15 / 810)),

                Text(
                  "Your Memories",
                  style: GoogleFonts.inter(
                    color: textColor,
                    fontSize: w * (26.0 / 375),
                    fontWeight: FontWeight.w900,
                  ),
                ),

                SizedBox(height: h * (1.62 / 810)),

                Text(
                  "Relive every spark from your past weekends.\nCaptured, well-lived, and strictly for your eyes.",
                  style: GoogleFonts.inter(
                    color: textColor.withOpacity(0.6),
                    fontSize: w * (13.0 / 375),
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: h * (20.25 / 810)),

                /// TABS
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(tabs.length, (index) {
                      final item = tabs[index];
                      final isActive = selectedIndex == index;

                      return GestureDetector(
                        onTap: () {
                          setState(() => selectedIndex = index);
                          if (item["type"] == "icon") {
                            _showCalendarDialog(context);
                          } else if (index > 0 && index <= _monthTabs.length) {
                            final monthIndex = index;
                            final months = _monthTabs;
                            if (monthIndex - 1 < months.length) {
                              _selectedMonth = monthIndex;
                              _loadMemories(month: monthIndex);
                            }
                          } else if (index == 0) {
                            _selectedMonth = null;
                            _selectedTag = null;
                            _loadMemories();
                          }
                        },
                        child: Container(
                          margin: EdgeInsets.only(right: w * (15.0 / 375)),
                          padding: EdgeInsets.symmetric(
                            horizontal: w * (15.0 / 375),
                            vertical: h * (8.1 / 810),
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? primaryColor
                                : Colors.transparent,
                            border: isActive
                                ? null
                                : Border.all(
                              color: textColor.withOpacity(0.2),
                            ),
                            borderRadius: BorderRadius.circular(w * (20.0 / 375)),
                          ),
                          child: item["type"] == "icon"
                              ? SvgPicture.asset(
                            item["icon"],
                            height: w * (18.0 / 375),
                            width: w * (18.0 / 375),
                            colorFilter: ColorFilter.mode(
                              isActive ? Colors.white : textColor,
                              BlendMode.srcIn,
                            ),
                          )
                              : Text(
                            item["label"],
                            style: GoogleFonts.inter(
                              color: isActive ? Colors.white : textColor,
                              fontSize: w * (13.0 / 375),
                              fontWeight: isActive
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                SizedBox(height: h * (20.25 / 810)),

                /// MEMORY LIST
                if (_isLoading)
                  Center(child: Padding(
                    padding: EdgeInsets.all(w * (40.0 / 375)),
                    child: const CustomLoader(),
                  ))
                else if (memories.isEmpty)
                  Center(child: Padding(
                    padding: EdgeInsets.all(w * (40.0 / 375)),
                    child: Text("No memories yet.", style: GoogleFonts.inter(color: textColor.withOpacity(0.5), fontSize: w * (14.0 / 375))),
                  ))
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: memories.length,
                    itemBuilder: (context, index) {
                      final item = memories[index];
                      return _memoryCard(item.tag, item.date, item.description, item.imageUrl, item.isNetworkImage, w, h);
                    },
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showCalendarDialog(BuildContext context) {
    DateTime focusedDay = DateTime.now();
    DateTime? selectedDay;
    final Color textColor = Theme.of(context).canvasColor;
    final Color cardColor = Theme.of(context).cardColor;

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    showDialog(
      context: context,
      builder: (context) {
        return Center(
          child: StatefulBuilder(
            builder: (context, setState) {
              return Dialog(
                backgroundColor: cardColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(w * (20.0 / 375)),
                ),
                child: Container(
                  width: w * (300.0 / 375),
                  height: h * (420.0 / 810),
                  padding: EdgeInsets.all(w * (12.0 / 375)),
                  child: TableCalendar(
                    firstDay: DateTime.utc(2020, 1, 1),
                    lastDay: DateTime.utc(2030, 12, 31),
                    focusedDay: focusedDay,
                    selectedDayPredicate: (day) => isSameDay(selectedDay, day),
                    onDaySelected: (selected, focused) {
                      setState(() {
                        selectedDay = selected;
                        focusedDay = focused;
                      });
                    },
                    calendarStyle: CalendarStyle(
                      todayDecoration: const BoxDecoration(
                        color: Colors.grey,
                        shape: BoxShape.circle,
                      ),
                      selectedDecoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        shape: BoxShape.circle,
                      ),
                      defaultTextStyle: TextStyle(color: textColor, fontSize: w * (14.0 / 375)),
                      weekendTextStyle: TextStyle(color: textColor, fontSize: w * (14.0 / 375)),
                    ),
                    headerStyle: HeaderStyle(
                      formatButtonVisible: false,
                      titleTextStyle: TextStyle(color: textColor, fontSize: w * (16.0 / 375)),
                      leftChevronIcon: Icon(Icons.chevron_left, color: textColor, size: w * (24.0 / 375)),
                      rightChevronIcon: Icon(Icons.chevron_right, color: textColor, size: w * (24.0 / 375)),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _memoryCard(String tag, String date, String description, String imgPath, bool isNetwork, double w, double h) {
    final ImageProvider imgProvider = isNetwork && imgPath.isNotEmpty
        ? NetworkImage(imgPath)
        : AssetImage(imgPath) as ImageProvider;

    return Container(
      height: h * (335.0 / 810),
      margin: EdgeInsets.only(bottom: h * (16.2 / 810)),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(w * (40.0 / 375)),
        image: DecorationImage(
          image: imgProvider,
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(w * (25.0 / 375)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: w * (14.0 / 375), vertical: h * (4.86 / 810)),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white54),
                  borderRadius: BorderRadius.circular(w * (20.0 / 375)),
                ),
                child: Text(
                  tag,
                  style: GoogleFonts.inter(color: Colors.white, fontSize: w * (10.0 / 375)),
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  date,
                  style: GoogleFonts.inter(
                    color: Colors.white70,
                    fontSize: w * (10.0 / 375),
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: h * (4.05 / 810)),
                Text(
                  description,
                  style: GoogleFonts.inter(
                    color: Colors.white,
                    fontSize: w * (15.0 / 375),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
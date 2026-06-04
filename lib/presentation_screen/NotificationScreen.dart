// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/presentation_screen/SettingScreen.dart';
// import 'package:highlights/widgets/Backbutton.dart';
//
//
// class Notificationscreen extends StatefulWidget {
//   const Notificationscreen({super.key});
//
//   @override
//   State<Notificationscreen> createState() => _NotificationscreenState();
// }
//
// class _NotificationscreenState extends State<Notificationscreen> {
//   bool isFollowed = false;
//   final List<Map<String, dynamic>> todayNotifications = [
//     {
//       "name": "Sasha Vane",
//       "message": "started\nfollowing you.",
//       "time": "2m ago",
//       "profileImage": "assets/images/image1.png",
//       "type": "follow",
//     },
//     {
//       "name": "Thomas Bolt",
//       "message": "liked\nyour moment.",
//       "time": "1h ago",
//       "profileImage": "assets/images/image1.png",
//       "postImage": "assets/images/image2.png",
//       "type": "like",
//     },
//     {
//       "name": "Stiphon Jik",
//       "message": "viewed\nyour profile.",
//       "time": "15h ago",
//       "profileImage": "assets/images/image1.png",
//       "countText": "+12",
//       "type": "view",
//     },
//   ];
//
//   final List<Map<String, dynamic>> yesterdayNotifications = [
//     {
//       "name": "Jordan Lee",
//       "message": "liked\nyour moment.",
//       "time": "Yesterday, 10:45 PM",
//       "profileImage": "assets/images/image1.png",
//       "postImage": "assets/images/image2.png",
//       "type": "like",
//     },
//     {
//       "name": "Kimberly West",
//       "message": "viewed\nyour profile.",
//       "time": "Yesterday, 09:00 PM",
//       "profileImage": "assets/images/image1.png",
//       "countText": "+15",
//       "type": "view",
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final size = MediaQuery.of(context).size;
//
//     return Scaffold(
//       backgroundColor: const Color(0xff0F1012),
//       body: SafeArea(
//         child: SingleChildScrollView(
//           padding: EdgeInsets.symmetric(
//             horizontal: size.width * 0.05,
//             vertical: size.height * 0.01,
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               SizedBox(height: size.height * 0.007),
//
//               /// Top Row
//               Row(
//                 children: [
//                   CustomBackButtonWidget(),
//                   SizedBox(width: size.width * 0.04),
//                   Text(
//                     "UPDATES",
//                     style: TextStyle(
//                       color: const Color(0xff4F98A7),
//                       fontSize: size.width * 0.03,
//                       fontWeight: FontWeight.w500,
//                       letterSpacing: 0.8,
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: size.height * 0.025),
//
//               /// Title + Mark all read
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "Activity",
//                     style: TextStyle(
//                       color: Colors.white,
//                       fontSize: size.width * 0.07,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: size.height * 0.01),
//                     child: Text(
//                       "Mark All As Read",
//                       style: TextStyle(
//                         color: const Color(0xff4F98A7),
//                         fontSize: size.width * 0.035,
//                         decoration: TextDecoration.underline,
//                         decorationColor: const Color(0xff4F98A7),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: size.height * 0.02),
//
//               /// Today notifications
//               ...List.generate(
//                 todayNotifications.length,
//                     (index) => Padding(
//                   padding: EdgeInsets.only(bottom: size.height * 0.012),
//                   child: _buildNotificationCard(
//                     size: size,
//                     data: todayNotifications[index],
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.008),
//
//               Text(
//                 "YESTERDAY",
//                 style: TextStyle(
//                   color: Colors.white70,
//                   fontSize: size.width * 0.038,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: 0.7,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.015),
//
//               /// Yesterday notifications
//               ...List.generate(
//                 yesterdayNotifications.length,
//                     (index) => Padding(
//                   padding: EdgeInsets.only(bottom: size.height * 0.012),
//                   child: _buildNotificationCard(
//                     size: size,
//                     data: yesterdayNotifications[index],
//                   ),
//                 ),
//               ),
//               SizedBox(height: size.height * 0.02),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildNotificationCard({
//     required Size size,
//     required Map<String, dynamic> data,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: size.height*0.135,
//       padding: EdgeInsets.symmetric(
//         horizontal: size.width * 0.04,
//         vertical: size.height * 0.022,
//       ),
//       decoration: BoxDecoration(
//         color: const Color(0xff262626),
//         borderRadius: BorderRadius.circular(size.width * 0.07),
//       ),
//       child: Row(
//         children: [
//           /// Left profile image
//           Container(
//             height: size.width * 0.14,
//             width: size.width * 0.14,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               image: DecorationImage(
//                 image: AssetImage(data["profileImage"]),
//                 fit: BoxFit.cover,
//               ),
//             ),
//           ),
//
//           SizedBox(width: size.width * 0.04),
//
//           /// Center text
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "${data["name"]} ",
//                         style: TextStyle(
//                           color: const Color(0xff4F98A7),
//                           fontSize: size.width * 0.045,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       TextSpan(
//                         text: data["message"],
//                         style: TextStyle(
//                           color: Colors.white70,
//                           fontSize: size.width * 0.045,
//                           fontWeight: FontWeight.w600,
//                           height: 1.15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.008),
//                 Text(
//                   data["time"],
//                   style: TextStyle(
//                     color: Colors.white38,
//                     fontSize: size.width * 0.035,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(width: size.width * 0.02),
//
//           /// Right side widget
//           _buildTrailingWidget(size, data),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrailingWidget(Size size, Map<String, dynamic> data) {
//
//     if (data["type"] == "follow") {
//       return GestureDetector(
//         onTap: () {
//           setState(() {
//             isFollowed = !isFollowed; // toggle
//           });
//         },
//         child: Container(
//           height: size.height * 0.035,
//           width: size.width * 0.22,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(size.width * 0.07),
//             color: isFollowed
//                 ? Colors.grey   // 👈 changed color
//                 : const Color(0xff4F98A7),
//             boxShadow: [
//               BoxShadow(
//                 color: (isFollowed
//                     ? Colors.grey
//                     : const Color(0xff4F98A7))
//                     .withOpacity(0.45),
//                 blurRadius: size.width * 0.03,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           padding: EdgeInsets.symmetric(
//             vertical: size.width * 0.02,
//             horizontal: size.width * 0.02,
//           ),
//           child: Center(
//             child: Text(
//               isFollowed ? "Following" : "Follow Back", // 👈 optional text change
//               style: TextStyle(
//                 color: Colors.white,
//                 fontSize: size.width * 0.025,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//           ),
//         ),
//       );
//     } else if (data["type"] == "like") {
//       return Container(
//         height: size.width * 0.15,
//         width: size.width * 0.15,
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(size.width * 0.035),
//           image: DecorationImage(
//             image: AssetImage(data["postImage"]),
//             fit: BoxFit.cover,
//           ),
//         ),
//       );
//     } else {
//       return Container(
//         height: size.width * 0.14,
//         width: size.width * 0.14,
//         decoration: BoxDecoration(
//           shape: BoxShape.circle,
//           color: const Color(0xff5B5358).withOpacity(0.8),
//         ),
//         child: Center(
//           child: Text(
//             data["countText"],
//             style: TextStyle(
//               color: Colors.white54,
//               fontSize: size.width * 0.045,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ),
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:highlights/widgets/Backbutton.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  bool isFollowed = false;

  final List<Map<String, dynamic>> todayNotifications = [
    {
      "name": "Sasha Vane",
      "message": "started\nfollowing you.",
      "time": "2m ago",
      "profileImage": "assets/images/image1.png",
      "type": "follow",
    },
    {
      "name": "Thomas Bolt",
      "message": "liked\nyour moment.",
      "time": "1h ago",
      "profileImage": "assets/images/image1.png",
      "postImage": "assets/images/image2.png",
      "type": "like",
    },
    {
      "name": "Stiphon Jik",
      "message": "viewed\nyour profile.",
      "time": "15h ago",
      "profileImage": "assets/images/image1.png",
      "countText": "+12",
      "type": "view",
    },
  ];

  final List<Map<String, dynamic>> yesterdayNotifications = [
    {
      "name": "Jordan Lee",
      "message": "liked\nyour moment.",
      "time": "Yesterday, 10:45 PM",
      "profileImage": "assets/images/image1.png",
      "postImage": "assets/images/image2.png",
      "type": "like",
    },
    {
      "name": "Kimberly West",
      "message": "viewed\nyour profile.",
      "time": "Yesterday, 09:00 PM",
      "profileImage": "assets/images/image1.png",
      "countText": "+15",
      "type": "view",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final Color textColor = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: size.width * 0.05,
            vertical: size.height * 0.01,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: size.height * 0.007),

              Row(
                children: [
                  const CustomBackButtonWidget(),
                  SizedBox(width: size.width * 0.04),
                  Text(
                    "UPDATES",
                    style: TextStyle(
                      color: primaryColor,
                      fontSize: size.width * 0.03,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.025),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    "Activity",
                    style: TextStyle(
                      color: textColor,
                      fontSize: size.width * 0.07,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: size.height * 0.01),
                    child: Text(
                      "Mark All As Read",
                      style: TextStyle(
                        color: primaryColor,
                        fontSize: size.width * 0.035,
                        decoration: TextDecoration.underline,
                        decorationColor: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: size.height * 0.02),

              ...List.generate(
                todayNotifications.length,
                    (index) => Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.012),
                  child: _buildNotificationCard(
                    size: size,
                    data: todayNotifications[index],
                    cardBg: cardBgColor,
                    textC: textColor,
                    primary: primaryColor,
                  ),
                ),
              ),

              SizedBox(height: size.height * 0.008),

              Text(
                "YESTERDAY",
                style: TextStyle(
                  color: textColor.withOpacity(0.6),
                  fontSize: size.width * 0.038,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.7,
                ),
              ),

              SizedBox(height: size.height * 0.015),

              ...List.generate(
                yesterdayNotifications.length,
                    (index) => Padding(
                  padding: EdgeInsets.only(bottom: size.height * 0.012),
                  child: _buildNotificationCard(
                    size: size,
                    data: yesterdayNotifications[index],
                    cardBg: cardBgColor,
                    textC: textColor,
                    primary: primaryColor,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.02),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationCard({
    required Size size,
    required Map<String, dynamic> data,
    required Color cardBg,
    required Color textC,
    required Color primary,
  }) {
    return Container(
      width: double.infinity,
      height: size.height * 0.135,
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.04,
        vertical: size.height * 0.022,
      ),
      decoration: BoxDecoration(
        color: cardBg,
        borderRadius: BorderRadius.circular(size.width * 0.07),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: size.width * 0.07,
            backgroundImage: AssetImage(data["profileImage"]),
          ),

          SizedBox(width: size.width * 0.04),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: "${data["name"]} ",
                        style: TextStyle(
                          color: primary,
                          fontSize: size.width * 0.042,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: data["message"],
                        style: TextStyle(
                          color: textC.withOpacity(0.8),
                          fontSize: size.width * 0.042,
                          fontWeight: FontWeight.w600,
                          height: 1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.005),
                Text(
                  data["time"],
                  style: TextStyle(
                    color: textC.withOpacity(0.4),
                    fontSize: size.width * 0.032,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(width: size.width * 0.02),

          _buildTrailingWidget(size, data, primary, textC),
        ],
      ),
    );
  }

  Widget _buildTrailingWidget(Size size, Map<String, dynamic> data, Color primary, Color textC) {
    if (data["type"] == "follow") {
      return GestureDetector(
        onTap: () => setState(() => isFollowed = !isFollowed),
        child: Container(
          height: size.height * 0.035,
          width: size.width * 0.22,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(size.width * 0.07),
            color: isFollowed ? Colors.grey.withOpacity(0.5) : primary,
            boxShadow: [
              BoxShadow(
                color: (isFollowed ? Colors.grey : primary).withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: Center(
            child: Text(
              isFollowed ? "Following" : "Follow Back",
              style: TextStyle(
                color: Colors.white,
                fontSize: size.width * 0.025,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ),
      );
    } else if (data["type"] == "like") {
      return ClipRRect(
        borderRadius: BorderRadius.circular(size.width * 0.03),
        child: Image.asset(
          data["postImage"],
          height: size.width * 0.13,
          width: size.width * 0.13,
          fit: BoxFit.cover,
        ),
      );
    } else {
      return CircleAvatar(
        radius: size.width * 0.065,
        backgroundColor: textC.withOpacity(0.1),
        child: Text(
          data["countText"],
          style: TextStyle(
            color: textC.withOpacity(0.6),
            fontSize: size.width * 0.035,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
  }
}
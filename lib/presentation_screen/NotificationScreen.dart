//
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:highlights/widgets/Backbutton.dart';
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
//
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
//     final Color textColor = Theme.of(context).canvasColor;
//     final Color primaryColor = Theme.of(context).primaryColor;
//     final Color cardBgColor = Theme.of(context).cardColor;
//
//     return Scaffold(
//       backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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
//               Row(
//                 children: [
//                   const CustomBackButtonWidget(),
//                   SizedBox(width: size.width * 0.04),
//                   Text(
//                     "UPDATES",
//                     style: TextStyle(
//                       color: primaryColor,
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
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 crossAxisAlignment: CrossAxisAlignment.end,
//                 children: [
//                   Text(
//                     "Activity",
//                     style: TextStyle(
//                       color: textColor,
//                       fontSize: size.width * 0.07,
//                       fontWeight: FontWeight.w800,
//                     ),
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(bottom: size.height * 0.01),
//                     child: Text(
//                       "Mark All As Read",
//                       style: TextStyle(
//                         color: primaryColor,
//                         fontSize: size.width * 0.035,
//                         decoration: TextDecoration.underline,
//                         decorationColor: primaryColor,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//
//               SizedBox(height: size.height * 0.02),
//
//               ...List.generate(
//                 todayNotifications.length,
//                     (index) => Padding(
//                   padding: EdgeInsets.only(bottom: size.height * 0.012),
//                   child: _buildNotificationCard(
//                     size: size,
//                     data: todayNotifications[index],
//                     cardBg: cardBgColor,
//                     textC: textColor,
//                     primary: primaryColor,
//                   ),
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.008),
//
//               Text(
//                 "YESTERDAY",
//                 style: TextStyle(
//                   color: textColor.withOpacity(0.6),
//                   fontSize: size.width * 0.038,
//                   fontWeight: FontWeight.w500,
//                   letterSpacing: 0.7,
//                 ),
//               ),
//
//               SizedBox(height: size.height * 0.015),
//
//               ...List.generate(
//                 yesterdayNotifications.length,
//                     (index) => Padding(
//                   padding: EdgeInsets.only(bottom: size.height * 0.012),
//                   child: _buildNotificationCard(
//                     size: size,
//                     data: yesterdayNotifications[index],
//                     cardBg: cardBgColor,
//                     textC: textColor,
//                     primary: primaryColor,
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
//     required Color cardBg,
//     required Color textC,
//     required Color primary,
//   }) {
//     return Container(
//       width: double.infinity,
//       height: size.height * 0.135,
//       padding: EdgeInsets.symmetric(
//         horizontal: size.width * 0.04,
//         vertical: size.height * 0.022,
//       ),
//       decoration: BoxDecoration(
//         color: cardBg,
//         borderRadius: BorderRadius.circular(size.width * 0.07),
//       ),
//       child: Row(
//         children: [
//           CircleAvatar(
//             radius: size.width * 0.07,
//             backgroundImage: AssetImage(data["profileImage"]),
//           ),
//
//           SizedBox(width: size.width * 0.04),
//
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 RichText(
//                   text: TextSpan(
//                     children: [
//                       TextSpan(
//                         text: "${data["name"]} ",
//                         style: TextStyle(
//                           color: primary,
//                           fontSize: size.width * 0.042,
//                           fontWeight: FontWeight.w700,
//                         ),
//                       ),
//                       TextSpan(
//                         text: data["message"],
//                         style: TextStyle(
//                           color: textC.withOpacity(0.8),
//                           fontSize: size.width * 0.042,
//                           fontWeight: FontWeight.w600,
//                           height: 1.15,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: size.height * 0.005),
//                 Text(
//                   data["time"],
//                   style: TextStyle(
//                     color: textC.withOpacity(0.4),
//                     fontSize: size.width * 0.032,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//
//           SizedBox(width: size.width * 0.02),
//
//           _buildTrailingWidget(size, data, primary, textC),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTrailingWidget(Size size, Map<String, dynamic> data, Color primary, Color textC) {
//     if (data["type"] == "follow") {
//       return GestureDetector(
//         onTap: () => setState(() => isFollowed = !isFollowed),
//         child: Container(
//           height: size.height * 0.035,
//           width: size.width * 0.22,
//           decoration: BoxDecoration(
//             borderRadius: BorderRadius.circular(size.width * 0.07),
//             color: isFollowed ? Colors.grey.withOpacity(0.5) : primary,
//             boxShadow: [
//               BoxShadow(
//                 color: (isFollowed ? Colors.grey : primary).withOpacity(0.3),
//                 blurRadius: 8,
//                 spreadRadius: 1,
//               ),
//             ],
//           ),
//           child: Center(
//             child: Text(
//               isFollowed ? "Following" : "Follow Back",
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
//       return ClipRRect(
//         borderRadius: BorderRadius.circular(size.width * 0.03),
//         child: Image.asset(
//           data["postImage"],
//           height: size.width * 0.13,
//           width: size.width * 0.13,
//           fit: BoxFit.cover,
//         ),
//       );
//     } else {
//       return CircleAvatar(
//         radius: size.width * 0.065,
//         backgroundColor: textC.withOpacity(0.1),
//         child: Text(
//           data["countText"],
//           style: TextStyle(
//             color: textC.withOpacity(0.6),
//             fontSize: size.width * 0.035,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//       );
//     }
//   }
// }
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../Contollers/notificaion_controller.dart';
import '../widgets/Backbutton.dart';

class Notificationscreen extends StatefulWidget {
  const Notificationscreen({super.key});

  @override
  State<Notificationscreen> createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  late final NotificationController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.isRegistered<NotificationController>()
        ? Get.find<NotificationController>()
        : Get.put(NotificationController());
  }

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    final Color textColor    = Theme.of(context).canvasColor;
    final Color primaryColor = Theme.of(context).primaryColor;
    final Color cardBgColor  = Theme.of(context).cardColor;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // ── FIXED HEADER ──────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: w * (18.75 / 375), // 0.05 scaled ratio
                vertical:   h * (8.1 / 810),   // 0.01 scaled ratio
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * (5.67 / 810)),

                  // Back + UPDATES
                  Row(
                    children: [
                      const CustomBackButtonWidget(),
                      SizedBox(width: w * (15.0 / 375)),
                      Text(
                        "UPDATES",
                        style: TextStyle(
                          color:         primaryColor,
                          fontSize:      w * (11.25 / 375),
                          fontWeight:    FontWeight.w500,
                          letterSpacing: 0.8,
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: h * (20.25 / 810)),

                  // Activity + Mark All As Read
                  Row(
                    mainAxisAlignment:  MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "Activity",
                        style: TextStyle(
                          color:      textColor,
                          fontSize:   w * (26.25 / 375),
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: h * (8.1 / 810)),
                        child: Obx(() => GestureDetector(
                          onTap: controller.isMarkingRead.value
                              ? null
                              : controller.markAllAsRead,
                          child: controller.isMarkingRead.value
                              ? SizedBox(
                            height: w * (15.0 / 375),
                            width:  w * (15.0 / 375),
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: primaryColor,
                            ),
                          )
                              : Text(
                            "Mark All As Read",
                            style: TextStyle(
                              color: controller.unreadCount.value > 0
                                  ? primaryColor
                                  : textColor.withOpacity(0.35),
                              fontSize:        w * (13.125 / 375),
                              decoration:      TextDecoration.underline,
                              decorationColor: controller.unreadCount.value > 0
                                  ? primaryColor
                                  : textColor.withOpacity(0.35),
                            ),
                          ),
                        )),
                      ),
                    ],
                  ),

                  SizedBox(height: h * (12.15 / 810)),
                ],
              ),
            ),

            // ── SCROLLABLE AREA ───────────────────────────────────────────
            Expanded(
              child: Obx(() {

                // ── Skeleton loading ──────────────────────────────────────
                if (controller.isLoading.value) {
                  return RefreshIndicator(
                    color:           primaryColor,
                    backgroundColor: cardBgColor,
                    displacement:    20,
                    onRefresh:       controller.refreshNotifications,
                    child: ListView.builder(
                      physics:   const AlwaysScrollableScrollPhysics(),
                      padding:   EdgeInsets.symmetric(
                        horizontal: w * (18.75 / 375),
                      ),
                      itemCount: 5,
                      itemBuilder: (_, __) => Padding(
                        padding: EdgeInsets.only(bottom: h * (9.72 / 810)),
                        child:   _SkeletonCard(w: w, h: h, cardBg: cardBgColor),
                      ),
                    ),
                  );
                }

                // ── Empty state ───────────────────────────────────────────
                if (controller.notifications.isEmpty) {
                  return RefreshIndicator(
                    color:           primaryColor,
                    backgroundColor: cardBgColor,
                    displacement:    20,
                    onRefresh:       controller.refreshNotifications,
                    child: SingleChildScrollView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      child: SizedBox(
                        height: h * (486.0 / 810),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.notifications_none_rounded,
                                size:  w * (67.5 / 375),
                                color: textColor.withOpacity(0.2),
                              ),
                              SizedBox(height: h * (16.2 / 810)),
                              Text(
                                "No notifications yet",
                                style: TextStyle(
                                  color:      textColor.withOpacity(0.45),
                                  fontSize:   w * (16.875 / 375),
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              SizedBox(height: h * (8.1 / 810)),
                              Text(
                                "Pull down to refresh",
                                style: TextStyle(
                                  color:    textColor.withOpacity(0.25),
                                  fontSize: w * (13.125 / 375),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }

                // ── Notification list ─────────────────────────────────────
                final grouped = _groupByDate(controller.notifications);

                return RefreshIndicator(
                  color:           primaryColor,
                  backgroundColor: cardBgColor,
                  displacement:    20,
                  onRefresh:       controller.refreshNotifications,
                  child: CustomScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    slivers: [
                      for (final entry in grouped.entries) ...[

                        if (entry.key != 'TODAY')
                          SliverToBoxAdapter(
                            child: Padding(
                              padding: EdgeInsets.only(
                                left:   w * (18.75 / 375),
                                right:  w * (18.75 / 375),
                                top:    h * (6.48 / 810),
                                bottom: h * (12.15 / 810),
                              ),
                              child: Text(
                                entry.key,
                                style: TextStyle(
                                  color:         textColor.withOpacity(0.6),
                                  fontSize:      w * (14.25 / 375),
                                  fontWeight:    FontWeight.w500,
                                  letterSpacing: 0.7,
                                ),
                              ),
                            ),
                          ),

                        // Notification cards
                        SliverPadding(
                          padding: EdgeInsets.symmetric(
                            horizontal: w * (18.75 / 375),
                          ),
                          sliver: SliverList(
                            delegate: SliverChildBuilderDelegate(
                                  (context, index) {
                                final notif = entry.value[index];
                                return Padding(
                                  padding: EdgeInsets.only(
                                    bottom: h * (9.72 / 810),
                                  ),
                                  child: _NotificationCard(
                                    notif:   notif,
                                    w:       w,
                                    h:       h,
                                    cardBg:  cardBgColor,
                                    textC:   textColor,
                                    primary: primaryColor,
                                  ),
                                );
                              },
                              childCount: entry.value.length,
                            ),
                          ),
                        ),
                      ],

                      SliverToBoxAdapter(
                        child: SizedBox(height: h * (16.2 / 810)),
                      ),
                    ],
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  Map<String, List<dynamic>> _groupByDate(List notifications) {
    final Map<String, List<dynamic>> grouped = {};
    final now       = DateTime.now();
    final today     = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    for (final notif in notifications) {
      try {
        final dt    = DateTime.parse(notif.createdAt.replaceAll(' ', 'T'));
        final dtDay = DateTime(dt.year, dt.month, dt.day);

        String label;
        if (dtDay == today) {
          label = 'TODAY';
        } else if (dtDay == yesterday) {
          label = 'YESTERDAY';
        } else {
          const months = [
            '', 'JAN', 'FEB', 'MAR', 'APR', 'MAY', 'JUN',
            'JUL', 'AUG', 'SEP', 'OCT', 'NOV', 'DEC',
          ];
          label = '${months[dt.month]} ${dt.day}';
        }
        grouped.putIfAbsent(label, () => []).add(notif);
      } catch (_) {
        grouped.putIfAbsent('EARLIER', () => []).add(notif);
      }
    }
    return grouped;
  }
}

// ─── Notification Card ────────────────────────────────────────────────────────
class _NotificationCard extends StatelessWidget {
  final dynamic notif;
  final double  w;
  final double  h;
  final Color   cardBg;
  final Color   textC;
  final Color   primary;

  const _NotificationCard({
    required this.notif,
    required this.w,
    required this.h,
    required this.cardBg,
    required this.textC,
    required this.primary,
  });

  @override
  Widget build(BuildContext context) {
    final bool    isUnread = !notif.isRead;
    final Color   bgColor  = isUnread ? cardBg.withOpacity(0.95) : cardBg;
    final Border? border   = isUnread
        ? Border.all(color: primary.withOpacity(0.18), width: 1)
        : null;

    return Container(
      width:   double.infinity,
      padding: EdgeInsets.symmetric(
        horizontal: w * (15.0 / 375),
        vertical:   h * (17.82 / 810),
      ),
      decoration: BoxDecoration(
        color:        bgColor,
        border:       border,
        borderRadius: BorderRadius.circular(w * (26.25 / 375)),
      ),
      child: Row(
        children: [
          _buildAvatar(),
          SizedBox(width: w * (15.0 / 375)),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment:  MainAxisAlignment.center,
              children: [
                RichText(
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: '${notif.fromUserName ?? 'Someone'} ',
                        style: TextStyle(
                          color:      primary,
                          fontSize:   w * (15.75 / 375),
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      TextSpan(
                        text: _messageText(),
                        style: TextStyle(
                          color:      textC.withOpacity(0.85),
                          fontSize:   w * (15.75 / 375),
                          fontWeight: FontWeight.w600,
                          height:     1.15,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: h * (4.05 / 810)),
                Text(
                  _formatTime(notif.createdAt),
                  style: TextStyle(
                    color:      textC.withOpacity(0.4),
                    fontSize:   w * (12.0 / 375),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: w * (7.5 / 375)),
          _buildTrailing(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    final double  radius  = w * (26.25 / 375);
    final String? url     = notif.fromUserAvatarUrl;
    final String  initial =
    (notif.fromUserName ?? 'S').substring(0, 1).toUpperCase();

    if (url != null &&
        url.isNotEmpty &&
        url.startsWith('http') &&
        !url.endsWith('.mp4') &&
        !url.endsWith('.heic')) {
      return CircleAvatar(
        radius:          radius,
        backgroundColor: textC.withOpacity(0.1),
        child: ClipOval(
          child: CachedNetworkImage(
            imageUrl:       url,
            width:          radius * 2,
            height:         radius * 2,
            fit:            BoxFit.cover,
            memCacheWidth:  150,
            memCacheHeight: 150,
            placeholder:    (_, __) => _avatarFallback(radius, initial),
            errorWidget:    (_, __, ___) => _avatarFallback(radius, initial),
          ),
        ),
      );
    }
    return _avatarFallback(radius, initial);
  }

  Widget _avatarFallback(double radius, String initial) {
    return CircleAvatar(
      radius:          radius,
      backgroundColor: primary.withOpacity(0.2),
      child: Text(
        initial,
        style: TextStyle(
          color:      primary,
          fontSize:   w * (15.75 / 375),
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  String _messageText() {
    switch (notif.type) {
      case 'post_share':   return 'shared your post.';
      case 'post_comment': return 'commented on your post.';
      case 'post_like':    return 'liked your moment.';
      case 'follow':       return 'started following you.';
      case 'post_view':    return 'viewed your profile.';
      default:
        final name = notif.fromUserName ?? '';
        final msg  = notif.message as String? ?? '';
        return msg.replaceFirst(name, '').trim();
    }
  }

  Widget _buildTrailing() {
    if (notif.type == 'follow') {
      return _FollowButton(w: w, h: h, primary: primary);
    }

    final String? postUrl  = notif.postDisplayUrl;
    final String  postType = notif.postType ?? '';

    final bool isValidImage = postUrl != null &&
        postUrl.isNotEmpty &&
        postUrl.startsWith('http') &&
        postType != 'video' &&
        !postUrl.endsWith('.mp4') &&
        !postUrl.endsWith('.mov') &&
        !postUrl.endsWith('.heic');

    if (isValidImage) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(w * (11.25 / 375)),
        child: CachedNetworkImage(
          imageUrl:       postUrl!,
          height:         w * (48.75 / 375),
          width:          w * (48.75 / 375),
          fit:            BoxFit.cover,
          memCacheWidth:  150,
          memCacheHeight: 150,
          placeholder:    (_, __) => _trailingPlaceholder(),
          errorWidget:    (_, __, ___) => _trailingPlaceholder(showIcon: true),
        ),
      );
    }

    return CircleAvatar(
      radius:          w * (24.375 / 375),
      backgroundColor: textC.withOpacity(0.1),
      child: Icon(
        postType == 'video'
            ? Icons.play_circle_outline_rounded
            : Icons.notifications_none_rounded,
        color: textC.withOpacity(0.5),
        size:  w * (22.5 / 375),
      ),
    );
  }

  Widget _trailingPlaceholder({bool showIcon = false}) {
    return Container(
      height: w * (48.75 / 375),
      width:  w * (48.75 / 375),
      decoration: BoxDecoration(
        color:        textC.withOpacity(0.1),
        borderRadius: BorderRadius.circular(w * (11.25 / 375)),
      ),
      child: showIcon
          ? Icon(Icons.image_not_supported_outlined,
          color: textC.withOpacity(0.3),
          size:  w * (22.5 / 375))
          : null,
    );
  }

  String _formatTime(String createdAt) {
    try {
      final dt = DateTime.parse(createdAt.replaceAll(' ', 'T') + 'Z').toLocal();
      final now  = DateTime.now();
      final diff = now.difference(dt);

      if (diff.inMinutes < 1)  return 'Just now';
      if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
      if (diff.inHours < 24)   return '${diff.inHours}h ago';
      if (diff.inDays == 1) {
        final h    = dt.hour % 12 == 0 ? 12 : dt.hour % 12;
        final m    = dt.minute.toString().padLeft(2, '0');
        final ampm = dt.hour < 12 ? 'AM' : 'PM';
        return 'Yesterday, $h:$m $ampm';
      }
      if (diff.inDays < 7) return '${diff.inDays}d ago';
      const months = [
        '', 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
        'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
      ];
      return '${months[dt.month]} ${dt.day}';
    } catch (_) {
      return createdAt;
    }
  }
}

// ─── Follow Back Button ───────────────────────────────────────────────────────
class _FollowButton extends StatefulWidget {
  final double w;
  final double h;
  final Color primary;
  const _FollowButton({required this.w, required this.h, required this.primary});

  @override
  State<_FollowButton> createState() => _FollowButtonState();
}

class _FollowButtonState extends State<_FollowButton> {
  bool _followed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => setState(() => _followed = !_followed),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve:    Curves.easeInOut,
        height:   widget.h * (28.35 / 810),
        width:    widget.w * (82.5 / 375),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(widget.w * (26.25 / 375)),
          color: _followed ? Colors.grey.withOpacity(0.5) : widget.primary,
          boxShadow: [
            BoxShadow(
              color: (_followed ? Colors.grey : widget.primary).withOpacity(0.3),
              blurRadius:   8,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Center(
          child: Text(
            _followed ? "Following" : "Follow Back",
            style: TextStyle(
              color:      Colors.white,
              fontSize:   widget.w * (9.375 / 375),
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Skeleton Card ────────────────────────────────────────────────────────────
class _SkeletonCard extends StatefulWidget {
  final double w;
  final double h;
  final Color cardBg;
  const _SkeletonCard({required this.w, required this.h, required this.cardBg});

  @override
  State<_SkeletonCard> createState() => _SkeletonCardState();
}

class _SkeletonCardState extends State<_SkeletonCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double>   _anim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync:    this,
      duration: const Duration(milliseconds: 1000),
    )..repeat(reverse: true);
    _anim = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _anim,
      builder: (_, __) => Container(
        height: widget.h * (109.35 / 810),
        padding: EdgeInsets.symmetric(
          horizontal: widget.w * (15.0 / 375),
          vertical:   widget.h * (17.82 / 810),
        ),
        decoration: BoxDecoration(
          color:        widget.cardBg,
          borderRadius: BorderRadius.circular(widget.w * (26.25 / 375)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius:          widget.w * (26.25 / 375),
              backgroundColor: Colors.white.withOpacity(_anim.value),
            ),
            SizedBox(width: widget.w * (15.0 / 375)),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment:  MainAxisAlignment.center,
                children: [
                  Container(
                    height: widget.h * (14.58 / 810),
                    width:  widget.w * (187.5 / 375),
                    decoration: BoxDecoration(
                      color:        Colors.white.withOpacity(_anim.value),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                  SizedBox(height: widget.h * (6.48 / 810)),
                  Container(
                    height: widget.h * (11.34 / 810),
                    width:  widget.w * (112.5 / 375),
                    decoration: BoxDecoration(
                      color:        Colors.white.withOpacity(_anim.value * 0.6),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(width: widget.w * (7.5 / 375)),
            ClipRRect(
              borderRadius: BorderRadius.circular(widget.w * (11.25 / 375)),
              child: Container(
                height: widget.w * (48.75 / 375),
                width:  widget.w * (48.75 / 375),
                color:  Colors.white.withOpacity(_anim.value),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
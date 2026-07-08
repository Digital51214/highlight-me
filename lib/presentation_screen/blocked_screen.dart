import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlights/widgets/custom_loader.dart';

import '../Contollers/block_controller.dart';
import '../widgets/Backbutton.dart';

class BlockedScreen extends StatefulWidget {
  const BlockedScreen({super.key});

  @override
  State<BlockedScreen> createState() => _BlockedScreenState();
}

class _BlockedScreenState extends State<BlockedScreen> {
  late final BlockController blockCtrl;

  @override
  void initState() {
    super.initState();
    blockCtrl = Get.isRegistered<BlockController>()
        ? Get.find<BlockController>()
        : Get.put(BlockController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      blockCtrl.fetchBlockedUsers();
    });
  }

  void _confirmUnblock(String userName, int userId) {
    final double w = MediaQuery.of(context).size.width;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        backgroundColor: Theme.of(context).cardColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(w * (16.0 / 375)),
        ),
        title: Text(
          'Unblock $userName?',
          style: GoogleFonts.inter(
            color: Theme.of(context).canvasColor,
            fontWeight: FontWeight.w700,
            fontSize: w * (16.0 / 375),
          ),
        ),
        content: Text(
          'They will be able to message you again, and you\'ll see their messages. You can block them again anytime.',
          style: GoogleFonts.inter(
            color: Theme.of(context).canvasColor.withOpacity(0.7),
            fontSize: w * (13.0 / 375),
            height: 1.5,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(dialogContext).pop(),
            child: Text(
              'Cancel',
              style: GoogleFonts.inter(
                color: Colors.grey,
                fontSize: w * (14.0 / 375),
              ),
            ),
          ),
          Obx(() => ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Theme.of(context).primaryColor,
              shadowColor: Theme.of(context).primaryColor.withOpacity(0.8),
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(w * (9.0 / 375)),
              ),
            ),
            onPressed: blockCtrl.isUnblocking.value
                ? null
                : () async {
              Navigator.of(dialogContext).pop();
              await blockCtrl.unblockUser(blockedUserId: userId);
            },
            child: blockCtrl.isUnblocking.value
                ? SizedBox(
              width: w * (16.0 / 375),
              height: w * (16.0 / 375),
              child: const CircularProgressIndicator(
                strokeWidth: 2,
                color: Colors.white,
              ),
            )
                : Text(
              'Unblock',
              style: GoogleFonts.inter(
                color: Colors.white,
                fontWeight: FontWeight.w600,
                fontSize: w * (14.0 / 375),
              ),
            ),
          )),
        ],
      ),
    );
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
        child: RefreshIndicator(
            color: Theme.of(context).primaryColor,
          onRefresh: () => blockCtrl.fetchBlockedUsers(),
          child: SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              horizontal: w * (20.625 / 375),
              vertical: h * (9.72 / 810),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: h * (8.1 / 810)),

                const CustomBackButtonWidget(),

                SizedBox(height: h * (28.35 / 810)),

                Text(
                  "Blocked Accounts",
                  style: TextStyle(
                    color: textColor,
                    fontSize: w * (24.375 / 375),
                    fontWeight: FontWeight.w800,
                    height: 1.1,
                  ),
                ),

                SizedBox(height: h * (5.67 / 810)),

                Text(
                  "Accounts you've restricted",
                  style: TextStyle(
                    color: textColor.withOpacity(0.6),
                    fontSize: w * (13.5 / 375),
                    fontWeight: FontWeight.w400,
                  ),
                ),

                SizedBox(height: h * (28.35 / 810)),

                // ── Blocked Users List ──
                Obx(() {
                  if (blockCtrl.isLoadingBlocked.value &&
                      blockCtrl.blockedUsers.isEmpty) {
                    return SizedBox(
                      height: h * (300.0 / 810),
                      child: const Center(child: CustomLoader()),
                    );
                  }

                  if (blockCtrl.blockedUsers.isEmpty) {
                    return SizedBox(
                      height: h * (300.0 / 810),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.block_flipped,
                              color: textColor.withOpacity(0.25),
                              size: w * (48.0 / 375),
                            ),
                            SizedBox(height: h * (12.0 / 810)),
                            Text(
                              "No blocked accounts",
                              style: TextStyle(
                                color: textColor.withOpacity(0.5),
                                fontSize: w * (14.0 / 375),
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: blockCtrl.blockedUsers.length,
                    itemBuilder: (context, index) {
                      final user = blockCtrl.blockedUsers[index];

                      final String? avatarUrl =
                      (user.avatarUrl != null &&
                          user.avatarUrl!.isNotEmpty &&
                          user.avatarUrl != 'null')
                          ? user.avatarUrl
                          : null;

                      return Padding(
                        padding: EdgeInsets.only(bottom: h * (16.2 / 810)),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // ── Avatar ──
                            ClipOval(
                              child: (avatarUrl != null)
                                  ? ExtendedImage.network(
                                avatarUrl,
                                width: w * (44.0 / 375),
                                height: w * (44.0 / 375),
                                fit: BoxFit.cover,
                                cache: true,
                                loadStateChanged: (state) {
                                  if (state.extendedImageLoadState ==
                                      LoadState.loading) {
                                    return Container(
                                      width: w * (44.0 / 375),
                                      height: w * (44.0 / 375),
                                      color: Colors.grey.shade700,
                                    );
                                  }
                                  if (state.extendedImageLoadState ==
                                      LoadState.failed) {
                                    return Container(
                                      width: w * (44.0 / 375),
                                      height: w * (44.0 / 375),
                                      color: Colors.grey.shade800,
                                      child: Icon(Icons.person,
                                          color: Colors.white,
                                          size: w * (22.0 / 375)),
                                    );
                                  }
                                  return null;
                                },
                              )
                                  : Container(
                                width: w * (44.0 / 375),
                                height: w * (44.0 / 375),
                                color: Colors.grey.shade800,
                                child: Icon(Icons.person,
                                    color: Colors.white,
                                    size: w * (22.0 / 375)),
                              ),
                            ),

                            SizedBox(width: w * (11.25 / 375)),

                            // ── Name + Subtitle ──
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    user.name,
                                    style: GoogleFonts.inter(
                                      color: textColor,
                                      fontWeight: FontWeight.w600,
                                      fontSize: w * (13.5 / 375),
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: h * (2.0 / 810)),
                                  Text(
                                    "Includes other accounts they\nmay have or create",
                                    style: GoogleFonts.inter(
                                      color: textColor.withOpacity(0.5),
                                      fontSize: w * (10.5 / 375),
                                      height: 1.3,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(width: w * (8.0 / 375)),

                            // ── Unblock Button ──
                            Obx(() {
                              final bool isThisUnblocking =
                                  blockCtrl.isUnblocking.value &&
                                      blockCtrl.unblockingUserId.value ==
                                          user.id;

                              return SizedBox(
                                height: h * (32.0 / 810),
                                child: ElevatedButton(
                                  onPressed: isThisUnblocking
                                      ? null
                                      : () {
                                    _confirmUnblock(user.name, user.id);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    shadowColor: Theme.of(context).primaryColor.withOpacity(0.8),
                                    backgroundColor: primaryColor,
                                    padding: EdgeInsets.symmetric(
                                      horizontal: w * (16.0 / 375),
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(
                                          w * (20.0 / 375)),
                                    ),
                                    elevation: 6,
                                  ),
                                  child: isThisUnblocking
                                      ? SizedBox(
                                    width: w * (14.0 / 375),
                                    height: w * (14.0 / 375),
                                    child:
                                    const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                      : Text(
                                    "Unblock",
                                    style: GoogleFonts.inter(
                                      fontSize: w * (11.5 / 375),
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            }),
                          ],
                        ),
                      );
                    },
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
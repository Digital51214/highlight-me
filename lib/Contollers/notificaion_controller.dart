import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import '../services/api_service.dart';
import '../services/session_manager.dart';

// ─── Notification Model ───────────────────────────────────────────────────────
class NotificationModel {
  final int     id;
  final int     userId;
  final int?    fromUserId;
  final int?    postId;
  final String  type;
  final String  title;
  final String  message;
  final bool    isRead;
  final String? readAt;
  final String  createdAt;
  final String? fromUserName;
  final String? fromUsername;
  final String? fromUserAvatarUrl;
  final String? postFileUrl;
  final String? postThumbnailUrl;
  final String? postDisplayUrl;
  final String? postType;

  NotificationModel({
    required this.id,
    required this.userId,
    this.fromUserId,
    this.postId,
    required this.type,
    required this.title,
    required this.message,
    required this.isRead,
    this.readAt,
    required this.createdAt,
    this.fromUserName,
    this.fromUsername,
    this.fromUserAvatarUrl,
    this.postFileUrl,
    this.postThumbnailUrl,
    this.postDisplayUrl,
    this.postType,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      id:                json['id'] ?? 0,
      userId:            json['user_id'] ?? 0,
      fromUserId:        json['from_user_id'],
      postId:            json['post_id'],
      type:              json['type'] ?? '',
      title:             json['title'] ?? '',
      message:           json['message'] ?? '',
      // ✅ Fix: int (0/1) aur bool dono handle karta hai
      isRead:            json['is_read'] == 1 || json['is_read'] == true,
      readAt:            json['read_at'],
      createdAt:         json['created_at'] ?? '',
      fromUserName:      json['from_user_name'],
      fromUsername:      json['from_username'],
      fromUserAvatarUrl: json['from_user_avatar_url'],
      postFileUrl:       json['post_file_url'],
      postThumbnailUrl:  json['post_thumbnail_url'],
      postDisplayUrl:    json['post_display_url'],
      postType:          json['post_type'],
    );
  }
}

// ─── Notification Controller ──────────────────────────────────────────────────
class NotificationController extends GetxController {

  RxBool isLoading     = false.obs;
  RxBool isMarkingRead = false.obs;
  RxInt  unreadCount   = 0.obs;
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;

  @override
  void onInit() {
    super.onInit();
    // ✅ Sirf yahan se fetch hoga — initState mein dobara call nahi hogi
    fetchNotifications();
  }

  // ─── FETCH NOTIFICATIONS ──────────────────────────────────────────────────
  Future<void> fetchNotifications() async {
    try {
      isLoading.value = true;

      final int? userId = await SessionManager.instance.getUserId();

      if (userId == null || userId == 0) {
        print('⚠️ NotificationController: userId nahi mila, 1 sec baad retry...');
        await Future.delayed(const Duration(seconds: 1));
        final int? retryId = await SessionManager.instance.getUserId();
        if (retryId == null || retryId == 0) {
          print('❌ NotificationController: Session still empty, skip.');
          return;
        }
        await _callApi(retryId);
        return;
      }

      await _callApi(userId);

    } catch (e) {
      print('❌ fetchNotifications unexpected error: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> _callApi(int userId) async {
    try {
      print('📡 Fetching notifications for user_id: $userId');

      final Response response = await ApiService.dio.post(
        'get-notifications',
        data: {"user_id": userId},
      );

      if (response.statusCode == 200) {
        final responseBody = response.data;

        if (responseBody['success'] == true) {
          // ✅ Fix: response.data['data'] se sahi tarah parse karo
          final Map<String, dynamic> data = responseBody['data'];

          unreadCount.value = data['unread_count'] ?? 0;

          final List<dynamic> rawList = data['notifications'] ?? [];
          notifications.value = rawList
              .map((item) => NotificationModel.fromJson(item as Map<String, dynamic>))
              .toList();

          print('✅ Notifications: ${notifications.length}, Unread: ${unreadCount.value}');
        } else {
          print('⚠️ API success false: ${responseBody['message']}');
        }
      }

    } on DioException catch (e) {
      final String msg = e.response?.data?['message'] ?? 'Failed to load notifications.';
      Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      print('❌ _callApi DioException: $e');
    }
  }

  // ─── MARK ALL AS READ ─────────────────────────────────────────────────────
  Future<void> markAllAsRead() async {
    if (unreadCount.value == 0) return;

    try {
      isMarkingRead.value = true;

      final int? userId = await SessionManager.instance.getUserId();
      if (userId == null || userId == 0) return;

      final Response response = await ApiService.dio.post(
        'mark-all-notifications-read',
        data: {"user_id": userId},
      );

      if (response.statusCode == 200 && response.data['success'] == true) {
        // ✅ Locally update — dobara API call nahi
        notifications.value = notifications.map((n) => NotificationModel(
          id:                n.id,
          userId:            n.userId,
          fromUserId:        n.fromUserId,
          postId:            n.postId,
          type:              n.type,
          title:             n.title,
          message:           n.message,
          isRead:            true,
          readAt:            n.readAt,
          createdAt:         n.createdAt,
          fromUserName:      n.fromUserName,
          fromUsername:      n.fromUsername,
          fromUserAvatarUrl: n.fromUserAvatarUrl,
          postFileUrl:       n.postFileUrl,
          postThumbnailUrl:  n.postThumbnailUrl,
          postDisplayUrl:    n.postDisplayUrl,
          postType:          n.postType,
        )).toList();

        unreadCount.value = 0;
        Get.snackbar('Done', 'All notifications marked as read.',
            snackPosition: SnackPosition.TOP);
        print('✅ All marked as read.');
      }

    } on DioException catch (e) {
      final String msg = e.response?.data?['message'] ?? 'Could not mark as read.';
      Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      print('❌ markAllAsRead error: $e');
    } finally {
      isMarkingRead.value = false;
    }
  }

  // ─── PULL TO REFRESH ─────────────────────────────────────────────────────
  Future<void> refreshNotifications() async {
    await fetchNotifications();
  }
}
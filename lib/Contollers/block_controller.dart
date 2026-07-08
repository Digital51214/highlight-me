import 'package:dio/dio.dart';
import 'package:get/get.dart' hide Response;
import '../Services/api_service.dart';
import '../Services/session_manager.dart';

// ═══════════════════════════════════════════════════════════════
//  Response Models
// ═══════════════════════════════════════════════════════════════

class BlockResponse {
  final bool success;
  final String message;

  BlockResponse({required this.success, required this.message});

  factory BlockResponse.fromJson(Map<String, dynamic> json) {
    return BlockResponse(
      success: json['success'] == true,
      message: json['message']?.toString() ?? '',
    );
  }
}

class BlockedUser {
  final int id;
  final String name;
  final String? email;
  final String? username;
  final String? avatar;
  final String? bio;
  final String? blockedAt;
  final String? avatarUrl;

  BlockedUser({
    required this.id,
    required this.name,
    this.email,
    this.username,
    this.avatar,
    this.bio,
    this.blockedAt,
    this.avatarUrl,
  });

  factory BlockedUser.fromJson(Map<String, dynamic> json) {
    return BlockedUser(
      id:        _parseInt(json['id']),
      name:      json['name']?.toString() ?? 'Unknown',
      email:     json['email']?.toString(),
      username:  json['username']?.toString(),
      avatar:    json['avatar']?.toString(),
      bio:       json['bio']?.toString(),
      blockedAt: json['blocked_at']?.toString(),
      avatarUrl: json['avatar_url']?.toString(),
    );
  }

  static int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is double) return val.toInt();
    return int.tryParse(val.toString()) ?? 0;
  }
}

// ═══════════════════════════════════════════════════════════════
//  BlockController
// ═══════════════════════════════════════════════════════════════
class BlockController extends GetxController {

  // ── Observable state ──
  final blockedUsers      = <BlockedUser>[].obs;
  final isLoadingBlocked  = false.obs;
  final isBlocking        = false.obs;
  final isUnblocking      = false.obs;

  // ── Kis specific user ID ko unblock kiya ja raha hai (per-tile loader ke liye) ──
  final unblockingUserId = Rxn<int>();

  // ── Blocked user IDs set — O(1) lookup ──
  // ChatListScreen mein quickly check kar sako koi blocked hai ya nahi
  final blockedUserIds = <int>{}.obs;

  // ─────────────────────────────────────────────
  //  Helper: SessionManager se user_id
  // ─────────────────────────────────────────────
  Future<int?> _getUserId() async {
    final id = await SessionManager.instance.getUserId();
    if (id == null) {
      Get.snackbar(
        'Session Expired',
        'Please login again.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    }
    return id;
  }

  // ─────────────────────────────────────────────
  //  DioException → user-friendly message
  // ─────────────────────────────────────────────
  String _dioErrorMessage(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return 'Request timed out. Please check your connection.';
      case DioExceptionType.connectionError:
        return 'No internet connection. Please try again.';
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode ?? 0;
        if (code == 401) return 'Session expired. Please login again.';
        if (code == 409) return e.response?.data?['message'] ?? 'User is already blocked.';
        if (code == 500) return 'Server error. Please try again later.';
        return e.response?.data?['message'] ?? 'Unexpected error (code $code).';
      default:
        return 'Network error. Please try again.';
    }
  }

  // ═══════════════════════════════════════════════════════════════
  //  1) BLOCK USER   →   POST /api/block-user
  // ═══════════════════════════════════════════════════════════════
  Future<BlockResponse?> blockUser({required int blockedUserId}) async {
    if (isBlocking.value) return null;

    try {
      isBlocking.value = true;
      final userId = await _getUserId();
      if (userId == null) return null;

      final response = await ApiService.dio.post(
        'block-user',
        data: {
          'user_id':         userId,
          'blocked_user_id': blockedUserId,
        },
      );

      final model = BlockResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (model.success) {
        // Locally blocked IDs mein add karo — instant UI update
        blockedUserIds.add(blockedUserId);
        blockedUserIds.refresh();

        Get.snackbar(
          'Blocked',
          model.message.isNotEmpty ? model.message : 'User has been blocked.',
        );
        return model;
      } else {
        // Already blocked ya koi aur error
        Get.snackbar(
          'Notice',
          model.message.isNotEmpty ? model.message : 'Could not block user.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
        return null;
      }

    } on DioException catch (e) {
      final msg = _dioErrorMessage(e);
      Get.snackbar(
        'Error',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isBlocking.value = false;
    }
  }

  // ═══════════════════════════════════════════════════════════════
  //  2) UNBLOCK USER   →   POST /api/unblock-user
  // ═══════════════════════════════════════════════════════════════
  Future<BlockResponse?> unblockUser({required int blockedUserId}) async {
    if (isUnblocking.value) return null;

    try {
      isUnblocking.value    = true;
      unblockingUserId.value = blockedUserId; // ✅ sirf isi tile ka loader chalega

      final userId = await _getUserId();
      if (userId == null) return null;

      final response = await ApiService.dio.post(
        'unblock-user',
        data: {
          'user_id':         userId,
          'blocked_user_id': blockedUserId,
        },
      );

      final model = BlockResponse.fromJson(
        response.data as Map<String, dynamic>,
      );

      if (model.success) {
        // ✅ blockedUsers list se remove karo — BlockedScreen turant update ho
        blockedUsers.removeWhere((u) => u.id == blockedUserId);
        blockedUsers.refresh();

        // ✅ blockedUserIds set se bhi remove karo — ChatListScreen turant update ho
        blockedUserIds.remove(blockedUserId);
        blockedUserIds.refresh();

        Get.snackbar(
          'Unblocked',
          model.message.isNotEmpty ? model.message : 'User has been unblocked.',
        );
        return model;
      } else {
        Get.snackbar(
          'Notice',
          model.message.isNotEmpty ? model.message : 'Could not unblock user.',
          snackPosition: SnackPosition.BOTTOM,
          duration: const Duration(seconds: 3),
        );
        return null;
      }

    } on DioException catch (e) {
      final msg = _dioErrorMessage(e);
      Get.snackbar(
        'Error',
        msg,
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return null;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    } finally {
      isUnblocking.value     = false;
      unblockingUserId.value = null;
    }
  }

  // ═══════════════════════════════════════════════════════════════
  //  3) GET BLOCKED USERS   →   POST /api/get-blocked-users
  // ═══════════════════════════════════════════════════════════════
  Future<void> fetchBlockedUsers() async {
    try {
      isLoadingBlocked.value = true;
      final userId = await _getUserId();
      if (userId == null) return;

      final response = await ApiService.dio.post(
        'blocked-users',
        data: {'user_id': userId},
      );

      final raw = response.data as Map<String, dynamic>;
      if (raw['success'] == true) {
        final data   = raw['data'] as Map<String, dynamic>;
        final rawList = data['blocked_users'] as List<dynamic>? ?? [];

        final users = rawList
            .whereType<Map>()
            .map((e) => BlockedUser.fromJson(Map<String, dynamic>.from(e)))
            .toList();

        blockedUsers.value   = users;
        // IDs set update karo
        blockedUserIds.value = users.map((u) => u.id).toSet();
        blockedUserIds.refresh();
      } else {
        Get.snackbar(
          'Error',
          raw['message']?.toString() ?? 'Could not fetch blocked users.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }

    } on DioException catch (e) {
      Get.snackbar(
        'Connection Error',
        _dioErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        'Something went wrong. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoadingBlocked.value = false;
    }
  }

  // ─────────────────────────────────────────────
  //  Helper: koi user blocked hai ya nahi
  // ─────────────────────────────────────────────
  bool isUserBlocked(int userId) => blockedUserIds.contains(userId);
}
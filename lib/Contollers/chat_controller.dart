import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;

import '../services/api_service.dart';
import '../services/session_manager.dart';

class ChatController extends GetxController {

  // ════════════════════════════════════════════════════════════
  //  Observable State
  // ════════════════════════════════════════════════════════════

  /// All conversations of logged-in user
  final conversations       = <Map<String, dynamic>>[].obs;

  /// Messages inside currently open conversation
  final messages            = <Map<String, dynamic>>[].obs;

  /// Meta of currently open conversation
  final currentConversation = <String, dynamic>{}.obs;

  // ── Loading flags ────────────────────────────────────────────
  final isLoadingConversations = false.obs;
  final isLoadingMessages      = false.obs;
  final isSendingMessage       = false.obs;
  final currentUserImg = ''.obs;

  // ════════════════════════════════════════════════════════════
  //  Private Helper: get logged-in user's ID from session
  //  (Same SessionManager used in AuthController)
  // ════════════════════════════════════════════════════════════

  Future<int?> _getUserId() async {
    final id = await SessionManager.instance.getUserId();
    if (id == null) {
      Get.snackbar(
        'Session Expired',
        'Please login again.',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    return id;
  }

  // ════════════════════════════════════════════════════════════
  //  API 20 ─ Start / Fetch Conversation
  //  POST /api/create-conversation
  //  Body : { user_id, other_user_id }
  //  Returns the conversation map so screen can navigate to chat
  // ════════════════════════════════════════════════════════════

  Future<Map<String, dynamic>?> createConversation({
    required int otherUserId,
  }) async {
    try {
      final userId = await _getUserId();
      if (userId == null) return null;

      final response = await ApiService.dio.post(
        'create-conversation',
        data: {
          'user_id'       : userId,
          'other_user_id' : otherUserId,
        },
      );

      if (response.data['success'] == true) {
        final conversation =
        response.data['data']['conversation'] as Map<String, dynamic>;
        currentConversation.value = conversation;
        return conversation;
      }

      Get.snackbar(
        'Error',
        response.data['message'] ?? 'Could not start conversation',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;

    } on DioException catch (e) {
      Get.snackbar(
        'Error',
        e.response?.data['message'] ?? 'Network error. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return null;
    }
  }

  // ════════════════════════════════════════════════════════════
  //  API 21 ─ Get My Conversations
  //  POST /api/my-conversations
  //  Body : { user_id }  ← auto-fetched from session
  //  Call on: Conversations list screen initState / onReady
  // ════════════════════════════════════════════════════════════

  Future<void> fetchMyConversations() async {
    int retryCount = 0;
    while (retryCount < 3) { // ✅ 3 baar try karega
      try {
        final userId = await _getUserId();
        if (userId == null) return;

        final avatar = await SessionManager.instance.getAvatar();
        print("🟣 CURRENT USER AVATAR: $avatar");
        currentUserImg.value = avatar ?? '';

        isLoadingConversations.value = true;

        final response = await ApiService.dio.post(
          'my-conversations',
          data: {'user_id': userId},
        );

        print("🟡 FULL RESPONSE: ${response.data}");
        print("🟡 SUCCESS VALUE: ${response.data['success']}");
        print("🟡 SUCCESS TYPE: ${response.data['success'].runtimeType}");

        if (response.data['success'] == true) {
          final rawData = response.data['data'];
          print("🟢 DATA: $rawData");

          final list = rawData['conversations'] as List<dynamic>;
          print("🟢 LIST LENGTH: ${list.length}");

          conversations.value = list.cast<Map<String, dynamic>>();
          print("🟢 CONVERSATIONS SET: ${conversations.length}");
          return; // ✅ Success — loop se bahar
        }

      } on DioException catch (e) {
        retryCount++;
        print("🔴 DIO ERROR (attempt $retryCount): ${e.message}");

        if (retryCount < 3) {
          print("🔄 Retry kar raha hai... ($retryCount/3)");
          await Future.delayed(const Duration(seconds: 2)); // 2 sec wait
        } else {
          Get.snackbar(
            'Connection Error',
            'Server se connection nahi ho raha. Please check internet.',
            snackPosition: SnackPosition.BOTTOM,
          );
        }
      } finally {
        isLoadingConversations.value = false;
      }
    }
  }

  Future<int?> getMyUserId() async {
    return await _getUserId();
  }

  // ════════════════════════════════════════════════════════════
  //  API 22 ─ Get Conversation Messages
  //  POST /api/conversation-messages
  //  Body : { conversation_id, user_id }  ← user_id auto from session
  //  Also auto-calls markMessagesRead after loading
  // ════════════════════════════════════════════════════════════

  Future<void> fetchMessages({
    required int conversationId,
    bool silent = false,   // ← polling ke liye silent mode
  }) async {
    try {
      final userId = await _getUserId();
      if (userId == null) return;

      // Pehli baar: loader show karo aur clear karo
      // Polling mein: kuch mat karo, silently update karo
      if (!silent) {
        isLoadingMessages.value = true;
        messages.clear();
      }

      final response = await ApiService.dio.post(
        'conversation-messages',
        data: {
          'conversation_id': conversationId,
          'user_id': userId,
        },
      );

      if (response.data['success'] == true) {
        final data = response.data['data'] as Map<String, dynamic>;

        currentConversation.value =
        data['conversation'] as Map<String, dynamic>;

        final list = data['messages'] as List<dynamic>;
        messages.value = list.cast<Map<String, dynamic>>();

        await markMessagesRead(conversationId: conversationId);
      }

    } on DioException catch (e) {
      if (!silent) {   // Error sirf pehli baar dikhao
        Get.snackbar(
          'Error',
          e.response?.data['message'] ?? 'Network error. Please try again.',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    } finally {
      isLoadingMessages.value = false;
    }
  }

  // ════════════════════════════════════════════════════════════
  //  API 23 ─ Send a Message
  //  POST /api/send-message  (multipart/form-data)
  //  Body : { conversation_id, sender_id, message, file? }
  //  sender_id ← auto from session, no need to pass manually
  // ════════════════════════════════════════════════════════════

  Future<bool> sendMessage({
    required int    conversationId,
    required String message,
    String?         filePath,     // optional: image / video local path
  }) async {
    try {
      final userId = await _getUserId();
      if (userId == null) return false;

      isSendingMessage.value = true;

      final formData = FormData.fromMap({
        'conversation_id' : conversationId,
        'sender_id'       : userId,
        'message'         : message,
        if (filePath != null)
          'file': await MultipartFile.fromFile(filePath),
      });

      final response = await ApiService.dio.post(
        'send-message',
        data: formData,
      );

      if (response.data['success'] == true) {
        final newMsg =
        response.data['data']['message'] as Map<String, dynamic>;

        // Append to messages → UI updates instantly (optimistic)
        messages.add(newMsg);

        // Sync last message preview in conversations list
        _updateLastMessage(
          conversationId: conversationId,
          lastMessage   : message,
        );

        return true;
      }

      Get.snackbar(
        'Error',
        response.data['message'] ?? 'Message not sent. Try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;

    } on DioException catch (e) {
      Get.snackbar(
        'Error',
        e.response?.data['message'] ?? 'Network error. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } finally {
      isSendingMessage.value = false;
    }
  }

  // ════════════════════════════════════════════════════════════
  //  API 24 ─ Mark Messages as Read
  //  POST /api/mark-messages-read
  //  Body : { user_id, conversation_id }  ← BOTH required by backend
  //  Called automatically by fetchMessages — no manual call needed
  // ════════════════════════════════════════════════════════════

  Future<void> markMessagesRead({required int conversationId}) async {
    try {
      final userId = await _getUserId();
      if (userId == null) return;

      final response = await ApiService.dio.post(
        'mark-messages-read',
        data: {
          'user_id'         : userId,
          'conversation_id' : conversationId, // ← required! (backend fix)
        },
      );

      if (response.data['success'] == true) {
        // Flip is_read flag locally → no extra API call needed
        for (int i = 0; i < messages.length; i++) {
          if (messages[i]['is_read'] == 0) {
            messages[i] = {...messages[i], 'is_read': 1};
          }
        }
        messages.refresh();

        // Clear unread badge on conversations list
        _updateUnreadCount(conversationId: conversationId, count: 0);
      }

    } on DioException catch (e) {
      // Silent fail ─ non-critical background action
      debugPrint('[ChatController] markMessagesRead failed: ${e.message}');
    }
  }

  // ════════════════════════════════════════════════════════════
  //  Private Helpers
  // ════════════════════════════════════════════════════════════

  /// After sending a message, update the preview in conversations list
  void _updateLastMessage({
    required int    conversationId,
    required String lastMessage,
  }) {
    final index =
    conversations.indexWhere((c) => c['id'] == conversationId);

    if (index != -1) {
      conversations[index] = {
        ...conversations[index],
        'last_message'    : lastMessage,
        'last_message_at': DateTime.now().toUtc().toIso8601String(),
      };
      conversations.refresh();
    }
  }

  /// Reset unread count badge for a conversation
  void _updateUnreadCount({
    required int conversationId,
    required int count,
  }) {
    final index =
    conversations.indexWhere((c) => c['id'] == conversationId);

    if (index != -1) {
      conversations[index] = {
        ...conversations[index],
        'unread_count': count,
      };
      conversations.refresh();
    }
  }

  // ════════════════════════════════════════════════════════════
  //  Cleanup  (call on screen dispose or logout)
  // ════════════════════════════════════════════════════════════

  /// Call when leaving chat detail screen
  void clearMessages() {
    messages.clear();
    currentConversation.value = {};
  }

  /// Call on logout (same pattern as AuthController)
  void clearAll() {
    conversations.clear();
    messages.clear();
    currentConversation.value = {};
  }
}
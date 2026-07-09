import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import '../Services/api_service.dart';
import '../Services/session_manager.dart';

// ═══════════════════════════════════════════════════════════════
//  StoryController
// ═══════════════════════════════════════════════════════════════
class StoryController extends GetxController {
  final RxBool isPosting = false.obs;

  Future<int?> _getUserId() async {
    final id = await SessionManager.instance.getUserId();
    debugPrint('[StoryController] user_id = $id');
    return id;
  }

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
        if (code == 403) return 'Access denied.';
        if (code == 413) return 'File too large. Try a shorter video.';
        if (code == 500) return 'Server error. Please try again later.';
        return 'Unexpected error (code $code).';
      default:
        return 'Network error. Please try again.';
    }
  }

  int _asInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is double) return val.toInt();
    return int.tryParse(val.toString()) ?? 0;
  }

  // ══════════════════════════════════════════════
  //  ADD STORY   →   POST /api/add-story
  //  ✅ FIX: success ke case mein ab yahan snackbar NAHI dikhate.
  //  Wajah — is method ke turant baad CreateStoryScreen Get.back()
  //  call karta hai, jis se snackbar (jo abhi camera screen pe
  //  overlay hoti hai) screen transition ke beech mein hi ghayab
  //  ho jaati thi aur user ko theek se dikhti nahi thi.
  //  Ab success snackbar HomeScreen dikhayega (jab wapas aa chuke
  //  ho) — is se woh properly visible rehti hai.
  //  Error snackbars yahin rehte hain — kyunki error hone pe user
  //  abhi bhi camera/preview screen pe hi hota hai, wahin dikhna theek hai.
  // ══════════════════════════════════════════════
  Future<bool> addStory({
    required File file,
    required String type,
  }) async {
    try {
      final userId = await _getUserId();
      if (userId == null) {
        Get.snackbar('Error', 'Session expired. Please login again.',
            snackPosition: SnackPosition.BOTTOM);
        return false;
      }

      isPosting.value = true;
      debugPrint('[StoryController] addStory — userId: $userId, type: $type, file: ${file.path}');

      final formData = FormData.fromMap({
        'user_id': userId,
        'type': type,
        'media': await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });

      final response = await ApiService.dio.post('add-story', data: formData);

      debugPrint('[StoryController] addStory status: ${response.statusCode}');
      debugPrint('[StoryController] addStory raw: ${response.data}');

      final success = response.data['success'] == true;
      final message = response.data['message']?.toString() ?? '';

      if (success) {
        // ✅ Yahan snackbar nahi — CreateStoryScreen navigate karega,
        // phir HomeScreen success snackbar dikhayega
        return true;
      }

      Get.snackbar('Error', message.isNotEmpty ? message : 'Could not post story.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } on DioException catch (e) {
      debugPrint('[StoryController] addStory DioError: ${e.response?.data}');
      final serverMsg = e.response?.data?['message']?.toString();
      Get.snackbar(
        'Connection Error',
        serverMsg?.isNotEmpty == true ? serverMsg! : _dioErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
      );
      return false;
    } catch (e) {
      debugPrint('[StoryController] addStory unknown: $e');
      Get.snackbar('Error', 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    } finally {
      isPosting.value = false;
    }
  }

  // ══════════════════════════════════════════════
  //  GET STORIES   →   POST /api/get-stories
  // ══════════════════════════════════════════════
  Future<List<Map<String, dynamic>>> getStories() async {
    try {
      final userId = await _getUserId();
      if (userId == null) return [];

      final response = await ApiService.dio.post('get-stories', data: {
        'user_id': userId,
      });

      debugPrint('[StoryController] getStories raw: ${response.data}');

      final data = response.data;
      if (data is Map && data['success'] == true) {
        final List<dynamic> storiesRaw =
            (data['data'] is Map ? data['data']['stories'] : null) ?? [];
        return storiesRaw
            .map((e) => Map<String, dynamic>.from(e as Map))
            .toList();
      }
      return [];
    } on DioException catch (e) {
      debugPrint('[StoryController] getStories DioError: ${e.response?.data}');
      return [];
    } catch (e) {
      debugPrint('[StoryController] getStories unknown: $e');
      return [];
    }
  }

  // ══════════════════════════════════════════════
  //  Flat stories list → per-user grouped list
  // ══════════════════════════════════════════════
  List<Map<String, dynamic>> groupStoriesByUser(
      List<Map<String, dynamic>> stories) {
    final Map<int, Map<String, dynamic>> grouped = {};

    for (final story in stories) {
      final userId = _asInt(story['user_id']);
      grouped.putIfAbsent(userId, () => {
        'user_id': userId,
        'user_name': story['user_name']?.toString() ?? 'User',
        'user_avatar_url': story['user_avatar_url']?.toString() ?? '',
        'stories': <Map<String, dynamic>>[],
      });
      (grouped[userId]!['stories'] as List<Map<String, dynamic>>).add(story);
    }

    for (final group in grouped.values) {
      (group['stories'] as List<Map<String, dynamic>>).sort((a, b) {
        final aDate =
            DateTime.tryParse(a['created_at']?.toString() ?? '') ?? DateTime(2000);
        final bDate =
            DateTime.tryParse(b['created_at']?.toString() ?? '') ?? DateTime(2000);
        return aDate.compareTo(bDate);
      });
    }

    final list = grouped.values.toList();
    list.sort((a, b) {
      final aStories = a['stories'] as List<Map<String, dynamic>>;
      final bStories = b['stories'] as List<Map<String, dynamic>>;
      final aLatest = aStories.isNotEmpty
          ? DateTime.tryParse(aStories.last['created_at']?.toString() ?? '') ??
          DateTime(2000)
          : DateTime(2000);
      final bLatest = bStories.isNotEmpty
          ? DateTime.tryParse(bStories.last['created_at']?.toString() ?? '') ??
          DateTime(2000)
          : DateTime(2000);
      return bLatest.compareTo(aLatest);
    });

    return list;
  }
}
//
// import 'dart:io';
// import 'package:dio/dio.dart';
// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart' hide Response, MultipartFile, FormData;
// import '../Services/api_service.dart';
// import '../Services/session_manager.dart';
// import '../core/models/post_analytics.dart';
//
// class PostController {
//
//   // ─────────────────────────────────────────────
//   //  SessionManager se user_id uthao
//   // ─────────────────────────────────────────────
//   static Future<int> _getUserId() async {
//     final id = await SessionManager.instance.getUserId() ?? 0;
//     debugPrint('[PostController] user_id = $id');
//     return id;
//   }
//
//   // ══════════════════════════════════════════════
//   //  1) POST A MOMENT   →   POST api/post-moment
//   // ══════════════════════════════════════════════
//   static Future<Map<String, dynamic>> addPost({
//     required File file,
//     required String type,
//     required String caption,
//     String? tags,
//   }) async {
//     try {
//       final userId = await _getUserId();
//       debugPrint('[PostController] start — type: $type, caption: $caption');
//
//       final formData = FormData.fromMap({
//         'user_id': userId,
//         'type': type,
//         'caption': caption,
//         'file': await MultipartFile.fromFile(
//           file.path,
//           filename: file.path.split('/').last,
//         ),
//         if (tags != null && tags.isNotEmpty) 'tags': tags,
//       });
//
//       final response = await ApiService.dio.post('post-moment', data: formData);
//       debugPrint('[PostController] response: ${response.statusCode}');
//
//       if (response.statusCode == 200 ||
//           response.statusCode == 201 ||
//           response.data['success'] == true) {
//         return {'status': true, 'data': response.data['data']};
//       } else {
//         return {
//           'status': false,
//           'message': response.data['message'] ?? 'Error occurred'
//         };
//       }
//     } on DioException catch (e) {
//       debugPrint('[PostController] DioError: ${e.response?.data}');
//       final serverMsg = e.response?.data?['message']?.toString() ??
//           'Validation Failed or Network Error.';
//       return {'status': false, 'message': serverMsg};
//     } catch (e) {
//       debugPrint('[PostController] unknown error: $e');
//       return {
//         'status': false,
//         'message': 'Something went wrong. Please try again.'
//       };
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  2) POST A STORY   →   POST api/add-story
//   // ══════════════════════════════════════════════
//   static Future<bool> addStory({
//     required File file,
//     required String type,
//   }) async {
//     try {
//       final userId = await _getUserId();
//
//       final formData = FormData.fromMap({
//         'user_id': userId,
//         'type': type,
//         'file': await MultipartFile.fromFile(
//           file.path,
//           filename: file.path.split('/').last,
//         ),
//       });
//
//       final response =
//       await ApiService.dio.post('add-story', data: formData);
//       return response.statusCode == 200 || response.statusCode == 201;
//     } on DioException catch (e) {
//       debugPrint('addStory error: ${e.response?.data}');
//       Get.snackbar(
//         'Error',
//         'Failed to post story.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  3) GET USER MEMORIES   →   GET api/memories
//   // ══════════════════════════════════════════════
//   static Future<Map<String, dynamic>?> getUserMemories({
//     required int year,
//     int? month,
//     String? tag,
//   }) async {
//     try {
//       final userId = await _getUserId();
//       final queryParams = <String, dynamic>{
//         'user_id': userId,
//         'year': year,
//         if (month != null) 'month': month,
//         if (tag != null && tag.isNotEmpty) 'tag': tag,
//       };
//
//       final response = await ApiService.dio.get(
//         'memories',
//         queryParameters: queryParams,
//       );
//
//       if (response.statusCode == 200 && response.data != null) {
//         final body = response.data;
//         if (body is Map<String, dynamic>) {
//           return body['data'] ?? body;
//         }
//       }
//       return null;
//     } on DioException catch (e) {
//       debugPrint('[PostController] getUserMemories DioError: ${e.response?.data}');
//       return null;
//     } catch (e) {
//       debugPrint('[PostController] getUserMemories unknown error: $e');
//       return null;
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  4) DELETE POST   →   DELETE api/delete-post
//   // ══════════════════════════════════════════════
//   static Future<bool> deletePost({required int postId}) async {
//     try {
//       final userId = await _getUserId();
//       final response = await ApiService.dio.delete(
//         'delete-post',
//         data: {'user_id': userId, 'post_id': postId},
//       );
//       return response.statusCode == 200;
//     } on DioException catch (e) {
//       debugPrint('[PostController] deletePost error: ${e.response?.data}');
//       return false;
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  5) AUTH TOKEN
//   // ══════════════════════════════════════════════
//   static void setAuthToken(String token) {
//     ApiService.dio.options.headers['Authorization'] = 'Bearer $token';
//     debugPrint('[PostController] Auth token set.');
//   }
//
//   // ══════════════════════════════════════════════
//   //  6) VIEW A POST   →   POST api/view-post
//   // ══════════════════════════════════════════════
//   static Future<void> viewPost({required int postId}) async {
//     try {
//       final userId = await _getUserId();
//       await ApiService.dio
//           .post('view-post', data: {'post_id': postId, 'user_id': userId});
//     } catch (e) {
//       debugPrint('viewPost error: $e');
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  7) LIKE / DISLIKE   →   POST api/like-dislike-post
//   // ══════════════════════════════════════════════
//   static Future<bool> likeDislikePost({required int postId}) async {
//     try {
//       final userId = await _getUserId();
//       final response = await ApiService.dio.post(
//         'share-post',
//         data: {'post_id': postId, 'user_id': userId},
//       );
//       return response.statusCode == 200;
//     } on DioException catch (e) {
//       debugPrint('likeDislike error: ${e.response?.data}');
//       return false;
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  8) ADD COMMENT   →   POST api/add-comment
//   // ══════════════════════════════════════════════
//   static Future<bool> addComment({
//     required int postId,
//     required String comment,
//   }) async {
//     try {
//       if (comment.trim().isEmpty) return false;
//       final userId = await _getUserId();
//       final response = await ApiService.dio.post(
//         'share-post',
//         data: {
//           'post_id': postId,
//           'user_id': userId,
//           'comment': comment.trim(),
//         },
//       );
//       return response.statusCode == 200;
//     } on DioException catch (e) {
//       debugPrint('addComment error: ${e.response?.data}');
//       Get.snackbar(
//         'Error',
//         'Failed to post comment.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  9) SHARE A POST   →   POST api/share-post
//   // ══════════════════════════════════════════════
//   static Future<void> sharePost({required int postId}) async {
//     try {
//       final userId = await _getUserId();
//       await ApiService.dio.post(
//         'share-post',
//         data: {'post_id': postId, 'user_id': userId},
//       );
//     } on DioException catch (e) {
//       debugPrint('sharePost error: ${e.response?.data}');
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  10) POST FEED   →   POST api/feed-posts
//   // ══════════════════════════════════════════════
//   static Future<List<Map<String, dynamic>>> getPostFeed({
//     int limit = 6,
//     int offset = 0,
//   }) async {
//     try {
//       final userId = await _getUserId();
//       final response = await ApiService.dio.post(
//         'feed-posts',
//         data: {'user_id': userId, 'limit': limit, 'offset': offset},
//       );
//       if (response.statusCode == 200) {
//         final raw = response.data as Map<String, dynamic>;
//         final data =
//         (raw['data'] is Map) ? raw['data'] as Map<String, dynamic> : {};
//         final posts = data['posts'];
//         if (posts is List) {
//           return posts.map((e) => Map<String, dynamic>.from(e)).toList();
//         }
//       }
//       return [];
//     } on DioException catch (e) {
//       debugPrint('getPostFeed error: ${e.response?.data}');
//       return [];
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  11) POST ANALYTICS   →   POST api/post-analytics
//   //  ✅ UPDATED — proper model + snackbar + logging
//   // ══════════════════════════════════════════════
//   static Future<PostAnalyticsModel?> getPostAnalytics({
//     String type = 'latest',
//   }) async {
//     try {
//       final userId = await _getUserId();
//       debugPrint('[PostController] getPostAnalytics — type: $type, userId: $userId');
//
//       final response = await ApiService.dio.post(
//         'post-analytics',
//         data: {'user_id': userId, 'type': type},
//       );
//
//       debugPrint('[PostController] analytics status: ${response.statusCode}');
//       debugPrint('[PostController] analytics raw: ${response.data}');
//
//       if (response.statusCode == 200 && response.data != null) {
//         final model = PostAnalyticsModel.fromJson(
//           response.data as Map<String, dynamic>,
//         );
//
//         if (model.success) {
//           debugPrint(
//             '[PostController] analytics parsed — '
//                 'posts: ${model.data?.posts.length}, '
//                 'likes: ${model.data?.summary.totalLikes}, '
//                 'comments: ${model.data?.summary.totalComments}, '
//                 'shares: ${model.data?.summary.totalShares}',
//           );
//           return model;
//         } else {
//           // API ne success: false bheja
//           debugPrint('[PostController] analytics success=false: ${model.message}');
//           Get.snackbar(
//             'Analytics',
//             model.message.isNotEmpty
//                 ? model.message
//                 : 'Could not load analytics.',
//             snackPosition: SnackPosition.BOTTOM,
//             duration: const Duration(seconds: 3),
//           );
//           return null;
//         }
//       }
//
//       // Non-200 status
//       debugPrint('[PostController] analytics unexpected status: ${response.statusCode}');
//       Get.snackbar(
//         'Error',
//         'Failed to load post analytics. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 3),
//       );
//       return null;
//
//     } on DioException catch (e) {
//       final statusCode = e.response?.statusCode;
//       final serverMsg  = e.response?.data?['message']?.toString();
//
//       debugPrint('[PostController] analytics DioError ($statusCode): ${e.response?.data}');
//
//       // Network ya server error
//       final userMsg = serverMsg?.isNotEmpty == true
//           ? serverMsg!
//           : _dioErrorMessage(e);
//
//       Get.snackbar(
//         'Connection Error',
//         userMsg,
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 4),
//       );
//       return null;
//
//     } catch (e) {
//       debugPrint('[PostController] analytics unknown error: $e');
//       Get.snackbar(
//         'Error',
//         'Something went wrong. Please try again.',
//         snackPosition: SnackPosition.BOTTOM,
//         duration: const Duration(seconds: 3),
//       );
//       return null;
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  12) ARCHIVE POST   →   POST api/archive-post
//   // ══════════════════════════════════════════════
//   static Future<bool> archivePost({required int postId}) async {
//     try {
//       final userId = await _getUserId();
//       final response = await ApiService.dio.post(
//         'archive-post',
//         data: {'post_id': postId, 'user_id': userId},
//       );
//       return response.statusCode == 200;
//     } on DioException catch (e) {
//       debugPrint('archivePost error: ${e.response?.data}');
//       Get.snackbar(
//         'Error',
//         'Failed to archive post.',
//         snackPosition: SnackPosition.BOTTOM,
//       );
//       return false;
//     }
//   }
//
//   // ══════════════════════════════════════════════
//   //  13) GET ARCHIVED POSTS   →   POST api/get-archived-posts
//   // ══════════════════════════════════════════════
//   static Future<Map<String, dynamic>?> getArchivedPosts() async {
//     try {
//       final userId = await _getUserId();
//       final response = await ApiService.dio.post(
//         'get-archived-posts',
//         data: {'user_id': userId},
//       );
//       if (response.statusCode == 200) {
//         final raw = response.data as Map<String, dynamic>;
//         return (raw['data'] is Map)
//             ? Map<String, dynamic>.from(raw['data'])
//             : null;
//       }
//       return null;
//     } on DioException catch (e) {
//       debugPrint('getArchivedPosts error: ${e.response?.data}');
//       return null;
//     }
//   }
//
//   // ─────────────────────────────────────────────
//   //  DioException → user-friendly message
//   // ─────────────────────────────────────────────
//   static String _dioErrorMessage(DioException e) {
//     switch (e.type) {
//       case DioExceptionType.connectionTimeout:
//       case DioExceptionType.sendTimeout:
//       case DioExceptionType.receiveTimeout:
//         return 'Request timed out. Please check your connection.';
//       case DioExceptionType.connectionError:
//         return 'No internet connection. Please try again.';
//       case DioExceptionType.badResponse:
//         final code = e.response?.statusCode ?? 0;
//         if (code == 401) return 'Session expired. Please login again.';
//         if (code == 403) return 'Access denied.';
//         if (code == 500) return 'Server error. Please try again later.';
//         return 'Unexpected error (code $code).';
//       default:
//         return 'Network error. Please try again.';
//     }
//   }
// }
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart' hide Response, MultipartFile, FormData;
import '../Services/api_service.dart';
import '../Services/session_manager.dart';
import '../core/models/post_analytics.dart';

// ═══════════════════════════════════════════════════════════════
//  Response Models
// ═══════════════════════════════════════════════════════════════

class SharePostResponse {
  final bool success;
  final String message;
  final int postId;
  final int sharesCount;

  SharePostResponse({
    required this.success,
    required this.message,
    required this.postId,
    required this.sharesCount,
  });

  factory SharePostResponse.fromJson(Map<String, dynamic> json) {
    final data = json['data'];
    return SharePostResponse(
      success:     json['success'] == true,
      message:     json['message']?.toString() ?? '',
      postId:      _parseInt(data?['post_id']),
      sharesCount: _parseInt(data?['shares_count']),
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
//  PostController
// ═══════════════════════════════════════════════════════════════
class PostController {

  // ─────────────────────────────────────────────
  //  SessionManager se user_id uthao
  // ─────────────────────────────────────────────
  static Future<int> _getUserId() async {
    final id = await SessionManager.instance.getUserId() ?? 0;
    debugPrint('[PostController] user_id = $id');
    return id;
  }

  // ─────────────────────────────────────────────
  //  DioException → user-friendly message
  // ─────────────────────────────────────────────
  static String _dioErrorMessage(DioException e) {
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
        if (code == 500) return 'Server error. Please try again later.';
        return 'Unexpected error (code $code).';
      default:
        return 'Network error. Please try again.';
    }
  }

  // ══════════════════════════════════════════════
  //  1) POST A MOMENT
  // ══════════════════════════════════════════════
  static Future<Map<String, dynamic>> addPost({
    required File file,
    required String type,
    required String caption,
    String? tags,
  }) async {
    try {
      final userId = await _getUserId();
      final formData = FormData.fromMap({
        'user_id': userId,
        'type':    type,
        'caption': caption,
        'file':    await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
        if (tags != null && tags.isNotEmpty) 'tags': tags,
      });
      final response = await ApiService.dio.post('post-moment', data: formData);
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.data['success'] == true) {
        return {'status': true, 'data': response.data['data']};
      }
      return {'status': false, 'message': response.data['message'] ?? 'Error occurred'};
    } on DioException catch (e) {
      final msg = e.response?.data?['message']?.toString() ?? 'Validation Failed or Network Error.';
      return {'status': false, 'message': msg};
    } catch (e) {
      return {'status': false, 'message': 'Something went wrong. Please try again.'};
    }
  }

  // ══════════════════════════════════════════════
  //  2) POST A STORY
  // ══════════════════════════════════════════════
  static Future<bool> addStory({
    required File file,
    required String type,
  }) async {
    try {
      final userId = await _getUserId();
      final formData = FormData.fromMap({
        'user_id': userId,
        'type':    type,
        'file':    await MultipartFile.fromFile(
          file.path,
          filename: file.path.split('/').last,
        ),
      });
      final response = await ApiService.dio.post('add-story', data: formData);
      return response.statusCode == 200 || response.statusCode == 201;
    } on DioException catch (e) {
      debugPrint('addStory error: ${e.response?.data}');
      Get.snackbar('Error', 'Failed to post story.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  // ══════════════════════════════════════════════
  //  3) GET USER MEMORIES
  // ══════════════════════════════════════════════
  static Future<Map<String, dynamic>?> getUserMemories({
    required int year,
    int? month,
    String? tag,
  }) async {
    try {
      final userId = await _getUserId();
      final response = await ApiService.dio.get('memories', queryParameters: {
        'user_id': userId,
        'year':    year,
        if (month != null) 'month': month,
        if (tag != null && tag.isNotEmpty) 'tag': tag,
      });
      if (response.statusCode == 200 && response.data != null) {
        final body = response.data;
        if (body is Map<String, dynamic>) return body['data'] ?? body;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('getUserMemories error: ${e.response?.data}');
      return null;
    }
  }

  // ══════════════════════════════════════════════
  //  4) DELETE POST
  // ══════════════════════════════════════════════
  static Future<bool> deletePost({required int postId}) async {
    try {
      final userId  = await _getUserId();
      final response = await ApiService.dio.delete(
        'delete-post',
        data: {'user_id': userId, 'post_id': postId},
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      debugPrint('deletePost error: ${e.response?.data}');
      return false;
    }
  }

  // ══════════════════════════════════════════════
  //  5) AUTH TOKEN
  // ══════════════════════════════════════════════
  static void setAuthToken(String token) {
    ApiService.dio.options.headers['Authorization'] = 'Bearer $token';
  }

  // ══════════════════════════════════════════════
  //  6) VIEW A POST
  // ══════════════════════════════════════════════
  static Future<void> viewPost({required int postId}) async {
    try {
      final userId = await _getUserId();
      await ApiService.dio.post('view-post',
          data: {'post_id': postId, 'user_id': userId});
    } catch (e) {
      debugPrint('viewPost error: $e');
    }
  }

  // ══════════════════════════════════════════════
  //  7) LIKE / DISLIKE   →   POST /api/share-post
  //  ✅ Toggle locally + API call + updated count return
  // ══════════════════════════════════════════════
  static Future<SharePostResponse?> likeDislikePost({
    required int postId,
  }) async {
    try {
      final userId = await _getUserId();
      debugPrint('[PostController] likeDislike — postId: $postId');

      final response = await ApiService.dio.post(
        'share-post',
        data: {'post_id': postId, 'user_id': userId},
      );

      debugPrint('[PostController] likeDislike status: ${response.statusCode}');
      debugPrint('[PostController] likeDislike raw: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final model = SharePostResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (model.success) {
          debugPrint('[PostController] like success — sharesCount: ${model.sharesCount}');
          return model;
        } else {
          Get.snackbar(
            'Error',
            model.message.isNotEmpty ? model.message : 'Could not process like.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          return null;
        }
      }
      return null;
    } on DioException catch (e) {
      debugPrint('[PostController] likeDislike DioError: ${e.response?.data}');
      Get.snackbar(
        'Connection Error',
        _dioErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return null;
    } catch (e) {
      debugPrint('[PostController] likeDislike unknown: $e');
      Get.snackbar('Error', 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  // ══════════════════════════════════════════════
  //  8) ADD COMMENT   →   POST /api/share-post
  //  ✅ comment field extra bhejo — proper response + error
  // ══════════════════════════════════════════════
  static Future<SharePostResponse?> addComment({
    required int postId,
    required String comment,
  }) async {
    try {
      if (comment.trim().isEmpty) {
        Get.snackbar('Oops', 'Comment cannot be empty.',
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }

      final userId = await _getUserId();
      debugPrint('[PostController] addComment — postId: $postId, comment: $comment');

      final response = await ApiService.dio.post(
        'share-post',
        data: {
          'post_id': postId,
          'user_id': userId,
          'comment': comment.trim(),
        },
      );

      debugPrint('[PostController] addComment status: ${response.statusCode}');
      debugPrint('[PostController] addComment raw: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final model = SharePostResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (model.success) {
          Get.snackbar(
            'Comment Posted',
            model.message.isNotEmpty
                ? model.message
                : 'Your comment has been posted.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 2),
          );
          return model;
        } else {
          Get.snackbar(
            'Error',
            model.message.isNotEmpty ? model.message : 'Could not post comment.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          return null;
        }
      }
      return null;
    } on DioException catch (e) {
      debugPrint('[PostController] addComment DioError: ${e.response?.data}');
      final serverMsg = e.response?.data?['message']?.toString();
      Get.snackbar(
        'Connection Error',
        serverMsg?.isNotEmpty == true ? serverMsg! : _dioErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return null;
    } catch (e) {
      debugPrint('[PostController] addComment unknown: $e');
      Get.snackbar('Error', 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  // ══════════════════════════════════════════════
  //  9) SHARE A POST   →   POST /api/share-post
  //  ✅ share_plus se native share + API count update
  // ══════════════════════════════════════════════
  static Future<SharePostResponse?> sharePost({
    required int postId,
  }) async {
    try {
      final userId = await _getUserId();
      debugPrint('[PostController] sharePost — postId: $postId');

      final response = await ApiService.dio.post(
        'share-post',
        data: {'post_id': postId, 'user_id': userId},
      );

      debugPrint('[PostController] sharePost status: ${response.statusCode}');
      debugPrint('[PostController] sharePost raw: ${response.data}');

      if (response.statusCode == 200 && response.data != null) {
        final model = SharePostResponse.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (model.success) {
          debugPrint('[PostController] share success — sharesCount: ${model.sharesCount}');
          return model;
        } else {
          Get.snackbar(
            'Error',
            model.message.isNotEmpty ? model.message : 'Could not share post.',
            snackPosition: SnackPosition.BOTTOM,
            duration: const Duration(seconds: 3),
          );
          return null;
        }
      }
      return null;
    } on DioException catch (e) {
      debugPrint('[PostController] sharePost DioError: ${e.response?.data}');
      Get.snackbar(
        'Connection Error',
        _dioErrorMessage(e),
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(seconds: 3),
      );
      return null;
    } catch (e) {
      debugPrint('[PostController] sharePost unknown: $e');
      Get.snackbar('Error', 'Something went wrong.',
          snackPosition: SnackPosition.BOTTOM);
      return null;
    }
  }

  // ══════════════════════════════════════════════
  static Future<List<Map<String, dynamic>>> getPostFeed({
    int limit = 20,
    int offset = 0,
  }) async {
    try {
      final userId  = await _getUserId();
      final response = await ApiService.dio.post(
        'feed-posts',
        data: {'user_id': userId, 'limit': limit, 'offset': offset},
      );
      if (response.statusCode == 200) {
        final raw  = response.data as Map<String, dynamic>;
        final data = (raw['data'] is Map) ? raw['data'] as Map<String, dynamic> : {};
        final posts = data['posts'];
        if (posts is List) {
          final result = posts.map((e) => Map<String, dynamic>.from(e)).toList();
          debugPrint('[DEBUG] First post full data: ${result.isNotEmpty ? result[0] : "empty"}');
          return result;
        }
      }
      return [];
    } on DioException catch (e) {
      debugPrint('getPostFeed error: ${e.response?.data}');
      return [];
    }
  }

  // ══════════════════════════════════════════════
  //  11) POST ANALYTICS
  // ══════════════════════════════════════════════
  static Future<PostAnalyticsModel?> getPostAnalytics({
    String type = 'latest',
  }) async {
    try {
      final userId  = await _getUserId();
      final response = await ApiService.dio.post(
        'post-analytics',
        data: {'user_id': userId, 'type': type},
      );
      if (response.statusCode == 200 && response.data != null) {
        final model = PostAnalyticsModel.fromJson(
          response.data as Map<String, dynamic>,
        );
        if (model.success) return model;
        Get.snackbar('Analytics', model.message,
            snackPosition: SnackPosition.BOTTOM);
        return null;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('getPostAnalytics error: ${e.response?.data}');
      Get.snackbar('Connection Error', _dioErrorMessage(e),
          snackPosition: SnackPosition.BOTTOM);
      return null;
    } catch (e) {
      debugPrint('getPostAnalytics unknown: $e');
      return null;
    }
  }

  // ══════════════════════════════════════════════
  //  12) ARCHIVE POST
  // ══════════════════════════════════════════════
  static Future<bool> archivePost({required int postId}) async {
    try {
      final userId  = await _getUserId();
      final response = await ApiService.dio.post(
        'archive-post',
        data: {'post_id': postId, 'user_id': userId},
      );
      return response.statusCode == 200;
    } on DioException catch (e) {
      debugPrint('archivePost error: ${e.response?.data}');
      Get.snackbar('Error', 'Failed to archive post.',
          snackPosition: SnackPosition.BOTTOM);
      return false;
    }
  }

  // ══════════════════════════════════════════════
  //  13) GET ARCHIVED POSTS
  // ══════════════════════════════════════════════
  static Future<Map<String, dynamic>?> getArchivedPosts() async {
    try {
      final userId  = await _getUserId();
      final response = await ApiService.dio.post(
        'get-archived-posts',
        data: {'user_id': userId},
      );
      if (response.statusCode == 200) {
        final raw = response.data as Map<String, dynamic>;
        return (raw['data'] is Map)
            ? Map<String, dynamic>.from(raw['data'])
            : null;
      }
      return null;
    } on DioException catch (e) {
      debugPrint('getArchivedPosts error: ${e.response?.data}');
      return null;
    }
  }
}
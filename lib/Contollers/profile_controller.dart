//
// import 'package:dio/dio.dart';
// import 'package:get/get.dart' hide Response;
// import '../Services/api_service.dart';
// import '../Services/session_manager.dart';
// import '../Contollers/auth_controller.dart';
//
// class ProfileController extends GetxController {
//   static final Dio _dio = ApiService.dio;
//
//   static Future<int> _getLoggedInUserId() async {
//     final userId = await SessionManager.instance.getUserId();
//     if (userId == null) {
//       throw Exception('No active session found. Please login again.');
//     }
//     return userId;
//   }
//
//   static Future<bool> editProfile({
//     required String name,
//     required String bio,
//     String? avatarBase64,
//     String? avatarLocalPath,
//   }) async {
//     final userId = await _getLoggedInUserId();
//
//     final response = await _dio.post(
//       'update-profile',
//       data: {
//         'user_id': userId,
//         'name': name,
//         'bio': bio,
//         if (avatarBase64 != null) 'avatar': avatarBase64,
//       },
//     );
//
//     if (response.statusCode == 200) {
//       print('Update profile response: ${response.data}');
//       String finalName = name;
//       String finalBio = bio;
//       String? finalAvatar = avatarBase64;
//
//       try {
//         if (response.data is Map<String, dynamic>) {
//           final raw = response.data as Map<String, dynamic>;
//           final outer = (raw['data'] is Map<String, dynamic>) ? raw['data'] as Map<String, dynamic> : raw;
//           final userData = (outer['user'] is Map<String, dynamic>) ? outer['user'] as Map<String, dynamic> : outer;
//
//           finalName = userData['name'] ?? userData['full_name'] ?? name;
//           finalBio = userData['bio'] ?? bio;
//           finalAvatar = userData['avatar'] ?? avatarBase64;
//         }
//       } catch (_) {}
//
//       await SessionManager.instance.saveSession(
//         userId: userId,
//         fullName: finalName,
//         bio: finalBio,
//         avatar: finalAvatar,
//       );
//
//       if (Get.isRegistered<AuthController>()) {
//         final auth = Get.find<AuthController>();
//         auth.userName.value = finalName;
//         if (avatarLocalPath != null) auth.userAvatarLocalPath.value = avatarLocalPath;
//         auth.userBio.value = finalBio;
//         if (finalAvatar != null) auth.userAvatar.value = finalAvatar;
//       }
//       return true;
//     }
//     return false;
//   }
//
//   RxBool isLoading = false.obs;
//   var oldPasswordError = RxnString();
//   var newPasswordError = RxnString();
//   var confirmPasswordError = RxnString();
//
//   void validateAndChangePassword({required String oldPassword, required String newPassword, required String confirmPassword}) {
//     oldPasswordError.value = null; newPasswordError.value = null; confirmPasswordError.value = null;
//     bool isValid = true;
//     if (oldPassword.isEmpty) { oldPasswordError.value = "Old password is required"; isValid = false; }
//     if (newPassword.isEmpty) { newPasswordError.value = "New password is required"; isValid = false; }
//     else if (newPassword.length < 6) { newPasswordError.value = "Password must be at least 6 characters"; isValid = false; }
//     if (confirmPassword.isEmpty) { confirmPasswordError.value = "Please confirm your new password"; isValid = false; }
//     else if (newPassword != confirmPassword) { confirmPasswordError.value = "Passwords do not match"; isValid = false; }
//
//     if (isValid) { _changePasswordApi(oldPassword: oldPassword, newPassword: newPassword); }
//   }
//
//   Future<void> _changePasswordApi({required String oldPassword, required String newPassword}) async {
//     try {
//       isLoading.value = true;
//       final userId = await _getLoggedInUserId();
//       Response response = await _dio.post('change-password', data: {'user_id': userId, 'old_password': oldPassword, 'new_password': newPassword});
//       if (response.statusCode == 200) {
//         Get.snackbar('Success', response.data['message'] ?? 'Password changed successfully!');
//         await Future.delayed(const Duration(milliseconds: 300)); Get.back();
//       }
//     } on DioException catch (e) {
//       String errorMessage = 'Failed to change password. Please check your inputs.';
//       if (e.response != null && e.response?.data != null) {
//         if (e.response?.statusCode == 422) {
//           var errors = e.response?.data['errors'];
//           errorMessage = errors is Map ? errors.values.first[0] : (e.response?.data['message'] ?? errorMessage);
//         } else { errorMessage = e.response?.data['message'] ?? errorMessage; }
//       }
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     } finally { isLoading.value = false; }
//   }
//
//   static Future<void> getProfileStats() async {
//     try {
//       final userId = await _getLoggedInUserId();
//       final response = await _dio.post('user-profile-stats', data: {'user_id': userId});
//       if (response.statusCode == 200 && Get.isRegistered<AuthController>()) {
//         final auth = Get.find<AuthController>();
//         final raw = response.data as Map<String, dynamic>;
//         final data = (raw['data'] is Map) ? raw['data'] as Map<String, dynamic> : raw;
//         auth.likesCount.value = _parseInt(data['likes'] ?? data['likes_count'] ?? data['total_likes'] ?? 0);
//         auth.commentsCount.value = _parseInt(data['comments'] ?? data['comments_count'] ?? 0);
//         auth.sharesCount.value = _parseInt(data['shares'] ?? data['shares_count'] ?? 0);
//         auth.foodSupport.value = _parseInt(data['food_support'] ?? 0);
//         auth.transportSupport.value = _parseInt(data['transport_support'] ?? 0);
//         auth.cashReward.value = _parseInt(data['cash_reward'] ?? 0);
//       }
//     } catch (e) { print('Stats error: $e'); }
//   }
//
//   static Future<void> getProfileStatsWithRank() async {
//     try {
//       final userId = await _getLoggedInUserId();
//       final response = await _dio.post('user-profile-stats-with-rank', data: {'user_id': userId});
//       if (response.statusCode == 200 && Get.isRegistered<AuthController>()) {
//         final auth = Get.find<AuthController>();
//         final raw = response.data as Map<String, dynamic>;
//         final data = (raw['data'] is Map) ? raw['data'] as Map<String, dynamic> : raw;
//         auth.userRank.value = _parseInt(data['rank'] ?? data['user_rank'] ?? data['ranking'] ?? 0);
//       }
//     } catch (e) { print('Stats+rank error: $e'); }
//   }
//
//   static int _parseInt(dynamic val) {
//     if (val == null) return 0;
//     if (val is int) return val;
//     if (val is double) return val.toInt();
//     return int.tryParse(val.toString()) ?? 0;
//   }
// }
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart' hide Response;
import '../Services/api_service.dart';
import '../Services/session_manager.dart';
import '../Contollers/auth_controller.dart';

class ProfileController extends GetxController {
  static final Dio _dio = ApiService.dio;

  // ✅ Base URL — relative path ko full URL banane ke liye
  static const String _baseUrl = 'https://highlightapp.io/';

  static Future<int> _getLoggedInUserId() async {
    final userId = await SessionManager.instance.getUserId();
    if (userId == null) {
      throw Exception('No active session found. Please login again.');
    }
    return userId;
  }

  // ✅ Helper: Relative path ko Full URL banata hai
  static String? _buildFullAvatarUrl(String? rawAvatar) {
    if (rawAvatar == null || rawAvatar.isEmpty) return null;
    if (rawAvatar.startsWith('http')) return rawAvatar; // Pehle se full URL
    return '$_baseUrl$rawAvatar'; // "uploads/users/xyz.jpg" → full URL
  }

  static Future<bool> editProfile({
    required String name,
    required String bio,
    String? avatarBase64,
    String? avatarLocalPath,
  }) async {
    final userId = await _getLoggedInUserId();

    final response = await _dio.post(
      'update-profile',
      data: {
        'user_id': userId,
        'name': name,
        'bio': bio,
        if (avatarBase64 != null) 'avatar': avatarBase64,
      },
    );

    if (response.statusCode == 200) {
      print('✅ Update profile response: ${response.data}');

      String finalName = name;
      String finalBio = bio;
      String? finalAvatar;

      try {
        if (response.data is Map<String, dynamic>) {
          final raw = response.data as Map<String, dynamic>;
          final outer = (raw['data'] is Map<String, dynamic>)
              ? raw['data'] as Map<String, dynamic>
              : raw;
          final userData = (outer['user'] is Map<String, dynamic>)
              ? outer['user'] as Map<String, dynamic>
              : outer;

          finalName = userData['name'] ?? userData['full_name'] ?? name;
          finalBio = userData['bio'] ?? bio;

          // ✅ FIX: avatar_url pehle check karo, phir avatar (relative path ko full URL banao)
          final String? rawAvatar =
              userData['avatar_url'] ?? userData['avatar'];
          finalAvatar = _buildFullAvatarUrl(rawAvatar) ?? avatarBase64;
        }
      } catch (e) {
        print('⚠️ Response parse error: $e');
        // Fallback: agar response parse na ho to base64 use karo
        finalAvatar = avatarBase64;
      }

      debugPrint("✅ Final avatar to save: $finalAvatar");
      debugPrint("✅ avatarLocalPath: $avatarLocalPath");

      // ✅ FIX: Session disk par save karo — avatar null ho to remove() call hogi (SessionManager fix se)
      await SessionManager.instance.saveSession(
        userId: userId,
        fullName: finalName,
        bio: finalBio,
        avatar: finalAvatar,
        avatarLocalPath: avatarLocalPath,
      );

      // ✅ RAM (GetX) update karo — UI foran refresh hoga
      if (Get.isRegistered<AuthController>()) {
        final auth = Get.find<AuthController>();
        auth.userName.value = finalName;
        auth.userBio.value = finalBio;

        // Avatar update: pehle local path try karo, phir network URL
        if (avatarLocalPath != null) {
          auth.userAvatarLocalPath.value = avatarLocalPath;
        } else {
          auth.userAvatarLocalPath.value = ''; // Local path clear karo
        }

        if (finalAvatar != null) {
          auth.userAvatar.value = finalAvatar; // Full URL ya Base64
        }
      }

      return true;
    }
    return false;
  }

  RxBool isLoading = false.obs;
  var oldPasswordError = RxnString();
  var newPasswordError = RxnString();
  var confirmPasswordError = RxnString();

  void validateAndChangePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
  }) {
    oldPasswordError.value = null;
    newPasswordError.value = null;
    confirmPasswordError.value = null;
    bool isValid = true;

    if (oldPassword.isEmpty) {
      oldPasswordError.value = "Old password is required";
      isValid = false;
    }
    if (newPassword.isEmpty) {
      newPasswordError.value = "New password is required";
      isValid = false;
    } else if (newPassword.length < 6) {
      newPasswordError.value = "Password must be at least 6 characters";
      isValid = false;
    }
    if (confirmPassword.isEmpty) {
      confirmPasswordError.value = "Please confirm your new password";
      isValid = false;
    } else if (newPassword != confirmPassword) {
      confirmPasswordError.value = "Passwords do not match";
      isValid = false;
    }

    if (isValid) {
      _changePasswordApi(oldPassword: oldPassword, newPassword: newPassword);
    }
  }

  Future<void> _changePasswordApi({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      isLoading.value = true;
      final userId = await _getLoggedInUserId();
      Response response = await _dio.post(
        'change-password',
        data: {
          'user_id': userId,
          'old_password': oldPassword,
          'new_password': newPassword,
        },
      );
      if (response.statusCode == 200) {
        Get.snackbar(
            'Success', response.data['message'] ?? 'Password changed successfully!');
        await Future.delayed(const Duration(milliseconds: 300));
        Get.back();
      }
    } on DioException catch (e) {
      String errorMessage = 'Failed to change password. Please check your inputs.';
      if (e.response != null && e.response?.data != null) {
        if (e.response?.statusCode == 422) {
          var errors = e.response?.data['errors'];
          errorMessage = errors is Map
              ? errors.values.first[0]
              : (e.response?.data['message'] ?? errorMessage);
        } else {
          errorMessage = e.response?.data['message'] ?? errorMessage;
        }
      }
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  static Future<void> getProfileStats() async {
    try {
      final userId = await _getLoggedInUserId();
      final response =
      await _dio.post('user-profile-stats', data: {'user_id': userId});
      if (response.statusCode == 200 && Get.isRegistered<AuthController>()) {
        final auth = Get.find<AuthController>();
        final raw = response.data as Map<String, dynamic>;
        final data =
        (raw['data'] is Map) ? raw['data'] as Map<String, dynamic> : raw;
        auth.likesCount.value = _parseInt(
            data['likes'] ?? data['likes_count'] ?? data['total_likes'] ?? 0);
        auth.commentsCount.value =
            _parseInt(data['comments'] ?? data['comments_count'] ?? 0);
        auth.sharesCount.value =
            _parseInt(data['shares'] ?? data['shares_count'] ?? 0);
        auth.foodSupport.value = _parseInt(data['food_support'] ?? 0);
        auth.transportSupport.value =
            _parseInt(data['transport_support'] ?? 0);
        auth.cashReward.value = _parseInt(data['cash_reward'] ?? 0);
      }
    } catch (e) {
      print('Stats error: $e');
    }
  }

  static Future<void> getProfileStatsWithRank() async {
    try {
      final userId = await _getLoggedInUserId();
      final response = await _dio.post(
          'user-profile-stats-with-rank', data: {'user_id': userId});
      if (response.statusCode == 200 && Get.isRegistered<AuthController>()) {
        final auth = Get.find<AuthController>();
        final raw = response.data as Map<String, dynamic>;
        final data =
        (raw['data'] is Map) ? raw['data'] as Map<String, dynamic> : raw;
        auth.userRank.value =
            _parseInt(data['rank'] ?? data['user_rank'] ?? data['ranking'] ?? 0);
      }
    } catch (e) {
      print('Stats+rank error: $e');
    }
  }

  static int _parseInt(dynamic val) {
    if (val == null) return 0;
    if (val is int) return val;
    if (val is double) return val.toInt();
    return int.tryParse(val.toString()) ?? 0;
  }
}

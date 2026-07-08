// import 'dart:io';
// import 'package:get/get.dart' hide Response;
// import 'package:dio/dio.dart';
// import '../auth_screen/login_screen.dart';
// import '../basic_files/bottom_bar.dart';
// import '../presentation_screen/UpdatePasswordScreen.dart';
// import '../presentation_screen/VerifyScreen.dart';
// import '../services/api_service.dart';
// import '../services/session_manager.dart';
//
//
// class AuthController extends GetxController {
//   RxBool isLoading = false.obs;
//   var otpError = RxBool(false);
//
//   RxString userName = ''.obs;
//   Rxn<String> userAvatar = Rxn<String>();
//   RxString userBio = ''.obs;
//   RxString userAvatarLocalPath = ''.obs;
//   RxInt likesCount = 0.obs;
//   RxInt commentsCount = 0.obs;
//   RxInt sharesCount = 0.obs;
//   RxInt userRank = 0.obs;
//   RxInt foodSupport = 0.obs;
//   RxInt transportSupport = 0.obs;
//   RxInt cashReward = 0.obs;
//
//   @override
//   void onInit() {
//     super.onInit();
//     _restoreSession();
//   }
//
//   Future<void> _restoreSession() async {
//     final token = await SessionManager.instance.getToken();
//     if (token != null && token.isNotEmpty) {
//       ApiService.dio.options.headers['Authorization'] = 'Bearer $token';
//     }
//     final savedName = await SessionManager.instance.getFullName();
//     if (savedName != null) userName.value = savedName;
//     final savedBio = await SessionManager.instance.getBio();
//     if (savedBio != null) userBio.value = savedBio;
//     final savedPath = await SessionManager.instance.getAvatarLocalPath();
//     if (savedPath != null && File(savedPath).existsSync()) {
//       userAvatarLocalPath.value = savedPath;
//     }
//   }
//
//   // var isLoading = false.obs;
//
//   // --- SIGN UP ERROR STATES ---
//   var nameError = RxnString();
//   var emailError = RxnString();
//   var passwordError = RxnString();
//   var confirmPasswordError = RxnString();
//
//   // --- LOGIN ERROR STATES ---
//   var loginEmailError = RxnString();
//   var loginPasswordError = RxnString();
//
//   Future<void> _saveUserSession(Map<String, dynamic> rawResponse) async {
//     try {
//       final Map<String, dynamic> outer =
//       (rawResponse['data'] is Map<String, dynamic>) ? rawResponse['data'] : rawResponse;
//
//       // 'user' object alag se nested hai
//       final Map<String, dynamic> userData =
//       (outer['user'] is Map<String, dynamic>) ? outer['user'] : outer;
//
//       final dynamic idValue = userData['id'] ?? userData['user_id'];
//       if (idValue == null) {
//         print('⚠️ Session save skip: user_id response mein nahi mila -> $rawResponse');
//         return;
//       }
//
//       final int userId = idValue is int ? idValue : int.parse(idValue.toString());
//       final String? fullName = userData['name'] ?? userData['full_name'];
//       final String? userEmail = userData['email'];
//       final String? avatar = userData['avatar'];
//       final String? bio = userData['bio'];
//       final String? token = outer['token']; // token 'user' ke andar nahi, ek level upar hai
//
//       await SessionManager.instance.saveSession(
//         userId: userId,
//         fullName: fullName,
//         email: userEmail,
//         avatar: avatar,
//         bio: bio,
//         token: token,
//       );
//
//       if (fullName != null) userName.value = fullName;
//       if (avatar != null) userAvatar.value = avatar;
//       if (bio != null) userBio.value = bio;
//
//       // Token mil gaya hai (Bearer auth) — ab har future request mein ye header khud lagega
//       if (token != null && token.isNotEmpty) {
//         ApiService.dio.options.headers['Authorization'] = 'Bearer $token';
//       }
//
//       print('✅ Session saved for user_id: $userId');
//     } catch (e) {
//       print('⚠️ Could not parse/save session, raw response was: $rawResponse');
//     }
//   }
//
//   // ==========================================
//   //               LOGIN LOGIC
//   // ==========================================
//   void validateAndLogin({
//     required String email,
//     required String password,
//   }) {
//     // 1. Purane errors clear karein
//     loginEmailError.value = null;
//     loginPasswordError.value = null;
//
//     bool isValid = true;
//
//     // 2. Professional Validations
//     if (email
//         .trim()
//         .isEmpty) {
//       loginEmailError.value = "Email or Username is required";
//       isValid = false;
//     }
//
//     if (password
//         .trim()
//         .isEmpty) {
//       loginPasswordError.value = "Password is required";
//       isValid = false;
//     }
//
//     // 3. Agar sab theek hai to API call karein
//     if (isValid) {
//       _loginUser(email: email, password: password);
//     }
//   }
//
//   Future<void> _loginUser({
//     required String email,
//     required String password,
//   }) async {
//     try {
//       isLoading.value = true;
//
//       // API Call
//       Response response = await ApiService.dio.post(
//         'login',
//         data: {
//           "email": email,
//           "password": password,
//         },
//       );
//
//       // Success
//       if (response.statusCode == 200) {
//         print('Login response: ${response.data}');
//
//         if (response.data is Map<String, dynamic>) {
//           await _saveUserSession(response.data);
//         }
//
//         Get.snackbar('Success', 'Logged in successfully!');
//         await Future.delayed(const Duration(milliseconds: 300));
//         Get.offAll(() => MainScreen(), transition: Transition.fadeIn);
//       }
//     } on DioException catch (e) {
//       // Error handling
//       String errorMessage = 'Login failed. Please check your credentials.';
//       if (e.response != null && e.response?.data != null) {
//         errorMessage = e.response?.data['message'] ?? errorMessage;
//       }
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ==========================================
//   //               SIGN UP LOGIC
//   // ==========================================
//   void validateAndSignUp({
//     required String fullName,
//     required String email,
//     required String password,
//     required String confirmPassword,
//     required bool rememberMe,
//   }) {
//     nameError.value = null;
//     emailError.value = null;
//     passwordError.value = null;
//     confirmPasswordError.value = null;
//
//     bool isValid = true;
//
//     if (fullName
//         .trim()
//         .isEmpty) {
//       nameError.value = "Full name is required";
//       isValid = false;
//     }
//
//     if (email
//         .trim()
//         .isEmpty) {
//       emailError.value = "Email address is required";
//       isValid = false;
//     } else if (!GetUtils.isEmail(email)) {
//       emailError.value = "Please enter a valid email";
//       isValid = false;
//     }
//
//     if (password
//         .trim()
//         .isEmpty) {
//       passwordError.value = "Password is required";
//       isValid = false;
//     } else if (password.length < 6) {
//       passwordError.value = "Password must be at least 6 characters";
//       isValid = false;
//     }
//
//     if (confirmPassword
//         .trim()
//         .isEmpty) {
//       confirmPasswordError.value = "Please confirm your password";
//       isValid = false;
//     } else if (password != confirmPassword) {
//       confirmPasswordError.value = "Passwords do not match";
//       isValid = false;
//     }
//
//     if (!rememberMe) {
//       Get.snackbar('Alert', 'Please agree to Terms & Conditions',
//           snackPosition: SnackPosition.BOTTOM);
//       isValid = false;
//     }
//
//     if (isValid) {
//       _signUpUser(fullName: fullName, email: email, password: password);
//     }
//   }
//
//   Future<void> _signUpUser({
//     required String fullName,
//     required String email,
//     required String password,
//   }) async {
//     try {
//       isLoading.value = true;
//       Response response = await ApiService.dio.post(
//         'signup',
//         data: {
//           "full_name": fullName,
//           "email": email,
//           "password": password,
//         },
//       );
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print('Signup response: ${response.data}');
//
//         if (response.data is Map<String, dynamic>) {
//           await _saveUserSession(response.data);
//         }
//
//         Get.snackbar('Success', 'Account created successfully!');
//         await Future.delayed(const Duration(milliseconds: 300));
//         Get.offAll(() => MainScreen(), transition: Transition.fadeIn);
//       }
//     } on DioException catch (e) {
//       String errorMessage = 'Signup failed. Please try again.';
//       if (e.response != null && e.response?.data != null) {
//         errorMessage = e.response?.data['message'] ?? errorMessage;
//       }
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> verifyOtpApi({
//     required String email,
//     required String otp,
//   }) async {
//     try {
//       isLoading.value = true;
//
//       // ⚠️ NOTE: 'verify-otp' endpoint Postman collection mein nahi mila.
//       // Backend dev se confirm kar lein ke ye endpoint exist karta hai ya nahi —
//       // agar nahi, to OTP ko local compare bhi kiya ja sakta hai kyunke
//       // sendForgotPasswordOtp() already actual OTP value response mein de deta hai.
//       Response response = await ApiService.dio.post(
//         'verify-otp',
//         data: {
//           "email": email,
//           "otp": otp,
//         },
//       );
//
//       // Success
//       if (response.statusCode == 200) {
//         Get.snackbar('Success', 'OTP Verified Successfully!');
//         // OTP verify hone ke baad Update Password screen par bhejein, aur sath email pass kar dein
//         Get.to(() => const UpdatePasswordscreen(), arguments: email,
//             transition: Transition.fadeIn);
//       }
//     } on DioException catch (e) {
//       String errorMessage = 'Invalid OTP code. Please try again.';
//       if (e.response != null && e.response?.data != null) {
//         errorMessage = e.response?.data['message'] ?? errorMessage;
//       }
//       Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
// // ==========================================
// //            RESEND OTP LOGIC
// // ==========================================
//   Future<void> resendOtp({required String email}) async {
//     try {
//       // Fix: pehle yahan 'forgot-password' (placeholder/wrong endpoint) call ho raha tha,
//       // jo Postman collection mein exist nahi karta. Sahi endpoint 'send-forgot-password-otp' hai.
//       await ApiService.dio.post(
//         'send-forgot-password-otp',
//         data: {
//           "email": email,
//         },
//       );
//       Get.snackbar('Success', 'New code sent to your email.');
//     } on DioException catch (e) {
//       Get.snackbar('Error', 'Failed to resend code.');
//     }
//   }
//   Future<Map<String, dynamic>?> sendForgotPasswordOtp({
//     required String email,
//   }) async {
//     try {
//       isLoading.value = true;
//
//       Response response = await ApiService.dio.post(
//         'send-forgot-password-otp',
//         data: {"email": email},
//       );
//
//       if (response.statusCode == 200) {
//         final data = response.data;
//         // Response: { "data": { "user_id": 10, "otp": "772411" } }
//         final int userId   = data['data']['user_id'];
//         final String otp   = data['data']['otp'].toString();
//
//         print("✅ OTP sent — userId: $userId, otp: $otp");
//         return {'user_id': userId, 'otp': otp};
//       }
//       return null;
//     } on DioException catch (e) {
//       print("API Error (send-otp): ${e.response?.data}");
//       String msg = e.response?.data['message'] ?? 'Could not send OTP';
//       Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
//       return null;
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//
// // ==========================================
// //         FORGOT PASSWORD LOGIC
// // ==========================================
//   Future<void> sendResetLink({required String email}) async {
//     // Purana error clear karein
//     emailError.value = null;
//
//     if (email.trim().isEmpty) {
//       emailError.value = "Email is required";
//       return;
//     } else if (!GetUtils.isEmail(email)) {
//       emailError.value = "Invalid email format";
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//
//       var response = await ApiService.dio.post(
//         'send-forgot-password-otp',
//         data: {
//           "email": email,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         Get.snackbar('Success', 'OTP sent to your email.');
//
//         // "data" object se user_id aur otp nikal lein
//         final data = response.data['data'];
//         final int userId = data['user_id'] ?? 0;
//         final String otp = data['otp']?.toString() ?? '';
//
//         Get.to(
//               () => const Verifyscreen(),
//           arguments: {
//             'email': email,
//             'user_id': userId,
//             'otp': otp,
//           },
//         );
//       }
//     } catch (e) {
//       Get.snackbar('Error', 'Failed to send OTP.');
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   Future<void> updatePassword({
//     required int userId,
//     required String newPassword,
//     required String confirmPassword,
//   }) async {
//     if (newPassword.isEmpty || confirmPassword.isEmpty) {
//       Get.snackbar('Alert', 'Fields cannot be empty');
//       return;
//     }
//     if (newPassword != confirmPassword) {
//       Get.snackbar('Alert', 'Passwords do not match');
//       return;
//     }
//
//     try {
//       isLoading.value = true;
//
//       var response = await ApiService.dio.post(
//         'reset-password',
//         data: {
//           "user_id": userId,
//           "password": newPassword,
//         },
//       );
//
//       if (response.statusCode == 200) {
//         Get.snackbar('Success', 'Password updated successfully!');
//         Get.offAll(() => const LoginScreen());
//       }
//     } on DioException catch (e) {
//       print("API Error (reset-password): ${e.response?.data}");
//       if (e.response?.statusCode == 422) {
//         var errors = e.response?.data['errors'];
//         String msg = errors is Map
//             ? errors.values.first[0]
//             : (e.response?.data['message'] ?? 'Validation failed');
//         Get.snackbar('Validation Error', msg);
//       } else {
//         Get.snackbar('Error', e.response?.data['message'] ?? 'Server Error');
//       }
//     } finally {
//       isLoading.value = false;
//     }
//   }
//
//   // ==========================================
//   //               LOGOUT LOGIC
//   // ==========================================
//   Future<void> logout() async {
//     await SessionManager.instance.clearSession();
//     ApiService.dio.options.headers.remove('Authorization');
//     userName.value = '';
//     userBio.value = '';
//     userAvatarLocalPath.value = '';
//     userAvatar.value = null;
//     likesCount.value = 0;
//     commentsCount.value = 0;
//     sharesCount.value = 0;
//     userRank.value = 0;
//     foodSupport.value = 0;
//     transportSupport.value = 0;
//     cashReward.value = 0;
//     Get.offAll(() => const LoginScreen());
//   }
//
// }
import 'dart:io';
import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import '../auth_screen/login_screen.dart';
import '../basic_files/bottom_bar.dart';
import '../on_boarding_screens/onboarding_screen.dart';
import '../presentation_screen/UpdatePasswordScreen.dart';
import '../presentation_screen/VerifyScreen.dart';
import '../services/api_service.dart';
import '../services/session_manager.dart';

class AuthController extends GetxController {
  RxBool isLoading = false.obs;
  final _box = GetStorage();
  var otpError = RxBool(false);

  // --- USER PROFILE STATES ---
  RxString userName = ''.obs;
  Rxn<String> userAvatar = Rxn<String>();
  RxString userBio = ''.obs;
  RxString userAvatarLocalPath = ''.obs;

  // --- USER STATS STATES ---
  RxInt likesCount = 0.obs;
  RxInt commentsCount = 0.obs;
  RxInt sharesCount = 0.obs;
  RxInt userRank = 0.obs;
  RxInt foodSupport = 0.obs;
  RxInt transportSupport = 0.obs;
  RxInt cashReward = 0.obs;

  // --- SIGN UP ERROR STATES ---
  var nameError = RxnString();
  var emailError = RxnString();
  var passwordError = RxnString();
  var confirmPasswordError = RxnString();

  // --- LOGIN ERROR STATES ---
  var loginEmailError = RxnString();
  var loginPasswordError = RxnString();

  @override
  void onInit() {
    super.onInit();
    _restoreSession();
  }


  // Keys
  static const String _onboardingKey = 'has_seen_onboarding';

  // ✅ Onboarding complete hone par call karein
  void completeOnboarding() {
    _box.write(_onboardingKey, true);
  }

  // --- RESTORE SESSION ON APP START ---
  Future<void> _restoreSession() async {
    final token = await SessionManager.instance.getToken();
    if (token != null && token.isNotEmpty) {
      ApiService.dio.options.headers['Authorization'] = 'Bearer $token';
    }

    final savedName = await SessionManager.instance.getFullName();
    if (savedName != null) userName.value = savedName;

    final savedBio = await SessionManager.instance.getBio();
    if (savedBio != null) userBio.value = savedBio;

    final savedAvatar = await SessionManager.instance.getAvatar();
    if (savedAvatar != null) userAvatar.value = savedAvatar;

    final savedPath = await SessionManager.instance.getAvatarLocalPath();
    if (savedPath != null && File(savedPath).existsSync()) {
      userAvatarLocalPath.value = savedPath;
    }
  }

  Future<void> checkLoginStatus() async {
    bool hasSeenOnboarding = _box.read(_onboardingKey) ?? false;

    if (!hasSeenOnboarding) {
      // Pehli baar → Onboarding dikhao
      Get.offAll(
            () => OnboardingScreen(),
        transition: Transition.fadeIn,
      );
      return; // ⬅️ yahan se nikal jao, aage mat jao
    }

    // Onboarding dekh chuka → Token check karo
    bool isLoggedIn = await _checkIfUserLoggedIn();

    if (isLoggedIn) {
      Get.offAll(
            () => const MainScreen(),
        transition: Transition.fadeIn,
      );
    } else {
      Get.offAll(
            () => const LoginScreen(),
        transition: Transition.fadeIn,
      );
    }
  }

  Future<bool> _checkIfUserLoggedIn() async {
    final token = await SessionManager.instance.getToken();
    return token != null && token.isNotEmpty; // ⬅️ bas itna hi
  }



  Future<void> _saveUserSession(Map<String, dynamic> rawResponse) async {
    try {
      final Map<String, dynamic> outer =
      (rawResponse['data'] is Map<String, dynamic>)
          ? rawResponse['data']
          : rawResponse;

      final Map<String, dynamic> userData =
      (outer['user'] is Map<String, dynamic>)
          ? outer['user']
          : outer;

      final dynamic idValue = userData['id'] ?? userData['user_id'];
      if (idValue == null) {
        print('⚠️ Session save skip: user_id nahi mila -> $rawResponse');
        return;
      }

      final int userId =
      idValue is int ? idValue : int.parse(idValue.toString());
      final String? fullName = userData['name'] ?? userData['full_name'];
      final String? userEmail = userData['email'];
      final String? bio = userData['bio'];
      final String? token = outer['token'];

      // ✅ FIX: Relative path ko full URL banao
      const String baseUrl = 'https://highlightapp.io/'; // 🔥 apna base URL
      final String? rawAvatar = userData['avatar_url'] ?? userData['avatar'];
      String? avatar;
      if (rawAvatar != null && rawAvatar.isNotEmpty) {
        if (rawAvatar.startsWith('http')) {
          avatar = rawAvatar; // Pehle se full URL hai
        } else {
          avatar = '$baseUrl$rawAvatar'; // Relative → Full URL
        }
      }

      // Disk par save
      await SessionManager.instance.saveSession(
        userId: userId,
        fullName: fullName,
        email: userEmail,
        avatar: avatar,       // Ab full URL save hogi ✅
        bio: bio,
        token: token,
      );

      // RAM update
      userName.value = fullName ?? '';
      userBio.value = bio ?? '';
      userAvatar.value = avatar;
      userAvatarLocalPath.value = '';

      if (token != null && token.isNotEmpty) {
        ApiService.dio.options.headers['Authorization'] = 'Bearer $token';
      }

      print('✅ Session saved! userId: $userId, avatar: $avatar');
    } catch (e) {
      print('⚠️ Error: $e');
    }
  }

  // 🔥 BONUS METHOD: Edit Profile screen se direct data sync karne ke liye
  void updateProfileData({required String name, required String bio, String? remoteAvatar, String? localPath}) {
    if (name.isNotEmpty) userName.value = name;
    userBio.value = bio;
    if (remoteAvatar != null) userAvatar.value = remoteAvatar;
    if (localPath != null) userAvatarLocalPath.value = localPath;
  }

  // --- VALIDATE AND LOGIN TRIGGER ---
  void validateAndLogin({required String email, required String password}) {
    loginEmailError.value = null;
    loginPasswordError.value = null;
    bool isValid = true;

    if (email.trim().isEmpty) {
      loginEmailError.value = "Email or Username is required";
      isValid = false;
    }
    if (password.trim().isEmpty) {
      loginPasswordError.value = "Password is required";
      isValid = false;
    }

    if (isValid) {
      _loginUser(email: email, password: password);
    }
  }

  // --- ACTUAL API LOGIN CALL ---
  Future<void> _loginUser({required String email, required String password}) async {
    try {
      isLoading.value = true;
      Response response = await ApiService.dio.post(
        'login',
        data: {"email": email, "password": password},
      );

      if (response.statusCode == 200) {
        if (response.data is Map<String, dynamic>) {
          await _saveUserSession(response.data);
        }
        Get.snackbar('Success', 'Logged in successfully!', snackPosition: SnackPosition.TOP);
        await Future.delayed(const Duration(milliseconds: 300));
        Get.offAll(() => const MainScreen(), transition: Transition.fadeIn);
      }
    } on DioException catch (e) {
      String errorMessage;
      if (e.type == DioExceptionType.connectionError ||
          e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.receiveTimeout) {
        errorMessage = 'No internet connection. Please check your network.';
      } else if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['message'] ?? 'Login failed. Please check your credentials.';
      } else {
        errorMessage = 'Login failed. Please check your credentials.';
      }
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // --- VALIDATE AND SIGN UP TRIGGER ---
  void validateAndSignUp({
    required String fullName,
    required String email,
    required String password,
    required String confirmPassword,
    required bool rememberMe,
  }) {
    nameError.value = null;
    emailError.value = null;
    passwordError.value = null;
    confirmPasswordError.value = null;
    bool isValid = true;

    if (fullName.trim().isEmpty) {
      nameError.value = "Full name is required";
      isValid = false;
    }
    if (email.trim().isEmpty) {
      emailError.value = "Email address is required";
      isValid = false;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = "Please enter a valid email";
      isValid = false;
    }
    if (password.trim().isEmpty) {
      passwordError.value = "Password is required";
      isValid = false;
    } else if (password.length < 6) {
      passwordError.value = "Password must be at least 6 characters";
      isValid = false;
    }
    if (confirmPassword.trim().isEmpty) {
      confirmPasswordError.value = "Please confirm your password";
      isValid = false;
    } else if (password != confirmPassword) {
      confirmPasswordError.value = "Passwords do not match";
      isValid = false;
    }
    if (!rememberMe) {
      Get.snackbar('Alert', 'Please agree to Terms & Conditions', snackPosition: SnackPosition.BOTTOM);
      isValid = false;
    }

    if (isValid) {
      _signUpUser(fullName: fullName, email: email, password: password);
    }
  }

  // --- ACTUAL API SIGN UP CALL ---
  Future<void> _signUpUser({required String fullName, required String email, required String password}) async {
    try {
      isLoading.value = true;
      Response response = await ApiService.dio.post(
        'signup',
        data: {"full_name": fullName, "email": email, "password": password},
      );
      if (response.statusCode == 200 || response.statusCode == 201) {
        if (response.data is Map<String, dynamic>) {
          await _saveUserSession(response.data);
        }
        Get.snackbar('Success', 'Account created successfully!', snackPosition: SnackPosition.TOP);
        await Future.delayed(const Duration(milliseconds: 300));
        Get.offAll(() => const MainScreen(), transition: Transition.fadeIn);
      }
    } on DioException catch (e) {
      String errorMessage = 'Signup failed. Please try again.';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // --- VERIFY OTP API ---
  Future<void> verifyOtpApi({required String email, required String otp}) async {
    try {
      isLoading.value = true;
      Response response = await ApiService.dio.post(
        'verify-otp',
        data: {"email": email, "otp": otp},
      );
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'OTP Verified Successfully!');
        Get.to(() => const UpdatePasswordscreen(), arguments: email, transition: Transition.fadeIn);
      }
    } on DioException catch (e) {
      String errorMessage = 'Invalid OTP code. Please try again.';
      if (e.response != null && e.response?.data != null) {
        errorMessage = e.response?.data['message'] ?? errorMessage;
      }
      Get.snackbar('Error', errorMessage, snackPosition: SnackPosition.BOTTOM);
    } finally {
      isLoading.value = false;
    }
  }

  // --- RESEND OTP ---
  Future<void> resendOtp({required String email}) async {
    try {
      await ApiService.dio.post('send-forgot-password-otp', data: {"email": email});
      Get.snackbar('Success', 'New code sent to your email.');
    } catch (e) {
      Get.snackbar('Error', 'Failed to resend code.');
    }
  }

  // --- FORGOT PASSWORD OTP ---
  Future<Map<String, dynamic>?> sendForgotPasswordOtp({required String email}) async {
    try {
      isLoading.value = true;
      Response response = await ApiService.dio.post('send-forgot-password-otp', data: {"email": email});
      if (response.statusCode == 200) {
        final data = response.data;
        final int userId = data['data']['user_id'];
        final String otp = data['data']['otp'].toString();
        print("✅ OTP sent — userId: $userId, otp: $otp");
        return {'user_id': userId, 'otp': otp};
      }
      return null;
    } on DioException catch (e) {
      String msg = e.response?.data['message'] ?? 'Could not send OTP';
      Get.snackbar('Error', msg, snackPosition: SnackPosition.BOTTOM);
      return null;
    } finally {
      isLoading.value = false;
    }
  }

  // --- SEND RESET LINK FLOW ---
  Future<void> sendResetLink({required String email}) async {
    emailError.value = null;
    if (email.trim().isEmpty) {
      emailError.value = "Email is required";
      return;
    } else if (!GetUtils.isEmail(email)) {
      emailError.value = "Invalid email format";
      return;
    }

    try {
      isLoading.value = true;
      var response = await ApiService.dio.post('send-forgot-password-otp', data: {"email": email});
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'OTP sent to your email.');
        final data = response.data['data'];
        final int userId = data['user_id'] ?? 0;
        final String otp = data['otp']?.toString() ?? '';
        Get.to(() => const Verifyscreen(), arguments: {'email': email, 'user_id': userId, 'otp': otp});
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to send OTP.');
    } finally {
      isLoading.value = false;
    }
  }

  // --- UPDATE PASSWORD FLOW ---
  Future<void> updatePassword({required int userId, required String newPassword, required String confirmPassword}) async {
    if (newPassword.isEmpty || confirmPassword.isEmpty) {
      Get.snackbar('Alert', 'Fields cannot be empty');
      return;
    }
    if (newPassword != confirmPassword) {
      Get.snackbar('Alert', 'Passwords do not match');
      return;
    }

    try {
      isLoading.value = true;
      var response = await ApiService.dio.post('reset-password', data: {"user_id": userId, "password": newPassword});
      if (response.statusCode == 200) {
        Get.snackbar('Success', 'Password updated successfully!');
        Get.offAll(() => const LoginScreen());
      }
    } on DioException catch (e) {
      if (e.response?.statusCode == 422) {
        var errors = e.response?.data['errors'];
        String msg = errors is Map ? errors.values.first[0] : (e.response?.data['message'] ?? 'Validation failed');
        Get.snackbar('Validation Error', msg);
      } else {
        Get.snackbar('Error', e.response?.data['message'] ?? 'Server Error');
      }
    } finally {
      isLoading.value = false;
    }
  }

  // --- LOGOUT METHOD ---
  Future<void> logout() async {
    await SessionManager.instance.clearSession();
    ApiService.dio.options.headers.remove('Authorization');
    userName.value = '';
    userBio.value = '';
    userAvatarLocalPath.value = '';
    userAvatar.value = null;
    likesCount.value = 0;
    commentsCount.value = 0;
    sharesCount.value = 0;
    userRank.value = 0;
    foodSupport.value = 0;
    transportSupport.value = 0;
    cashReward.value = 0;
    Get.offAll(() => const LoginScreen());
  }
}
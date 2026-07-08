// import 'package:shared_preferences/shared_preferences.dart';
//
// /// Saves logged-in user's info on device so we don't have to
// /// hardcode/pass user_id manually everywhere.
// /// Call `saveSession()` right after a successful LOGIN or SIGNUP.
// /// Call `clearSession()` on LOGOUT.
// class SessionManager {
//   SessionManager._();
//   static final SessionManager instance = SessionManager._();
//
//   static const _keyUserId = 'user_id';
//   static const _keyFullName = 'full_name';
//   static const _keyEmail = 'email';
//   static const _keyAvatar = 'avatar';
//   static const _keyAvatarLocalPath = 'avatar_local_path';
//   static const _keyBio = 'bio';
//   static const _keyToken = 'token'; // agar backend response mein token nahi ata, is field ko ignore/remove kar sakte hain
//   static const _keyIsLoggedIn = 'is_logged_in';
//
//   SharedPreferences? _prefs;
//
//   Future<SharedPreferences> get _prefsInstance async {
//     _prefs ??= await SharedPreferences.getInstance();
//     return _prefs!;
//   }
//
//   /// Login/Signup success ke baad ye call karein
//   Future<void> saveSession({
//     required int userId,
//     String? fullName,
//     String? email,
//     String? avatar,
//     String? avatarLocalPath,
//     String? bio,
//     String? token,
//   }) async {
//     final prefs = await _prefsInstance;
//     await prefs.setInt(_keyUserId, userId);
//     await prefs.setBool(_keyIsLoggedIn, true);
//     if (fullName != null) await prefs.setString(_keyFullName, fullName);
//     if (email != null) await prefs.setString(_keyEmail, email);
//     if (avatar != null) await prefs.setString(_keyAvatar, avatar);
//     if (avatarLocalPath != null) await prefs.setString(_keyAvatarLocalPath, avatarLocalPath);
//     if (bio != null) await prefs.setString(_keyBio, bio);
//     if (token != null) await prefs.setString(_keyToken, token);
//   }
//
//   Future<int?> getUserId() async {
//     final prefs = await _prefsInstance;
//     return prefs.getInt(_keyUserId);
//   }
//
//   Future<String?> getToken() async {
//     final prefs = await _prefsInstance;
//     return prefs.getString(_keyToken);
//   }
//
//   Future<String?> getFullName() async {
//     final prefs = await _prefsInstance;
//     return prefs.getString(_keyFullName);
//   }
//
//   Future<String?> getEmail() async {
//     final prefs = await _prefsInstance;
//     return prefs.getString(_keyEmail);
//   }
//
//   Future<String?> getAvatar() async {
//     final prefs = await _prefsInstance;
//     return prefs.getString(_keyAvatar);
//   }
//
//   Future<String?> getAvatarLocalPath() async {
//     final prefs = await _prefsInstance;
//     return prefs.getString(_keyAvatarLocalPath);
//   }
//
//   Future<String?> getBio() async {
//     final prefs = await _prefsInstance;
//     return prefs.getString(_keyBio);
//   }
//
//   Future<bool> isLoggedIn() async {
//     final prefs = await _prefsInstance;
//     return prefs.getBool(_keyIsLoggedIn) ?? false;
//   }
//
//   /// Logout par ye call karein - sara saved data clear ho jayega
//   Future<void> clearSession() async {
//     final prefs = await _prefsInstance;
//     await prefs.setBool(_keyIsLoggedIn, false);
//     await prefs.remove(_keyToken);
//     final prefs = await SharedPreferences.getInstance();
//     await prefs.clear();
//   }
// }
import 'package:shared_preferences/shared_preferences.dart';

/// Saves logged-in user's info on device so we don't have to
/// hardcode/pass user_id manually everywhere.
/// Call `saveSession()` right after a successful LOGIN or SIGNUP.
/// Call `clearSession()` on LOGOUT.
class SessionManager {
  SessionManager._();
  static final SessionManager instance = SessionManager._();

  static const _keyUserId = 'user_id';
  static const _keyFullName = 'full_name';
  static const _keyEmail = 'email';
  static const _keyAvatar = 'avatar';
  static const _keyAvatarLocalPath = 'avatar_local_path';
  static const _keyBio = 'bio';
  static const _keyToken = 'token';
  static const _keyIsLoggedIn = 'is_logged_in';

  SharedPreferences? _prefs;

  Future<SharedPreferences> get _prefsInstance async {
    _prefs ??= await SharedPreferences.getInstance();
    return _prefs!;
  }

  /// Login/Signup success ke baad ye call karein
  Future<void> saveSession({
    required int userId,
    String? fullName,
    String? email,
    String? avatar,
    String? avatarLocalPath,
    String? bio,
    String? token,
  }) async {
    final prefs = await _prefsInstance;
    await prefs.setInt(_keyUserId, userId);
    await prefs.setBool(_keyIsLoggedIn, true);
    if (fullName != null) await prefs.setString(_keyFullName, fullName);
    if (email != null) await prefs.setString(_keyEmail, email);
    if (avatar != null) {
      await prefs.setString(_keyAvatar, avatar);
    } else {
      await prefs.remove(_keyAvatar);
    }
    if (avatarLocalPath != null) {
      await prefs.setString(_keyAvatarLocalPath, avatarLocalPath);
    } else {
      await prefs.remove(_keyAvatarLocalPath);
    }
    if (bio != null) await prefs.setString(_keyBio, bio);
    if (token != null) await prefs.setString(_keyToken, token);
  }

  Future<int?> getUserId() async {
    final prefs = await _prefsInstance;
    return prefs.getInt(_keyUserId);
  }

  Future<String?> getToken() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyToken);
  }

  Future<String?> getFullName() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyFullName);
  }

  Future<String?> getEmail() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyEmail);
  }

  Future<String?> getAvatar() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyAvatar);
  }

  Future<String?> getAvatarLocalPath() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyAvatarLocalPath);
  }

  Future<String?> getBio() async {
    final prefs = await _prefsInstance;
    return prefs.getString(_keyBio);
  }

  Future<bool> isLoggedIn() async {
    final prefs = await _prefsInstance;
    return prefs.getBool(_keyIsLoggedIn) ?? false;
  }

  /// ✅ FIXED: Logout par ye call karein - sara saved data ek hi baar me flush ho jayega
  Future<void> clearSession() async {
    final prefs = await _prefsInstance;
    await prefs.clear(); // Yeh line saara local cache flush kar degi taake account mix up na ho
  }
}
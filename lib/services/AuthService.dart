import 'package:flutter/cupertino.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:go_router/go_router.dart';
import '../app_routes/app_routes.dart';
import '../core/api_config.dart';
import '../utils/constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'ApiClient.dart';

class AuthService {
  static const String _accessTokenKey = "access_token";
  static const String _refreshTokenKey = "refresh_token";
  static const String _tokenExpiryKey = "token_expiry";
  static const String _role = "role";
  static const String _userId = "user_id";
  static const String _userName = "user_name";
  static const String _email = "email";
  static const String _mobile = "mobile";
  static const String _coins = "_coins";

  static final FlutterSecureStorage _storage = const FlutterSecureStorage();

  /// Check if the user is a guest (no token or empty token)
  static Future<bool> get isGuest async {
    final token = await getAccessToken();
    return token == null || token.isEmpty;
  }

  /// Get stored access token
  static Future<String?> getAccessToken() async {
    return await _storage.read(key: _accessTokenKey);
  }

  /// Get role
  static Future<String?> getRole() async {
    return await _storage.read(key: _role);
  }

  /// Get USer_id
  static Future<String?> getUSerId() async {
    return await _storage.read(key: _userId);
  }

  /// get Name
  static Future<String?> getName() async {
    return await _storage.read(key: _userName);
  }

  static Future<String?> getEmail() async {
    return await _storage.read(key: _email);
  }

  static Future<String?> getMobile() async {
    return await _storage.read(key: _mobile);
  }

  static Future<void> saveCoins(int coins) async {
    await _storage.write(key: _coins, value: coins.toString());
  }

  static Future<String?> getCoins() async {
    return await _storage.read(key: _coins);
  }

  /// Get stored refresh token
  static Future<String?> getRefreshToken() async {
    return await _storage.read(key: _refreshTokenKey);
  }

  /// Check if token is expired
  static Future<bool> isTokenExpired() async {
    final expiryTimestampStr = await _storage.read(key: _tokenExpiryKey);
    if (expiryTimestampStr == null) {
      debugPrint('No expiry timestamp found, considering token expired');
      return true;
    }

    final expiryTimestamp = int.tryParse(expiryTimestampStr);
    if (expiryTimestamp == null) {
      debugPrint('Invalid expiry timestamp, considering token expired');
      return true;
    }

    final now = DateTime.now().millisecondsSinceEpoch;
    final isExpired = now >= expiryTimestamp;

    debugPrint(
      'Token expiry check: now=$now, expiry=$expiryTimestamp, isExpired=$isExpired',
    );
    return isExpired;
  }

  static Future<void> saveTokens(
      String accessToken,
      String refreshToken,
      int expiresInMs, // <-- duration in ms
      // String userName,
      // String email,
      ) async {
    final expiryTimestamp =
        DateTime.now().millisecondsSinceEpoch + expiresInMs;

    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken);
    await _storage.write(
        key: _tokenExpiryKey, value: expiryTimestamp.toString());
    // await _storage.write(key: _userName, value: userName);
    // await _storage.write(key: _email, value: email);
  }

  /// Update tokens only (during refresh)
  static Future<void> updateTokens(
      String accessToken,
      String? refreshToken,
      int expiresIn,
      ) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    await _storage.write(key: _refreshTokenKey, value: refreshToken ?? "");
    await _storage.write(key: _tokenExpiryKey, value: expiresIn.toString());
    debugPrint('🔄 Tokens updated (refresh)');
  }

  /// Refresh token
  static Future<bool> refreshToken() async {
    final refreshToken = await getRefreshToken();
    if (refreshToken == null) {
      debugPrint('❌ No refresh token available');
      return false;
    }

    try {
      final response = await ApiClient.post(
        ApiConfig.refreshToken,
        data: {"refreshToken": refreshToken},
      );

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;
        final newAccessToken = data["accessToken"];
        final newRefreshToken = data["refreshToken"];
        final expiryTime = data["accessTokenExpiry"];

        if (newAccessToken == null ||
            newRefreshToken == null ||
            expiryTime == null) {
          debugPrint("❌ Missing token data in response: $data");
          return false;
        }
        await updateTokens(newAccessToken, newRefreshToken, expiryTime);
        debugPrint("✅ Token refreshed successfully");
        return true;
      } else {
        debugPrint("❌ Refresh token failed: ${response.statusCode}");
        return false;
      }
    } catch (e) {
      debugPrint("❌ Exception during token refresh: $e");
      return false;
    }
  }

  /// Logout and clear tokens, redirect to sign-in screen
  static Future<void> logout() async {
    await _storage.deleteAll(); // clear all tokens
    debugPrint('Tokens cleared, user logged out');

    final context = navigatorKey.currentContext;
    if (context != null) {
      Get.offAllNamed(Routes.login);
    } else {
      debugPrint('Context is null, scheduling GoRouter navigation after frame');
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final postFrameContext = navigatorKey.currentContext;
        if (postFrameContext != null) {
          Get.offAllNamed(Routes.login);
        } else {
          debugPrint('Still no context available after frame');
          // Optional: consider forcing rebuild or restarting app
        }
      });
    }
  }
}

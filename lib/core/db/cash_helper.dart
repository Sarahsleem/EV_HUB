import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Keys {
  guestMode,
  searchText,
  notFirstTime,
  userName,
  phoneNumber,
  token,
  darkMode,
  language,
  userImage,
  rideRequest,
  rideRequestID,
  couponID,
  couponAmount,
  lastTimeToLogin,
  counterOfLogin,
  signInResponse,
  signUpResponse,
  name,
  profileResponse,
  email,
  otpValue,
  userId,
  secretKey, theme,
}

class CashHelper {
  static late SharedPreferences sharedPreferences;
  static const FlutterSecureStorage _secureStorage = FlutterSecureStorage(
    aOptions: AndroidOptions(
      encryptedSharedPreferences: true,
    ),
  );

  /// Initialize SharedPreferences
  static Future<void> init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Save a string value in SharedPreferences
  static Future<void> putString({
    required Keys key,
    required String value,
  }) async {
    await sharedPreferences.setString(key.name, value);
  }

  /// Get a string value from SharedPreferences
  static String? getString({required Keys key}) {
    return sharedPreferences.getString(key.name);
  }

  /// Save an integer value in SharedPreferences
  static Future<void> putInt({
    required Keys key,
    required int value,
  }) async {
    await sharedPreferences.setInt(key.name, value);
  }

  /// Get an integer value from SharedPreferences
  static int? getInt({required Keys key}) {
    return sharedPreferences.getInt(key.name);
  }

  /// Remove a value from SharedPreferences
  static Future<bool> remove({required Keys key}) async {
    return await sharedPreferences.remove(key.name);
  }

  /// Save a boolean value in SharedPreferences
  static Future<void> putBool({
    required Keys key,
    required bool value,
  }) async {
    await sharedPreferences.setBool(key.name, value);
  }

  /// Get a boolean value from SharedPreferences
  static bool? getBool({required Keys key}) {
    return sharedPreferences.getBool(key.name);
  }

  /// Save a double value in SharedPreferences
  static Future<void> putDouble({
    required Keys key,
    required double value,
  }) async {
    await sharedPreferences.setDouble(key.name, value);
  }

  /// Get a double value from SharedPreferences
  static double? getDouble({required Keys key}) {
    return sharedPreferences.getDouble(key.name);
  }

  /// Get the current mode (light/dark) from SharedPreferences
  static bool? getMode() {
    return sharedPreferences.getBool(Keys.darkMode.name);
  }

  /// Save a string value in FlutterSecureStorage
  static Future<void> setStringSecured({
    required Keys key,
    required String value,
  }) async {
    try {
      await _secureStorage.write(key: key.name, value: value);
    } catch (e) {
      debugPrint("Error saving to secure storage: $e");
    }
  }

  /// Get a string value from FlutterSecureStorage
  static Future<String> getStringSecured({required Keys key}) async {
    try {
      return await _secureStorage.read(key: key.name) ?? '';
    } catch (e) {
      debugPrint("Error reading from secure storage: $e");
      return '';
    }
  }

  /// Clear all data from both SharedPreferences and FlutterSecureStorage
  static Future<void> clear() async {
    try {
      // Clear secure storage
      await _secureStorage.deleteAll();

      // Retain specific preferences before clearing SharedPreferences
      final bool darkMode = getMode() ?? (ThemeMode.system == ThemeMode.dark);
      final String? language = getString(key: Keys.language);

      await sharedPreferences.clear();

      // Re-set retained preferences
      await sharedPreferences.setBool(Keys.notFirstTime.name, true);
      await sharedPreferences.setBool(Keys.darkMode.name, darkMode);
      await sharedPreferences.setString(Keys.language.name, language ?? "en");
    } catch (e) {
      debugPrint("Error clearing preferences: $e");
    }
  }
}

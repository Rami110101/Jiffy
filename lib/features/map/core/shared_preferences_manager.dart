import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesManager {
  static late SharedPreferences _sharedPreferences;

  /// Initializes the SharedPreferences instance
  static Future<void> sharedPreferencesInitialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  /// Stores data of various types in SharedPreferences
  static Future<bool> setData(
      {required String key, required dynamic value}) async {
    if (value is String) {
      await _sharedPreferences.setString(key, value);
    } else if (value is int) {
      await _sharedPreferences.setInt(key, value);
    } else if (value is bool) {
      await _sharedPreferences.setBool(key, value);
    } else if (value is double) {
      await _sharedPreferences.setDouble(key, value);
    } else if (value is List<String>) {
      await _sharedPreferences.setStringList(key, value);
    } else if (value is List<double> || value is List<dynamic>) {
      // Ensure all elements are convertible to JSON
      String jsonString = json.encode(value);
      await _sharedPreferences.setString(key, jsonString);
    } else {
      return false;
    }
    return true;
  }

  Future<void> saveSenderCoordinates(double lat, double lng) async {
    debugPrint('💾 Saving Sender Coordinates: [$lat, $lng]');
    await SharedPreferencesManager.setData(
      key: 'sender_coordinates',
      value: [lat, lng], // This will now be properly stored as JSON
    );
  }

  Future<void> saveRecipientCoordinates(double lat, double lng) async {
    debugPrint('💾 Saving Recipient Coordinates: [$lat, $lng]');
    await SharedPreferencesManager.setData(
      key: 'recipient_coordinates',
      value: [lat, lng], // This will now be properly stored as JSON
    );
  }

  /// Retrieves data from SharedPreferences based on the key
  static dynamic getData({required String key}) {
    dynamic value = _sharedPreferences.get(key);

    if (value is String) {
      try {
        // Try decoding JSON for lists
        dynamic decodedValue = json.decode(value);
        if (decodedValue is List) return decodedValue;
      } catch (e) {
        // If decoding fails, return original string
      }
    }
    
    return value;
  }

  static Future<bool> removeData({required String key}) async {
    await _sharedPreferences.remove(key);
    return true;
  }

  static Future<bool> clearAllData() async {
    await _sharedPreferences.clear();
    return true;
  }
}

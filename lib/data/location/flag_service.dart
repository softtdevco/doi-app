import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FlagService {


  
 
  Map<String, dynamic> _flagsMap = {};
  bool _isInitialized = false;
  

  Future<void> initialize() async {
    if (_isInitialized) return;
    
    try {
    
      final String flagData = await rootBundle.loadString('assets/flag.json');
      final List<dynamic> flagsList = json.decode(flagData);
      

      for (final flag in flagsList) {
        _flagsMap[flag['code']] = flag;
      }
      
      _isInitialized = true;
    } catch (e) {
      print('Error loading flag data: $e');
    }
  }
  

  String? getFlagImageUrl(String countryCode) {
    if (!_isInitialized) {
      print('Flag service not initialized');
      return null;
    }
    
    final flag = _flagsMap[countryCode.toUpperCase()];
    if (flag == null) return null;
    
    return flag['image'];
  }
  
 
  String? getFlagEmoji(String countryCode) {
    if (!_isInitialized) {
      print('Flag service not initialized');
      return null;
    }
    
    final flag = _flagsMap[countryCode.toUpperCase()];
    if (flag == null) return null;
    
    return flag['emoji'];
  }
  
 
  bool get isInitialized => _isInitialized;
}

final flagServiceProvider = Provider<FlagService>((ref) {
  return FlagService();
});
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/services/base_service.dart';

class AppProvider extends BaseProvider<BaseService> {
  AppProvider() : super();

  bool _isInitialized = false;
  bool get isInitialized => _isInitialized;

  String? _token;
  String? get token => _token;
  bool get isLoggedIn => _token != null && _token!.isNotEmpty;


  void setToken(String? token) {
    _token = token;
    notifyListeners();
  }

  Future<void> logout() async {}
}

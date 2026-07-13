import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/base_provider.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/constants/app_strings.dart';
import 'package:obm_gen_with_ai/features/login/component/login_service.dart';
import 'package:obm_gen_with_ai/features/login/model/login_model.dart';
import 'package:obm_gen_with_ai/core/base/navigation/navigate_event.dart';
import 'package:obm_gen_with_ai/core/constants/route_generator.dart';
import 'package:obm_gen_with_ai/core/utils/app_storage.dart';

class LoginProvider extends BaseProvider<LoginService> {
  final LoginService _service;

  LoginProvider(this._service) : super();

  LoginService get service => _service;

  // Controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  // Local state
  bool isRememberAccount = false;
  bool isPasswordVisible = false;
  bool isProcessing = false;
  String? emailError;
  String? passwordError;

  // Validation helpers
  bool _isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );
    return emailRegex.hasMatch(email.trim());
  }

  String? validateEmail() {
    final email = emailController.text.trim();
    if (email.isEmpty) {
      emailError = AppStrings.vuiLongNhapEmail;
      notifyListeners();
      return emailError;
    }
    if (!_isValidEmail(email)) {
      emailError = AppStrings.emailKhongDungDinhDang;
      notifyListeners();
      return emailError;
    }
    emailError = null;
    notifyListeners();
    return null;
  }

  String? validatePassword() {
    if (passwordController.text.isEmpty) {
      passwordError = AppStrings.vuiLongNhapMatKhau;
      notifyListeners();
      return passwordError;
    }
    passwordError = null;
    notifyListeners();
    return null;
  }

  void clearErrors() {
    emailError = null;
    passwordError = null;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    isPasswordVisible = !isPasswordVisible;
    notifyListeners();
  }

  void toggleRememberAccount() {
    isRememberAccount = !isRememberAccount;
    notifyListeners();
  }

  Future<void> submitLogin() async {
    clearErrors();

    final emailErr = validateEmail();
    final passErr = validatePassword();
    if (emailErr != null || passErr != null) return;
    showLoading();
    isProcessing = true;
    notifyListeners();

    try {
      final request = LoginRequest(
        email: emailController.text.trim(),
        password: passwordController.text,
      );
      final response = await service.login(request);
      if (response.accessToken != null) {
        await AppStorage().saveAccessToken(accessToken: response.accessToken!);
        await AppStorage().saveUserInfo(response.user!);
      }
      isProcessing = false;
      showLoaded();
      showToast(
        AppStrings.dangNhapThanhCong,
        type: ToastType.success,
      );
      navigate(NavigateEvent.pushReplacementNamed(RouteGenerator.dashboard));
    } on DioException catch (e) {
      isProcessing = false;
      showLoaded();
      final message = e.message ?? '';
      if (message.contains('401')) {
        showToast(
          AppStrings.emailHoacMatKhauKhongChinhXac,
          type: ToastType.error,
        );
      } else {
        showToast(
          AppStrings.khongTheKetNoiMauChu,
          type: ToastType.error,
        );
      }
      notifyListeners();
    } catch (e) {
      isProcessing = false;
      showToast(
        AppStrings.khongTheKetNoiMauChu,
        type: ToastType.error,
      );
      notifyListeners();
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    emailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }
}

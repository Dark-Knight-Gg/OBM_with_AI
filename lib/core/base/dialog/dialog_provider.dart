/*
import 'dart:async';

import 'package:flutter/material.dart';

import 'dialog_event.dart';

class DialogProvider extends ChangeNotifier {

  final StreamController<dynamic> dialogStream = StreamController<dynamic>.broadcast();

  void addDialogEvent(DialogEvent event) {
    dialogStream.add(event);
  }

*/
/*  String? _errorMessage;
  String? _successMessage;
  bool _isConfirmDialogVisible = false;
  String? _confirmTitle;
  String? _confirmMessage;
  Function(bool)? _onConfirmCallback;

  String? get errorMessage => _errorMessage;
  String? get successMessage => _successMessage;
  bool get isConfirmDialogVisible => _isConfirmDialogVisible;
  String? get confirmTitle => _confirmTitle;
  String? get confirmMessage => _confirmMessage;*//*


*/
/*  void addDialogListener(Function(dynamic) listener) {
    dialogStream.stream.listen(listener);
  }*//*


*/
/*  void showError(String message) {
    _errorMessage = message;
    dialogStream.add('showError');
    notifyListeners();
  }

  void clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void showSuccess(String message) {
    _successMessage = message;
    dialogStream.add('showSuccess');
    notifyListeners();
  }

  void clearSuccess() {
    _successMessage = null;
    notifyListeners();
  }

  void showConfirm({
    required String title,
    required String message,
    required Function(bool) onConfirm,
  }) {
    _isConfirmDialogVisible = true;
    _confirmTitle = title;
    _confirmMessage = message;
    _onConfirmCallback = onConfirm;
    dialogStream.add('showConfirm');
    notifyListeners();
  }

  void handleConfirm(bool result) {
    _isConfirmDialogVisible = false;
    _confirmTitle = null;
    _confirmMessage = null;
    _onConfirmCallback?.call(result);
    _onConfirmCallback = null;
    notifyListeners();
  }

  Future<void> showErrorDialog(BuildContext context, String message) async {
    showError(message);
    dialogStream.add('showErrorDialog');
    await DialogEvent.showErrorDialog(
      context: context,
      message: message,
    );
    clearError();
  }

  Future<void> showSuccessDialog(BuildContext context, String message) async {
    showSuccess(message);
    dialogStream.add('showSuccessDialog');
    await DialogEvent.showSuccessDialog(
      context: context,
      message: message,
    );
    clearSuccess();
  }

  Future<bool> showConfirmDialog(
    BuildContext context, {
    required String title,
    required String message,
  }) async {
    dialogStream.add('showConfirmDialog');
    return await DialogEvent.showConfirmDialog(
      context: context,
      title: title,
      message: message,
    );
  }*//*


  @override
  void dispose() {
    dialogStream.close();
    super.dispose();
  }
}
*/

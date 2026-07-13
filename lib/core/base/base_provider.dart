import 'dart:async';

import 'package:flutter/material.dart';
import 'package:obm_gen_with_ai/core/base/progress/progress_event.dart';
import 'package:obm_gen_with_ai/core/base/services/base_service.dart';
import 'package:obm_gen_with_ai/core/base/toast/toast_event.dart';
import 'package:obm_gen_with_ai/core/base/navigation/navigate_event.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dialog/dialog_event.dart';

enum StateType { loading, error, noData, loaded, none }

abstract class BaseProvider<S extends BaseService> extends ChangeNotifier {
  StateType _currentState = StateType.none;
  late StreamController<dynamic> eventStream;

  String? errorMessage = '';

  String? get error => errorMessage;

  StateType get currentState => _currentState;

  bool get isLoading => currentState == StateType.loading;

  bool get loadingFailed => currentState == StateType.error;

  bool get isLoaded => currentState == StateType.loaded;

  bool get noData => currentState == StateType.noData;

  void setEventStream(StreamController<dynamic> eventStream) {
    this.eventStream = eventStream;
  }

  BaseProvider() {
    onStart();
  }

  void onStart() {}

  void onInit(Map<String, dynamic> data) {}

  void onEventResult(dynamic event, dynamic response) {}

  void showLoading() {
    _currentState = StateType.loading;
    notifyListeners();
  }

  void setStateNone() {
    _currentState = StateType.none;
    notifyListeners();
  }

  void showError() {
    _currentState = StateType.error;
    notifyListeners();
  }

  void showNoData() {
    _currentState = StateType.noData;
    notifyListeners();
  }

  void showLoaded() {
    _currentState = StateType.loaded;
    notifyListeners();
  }

  void showToast(String message, {ToastType type = ToastType.warning, Duration duration = const Duration(seconds: 2)}) {
    final toastEvent = ToastEvent(message: message, type: type, duration: duration);
    eventStream.add(toastEvent);
  }

  void showDialog({
    required DialogType type,
    String? title,
    String? content,
    bool? dismissible,
    Function(DialogActionType)? onActionCallback,
    bool expandedActions = false,
  }) {
    final dialogEvent = DialogEvent.withType(
      dialogType: type,
      title: title,
      content: content,
      dismissible: dismissible,
      onActionCallback: onActionCallback,
      expandedActions: expandedActions,
    );
    eventStream.add(dialogEvent);
  }

  void navigate(NavigateEvent event) {
    if (this.eventStream.isClosed) return;
    eventStream.add(event);
  }
  void nextPage() {}

  void prevPage() {}

  void showProgress() {
    eventStream.add(ProgressEvent.show());
  }

  void hideProgress() {
    eventStream.add(ProgressEvent.hide());
  }
}

mixin ControllerLoadMoreMixin {
  final RefreshController refreshControllerDefault = RefreshController();
  int page = 1;

  int firstPage = 1;

  int get limit => 20;

  void onLoadMore() {}

  void reStart() {}

  void emitRefreshToIdle({RefreshController? controller}) {
    final refreshController = controller ?? refreshControllerDefault;
    refreshController.refreshToIdle();
  }

  void emitLoadComplete({RefreshController? controller, Function()? callback}) {
    if (callback != null) {
      ///hàm callback để tăng số page=> page++
      callback();
    }
    page++;
    final refreshController = controller ?? refreshControllerDefault;
    refreshController.loadComplete();
  }

  void emitLoadFailed({RefreshController? controller}) {
    final refreshController = controller ?? refreshControllerDefault;
    refreshController.loadFailed();
  }

  void emitLoadNoData({RefreshController? controller}) {
    final refreshController = controller ?? refreshControllerDefault;
    refreshController.loadNoData();
  }

  bool isRefresh() => page == firstPage;

  bool isLoadMore() => page > firstPage;

  void emitNewLoadState({
    List? newData,
    String? exception,
    RefreshController? controller,
    Function()? handleLoadComplete,
    Function()? emitSuccess,
    Function()? emmitEmpty,
    Function()? emmitError,
  }) {
    if (exception != null) {
      if (isRefresh()) {
        emitRefreshToIdle(controller: controller);
        emmitError?.call();
      } else {
        emitLoadFailed(controller: controller);
      }
      return;
    }
    if (newData != null) {
      final dataLength = newData.length;
      if (isRefresh()) {
        emitRefreshToIdle(controller: controller);
        if (dataLength == 0) {
          emmitEmpty?.call();
        } else {
          emitSuccess?.call();
        }
      }
      if (dataLength < limit) {
        emitLoadNoData(controller: controller);
        emitSuccess?.call();
      } else {
        handleLoadComplete?.call() ?? emitLoadComplete(controller: controller);
        emitSuccess?.call();
      }
    }
  }
}

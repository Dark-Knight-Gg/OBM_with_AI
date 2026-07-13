import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class LoadingInterceptor extends Interceptor {
  final LoadingManager lm;

  LoadingInterceptor(this.lm);

  @override
  void onRequest(options, handler) {
    if (options.extra['noLoading'] != true) {
      lm.inc();
    }
    handler.next(options);
  }

  @override
  void onResponse(response, handler) {
     lm.dec();
    handler.next(response);
  }

  @override
  void onError(err, handler)  {
 lm.dec();
    handler.next(err);
  }
}

class LoadingManager extends ChangeNotifier {
  int _count = 0;

  bool get isLoading => _count > 0;

  void inc() {
    _count++;
    notifyListeners();
  }

void dec() {
    _count--;
    if (_count < 0) _count = 0;

      notifyListeners();

  }
}

class LoadingHub {
  static final LoadingManager instance = LoadingManager();
}



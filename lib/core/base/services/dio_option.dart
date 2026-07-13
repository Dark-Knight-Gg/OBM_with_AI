import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';
import '../../constants/app_strings.dart';
import '../../utils/util.dart';
import 'package:obm_gen_with_ai/core/utils/app_storage.dart';

String HANDLE401 = AppStrings.warningExpiredLogin;
const HANDLE401RESEND = "RESENDTOKEN";
const NO_INTERNET = "Không thể kết nối tới máy chủ. Vui lòng kiểm tra lại kết nối Internet.";

typedef DioErrorHander = Function(DioException);
typedef DioResponseHander = Function(Response);
typedef DioHeaderOption = Function(bool, RequestOptions);

bool _showingNetworkError = false;

class DioOption {
  Dio? client;
  int refreshTokenNumber = 0;
  Duration? connectTimeout = const Duration(milliseconds: 10000);
  static DioResponseHander? _callbackResponse;
  static DioHeaderOption? _headerOption;

  static void setAuthHeaderCallback(DioHeaderOption callback) {
    _headerOption = callback;
  }

  bool isRefreshing = false;
  List<Function(Response)> requestQueue = [];

  Dio createDio({xFormUrl = false}) {
    refreshTokenNumber = 0;
    client = Dio();
    client!.options.connectTimeout = connectTimeout;
    client?.httpClientAdapter = IOHttpClientAdapter(
      createHttpClient: () {
        final HttpClient client = HttpClient(context: SecurityContext(withTrustedRoots: true));
        if (kDebugMode) {
          client.badCertificateCallback = ((X509Certificate cert, String host, int port) => true);
        }
        return client;
      },
    );
    (client?.httpClientAdapter as IOHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      if (kDebugMode) {
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      }
      return client;
    };
    client!.interceptors
      ..clear()
      ..add(
        QueuedInterceptorsWrapper(
          onRequest: (RequestOptions options, handler) async {
            if (_headerOption != null) {
              options = await _headerOption!(xFormUrl, options);
            } else {
              String? token = await AppStorage().getAccessToken();
              options.headers['Authorization'] = "Bearer $token";
            }

            return handler.next(options);
          },
          onResponse: (Response response, handler) async {
            // if (response.data is String) {
            //   response.data = json.decode(response.data);
            // }
            if (_callbackResponse != null) {
              response = await _callbackResponse!(response);
            }

            return handler.next(response);
          },
          onError: (DioException error, handler) async {
            if (_isNetworkError(error)) {
              print("------nnnn----------");
              if (!_showingNetworkError) {
                print("------ssss----------");
                _showingNetworkError = true;

                error = error.copyWith(message: AppStrings.warningNotConnectInternet);

                Future.delayed(const Duration(seconds: 2), () {
                  _showingNetworkError = false;
                });
              }

              error = initException(error);
              return handler.next(error);
            } else if (error.type == DioExceptionType.badResponse) {
              print("-------okhttp-------badResponse--------------");
              switch (error.response!.statusCode) {
                case 401:
                  print("-------okhttp-------401--------------");
                  final options = Options(method: error.requestOptions.method, headers: error.requestOptions.headers);
                  var param = error.requestOptions.data;
                  if (error.requestOptions.data is FormData) {
                    param = (error.requestOptions.data as FormData).clone();
                  }
                  final cloneReq = await DioOption().client!.request<dynamic>(
                    error.requestOptions.path,
                    data: param,
                    queryParameters: error.requestOptions.queryParameters,
                    options: options,
                  );
                  return handler.resolve(cloneReq);
                case 404:
                  error = error.copyWith(message: AppStrings.warningNotFound);
                  error = initException(error);
                  return handler.next(error);
                default:
                  error = initException(error);
                  return handler.next(error);
              }
            }

            error = initException(error);
            return handler.next(error);
          },
        ),
      );
    client!.interceptors.add(
      LogInterceptor(
        responseBody: true,
        error: true,
        requestHeader: false,
        responseHeader: false,
        request: false,
        requestBody: true,
        logPrint: printWrapped,
      ),
    );
    return client!;
  }
}

bool _isNetworkError(DioException error) {
  return error.type == DioExceptionType.connectionError ||
      error.type == DioExceptionType.connectionTimeout ||
      error.type == DioExceptionType.receiveTimeout ||
      error.error is SocketException;
}

void printWrapped(Object object) {
  String text = object.toString();
  final pattern = RegExp('.{1,800}'); // 800 is the size of each chunk
  pattern.allMatches(text).forEach((match) {
    if (kDebugMode) {
      log(match.group(0) ?? "");
    }
  });
}

DioException initException(DioException dioError) {
  try {
    if (dioError.response != null) {
      if (dioError.response != null &&
          dioError.response!.data != null &&
          dioError.response!.data is Map<String, dynamic>) {
        dioError = dioError.copyWith(message: dioError.response!.data.toString());
        if (dioError.response!.statusCode == 401) {
          dioError = dioError.copyWith(message: HANDLE401);
        } else if (dioError.response!.statusCode == 400) {
          if ((dioError.response!.data as Map<String, dynamic>).containsKey("message") &&
              (dioError.response!.data['message'] is String) &&
              ((dioError.response!.data['message'] as String).contains('TRANSACTION') ||
                  (dioError.response!.data['message'] as String).contains('EXPIRED'))) {
            dioError = dioError.copyWith(message: HANDLE401);
            return dioError;
          }
          if ((dioError.response!.data as Map<String, dynamic>).containsKey("title")) {
            dioError = dioError.copyWith(
              message: Util.orEmpty((dioError.response!.data as Map<String, dynamic>)["title"]),
            );
            return dioError;
          }
        } else {
          if ((dioError.response!.data as Map<String, dynamic>).containsKey("status") &&
              (dioError.response!.data["status"] is Map<String, dynamic>) &&
              (dioError.response!.data["status"] as Map<String, dynamic>).containsKey("message")) {
            dioError = dioError.copyWith(
              message: Util.orEmpty((dioError.response!.data["status"] as Map<String, dynamic>)["message"]),
            );
          }
          if ((dioError.response!.data as Map<String, dynamic>).containsKey("msg")) {
            dioError = dioError.copyWith(
              message: Util.orEmpty((dioError.response!.data as Map<String, dynamic>)["msg"]),
            );
          }
          if ((dioError.response!.data as Map<String, dynamic>).containsKey("title")) {
            dioError = dioError.copyWith(
              message: Util.orEmpty((dioError.response!.data as Map<String, dynamic>)["title"]),
            );
            if ((dioError.response!.data as Map<String, dynamic>).containsKey("message") &&
                (dioError.response!.data['message'] is String) &&
                (dioError.response!.data['message'] as String).contains('error')) {
              return dioError.copyWith(message: dioError.response!.data['message']);
            }
          }

          if ((dioError.response!.data as Map<String, dynamic>).containsKey("message")) {
            dioError = dioError.copyWith(
              message: Util.orEmpty((dioError.response!.data as Map<String, dynamic>)["message"]),
            );
          }
          if ((dioError.response!.data as Map<String, dynamic>).containsKey("detail")) {
            dioError = dioError.copyWith(
              message:
                  dioError.response!.data['detail'] +
                  ', X-TraceId = ' +
                  dioError.response!.headers['X-TraceId']!.join(""),
            );
          }
        }
      } else {
        dioError = dioError.copyWith(message: dioError.message!);
      }
      return dioError;
    } else {
      if ((dioError.message ?? "").isEmpty) {
        return dioError.copyWith(message: "Hệ thống bị gián đoạn trong giây lát, xin vui lòng quay lại sau!");
      }
      if (dioError.message == NO_INTERNET) {
        return dioError;
      }
      dioError = dioError.copyWith(
        message:
            (dioError.error == null || dioError.error.toString().isEmpty)
                ? "Hệ thống bị gián đoạn trong giây lát, xin vui lòng quay lại sau!"
                : dioError.error.toString(),
      );
      return dioError;
    }
  } catch (e) {
    if ((dioError.message ?? "").isEmpty) {
      return dioError;
    }
    dioError = dioError.copyWith(
      message:
          (dioError.error == null || dioError.error.toString().isEmpty)
              ? "Hệ thống bị gián đoạn trong giây lát, xin vui lòng quay lại sau!"
              : dioError.error.toString(),
    );
    return dioError;
  }
}

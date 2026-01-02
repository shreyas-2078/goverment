import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import '../constants/local_storage_key_strings.dart';
import 'api_logger.dart';
import 'package:get/get.dart' as get_x;

enum RefreshTokenStatus { active, expired, fail, pending }

enum ErrorCheckResults { end, retry, next, renewSession }

class AppInterceptor extends Interceptor {
  AppInterceptor(this._baseUrl, {this.skipUnauthorizedHandler = false});

  final String _baseUrl;
  final bool skipUnauthorizedHandler;

  static bool _isRefreshing = false;
  static final List<Function(String)> _queuedRequests = [];

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final storage = GetStorage();
    final token = storage.read(LocalStorageKeyStrings.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    options.extra['skipUnauthorizedHandler'] = skipUnauthorizedHandler;
    handler.next(options);
  }

  @override
  Future<void> onResponse(
    Response response,
    ResponseInterceptorHandler handler,
  ) async {
    return handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final skipHandler =
        err.requestOptions.extra['skipUnauthorizedHandler'] as bool? ?? false;

    if (err.response?.statusCode == 401 && !skipHandler) {
      final storage = GetStorage();
      final refreshToken = storage.read(LocalStorageKeyStrings.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        logout();
        return;
      }

      if (_isRefreshing) {
        _queuedRequests.add((String newToken) async {
          final retryResponse = await _retryRequest(
            err.requestOptions,
            newToken,
          );
          handler.resolve(retryResponse);
        });
        return;
      }

      _isRefreshing = true;

      
     
    } else {
      handler.next(err);
    }
  }

  Future<Response> _retryRequest(
    RequestOptions requestOptions,
    String newToken,
  ) async {
    final dioRetry = Dio(
      BaseOptions(
        baseUrl: requestOptions.baseUrl,
        headers: {'Authorization': 'Bearer $newToken'},
      ),
    );

    final Response response = await dioRetry.request(
      requestOptions.path,
      data: requestOptions.data,
      queryParameters: requestOptions.queryParameters,
      options: Options(
        method: requestOptions.method,
        headers: requestOptions.headers,
      ),
    );

    return response;
  }
}

logout() async {
  log("logout unauthorize");
  try {
    get_x.Get.reset();
  } catch (e) {
    print('Error resetting GetX state on logout: $e');
  }
  await GetStorage().erase();
  LocalStorageKeyStrings.appNavKey.currentContext!.go('/');
}

class Logging extends Interceptor {
  final Dio dio;

  Logging(this.dio);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    ApiLogger.logDioRequest(options);
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    ApiLogger.logDioResponse(response);
    return super.onResponse(response, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    ApiLogger.logDioError(err);
    return super.onError(err, handler);
  }
}

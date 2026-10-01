import 'package:demo_dio/core/api_key/api_key.dart';
import 'package:dio/dio.dart';
import 'api_endpoints.dart';
import 'api_exception.dart';


class ApiService {

  late final Dio _dio;

  ApiService() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiEndpoints.baseUrl,
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10),
        sendTimeout: const Duration(seconds: 10),

        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          "x-api-key": ApiKey().key
        },
      ),
    );

    _setupInterceptors();
  }

  void _setupInterceptors() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) {
          print(
            'REQUEST: ${options.method} ${options.uri} ${options.data}',
          );

          handler.next(options);
        },

        onResponse: (response, handler) {
          print(
            'RESPONSE: ${response.statusCode} ${response.requestOptions.uri}  ${response.data}',
          );

          handler.next(response);
        },

        onError: (error, handler) {
          print(
            'ERROR: ${error.requestOptions.uri}',
          );

          handler.next(error);
        },
      ),
    );
  }

  // =========================
  // GET
  // =========================

  Future<Response> get(
      String endpoint, {
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.get(
        endpoint,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // =========================
  // POST
  // =========================

  Future<Response> post(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.post(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // =========================
  // PUT
  // =========================

  Future<Response> put(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.put(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // =========================
  // PATCH
  // =========================

  Future<Response> patch(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.patch(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // =========================
  // DELETE
  // =========================

  Future<Response> delete(
      String endpoint, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
      }) async {
    try {
      final response = await _dio.delete(
        endpoint,
        data: data,
        queryParameters: queryParameters,
        options: options,
      );

      return response;
    } on DioException catch (e) {
      throw _handleDioException(e);
    }
  }

  // =========================
  // ERROR HANDLING
  // =========================

  ApiException _handleDioException(
      DioException error,
      ) {
    if (error.response != null) {
      final statusCode = error.response?.statusCode;

      switch (statusCode) {
        case 400:
          return ApiException(
            message: 'Bad request',
            statusCode: statusCode,
          );

        case 401:
          return ApiException(
            message: 'Unauthorized',
            statusCode: statusCode,
          );

        case 403:
          return ApiException(
            message: 'Access denied',
            statusCode: statusCode,
          );

        case 404:
          return ApiException(
            message: 'Resource not found',
            statusCode: statusCode,
          );

        case 500:
          return ApiException(
            message: 'Server error',
            statusCode: statusCode,
          );

        default:
          return ApiException(
            message: 'Something went wrong',
            statusCode: statusCode,
          );
      }
    }

    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ApiException(
          message: 'Connection timeout',
        );

      case DioExceptionType.sendTimeout:
        return ApiException(
          message: 'Request timeout',
        );

      case DioExceptionType.receiveTimeout:
        return ApiException(
          message: 'Server response timeout',
        );

      case DioExceptionType.connectionError:
        return ApiException(
          message: 'No internet connection',
        );

      case DioExceptionType.cancel:
        return ApiException(
          message: 'Request cancelled',
        );

      default:
        return ApiException(
          message: 'Something went wrong',
        );
    }
  }
}
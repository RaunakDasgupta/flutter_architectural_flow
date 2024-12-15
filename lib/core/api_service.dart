import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:dio_smart_retry/dio_smart_retry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

/// Here generic `T` is the response type
class ApiService {
  ApiService({
    required Dio dio,
    required String baseUrl
  }) : _dio = dio,
       _baseUrl = baseUrl {
    _dio.options.baseUrl = _baseUrl;
    _dio.options.connectTimeout = const Duration(minutes: 1);
    _dio.options.sendTimeout = const Duration(minutes: 1);
    _dio.options.receiveTimeout = const Duration(minutes: 1);

    _dio.interceptors.add(RetryInterceptor(dio: _dio));
    if (kDebugMode) {
      _dio.interceptors.add(
        PrettyDioLogger(
          requestHeader: true,
          requestBody: true,
        ),
      );
    }
  }

  final Dio _dio;
  final String _baseUrl;
  // Get:----------------------------------------------------------------------
  Future<ApiDataHolder<T>> get<T>(String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    void Function(int, int)? onReceiveProgress,
  }) async {
    final apiDataHolder = ApiDataHolder<T>();
    try {
      final response = await _dio.get<T>(path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress);
      apiDataHolder.setApiResponseData(response.data);
    } on DioException catch (e) {
      apiDataHolder.setErrorCode(e.response?.statusCode ?? -1);
      apiDataHolder.setErrorMessage(e.message ?? "Something went wrong!");
    }
    return apiDataHolder;
  }

  // Post:----------------------------------------------------------------------
  Future<ApiDataHolder> post(
      String path, {
        dynamic data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        CancelToken? cancelToken,
        void Function(int, int)? onSendProgress,
        void Function(int, int)? onReceiveProgress,
      }) async {
    final apiDataHolder = ApiDataHolder();
    try {
      final response = await _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onSendProgress: onSendProgress,
        onReceiveProgress: onReceiveProgress,
      );
      apiDataHolder.setApiResponseData(response.data);
    } on DioException catch (e) {
      apiDataHolder.setErrorCode(e.response?.statusCode ?? -1);
      apiDataHolder.setErrorMessage(e.message ?? "Something went wrong!");
    }
    return apiDataHolder;
  }

  // // Put:-----------------------------------------------------------------------
  // Future<Response<T>> put<T>(
  //     String path, {
  //       dynamic data,
  //       Map<String, dynamic>? queryParameters,
  //       Options? options,
  //       CancelToken? cancelToken,
  //       void Function(int, int)? onSendProgress,
  //       void Function(int, int)? onReceiveProgress,
  //     }) async {
  //   final response = await _dio.put<T>(
  //     path,
  //     data: data,
  //     queryParameters: queryParameters,
  //     options: options,
  //     cancelToken: cancelToken,
  //     onSendProgress: onSendProgress,
  //     onReceiveProgress: onReceiveProgress,
  //   );
  //   return response;
  // }
  //
  // // Delete:--------------------------------------------------------------------
  // Future<Response<T>> delete<T>(
  //     String path, {
  //       dynamic data,
  //       Map<String, dynamic>? queryParameters,
  //       Options? options,
  //       CancelToken? cancelToken,
  //     }) async {
  //   final response = await _dio.delete<T>(
  //     path,
  //     data: data,
  //     queryParameters: queryParameters,
  //     options: options,
  //     cancelToken: cancelToken,
  //   );
  //   return response;
  // }
  //
  // // Patch:---------------------------------------------------------------------
  // Future<Response<T>> patch<T>(
  //     String path, {
  //       dynamic data,
  //       Map<String, dynamic>? queryParameters,
  //       Options? options,
  //       CancelToken? cancelToken,
  //       void Function(int, int)? onSendProgress,
  //       void Function(int, int)? onReceiveProgress,
  //     }) async {
  //   final response = await _dio.patch<T>(
  //     path,
  //     queryParameters: queryParameters,
  //     options: options,
  //     cancelToken: cancelToken,
  //     onSendProgress: onSendProgress,
  //     onReceiveProgress: onReceiveProgress,
  //   );
  //   return response;
  // }

}
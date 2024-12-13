import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';

/// Here generic `T` is the response type
class ApiService {

  Future<ApiDataHolder> get(String url) async {
    final dio = Dio();
    final apiDataHolder = ApiDataHolder();
    try {
      final response = await dio.get(url);
      log("${response.data}");
      apiDataHolder.setApiResponseData(response.data);

    } on DioException catch (e) {
      apiDataHolder.setErrorCode(e.response?.statusCode ?? -1);
      apiDataHolder.setErrorMessage(e.message ?? "Something went wrong!");
    }
    return apiDataHolder;
  }

}
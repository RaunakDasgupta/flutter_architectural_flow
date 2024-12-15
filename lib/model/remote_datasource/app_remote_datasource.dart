import 'package:dio/dio.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/core/api_response_types.dart';
import 'package:flutter_architectural_flow/core/api_service.dart';

class AppRemoteDatasource {
  final apiService = ApiService(dio: Dio(), baseUrl: "https://dogapi.dog/api/v2");

  Future<ApiDataHolder> getDogListData() async {
    return await apiService.get<json_response>("/breeds");
  }
}
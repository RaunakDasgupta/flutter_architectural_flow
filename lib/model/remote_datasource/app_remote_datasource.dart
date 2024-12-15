import 'package:dio/dio.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/core/api_response_types.dart';
import 'package:flutter_architectural_flow/core/api_service.dart';
import 'package:flutter_architectural_flow/core/network_urls.dart';

class AppRemoteDatasource {
  AppRemoteDatasource({
    required ApiService apiService
}): _apiService = apiService;
  final ApiService _apiService;

  Future<ApiDataHolder> getDogListData() async {
    return await _apiService.get<json_response>(DogUrlPaths.getAllBreeds);
  }
}
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/core/api_service.dart';

class AppRemoteDatasource {
  final apiService = ApiService();

  Future<ApiDataHolder> getDogListData() async {
    return await apiService.get("https://dogapi.dog/api/v2/breeds");
  }
}
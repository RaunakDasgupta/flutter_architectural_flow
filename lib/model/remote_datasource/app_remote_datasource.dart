import 'package:dio/dio.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/core/api_response_types.dart';
import 'package:flutter_architectural_flow/core/api_service.dart';
import 'package:flutter_architectural_flow/core/network_urls.dart';
import 'package:flutter_architectural_flow/data_classes/blog_update_req_body.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class AppRemoteDatasource {
  AppRemoteDatasource({
    required ApiService apiService
}): _apiService = apiService;
  final ApiService _apiService;

  Future<ApiDataHolder> getBlogData() async {
    final apiService = ApiService(dio: Dio(), baseUrl: AppBaseUrls.blogDataUrl);
    return await apiService.get<text_response>(BlogUrlPaths.blogDataJson,
    queryParameters: {"timestamp": '${DateTime.now().millisecondsSinceEpoch}'});
  }

  Future<ApiDataHolder<json_response>> getBlogJsonFileInfo() async {
    return await _apiService.get<json_response>(BlogUrlPaths.blogJsonContentInfoPath,
      options: Options(headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${dotenv.env["GITHUB_ACCESS_TOKEN"]}"
        }),
    );
  }

  Future<ApiDataHolder<json_response>> updateBlogJsonFileContent(BlogUpdateReqBody reqBody) async {
    return await _apiService.put<json_response>(
        BlogUrlPaths.blogJsonContentInfoPath,
        options: Options(headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer ${dotenv.env["GITHUB_ACCESS_TOKEN"]}"
        }),
        data: reqBody.toJson()
    );
  }
}
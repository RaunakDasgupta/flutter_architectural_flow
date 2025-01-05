import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/core/constants.dart';
import 'package:flutter_architectural_flow/data_classes/blog_json_file_info.dart';
import 'package:flutter_architectural_flow/data_classes/blog_update_req_body.dart';
import 'package:flutter_architectural_flow/model/remote_datasource/app_remote_datasource.dart';

class AppRepository {
  AppRepository({
    required AppRemoteDatasource remoteDatasource
  }): _remoteDatasource = remoteDatasource;
  final AppRemoteDatasource _remoteDatasource;

  final StreamController<ApiDataHolder> _blogDataController = StreamController<ApiDataHolder>();
  Stream<ApiDataHolder> get blogDataStream => _blogDataController.stream;

  final StreamController<ApiDataHolder> _contentUpdateController = StreamController<ApiDataHolder>();
  Stream<ApiDataHolder> get contentUpdateStream => _contentUpdateController.stream;

  Future<void> getBlogData() async {
    final apiDataHolder = await _remoteDatasource.getBlogData();
    _blogDataController.add(apiDataHolder);
  }

  Future<void> updateBlogContent(String contentString, {String? commitMessage}) async {
    final blogFileInfoDataHolder = await _remoteDatasource.getBlogJsonFileInfo();
    final BlogJsonFileInfo fileInfo = BlogJsonFileInfo.fromJson(blogFileInfoDataHolder.apiResponseData ?? {});
    final String encodedContent = base64Encode(utf8.encode(contentString));
    log("Encoded String $encodedContent");
    final reqBody = BlogUpdateReqBody(
        message: commitMessage ?? "Content Updated!",
        base64EncodedContent: encodedContent,
        sha: fileInfo.sha ?? strConstant);

    final apiDataHolder = await _remoteDatasource.updateBlogJsonFileContent(reqBody);
    _contentUpdateController.add(apiDataHolder);
  }
  // Future<void> getDogListData() async {
  //   final apiDataHolder = await _remoteDatasource.getDogListData();
  //   _appDataController.add(apiDataHolder);
  // }

}
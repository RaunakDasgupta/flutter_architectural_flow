import 'package:dio/dio.dart';
import 'package:flutter_architectural_flow/core/api_service.dart';
import 'package:flutter_architectural_flow/core/network_urls.dart';
import 'package:flutter_architectural_flow/model/remote_datasource/app_remote_datasource.dart';
import 'package:flutter_architectural_flow/model/repositories/app_repository.dart';
import 'package:flutter_architectural_flow/viewmodel/app_viewmodel.dart';
import 'package:get_it/get_it.dart';

GetIt coreLocator = GetIt.instance;

Future<void> setUpCoreLocator() async {
  // ViewModels
  coreLocator.registerLazySingleton<AppViewModel>(() => AppViewModel(repository: coreLocator()));
  // Repositories
  coreLocator.registerLazySingleton<AppRepository>(() => AppRepository(remoteDatasource: coreLocator()));
  // Remote DataSources
  coreLocator.registerLazySingleton<AppRemoteDatasource>(() => AppRemoteDatasource(apiService: coreLocator()));
  // App Services
  coreLocator.registerLazySingleton<ApiService>(() => ApiService(
      dio: coreLocator(), baseUrl: AppBaseUrls.dogBaseUrl));
  // External Dependencies
  coreLocator.registerLazySingleton<Dio>(() => Dio());
}
import 'dart:convert';

import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/data_classes/blog_data.dart';
import 'package:flutter_architectural_flow/model/repositories/app_repository.dart';
import 'package:flutter_architectural_flow/viewmodel/state/blog_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogDataViewModel extends Cubit<BlogDataState> {
  final AppRepository _repository;
  BlogDataViewModel({
    required AppRepository repository
  }): _repository = repository, super(const BlogDataState(appData: null)) {
    repository.blogDataStream.listen((apiData){
      emit(state.copyWith(
        appData: apiData.apiResponseData != null ? BlogData.fromJson(json.decode(apiData.apiResponseData ?? "")) : null,
        errorMessage: apiData.errorMessage,
        apiResponseState: apiData.errorMessage != null ? ApiState.failure : ApiState.success
      ));
    });
  }

  Future<void> getBlogData() async {
    emit(state.copyWith(apiResponseState: ApiState.loading));
    await _repository.getBlogData();
  }
}
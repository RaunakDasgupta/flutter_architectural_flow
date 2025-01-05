import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/model/repositories/app_repository.dart';
import 'package:flutter_architectural_flow/viewmodel/state/blog_content_update_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlogContentViewModel extends Cubit<BlogContentUpdateState> {
  final AppRepository _repository;
  BlogContentViewModel({
    required AppRepository repository
  }): _repository = repository, super(const BlogContentUpdateState()) {
    repository.contentUpdateStream.listen((apiData) {
      emit(state.copyWith(
          errorMessage: apiData.errorMessage,
          apiResponseState: apiData.errorMessage != null
              ? ApiState.failure
              : ApiState.success
      ));
    });
  }

  Future<void> updateBlogJsonContent(String contentJsonString) async {
    emit(state.copyWith(apiResponseState: ApiState.loading));
    await _repository.updateBlogContent(contentJsonString);
  }
}
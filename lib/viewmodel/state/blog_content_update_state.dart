import 'package:equatable/equatable.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';

class BlogContentUpdateState extends Equatable{
  final ApiState apiResponseState;
  final String? errorMessage;
  const BlogContentUpdateState({
    this.apiResponseState = ApiState.idle,
    this.errorMessage
  });

  BlogContentUpdateState copyWith({
    ApiState? apiResponseState,
    String? errorMessage
  }){
    return BlogContentUpdateState(
        apiResponseState: apiResponseState ?? ApiState.idle,
        errorMessage: errorMessage
    );
  }

  @override
  List<Object?> get props => [apiResponseState, errorMessage];
}
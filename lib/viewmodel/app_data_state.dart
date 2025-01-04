import 'package:equatable/equatable.dart';
import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/data_classes/blog_data.dart';

class AppDataState extends Equatable{
  final BlogData? appData;
  final ApiState apiResponseState;
  final String? errorMessage;
  const AppDataState({
    required this.appData,
    this.apiResponseState = ApiState.idle,
    this.errorMessage
  });

  AppDataState copyWith({
    BlogData? appData,
    ApiState? apiResponseState,
    String? errorMessage
  }){
    return AppDataState(
      appData: appData,
      apiResponseState: apiResponseState ?? ApiState.idle,
      errorMessage: errorMessage
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [appData, apiResponseState, errorMessage];
}
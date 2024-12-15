import 'package:flutter_architectural_flow/core/api_data_holder.dart';
import 'package:flutter_architectural_flow/data_classes/dog_breed_response.dart';
import 'package:flutter_architectural_flow/model/repositories/app_repository.dart';
import 'package:flutter_architectural_flow/viewmodel/app_data_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppViewModel extends Cubit<AppDataState> {
  final AppRepository _repository;
  AppViewModel({
    required AppRepository repository
  }): _repository = repository, super(const AppDataState(appData: null)) {
    repository.appDataStream.listen((apiData){
      emit(state.copyWith(
        appData: DogBreedListResponse.fromJson(apiData.apiResponseData ?? {}),
        errorMessage: apiData.errorMessage,
        apiResponseState: apiData.errorMessage != null ? ApiState.failure : ApiState.success
      ));
    });
  }

  Future<void> getDogListData() async {
     emit(state.copyWith(apiResponseState: ApiState.loading));
     await _repository.getDogListData();
  }


}
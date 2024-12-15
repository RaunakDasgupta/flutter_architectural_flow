import 'package:equatable/equatable.dart';

typedef OnFailureCallback = void Function(int statusCode, String? errorMessage);

class ApiDataHolder<T> extends Equatable{
  T? _apiResponseData;
  int? _errorCode;
  String? _errorMessage;

  bool isErrorOccured() {
    return (_errorCode != null) ? true : false;
  }

  setApiResponseData(T? data){
    _apiResponseData = data;
  }
  T? get apiResponseData => _apiResponseData;

  setErrorCode(int errorCode){
    _errorCode = errorCode;
  }
  int? get errorCode => _errorCode;

  setErrorMessage(String errorMessage){
    _errorMessage = errorMessage;
  }
  String? get errorMessage => _errorMessage;

  @override
  List<Object?> get props => [_apiResponseData, _errorCode, _errorMessage];
}

enum ApiState {
  idle,
  loading,
  success,
  failure
}
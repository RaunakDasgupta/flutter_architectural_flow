import 'package:equatable/equatable.dart';

typedef OnFailureCallback = void Function(int statusCode, String? errorMessage);

class ApiDataHolder extends Equatable{
  Map<String, dynamic>? _apiResponseData;
//  OnFailureCallback? _onFailureCallback;
  int? _errorCode;
  String? _errorMessage;

  bool isErrorOccured() {
    return (_errorCode != null) ? true : false;
  }

  setApiResponseData(Map<String, dynamic> data){
    _apiResponseData = data;
  }
  Map<String, dynamic>? get apiResponseData => _apiResponseData;

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

// setOnFailureCallback(OnFailureCallback callBack){
//   _onFailureCallback = callBack;
// }
// OnFailureCallback? get onFailureCallback => _onFailureCallback;
}

enum ApiState {
  idle,
  loading,
  success,
  failure
}
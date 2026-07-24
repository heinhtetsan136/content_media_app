import 'package:media_content_library/feature/auth/data/model/sign_up_model.dart';

class SignUpStateModel {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final SignUpModel? signUpModel;

  final String? errorMessage;
  final bool initialState;

  SignUpStateModel({
    this.errorMessage,
    this.initialState = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailed = false,
    this.signUpModel,
  });
  SignUpStateModel copyWith({
    bool? initialState,
    bool? isLoading,
    bool? isSucces,
    bool? isFailed,
    SignUpModel? signUpModel,
    String? errorMessage,
  }) {
    return SignUpStateModel(
      signUpModel: signUpModel ?? this.signUpModel,
      initialState:
          initialState ?? this.initialState,
      errorMessage:
          errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isSuccess: isSucces ?? this.isSuccess,
      isFailed: isFailed ?? this.isFailed,
    );
  }
}

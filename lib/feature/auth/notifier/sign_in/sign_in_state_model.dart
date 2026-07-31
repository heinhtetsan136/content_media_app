import 'package:media_content_library/feature/auth/data/model/sigin_model.dart';

class SignInStateModel {

  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final SignInModel? signInModel;

  final String? errorMessage;
  final bool initialState;

  SignInStateModel({
    this.errorMessage,
    this.initialState = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailed = false,
    this.signInModel,
  });
  SignInStateModel copyWith({
    bool? initialState,
    bool? isLoading,
    bool? isSucces,
    bool? isFailed,
    SignInModel? signInModel,
    String? errorMessage,
  }) {
    return SignInStateModel(
      signInModel: signInModel ?? this.signInModel,
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
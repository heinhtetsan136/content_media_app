import 'package:media_content_library/feature/auth/data/model/singn_up_otp.dart';

class SignUpOtpStateModel {
  final bool isLoading;
  final bool isSuccess;
  final bool isFailed;
  final SignUpOtpModel? otpModel;

  final String? errorMessage;
  final bool initialState;

  SignUpOtpStateModel({
    this.errorMessage,
    this.initialState = true,
    this.isLoading = false,
    this.isSuccess = false,
    this.isFailed = false,
    this.otpModel,
  });
  SignUpOtpStateModel copyWith({
    bool? initialState,
    bool? isLoading,
    bool? isSucces,
    bool? isFailed,
    SignUpOtpModel? otpModel,
    String? errorMessage,
  }) {
    return SignUpOtpStateModel(
      otpModel: otpModel ?? this.otpModel,
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

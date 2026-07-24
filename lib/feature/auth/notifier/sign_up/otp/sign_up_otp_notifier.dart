import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/auth/data/service/auth_service.dart';
import 'package:media_content_library/feature/auth/notifier/sign_up/otp/sign_up_otp_state_model.dart';

typedef SignupOtpProvider =
    NotifierProvider<
      SignUpOtpNotifier,
      SignUpOtpStateModel
    >;

class SignUpOtpNotifier
    extends Notifier<SignUpOtpStateModel> {
  @override
  SignUpOtpStateModel build() {
    // TODO: implement build
    return SignUpOtpStateModel();
  }

  final AuthService authService = AuthService();
  void failed() {
    print("try again");
    state = state.copyWith(
      isFailed: false,
      isSucces: false,
      initialState: true,
      otpModel: null,
    );
  }

  void requestOtp({required String email}) async {
    try {
      state = state.copyWith(
        isLoading: true,
        initialState: false,
        isFailed: false,
        isSucces: false,
      );
      final otpModel = await authService.getOtp(
        email: email,
      );
      state = state.copyWith(
        isLoading: false,
        isSucces: true,
        otpModel: otpModel,
      );
    } catch (e) {
      String errorMessage="Something Wrong";
      if(e is DioException){
        errorMessage=e.response?.data["message"] ??errorMessage;
      }
      state = state.copyWith(
        isLoading: false,
        isSucces: false,
        isFailed: true,
        errorMessage: "$errorMessage",
      );
    }
  }
}

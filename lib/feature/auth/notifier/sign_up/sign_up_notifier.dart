import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/auth/notifier/sign_up/sign_up_state_model.dart';

import '../../data/service/auth_service.dart';

typedef SignupProvider =
    NotifierProvider<
      SignUpNotifier,
      SignUpStateModel
    >;

class SignUpNotifier
    extends Notifier<SignUpStateModel> {
  @override
  SignUpStateModel build() {
    // TODO: implement build
    return SignUpStateModel();
  }

  final AuthService authService = AuthService();
  void tryAgin() {
    state = state.copyWith(
      isFailed: false,
      isSucces: false,
      initialState: true,
      isLoading: false,
      signUpModel: null,
    );
  }

  void signUp({
    required String email,
    required String password,
    required String otp,
    required String name,
  }) async {
    try {
      state = state.copyWith(
        isLoading: true,
        initialState: false,
        isFailed: false,
        isSucces: false,
      );
      final signUpModel = await authService
          .signUp(
            email: email,
            name: name,
            password: password,
            otp: otp,
          );
      state = state.copyWith(
        isLoading: false,
        isSucces: true,
        signUpModel: signUpModel,
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

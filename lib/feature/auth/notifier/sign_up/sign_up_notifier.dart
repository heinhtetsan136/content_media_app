import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/const/di/locator.dart';
import 'package:media_content_library/const/storage/user_session.dart';
import 'package:media_content_library/feature/auth/data/model/sign_up_model.dart';
import 'package:media_content_library/feature/auth/notifier/sign_up/sign_up_state_model.dart';

import '../../data/service/auth_service.dart';

typedef SignupProvider =
    NotifierProvider<
      SignUpNotifier,
      SignUpStateModel
    >;

class SignUpNotifier
    extends Notifier<SignUpStateModel> {
  final UserSession userSession = getIt
      .get<UserSession>();
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
      await _saveUserCreditial(signUpModel);
      state = state.copyWith(
        isLoading: false,
        isSucces: true,
        signUpModel: signUpModel,
      );
      await _saveUserCreditial(signUpModel);
    }

    catch (e) {

      String errorMessage = "Something Wrong";
      if (e is DioException) {
        final error =
            e.response?.data;
        print(error);
        if(error is Map?){
          errorMessage=error?["message"] ?? errorMessage;
        }
      }

      print(errorMessage);
      state = state.copyWith(
        initialState: false,
        isLoading: false,
        isSucces: false,
        isFailed: true,
        errorMessage: errorMessage,
      );
    }
  }

  Future<void> _saveUserCreditial(
    SignUpModel signUpModel,
  ) async {
    await userSession.saveName(
      name: signUpModel.user?.name ?? "",
    );
    await userSession.saveId(
      id: signUpModel.user?.id?.toString() ?? "",
    );
    await userSession.saveToken(
      token: signUpModel.token ?? "",
    );
    await userSession.saveEmail(
      email: signUpModel.user?.email ?? "",
    );
  }

}

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/const/di/locator.dart';
import 'package:media_content_library/const/storage/user_session.dart';
import 'package:media_content_library/feature/auth/data/model/sigin_model.dart';
import 'package:media_content_library/feature/auth/data/service/auth_service.dart';
import 'package:media_content_library/feature/auth/notifier/sign_in/sign_in_state_model.dart';

typedef SigninProvider =
    NotifierProvider<
      SignInNotifier,
      SignInStateModel
    >;

class SignInNotifier
    extends Notifier<SignInStateModel> {
  final AuthService _authService = AuthService();
  @override
  SignInStateModel build() {
    // TODO: implement build
    return SignInStateModel();
  }

  Future<void> tryAgain() async{
    state = state.copyWith(
      initialState: true,
      isSucces: false,
      isFailed: false,
      signInModel: null,
    );
  }
  final UserSession userSession=getIt.get<UserSession>();
  Future<void> _saveUserCreditial(
      SignInModel signInModel,
      ) async {
    await userSession.saveName(
      name: signInModel.user?.name ?? "",
    );
    await userSession.saveId(
      id: signInModel.user?.id?.toString() ?? "",
    );
    await userSession.saveToken(
      token: signInModel.token ?? "",
    );
    await userSession.saveEmail(
      email: signInModel.user?.email ?? "",
    );
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    try {
      state = state.copyWith(
        initialState: false,
        isFailed: false,
        isLoading: true,
        isSucces: false,
      );
      final result = await _authService.login(
        email: email,
        password: password,
      );
   await   _saveUserCreditial(result);
      state = state.copyWith(
        signInModel: result,
        isFailed: false,
        isLoading: false,
        isSucces: true,
      );
    } catch (e) {
      String errorMessage = "Something Wrong";
      if (e is DioException) {
        final error =
            e.response?.data;
        print(error);
        if(error is Map?){
          errorMessage=error?["message"] ?? errorMessage;
        }
      }
      state = state.copyWith(
        errorMessage: errorMessage,
        initialState: false,
        isFailed: true,
        isLoading: false,
        isSucces: false,
      );
    }
  }
}

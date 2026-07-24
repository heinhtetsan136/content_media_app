import 'dart:math';

import 'package:dio/dio.dart';
import 'package:media_content_library/const/api_const/api_const.dart';
import 'package:media_content_library/const/di/locator.dart';
import 'package:media_content_library/feature/auth/data/model/sign_up_model.dart';
import 'package:media_content_library/feature/auth/data/model/singn_up_otp.dart';

class AuthService {
  final Dio _dio = getIt.get<Dio>();
  Future<SignUpOtpModel> getOtp({
    required String email,
  }) async {
    final result = await _dio.post(
      ApiConst.signUpOtp,
      data: {"email": email},
    );
    return SignUpOtpModel.fromJson(result.data);
  }

  Future<SignUpModel> signUp({
    required String name,
    required String email,
    required String password,
    required String otp,
  }) async {
    final response = await _dio.post(
      ApiConst.signUp,
      data: {
        "name": name,
        "email": email,
        "password": password,
        "otp": otp,
      },
    );
    return SignUpModel.fromJson(response.data);
  }
}

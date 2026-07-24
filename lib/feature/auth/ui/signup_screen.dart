import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/feature/auth/notifier/sign_up/otp/sign_up_otp_notifier.dart';
import 'package:media_content_library/feature/auth/notifier/sign_up/sign_up_notifier.dart';
import 'package:media_content_library/feature/ui/widget/failed_widget.dart';

class SignupScreen
    extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() =>
      _SignupScreenState();
}

class _SignupScreenState
    extends ConsumerState<SignupScreen> {
  final SignupProvider _signupProvider =
      SignupProvider(() => SignUpNotifier());
  final TextEditingController _controller =
      TextEditingController();
  final SignupOtpProvider _signupOtpProvider =
      SignupOtpProvider(
        () => SignUpOtpNotifier(),
      );
  GlobalKey<FormState> formKey =
      GlobalKey<FormState>();
  String? _name, _email, _password;
  @override
  Widget build(BuildContext context) {
    final signUpState=ref.watch(_signupProvider);
    final otpState = ref.watch(_signupOtpProvider);
    return Scaffold(
      appBar: AppBar(title: Text("Sign Up")),
      body: Center(
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.center,
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            if (otpState.initialState)
              Center(
                child: Container(
                  constraints: BoxConstraints(
                    maxWidth: 500,
                  ),
                  padding: EdgeInsets.all(8),

                  child: Form(
                    key: formKey,

                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (name) {
                            _name = name;
                          },
                          validator: (name) {
                            if (name
                                    ?.trim()
                                    .isEmpty ==
                                true) {
                              return "Please enter your name";
                            } else if (name !=
                                    null &&
                                name.length < 3) {
                              return "Enter valid name";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(),
                            hintText:
                                "Enter Your Name *",
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          onSaved: (email) {
                            _email = email;
                          },
                          validator: (email) {
                            if (email
                                        ?.trim()
                                        .isEmpty ==
                                    true ||
                                email == null) {
                              return "Please enter your email";
                            }
                            final RegExp
                            emailRegExp = RegExp(
                              r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
                            );
                            if (!emailRegExp
                                .hasMatch(
                                  email,
                                )) {
                              return "Please Enter valid Email";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(),
                            hintText:
                                "Enter Your email *",
                          ),
                        ),
                        SizedBox(height: 8),
                        TextFormField(
                          onSaved: (p) {
                            print(p);
                            _password = p;
                          },
                          decoration: InputDecoration(
                            border:
                                OutlineInputBorder(),
                            hintText:
                                "Enter Your password(min 8 digits) *",
                          ),
                          validator: (password) {
                            if (password
                                    ?.trim()
                                    .isEmpty ==
                                true) {
                              return "Please enter your password";
                            } else if (password !=
                                    null &&
                                password.length <
                                    9) {
                              return "Enter valid password";
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {
                            print(
                              "${_email} ${_password}",
                            );
                            if (formKey
                                    .currentState
                                    ?.validate() ==
                                true) {
                              formKey.currentState
                                  ?.save();
                              print(_email);
                              ref
                                  .read(
                                    _signupOtpProvider
                                        .notifier,
                                  )
                                  .requestOtp(
                                    email:
                                        _email ??
                                        "",
                                  );
                            }
                          },
                          child: Text("Continue"),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            if (otpState.isLoading || signUpState.isLoading)
              Center(
                child:
                    CircularProgressIndicator(),
              ),
            if (otpState.isFailed || signUpState.isFailed)
              FailedWidget(
                errorMessage: otpState.isFailed ? otpState.errorMessage :signUpState.errorMessage  ,

                ref: ref,
                onTry: () {
                  if(otpState.isFailed){
                    ref
                        .read(
                      _signupOtpProvider
                          .notifier,
                    )
                        .failed();
                    return;
                  }
                  if(signUpState.isFailed){
                    ref.read(_signupProvider.notifier).tryAgin();
                  }

                },
              ),
            if (otpState.isSuccess && signUpState.initialState)
              Container(
                padding: EdgeInsets.all(8),
                constraints: BoxConstraints(
                  maxWidth: 300,
                ),
                child: Column(
                  mainAxisAlignment:
                      MainAxisAlignment.center,
                  children: [
                    Text("Enter Otp"),
                    SizedBox(height: 10),
                    TextField(
                      keyboardType:
                          TextInputType.number,
                      controller: _controller,

                      decoration: InputDecoration(
                        labelText:
                            "Enter Six Digit of Otp",
                        border:
                            OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 10),
                    OutlinedButton(
                      onPressed: () {
                        if (_controller.text
                                .trim()
                                .length !=
                            6 ) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Enter your 6 digit OTP",
                              ),
                            ),
                          );
                          _controller.text = "";
                          return;
                        }
                        ref
                            .read(
                              _signupProvider
                                  .notifier,
                            )
                            .signUp(
                              email: _email!,
                              password:
                                  _password!,
                              otp: _controller
                                  .text,
                              name: _name!,
                            );
                      },
                      child: Text("Sign Up"),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}

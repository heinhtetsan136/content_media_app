import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_content_library/const/di/locator.dart';
import 'package:media_content_library/feature/auth/notifier/sign_in/sign_in_notifier.dart';
import 'package:media_content_library/feature/auth/notifier/sign_in/sign_in_state_model.dart';
import 'package:media_content_library/feature/setting/notifier/profile/profile_notifier.dart';
import 'package:media_content_library/feature/ui/widget/failed_widget.dart';

class SigninScreen
    extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() =>
      _SigninScreenState();
}

class _SigninScreenState
    extends ConsumerState<SigninScreen> {

  final SigninProvider _signInProvider =
      SigninProvider(() => SignInNotifier());
  final GlobalKey<FormState> formKey =
      GlobalKey();
  final ProfileProvider _profileProvider=getIt.get();
  String? _password;
  String? _email;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(_profileProvider.notifier).checkAuth();
    });
  }
  @override
  Widget build(BuildContext context) {
    ref.listen(_profileProvider, (oldState,newState){
      if(newState.token?.isNotEmpty ==true){
        context.go("/");
      }
    });
    return Scaffold(
      appBar: AppBar(title: Text("Sign in")),
      body: _signInbody(),
    );
  }

  Widget _signInbody() {
    ref.listen(_signInProvider, (o, n) async {
      if (n.isSuccess &&
          n.signInModel?.token?.isNotEmpty ==
              true) {
        Future.delayed(Duration(seconds: 1));
        ref.read(_profileProvider.notifier).checkAuth();
        if (context.mounted) {
          context.go("/settings");
        }
      }
    });
    final SignInStateModel stateModel = ref.watch(
      _signInProvider,
    );
    if (stateModel.initialState) {
      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            Container(
              constraints: BoxConstraints(
                maxWidth: 500,
              ),
              padding: EdgeInsets.all(8),
              child: Form(
                key: formKey,

                child: Column(
                  children: [
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
                        if (!emailRegExp.hasMatch(
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
                      obscureText: true,
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
                            password.length < 9) {
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
                        if (formKey.currentState
                                ?.validate() ==
                            true) {
                          formKey.currentState
                              ?.save();
                          print(_email);
                          ref
                              .read(
                                _signInProvider
                                    .notifier,
                              )
                              .login(
                                password:
                                    _password ??
                                    "",
                                email:
                                    _email ?? "",
                              );
                        }
                      },
                      child: Text("Continue"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }
    if (stateModel.isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }
    if (stateModel.isSuccess) {
      return Text("Success");
    }
    if (stateModel.isFailed) {
      return Center(
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center,
          children: [
            FailedWidget(
              errorMessage: stateModel.errorMessage,
              ref: ref,
              onTry: () {
                ref
                    .read(
                      _signInProvider.notifier,
                    )
                    .tryAgain();
              },
            ),
          ],
        ),
      );
    }
    return SizedBox.shrink();
  }
}

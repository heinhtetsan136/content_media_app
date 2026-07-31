import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/const/di/locator.dart';
import 'package:media_content_library/const/storage/user_session.dart';
import 'package:media_content_library/feature/setting/notifier/profile/profile_state_model.dart';

typedef ProfileProvider =
    NotifierProvider<
      ProfileNotifier,
      ProfileStateModel
    >;

class ProfileNotifier
    extends Notifier<ProfileStateModel> {
  final UserSession userSession = getIt
      .get<UserSession>();
  @override
  ProfileStateModel build() {
    // TODO: implement build
    return ProfileStateModel();
  }
  Future<void> logOut()async{
    await userSession.logOut();
  state=ProfileStateModel();



  }

  Future<void> checkAuth() async {
    try {
      state = state.copyWith(
        name: await userSession.getName(),
        email: await userSession.getEmail(),
        id: await userSession.getId(),
        token: await userSession.getToken(),
      );
    } catch (e) {}
  }
}

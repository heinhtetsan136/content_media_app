import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:media_content_library/const/di/locator.dart';
import 'package:media_content_library/const/storage/user_session.dart';
import 'package:media_content_library/feature/setting/notifier/profile/profile_notifier.dart';
import 'package:media_content_library/feature/setting/notifier/profile/profile_state_model.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
 ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final ProfileProvider provider=getIt.get<ProfileProvider>();
    @override
  void initState() {

    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_){
      ref.read(provider.notifier).checkAuth();
    });
  }


  @override
  Widget build(BuildContext context) {
      final ProfileStateModel stateModel=ref.watch(provider);
      print(stateModel.token);
    if(stateModel.token?.isNotEmpty ==true ){
      return Column(
        children: [
          ListTile(
            leading: Icon(Icons.person),
            title: Text(stateModel.name ??""),),
          ListTile(
            leading: Icon(Icons.email),
            title: Text(stateModel.email??""),),
          ListTile(
            onTap: ()async{

  await ref.read(provider.notifier).logOut();


              if(context.mounted){
                context.go("/");
              }
            },
            leading: Icon(Icons.logout),
            title: Text("Log Out"),)
        ],
      );
    }
    else{
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              onTap: () {
                context.push("/signUp");
              },
              title: Text("Sign up"),
            ),
            Divider(),
            ListTile(
              onTap: () {
                context.push("/login");
              },
              title: Text("Sign In"),
            ),
          ],
        ),
      );
    }
  }
}

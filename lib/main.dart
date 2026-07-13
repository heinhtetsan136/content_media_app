import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:media_content_library/const/router/router.dart';

import 'const/di/locator.dart';
import 'feature/ui/home/home.dart';


void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await setUpLocator();
  runApp(ProviderScope(child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',

    routerConfig : goRoute,
    );
  }
}




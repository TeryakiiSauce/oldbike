///
/// This file includes the theme data as well as the screen routes information.
/// === === === === ===

import 'firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/utils/theme.dart';
import 'package:oldbike/utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const OldBikeApp());
}

class OldBikeApp extends StatelessWidget {
  const OldBikeApp({super.key});

  MaterialApp buildAndroidApp() => MaterialApp.router(
        routerConfig: appRouter,
        debugShowCheckedModeBanner: false,
        title: 'Old Bike',
        theme: androidThemeData,
      );

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return buildAndroidApp();
  }
}

import 'package:chat_app_koko/auth/auth_gate.dart';
import 'package:chat_app_koko/pages/login_page.dart';
import 'package:chat_app_koko/themes/light_mode.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'auth/login_or_register.dart';

Future main() async {
WidgetsFlutterBinding.ensureInitialized();
if(kIsWeb){
  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyC61k-ml6oJ4HqkCkIqLzAKIpsUMJyT0-c",
          appId: "1:782470251607:web:9d0a288c9703edf6fe0f12",
          messagingSenderId: "782470251607",
          projectId: "chatappkoko-5468d",));
}
await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: lightMode,
      // home: LoginPage(),
      // home: LoginOrRegister(),
      home: AuthGate(),
    );
  }
}

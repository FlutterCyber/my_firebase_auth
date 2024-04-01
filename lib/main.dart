import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_auth/firebase_options.dart';
import 'package:my_firebase_auth/pages/home_page.dart';
import 'package:my_firebase_auth/pages/post_page.dart';
import 'package:my_firebase_auth/pages/sign_in_page.dart';
import 'package:my_firebase_auth/pages/sign_up_page.dart';
import 'package:my_firebase_auth/pages/splash_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashPage(),
      routes: {
        SplashPage.id: (context) => const SplashPage(),
        SignInPage.id: (context) => const SignInPage(),
        SignUpPage.id: (context) => const SignUpPage(),
        HomePage.id: (context) => const HomePage(),
        PostPage.id: (context) => const PostPage(),
      },
    );
  }
}

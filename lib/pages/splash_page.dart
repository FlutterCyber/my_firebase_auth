import 'dart:async';

import 'package:flutter/material.dart';
import 'package:my_firebase_auth/pages/sign_in_page.dart';
import 'package:my_firebase_auth/pages/sign_up_page.dart';

class SplashPage extends StatefulWidget {
  static const String id = "splash_page";

  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoggedIn = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _myTimer();
  }

  void _myTimer() {
    Timer(const Duration(seconds: 3), () {
      if (isLoggedIn == true) {
        Navigator.pushReplacementNamed(context, SignInPage.id);
      } else {
        Navigator.pushReplacementNamed(context, SignUpPage.id);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Stack(
          children: [
            Center(
              child: Container(
                height: 300,
                width: 300,
                child: Image.asset('assets/images/netflix.png'),
              ),
            ),
            const Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Center(
                  child: Text(
                    "From Netflix",
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

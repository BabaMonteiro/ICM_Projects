import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzy/pages/auth.dart';
import 'package:quizzy/pages/profile.dart';
import 'package:quizzy/services/splash.dart';

class Account extends StatelessWidget {

  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (ctx, snapshot) {
      print("Connection state: ${snapshot.connectionState}");
      print("Has data: ${snapshot.hasData}");
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const SplashScreen();
      }
      if (snapshot.hasData) {
        return ProfileScreen();
      }
      return const AuthScreen();
    });
  }
}
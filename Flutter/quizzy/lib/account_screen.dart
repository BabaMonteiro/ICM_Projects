

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:quizzy/auth.dart';
import 'package:quizzy/profile.dart';
import 'package:quizzy/splash.dart';
import 'package:quizzy/start_screen.dart';

class Account extends StatelessWidget {

  const Account({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(), 
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashScreen();
        }

        if (snapshot.hasData) {
          return const ProfileScreen();
        }

        return const AuthScreen();
      });
  }
}

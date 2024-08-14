import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/screens/mainwrapper.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasData) {
            return MainWrapper();
          } else if (snapshot.hasError) {
            return Center(child: Text('Something went wrong: ${snapshot.error}'));
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}

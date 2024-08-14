import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/screens/mainwrapper.dart';
import 'package:lightforisrael/presentation/themes/my_app_theme.dart';

class HomePage extends StatelessWidget {
   HomePage({super.key}); 

  final user = FirebaseAuth.instance.currentUser;


  void signUserOut() {
   FirebaseAuth.instance.signOut();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      home: const MainWrapper(),
    );
  }
}

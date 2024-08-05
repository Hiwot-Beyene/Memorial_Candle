import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lightforisrael/presentation/screens/mainwrapper.dart';

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
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          primary: Colors.deepPurple,
          secondary: Colors.amber,
          background: Colors.black, 
          onBackground: Colors.white, 
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black, 
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Colors.black, 
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white), 
          bodyMedium: TextStyle(color: Colors.white), 
          headlineLarge: TextStyle(color: Colors.white), 
          headlineMedium: TextStyle(color: Colors.white), 
          headlineSmall: TextStyle(color: Colors.white), 
          titleLarge: TextStyle(color: Colors.white), 
          titleMedium: TextStyle(color: Colors.white), 
          titleSmall: TextStyle(color: Colors.white), 
          labelLarge: TextStyle(color: Colors.white),
          labelMedium: TextStyle(color: Colors.white), 
          labelSmall: TextStyle(color: Colors.white), 
        ),
        iconTheme: IconThemeData(
          color: Colors.white, 
        ),
        // bottomNavigationBarTheme: BottomNavigationBarThemeData(
        //   backgroundColor: Colors.black, 
        //   selectedItemColor: Colors.white, 
        //   unselectedItemColor: Colors.grey, 
        // ),
        dividerColor: Colors.white, 
      ),
      home: const MainWrapper(),
    );;
  }
}

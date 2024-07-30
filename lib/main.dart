import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lightforisrael/presentation/screens/login_page.dart';
import 'package:lightforisrael/presentation/screens/signup_page.dart';
import 'package:lightforisrael/presentation/screens/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter router = GoRouter(
      initialLocation: '/splash1',
      routes: [
        GoRoute(
          path: '/splash1',
          builder: (context, state) => SplashScreen(),
        ),
        GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(),
        ),
        GoRoute(
          path: '/signup',
          builder: (context, state) => SignUpPage(),
        ),
      ],
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

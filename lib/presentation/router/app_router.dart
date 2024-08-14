import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lightforisrael/presentation/screens/auth_page.dart';
import 'package:lightforisrael/presentation/screens/mainwrapper.dart';
import 'package:lightforisrael/presentation/screens/my_candles.dart';
import 'package:lightforisrael/presentation/screens/profile.dart';
import 'package:lightforisrael/presentation/screens/signup_page.dart';
import 'package:lightforisrael/presentation/screens/splash_screen.dart';

GoRouter createRouter() {
  return GoRouter(
    initialLocation: '/splash1',
    routes: [
      GoRoute(
        path: '/splash1',
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => AuthPage(),
      ),
      GoRoute(
        path: '/signup',
        builder: (context, state) => SignUpPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => MainWrapper(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => ProfilePage(),
      ),
    ],
  );
}

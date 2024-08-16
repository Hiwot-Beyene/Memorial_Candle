import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:go_router/go_router.dart';
// ignore: depend_on_referenced_packages
import 'package:firebase_core/firebase_core.dart';
import 'package:lightforisrael/consts.dart';
import 'package:lightforisrael/data/services/stripe_service.dart';
import 'package:lightforisrael/presentation/themes/my_app_theme.dart';
import 'firebase_options.dart';
import 'presentation/router/app_router.dart';

void main() async {
  await _setup();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp( MyApp());
  
}

Future<void> _setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GoRouter router = createRouter();
    return MaterialApp.router(
      theme:appTheme,
      debugShowCheckedModeBanner: false,
      routerConfig: router,
    );
  }
}

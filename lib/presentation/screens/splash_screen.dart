import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:go_router/go_router.dart';
import 'package:lightforisrael/presentation/widgets/my_button.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/splash.jpeg', 
              fit: BoxFit.cover,
            ),
          ),
          // Blurry overlay at the bottom
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: 350, 
              width: double.infinity,
              child: Stack(
                children: [
                  Blur(
                    blur: 4,
                    blurColor:Colors.black,
                    colorOpacity: 0.1,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.5),
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(50),
                          topRight: Radius.circular(50),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 25, horizontal: 20),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Light For Israel',
                          style: TextStyle(
                            color: Color.fromARGB(255, 197, 20, 20),
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Text(
                          'In memory of lives lost to Hamas violence, this app serves as a tribute. Each flame represents a cherished individual, symbolizing our collective grief, resilience, and hope for peace.',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 25),
                        Align(
                          alignment: Alignment.center,
                          child: MyButton(
                            buttonText: 'Get Started',
                            onTap: () {
                              GoRouter.of(context).go('/login');
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

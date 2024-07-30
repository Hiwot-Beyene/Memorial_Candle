import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lightforisrael/presentation/components/my_button.dart';
import 'package:lightforisrael/presentation/components/square_tile.dart';
import 'package:lightforisrael/presentation/components/text_field.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key? key}) : super(key: key);

  //text editing controllers
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in
  void signUserUp() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: Image.asset(
              'assets/bg.jpeg', 
              fit: BoxFit.cover,
            ),
          ),
          // Blurred Background
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                color:
                    const Color.fromARGB(255, 198, 51, 51).withOpacity(0.4), 
              ),
            ),
          ),
          // UI Content
          SafeArea(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  // Logo
                  Container(
                    width: 200.0, 
                    height: 200.0, 
                    child: Image.asset('assets/logo.png'),
                  ),
                  SizedBox(height: 20),
                  // Welcome text
                  Text(
                    'Welcome Back',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  SizedBox(height: 20),
                  // Username input
                  CustomTextField(
                    controller: usernameController,
                    hintText: 'Username',
                    obscureText: false,
                  ),
                  SizedBox(height: 20),
                  // Password input
                  CustomTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: true,
                  ),
                  SizedBox(height: 20),
                  // Forgot password
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            context.go('/signup');
                          },
                          child: Text(
                            'SignIn?',
                            style: TextStyle(
                                color: Color.fromARGB(255, 172, 29, 29),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        SizedBox(
                          width: 132,
                        ),
                        Text(
                          'Forgot password?',
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // Login button
                  MyButton(
                    buttonText: 'Login',
                    onTap: signUserUp,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: const Row(
                      children: [
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            "continue with",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                        Expanded(
                          child: Divider(
                            thickness: 0.5,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Or continue with Google
                  SizedBox(
                    height: 20,
                  ),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SquareTile(imagePath: 'assets/google.png'),
                      SizedBox(
                        width: 20,
                      ),
                      SquareTile(imagePath: 'assets/apple.png')
                    ],
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  Center(
                    child: Text(
                      'Continue as Guest',
                      style: TextStyle(
                          color: const Color.fromARGB(255, 235, 61, 61)),
                    ),
                  )
                  // Not a member? Sign up
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lightforisrael/data/services/auth_services.dart';
import 'package:lightforisrael/presentation/widgets/my_button.dart';
import 'package:lightforisrael/presentation/widgets/square_tile.dart';
import 'package:lightforisrael/presentation/widgets/text_field.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  final AuthService _authService = AuthService();

  Future<void> signUserIn() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    if (usernameController.text.isEmpty || passwordController.text.isEmpty) {
      setState(() {
        _errorMessage = 'Please enter both email and password';
        _isLoading = false;
      });
      return;
    }

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      setState(() {
        _errorMessage = ''; 
      });
      
      context.go('/home');
    } on FirebaseAuthException catch (e) {
      setState(() {
        if (e.code == 'user-not-found') {
          _errorMessage = 'User not found';
        } else if (e.code == 'wrong-password') {
          _errorMessage = 'Incorrect password';
        } else {
          _errorMessage = 'An error occurred: ${e.message}';
        }
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> signInWithGoogle() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    try {
      User? user = await _authService.signInWithGoogle();
      if (user != null) {
        
        context.go('/home');
      } else {
        setState(() {
          _errorMessage = 'Failed to sign in with Google';
        });
      }
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/bg.jpeg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(
                color: Colors.black.withOpacity(0.7),
              ),
            ),
          ),
          SafeArea(
            child: Center(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: IntrinsicHeight(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const SizedBox(height: 10),
                            Container(
                              width: 200.0,
                              height: 200.0,
                              child: Image.asset('assets/logo.png'),
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Welcome Back',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 30),
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: usernameController,
                              hintText: 'Username',
                              obscureText: false,
                            ),
                            SizedBox(height: 10),
                            CustomTextField(
                              controller: passwordController,
                              hintText: 'Password',
                              obscureText: true,
                            ),
                            SizedBox(height: 10),
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
                                      'SignUp?',
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 172, 29, 29),
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  SizedBox(width: 132),
                                  Text(
                                    'Forgot password?',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            if (_errorMessage.isNotEmpty)
                              Padding(
                                padding: const EdgeInsets.only(top: 8.0),
                                child: Text(
                                  _errorMessage,
                                  style: TextStyle(color: Colors.red),
                                ),
                              ),
                            const SizedBox(height: 10),
                            MyButton(
                              buttonText: 'Login',
                              onTap: signUserIn,
                            ),
                            const SizedBox(height: 10),
                            const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 25),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Divider(
                                      thickness: 0.5,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 10),
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
                            SizedBox(height: 10),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SquareTile(
                                  onTap: signInWithGoogle,
                                  imagePath: 'assets/google.png'),
                                SizedBox(width: 10),
                                SquareTile(
                                  onTap: (){
                                    
                                  },
                                  imagePath: 'assets/facebook.png'),
                              ],
                            ),
                            SizedBox(height: 50),
                            Center(
                              child: TextButton(
                                onPressed: () {
                                  context.go('/home');
                                },
                                child: Text(
                                  'Continue as Guest',
                                  style: TextStyle(
                                      color: const Color.fromARGB(
                                          255, 235, 61, 61)),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          if (_isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}

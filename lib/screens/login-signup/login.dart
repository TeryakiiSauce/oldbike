import 'package:flutter/material.dart';
import 'package:oldbike/constants.dart';
import 'package:oldbike/screens/home/home.dart';

class LoginScreen extends StatefulWidget {
  static const String screen = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Sign In',
                style: kTitleTS,
              ),
              const Text(
                'The app\nfor tracking all\nyour bike rides',
                style: kLargeLabelTS,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextFormField(
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.person),
                      hintText: 'Username',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  TextFormField(
                    obscureText: true,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: const Icon(Icons.visibility_outlined),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16.0),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  const Text(
                    'Forgot Password?',
                    textAlign: TextAlign.right,
                    style: kAttentionLabelTS,
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_circle_right_rounded,
                size: 100.0,
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text('Don\'t have an account?'),
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Create Account',
                        style: kAttentionLabelTS,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15.0,
                    width: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Wanna do it up later?'),
                      const SizedBox(
                        width: 5.0,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                              context, HomeScreen.screen);
                        },
                        child: const Text(
                          'Skip',
                          style: kAttentionLabelTS,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';
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
    const SizedBox spacing = SizedBox(
      height: 30.0,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            reverse: true,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Sign In',
                    style: ktsMainTitle,
                  ),
                  spacing,
                  const Text(
                    'The app\nfor tracking all\nyour bike rides',
                    style: ktsNormalLargeLabel,
                  ),
                  spacing,
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
                        style: ktsAttentionLabel,
                      ),
                    ],
                  ),
                  spacing,
                  const Icon(
                    Icons.arrow_circle_right_rounded,
                    size: 100.0,
                  ),
                  spacing,
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
                            style: ktsAttentionLabel,
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
                              style: ktsAttentionLabel,
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
        ),
      ),
    );
  }
}

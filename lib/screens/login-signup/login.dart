import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/screens/login-signup/signup.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/tab_view_controller.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class LoginScreen extends StatefulWidget {
  static const String screen = 'login';

  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;

  Future<void> togglePasswordVisibility() async {
    await HapticFeedback.selectionClick();

    setState(() {
      if (showPassword) {
        showPassword = false;
      } else {
        showPassword = true;
      }
    });
  }

  Icon getVisibilityIcon() {
    if (showPassword) {
      return const Icon(Icons.visibility_off_outlined);
    } else {
      return const Icon(Icons.visibility_outlined);
    }
  }

  @override
  Widget build(BuildContext context) {
    const SizedBox spacing = SizedBox(
      height: 30.0,
    );

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Scrollbar(
            child: SingleChildScrollView(
              reverse: true,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30.0,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    spacing,
                    const AppLogo(),
                    spacing,
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
                          decoration: const InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            hintText: 'Username',
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                        TextFormField(
                          obscureText: !showPassword,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.lock),
                            suffixIcon: GestureDetector(
                              onTap: () {
                                togglePasswordVisibility();
                              },
                              child: getVisibilityIcon(),
                            ),
                            hintText: 'Password',
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
                          children: [
                            const Text('Don\'t have an account?'),
                            const SizedBox(
                              width: 5.0,
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, SignUpScreen.screen);
                              },
                              child: const Text(
                                'Create Account',
                                style: ktsAttentionLabel,
                              ),
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
                                HapticFeedback.selectionClick();
                                PersistentNavBarNavigator.pushNewScreen(
                                  context,
                                  withNavBar: false,
                                  pageTransitionAnimation:
                                      PageTransitionAnimation.cupertino,
                                  screen: const TabViewController(),
                                );
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
                    spacing,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

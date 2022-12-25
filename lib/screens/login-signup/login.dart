import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/custom_form.dart';
import 'package:oldbike/components/custom_notice_screen.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/utils/text_styles.dart';

class LoginScreen extends StatefulWidget {
  static const String screen = 'login';
  final bool displaySignInPage;

  const LoginScreen({
    Key? key,
    this.displaySignInPage = false,
  }) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool showPassword = false;
  MyUser userInfo = MyUser(email: '', password: '');

  void onSkipButtonPressed() {
    HapticFeedback.selectionClick();
    context.go('/tab-view-controller');
  }

  void onCreateAccountButtonPressed() {
    HapticFeedback.selectionClick();
    context.push('/signup');
  }

  void onContinueButtonClicked() {
    HapticFeedback.lightImpact();
    context.go('/tab-view-controller');
  }

  Widget displayLogInScreen() {
    const SizedBox spacing = SizedBox(
      height: 30.0,
    );

    return Scaffold(
      body: SafeArea(
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
                  // Header
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: const [
                      spacing,
                      AppLogo(),
                      spacing,
                      Text(
                        'Sign In',
                        style: ktsMainTitle,
                      ),
                      spacing,
                      Text(
                        'The app\nfor tracking all\nyour bike rides',
                        style: ktsNormalLargeLabel,
                      ),
                      spacing,
                    ],
                  ),

                  // Login Form
                  CustomUserInfoForm(
                    userInfo: userInfo,
                    showForgotPasswordButton: false,
                  ),

                  // 'Create account' + 'Skip' buttons
                  Column(
                    children: [
                      spacing,

                      // Create Account Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Don\'t have an account?'),
                          const SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () => onCreateAccountButtonPressed(),
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

                      // Skip Button
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('Not now?'),
                          const SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () => onSkipButtonPressed(),
                            child: const Text(
                              'Skip (Anonymous mode)',
                              style: ktsAttentionLabel,
                            ),
                          ),
                        ],
                      ),
                      spacing,
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

  Widget displayAlreadyLoggedInScreen() {
    return CustomNoticeScreen(
      signOutButton: false,
      appBarTitle: 'Already Logged In',
      title: 'Already Logged In ⛄︎',
      content: 'Please press Continue to proceed...',
      onButtonPressed: () => onContinueButtonClicked(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If user is already logged in, immediately go to the home screen.
    if (widget.displaySignInPage) {
      return displayLogInScreen();
    } else if (MyUser.getUserInfo() != null) {
      return displayAlreadyLoggedInScreen();
    } else {
      return displayLogInScreen();
    }
  }
}

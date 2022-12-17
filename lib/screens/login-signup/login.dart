import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/custom_notice_screen.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/screens/login-signup/signup.dart';
import 'package:oldbike/utils/popup_alerts.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/tab_view_controller.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

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
  MyUser user = MyUser(email: '', password: '');

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

  void onLoginButtonPressed() async {
    // ignore: todo
    // TODO: [could't figure out a proper way to do it, the package that I've used before is now obsolete] Display spinner when button is clicked

    HapticFeedback.selectionClick();

    if (await user.signIn()) {
      pushNewScreen(
        context,
        withNavBar: false,
        pageTransitionAnimation: PageTransitionAnimation.cupertino,
        screen: const TabViewController(),
      );
    } else {
      showDialog(
        context: context,
        builder: (context) => CustomPopupAlerts.displayLoginError(context),
      );
    }
  }

  void onSkipButtonPressed() {
    HapticFeedback.selectionClick();
    // user.signInAnon();
    pushNewScreen(
      context,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
      screen: const TabViewController(),
    );
  }

  void onCreateAccountButtonPressed() {
    Navigator.pushNamed(context, SignUpScreen.screen);
  }

  void onContinueButtonClicked() {
    pushNewScreen(
      context,
      withNavBar: false,
      pageTransitionAnimation: PageTransitionAnimation.cupertino,
      screen: const TabViewController(),
    );
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

                  // Input Text Fields
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        onChanged: (value) => user.email = value,
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.person),
                          hintText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 20.0,
                      ),
                      TextFormField(
                        onChanged: (value) => user.password = value,
                        obscureText: !showPassword,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          suffixIcon: GestureDetector(
                            onTap: () => togglePasswordVisibility(),
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
                      spacing,
                    ],
                  ),

                  // Login Button
                  IconButton(
                    onPressed: () => onLoginButtonPressed(),
                    icon: const Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 100.0,
                    ),
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
                          const Text('Wanna do it up later?'),
                          const SizedBox(
                            width: 5.0,
                          ),
                          GestureDetector(
                            onTap: () => onSkipButtonPressed(),
                            child: const Text(
                              'Skip',
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
      title: 'Already Logged In',
      content: 'Press continue to proceed',
      onButtonPressed: () => onContinueButtonClicked(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // If user is already logged in, immediately go to the home screen.
    if (widget.displaySignInPage) {
      return displayLogInScreen();
    } else if (user.getUserInfo() != null) {
      return displayAlreadyLoggedInScreen();
    } else {
      return displayLogInScreen();
    }
  }
}

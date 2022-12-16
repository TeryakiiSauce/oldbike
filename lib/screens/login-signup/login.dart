import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/custom_notice_screen.dart';
import 'package:oldbike/components/platform_based_widgets.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/screens/login-signup/signup.dart';
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
                  IconButton(
                    onPressed: () async {
                      // ignore: todo
                      // TODO: [could't figure out a proper way to do it, the package that I've used before is now obsolete] Display spinner when button is clicked

                      HapticFeedback.selectionClick();

                      if (await user.signIn()) {
                        pushNewScreen(
                          context,
                          withNavBar: false,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                          screen: const TabViewController(),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return const DynamicAlertDialog(
                              title: Text('Incorrect email or password'),
                              content: Text(
                                  'Please retry entering your details correctly.'),
                            );
                          },
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.arrow_circle_right_rounded,
                      size: 100.0,
                    ),
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
                              Navigator.pushNamed(context, SignUpScreen.screen);
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
                              // user.signInAnon();
                              pushNewScreen(
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
    );
  }

  Widget displayAlreadyLoggedInScreen() {
    return CustomNoticeScreen(
      signOutButton: false,
      appBarTitle: 'Already Logged In',
      title: 'Already Logged In',
      content: 'Press continue to proceed',
      onButtonPressed: () {
        pushNewScreen(
          context,
          withNavBar: false,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
          screen: const TabViewController(),
        );
      },
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

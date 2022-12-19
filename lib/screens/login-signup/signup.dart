import 'package:flutter/material.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/utils/popup_alerts.dart';

// TODO: [high priority] design this screen

class SignUpScreen extends StatefulWidget {
  static const String screen = 'signup';
  final String username, password;

  const SignUpScreen({
    super.key,
    this.username = '',
    this.password = '',
  });

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late MyUser userInfo;

  void onSignUpButtonPressed() async {
    userInfo = MyUser(
      firstName: 'teryakii',
      lastName: 'sauce',
      email: 'teryakii@sauce.com',
      gender: 'male',
      bloodGroup: 'A+',
      password: '123456',
      dob: DateTime.parse('2000-01-02'),
      height: 179,
      weight: 60,
    );

    final NavigatorState navigator = Navigator.of(context);
    final String error = await userInfo.createUser();

    if (error != '') {
      await showDialog(
        context: navigator.context,
        builder: (context) => CustomPopupAlerts.displayRegistrationError(
          context,
          error,
        ),
      );
    }

    await userInfo.uploadUserInfo();
    navigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenTemplate(
      title: 'Register Now',
      signOutButton: false,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        color: Colors.amber,
        child: IconButton(
          onPressed: () => onSignUpButtonPressed(),
          icon: const Icon(
            Icons.arrow_circle_right,
            size: 100.0,
            color: Colors.black87,
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/components/custom_form.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/models/my_user.dart';

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
  MyUser userInfo = MyUser(
    email: '',
    password: '',
    firstName: '',
    lastName: '',
    bloodGroup: '',
    gender: '',
    height: 0.0,
    weight: 0.0,
    dob: DateTime.now(),
  );

  @override
  Widget build(BuildContext context) {
    return BaseScreenTemplate(
      title: 'Register Now',
      signOutButton: false,
      body: ListView(
        children: [
          LabelledWidget(
            title: 'Register Now',
            childPadding: 30.0,
            titlePadding: 30.0,
            child: CustomUserInfoForm(
              userInfo: userInfo,
              isLoginForm: false,
            ),
          ),
        ],
      ),
    );
  }
}

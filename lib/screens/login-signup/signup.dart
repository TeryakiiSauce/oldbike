import 'package:flutter/material.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/utils/popup_alerts.dart';

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
          onPressed: () async {
            userInfo = MyUser(
              // username: 'teryakii',
              firstName: 'teryakii',
              lastName: 'sauce',
              email: 'teryakii@sauce.com',
              gender: 'male',
              bloodGroup: 'A+',
              password: '123456',
              dob: DateTime.parse('2000-01-01'),
              height: 179,
              weight: 60,
            );

            final NavigatorState navigator = Navigator.of(context);
            final String error = await userInfo.createUser();

            if (error != '') {
              showDialog(
                context: navigator.context,
                builder: (context) =>
                    CustomPopupAlerts.displayRegistrationError(
                  context,
                  error,
                ),
              );
            } else {
              navigator.pop();
            }
          },
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

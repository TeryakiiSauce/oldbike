import 'package:flutter/material.dart';
import 'package:oldbike/models/user.dart';

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
  late User userInfo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber,
      child: IconButton(
        onPressed: () {
          userInfo = User(
            username: 'teryakii',
            firstName: 'teryakii',
            lastName: 'sauce',
            email: 'teryakii@sauce.com',
            gender: 'male',
            bloodGroup: 'A+',
            dob: DateTime.parse('2000-01-01'),
            height: 179,
            weight: 60,
          );

          userInfo.createUser();
        },
        icon: const Icon(
          Icons.arrow_circle_right,
          size: 100.0,
          color: Colors.black87,
        ),
      ),
    );
  }
}

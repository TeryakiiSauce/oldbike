import 'package:flutter/material.dart';
import 'package:oldbike/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: const [
            Expanded(
              child: Text(
                'The app\nfor tracking all\nyour bike rides',
                style: kLargeLabelTS,
              ),
            ),
            Expanded(
              child: Text('Email'),
            ),
            Expanded(
              child: Text('Password'),
            ),
            Expanded(
              child: Icon(
                Icons.arrow_circle_right_rounded,
                size: 100.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

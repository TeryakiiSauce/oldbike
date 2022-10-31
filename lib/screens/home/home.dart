import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: const Color(0x00000000),
      ),
      body: SafeArea(
        child: Column(
          children: [
            GestureDetector(
              onTap: () => Navigator.pushReplacementNamed(context, '/'),
              child: Container(
                margin: const EdgeInsets.all(15.0),
                padding: const EdgeInsets.all(50.0),
                decoration: BoxDecoration(
                  color: const Color(0xff6774dc),
                  borderRadius: BorderRadius.circular(16.0),
                ),
                child: const Text('Restart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
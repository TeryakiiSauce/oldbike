import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';

class ProfileScreen extends StatefulWidget {
  static const String screen = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        LabelledWidget(
          title: 'Profile',
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CircularImage(
                image: Image.asset(
                    'images/vecteezy_watercolor-sketch-of-cute-cartoon-jumping-dolphin_11017755_378.png'),
                padding: 5,
                // size: 15,
              ),
              // const SizedBox(
              //   width: 30.0,
              // ),
              Column(
                // crossAxisAlignment: CrossAxisAlignment.stretch,
                children: const [
                  Text('hehr'),
                  Text('hehr'),
                  Text('hehr'),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

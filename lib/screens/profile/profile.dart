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
      padding: const EdgeInsets.all(10.0),
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
              ),
            ],
          ),
        ),
        Divider(
          indent: 100.0,
          height: 50.0,
          endIndent: 100.0,
          color: Colors.black,
          thickness: 2.0,
        ),
        Text('Credits'),
      ],
    );
  }
}

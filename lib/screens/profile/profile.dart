import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/utils/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  static const String screen = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LabelledWidget buildProfileSummary() => LabelledWidget(
        title: 'Profile',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getProfileDetails(),
          ],
        ),
      );

  LabelledWidget buildUserRecentRides() => LabelledWidget(
        title: 'Recent Rides',
        child: Container(
          height: 250.0,
          width: 300.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.amber,
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              'images/robert-bye-tG36rvCeqng-unsplash.jpg',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );

  Row getProfileDetails() => Row(
        children: [
          Flexible(
            child: CircularImage(
              image: Image.asset(
                  'images/vecteezy_watercolor-sketch-of-cute-cartoon-jumping-dolphin_11017755_378.png'),
              padding: 5,
              size: 12,
            ),
          ),
          const SizedBox(
            width: 30.0,
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Rintarou Okabe',
                  style: ktsProfileTitle,
                ),
                Text(
                  '25 years old, Male',
                  style: ktsProfileSubtitle,
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                  ),
                ),
                Text(
                  '70 kg\n'
                  '182 cm\n'
                  'O+ Blood group',
                  style: ktsProfileTiny,
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    SizedBox spacing = const SizedBox(
      height: 35.0,
    );

    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        buildProfileSummary(),
        spacing,
        buildUserRecentRides(),
      ],
    );
  }
}

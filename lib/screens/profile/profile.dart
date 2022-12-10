import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/components/horizontal_scroll.dart';
import 'package:oldbike/components/compact_ride_info_card.dart';

class ProfileScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.profile;

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final List<CompactRideInfoCard> recentRides = [
    CompactRideInfoCard(
      date: DateTime.now(),
      avgSpeed: 9.52353,
      distTravelled: 13.54246,
      elevationGained: 7.57290,
    ),
    CompactRideInfoCard(
      date: DateTime.now(),
      avgSpeed: 12.43294,
      distTravelled: 17.12309,
      elevationGained: 12.96256,
    ),
    CompactRideInfoCard(
      date: DateTime.now(),
      avgSpeed: 17.25903,
      distTravelled: 26.25905,
      elevationGained: 46.23498,
    ),
    CompactRideInfoCard(
      date: DateTime.now(),
      avgSpeed: 9.34615,
      distTravelled: 22.23004,
      elevationGained: 26.34013,
    ),
  ];

  LabelledWidget buildProfileSummary({double padding = 0}) => LabelledWidget(
        titlePadding: padding,
        childPadding: padding,
        title: 'Profile',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getProfileDetails(),
          ],
        ),
      );

  LabelledWidget buildUserRecentRides({double padding = 0}) => LabelledWidget(
        titlePadding: padding,
        childPadding: 0,
        title: 'Recent Rides',
        child: HorizontalScroll(
          height: MediaQuery.of(context).size.height * 0.25,
          itemsCount: recentRides.length,
          child: recentRides,
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
    const double padding = 20;

    return BaseScreenTemplate(
      title: 'Profile',
      body: ListView(
        children: [
          buildProfileSummary(padding: padding),
          buildUserRecentRides(padding: padding),
        ],
      ),
    );
  }
}

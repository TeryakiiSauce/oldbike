import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/components/no_data_found_notice.dart';
import 'package:oldbike/models/my_user.dart';
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
  final firestore = FirebaseFirestore.instance;
  final User? userInfo = MyUser(email: '', password: '').getUserInfo();

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
        child: userInfo == null
            ? const NoDataFoundNotice()
            : StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('rides-statistics')
                    .doc(userInfo!.uid)
                    .collection('rides')
                    .snapshots(),
                builder: (context, snapshot) {
                  final rides = snapshot.data?.docs.reversed;
                  List<Widget> rideStatsWidgets = [];

                  for (var i = 0; i < 3; i++) {
                    final ride = rides?.elementAt(i);

                    if (ride == null) return Container();

                    final rideStats = CompactRideInfoCard(
                      date: DateTime.parse(ride.id),
                      avgSpeed: ride.get('averageSpeed'),
                      distTravelled: ride.get('distanceTravelled'),
                      elevationGained: ride.get('elevationGained'),
                    );

                    rideStatsWidgets.add(rideStats);
                  }

                  return HorizontalScroll(
                    height: MediaQuery.of(context).size.height * 0.25,
                    itemsCount: 3,
                    child: rideStatsWidgets,
                  );
                },
              ),
      );

  LabelledWidget buildAllTimeStats({double padding = 0}) => LabelledWidget(
        titlePadding: padding,
        childPadding: padding,
        title: 'All Time Stats',
        child: CompactRideInfoCard(date: DateTime.now()),
      );

  Widget moreButton() => Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: GestureDetector(
          onTap: () {},
          child: const Text(
            'Show all',
            textAlign: TextAlign.end,
            style: ktsCardAction,
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
    const double padding = 20;
    const spacing = SizedBox(height: padding);
    const muchMoreSpacing = SizedBox(height: 100.0);

    return BaseScreenTemplate(
      title: 'Profile',
      body: ListView(
        children: [
          buildProfileSummary(padding: padding),
          spacing,
          buildUserRecentRides(padding: padding),
          userInfo == null ? Container() : spacing,
          userInfo == null ? Container() : moreButton(),
          spacing,
          buildAllTimeStats(padding: padding),
          muchMoreSpacing,
          const AppLogo(),
          spacing,
          const Text(
            'Elias Rahma, 2022',
            textAlign: TextAlign.center,
            style: ktsProfileTiny,
          ),
          muchMoreSpacing,
        ],
      ),
    );
  }
}

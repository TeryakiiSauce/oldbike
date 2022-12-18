import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/components/no_data_found_notice.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/models/ride_stats.dart';
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
        child: MyUser.getUserInfo() == null
            ? const NoDataFoundNotice()
            : StreamBuilder<QuerySnapshot>(
                stream: RideStatistics.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data?.size == 0) {
                    return showHorizontalScroll(
                      itemsCount: 0,
                      rideStatsWidgets: [],
                    );
                  }

                  final rides = snapshot.data?.docs.reversed;
                  List<Widget> rideStatsWidgets = [];
                  int itemsCount = 3;

                  for (var i = 0; i < itemsCount; i++) {
                    if (rides == null) return Container();
                    if (rides.isEmpty) {
                      snapshot.data; // forgot what this is for ngl
                      return Container();
                    }
                    if (rides.length < itemsCount) itemsCount = rides.length;

                    final ride = rides.elementAt(i);
                    final RideStatistics rideStats =
                        RideStatistics.createObject(ride);

                    final rideWidget = RideInfoCard(
                      date: DateTime.parse(ride.id),
                      rideStatistics: rideStats,
                    );

                    rideStatsWidgets.add(rideWidget);
                  }

                  return showHorizontalScroll(
                    itemsCount: itemsCount,
                    rideStatsWidgets: rideStatsWidgets,
                  );
                },
              ),
      );

  LabelledWidget buildAllTimeStats({double padding = 0}) => LabelledWidget(
        titlePadding: padding,
        childPadding: padding,
        title: 'All Time Stats',
        child: RideInfoCard(
          date: DateTime.now(),
          makeAsButton: false,
        ),
      );

  Widget showHorizontalScroll({
    required int itemsCount,
    required List<Widget> rideStatsWidgets,
  }) =>
      HorizontalScroll(
        height: MediaQuery.of(context).size.height * 0.25,
        itemsCount: itemsCount,
        child: rideStatsWidgets,
      );

  StreamBuilder buildUserInfo() {
    // final MyUser userDetails = MyUser.createObject();

    return StreamBuilder<QuerySnapshot>(
        // stream: Fire,
        builder: (context, snapshot) {
      return Column(
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
      );
    });
  }

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
            child: buildUserInfo(),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    const double padding = 20;
    const spacing = SizedBox(height: 5);
    const muchMoreSpacing = SizedBox(height: 100.0);

    return BaseScreenTemplate(
      title: 'Profile',
      body: ListView(
        children: [
          buildProfileSummary(padding: padding),
          spacing,
          buildUserRecentRides(padding: padding),
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

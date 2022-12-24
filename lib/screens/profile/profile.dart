import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/components/no_data_found_notice.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/utils/custom_formatting.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/components/horizontal_scroll.dart';
import 'package:oldbike/components/ride_info_card.dart';
import 'package:oldbike/utils/extensions.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class ProfileScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.profile;

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  double allTimeAvgSpeed = 0.0,
      allTimeDistanceTravelled = 0.0,
      allTimeElevationGained = 0.0,
      allTimeTopSpeed = 0.0,
      allTimeMinAltitude = 0.0,
      allTimeMaxAltitude = 0.0,
      allTimeUphillDist = 0.0,
      allTimeDownhillDist = 0.0;
  Duration allTimeTimeElapsed = const Duration();

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
        title: 'My Rides',
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

                  double tempAllTimeAvgSpeed = 0.0,
                      tempAllTimeDistanceTravelled = 0.0,
                      tempAllTimeElevationGained = 0.0,
                      tempAllTimeTopSpeed = 0.0,
                      tempAllTimeMinAltitude = 1000000000.0,
                      tempAllTimeMaxAltitude = 0.0,
                      tempAllTimeUphillDist = 0.0,
                      tempAllTimeDownhillDist = 0.0;
                  Duration tempAllTimeTimeElapsed = const Duration();

                  final rides = snapshot.data?.docs.reversed;
                  List<Widget> rideStatsWidgets = [];
                  int itemsCount = snapshot.data?.size ?? 3;

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

                    // To calculate 'All-Time' statistics
                    tempAllTimeAvgSpeed += rideStats.averageSpeed;
                    tempAllTimeDistanceTravelled += rideStats.distanceTravelled;
                    tempAllTimeElevationGained += rideStats.elevationGained;
                    tempAllTimeUphillDist += rideStats.uphillDistance;
                    tempAllTimeDownhillDist += rideStats.downhillDistance;
                    tempAllTimeTimeElapsed += rideStats.timeElapsed;
                    rideStats.topSpeed > tempAllTimeTopSpeed
                        ? tempAllTimeTopSpeed = rideStats.topSpeed
                        : null;
                    rideStats.maxAltitude > tempAllTimeMaxAltitude
                        ? tempAllTimeMaxAltitude = rideStats.maxAltitude
                        : null;
                    if (rideStats.minAltitude != 0) {
                      rideStats.minAltitude < tempAllTimeMinAltitude
                          ? tempAllTimeMinAltitude = rideStats.minAltitude
                          : null;
                    }

                    final rideWidget = RideInfoCard(
                      date: DateTime.parse(ride.id),
                      rideStatistics: rideStats,
                      onClicked: () {
                        HapticFeedback.selectionClick();
                        pushNewScreen(
                          context,
                          withNavBar: true,
                          pageTransitionAnimation:
                              PageTransitionAnimation.cupertino,
                          screen: StatisticsScreen(
                            statsInfo: rideStats,
                            doUpload: false,
                            doPost: false,
                          ),
                        );
                      },
                    );

                    rideStatsWidgets.add(rideWidget);
                  }

                  tempAllTimeAvgSpeed /= itemsCount;

                  allTimeAvgSpeed = tempAllTimeAvgSpeed;
                  allTimeDistanceTravelled = tempAllTimeDistanceTravelled;
                  allTimeElevationGained = tempAllTimeElevationGained;
                  allTimeTopSpeed = tempAllTimeTopSpeed;
                  allTimeUphillDist = tempAllTimeUphillDist;
                  allTimeDownhillDist = tempAllTimeDownhillDist;
                  allTimeTimeElapsed = tempAllTimeTimeElapsed;
                  allTimeMaxAltitude = tempAllTimeMaxAltitude;
                  allTimeMinAltitude = tempAllTimeMinAltitude;

                  return Column(
                    children: [
                      showHorizontalScroll(
                        itemsCount: itemsCount,
                        rideStatsWidgets: rideStatsWidgets,
                      ),
                      buildAllTimeStats(
                        padding: padding,
                        allRidesInfo: RideStatistics(
                          averageSpeed: allTimeAvgSpeed,
                          distanceTravelled: allTimeDistanceTravelled,
                          downhillDistance: allTimeDownhillDist,
                          elevationGained: allTimeElevationGained,
                          maxAltitude: allTimeMaxAltitude,
                          minAltitude: allTimeMinAltitude,
                          topSpeed: allTimeTopSpeed,
                          uphillDistance: allTimeUphillDist,
                          timeElapsed: allTimeTimeElapsed,
                          altitude: 0.0,
                          previousAltitude: 0.0,
                          currentSpeed: 0.0,
                        ),
                      ),
                    ],
                  );
                },
              ),
      );

  LabelledWidget buildAllTimeStats({
    double padding = 0,
    required RideStatistics allRidesInfo,
  }) {
    return LabelledWidget(
      titlePadding: padding,
      childPadding: padding,
      title: 'All Time Stats',
      child: RideInfoCard(
        date: DateTime.now(),
        enableLongPress: false,
        onClicked: () {
          HapticFeedback.selectionClick();
          pushNewScreen(
            context,
            withNavBar: true,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
            screen: StatisticsScreen(
              statsInfo: allRidesInfo,
              doUpload: false,
              doPost: false,
            ),
          );
        },
        rideStatistics: allRidesInfo,
      ),
    );
  }

  Widget showHorizontalScroll({
    required int itemsCount,
    required List<Widget> rideStatsWidgets,
  }) =>
      HorizontalScroll(
        height: MediaQuery.of(context).size.height * 0.25,
        itemsCount: itemsCount,
        showAllButton: false,
        child: rideStatsWidgets,
      );

  Column userInfoWidget({
    required String fullName,
    required DateTime dob,
    required String gender,
    required String bloodGroup,
    required double weight,
    required double height,
  }) {
    // Find user's age
    String age = CustomFormat.getFormattedNumber(
      DateTime.now().difference(dob).inDays / 365.24,
      decimalPlace: 0,
    );

    String weightStr = CustomFormat.getFormattedNumber(
      weight,
      decimalPlace: 0,
    );

    String heightStr = CustomFormat.getFormattedNumber(
      height,
      decimalPlace: 0,
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          fullName,
          style: ktsProfileTitle,
        ),
        Text(
          '$age years old, ${gender.toCapitalized()}',
          style: ktsProfileSubtitle,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
          ),
        ),
        Text(
          'Weight: $weightStr Kg\n'
          'Height: $heightStr Cm\n'
          'Blood group: $bloodGroup',
          style: ktsProfileTiny,
          textHeightBehavior: const TextHeightBehavior(
            applyHeightToFirstAscent: false,
          ),
        ),
      ],
    );
  }

  Widget buildUserInfo() {
    return MyUser.getUserInfo() == null
        ? userInfoWidget(
            fullName: 'Rintarou Okabe',
            dob: DateTime.parse('1991-12-14'),
            gender: 'Male',
            bloodGroup: 'A',
            height: 177,
            weight: 59,
          )
        : StreamBuilder<QuerySnapshot>(
            stream: MyUser.snapshots(),
            builder: (context, snapshot) {
              final MyUser userInfo = MyUser.createObject(
                snapshot.data?.docs.singleWhere((element) {
                  String currentUserID = MyUser.getUserInfo()?.email ?? '';
                  if (element.id == currentUserID) {
                    return true;
                  }
                  return false;
                }),
              );

              // Full Name
              String firstName =
                  userInfo.firstName?.toCapitalized() ?? 'Rintarou';
              String lastName = userInfo.lastName?.toCapitalized() ?? 'Okabe';
              String fullName = '$firstName $lastName';

              return userInfoWidget(
                fullName: fullName,
                dob: userInfo.dob ?? DateTime.parse('1991-12-14'),
                gender: userInfo.gender ?? 'Male',
                bloodGroup: userInfo.bloodGroup?.toUpperCase() ?? 'A',
                height: userInfo.height ?? 177,
                weight: userInfo.weight ?? 59,
              );
            },
          );
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
      body: Scrollbar(
        child: ListView(
          children: [
            buildProfileSummary(padding: padding),
            spacing,
            buildUserRecentRides(padding: padding),
            // buildAllTimeStats(padding: padding),
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
      ),
    );
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/services/location.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:oldbike/utils/extensions.dart';
import 'package:oldbike/utils/popup_alerts.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';
import 'package:wakelock/wakelock.dart';

class RideTrackingScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.track;

  const RideTrackingScreen({super.key});

  @override
  State<RideTrackingScreen> createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  final Location location = Location();
  late CustomLocationPermission permission;
  DateTime startTime = DateTime.now(),
      pausedAt = DateTime.now(),
      resumedAt = DateTime.now();
  late StreamSubscription networkConnectionListener;
  late StreamSubscription currentPositionListener;
  bool isConnectedToInternet = false;
  bool doUpload = false;
  bool isLocationPermissionGranted = false;
  Position position = Position(
    latitude: 51.509865,
    longitude: -0.118092,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );
  Position previousPosition = Position(
    latitude: 51.509865,
    longitude: -0.118092,
    timestamp: DateTime.now(),
    accuracy: 0.0,
    altitude: 0.0,
    heading: 0.0,
    speed: 0.0,
    speedAccuracy: 0.0,
  );
  RideStatistics rideStats = RideStatistics(
    currentSpeed: 0.0,
    averageSpeed: 0.0,
    distanceTravelled: 0.0,
    downhillDistance: 0.0,
    elevationGained: 0.0,
    altitude: 0.0,
    previousAltitude: 0.0,
    maxAltitude: 0.0,
    minAltitude: 0.0,
    timeElapsed: const Duration(),
    topSpeed: 0.0,
    uphillDistance: 0.0,
  );

  void initNetworkListener() {
    networkConnectionListener =
        InternetConnectionChecker().onStatusChange.listen(
      (status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            debugPrint('connected to internet.');
            setState(() {
              isConnectedToInternet = true;
            });
            break;
          case InternetConnectionStatus.disconnected:
            debugPrint('NOT connected to internet.');
            setState(() {
              isConnectedToInternet = false;
            });
            break;
        }

        // debugPrint('internet connection = $isConnectedToInternet');
      },
    );
  }

  Future<void> getPermission() async {
    permission = await location.checkPermission();

    setState(() {
      isLocationPermissionGranted =
          permission == CustomLocationPermission.always ||
              permission == CustomLocationPermission.whileInUse;
    });

    if (!isLocationPermissionGranted) {
      debugPrint('location permissions are NOT granted');

      showDialog(
        context: context,
        builder: (context) {
          final bool isServiceDisabled =
              permission == CustomLocationPermission.serviceDisabled;

          return CustomPopupAlerts.displayLocationDisabledAlert(
              context, isServiceDisabled, location);
        },
      );
    } else {
      debugPrint('location permissions are granted');
    }
  }

  void initPositionListener() {
    currentPositionListener = location.positionStream.listen(
      (tempPosition) async {
        // This fixes the issue (app crash) while the phone is moving faster than the updates of the map tiles which most probably happens due to internet disconnectivity.
        if (!await InternetConnectionChecker().hasConnection) return;

        // ignore: todo
        // TODO: [I give up] check for signal

        if (position.latitude != previousPosition.latitude &&
            position.longitude != previousPosition.longitude) {
          previousPosition = position;
        }

        setState(() {
          position = tempPosition;
        });
      },
      cancelOnError: false,
      onError: (e) {
        return 'Error occurred: $e';
      },
    );
  }

  void statisticsCalculations() async {
    // All speeds units are in Kph
    rideStats.currentSpeed = position.speed * 3.6;
    rideStats.timeElapsed = position.timestamp!.difference(startTime);
    rideStats.distanceTravelled += Geolocator.distanceBetween(
          previousPosition.latitude,
          previousPosition.longitude,
          position.latitude,
          position.longitude,
        ) /
        1000;
    rideStats.averageSpeed =
        rideStats.distanceTravelled / (rideStats.timeElapsed.inSeconds / 3600);

    if (rideStats.currentSpeed > rideStats.topSpeed) {
      rideStats.topSpeed = rideStats.currentSpeed;
    }

    rideStats.previousAltitude =
        rideStats.altitude == 0.0 ? position.altitude : rideStats.altitude;
    rideStats.altitude = position.altitude;

    if (rideStats.minAltitude == 0.0) {
      rideStats.minAltitude = rideStats.altitude;
    }

    if (rideStats.altitude > rideStats.maxAltitude) {
      rideStats.maxAltitude = rideStats.altitude;
    }

    if (rideStats.altitude < rideStats.minAltitude) {
      rideStats.minAltitude = rideStats.altitude;
    }

    if (rideStats.altitude > rideStats.previousAltitude) {
      rideStats.uphillDistance +=
          rideStats.altitude - rideStats.previousAltitude;
    } else if (rideStats.altitude < rideStats.previousAltitude) {
      rideStats.downhillDistance +=
          rideStats.previousAltitude - rideStats.altitude;
    }

    rideStats.elevationGained =
        rideStats.uphillDistance - rideStats.downhillDistance;

    if (MyUser.getUserInfo() == null) return;

    final User? userInfo = MyUser.getUserInfo();
    final userDetails = await MyUser.document(userInfo?.email).get();

    String firstName = userDetails.get('firstName').toString().toCapitalized();
    String lastName = userDetails.get('lastName').toString().toCapitalized();
    String fullName = '$firstName $lastName';

    rideStats.cyclistName = fullName;
  }

  List<Widget> buildTrackScreen() => [
        Expanded(
          flex: isLocationPermissionGranted ? 1 : 1,
          child: Padding(
            padding: const EdgeInsets.all(30.0),
            child: buildMapDisplay(),
          ),
        ),
        isLocationPermissionGranted
            ? Expanded(
                flex: 1,
                child: buildStatsDisplay(),
              )
            : Container(),
        Expanded(
          child: isLocationPermissionGranted
              ? buildTrackingButtons()
              : buildWarningContainer(),
        ),
      ];

  List<Widget> buildNoConnectionScreen() => [
        Column(
          children: const [
            Icon(
              Icons.wifi_off_rounded,
              size: 100.0,
            ),
            SizedBox(
              height: 20.0,
            ),
            Text(
              'Internet connection lost, tracking paused',
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ];

  Widget buildMapDisplay() => ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Stack(
          children: [
            FlutterMap(
              options: MapOptions(
                center: LatLng(position.latitude, position.longitude),
                // ignore: todo
                // TODO: [Too lazy to fix since it's unlikely to be a problem] Those two lines can crash the app if the current location is at the max boundaries.
                bounds: LatLngBounds(
                  LatLng(position.latitude - 0.001, position.longitude + 0.001),
                  LatLng(position.latitude + 0.001, position.longitude - 0.001),
                ),
                maxBounds: LatLngBounds(
                  LatLng(-90.0, -180.0),
                  LatLng(90.0, 180.0),
                ),
                zoom: 18.0,
                minZoom: 2.0,
                maxZoom: 18,
                interactiveFlags: InteractiveFlag.all & ~InteractiveFlag.rotate,
              ),
              nonRotatedChildren: [
                MarkerLayer(
                  markers: [
                    Marker(
                      // height: 100.0,
                      // width: 100.0,
                      point: LatLng(position.latitude, position.longitude),
                      builder: (context) => Icon(
                        Icons.circle_rounded,
                        color: Colors.indigo[400],
                        size: 20.0,
                      ),
                    )
                  ],
                ),
              ],
              children: [
                TileLayer(
                  urlTemplate:
                      'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                  subdomains: const ['a', 'b', 'c'],
                ),
              ],
            ),
          ],
        ),
      );

  Widget buildStatsDisplay() {
    statisticsCalculations();
    return rideStats.displayCurrentStats();
  }

  Widget buildTrackingButtons() {
    bool isPaused = currentPositionListener.isPaused;

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () async {
              HapticFeedback.selectionClick();
              Wakelock.enable();

              await getPermission();
              if (!isLocationPermissionGranted) return;

              debugPrint(!isPaused ? 'tracking paused' : 'tracker is running');

              Duration pausedDuration = const Duration();
              DateTime newStartTime = DateTime.now();

              if (!isPaused) {
                pausedAt = DateTime.now();
              } else {
                resumedAt = DateTime.now();
                pausedDuration = resumedAt.difference(pausedAt);
                newStartTime = startTime.add(pausedDuration);

                setState(() {
                  startTime = newStartTime;
                });
              }

              // debugPrint('st = $startTime\n'
              //     'pt = $pausedAt\n'
              //     'rt = $resumedAt\n'
              //     'pd = ${pausedDuration.inSeconds} sec\n'
              //     'new st = $newStartTime');

              setState(() {
                isPaused
                    ? currentPositionListener.resume()
                    : currentPositionListener.pause();
              });
            },
            icon: FaIcon(
              isPaused
                  ? FontAwesomeIcons.solidCirclePlay
                  : FontAwesomeIcons.solidCirclePause,
              size: 70.0,
            ),
          ),
          IconButton(
            onPressed: isPaused
                ? null
                : () async {
                    if (isPaused) return;
                    HapticFeedback.selectionClick();
                    Wakelock.disable();

                    if (MyUser.getUserInfo() == null) {
                      // ignore: todo
                      // TODO: [very low priority] Add a feature to allow user to export their statistics.
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CustomPopupAlerts
                              .displayWarningWhileAnonDuringUpload(context);
                        },
                      );
                    } else {
                      doUpload = true;
                    }

                    await pushNewScreen(
                      context,
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                      screen: StatisticsScreen(
                        statsInfo: rideStats,
                        doUpload: doUpload,
                      ),
                    );

                    setState(() {
                      currentPositionListener.pause();
                      startTime = DateTime.now();
                      pausedAt = DateTime.now();
                      resumedAt = DateTime.now();
                    });

                    if (!mounted) return;

                    debugPrint('resetting values...');
                    doUpload = false;
                    setState(() {
                      // rideStats.timeElapsed = const Duration(seconds: 0);
                      rideStats.distanceTravelled = 0.0;
                      rideStats.elevationGained = 0.0;
                    });
                  },
            icon: FaIcon(
              FontAwesomeIcons.circleStop,
              size: 50.0,
              color: isPaused ? kcPrimaryT9 : kcPrimaryT13,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWarningContainer() {
    return Padding(
      padding: const EdgeInsets.only(top: 18.0),
      child: Column(
        children: const [
          AppLogo(),
          SizedBox(
            height: 30.0,
          ),
          Text(
            'Location Access Denied',
            style: ktsProfileTitle,
          ),
          SizedBox(
            height: 15.0,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 50.0),
            child: Text(
              'Please go to Settings and turn on location services so that you can continue tracking statistics of your rides.',
              style: ktsCardDate,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    initNetworkListener();
    getPermission();
    initPositionListener();
    currentPositionListener.pause();
  }

  @override
  void dispose() {
    networkConnectionListener.cancel();
    currentPositionListener.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> screenDisplay =
        isConnectedToInternet ? buildTrackScreen() : buildNoConnectionScreen();

    return BaseScreenTemplate(
      title: 'Track',
      body: GestureDetector(
        onTap: () async => getPermission(),
        onTapCancel: () async => getPermission(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: screenDisplay,
        ),
      ),
    );
  }
}

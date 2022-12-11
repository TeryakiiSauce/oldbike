import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/services/location.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/custom_formatting.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oldbike/components/platform_based_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';
import 'package:wakelock/wakelock.dart';

class RideTrackingScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.track;

  const RideTrackingScreen({super.key});

  @override
  State<RideTrackingScreen> createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  final Location location = Location();
  DateTime startTime = DateTime.now(),
      pausedAt = DateTime.now(),
      resumedAt = DateTime.now();
  late StreamSubscription networkConnectionListener;
  late StreamSubscription currentPositionListener;
  bool isConnectedToInternet = false;
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
  // TODO: create a class for the statistics
  double currentSpeedInMps = 0.0,
      currentSpeedInKph = 0.0,
      averageSpeedInKph = 0.0,
      topSpeedInKph = 0.0,
      distanceTravelled = 0.0,
      currentAltitude = 0.0,
      previousAltitude = 0.0,
      maxAltitude = 0.0,
      minAltitude = 0.0,
      uphill = 0.0,
      downhill = 0.0,
      elevationGained = 0.0;
  Duration timeTaken = const Duration(seconds: 0);

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

  void getPermission() async {
    CustomLocationPermission permission = await location.getPermission();

    if (permission != CustomLocationPermission.always &&
        permission != CustomLocationPermission.whileInUse) {
      debugPrint('location permissions are NOT granted');

      showDialog(
        context: context,
        builder: (context) {
          final bool isServiceDisabled =
              permission == CustomLocationPermission.serviceDisabled;

          return DynamicAlertDialog(
            title: Text(
              isServiceDisabled ? 'Location Disabled' : 'Location Permission',
            ),
            content: Text(
              isServiceDisabled
                  ? 'Access to location is disabled on your phone. Click Ok and turn on location service and then give the app permission to use location data.'
                  : 'Permission to location is required in order for the app to track your progress. Click Ok to open App settings.',
            ),
            approveAction: () {
              isServiceDisabled
                  ? location.openPrivacyLocationSettings()
                  : location.openAppSettings();

              Navigator.pop(context);
            },
          );
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
    );
  }

  void statisticsCalculations() {
    currentSpeedInMps = position.speed;
    currentSpeedInKph = currentSpeedInMps * 3.6;
    timeTaken = position.timestamp!.difference(startTime);
    // distanceTravelled = (speedInMps * timeTaken.inSeconds) / 1000;
    distanceTravelled += Geolocator.distanceBetween(
          previousPosition.latitude,
          previousPosition.longitude,
          position.latitude,
          position.longitude,
        ) /
        1000;

    averageSpeedInKph = distanceTravelled / (timeTaken.inSeconds / 3600);
    if (currentSpeedInKph > topSpeedInKph) topSpeedInKph = currentSpeedInKph;

    previousAltitude =
        currentAltitude == 0 ? position.altitude : currentAltitude;
    currentAltitude = position.altitude;

    if (minAltitude == 0) minAltitude = currentAltitude;
    if (currentAltitude > maxAltitude) maxAltitude = currentAltitude;
    if (currentAltitude < minAltitude) minAltitude = currentAltitude;

    if (currentAltitude > previousAltitude) {
      uphill += currentAltitude - previousAltitude;
    } else if (currentAltitude < previousAltitude) {
      downhill += previousAltitude - currentAltitude;
    }

    elevationGained = uphill - downhill;
  }

  List<Widget> buildTrackScreen() => [
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildMapDisplay(),
          ),
        ),
        Expanded(
          child: buildStatsDisplay(),
        ),
        Expanded(
          child: buildTrackingButtons(),
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
        borderRadius: BorderRadius.circular(16.0),
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
    // speedInMps = position.speed;
    // speedInKph = speedInMps * 3.6;
    // timeTaken = position.timestamp!.difference(startTime);
    // distanceTravelled = (speedInMps * timeTaken.inSeconds) / 1000;
    // previousAltitude =
    //     currentAltitude == 0 ? position.altitude : currentAltitude;
    // currentAltitude = position.altitude;

    // if (minAltitude == 0) minAltitude = currentAltitude;
    // if (currentAltitude > maxAltitude) maxAltitude = currentAltitude;
    // if (currentAltitude < minAltitude) minAltitude = currentAltitude;

    // if (currentAltitude > previousAltitude) {
    //   uphill += currentAltitude - previousAltitude;
    // } else if (currentAltitude < previousAltitude) {
    //   downhill += previousAltitude - currentAltitude;
    // }

    // elevationGained = uphill - downhill;
    statisticsCalculations();

    return Center(
      child: Text(
        'top speed: ${CustomFormat.getFormattedNumber(topSpeedInKph, decimalPlace: 2)} km/h\n'
        'current speed: ${CustomFormat.getFormattedNumber(currentSpeedInKph, decimalPlace: 2)} km/h\n'
        'avg speed: ${CustomFormat.getFormattedNumber(averageSpeedInKph, decimalPlace: 2)} km/h\n'
        'time elapsed: ${timeTaken.inMinutes}:${timeTaken.inSeconds % 60} minute(s)\n'
        'distance travelled: ${CustomFormat.getFormattedNumber(distanceTravelled, decimalPlace: 2)} km\n'
        'altitude: ${CustomFormat.getFormattedNumber(currentAltitude, decimalPlace: 2)} m\n'
        'min altitude: ${CustomFormat.getFormattedNumber(minAltitude, decimalPlace: 2)} m\n'
        'max altitude: ${CustomFormat.getFormattedNumber(maxAltitude, decimalPlace: 2)} m\n'
        'uphill distance: ${CustomFormat.getFormattedNumber(uphill, decimalPlace: 2)} m\n'
        'downhill distance: ${CustomFormat.getFormattedNumber(downhill, decimalPlace: 2)} m\n'
        'elevation gained: ${CustomFormat.getFormattedNumber(elevationGained, decimalPlace: 2)} m\n',
        // 'floors climbed: ${position.floor ?? 0} floor(s)\n',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildTrackingButtons() {
    bool isPaused = currentPositionListener.isPaused;

    return Center(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            onPressed: () {
              HapticFeedback.selectionClick();
              Wakelock.enable();

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

              debugPrint('st = $startTime\n'
                  'pt = $pausedAt\n'
                  'rt = $resumedAt\n'
                  'pd = ${pausedDuration.inSeconds} sec\n'
                  'new st = $newStartTime');

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
                : () {
                    if (isPaused) return;
                    HapticFeedback.selectionClick();
                    Wakelock.disable();

                    setState(() {
                      currentPositionListener.pause();
                      startTime = DateTime.now();
                      pausedAt = DateTime.now();
                      resumedAt = DateTime.now();
                    });

                    PersistentNavBarNavigator.pushNewScreen(
                      context,
                      withNavBar: true,
                      pageTransitionAnimation:
                          PageTransitionAnimation.cupertino,
                      screen: StatisticsScreen(
                        speed: currentSpeedInKph,
                        // altitude: currentAltitude,
                        distance: distanceTravelled,
                        timeElapsed: timeTaken,
                        downhill: downhill,
                        uphill: uphill,
                        elevationGained: elevationGained,
                        maxAltitude: maxAltitude,
                        minAltitude: minAltitude,
                        avgSpeed: averageSpeedInKph,
                        topSpeed: topSpeedInKph,
                        upload: false, // TODO: toggle on
                      ),
                    );
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
    return BaseScreenTemplate(
      title: 'Track',
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: isConnectedToInternet
            ? buildTrackScreen()
            : buildNoConnectionScreen(),
      ),
    );
  }
}

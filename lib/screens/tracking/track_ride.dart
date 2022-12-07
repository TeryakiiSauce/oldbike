import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oldbike/screens/tracking/statistics.dart';
import 'package:oldbike/services/location.dart';
import 'package:oldbike/utils/custom_formatting.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:oldbike/utils/platform_based_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class RideTrackingScreen extends StatefulWidget {
  static const String screen = 'beginTrackingRide';
  static bool isRecording = false;

  const RideTrackingScreen({super.key});

  @override
  State<RideTrackingScreen> createState() => _RideTrackingScreenState();
}

class _RideTrackingScreenState extends State<RideTrackingScreen> {
  final Location location = Location();
  final DateTime startTime = DateTime.now();
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
        // This fixes the issue (app crash) while the phone is moving faster than the updates of the map tiles which most probably happens due to internet disconnectivity
        if (!await InternetConnectionChecker().hasConnection) return;

        setState(() {
          position = tempPosition;
        });
      },
    );
  }

  List<Widget> buildTrackScreen() => [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: buildMapDisplay(),
          ),
        ),
        Expanded(
          flex: 1,
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
                // TODO: Those two lines can crash the app if the current location is at the max boundaries.
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
    double speed = position.speed;
    Duration timeTaken = position.timestamp!.difference(startTime);
    double distanceTravelled = (speed * timeTaken.inSeconds) / 1000;

    return Center(
      child: Text(
        'speed: ${CustomFormat.getFormattedNumber(speed * 3.6, decimalPlace: 2)} km/h\n'
        'time elapsed: ${timeTaken.inMinutes}:${timeTaken.inSeconds % 60} minute(s)\n'
        'distance travelled: ${CustomFormat.getFormattedNumber(distanceTravelled, decimalPlace: 2)} km\n'
        'altitude: ${position.altitude} m\n'
        'floors climbed: ${position.floor ?? 0} floor(s)\n',
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget buildTrackingButtons() => Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  currentPositionListener.isPaused
                      ? currentPositionListener.resume()
                      : currentPositionListener.pause();
                });
                RideTrackingScreen.isRecording = true;
              },
              icon: FaIcon(
                currentPositionListener.isPaused
                    ? FontAwesomeIcons.solidCirclePlay
                    : FontAwesomeIcons.solidCirclePause,
                size: 70.0,
              ),
            ),
            IconButton(
              onPressed: () {
                RideTrackingScreen.isRecording = false;
                // TODO: show an alert before cancelling subscription
                // currentPositionListener.cancel();
                Navigator.pushNamed(context, StatisticsScreen.screen);
                // TODO: move to another page and show result
              },
              icon: const FaIcon(
                FontAwesomeIcons.circleStop,
                size: 50.0,
              ),
            ),
          ],
        ),
      );

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: isConnectedToInternet
          ? buildTrackScreen()
          : buildNoConnectionScreen(),
    );
  }
}

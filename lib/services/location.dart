import 'dart:async';
import 'dart:math';

import 'package:geolocator/geolocator.dart';

class Location {
  // double latitude = 35.86002, longitude = 104.1658; // Default Location
  late double latitude, longitude;
  double distanceTravelled = 0; // Distance is calculated in Meters.

  Stopwatch swatch = Stopwatch();

  List<Position> coordinates = [];

  void timer() {
    Timer(Duration(seconds: 1), (() {
      // if (swatch.elapsed.inSeconds > 10) {
      //   swatch.stop();
      //   print('timeout');
      //   return;
      // }

      if (swatch.isRunning) {
        print('${swatch.elapsed.inSeconds} seconds');
        if (coordinates.length >= 2) {
          distanceTravelled += Geolocator.distanceBetween(
            coordinates[0].latitude,
            coordinates[0].longitude,
            coordinates[1].latitude,
            coordinates[1].longitude,
          );
          coordinates.clear(); // To save memory.
        }
        print('Distance travelled: $distanceTravelled Meters.');

        // * Use `seconds % 60` to get seconds remainder

        // Calculation to find speed in Kmph.
        final speed = (distanceTravelled * pow(10, -3)) /
            (swatch.elapsed.inSeconds * (1 / 3600));
        print('Speed in KMPH: $speed KMPH');

        timer();
      }
    }));
  }

  Future<void> getCurrentLocation() async {
    swatch.start();
    timer();

    bool serviceEnabled;
    LocationPermission permission;
    Position pos;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    LocationSettings locationSettings = AppleSettings(
      accuracy: LocationAccuracy.high,
      activityType: ActivityType.fitness,
      distanceFilter: 100,
      pauseLocationUpdatesAutomatically: true,
      // Only set to true if our app will be started up in the background.
      showBackgroundLocationIndicator: true,
    );

    StreamSubscription<Position> positionStream =
        Geolocator.getPositionStream(locationSettings: locationSettings).listen(
      (Position? position) {
        print(position == null
            ? 'Unknown'
            : '${position.latitude.toString()}, ${position.longitude.toString()}');

        if (position != null) {
          coordinates.add(position);
        }
      },
      cancelOnError: false,
      onError: (i) => print('error occured: $i'),
    );
  }

  // Future<void> getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;
  //   Position pos;

  //   // Test if location services are enabled.
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     // Location services are not enabled don't continue
  //     // accessing the position and request users of the
  //     // App to enable the location services.
  //     return Future.error('Location services are disabled.');
  //   }

  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       // Permissions are denied, next time you could try
  //       // requesting permissions again (this is also where
  //       // Android's shouldShowRequestPermissionRationale
  //       // returned true. According to Android guidelines
  //       // your App should show an explanatory UI now.
  //       return Future.error('Location permissions are denied');
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     // Permissions are denied forever, handle appropriately.
  //     return Future.error(
  //         'Location permissions are permanently denied, we cannot request permissions.');
  //   }

  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   try {
  //     pos = await Geolocator.getCurrentPosition(
  //       desiredAccuracy: LocationAccuracy.medium,
  //       timeLimit: const Duration(seconds: 10),
  //     );

  //     latitude = pos.latitude;
  //     longitude = pos.longitude;
  //   } catch (e) {
  //     // print('An unknown error occurred...\nMore Info:\n$e');
  //     throw Exception('An unknown error occurred...\nMore Info:\n$e');
  //   }
  // }

  Future<void> openSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<void> openLocation() async {
    await Geolocator.openLocationSettings();
  }
}

import 'dart:async';
import 'dart:math';
import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

class Location {
  // late double latitude, longitude;
  // double latitude = 0, longitude = 0;
  // late StreamSubscription<Position> _positionStream;
  late Position currentPosition;
  late LocationSettings _locationSettings;
  // double distanceTravelledInMeters = 0;
  // bool isLocationFound = false;
  // Stopwatch swatch = Stopwatch();
  // List<Position> coordinates = [];
  bool _isPermissionGranted = false;

  Location() {
    _checkPermissionIsGranted().catchError((e) => print(e));
    _getLocationSettings();
  }

  Future<void> _checkPermissionIsGranted() async {
    bool serviceEnabled;
    LocationPermission permission;

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

    _isPermissionGranted = true;
  }

  void _getLocationSettings() {
    if (defaultTargetPlatform == TargetPlatform.android) {
      _locationSettings = AndroidSettings(
        accuracy: LocationAccuracy.best,
        intervalDuration: const Duration(seconds: 10),
        foregroundNotificationConfig: const ForegroundNotificationConfig(
          notificationText:
              "Old Bike will continue to receive your location even when you aren't using it",
          notificationTitle: "Running in Background",
          enableWakeLock: true,
          enableWifiLock: true,
        ),
      );
    } else if (defaultTargetPlatform == TargetPlatform.iOS ||
        defaultTargetPlatform == TargetPlatform.macOS) {
      _locationSettings = AppleSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        activityType: ActivityType.fitness,
        pauseLocationUpdatesAutomatically: true,
        allowBackgroundLocationUpdates: true,
        showBackgroundLocationIndicator: true,
      );
    } else {
      _locationSettings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
      );
    }
  }

  // void timer() {
  //   Timer(const Duration(seconds: 1), (() {
  //     // if (swatch.elapsed.inSeconds > 10) {
  //     //   swatch.stop();
  //     //   print('timeout');
  //     //   return;
  //     // }
  //
  //     if (swatch.isRunning) {
  //       print('${swatch.elapsed.inSeconds} seconds');
  //       if (coordinates.length >= 2) {
  //         distanceTravelledInMeters += Geolocator.distanceBetween(
  //           coordinates[0].latitude,
  //           coordinates[0].longitude,
  //           coordinates[1].latitude,
  //           coordinates[1].longitude,
  //         );
  //         coordinates.clear(); // To save memory.
  //       }
  //       print('Distance travelled: $distanceTravelledInMeters Meters.');
  //
  //       // * Use `seconds % 60` to get seconds remainder
  //
  //       // Calculation to find speed in Kph.
  //       final speed = (distanceTravelledInMeters * pow(10, -3)) /
  //           (swatch.elapsed.inSeconds * (1 / 3600));
  //       print('Speed in KPH: $speed KPH');
  //
  //       timer();
  //     }
  //   }));
  // }
  //
  // Future<void> getCurrentLocationStream() async {
  //   if (!await _checkPermissionIsGranted()) return;
  //
  //   // When we reach here, permissions are granted and we can
  //   // continue accessing the position of the device.
  //   LocationSettings locationSettings = AppleSettings(
  //     accuracy: LocationAccuracy.bestForNavigation,
  //     activityType: ActivityType.fitness,
  //     distanceFilter: 100,
  //     pauseLocationUpdatesAutomatically: true,
  //     showBackgroundLocationIndicator: true,
  //   );
  //
  //   _positionStream =
  //       Geolocator.getPositionStream(locationSettings: locationSettings).listen(
  //     (Position? tempPosition) {
  //       print(tempPosition == null
  //           ? 'Unknown'
  //           : '${tempPosition.latitude.toString()}, ${tempPosition.longitude.toString()}');
  //
  //       if (tempPosition != null) {
  //         coordinates.add(tempPosition);
  //         currentPosition = tempPosition;
  //         // isLocationFound = true;
  //       } else {
  //         // isLocationFound = false;
  //       }
  //     },
  //     cancelOnError: false,
  //     onError: (i) => print('error occurred: $i'),
  //   );
  //
  //   // swatch.start();
  //   // timer();
  // }
  //
  // void stopLocationStream() {
  //   _positionStream.cancel();
  // }

  Stream<Position> getPositionStream() {
    return Geolocator.getPositionStream(locationSettings: _locationSettings);
    // .timeout(
    // const Duration(seconds: 5),
    // );
  }

  // TODO: [done]
  Future<void> getCurrentLocation() async {
    if (!_isPermissionGranted) return;

    try {
      currentPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.medium,
        // timeLimit: const Duration(seconds: 10),
      );

      // isLocationFound = true;
    } catch (e) {
      print(e); // TODO: display popup
      // isLocationFound = false;
    }
  }

  Future<void> openSettings() async {
    await Geolocator.openAppSettings();
  }

  Future<void> openLocation() async {
    await Geolocator.openLocationSettings();
  }
}

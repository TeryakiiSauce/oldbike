import 'dart:async';
import 'package:geolocator/geolocator.dart';
import 'package:geolocator_apple/geolocator_apple.dart';

import 'package:flutter/material.dart';
import 'package:oldbike/services/location.dart';

class BeginTrackingRideScreen extends StatefulWidget {
  static const String screen = 'beginTrackingRide';

  const BeginTrackingRideScreen({super.key});

  @override
  State<BeginTrackingRideScreen> createState() =>
      _BeginTrackingRideScreenState();
}

class _BeginTrackingRideScreenState extends State<BeginTrackingRideScreen> {
  final Location currentLocation = Location();
  bool isLocationFound = false;

  Future<void> refreshLocation() async {
    try {
      await currentLocation.getCurrentLocation();
    } catch (e) {
      print('Error occurred: $e');
    }

    // setState(() {
    //   isLocationFound = true;
    // });
  }

  @override
  void initState() {
    super.initState();
    refreshLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          // refreshLocation();
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const Text('press to refresh location'),
            Text(
              isLocationFound
                  // ? 'lat: ${currentLocation.latitude} | lon: ${currentLocation.longitude}'
                  ? '[location here]'
                  : 'Loading...',
            ),
          ],
        ),
      ),
    );
  }
}

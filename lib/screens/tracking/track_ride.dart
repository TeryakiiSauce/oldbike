import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:oldbike/services/location.dart';
import 'package:oldbike/utils/custom_formatting.dart';

class BeginTrackingRideScreen extends StatefulWidget {
  static const String screen = 'beginTrackingRide';

  const BeginTrackingRideScreen({super.key});

  @override
  State<BeginTrackingRideScreen> createState() =>
      _BeginTrackingRideScreenState();
}

class _BeginTrackingRideScreenState extends State<BeginTrackingRideScreen> {
  final Location location = Location();
  final DateTime startTime = DateTime.now();

  // bool isLocationFound = false;
  //
  Future<void> initLocation() async {
    await location.getCurrentLocation();

    // setState(() {
    //   isLocationFound = location.isLocationFound;
    // });  
    //
    //todo: if func
    //
    // refreshLocation();
  }

  // Future<void> refreshLocation() async {
  //   await location.getCurrentLocationStream();
  //
  //   setState(() {
  //     isLocationFound = location.isLocationFound;
  //   });
  // }

  @override
  void initState() {
    super.initState();
    // initLocation();
    // refreshLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          flex: 10,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.0),
              child: Stack(
                children: [
                  StreamBuilder<Position>(
                    stream: location.getPositionStream(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return const Center(
                          child: Icon(
                            Icons.emergency_share_rounded,
                            size: 100.0,
                          ),
                        );
                      }

                      double lat = snapshot.data!.latitude,
                          long = snapshot.data!.longitude;

                      // print('$lat, $long');

                      return FlutterMap(
                        options: MapOptions(
                          center: LatLng(lat, long),
                          bounds: LatLngBounds(
                            LatLng(lat - 0.001, long + 0.001),
                            LatLng(lat + 0.001, long - 0.001),
                          ),
                          zoom: 18.0,
                          minZoom: 2.0,
                          maxBounds: LatLngBounds(
                            LatLng(-90.0, -180.0),
                            LatLng(90.0, 180.0),
                          ),
                          interactiveFlags:
                              InteractiveFlag.all & ~InteractiveFlag.rotate,
                          maxZoom: 18,
                        ),
                        nonRotatedChildren: [
                          MarkerLayer(
                            markers: [
                              Marker(
                                // height: 100.0,
                                // width: 100.0,
                                point: LatLng(lat, long),
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
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        Expanded(
          flex: 2,
          child: StreamBuilder<Position>(
            stream: location.getPositionStream(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Column(
                    children: const [
                      Icon(
                        Icons.satellite_alt_rounded,
                        size: 20.0,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        'No signal detected!\nMove to an open space area...',
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ); // todo: add progress circle
              }

              double speed = snapshot.data!.speed;
              Duration timeTaken =
                  snapshot.data!.timestamp!.difference(startTime);
              double distanceTravelled = (speed * timeTaken.inSeconds) / 1000;

              return Center(
                child: Text(
                  'speed: ${CustomFormat.getFormattedNumber(speed * 3.6, decimalPlaces: 2)} km/h\n'
                  'time elapsed: ${timeTaken.inMinutes}:${timeTaken.inSeconds % 60} minute(s)\n'
                  'distance travelled: ${CustomFormat.getFormattedNumber(distanceTravelled, decimalPlaces: 2)} km\n'
                  'altitude: ${snapshot.data!.altitude} m\n'
                  'floors climbed: ${snapshot.data!.floor ?? 0} floor(s)\n',
                  textAlign: TextAlign.center,
                ),
              );
            },
          ),
        ),
        const Expanded(child: Center(child: Text('[controller icons]'))),
      ],
    );
    //
    // return Column(
    //   crossAxisAlignment: CrossAxisAlignment.stretch,
    //   children: [
    //     updateLocation(),
    //     const Expanded(child: Text('[stats]')),
    //     const Expanded(child: Text('[controller icons]')),
    //   ],
    // );
  }
}

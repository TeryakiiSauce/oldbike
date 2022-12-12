import 'package:oldbike/utils/custom_formatting.dart';

class RideStatistics {
  double topSpeed,
      currentSpeed,
      averageSpeed,
      distanceTravelled,
      altitude,
      previousAltitude,
      minAltitude,
      maxAltitude,
      uphillDistance,
      downhillDistance,
      elevationGained;
  Duration timeElapsed;

  RideStatistics({
    required this.averageSpeed,
    required this.currentSpeed,
    required this.distanceTravelled,
    required this.downhillDistance,
    required this.elevationGained,
    required this.altitude,
    required this.previousAltitude,
    required this.minAltitude,
    required this.maxAltitude,
    required this.timeElapsed,
    required this.topSpeed,
    required this.uphillDistance,
  });

// TODO: display these values to summary as well and then upload to firebase
  String displayCurrentStats() {
    return 'top speed: ${CustomFormat.getFormattedNumber(topSpeed, decimalPlace: 2)} km/h\n'
        'current speed: ${CustomFormat.getFormattedNumber(currentSpeed, decimalPlace: 2)} km/h\n'
        'avg speed: ${CustomFormat.getFormattedNumber(averageSpeed, decimalPlace: 2)} km/h\n'
        'time elapsed: ${timeElapsed.inMinutes}:${timeElapsed.inSeconds % 60} minute(s)\n'
        'distance travelled: ${CustomFormat.getFormattedNumber(distanceTravelled, decimalPlace: 2)} km\n'
        'altitude: ${CustomFormat.getFormattedNumber(altitude, decimalPlace: 2)} m\n'
        'min altitude: ${CustomFormat.getFormattedNumber(minAltitude, decimalPlace: 2)} m\n'
        'max altitude: ${CustomFormat.getFormattedNumber(maxAltitude, decimalPlace: 2)} m\n'
        'uphill distance: ${CustomFormat.getFormattedNumber(uphillDistance, decimalPlace: 2)} m\n'
        'downhill distance: ${CustomFormat.getFormattedNumber(downhillDistance, decimalPlace: 2)} m\n'
        'elevation gained: ${CustomFormat.getFormattedNumber(elevationGained, decimalPlace: 2)} m\n';
  }
}

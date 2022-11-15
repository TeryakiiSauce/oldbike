import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/components/circular_icon.dart';
import 'package:intl/intl.dart';

class RideInfoCard extends StatelessWidget {
  final String username;
  final DateTime date;
  final double avgSpeed, distTravelled, elevationGained;

  /// This creates a card that displays a summary of a bike ride.
  ///
  /// Information includes:
  ///   - The average speed.
  ///   - The distance travelled.
  ///   - The elevation gained.
  const RideInfoCard(
      {super.key,
      required this.username,
      required this.date,
      this.avgSpeed = 0.0,
      this.distTravelled = 0.0,
      this.elevationGained = 0.0});

  /// Returns a `Row()` of three icons that include labels and the statistics of a bike ride.
  Row _getLabelledIcons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircularIcon(
          icon: Icons.flash_on_rounded,
          label: 'Average Speed',
          result: _getFormattedResult(avgSpeed),
          unit: 'km/ h',
        ),
        CircularIcon(
          icon: Icons.location_on_rounded,
          label: 'Distance Travelled',
          result: _getFormattedResult(distTravelled),
          unit: 'km',
        ),
        CircularIcon(
          icon: Icons.trending_up_rounded,
          label: 'Elevation Gained',
          result: _getFormattedResult(elevationGained),
          unit: 'm',
        ),
      ],
    );
  }

  /// Formats the date (created by the constructor) & returns a `String` date in the following format: `MMM dd, yyyy - HH:mm` (example: `Nov 16, 2022 - 02:07`).
  String _getFormattedDate() {
    // Reference: https://stackoverflow.com/a/16126580
    DateFormat formatter = DateFormat('MMM dd, yyyy - HH:mm');
    return formatter.format(date);
  }

  /// Returns string number in *one* decimal place if the passed number is between 0 & 10 (0-9). Numbers after `9.9` are formatted to have no decimal places. If the number passed is greater than `99.9`, '99+' will be returned.
  String _getFormattedResult(double num) {
    String result = '';

    if (num > 99.9) {
      result = '99+';
    } else if (num > 9.9) {
      result = num.toStringAsFixed(0);
    } else if (num < 0.0) {
      result = '0.0';
    } else {
      result = num.toStringAsFixed(1);
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    const SizedBox spacing = SizedBox(
      height: 20.0,
    );

    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: kcPrimaryT1,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset('images/robert-bye-tG36rvCeqng-unsplash.jpg'),
          ),
          spacing,
          Text(
            username,
            style: ktsCardTitle,
          ),
          const SizedBox(
            height: 5.0,
          ),
          Text(
            _getFormattedDate(),
            style: ktsCardDate,
          ),
          spacing,
          _getLabelledIcons(),
          spacing,
          const Text(
            'More >',
            textAlign: TextAlign.end,
            style: ktsCardAction,
          ),
        ],
      ),
    );
  }
}

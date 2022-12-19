import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:oldbike/components/custom_notice_screen.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/screens/tracking/track_ride.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent-tab-view.dart';

class LocationUsageAgreementScreen extends StatelessWidget {
  static const TabScreen screen = TabScreen.locationUsageAgreement;
  const LocationUsageAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomNoticeScreen(
      appBarTitle: 'Location Usage Notice',
      title: 'Notice',
      content:
          'Your location will used for determining your current position as well as to calculate statistics of your progress. Click Continue to grant Old Bike access.',
      onButtonPressed: () {
        HapticFeedback.lightImpact();
        pushNewScreen(
          context,
          screen: const RideTrackingScreen(),
          withNavBar: true,
          pageTransitionAnimation: PageTransitionAnimation.cupertino,
        );
      },
    );
  }
}

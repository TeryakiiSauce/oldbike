import 'package:flutter/cupertino.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/screens/tracking/track_ride.dart';
import 'package:oldbike/components/app_logo.dart';
import 'package:oldbike/components/base_screen_template.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

class LocationUsageAgreementScreen extends StatelessWidget {
  static const TabScreen screen = TabScreen.locationUsageAgreement;
  const LocationUsageAgreementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreenTemplate(
      title: 'Location Usage Notice',
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 40.0,
          vertical: 100.0,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const AppLogo(),
            const SizedBox(
              height: 100.0,
            ),
            Column(
              children: const [
                Text(
                  'Notice',
                  style: ktsProfileTitle,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30.0,
                ),
                Text(
                  'Your location will used for determining your current position as well as to calculate statistics of your progress. Click Continue to grant Old Bike access.',
                  style: ktsNormal,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
            const SizedBox(
              height: 100.0,
            ),
            CupertinoButton(
              color: kcAccent,
              onPressed: () {
                PersistentNavBarNavigator.pushNewScreen(
                  context,
                  screen: const RideTrackingScreen(),
                  withNavBar: true,
                  pageTransitionAnimation: PageTransitionAnimation.cupertino,
                );
              },
              child: const Text(
                'Continue',
                style: ktsNormalDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

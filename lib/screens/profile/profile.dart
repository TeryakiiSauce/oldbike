import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/utils/text_styles.dart';
import 'package:oldbike/components/horizontal_scroll.dart';
import 'package:oldbike/components/compact_ride_info_card.dart';

class ProfileScreen extends StatefulWidget {
  static const String screen = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  LabelledWidget buildProfileSummary({double padding = 0}) => LabelledWidget(
        titlePadding: padding,
        childPadding: padding,
        title: 'Profile',
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            getProfileDetails(),
          ],
        ),
      );

  LabelledWidget buildUserRecentRides({double padding = 0}) => LabelledWidget(
        titlePadding: padding,
        childPadding: 0,
        title: 'Recent Rides',
        child: HorizontalScroll(
          height: MediaQuery.of(context).size.height * 0.25,
          itemsCount: 3,
          child: CompactRideInfoCard(
            date: DateTime.now(),
          ),
        ),
      );

  Row getProfileDetails() => Row(
        children: [
          Flexible(
            child: CircularImage(
              image: Image.asset(
                  'images/vecteezy_watercolor-sketch-of-cute-cartoon-jumping-dolphin_11017755_378.png'),
              padding: 5,
              size: 12,
            ),
          ),
          const SizedBox(
            width: 30.0,
          ),
          Flexible(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: const [
                Text(
                  'Rintarou Okabe',
                  style: ktsProfileTitle,
                ),
                Text(
                  '25 years old, Male',
                  style: ktsProfileSubtitle,
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                  ),
                ),
                Text(
                  '70 kg\n'
                  '182 cm\n'
                  'O+ Blood group',
                  style: ktsProfileTiny,
                  textHeightBehavior: TextHeightBehavior(
                    applyHeightToFirstAscent: false,
                  ),
                ),
              ],
            ),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    const double padding = 20;

    return ListView(
      children: [
        buildProfileSummary(padding: padding),
        buildUserRecentRides(padding: padding),

        // TODO: remove the widget below later
        const LabelledWidget(
          title: 'title',
          titlePadding: padding,
          childPadding: padding,
          child: Text('vwe'),
        ),
      ],
    );
  }
}

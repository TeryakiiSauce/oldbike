import 'package:flutter/material.dart';
import 'package:oldbike/components/circular_image.dart';
import 'package:oldbike/components/labelled_widget.dart';
import 'package:oldbike/utils/text_styles.dart';

class ProfileScreen extends StatefulWidget {
  static const String screen = 'profile';

  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(20.0),
      children: [
        LabelledWidget(
          title: 'Profile',
          child: Column(
            children: [
              Row(
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
              ),
              const Divider(
                height: 50.0,
                thickness: 5,
              ),
              Row(
                children: [
                  Flexible(
                    child: CircularImage(
                      image: Image.asset(
                          'images/vecteezy_3d-icon-rendering_12981600_145.png'),
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
              ),
              const Divider(
                height: 50.0,
                thickness: 5,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

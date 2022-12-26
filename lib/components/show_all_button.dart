///
/// [Deprecated] This widget is not used any more due to lack of time to create the functionality.
///
/// This widget is used in the 'Profile' screen in 'My Rides' (previously known as 'Recent Rides')
/// to display another screen and show all the user's rides.
/// === === === === ===

import 'package:flutter/material.dart';
import 'package:oldbike/utils/text_styles.dart';

class ShowAllButton extends StatelessWidget {
  const ShowAllButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(
            height: 20.0,
          ),
          GestureDetector(
            onTap: () {},
            child: const Text(
              'Show all',
              textAlign: TextAlign.end,
              style: ktsCardAction,
            ),
          ),
        ],
      ),
    );
  }
}

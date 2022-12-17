import 'package:flutter/material.dart';
import 'package:oldbike/components/ride_info_card.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';

class HomeScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.home;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Widget> getRidesInfoCards() {
    List<Widget> cardsList = [];

    cardsList.addAll(
      [
        FeedRideInfoCard(
          username: 'Mason Bart',
          date: DateTime.now(),
          avgSpeed: 7.56360,
          distTravelled: 123.25257,
          elevationGained: 33.52390,
        ),
        FeedRideInfoCard(
          username: 'Tylor Smith',
          date: DateTime.now(),
          avgSpeed: 13.96563,
          distTravelled: 6.46512,
          elevationGained: 1.91236,
        ),
        FeedRideInfoCard(
          username: 'John Wick',
          date: DateTime.now(),
          avgSpeed: 8.34590,
          distTravelled: 7.12490,
          elevationGained: 2.63481,
        ),
        FeedRideInfoCard(
          username: 'May Jordan',
          date: DateTime.now(),
          avgSpeed: 15.79402,
          distTravelled: 30.23518,
          elevationGained: 0.67411,
        ),
      ],
    );

    return cardsList;
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenTemplate(
      title: 'Old Bike Feed',
      body: Scrollbar(
        child: ListView(
          children: getRidesInfoCards(),
        ),
      ),
    );
  }
}

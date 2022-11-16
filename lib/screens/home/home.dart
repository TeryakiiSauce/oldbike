import 'package:flutter/material.dart';
import 'package:oldbike/utils/colors.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/components/ride_info_card.dart';

class HomeScreen extends StatefulWidget {
  static const String screen = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RideInfoCard> getRidesInfoCards() {
    List<RideInfoCard> cardsList = [];

    cardsList.addAll(
      [
        RideInfoCard(
          username: 'Mason Bart',
          date: DateTime.now(),
          avgSpeed: 7.56360,
          distTravelled: 123.25257,
          elevationGained: 33.52390,
        ),
        RideInfoCard(
          username: 'Tylor Smith',
          date: DateTime.now(),
          avgSpeed: 13.96563,
          distTravelled: 6.46512,
          elevationGained: 1.91236,
        ),
        RideInfoCard(
          username: 'John Wick',
          date: DateTime.now(),
          avgSpeed: 8.34590,
          distTravelled: 7.12490,
          elevationGained: 2.63481,
        ),
        RideInfoCard(
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
    return Scaffold(
      backgroundColor: kcPrimaryT3,
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: kcAppBar,
        actions: [
          IconButton(
            onPressed: () =>
                Navigator.pushReplacementNamed(context, LoginScreen.screen),
            icon: const Icon(Icons.exit_to_app_rounded),
          ),
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const [
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.ac_unit_rounded),
      //       label: '',
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.access_time),
      //       label: '',
      //     ),
      //   ],
      // ),
      body: SafeArea(
        child: Scrollbar(
          child: ListView(
            children: getRidesInfoCards(),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:oldbike/screens/login-signup/login.dart';
import 'package:oldbike/utils/colors.dart';

class HomeScreen extends StatefulWidget {
  static const String screen = 'home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<RideInfoCard> getRidesInfoCards() {
    List<RideInfoCard> cardsList = [];

    for (var i = 0; i < 3; i++) {
      // TODO: adjust the function call below
      cardsList.add(const RideInfoCard());
    }

    return cardsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: ListView(
          children: getRidesInfoCards(),
        ),
      ),
    );
  }
}

class RideInfoCard extends StatelessWidget {
  const RideInfoCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(20.0),
      padding: const EdgeInsets.all(20.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: kcPrimaryT2,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset('images/robert-bye-tG36rvCeqng-unsplash.jpg'),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'Tylor Smith',
            style: TextStyle(fontSize: 34.0, fontWeight: FontWeight.w900),
          ),
          const Text(
            '22/11/2022',
            style: TextStyle(fontSize: 15.0),
          ),
          const SizedBox(
            height: 20.0,
          ),
          const Text('Average Speed: 13 km/h'),
          const Text('Distance Travelled: 13 km'),
          const Text('Elevation Gained: 2.5m'),
          const SizedBox(
            height: 20.0,
          ),
          const Text(
            'More >',
            textAlign: TextAlign.end,
          ),
        ],
      ),
    );
  }
}

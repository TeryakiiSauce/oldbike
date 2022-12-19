import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/components/no_data_found_notice.dart';
import 'package:oldbike/components/feed_ride_info_card.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';

class HomeScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.home;

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Widget displayNoPosts() {
    return Padding(
      padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.29),
      child: const NoDataFoundNotice(
        dividerWidth: 150.0,
        textWidth: 250.0,
        title: 'Your Feed is Empty!',
        text:
            'You can either wait for other users to post their ride statistics or you can immediately start tracking your own ride statistics.',
      ),
    );
  }

  Widget buildPosts() {
    return StreamBuilder<QuerySnapshot>(
      stream: RideStatistics.latestPostsSnapshots(),
      builder: (context, snapshot) {
        if (snapshot.data == null) return displayNoPosts();
        final int totalNumOfPosts = snapshot.data!.size;

        return totalNumOfPosts == 0
            ? displayNoPosts()
            : ListView.separated(
                itemCount: totalNumOfPosts,
                separatorBuilder: (context, index) {
                  return const Divider(
                    thickness: 4.0,
                    indent: 150,
                    endIndent: 150,
                  );
                },
                itemBuilder: (context, index) {
                  final QueryDocumentSnapshot<Object?> document =
                      snapshot.data!.docs.reversed.elementAt(index);

                  DateTime date = DateTime.parse(document.id);
                  RideStatistics rideStatistics =
                      RideStatistics.createObject(document);
                  String title = rideStatistics.cyclistName;

                  return FeedRideInfoCard(
                    title: title,
                    date: date,
                    rideStatistics: rideStatistics,
                  );
                },
              );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreenTemplate(
      title: 'Old Bike Feed',
      body: Scrollbar(
        child: buildPosts(),
      ),
    );
  }
}

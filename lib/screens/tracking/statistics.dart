import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/models/screen.dart';
import 'package:oldbike/components/base_screen_template.dart';

class StatisticsScreen extends StatefulWidget {
  static const TabScreen screen = TabScreen.statistics;
  final RideStatistics statsInfo;
  final bool doUpload;

  const StatisticsScreen({
    super.key,
    required this.statsInfo,
    this.doUpload = false,
  });

  @override
  State<StatisticsScreen> createState() => _StatisticsScreenState();
}

class _StatisticsScreenState extends State<StatisticsScreen> {
  final User? userInfo = MyUser(email: '', password: '').getUserInfo();

  void uploadStats() async {
    debugPrint(
        'User ID: ${userInfo?.uid}\ndata to be uploaded: ${widget.statsInfo.toJSON()}');

    // Reference: https://stackoverflow.com/a/55328839
    final CollectionReference rideStatsReference =
        FirebaseFirestore.instance.collection('/rides-statistics');

    await rideStatsReference
        .doc(userInfo!.uid)
        .collection('rides')
        .doc('${DateTime.now()}')
        .set(widget.statsInfo.toJSON());

    debugPrint('uploaded ride info to database');
  }

  @override
  Widget build(BuildContext context) {
    if (widget.doUpload) uploadStats();

    return BaseScreenTemplate(
      title: 'Your Statistics',
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Center(
          child: widget.statsInfo.displaySummarizedStats(),
        ),
      ),
    );
  }
}

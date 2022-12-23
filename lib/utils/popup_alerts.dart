import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:oldbike/components/platform_based_widgets.dart';
import 'package:oldbike/models/my_user.dart';
import 'package:oldbike/models/ride_stats.dart';
import 'package:oldbike/services/location.dart';
import 'package:oldbike/utils/extensions.dart';

class CustomPopupAlerts {
  static Widget displayLocationDisabledAlert(
    BuildContext context,
    bool isServiceDisabled,
    Location location,
  ) {
    return DynamicAlertDialog(
      title: Text(
        isServiceDisabled ? 'Location Disabled' : 'Location Permission',
      ),
      content: Text(
        isServiceDisabled
            ? 'Access to location is disabled on your phone. Click Ok and turn on location service and then give the app permission to use location data.'
            : 'Permission to location is required in order for the app to track your progress. Click Ok to open App settings.',
      ),
      cancelAction: () {
        HapticFeedback.selectionClick();
        context.pop();
      },
      approveAction: () {
        HapticFeedback.selectionClick();

        isServiceDisabled
            ? location.openPrivacyLocationSettings()
            : location.openAppSettings();

        context.pop();
      },
    );
  }

  static Widget displayLoginError(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text(
        'Incorrect email or password',
      ),
      content: const Text(
        'Please retry entering your details correctly.',
      ),
      showCancelButton: false,
      approveText: 'Retry',
      approveAction: () {
        HapticFeedback.selectionClick();
        context.pop();
      },
    );
  }

  static Widget displayWarningWhileAnonDuringUpload(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text('Not Signed In!'),
      content: const Text(
        'While in anonymous mode, your statistics will not be uploaded. \n\nHowever, your statistics will still be publicly visible, anonymously.',
      ),
      showCancelButton: false,
      approveText: 'Got it!',
      approveAction: () {
        HapticFeedback.selectionClick();
        context.pop();
      },
    );
  }

  static Widget displayConfirmationToDeleteRideStats(
      BuildContext context, DateTime date, RideStatistics? statsInfo) {
    return DynamicAlertDialog(
      title: const Text('Confirmation'),
      content: const Text(
        'This will delete statistics data from all your devices! Are you sure that you want to continue?',
      ),
      isApproveDestructive: true,
      approveText: 'Delete',
      cancelAction: () {
        HapticFeedback.selectionClick();
        context.pop();
      },
      approveAction: () async {
        HapticFeedback.selectionClick();

        // Reference: https://github.com/flutter/flutter/issues/110694#issuecomment-1233341081
        final NavigatorState navigator = Navigator.of(context);

        debugPrint('Deleting document with ID: $date');

        final User? userInfo = MyUser.getUserInfo();

        final CollectionReference rideStatsReference =
            FirebaseFirestore.instance.collection('/rides-statistics');

        await rideStatsReference
            .doc(userInfo!.uid)
            .collection('rides')
            .doc('$date')
            .delete();

        navigator.pop();
      },
    );
  }

  static Widget displayRegistrationError(BuildContext context, String error) {
    // To get the error title
    final regExpToGetTitle = RegExp('/.*]');
    final regExpToReplaceDashesWithSpaces = RegExp('-');
    String? title = regExpToGetTitle.stringMatch(error) ?? 'Error Occurred';
    title = title.substring(1, title.length - 1);
    title = title.replaceAll(regExpToReplaceDashesWithSpaces, ' ');
    title = title.toTitleCase();

    // To get the error description
    final regExpToGetDesc = RegExp('] .*');
    String? desc =
        regExpToGetDesc.stringMatch(error) ?? 'An unknown error has occurred.';
    desc = desc.substring(2);
    desc = desc.toCapitalized();
    if (!desc.endsWith('.')) desc += '.';

    return DynamicAlertDialog(
      title: Text(title),
      content: Text(desc),
      showApproveButton: false,
      cancelText: 'Fix now',
      cancelAction: () {
        HapticFeedback.selectionClick();
        context.pop();
      },
    );
  }

  static Widget displayNoInternetConnection(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text('No Internet Connection'),
      content: const Text(
          'Please make sure that you are connected to the internet.'),
      showApproveButton: false,
      cancelText: 'Retry',
      cancelAction: () {
        HapticFeedback.selectionClick();
        context.pop();
      },
    );
  }

  static Widget displayInvalid(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text('Invalid Information'),
      content: const Text('Some information entered is invalid'),
      showApproveButton: false,
      cancelText: 'Fix now',
      cancelAction: () {
        HapticFeedback.selectionClick();
        context.pop();
      },
    );
  }

  /// [Deprecated]
  @Deprecated('Not used any more')
  static Widget displayUserCreatedSuccessfully(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text('User Created Successfully'),
      content: const Text(
          'Your profile has been created successfully. Now, you may login to the application with your new account.'),
      showCancelButton: false,
      approveAction: () => context.pop(),
    );
  }
}

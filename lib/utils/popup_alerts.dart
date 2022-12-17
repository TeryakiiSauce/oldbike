import 'package:flutter/material.dart';
import 'package:oldbike/components/platform_based_widgets.dart';
import 'package:oldbike/services/location.dart';

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
        Navigator.pop(context);
      },
      approveAction: () {
        isServiceDisabled
            ? location.openPrivacyLocationSettings()
            : location.openAppSettings();

        Navigator.pop(context);
      },
    );
  }

  static Widget displayLoginError(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text('Incorrect email or password'),
      content: const Text('Please retry entering your details correctly.'),
      showCancelButton: false,
      approveText: 'Retry',
      approveAction: () => Navigator.pop(context),
    );
  }

  static Widget displayWarningWhileAnonDuringUpload(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text('Not Signed In!'),
      content: const Text(
          'While in anonymous mode, your statistics will not be uploaded.'),
      showCancelButton: false,
      approveText: 'Got it!',
      approveAction: () => Navigator.pop(context),
    );
  }

  static Widget displayConfirmationToDeleteRideStats(BuildContext context) {
    return DynamicAlertDialog(
      title: const Text('Confirmation'),
      content: const Text(
          'This will delete statistics data from all your devices! Are you sure that you want to continue?'),
      isApproveDestructive: true,
      approveText: 'Delete',
      cancelAction: () => Navigator.pop(context),
      approveAction: () {},
    );
  }
}

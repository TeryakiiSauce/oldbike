import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicAlertDialog extends StatelessWidget {
  final Widget title;
  final Widget content;
  final VoidCallback? approveAction;
  final VoidCallback? cancelAction;
  // final List<Widget> actions;

  const DynamicAlertDialog({
    Key? key,
    this.title = const Text(''),
    this.content = const Text(''),
    this.approveAction,
    this.cancelAction,
    // this.actions = const [],
  }) : super(key: key);

  AlertDialog androidAlert(BuildContext context) => AlertDialog(
        title: title,
        content: content,
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: approveAction,
            child: const Text('Ok'),
          ),
        ],
      );

  CupertinoAlertDialog iosAlert(BuildContext context) => CupertinoAlertDialog(
        title: title,
        content: content,
        actions: [
          CupertinoDialogAction(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          CupertinoDialogAction(
            onPressed: approveAction,
            child: const Text('Ok'),
          ),
        ],
      );

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? androidAlert(context) : iosAlert(context);
  }
}

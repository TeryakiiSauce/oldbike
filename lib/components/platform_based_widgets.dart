import 'dart:io' show Platform;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DynamicAlertDialog extends StatelessWidget {
  final Widget title, content;
  final String approveText, cancelText;
  final bool showCancelButton, showApproveButton, isApproveDestructive;
  final VoidCallback? approveAction;
  final VoidCallback? cancelAction;

  const DynamicAlertDialog({
    Key? key,
    this.title = const Text(''),
    this.content = const Text(''),
    this.showApproveButton = true,
    this.showCancelButton = true,
    this.isApproveDestructive = false,
    this.approveText = 'Ok',
    this.cancelText = 'Cancel',
    this.approveAction,
    this.cancelAction,
  }) : super(key: key);

  AlertDialog androidAlert(BuildContext context) {
    List<Widget> list = [];

    showCancelButton
        ? list.add(
            TextButton(
              onPressed: cancelAction,
              child: Text(cancelText),
            ),
          )
        : null;

    showApproveButton
        ? list.add(
            TextButton(
              onPressed: approveAction,
              child: Text(approveText),
            ),
          )
        : null;

    return AlertDialog(
      title: title,
      content: content,
      actions: list,
    );
  }

  CupertinoAlertDialog iosAlert(BuildContext context) {
    List<Widget> list = [];

    showCancelButton
        ? list.add(
            CupertinoDialogAction(
              onPressed: cancelAction,
              child: Text(cancelText),
            ),
          )
        : null;

    showApproveButton
        ? list.add(
            CupertinoDialogAction(
              isDestructiveAction: isApproveDestructive,
              onPressed: approveAction,
              child: Text(approveText),
            ),
          )
        : null;

    return CupertinoAlertDialog(
      title: title,
      content: content,
      actions: list,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Platform.isAndroid ? androidAlert(context) : iosAlert(context);
  }
}
